unit UDataFolding;

interface

uses
  SysUtils,URLThread;

type
  TFoldingDataThread = class(TURLThread)
  private
    foldMemSince, foldLastWU, foldActProcsWeek, foldTeam, foldScore,
    foldRank, foldWU: String;
    procedure DoFoldingHTTPUpdate;
  protected
    procedure  DoUpdate; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure  ResolveVariables(var Line : string); override;
  end;

implementation

uses
  UConfig,UUtils;

constructor TFoldingDataThread.Create;
begin
  inherited Create(config.newsRefresh*60000);
end;

destructor TFoldingDataThread.Destroy;
begin
  inherited;
end;

procedure TFoldingDataThread.ResolveVariables(var Line : string);
begin
  if (pos('$FOLD', line) <> 0) then
  begin
    fDataLock.Enter();
    try
      line := StringReplace(line, '$FOLDmemsince', foldMemSince, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDlastwu', foldLastWU, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDactproc', foldActProcsWeek, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDteam', foldTeam, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDscore', foldScore, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDrank', foldRank, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDwu', foldWU, [rfReplaceAll]);
    finally
      fDataLock.Leave();
    end;
  end;
end;

procedure TFoldingDataThread.DoFoldingHTTPUpdate;
var
  tempstr,tempstr2 : string;
  sFilename: String;
begin
  try
    sFilename := getUrl(
      'http://vspx27.stanford.edu/cgi-bin/main.py?qtype=userpage&username='
      + config.foldUsername, config.newsRefresh);
    tempstr := FileToString(sFilename);

    tempstr := StringReplace(tempstr,'&deg;',#176{'°'},[rfIgnoreCase,rfReplaceAll]);//LMB
    tempstr := StringReplace(tempstr, '&amp;', '&', [rfReplaceAll]);
    tempstr := StringReplace(tempstr, chr(10), '', [rfReplaceAll]);
    tempstr := StringReplace(tempstr, chr(13), '', [rfReplaceAll]);

    fDataLock.Enter();
    foldMemSince := '[FOLDmemsince: not supported]';
    fDataLock.Leave();

    tempstr2 := copy(tempstr, pos('Date of last work unit', tempstr) + 22,
      500);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    fDataLock.Enter();
    foldLastWU := tempstr2;
    fDataLock.Leave();

    tempstr2 := copy(tempstr, pos('Total score', tempstr) + 11, 100);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    fDataLock.Enter();
    foldScore := tempstr2;
    fDataLock.Leave();

    tempstr2 := copy(tempstr, pos('Overall rank (if points are combined)',
      tempstr) + 37, 100);
    tempstr2 := copy(tempstr2, 1, pos('of', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    fDataLock.Enter();
    foldRank := tempstr2;
    fDataLock.Leave();

    tempstr2 := copy(tempstr, pos('Active processors (within 7 days)',
      tempstr) + 33, 100);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    fDataLock.Enter();
    foldActProcsWeek := tempstr2;
    fDataLock.Leave();

    tempstr2 := copy(tempstr, pos('Team', tempstr) + 4, 500);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    fDataLock.Enter();
    foldTeam := tempstr2;
    fDataLock.Leave();

    tempstr2 := copy(tempstr, pos('WU', tempstr) + 2, 500);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    if (pos('(', tempstr2) <> 0) then tempstr2 := copy(tempstr2, 1, pos('(',
      tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    fDataLock.Enter();
    foldWU := tempstr2;
    fDataLock.Leave();

  except
    on EExiting do raise;
    on E: Exception do
    begin
      fDataLock.Enter();
      try
        foldMemSince := '[fold: ' + E.Message + ']';
        foldLastWU := '[fold: ' + E.Message + ']';
        foldActProcsWeek := '[fold: ' + E.Message + ']';
        foldTeam := '[fold: ' + E.Message + ']';
        foldScore := '[fold: ' + E.Message + ']';
        foldRank := '[fold: ' + E.Message + ']';
        foldWU := '[fold: ' + E.Message + ']';
      finally
        fDataLock.Leave();
      end;
    end;
  end;
end;

procedure TFoldingDataThread.DoUpdate;
var
  MyDoUpdate : boolean;
  ScreenCount,LineCount : integer;
  screenline : string;
begin
  MyDoUpdate := false;
  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to config.height do
    begin
      screenline := config.screen[ScreenCount][LineCount].text;
      if (pos('$FOLD', screenline) <> 0) then MyDoUpdate := true;
    end;
  end;
  if MyDoUpdate then
    DoFoldingHTTPUpdate;
end;

end.
