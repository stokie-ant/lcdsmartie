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
 *  $Revision: 1.20 $ $Date: 2004/11/29 16:55:20 $
 *****************************************************************************}


interface

uses Classes, System2, xmldom, XMLIntf, SysUtils, xercesxmldom, XMLDoc,
  msxmldom, ComCtrls, ComObj;

const
  ticksperweek = 3600000*24*7;
  ticksperdag = 3600000*24;
  ticksperhour = 3600000;
  ticksperminute = 60000;
  ticksperseconde = 1000;
  maxRssItems = 20;
  MAXNETSTATS = 10;

type
  TBusType = (btISA, btSMBus, btVIA686ABus, btDirectIO);
  TSMBType = (smtSMBIntel, smtSMBAMD, smtSMBALi, smtSMBNForce, smtSMBSIS);
  TSensorType = (stUnknown, stTemperature, stVoltage, stFan, stMhz,
    stPercentage);

  TSharedIndex = Record
    iType : TSensorType;                          // type of sensor
    Count : Integer;                              // number of sensor for that type
  end;

  TThreadMethod = procedure of object;

  TMyThread = class(TTHREAD)
  public
    constructor Create(myMethod: TThreadMethod);
  private
    method: TThreadMethod; 
  published
    procedure execute; override;
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

  TMyProc = function(param1: pchar; param2: pchar): Pchar;
  stdcall;

  TData = Class(TObject)
  public
    lcdSmartieUpdate: Boolean;
    lcdSmartieUpdateText: String;
    mbmactive: Boolean;
    dllcancheck: Boolean;
    isconnected: Boolean;
    gotEmail: Boolean;
    function change(line: String; qstattemp: Integer = 1): String;
    procedure refres(Sender: TObject);
    procedure updateNetworkStats(Sender: TObject);
    procedure updateMBMStats(Sender: TObject);
    procedure UpdateHTTP;
    procedure UpdateGameStats;
    procedure UpdateEmail;
    constructor Create;
    destructor Destroy; override;
  private
    doHTTPUpdate, doGameUpdate, doEmailUpdate: Boolean; STUsername,
      STComputername, STCPUType, STCPUSpeed: String;
    STPageFree, STPageTotal: Int64;
    STMemFree, STMemTotal: Int64;
    STHDFree, STHDTotal: Array[65..90] of Int64;
    CPUUsage: Array [1..5] of Cardinal;
    CPUUsageCount: Cardinal;
    CPUUsagePos: Cardinal;
    STCPUUsage: Cardinal;
    lastCpuUpdate,
      lastSpdUpdate: LongWord;
    dataThread: TMyThread;
    replline,
      screenResolution: String;
    netadaptername: Array[0..MAXNETSTATS-1] of String;
    iNetTotalDown, iNetTotalDownOld, iPrevSysNetTotalDown: Array[0..9] of Int64;
    iNetTotalUp, iNetTotalUpOld, iPrevSysNetTotalUp: Array[0..9] of Int64;
    uiNetUnicastDown, uiNetUnicastUp, uiNetNonUnicastDown,
      uiNetNonUnicastUp,  uiNetDiscardsDown, uiNetDiscardsUp,
      uiNetErrorsDown, uiNetErrorsUp: Array[0..9] of Cardinal;
    dNetSpeedDownK, dNetSpeedUpK, dNetSpeedDownM, dNetSpeedUpM: Array[0..9] of double;
    ipaddress: String;
    // Begin MBM Stats
    Temperature: Array [1..11] of double;
    Voltage: Array [1..11] of double;
    Fan: Array [1..11] of double;
    CPU: Array [1..5] of double;
    TempName: Array[1..11] of String;
    VoltName: Array[1..11] of String;
    FanName: Array[1..11] of String;
    dMbmCpuUsage: double;
    SharedData: PSharedData;
    // End MBM Stats
    replline2, replline1, uptimereg, uptimeregs: String;
    qstatreg1: Array[1..20, 1..4] of String;
    qstatreg2: Array[1..20, 1..4] of String;
    qstatreg3: Array[1..20, 1..4] of String;
    dllsArray: Array[0..40] of String;
    totaldlls: Integer; templib: String;
    STHDBar: String;
    hlib: Cardinal;
    nlib: Integer;
    plib: String;
    tlib: String;
    function1, function2, function3, function4, function5, function6, function7,
      function8, function9, function10: TmyProc;
    distributedlog: String;
    srvr: String;
    System1: Tsystem;
    qstatreg4: Array[1..20, 1..4] of String;
    DoNewsUpdate: Array [1..9] of Boolean;
    newsAttempts: Array [1..9] of Byte;
    mail: Array [0..9] of TEmail;
    setiNumResults, setiCpuTime, setiAvgCpu, setiLastResult, setiUserTime,
      setiTotalUsers, setiRank, setiShareRank, setiMoreWU: String;
    foldMemSince, foldLastWU, foldActProcsWeek, foldTeam, foldScore,
      foldRank, foldWU: String;
    rss: Array of TRss;
    rssEntries: Cardinal;
    procedure emailUpdate;
    procedure fetchHTTPUpdates;
    procedure httpUpdate;
    procedure gameUpdate;
    procedure doDataThread;
    function ReadMBM5Data : Boolean;
    function getRss(Url: String;var titles, descs: Array of String; maxitems:
      Cardinal; maxfreq: Cardinal = 0): Cardinal;
    function decodeArgs(str: String; funcName: String; maxargs: Cardinal; var
      args: Array of String; var prefix: String; var postfix: String; var
      numArgs: Cardinal): Boolean;
    function changeWinamp(line: String): String;
    function changeNet(line: String): String;
    procedure doSeti;
    function getUrl(Url: String; maxfreq: Cardinal = 0): String;
    function FileToString(sFilename: String): String;
    function CleanString(str: String): String;
  end;

function stripspaces(FString: String): String;



implementation

uses cxCpu40, adCpuUsage, UMain, Windows, Forms, Registry, IpHlpApi,
  IpIfConst, IpRtrMib, WinSock, Dialogs, Buttons, Graphics, ShellAPI,
  mmsystem, ExtActns, Messages, IdHTTP, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdPOP3, IdMessage, Menus,
  ExtCtrls, Controls, StdCtrls, StrUtils, ActiveX, IdUri, DateUtils, IdGlobal;

// Takes a string like: 'C:$Bar(20,30,10) jterlktjer(fsdfs)sfsdf(sdf)'
// with funcName '$Bar'
// and returns true(found) and numArgs=3 and an array with: '20', '30', '10'
// postfix=' jterlktjer(fsdfs)sfsdf(sdf)'
// prefix='C:'
function TData.decodeArgs(str: String; funcName: String; maxargs: Cardinal;
  var args: Array of String; var prefix: String; var postfix: String; var
  numArgs: Cardinal): Boolean;
var
  posFuncStart, posArgsStart, posArgsEnd, posComma, posComma2: Integer;
  tempStr: String;
begin
  Result := true;
  numArgs := 0;

  posFuncStart := pos(funcName + '(', str);
  if (posFuncStart <> 0) then
  begin
    posArgsStart := posFuncStart + length(funcName);
    posArgsEnd := PosEx(')', str, posArgsStart + 1);

    if (posArgsStart <> 0) and (posArgsEnd <> 0) then
    begin
      prefix := copy(str, 1, posFuncStart-1);
      postfix := copy(str, posArgsEnd + 1, length(str)-posArgsEnd + 1);
      tempstr := copy(str, posArgsStart + 1, posArgsEnd-posArgsStart-1);
      // tempstr is now something like: '20,30,10'
      posComma2 := 1;
      repeat
        posComma := posEx(',', tempstr, posComma2);
        if (poscomma = 0) then
        begin
          args[numArgs] := copy(tempstr, posComma2, length(tempstr)-PosComma2
            + 1);
          Inc(numArgs);
        end
        else
        begin
          args[numArgs] := copy(tempstr, posComma2, PosComma-PosComma2);
          Inc(numArgs);
        end;
        posComma2 := posComma + 1;
      until (poscomma = 0) or (numArgs >= maxArgs);
    end;
  end
  else Result := false;

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

constructor TMyThread.Create(myMethod: TThreadMethod);
begin
  method := myMethod;
  inherited Create(true);   // Create suspended.
end;

procedure TMyThread.Execute;
begin
  method();
end;

constructor TData.Create;
begin
  inherited;

  CPUUsagePos := 1;
  isconnected := false;
  totaldlls := 0;
  lcdSmartieUpdate := False;
  distributedlog := config.distLog;

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

  // Start data collection thread
  dataThread := TMyThread.Create(self.doDataThread);
  dataThread.Resume;
end;

destructor TData.Destroy;
begin
  if (Assigned(dataThread)) then
  begin
    if (not dataThread.Terminated) then dataThread.Terminate;
    dataThread.WaitFor;
    dataThread.Destroy;
  end;

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
    line := StringReplace(line, '$WinampTitle', copy(tempstr, pos('. ',
      tempstr) + 2, length(tempstr)-pos('. ', tempstr)-2), [rfReplaceAll]);
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
    assert(numargs = 1);
    try
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
      tempstr := tempstr + formatfloat('00', m) +  'min ';
      tempstr := tempstr + formatfloat('00', s) +  'sec';
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  'min ';
        tempstr := tempstr + formatfloat('00', s) +  'sec';
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
      tempstr := tempstr + formatfloat('00', m) +  'min ';
      tempstr := tempstr + formatfloat('00', s) +  'sec';
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  'min ';
        tempstr := tempstr + formatfloat('00', s) +  'sec';
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
      tempstr := tempstr + formatfloat('00', m) +  ':';
      tempstr := tempstr + formatfloat('00', s);
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  ':';
        tempstr := tempstr + formatfloat('00', s);
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
      tempstr := tempstr + formatfloat('00', m) +  ':';
      tempstr := tempstr + formatfloat('00', s);
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  ':';
        tempstr := tempstr + formatfloat('00', s);
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
      tempstr := tempstr + formatfloat('00', m) +  'min ';
      tempstr := tempstr + formatfloat('00', s) +  'sec';
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) +  'min ';
        tempstr := tempstr + formatfloat('00', s) +  'sec';
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
      tempstr := tempstr + formatfloat('00', m) + ':';
      tempstr := tempstr + formatfloat('00', s);
    end
    else
    begin
      if m > 0 then
      begin
        tempstr := tempstr + IntToStr(m) + ':';
        tempstr := tempstr + formatfloat('00', s);
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
  while decodeArgs(line, '$NetAdapter', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + netadaptername[adapterNum] + postfix;
    except
      on E: Exception do line := prefix + '[NetAdapter: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetDownK', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(Round(iNetTotalDown[adapterNum]/1024*10)/10,
        ffFixed, 18, 1) + postfix;
    except
      on E: Exception do line := prefix + '[NetDownK: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetUpK', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(Round(iNetTotalUp[adapterNum]/1024*10)/10,
        ffFixed, 18, 1) + postfix;
    except
      on E: Exception do line := prefix + '[NetUpK: ' + CleanString(E.Message)
        + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetDownM', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    try
      adapterNum := StrToInt(args[1]);
      line := prefix +
         FloatToStrF(Round((iNetTotalDown[adapterNum] div 1024)/1024*10)/10,
         ffFixed, 18, 1) + postfix;
    except
      on E: Exception do line := prefix + '[NetDownM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetUpM', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix +
        FloatToStrF(Round((iNetTotalUp[adapterNum] div 1024)/1024*10)/10,
        ffFixed, 18, 1) + postfix;
    except
      on E: Exception do line := prefix + '[NetUpM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetDownG', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix +
        FloatToStrF(Round((iNetTotalDown[adapterNum] div (1024*1024))/1024*10)/10,
        ffFixed, 18, 1) +
        postfix;
    except
      on E: Exception do line := prefix + '[NetDownG: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetUpG', maxArgs, args, prefix, postfix, numargs)
    do
  begin
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix +
        FloatToStrF(Round((iNetTotalUp[adapterNum] div (1024*1024))/1024*10)/10,
        ffFixed, 18, 1) + postfix;
    except
      on E: Exception do line := prefix + '[NetUpG: ' +
        CleanString(E.Message) + ']' + postfix;
    end;
  end;
  while decodeArgs(line, '$NetErrDown', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
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
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedDownK[adapterNum], ffFixed, 18, 1)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpDownK: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpUpK', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedUpK[adapterNum], ffFixed, 18, 1)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpUpK: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpDownM', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedDownM[adapterNum], ffFixed, 18, 1)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpDownM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  while decodeArgs(line, '$NetSpUpM', maxArgs, args, prefix, postfix,
    numargs) do
  begin
    assert(numargs = 1);
    try
      adapterNum := StrToInt(args[1]);
      line := prefix + FloatToStrF(dNetSpeedUpM[adapterNum], ffFixed, 18, 1)
        + postfix;
    except
      on E: Exception do line := prefix + '[NetSpUpM: '
        + CleanString(E.Message) + ']' + postfix;
    end;
  end;

  Result := line;
end;



function TData.change(line: String; qstattemp: Integer = 1): String;
const
  maxArgs = 10;

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

begin
  try

    hdcounter := 0;
    while decodeArgs(line, '$LogFile', maxArgs, args, prefix, postfix,
      numargs) do
    begin
      assert(numargs = 2);
      hdcounter := hdcounter + 1;
      if hdcounter > 4 then line := StringReplace(line, '$LogFile("',
        'error', []);

      sFileloc := args[1];

      try
        iFileline := StrToInt(args[2]);

        if iFileline > 3 then iFileline := 3;
        if iFileline < 0 then iFileline := 0;

        SetLength(spaceline, 1024);

        //****BUGBUG: This will cause an exception if there are less than 1024
        // bytes in the file.
        FileStream := TFileStream.Create(sFileloc, fmOpenRead or
          fmShareDenyNone);
        FileStream.Seek(-1 * 1024, soFromEnd);
        FileStream.ReadBuffer(spaceline[1], 1024);
        FileStream.Free;

        Lines := TStringList.Create;
        Lines.Text := spaceline;
        spaceline := stripspaces(lines[lines.count - 1 - iFileline]);
        spaceline := copy(spaceline, pos('] ', spaceline) + 3,
          length(spaceline));
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
      assert(numargs = 2);
      sFileloc := args[1];

      try
        iFileline := StrToInt(args[2]);

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

    line := StringReplace(line, '$UpTime', uptimereg, [rfReplaceAll]);
    line := StringReplace(line, '$UpTims', uptimeregs, [rfReplaceAll]);

    line := StringReplace(line, '$NetIPaddress', ipaddress, [rfReplaceAll]);

    line := StringReplace(line, '$Username', STUsername, [rfReplaceAll]);
    line := StringReplace(line, '$Computername', STcomputername,
      [rfReplaceAll]);
    if (pos('$CPU', line) <> 0) then
    begin
      line := StringReplace(line, '$CPUType', STCPUType, [rfReplaceAll]);
      line := StringReplace(line, '$CPUSpeed', STCPUSpeed, [rfReplaceAll]);
      line := StringReplace(line, '$CPUUsage%', IntToStr(STCPUUsage),
        [rfReplaceAll]);
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
    line := StringReplace(line, '$ScreenReso', screenResolution,
      [rfReplaceAll]);

    if (pos('$Temp', line) <> 0) then
    begin
      for x := 1 to 10 do
      begin
        line := StringReplace(line, '$Tempname' + IntToStr(x), TempName[x],
          [rfReplaceAll]);
        line := StringReplace(line, '$Temp' + IntToStr(x),
          FloatToStr(Temperature[x]), [rfReplaceAll]);
      end;
    end;
    if (pos('$Fan', line) <> 0) then
    begin
      for x := 1 to 10 do
      begin
        line := StringReplace(line, '$Fanname' + IntToStr(x), Fanname[x],
          [rfReplaceAll]);
        line := StringReplace(line, '$FanS' + IntToStr(x),
          FloatToStr(Fan[x]), [rfReplaceAll]);
      end;
    end;

    if (pos('$Volt', line) <> 0) then
    begin
      for x := 1 to 10 do
      begin
        line := StringReplace(line, '$Voltname' + IntToStr(x),Voltname[x],
          [rfReplaceAll]);
        line := StringReplace(line, '$Voltage' + IntToStr(x),
          FloatToStr(Voltage[x]), [rfReplaceAll]);
      end;
    end;

    line := StringReplace(line, '$Half-life1', qstatreg1[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeII1', qstatreg1[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeIII1', qstatreg1[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Unreal1', qstatreg1[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Half-life2', qstatreg2[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeII2', qstatreg2[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeIII2', qstatreg2[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Unreal2', qstatreg2[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Half-life3', qstatreg3[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeII3', qstatreg3[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeIII3', qstatreg3[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Unreal3', qstatreg3[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Half-life4', qstatreg4[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeII4', qstatreg4[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$QuakeIII4', qstatreg4[activeScreen,
      qstattemp], [rfReplaceAll]);
    line := StringReplace(line, '$Unreal4', qstatreg4[activeScreen,
      qstattemp], [rfReplaceAll]);

    if (pos('$Email', line) <> 0) then
    begin
      for x := 0 to 9 do
      begin
        line := StringReplace(line, '$Email' + IntToStr(x),
          IntToStr(mail[x].messages), [rfReplaceAll]);
        line := StringReplace(line, '$EmailSub' + IntToStr(x),
          mail[x].lastSubject, [rfReplaceAll]);
        line := StringReplace(line, '$EmailFrom' + IntToStr(x),
          mail[x].lastFrom, [rfReplaceAll]);
      end;
    end;


    line := StringReplace(line, '$DnetDone', replline2, [rfReplaceAll]);
    line := StringReplace(line, '$DnetSpeed', replline1, [rfReplaceAll]);

    if (pos('$SETI', line) <> 0) then
    begin
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
    end;

    if (pos('$FOLD', line) <> 0) then
    begin
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
    end;

    while pos('$Time(', line) <> 0 do
    begin
      try
        line2 := copy(line, pos('$Time(', line) + 6, length(line));
        line2 := copy(line2, 1, pos(')', line2)-1);
        tempst := formatdatetime(line2, now);
        line := StringReplace(line, '$Time(' + line2 + ')', tempst, []);
      except
        on E: Exception do line := StringReplace(line, '$Time(', '[Time: '
          + CleanString(E.Message) + ']', []);
      end;
    end;

    if (pos('$Net', line) <> 0) then line := changeNet(line);


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

    while decodeArgs(line, '$HDFreg', maxArgs, args, prefix, postfix,
      numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
        line := prefix + IntToStr(round(STHDFree[letter]/1024)) + postfix;
      except
        on E: Exception do line := prefix + '[HDFreg: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$HDFree', maxArgs, args, prefix, postfix,
      numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
        line := prefix + IntToStr(STHDFree[letter]) + postfix;
      except
        on E: Exception do line := prefix + '[HDFree: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;


    while decodeArgs(line, '$HDUseg', maxArgs, args, prefix, postfix,
      numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
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
      try
        letter := ord(upcase(args[1][1]));
        line2 := IntToStr(STHDTotal[letter]-STHDFree[letter]);
        line := prefix + line2 + postfix;
      except
        on E: Exception do line := prefix + '[HDUsed: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$HDF%', maxArgs, args, prefix, postfix, numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
        line2 := intToStr(round(100/STHDTotal[letter]*STHDFree[letter]));
        line := prefix + line2 + postfix;
      except
        on E: Exception do line := prefix + '[HDF%: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$HDU%', maxArgs, args, prefix, postfix, numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
        line2 :=
          intToStr(round(100/STHDTotal[letter]*(STHDTotal[letter]-STHDFree[
          letter])));
        line := prefix + line2 + postfix;
      except
        on E: Exception do line := prefix + '[HDU%: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$HDTotag', maxArgs, args, prefix, postfix,
      numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
        line := prefix + IntToStr(round(STHDTotal[letter]/1024)) + postfix;
      except
        on E: Exception do line := prefix + '[HDTotag: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$HDTotal', maxArgs, args, prefix, postfix,
      numargs) do
    begin
      try
        letter := ord(upcase(args[1][1]));
        line := prefix + IntToStr(STHDTotal[letter]) + postfix;
      except
        on E: Exception do line := prefix + '[HDTotal: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    if decodeArgs(line, '$MObutton', maxArgs, args, prefix, postfix, numargs)
      then
    begin
      if UMain.key = args[1] then spacecount := 1
      else spacecount := 0;
      line := prefix + intToStr(spacecount) + postfix;
    end;

    if decodeArgs(line, '$Chr', maxArgs, args, prefix, postfix, numargs) then
    begin
      try
        line := prefix + Chr(StrToInt(args[1])) + postfix;
      except
        on E: Exception do line := prefix + '[Chr: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$dll', maxArgs, args, prefix, postfix, numargs)
      do
    begin
      totaldlls := totaldlls + 1;
      if dllcancheck = true then
      begin
        try
          tempst := args[1];
          if templib <> tempst then hlib :=
            LoadLibrary(pchar(extractfilepath(application.exename) +
            'plugins\' + tempst));
          templib := tempst;

          nlib := StrToInt(args[2]);
          plib := args[3];
          tlib := args[4];

          if nlib = 1 then
          begin
            @function1 := getprocaddress(hlib, 'function1');
            if @function1 <> nil then dllsArray[totaldlls] :=
              function1(pchar(plib), pchar(tlib));
          end;
          if nlib = 2 then
          begin
            @function2 := getprocaddress(hlib, 'function2');
            if @function2 <> nil then dllsArray[totaldlls] :=
              function2(pchar(plib), pchar(tlib));
          end;
          if nlib = 3 then
          begin
            @function3 := getprocaddress(hlib, 'function3');
            if @function3 <> nil then dllsArray[totaldlls] :=
              function3(pchar(plib), pchar(tlib));
          end;
          if nlib = 4 then
          begin
            @function4 := getprocaddress(hlib, 'function4');
            if @function4 <> nil then dllsArray[totaldlls] :=
              function4(pchar(plib), pchar(tlib));
          end;
          if nlib = 5 then
          begin
            @function5 := getprocaddress(hlib, 'function5');
            if @function5 <> nil then dllsArray[totaldlls] :=
              function5(pchar(plib), pchar(tlib));
          end;
          if nlib = 6 then
          begin
            @function6 := getprocaddress(hlib, 'function6');
            if @function6 <> nil then dllsArray[totaldlls] :=
              function6(pchar(plib), pchar(tlib));
          end;
          if nlib = 7 then
          begin
            @function7 := getprocaddress(hlib, 'function7');
            if @function7 <> nil then dllsArray[totaldlls] :=
              function7(pchar(plib), pchar(tlib));
          end;
          if nlib = 8 then
          begin
            @function8 := getprocaddress(hlib, 'function8');
            if @function8 <> nil then dllsArray[totaldlls] :=
              function8(pchar(plib), pchar(tlib));
          end;
          if nlib = 9 then
          begin
            @function9 := getprocaddress(hlib, 'function9');
            if @function9 <> nil then dllsArray[totaldlls] :=
              function9(pchar(plib), pchar(tlib));
          end;
          if nlib = 0 then
          begin
            @function10 := getprocaddress(hlib, 'function10');
            if @function10 <> nil then dllsArray[totaldlls] :=
              function10(pchar(plib), pchar(tlib));
          end;
          line := prefix + dllsArray[totaldlls] + postfix;
        except
          on E: Exception do line := prefix + '[dll: '
            + CleanString(E.Message) + ']' + postfix;
        end;
      end
      else
      begin
        line := prefix + dllsArray[totaldlls] + postfix;
      end;
    end;

    while decodeArgs(line, '$Count', maxArgs, args, prefix, postfix, numargs)
      do
    begin
      ccount := 0;
      try
        tempst := args[1];
        while pos('#', tempst) <> 0 do
        begin
          ccount := ccount + StrToInt(copy(tempst, 1, pos('#', tempst)-1));
          tempst := copy(tempst, pos('#', tempst) + 1, length(tempst));
        end;
        ccount := ccount + StrToInt(copy(tempst, 1, length(tempst)));

        line := prefix + FloatToStr(ccount) + postfix;
      except
        on E: Exception do line := prefix + '[Count: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while (pos('$CustomChar(', line) <> 0) do
    begin
      try
        line2 := copy(line, pos('$CustomChar(', line) + 12, length(line));
        line2 := copy(line2, 1, pos(')', line2)-1);
        customchar(line2);
        line := StringReplace(line, '$CustomChar(' + line2 + ')', '', []);
      except
        on E: Exception do line := StringReplace(line, '$CustomChar(',
          '[CustomChar: ' + CleanString(E.Message) + ']', []);
      end;
    end;

    // $Rss(URL, TYPE [, NUM [, FREQ]])
    //   TYPE is t=title, d=desc, b=both
    //   NUM is 1 for item 1, etc. 0 means all (default). [when TYPR is b, then 0 is used]
    //   FREQ is the number of hours that must past before checking stream again.
    while decodeArgs(line, '$Rss', maxArgs, args, prefix, postfix, numargs)
      do
    begin
      if (numargs < 3) then
      begin
        args[3] := '0';
      end;

      // locate entry
      jj := 0;
      found := false;
      while (jj < rssEntries) and (not found) do
      begin
        if (rss[jj].url = args[1]) then found := true
        else Inc(jj);
      end;



      try
        if (found) and (rss[jj].items > 0) and (Cardinal(StrToInt(args[3])) <=
          rss[jj].items) then
        begin

          // What Rss data do they want: t=title, d=description, b=both
          if (args[2]='t') then
          begin
            line := prefix + rss[jj].title[StrToInt(args[3])] + postfix;
          end
          else
            if (args[2]='d') then
            begin
              line := prefix + rss[jj].desc[StrToInt(args[3])] + postfix;
            end
            else
              if (args[2]='b') then
              begin
                line := prefix + rss[jj].whole + postfix;
              end
              else line := prefix + '[Error: Rss: bad arg #2]' + postfix;

        end
        else
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
      except
        on E: Exception do line := prefix + '[Rss: '
          + CleanString(E.Message) + ']' + postfix;
      end;
    end;

    while decodeArgs(line, '$Bar', maxArgs, args, prefix, postfix, numargs)
      do
    begin
      assert(numargs = 3);
      try
        spacecount := strtoint(args[3])*3;

        if (StrToFloat(args[2]) <> 0) then x :=
          round(StrToFloat(args[1])*spacecount/StrToFloat(args[2]))
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
        if (doesflash) then
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

    while pos('$Right(', line) <> 0 do
    begin
      try
        line2 := copy(line, pos('$Right(', line), length(line));
        spacecount := StrToInt(copy(line2, pos(',$', line2) + 2, pos('%)',
          line2)-pos(',$', line2)-2));
        line2 := copy(line2, pos('$Right(', line2) + 7, pos(',$',
          line2)-pos('$Right(', line2)-7);

        spaceline := '';
        if spacecount > length(line2) then
        begin
          for h := 1 to spacecount - length(line2) do
          begin
            spaceline := ' ' + spaceline;
          end;
        end;
        spaceline := spaceline + line2;
        line := StringReplace(line, '$Right(' + line2 + ',$' +
          IntToStr(spacecount) + '%)', spaceline, []);
      except
        on E: Exception do line := StringReplace(line, '$Right(', '[Right: '
          + CleanString(E.Message) + ']', []);
      end;
    end;

    while decodeArgs(line, '$Fill', maxArgs, args, prefix, postfix, numargs)
      do
    begin
      try
        spacecount := StrToInt(args[1]);
        spaceline := '';
        if spacecount >= length(prefix) then
        begin
          for h := 0 to spacecount - length(prefix) do
          begin
            spaceline := spaceline + ' ';
          end;
        end;
        line := prefix + spaceline + postfix;
      except
        on E: Exception do line := prefix + '[Fill: ' + E.Message + ']' +
          postfix;
      end;
    end;
  except
    on E: Exception do line := '[Unhandled Exception: '
      + CleanString(E.Message) + ']';
  end;

  line := StringReplace(line, Chr($A), '', [rfReplaceAll]);
  line := StringReplace(line, Chr($D), '', [rfReplaceAll]);
  result := line;
end;

procedure TData.refres(Sender: TObject);
const
  ticksperweek : Cardinal = 3600000*24*7;
  ticksperdag : Cardinal = 3600000*24;
  ticksperhour : Cardinal = 3600000;
  ticksperminute : Cardinal = 60000;
  ticksperseconde : Cardinal = 1000;

var
  t: longword;
  w, d, h, m, s : Cardinal;
  total, y: Cardinal;
  rawcpu: Double;

begin
//try
  //cpuusage!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //Application.ProcessMessages;
  t := GetTickCount;
  if (t - lastCpuUpdate > (ticksperseconde div 4)) then
  begin
    lastCpuUpdate := t;
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
    for y := 1 to CPUUsageCount do total := total + CPUUsage[y];
    if (CPUUsageCount > 0) then STCPUUsage := total div CPUUsageCount;
  end;

  //Update CPU Speed (might change on clock-throttling systems
  if (t - lastSpdUpdate > (ticksperseconde * 2)) then
  begin                                                     // Update every 2 s
    lastSpdUpdate := t;
    try
      STCPUSpeed := IntToStr(cxCpu[0].Speed.RawSpeed.AsNumber);
    except
      // BUGBUG: This has been reported as failing when with Range check error,
      // they reported that it only occured when they ran a slow 16 bit app.
    end;
  end;


  //time/uptime!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  t := GetTickCount;
  w := t div ticksperweek;
  t := t - w * ticksperweek;
  d := t div ticksperdag;
  t := t - d * ticksperdag;
  h := t div ticksperhour;
  t := t - h * ticksperhour;
  m := t div ticksperminute;
  t := t - m * ticksperminute;
  s := t div ticksperseconde;
  uptimereg := '';
  uptimeregs := '';
  if w > 0 then uptimereg := uptimereg + IntToStr(w) +  'wks ';
  if d > 0 then uptimereg := uptimereg + IntToStr(d) +  'dys ';
  if h > 0 then uptimereg := uptimereg + IntToStr(h) +  'hrs ';
  if m > 0 then uptimereg := uptimereg + IntToStr(m) +  'min ';
  uptimereg := uptimereg + IntToStr(s) + 'secs';

  uptimeregs := uptimeregs + IntToStr(d) +  ':';
  uptimeregs := uptimeregs + IntToStr(h) +  ':';
  uptimeregs := uptimeregs + IntToStr(m);

  totaldlls := 0;

  dllcancheck := false;

  distributedlog := config.distLog;

//except
//end;

end;




function TData.ReadMBM5Data : Boolean;
var
  myHandle, B, TotalCount : Integer;
  temptemp, tempfan, tempmhz, tempvolt: Integer;
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

procedure TData.updateNetworkStats(Sender: TObject);
//NETWORKS STATS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  network: Integer;
  Size: ULONG;
  IntfTable: PMibIfTable;
  I: Integer;
  z, y: Integer;
  MibRow: TMibIfRow;
  phoste: PHostEnt;
  Buffer: Array [0..100] of char;
  WSAData: TWSADATA;
  maxEntries: Cardinal;
  status: Integer;

begin
  network := 0;

  for z := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      if (config.screen[z][y].enabled) and (pos('$Net',
        config.screen[z][y].text) <> 0) then network := 1;
    end;
  end;

  if network = 1 then
  begin
    status := WSAStartup($0101, WSAData);
    if status <> 0 then
    begin
      ipaddress := '[WSAStartup Failed: ';
      case status of
        WSASYSNOTREADY: ipaddress := ipaddress + ' WSASYSNOTREADY]';
        WSAVERNOTSUPPORTED: ipaddress := ipaddress + ' WSAVERNOTSUPPORTED]';
        WSAEPROCLIM: ipaddress := ipaddress + ' WSAPROCLIM]';
        WSAEFAULT: ipaddress := ipaddress + ' WSAEFAULT]';
        else ipaddress := ipaddress + ' Unknown]';
      end;
      exit;
    end;
    GetHostName(Buffer, Sizeof(Buffer));
    phoste := GetHostByName(buffer);
    if phoste = nil then ipaddress := '127.0.0.1'
    else ipaddress := StrPas(inet_ntoa(PInAddr(phoste^.h_addr_list^)^));
    WSACleanup;

    Size := 0;
    if GetIfTable(nil, Size, True) <> ERROR_INSUFFICIENT_BUFFER then Exit;
    IntfTable := AllocMem(Size);
    try
      if GetIfTable(IntfTable, Size, True) = NO_ERROR then
      begin
        maxEntries := IntfTable^.dwNumEntries;
        if (maxEntries > MAXNETSTATS) then maxEntries := MAXNETSTATS;
        for I := 0 to maxEntries - 1 do
        begin
        {$R-}MibRow := IntfTable.Table[I];{$R+}
        // Ignore everything except ethernet cards
        //if MibRow.dwType <> MIB_IF_TYPE_ETHERNET then Continue;

          netadaptername[I] := stripspaces(PChar(@MibRow.bDescr[0]));

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
      FreeMem(IntfTable);
    end;
  end;
end;



procedure TData.updateMBMStats(Sender: TObject);
//HARDDISK MOTHERBOARD MONITOR AND DISTRIBUTED STATS!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  letter: Integer;
  letter2: Array [65..90] of Integer;
  x: Integer;
  fFile: textfile;
  replz, hd, mbm, counter: Integer;
  line: String;
  z, y: Integer;
  screenline: String;

begin

  hd := 0;
  mbm := 0;
  replz := 0;

  for z := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      if (config.screen[z][y].enabled) then
      begin
        screenline := config.screen[z][y].text;
        if (pos('$Fan', screenline) <> 0) then mbm := 1;
        if (pos('$Volt', screenline) <> 0) then mbm := 1;
        if (pos('$Temp', screenline) <> 0) then mbm := 1;
        if (pos('$CPUUsage', screenline) <> 0) then mbm := 1; // used as backup.
        if (pos('$HD', screenline) <> 0) then hd := 1;
        if (pos('$Dnet', screenline) <> 0) then replz := 1;
      end;
    end;
  end;

  STComputername := system1.Computername;
  STUsername := system1.Username;

  STMemfree := system1.availPhysmemory div (1024 * 1024);
  STMemTotal := system1.totalPhysmemory div (1024 * 1024);
  STPageTotal := system1.totalPageFile div (1024 * 1024);
  STPageFree := system1.AvailPageFile div (1024 * 1024);

// HD space!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if hd = 1 then
  begin
    for letter := 65 to 90 do letter2[letter] := 0;
    for z := 1 to 20 do
    begin
      for y := 1 to 4 do
      begin
        screenline := config.screen[z][y].text;
        while pos('$HD', screenline) <> 0 do
        begin
          try
            screenline := copy(screenline, pos('$HD', screenline),
              length(screenline));
            letter2[ord(upcase(copy(screenline, pos('(', screenline) + 1,
              1)[1]))] := 1;
            screenline := Stringreplace(screenline, '$HD', '', []);
          except
            screenline := Stringreplace(screenline, '$HD', '', []);
          end;
        end;
      end;
    end;
    for letter := 65 to 90 do
    begin
      try
        if letter2[letter] = 1 then
        begin
//        if (system1.diskindrive(chr(letter), true)) then begin
          STHDFree[letter] := system1.diskfreespace(chr(letter)) div
            (1024*1024);
          STHDTotal[letter] := system1.disktotalspace(chr(letter)) div
            (1024*1024);
//        end;
        end;
      except
      end;
    end;
  end;

//cputype!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  try
    STCPUType := cxCpu[0].Name.AsString;
  except
    on E: Exception do STCPUType := '[CPUType: ' + E.Message + ']';
  end;

//SCREENRESO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  screenResolution := IntToStr(Screen.DesktopWidth) + 'x' +
    IntToStr(Screen.DesktopHeight);

//MBM5!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  if mbm = 1 then
  begin
    if (ReadMBM5Data) then mbmactive := true
    else mbmactive := false;
  end;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if replz = 1 then
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
      replline1 := copy(replline, pos('- [', replline) + 3, pos(' keys',
        replline)-pos('- [', replline));
      if length(replline1) > 7 then
      begin
        replline1 := copy(replline1, 1, pos(',', copy(replline1, 3,
          length(replline1))) + 1);
      end;
      replline := copy(replline, pos('completion', replline) + 30, 200);
      replline2 := copy(replline, pos('(', replline) + 1, pos('.',
        replline)-pos('(', replline)-1);
    end;

    if copy(replline, 1, 3) = 'OGR' then
    begin
      replline1 := copy(replline, pos('- [', replline) + 3, pos(' nodes',
        replline)-pos('- [', replline));
      if length(replline1) > 7 then
      begin
        replline1 := copy(replline1, 1, pos(',', copy(replline1, 3,
          length(replline1))) + 1);
      end;
      replline := copy(replline, pos('remain', replline) + 8, 100);
      replline2 := copy(replline, pos('(', replline) + 1, pos('stats',
        replline)-pos('(', replline)-3);
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

begin
  // Generate a filename for the cached Rss stream.
  Filename := LowerCase(Url);
  Filename := StringReplace(Filename, '\\', '_', [rfReplaceAll]);
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
  Filename := 'cache\\' + Filename + '.cache';

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
        sl.Text := HTTP.Get(Url);
        sl.savetofile(Filename);
      end;
    finally
      sl.Free;
      HTTP.Free;
    end;
  except
    on E: EIdHTTPProtocolException do
    begin
      if (E.ReplyErrorCode <> 304) then   // 304=Not Modified.
        raise;
    end;

    else raise;
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

    // Parse the Xml data
    if FileExists(Filename) then
    begin
      XMLDoc := LoadXMLDocument(Filename);

      StartItemNode := XMLDoc.DocumentElement.ChildNodes.FindNode('userinfo');
      ANode := StartItemNode;

      setiNumResults := ANode.ChildNodes['numresults'].Text;
      setiCpuTime := ANode.ChildNodes['cputime'].Text;
      setiAvgCpu := ANode.ChildNodes['avecpu'].Text;
      setiLastResult := ANode.ChildNodes['lastresulttime'].Text;
      setiUserTime := ANode.ChildNodes['usertime'].Text;
      // not used: 'regdate'

      // not used: group info.

      StartItemNode := XMLDoc.DocumentElement.ChildNodes.FindNode('rankinfo');
      ANode := StartItemNode;

      setiTotalUsers := ANode.ChildNodes['ranktotalusers'].Text;
      setiRank := ANode.ChildNodes['rank'].Text;
      setiShareRank := ANode.ChildNodes['num_samerank'].Text;
      setiMoreWU :=
        FloatToStr(100-StrToFloat(ANode.ChildNodes['top_rankpct'].Text));
    end;
  except
    on E: Exception do
    begin
      setiNumResults := '[Seti: ' + E.Message + ']';
      setiCpuTime := '[Seti: ' + E.Message + ']';
      setiAvgCpu := '[Seti: ' + E.Message + ']';
      setiLastResult := '[Seti: ' + E.Message + ']';
      setiUserTime := '[Seti: ' + E.Message + ']';
      setiTotalUsers := '[Seti: ' + E.Message + ']';
      setiRank := '[Seti: ' + E.Message + ']';
      setiShareRank := '[Seti: ' + E.Message + ']';
      setiMoreWU := '[Seti: ' + E.Message + ']';
    end;
  end;
end;


function stripspaces(FString: String): String;
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

  while (not dataThread.Terminated) do
  begin
    if (not dataThread.Terminated) and (doHTTPUpdate) then httpUpdate;
    if (not dataThread.Terminated) and (doEmailUpdate) then emailUpdate;
    if (not dataThread.Terminated) and (doGameUpdate) then gameUpdate;
    if (not dataThread.Terminated) then sleep(1000);
  end;

  CoUninitialize;
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

begin
  doGameUpdate := False;

  for z := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      try
        screenline := config.screen[z][y].text;
        if (config.screen[z][y].enabled) and ((pos('$Unreal', screenline) <>
          0) or (pos('$QuakeIII', screenline) <> 0) or (pos('$QuakeII',
          screenline) <> 0) or (pos('$Half-life', screenline) <> 0)) then
        begin

          if (dataThread.Terminated) then Exit;

          if pos('$Half-life', screenline) <> 0 then srvr := '-hls';
          if pos('$QuakeII', screenline) <> 0 then srvr := '-q2s';
          if pos('$QuakeIII', screenline) <> 0 then srvr := '-q3s';
          if pos('$Unreal', screenline) <> 0 then srvr := '-uns';
          winexec(PChar(extractfilepath(application.exename) +
            'qstat.exe -P -of txt' + intToStr(z) + '-' + intToStr(y) +
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

          if (pos('$Unreal1', screenline) <> 0) or (pos('$QuakeIII1',
            screenline) <> 0) or (pos('$QuakeII1', screenline) <> 0) or
            (pos('$Half-life1', screenline) <> 0) then
          begin
            qstatreg1[z, y] := copy(templine1[2], pos(' / ', templine1[2]) +
              3, length(templine1[2]));
            qstatreg1[z, y] := stripspaces(copy(qstatreg1[z, y], pos(' ',
              qstatreg1[z, y]) + 1, length(qstatreg1[z, y])));
          end;

          if (pos('$Unreal2', screenline) <> 0) or (pos('$QuakeIII2',
            screenline) <> 0) or (pos('$QuakeII2', screenline) <> 0) or
            (pos('$Half-life2', screenline) <> 0) then
          begin
            qstatreg2[z, y] := copy(templine1[2], pos(':', templine1[2]),
              length(templine1[2]));
            qstatreg2[z, y] := copy(qstatreg2[z, y], pos('/', qstatreg2[z, y])
              + 4, length(qstatreg2[z, y]));
            qstatreg2[z, y] := copy(qstatreg2[z, y], 1, pos('/', qstatreg2[z,
              y])-5);
            qstatreg2[z, y] := stripspaces(copy(qstatreg2[z, y], pos(' ',
              qstatreg2[z, y]) + 1, length(qstatreg2[z, y])));
          end;

          if (pos('$Unreal3', screenline) <> 0) or (pos('$QuakeIII3',
            screenline) <> 0) or (pos('$QuakeII3', screenline) <> 0) or
            (pos('$Half-life3', screenline) <> 0) then
          begin
            qstatreg3[z, y] := stripspaces(copy(templine1[2], pos(' ',
              templine1[2]), length(templine1[2])));
            qstatreg3[z, y] := stripspaces(copy(qstatreg3[z, y], 1, pos('/',
              qstatreg3[z, y]) + 3));
          end;

          if (pos('$Unreal4', screenline) <> 0) or (pos('$QuakeIII4',
            screenline) <> 0) or (pos('$QuakeII4', screenline) <> 0) or
            (pos('$Half-life4', screenline) <> 0) then
          begin
            qstatreg4[z, y] := '';
            for counter2 := 1 to counter-3 do
            begin
              line := stripspaces(templine1[counter2 + 2]);
              templine2 := stripspaces(copy(copy(line, pos('s ', line) + 1,
                length(line)), pos('s ', line) + 2, length(line)));
              templine4 := stripspaces(copy(line, 2, pos(' frags ',
                line)-1));
              line := templine2 + ':' + templine4 + ',';
              qstatreg4[z, y] := qstatreg4[z, y] + line;
            end;
          end;
        end;
      except
        on E: Exception do
        begin
          qstatreg1[z, y] := '[Exception: ' + E.Message + ']';
          qstatreg2[z, y] := '[Exception: ' + E.Message + ']';
          qstatreg3[z, y] := '[Exception: ' + E.Message + ']';
          qstatreg4[z, y] := '[Exception: ' + E.Message + ']';
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
begin
  doHTTPUpdate := False;

  for y := 1 to 9 do newsAttempts[y] := 0;

  // TODO: this should only be done when the config changes...
  myRssCount := 0;
  DoNewsUpdate[6] := config.checkUpdates;

  for z := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      if (config.screen[z][y].enabled) then
      begin
        screenline := config.screen[z][y].text;
        while decodeArgs(screenline, '$Rss', maxArgs, args, prefix, postfix,
          numargs) do
        begin
          // check if we have already seen this url:
          iFound := -1;
          for x := 0 to myRssCount-1 do
            if (rss[x].url = args[1]) then iFound := x;

          if (iFound = -1) then
          begin
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
              try
                rss[myRssCount].maxfreq := StrToInt(args[4]) * 60
              except 
              end;
            end;

            Inc(myRssCount);
          end
          else
          begin
            // seen this one before - raise the maxfreq if this one is higher.
            if (numargs >= 4)
              and (rss[iFound].maxfreq < Cardinal(StrToInt(args[4]) * 60)) then
            begin
              try
                rss[iFound].maxfreq := StrToInt(args[4]) * 60;
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
  end;
  rssEntries := myRssCount;
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
  titles, descs, whole: String;
  sFilename: String;
  tempstr, tempstr2: String;

begin
  if DoNewsUpdate[1] then
  begin
    DoNewsUpdate[1] := False;

    for counter := 0 to rssEntries-1 do
    begin
      if (rss[counter].url <> '') then
      begin
        if (dataThread.Terminated) then Exit;

        try
          rss[counter].items := getRss(rss[counter].url, rss[counter].title,
            rss[counter].desc, maxRssItems, rss[counter].maxfreq);

          titles := '';
          descs := '';
          whole := '';
          for counter2 := 1 to rss[counter].items do
          begin
            titles := titles + rss[counter].title[counter2] + ' | ';
            descs := descs + rss[counter].desc[counter2] + ' | ';
            whole := whole + rss[counter].title[counter2] + ':' +
              rss[counter].desc[counter2] + ' | ';

            if (dataThread.Terminated) then Exit;
          end;
          rss[counter].whole := whole;
          rss[counter].title[0] := titles;
          rss[counter].desc[0] := descs;
        except
          on E: Exception do
          begin
            rss[counter].items := 0;
            rss[counter].title[0] := '[Rss: ' + E.Message + ']';
            rss[counter].desc[0] := '[Rss: ' + E.Message + ']';
            rss[counter].whole := '[Rss: ' + E.Message + ']';
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
      if (dataThread.Terminated) then Exit;
      try
        sFilename := getUrl('http://lcdsmartie.sourceforge.net/version.txt',
          96*60);
        versionline := FileToString(sFilename);
      except
        versionline := '';
      end;
      versionline := StringReplace(versionline, chr(10), '',
        [rfReplaceAll]);
      versionline := StringReplace(versionline, chr(13), '',
        [rfReplaceAll]);
      if copy(versionline, 1, 1) = '5' then isconnected := true;
      if (length(versionline) < 72) and (copy(versionline, 1, 7) <>
        '5.3.0.1') and (versionline <> '') then
      begin
        if (lcdSmartieUpdateText <> copy(versionline, 8, 62)) then
        begin
          lcdSmartieUpdateText := copy(versionline, 8, 62);
          lcdSmartieUpdate := True;
        end;
      end;
    end;
  end;

  if DoNewsUpdate[7] then
  begin
    DoNewsUpdate[7] := False;
    if (dataThread.Terminated) then Exit;
    doSeti();
  end;

  if DoNewsUpdate[9] then
  begin
    DoNewsUpdate[9] := False;
    if (dataThread.Terminated) then Exit;

    try
      sFilename := getUrl(
        'http://vspx27.stanford.edu/cgi-bin/main.py?qtype=userpage&username='
        + config.foldUsername, config.newsRefresh);
      tempstr := FileToString(sFilename);

      tempstr := StringReplace(tempstr, '&amp', '&', [rfReplaceAll]);
      tempstr := StringReplace(tempstr, chr(10), '', [rfReplaceAll]);
      tempstr := StringReplace(tempstr, chr(13), '', [rfReplaceAll]);

      foldMemSince := '[FOLDmemsince: not supported]';

      tempstr2 := copy(tempstr, pos('Date of last work unit', tempstr) + 22,
        500);
      tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
      foldLastWU := stripspaces(stripHtml(tempstr2));

      tempstr2 := copy(tempstr, pos('Total score', tempstr) + 11, 100);
      tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
      foldScore := stripspaces(stripHtml(tempstr2));

      tempstr2 := copy(tempstr, pos('Overall rank (if points are combined)',
        tempstr) + 37, 100);
      tempstr2 := copy(tempstr2, 1, pos('of', tempstr2)-1);
      foldRank := stripspaces(stripHtml(tempstr2));

      tempstr2 := copy(tempstr, pos('Active processors (within 7 days)',
        tempstr) + 33, 100);
      tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
      foldActProcsWeek := stripspaces(stripHtml(tempstr2));

      tempstr2 := copy(tempstr, pos('Team', tempstr) + 4, 500);
      tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
      foldTeam := stripspaces(stripHtml(foldTeam));

      tempstr2 := copy(tempstr, pos('WU', tempstr) + 2, 500);
      tempstr2 := copy(tempstr2, 1, pos('</TR>', tempstr2)-1);
      if (pos('(', tempstr2) <> 0) then tempstr2 := copy(tempstr2, 1, pos('(',
        tempstr2)-1);
      foldWU := stripspaces(stripHtml(tempstr2));

    except
      on E: Exception do
      begin
        if newsAttempts[9]<4 then
        begin
          newsAttempts[9] := newsAttempts[9] + 1;
          DoNewsUpdate[9] := True;
        end
        else
        begin
          foldMemSince := '[fold: ' + E.Message + ']';
          foldLastWU := '[fold: ' + E.Message + ']';
          foldActProcsWeek := '[fold: ' + E.Message + ']';
          foldTeam := '[fold: ' + E.Message + ']';
          foldScore := '[fold: ' + E.Message + ']';
          foldRank := '[fold: ' + E.Message + ']';
          foldWU := '[fold: ' + E.Message + ']';
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

begin
  doEmailUpdate := False;

  for y := 0 to 9 do mailz[y] := 0;

  for z := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      if (config.screen[z][y].enabled) then
      begin
        screenline := config.screen[z][y].text;
        for x := 0 to 9 do
        begin
          if (pos('$Email' + IntToStr(x), screenline) <> 0) then mailz[x] :=
            1;
          if (pos('$EmailSub' + IntToStr(x), screenline) <> 0) then mailz[x]
            := 1;
          if (pos('$EmailFrom' + IntToStr(x), screenline) <> 0) then mailz[x]
            := 1;
        end;
      end;
    end;
  end;

  myGotEmail := False;

  for y := 0 to 9 do
  begin
    if mailz[y] = 1 then
    begin
      if (dataThread.Terminated) then Exit;
      try
        if config.pop[y].server <> '' then
        begin
          pop3 := TIdPOP3.Create(nil);
          msg := TIdMessage.Create(nil);
          pop3.host := config.pop[y].server;
          pop3.MaxLineAction := maSplit;
          pop3.ReadTimeout := 10000;   //10 seconds
          pop3.username := config.pop[y].user;
          pop3.Password := config.pop[y].pword;

          try
            pop3.Connect(30000);   // 30 seconds

            mail[y].messages := pop3.CheckMessages;

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
            pop3.Disconnect;
            pop3.Free;
            msg.Free;
          end;

          if (mail[y].messages > 0) then myGotEmail := true;

        end;

      except
        on E: Exception do
        begin
          mail[y].messages := 0;
          mail[y].lastSubject := '[email: ' + E.Message + ']';
          mail[y].lastFrom := '[email: ' + E.Message + ']';
        end;
      end;
    end;
  end;

  gotEmail := myGotEmail;
end;


end.
