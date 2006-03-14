unit UData;
{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/UData.pas,v $
 *  $Revision: 1.68 $ $Date: 2006/03/14 21:20:56 $
 *****************************************************************************}


interface

uses Classes, xmldom, XMLIntf, SysUtils, xercesxmldom, XMLDoc,
  msxmldom, ComCtrls, ComObj, UUtils, IdHTTP, SyncObjs, UConfig,
  UDataEmail, UDataMBM;

const
  maxRssItems = 20;
  iMaxPluginFuncs = 20;

type
  THTTPUpdateType = (huRSS,huLCDSmartie,huSETI,huFolding);
const
  FirstHTTPUpdate = huRSS;
  LastHTTPUpdate = huFolding;
type

  TRss = Record
    url: String;
    title: Array [0..maxRssItems] of String; // 0 is all titles
    desc: Array [0..maxRssItems] of String;   // 0 is all descs
    items: Cardinal;
    whole: String;                            // all titles and descs
    maxfreq: Cardinal;                        // hours - 0 means no restriction
  end;

  PHttp = ^TIdHttp;

  TMyProc = function(param1: pchar; param2: pchar): Pchar; stdcall;
  TFiniProc = procedure(); stdcall;
  TBridgeProc = function(iBridgeId: Integer; iFunc: Integer; param1: pchar; param2: pchar): Pchar; stdcall;

  TDll = Record
    sName: String;
    hDll: HMODULE;
    bBridge: Boolean;
    iBridgeId: Integer;
    functions: Array [1..iMaxPluginFuncs] of TMyProc;
    bridgeFunc: TBridgeProc;
    finiFunc: TFiniProc;
    uiLastRefreshed: Cardinal;  // time when Dll results were refreshed.
    uiMinRefreshInterval: Cardinal; // min Refresh interval between refreshes.
  end;

  TData = Class(TObject)
  private
    localeFormat : TFormatSettings;
    usFormat : TFormatSettings; //this is initialized with US/English
    cacheresult_lastFindPlugin: Cardinal;
    cache_lastFindPlugin: String;
    uiScreenStartTime: Cardinal; // time that new start refresh started (used by plugin cache code)
    bNewScreenEvent: Boolean;
    bForceRefresh: Boolean;
    dataCs: TCriticalSection;  // data + main thread
    fdataThread : TMyThread;
    replline2, replline1: String;

    // DLL plugins
    dlls: Array of TDll;
    uiTotalDlls: Cardinal;
    sDllResults: array of string;
    iDllResults: Integer;

    // http
    doHTTPUpdate : boolean;
    httpCs: TCriticalSection;  // data + main thread
    httpCopy: PHttp;   // so we can cancel the request. Guarded by httpCs
    DoNewsUpdate: Array [THTTPUpdateType] of Boolean;  // data thread only
    rssCs: TCriticalSection;  // protecting rss & rssCs
    rss: Array of TRss;    // Guarded by rssCs, data + main thread
    rssEntries: Cardinal;  // Guarded by rssCs, data + main thread
    setiNumResults, setiCpuTime, setiAvgCpu, setiLastResult, setiUserTime,
      setiTotalUsers, setiRank, setiShareRank, setiMoreWU: String; //Guarded by dataCs, data+main threads
    foldMemSince, foldLastWU, foldActProcsWeek, foldTeam, foldScore,
      foldRank, foldWU: String;                              //Guarded by dataCs, data+main threads

    // email thread
    EmailThread : TEmailDataThread;  // keep a copy for mainline "GotMail"
    MBMThread : TMBMDataThread;  // for finding MBM cpu speed
    DataThreads : TList;  // of TDataThread

    // data thread
    procedure doDataThread;
    // other variables
    procedure ResolveOtherVariables(var line: String);
    procedure ResolveTimeVariable(var line: String);
    procedure ResolveStringFunctionVariables(var line: String);
    procedure ResolveLCDFunctionVariables(var line: String);
    // file data
    procedure ResolveFileVariables(var line: String);
    // dll plugins
    procedure LoadPlugin(sDllName: String; bDotNet: Boolean = false);
    procedure ResolvePluginVariables(var line: String; qstattemp: Integer;
      bCacheResults: Boolean);
    // winamp
    procedure ResolveWinampVariables(var Line: string);
    // dist.net
    procedure ResolveDNetVariables(var Line : string);
    // MBM stats
    function  GetMBMActive : boolean;
    // HTTP stuff
    function getUrl(Url: String; maxfreq: Cardinal = 0): String;
    function getRss(Url: String;var titles, descs: Array of String; maxitems:
      Cardinal; maxfreq: Cardinal = 0): Cardinal;
    procedure DoRSSHTTPUpdate;
    procedure ResolveRSSVariables(var line: String);
    procedure DoLCDSmartieHTTPUpdate;
    procedure DoSETIHTTPUpdate;
    procedure ResolveSETIVariables(var Line : string);
    procedure DoFoldingHTTPUpdate;
    procedure ResolveFoldingVariables(var Line : string);
    procedure FetchHTTPUpdates;
    procedure HTTPUpdate;
    // e-mail stuff
    function  GetGotEmail : boolean;
  public
    lcdSmartieUpdate: Boolean;    // data+main threads
    lcdSmartieUpdateText: String; // data+main threads
    isconnected: Boolean;         // data+main threads
    cLastKeyPressed: Char;
    procedure ScreenStart;
    procedure ScreenEnd;
    procedure NewScreen(bYes: Boolean);
    function change(line: String; qstattemp: Integer = 1;
      bCacheResults: Boolean = false): String;
    function CallPlugin(uiDll: Integer; iFunc: Integer;
                    const sParam1: String; const sParam2:String) : String;
    function FindPlugin(const sDllName: String): Cardinal;
    procedure UpdateDNetStats(Sender: TObject);
    procedure UpdateHTTP;
    constructor Create;
    destructor Destroy; override;
    function CanExit: Boolean;
    procedure RefreshDataThreads;
    //
    property GotEmail : boolean read GetGotEmail;
    property MBMActive : boolean read GetMBMActive;
  end;



implementation

uses
  Winsock, UMain, Windows, Forms,
  IpIfConst, Dialogs, Buttons, Graphics, ShellAPI,
  mmsystem, ExtActns, Messages, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, Menus,
  ExtCtrls, Controls, StdCtrls, StrUtils, ActiveX, IdUri, DateUtils, IdGlobal,

  DataThread, UDataNetwork, UDataDisk, UDataGame, UDataMemory,
  UDataCPU;




///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      M A I N   D A T A    F U N C T I O N S                           ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


constructor TData.Create;
var
  status: Integer;
  WSAData: TWSADATA;
  DataThread : TDataThread;
begin
  inherited;

  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, localeFormat);
  GetLocaleFormatSettings($0409,                usFormat);  //English/USA

  status := WSAStartup(MAKEWORD(2,0), WSAData);
  if status <> 0 then
     raise Exception.Create('WSAStartup failed');

  isconnected := false;
  uiTotalDlls := 0;
  lcdSmartieUpdate := False;

  DataThreads := TList.Create;

  EmailThread := TEmailDataThread.Create;  // keep a copy for mainline GotEmail call
  EmailThread.Resume;
  DataThreads.Add(EmailThread);

  MBMThread :=  TMBMDataThread.Create;  // keep a copy for finding MBM cpu speed
  MBMThread.Resume;
  DataThreads.Add(MBMThread);

  DataThread := TGameDataThread.Create;
  DataThread.Resume;
  DataThreads.Add(DataThread);

  DataThread := TNetworkDataThread.Create;
  DataThread.Resume;
  DataThreads.Add(DataThread);

  DataThread := TDiskDataThread.Create;
  DataThread.Resume;
  DataThreads.Add(DataThread);

  DataThread := TMemoryDataThread.Create;
  DataThread.Resume;
  DataThreads.Add(DataThread);

  DataThread := TCPUDataThread.Create(MBMThread);
  DataThread.Resume;
  DataThreads.Add(DataThread);

  doHTTPUpdate := True;

  httpCs := TCriticalSection.Create();
  rssCs := TCriticalSection.Create();
  dataCs := TCriticalSection.Create();

  // Start data collection thread
  fdataThread := TMyThread.Create(self.doDataThread);
  fdataThread.Resume;
end;

function TData.CanExit: Boolean;
var
  uiDll: Cardinal;
  Loop : longint;
begin
  for Loop := 0 to DataThreads.Count-1 do begin
    TDataThread(DataThreads[Loop]).Terminate;
  end;

  if (Assigned(fdataThread)) then
    fdataThread.Terminate;

  // close all plugins
  for uiDll:=1 to uiTotalDlls do
  begin
    try
      if (dlls[uiDll-1].hDll <> 0) then
      begin
        // call SmartieFini if it exists
        if (Assigned(dlls[uiDll-1].finiFunc)) then
        begin
          try
            dlls[uiDll-1].finiFunc();
          except
            on E: Exception do
              raise Exception.Create('Plugin '+dlls[uiDll-1].sName+' had an exception during closedown: '
              + E.Message);
          end;
        end;
        FreeLibrary(dlls[uiDll-1].hDll);
      end;
    except
    end;
    dlls[uiDll-1].hDll := 0;
  end;
  uiTotalDlls := 0;


  // Cancel outstanding http/pop3 requests
  if (Assigned(httpCs)) then
  begin
    httpCs.Enter();
    try
      try
        if (httpCopy <> nil) then
          httpCopy^.DisconnectSocket();
      except
      end;
    finally
      httpCs.Leave();
    end;
  end;

  Result := True;
  { code not needed - yet as the above method of cancelling seems to work
  if (Assigned(fdataThread)) then
  begin
    Wait for 30 seconds and then just give up.
    if (fdataThread.Exited.WaitFor(30000) <> wrSignaled) then
      Result := False;
  end; }
end;

destructor TData.Destroy;
var
  Loop : longint;
begin

  if (Assigned(fdataThread)) then
  begin
    fdataThread.WaitFor();
    fdataThread.Free();

    if Assigned(httpCs) then httpCs.Free;
    if Assigned(rssCs) then rssCs.Free;
    if Assigned(dataCs) then dataCs.Free;
  end;

  for Loop := 0 to DataThreads.Count-1 do begin
    TDataThread(DataThreads[Loop]).WaitFor;
    TDataThread(DataThreads[Loop]).Free;
  end;

  DataThreads.Free;

  WSACleanup();

  inherited;
end;


procedure TData.RefreshDataThreads;
var
  Loop : longint;
begin
  for Loop := 0 to DataThreads.Count-1 do begin
    TDataThread(DataThreads[Loop]).Refresh;
  end;
end;

procedure TData.NewScreen(bYes: Boolean);
var
  Loop : longint;
begin
  bNewScreenEvent := bYes;
  if (bYes) then
  begin
    LCDSmartieDisplayForm.MBMUpdateTimer.Interval := 0;
    LCDSmartieDisplayForm.MBMUpdateTimer.Interval := 250; // force an update of Mbm, etc data in 0.25 seconds
    bForceRefresh := true;
    for Loop := 0 to DataThreads.Count-1 do begin
      TDataThread(DataThreads[Loop]).Active := false;
    end;
  end;
end;

procedure TData.ScreenStart;
begin
  iDllResults := 0;
  uiScreenStartTime := GetTickCount();
end;

procedure TData.ScreenEnd;
begin
  bForceRefresh := false;
end;

function TData.change(line: String; qstattemp: Integer = 1;
   bCacheResults: Boolean = false): String;
label
  endChange;
var
  Loop : longint;
begin
  try
    for Loop := 0 to DataThreads.Count-1 do begin
      TDataThread(DataThreads[Loop]).ResolveVariables(Line);
      if (Pos('$', line) = 0) then break;
    end;

    ResolvePluginVariables(line, qstattemp, bCacheResults);
    if (Pos('$', line) = 0) then goto endChange;
    ResolveOtherVariables(Line);
    ResolveFileVariables(Line);
    ResolveLCDFunctionVariables(Line);
    if (Pos('$', line) = 0) then goto endChange;
    ResolveWinampVariables(line);
    ResolveDNetVariables(Line);
    ResolveSETIVariables(Line);
    ResolveFoldingVariables(Line);
    if (Pos('$', line) = 0) then goto endChange;
    ResolveTimeVariable(Line);
    ResolveRSSVariables(Line);
    ResolveStringFunctionVariables(Line);
endChange:
  except
    on E: Exception do line := '[Unhandled Exception: '
      + CleanString(E.Message) + ']';
  end;

  line := StringReplace(line, Chr($A), '', [rfReplaceAll]);
  line := StringReplace(line, Chr($D), '', [rfReplaceAll]);
  result := line;
end;

// Runs in data thread
procedure TData.doDataThread;
begin
  coinitialize(nil);

  try
    try
      while (not fdataThread.Terminated) do
      begin
        if (not fdataThread.Terminated) and (doHTTPUpdate) then HTTPUpdate;
        if (not fdataThread.Terminated) then sleep(1000);
      end;
    finally
      CoUninitialize;
    end;
  except
    on E: EExiting do Exit;
    else raise;
  end;
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      R E S O L V E    O T H E R    V A R I A B L E S                  ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TData.ResolveOtherVariables(var line: String);
var
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  spacecount : Integer;
  ccount: double;
  tempst : String;
  iPos1, iPos2 : Integer;
  screenResolution: String;
begin
  if (pos('$ScreenReso', line) <> 0) then begin
    screenResolution := IntToStr(Screen.DesktopWidth) + 'x' +
      IntToStr(Screen.DesktopHeight);

    line := StringReplace(line, '$ScreenReso', screenResolution,
      [rfReplaceAll]);
  end;


  if decodeArgs(line, '$MObutton', maxArgs, args, prefix, postfix, numargs)
    then
  begin
    spacecount := 0;
    if (numargs = 1) and (cLastKeyPressed = args[1]) then spacecount := 1;

    line := prefix + intToStr(spacecount) + postfix;
  end;

  if pos('$ScreenChanged', line) <> 0 then
  begin
    spacecount := 0;
    if (bNewScreenEvent) then
      spacecount := 1;

    line := StringReplace(line, '$ScreenChanged', IntToStr(spacecount), [rfReplaceAll]);
  end;

  while decodeArgs(line, '$Count', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    ccount := 0;
    try
      RequiredParameters(numargs, 1, 1);
      tempst := args[1];
      iPos1 := 1;
      iPos2 := pos('#', tempst);

      repeat
        if (iPos2 = 0) then
          ccount := ccount + StrToFloatN(tempst, iPos1, length(tempst)-iPos1+1)
        else
          ccount := ccount + StrToFloatN(tempst, iPos1, iPos2-iPos1);
        iPos1 := iPos2 + 1;
        iPos2 := PosEx('#', tempst, iPos1);
      until (iPos1 = 1);

      line := prefix + FloatToStr(ccount, localeFormat) + postfix;
    except
      on E: Exception do line := prefix + '[Count: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;


end;

procedure TData.ResolveTimeVariable(var line: String);
var
  tempst, line2 : String;
begin
  while pos('$Time(', line) <> 0 do
  begin
    try
      line2 := copy(line, pos('$Time(', line) + 6, length(line));
      if (pos(')', line2) = 0) then
        raise Exception.Create('No ending bracket');
      line2 := copy(line2, 1, pos(')', line2)-1);
      tempst := formatdatetime(line2, now, localeFormat);
      line := StringReplace(line, '$Time(' + line2 + ')', tempst, []);
    except
      on E: Exception do line := StringReplace(line, '$Time(', '[Time: '
        + CleanString(E.Message) + ']', []);
    end;
  end;
end;

procedure TData.ResolveLCDFunctionVariables(var line: String);
var
  spaceline, line2 : String;
  h, iPos1, iPos2 : Integer;
begin
  iPos1 :=  pos('$CustomChar(', line);
  while (iPos1 <> 0) do
  begin
    try
      iPos2 := PosEx(')', line, iPos1+12);
      if (iPos2 = 0) then
        raise Exception.Create('No ending bracket');
      LCDSmartieDisplayForm.customchar(AnsiMidStr(line, iPos1+12, iPos2-(iPos1+12)));
      Delete(line, iPos1, iPos2-iPos1+1);
    except
      on E: Exception do line := StringReplace(line, '$CustomChar(',
        '[CustomChar: ' + CleanString(E.Message) + ']', []);
    end;
    iPos1 :=  PosEx('$CustomChar(', line, iPos1);
  end;

  while (pos('$Flash(', line) <> 0) do
  begin
    try
      line2 := copy(line, pos('$Flash(', line) + 7, (pos('$)$',
        line))-(pos('$Flash(', line) + 7));
      if (LCDSmartieDisplayForm.doesflash) then
      begin
        spaceline := '';
        for h := 1 to length(line2) do
        begin
          spaceline := spaceline + ' ';
        end;
      end
      else
      begin
        spaceline := line2;
      end;
      if pos('$)$', line) <> 0 then line := StringReplace(line, '$Flash('
        + line2 + '$)$', spaceline, [])
      else line := StringReplace(line, '$Flash(', 'ERROR', []);
    except
      on E: Exception do line := StringReplace(line, '$Flash(', '[Flash: '
        + CleanString(E.Message) + ']', []);
    end;
  end;
end;

procedure TData.ResolveStringFunctionVariables(var line: String);
var
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  h, x, iPos1, iPos2, iPos3: Integer;
  spacecount : Integer;
  spaceline : string;
  STHDBar: String;
begin

  iPos1 := pos('$Right(', line);
  while iPos1 <> 0 do
  begin
    try
      iPos2 := PosEx(',$', line, iPos1+1);
      if (iPos2 = 0) then
        raise Exception.Create('Missing ",$"');

      iPos3 := PosEx('%)', line, iPos2+2);
      if (iPos3 = 0) then
        raise Exception.Create('Missing "%)"');

      spacecount := StrToIntN(line, iPos2 + 2, iPos3-(iPos2+2));
      Delete(line, iPos2, (iPos3+2)-iPos2);
      Delete(line, iPos1, 7);
      if (spacecount >  iPos2-(iPos1+7)) then
        Insert(DupeString(' ', spacecount-(iPos2-(iPos1+7))), line, iPos1);
    except
      on E: Exception do line := StringReplace(line, '$Right(', '[Right: '
        + CleanString(E.Message) + ']', []);
    end;

    iPos1 := PosEx('$Right(',line,iPos1);
  end;

  while decodeArgs(line, '$Center', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    try
      RequiredParameters(numargs, 1, 2);
      if (numargs = 1) then spacecount := config.width
      else spacecount := StrToInt(args[2]);

      line := prefix + CenterText(args[1], spacecount) + postfix;
    except
      on E: Exception do line := prefix + '[Center: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$Chr', maxArgs, args, prefix, postfix, numargs) do
  begin
    try
      RequiredParameters(numargs, 1, 1);
      line := prefix + Chr(StrToInt(args[1])) + postfix;
    except
      on E: Exception do line := prefix + '[Chr: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$Fill', maxArgs, args, prefix, postfix, numargs) do
  begin
    try
      RequiredParameters(numargs, 1, 1);
      spacecount := StrToInt(args[1]);
      spaceline := '';

      if spacecount > length(prefix) then
        spaceline := DupeString(' ', spacecount - length(prefix));

      line := prefix + spaceline + postfix;
    except
      on E: Exception do line := prefix + '[Fill: ' + E.Message + ']' +
        postfix;
    end;
  end;

  while decodeArgs(line, '$Bar', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    try
      RequiredParameters(numargs, 3, 3);
      spacecount := strtoint(args[3])*3;

      if (StrToFloat(args[2], localeFormat) <> 0) then
        x := round(StrToFloat(args[1], localeFormat)
                  * spacecount / StrToFloat(args[2], localeFormat))
      else x := 0;

      if x > spacecount then x := spacecount;
      STHDBar := '';
      for h := 1 to (x div 3) do STHDBar := STHDBar + 'ž';
      if (x mod 3 = 1) then STHDBar := STHDBar + chr(131);
      if (x mod 3 = 2) then STHDBar := STHDBar + chr(132);
      for h := 1 to round(spacecount/3)-length(STHDBar) do STHDBar :=
        STHDBar + '_';

      line := prefix + STHDBar + postfix;
    except
      on E: Exception do line := prefix + '[Bar: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

end;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      L O A D   F R O M    F I L E    P R O C E D U R E S              ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TData.ResolveFileVariables(var line: String);
var
  hdcounter: Integer;
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  spaceline, sFileloc : string;
  i,iFileline: Integer;
  FileStream: TFileStream;
  Lines: TStringList;
  fFile3: textfile;
  line3 : string;
  iBytesToRead: Integer;
  counter3: Integer;
begin
  hdcounter := 0;
  while decodeArgs(line, '$LogFile', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    try
      hdcounter := hdcounter + 1;
      if hdcounter > 4 then line := StringReplace(line, '$LogFile(',
        'error', []);

      sFileloc := args[1];
      if (sFileloc[1] = '"') and (sFileloc[Length(sFileLoc)] = '"') then
        sFileloc := copy(sFileloc, 2, Length(sFileloc)-2);

      if (not FileExists(sFileloc)) then
        raise Exception.Create('No such file');

      RequiredParameters(numargs, 2, 2);
      iFileline := StrToInt(args[2]);

      if iFileline > 3 then iFileline := 3;
      if iFileline < 0 then iFileline := 0;

      FileStream := TFileStream.Create(sFileloc, fmOpenRead or fmShareDenyNone);
      iBytesToRead := 1024;
      if (FileStream.Size < iBytesToRead) then
        iBytesToRead := FileStream.Size;
      SetLength(spaceline, iBytesToRead);

      FileStream.Seek(-1 * iBytesToRead, soFromEnd);
      FileStream.ReadBuffer(spaceline[1], iBytesToRead);
      FileStream.Free;

      Lines := TStringList.Create;
      Lines.Text := spaceline;
      spaceline := stripspaces(lines[lines.count - iFileline]);
      if (pos('] ', spaceline) <> 0) then
        spaceline := copy(spaceline, pos('] ', spaceline) + 2, length(spaceline));

      for i := 0 to 7 do spaceline := StringReplace(spaceline, chr(i), '',
        [rfReplaceAll]);
      Lines.Free;
      line := prefix + spaceline + postfix;
    except
      on E: Exception do line := prefix + '[LogFile: '
        + CleanString(E.message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$File', maxArgs, args, prefix, postfix, numargs) do
  begin
    sFileloc := args[1];
    if (sFileloc[1] = '"') and (sFileloc[Length(sFileLoc)] = '"') then
      sFileloc := copy(sFileloc, 2, Length(sFileloc)-2);

    try
      RequiredParameters(numargs, 2, 2);
      iFileline := StrToInt(args[2]);
      if (not FileExists(sFileloc)) then
        raise Exception.Create('No such file');
      assignfile(fFile3, sFileloc);
      reset(fFile3);
      for counter3 := 1 to iFileline do readln(fFile3, line3);
      closefile(fFile3);
      line := prefix + line3 + postfix;
    except
      on E: Exception do line := prefix + '[File: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      D L L    P L U G I N        P R O C E D U R E S                  ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TData.ResolvePluginVariables(var line: String; qstattemp: Integer;
  bCacheResults: Boolean);
var
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  sParam1, sParam2: String;
  sAnswer: String;
  uiPlugin: Cardinal;
  uiMinRefresh: Cardinal;
  bCallPlugin: Boolean;
begin
  while decodeArgs(line, '$dll', maxArgs, args, prefix, postfix, numargs) do
  begin
    try
      RequiredParameters(numargs, 4, 4);

      uiPlugin := FindPlugin(args[1]);
      if (bCacheResults) and (not bForceRefresh) then
      begin
        if (dlls[uiPlugin].uiMinRefreshInterval < Cardinal(config.dllPeriod)) then
          uiMinRefresh := config.dllPeriod
        else
          uiMinRefresh := dlls[uiPlugin].uiMinRefreshInterval;

        if (uiScreenStartTime <= dlls[uiPlugin].uiLastRefreshed)
          or (uiScreenStartTime - dlls[uiPlugin].uiLastRefreshed > uiMinRefresh) then
        begin
          dlls[uiPlugin].uiLastRefreshed := uiScreenStartTime;

          bCallPlugin := True;
        end
        else
          bCallPlugin := False;
      end
      else
        bCallPlugin := True; // always call, if new screen or not to be cached.

      if (bCallPlugin) then
      begin
        sParam1 := change(args[3], qstattemp);
        sParam2 := change(args[4], qstattemp);
        try
          sAnswer := CallPlugin(uiPlugin, StrToInt(args[2]), sParam1, sParam2);
        except
          on E: Exception do
            sAnswer := '[Dll: ' + CleanString(E.Message) + ']';
        end;
      end;

      if (bCacheResults) then
      begin
        Inc(iDllResults);
        if (iDllResults >= Length(sDllResults)) then
           SetLength(sDllResults, iDllResults + 5);

        if (bCallPlugin) then
          sDllResults[iDllResults] := sAnswer // save result
        else
          sAnswer := sDllResults[iDllResults]; // get cached result
      end;

      sAnswer := change(sAnswer, qstattemp);

      line := prefix +  sAnswer + postfix;
    except
      on E: Exception do
        line := prefix + '[Dll: ' + CleanString(E.Message) + ']' + postfix;
    end;
  end;
end;

function TData.FindPlugin(const sDllName: String): Cardinal;
var
  uiDll: Cardinal;
  sLoadDllName: String;
begin
  // for speed reason - check if this is the same plugin as the last one:
  if (sDllName = cache_lastFindPlugin) then
    Result := cacheresult_lastFindPlugin
  else
  begin

    // check if we have seen this dll before
    sLoadDllName := sDllName;
    if (Pos('.DLL', UpperCase(sLoadDllName)) = 0) then
      sLoadDllName := sLoadDllName + '.dll';
    uiDll:=1;
    while (uiDll<=uiTotalDlls) and (dlls[uiDll-1].sName <> sLoadDllName) do
      Inc(uiDll);
    Dec(uiDll);

    if (uiDll >= uiTotalDlls) then
    begin // we havent seen this one before - load it
      try
        LoadPlugin(sLoadDllName);
      except
        on E: Exception do
          showmessage('Load of plugin failed: ' + e.Message)
      end;
    end;

    cacheresult_lastFindPlugin := uiDll;
    cache_lastFindPlugin := sDllName;

    Result := uiDll;
  end;
end;

function TData.CallPlugin(uiDll: Integer; iFunc: Integer;
                    const sParam1: String; const sParam2:String) : String;
begin
  if (dlls[uiDll].hDll <> 0) then
  begin
    if (iFunc >= 0) and (iFunc <= iMaxPluginFuncs) then
    begin
      if (iFunc = 0) then iFunc := 10;
      try
        if (dlls[uiDll].bBridge) then
        begin
          if (@dlls[uiDll].bridgeFunc = nil) then
            raise Exception.Create('No Bridge Func');
          Result := dlls[uiDll].bridgeFunc( dlls[uiDll].iBridgeId, iFunc,
             pchar(sParam1), pchar(sParam2) );
        end
        else if @dlls[uiDll].functions[iFunc] <> nil then
          Result := dlls[uiDll].functions[iFunc]( pchar(sParam1), pchar(sParam2) )
        else
          Result := '[Dll: Function not found]';
      except
        on E: Exception do
          Result := '[Dll: ' + CleanString(E.Message) + ']';
      end;
    end
    else
      Result := '[Dll: function number out of range]';
  end
  else
    Result := '[Dll: Can not load plugin]';
end;

procedure TData.LoadPlugin(sDllName: String; bDotNet: Boolean = false);
type
  TBridgeInit = function(dll: PChar; var id: Integer; var refresh: Integer): PChar; stdcall;
  TMinRefreshFunc = function: Integer; stdcall;
var
  uiDll: Cardinal;
  i: Integer;
  id: Integer;
  minRefresh: Integer;
  initFunc:  procedure; stdcall;
  minRefreshFunc: TMinRefreshFunc;
  bridgeInitFunc: TBridgeInit;
  bFound: Boolean;
  sLibraryPath: String;
  sResult: String;
begin
  bFound := false;

  uiDll := uiTotalDlls;

  Inc(uiTotalDlls);
  SetLength(dlls, uiTotalDlls);
  dlls[uiDll].sName := sDllName;
  dlls[uiDll].uiLastRefreshed := 0;
  dlls[uiDll].uiMinRefreshInterval := 300;

  dlls[uiDll].bBridge := bDotNet;
  if (bDotNet) then
    sLibraryPath := 'DNBridge.dll'
  else
    sLibraryPath := 'plugins\' + sDllName;

  dlls[uiDll].hDll := LoadLibrary(pchar(extractfilepath(application.exename) +
    sLibraryPath));

  if (dlls[uiDll].hDll <> 0) then
  begin
    initFunc := getprocaddress(dlls[uiDll].hDll, PChar('SmartieInit'));
    if (not Assigned(initFunc)) then
      initFunc := getprocaddress(dlls[uiDll].hDll, PChar('_SmartieInit@0'));

    dlls[uiDll].finiFunc := getprocaddress(dlls[uiDll].hDll, PChar('SmartieFini'));
    if (not Assigned(dlls[uiDll].finiFunc)) then
      dlls[uiDll].finiFunc := getprocaddress(dlls[uiDll].hDll, PChar('_SmartieFini@0'));

    // Call SmartieInit if it exists.
    if (Assigned(initFunc)) then
    begin
      try
        initFunc();
      except
        on E: Exception do
          raise Exception.Create('Plugin '+sDllName+' had an exception during Init: '
            + E.Message);
      end;
    end;

    if (bDotNet) then
    begin
      @bridgeInitFunc := getprocaddress(dlls[uiDll].hDll, PChar('_BridgeInit@12'));
      if (@bridgeInitFunc = nil) then
        raise Exception.Create('Could not init bridge');

      try
        sResult := bridgeInitFunc(PChar(dlls[uiDll].sName), id, minRefresh);
      except
        on E: Exception do
          raise Exception.Create('Bridge Init for '+dlls[uiDll].sName+' had an exception: '
            + E.Message);
      end;
      if (id = -1) or (sResult <> '') then
         raise Exception.Create('Bridge Init for '+dlls[uiDll].sName+' failed with: '
            + sResult);
      dlls[uiDll].iBridgeId := id;
      if (minRefresh > 0) then
        dlls[uiDll].uiMinRefreshInterval := minRefresh;

      @dlls[uiDll].BridgeFunc := getprocaddress(dlls[uiDll].hDll,
        PChar('_BridgeFunc@16'));
      if (@dlls[uiDll].BridgeFunc = nil) then
        raise Exception.Create('No Bridge function found.');
    end
    else
    begin
      for i:= 1 to iMaxPluginFuncs do
      begin
        @dlls[uiDll].functions[i] := getprocaddress(dlls[uiDll].hDll,
          PChar('function' + IntToStr(i)));
        if (@dlls[uiDll].functions[i] = nil) then
          @dlls[uiDll].functions[i] := getprocaddress(dlls[uiDll].hDll,
            PChar('_function' + IntToStr(i)+'@8'));
        if (@dlls[uiDll].functions[i] <> nil) then
          bFound := True;
      end;

      minRefreshFunc := getprocaddress(dlls[uiDll].hDll, PChar('GetMinRefreshInterval'));
      if (not Assigned(minRefreshFunc)) then
        minRefreshFunc := getprocaddress(dlls[uiDll].hDll, PChar('_GetMinRefreshInterval@0'));

      if (@minRefreshFunc <> nil) then
      begin
        try
          minRefresh := minRefreshFunc();
        except
          on E: Exception do
            raise Exception.Create('Plugin '+sDllName
              +' had an exception during GetMinRefreshInterval:' + E.Message);
        end;
        if (minRefresh > 0) then
          dlls[uiDll].uiMinRefreshInterval := minRefresh;
      end;

      if (not bFound) then
      begin
        if (dlls[uiDll].hDll <> 0) then FreeLibrary(dlls[uiDll].hDll);
        dlls[uiDll].hDll := 0;
        Dec(uiTotalDlls);
        LoadPlugin(dlls[uiDll].sName, true);
      end;
    end;
  end
  else
  begin
    raise Exception.Create('LoadLibrary failed with ' + ErrMsg(GetLastError));
  end;
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      W I N A M P                 P R O C E D U R E S                  ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////



procedure TData.ResolveWinampVariables(var Line: string);
var
  tempstr: String;
  barLength: Cardinal;
  barPosition: Integer;
  trackLength, trackPosition, t: Integer;
  i: Integer;
  m, h, s: Integer;
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
begin
  if pos('$Winamp', line) = 0 then exit;

  trackLength := LCDSmartieDisplayForm.winampctrl1.TrackLength;
  trackPosition := LCDSmartieDisplayForm.winampctrl1.TrackPosition;
  if (trackLength < 0) then trackLength := 0;
  if (trackPosition < 0) then trackPosition := 0;

  if pos('$WinampTitle', line) <> 0 then
  begin
    tempstr := LCDSmartieDisplayForm.winampctrl1.GetCurrSongTitle;
    i:=1;
    while (i<=length(tempstr)) and (tempstr[i]>='0')
      and (tempstr[i]<='9') do Inc(i);

    if (i<length(tempstr)) and (tempstr[i]='.') and (tempstr[i+1]=' ') then
      tempstr := copy(tempstr, i+2, length(tempstr));
    line := StringReplace(line, '$WinampTitle', Trim(tempstr), [rfReplaceAll]);
  end;
  if pos('$WinampChannels', line) <> 0 then
  begin
    if LCDSmartieDisplayForm.winampctrl1.GetSongInfo(2)>1 then tempstr := 'stereo'
    else tempstr := 'mono';
    line := StringReplace(line, '$WinampChannels', tempstr, [rfReplaceAll]);
  end;
  if pos('$WinampKBPS', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampKBPS',
      IntToStr(LCDSmartieDisplayForm.winampctrl1.GetSongInfo(1)), [rfReplaceAll]);
  end;
  if pos('$WinampFreq', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampFreq',
      IntToStr(LCDSmartieDisplayForm.winampctrl1.GetSongInfo(0)), [rfReplaceAll]);
  end;
  if pos('$WinampStat', line) <> 0 then
  begin
    case LCDSmartieDisplayForm.WinampCtrl1.GetState of
      0: line := StringReplace(line, '$WinampStat', 'stopped',
        [rfReplaceAll]);
      1: line := StringReplace(line, '$WinampStat', 'playing',
        [rfReplaceAll]);
      3: line := StringReplace(line, '$WinampStat', 'paused',
        [rfReplaceAll]);
      else line := StringReplace(line, '$WinampStat', '[unknown]',
          [rfReplaceAll]);
    end;
  end;

  while decodeArgs(line, '$WinampPosition', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    try
      RequiredParameters(numargs, 1, 1);
      barlength := strtoint(args[1]);

      if (trackLength > 0) then barPosition := round(((trackPosition /
        1000)*barLength) /trackLength)
      else barPosition := 0;

      tempstr := '';

      for i := 1 to barPosition-1 do tempstr := tempstr +  '-';
      tempstr := tempstr +  '+';
      for i := barPosition + 1 to barlength do tempstr := tempstr +  '-';
      tempstr := copy(tempstr, 1, barlength);

      line := prefix + tempstr + postfix;
    except
      on E: Exception do line := prefix + '[WinampPosition: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  if pos('$WinampPolo', line) <> 0 then
  begin
    t := trackPosition;
    if t / 1000 > trackLength then t := trackLength;
    h := t div ticksperhour;
    t := t - h * ticksperhour;
    m := t div ticksperminute;
    t := t - m * ticksperminute;
    s := t div ticksperseconde;
    tempstr := '';
    if h > 0 then
    begin
      tempstr := tempstr + IntToStr(h) +  'hrs ';
      tempstr := tempstr + formatfloat('00', m, localeFormat) +  'min ';
      tempstr := tempstr + formatfloat('00', s, localeFormat) +  'sec';
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  'min ';
        tempstr := tempstr + formatfloat('00', s, localeFormat) +  'sec';
      end
      else
      begin
        tempstr := tempstr + IntToStr(s) +  'sec';
      end;
    end;
    line := StringReplace(line, '$WinampPolo', tempstr, [rfReplaceAll]);
  end;

  if pos('$WinampRelo', line) <> 0 then
  begin
    t := trackLength*1000 - trackPosition;
    if t/1000> trackLength then t := trackLength;
    h := t div ticksperhour;
    t := t -h * ticksperhour;
    m := t div ticksperminute;
    t := t -m * ticksperminute;
    s := t div ticksperseconde;
    tempstr := '';
    if h > 0 then
    begin
      tempstr := tempstr + IntToStr(h) +  'hrs ';
      tempstr := tempstr + formatfloat('00', m, localeFormat) +  'min ';
      tempstr := tempstr + formatfloat('00', s, localeFormat) +  'sec';
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  'min ';
        tempstr := tempstr + formatfloat('00', s, localeFormat) +  'sec';
      end
      else
      begin
        tempstr := tempstr + IntToStr(s) +  'sec';
      end;
    end;
    line := StringReplace(line, '$WinampRelo', tempstr, [rfReplaceAll]);
  end;

  if pos('$WinampPosh', line) <> 0 then
  begin
    t := trackPosition;
    if t/1000> trackLength then t := trackLength;
    h := t div ticksperhour;
    t := t -h * ticksperhour;
    m := t div ticksperminute;
    t := t -m * ticksperminute;
    s := t div ticksperseconde;
    tempstr := '';
    if h > 0 then
    begin
      tempstr := tempstr + IntToStr(h) +  ':';
      tempstr := tempstr + formatfloat('00', m, localeFormat) +  ':';
      tempstr := tempstr + formatfloat('00', s, localeFormat);
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  ':';
        tempstr := tempstr + formatfloat('00', s, localeFormat);
      end
      else
      begin
        tempstr := tempstr + IntToStr(s);
      end;
    end;
    line := StringReplace(line, '$WinampPosh', tempstr, [rfReplaceAll]);
  end;

  if pos('$WinampResh', line) <> 0 then
  begin
    t := trackLength * 1000 - trackPosition;
    if t / 1000 > trackLength then t := trackLength;
    h := t div ticksperhour;
    t := t - h * ticksperhour;
    m := t div ticksperminute;
    t := t - m * ticksperminute;
    s := t div ticksperseconde;
    tempstr := '';
    if h > 0 then
    begin
      tempstr := tempstr + IntToStr(h) +  ':';
      tempstr := tempstr + formatfloat('00', m, localeFormat) +  ':';
      tempstr := tempstr + formatfloat('00', s, localeFormat);
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  ':';
        tempstr := tempstr + formatfloat('00', s, localeFormat);
      end
      else
      begin
        tempstr := tempstr + IntToStr(s);
      end;
    end;
    line := StringReplace(line, '$WinampResh', tempstr, [rfReplaceAll]);
  end;

  if pos('$Winamppos', line) <> 0 then
  begin
    t := round((trackPosition / 1000));
    if t > trackLength then t := trackLength;
    line := StringReplace(line, '$Winamppos', IntToStr(t), [rfReplaceAll]);
  end;
  if pos('$WinampRem', line) <> 0 then
  begin
    t := round(tracklength-(trackPosition / 1000));
    if t > trackLength then t := trackLength;
    line := StringReplace(line, '$WinampRem', IntToStr(t), [rfReplaceAll]);
  end;

  if pos('$WinampLengtl', line) <> 0 then
  begin
    t := trackLength * 1000;
    h := t div ticksperhour;
    t := t - h * ticksperhour;
    m := t div ticksperminute;
    t := t - m * ticksperminute;
    s := t div ticksperseconde;
    tempstr := '';
    if h > 0 then
    begin
      tempstr := tempstr + IntToStr(h) +  'hrs ';
      tempstr := tempstr + formatfloat('00', m, localeFormat) +  'min ';
      tempstr := tempstr + formatfloat('00', s, localeFormat) +  'sec';
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  'min ';
        tempstr := tempstr + formatfloat('00', s, localeFormat) +  'sec';
      end
      else
      begin
        tempstr := tempstr + IntToStr(s) +  'sec';
      end;
    end;
    line := StringReplace(line, '$WinampLengtl', tempstr, [rfReplaceAll]);
  end;

  if pos('$WinampLengts', line) <> 0 then
  begin
    t := trackLength*1000;
    h := t div ticksperhour;
    t := t - h * ticksperhour;
    m := t div ticksperminute;
    t := t - m * ticksperminute;
    s := t div ticksperseconde;
    tempstr := '';
    if h > 0 then
    begin
      tempstr := tempstr + IntToStr(h) + ':';
      tempstr := tempstr + formatfloat('00', m, localeFormat) + ':';
      tempstr := tempstr + formatfloat('00', s, localeFormat);
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) + ':';
        tempstr := tempstr + formatfloat('00', s, localeFormat);
      end
      else
      begin
        tempstr := tempstr + IntToStr(s);
      end;
    end;
    line := StringReplace(line, '$WinampLengts', tempstr, [rfReplaceAll]);
  end;

  if pos('$WinampLength', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampLength', IntToStr(trackLength),
      [rfReplaceAll]);
  end;

  if pos('$WinampTracknr', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampTracknr',
      IntToStr(LCDSmartieDisplayForm.winampctrl1.GetListPos + 1), [rfReplaceAll]);
  end;
  if pos('$WinampTotalTracks', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampTotalTracks',
      IntToStr(LCDSmartieDisplayForm.winampctrl1.GetListCount), [rfReplaceAll]);
  end;
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      D I S T R I B U T E D  .  N E T          P R O C E D U R E S     ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

procedure TData.ResolveDNetVariables(var Line : string);
begin
  if (pos('$Dnet', line) <> 0) then
  begin
    dataCs.Enter();
    try
      line := StringReplace(line, '$DnetDone', replline2, [rfReplaceAll]);
      line := StringReplace(line, '$DnetSpeed', replline1, [rfReplaceAll]);
    finally
      dataCs.Leave();
    end;
  end;
end;

procedure TData.UpdateDNetStats(Sender: TObject);
//DISTRIBUTED STATS!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  fFile: textfile;
  x,counter: Integer;
  bReplz: Boolean;
  line: String;
  ScreenCount, LineCount: Integer;
  screenline: String;
  replline: String;
  sTemp: String;
begin

  bReplz := false;

  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to config.height do
    begin
      screenline := config.screen[ScreenCount][LineCount].text;
      if (not bReplz) and (pos('$Dnet', screenline) <> 0) then bReplz := true;
    end;
  end;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if bReplz then
  begin
    x := 0;
    replline := 'File not found';
    if FileExists(config.distLog) = true then
    begin
      assignfile(fFile, config.distLog);
      reset (fFile);
      while not eof(fFile) do
      begin
        readln (fFile);
        x := x + 1;
      end;
      reset(fFile);
      for counter := 1 to x-50 do
      begin
        readln(fFile);
      end;
      while not eof(fFile) do
      begin
        readln(fFile, line);
        replline := replline + ' ' + line;
      end;
      closefile(fFile);
    end;
    replline := copy(replline, pos('Completed', replline)-5,
      length(replline));
    for x := 1 to 9 do
    begin
      if pos('Completed', replline) <> 0 then
      begin
        replline := copy(replline, pos('Completed', replline)-5,
          length(replline));
        replline := StringReplace(replline, 'Completed', '-', []);
      end;
    end;

    if copy(replline, 1, 3) = 'RC5' then
    begin
      sTemp := copy(replline, pos('- [', replline) + 3, pos(' keys',
        replline)-pos('- [', replline));
      if length(sTemp) > 7 then
      begin
        sTemp := copy(sTemp, 1, pos(',', copy(sTemp, 3,
          length(sTemp))) + 1);
      end;
      dataCs.Enter();
      replline1 := sTemp;
      dataCs.Leave();

      replline := copy(replline, pos('completion', replline) + 30, 200);
      sTemp := copy(replline, pos('(', replline) + 1, pos('.',
        replline)-pos('(', replline)-1);

      dataCs.Enter();
      replline2 := sTemp;
      dataCs.Leave();
    end;

    if copy(replline, 1, 3) = 'OGR' then
    begin
      sTemp := copy(replline, pos('- [', replline) + 3, pos(' nodes',
        replline)-pos('- [', replline));
      if length(sTemp) > 7 then
      begin
        sTemp := copy(sTemp, 1, pos(',', copy(sTemp, 3,
          length(sTemp))) + 1);
      end;

      dataCs.Enter();
      replline1 := sTemp;
      dataCs.Leave();

      replline := copy(replline, pos('remain', replline) + 8, 100);
      sTemp := copy(replline, pos('(', replline) + 1, pos('stats',
        replline)-pos('(', replline)-3);

      dataCs.Enter();
      replline2 := sTemp;
      dataCs.Leave();
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      H T T P         U P D A T E        P R O C E D U R E S           ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////



procedure TData.ResolveRSSVariables(var line: String);
var
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  RSSFeedIndex: Cardinal;
  found: Boolean;
  ItemIndex : Cardinal;
begin
  // $Rss(URL, TYPE [, NUM [, FREQ]])
  //   TYPE is t=title, d=desc, b=both
  //   NUM is 1 for item 1, etc. 0 means all (default). [when TYPR is b, then 0 is used]
  //   FREQ is the number of hours that must past before checking stream again.
  while decodeArgs(line, '$Rss', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    RequiredParameters(numargs, 2, 4);
    if (numargs < 3) then
    begin
      args[3] := '0';
    end;

    // locate entry
    RSSFeedIndex := 0;
    found := false;
    rssCs.Enter();
    try
      while (RSSFeedIndex < rssEntries) and (not found) do
      begin
        if (rss[RSSFeedIndex].url = args[1]) then found := true
        else Inc(RSSFeedIndex);
      end;

      try
        if (found) and (rss[RSSFeedIndex].items > 0)
          and (Cardinal(StrToInt(args[3])) <= rss[RSSFeedIndex].items) then
        begin

          ItemIndex := StrToInt(args[3]);
          case (args[2][1]) of
            't' : line := prefix + rss[RSSFeedIndex].title[ItemIndex] + postfix;  // title
            'd' : line := prefix + rss[RSSFeedIndex].desc[ItemIndex] + postfix; // description
            'b' : begin
              if (ItemIndex > 0) then  // both
                line := prefix + rss[RSSFeedIndex].title[ItemIndex] + ':' +
                        rss[RSSFeedIndex].desc[ItemIndex] + postfix
              else
                line := prefix + rss[RSSFeedIndex].whole + postfix;
            end;
            else line := prefix + '[Error: Rss: bad arg #2]' + postfix;
          end; // case

        end
        else
        begin
          if (found) then
          begin

            // We know about the Rss entry but have no data...
            if (copy(rss[RSSFeedIndex].whole, 1, 6) = '[Rss: ') then
            begin
              // Assume an error message is in whole
              line := prefix + rss[RSSFeedIndex].whole + postfix;
            end
            else
            begin
              line := prefix + '[Rss: No Data]' + postfix;
            end;

          end
          else
          begin

            // Nothing known yet - waiting for data thread...
            line := prefix + '[Rss: Waiting for data]' + postfix;

          end;
        end;
      except
        on E: Exception do line := prefix + '[Rss: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    finally
      rssCs.Leave();
    end;
  end;

end;

// Download URL and return file location.
// Just return cached file if newer than maxfreq minutes.
function TData.getUrl(Url: String; maxfreq: Cardinal = 0): String;
var
  HTTP: TIdHTTP;
  sl: TStringList;
  Filename: String;
  lasttime: TDateTime;
  toonew: Boolean;
  sRest: String;
  iRest: Integer;
  i: Integer;

begin
  // Generate a filename for the cached Rss stream.
  Filename := copy(LowerCase(Url),1,30);
  sRest := copy(LowerCase(Url),30,length(Url)-30);

  Filename := StringReplace(Filename, 'http://', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '\', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, ':', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '/', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '"', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '|', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '<', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '>', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '&', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '?', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '=', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '.', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '%', '_', [rfReplaceAll]);
  iRest := 0;
  for i := 1 to length(sRest) do
  begin
     iRest := iRest + (Ord(sRest[i]) xor i);
  end;
  Filename := Filename + IntToHex(iRest, 0);
  Filename :=  extractfilepath(application.exename) + 'cache\\' + Filename + '.cache';

  try
    toonew := false;
    sl := TStringList.create;
    HTTP := TIdHTTP.Create(nil);

    try
      // Only fetch new data if it's newer than the cache files' date.
      // and if it's older than maxfreq hours.
      if FileExists(Filename) then
      begin
        lasttime := FileDateToDateTime(FileAge(Filename));
        if (MinutesBetween(Now, lasttime) < maxfreq) then toonew := true;
        HTTP.Request.LastModified := lasttime;
      end;

      if (not toonew) then
      begin
        HTTP.HandleRedirects := True;
        if (config.httpProxy <> '') and (config.httpProxyPort <> 0) then
        begin
          HTTP.ProxyParams.ProxyServer := config.httpProxy;
          HTTP.ProxyParams.ProxyPort := config.httpProxyPort;
        end;
        HTTP.ReadTimeout := 30000;  // 30 seconds

        if (fdataThread.Terminated) then raise EExiting.Create('');

        httpCs.Enter();
        httpCopy := @HTTP;
        httpCs.Leave();
        sl.Text := HTTP.Get(Url);
        // the get call can block for a long time so check if smartie is exiting
        if (fdataThread.Terminated) then raise EExiting.Create('');

        sl.savetofile(Filename);
      end;
    finally
      httpCs.Enter();
      httpCopy := nil;
      httpCs.Leave();

      sl.Free;
      HTTP.Free;
    end;
  except
    on E: EIdHTTPProtocolException do
    begin
      if (fdataThread.Terminated) then raise EExiting.Create('');
      if (E.ReplyErrorCode <> 304) then   // 304=Not Modified.
        raise;
    end;

    else
    begin
      if (fdataThread.Terminated) then raise EExiting.Create('');
      raise;
    end;
  end;

  // Even if we fail to download - give the filename so they can use the old data.
  Result := filename;
end;

function TData.getRss(Url: String; var titles, descs: Array of String;
  maxitems: Cardinal; maxfreq: Cardinal = 0): Cardinal;
var
  StartItemNode : IXMLNode;
  ANode : IXMLNode;
  XMLDoc : IXMLDocument;
  items: Cardinal;
  rssFilename: String;
  x: Integer;

begin
  items := 0;

  //
  // Fetch the Rss data
  //

  // Use newRefresh as a maxfreq if none given - this is mostly in case
  // the application is stopped and started quickly.
  if (maxfreq = 0) then maxfreq := config.newsRefresh;
  RssFileName := getUrl(Url, maxfreq);
  if (fdataThread.Terminated) then raise EExiting.Create('');

  // Parse the Xml data
  if FileExists(RssFilename) then
  begin
    XMLDoc := LoadXMLDocument(RssFilename);
    //XMLDoc.Options  := [doNodeAutoCreate,  doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl];
    //XMLDoc.FileName := 'bbc.xml';
    //XMLDoc.Active := True;

    // This only works with some RSS feeds
    StartItemNode :=
      XMLDoc.DocumentElement.ChildNodes.First.ChildNodes.FindNode('item');
    if (StartItemNode = nil) then
    begin
      // Would like to use FindNode at top level but it wasn't working so
      // we'll do it long hand.
      with XMLDoc.DocumentElement.ChildNodes do
      begin
        x := 0;
        while (x < Count) and (Get(x).NodeName <> 'item') do Inc(x);
        if (x < Count) then StartItemNode := Get(x);
      end;
    end;
    if (StartItemNode = nil) then raise
      Exception.Create('unable to parse Rss');

    ANode := StartItemNode;

    repeat
      Inc(items);
      if (ANode.ChildNodes['title'] <> nil) then titles[items] :=
        stripHtml(ANode.ChildNodes['title'].Text)
      else titles[items] := 'Unknown';

      if (ANode.ChildNodes['title'] <> nil) then descs[items] :=
        stripHtml(ANode.ChildNodes['description'].Text)
      else descs[items] := 'Unknown';

      ANode := ANode.NextSibling;
    until (ANode = nil) or (items >= maxItems);
  end;

  Result := items;
end;

procedure TData.DoRSSHTTPUpdate;
var
  counter, counter2: Integer;
  sAllTitles, sAllDescs, sWhole: String;
  items: Cardinal;
  titles: Array[0..maxRssItems] of String;
  descs: Array[0..maxRssItems] of String;
begin
  for counter := 0 to rssEntries-1 do
  begin
    if (rss[counter].url <> '') then
    begin
      if (fdataThread.Terminated) then raise EExiting.Create('');

      try
        items := getRss(rss[counter].url, titles,
          descs, maxRssItems, rss[counter].maxfreq);

        rssCs.Enter();
        try
          rss[counter].items := items;

          sAllTitles := '';
          sAllDescs := '';
          sWhole := '';
          for counter2 := 1 to items do
          begin
            rss[counter].title[counter2] := titles[counter2];
            rss[counter].desc[counter2] := descs[counter2];

            sAllTitles := sAllTitles + titles[counter2] + ' | ';
            sAllDescs := sAllDescs + descs[counter2] + ' | ';
            sWhole := sWhole + titles[counter2] + ':' +
              descs[counter2] + ' | ';

            if (fdataThread.Terminated) then raise EExiting.Create('');
          end;
          rss[counter].whole := sWhole;
          rss[counter].title[0] := sAllTitles;
          rss[counter].desc[0] := sAllDescs;
        finally
          rssCs.Leave();
        end;
      except
        on EExiting do raise;
        on E: Exception do
        begin
          rssCs.Enter();
          try
            rss[counter].items := 0;
            rss[counter].title[0] := '[Rss: ' + E.Message + ']';
            rss[counter].desc[0] := '[Rss: ' + E.Message + ']';
            rss[counter].whole := '[Rss: ' + E.Message + ']';
          finally
            rssCs.Leave();
          end;
        end;
      end;
    end;
  end;
end;

procedure TData.DoLCDSmartieHTTPUpdate;
var
  iPos1, iPosPoint1, iPosPoint2, iPosPoint3: Integer;
  iVersMaj, iVersMin, iVersRel, iVersBuild: Integer;
  bUpgrade: Boolean;
  versionline : string;
  sFilename: String;
begin
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
    isconnected := true;

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
          if (lcdSmartieUpdateText <> MidStr(versionline, iPos1+1, 62)) then
          begin
            lcdSmartieUpdateText := MidStr(versionline, iPos1+1, 62);
            lcdSmartieUpdate := True;
          end;
        end;
      end;
    end;
  end;
end;

procedure TData.ResolveSETIVariables(var Line : string);
begin
  if (pos('$SETI', line) <> 0) then
  begin
    dataCs.Enter();
    try
      line := StringReplace(line, '$SETIResults', setiNumResults, [rfReplaceAll]);
      line := StringReplace(line, '$SETICPUTime', setiCpuTime, [rfReplaceAll]);
      line := StringReplace(line, '$SETIAverage', setiAvgCpu, [rfReplaceAll]);
      line := StringReplace(line, '$SETILastresult', setiLastResult, [rfReplaceAll]);
      line := StringReplace(line, '$SETIusertime', setiUserTime, [rfReplaceAll]);
      line := StringReplace(line, '$SETItotalusers', setiTotalUsers, [rfReplaceAll]);
      line := StringReplace(line, '$SETIrank', setiRank, [rfReplaceAll]);
      line := StringReplace(line, '$SETIsharingrank', setiShareRank, [rfReplaceAll]);
      line := StringReplace(line, '$SETImoreWU', setiMoreWU, [rfReplaceAll]);
    finally
      dataCs.Leave();
    end;
  end;
end;

procedure TData.DoSETIHTTPUpdate;
var
  StartItemNode : IXMLNode;
  ANode : IXMLNode;
  XMLDoc : IXMLDocument;
  Filename: String;

begin

  // Fetch the Rss data  (but not more oftern than 24 hours)
  try
    FileName := getUrl(
      'http://setiathome2.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=user_xml&email='
      + config.setiEmail, 12*60);
    if (fdataThread.Terminated) then raise EExiting.Create('');

    // Parse the Xml data
    if FileExists(Filename) then
    begin
      XMLDoc := LoadXMLDocument(Filename);

      StartItemNode := XMLDoc.DocumentElement.ChildNodes.FindNode('userinfo');
      ANode := StartItemNode;

      dataCs.Enter();
      try
        setiNumResults := ANode.ChildNodes['numresults'].Text;
        setiCpuTime := ANode.ChildNodes['cputime'].Text;
        setiAvgCpu := ANode.ChildNodes['avecpu'].Text;
        setiLastResult := ANode.ChildNodes['lastresulttime'].Text;
        setiUserTime := ANode.ChildNodes['usertime'].Text;
      finally
        dataCs.Leave();
      end;
      // not used: 'regdate'

      // not used: group info.

      StartItemNode := XMLDoc.DocumentElement.ChildNodes.FindNode('rankinfo');
      ANode := StartItemNode;

      dataCs.Enter();
      try
        setiTotalUsers := ANode.ChildNodes['ranktotalusers'].Text;
        setiRank := ANode.ChildNodes['rank'].Text;
        setiShareRank := ANode.ChildNodes['num_samerank'].Text;
        // SETI provides floats not dependent on user's locale, but always in US format
        setiMoreWU := FloatToStr(
          100-StrToFloat(ANode.ChildNodes['top_rankpct'].Text, usFormat),
          localeFormat);
      finally
        dataCs.Leave();
      end;
    end;
  except
    on EExiting do raise;
    on E: Exception do
    begin
      dataCs.Enter();
      try
        setiNumResults := '[Seti: ' + E.Message + ']';
        setiCpuTime := '[Seti: ' + E.Message + ']';
        setiAvgCpu := '[Seti: ' + E.Message + ']';
        setiLastResult := '[Seti: ' + E.Message + ']';
        setiUserTime := '[Seti: ' + E.Message + ']';
        setiTotalUsers := '[Seti: ' + E.Message + ']';
        setiRank := '[Seti: ' + E.Message + ']';
        setiShareRank := '[Seti: ' + E.Message + ']';
        setiMoreWU := '[Seti: ' + E.Message + ']';
      finally
        dataCs.Leave();
      end;
    end;
  end;
end;

procedure TData.ResolveFoldingVariables(var Line : string);
begin
  if (pos('$FOLD', line) <> 0) then
  begin
    dataCs.Enter();
    try
      line := StringReplace(line, '$FOLDmemsince', foldMemSince, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDlastwu', foldLastWU, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDactproc', foldActProcsWeek, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDteam', foldTeam, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDscore', foldScore, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDrank', foldRank, [rfReplaceAll]);
      line := StringReplace(line, '$FOLDwu', foldWU, [rfReplaceAll]);
    finally
      dataCs.Leave();
    end;
  end;
end;

procedure TData.DoFoldingHTTPUpdate;
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

    dataCs.Enter();
    foldMemSince := '[FOLDmemsince: not supported]';
    dataCs.Leave();

    tempstr2 := copy(tempstr, pos('Date of last work unit', tempstr) + 22,
      500);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    dataCs.Enter();
    foldLastWU := tempstr2;
    dataCs.Leave();

    tempstr2 := copy(tempstr, pos('Total score', tempstr) + 11, 100);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    dataCs.Enter();
    foldScore := tempstr2;
    dataCs.Leave();

    tempstr2 := copy(tempstr, pos('Overall rank (if points are combined)',
      tempstr) + 37, 100);
    tempstr2 := copy(tempstr2, 1, pos('of', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    dataCs.Enter();
    foldRank := tempstr2;
    dataCs.Leave();

    tempstr2 := copy(tempstr, pos('Active processors (within 7 days)',
      tempstr) + 33, 100);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    dataCs.Enter();
    foldActProcsWeek := tempstr2;
    dataCs.Leave();

    tempstr2 := copy(tempstr, pos('Team', tempstr) + 4, 500);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    dataCs.Enter();
    foldTeam := tempstr2;
    dataCs.Leave();

    tempstr2 := copy(tempstr, pos('WU', tempstr) + 2, 500);
    tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
    if (pos('(', tempstr2) <> 0) then tempstr2 := copy(tempstr2, 1, pos('(',
      tempstr2)-1);
    tempstr2 := stripspaces(stripHtml(tempstr2));
    dataCs.Enter();
    foldWU := tempstr2;
    dataCs.Leave();

  except
    on EExiting do raise;
    on E: Exception do
    begin
      dataCs.Enter();
      try
        foldMemSince := '[fold: ' + E.Message + ']';
        foldLastWU := '[fold: ' + E.Message + ']';
        foldActProcsWeek := '[fold: ' + E.Message + ']';
        foldTeam := '[fold: ' + E.Message + ']';
        foldScore := '[fold: ' + E.Message + ']';
        foldRank := '[fold: ' + E.Message + ']';
        foldWU := '[fold: ' + E.Message + ']';
      finally
        dataCs.Leave();
      end;
    end;
  end;
end;

// Runs in data thread
procedure TData.FetchHTTPUpdates;
begin
  if DoNewsUpdate[huRSS] then
  begin
    DoNewsUpdate[huRSS] := False;
    DoRSSHTTPUpdate();
  end;

  if (DoNewsUpdate[huLCDSmartie]) then
  begin
    DoNewsUpdate[huLCDSmartie] := False;
    if (fdataThread.Terminated) then raise EExiting.Create('');
    DoLCDSmartieHTTPUpdate();
  end;

  if DoNewsUpdate[huSETI] then
  begin
    DoNewsUpdate[huSETI] := False;
    if (fdataThread.Terminated) then raise EExiting.Create('');
    DoSETIHTTPUpdate();
  end;

  if DoNewsUpdate[huFolding] then
  begin
    DoNewsUpdate[huFolding] := False;
    if (fdataThread.Terminated) then raise EExiting.Create('');
    DoFoldingHTTPUpdate();
  end;
end;

// Runs in data thread
procedure TData.HTTPUpdate;
const
  maxArgs = 10;
var
  UpdateTypeLoop : tHTTPUpdateType;
  screenline: String;
  RSSLoop,ScreenCount,LineCount : integer;
  args: Array [1..maxArgs] of String;
  prefix: String;
  postfix: String;
  numargs: Cardinal;
  myRssCount: Integer;
  updateNeeded: Boolean;
  iFound: Integer;
  iMaxFreq: Integer;
begin
  doHTTPUpdate := False;

  // TODO: this should only be done when the config changes...
  myRssCount := 0;
  DoNewsUpdate[huLCDSmartie] := config.checkUpdates;

  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to config.height do
    begin
        screenline := config.screen[ScreenCount][LineCount].text;
        while decodeArgs(screenline, '$Rss', maxArgs, args, prefix, postfix,
          numargs) do
        begin
          // check if we have already seen this url:
          iFound := -1;
          for RSSLoop := 0 to myRssCount-1 do
            if (rss[RSSLoop].url = args[1]) then iFound := RSSLoop;

          iMaxFreq := 0;
          if (numargs >= 4) then
          begin
            try
              iMaxFreq := StrToInt(args[4]) * 60;
            except
            end;
          end;

          if (iFound = -1) then
          begin
            rssCs.Enter();

            try
              // not found - add details:
              if (myRssCount + 1 >= Length(rss)) then
                SetLength(rss, myRssCount + 10);

              if (rss[myRssCount].url <> args[1]) then
              begin
                rss[myRssCount].url := args[1];
                rss[myRssCount].whole := '';
                rss[myRssCount].items := 0;
              end;

              rss[myRssCount].maxfreq := 0;
              if (numargs >= 4) then
              begin
                  rss[myRssCount].maxfreq := iMaxFreq
              end;
            finally
              rssCs.Leave();
            end;

            Inc(myRssCount);
          end
          else
          begin
            // seen this one before - raise the maxfreq if this one is higher.
            if (numargs >= 4)
              and (rss[iFound].maxfreq < Cardinal(iMaxFreq)) then
            begin
              try
                rssCs.Enter();
                try
                  rss[iFound].maxfreq := iMaxFreq;
                finally
                  rssCs.Leave();
                end;
              except
              end;
            end;
          end;

          // remove this Rss, and continue to parse the rest
          screenline := prefix + postfix;
        end;
        if (pos('$SETI', screenline) <> 0) then DoNewsUpdate[huSETI] := true;
        if (pos('$FOLD', screenline) <> 0) then DoNewsUpdate[huFolding] := true;
    end;
  end;

  rssCs.Enter();
  try
    rssEntries := myRssCount;
  finally
    rssCs.Leave();
  end;
  if (myRssCount > 0) then DoNewsUpdate[huRSS] := true;

  updateNeeded := False;
  for UpdateTypeLoop := FirstHTTPUpdate to LastHTTPUpdate do
  begin
    if (donewsupdate[UpdateTypeLoop]) then updateNeeded := true;
  end;
  if (updateNeeded) then FetchHTTPUpdates;
end;

procedure TData.UpdateHTTP;
begin
  doHTTPUpdate := True;
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      E - M A I L    C H E C K I N G    P R O  C E D U R E S           ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

function TData.GetGotEmail : boolean;
begin
  Result := false;
  if assigned(EmailThread) then
    Result := EmailThread.GotEmail;
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      M O T H E R B O A R D     S T A T S      P R O C E D U R E S     ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


function TData.GetMBMActive : boolean;
begin
  Result := false;
  if assigned(MBMThread) then
    Result := MBMThread.MBMActive;
end;

end.
