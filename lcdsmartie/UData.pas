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
 *  $Revision: 1.4 $ $Date: 2004/11/17 11:42:46 $
 *****************************************************************************}


interface

uses Classes, System2, System2Ex, xmldom, XMLIntf, SysUtils, xercesxmldom, XMLDoc,
 msxmldom, ComCtrls, ComObj;

const
  ticksperweek  = 3600000*24*7;
  ticksperdag   = 3600000*24;
  ticksperhour  = 3600000;
  ticksperminute = 60000;
  ticksperseconde = 1000;
  maxRss = 10;
  maxRssItems = 20;

type
  TBusType     = (btISA, btSMBus,btVIA686ABus, btDirectIO);
  TSMBType     = (smtSMBIntel, smtSMBAMD, smtSMBALi, smtSMBNForce, smtSMBSIS);
  TSensorType  = (stUnknown, stTemperature, stVoltage, stFan, stMhz, stPercentage);

  TSharedIndex = record
    iType : TSensorType;                          // type of sensor
    Count : integer;                              // number of sensor for that type
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


  TSharedSensor = record
    ssType    : TSensorType;                      // type of sensor
    ssName    : array [0..11] of AnsiChar;        // name of sensor
    sspadding1: array [0..2] of Char;             // padding of 3 byte
    ssCurrent : Double;                           // current value
    ssLow     : Double;                           // lowest readout
    ssHigh    : Double;                           // highest readout
    ssCount   : LongInt;                          // total number of readout
    sspadding2: array [0..3] of Char;             // padding of 4 byte
    ssTotal   : Extended;                         // total amout of all readouts
    sspadding3: array [0..5] of Char;             // padding of 6 byte
    ssAlarm1  : Double;                           // temp & fan: high alarm; voltage: % off;
    ssAlarm2  : Double;                           // temp: low alarm
  end;

  TSharedInfo = record
    siSMB_Base       : Word;                      // SMBus base address
    siSMB_Type       : TBusType;                  // SMBus/Isa bus used to access chip
    siSMB_Code       : TSMBType;                  // SMBus sub type, Intel, AMD or ALi
    siSMB_Addr       : Byte;                      // Address of sensor chip on SMBus
    siSMB_Name       : array [0..40] of AnsiChar; // Nice name for SMBus
    siISA_Base       : Word;                      // ISA base address of sensor chip on ISA
    siChipType       : Integer;                   // Chip nr, connects with Chipinfo.ini
    siVoltageSubType : Byte;                      // Subvoltage option selected
  end;

  TSharedData =  record
    sdVersion : Double;                           // version number (example: 51090)
    sdIndex   : array [0..9]   of TSharedIndex;   // Sensor index
    sdSensor  : array [0..99]  of TSharedSensor;  // sensor info
    sdInfo    : TSharedInfo;                      // misc. info
    sdStart   : array [0..40]  of AnsiChar;       // start time
    sdCurrent : array [0..40]  of AnsiChar;       // current time
    sdPath    : array [0..255] of AnsiChar;       // MBM path
  end;

  PSharedData   = ^TSharedData;

  TEmail = record
    messages: Integer;
    lastSubject: String;
    lastFrom: String;
  end;

  TRss = record
    url: String;
    title: Array [0..maxRssItems] of String; // 0 is all titles
    desc: Array [0..maxRssItems] of String;   // 0 is all descs
    items: Cardinal;
    whole: String;                            // all titles and descs
    maxfreq: Cardinal;                        // hours - 0 means no restriction
  end;

  TMyProc  = function(param1: pchar; param2: pchar): Pchar; stdcall;

  TData = Class(TObject)
    public
      lcdSmartieUpdate: Boolean;
      lcdSmartieUpdateText: String;
      mbmactive:boolean;
      dllcancheck: Boolean;
      isconnected: Boolean;
      gotEmail: Boolean;
      function change(regel:string; qstattemp: Integer=1):string;
      procedure refres(Sender: TObject);
      procedure updateNetworkStats(Sender: TObject);
      procedure updateMBMStats(Sender: TObject);
      procedure UpdateHTTP;
      procedure UpdateGameStats;
      procedure UpdateEmail;
      constructor Create;
      destructor Destroy;   override;
    private
      doHTTPUpdate, doGameUpdate, doEmailUpdate: Boolean;
      STUsername, STComputername, STCPUType, STCPUSpeed: string;
      STPageFree,STPageTotal:Int64;
      STMemFree, STMemTotal: Int64;
      STHDFree,STHDTotal:array[67..90] of Int64;
      CPUUsage: array [1..5] of Cardinal;
      CPUUsageCount: Cardinal;
      CPUUsagePos: Cardinal;
      STCPUUsage: Cardinal;
      lastCpuUpdate: LongWord;
      dataThread: TMyThread;
      koeregel,screenResolution:string;
      netadaptername: array[0..9] of String;
      nettotaldown,nettotalup,netunicastdown,netunicastup,
      netnunicastDown,netnunicastUp,netDiscardsDown,netDiscardsUp,
      netErrorsDown,netErrorsUp,netSpeedDownK,netSpeedUpK, netSpeedDownM,
      netSpeedUpM,nettotaldownold,nettotalupold:array[0..9] of double;
      ipaddress:string;
      Temperature       : array [1..11]  of double;
      Voltage           : array [1..11]  of double;
      Fan               : array [1..11]  of double;
      CPU               : array [1..5]   of double;
      TempName          : array[1..11] of String;
      VoltName          : array[1..11] of String;
      FanName           : array[1..11] of String;
      SharedData   : PSharedData;
      koeregel2,koeregel1,uptimereg,uptimeregs:string;
      qstatreg1: array[1..20,1..4] of string;
      qstatreg2: array[1..20,1..4] of string;
      qstatreg3: array[1..20,1..4] of string;
      dllsarray:array[0..40] of string;
      totaldlls: integer;
      templib:string;
      STHDBar:string;
      hlib: cardinal;
      nlib: Integer;
      plib: string;
      tlib: string;
      function1:TmyProc;
      function2:TmyProc;
      function3:TmyProc;
      function4:TmyProc;
      function5:TmyProc;
      function6:TmyProc;
      function7:TmyProc;
      function8:TmyProc;
      function9:TmyProc;
      function10:TmyProc;
      distributedlog: String;
      srvr:string;
      System1:Tsystem;
      System1Ex:TsystemEx;
      qstatreg4: array[1..20,1..4] of string;
      DoNewsUpdate: Array [1..9] of Boolean;
      newsAttempts: Array [1..9] of Byte;
      mail: Array [0..9] of TEmail;
      setiNumResults,setiCpuTime,setiAvgCpu,setiLastResult,setiUserTime,
      setiTotalUsers,setiRank,setiShareRank,setiMoreWU:string;
      foldMemSince, foldLastWU, foldActProcsWeek, foldTeam, foldScore, foldRank, foldWU:string;
      rss: Array [1..maxRss] of TRss;
      rssEntries: Cardinal;
      procedure emailUpdate;
      procedure fetchHTTPUpdates;
      procedure httpUpdate;
      procedure gameUpdate;
      procedure doDataThread;
      function ReadMBM5Data : Boolean;
      function GetCpuSpeedRegistry(proc: Byte): string;
      function getRss(Url: String;var titles, descs: array of string; maxitems:Cardinal; maxfreq:Cardinal=0): Cardinal;
      function decodeArgs(str: String; funcName: String; maxargs: Cardinal;
         var args: array of String; var prefix: String; var postfix: String; var numArgs:Cardinal):Boolean;
      function changeWinamp(regel: String):String;
      function changeNet(regel: String):String;
      procedure doSeti;
      function getUrl(Url: String; maxfreq: Cardinal=0): String;
      function fileToString(filename: String): String;
  end;

  function stripspaces(Fstring:string): string;



implementation

uses cxCpu40, adCpuUsage, UMain, Windows, Forms, Registry,
      IpHlpApi,  IpIfConst, IpRtrMib, WinSock, Dialogs, Buttons,
      Graphics,  ShellAPI, mmsystem,  ExtActns,
      Messages, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection,
      IdTCPClient, IdMessageClient, IdPOP3, IdMessage, Menus, ExtCtrls, Controls, StdCtrls,
      StrUtils, ActiveX, IdUri, DateUtils, IdGlobal;

// Takes a string like: 'C:$Bar(20,30,10) jterlktjer(fsdfs)sfsdf(sdf)'
// with funcName '$Bar'
// and returns true(found) and numArgs=3 and an array with: '20', '30', '10'
// postfix=' jterlktjer(fsdfs)sfsdf(sdf)'
// prefix='C:'
function TData.decodeArgs(str: String; funcName: String; maxargs: Cardinal;
       var args: array of String; var prefix: String; var postfix: String; var numArgs:Cardinal):Boolean;
var
  posFuncStart, posArgsStart, posArgsEnd, posComma, posComma2: Integer;
  tempStr: String;
begin
  Result:=true;
  numArgs:=0;

  posFuncStart:=pos(funcName+'(', str);
  if (posFuncStart<>0) then begin
    posArgsStart:=posFuncStart+length(funcName);
    posArgsEnd:=PosEx(')', str, posArgsStart+1);

    if (posArgsStart<>0) and (posArgsEnd<>0) then begin
      prefix:=copy(str, 1, posFuncStart-1);
      postfix:=copy(str, posArgsEnd+1, length(str)-posArgsEnd+1);
      tempstr:=copy(str, posArgsStart+1, posArgsEnd-posArgsStart-1);
      // tempstr is now something like: '20,30,10'
      posComma2:=1;
      repeat
        posComma:=posEx(',',tempstr, posComma2);
        if (poscomma=0) then begin
          args[numArgs]:=copy(tempstr, posComma2,  length(tempstr)-PosComma2+1);
          Inc(numArgs);
        end else begin
           args[numArgs]:=copy(tempstr, posComma2, PosComma-PosComma2);
           Inc(numArgs);
        end;
        posComma2:=posComma+1;
      until (poscomma=0) or (numArgs>=maxArgs);
    end;
  end else Result:=false;

end;

function stripHtml(str:String):String;
var
  posTag, posTagEnd: Cardinal;
begin

  repeat
    posTag:=pos('<', str);
    if (posTag<>0) then begin
      posTagEnd:=posEx('>', str, posTag+1);
      if (posTagEnd<>0) then Delete(str, posTag, posTagEnd-posTag+1);
    end;
  until (posTag=0);

  result:=str;
end;

constructor TMyThread.Create(myMethod: TThreadMethod);
begin
  method:=myMethod;
  inherited Create(true);   // Create suspended.
end;

procedure TMyThread.Execute;
begin
    method();
end;

constructor TData.Create;
begin
  inherited;

  CPUUsagePos:=1;
  isconnected:=false;
  totaldlls:=0;
  lcdSmartieUpdate:=False;
  distributedlog:=config.distLog;

  // Get CPU speed once:
  STCPUSpeed:=GetCpuSpeedRegistry(0);
  if (STCPUSpeed='') then STCPUSpeed:=cxCpu[0].Speed.Normalised.FormatMhz;

  doEmailUpdate:=True;
  doHTTPUpdate:=True;
  doGameUpdate:=True;

  // Start data collection thread
  dataThread:= TMyThread.Create(self.doDataThread);
  dataThread.Resume;
end;

destructor TData.Destroy;
begin
  if (Assigned(dataThread)) then begin
    if (not dataThread.Terminated) then dataThread.Terminate;
    dataThread.WaitFor;
    dataThread.Destroy;
  end;

  inherited;
end;


function TData.changeWinamp(regel: String):String;
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
    trackLength:=form1.winampctrl1.TrackLength;
    trackPosition:=form1.winampctrl1.TrackPosition;
    if (trackLength < 0) then trackLength:=0;
    if (trackPosition < 0) then trackPosition:=0;

    if pos('$WinampTitle',regel) <> 0 then begin
      tempstr:=form1.winampctrl1.GetCurrSongTitle;
      regel:=StringReplace(regel,'$WinampTitle',copy(tempstr,pos('. ',tempstr)+2,length(tempstr)-pos('. ',tempstr)-2),[rfReplaceAll]);
    end;
    if pos('$WinampChannels',regel) <> 0 then begin
      if form1.winampctrl1.GetSongInfo(2)>1 then tempstr:='stereo' else tempstr:='mono';
      regel:=StringReplace(regel,'$WinampChannels',tempstr,[rfReplaceAll]);
    end;
    if pos('$WinampKBPS',regel) <> 0 then begin
      regel:=StringReplace(regel,'$WinampKBPS',IntToStr(form1.winampctrl1.GetSongInfo(1)),[rfReplaceAll]);
    end;
    if pos('$WinampFreq',regel) <> 0 then begin
      regel:=StringReplace(regel,'$WinampFreq',IntToStr(form1.winampctrl1.GetSongInfo(0)),[rfReplaceAll]);
    end;
    if pos('$WinampStat',regel) <> 0 then begin
      case form1.WinampCtrl1.GetState of
        0: regel:=StringReplace(regel,'$WinampStat','stopped',[rfReplaceAll]);
        1: regel:=StringReplace(regel,'$WinampStat','playing',[rfReplaceAll]);
        3: regel:=StringReplace(regel,'$WinampStat','paused',[rfReplaceAll]);
      else
        regel:= StringReplace(regel,'$WinampStat','[unknown]',[rfReplaceAll]);
      end;
    end;

    while decodeArgs(regel, '$WinampPosition', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        barlength:=strtoint(args[1]);

        if (trackLength>0) then
          barPosition:=round(((trackPosition / 1000)*barLength) /trackLength)
        else
          barPosition:=0;

        tempstr:='';

        for i:=1 to barPosition-1 do tempstr:=tempstr+ '-';
        tempstr:=tempstr+ '+';
        for i:=barPosition+1 to barlength do tempstr:=tempstr+ '-';
        tempstr:=copy(tempstr,1,barlength);

        regel:=prefix+tempstr+postfix;
      except
        on E: Exception do regel:=prefix+'[WinampPosition: '+E.Message+']'+postfix;
      end;
    end;

    if pos('$WinampPolo',regel) <> 0 then begin
      t:=trackPosition;
      if t/1000> trackLength then t:=trackLength;
      h := t div ticksperhour;
      t:=t -h * ticksperhour;
      m := t div ticksperminute;
      t:=t -m * ticksperminute;
      s := t div ticksperseconde;
      tempstr:='';
      if h>0 then begin
        tempstr:=tempstr+IntToStr(h)+ 'hrs ';
        tempstr:=tempstr+formatfloat('00', m)+ 'min ';
        tempstr:=tempstr+formatfloat('00', s)+ 'sec';
      end else begin
        if m>0 then begin
          tempstr:=tempstr+IntToStr(m)+ 'min ';
          tempstr:=tempstr+formatfloat('00', s)+ 'sec';
        end else begin
          tempstr:=tempstr+IntToStr(s)+ 'sec';
        end;
      end;
      regel:=StringReplace(regel,'$WinampPolo',tempstr,[rfReplaceAll]);
    end;

    if pos('$WinampRelo',regel) <> 0 then begin
      t:=trackLength*1000 - trackPosition;
      if t/1000> trackLength then t:=trackLength;
      h := t div ticksperhour;
      t:=t -h * ticksperhour;
      m := t div ticksperminute;
      t:=t -m * ticksperminute;
      s := t div ticksperseconde;
      tempstr:='';
      if h>0 then begin
        tempstr:=tempstr+IntToStr(h)+ 'hrs ';
        tempstr:=tempstr+formatfloat('00', m)+ 'min ';
        tempstr:=tempstr+formatfloat('00', s)+ 'sec';
      end else begin
        if m>0 then begin
          tempstr:=tempstr+IntToStr(m)+ 'min ';
          tempstr:=tempstr+formatfloat('00', s)+ 'sec';
        end else begin
          tempstr:=tempstr+IntToStr(s)+ 'sec';
        end;
      end;
      regel:=StringReplace(regel,'$WinampRelo',tempstr,[rfReplaceAll]);
    end;

    if pos('$WinampPosh',regel) <> 0 then begin
      t:=trackPosition;
      if t/1000> trackLength then t:=trackLength;
      h := t div ticksperhour;
      t:=t -h * ticksperhour;
      m := t div ticksperminute;
      t:=t -m * ticksperminute;
      s := t div ticksperseconde;
      tempstr:='';
      if h>0 then begin
        tempstr:=tempstr+IntToStr(h)+ ':';
        tempstr:=tempstr+formatfloat('00', m)+ ':';
        tempstr:=tempstr+formatfloat('00', s);
      end else begin
        if m>0 then begin
          tempstr:=tempstr+IntToStr(m)+ ':';
          tempstr:=tempstr+formatfloat('00', s);
        end else begin
          tempstr:=tempstr+IntToStr(s);
        end;
      end;
      regel:=StringReplace(regel,'$WinampPosh',tempstr,[rfReplaceAll]);
    end;

    if pos('$WinampResh',regel) <> 0 then begin
      t:=trackLength*1000 - trackPosition;
      if t /1000 > trackLength then t:=trackLength;
      h := t div ticksperhour;
      t:=t -h * ticksperhour;
      m := t div ticksperminute;
      t:=t -m * ticksperminute;
      s := t div ticksperseconde;
      tempstr:='';
      if h>0 then begin
        tempstr:=tempstr+IntToStr(h)+ ':';
        tempstr:=tempstr+formatfloat('00', m)+ ':';
        tempstr:=tempstr+formatfloat('00', s);
      end else begin
        if m>0 then begin
          tempstr:=tempstr+IntToStr(m)+ ':';
          tempstr:=tempstr+formatfloat('00', s);
        end else begin
          tempstr:=tempstr+IntToStr(s);
        end;
      end;
      regel:=StringReplace(regel,'$WinampResh',tempstr,[rfReplaceAll]);
    end;

    if pos('$Winamppos',regel) <> 0 then begin
      t:=round((trackPosition / 1000));
      if t>trackLength then t:=trackLength;
      regel:=StringReplace(regel,'$Winamppos',IntToStr(t),[rfReplaceAll]);
    end;
    if pos('$WinampRem',regel) <> 0 then begin
      t:=round(tracklength-(trackPosition / 1000));
      if t>trackLength then t:=trackLength;
      regel:=StringReplace(regel,'$WinampRem',IntToStr(t),[rfReplaceAll]);
    end;

    if pos('$WinampLengtl',regel) <> 0 then begin
      t:=trackLength*1000;
      h := t div ticksperhour;
      t:=t -h * ticksperhour;
      m := t div ticksperminute;
      t:=t -m * ticksperminute;
      s := t div ticksperseconde;
      tempstr:='';
      if h>0 then begin
        tempstr:=tempstr+IntToStr(h)+ 'hrs ';
        tempstr:=tempstr+formatfloat('00', m)+ 'min ';
        tempstr:=tempstr+formatfloat('00', s)+ 'sec';
      end else begin
        if m>0 then begin
          tempstr:=tempstr+IntToStr(m)+ 'min ';
          tempstr:=tempstr+formatfloat('00', s)+ 'sec';
        end else begin
          tempstr:=tempstr+IntToStr(s)+ 'sec';
        end;
      end;
      regel:=StringReplace(regel,'$WinampLengtl',tempstr,[rfReplaceAll]);
    end;

    if pos('$WinampLengts',regel) <> 0 then begin
      t:=trackLength*1000;
      h := t div ticksperhour;
      t:=t -h * ticksperhour;
      m := t div ticksperminute;
      t:=t -m * ticksperminute;
      s := t div ticksperseconde;
      tempstr:='';
      if h>0 then begin
        tempstr:=tempstr+IntToStr(h)+ ':';
        tempstr:=tempstr+formatfloat('00', m)+ ':';
        tempstr:=tempstr+formatfloat('00', s);
      end else begin
        if m>0 then begin
          tempstr:=tempstr+IntToStr(m)+ ':';
          tempstr:=tempstr+formatfloat('00', s);
        end else begin
          tempstr:=tempstr+IntToStr(s);
        end;
      end;
      regel:=StringReplace(regel,'$WinampLengts',tempstr,[rfReplaceAll]);
    end;

    if pos('$WinampLength',regel) <> 0 then begin
      regel:=StringReplace(regel,'$WinampLength',IntToStr(trackLength),[rfReplaceAll]);
    end;

    if pos('$WinampTracknr',regel) <> 0 then begin
      regel:=StringReplace(regel,'$WinampTracknr',IntToStr(form1.winampctrl1.GetListPos +1),[rfReplaceAll]);
    end;
    if pos('$WinampTotalTracks',regel) <> 0 then begin
      regel:=StringReplace(regel,'$WinampTotalTracks',IntToStr(form1.winampctrl1.GetListCount),[rfReplaceAll]);
    end;

    Result:=regel;
end;

function TData.changeNet(regel: String):String;
const
  maxArgs = 10;

var
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  adapterNum: Cardinal;

begin
    while decodeArgs(regel, '$NetAdapter', maxArgs, args, prefix, postfix, numargs) do begin
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+netadaptername[adapterNum]+postfix;
      except
        on E: Exception do regel:=prefix+'[NetAdapter: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDownK', maxArgs, args, prefix, postfix, numargs) do begin
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotaldown[adapterNum]/1024*10)/10)+postfix;
      except
        on E: Exception do regel:=prefix+'[NetDownK: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUpK', maxArgs, args, prefix, postfix, numargs) do begin
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotalup[adapterNum]/1024*10)/10)+postfix;
      except
        on E: Exception do regel:=prefix+'[NetUpK: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDownM', maxArgs, args, prefix, postfix, numargs) do begin
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotaldown[adapterNum]/1024/1024*10)/10)+postfix;
      except
        on E: Exception do regel:=prefix+'[NetDownM: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUpM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotalup[adapterNum]/1024/1024*10)/10)+postfix;
      except
        on E: Exception do regel:=prefix+'[NetUpM: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDownG', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotaldown[adapterNum]/1024/1024/1024*10)/10)+postfix;
      except
        on E: Exception do regel:=prefix+'[NetDownG: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUpG', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotalup[adapterNum]/1024/1024/1024*10)/10)+postfix;
      except
        on E: Exception do regel:=prefix+'[NetUpG: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetErrDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netErrorsDown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetErrDown: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetErrUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netErrorsUp[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetErrUp: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetErrTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netErrorsDown[adapterNum]+netErrorsUp[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetErrTot: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUniDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netunicastdown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetUniDown: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUniUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netunicastup[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetUniUp: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUniTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netunicastup[adapterNum]+netunicastdown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetUniTot: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetNuniDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastdown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetNuniDown: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetNuniUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastup[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetNuniUp: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetNuniTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastup[adapterNum]+netnunicastdown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetNuniTot: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetPackTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
         adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastup[adapterNum]+netnunicastdown[adapterNum]+netunicastdown[adapterNum]+netunicastup[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetPackTot: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDiscDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netDiscardsdown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetDiscDown: '+E.Message+']'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDiscUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netDiscardsup[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetDiscUp: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetDiscTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netDiscardsup[adapterNum]+netDiscardsdown[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetDiscTot: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpDownK', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeeddownK[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetSpDownK: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpUpK', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeedupK[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetSpUpK: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpDownM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeeddownM[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetSpDownM: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpUpM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeedupM[adapterNum])+postfix;
      except
        on E: Exception do regel:=prefix+'[NetSpUpM: '+E.Message+']'+postfix;
      end;
    end;

  Result:=regel;
end;



function TData.change(regel:string; qstattemp: Integer=1):string;
const
  maxArgs = 10;

var
  FileStream: TFileStream;
  Lines: TStringList;
  letter : Cardinal;
  spacecount : Integer;
  i, h : Integer;
  x: Integer;
  teller3:integer;
  tempst,fileloc,spaceline, regel2,regel3:string;
  fileline: Integer;
  bestand3:textfile;
  ccount:double;
  hdteller:integer;
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  mem: Int64;
  jj: Cardinal;
  found: Boolean;

begin
  try

    hdteller:=0;
    while decodeArgs(regel, '$LogFile', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=2);
      hdteller:=hdteller+1;
      if hdteller>4 then regel:=StringReplace(regel,'$LogFile("','error', []);

      fileloc:=args[1];

      try
        fileline:=StrToInt(args[2]);

        if fileline > 3 then fileline:=3;
        if fileline < 0 then fileline:=0;

        SetLength(spaceline, 1024);

        //****BUGBUG: This will cause an exception if there are less than 1024
        // bytes in the file.
        FileStream:= TFileStream.Create(fileloc, fmOpenRead or fmShareDenyNone);
        FileStream.Seek(-1 * 1024, soFromEnd);
        FileStream.ReadBuffer(spaceline[1], 1024);
        FileStream.Free;

        Lines:= TStringList.Create;
        Lines.Text:= spaceline;
        spaceline:=stripspaces(lines[lines.count-1-fileline]);
        spaceline:=copy(spaceline, pos('] ',spaceline)+3,length(spaceline));
        for i:=0 to 7 do spaceline:=StringReplace(spaceline, chr(I),'',[rfReplaceAll]);
        Lines.Free;
        regel:=prefix+spaceline+postfix;
      except
        on E: Exception do regel:=prefix+'[Logfile: '+E.message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$File', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=2);
      fileloc:=args[1];

      try
        fileline:=StrToInt(args[2]);

        assignfile(bestand3, fileloc);
        reset(bestand3);
        for teller3:= 1 to fileline do
          readln(bestand3, regel3);
        closefile(bestand3);
        regel:=prefix+regel3+postfix;
      except
        on E: Exception do regel:=prefix+'[File: '+E.Message+']'+postfix;
      end;
    end;

    if pos('$Winamp', regel) <> 0 then regel:=changeWinamp(regel);

    regel:=StringReplace(regel,'$UpTime',uptimereg,[rfReplaceAll]);
    regel:=StringReplace(regel,'$UpTims',uptimeregs,[rfReplaceAll]);

    regel:=StringReplace(regel,'$NetIPaddress',ipaddress,[rfReplaceAll]);

    regel:=StringReplace(regel,'$Username',STUsername,[rfReplaceAll]);
    regel:=StringReplace(regel,'$Computername',STcomputername,[rfReplaceAll]);
    if (pos('$CPU', regel)<>0) then begin
      regel:=StringReplace(regel,'$CPUType',STCPUType,[rfReplaceAll]);
      regel:=StringReplace(regel,'$CPUSpeed',STCPUSpeed,[rfReplaceAll]);
      regel:=StringReplace(regel,'$CPUUsage%',IntToStr(STCPUUsage),[rfReplaceAll]);
    end;
    regel:=StringReplace(regel,'$MemFree',IntToStr(STMemFree),[rfReplaceAll]);
    regel:=StringReplace(regel,'$MemUsed',IntToStr(STMemTotal-STMemFree),[rfReplaceAll]);
    regel:=StringReplace(regel,'$MemTotal',IntToStr(STMemTotal),[rfReplaceAll]);
    regel:=StringReplace(regel,'$PageFree',IntToStr(STPageFree),[rfReplaceAll]);
    regel:=StringReplace(regel,'$PageUsed',IntToStr(STPageTotal-STPageFree),[rfReplaceAll]);
    regel:=StringReplace(regel,'$PageTotal',IntToStr(STPageTotal),[rfReplaceAll]);
    regel:=StringReplace(regel,'$ScreenReso',screenResolution,[rfReplaceAll]);

    if (pos('$Temp', regel)<>0) then begin
      for x:=1 to 10 do begin
        regel:=StringReplace(regel,'$Tempname'+IntToStr(x),TempName[x],[rfReplaceAll]);
        regel:=StringReplace(regel,'$Temp'+IntToStr(x),FloatToStr(Temperature[x]),[rfReplaceAll]);
      end;
    end;
    if (pos('$Fan', regel)<>0) then begin
      for x:=1 to 10 do begin
        regel:=StringReplace(regel,'$Fanname'+IntToStr(x),Fanname[x],[rfReplaceAll]);
        regel:=StringReplace(regel,'$FanS'+IntToStr(x),FloatToStr(Fan[x]),[rfReplaceAll]);
      end;
    end;

    if (pos('$Volt', regel)<>0) then begin
      for x:= 1 to 10 do begin
        regel:=StringReplace(regel,'$Voltname'+IntToStr(x),Voltname[x],[rfReplaceAll]);
        regel:=StringReplace(regel,'$Voltage'+IntToStr(x),FloatToStr(Voltage[x]),[rfReplaceAll]);
      end;
    end;

    regel:=StringReplace(regel,'$Half-life1',qstatreg1[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeII1',qstatreg1[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeIII1',qstatreg1[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Unreal1',qstatreg1[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Half-life2',qstatreg2[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeII2',qstatreg2[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeIII2',qstatreg2[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Unreal2',qstatreg2[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Half-life3',qstatreg3[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeII3',qstatreg3[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeIII3',qstatreg3[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Unreal3',qstatreg3[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Half-life4',qstatreg4[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeII4',qstatreg4[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$QuakeIII4',qstatreg4[activeScreen,qstattemp],[rfReplaceAll]);
    regel:=StringReplace(regel,'$Unreal4',qstatreg4[activeScreen,qstattemp],[rfReplaceAll]);

    if (pos('$Email', regel) <> 0) then begin
      for x:=0 to 9 do begin
        regel:=StringReplace(regel,'$Email'+IntToStr(x),IntToStr(mail[x].messages),[rfReplaceAll]);
        regel:=StringReplace(regel,'$EmailSub'+IntToStr(x),mail[x].lastSubject,[rfReplaceAll]);
        regel:=StringReplace(regel,'$EmailFrom'+IntToStr(x),mail[x].lastFrom,[rfReplaceAll]);
      end;
    end;


    regel:=StringReplace(regel,'$DnetDone',koeregel2,[rfReplaceAll]);
    regel:=StringReplace(regel,'$DnetSpeed',koeregel1,[rfReplaceAll]);

    if (pos('$SETI',regel)<>0) then begin
      regel:=StringReplace(regel,'$SETIResults',setiNumResults,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETICPUTime',setiCpuTime,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIAverage',setiAvgCpu,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETILastresult',setiLastResult,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIusertime',setiUserTime,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETItotalusers',setiTotalUsers,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIrank',setiRank,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIsharingrank',setiShareRank,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETImoreWU',setiMoreWU,[rfReplaceAll]);
    end;

    if (pos('$FOLD',regel)<>0) then begin
      regel:=StringReplace(regel,'$FOLDmemsince',foldMemSince,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDlastwu',foldLastWU,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDactproc',foldActProcsWeek,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDteam',foldTeam,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDscore',foldScore,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDrank',foldRank,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDwu',foldWU,[rfReplaceAll]);
    end;

    while pos('$Time(',regel) <> 0 do begin
      try
        regel2:=copy(regel, pos('$Time(',regel)+6,length(regel));
        regel2:=copy(regel2, 1, pos(')',regel2)-1);
        tempst:=formatdatetime(regel2,now);
        regel:=StringReplace(regel,'$Time('+regel2+')',tempst,[]);
      except
        on E: Exception do regel:=StringReplace(regel,'$Time(','[Time: '+E.Message+']',[]);
      end;
    end;

    if (pos('$Net', regel)<>0) then regel:=changeNet(regel);


    if pos('$MemF%',regel) <> 0 then begin
      if (STMemTotal>0) then mem:= round(100/STMemTotal*STMemfree)
      else mem:=0;
      regel:=StringReplace(regel,'$MemF%', IntToStr(mem),[rfReplaceAll]);
    end;
    if pos('$MemU%',regel) <> 0 then begin
      if (STMemTotal>0) then mem:=round(100/STMemTotal*(STMemTotal-STMemfree))
      else mem:=0;
      regel:=StringReplace(regel,'$MemU%', IntToStr(mem),[rfReplaceAll]);
    end;

    if pos('$PageF%',regel) <> 0 then begin
      if (STPageTotal>0) then mem:= round(100/STPageTotal*STPagefree)
      else mem:=0;
      regel:=StringReplace(regel,'$PageF%', IntToStr(mem),[rfReplaceAll]);
    end;

    if pos('$PageU%',regel) <> 0 then begin
      if (STPageTotal>0) then mem:=round(100/STPageTotal*(STPageTotal-STPagefree))
      else mem:=0;
      regel:=StringReplace(regel,'$PageU%', IntToStr(0),[rfReplaceAll]);
    end;

    while decodeArgs(regel, '$HDFreg', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(round(STHDFree[letter]/1024))+postfix;
      except
        on E: Exception do regel:=prefix+'[HDFreg: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDFree', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(STHDFree[letter])+postfix;
      except
        on E: Exception do regel:=prefix+'[HDFree: '+E.Message+']'+postfix;
      end;
    end;


    while decodeArgs(regel, '$HDUseg', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=IntToStr(round((STHDTotal[letter]-STHDFree[letter])/1024));
        regel:=prefix+regel2+postfix;
      except
        on E: Exception do regel:=prefix+'[HDUseg: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDUsed', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=IntToStr(STHDTotal[letter]-STHDFree[letter]);
        regel:=prefix+regel2+postfix;
      except
        on E: Exception do regel:=prefix+'[HDUsed: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDF%', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=intToStr(round(100/STHDTotal[letter]*STHDFree[letter]));
        regel:=prefix+regel2+postfix;
      except
        on E: Exception do regel:=prefix+'[HDF%: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDU%', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=intToStr(round(100/STHDTotal[letter]*(STHDTotal[letter]-STHDFree[letter])));
        regel:=prefix+regel2+postfix;
      except
        on E: Exception do regel:=prefix+'[HDU%: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDTotag', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(round(STHDTotal[letter]/1024))+postfix;
      except
        on E: Exception do regel:=prefix+'[HDTotag: '+E.Message+']'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDTotal', maxArgs, args, prefix, postfix, numargs) do begin
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(STHDTotal[letter])+postfix;
      except
        on E: Exception do regel:=prefix+'[HDTotal: '+E.Message+']'+postfix;
      end;
    end;

    if decodeArgs(regel, '$MObutton', maxArgs, args, prefix, postfix, numargs) then begin
      if UMain.kar=args[1] then spacecount:=1 else spacecount:=0;
      regel:=prefix+intToStr(spacecount)+postfix;
    end;

    if decodeArgs(regel, '$Chr', maxArgs, args, prefix, postfix, numargs) then begin
      try
        regel:=prefix+Chr(StrToInt(args[1]))+postfix;
      except
        on E: Exception do regel:=prefix+'[Chr]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$dll', maxArgs, args, prefix, postfix, numargs) do begin
      totaldlls:=totaldlls+1;
      if dllcancheck=true then begin
        try
          tempst:=args[1];
          if templib <> tempst then hlib:=LoadLibrary(pchar(extractfilepath(application.exename)+'plugins\'+tempst));
          templib:=tempst;

          nlib:=StrToInt(args[2]);
          plib:=args[3];
          tlib:=args[4];

          if nlib = 1 then begin
            @function1:=getprocaddress(hlib,'function1');
            if @function1 <> nil then dllsarray[totaldlls]:=function1(pchar(plib), pchar(tlib));
          end;
          if nlib = 2 then begin
            @function2:=getprocaddress(hlib,'function2');
            if @function2 <> nil then dllsarray[totaldlls]:=function2(pchar(plib), pchar(tlib));
          end;
          if nlib = 3 then begin
            @function3:=getprocaddress(hlib,'function3');
            if @function3 <> nil then dllsarray[totaldlls]:=function3(pchar(plib), pchar(tlib));
          end;
          if nlib = 4 then begin
            @function4:=getprocaddress(hlib,'function4');
            if @function4 <> nil then dllsarray[totaldlls]:=function4(pchar(plib), pchar(tlib));
          end;
          if nlib = 5 then begin
            @function5:=getprocaddress(hlib,'function5');
            if @function5 <> nil then dllsarray[totaldlls]:=function5(pchar(plib), pchar(tlib));
          end;
          if nlib = 6 then begin
            @function6:=getprocaddress(hlib,'function6');
            if @function6 <> nil then dllsarray[totaldlls]:=function6(pchar(plib), pchar(tlib));
          end;
          if nlib = 7 then begin
            @function7:=getprocaddress(hlib,'function7');
            if @function7 <> nil then dllsarray[totaldlls]:=function7(pchar(plib), pchar(tlib));
          end;
          if nlib = 8 then begin
            @function8:=getprocaddress(hlib,'function8');
            if @function8 <> nil then dllsarray[totaldlls]:=function8(pchar(plib), pchar(tlib));
          end;
          if nlib = 9 then begin
            @function9:=getprocaddress(hlib,'function9');
            if @function9 <> nil then dllsarray[totaldlls]:=function9(pchar(plib), pchar(tlib));
          end;
          if nlib = 0 then begin
            @function10:=getprocaddress(hlib,'function10');
            if @function10 <> nil then dllsarray[totaldlls]:=function10(pchar(plib), pchar(tlib));
          end;
          regel:=prefix+dllsarray[totaldlls]+postfix;
        except
          on E: Exception do regel:=prefix+'[dll: '+E.Message+']'+postfix;
        end;
      end else begin
        regel:=prefix+dllsarray[totaldlls]+postfix;
      end;
    end;

    while decodeArgs(regel, '$Count', maxArgs, args, prefix, postfix, numargs) do begin
      ccount:=0;
      try
        tempst:=args[1];
        while pos('#',tempst) <> 0 do begin
          ccount:=ccount+StrToInt(copy(tempst,1,pos('#',tempst)-1));
          tempst:=copy(tempst,pos('#',tempst)+1,length(tempst));
        end;
        ccount:=ccount+StrToInt(copy(tempst,1,length(tempst)));

        regel:=prefix+FloatToStr(ccount)+postfix;
      except
        on E: Exception do regel:=prefix+'[Count: '+E.Message+']'+postfix;
      end;
    end;

    while (pos('$CustomChar(',regel) <> 0) do begin
      try
        regel2:=copy(regel,pos('$CustomChar(',regel)+12, length(regel));
        regel2:=copy(regel2,1,pos(')',regel2)-1);
        customchar(regel2);
        regel:=StringReplace(regel,'$CustomChar('+regel2+')','', []);
      except
        on E: Exception do regel:=StringReplace(regel,
                                      '$CustomChar(',
                                      '[CustomChar: '+E.Message+']', []);
      end;
    end;

    // $Rss(URL, TYPE [, NUM [, FREQ]])
    //   TYPE is t=title, d=desc, b=both
    //   NUM is 1 for item 1, etc. 0 means all (default). [when TYPR is b, then 0 is used]
    //   FREQ is the number of hours that must past before checking stream again.
   while decodeArgs(regel, '$Rss', maxArgs, args, prefix, postfix, numargs) do begin
      if (numargs<3) then begin
        args[3]:='0';
      end;

      // locate entry
      jj:=0;
      found:=false;
      repeat
        Inc(jj);
        if (rss[jj].url = args[1]) then found:=true;
      until (jj>=rssEntries) or (found);

      try
        if (found) and (rss[jj].items>0) and (Cardinal(StrToInt(args[3]))<=rss[jj].items) then begin
          if (args[2]='t') then begin
            regel:=prefix+rss[jj].title[StrToInt(args[3])]+postfix;
          end else if (args[2]='d') then begin
            regel:=prefix+rss[jj].desc[StrToInt(args[3])]+postfix;
          end else if (args[2]='b') then begin
            regel:=prefix+rss[jj].whole+postfix;
          end else regel:=prefix+'[Error: Rss: bad arg 2]'+postfix;
        end
        else regel:=prefix+'[Rss: Data Not Available]'+postfix;
      except
        on E: Exception do regel:=prefix+'[Rss: '+E.Message+']'+postfix;
      end;
   end;

   while decodeArgs(regel, '$Bar', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=3);
      try
        spacecount:=strtoint(args[3])*3;

        if (StrToFloat(args[2])<> 0) then
          x:=round(StrToFloat(args[1])*spacecount/StrToFloat(args[2]))
        else
          x:=0;

        if x>spacecount then x:=spacecount;
        STHDBar:='';
        for h:=1 to (x div 3) do STHDBar:=STHDBar+'ž';
        if (x mod 3 = 1) then STHDBar:=STHDBar+chr(131);
        if (x mod 3 = 2) then STHDBar:=STHDBar+chr(132);
        for h:=1 to round(spacecount/3)-length(STHDBar) do STHDBar:=STHDBar+'_';

        regel:=prefix+STHDBar+postfix;
      except
        on E: Exception do regel:=prefix+'[Bar: '+E.Message+']'+postfix;
      end;
    end;

    while (pos('$Flash(',regel) <> 0) do begin
      try
        regel2:=copy(regel,pos('$Flash(',regel)+7, (pos('$)$',regel))-(pos('$Flash(',regel)+7));
        if (doesflash) then begin
          spaceline:='';
          for h:=1 to length(regel2) do begin
            spaceline:=spaceline+' ';
          end;
        end else begin
          spaceline:=regel2;
        end;
        if pos('$)$',regel)<>0 then
          regel:=StringReplace(regel,'$Flash('+regel2+'$)$',spaceline, [])
        else
          regel:=StringReplace(regel,'$Flash(','ERROR', []);
      except
        on E: Exception do regel:=StringReplace(regel,
                                          '$Flash(',
                                          '[Flash: '+E.Message+']', []);
      end;
    end;

    while pos('$Right(',regel) <> 0 do begin
      try
        regel2:=copy(regel,pos('$Right(',regel),length(regel));
        spacecount:=StrToInt(copy(regel2, pos(',$',regel2)+2,pos('%)',regel2)-pos(',$',regel2)-2));
        regel2:=copy(regel2,pos('$Right(',regel2)+7,pos(',$',regel2)-pos('$Right(',regel2)-7);

        spaceline:='';
        if spacecount > length(regel2) then begin
          for h:=1 to spacecount - length(regel2) do begin
            spaceline:=' '+spaceline;
          end;
        end;
        spaceline:=spaceline+regel2;
        regel:=StringReplace(regel,'$Right('+regel2+',$'+IntToStr(spacecount)+'%)',spaceline, []);
      except
        on E: Exception do regel:=StringReplace(regel,'$Right(','[Right: '+E.Message+']', []);
      end;
    end;

    while decodeArgs(regel, '$Fill', maxArgs, args, prefix, postfix, numargs) do begin
      try
        spacecount:=StrToInt(args[1]);
        spaceline:='';
        if spacecount >= length(prefix) then begin
          for h:=0 to spacecount - length(prefix) do begin
            spaceline:=spaceline+' ';
          end;
        end;
        regel:=prefix+spaceline+postfix;
      except
        on E: Exception do regel:=prefix+'[Fill: '+E.Message+']'+postfix;
      end;
    end;
  except
    on E: Exception do regel:='[Unhandled Exception: '+E.Message+']';
  end;

  regel:=StringReplace(regel,Chr($A),'',[rfReplaceAll]);
  regel:=StringReplace(regel,Chr($D),'',[rfReplaceAll]);
  result:=regel;
end;

procedure TData.refres(Sender: TObject);
const
  ticksperweek    : Cardinal = 3600000*24*7;
  ticksperdag     : Cardinal = 3600000*24;
  ticksperhour    : Cardinal = 3600000;
  ticksperminute  : Cardinal = 60000;
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
  t:=GetTickCount;
  if (t - lastCpuUpdate > (ticksperseconde div 4)) then begin
    lastCpuUpdate := t;
    //try
      {  CPUUsage[CPUUsagePos]:=cxCpu[0].Usage.Value.AsNumber;}
      CollectCPUData;
      rawcpu:= adCpuUsage.GetCPUUsage(0);

      if (rawcpu <= 1.1) and (rawcpu >= -0.1) then begin
        CPUUsage[CPUUsagePos]:=Trunc(abs(rawcpu) * 100);
        Inc(CPUUsagePos);
        if (CPUUsagePos>5) then CPUUsagePos:=1;
        if (CPUUsageCount<5) then Inc(CPUUsageCount);
      end;
    //except
    //end;

    total:=0;
    for y:=1 to CPUUsageCount do total:=total+CPUUsage[y];
    if (CPUUsageCount>0) then STCPUUsage:=total div CPUUsageCount;
  end;


  //time/uptime!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  t:=GetTickCount;
  w := t div ticksperweek;
  t:=t -w*ticksperweek;
  d := t div ticksperdag;
  t:=t -d * ticksperdag;
  h := t div ticksperhour;
  t:=t -h * ticksperhour;
  m := t div ticksperminute;
  t:=t -m * ticksperminute;
  s := t div ticksperseconde;
  uptimereg:='';
  uptimeregs:='';
  if w>0 then uptimereg:=uptimereg+IntToStr(w)+ 'wks ';
  if d>0 then uptimereg:=uptimereg+IntToStr(d)+ 'dys ';
  if h>0 then uptimereg:=uptimereg+IntToStr(h)+ 'hrs ';
  if m>0 then uptimereg:=uptimereg+IntToStr(m)+ 'min ';
  uptimereg:=uptimereg+IntToStr(s) + 'secs';

  uptimeregs:=uptimeregs+IntToStr(d)+ ':';
  uptimeregs:=uptimeregs+IntToStr(h)+ ':';
  uptimeregs:=uptimeregs+IntToStr(m);

  totaldlls:=0;

  dllcancheck:=false;

  distributedlog:=config.distLog;

//except
//end;

end;




function TData.ReadMBM5Data : Boolean;
  var     myHandle, B, TotalCount : Integer;
          temptemp,tempfan,tempmhz,tempvolt:integer;
begin
  myHandle :=  OpenFileMapping(FILE_MAP_READ, False, '$M$B$M$5$S$D$');
  if myHandle > 0 then begin
    SharedData := MapViewOfFile(myHandle, FILE_MAP_READ, 0, 0, 0);
    with SharedData^ do begin
      TotalCount := sdIndex[0].Count +
                    sdIndex[1].Count +
                    sdIndex[2].Count +
                    sdIndex[3].Count +
                    sdIndex[4].Count;
      temptemp:=0;
      tempfan:=0;
      tempvolt:=0;
      tempmhz:=0;
      for B := 0 to TotalCount - 1 do begin
        with sdSensor[B] do begin
          if ssType = stTemperature then begin
            temptemp:=temptemp+1;
            if temptemp > 11 then temptemp:= 11;
            Temperature[temptemp]:=ssCurrent;
            TempName[temptemp]:=ssName;
          end;
          if ssType = stVoltage then begin
            tempvolt:=tempvolt+1;
            if tempvolt > 11 then tempvolt:= 11;
            Voltage[tempvolt]:=round(ssCurrent*100)/100;
            VoltName[tempvolt]:=ssName;
          end;
          if ssType = stFan then begin
            tempfan:=tempfan+1;
            if tempfan > 11 then tempfan:= 11;
            Fan[tempfan]:=ssCurrent;
            FanName[tempfan]:=ssName;
          end;
          if ssType = stMhz then begin
            tempmhz:=tempmhz+1;
            if tempmhz > 5 then tempmhz:= 5;
            CPU[tempmhz]:=ssCurrent;
          end;
        end;
      end;
    end;
    UnMapViewOfFile(SharedData);
    Result := True;
    CloseHandle(myHandle);
  end else result := false;
end;

function TData.GetCpuSpeedRegistry(proc: Byte): string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('Hardware\Description\System\CentralProcessor\'+IntToStr(proc), False) then
    begin
      Result := IntToStr(Reg.ReadInteger('~MHz'));
      Reg.CloseKey;
    end else begin
      Result := '';
    end;
  finally
    Reg.Free;
  end;
end;



procedure TData.updateNetworkStats(Sender: TObject);
//NETWORKS STATS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  netwerk:integer;
  Size: ULONG;
  IntfTable: PMibIfTable;
  I: Integer;
  z,y: Integer;
  MibRow: TMibIfRow;
  phoste: PHostEnt;
  Buffer: array [0..100] of char;
  WSAData: TWSADATA;

begin
  netwerk:=0;

  for z:= 1 to 20 do begin
    for y:= 1 to 4 do begin
      if (config.screen[z][y].enabled) and (pos('$Net', config.screen[z][y].text) <> 0) then netwerk:=1;
    end;
  end;

if netwerk=1 then begin
  if WSAStartup($0101, WSAData) <> 0 then exit;
  GetHostName(Buffer,Sizeof(Buffer));
  phoste:=GetHostByName(buffer);
  if phoste = nil then ipaddress:='127.0.0.1'
  else ipaddress:=StrPas(inet_ntoa(PInAddr(phoste^.h_addr_list^)^));
  WSACleanup;

  Size := 0;
  if GetIfTable(nil, Size, True) <> ERROR_INSUFFICIENT_BUFFER then Exit;
  IntfTable := AllocMem(Size);
  try
    if GetIfTable(IntfTable, Size, True) = NO_ERROR then
    begin
      for I := 0 to IntfTable^.dwNumEntries - 1 do
      begin
        {$R-}MibRow := IntfTable.Table[I];{$R+}
        // Ignore everything except ethernet cards
        if MibRow.dwType <> MIB_IF_TYPE_ETHERNET then Continue;

        netadaptername[I]:=stripspaces(PChar(@MibRow.bDescr[0]));
        nettotaldown[I]:=MibRow.dwInOctets;
        nettotalup[I]:=MibRow.dwOutOctets;
        netunicastdown[I]:=MibRow.dwInUcastPkts;
        netunicastup[I]:=MibRow.dwOutUcastPkts;
        netnunicastDown[I]:=MibRow.dwInNUcastPkts;
        netnunicastUp[I]:=MibRow.dwOutNUcastPkts;
        netDiscardsDown[I]:=MibRow.dwInDiscards;
        netDiscardsUp[I]:=MibRow.dwOutDiscards;
        netErrorsDown[I]:=MibRow.dwInErrors;
        netErrorsUp[I]:=MibRow.dwOutErrors;
        netSpeedDownK[I]:=round((nettotaldown[I]-nettotaldownold[I])/1024*10)/10;
        netSpeedUpK[I]:=round((nettotalup[I]-nettotalupold[I])/1024*10)/10;
        netSpeedDownM[I]:=round((nettotaldown[I]-nettotaldownold[I])/1024/1024*10)/10;
        netSpeedUpM[I]:=round((nettotalup[I]-nettotalupold[I])/1024/1024*10)/10;
        nettotaldownold[I]:=nettotaldown[I];
        nettotalupold[I]:=nettotalup[I];
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
  letter:integer;
  letter2:array [67..90] of integer;
  x:integer;
  bestand:textfile;
  koez, hd, mbm, teller: Integer;
  regel:string;
  z, y: Integer;
  screenline: String;
  oviVersionInfo: TOSVERSIONINFO;

begin

  hd:=0;
  mbm:=0;
  koez:=0;

  for z:= 1 to 20 do begin
    for y:= 1 to 4 do begin
      if (config.screen[z][y].enabled) then begin
        screenline:=config.screen[z][y].text;
        if (pos('$Fan',screenline) <> 0) then mbm:=1;
        if (pos('$Volt',screenline) <> 0) then mbm:=1;
        if (pos('$Temp',screenline) <> 0) then mbm:=1;
        if (pos('$HD', screenline) <> 0) then hd:=1;
        if (pos('$Dnet', screenline) <> 0) then koez:=1;
      end;
    end;
  end;

oviVersionInfo.dwOSVersionInfoSize := SizeOf(oviVersionInfo);

if not GetVersionEx(oviVersionInfo) then
 raise Exception.Create('Can''t get the Windows version');

if (oviVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and
   (oviVersionInfo.dwMajorVersion >= 5) then begin
  STComputername:=system1Ex.Computername;
  STUsername:=system1Ex.Username;

  STMemfree:=system1Ex.availPhysmemory div (1024*1024);
  STMemTotal:=system1Ex.totalPhysmemory div (1024*1024);
  STPageTotal:=system1Ex.totalPageFile div (1024*1024);
  STPageFree:=system1Ex.AvailPageFile div (1024*1024);
end else begin
  STComputername:=system1.Computername;
  STUsername:=system1.Username;

  STMemfree:=system1.availPhysmemory div (1024 * 1024);
  STMemTotal:=system1.totalPhysmemory div (1024 * 1024);
  STPageTotal:=system1.totalPageFile div (1024 * 1024);
  STPageFree:=system1.AvailPageFile div (1024 * 1024);
end;   


// HD space!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
if hd=1 then begin
  for letter:= 67 to 90 do
    letter2[letter]:=0;
  for z:= 1 to 20 do begin
    for y:= 1 to 4 do begin
      screenline:=config.screen[z][y].text;
      while pos('$HD',screenline) <> 0 do begin
        try
          screenline:=copy(screenline,pos('$HD',screenline),length(screenline));
          letter2[ord(upcase(copy(screenline,pos('(',screenline)+1,1)[1]))]:=1;
          screenline:=stringreplace(screenline,'$HD','',[]);
        except
          screenline:=stringreplace(screenline,'$HD','',[]);
        end;
      end;
    end;
  end;
  for letter:= 67 to 90 do begin
    try
      if letter2[letter]=1 then begin
//        if (system1.diskindrive(chr(letter),true)) then begin
          STHDFree[letter]:=system1.diskfreespace(chr(letter)) div (1024*1024);
          STHDTotal[letter]:=system1.disktotalspace(chr(letter)) div (1024*1024);
//        end;
      end;
    except
    end;
  end;
end;

//cputype!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
try
  STCPUType:=cxCpu[0].Name.AsString;
except
  on E: Exception do STCPUType:='[CPUType: '+E.Message+']';
end;

//SCREENRESO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
screenResolution:=IntToStr(Screen.DesktopWidth)+'x'+IntToStr(Screen.DesktopHeight);

//MBM5!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if mbm=1 then begin
  if (ReadMBM5Data) then mbmactive:=true
                    else mbmactive:=false;
end;

//koetje!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
if koez=1 then begin
  x:=0;
  koeregel:='file not found';
  if FileExists(config.distLog)=true then begin
    assignfile(bestand,config.distLog);
    reset (bestand);
    while not eof(bestand) do begin
      readln (bestand);
      x:=x+1;
    end;
    reset(bestand);
    for teller:=1 to x-50 do begin
      readln(bestand);
    end;
    while not eof(bestand) do begin
      readln(bestand,regel);
      koeregel:=koeregel+' '+regel;
    end;
    closefile(bestand);
  end;
  koeregel:=copy(koeregel,pos('Completed',koeregel)-5,length(koeregel));
  for x:= 1 to 9 do begin
    if pos('Completed', koeregel) <> 0 then begin
      koeregel:=copy(koeregel,pos('Completed',koeregel)-5,length(koeregel));
      koeregel:=StringReplace(koeregel,'Completed','-',[]);
    end;
  end;

  if copy(koeregel,1,3) = 'RC5' then begin
    koeregel1:=copy(koeregel,pos('- [',koeregel)+3,pos(' keys',koeregel)-pos('- [',koeregel));
    if length(koeregel1) > 7 then begin
      koeregel1:=copy(koeregel1,1,pos(',',copy(koeregel1,3,length(koeregel1)))+1);
    end;
    koeregel:=copy(koeregel,pos('completion',koeregel)+30,200);
    koeregel2:=copy(koeregel,pos('(',koeregel)+1,pos('.',koeregel)-pos('(',koeregel)-1);
  end;

  if copy(koeregel,1,3) = 'OGR' then begin
    koeregel1:=copy(koeregel,pos('- [',koeregel)+3,pos(' nodes',koeregel)-pos('- [',koeregel));
    if length(koeregel1) > 7 then begin
      koeregel1:=copy(koeregel1,1,pos(',',copy(koeregel1,3,length(koeregel1)))+1);
    end;
    koeregel:=copy(koeregel,pos('remain',koeregel)+8,100);
    koeregel2:=copy(koeregel,pos('(',koeregel)+1, pos('stats',koeregel)-pos('(',koeregel)-3);
  end;
end;
end;

// Download URL and return file location.
// Just return cached file if newer than maxfreq minutes.
function TData.getUrl(Url: String; maxfreq: Cardinal=0): String;
var
  HTTP: TIdHTTP;
  sl: TStringList;
  Filename: String;
  lasttime: TDateTime;
  toonew: Boolean;

begin
  // Generate a filename for the cached Rss stream.
  Filename:=LowerCase(Url);
  Filename:=StringReplace(Filename,'\\','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,':','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'/','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'"','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'|','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'<','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'>','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'&','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'?','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'=','_',[rfReplaceAll]);
  Filename:=StringReplace(Filename,'.','_',[rfReplaceAll]);
  Filename:='cache\\'+Filename+'.cache';

  try
    toonew:=false;
    sl:=TStringList.create;
    HTTP:= TIdHTTP.Create(nil);

    try
      // Only fetch new data if it's newer than the cache files' date.
      // and if it's older than maxfreq hours.
      if FileExists(Filename) then begin
        lasttime:=FileDateToDateTime(FileAge(Filename));
        if (MinutesBetween(Now, lasttime) < maxfreq) then toonew:=true;
        HTTP.Request.LastModified := lasttime;
      end;

      if (not toonew) then begin
        HTTP.HandleRedirects := True;
        if (config.httpProxy<>'') and (config.httpProxyPort<>0) then begin
          HTTP.ProxyParams.ProxyServer:=config.httpProxy;
          HTTP.ProxyParams.ProxyPort:=config.httpProxyPort;
        end;
        sl.Text:=HTTP.Get(Url);
        sl.savetofile(Filename);
      end;
    finally
      sl.Free;
      HTTP.Free;
    end;
  except
  end;

  // Even if we fail to download - give the filename so they can use the old data.
  Result:=filename;
end;


function TData.getRss(Url: String;var titles, descs: array of string; maxitems:Cardinal; maxfreq:Cardinal=0): Cardinal;
var
  StartItemNode : IXMLNode;
  ANode : IXMLNode;
  XMLDoc : IXMLDocument;
  items: Cardinal;
  rssFilename: String;

begin
  items:=0;

  //
  // Fetch the Rss data
  //

  // Use newRefresh as a maxfreq if none given - this is mostly in case
  // the application is stopped and started quickly.
  if (maxfreq=0) then maxfreq:=config.newsRefresh;
  RssFileName:=getUrl(Url, maxfreq);


  // Parse the Xml data
  try
    if FileExists(RssFilename) then begin
      XMLDoc := LoadXMLDocument(RssFilename);
      //XMLDoc.Options  := [doNodeAutoCreate,  doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl];
      //XMLDoc.FileName := 'bbc.xml';
      //XMLDoc.Active:=True;

      StartItemNode:=XMLDoc.DocumentElement.ChildNodes.First.ChildNodes.FindNode('item');
      ANode := StartItemNode;

      repeat
        Inc(items);
        titles[items]:=stripHtml(ANode.ChildNodes['title'].Text);
        descs[items]:=stripHtml(ANode.ChildNodes['description'].Text);
        ANode := ANode.NextSibling;
      until (ANode = nil) or (items >= maxItems);
    end;
  except
    on E: Exception do begin
      items:=0;
      titles[0]:='[Rss: '+E.Message+']';
      descs[0]:='[Rss: '+E.Message+']';
    end;
  end;

  Result:=items;
end;

function TData.fileToString(filename: String): String;
var
  sl: TStringList;
begin
  sl:=TStringList.Create;
  try
    try
      sl.LoadFromFile(filename);
      Result:=sl.Text;
    except
      on E: Exception do Result:='[Exception: '+E.Message+']';
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
  FileName:=getUrl('http://setiathome2.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=user_xml&email=' + config.setiEmail, 12*60);

  // Parse the Xml data
  try
    if FileExists(Filename) then begin
      XMLDoc := LoadXMLDocument(Filename);

      StartItemNode:=XMLDoc.DocumentElement.ChildNodes.FindNode('userinfo');
      ANode := StartItemNode;

      setiNumResults:=ANode.ChildNodes['numresults'].Text;
      setiCpuTime:=ANode.ChildNodes['cputime'].Text;
      setiAvgCpu:=ANode.ChildNodes['avecpu'].Text;
      setiLastResult:=ANode.ChildNodes['lastresulttime'].Text;
      setiUserTime:=ANode.ChildNodes['usertime'].Text;
      // not used: 'regdate'

      // not used: group info.

      StartItemNode:=XMLDoc.DocumentElement.ChildNodes.FindNode('rankinfo');
      ANode := StartItemNode;

      setiTotalUsers:=ANode.ChildNodes['ranktotalusers'].Text;
      setiRank:=ANode.ChildNodes['rank'].Text;
      setiShareRank:=ANode.ChildNodes['num_samerank'].Text;
      setiMoreWU:=FloatToStr(100-StrToFloat(ANode.ChildNodes['top_rankpct'].Text));
    end;
  except
    on E: Exception do begin
      setiNumResults:='[Seti: '+E.Message+']';
      setiCpuTime:='[Seti: '+E.Message+']';
      setiAvgCpu:='[Seti: '+E.Message+']';
      setiLastResult:='[Seti: '+E.Message+']';
      setiUserTime:='[Seti: '+E.Message+']';
      setiTotalUsers:='[Seti: '+E.Message+']';
      setiRank:='[Seti: '+E.Message+']';
      setiShareRank:='[Seti: '+E.Message+']';
      setiMoreWU:='[Seti: '+E.Message+']';
    end;
  end;
end;


function stripspaces(Fstring:string): string;
begin
  FString:=StringReplace(FString,chr(10),'',[rfReplaceAll]);
  FString:=StringReplace(FString,chr(13),'',[rfReplaceAll]);
  FString:=StringReplace(FString,chr(9),' ',[rfReplaceAll]);

  while copy(fstring,1,1) = ' ' do begin
    fstring:=copy(fstring,2,length(fstring));
  end;
  while copy(fstring,length(fstring),1) = ' ' do begin
    fstring:=copy(fstring,1,length(fstring)-1);
  end;

  result:=fstring;
end;




procedure TData.UpdateHTTP;
begin
  doHTTPUpdate:=True;
end;

procedure TData.UpdateGameStats;
begin
  doGameUpdate:=True;
end;

procedure TData.UpdateEmail;
begin
  doEmailUpdate:=True;
end;

// Runs in data thread
procedure TData.doDataThread;
begin
  coinitialize(nil);

  while (not dataThread.Terminated) do begin
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
  tempregel,tempregel2,tempregel4,regel:string;
  tempregel1:array [1..80] of String;
  teller,teller2:integer;
  bestand2:textfile;
  z, y:Integer;
  screenline: String;

begin
  doGameUpdate:=False;

  for z:=1 to 20 do begin
    for y:=1 to 4 do begin
      try
        screenline:=config.screen[z][y].text;
        if (config.screen[z][y].enabled) and
                  ((pos('$Unreal', screenline) <> 0) or
                  (pos('$QuakeIII', screenline) <> 0) or
                  (pos('$QuakeII', screenline) <> 0) or
                  (pos('$Half-life', screenline) <> 0)) then
        begin

          if (dataThread.Terminated) then Exit;

          if pos('$Half-life', screenline) <> 0 then srvr:='-hls';
          if pos('$QuakeII', screenline) <> 0 then srvr:='-q2s';
          if pos('$QuakeIII', screenline) <> 0 then srvr:='-q3s';
          if pos('$Unreal', screenline) <> 0 then srvr:='-uns';
          winexec(PChar(extractfilepath(application.exename) + 'qstat.exe -P -of txt'+intToStr(z)+'-'+intToStr(y)+'.txt -sort F '+ srvr +' '+ config.gameServer[z,y]),sw_hide);

          tempregel:='';
          sleep(1000);

          assignfile (bestand2,extractfilepath(application.exename)+'txt'+IntToStr(z)+'-'+IntToStr(y)+'.txt');
          try
            reset (bestand2);
            teller:=1;
            while (not eof(bestand2)) and (teller<80) do begin
              readln (bestand2, tempregel1[teller]);
              teller:=teller+1;
            end;
          finally
            closefile(bestand2);
          end;

          if (pos('$Unreal1', screenline) <> 0) or
               (pos('$QuakeIII1', screenline) <> 0) or
               (pos('$QuakeII1', screenline) <> 0) or
               (pos('$Half-life1', screenline) <> 0) then
          begin
            qstatreg1[z,y]:=copy(tempregel1[2],pos(' / ',tempregel1[2])+3,length(tempregel1[2]));
            qstatreg1[z,y]:=stripspaces(copy(qstatreg1[z,y],pos(' ',qstatreg1[z,y])+1,length(qstatreg1[z,y])));
          end;

          if (pos('$Unreal2', screenline) <> 0) or
                (pos('$QuakeIII2', screenline) <> 0) or
                (pos('$QuakeII2', screenline) <> 0) or
                (pos('$Half-life2', screenline) <> 0) then
          begin
            qstatreg2[z,y]:=copy(tempregel1[2],pos(':',tempregel1[2]),length(tempregel1[2]));
            qstatreg2[z,y]:=copy(qstatreg2[z,y],pos('/',qstatreg2[z,y])+4,length(qstatreg2[z,y]));
            qstatreg2[z,y]:=copy(qstatreg2[z,y],1,pos('/',qstatreg2[z,y])-5);
            qstatreg2[z,y]:=stripspaces(copy(qstatreg2[z,y],pos(' ',qstatreg2[z,y])+1,length(qstatreg2[z,y])));
          end;

          if (pos('$Unreal3', screenline) <> 0) or
              (pos('$QuakeIII3', screenline) <> 0) or
              (pos('$QuakeII3', screenline) <> 0) or
              (pos('$Half-life3', screenline) <> 0) then
          begin
            qstatreg3[z,y]:=stripspaces(copy(tempregel1[2],pos(' ',tempregel1[2]),length(tempregel1[2])));
            qstatreg3[z,y]:=stripspaces(copy(qstatreg3[z,y],1,pos('/',qstatreg3[z,y])+3));
          end;

          if (pos('$Unreal4', screenline) <> 0) or
              (pos('$QuakeIII4', screenline) <> 0) or
              (pos('$QuakeII4', screenline) <> 0) or
              (pos('$Half-life4', screenline) <> 0) then
          begin
            qstatreg4[z,y]:='';
            for teller2:=1 to teller-3 do begin
              regel:=stripspaces(tempregel1[teller2+2]);
              tempregel2:=stripspaces(copy(copy(regel,pos('s ', regel)+1,length(regel)),pos('s ', regel)+2,length(regel)));
              tempregel4:=stripspaces(copy(regel,2,pos(' frags ',regel)-1));
              regel:=tempregel2 + ': '+ tempregel4 + ', ';
              qstatreg4[z,y]:=qstatreg4[z,y]+regel;
            end;
          end;
        end;
      except
        on E: Exception do begin
          qstatreg1[z,y]:='[Exception: '+E.Message+']';
          qstatreg2[z,y]:='[Exception: '+E.Message+']';
          qstatreg3[z,y]:='[Exception: '+E.Message+']';
          qstatreg4[z,y]:='[Exception: '+E.Message+']';
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
  screenline:String;
  z,y: Integer;
  args: array [1..maxArgs] of String;
  prefix: String;
  postfix: String;
  numargs: Cardinal;
  myRssCount: Cardinal;
  updateNeeded: Boolean;
begin
  doHTTPUpdate:=False;

  for y:= 1 to 9 do
    newsAttempts[y]:=0;

  // TODO: this should only be done when the config changes...
  myRssCount:=0;
  DoNewsUpdate[6]:=config.checkUpdates;;
  for z:= 1 to 20 do begin
    for y:= 1 to 4 do begin
      if (config.screen[z][y].enabled) then begin
        screenline:=config.screen[z][y].text;
        while decodeArgs(screenline, '$Rss', maxArgs, args, prefix, postfix, numargs) do begin
          Inc(myRssCount);
          if (rss[myRssCount].url <> args[1]) then begin
            rss[myRssCount].url := args[1];
            rss[myRssCount].whole:='';
            rss[myRssCount].items:=0;
          end;
          if (numargs>=4) then rss[myRssCount].maxfreq := StrToInt(args[4])*60;
          screenline:=prefix+postfix;
        end;
        if (pos('$SETI',screenline) <> 0) then DoNewsUpdate[7]:=true;
        if (pos('$FOLD',screenline) <> 0) then DoNewsUpdate[9]:=true;
      end;
    end;
  end;
  rssEntries:=myRssCount;
  if (myRssCount>0) then  DoNewsUpdate[1]:=true;

  updateNeeded:=False;
  for y:=1 to 9 do begin
    if (donewsupdate[y]) then updateNeeded := true;
  end;
  if (updateNeeded) then fetchHTTPUpdates;
end;

// Runs in data thread
procedure TData.fetchHTTPUpdates;
var
  teller,teller2:integer;
  versionregel: String;
  titles, descs, whole: String;
  filename: String;
  tempstr, tempstr2: String;

begin
  if DoNewsUpdate[1] then begin
    DoNewsUpdate[1]:=False;

    for teller:=1 to rssEntries do begin
      if (rss[teller].url <> '') then begin
        if (dataThread.Terminated) then Exit;

        rss[teller].items := getRss(rss[teller].url, rss[teller].title,
                                  rss[teller].desc, maxRssItems, rss[teller].maxfreq);
        titles:=''; descs:=''; whole:='';
        for teller2:=1 to rss[teller].items do begin
          titles:=titles+rss[teller].title[teller2]+' | ';
          descs:=descs+rss[teller].desc[teller2]+' | ';
          whole:=whole+rss[teller].title[teller2]+': '+rss[teller].desc[teller2]+' | ';

          if (dataThread.Terminated) then Exit;
        end;
        rss[teller].whole:=whole;
        rss[teller].title[0]:=titles;
        rss[teller].desc[0]:=descs;
      end;
    end;
  end;


  if (DoNewsUpdate[6]) then begin
    DoNewsUpdate[6]:=False;
    if (config.checkUpdates) then begin
      if (dataThread.Terminated) then Exit;
      try
        filename:=getUrl('http://lcdsmartie.sourceforge.net/version.txt', 96*60);
        versionregel:=fileToString(filename);
      except
        versionregel:='';
      end;
      versionregel:=StringReplace(versionregel,chr(10),'',[rfReplaceAll]);
      versionregel:=StringReplace(versionregel,chr(13),'',[rfReplaceAll]);
      if copy(versionregel,1,1) = '5' then
        isconnected:=true;
      if (length(versionregel) < 72) and (copy(versionregel,1,7) <> '5.3.0.1') and (versionregel <> '') then begin
        if (lcdSmartieUpdateText<>copy(versionregel,8,62)) then begin
          lcdSmartieUpdateText:=copy(versionregel,8,62);
          lcdSmartieUpdate:=True;
        end;
      end;
    end;
  end;

  if DoNewsUpdate[7] then begin
    DoNewsUpdate[7]:=False;
    if (dataThread.Terminated) then Exit;
    doSeti();
  end;

  if DoNewsUpdate[9] then begin
    DoNewsUpdate[9]:=False;
    if (dataThread.Terminated) then Exit;

    try
      filename:=getUrl('http://vspx27.stanford.edu/cgi-bin/main.py?qtype=userpage&username='+config.foldUsername, config.newsRefresh);
      tempstr:=fileToString(filename);

      tempstr:=StringReplace(tempstr,'&amp','&',[rfReplaceAll]);
      tempstr:=StringReplace(tempstr,chr(10),'',[rfReplaceAll]);
      tempstr:=StringReplace(tempstr,chr(13),'',[rfReplaceAll]);

      foldMemSince:='[FOLDmemsince: not supported]';

      tempstr2:=copy(tempstr,pos('Date of last work unit', tempstr)+22, 500);
      tempstr2:=copy(tempstr2,1,pos('</TR>',tempstr2)-1);
      foldLastWU:=stripspaces(stripHtml(tempstr2));

      tempstr2:=copy(tempstr,pos('Total score', tempstr)+11, 100);
      tempstr2:=copy(tempstr2,1,pos('</TR>',tempstr2)-1);
      foldScore:=stripspaces(stripHtml(tempstr2));

      tempstr2:=copy(tempstr,pos('Overall rank (if points are combined)', tempstr)+37, 100);
      tempstr2:=copy(tempstr2,1,pos('of',tempstr2)-1);
      foldRank:=stripspaces(stripHtml(tempstr2));

      tempstr2:=copy(tempstr,pos('Active processors (within 7 days)', tempstr)+33, 100);
      tempstr2:=copy(tempstr2,1,pos('</TR>',tempstr2)-1);
      foldActProcsWeek:=stripspaces(stripHtml(tempstr2));

      tempstr2:=copy(tempstr,pos('Team', tempstr)+4, 500);
      tempstr2:=copy(tempstr2,1,pos('</TR>',tempstr2)-1);
      foldTeam:=stripspaces(stripHtml(foldTeam));

      tempstr2:=copy(tempstr,pos('WU', tempstr)+2, 500);
      tempstr2:=copy(tempstr2,1,pos('</TR>',tempstr2)-1);
      if (pos('(', tempstr2)<>0) then tempstr2:=copy(tempstr2,1,pos('(',tempstr2)-1);
      foldWU:=stripspaces(stripHtml(tempstr2));

    except
      on E: Exception do begin
        if newsAttempts[9]<4 then begin
          newsAttempts[9]:=newsAttempts[9]+1;
          DoNewsUpdate[9]:=True;
        end else begin
          foldMemSince:='[fold: '+E.Message+']';
          foldLastWU:='[fold: '+E.Message+']';
          foldActProcsWeek:='[fold: '+E.Message+']';
          foldTeam:='[fold: '+E.Message+']';
          foldScore:='[fold: '+E.Message+']';
          foldRank:='[fold: '+E.Message+']';
          foldWU:='[fold: '+E.Message+']';
        end;
      end;
    end;
  end;
end;

// Runs in data thread
procedure TData.emailUpdate;
var
  mailz: array[0..9] of integer;
  z, y, x: Integer;
  screenline: String;
  pop3: TIdPOP3;
  msg: TIdMessage;
  myGotEmail: Boolean;

begin
  doEmailUpdate:=False;

  for y:= 0 to 9 do mailz[y]:=0;

  for z:= 1 to 20 do begin
    for y:= 1 to 4 do begin
      if (config.screen[z][y].enabled) then begin
        screenline:=config.screen[z][y].text;
        for x:=0 to 9 do begin
          if (pos('$Email'+IntToStr(x),screenline) <> 0) then mailz[x]:=1;
          if (pos('$EmailSub'+IntToStr(x),screenline) <> 0) then mailz[x]:=1;
          if (pos('$EmailFrom'+IntToStr(x),screenline) <> 0) then mailz[x]:=1;
        end;
      end;
    end;
  end;

  myGotEmail:=False;

  for y:=0 to 9 do begin
    if mailz[y]=1 then begin
      if (dataThread.Terminated) then Exit;
      try
          pop3:=TIdPOP3.Create(nil);
          msg:=TIdMessage.Create(nil);
        try
          pop3.MaxLineAction  := maSplit;
          pop3.ReadTimeout := 10000; //10 seconds
          pop3.host:=config.pop[y].server;
          pop3.username:=config.pop[y].user;
          pop3.Password:=config.pop[y].pword;

          pop3.Connect(30000); // 30 seconds

          mail[y].messages :=pop3.CheckMessages;

          if (mail[y].messages>0) and (pop3.RetrieveHeader(mail[y].messages,msg)) then begin
            mail[y].lastSubject:=msg.Subject;
            mail[y].lastFrom:=msg.From.Name;
          end else begin
            mail[y].lastSubject:='[none]';
            mail[y].lastFrom:='[none]';
          end;

        finally
          pop3.Disconnect;
          pop3.Free;
          msg.Free;
        end;

        if (mail[y].messages>0) then myGotEmail:= true;
      except
        on E: Exception do begin
          mail[y].messages:=0;
          mail[y].lastSubject :='[email: '+E.Message+']';
          mail[y].lastFrom :='[email: '+E.Message+']';
        end;
      end;
    end;
  end;

  gotEmail:=myGotEmail;
end;


end.
