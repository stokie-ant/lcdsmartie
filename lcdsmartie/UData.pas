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
 *  $Revision: 1.1 $ $Date: 2004/11/11 22:48:33 $
 *****************************************************************************}


interface

uses Classes, System2, xmldom, XMLIntf, SysUtils, xercesxmldom, XMLDoc,
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
      qstattemp: integer;
      mbmactive:boolean;
      dllcancheck: Boolean;
      isconnected: Boolean;
      gotEmail: Boolean;
      function change(regel:string):string;
      procedure checkEmails;
      procedure updateGameStats(Sender: TObject);
      procedure refres(Sender: TObject);
      procedure updateNetworkStats(Sender: TObject);
      procedure checkIfNewsUpdatesRequired;
      procedure updateMBMStats(Sender: TObject);
      constructor Create;
      destructor Destory;
    private
      STUsername, STComputername, STCPUType, STCPUSpeed: string;
      STPageFree,STPageTotal:Integer;
      STMemFree, STMemTotal: Integer;
      STHDFree,STHDTotal:array[67..90] of Integer;
      CPUUsage: array [1..5] of Cardinal;
      CPUUsageCount: Cardinal;
      CPUUsagePos: Cardinal;
      STCPUUsage: Cardinal;
      lastCpuUpdate: LongWord;
      pop3Thread, HTTPThread: TMyThread;
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
      qstatreg4: array[1..20,1..4] of string;
      HTTPthreadisrunning: Boolean;
      DoNewsUpdate: Array [1..9] of Boolean;
      newsAttempts: Array [1..9] of Byte;
      CNNregel,aexregel,techregel,weerregel,tnetregel,timeregel: String;
      pop3threadisrunning: Boolean;
      mailregel: Array [0..9] of Cardinal;
      setireg1,setireg2,setireg3,setireg4,setireg5,setireg6,setireg7,setireg8,setireg9:string;
      foldreg1, foldreg2, foldreg3, foldreg4, foldreg5, foldreg6, foldreg7:string;
      locationnumber: String;
      weather2: String;
      rss: Array [1..maxRss] of TRss;
      rssEntries: Cardinal;
      function ReadMBM5Data : Boolean;
      function GetCpuSpeedRegistry(proc: Byte): string;
      procedure checkHTTPUpdates;
      procedure checkEmailUpdates;
      function getRss(Url: String;var titles, descs: array of string; maxitems:Cardinal; maxfreq:Cardinal=0): Cardinal;
      function decodeArgs(str: String; funcName: String; maxargs: Cardinal;
         var args: array of String; var prefix: String; var postfix: String; var numArgs:Cardinal):Boolean;
      function changeWinamp(regel: String):String;
      function changeNet(regel: String):String;
  end;

  function stripspaces(Fstring:string): string;



implementation

uses cxCpu40, adCpuUsage, UMain, Windows, Forms, Registry,
      IpHlpApi,  IpIfConst, IpRtrMib, WinSock, Dialogs, Buttons,
      Graphics,  ShellAPI, mmsystem,  ExtActns,
      Messages, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection,
      IdTCPClient, IdMessageClient, IdPOP3, Menus, ExtCtrls, Controls, StdCtrls,
      StrUtils, ActiveX, IdUri, DateUtils ;

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
  inherited Create(false);
end;

procedure TMyThread.Execute;
begin
  try
    method();
  except
  end;
end;

constructor TData.Create;
begin
  inherited;

  qstattemp:=1;
  CPUUsagePos:=1;
  isconnected:=false;
  totaldlls:=0;
  distributedlog:=config.distLog;

  // Get CPU speed once:
  STCPUSpeed:=GetCpuSpeedRegistry(0);
  if (STCPUSpeed='') then STCPUSpeed:=cxCpu[0].Speed.Normalised.FormatMhz;

  checkIfNewsUpdatesRequired();
end;

destructor TData.Destory;
begin
  if HTTPthreadisrunning=true then begin
    try
      assert(Assigned(HTTPThread));
      HTTPThread.Terminate;
      HTTPThread.WaitFor;
      HTTPThread.Destroy;
    except
    end;
  end;
  if pop3threadisrunning=true then  begin
    try
      assert(Assigned(pop3thread));
      pop3thread.Terminate;
      pop3thread.WaitFor;
      pop3thread.Destroy;
    except
    end;
  end;
  inherited;
end;


procedure TData.checkEmails;
begin
  if pop3threadisrunning=false then begin
    if Assigned(pop3Thread) then begin
      try
        pop3Thread.WaitFor;
        pop3Thread.Destroy;
      except
      end;
    end;
    pop3Thread:= TMyThread.Create(self.checkEmailUpdates);
  end;
end;

function TData.changeWinamp(regel: String):String;
var
  tempstr: String;
  p: Cardinal;
  barLength: Cardinal;
  barPosition: Integer;
  trackLength, trackPosition, t: Integer;
  i: Integer;
  m, h, s: Integer;

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
    while pos('$WinampPosition(',regel) <> 0 do begin
      try
        p:=pos('$WinampPosition(',regel)+16;
        tempstr:=copy(regel,p,length(regel));
        barlength:=strtoint(copy(tempstr,1,pos(')',tempstr)-1));

        barPosition:=round(((trackPosition / 1000)*barLength) /trackLength);
        tempstr:='';

        for i:=1 to barPosition-1 do tempstr:=tempstr+ '-';
        tempstr:=tempstr+ '+';
        for i:=barPosition+1 to barlength do tempstr:=tempstr+ '-';
        tempstr:=copy(tempstr,1,barlength);
        regel:=StringReplace(regel,'$WinampPosition('+inttostr(barlength)+')', tempstr,[]);
      except
        regel:=StringReplace(regel,'$WinampPosition(','error',[]);
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
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+netadaptername[adapterNum]+postfix;
      except
        regel:=prefix+'[Error:NetAdapter]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDownK', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotaldown[adapterNum]/1024*10)/10)+postfix;
      except
        regel:=prefix+'[Error:NetDownK]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUpK', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotalup[adapterNum]/1024*10)/10)+postfix;
      except
        regel:=prefix+'[Error:NetUpK]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDownM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotaldown[adapterNum]/1024/1024*10)/10)+postfix;
      except
        regel:=prefix+'[Error:NetDownM]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUpM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotalup[adapterNum]/1024/1024*10)/10)+postfix;
      except
        regel:=prefix+'[Error:NetUpM]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDownG', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotaldown[adapterNum]/1024/1024/1024*10)/10)+postfix;
      except
        regel:=prefix+'[Error:NetDownG]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUpG', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+floatToStr(Round(nettotalup[adapterNum]/1024/1024/1024*10)/10)+postfix;
      except
        regel:=prefix+'[Error:NetUpG]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetErrDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netErrorsDown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetErrDown]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetErrUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netErrorsUp[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetErrUp]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetErrTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netErrorsDown[adapterNum]+netErrorsUp[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetErrTot]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUniDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netunicastdown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetUniDown]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUniUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netunicastup[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetUniUp]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetUniTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netunicastup[adapterNum]+netunicastdown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetUniTot]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetNuniDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastdown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetNuniDown]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetNuniUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastup[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetNuniUp]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetNuniTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastup[adapterNum]+netnunicastdown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetNuniTot]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetPackTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
         adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netnunicastup[adapterNum]+netnunicastdown[adapterNum]+netunicastdown[adapterNum]+netunicastup[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetPackTot]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDiscDown', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netDiscardsdown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetDiscDown]'+postfix;
      end;
    end;
    while decodeArgs(regel, '$NetDiscUp', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netDiscardsup[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetDiscUp]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetDiscTot', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netDiscardsup[adapterNum]+netDiscardsdown[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetDiscTot]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpDownK', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeeddownK[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetSpDownK]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpUpK', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeedupK[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetSpUpK]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpDownM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeeddownM[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetSpDownM]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$NetSpUpM', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        adapterNum:=StrToInt(args[1]);
        regel:=prefix+FloatToStr(netSpeedupM[adapterNum])+postfix;
      except
        regel:=prefix+'[Error:NetSpUpM]'+postfix;
      end;
    end;

  Result:=regel;
end;



function TData.change(regel:string):string;
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
  tempst,fileline,fileloc,spaceline, regel2,regel3:string;
  bestand3:textfile;
  ccount:double;
  hdteller:integer;
  args: Array [1..maxArgs] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  jj: Cardinal;
  found: Boolean;

begin
    hdteller:=0;
    while pos('$LogFile("',regel) <> 0 do begin
      hdteller:=hdteller+1;
      if hdteller>4 then regel:=StringReplace(regel,'$LogFile("','error', []);

      try
        spaceline:=copy(regel, pos('$LogFile("',regel)+10,length(regel));
        fileloc:=copy(spaceline, 1,pos('"',spaceline)-1);
        fileline:=copy(spaceline,pos('",',spaceline)+2,pos(')',spaceline)-pos('",',spaceline)-2);
        if fileline > '3' then fileline:='3';
        if fileline < '0' then fileline:='0';
        try
          SetLength(spaceline, 1024);
          FileStream:= TFileStream.Create(fileloc, fmOpenRead or fmShareDenyNone);
          FileStream.Seek(-1 * 1024, soFromEnd);
          FileStream.ReadBuffer(spaceline[1], 1024);
          FileStream.Free;

          Lines:= TStringList.Create;
          Lines.Text:= spaceline;
          spaceline:=stripspaces(lines[lines.count-1-strtoint(fileline)]);
          spaceline:=copy(spaceline, pos('] ',spaceline)+3,length(spaceline));
          for i:=0 to 7 do spaceline:=StringReplace(spaceline, chr(I),'',[rfReplaceAll]);
          Lines.Free;
          regel:=StringReplace(regel,'$LogFile("' + fileloc + '",' + fileline + ')',spaceline, []);
        except
          regel:=StringReplace(regel,'$LogFile("','error', []);
        end;
      except
        regel:=StringReplace(regel,'$LogFile("','error', []);
      end;
    end;

    while pos('$File("',regel) <> 0 do begin
      spaceline:=copy(regel, pos('$File("',regel)+7,length(regel));
      fileloc:=copy(spaceline, 1,pos('"',spaceline)-1);
      fileline:=copy(spaceline,pos('",',spaceline)+2,pos(')',spaceline)-pos('",',spaceline)-2);

      try
        assignfile(bestand3, fileloc);
        reset(bestand3);
        for teller3:= 1 to StrToInt(fileline) do
       readln(bestand3, regel3);
        closefile(bestand3);
        regel:=StringReplace(regel,'$File("' + fileloc + '",' + fileline + ')',regel3, []);
      except
        regel:=StringReplace(regel,fileloc,'', []);
        regel:=StringReplace(regel,'$File("','', []);
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
      regel:=StringReplace(regel,'$Tempname1',TempName[1],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname2',TempName[2],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname3',TempName[3],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname4',TempName[4],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname5',TempName[5],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname6',TempName[6],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname7',TempName[7],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname8',TempName[8],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname9',TempName[9],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Tempname10',TempName[10],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp1',FloatToStr(Temperature[1]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp2',FloatToStr(Temperature[2]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp3',FloatToStr(Temperature[3]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp4',FloatToStr(Temperature[4]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp5',FloatToStr(Temperature[5]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp6',FloatToStr(Temperature[6]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp7',FloatToStr(Temperature[7]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp8',FloatToStr(Temperature[8]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp9',FloatToStr(Temperature[9]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Temp10',FloatToStr(Temperature[10]),[rfReplaceAll]);
    end;
    if (pos('$Fan', regel)<>0) then begin
      regel:=StringReplace(regel,'$Fanname1',Fanname[1],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname2',Fanname[2],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname3',Fanname[3],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname4',Fanname[4],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname5',Fanname[5],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname6',Fanname[6],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname7',Fanname[7],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname8',Fanname[8],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname9',Fanname[9],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Fanname10',Fanname[10],[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS1',FloatToStr(Fan[1]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS2',FloatToStr(Fan[2]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS3',FloatToStr(Fan[3]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS4',FloatToStr(Fan[4]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS5',FloatToStr(Fan[5]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS6',FloatToStr(Fan[6]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS7',FloatToStr(Fan[7]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS8',FloatToStr(Fan[8]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS9',FloatToStr(Fan[9]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$FanS10',FloatToStr(Fan[10]),[rfReplaceAll]);
    end;

    if (pos('$Volt', regel)<>0) then begin
      regel:=StringReplace(regel,'$Voltname1',Voltname[1],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname2',Voltname[2],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname3',Voltname[3],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname4',Voltname[4],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname5',Voltname[5],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname6',Voltname[6],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname7',Voltname[7],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname8',Voltname[8],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname9',Voltname[9],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltname10',Voltname[10],[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage1',FloatToStr(Voltage[1]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage2',FloatToStr(Voltage[2]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage3',FloatToStr(Voltage[3]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage4',FloatToStr(Voltage[4]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage5',FloatToStr(Voltage[5]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage6',FloatToStr(Voltage[6]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage7',FloatToStr(Voltage[7]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage8',FloatToStr(Voltage[8]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage9',FloatToStr(Voltage[9]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Voltage10',FloatToStr(Voltage[10]),[rfReplaceAll]);
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

    regel:=StringReplace(regel,'$CNN',CNNregel,[rfReplaceAll]);
    regel:=StringReplace(regel,'$Stocks',aexregel,[rfReplaceAll]);
    regel:=StringReplace(regel,'$TomsHW',techregel,[rfReplaceAll]);
    regel:=StringReplace(regel,'$T.netHL',tnetregel,[rfReplaceAll]);
    regel:=StringReplace(regel,'$DutchWeather',weerregel,[rfReplaceAll]);
    regel:=StringReplace(regel,'$Weather.com('+locationnumber+')',weather2,[rfReplaceAll]);

    if (pos('$Email', regel) <> 0) then begin
      regel:=StringReplace(regel,'$Email0',IntToStr(mailregel[0]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email1',IntToStr(mailregel[1]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email2',IntToStr(mailregel[2]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email3',IntToStr(mailregel[3]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email4',IntToStr(mailregel[4]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email5',IntToStr(mailregel[5]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email6',IntToStr(mailregel[6]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email7',IntToStr(mailregel[7]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email8',IntToStr(mailregel[8]),[rfReplaceAll]);
      regel:=StringReplace(regel,'$Email9',IntToStr(mailregel[9]),[rfReplaceAll]);
    end;


    regel:=StringReplace(regel,'$DnetDone',koeregel2,[rfReplaceAll]);
    regel:=StringReplace(regel,'$DnetSpeed',koeregel1,[rfReplaceAll]);

    if (pos('$SETI',regel)<>0) then begin
      regel:=StringReplace(regel,'$SETIResults',setireg1,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETICPUTime',setireg2,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIAverage',setireg3,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETILastresult',setireg4,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIusertime',setireg5,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETItotalusers',setireg6,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIrank',setireg7,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETIsharingrank',setireg8,[rfReplaceAll]);
      regel:=StringReplace(regel,'$SETImoreWU',setireg9,[rfReplaceAll]);
    end;

    if (pos('$FOLD',regel)<>0) then begin
      regel:=StringReplace(regel,'$FOLDmemsince',foldreg1,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDlastwu',foldreg2,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDactproc',foldreg3,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDteam',foldreg4,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDscore',foldreg5,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDrank',foldreg6,[rfReplaceAll]);
      regel:=StringReplace(regel,'$FOLDwu',foldreg7,[rfReplaceAll]);
    end;


    while decodeArgs(regel, '$Time', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        timeregel:=formatdatetime(args[1],now);
        regel:=prefix+timeregel+postfix;
      except
        regel:=prefix+'[Error:Time]'+postfix;
      end;
    end;

    if (pos('$Net', regel)<>0) then regel:=changeNet(regel);


    if pos('$MemF%',regel) <> 0 then regel:=StringReplace(regel,'$MemF%', IntToStr(round(100/STMemTotal*STMemfree)),[rfReplaceAll]);
    if pos('$MemU%',regel) <> 0 then regel:=StringReplace(regel,'$MemU%', IntToStr(round(100/STMemTotal*(STMemTotal-STMemfree))),[rfReplaceAll]);

    if pos('$PageF%',regel) <> 0 then regel:=StringReplace(regel,'$PageF%', IntToStr(round(100/STPageTotal*STPagefree)),[rfReplaceAll]);
    if pos('$PageU%',regel) <> 0 then regel:=StringReplace(regel,'$PageU%', IntToStr(round(100/STPageTotal*(STPageTotal-STPagefree))),[rfReplaceAll]);

    while decodeArgs(regel, '$HDFreg', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(round(STHDFree[letter]/1024))+postfix;
      except
        regel:=prefix+'[Error:HDFreg]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDFree', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(STHDFree[letter])+postfix;
      except
        regel:=prefix+'[Error:HDFree]'+postfix;
      end;
    end;


    while decodeArgs(regel, '$HDUseg', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=IntToStr(round((STHDTotal[letter]-STHDFree[letter])/1024));
        regel:=prefix+regel2+postfix;
      except
        regel:=prefix+'[Error:HDUseg]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDUsed', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=IntToStr(round(STHDTotal[letter]-STHDFree[letter]));
        regel:=prefix+regel2+postfix;
      except
        regel:=prefix+'[Error:HDUsed]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDF%', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=intToStr(round(100/STHDTotal[letter]*STHDFree[letter]));
        regel:=prefix+regel2+postfix;
      except
        regel:=prefix+'[Error:HDF%]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDU%', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel2:=intToStr(round(100/STHDTotal[letter]*(STHDTotal[letter]-STHDFree[letter])));
        regel:=prefix+regel2+postfix;
      except
        regel:=prefix+'[Error:HDU%]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDTotag', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(round(STHDTotal[letter]/1024))+postfix;
      except
        regel:=prefix+'[Error:HDTotag]'+postfix;
      end;
    end;

    while decodeArgs(regel, '$HDTotal', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
      try
        letter:=ord(upcase(args[1][1]));
        regel:=prefix+IntToStr(STHDTotal[letter])+postfix;
      except
        regel:=prefix+'[Error:HDTotal]'+postfix;
      end;
    end;

    if decodeArgs(regel, '$MObutton', maxArgs, args, prefix, postfix, numargs) then begin
      assert(numargs=1);
      if UMain.kar=args[1] then spacecount:=1 else spacecount:=0;
      regel:=prefix+intToStr(spacecount)+postfix;
    end;

    if decodeArgs(regel, '$Chr', maxArgs, args, prefix, postfix, numargs) then begin
      assert(numargs=1);
      try
        regel:=prefix+Chr(StrToInt(args[1]))+postfix;
      except
        regel:=prefix+'[Error:Chr]'+postfix;
      end;
    end;

    while pos('$dll(',regel) <> 0 do begin
      try
        totaldlls:=totaldlls+1;
        if dllcancheck=true then begin
          try
            tempst:=copy(regel, pos('$dll(',regel),length(regel));
            tempst:=copy(tempst, pos('$dll(',tempst)+5,pos(',',tempst)-pos('$dll(',tempst)-5);
            if templib <> tempst then hlib:=LoadLibrary(pchar(extractfilepath(application.exename)+'plugins\'+tempst));
            templib:=tempst;

            tempst:=copy(regel, pos('$dll(',regel)+5,length(regel));
            tempst:=copy(tempst,pos(',',tempst)+1,length(tempst));

            nlib:=StrToInt(copy(tempst,1,1));
            tempst:=copy(tempst,3,length(tempst));
            plib:=copy(tempst,1,pos(',',tempst)-1);
            tlib:=copy(tempst,pos(',',tempst)+1,pos(')',tempst)-pos(',',tempst)-1);
            tempst:=copy(regel,pos('$dll(',regel),length(regel));
            tempst:=copy(tempst,1,pos(')',tempst));
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
          except end;
        end;
      finally
        tempst:=copy(regel,pos('$dll(',regel),length(regel));
        tempst:=copy(tempst,1,pos(')',tempst));
        try
          if pos('$dll(',tempst)<>0 then begin
            regel:=StringReplace(regel,tempst,dllsarray[totaldlls],[]);
          end;
        except
          regel:=StringReplace(regel,'$dll(',dllsarray[totaldlls],[]);
        end;
      end;
    end;

    hdteller:=0;
    while pos('$Count(',regel) <> 0 do begin
      ccount:=0;
      try
        hdteller:=hdteller+1;
        if hdteller>10 then regel:=StringReplace(regel,'$Count(','error',[rfReplaceAll]);
        tempst:=copy(regel,pos('$Count(',regel)+7,length(regel));
        tempst:=copy(tempst,1,pos(')',tempst)-1);
        while pos('#',tempst) <> 0 do begin
          ccount:=ccount+StrToInt(copy(tempst,1,pos('#',tempst)-1));
          tempst:=copy(tempst,pos('#',tempst)+1,length(tempst));
        end;
        ccount:=ccount+StrToInt(copy(tempst,1,length(tempst)));
        tempst:=copy(regel,pos('$Count(',regel)+7,length(regel));
        tempst:=copy(tempst,1,pos(')',tempst)-1);
        regel:=StringReplace(regel,'$Count('+ tempst+')',FloatToStr(ccount),[]);
     except
        regel:=StringReplace(regel,'$Count(','error',[]);
      end;
    end;

    while (pos('$CustomChar(',regel) <> 0) do begin
      try
        regel2:=copy(regel,pos('$CustomChar(',regel)+12, length(regel));
        regel2:=copy(regel2,1,pos(')',regel2)-1);
        customchar(regel2);
        regel:=StringReplace(regel,'$CustomChar('+regel2+')','', []);
      except
        regel:=StringReplace(regel,'$CustomChar(','ERROR', []);
      end;
    end;

    // $Rss(URL, TYPE [, NUM [, FREQ]])
    //   TYPE is t=title, d=desc, b=both
    //   NUM is 1 for item 1, etc. 0 means all (default). [when TYPR is b, then 0 is used]
    //   FREQ is the number of hours that must past before checking stream again.
   while decodeArgs(regel, '$Rss', maxArgs, args, prefix, postfix, numargs) do begin
      assert((numargs>=2) and (numargs<=4));

      if (numargs<3) then begin
        args[3]:='0';
      end;

      // locate entry
      jj:=0;
      found:=false;
      repeat
        Inc(jj);
        if (rss[jj].url = args[jj]) then found:=true;
      until (jj>=rssEntries) or (found);

      if (found) and (rss[jj].items>0) and (Cardinal(StrToInt(args[3]))<=rss[jj].items) then begin
        if (args[2]='t') then begin
          regel:=prefix+rss[jj].title[StrToInt(args[3])]+postfix;
        end else if (args[2]='d') then begin
          regel:=prefix+rss[jj].desc[StrToInt(args[3])]+postfix;
        end else if (args[2]='b') then begin
          regel:=prefix+rss[jj].whole+postfix;
        end else regel:=prefix+'[Error: Rss: bad arg 2]'+postfix;
      end
      else regel:=prefix+'[Error: Rss]'+postfix;
   end;

   while decodeArgs(regel, '$Bar', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=3);
      try
        spacecount:=strtoint(args[3])*3;

        if (StrToInt(args[2])<> 0) then
          x:=round(StrToInt(args[1])*spacecount/StrToInt(args[2]))
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
        regel:=prefix+'[Error:Bar]'+postfix;
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
        regel:=StringReplace(regel,'$Flash(','ERROR', []);
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
        regel:=StringReplace(regel,'$Right(','error', []);
      end;
    end;

    while decodeArgs(regel, '$Fill', maxArgs, args, prefix, postfix, numargs) do begin
      assert(numargs=1);
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
        regel:=prefix+'[Error:Fill]'+postfix;
      end;

    end;
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
  runThread: Boolean;

begin
try
  runThread:=False;
  for y:=1 to 9 do begin
    if (donewsupdate[y]) then runThread := true;
  end;

  if (runThread) and (HTTPthreadisrunning =false) then begin
    if Assigned(HTTPThread) then begin
      try
        HTTPThread.WaitFor;
        HTTPThread.Destroy;
      except
      end;
    end;
    HTTPThread:=TMyThread.Create(self.checkHTTPUpdates);
  end;

//cpuusage!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//Application.ProcessMessages;
t:=GetTickCount;
if (t - lastCpuUpdate > (ticksperseconde div 4)) then begin
  lastCpuUpdate := t;
  try
  {  CPUUsage[CPUUsagePos]:=cxCpu[0].Usage.Value.AsNumber;}
    CollectCPUData;
    rawcpu:= adCpuUsage.GetCPUUsage(0);

    if (rawcpu <= 1.1) and (rawcpu >= -0.1) then begin
      CPUUsage[CPUUsagePos]:=Trunc(abs(rawcpu) * 100);
      Inc(CPUUsagePos);
      if (CPUUsagePos>5) then CPUUsagePos:=1;
      if (CPUUsageCount<5) then Inc(CPUUsageCount);
    end ;

  except
  end;
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

except
end;


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
  end else result := false;
  CloseHandle(myHandle);
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


 
procedure TData.updateGameStats(Sender: TObject);
//GAMESTATS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  tempregel,tempregel2,tempregel4,regel:string;
  tempregel1:array [1..80] of String;
  tempregel3:array [1..20] of array [1..4] of string;
  teller,teller2:integer;
  bestand2,bestand:textfile;
  z, y:Integer;
  screenline: String;

begin


  assignfile(bestand,extractfilepath(application.exename)+'servers.cfg');
  reset (bestand);
  for z:=1 to 20 do begin
    for y:=1 to 4 do begin
      readln(bestand, tempregel3[z,y]);
    end;
    //application.ProcessMessages;
  end;
  closefile(bestand);

  for z:=1 to 20 do begin
    for y:=1 to 4 do begin
      //application.ProcessMessages;
      screenline:=config.screen[z][y].text;
      if ((pos('$Unreal', screenline) <> 0) or (pos('$QuakeIII', screenline) <> 0) or (pos('$QuakeII', screenline) <> 0) or (pos('$Half-life', screenline) <> 0)) and (copy(screenline,pos('¿',screenline)+1,1)='1') then begin
        teller:=1;
        try
          if pos('$Half-life', screenline) <> 0 then srvr:='-hls';
          if pos('$QuakeII', screenline) <> 0 then srvr:='-q2s';
          if pos('$QuakeIII', screenline) <> 0 then srvr:='-q3s';
          if pos('$Unreal', screenline) <> 0 then srvr:='-uns';
          //application.ProcessMessages;
          winexec(PChar(extractfilepath(application.exename) + 'qstat.exe -P -of txt'+intToStr(z)+'-'+intToStr(y)+'.txt -sort F '+ srvr +' '+ tempregel3[z,y]),sw_hide);

          tempregel:='';
          //application.ProcessMessages;
          sleep(1000);
          //application.ProcessMessages;

          assignfile (bestand2,extractfilepath(application.exename)+'txt'+IntToStr(z)+'-'+IntToStr(y)+'.txt');
          reset (bestand2);
          teller:=1;
          while (not eof(bestand2)) and (teller<80) do begin
            readln (bestand2, tempregel1[teller]);
            teller:=teller+1;
          end;
          closefile(bestand2);
        except
          try CloseFile(bestand2); except end;
        end;

        if (pos('$Unreal1', screenline) <> 0) or (pos('$QuakeIII1', screenline) <> 0) or (pos('$QuakeII1', screenline) <> 0) or (pos('$Half-life1', screenline) <> 0) then begin
          qstatreg1[z,y]:=copy(tempregel1[2],pos(' / ',tempregel1[2])+3,length(tempregel1[2]));
          qstatreg1[z,y]:=stripspaces(copy(qstatreg1[z,y],pos(' ',qstatreg1[z,y])+1,length(qstatreg1[z,y])));
        end;

        if (pos('$Unreal2', screenline) <> 0) or (pos('$QuakeIII2', screenline) <> 0) or (pos('$QuakeII2', screenline) <> 0) or (pos('$Half-life2', screenline) <> 0) then begin
          qstatreg2[z,y]:=copy(tempregel1[2],pos(':',tempregel1[2]),length(tempregel1[2]));
          qstatreg2[z,y]:=copy(qstatreg2[z,y],pos('/',qstatreg2[z,y])+4,length(qstatreg2[z,y]));
          qstatreg2[z,y]:=copy(qstatreg2[z,y],1,pos('/',qstatreg2[z,y])-5);
          qstatreg2[z,y]:=stripspaces(copy(qstatreg2[z,y],pos(' ',qstatreg2[z,y])+1,length(qstatreg2[z,y])));
        end;

        if (pos('$Unreal3', screenline) <> 0) or (pos('$QuakeIII3', screenline) <> 0) or (pos('$QuakeII3', screenline) <> 0) or (pos('$Half-life3', screenline) <> 0) then begin
          qstatreg3[z,y]:=stripspaces(copy(tempregel1[2],pos(' ',tempregel1[2]),length(tempregel1[2])));
          qstatreg3[z,y]:=stripspaces(copy(qstatreg3[z,y],1,pos('/',qstatreg3[z,y])+3));
        end;

        if (pos('$Unreal4', screenline) <> 0) or (pos('$QuakeIII4', screenline) <> 0) or (pos('$QuakeII4', screenline) <> 0) or (pos('$Half-life4', screenline) <> 0) then begin
          qstatreg4[z,y]:='';
          for teller2:=1 to teller-3 do begin
            regel:=stripspaces(tempregel1[teller2+2]);
            tempregel2:=stripspaces(copy(copy(regel,pos('s ', regel)+1,length(regel)),pos('s ', regel)+2,length(regel)));
            tempregel4:=stripspaces(copy(regel,2,pos(' frags ',regel)-1));
            regel:=tempregel2 + ': '+ tempregel4 + ', ';
            qstatreg4[z,y]:=qstatreg4[z,y]+regel;
            //application.ProcessMessages;
          end;
          //application.ProcessMessages;
        end;
      end;
    end;
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


procedure TData.checkIfNewsUpdatesRequired;
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
begin
  for y:= 1 to 9 do
    newsAttempts[y]:=0;

  // TODO: this should only be done when the config changes...
  myRssCount:=0;
  DoNewsUpdate[6]:=true;
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
          if (numargs>=4) then rss[myRssCount].maxfreq := StrToInt(args[4]);
          screenline:=prefix+postfix;
        end;
        if (pos('$DutchWeather',screenline) <> 0) then DoNewsUpdate[2]:=true;
        if (pos('$TomsHW',screenline) <> 0) then DoNewsUpdate[3]:=true;
        if (pos('$Stocks',screenline) <> 0) then DoNewsUpdate[4]:=true;
        if (pos('$CNN',screenline) <> 0) then DoNewsUpdate[5]:=true;
        if (pos('$SETI',screenline) <> 0) then DoNewsUpdate[7]:=true;
        if (pos('$FOLD',screenline) <> 0) then DoNewsUpdate[9]:=true;
        if (pos('$Weather.com(',screenline) <> 0) then begin
          locationnumber:=copy(screenline,pos('(',screenline)+1,pos(')',screenline)-pos('(',screenline)-1);
          DoNewsUpdate[8]:=true;
        end;
      end;
    end;
  end;
  rssEntries:=myRssCount;
  if (myRssCount>0) then  DoNewsUpdate[1]:=true;
end;


procedure TData.updateMBMStats(Sender: TObject);
//HARDDISK MOTHERBOARD MONITOR AND DISTRIBUTED STATS!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  letter:integer;
  letter2:array [67..90] of integer;
  x:integer;
  bestand:textfile;
  koez,hd,mbm,teller:integer;
  regel:string;
{  cpuinfo:tcpuinfo;    }
  z, y: Integer;
  screenline: String;

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


  STComputername:=system1.Computername;
  STUsername:=system1.Username;

  STMemfree:=round(system1.availPhysmemory / 1024 / 1023.5);
  STMemTotal:=round(system1.totalPhysmemory / 1024 /1023);
  STPageTotal:=round(system1.totalPageFile / 1024 /1024);
  STPageFree:=round(system1.AvailPageFile / 1024 /1024);

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



function TData.getRss(Url: String;var titles, descs: array of string; maxitems:Cardinal; maxfreq:Cardinal=0): Cardinal;
var
  StartItemNode : IXMLNode;
  ANode : IXMLNode;
  XMLDoc : IXMLDocument;
  items: Cardinal;
  HTTP: TIdHTTP;
  sl: TStringList;
  lasttime: TDateTime;
  RssFilename: String;
  toonew: Boolean;

begin
  items:=0;

  // Generate a filename for the cached Rss stream.
  RssFilename:=LowerCase(Url);
  RssFilename:=StringReplace(RssFilename,'\\','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,':','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'/','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'"','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'|','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'<','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'>','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'&','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'?','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'=','_',[rfReplaceAll]);
  RssFilename:=StringReplace(RssFilename,'.','_',[rfReplaceAll]);
  RssFilename:=RssFilename+'.rss';

  // Fetch the Rss data
  try
    toonew:=false;
    sl:=TStringList.create;
    HTTP:= TIdHTTP.Create(nil);

    // Only fetch new data if it's newer than the cache files' date.
    // and if it's older than maxfreq hours.
    if FileExists(RssFilename) then begin

      lasttime:=FileDateToDateTime(FileAge(RssFilename));
      if (HoursBetween(lasttime, Now) < maxfreq) then toonew:=true;
      HTTP.Request.LastModified := lasttime;
    end;
    try
      if (not toonew) then begin
        sl.Text:=HTTP.Get(Url);
        sl.savetofile(RssFilename);
      end;
    finally
      sl.Free;
      HTTP.Free;
    end;
  except
  end;

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
    items:=0;
  end;

  Result:=items;
end;

procedure TData.checkHTTPUpdates;
var
  teller,teller2:integer;
  templine:array[1..20] of String;
  versionregel: String;
  titles, descs, whole: String;

begin
  HTTPthreadisrunning:=true;

  coinitialize(nil);
  try

    if DoNewsUpdate[1] then begin
      DoNewsUpdate[1]:=False;

      for teller:=1 to rssEntries do begin
        if (rss[teller].url <> '') then begin
          rss[teller].items := getRss(rss[teller].url, rss[teller].title,
                                    rss[teller].desc, maxRssItems, rss[teller].maxfreq);
          titles:=''; descs:=''; whole:='';
          for teller2:=1 to rss[teller].items do begin
            titles:=titles+rss[teller].title[teller2]+' | ';
            descs:=descs+rss[teller].desc[teller2]+' | ';
            whole:=whole+rss[teller].title[teller2]+': '+rss[teller].desc[teller2]+' | ';
          end;
          rss[teller].whole:=whole;
          rss[teller].title[0]:=titles;
          rss[teller].desc[0]:=descs;
        end;
      end;
    end;


{  if DoNewsUpdate[1] then begin
    DoNewsUpdate[1]:=False;
    try
     //Application.ProcessMessages;
     tnetregel:=form1.IDHTTP4.Get('http://aphrodite.tweakers.net/turbotracker.dsp');
    except
      if newsAttempts[1]<4 then begin
        Inc(newsAttempts[1]);
        DoNewsUpdate[1]:=True;
      end else tnetregel:= 'Connection Time-Out'
    end;

    tnetregel:=StringReplace(tnetregel,'&amp','&',[rfReplaceAll]);
    tnetregel:=StringReplace(tnetregel,chr(10),'',[rfReplaceAll]);
    tnetregel:=StringReplace(tnetregel,chr(13),'',[rfReplaceAll]);

    for teller:=1 to 12 do begin
      tnetregel:=copy(tnetregel,pos('<titel>',tnetregel)+length('<titel>'),length(tnetregel));
      templine[teller]:=copy(tnetregel,1,pos('</titel>',tnetregel)-1);
    end;
    tnetregel:=templine[1]+' | '+templine[2]+' | '+templine[3]+' | '+templine[4]+' | '+templine[5]+' | '+templine[6]+' | '+templine[7]+' | '+templine[8]+' | '+templine[9]+' | '+templine[10]+' | '+templine[11]+' | '+templine[12];
    if copy(tnetregel,1,6)=' |  | ' then begin
      if newsAttempts[1]<4 then begin
        Inc(newsAttempts[1]);
        DoNewsUpdate[1]:=True;
      end else tnetregel:= 'Connection Time-Out'
    end;
  end;}

  if DoNewsUpdate[2] then begin
   try
     //Application.ProcessMessages;
     if DoNewsUpdate[2] then begin
       DoNewsUpdate[2]:=False;
       weerregel:=Form1.IDHTTP1.Get('http://www.knmi.nl/voorl/weer/weermain.html');
       weerregel:=copy(weerregel,pos('<p>',weerregel)+3,(700)-(pos('<p>',weerregel)+3));
       weerregel:=StringReplace(weerregel,'&amp','&',[rfReplaceAll]);
       for teller2:=1 to 10 do begin
        //Application.ProcessMessages;
        templine[teller2]:=copy(weerregel,1,pos(chr(10),weerregel)-1)+' ';
        weerregel:=copy(weerregel,pos(chr(10),weerregel)+1,length(weerregel)-pos(chr(10),weerregel)+1);
       end;
       weerregel:=templine[1]+templine[2]+templine[3]+templine[4]+templine[5]+templine[6]+templine[7]+templine[8]+templine[9]+templine[10];
       weerregel:=copy(weerregel,pos('<p>',weerregel)+3,(pos('<P>',weerregel)-6)-(pos('<p>',weerregel)+3));
     end;
     if copy(weerregel,1,6)='      ' then begin
       if newsAttempts[2]<4 then begin
         newsAttempts[2]:=newsAttempts[2]+1;
         DoNewsUpdate[2]:=true;
       end else weerregel:= 'Connection Time-Out';
     end;
   except
     if newsAttempts[2]<4 then begin
       newsAttempts[2]:=newsAttempts[2]+1;
       DoNewsUpdate[2]:=true;
     end else weerregel:= 'Connection Time-Out';
   end;
 end;

  if DoNewsUpdate[3] then begin
    DoNewsUpdate[3]:=False;
      try
       //Application.ProcessMessages;
       techregel:=Form1.IDHTTP2.Get('http://www.tomshardware.com/technews/index.html');
      except
        if newsAttempts[3]<4 then begin
          newsAttempts[3]:=newsAttempts[3]+1;
          DoNewsUpdate[3]:=True;
        end else techregel:= 'Connection Time-Out';
      end;

      techregel:=StringReplace(techregel,chr(10),'',[rfReplaceAll]);
      techregel:=StringReplace(techregel,chr(13),'',[rfReplaceAll]);
      techregel:=copy(techregel,pos('<FONT FACE="Verdana,Arial,Helvetica" SIZE="1" COLOR="#000000"><B>',techregel)+length('<FONT FACE="Verdana,Arial,Helvetica" SIZE="1" COLOR="#000000"><B>'),length(techregel));
      for teller:= 1 to 10 do begin
        techregel:=copy(techregel,pos('TARGET="_top">',techregel)+length('TARGET="_top">'),length(techregel));
        templine[teller]:=copy(techregel,1,pos('<',techregel)-1)+' | ';
      end;
      techregel:=templine[1]+templine[2]+templine[3]+templine[4]+templine[5]+templine[6]+templine[7]+templine[8]+templine[9]+templine[10];
      if copy(techregel,1,6)=' |  | ' then begin
        if newsAttempts[3]<4 then begin
          newsAttempts[3]:=newsAttempts[3]+1;
          DoNewsUpdate[3]:=True;
        end else techregel:= 'Connection Time-Out';
      end;
  end;

  if DoNewsUpdate[4] then begin
   DoNewsUpdate[4]:=False;
    try
     //Application.ProcessMessages;
     aexregel:=Form1.IDHTTP3.Get('http://www.aex.nl/scripts/home2.asp?taal=nl');
    except
       if newsAttempts[4]<4 then begin
         newsAttempts[4]:=newsAttempts[4]+1;
         DoNewsUpdate[4]:=True;
       end else aexregel:= 'Connection Time-Out';
    end;

      aexregel:=StringReplace(aexregel,'&nbsp;','',[rfReplaceAll]);
      aexregel:=StringReplace(aexregel,'&amp','&',[rfReplaceAll]);
      aexregel:=StringReplace(aexregel,'<!--*********************-->','',[rfReplaceAll]);
      aexregel:=StringReplace(aexregel,chr(10),'',[rfReplaceAll]);
      aexregel:=StringReplace(aexregel,chr(13),'',[rfReplaceAll]);

     aexregel:=copy(aexregel,pos('<TD ROWSPAN=5 BACKGROUND="/i/beurs.gif"><IMG SRC="/i/pixel.gif" WIDTH=357 HEIGHT=1><BR><IMG NAME="graph" SRC="/i/pixel.gif" WIDTH=250 HEIGHT=105 HSPACE=0 VSPACE=0></TD>',aexregel)+length('<TD ROWSPAN=5 BACKGROUND="/i/beurs.gif"><IMG SRC="/i/pixel.gif" WIDTH=357 HEIGHT=1><BR><IMG NAME="graph" SRC="/i/pixel.gif" WIDTH=250 HEIGHT=105 HSPACE=0 VSPACE=0></TD>'),length(aexregel));
     aexregel:=copy(aexregel,pos('<FONT FACE="Arial, Helvetica" SIZE=1><!-- VALUE #0 -->',aexregel)+length('<FONT FACE="Arial, Helvetica" SIZE=1><!-- VALUE #0 -->'),length(aexregel));

     for teller:=1 to 8 do begin
     aexregel:=copy(aexregel,pos(');return true">',aexregel)+length(');return true">'),length(aexregel));
       templine[teller]:=copy(aexregel,1,pos('</A>',aexregel)-1);
     end;
     aexregel:=templine[2]+':'+templine[1]+' | '+templine[4]+':'+templine[3]+' | '+templine[6]+':'+templine[5]+' | '+templine[8]+':'+templine[7];
     if copy(aexregel,1,6)=': | : ' then begin
       if newsAttempts[4]<4 then begin
         newsAttempts[4]:=newsAttempts[4]+1;
         DoNewsUpdate[4]:=True;
       end else aexregel:= 'Connection Time-Out';
     end;
  end;

  if DoNewsUpdate[5] then begin
    DoNewsUpdate[5]:=False;
    try
      //Application.ProcessMessages;
      CNNregel:=Form1.IDHTTP5.Get('http://www.cnn.com/WORLD/');
    except
      if newsAttempts[5]<4 then begin
        newsAttempts[5]:=newsAttempts[5]+1;
        DoNewsUpdate[5]:=True;
      end else CNNregel:= 'Connection Time-Out';
    end;

    CNNregel:=StringReplace(CNNregel,'&amp','&',[rfReplaceAll]);
    CNNregel:=StringReplace(CNNregel,chr(10),'',[rfReplaceAll]);
    CNNregel:=StringReplace(CNNregel,chr(13),'',[rfReplaceAll]);

    CNNregel:=copy(CNNregel,pos('<!-- ================== content ================== -->',CNNregel)+length('<!-- ================== content ================== -->'),length(CNNregel));
    CNNregel:=copy(CNNregel,pos('<td width="170" valign="top">',CNNregel)+length('<td width="170" valign="top">'),length(CNNregel));
    CNNregel:=copy(CNNregel,pos('<span class="Text1">',CNNregel)+length('<span class="Text1">'),pos('<br clear="all">',CNNregel));

     for teller:=1 to 12 do templine[teller]:='';
     for teller:=1 to 10 do begin
         CNNregel:=copy(CNNregel,pos('html">',CNNregel)+length('html">'),length(CNNregel));
         templine[teller]:=copy(CNNregel,1,pos('</a>',CNNregel)-1)+' | ';
         CNNregel:=copy(CNNregel,pos('</a>',CNNregel)+length('</a>'),length(CNNregel));
         if templine[teller]=' | ' then templine[teller]:='';
     end;
     CNNregel:=templine[1]+templine[2]+templine[3]+templine[4]+templine[5]+templine[6]+templine[7]+templine[8]+templine[9]+templine[10];
     CNNregel:=copy(CNNregel,1,length(CNNregel)-3);
     if copy(CNNregel,1,6)='' then begin
       if newsAttempts[5]<4 then begin
         newsAttempts[5]:=newsAttempts[5]+1;
         DoNewsUpdate[5]:=True;
       end else CNNregel:= 'Connection Time-Out';
     end;
  end;

  if (config.checkUpdates) and (DoNewsUpdate[6]) then begin
    DoNewsUpdate[6]:=False;
    try
      //Application.ProcessMessages;
      versionregel:=Form1.IDHTTP6.Get('http://lcdsmartie.sourceforge.net/version.txt');
      //Application.ProcessMessages;
    except
      versionregel:='';
    end;
    versionregel:=StringReplace(versionregel,chr(10),'',[rfReplaceAll]);
    versionregel:=StringReplace(versionregel,chr(13),'',[rfReplaceAll]);
    if copy(versionregel,1,1) = '5' then
      isconnected:=true;
    if (length(versionregel) < 72) and (copy(versionregel,1,7) <> '5.3.0.0') and (versionregel <> '') then begin
      Form1.timer1.enabled:=false;
      Form1.timer2.enabled:=false;
      Form1.timer3.enabled:=false;
      Form1.timer4.enabled:=false;
      Form1.timer5.enabled:=false;
      Form1.timer6.enabled:=false;
      Form1.timer7.enabled:=false;
      Form1.timer8.enabled:=false;
      Form1.timer9.enabled:=false;
      if MessageDlg('A new version of LCD Smartie is detected. '+chr(13)+copy(versionregel,8,62)+chr(13)+'Go to download page?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        ShellExecute(0, Nil, pchar('http://lcdsmartie.sourceforge.net/'), Nil, Nil, SW_NORMAL);
        Form1.close;
      end else begin
        Form1.timer1.enabled:=true;
        Form1.timer2.enabled:=true;
        Form1.timer3.enabled:=true;
        Form1.timer6.enabled:=true;
        Form1.timer7.enabled:=true;
        Form1.timer8.enabled:=true;
        Form1.timer9.enabled:=true;
      end;
    end;
  end;

  if DoNewsUpdate[7] then begin
  DoNewsUpdate[7]:=False;
    try
      //Application.ProcessMessages;
      Setireg1:=Form1.IDHTTP7.Get('http://setiathome.ssl.berkeley.edu/fcgi-bin/fcgi?email=' + config.setiEmail + '&cmd=user_stats_new');
    except
      if newsAttempts[7]<4 then begin
        newsAttempts[7]:=newsAttempts[7]+1;
        DoNewsUpdate[7]:=True;
      end else begin
        setireg1:='No connection';
        setireg2:='No connection';
        setireg3:='No connection';
        setireg4:='No connection';
        setireg5:='No connection';
        setireg6:='No connection';
        setireg7:='No connection';
        setireg8:='No connection';
        setireg9:='No connection';
      end;
    end;

    setireg1:=StringReplace(setireg1,'&amp','&',[rfReplaceAll]);
    setireg1:=StringReplace(setireg1,chr(10),'',[rfReplaceAll]);
    setireg1:=StringReplace(setireg1,chr(13),'',[rfReplaceAll]);

    setireg1:=copy(setireg1,pos('Results Received',setireg1)+25,length(setireg1));
    setireg2:=copy(setireg1,pos('Results Received',setireg1)+25,length(setireg1));
    setireg1:=copy(setireg1,1,pos('</td></tr>',setireg1)-1);

    setireg2:=copy(setireg2,pos('Total CPU Time',setireg2)+17,length(setireg2));
    setireg3:=copy(setireg2,pos('Total CPU Time',setireg2)+21,length(setireg2));
    setireg2:=copy(setireg2,pos('<td>',setireg2)+4,pos('</td>',setireg2)-pos('<td>',setireg2)-4);

    setireg2:=stripspaces(setireg2);

    setireg3:=copy(setireg3,pos('Average CPU Time per work unit',setireg3)+39,length(setireg3));
    setireg4:=copy(setireg3,pos('Average CPU Time per work unit',setireg3)+39,length(setireg3));
    setireg3:=copy(setireg3,1,pos('</td>',setireg3)-1);

    setireg4:=copy(setireg4,pos('Last result returned:',setireg3)+32,length(setireg4));
    setireg5:=copy(setireg4,pos('Last result returned:',setireg3)+32,length(setireg4));
    setireg4:=copy(setireg4,1,pos('</TD>',setireg4)-1);

    setireg5:=copy(setireg5,pos('SETI@home user for:',setireg5)+28,length(setireg5));
    setireg6:=copy(setireg5,pos('SETI@home user for:',setireg5)+28,length(setireg5));
    setireg5:=copy(setireg5,1,pos('</TD>',setireg5)-1);

    setireg6:=copy(setireg6,pos('Your rank out of',setireg6)+20,length(setireg6));
    setireg7:=copy(setireg6,pos('Your rank out of',setireg6)+20,length(setireg6));
    setireg6:=copy(setireg6,1,pos('</b>',setireg6)-1);

    setireg7:=copy(setireg7,pos('total users is:',setireg7)+21,length(setireg7));
    setireg8:=copy(setireg7,pos('total users is:',setireg7)+21,length(setireg7));
    setireg7:=copy(setireg7,1,pos('<sup>',setireg7)-1);

    setireg8:=copy(setireg8,pos('have this rank:',setireg8)+27,length(setireg8));
    setireg9:=copy(setireg8,pos('have this rank:',setireg8)+27,length(setireg8));
    setireg8:=copy(setireg8,1,pos('</b>',setireg8)-1);

    setireg9:=copy(setireg9,pos('work units than',setireg9)+27,length(setireg9));
    setireg9:=copy(setireg9,1,pos('%',setireg9)-1);
  end;

  if DoNewsUpdate[9] then begin
    DoNewsUpdate[9]:=False;
    try
      //Application.ProcessMessages;
      foldreg7:=Form1.IDHTTP9.Get('http://folding.stanford.edu/cgi-bin/userpage.detailed?name='+config.foldUsername);
    except
      if newsAttempts[9]<4 then begin
        newsAttempts[9]:=newsAttempts[9]+1;
        DoNewsUpdate[9]:=True;
      end else begin
        foldreg1:='Connection Time-Out';
        foldreg2:='Connection Time-Out';
        foldreg3:='Connection Time-Out';
        foldreg4:='Connection Time-Out';
        foldreg5:='Connection Time-Out';
        foldreg6:='Connection Time-Out';
        foldreg7:='Connection Time-Out';
      end;
    end;

    foldreg7:=StringReplace(foldreg7,'&amp','&',[rfReplaceAll]);
    foldreg7:=StringReplace(foldreg7,chr(10),'',[rfReplaceAll]);
    foldreg7:=StringReplace(foldreg7,chr(13),'',[rfReplaceAll]);

    foldreg1:=copy(foldreg7,pos('Member Since</B></TD><TD align=left><font size=4>', foldreg7), 100);
    foldreg1:=copy(foldreg1,pos('size=4>',foldreg1)+7,pos(' </font>', foldreg1)-pos('size=4>',foldreg1)-7);

    foldreg2:=copy(foldreg7,pos('Date of last work unit</b></TD><TD align=left><font size=4>', foldreg7), 100);
    foldreg2:=copy(foldreg2,pos('size=4>',foldreg2)+7,pos(' </font>', foldreg2)-pos('size=4>',foldreg2)-7);

    foldreg3:=copy(foldreg7,pos('Active processors (within a week)</b></TD><TD align=left><font size=4>', foldreg7), 100);
    foldreg3:=stripspaces(copy(foldreg3,pos('size=4>',foldreg3)+7,pos('</font>', foldreg3)-pos('size=4>',foldreg3)-7));

    foldreg4:=copy(foldreg7,pos('Team</TD><TD><b><a href=teampage?q=', foldreg7)+2, 100);
    foldreg4:=copy(foldreg4,pos('teampage?q=',foldreg4)+11,100);
    foldreg4:=copy(foldreg4,pos('>',foldreg4)+1, pos(' (id #', foldreg4)-pos('>',foldreg4)-1);

    foldreg5:=copy(foldreg7,pos('Score</TD><TD><font size=3><b>', foldreg7), 100);
    foldreg5:=copy(foldreg5,pos('<b>',foldreg5)+3,pos('</b>', foldreg5)-pos('<b>',foldreg5)-3);

    foldreg6:=copy(foldreg7,pos('User Rank</TD><TD><font size=3><b>', foldreg7), 100);
    foldreg6:=copy(foldreg6,pos('<b>',foldreg6)+3,pos('</b>', foldreg6)-pos('<b>',foldreg6)-3);

    foldreg7:=copy(foldreg7,pos('WU</TD><TD><font size=3><b>', foldreg7), 100);
    foldreg7:=copy(foldreg7,pos('<b>',foldreg7)+3,pos('</b>', foldreg7)-pos('<b>',foldreg7)-3);
  end;

  if DoNewsUpdate[8] then begin
  DoNewsUpdate[8]:=False;
    try
      weather2:=Form1.IDHTTP8.Get('http://www.weather.com/weather/print/'+locationnumber);
      //Application.ProcessMessages;

      weather2:=StringReplace(weather2,chr(10),'',[rfReplaceAll]);
      weather2:=StringReplace(weather2,chr(13),'',[rfReplaceAll]);
      weather2:=StringReplace(weather2,chr(9),' ',[rfReplaceAll]);
      weather2:=StringReplace(weather2,'&amp','&',[rfReplaceAll]);
      weather2:=StringReplace(weather2,'&deg;','°',[rfReplaceAll]);
      weather2:=StringReplace(weather2,'&nbsp;',' ',[rfReplaceAll]);
      weather2:=StringReplace(weather2,' %<','%<',[rfReplaceAll]);

      weather2:=copy(weather2,pos('<!-- if printable page, use code below -->',weather2),length(weather2));
      //application.ProcessMessages;
      weather2:=copy(weather2,pos('<!-- insert forecast -->',weather2)+24,length(weather2));
      templine[1]:=copy(weather2,1,pos('</TD>',weather2)-1);
      weather2:=copy(weather2,pos('<!-- insert high -->',weather2)+20,length(weather2));
      templine[2]:=copy(weather2,1,pos('<!-- ',weather2)-1);
      weather2:=copy(weather2,pos('<!-- insert low -->',weather2)+19,length(weather2));
      templine[3]:=copy(weather2,1,pos('</B>',weather2)-1);
      weather2:=copy(weather2,pos('<!-- insert precip. chance -->',weather2)+30,length(weather2));
      templine[4]:=copy(weather2,1,pos('</DIV>',weather2)-1);
      weather2:=stripspaces(templine[1]+' '+templine[2]+templine[3]+' '+templine[4]);
    except
      if newsAttempts[8]<4 then begin
        newsAttempts[8]:=newsAttempts[8]+1;
        DoNewsUpdate[8]:=True;
      end else begin
        weather2:='Connection Time-Out';
      end;
    end;
  end;

  finally
  CoUninitialize;
  end;
  HTTPthreadisrunning:=false;
end;

procedure TData.checkEmailUpdates;
var
  mailz: array[0..9] of integer;
  z, y: Integer;
  screenline: String;

begin
  pop3threadisrunning:=true;
  for y:= 0 to 9 do mailz[y]:=0;

  for z:= 1 to 20 do begin
    for y:= 1 to 4 do begin
      if (config.screen[z][y].enabled) then begin
        screenline:=config.screen[z][y].text;
        if (pos('$Email1',screenline) <> 0) then mailz[1]:=1;
        if (pos('$Email2',screenline) <> 0) then mailz[2]:=1;
        if (pos('$Email3',screenline) <> 0) then mailz[3]:=1;
        if (pos('$Email4',screenline) <> 0) then mailz[4]:=1;
        if (pos('$Email5',screenline) <> 0) then mailz[5]:=1;
        if (pos('$Email6',screenline) <> 0) then mailz[6]:=1;
        if (pos('$Email7',screenline) <> 0) then mailz[7]:=1;
        if (pos('$Email8',screenline) <> 0) then mailz[8]:=1;
        if (pos('$Email9',screenline) <> 0) then mailz[9]:=1;
        if (pos('$Email0',screenline) <> 0) then mailz[0]:=1;
      end;
    end;
  end;

  gotEmail:=False;

  for y:=0 to 9 do begin
    if mailz[y]=1 then begin
      try
        form1.pop3[y].host:=config.pop[y].server;
        form1.pop3[y].UserName:=config.pop[y].user;
        form1.pop3[y].Password:=config.pop[y].pword;
        form1.pop3[y].Connect;
        mailregel[y]:=form1.pop3[y].CheckMessages;
        if (mailregel[y]>0) then gotEmail:= true;
        form1.pop3[y].Disconnect;
        form1.POP3[y].DisconnectSocket;
      except
        form1.POP3[y].DisconnectSocket;
        mailregel[y]:=0;
      end;
    end;
  end;

  pop3threadisrunning:=false;
end;

function stripspaces(Fstring:string): string;
begin
  while copy(fstring,1,1) = ' ' do begin
    fstring:=copy(fstring,2,length(fstring));
  end;
  while copy(fstring,length(fstring),1) = ' ' do begin
    fstring:=copy(fstring,1,length(fstring)-1);
  end;
  while copy(fstring,1,1) = chr(10) do begin
    fstring:=copy(fstring,2,length(fstring));
  end;
  while copy(fstring,length(fstring),1) = chr(10) do begin
    fstring:=copy(fstring,1,length(fstring)-1);
  end;
  while copy(fstring,1,1) = chr(13) do begin
    fstring:=copy(fstring,2,length(fstring));
  end;
  while copy(fstring,length(fstring),1) = chr(13) do begin
    fstring:=copy(fstring,1,length(fstring)-1);
  end;
  result:=fstring;
end;



end.
