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
 *  $Revision: 1.52 $ $Date: 2005/01/28 21:39:01 $
 *****************************************************************************}


interface

uses Classes, System2, xmldom, XMLIntf, SysUtils, xercesxmldom, XMLDoc,
  msxmldom, ComCtrls, ComObj, UUtils, IdHTTP, SyncObjs, IdPOP3;

const
  ticksperseconde = 1000;
  ticksperminute = ticksperseconde * 60;
  ticksperhour = ticksperminute * 60;
  ticksperdag = ticksperhour * 24;
  ticksperweek = ticksperdag * 7;
  tickspermonth: Int64 = Int64(ticksperdag) * 30;
  ticksperyear: Int64 = Int64(ticksperdag) * 30 * 12;
  maxRssItems = 20;
  MAXNETSTATS = 10;
  maxArgs = 10;
  iMaxPluginFuncs = 20;

type
  EExiting = Class(Exception);

  TBusType = (btISA, btSMBus, btVIA686ABus, btDirectIO);
  TSMBType = (smtSMBIntel, smtSMBAMD, smtSMBALi, smtSMBNForce, smtSMBSIS);
  TSensorType = (stUnknown, stTemperature, stVoltage, stFan, stMhz,
    stPercentage);

  TSharedIndex = Record
    iType : TSensorType;                          // type of sensor
    Count : Integer;                              // number of sensor for that type
  end;


  TSharedSensor = Record
    ssType : TSensorType;                         // type of sensor
    ssName : Array [0..11] of AnsiChar;           // name of sensor
    sspadding1: Array [0..2] of Char;             // padding of 3 byte
    ssCurrent : Double;                           // current value
    ssLow : Double;                               // lowest readout
    ssHigh : Double;                              // highest readout
    ssCount : LongInt;                            // total number of readout
    sspadding2: Array [0..3] of Char;             // padding of 4 byte
    ssTotal : Extended;                           // total amout of all readouts
    sspadding3: Array [0..5] of Char;             // padding of 6 byte
    ssAlarm1 : Double;                            // temp & fan: high alarm; voltage: % off;
    ssAlarm2 : Double;                            // temp: low alarm
  end;

  TSharedInfo = Record
    siSMB_Base : Word;                            // SMBus base address
    siSMB_Type : TBusType;                        // SMBus/Isa bus used to access chip
    siSMB_Code : TSMBType;                        // SMBus sub type, Intel, AMD or ALi
    siSMB_Addr : Byte;                            // Address of sensor chip on SMBus
    siSMB_Name : Array [0..40] of AnsiChar;       // Nice name for SMBus
    siISA_Base : Word;                            // ISA base address of sensor chip on ISA
    siChipType : Integer;                         // Chip nr, connects with Chipinfo.ini
    siVoltageSubType : Byte;                      // Subvoltage option selected
  end;

  TSharedData = Record
    sdVersion : Double;                           // version number (example: 51090)
    sdIndex : Array [0..9] of TSharedIndex;       // Sensor index
    sdSensor : Array [0..99] of TSharedSensor;    // sensor info
    sdInfo : TSharedInfo;                         // misc. info
    sdStart : Array [0..40] of AnsiChar;          // start time
    sdCurrent : Array [0..40] of AnsiChar;        // current time
    sdPath : Array [0..255] of AnsiChar;          // MBM path
  end;

  PSharedData = ^TSharedData;

  TEmail = Record
    messages: Integer;
    lastSubject: String;
    lastFrom: String;
  end;

  TRss = Record
    url: String;
    title: Array [0..maxRssItems] of String; // 0 is all titles
    desc: Array [0..maxRssItems] of String;   // 0 is all descs
    items: Cardinal;
    whole: String;                            // all titles and descs
    maxfreq: Cardinal;                        // hours - 0 means no restriction
  end;

  PHttp = ^TIdHttp;
  PPop3 = ^TIdPop3;

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
  public
    lcdSmartieUpdate: Boolean;    // data+main threads
    lcdSmartieUpdateText: String; // data+main threads
    mbmactive: Boolean;
    isconnected: Boolean;         // data+main threads
    gotEmail: Boolean;            // data+main threads
    cLastKeyPressed: Char;
    procedure ScreenStart;
    procedure ScreenEnd;
    procedure NewScreen(bYes: Boolean);
    function change(line: String; qstattemp: Integer = 1;
      bCacheResults: Boolean = false): String;
    function CallPlugin(uiDll: Integer; iFunc: Integer;
                    const sParam1: String; const sParam2:String) : String;
    function FindPlugin(const sDllName: String): Cardinal;
    procedure updateMBMStats(Sender: TObject);
    procedure UpdateHTTP;
    procedure UpdateGameStats;
    procedure UpdateEmail;
    constructor Create;
    destructor Destroy; override;
    function CanExit: Boolean;
  private
    localeFormat : TFormatSettings;
    cacheresult_lastFindPlugin: Cardinal;
    cache_lastFindPlugin: String;
    uiScreenStartTime: Cardinal; // time that new start refresh started (used by plugin cache code)
    bNewScreenEvent: Boolean;
    bForceRefresh: Boolean;
    dlls: Array of TDll;
    uiTotalDlls: Cardinal;
    sDllResults: array of string;
    iDllResults: Integer;
    doHTTPUpdate, doGameUpdate, doEmailUpdate: Boolean;
    STUsername, STComputername, STCPUType: String;
    STPageFree, STPageTotal: Int64;
    STMemFree, STMemTotal: Int64;          // cpu + main thread.
    STHDFree, STHDTotal: Array[65..90] of Int64; // cpu + main thread.
    CPUUsage: Array [1..5] of Cardinal;   //cpu thread only
    CPUUsageCount: Cardinal;              //cpu thread only
    CPUUsagePos: Cardinal;                //cpu thread only
    STCPUUsage: Cardinal;                 //cpu + main thread
    lastSpdUpdate: LongWord;              //cpu thread only
    STCPUSpeed: String;                   // Guarded by dataCs, cpu + main thread
    iUptime: Int64;                       //cpu thread only
    iLastUptime: Cardinal;                //cpu thread only
    dataCs: TCriticalSection;  // data + main thread
    uptimereg, uptimeregs: String;        // Guarded by dataCs, cpu + main thread
    dataThread, cpuThread: TMyThread;
    screenResolution: String;
    netadaptername: Array[0..MAXNETSTATS-1] of String;  // Guarded by dataCs, cpu + main thread
    iNetTotalDown, iNetTotalUp: Array[0..9] of Int64;  // cpu + main thread
    iNetTotalDownOld, iPrevSysNetTotalDown: Array[0..9] of Int64; // cpu thread
    iNetTotalUpOld, iPrevSysNetTotalUp: Array[0..9] of Int64;     // cpu thread
    uiNetUnicastDown, uiNetUnicastUp, uiNetNonUnicastDown,
      uiNetNonUnicastUp,  uiNetDiscardsDown, uiNetDiscardsUp,
      uiNetErrorsDown, uiNetErrorsUp: Array[0..9] of Cardinal; // cpu + main thread
    dNetSpeedDownK, dNetSpeedUpK,
      dNetSpeedDownM, dNetSpeedUpM: Array[0..9] of double;    // cpu + main thread
    ipaddress: String;                     //Guarded by dataCs, cpu + main thread
    // Begin MBM Stats - main thread only
    Temperature: Array [1..11] of double;
    Voltage: Array [1..11] of double;
    Fan: Array [1..11] of double;
    CPU: Array [1..5] of double;
    TempName: Array[1..11] of String;
    VoltName: Array[1..11] of String;
    FanName: Array[1..11] of String;
    dMbmCpuUsage: double;
    // End MBM Stats
    replline2, replline1: String;
    qstatreg1: Array[1..20, 1..4] of String;  //Guarded by dataCs,  data+main thread
    qstatreg2: Array[1..20, 1..4] of String;  //Guarded by dataCs,  data+main thread
    qstatreg3: Array[1..20, 1..4] of String;  //Guarded by dataCs,  data+main thread
    qstatreg4: Array[1..20, 1..4] of String;  //Guarded by dataCs,  data+main thread
    System1: Tsystem;
    DoNewsUpdate: Array [1..9] of Boolean;  // data thread only
    newsAttempts: Array [1..9] of Byte;
    mailCs: TCriticalSection;  // Protects mail, data + main thread
    mail: Array [0..9] of TEmail; // Guarded by mailCs, data+main thread
    setiNumResults, setiCpuTime, setiAvgCpu, setiLastResult, setiUserTime,
      setiTotalUsers, setiRank, setiShareRank, setiMoreWU: String; //Guarded by dataCs, data+main threads
    foldMemSince, foldLastWU, foldActProcsWeek, foldTeam, foldScore,
      foldRank, foldWU: String;                              //Guarded by dataCs, data+main threads
    rssCs: TCriticalSection;  // protecting rss & rssCs
    rss: Array of TRss;    // Guarded by rssCs, data + main thread
    rssEntries: Cardinal;  // Guarded by rssCs, data + main thread
    httpCs: TCriticalSection;  // data + main thread
    httpCopy: PHttp;   // so we can cancel the request. Guarded by httpCs
    pop3Copy: PPop3;   // so we can cancel the request. Guarded by httpCs
    bDoCpuUsage: Boolean; // cpu + main threads.
    bDoCpuSpeed: Boolean; // cpu + main threads.
    bDoScreenRes: Boolean;
    bDoDisks: Boolean; // cpu + main threads;
    bDoDisk: Array[65..90] of Boolean; // cpu + main threads
    bDoNet: Boolean; // cpu + main threads;
    procedure diskUpdate;
    procedure updateNetworkStats;
    procedure emailUpdate;
    procedure fetchHTTPUpdates;
    procedure httpUpdate;
    procedure gameUpdate;
    procedure cpuUpdate;
    procedure doDataThread;
    procedure doCpuThread;
    function ReadMBM5Data : Boolean;
    function getRss(Url: String;var titles, descs: Array of String; maxitems:
      Cardinal; maxfreq: Cardinal = 0): Cardinal;
    function changeWinamp(line: String): String;
    function changeNet(line: String): String;
    procedure doSeti;
    function getUrl(Url: String; maxfreq: Cardinal = 0): String;
    function FileToString(sFilename: String): String;
    function CleanString(str: String): String;
    procedure RequiredParameters(uiArgs: Cardinal; uiMinArgs: Cardinal; uiMaxArgs: Cardinal = 0);
    procedure ProcessPlugin(var line: String; qstattemp: Integer;
      bCacheResults: Boolean);
    procedure LoadPlugin(sDllName: String; bDotNet: Boolean = false);
    function stripspaces(FString: String): String;
  end;



implementation

uses cxCpu40, adCpuUsage, UMain, Windows, Forms, IpHlpApi,
  IpIfConst, IpRtrMib, WinSock, Dialogs, Buttons, Graphics, ShellAPI,
  mmsystem, ExtActns, Messages, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdMessage, Menus,
  ExtCtrls, Controls, StdCtrls, StrUtils, ActiveX, IdUri, DateUtils, IdGlobal;

procedure TData.NewScreen(bYes: Boolean);
begin
  bNewScreenEvent := bYes;
  if (bYes) then
  begin
    form1.timer6.Interval := 0;
    form1.timer6.Interval := 250; // force an update of Mbm, etc data in 0.25 seconds
    bForceRefresh := true;
    bDoCpuUsage := false;
    bDoCpuSpeed := false;
    CPUUsagePos := 1;
    CPUUsageCount := 0;
    bDoScreenRes := false;
    bDoDisks := false;
    bDoNet := false;
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

procedure TData.RequiredParameters(uiArgs: Cardinal; uiMinArgs: Cardinal; uiMaxArgs: Cardinal = 0);
begin
  if (uiArgs < uiMinArgs) then
    raise Exception.Create('Too few parameters');
  if (uiArgs > uiMaxArgs) then
    raise Exception.Create('Too many parameters');
end;

// Remove $'s from the string - this is used when an exception
// message is inserted into the parsed string. This avoids
// any chance of infinite recursion.
function TData.CleanString(str: String): String;
begin
  Result := StringReplace(str, '$', '', [rfReplaceAll]);
end;


function stripHtml(str: String): String;
var
  posTag, posTagEnd: Cardinal;
begin

  repeat
    posTag := pos('<', str);
    if (posTag <> 0) then
    begin
      posTagEnd := posEx('>', str, posTag + 1);
      if (posTagEnd <> 0) then Delete(str, posTag, posTagEnd-posTag + 1);
    end;
  until (posTag = 0);

  result := str;
end;

constructor TData.Create;
var
  status: Integer;
  WSAData: TWSADATA;
begin
  inherited;

  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, localeFormat);

  status := WSAStartup(MAKEWORD(2,0), WSAData);
  if status <> 0 then
     raise Exception.Create('WSAStartup failed');

  CPUUsagePos := 1;
  isconnected := false;
  uiTotalDlls := 0;
  lcdSmartieUpdate := False;

  // Get CPU speed first time:
  try
    STCPUSpeed := IntToStr(cxCpu[0].Speed.RawSpeed.AsNumber);
  except
    // BUGBUG: This has been reported as failing when with Range check error,
    // they reported that it only occured when they ran a slow 16 bit app
  end;

  doEmailUpdate := True;
  doHTTPUpdate := True;
  doGameUpdate := True;

  httpCs := TCriticalSection.Create();
  rssCs := TCriticalSection.Create();
  mailCs := TCriticalSection.Create();
  dataCs := TCriticalSection.Create();

  // Start data collection thread
  dataThread := TMyThread.Create(self.doDataThread);
  dataThread.Resume;

  cpuThread := TMyThread.Create(self.doCpuThread);
  cpuThread.Resume;
end;

function TData.CanExit: Boolean;
var
  uiDll: Cardinal;
begin

  if (Assigned(dataThread)) then
    dataThread.Terminate;

  if (Assigned(cpuThread)) then
  begin
    cpuThread.Terminate;
    cpuThread.WaitFor();
    cpuThread.Free();
  end;

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
        if (pop3Copy <> nil) then
          pop3Copy^.DisconnectSocket();
      except
      end;
    finally
      httpCs.Leave();
    end;
  end;


  Result := True;
  { code not needed - yet as the above method of cancelling seems to work
  if (Assigned(dataThread)) then
  begin
    Wait for 30 seconds and then just give up.
    if (dataThread.Exited.WaitFor(30000) <> wrSignaled) then
      Result := False;
  end; }
end;

destructor TData.Destroy;
begin

  if (Assigned(dataThread)) then
  begin
    dataThread.WaitFor();
    dataThread.Free();

    if Assigned(httpCs) then httpCs.Free;
    if Assigned(rssCs) then rssCs.Free;
    if Assigned(mailCs) then mailCs.Free;
    if Assigned(dataCs) then dataCs.Free;
  end;

  WSACleanup();

  inherited;
end;


function TData.changeWinamp(line: String): String;
const
  maxArgs = 10;
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
  trackLength := form1.winampctrl1.TrackLength;
  trackPosition := form1.winampctrl1.TrackPosition;
  if (trackLength < 0) then trackLength := 0;
  if (trackPosition < 0) then trackPosition := 0;

  if pos('$WinampTitle', line) <> 0 then
  begin
    tempstr := form1.winampctrl1.GetCurrSongTitle;
    i:=1;
    while (i<=length(tempstr)) and (tempstr[i]>='0')
      and (tempstr[i]<='9') do Inc(i);

    if (i<length(tempstr)) and (tempstr[i]='.') and (tempstr[i+1]=' ') then
      tempstr := copy(tempstr, i+2, length(tempstr));
    line := StringReplace(line, '$WinampTitle', Trim(tempstr), [rfReplaceAll]);
  end;
  if pos('$WinampChannels', line) <> 0 then
  begin
    if form1.winampctrl1.GetSongInfo(2)>1 then tempstr := 'stereo'
    else tempstr := 'mono';
    line := StringReplace(line, '$WinampChannels', tempstr, [rfReplaceAll]);
  end;
  if pos('$WinampKBPS', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampKBPS',
      IntToStr(form1.winampctrl1.GetSongInfo(1)), [rfReplaceAll]);
  end;
  if pos('$WinampFreq', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampFreq',
      IntToStr(form1.winampctrl1.GetSongInfo(0)), [rfReplaceAll]);
  end;
  if pos('$WinampStat', line) <> 0 then
  begin
    case form1.WinampCtrl1.GetState of
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
      IntToStr(form1.winampctrl1.GetListPos + 1), [rfReplaceAll]);
  end;
  if pos('$WinampTotalTracks', line) <> 0 then
  begin
    line := StringReplace(line, '$WinampTotalTracks',
      IntToStr(form1.winampctrl1.GetListCount), [rfReplaceAll]);
  end;

  Result := line;
end;

function TData.changeNet(line: String): String;
const
  maxArgs = 10;

var
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  adapterNum: Cardinal;

begin
  if (pos('$NetIPaddress', line) <> 0) then
  begin
    bDoNet := true;
    dataCs.Enter();
    try
      line := StringReplace(line, '$NetIPaddress', ipaddress, [rfReplaceAll]);
    finally
      dataCs.Leave();
    end;
  end;

  while decodeArgs(line, '$NetAdapter', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      dataCs.Enter();
      try
        line := prefix + netadaptername[adapterNum] + postfix;
      finally
        dataCs.Leave();
      end;
    except
      on E: Exception do line := prefix + '[NetAdapter: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetDownK', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(Round(iNetTotalDown[adapterNum]/1024*10)/10,
        ffFixed, 18, 1, localeFormat) + postfix;
    except
      on E: Exception do line := prefix + '[NetDownK: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetUpK', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(Round(iNetTotalUp[adapterNum]/1024*10)/10,
        ffFixed, 18, 1, localeFormat) + postfix;
    except
      on E: Exception do line := prefix + '[NetUpK: ' + CleanString(E.Message)
        + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetDownM', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix +
         FloatToStrF(Round((iNetTotalDown[adapterNum] div 1024)/1024*10)/10,
         ffFixed, 18, 1, localeFormat) + postfix;
    except
      on E: Exception do line := prefix + '[NetDownM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetUpM', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix +
        FloatToStrF(Round((iNetTotalUp[adapterNum] div 1024)/1024*10)/10,
        ffFixed, 18, 1, localeFormat) + postfix;
    except
      on E: Exception do line := prefix + '[NetUpM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetDownG', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix +
        FloatToStrF(Round((iNetTotalDown[adapterNum] div (1024*1024))/1024*10)/10,
        ffFixed, 18, 1, localeFormat) +
        postfix;
    except
      on E: Exception do line := prefix + '[NetDownG: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetUpG', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix +
        FloatToStrF(Round((iNetTotalUp[adapterNum] div (1024*1024))/1024*10)/10,
        ffFixed, 18, 1, localeFormat) + postfix;
    except
      on E: Exception do line := prefix + '[NetUpG: ' +
        CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetErrDown', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetErrorsDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetErrDown: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetErrUp', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetErrorsUp[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetErrUp: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetErrTot', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetErrorsDown[adapterNum] +
        uiNetErrorsUp[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetErrTot: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetUniDown', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetUnicastDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetUniDown: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetUniUp', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetUnicastUp[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetUniUp: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetUniTot', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetUnicastUp[adapterNum]
        + uiNetUnicastDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetUniTot: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetNuniDown', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetNonUnicastDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetNuniDown: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetNuniUp', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetNonUnicastUp[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetNuniUp: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetNuniTot', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetNonUnicastUp[adapterNum]
        + uiNetNonUnicastDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetNuniTot: ' + E.Message + ']' +
        postfix;
    end;
  end;

  while decodeArgs(line, '$NetPackTot', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(Int64(uiNetNonUnicastUp[adapterNum]) +
        uiNetNonUnicastDown[adapterNum] + uiNetUnicastDown[adapterNum] +
        uiNetUnicastUp[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetPackTot: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetDiscDown', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetDiscardsDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetDiscDown: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetDiscUp', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetDiscardsUp[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetDiscUp: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetDiscTot', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + IntToStr(uiNetDiscardsUp[adapterNum] +
        uiNetDiscardsDown[adapterNum]) + postfix;
    except
      on E: Exception do line := prefix + '[NetDiscTot: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpDownK', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedDownK[adapterNum], ffFixed, 18, 1, localeFormat)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpDownK: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpUpK', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedUpK[adapterNum], ffFixed, 18, 1, localeFormat)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpUpK: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpDownM', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedDownM[adapterNum], ffFixed, 18, 1, localeFormat)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpDownM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpUpM', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    bDoNet := true;
    try
      RequiredParameters(numargs, 1, 1);
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedUpM[adapterNum], ffFixed, 18, 1, localeFormat)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpUpM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  Result := line;
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


procedure TData.ProcessPlugin(var line: String; qstattemp: Integer;
  bCacheResults: Boolean);
var
  args: Array [0..maxArgs-1] of String;
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

      uiPlugin := FindPlugin(args[0]);
      if (bCacheResults) and (not bForceRefresh) then
      begin
        if (dlls[uiPlugin].uiMinRefreshInterval < Cardinal(config.dllPeriod)) then
          uiMinRefresh := config.dllPeriod
        else
          uiMinRefresh := dlls[uiPlugin].uiMinRefreshInterval;

        if (Cardinal(abs(uiScreenStartTime - dlls[uiPlugin].uiLastRefreshed))
            > uiMinRefresh)
          or (uiScreenStartTime = dlls[uiPlugin].uiLastRefreshed) then
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
        sParam1 := change(args[2], qstattemp);
        sParam2 := change(args[3], qstattemp);
        try
          sAnswer := CallPlugin(uiPlugin, StrToInt(args[1]), sParam1, sParam2);
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


function TData.change(line: String; qstattemp: Integer = 1;
   bCacheResults: Boolean = false): String;
var
  FileStream: TFileStream;
  Lines: TStringList;
  letter : Cardinal;
  spacecount : Integer;
  i, h : Integer;
  x: Integer;
  counter3: Integer;
  tempst, sFileloc, spaceline, line2, line3: String;
  iFileline: Integer;
  fFile3: textfile;
  ccount: double;
  hdcounter: Integer;
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  mem: Int64;
  jj: Cardinal;
  found: Boolean;
  iBytesToRead: Integer;
  iPos1, iPos2, iPos3: Integer;
  STHDBar: String;
label
  endChange;
begin
  try
    ProcessPlugin(line, qstattemp, bCacheResults);

    if (Pos('$', line) = 0) then goto endChange;

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

    line := StringReplace(line, '$MemFree', IntToStr(STMemFree),
      [rfReplaceAll]);
    line := StringReplace(line, '$MemUsed', IntToStr(STMemTotal-STMemFree),
      [rfReplaceAll]);
    line := StringReplace(line, '$MemTotal', IntToStr(STMemTotal),
      [rfReplaceAll]);
    line := StringReplace(line, '$PageFree', IntToStr(STPageFree),
      [rfReplaceAll]);
    line := StringReplace(line, '$PageUsed',
      IntToStr(STPageTotal-STPageFree), [rfReplaceAll]);
    line := StringReplace(line, '$PageTotal', IntToStr(STPageTotal),
      [rfReplaceAll]);
    if (pos('$ScreenReso', line) <> 0) then
    begin
      bDoScreenRes := true;
      line := StringReplace(line, '$ScreenReso', screenResolution,
        [rfReplaceAll]);
    end;

    if pos('$MemF%', line) <> 0 then
    begin
      if (STMemTotal > 0) then mem := round(100/STMemTotal*STMemfree)
      else mem := 0;
      line := StringReplace(line, '$MemF%', IntToStr(mem), [rfReplaceAll]);
    end;
    if pos('$MemU%', line) <> 0 then
    begin
      if (STMemTotal > 0) then mem := round(100/STMemTotal*(STMemTotal-STMemfree))
      else mem := 0;
      line := StringReplace(line, '$MemU%', IntToStr(mem), [rfReplaceAll]);
    end;

    if pos('$PageF%', line) <> 0 then
    begin
      if (STPageTotal > 0) then mem := round(100/STPageTotal*STPagefree)
      else mem := 0;
      line := StringReplace(line, '$PageF%', IntToStr(mem), [rfReplaceAll]);
    end;

    if pos('$PageU%', line) <> 0 then
    begin
      if (STPageTotal > 0) then mem := round(100/STPageTotal*(STPageTotal-STPagefree))
      else mem := 0;
      line := StringReplace(line, '$PageU%', IntToStr(mem), [rfReplaceAll]);
    end;

    if (pos('$HD', line) <> 0) then
    begin
      while decodeArgs(line, '$HDFreg', maxArgs, args, prefix, postfix,
        numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          line := prefix + IntToStr(round(STHDFree[letter]/1024)) + postfix;
        except
          on E: Exception do line := prefix + '[HDFreg: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;

      while decodeArgs(line, '$HDFree', maxArgs, args, prefix, postfix,
        numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          line := prefix + IntToStr(STHDFree[letter]) + postfix;
        except
          on E: Exception do line := prefix + '[HDFree: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;


      while decodeArgs(line, '$HDUseg', maxArgs, args, prefix, postfix,
        numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          line2 := IntToStr(round((STHDTotal[letter]-STHDFree[letter])/1024));
          line := prefix + line2 + postfix;
        except
          on E: Exception do line := prefix + '[HDUseg: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;

      while decodeArgs(line, '$HDUsed', maxArgs, args, prefix, postfix,
        numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          line2 := IntToStr(STHDTotal[letter]-STHDFree[letter]);
          line := prefix + line2 + postfix;
        except
          on E: Exception do line := prefix + '[HDUsed: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;

      while decodeArgs(line, '$HDF%', maxArgs, args, prefix, postfix, numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          if (STHDTotal[letter]*STHDFree[letter] <> 0) then
            line2 := intToStr(round(100/STHDTotal[letter]*STHDFree[letter]))
          else
            line2 := '0';
          line := prefix + line2 + postfix;
        except
          on E: Exception do line := prefix + '[HDF%: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;

      while decodeArgs(line, '$HDU%', maxArgs, args, prefix, postfix, numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          if (STHDTotal[letter]*(STHDTotal[letter]-STHDFree[letter]) <> 0) then
            line2 :=
              intToStr(round(100/STHDTotal[letter]*(STHDTotal[letter]-STHDFree[
              letter])))
          else
            line2 := '0';

          line := prefix + line2 + postfix;
        except
          on E: Exception do line := prefix + '[HDU%: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;

      while decodeArgs(line, '$HDTotag', maxArgs, args, prefix, postfix,
        numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          line := prefix + IntToStr(round(STHDTotal[letter]/1024)) + postfix;
        except
          on E: Exception do line := prefix + '[HDTotag: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;

      while decodeArgs(line, '$HDTotal', maxArgs, args, prefix, postfix,
        numargs) do
      begin
        bDoDisks := true;
        try
          RequiredParameters(numargs, 1, 1);
          letter := ord(upcase(args[1][1]));
          bDoDisk[letter] := true;
          line := prefix + IntToStr(STHDTotal[letter]) + postfix;
        except
          on E: Exception do line := prefix + '[HDTotal: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end;
    end;

    if (pos('$Email', line) <> 0) then
    begin
      mailCs.Enter();
      try
        for x := 0 to 9 do
        begin
          line := StringReplace(line, '$Email' + IntToStr(x),
            IntToStr(mail[x].messages), [rfReplaceAll]);
          line := StringReplace(line, '$EmailSub' + IntToStr(x),
            mail[x].lastSubject, [rfReplaceAll]);
          line := StringReplace(line, '$EmailFrom' + IntToStr(x),
            mail[x].lastFrom, [rfReplaceAll]);
        end;
      finally
        mailCs.Leave();
      end;
    end;

    iPos1 :=  pos('$CustomChar(', line);
    while (iPos1 <> 0) do
    begin
      try
        iPos2 := PosEx(')', line, iPos1+12);
        if (iPos2 = 0) then
          raise Exception.Create('No ending bracket');
        Form1.customchar(AnsiMidStr(line, iPos1+12, iPos2-(iPos1+12)));
        Delete(line, iPos1, iPos2-iPos1+1);
      except
        on E: Exception do line := StringReplace(line, '$CustomChar(',
          '[CustomChar: ' + CleanString(E.Message) + ']', []);
      end;

      iPos1 :=  PosEx('$CustomChar(', line, iPos1);
    end;

    if (Pos('$', line) = 0) then goto endChange;

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

    if pos('$Winamp', line) <> 0 then line := changeWinamp(line);

    if (pos('$UpTim', line) <> 0) then
    begin
      dataCs.Enter();
      try
        line := StringReplace(line, '$UpTime', uptimereg, [rfReplaceAll]);
        line := StringReplace(line, '$UpTims', uptimeregs, [rfReplaceAll]);
      finally
        dataCs.Leave();
      end;
    end;

    line := StringReplace(line, '$Username', STUsername, [rfReplaceAll]);
    line := StringReplace(line, '$Computername', STcomputername,
      [rfReplaceAll]);
    if (pos('$CPU', line) <> 0) then
    begin
      line := StringReplace(line, '$CPUType', STCPUType, [rfReplaceAll]);


      if (pos('$CPUSpeed', line) <> 0) then
      begin
        bDoCpuSpeed := true;
        dataCs.Enter();
        try
          line := StringReplace(line, '$CPUSpeed', STCPUSpeed, [rfReplaceAll]);
        finally
          dataCs.Leave();
        end;
      end;

      if (pos('$CPUUsage%', line) <> 0) then
      begin
        bDoCpuUsage := true;
        line := StringReplace(line, '$CPUUsage%', IntToStr(STCPUUsage),
          [rfReplaceAll]);
      end;
    end;

    if (pos('$Temp', line) <> 0) then
    begin
      for x := 1 to 10 do
      begin
        line := StringReplace(line, '$Tempname' + IntToStr(x), TempName[x],
          [rfReplaceAll]);
        line := StringReplace(line, '$Temp' + IntToStr(x),
          FloatToStr(Temperature[x], localeFormat), [rfReplaceAll]);
      end;
    end;
    if (pos('$Fan', line) <> 0) then
    begin
      for x := 1 to 10 do
      begin
        line := StringReplace(line, '$Fanname' + IntToStr(x), Fanname[x],
          [rfReplaceAll]);
        line := StringReplace(line, '$FanS' + IntToStr(x),
          FloatToStr(Fan[x], localeFormat), [rfReplaceAll]);
      end;
    end;

    if (pos('$Volt', line) <> 0) then
    begin
      for x := 1 to 10 do
      begin
        line := StringReplace(line, '$Voltname' + IntToStr(x),Voltname[x],
          [rfReplaceAll]);
        line := StringReplace(line, '$Voltage' + IntToStr(x),
          FloatToStr(Voltage[x], localeFormat), [rfReplaceAll]);
      end;
    end;

    if (pos('$Half-life', line) <> 0) then
    begin
      dataCs.Enter();
      try
        line := StringReplace(line, '$Half-life1', qstatreg1[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$Half-life2', qstatreg2[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$Half-life3', qstatreg3[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$Half-life4', qstatreg4[activeScreen,
          qstattemp], [rfReplaceAll]);
      finally
        dataCs.Leave();
      end;
    end;

    if (pos('$Quake', line) <> 0) then
    begin
      dataCs.Enter();
      try
        line := StringReplace(line, '$QuakeII1', qstatreg1[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeIII1', qstatreg1[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeII2', qstatreg2[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeIII2', qstatreg2[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeII3', qstatreg3[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeIII3', qstatreg3[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeII4', qstatreg4[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$QuakeIII4', qstatreg4[activeScreen,
          qstattemp], [rfReplaceAll]);
      finally
        dataCs.Leave();
      end;
    end;

    if (Pos('$Unreal', line) <> 0) then
    begin
      dataCs.Enter();
      try
        line := StringReplace(line, '$Unreal1', qstatreg1[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$Unreal2', qstatreg2[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$Unreal3', qstatreg3[activeScreen,
          qstattemp], [rfReplaceAll]);
        line := StringReplace(line, '$Unreal4', qstatreg4[activeScreen,
          qstattemp], [rfReplaceAll]);
      finally
        dataCs.Leave();
      end;
    end;

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

    if (pos('$SETI', line) <> 0) then
    begin
      dataCs.Enter();
      try
        line := StringReplace(line, '$SETIResults', setiNumResults,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETICPUTime', setiCpuTime,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETIAverage', setiAvgCpu,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETILastresult', setiLastResult,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETIusertime', setiUserTime,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETItotalusers', setiTotalUsers,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETIrank', setiRank, [rfReplaceAll]);
        line := StringReplace(line, '$SETIsharingrank', setiShareRank,
          [rfReplaceAll]);
        line := StringReplace(line, '$SETImoreWU', setiMoreWU,
          [rfReplaceAll]);
      finally
        dataCs.Leave();
      end;
    end;

    if (pos('$FOLD', line) <> 0) then
    begin
      dataCs.Enter();
      try
        line := StringReplace(line, '$FOLDmemsince', foldMemSince,
          [rfReplaceAll]);
        line := StringReplace(line, '$FOLDlastwu', foldLastWU,
          [rfReplaceAll]);
        line := StringReplace(line, '$FOLDactproc', foldActProcsWeek,
          [rfReplaceAll]);
        line := StringReplace(line, '$FOLDteam', foldTeam, [rfReplaceAll]);
        line := StringReplace(line, '$FOLDscore', foldScore, [rfReplaceAll]);
        line := StringReplace(line, '$FOLDrank', foldRank, [rfReplaceAll]);
        line := StringReplace(line, '$FOLDwu', foldWU, [rfReplaceAll]);
      finally
        dataCs.Leave();
      end;
    end;

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

    if (pos('$Net', line) <> 0) then line := changeNet(line);



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
      jj := 0;
      found := false;
      rssCs.Enter();
      try
        while (jj < rssEntries) and (not found) do
        begin
          if (rss[jj].url = args[1]) then found := true
          else Inc(jj);
        end;

        try
          if (found) and (rss[jj].items > 0)
            and (Cardinal(StrToInt(args[3])) <= rss[jj].items) then
          begin

            // What Rss data do they want: t=title, d=description, b=both
            if (args[2]='t') then
            begin
              line := prefix + rss[jj].title[StrToInt(args[3])] + postfix;
            end
            else
            begin
              if (args[2]='d') then
              begin
                line := prefix + rss[jj].desc[StrToInt(args[3])] + postfix;
              end
              else
              begin
                if (args[2]='b') then
                begin
                  line := prefix + rss[jj].whole + postfix;
                end
                else line := prefix + '[Error: Rss: bad arg #2]' + postfix;
              end;
            end;

          end
          else
          begin
            if (found) then
            begin

              // We know about the Rss entry but have no data...
              if (copy(rss[jj].whole, 1, 6) = '[Rss: ') then
              begin
                // Assume an error message is in whole
                line := prefix + rss[jj].whole + postfix;
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

    while (pos('$Flash(', line) <> 0) do
    begin
      try
        line2 := copy(line, pos('$Flash(', line) + 7, (pos('$)$',
          line))-(pos('$Flash(', line) + 7));
        if (form1.doesflash) then
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
procedure TData.doCpuThread;
var
  count: Integer; // used to update net/memory/disk stats every second.
begin
  count := 0;
  coinitialize(nil);

  while (not cpuThread.Terminated) do
  begin
    cpuUpdate();

    Inc(count);
    if (not cpuThread.Terminated) and (count > 4) then
    begin
      count := 0;
      updateNetworkStats();
      if (not cpuThread.Terminated) then
        diskUpdate();
      if (not cpuThread.Terminated) then
        STMemfree := system1.availPhysmemory div (1024 * 1024);
      if (not cpuThread.Terminated) then
        STMemTotal := system1.totalPhysmemory div (1024 * 1024);
      if (not cpuThread.Terminated) then
        STPageTotal := system1.totalPageFile div (1024 * 1024);
      if (not cpuThread.Terminated) then
        STPageFree := system1.AvailPageFile div (1024 * 1024);
    end;

    if (not cpuThread.Terminated) then sleep(250);
  end;

  CoUninitialize;
end;

procedure TData.diskUpdate;
var
  letter: Cardinal;
begin
// HD space!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if bDoDisks then
  begin
    for letter := 65 to 90 do
    begin
      try
        if (bDoDisk[letter]) then
        begin
          bDoDisk[letter] := false;
          STHDFree[letter] := system1.diskfreespace(chr(letter)) div (1024*1024);
          STHDTotal[letter] := system1.disktotalspace(chr(letter)) div (1024*1024);
        end;
      except
      end;
    end;
  end;
end;

procedure TData.cpuUpdate;
var
  t: longword;
  y, mo, d, h, m, s : Cardinal;
  total, x: Cardinal;
  rawcpu: Double;
  uiRemaining: Cardinal;
  sTempUptime: String;
begin
//try
  //cpuusage!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //Application.ProcessMessages;

  if (bDoCpuUsage) then
  begin
    try
      CollectCPUData;
      rawcpu := adCpuUsage.GetCPUUsage(0);
      rawcpu := abs(rawcpu) * 100;
    except

      // The above (CollectCPUData/GetCPUUsage) can fail if the processor
      // Usage performance counter doesn't exist.
      // Use the MBM Usage counter instead... It will most likely to 0.
      rawcpu := dMbmCpuUsage;
    end;

    if (rawcpu > 100) then rawcpu := 100;
    if (rawcpu < 0) then rawcpu := 0;

    CPUUsage[CPUUsagePos] := Trunc(rawcpu);
    Inc(CPUUsagePos);
    if (CPUUsagePos > 5) then CPUUsagePos := 1;
    if (CPUUsageCount < 5) then Inc(CPUUsageCount);

    total := 0;
    for x := 1 to CPUUsageCount do total := total + CPUUsage[x];
    if (CPUUsageCount > 0) then STCPUUsage := total div CPUUsageCount;
  end;

  t := GetTickCount;

  // The below code creates a very high priority thread which could cause
  // cpu spikes.  Don't do it unless the user is using $CPUSpeed.
  if (bDoCPUSpeed) then
  begin
    //Update CPU Speed (might change on clock-throttling systems
    if (t - lastSpdUpdate > (ticksperseconde * 2)) then
    begin                                                 // Update every 2 s
      lastSpdUpdate := t;

      try
        dataCs.Enter();
        try
          STCPUSpeed := IntToStr(cxCpu[0].Speed.RawSpeed.AsNumber);
        finally
          dataCs.Leave();
        end;
      except
        // BUGBUG: This has been reported as failing when with Range check error,
        // they reported that it only occured when they ran a slow 16 bit app.
      end;
    end;
  end;


  //time/uptime!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if (t < iLastUptime) then iUptime := iUptime + t + (MAXDWORD-iLastUptime)
  else iUptime := iUptime + (t - iLastUptime);
  iLastUptime := t;

  y :=  iUptime div ticksperyear;
  mo := (iUptime div tickspermonth) mod 12;
  d := (iUptime div ticksperdag) mod 30;
  h := (iUptime div ticksperhour) mod 24;
  m := (iUptime div ticksperminute) mod 60;
  s := (iUptime div ticksperseconde) mod 60;

  sTempUptime := '';
  if (y > 0) or (sTempUptime<>'') then
    sTempUptime := sTempUptime + IntToStr(y) +  'yrs ';
  if (mo > 0) or (sTempUptime<>'') then
    sTempUptime := sTempUptime + IntToStr(mo) +  'mts ';
  if (d > 0) or (sTempUptime<>'') then
    sTempUptime := sTempUptime + IntToStr(d) +  'dys ';
  if (h > 0) or (sTempUptime<>'') then
    sTempUptime := sTempUptime + IntToStr(h) +  'hrs ';
  if (m > 0) or (sTempUptime<>'') then
    sTempUptime := sTempUptime + IntToStr(m) +  'min ';
  sTempUptime := sTempUptime + Format('%.2d',[s], localeFormat) + 'secs';
  dataCs.Enter();
  uptimereg := sTempUptime;
  dataCs.Leave();

  // Create the short uptime string
  // Display the three largest units, i.e. '15d 7h 12m' or '7h 12m 2s'
  sTempUptime := '';
  uiRemaining := 0;
  if (y>0) and (sTempUptime='') then uiRemaining := 3;
  if (uiRemaining > 0) then
  begin
    Dec(uiRemaining);
    sTempUptime := sTempUptime + IntToStr(y) +'y ';
  end;

  if (mo>0) and (sTempUptime='') then uiRemaining := 3;
  if (uiRemaining > 0) then
  begin
    Dec(uiRemaining);
    sTempUptime := sTempUptime + IntToStr(mo) +'m ';
  end;

  if (d>0) and (sTempUptime='') then uiRemaining := 3;
  if (uiRemaining > 0) then
  begin
    Dec(uiRemaining);
    sTempUptime := sTempUptime + IntToStr(d) +'d ';
  end;

  if (h>0) and (sTempUptime='') then uiRemaining := 3;
  if (uiRemaining > 0) then
  begin
    Dec(uiRemaining);
    sTempUptime := sTempUptime + IntToStr(h) +'h ';
  end;

  if (m>0) and (sTempUptime='') then uiRemaining := 3;
  if (uiRemaining > 0) then
  begin
    Dec(uiRemaining);
    sTempUptime := sTempUptime + IntToStr(m) +'m ';
  end;

  if (sTempUptime='') or (uiRemaining > 0) then
  begin
    sTempUptime := sTempUptime + Format('%.2d', [s], localeFormat) +'s ';
  end;

  // remove the trailing space and assign to class member
  dataCs.Enter();
  uptimeregs := MidStr(sTempUptime, 1, Length(sTempUptime)-1);
  dataCs.Leave();

//except
//end;

end;




function TData.ReadMBM5Data : Boolean;
var
  myHandle, B, TotalCount : Integer;
  temptemp, tempfan, tempmhz, tempvolt: Integer;
  SharedData: PSharedData;
begin
  myHandle := OpenFileMapping(FILE_MAP_READ, False, '$M$B$M$5$S$D$');
  if myHandle > 0 then
  begin
    SharedData := MapViewOfFile(myHandle, FILE_MAP_READ, 0, 0, 0);
    with SharedData^ do
    begin
      TotalCount := sdIndex[0].Count + sdIndex[1].Count + sdIndex[2].Count +
        sdIndex[3].Count + sdIndex[4].Count;
      temptemp := 0;
      tempfan := 0;
      tempvolt := 0;
      tempmhz := 0;
      for B := 0 to TotalCount - 1 do
      begin
        with sdSensor[B] do
        begin
          if ssType = stTemperature then
          begin
            temptemp := temptemp + 1;
            if temptemp > 11 then temptemp := 11;
            Temperature[temptemp] := ssCurrent;
            TempName[temptemp] := ssName;
          end;
          if ssType = stVoltage then
          begin
            tempvolt := tempvolt + 1;
            if tempvolt > 11 then tempvolt := 11;
            Voltage[tempvolt] := round(ssCurrent*100)/100;
            VoltName[tempvolt] := ssName;
          end;
          if ssType = stFan then
          begin
            tempfan := tempfan + 1;
            if tempfan > 11 then tempfan := 11;
            Fan[tempfan] := ssCurrent;
            FanName[tempfan] := ssName;
          end;
          if ssType = stMhz then
          begin
            tempmhz := tempmhz + 1;
            if tempmhz > 5 then tempmhz := 5;
            CPU[tempmhz] := ssCurrent;
          end;
          if ssType = stPercentage then
          begin
            dMbmCpuUsage := ssCurrent;
          end;
        end;
      end;
    end;
    UnMapViewOfFile(SharedData);
    Result := True;
    CloseHandle(myHandle);
  end
  else result := false;
end;

procedure TData.updateNetworkStats;
//NETWORKS STATS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  Size: ULONG;
  IntfTable: PMibIfTable;
  I: Integer;
  MibRow: TMibIfRow;
  phoste: PHostEnt;
  Buffer: Array [0..100] of char;
  maxEntries: Cardinal;

begin

  if (bDoNet) then
  begin

    GetHostName(Buffer, Sizeof(Buffer));
    phoste := GetHostByName(buffer);
    dataCs.Enter();
    try
      if phoste = nil then ipaddress := '127.0.0.1'
      else ipaddress := StrPas(inet_ntoa(PInAddr(phoste^.h_addr_list^)^));
    finally
      dataCs.Leave();
    end;

    Size := 0;
    if GetIfTable(nil, Size, True) <> ERROR_INSUFFICIENT_BUFFER then  Exit;
      //raise Exception.Create('getiftable failed with ' + errMsg(GetLastError));

    if (Size < sizeof( TMibIftable)) then Exit;
//          raise Exception.Create('size too small');
    IntfTable := AllocMem(Size);
 //   if (IntfTable = nil) then
   //     raise Exception.Create('no memory?');

    try
      if (IntfTable <> nil) and (GetIfTable(IntfTable, Size, True) = NO_ERROR) then
      begin
        maxEntries := IntfTable^.dwNumEntries;
        if (maxEntries > MAXNETSTATS) then maxEntries := MAXNETSTATS;
        for I := 0 to maxEntries - 1 do
        begin
        {$R-}MibRow := IntfTable.Table[I];{$R+}
        // Ignore everything except ethernet cards
        //if MibRow.dwType <> MIB_IF_TYPE_ETHERNET then Continue;

          dataCs.Enter();
          try
            netadaptername[I] := stripspaces(PChar(@MibRow.bDescr[0]));
          finally
            dataCs.Leave();
          end;

          // System values have a limit of 4Gb, so keep our own values,
          // and track overflows.
          if (MibRow.dwInOctets < iPrevSysNetTotalDown[I]) then
          begin
            // System values have wrapped (at 4Gb)
            iNetTotalDown[I] := iNetTotalDown[I] + MibRow.dwInOctets
              + (MAXDWORD - iPrevSysNetTotalDown[I])
          end
          else
          begin
            iNetTotalDown[I] := iNetTotalDown[I]
              + (MibRow.dwInOctets - iPrevSysNetTotalDown[I]);
          end;
          iPrevSysNetTotalDown[I] := MibRow.dwInOctets;

          // System values have a limit of 4Gb, so keep our own values,
          // and track overflows.
          if (MibRow.dwOutOctets < iPrevSysNetTotalUp[I]) then
          begin
            // System values have wrapped (at 4Gb)
            iNetTotalUp[I] := iNetTotalUp[I] + MibRow.dwOutOctets
              + (MAXDWORD - iPrevSysNetTotalUp[I])
          end
          else
          begin
            iNetTotalUp[I] := iNetTotalUp[I]
              + (MibRow.dwOutOctets - iPrevSysNetTotalUp[I]);
          end;
          iPrevSysNetTotalUp[I] := MibRow.dwOutOctets;

          uiNetUnicastDown[I] := MibRow.dwInUcastPkts;
          uiNetUnicastUp[I] := MibRow.dwOutUcastPkts;
          uiNetNonUnicastDown[I] := MibRow.dwInNUcastPkts;
          uiNetNonUnicastUp[I] := MibRow.dwOutNUcastPkts;
          uiNetDiscardsDown[I] := MibRow.dwInDiscards;
          uiNetDiscardsUp[I] := MibRow.dwOutDiscards;
          uiNetErrorsDown[I] := MibRow.dwInErrors;
          uiNetErrorsUp[I] := MibRow.dwOutErrors;
          dNetSpeedDownK[I] :=
            round((iNetTotalDown[I]-iNetTotalDownOld[I])/1024*10)/10;
          dNetSpeedUpK[I] :=
            round((iNetTotalUp[I]-iNetTotalupOld[I])/1024*10)/10;
          dNetSpeedDownM[I] :=
            round(((iNetTotalDown[I]-iNetTotalDownOld[I]) div 1024)/1024*10)/10;
          dNetSpeedUpM[I] :=
            round(((iNetTotalUp[I]-iNetTotalUpOld[I]) div 1024)/1024*10)/10;
          iNetTotalDownOld[I] := iNetTotalDown[I];
          iNetTotalUpOld[I] := iNetTotalUp[I];
        end;
      end;
    finally
      if (IntfTable <> nil) then FreeMem(IntfTable);
    end;
  end;
end;



procedure TData.updateMBMStats(Sender: TObject);
//HARDDISK MOTHERBOARD MONITOR AND DISTRIBUTED STATS!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  x: Integer;
  fFile: textfile;
  counter: Integer;
  bMbm, bReplz: Boolean;
  line: String;
  z, y: Integer;
  screenline: String;
  replline: String;
  sTemp: String;

begin

  bMbm := false;
  bReplz := false;

  for z := 1 to 20 do
  begin
    for y := 1 to config.height do
    begin
      screenline := config.screen[z][y].text;
      if (not bMbm) and (pos('$Fan', screenline) <> 0) then bMbm := true;
      if (not bMbm) and (pos('$Volt', screenline) <> 0) then bMbm := true;
      if (not bMbm) and (pos('$Temp', screenline) <> 0) then bMbm := true;
      if (not bMbm) and (pos('$CPUUsage%', screenline) <> 0) then bMbm := true; // used as backup.
      if (not bReplz) and (pos('$Dnet', screenline) <> 0) then bReplz := true;
    end;
  end;

  STComputername := system1.Computername;
  STUsername := system1.Username;

//cputype!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  try
    STCPUType := cxCpu[0].Name.AsString;
  except
    on E: Exception do STCPUType := '[CPUType: ' + E.Message + ']';
  end;

//SCREENRESO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if (bDoScreenRes) then
  begin
    screenResolution := IntToStr(Screen.DesktopWidth) + 'x' +
      IntToStr(Screen.DesktopHeight);
  end;

//MBM5!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  if bMbm then
    mbmactive := ReadMBM5Data();

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

        if (dataThread.Terminated) then raise EExiting.Create('');

        httpCs.Enter();
        httpCopy := @HTTP;
        httpCs.Leave();
        sl.Text := HTTP.Get(Url);
        // the get call can block for a long time so check if smartie is exiting
        if (dataThread.Terminated) then raise EExiting.Create('');

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
      if (dataThread.Terminated) then raise EExiting.Create('');
      if (E.ReplyErrorCode <> 304) then   // 304=Not Modified.
        raise;
    end;

    else
    begin
      if (dataThread.Terminated) then raise EExiting.Create('');
      raise;
    end;
  end;

  // Even if we fail to download - give the filename so they can use the old data.
  Result := filename;
end;


function TData.getRss(Url: String;var titles, descs: Array of String;
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
  if (dataThread.Terminated) then raise EExiting.Create('');

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

function TData.FileToString(sFilename: String): String;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    try
      sl.LoadFromFile(sFilename);
      Result := sl.Text;
    except
      on E: Exception do Result := '[Exception: ' + E.Message + ']';
    end;
  finally
    sl.Free;
  end;
end;

procedure TData.doSeti;
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
    if (dataThread.Terminated) then raise EExiting.Create('');

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
        setiMoreWU := FloatToStr(
          100-StrToFloat(ANode.ChildNodes['top_rankpct'].Text, localeFormat),
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


function TData.stripspaces(FString: String): String;
begin
  FString := StringReplace(FString, chr(10), '', [rfReplaceAll]);
  FString := StringReplace(FString, chr(13), '', [rfReplaceAll]);
  FString := StringReplace(FString, chr(9), ' ', [rfReplaceAll]);

  while copy(fString, 1, 1) = ' ' do
  begin
    fString := copy(fString, 2, length(fString));
  end;
  while copy(fString, length(fString), 1) = ' ' do
  begin
    fString := copy(fString, 1, length(fString)-1);
  end;

  result := fString;
end;




procedure TData.UpdateHTTP;
begin
  doHTTPUpdate := True;
end;

procedure TData.UpdateGameStats;
begin
  doGameUpdate := True;
end;

procedure TData.UpdateEmail;
begin
  doEmailUpdate := True;
end;

// Runs in data thread
procedure TData.doDataThread;
begin
  coinitialize(nil);

  try
    try
      while (not dataThread.Terminated) do
      begin
        if (not dataThread.Terminated) and (doHTTPUpdate) then httpUpdate;
        if (not dataThread.Terminated) and (doEmailUpdate) then emailUpdate;
        if (not dataThread.Terminated) and (doGameUpdate) then gameUpdate;
        if (not dataThread.Terminated) then sleep(1000);
      end;
    finally
      CoUninitialize;
    end;
  except
    on E: EExiting do Exit;
    else raise;
  end;
end;


// Runs in data thread
procedure TData.gameUpdate;
//GAMESTATS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  templine, templine2, templine4, line: String;
  templine1: Array [1..80] of String;
  counter, counter2: Integer;
  fFile2: textfile;
  z, y: Integer;
  screenline: String;
  srvr: String;
  sTemp: String;
begin
  doGameUpdate := False;

  for z := 1 to 20 do
  begin
    for y := 1 to config.height do
    begin
      try
        screenline := config.screen[z][y].text;
        if ((pos('$Unreal', screenline) <> 0)
          or (pos('$QuakeIII', screenline) <> 0)
          or (pos('$QuakeII', screenline) <> 0)
          or (pos('$Half-life', screenline) <> 0)) then
        begin

          if (dataThread.Terminated) then raise EExiting.Create('');

          if pos('$Half-life', screenline) <> 0 then srvr := '-hls';
          if pos('$QuakeII', screenline) <> 0 then srvr := '-q2s';
          if pos('$QuakeIII', screenline) <> 0 then srvr := '-q3s';
          if pos('$Unreal', screenline) <> 0 then srvr := '-uns';
          winexec(PChar(extractfilepath(application.exename) +
            'qstat.exe -P -of txt'
            + intToStr(z) + '-' + intToStr(y) +
            '.txt -sort F ' + srvr + ' ' + config.gameServer[z, y]), sw_hide);

          templine := '';
          sleep(1000);

          assignfile (fFile2, extractfilepath(application.exename) + 'txt' +
            IntToStr(z) + '-' + IntToStr(y) + '.txt');
          try
            reset (fFile2);
            counter := 1;
            while (not eof(fFile2)) and (counter < 80) do
            begin
              readln (fFile2, templine1[counter]);
              counter := counter + 1;
            end;
          finally
            closefile(fFile2);
          end;

          if (pos('$Unreal1', screenline) <> 0)
            or (pos('$QuakeIII1', screenline) <> 0)
            or (pos('$QuakeII1', screenline) <> 0)
            or (pos('$Half-life1', screenline) <> 0) then
          begin
            sTemp := copy(templine1[2], pos(' / ', templine1[2]) +
              3, length(templine1[2]));
            sTemp := stripspaces(copy(sTemp, pos(' ', sTemp) + 1, length(sTemp)));

            dataCs.Enter();
            qstatreg1[z, y] := sTemp;
            dataCs.Leave();
          end;

          if (pos('$Unreal2', screenline) <> 0)
            or (pos('$QuakeIII2', screenline) <> 0)
            or (pos('$QuakeII2', screenline) <> 0)
            or (pos('$Half-life2', screenline) <> 0) then
          begin
            sTemp := copy(templine1[2], pos(':', templine1[2]), length(templine1[2]));
            sTemp := copy(sTemp, pos('/', sTemp) + 4, length(sTemp));
            sTemp := copy(sTemp, 1, pos('/', sTemp)-5);
            sTemp := stripspaces(copy(sTemp, pos(' ', sTemp) + 1, length(sTemp)));

            dataCs.Enter();
            qstatreg2[z, y] := sTemp;
            dataCs.Leave();
          end;

          if (pos('$Unreal3', screenline) <> 0)
            or (pos('$QuakeIII3', screenline) <> 0)
            or (pos('$QuakeII3', screenline) <> 0)
            or (pos('$Half-life3', screenline) <> 0) then
          begin
            sTemp := stripspaces(copy(templine1[2], pos(' ', templine1[2]),
                 length(templine1[2])));
            sTemp := stripspaces(copy(sTemp, 1, pos('/', sTemp) + 3));

            dataCs.Enter();
            qstatreg3[z, y] := sTemp;
            dataCs.Leave();
          end;

          if (pos('$Unreal4', screenline) <> 0)
            or (pos('$QuakeIII4', screenline) <> 0)
            or (pos('$QuakeII4', screenline) <> 0)
            or (pos('$Half-life4', screenline) <> 0) then
          begin
            sTemp := '';
            for counter2 := 1 to counter-3 do
            begin
              line := stripspaces(templine1[counter2 + 2]);
              templine2 := stripspaces(copy(copy(line, pos('s ', line) + 1,
                length(line)), pos('s ', line) + 2, length(line)));
              templine4 := stripspaces(copy(line, 2, pos(' frags ',
                line)-1));
              line := templine2 + ':' + templine4 + ',';
              sTemp := sTemp + line;
            end;
            dataCs.Enter();
            qstatreg4[z, y] := sTemp;
            dataCs.Leave();
          end;
        end;
      except
        on EExiting do raise;
        on E: Exception do
        begin
          dataCs.Enter();
          try
            qstatreg1[z, y] := '[Exception: ' + E.Message + ']';
            qstatreg2[z, y] := '[Exception: ' + E.Message + ']';
            qstatreg3[z, y] := '[Exception: ' + E.Message + ']';
            qstatreg4[z, y] := '[Exception: ' + E.Message + ']';
          finally
            dataCs.Leave();
          end;
        end
      end;
    end;
  end;
end;

// Runs in data thread
procedure TData.httpUpdate;
const
  maxArgs = 10;
var
  screenline: String;
  z, y, x: Integer;
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

  for y := 1 to 9 do newsAttempts[y] := 0;

  // TODO: this should only be done when the config changes...
  myRssCount := 0;
  DoNewsUpdate[6] := config.checkUpdates;

  for z := 1 to 20 do
  begin
    for y := 1 to config.height do
    begin
        screenline := config.screen[z][y].text;
        while decodeArgs(screenline, '$Rss', maxArgs, args, prefix, postfix,
          numargs) do
        begin
          // check if we have already seen this url:
          iFound := -1;
          for x := 0 to myRssCount-1 do
            if (rss[x].url = args[1]) then iFound := x;

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
        if (pos('$SETI', screenline) <> 0) then DoNewsUpdate[7] := true;
        if (pos('$FOLD', screenline) <> 0) then DoNewsUpdate[9] := true;
    end;
  end;

  rssCs.Enter();
  try
    rssEntries := myRssCount;
  finally
    rssCs.Leave();
  end;
  if (myRssCount > 0) then DoNewsUpdate[1] := true;

  updateNeeded := False;
  for y := 1 to 9 do
  begin
    if (donewsupdate[y]) then updateNeeded := true;
  end;
  if (updateNeeded) then fetchHTTPUpdates;
end;

// Runs in data thread
procedure TData.fetchHTTPUpdates;
var
  counter, counter2: Integer;
  versionline: String;
  sAllTitles, sAllDescs, sWhole: String;
  sFilename: String;
  tempstr, tempstr2: String;
  iPos1, iPosPoint1, iPosPoint2, iPosPoint3: Integer;
  iVersMaj, iVersMin, iVersRel, iVersBuild: Integer;
  bUpgrade: Boolean;
  items: Cardinal;
  titles: Array[0..maxRssItems] of String;
  descs: Array[0..maxRssItems] of String;

begin
  if DoNewsUpdate[1] then
  begin
    DoNewsUpdate[1] := False;

    for counter := 0 to rssEntries-1 do
    begin
      if (rss[counter].url <> '') then
      begin
        if (dataThread.Terminated) then raise EExiting.Create('');

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

              if (dataThread.Terminated) then raise EExiting.Create('');
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

  if (DoNewsUpdate[6]) then
  begin
    DoNewsUpdate[6] := False;
    if (config.checkUpdates) then
    begin
      if (dataThread.Terminated) then raise EExiting.Create('');
      try
        sFilename := getUrl('http://lcdsmartie.sourceforge.net/version2.txt',
          96*60);
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
  end;

  if DoNewsUpdate[7] then
  begin
    DoNewsUpdate[7] := False;
    if (dataThread.Terminated) then raise EExiting.Create('');
    doSeti();
  end;

  if DoNewsUpdate[9] then
  begin
    DoNewsUpdate[9] := False;
    if (dataThread.Terminated) then raise EExiting.Create('');

    try
      sFilename := getUrl(
        'http://vspx27.stanford.edu/cgi-bin/main.py?qtype=userpage&username='
        + config.foldUsername, config.newsRefresh);
      tempstr := FileToString(sFilename);

      tempstr := StringReplace(tempstr, '&amp', '&', [rfReplaceAll]);
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
        if newsAttempts[9]<4 then
        begin
          newsAttempts[9] := newsAttempts[9] + 1;
          DoNewsUpdate[9] := True;
        end
        else
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
  end;
end;

// Runs in data thread
procedure TData.emailUpdate;
var
  mailz: Array[0..9] of Integer;
  z, y, x: Integer;
  screenline: String;
  pop3: TIdPOP3;
  msg: TIdMessage;
  myGotEmail: Boolean;
  messages: Integer;

begin
  doEmailUpdate := False;

  for y := 0 to 9 do mailz[y] := 0;

  for z := 1 to 20 do
  begin
    for y := 1 to config.height do
    begin
        screenline := config.screen[z][y].text;
        for x := 0 to 9 do
        begin
          if (pos('$Email' + IntToStr(x), screenline) <> 0)
            or (pos('$EmailSub' + IntToStr(x), screenline) <> 0)
            or (pos('$EmailFrom' + IntToStr(x), screenline) <> 0) then
          begin
            mailz[x] := 1;
          end;
        end;
    end;
  end;

  myGotEmail := False;

  for y := 0 to 9 do
  begin
    if mailz[y] = 1 then
    begin
      if (dataThread.Terminated) then raise EExiting.Create('');
      try
        if config.pop[y].server <> '' then
        begin
          pop3 := TIdPOP3.Create(nil);
          msg := TIdMessage.Create(nil);
          pop3.host := config.pop[y].server;
          pop3.MaxLineAction := maSplit;
          pop3.ReadTimeout := 15000;   //15 seconds
          pop3.username := config.pop[y].user;
          pop3.Password := config.pop[y].pword;

          try
            httpCs.Enter();
            pop3Copy := @pop3;
            httpCs.Leave();
            if (dataThread.Terminated) then raise EExiting.Create('');
            pop3.Connect(30000);   // 30 seconds
            if (dataThread.Terminated) then raise EExiting.Create('');

            messages := pop3.CheckMessages;
            mailCs.Enter();
            try
              mail[y].messages := messages;
              if (mail[y].messages > 0) and
                (pop3.RetrieveHeader(mail[y].messages, msg)) then
              begin
                mail[y].lastSubject := msg.Subject;
                mail[y].lastFrom := msg.From.Name;
              end
              else
              begin
                mail[y].lastSubject := '[none]';
                mail[y].lastFrom := '[none]';
              end;
            finally
              mailCs.Leave();
            end;

          finally
            httpCs.Enter();
            pop3Copy := nil;
            httpCs.Leave();
            pop3.Disconnect;
            pop3.Free;
            msg.Free;
          end;

          if (mail[y].messages > 0) then myGotEmail := true;

        end;

      except
        on EExiting do raise;
        on E: Exception do
        begin
          mailCs.Enter();
          try
            mail[y].messages := 0;
            mail[y].lastSubject := '[email: ' + E.Message + ']';
            mail[y].lastFrom := '[email: ' + E.Message + ']';
          finally
            mailCs.Leave();
          end;
        end;
      end;
    end;
  end;

  gotEmail := myGotEmail;
end;


end.
