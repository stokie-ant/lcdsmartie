unit WinampCtrl;

{ Created by Stu Pidass = Lee_Nover }
{ I've used all of the functions I found on winamp , DO use the Control,
  maybe change it ? taka a look at the code for explanations and stuff...
  comments, suggestions, anything .. to Lee.Nover@Email.si }


interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs,  ExtCtrls;

type
  TRunThread = class(TThread)
  public
    FileName: TFileName;
    Params: String;
    NewInstance: Boolean;
    procedure Execute;override;
  end;

  TWinampCtrl = class(TComponent)
  private
    { Private declarations }
    FWinampLocation: TFileName;
    FParams: String;
    RunThread: TRunThread;
    FTitleList: TStringList;
    FFileNameList: TStringList;
    FLengthList: TStringList;
    FFreeLists: Boolean;
    FAlwaysLoadList: Boolean;
    FUseBalanceCorrection: Boolean;

    Checkica: TTimer;
    PlaylistPos: integer;
    FOnSongChanged: TNotifyEvent;
    procedure SetWinampLocation(Value: TFileName);
    procedure SongChanged(Sender: TObject);//(var Msg: TWMSetText);message WM_SETTEXT;
  protected
    { Protected declarations }
    procedure LoadFileNameList;
    procedure LoadTitleList;
    procedure LoadLengthList;
  public
    { Public declarations }

    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;

    function GetState : integer;
    function GetOutputTime(TimeMode : Integer) : Int64;
    function GetSongInfo(InfoMode : Integer) : Integer;
    function GetEQData(Position : Integer) : Integer;
    function GetListCount : Integer;
    function GetListPos : Integer;
    function GetCurrSongTitle : String;
    // from within a Plugin only -----------------------------------------------
    function GetSongFileName(Position: Integer) : String;
    function GetSongTitle(Position: Integer) : String;
    // getting info from WinAmps internal playlist -----------------------------
    function PlayListGetSongTitle(Position: Integer):String;
    function PlayListGetSongFileName(Position: Integer):String;
    function PlayListGetSongLength(Position: Integer):Integer;
    // aditional Functions -----------------------------------------------------
    function TrackPosition: Int64;
    function TrackLength: Int64;
    function SampleRate: integer;
    function Frequency: integer;
    function NofChannels: integer;
    procedure EQEnable(Enable: Boolean);
    procedure EQAutoLoad(Enable: Boolean);

    procedure SaveTitleListToFile(FileName: TFileName);
    procedure SaveFileNameListToFile(FileName: TFileName);
    procedure StartPlay;
    Procedure Previous;
    Procedure Play;
    Procedure Pause;
    Procedure Stop;
    Procedure Next;
    procedure Previous_Shift;
    procedure Play_Shift;
    procedure Stop_Shift;
    procedure Next_Shift;
    procedure Previous_Ctrl;
    procedure Play_Ctrl;
    procedure Next_Ctrl;
    procedure StopAfterCurrTrack;
    Procedure Hide;
    Procedure Show;
    procedure SetVolume(Volume : Byte);
    procedure SetPanning(Panning : Byte);
    procedure SetEQData(Position,Value : Integer);
    procedure SetListPos(Position : Integer);
    procedure SetTimeDisplay(Remaining: Boolean);
    procedure ToggleEQ;
    procedure TogglePlaylist;
    procedure ToggleAutoscrolling;
    procedure ToggleWindowShade;
    procedure TogglePlayListWindowShade;
    procedure ToggleDoubleSize;
    procedure ToggleMainVisible;
    procedure ToggleMiniBrowser;
    procedure ToggleEasyMove;
    procedure ToggleRepeat;
    procedure ToggleShufflE;
    procedure ToggleAlwaysOnTop;
    procedure VolumeUp;
    procedure VolumeDown;
    procedure FastForward_5s;
    procedure Rewind_5s;
    procedure PopUpPrefs;
    procedure OpenFileInfoBox;
    procedure JumpToTime;
    procedure JumpToFile;
    procedure LoadFiles;
    procedure RunWinAmp(NewInstance: Boolean);
    procedure CloseWinAmp;

    procedure Seek(Offset: Integer);// in milliseconds

  published
    { Published declarations }
    property AlwaysLoadList: Boolean read FAlwaysLoadList write FAlwaysLoadList default False;
    property FreeLists: Boolean read FFreeLists write FFreeLists default false;
    property UseBalanceCorrection: Boolean read FUseBalanceCorrection write FUseBalanceCorrection default True;
    property WinampLocation: TFileName read fWinampLocation write SetWinampLocation;
    property Params: String read FParams write FParams;

    property OnSongChanged: TNotifyEvent read FOnSongChanged write FOnSongChanged;
  end;
  
implementation

var hwnd_winamp : integer;

const
  WinampClassName = 'winamp v1.x';

constructor TWinampCtrl.Create(AOwner: TComponent);
begin
     inherited;
     FFileNameList:=TStringList.Create;
     FTitleList:=TStringList.Create;
     FLengthList:=TStringList.Create;
     FFreeLists:=true;
     FUseBalanceCorrection:=true;
     Checkica:=TTimer.Create(AOwner);
     Checkica.Interval:=250;
     Checkica.OnTimer:=SongChanged;
     Checkica.Enabled:=true;
end;

destructor TWinampCtrl.Destroy;
begin
     if Assigned(FFileNameList)then FFileNameList.Free;
     if Assigned(FTitleList)then FTitleList.Free;
     if Assigned(FLengthList)then FLengthList.Free;
     Checkica.OnTimer:=nil;
     Checkica.Enabled:=false;
     Sleep(300);
     Checkica.Destroying;
     inherited;
end;

// WM_COMMAND messages ---------------------------------------------------------

Procedure TWinampCtrl.Previous;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  SendMessage(hwnd_winamp,WM_COMMAND,40044,0);
end;

Procedure TWinampCtrl.Play;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  sendMessage(hwnd_winamp,WM_COMMAND,40045,0);
end;

Procedure TWinampCtrl.Pause;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  SendMessage(hwnd_winamp,WM_COMMAND,40046,0);
end;

Procedure TWinampCtrl.Stop;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  SendMessage(hwnd_winamp,WM_COMMAND,40047,0);
end;

Procedure TWinampCtrl.Next;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  SendMessage(hwnd_winamp,WM_COMMAND,40048,0);
end;

procedure TWinampCtrl.FastForward_5s;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40060,0);
end;

procedure TWinampCtrl.Rewind_5s;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40061,0);
end;

// start of playlist
procedure TWinampCtrl.Previous_Ctrl;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40154,0);
end;

// open location
procedure TWinampCtrl.Play_Ctrl;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40155,0);
end;

// end of playlist
procedure TWinampCtrl.Next_Ctrl;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40158,0);
end;

// rewind 5 seconds
procedure TWinampCtrl.Previous_Shift;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40144,0);
end;

// open file(s)
procedure TWinampCtrl.Play_Shift;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40145,0);
end;

// fade out and stop
procedure TWinampCtrl.Stop_Shift;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40147,0);
end;

// fast forward 5 sec0nds
procedure TWinampCtrl.Next_Shift;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40148,0);
end;

procedure TWinampCtrl.StopAfterCurrTrack;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40157,0);
end;

procedure TWinampCtrl.ToggleEQ;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40036,0);
end;

procedure TWinampCtrl.TogglePlaylist;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40040,0);
end;

procedure TWinampCtrl.VolumeUp;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40058,0);
end;

procedure TWinampCtrl.VolumeDown;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40059,0);
end;

procedure TWinampCtrl.ToggleAlwaysOnTop;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40019,0);
end;

procedure TWinampCtrl.PopUpPrefs;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40012,0);
end;

procedure TWinampCtrl.OpenFileInfoBox;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40188,0);
end;

procedure TWinampCtrl.LoadFiles;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40029,0);
end;

procedure TWinampCtrl.SetTimeDisplay(Remaining: Boolean);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40037+Integer(Remaining),0)
end;

procedure TWinampCtrl.ToggleAutoscrolling;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40189,0);
end;

procedure TWinampCtrl.ToggleWindowShade;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40064,0);
end;

procedure TWinampCtrl.TogglePlayListWindowShade;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40266,0);
end;

procedure TWinampCtrl.ToggleDoubleSize;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40165,0);
end;

procedure TWinampCtrl.ToggleMainVisible;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40258,0);
end;

procedure TWinampCtrl.ToggleMiniBrowser;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40298,0);
end;

procedure TWinampCtrl.ToggleEasyMove;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40186,0);
end;

procedure TWinampCtrl.ToggleRepeat;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40022,0);
end;

procedure TWinampCtrl.ToggleShufflE;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40023,0);
end;

procedure TWinampCtrl.JumpToFile;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40194,0);
end;

procedure TWinampCtrl.JumpToTime;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40193,0);
end;

procedure TWinampCtrl.CloseWinAmp;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_COMMAND,40001,0);
end;

// WM_USER messages ------------------------------------------------------------

procedure TWinampCtrl.StartPlay;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,0,102);
end;

procedure TWinampCtrl.Seek(Offset: Integer);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,Offset,106);
end;

function TWinampCtrl.GetState: Integer;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=SendMessage(hwnd_winamp,WM_USER,0,104);
     {  States :
         0: Stopped
         1: Playing
         3: Paused }
end;

function TWinampCtrl.GetListCount: Integer;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=SendMessage(hwnd_winamp,WM_USER,0,124);
end;

function TWinampCtrl.GetListPos: integer;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=SendMessage(hwnd_winamp,WM_USER,0,125);
end;

function TWinampCtrl.GetOutputTime(TimeMode : Integer) : Int64;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=SendMessage(hwnd_winamp,WM_USER,TimeMode,105);
     { TimeMode :
        0 : Position in milliseconds
        1 : Length in seconds }
end;

// available only from an internal dll -----------------------------------------
// an alternative method is used just a bit down to get the Playlist info ------
function TWinampCtrl.GetSongFileName(Position: Integer) : String;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=PChar(SendMessage(hwnd_winamp,WM_USER,Position,211));
end;

function TWinampCtrl.GetSongTitle(Position: Integer) : String;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=PChar(SendMessage(hwnd_winamp,WM_USER,Position,212));
end;
// all other things work O.K. --------------------------------------------------

procedure TWinampCtrl.SetVolume(Volume : Byte);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,Volume,122);
end;

procedure TWinampCtrl.SetPanning(Panning : Byte);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     if FUseBalanceCorrection then begin// some strange logic for the Balance ?
        if Panning in[0..127] then Panning:=Panning+128 else// so correct it
        if Panning in[128..255] then Panning:=Panning-128;
     end;
     SendMessage(hwnd_winamp,WM_USER,Panning,123);
end;

procedure TWinampCtrl.SetListPos(Position : Integer);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,Position,121);
end;

function TWinampCtrl.GetSongInfo(InfoMode : Integer): Integer;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=SendMessage(hwnd_winamp,WM_USER,InfoMode,126);
     { InfoMode
     0 : SampleRate
     1 : BitRate
     2 : Channels }
end;

function TWinampCtrl.GetEQData(Position : Integer) : Integer;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     Result:=SendMessage(hwnd_winamp,WM_USER,Position,127);
     { Position :
      0-9 : the ten EQ bands from left to right : Result = 0-63 ( +20 - -20 dB )
      10 : the preamplifier value : Result = 0-63 ( +20 - -20 dB )
      11 : EQ Enabled : Result = 0 if EQ Disabled else Result = NonZero
      12 : Autoload Enabled : Result = 0 if EQ Disabled else Result = NonZero
     }
end;

procedure TWinampCtrl.SetEQData(Position,Value : Integer);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,Position,127);
     SendMessage(hwnd_winamp,WM_USER,Value,128);
end;

// some Additional functions (separated from existing functions)

function TWinampCtrl.TrackLength: int64;
begin
     Result:=GetOutputTime(1);
end;

function TWinampCtrl.TrackPosition: int64;
begin
     Result:=GetOutputTime(0);
end;

function TWinampCtrl.Frequency: integer;
begin
     Result:=GetSongInfo(1);
end;

function TWinampCtrl.SampleRate: integer;
begin
     Result:=GetSongInfo(0);
end;

function TWinampCtrl.NofChannels: integer;
begin
     Result:=GetSongInfo(2);
end;

procedure TWinampCtrl.EQAutoLoad(Enable: boolean);
begin
     SetEQData(12,Integer(Enable));
end;

procedure TWinampCtrl.EQEnable(Enable: boolean);
begin
     SetEQData(11,Integer(Enable));
end;

// loading lists ---------------------------------------------------------------

// FileNames list --------------------------------------------------------------
procedure TWinampCtrl.LoadFileNameList;
var P: Integer;
begin
     if not FileExists(FWinAmpLocation) then Exit;
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,0,120);
     FFileNameList.LoadFromFile(ExtractFilePath(FWinampLocation)+'winamp.m3u');
     FFileNameList.Delete(0);
     for P:=FFileNameList.Count-1 downto 0 do
         if (P mod 2)=0 then
            FFileNameList.Delete(P);
end;

// Titles list -----------------------------------------------------------------
procedure TWinampCtrl.LoadTitleList;
var P,L: Integer;
    S: String;
begin
     if not FileExists(FWinAmpLocation) then Exit;
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,0,120);
     FTitleList.LoadFromFile(ExtractFilePath(FWinampLocation)+'winamp.m3u');
     FTitleList.Delete(0);
     for P:=FTitleList.Count-1 downto 0 do
         if (P mod 2)<>0 then
            FTitleList.Delete(P)
         else begin
              S:=FTitleList.Strings[P];
              L:=Pos(',',S);
              FTitleList.Strings[P]:=Copy(S,L+1,Length(S)-L);
         end;
end;

// Length list -----------------------------------------------------------------
procedure TWinampCtrl.LoadLengthList;
var P,L,X: Integer;
    S: String;
begin
     if not FileExists(FWinAmpLocation) then Exit;
     hwnd_winamp := FindWindow(WinampClassName,nil);
     SendMessage(hwnd_winamp,WM_USER,0,120);
     FLengthList.LoadFromFile(ExtractFilePath(FWinampLocation)+'winamp.m3u');
     FLengthList.Delete(0);
     for P:=FLengthList.Count-1 downto 0 do
         if (P mod 2)<>0 then
            FLengthList.Delete(P)
         else begin
              S:=FLengthList.Strings[P];
              L:=Pos(',',S);
              X:=Pos(':',S);
              FLengthList.Strings[P]:=Copy(S,X+1,L-X-1);
         end;
end;

// Retrieving PlayList info ----------------------------------------------------

// Songs FileName --------------------------------------------------------------
function TWinampCtrl.PlayListGetSongFileName(Position: Integer):String;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     if FFreeLists and (FFileNameList=NIL) then FFileNameList:=TStringList.Create;

     if ((FFileNameList.Count * 2)+1 <> SendMessage(hwnd_winamp,WM_USER,0,124))
     or FAlwaysLoadList then LoadFileNameList;

     if Position >= FFileNameList.Count then Position:=FFileNameList.Count-1;
     if Position < 0 then Position:=0;
     Result:=FFileNameList.Strings[Position];
     if FFreeLists and (Assigned(FFileNameList)) then FFileNameList.Free;
end;

// Songs Title -----------------------------------------------------------------
function TWinampCtrl.PlayListGetSongTitle(Position: Integer):String;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     if FFreeLists and (FTitleList=NIL) then FTitleList:=TStringList.Create;

     if ((FTitleList.Count * 2)+1 <> SendMessage(hwnd_winamp,WM_USER,0,124))
     or FAlwaysLoadList then LoadTitleList;

     if Position >= FTitleList.Count then Position:=FTitleList.Count-1;
     if Position < 0 then Position:=0;
     Result:=FTitleList.Strings[Position];
     if FFreeLists and (Assigned(FTitleList)) then FTitleList.Free;
end;

// Songs Length in seconds -----------------------------------------------------
function TWinampCtrl.PlayListGetSongLength(Position: Integer):Integer;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     if FFreeLists and (FLengthList=NIL) then FLengthList:=TStringList.Create;

     if ((FLengthList.Count * 2)+1 <> SendMessage(hwnd_winamp,WM_USER,0,124))
     or FAlwaysLoadList then LoadLengthList;

     if Position >= FLengthList.Count then Position:=FLengthList.Count-1;
     if Position < 0 then Position:=0;
     Result:=StrToInt(FLengthList.Strings[Position]);
     if FFreeLists and (Assigned(FLengthList)) then FLengthList.Free;
end;

procedure TWinampCtrl.SaveFileNameListToFile(FileName: TFileName);
begin
     if FFreeLists and (FFileNameList=NIL) then FFileNameList:=TStringList.Create;
     LoadFileNameList;
     FFileNameList.SaveToFile(FileName);
     if FFreeLists and (Assigned(FFileNameList)) then FFileNameList.Free;
end;

procedure TWinampCtrl.SaveTitleListToFile(FileName: TFileName);
begin
     if FFreeLists and (FTitleList=NIL) then FTitleList:=TStringList.Create;
     LoadTitleList;
     FTitleList.SaveToFile(FileName);
     if FFreeLists and (Assigned(FTitleList)) then FTitleList.Free;
end;

// miscelaneous stuff ----------------------------------------------------------

// hide manually ---------------------------------------------------------------
procedure TWinampCtrl.Hide;
var
  WP : TWindowPlaceMent;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  wp.length := SizeOf(TWindowPlaceMent);
  wp.showCmd := SW_HIDE;
  SetWindowPlacement(hwnd_winamp,@wp);
end;

// show manually ---------------------------------------------------------------
procedure TWinampCtrl.Show;
var
  WP : TWindowPlaceMent;
begin
  hwnd_winamp := FindWindow(WinampClassName,nil);
  wp.length := SizeOf(TWindowPlaceMent);
  wp.showCmd := SW_SHOW;
  SetWindowPlacement(hwnd_winamp,@wp);
end;

// here we read the WinAmp Title :-) -------------------------------------------
function TWinampCtrl.GetCurrSongTitle: String;
var WATitle: PChar;
    Stringica: String;
    I,Sizica: Integer;
    s: string;
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     if hwnd_winamp=0 then exit;
     Sizica:=GetWindowTextLength(hwnd_winamp);
     WATitle:=StrAlloc(Sizica+1);// allocte the memory for the buffer
     GetWindowText(hwnd_Winamp,WATitle,Sizica+1);
     Stringica:=StrPas(WATitle);
     StrDispose(WATitle);// free the memory
     for I:=1 to Length(Stringica) do begin
         s:=Copy(Stringica,I,8);
         if LowerCase(s)='- winamp' then break;
     end;
     Result:=Copy(Stringica,1,I-1);
end;

procedure TWinampCtrl.SongChanged(Sender: TObject);//(var Msg: TWMSetText);
begin
     hwnd_winamp := FindWindow(WinampClassName,nil);
     if hwnd_winamp=0 then exit;
     if PlaylistPos<>GetListPos then begin
        PlaylistPos:=GetListPos;
        if Assigned(FOnSongChanged) then FOnSongChanged(Self);
     end;
end;

//running WinAmp ---------------------------------------------------------------

procedure TWinampCtrl.RunWinAmp(NewInstance: Boolean);
begin
     if fWinAmpLocation='' then begin
        MessageBox(0,'No file to run','Error',mb_IconError);
        Exit;
     end;
     if FileExists(fWinAmpLocation) then begin
        if LowerCase(ExtractFileExt(fWinAmpLocation))='.exe' then begin
           RunThread:=TRunThread.Create(true);
           RunThread.FileName:=fWinAmpLocation;
           RunThread.Params:=FParams;
           RunThread.NewInstance:=NewInstance;
           RunThread.FreeOnTerminate:=true;
           RunThread.Priority:=tpNormal;
           RunThread.Resume;
        end
        else MessageBox(0,'Not an executable file!','Error',mb_IconError);
     end
     else MessageBox(0,'File doesn''t exist!','Error',mb_IconError);
end;

procedure TWinampCtrl.SetWinampLocation(Value: TFileName);
begin
     if Value <> fWinAmpLocation then fWinAmpLocation:=Value;
end;

// executing winamp ------------------------------------------------------------

procedure TRunThread.Execute;
begin
     if NewInstance then WinExec(PChar(FileName+' /NEW'+' '+Params),SW_SHOW)
     else WinExec(PChar(FileName+' '+Params),SW_SHOW);
end;

end.
