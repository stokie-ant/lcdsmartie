unit UMain;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/UMain.pas,v $
 *  $Revision: 1.7 $ $Date: 2004/11/16 19:44:33 $
 *****************************************************************************}

interface

uses Messages, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdPOP3, VaClasses, VaComm, CoolTrayIcon,
  Menus, WinampCtrl, ExtCtrls, Controls, StdCtrls, Buttons, Classes, Forms,
  parport, system2, UConfig, ULCD, UData, xmldom, XMLIntf, msxmldom, XMLDoc;

const
  WM_ICONTRAY = WM_USER + 1;   // User-defined message

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    Showwindow1: TMenuItem;
    Close1: TMenuItem;
    Button2: TButton;
    Image1: TImage;
    SpeedButton10: TSpeedButton;
    Button1: TButton;
    CoolTrayIcon1: TCoolTrayIcon;
    Panel1: TPanel;   // aka screenLcd[1]
    Panel2: TPanel;   // aka screenLcd[2]
    Panel3: TPanel;   // aka screenLcd[3]
    Panel4: TPanel;   // aka screenLcd[4]
    Configure1: TMenuItem;
    BacklightOn1: TMenuItem;
    Commands1: TMenuItem;
    Freeze1: TMenuItem;
    NextTheme1: TMenuItem;
    LastTheme1: TMenuItem;
    N2: TMenuItem;
    Credits1: TMenuItem;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    SpeedButton1: TSpeedButton;
    Panel5: TPanel;
    Timertrans: TTimer;
    VaComm1: TVaComm;
    VaComm2: TVaComm;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Timer5: TTimer;
    Timer6: TTimer;
    Timer7: TTimer;
    Timer8: TTimer;
    Timer9: TTimer;
    Timer10: TTimer;
    Timer11: TTimer;
    Timer12: TTimer;
    Timer13: TTimer;
    WinampCtrl1: TWinampCtrl;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Showwindow1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Configure1Click(Sender: TObject);
    procedure BacklightOn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure Timer7Timer(Sender: TObject);
    procedure Timer8Timer(Sender: TObject);
    procedure Timer9Timer(Sender: TObject);
    procedure Timer10Timer(Sender: TObject);
    procedure Timer11Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Credits1Click(Sender: TObject);
    procedure NextTheme1Click(Sender: TObject);
    procedure LastTheme1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Freeze1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Image12MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image16MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image16MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image17MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image17MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image12Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image17Click(Sender: TObject);
    procedure Image16Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer13Timer(Sender: TObject);
    procedure TimertransTimer(Sender: TObject);
    procedure Timer12Timer(Sender: TObject);
    procedure WMQueryEndSession (var M: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure WMPowerBroadcast (var M: TMessage); message WM_POWERBROADCAST;
    procedure kleur();
    procedure ChangeScreen(scr: Integer);
  private
    screenLcd: Array [1..4] of ^TPanel;
    canflash: Boolean;
    aantregelsoud, foo2:integer;
    didMOFan,didWAShuffle,didbltoggle,didgpotoggle,didbl,didwavolup,didwavoldown,didwaplay,didwastop, didwapause,
    didgotoscreen,didgototheme,didfreeze,didrefreshall,didnexttheme,didlasttheme,didnextscreen,didlastscreen,
    didgpo,didgpoflash,didwanexttrack,didwalasttrack,didflash,didsound,didexec:array [1..99] of boolean;
    file1:string;
    kleuren:Integer;
    parsedLine: Array [1..4] of String;
    scrollPos:array[1..4] of integer;
    regel2scroll:integer;
    tmpregel: Array [1..4] of String;
    forgroundcoloroff,forgroundcoloron,backgroundcoloroff,backgroundcoloron:integer;
    Oldline:array[1..4] of string;
    Newline:array[1..4] of string;
    Gotnewlines:boolean;
    transActietemp,transActietemp2,TransCycle,timertransIntervaltemp:integer;
    gokjesarray:array[1..4,1..40] of boolean;
    activetheme:integer;
    canscroll:boolean;
    gpo: array [1..8] of boolean;
    doesgpoflash: boolean;
    gpoflash, whatgpo:integer;
    flash: Integer;
    function doguess(line: Integer): integer;
    procedure freeze();
    procedure doGPO(const ftemp1,ftemp2:integer);
    function scroll(const scrollvar:string;const line,speed:integer):string;
    procedure scrollLine(line: Byte; direction: Integer);
    procedure doInteractions;
end;

var
  Lcd: TLCD;
  doesflash:Boolean;
  Form1: TForm1;
  backlight: Integer;
  config: TConfig;
  parameter1, parameter2, parameter3, parameter4 : String;
  Data: TData;
  poort1: TParPort;
  frozen: Boolean;
  setupbutton: Integer;
  setupscreen: Integer;
  tempscreen: Integer;
  kar:char;
  activeScreen : Integer;
  actionsarray:array[1..99,1..4] of string;
  aantalscreensheenweer: Integer;
  combobox8temp: Integer;
  totalactions: Integer;
  procedure customchar(fregel:string);
  procedure backlit();

implementation

uses
  Registry, Windows, SysUtils, Graphics,  Dialogs,
  ShellAPI, mmsystem, USetup, UCredits,
  ULCD_MO, ULCD_CF, ULCD_HD, ExtActns;

procedure TForm1.WMPowerBroadcast (var M: TMessage);
const
  PBT_APMRESUMECRITICAL=6;
  PBT_APMRESUMESUSPEND=7;
  PBT_APMRESUMESTANDBY=8;
  PBT_APMRESUMEAUTOMATIC=$012;
begin
  if (M.WParam=PBT_APMRESUMEAUTOMATIC) or
      (M.WParam=PBT_APMRESUMECRITICAL) or
      (M.WParam=PBT_APMRESUMESTANDBY) or
      (M.WParam=PBT_APMRESUMESUSPEND) then begin
    if Assigned(Lcd) then Lcd.powerResume;
  end;
end;

procedure TForm1.ChangeScreen(scr: Integer);
var
  y: Integer;
begin
  activeScreen:=scr;
  for y:= 1 to 4 do begin
    scrollPos[y]:=0; // Reset scroll postion.
  end;
end;

function TForm1.doguess(line:integer): integer;
var
  goedgokje:boolean;
  x:integer;
  loopcount: Integer;

begin
  goedgokje:=false;
  x:=0;
  loopcount:=0;

  while goedgokje = false do begin
    Inc(loopcount);
    x:=round(random(config.width)+1);
    if gokjesarray[line,x]=false then begin
      goedgokje:=true;
    end else if (loopcount>config.width*2) then begin
      // it's taking too long - use first unset element
      x:=0;
      repeat
        Inc(x);
        if (gokjesarray[line,x]=false) then goedgokje:=true;
      until (x>=config.width) or (goedgokje);
      if (not goedgokje) then begin
        // all the elements are set - use 1 (arb.)
        x:=1;
        goedgokje:=true;
      end;
    end;
  end;
  gokjesarray[line,x]:=true;
  result:=x;
end;

procedure customchar(fregel:string);
var
  character:integer;
  waarde:array[0..7] of Byte;
  i:integer;

begin
  character:=StrToInt(copy(fregel,1,pos(',',fregel)-1));
  fregel:=copy(fregel,pos(',',fregel)+1,length(fregel));
  for i:=0 to 6 do begin
    waarde[i]:=StrToInt(copy(fregel,1,pos(',',fregel)-1));
    fregel:=copy(fregel,pos(',',fregel)+1,length(fregel));
  end;
  waarde[7]:=StrToInt(copy(fregel,1,length(fregel)));

  Lcd.customChar(character, waarde);
end;



function TForm1.scroll(const scrollvar:string;const line,speed:integer):string;
var
  scrolltext:string;
  len: Integer;

begin
  if length(scrollvar) > config.width then begin
    scrollPos[line]:=scrollPos[line]+speed;
    if (scrollPos[line]>length(scrollvar)) then scrollPos[line]:=1;

    len:=length(scrollvar)-scrollPos[line]+1;
    if (len>config.width) then len:=config.width;
    scrolltext:=copy(scrollvar, scrollPos[line], len);

    if length(scrolltext) < config.width then begin
      scrolltext:=scrolltext+copy(scrollvar,1,config.width-length(scrolltext));
    end;
    result:=scrolltext;
    
  end else result:=scrollvar;
end;


{$R *.DFM}



procedure TForm1.FormCreate(Sender: TObject);
var
  regel:string;
  initfile:textfile;
begin
  Randomize;

  SetCurrentDir(extractfilepath(application.exename));
  CreateDirectory('cache',nil);

  screenLcd[1]:=@Panel1;
  screenLcd[2]:=@Panel2;
  screenLcd[3]:=@Panel3;
  screenLcd[4]:=@Panel4;


//SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW );
  try
    regel:=extractfilepath(application.exename);
    image1.picture.LoadFromFile(regel+'images\logo.bmp');
    image3.picture.LoadFromFile(regel+'images\small_arrow_left_up1.bmp');
    image4.picture.LoadFromFile(regel+'images\small_arrow_left_up2.bmp');
    image5.picture.LoadFromFile(regel+'images\small_arrow_left_up3.bmp');
    image6.picture.LoadFromFile(regel+'images\small_arrow_left_up4.bmp');
    image7.picture.LoadFromFile(regel+'images\small_arrow_right_up1.bmp');
    image8.picture.LoadFromFile(regel+'images\small_arrow_right_up2.bmp');
    image9.picture.LoadFromFile(regel+'images\small_arrow_right_up3.bmp');
    image10.picture.LoadFromFile(regel+'images\small_arrow_right_up4.bmp');
    image11.picture.LoadFromFile(regel+'images\big_arrow_right_up.bmp');
    image12.picture.LoadFromFile(regel+'images\big_arrow_left_up.bmp');
    image13.picture.LoadFromFile(regel+'images\bar_left.bmp');
    image14.picture.LoadFromFile(regel+'images\bar_right.bmp');
    image15.picture.LoadFromFile(regel+'images\bar_middle.bmp');
    image16.picture.LoadFromFile(regel+'images\setup_up.bmp');
    image17.picture.LoadFromFile(regel+'images\hide_up.bmp');
    cooltrayicon1.Icon.LoadFromFile(regel+'images\smartie.ico');
    application.Icon.LoadFromFile(regel+'images\smartie.ico');
    cooltrayicon1.Refresh;
  except
    on E: Exception do begin
      showmessage('Error: unable to access images subdirectory: '+E.Message);
      application.terminate;
    end;
  end;
  form1.color:=$00BFBFBF;

  parameter1:=lowercase(paramstr(1));
  parameter2:=lowercase(paramstr(2));
  parameter3:=lowercase(paramstr(3));
  parameter4:=lowercase(paramstr(4));
  aantalscreensheenweer:=1;

//register
  try
    assignfile(initfile, extractfilepath(application.exename)+'images\colors.cfg');
    reset(initfile);
    readln(initfile,regel);
    panel5.Color:=StrToInt('$00'+copy(regel,1,6));
    readln(initfile,regel);
    panel5.font.Color:=StrToInt('$00'+copy(regel,1,6));
    readln(initfile,regel);
    forgroundcoloron:=StrToInt('$00'+copy(regel,1,6));
    readln(initfile,regel);
    backgroundcoloron:=StrToInt('$00'+copy(regel,1,6));
    readln(initfile,regel);
    forgroundcoloroff:=StrToInt('$00'+copy(regel,1,6));
    readln(initfile,regel);
    backgroundcoloroff:=StrToInt('$00'+copy(regel,1,6));
    closefile(initfile);
  except
    on E: Exception do begin
      showmessage('Fatal Error:  Can`t find images\colors.cfg: ' + E.Message);
      application.Terminate;
    end;
  end;

  config:=TConfig.Create();

  if (config.load() = false) then begin
    showmessage('Fatal Error:  Failed to load configuration');
    application.Terminate;
  end;

  Data:=TData.Create();

  form1.WinampCtrl1.WinampLocation:=config.winampLocation;
  file1:=config.distLog;

  ChangeScreen(1);

  aantregelsoud:=config.height;

  screenLcd[2].visible:=false;
  screenLcd[3].visible:=false;
  screenLcd[4].visible:=false;
  image4.enabled:=false;
  image5.enabled:=false;
  image6.enabled:=false;
  image8.enabled:=false;
  image9.enabled:=false;
  image10.enabled:=false;
  if config.height>1 then begin
    screenLcd[2].visible:=true;
    image4.enabled:=true;
    image8.enabled:=true;
  end;
  if config.height>2 then begin
    screenLcd[3].visible:=true;
    image5.enabled:=true;
    image9.enabled:=true;
  end;
  if config.height>3 then begin
    screenLcd[4].visible:=true;
    image6.enabled:=true;
    image10.enabled:=true;
  end;

  kleuren:=config.colorOption;
  backlight:=1;
  kleur();


  if (config.isMO) or (config.isCF) then begin
    try
      if (config.isMO) and (config.isUsbPalm) then begin
        Lcd:=TLCD_MO.CreateUsb(config.UsbPalmDevice);
      end else begin
        case config.baudrate of
        0:  VaComm1.Baudrate:=br110;
        1:  VaComm1.Baudrate:=br300;
        2:  VaComm1.Baudrate:=br600;
        3:  VaComm1.Baudrate:=br1200;
        4:  VaComm1.Baudrate:=br2400;
        5:  VaComm1.Baudrate:=br4800;
        6:  VaComm1.Baudrate:=br9600;
        7:  VaComm1.Baudrate:=br14400;
        8:  VaComm1.Baudrate:=br19200;
        9:  VaComm1.Baudrate:=br38400;
        10: VaComm1.Baudrate:=br56000;
        11: VaComm1.Baudrate:=br57600;
        12: VaComm1.Baudrate:=br115200;
        13: VaComm1.Baudrate:=br128000;
        14: VaComm1.Baudrate:=br256000;
        end;
        VaComm1.PortNum:=config.comPort;
        //VaComm1.Close;
        VaComm1.Open;
        if (config.isCF) then Lcd:=TLCD_CF.Create()
        else if (config.isMO) then Lcd:=TLCD_MO.Create();
      end;
    except
      on E: Exception do begin
        showmessage('Failed to open device: ' + E.Message);
        Lcd:=TLCD.Create();
      end;
    end;
  end;

    if not (config.isCF or config.isMO or config.isHD) then Lcd:=TLCD.Create();

    if (config.isMO) or (config.isCF) then begin
      customchar('1,12,18,18,12,0,0,0,0');
      customchar('2,31,31,31,31,31,31,31,31');
      customchar('3,16,16,16,16,16,16,31,16');
      customchar('4,28,28,28,28,28,28,31,28');
    end;

    if (config.isMO) then begin
      Lcd.setContrast(config.contrast);
      Lcd.setBrightness(config.brightness);
    end;

    if (config.isCF) then begin
      customchar('7,4,4,4,4,4,4,4,0');
      customchar('8,14,17,1,13,21,21,14,0');

      Lcd.setContrast(config.CF_contrast);
      Lcd.setBrightness(config.CF_brightness);
    end;

    //
    // Enable the timers...
    //
    if (not config.isHD) and (not config.isHD2) then begin
      timer1.enabled:=true;
      timer2.enabled:=true;
      timer3.enabled:=true;
      timer6.enabled:=true;
      timer7.enabled:=true;
      timer8.enabled:=true;
      timer9.enabled:=true;
      timer10.enabled:=true;
      timer12.enabled:=true;
      timer13.enabled:=true;
    end else begin
      // HD/HD2 have a delay start - they will setup the above timers later.
      if config.bootDriverDelay=0 then timer11.interval:=10
      else timer11.interval:=config.bootDriverDelay*1000;
      timer11.enabled:=true;
    end;

end;

procedure TForm1.doInteractions;
var
  gokreg:array[1..4] of string;
  tempstr: String;
  line: Integer;
  maxTransCycles: Integer;
  gokje:integer;
  x: Integer;
  foo: Integer;

begin
  // Changing screen - do any interactions required.
  TransCycle:=TransCycle+1;
  maxTransCycles:=timertrans.Interval div timer1.Interval;

  if (TransCycle>maxTransCycles) then Exit;

  for x:=1 to config.height do begin
    oldline[x]:=copy(oldline[x]+'                                        ',1,config.width);
    newline[x]:=copy(newline[x]+'                                        ',1,config.width);
  end;

  if transActietemp=1 then begin  //left-->right

    for x:=1 to config.height do begin
      tempstr:=copy(newline[x]+'|'+oldline[x],
                  round((config.width+2)-TransCycle*((config.width+2)/maxTransCycles)),
                  config.width);
      screenLcd[x].Caption:=StringReplace(tempstr,'&','&&',[rfReplaceAll]);
    end;

  end else if transActietemp=2 then begin  //right-->left

    for x:=1 to config.height do begin
      tempstr:=copy(oldline[x]+'|'+newline[x],
                round(TransCycle*((config.width+2)/maxTransCycles)),
                config.width);
      screenLcd[x].Caption:=StringReplace(tempstr,'&','&&',[rfReplaceAll]);
    end;

  end else if transActietemp=3 then begin  //top-->bottom

    line:=round(TransCycle*(config.height/maxTransCycles))+1;
    for x:=1 to line-1 do begin
      screenLcd[x].Caption:=StringReplace(newline[config.height-(line-1)+x],'&','&&',[rfReplaceAll]);
    end;

    if (line<=config.height) then
      screenLcd[line].Caption:=copy('----------------------------------------', 1, config.width);

    for x:=line+1 to config.height do begin
      screenLcd[x].Caption:=StringReplace(oldline[x-(line+1)+1],'&','&&',[rfReplaceAll]);
    end;

  end else if transActietemp=4 then begin  //bottom-->top

    line:=round(TransCycle*(config.height/maxTransCycles))+1;
    for x:=1 to config.height-line do begin
      screenLcd[x].Caption:=StringReplace(oldline[x+line-1],'&','&&',[rfReplaceAll]);
    end;

    if (config.height-line+1>0) then
      screenLcd[config.height-line+1].Caption:=copy('----------------------------------------', 1, config.width);

    for x:=config.height-line+2 to config.height do begin
      screenLcd[x].Caption:=StringReplace(newline[x-(config.height-line+2)+1],'&','&&',[rfReplaceAll]);
    end;

  end else if transActietemp=5 then begin  //random blocks

    for x:=1 to 4 do begin
      gokreg[x]:=copy(screenLcd[x].caption+'                                        ',1,config.width);
    end;

    for x:= round((config.width/maxTransCycles)*(TransCycle-1)) to round((config.width/maxTransCycles)*TransCycle)-1 do begin
      for line:=1 to 4 do begin
        gokje:=doguess(line);
        gokreg[line]:=copy(gokreg[line],1,gokje-1)
                      +copy(newline[line],gokje,1)
                      +copy(gokreg[line],gokje+1,config.width-gokje);
      end;
    end;
    for x:=1 to 4 do begin
      screenLcd[x].caption:=StringReplace(gokreg[x],'&','&&',[rfReplaceAll]);
    end;

  end else if transActietemp=6 then begin  //contrast fade

    // For the first half of the cycles - lower the contrast
    if (TransCycle<maxTransCycles/2) then begin
      if (config.isMO)then
        x:=config.contrast
      else
        x:=config.CF_contrast;

      foo:=round(x-(TransCycle*x/(MaxTransCycles/2)));
      if foo < 0 then foo:=0;
      Lcd.setContrast(foo);
    end else begin
      // raise the contrast over the second half

      for x:=1 to 4 do begin
        screenLcd[x].Caption:=newline[x];
      end;

      if (config.isMO) then
        x:=config.contrast
      else
        x:=config.CF_contrast;

      foo:=round((TransCycle-(MaxTransCycles/2))*x/(MaxTransCycles/2-1));
      if foo > x then foo:=x;
      Lcd.setContrast(foo);
    end;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
  teller, h: Integer;
  regel: String;
  scrollcount: Integer;

begin
  timer1.Interval:=config.refreshRate;

  if ((gotnewlines=false) OR (timertrans.enabled=false))then begin
    Data.refres(self);

    if kleuren <> config.colorOption then
    begin
      kleuren:=config.colorOption;
      kleur();
    end;

    if (config.alwaysOnTop) and (not form2.Visible) and (not form4.Visible) then begin
      form1.formStyle:=fsStayOnTop;
    end else begin
      form1.formStyle:=fsNormal;
    end;


    if form1.left < 8 then form1.left:=0;
    if form1.top < 8 then form1.top:=0;
    if form1.left+form1.Width > screen.desktopwidth -8 then form1.left:= screen.desktopwidth-form1.width;
    if form1.top+form1.height > screen.desktopheight -34 then form1.top:= screen.desktopheight-form1.height-28;


    if (config.width=40) then begin
      form1.Width:=389;
      image1.left:=356;
      image11.left:=368;
      image7.left:=352;
      image8.left:=352;
      image9.left:=352;
      image10.left:=352;
      image14.left:=266;
      image17.left:=323;
      for h:= 1 to 4 do begin
        screenLcd[h].width:=321;
      end;
      image15.width:=220;
    end else if (config.width=24) then begin
      form1.Width:=261;
      image1.left:=228;
      image11.left:=240;
      image7.left:=224;
      image8.left:=224;
      image9.left:=224;
      image10.left:=224;
      image14.left:=140;
      image17.left:=197;
      for h:= 1 to 4 do begin
        screenLcd[h].width:=193;
      end;
      image15.width:=70;
    end else begin
      form1.Width:=231;
      image1.left:=198;
      image11.left:=210;
      image7.left:=194;
      image8.left:=194;
      image9.left:=194;
      image10.left:=194;
      for h:= 1 to 4 do begin
        screenLcd[h].width:=162;
      end;
      image14.left:=108;
      image17.left:=165;
      image15.width:=20;
    end;


    if config.height<>aantregelsoud then begin
      aantregelsoud:=config.height;
      screenLcd[2].visible:=false;
      screenLcd[3].visible:=false;
      screenLcd[4].visible:=false;
      image4.visible:=false;
      image5.visible:=false;
      image6.visible:=false;
      image8.visible:=false;
      image9.visible:=false;
      image10.visible:=false;
      if config.height>1 then begin
        screenLcd[2].visible:=true;
        image4.Visible:=true;
        image8.Visible:=true;
      end;
      if config.height>2 then begin
        screenLcd[3].visible:=true;
        image5.Visible:=true;
        image9.Visible:=true;
      end;
      if config.height>3 then begin
        screenLcd[4].visible:=true;
        image6.Visible:=true;
        image10.Visible:=true;
      end;
    end;
    if (canflash) then begin
      canflash:=false;
      doesflash:= not doesflash;
      if (flash > 0) then begin
       flash := flash -1;
       backlit()
      end;
    end;

    for teller:= 1 to config.height do begin
      //Application.ProcessMessages;
      regel:=config.screen[activeScreen][teller].text;
      regel:=Data.change(regel, teller);

      // Center the line if requested.
      if config.screen[activeScreen][teller].center then begin
        if length(regel) < config.width-1 then begin
          for h:=1 to round((config.width - length(regel))/2 - 0.4) do begin
            regel:=' '+regel+' ';
          end;
        end;
      end;

      parsedLine[teller]:=regel;
      newline[teller]:=regel;  // Used by screen change interaction.
    end;
    for h:= 1 to 4 do begin
      // handle continuing on the next line (if req)
      if (h<4) and (config.screen[activeScreen][h].contNextLine) then begin
        parsedLine[h+1]:=copy(parsedLine[h],1+config.width,length(parsedLine[h]));
      end;
    end;

    gotnewlines:=true;
  end;

  if timertrans.Enabled=false then begin

    if (canscroll) then begin
      canscroll:=false;
      scrollcount:=1;

      doesgpoflash := not doesgpoflash;
      if (gpoflash > 0) then begin
        gpoflash := gpoflash -1;
        doGPO(whatgpo,2)
      end;
    end else begin
      scrollcount:=0;
    end;

    // calculate scroll positions
    for teller:= 1 to config.height do begin
       if (not config.screen[activeScreen][teller].noscroll) then
          screenLcd[teller].Caption:=StringReplace(scroll(parsedLine[teller],teller,scrollcount),'&','&&',[rfReplaceAll])
       else if (scrollPos[teller]>1) then // maintain manual scroll postion
          screenLcd[teller].Caption:=StringReplace(scroll(parsedLine[teller],teller,0),'&','&&',[rfReplaceAll])
       else
          screenLcd[teller].Caption:=StringReplace(copy(parsedLine[teller],1,config.width),'&','&&',[rfReplaceAll]);
    end;

  end else begin // timertrans.Enabled=true
    doInteractions();
  end;


  for h:=1 to config.height do begin
    if tmpregel[h]<>copy(screenLcd[h].Caption + '                                        ',1,config.width) then begin
      tmpregel[h]:=copy(StringReplace(screenLcd[h].Caption,'&&','&',[rfReplaceAll]) + '                                        ',1,config.width);

      Lcd.setPosition(1, h);
      Lcd.write(tmpregel[h]);
    end;
  end;

  Application.ProcessMessages;
end;


// toggles backlight
procedure backlit;
begin
  backlight:=1-backlight;
  Lcd.setbacklight(backlight=1);

  if backlight=0 then
    Form1.popupmenu1.Items[0].Items[0].Caption:='&Backlight On'
  else
    Form1.popupmenu1.Items[0].Items[0].Caption:='&Backlight Off';
  Form1.kleur();
end;

procedure TForm1.FormShow(Sender: TObject);
var
  initfile:textfile;
  teller:integer;
  regel: String;

begin
  timer1.Interval:=config.refreshRate;


  if (parameter1= '-hide') or (parameter2= '-hide') or (parameter3= '-hide') or (parameter4= '-hide') then begin
    if parameter1 = '-hide' then parameter1:= '';
    if parameter2 = '-hide' then parameter2:= '';
    if parameter3 = '-hide' then parameter3:= '';
    if parameter4 = '-hide' then parameter4:= '';
    application.minimize;
    hide;
  end;

  if (parameter1= '-totalhide') or (parameter2= '-totalhide') or (parameter3= '-totalhide') or (parameter4= '-totalhide') then begin
    if parameter1 = '-totalhide' then parameter1:= '';
    if parameter2 = '-totalhide' then parameter2:= '';
    if parameter3 = '-totalhide' then parameter3:= '';
    if parameter4 = '-totalhide' then parameter4:= '';
    cooltrayicon1.Destroy;
    application.minimize;
    hide;
  end;



  if config.height<>aantregelsoud then begin
    aantregelsoud:=config.height;
    // only show used lines on the screen lcd.
    for teller:=1 to 4 do begin
      screenLcd[teller].visible:=(teller<=config.height);
    end;
  end;

  teller:=0;
  try
    assignfile(initfile,extractfilepath(application.exename)+'actions.cfg');
    try
      reset (initfile);
      while not eof(initfile) do begin
        readln(initfile,regel);
        teller:=teller+1;
        actionsarray[teller,1]:=copy(regel,1,pos('¿',regel)-1);
        actionsarray[teller,2]:=copy(regel,pos('¿',regel)+1,1);
        actionsarray[teller,3]:=copy(regel,pos('¿¿',regel)+2,pos('¿¿¿',regel)-pos('¿¿',regel)-2);
        actionsarray[teller,4]:=copy(regel,pos('¿¿¿',regel)+3,length(regel));
      end;
    finally
      closefile(initfile);
    end;
  except
  end;
  totalactions:=teller;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if (data.lcdSmartieUpdate) then begin
    data.lcdSmartieUpdate:=False;

    timer1.enabled:=false;
    timer2.enabled:=false;
    timer3.enabled:=false;
    timer4.enabled:=false;
    timer5.enabled:=false;
    timer6.enabled:=false;
    timer7.enabled:=false;
    timer8.enabled:=false;
    timer9.enabled:=false;
    if MessageDlg('A new version of LCD Smartie is detected. '+chr(13)+data.lcdSmartieUpdateText+chr(13)+'Go to download page?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      ShellExecute(0, Nil, pchar('http://lcdsmartie.sourceforge.net/'), Nil, Nil, SW_NORMAL);
      Form1.close;
    end else begin
      timer1.enabled:=true;
      timer2.enabled:=true;
      timer3.enabled:=true;
      timer6.enabled:=true;
      timer7.enabled:=true;
      timer8.enabled:=true;
      timer9.enabled:=true;
    end;
  end;

  Data.UpdateHTTP;
  timer2.Interval:=config.newsRefresh*1000*60;
end;

procedure TForm1.kleur;
begin
if backlight=1 then
 begin
   if kleuren =0 then begin
     screenLcd[1].color:=$0001FFA8;
     screenLcd[2].color:=$0001FFA8;
     screenLcd[3].color:=$0001FFA8;
     screenLcd[4].color:=$0001FFA8;
     form1.Color:=$0001FFA8;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =1 then begin
     screenLcd[1].color:=$00FDF103;
     screenLcd[2].color:=$00FDF103;
     screenLcd[3].color:=$00FDF103;
     screenLcd[4].color:=$00FDF103;
     form1.Color:=$00FDF103;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =2 then begin
     screenLcd[1].color:=clyellow;
     screenLcd[2].color:=clyellow;
     screenLcd[3].color:=clyellow;
     screenLcd[4].color:=clyellow;
     form1.Color:=clyellow;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =3 then begin
     screenLcd[1].color:=clwhite;
     screenLcd[2].color:=clwhite;
     screenLcd[3].color:=clwhite;
     screenLcd[4].color:=clwhite;
     form1.Color:=clwhite;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =4 then begin
     screenLcd[1].color:=backgroundcoloron;
     screenLcd[2].color:=backgroundcoloron;
     screenLcd[3].color:=backgroundcoloron;
     screenLcd[4].color:=backgroundcoloron;
     form1.Color:=backgroundcoloron;
     screenLcd[1].Font.Color:=forgroundcoloron;
     screenLcd[2].Font.Color:=forgroundcoloron;
     screenLcd[3].Font.Color:=forgroundcoloron;
     screenLcd[4].Font.Color:=forgroundcoloron;
   end;
 end
else
 begin
   if kleuren =0 then begin
     screenLcd[1].color:=clgreen;
     screenLcd[2].color:=clgreen;
     screenLcd[3].color:=clgreen;
     screenLcd[4].color:=clgreen;
     form1.Color:=clgreen;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =1 then begin
     screenLcd[1].color:=$00C00000;
     screenLcd[2].color:=$00C00000;
     screenLcd[3].color:=$00C00000;
     screenLcd[4].color:=$00C00000;
     form1.Color:=$00C00000;
     screenLcd[1].Font.Color:=clWhite;
     screenLcd[2].Font.Color:=clWhite;
     screenLcd[3].Font.Color:=clWhite;
     screenLcd[4].Font.Color:=clWhite;
   end else if kleuren =2 then begin
     screenLcd[1].color:=clOlive;
     screenLcd[2].color:=clOlive;
     screenLcd[3].color:=clOlive;
     screenLcd[4].color:=clOlive;
     form1.Color:=clOlive;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =3 then begin
     screenLcd[1].color:=clsilver;
     screenLcd[2].color:=clsilver;
     screenLcd[3].color:=clsilver;
     screenLcd[4].color:=clsilver;
     form1.Color:=clsilver;
     screenLcd[1].Font.Color:=clBlack;
     screenLcd[2].Font.Color:=clBlack;
     screenLcd[3].Font.Color:=clBlack;
     screenLcd[4].Font.Color:=clBlack;
   end else if kleuren =4 then begin
     screenLcd[1].color:=backgroundcoloroff;
     screenLcd[2].color:=backgroundcoloroff;
     screenLcd[3].color:=backgroundcoloroff;
     screenLcd[4].color:=backgroundcoloroff;
     form1.Color:=backgroundcoloroff;
     screenLcd[1].Font.Color:=forgroundcoloroff;
     screenLcd[2].Font.Color:=forgroundcoloroff;
     screenLcd[3].Font.Color:=forgroundcoloroff;
     screenLcd[4].Font.Color:=forgroundcoloroff;
   end;
 end;
end;

procedure TForm1.Showwindow1Click(Sender: TObject);
begin
  if popupmenu1.Items[3].caption='&Minimize' then begin
    button1.Click;
  end else begin
    form1.Show;
    form1.BringToFront;
    form1.SetFocus;
    //Application.ProcessMessages;
  end;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  form1.close();
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  popupmenu1.Items[3].caption:='Minimize';
  popupmenu1.Popup(form1.left+image1.left+round(image1.width/2),form1.top+image1.top+round(image1.height));
end;

// Only used when line scroll button is pressed.
procedure TForm1.scrollLine(line: Byte; direction: Integer);
begin
    screenLcd[line].caption:=StringReplace(scroll(parsedLine[line],line,direction),'&','&&',[rfReplaceAll]);
    tmpregel[line]:=copy(screenLcd[line].caption + '                                        ',1,config.width-1);
    Lcd.setPosition(1,line);
    Lcd.write(tmpregel[line]);
end;

// For scrolling right when a line scroll button is pressed.
procedure TForm1.Timer4Timer(Sender: TObject);
begin
  scrollLine(regel2scroll, 1);
end;

// For scrolling left when a line scroll button is pressed.
procedure TForm1.Timer5Timer(Sender: TObject);
begin
  scrollLine(regel2scroll, -1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  form1.formStyle:=fsNormal;
  form1.enabled:=false;
  form2.visible:=true;
  form2.SetFocus;
end;

procedure TForm1.Timer6Timer(Sender: TObject);
begin
  Data.updateMBMStats(Sender);
  timer6.Interval:=config.mbmRefresh*1000;
end;


procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  aantalscreensheenweer:=1;
  frozen:=true;
  freeze();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  popupmenu1.Items[3].caption:='Show Main';
  application.minimize;
  hide;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.minimize;
  hide;
  cooltrayicon1.HideTaskbarIcon;
  cooltrayicon1.enabled:=False;
  cooltrayicon1.IconVisible:=False;
  cooltrayicon1.Refresh;

  try
    while timer1.enabled=true do timer1.enabled:=false;
    while timer2.enabled=true do timer2.enabled:=false;
    while timer3.enabled=true do timer3.enabled:=false;
    while timer4.enabled=true do timer4.enabled:=false;
    while timer5.enabled=true do timer5.enabled:=false;
    while timer6.enabled=true do timer6.enabled:=false;
    while timer7.enabled=true do timer7.enabled:=false;
    while timer8.enabled=true do timer8.enabled:=false;
    while timer9.enabled=true do timer9.enabled:=false;
    while timer10.enabled=true do timer10.enabled:=false;
    while timer11.enabled=true do timer11.enabled:=false;
    while timer12.enabled=true do timer12.enabled:=false;
    while timer13.enabled=true do timer13.enabled:=false;
    while timertrans.enabled=true do timertrans.enabled:=false;
  except
  end;

  try
    if (Lcd <> nil) Then Lcd.Destroy();
  except
  end;

  if config.isHD then begin
    try
      poort1.clear;
    except end;
    try
      poort1.Free;
    except end;
  end;

  if config.isMO then begin
    sleep(500);
    try Vacomm1.close; except end;
  end;

  if config.isCF then begin
    Vacomm1.close;
  end;

  Data.Destroy;
  config.Destroy;
end;

procedure TForm1.Timer8Timer(Sender: TObject);
begin
  Data.updateGameStats;
  timer8.Interval:=config.gameRefresh*60000;
end;

procedure TForm1.Configure1Click(Sender: TObject);
begin
Showwindow1.click();
button2.click();
end;

procedure TForm1.Timer3Timer(Sender: TObject);
//ACTIONS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  teller:integer;
  todo: array[1..99] of string;
  temp1,temp2:string;

begin

  if (Lcd.readKey(kar)) then form2.Edit17.text:=kar;

if (form2<>nil) and (form2.Visible=false) then begin
  for teller := 1 to totalactions do begin
    if actionsarray[teller, 2] = '0' then begin
      try
        if StrToInt(Data.change(actionsarray[teller, 1])) > StrToInt(actionsarray[teller, 3]) then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
      except
        try
          if Data.change(actionsarray[teller, 1]) > actionsarray[teller, 3] then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
        except todo[teller]:=''; end;
      end;
    end;
    if actionsarray[teller, 2] = '1' then begin
      try
        if StrToInt(Data.change(actionsarray[teller, 1])) < StrToInt(actionsarray[teller, 3]) then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
      except
        try
          if Data.change(actionsarray[teller, 1]) < actionsarray[teller, 3] then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
        except todo[teller]:=''; end;
      end;
    end;
    if actionsarray[teller, 2] = '2' then begin
      try
        if StrToInt(Data.change(actionsarray[teller, 1])) = StrToInt(actionsarray[teller, 3]) then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
      except
        try
          if Data.change(actionsarray[teller, 1]) = actionsarray[teller, 3] then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
        except todo[teller]:=''; end;
      end;
    end;
    if actionsarray[teller, 2] = '3' then begin
      try
        if StrToInt(Data.change(actionsarray[teller, 1])) <= StrToInt(actionsarray[teller, 3]) then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
      except
        try
          if Data.change(actionsarray[teller, 1]) <= actionsarray[teller, 3] then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
        except todo[teller]:=''; end;
      end;
    end;
    if actionsarray[teller, 2] = '4' then begin
      try
        if StrToInt(Data.change(actionsarray[teller, 1])) >= StrToInt(actionsarray[teller, 3]) then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
      except
        try
          if Data.change(actionsarray[teller, 1]) >= actionsarray[teller, 3] then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
        except todo[teller]:=''; end;
      end;
    end;
    if actionsarray[teller, 2] = '5' then begin
      try
        if StrToInt(Data.change(actionsarray[teller, 1])) <> StrToInt(actionsarray[teller, 3]) then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
      except
        try
          if Data.change(actionsarray[teller, 1]) <> actionsarray[teller, 3] then todo[teller]:='1'+actionsarray[teller, 4] else todo[teller]:='2'+actionsarray[teller, 4];
        except todo[teller]:=''; end;
      end;
    end;
  end;

  for teller := 1 to totalactions do begin
    if pos('1NextTheme',todo[teller])<>0 then begin
      if didNextTheme[teller]=false then begin
        didNextTheme[teller]:=true;
        activetheme:=activetheme+1;
        if activetheme=10 then activetheme:= 0;
        frozen:=true;
        freeze();
      end;
    end;
    if pos('2NextTheme',todo[teller])<>0 then begin
      didNextTheme[teller]:=false;
    end;
    if pos('1LastTheme',todo[teller])<>0 then begin
      if didLastTheme[teller]=false then begin
        didLastTheme[teller]:=true;
        activetheme:=activetheme-1;
        if activetheme=-1 then activetheme:= 9;
        frozen:=true;
        freeze();
      end;
    end;
    if pos('2LastTheme',todo[teller])<>0 then begin
      didLastTheme[teller]:=false;
    end;
    if pos('1NextScreen',todo[teller])<>0 then begin
      if didNextScreen[teller]=false then begin
        didNextScreen[teller]:=true;
        aantalscreensheenweer:=1;
        frozen:=true;
        freeze();
      end;
    end;
    if pos('2NextScreen',todo[teller])<>0 then begin
      didNextScreen[teller]:=false;
    end;
    if pos('1LastScreen',todo[teller])<>0 then begin
      if didLastScreen[teller]=false then begin
        didLastScreen[teller]:=true;
        aantalscreensheenweer:=-1;
        frozen:=true;
        freeze();
      end;
    end;
    if pos('2LastScreen',todo[teller])<>0 then begin
      didLastScreen[teller]:=false;
    end;
    if pos('1GotoTheme(',todo[teller])<>0 then begin
      if didgototheme[teller]=false then begin
        didgototheme[teller]:=true;
        activetheme:=StrToInt(copy(todo[teller],pos('1GotoTheme(',todo[teller])+11,pos(')',todo[teller])-pos('1GotoTheme(',todo[teller])-11))-1;
      end;
    end;
    if pos('2GotoTheme',todo[teller])<>0 then begin
      didgototheme[teller]:=false;
    end;
    if pos('1GotoScreen(',todo[teller])<>0 then begin
      if didgotoscreen[teller]=false then begin
        didgotoscreen[teller]:=true;
        ChangeScreen(StrToInt(copy(todo[teller],pos('1GotoScreen(',todo[teller])+12,pos(')',todo[teller])-pos('1GotoScreen(',todo[teller])-12))-1);
      end;
    end;
    if pos('2GotoScreen',todo[teller])<>0 then begin
      didGotoscreen[teller]:=false;
    end;
    if pos('1FreezeScreen',todo[teller])<>0 then begin
      if didFreeze[teller]=false then begin
        didFreeze[teller]:=true;
        freeze();
      end;
    end;
    if pos('2FreezeScreen',todo[teller])<>0 then begin
      didFreeze[teller]:=false;
    end;
    if pos('1RefreshAll',todo[teller])<>0 then begin
      if didRefreshAll[teller]=false then begin
        didRefreshAll[teller]:=true;
        timer2.interval:=10;
        timer6.interval:=10;
        timer8.interval:=10;
        timer9.interval:=10;
        timer10.interval:=10;
      end;
    end;
    if pos('2RefreshAll',todo[teller])<>0 then begin
      didRefreshAll[teller]:=false;
    end;
    if pos('1Backlight(',todo[teller])<>0 then begin
      if didbl[teller]=false then begin
        didbl[teller]:=true;
        temp1:=copy(todo[teller],pos('(',todo[teller])+1,1);
        if temp1 = '1' then backlight := 0;
        if temp1 = '0' then backlight := 1;
        if (temp1 = '1') or (temp1 = '0') then backlit();
      end;
    end;
    if pos('2Backlight(',todo[teller])<>0 then begin
      if didbl[teller]=true then begin
        didbl[teller]:=false;
        temp1:=copy(todo[teller],pos('(',todo[teller])+1,1);
        if temp1 = '0' then backlight := 0;
        if temp1 = '1' then backlight := 1;
        if (temp1 = '1') or (temp1 = '0') then backlit();
      end;
    end;
    if pos('1BacklightToggle',todo[teller])<>0 then begin
      if didbltoggle[teller]=false then begin
        didbltoggle[teller]:=true;
        backlit();
      end;
    end;
    if pos('2BacklightToggle',todo[teller])<>0 then begin
      didbltoggle[teller]:=false;
    end;
    if pos('1BLFlash(',todo[teller])<>0 then begin
      if didflash[teller]=false then begin
        temp1:=copy(todo[teller],pos('(',todo[teller])+1,pos(')',todo[teller])-pos('(',todo[teller])-1);
        flash:=StrToInt(temp1)*2;
        didflash[teller]:=true;
      end;
    end;
    if pos('2BLFlash(',todo[teller])<>0 then begin
      didflash[teller]:=false;
    end;
    if pos('1Wave[',todo[teller])<>0 then begin
      temp1:=copy(todo[teller],pos('1Wave[',todo[teller])+6,pos(']',todo[teller])-pos('1Wave[',todo[teller])-6);
      if didsound[teller]=false then begin
        didsound[teller]:=true;
        playsound(Pchar(temp1),0,SND_FILENAME);
      end;
    end;
    if pos('2Wave[',todo[teller])<>0 then begin
      didsound[teller]:=false;
    end;
    if pos('1Exec[',todo[teller])<>0 then begin
      temp1:=copy(todo[teller],pos('1Exec[',todo[teller])+6,pos(']',todo[teller])-pos('1Exec[',todo[teller])-6);
      if didexec[teller]=false then begin
        didexec[teller]:=true;
        shellexecute(0,'open',PChar(temp1),'','',SW_SHOW);
      end;
    end;
    if pos('2Exec[',todo[teller])<>0 then begin
      didexec[teller]:=false;
    end;
    if pos('1WANextTrack',todo[teller])<>0 then begin
      if didwanexttrack[teller]=false then begin
        didwanexttrack[teller]:=true;
        Winampctrl1.Next;
      end;
    end;
    if pos('2WANextTrack',todo[teller])<>0 then begin
      didwanexttrack[teller]:=false;
    end;
    if pos('1WALastTrack',todo[teller])<>0 then begin
      if didwalasttrack[teller]=false then begin
        didwalasttrack[teller]:=true;
        Winampctrl1.Previous;
      end;
    end;
    if pos('2WALastTrack',todo[teller])<>0 then begin
      didwalasttrack[teller]:=false;
    end;
    if pos('1WAPlay',todo[teller])<>0 then begin
      if didwaPlay[teller]=false then begin
        didwaPlay[teller]:=true;
        Winampctrl1.Play;
      end;
    end;
    if pos('2WAPlay',todo[teller])<>0 then begin
      didwaplay[teller]:=false;
    end;
    if pos('1WAStop',todo[teller])<>0 then begin
      if didwaStop[teller]=false then begin
        didwaStop[teller]:=true;
        Winampctrl1.Stop;
      end;
    end;
    if pos('2WAStop',todo[teller])<>0 then begin
      didwastop[teller]:=false;
    end;
    if pos('1WAPause',todo[teller])<>0 then begin
      if didwaPause[teller]=false then begin
        didwaPause[teller]:=true;
        Winampctrl1.Pause;
      end;
    end;
    if pos('2WAPause',todo[teller])<>0 then begin
      didwaPause[teller]:=false;
    end;
    if pos('1WAShuffle',todo[teller])<>0 then begin
      if didwaShuffle[teller]=false then begin
        didwashuffle[teller]:=true;
        Winampctrl1.ToggleShufflE;
      end;
    end;
    if pos('2WAShuffle',todo[teller])<>0 then begin
      didwaShuffle[teller]:=false;
    end;
    if pos('1WAVolDown',todo[teller])<>0 then begin
      if didWAVolDown[teller]=false then begin
        didWAVolDown[teller]:=true;
        WinampCtrl1.VolumeDown;
        WinampCtrl1.VolumeDown;
        WinampCtrl1.VolumeDown;
        WinampCtrl1.VolumeDown;
        WinampCtrl1.VolumeDown;
      end;
    end;
    if pos('2WAVolDown',todo[teller])<>0 then begin
      didWAVolDown[teller]:=false;
    end;
    if pos('1WAVolUp',todo[teller])<>0 then begin
      if didWAVolUp[teller]=false then begin
        didWAVolUp[teller]:=true;
        WinampCtrl1.VolumeUp;
        WinampCtrl1.VolumeUp;
        WinampCtrl1.VolumeUp;
        WinampCtrl1.VolumeUp;
        WinampCtrl1.VolumeUp;
      end;
    end;
    if pos('2WAVolUp',todo[teller])<>0 then begin
      didWAVolUp[teller]:=false;
    end;
    if pos('1GPO(',todo[teller])<>0 then begin
      if didgpo[teller]=false then begin
        didgpo[teller]:=true;
        if config.isMO then begin
          try
            temp1:=copy(todo[teller],pos('(',todo[teller])+1,pos(',',todo[teller])-pos('(',todo[teller])-1);
            temp2:=copy(todo[teller],pos(',',todo[teller])+1,pos(')',todo[teller])-pos(',',todo[teller])-1);
            if (temp2 = '1') or (temp2 = '0') then doGPO(StrToInt(temp1), StrToInt(temp2));
          except end;
        end;
      end;
    end;
    if pos('2GPO(',todo[teller])<>0 then begin
      if didgpo[teller]=true then begin
        didgpo[teller]:=false;
        if config.isMO then begin
          try
            temp1:=copy(todo[teller],pos('(',todo[teller])+1,pos(',',todo[teller])-pos('(',todo[teller])-1);
            temp2:=copy(todo[teller],pos(',',todo[teller])+1,pos(')',todo[teller])-pos(',',todo[teller])-1);
            if temp2='1' then temp2:='0' else temp2:='1';
            if (temp2 = '1') or (temp2 = '0') then doGPO(StrToInt(temp1), StrToInt(temp2));
          except end;
        end;
      end;
    end;
    if pos('1GPOFlash(',todo[teller])<>0 then begin
      if didGPOFlash[teller]=false then begin
        didGPOFlash[teller]:=true;
        if config.isMO then begin
          try
            whatgpo:=StrToInt(copy(todo[teller],pos('(',todo[teller])+1,pos(',',todo[teller])-pos('(',todo[teller])-1));
            temp2:=copy(todo[teller],pos(',',todo[teller])+1,pos(')',todo[teller])-pos(',',todo[teller])-1);
            gpoflash:=StrToInt(temp2)*2;
          except end;
        end;
      end;
    end;
    if pos('2GPOFlash(',todo[teller])<>0 then begin
      didGPOFlash[teller]:=false;
    end;
    if pos('1GPOToggle(',todo[teller])<>0 then begin
      if didgpotoggle[teller]=false then begin
        try
          didgpotoggle[teller]:=true;
          temp1:=copy(todo[teller],pos('(',todo[teller])+1,pos(')',todo[teller])-pos('(',todo[teller])-1);
          dogpo(StrToInt(temp1),2)
        except end;
      end;
    end;
    if pos('2GPOToggle(',todo[teller])<>0 then begin
      didgpotoggle[teller]:=false;
    end;
    if pos('1Fan(',todo[teller])<>0 then begin
      if didMOFan[teller]=false then begin
        try
          didMOFan[teller]:=true;
          temp1:=copy(todo[teller],pos('(',todo[teller])+1,pos(',',todo[teller])-pos('(',todo[teller])-1);
          temp2:=copy(todo[teller],pos(',',todo[teller])+1,pos(')',todo[teller])-pos(',',todo[teller])-1);

          Lcd.setFan(StrToInt(temp1), StrToInt(temp2));

        except end;
      end;
    end;
    if pos('2Fan(',todo[teller])<>0 then begin
      didMOFan[teller]:=false;
    end;
  end;
end;
end;


procedure TForm1.Timer9Timer(Sender: TObject);
//MAILS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
begin
  timer9.Interval:=config.emailPeriod*60000;
  Data.UpdateEmail;
end;

procedure TForm1.BacklightOn1Click(Sender: TObject);
begin
  backlit();
end;

procedure TForm1.Timer10Timer(Sender: TObject);
begin
  Data.updateNetworkStats(Sender);
  timer10.interval:=1000;
end;


procedure TForm1.Timer7Timer(Sender: TObject);
//NEXT SCREEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Label opnieuwscreen;
var
  xx, x:integer;
  y: Integer;
  ascreen: TScreenLine;
  tmpscreen: Integer;

begin
  tmpScreen:=activeScreen;
  x:=0;
  xx:=0;
opnieuwscreen:
  x:=x+1;
  xx:=xx+1;
  if (config.randomScreens) and (x<500) then begin
    tmpScreen:=round(random(20)+1);
    if tmpScreen>20 then tmpScreen:=20;
    if tmpScreen<1 then tmpScreen:=1;
  end else begin
    tmpScreen:=tmpScreen+aantalscreensheenweer;
    if tmpScreen>20 then tmpScreen:=1;
    if tmpScreen<1 then tmpScreen:=20;
  end;

  if xx> 22 then begin
    activetheme:=activetheme+1;
    xx:=0;
  end;
  if (((x> 242) and (not config.randomScreens))
        or ((x> 1000) and (config.randomScreens))) then begin

    // It seems that we are in a endless loop because no screen is able to be
    // displayed.  Force screen 1 to be displayed.
    x:=0;

    for y:= 1 to 4 do begin
      config.screen[1][y].enabled:=True;
      config.screen[1][y].skip:=0;
      //config.screen[1][y].noscroll:=False;
    end;

    tmpScreen:=1;
    activetheme:=0;
  end;

  ascreen:= config.screen[tmpScreen][1];

  if (ascreen.theme <> activetheme) then goto opnieuwscreen;
  if (not ascreen.enabled) then goto opnieuwscreen;
  if (ascreen.skip = 1) and (winampctrl1.GetSongInfo(1) = 0) then goto opnieuwscreen;
  if (ascreen.skip = 2) and (winampctrl1.GetSongInfo(1) <> 0) then goto opnieuwscreen;
  if (ascreen.skip = 3) and (not Data.mbmactive) then goto opnieuwscreen;
  if (ascreen.skip = 4) and (Data.mbmactive) then goto opnieuwscreen;
  if (ascreen.skip = 7) and (not Data.isconnected) then goto opnieuwscreen;
  if (ascreen.skip = 8) and (Data.isconnected) then goto opnieuwscreen;
  if (ascreen.skip = 5) and (not Data.gotEmail) then goto opnieuwscreen;
  if (ascreen.skip = 6) and (Data.gotEmail) then goto opnieuwscreen;

  if timertransIntervaltemp <> 0 then timertrans.Interval:=timertransIntervaltemp;

  gotnewlines:=false;
  TransCycle:=0;
  foo2:=0;



  for x:=1 to 4 do begin
    oldline[x]:=screenLcd[x].Caption;
  end;

  for x:=1 to 40 do begin
    gokjesarray[1,x]:=false;
    gokjesarray[2,x]:=false;
    gokjesarray[3,x]:=false;
    gokjesarray[4,x]:=false;
  end;

  timer7.Interval:=ascreen.showTime*1000+timertransIntervaltemp;
  aantalscreensheenweer:=1;

  timertransIntervaltemp:=ascreen.interactionTime*100;
  transActietemp:=transActietemp2;
  transActietemp2:=ascreen.interaction;

  if not ascreen.enabled then transActietemp2:=0;
  if transActietemp2=0 then timertransIntervaltemp:=1;

  if (config.width=40) then begin
    panel5.left:=135;
    panel5.width:=100;
    Panel5.Caption:='Theme:' + IntToStr(activetheme+1) + ' Screen:' + IntToStr(tmpScreen)+'  ';
  end else begin
    panel5.left:=90;
    panel5.width:=33;
    Panel5.Caption:=IntToStr(activetheme+1) + ' | ' + IntToStr(tmpScreen) + '  ';
  end;

  if (activeScreen<>tmpScreen) then begin
    ChangeScreen(tmpScreen); // changes activeScreen
    timertrans.Enabled:=True;
  end;
end;

procedure TForm1.Timer11Timer(Sender: TObject);
begin
  poort1 := TParPort.Create($+config.parallelPort,config.width, config.height); //hex waarde v/d poort
  Lcd:=TLCD_HD.Create();
  Lcd.setbacklight(true);

  customchar('1,12,18,18,12,0,0,0,0');
  customchar('2,31,31,31,31,31,31,31,31');
  customchar('3,16,16,16,16,16,16,31,16');
  customchar('4,28,28,28,28,28,28,31,28');
  customchar('1,12,18,18,12,0,0,0,0');
  customchar('2,31,31,31,31,31,31,31,31');
  customchar('3,16,16,16,16,16,16,31,16');
  customchar('4,28,28,28,28,28,28,31,28');

  timer1.enabled:=true;
  timer2.enabled:=true;
  timer3.enabled:=true;
  timer6.enabled:=true;
  timer7.enabled:=true;
  timer8.enabled:=true;
  timer9.enabled:=true;
  timer10.enabled:=true;
  timer11.Enabled:=false;
  timer12.enabled:=true;
  timer13.enabled:=true;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canclose:=true;
end;

procedure TForm1.Credits1Click(Sender: TObject);
begin
  form1.formStyle:=fsNormal;
  form1.enabled:=false;
  form4.visible:=true;
  form4.BringToFront;
end;

procedure TForm1.NextTheme1Click(Sender: TObject);
begin
  activetheme:=activetheme+1;
  if activetheme=10 then activetheme:= 0;
  frozen:=true;
  freeze();
end;

procedure TForm1.LastTheme1Click(Sender: TObject);
begin
  activetheme:=activetheme-1;
  if activetheme=-1 then activetheme:= 9;
  frozen:=true;
  freeze();
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
  form1.formStyle:=fsNormal;
  form1.enabled:=false;
  form4.visible:=true;
  form4.BringToFront;
end;

procedure TForm1.Freeze1Click(Sender: TObject);
begin
freeze();
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if upcase(key)='Z' then winampctrl1.Previous;
  if upcase(key)='X' then winampctrl1.Play;
  if upcase(key)='C' then winampctrl1.Pause;
  if upcase(key)='V' then winampctrl1.Stop;
  if upcase(key)='B' then winampctrl1.Next;
  if upcase(key)='N' then backlit();
  if upcase(key)='M' then freeze();
  if upcase(key)='K' then begin
    activetheme:=activetheme-1;
    if activetheme=-1 then activetheme:= 9;
    frozen:=true;
    freeze();
  end;
  if upcase(key)='L' then begin
    activetheme:=activetheme+1;
    if activetheme=10 then activetheme:= 0;
    frozen:=true;
    freeze();
  end;
  if upcase(key)=',' then speedbutton1.click();
  if upcase(key)='.' then speedbutton10.click();
  if (upcase(key)='?') or (upcase(key)='/') then begin
    form1.timer2.interval:=10;
    form1.timer8.interval:=10;
    form1.timer9.interval:=10;
    form1.timer6.interval:=10;
  end;
end;

procedure TForm1.freeze();
begin
  if frozen=false then begin
    frozen:=true;
    form1.timer7.enabled:=false;
    popupmenu1.Items[0].Items[1].Caption:='Unfreeze';
    form1.caption:=form1.caption + ' - frozen'
  end else begin
    frozen:=false;
    form1.timer7.enabled:=true;
    form1.timer7.interval:=5;
    popupmenu1.Items[0].Items[1].Caption:='Freeze';
    if pos('frozen', form1.caption) <> 0 then
      form1.caption:=copy(form1.caption,1, length(form1.caption)-length(' - frozen'));
  end;
end;

procedure TForm1.Image12MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image12.picture.LoadFromFile(extractfilepath(application.exename)+'images\big_arrow_left_up.bmp');
end;

procedure TForm1.Image12MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image12.picture.LoadFromFile(extractfilepath(application.exename)+'images\big_arrow_left_down.bmp');
end;

procedure TForm1.Image16MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image16.picture.LoadFromFile(extractfilepath(application.exename)+'images\setup_down.bmp');
end;

procedure TForm1.Image16MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image16.picture.LoadFromFile(extractfilepath(application.exename)+'images\setup_up.bmp');
end;

procedure TForm1.Image17MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image17.picture.LoadFromFile(extractfilepath(application.exename)+'images\hide_down.bmp');
end;

procedure TForm1.Image17MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image17.picture.LoadFromFile(extractfilepath(application.exename)+'images\hide_up.bmp');
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_down1.bmp');
  regel2scroll:=1;
  timer5.enabled:=true;
  timer1.enabled:=false;
end;

procedure TForm1.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_up1.bmp');
  timer5.enabled:=false;
  timer1.enabled:=true;
end;

procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image4.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_down2.bmp');
  regel2scroll:=2;
  timer5.enabled:=true;
  timer1.enabled:=false;
end;

procedure TForm1.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image5.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_down3.bmp');
  regel2scroll:=3;
  timer5.enabled:=true;
  timer1.enabled:=false;
end;

procedure TForm1.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image6.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_down4.bmp');
  regel2scroll:=4;
  timer5.enabled:=true;
  timer1.enabled:=false;
end;

procedure TForm1.Image7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image7.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_down1.bmp');
  regel2scroll:=1;
  timer4.enabled:=true;
end;

procedure TForm1.Image8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image8.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_down2.bmp');
  regel2scroll:=2;
  timer4.enabled:=true;
end;

procedure TForm1.Image9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image9.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_down3.bmp');
  regel2scroll:=3;
  timer4.enabled:=true;
end;

procedure TForm1.Image10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image10.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_down4.bmp');
  regel2scroll:=4;
  timer4.enabled:=true;
end;

procedure TForm1.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image4.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_up2.bmp');
  timer5.enabled:=false;
  timer1.enabled:=true;
end;

procedure TForm1.Image5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image5.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_up3.bmp');
  timer5.enabled:=false;
  timer1.enabled:=true;
end;

procedure TForm1.Image6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image6.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_left_up4.bmp');
  timer5.enabled:=false;
  timer1.enabled:=true;
end;

procedure TForm1.Image7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image7.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_up1.bmp');
  timer4.enabled:=false;
end;

procedure TForm1.Image8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image8.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_up2.bmp');
  timer4.enabled:=false;
end;

procedure TForm1.Image9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image9.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_up3.bmp');
  timer4.enabled:=false;
end;

procedure TForm1.Image10MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image10.picture.LoadFromFile(extractfilepath(application.exename)+'images\small_arrow_right_up4.bmp');
  timer4.enabled:=false;
end;

procedure TForm1.Image11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image11.picture.LoadFromFile(extractfilepath(application.exename)+'images\big_arrow_right_down.bmp');
end;

procedure TForm1.Image11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image11.picture.LoadFromFile(extractfilepath(application.exename)+'images\big_arrow_right_up.bmp');
end;

procedure TForm1.Image12Click(Sender: TObject);
begin
  speedbutton1.click;
end;

procedure TForm1.Image11Click(Sender: TObject);
begin
  speedbutton10.click;
end;

procedure TForm1.Image17Click(Sender: TObject);
begin
  button1.click;
end;

procedure TForm1.Image16Click(Sender: TObject);
begin
  if timer11.enabled = false then button2.click;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  aantalscreensheenweer:=-1;
  frozen:=true;
  freeze();
end;

procedure tform1.dogpo(const ftemp1,ftemp2:integer);
begin
  if ftemp1 < 9 then begin
    if ftemp2=0 then begin
      Lcd.setGPO(ftemp1, false);
      gpo[ftemp1]:=false;
    end;
    if ftemp2=1 then begin
      Lcd.setGPO(ftemp1, true);
      gpo[ftemp1]:=true;
    end;
    if ftemp2=2 then begin
      if (gpo[ftemp1]) then begin
        Lcd.setGPO(ftemp1, false);
        gpo[ftemp1]:=false;
      end else begin
        Lcd.setGPO(ftemp1, true);
        gpo[ftemp1]:=true;
      end;
    end;
  end;
end;

procedure TForm1.Timer13Timer(Sender: TObject);
begin
  timer13.Interval:=config.scrollPeriod;
  Data.dllcancheck:=true;
end;

procedure TForm1.WMQueryEndSession (var M: TWMQueryEndSession);
begin
  inherited;
  form1.Close;
end;
procedure TForm1.TimertransTimer(Sender: TObject);
begin
  timertrans.Enabled:=false;
end;

procedure TForm1.Timer12Timer(Sender: TObject);
begin
  timer12.Interval:=config.scrollPeriod;
  canscroll:=true;
  canflash:=true;
end;

end.

