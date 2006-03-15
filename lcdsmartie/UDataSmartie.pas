unit UDataSmartie;

interface

uses
  SysUtils,URLThread;

type
  TSmartieDataThread = class(TURLThread)
  private
    fIsConnected : boolean;
    fLCDSmartieUpdate : boolean;
    fLCDSmartieUpdateText : string;
    function GetLCDSmartieUpdate : boolean;
    function GetLCDSmartieUpdateText : string;
  protected
    procedure  DoUpdate; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure  ResolveVariables(var Line : string); override;
    property IsConnected : boolean read fIsConnected;
    property LCDSmartieUpdate : boolean read GetLCDSmartieUpdate;
    property LCDSmartieUpdateText : string read GetLCDSmartieUpdateText;
  end;

implementation

uses
  StrUtils,UConfig,UUtils,UMain;

constructor TSmartieDataThread.Create;
begin
  fIsConnected := false;
  fLCDSmartieUpdate := false;
  fLCDSmartieUpdateText := '';
  inherited Create(config.newsRefresh*60000);
end;

destructor TSmartieDataThread.Destroy;
begin
  inherited;
end;

procedure TSmartieDataThread.ResolveVariables(var Line : string);
begin
end;

function TSmartieDataThread.GetLCDSmartieUpdate : boolean;
begin
  fDataLock.Enter;
  GetLCDSmartieUpdate := fLCDSmartieUpdate;
  fDataLock.Leave;
end;

function TSmartieDataThread.GetLCDSmartieUpdateText : string;
begin
  fDataLock.Enter;
  GetLCDSmartieUpdateText := fLCDSmartieUpdateText;
  fDataLock.Leave;
end;

procedure TSmartieDataThread.DoUpdate;
var
  iPos1, iPosPoint1, iPosPoint2, iPosPoint3: Integer;
  iVersMaj, iVersMin, iVersRel, iVersBuild: Integer;
  bUpgrade: Boolean;
  versionline : string;
  sFilename: String;
begin
  if not config.checkUpdates then exit;
  try
    sFilename := getUrl('http://lcdsmartie.sourceforge.net/version2.txt',96*60);
    versionline := FileToString(sFilename);
  except
    on E: EExiting do raise;
    else versionline := '';
  end;
  versionline := StringReplace(versionline, chr(10), '', [rfReplaceAll]);
  versionline := StringReplace(versionline, chr(13), '', [rfReplaceAll]);

  if (Length(versionline) > 1) and (versionline[1]=':') then
  begin
    fIsConnected := true;

    iPos1 := PosEx(':', versionline, 2);

    if (iPos1 <> 0) then
    begin
      iPosPoint1 := PosEx('.', versionline, 2);
      iPosPoint2 := PosEx('.', versionline, iPosPoint1 + 1);
      iPosPoint3 := PosEx('.', versionline, iPosPoint2 + 1);

      if (iPosPoint1 <> 0) and (iPosPoint2 <> 0) and (iPosPoint3 <> 0)
        and (iPosPoint3 < iPos1) then
      begin
        try
          iVersMaj := StrToInt(MidStr(versionline, 2, iPosPoint1-2));
          iVersMin := StrToInt(MidStr(versionline, iPosPoint1+1, iPosPoint2-(iPosPoint1+1)));
          iVersRel := StrToInt(MidStr(versionline, iPosPoint2+1, iPosPoint3-(iPosPoint2+1)));
          iVersBuild:= StrToInt(MidStr(versionline, iPosPoint3+1, iPos1-(iPosPoint3+1)));
        except
          iVersMaj := 0;
          iVersMin := 0;
          iVersRel := 0;
          iVersBuild := 0;
        end;

        bUpgrade := false;
        if (iVersMaj > OurVersMaj) then bUpgrade := true;

        if (iVersMaj = OurVersMaj) then
        begin
          if (iVersMin > OurVersMin) then bUpgrade := true;

          if (iVersMin = OurVersMin) then
          begin
            if (iVersRel > OurVersRel) then bUpgrade := true;

            if (iVersRel = OurVersRel) then
            begin
              if (iVersBuild > OurVersBuild) then bUpgrade := true;
            end;
          end;
        end;

        if (bUpgrade) then
        begin
          if (fLCDSmartieUpdateText <> MidStr(versionline, iPos1+1, 62)) then
          begin
            fDataLock.Enter;
            try
              fLCDSmartieUpdateText := MidStr(versionline, iPos1+1, 62);
              fLCDSmartieUpdate := True;
            finally
              fDataLock.Leave;
            end;
          end;
        end;
      end;
    end;
  end;
end;

end.
