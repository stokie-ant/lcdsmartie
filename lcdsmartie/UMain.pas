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
 *  $Revision: 1.36 $ $Date: 2005/01/02 21:37:37 $
 *****************************************************************************}

interface

uses Messages, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdPOP3,  CoolTrayIcon, Menus,
  WinampCtrl, ExtCtrls, Controls, StdCtrls, Buttons, Classes, Forms, 
  UConfig, ULCD, UData, xmldom, XMLIntf, msxmldom, XMLDoc;

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
    WinAmpTimer: TTimer;
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
    procedure Image12MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image12MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image16MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image16MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image17MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image17MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image7MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image8MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image10MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image7MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image8MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image9MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image10MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image11MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Image12Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image17Click(Sender: TObject);
    procedure Image16Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer13Timer(Sender: TObject);
    procedure TimertransTimer(Sender: TObject);
    procedure Timer12Timer(Sender: TObject);
    procedure WMQueryEndSession (var M: TWMQueryEndSession); message
      WM_QUERYENDSESSION;
    procedure WMPowerBroadcast (var M: TMessage); message WM_POWERBROADCAST;
    procedure kleur();
    procedure ChangeScreen(scr: Integer);
    procedure WinAmpTimerCheck(Sender: TObject);
    procedure customchar(fline: String);
  private
    screenLcd: Array[1..4] of ^TPanel;
    canflash: Boolean;
    iNrLines, foo2: Integer;
    didAction: Array [1..99] of Boolean;
    file1: String;
    kleuren: Integer;
    parsedLine: Array[1..4] of String;
    scrollPos: Array[1..4] of Integer;
    line2scroll: Integer;
    tmpline: Array [1..4] of String;
    forgroundcoloroff, forgroundcoloron, backgroundcoloroff,
      backgroundcoloron: Integer;
    Oldline: Array[1..4] of String;
    Newline: Array[1..4] of String;
    Gotnewlines: Boolean;
    transActietemp, transActietemp2, TransCycle,
      timertransIntervaltemp: Integer;
    gamesArray: Array[1..4, 1..40] of Boolean;
    activetheme: Integer; canscroll: Boolean;
    gpo: Array [1..8] of Boolean;
    customChars: Array [1..8, 0..7] of Byte;
    customCharsChanged: Array [1..8] of Boolean;
    doesgpoflash: Boolean;
    gpoflash, whatgpo: Integer;
    flash: Integer;
    ResetContrast: Boolean;
    flashdelay: Cardinal;
    bNewScreen: Boolean;
    function doguess(line: Integer): Integer;
    procedure freeze();
    procedure doGPO(const ftemp1, ftemp2: Integer);
    function scroll(const scrollvar: String;const line, speed: Integer):
      String;
    procedure scrollLine(line: Byte; direction: Integer);
    procedure doInteractions;
    procedure OnMinimize(Sender: TObject);
    procedure backlit(iOn: Integer = -1);
    function EscapeAmp(const sStr: string):String;
    function UnescapeAmp(const sStr: string): String;
    procedure SendCustomChars;
    procedure ProcessAction(bDoAction: Boolean; sAction: String);
  end;

var
  Lcd: TLCD;
  doesflash: Boolean;
  Form1: TForm1;
  backlight: Integer;
  config: TConfig;
  parameter1, parameter2, parameter3, parameter4 : String;
  Data: TData;
  frozen: Boolean;
  tempscreen: Integer;
  key: char;
  activeScreen : Integer;
  aantalscreensheenweer: Integer;
  combobox8temp: Integer;


implementation

uses Registry, Windows, SysUtils, Graphics, Dialogs, ShellAPI, mmsystem,
  USetup, UCredits, ULCD_MO, ULCD_CF, ULCD_HD, ExtActns, UUtils;

function TForm1.EscapeAmp(const sStr: string): String;
begin
  Result := StringReplace(sStr, '&', '&&', [rfReplaceAll])
end;

function TForm1.UnescapeAmp(const sStr: string): String;
begin
  Result := StringReplace(sStr, '&&', '&', [rfReplaceAll])
end;

procedure TForm1.WMPowerBroadcast (var M: TMessage);
const
  PBT_APMRESUMECRITICAL = 6;
  PBT_APMRESUMESUSPEND = 7;
  PBT_APMRESUMESTANDBY = 8;
  PBT_APMRESUMEAUTOMATIC = $012;
var
  x: Integer;
begin
  if (M.WParam = PBT_APMRESUMEAUTOMATIC) or (M.WParam = PBT_APMRESUMECRITICAL)
    or (M.WParam = PBT_APMRESUMESTANDBY) or (M.WParam = PBT_APMRESUMESUSPEND)
    then
  begin
    if Assigned(Lcd) then Lcd.powerResume;

    // Wipe the virtual display
    for x := 1 to config.height do
    begin
      screenLcd[x].Caption := '';
    end;

  end;
end;

procedure TForm1.ChangeScreen(scr: Integer);
var
  y: Integer;
  ascreen: TScreenLine;
begin

  if timertransIntervaltemp <> 0 then
  begin
    timertrans.Interval := 0;
    timertrans.Interval := timertransIntervaltemp;
  end;
  timer7.Interval := 0; // reset timer

  if (not config.screen[scr][1].bSticky) then
    timer7.Interval := config.screen[scr][1].showTime*1000 + timertransIntervaltemp;

  if (activeScreen = scr) then
    Exit;

  activeScreen := scr;
  ascreen := config.screen[activeScreen][1];

  for y := 1 to 4 do
  begin
    scrollPos[y] := 0; // Reset scroll postion.
    oldline[y] := UnescapeAmp(screenLcd[y].Caption);
  end;

  gotnewlines := false;
  TransCycle := 0;
  foo2 := 0;

  for y := 1 to 40 do
  begin
    gamesArray[1, y] := false;
    gamesArray[2, y] := false;
    gamesArray[3, y] := false;
    gamesArray[4, y] := false;
  end;

  timertransIntervaltemp := ascreen.interactionTime*100;

  transActietemp := transActietemp2;
  transActietemp2 := ascreen.interaction;

  if not ascreen.enabled then transActietemp2 := 0;
  if transActietemp2 = 0 then timertransIntervaltemp := 1;

  if (config.width = 40) then
  begin
    panel5.left := 115;
    panel5.width := 130;
    Panel5.Caption := 'Theme: ' + IntToStr(activetheme + 1) + ' Screen: ' +
      IntToStr(activeScreen);
  end
  else
  begin
    panel5.left := 87;
    panel5.width := 33;
    Panel5.Caption := IntToStr(activetheme + 1) + ' | ' + IntToStr(activeScreen);
  end;

  bNewScreen := True;
  data.bNewScreenEvent := True;

end;

function TForm1.doguess(line: Integer): Integer;
var
  goedgokje: Boolean;
  x: Integer;
  loopcount: Integer;

begin
  goedgokje := false;
  x := 0;
  loopcount := 0;

  while goedgokje = false do
  begin
    Inc(loopcount);
    x := round(random(config.width) + 1);
    if gamesArray[line, x] = false then
    begin
      goedgokje := true;
    end
    else
      if (loopcount > config.width*2) then
      begin
      // it's taking too long - use first unset element
        x := 0;
        repeat
          Inc(x);
          if (gamesArray[line, x] = false) then goedgokje := true;
        until (x >= config.width) or (goedgokje);
        if (not goedgokje) then
        begin
        // all the elements are set - use 1 (arb.)
          x := 1;
          goedgokje := true;
        end;
      end;
  end;
  gamesArray[line, x] := true;
  result := x;
end;

procedure TForm1.customchar(fline: String);
var
  character: Integer;
  waarde: Array[0..7] of Byte;
  i: Integer;

begin
  character := StrToInt(copy(fline, 1, pos(',', fline)-1));
  fline := copy(fline, pos(',', fline) + 1, length(fline));
  for i := 0 to 6 do
  begin
    waarde[i] := StrToInt(copy(fline, 1, pos(',', fline)-1));
    fline := copy(fline, pos(',', fline) + 1, length(fline));
  end;
  waarde[7] := StrToInt(copy(fline, 1, length(fline)));

  // Only send if not already defined.
  i := 0;
  while (i <= 7) and (waarde[i] = customChars[character, i]) do Inc(i);

  if (i <= 7) then
  begin
    //Lcd.customChar(character, waarde);
    customCharsChanged[character] := true;
    for i := 0 to 7 do customChars[character, i] := waarde[i];
  end;
end;

procedure TForm1.SendCustomChars;
var
  i: Integer;
begin
  for i:= 1 to 8 do
  begin
    if (customCharsChanged[i]) then
    begin
      Lcd.customChar(i, customChars[i]);
      customCharsChanged[i] := false;
    end;
  end;
end;



function TForm1.scroll(const scrollvar: String;const line, speed: Integer):
  String;
var
  scrolltext: String;
  len: Integer;
begin

  if length(scrollvar) > config.width then
  begin
    scrollPos[line] := scrollPos[line] + speed;
    if (scrollPos[line]>length(scrollvar)) then scrollPos[line] := 1;

    len := length(scrollvar)-scrollPos[line] + 1;
    if (len > config.width) then len := config.width;
    scrolltext := copy(scrollvar, scrollPos[line], len);

    if length(scrolltext) < config.width then
    begin
      scrolltext := scrolltext + copy(scrollvar, 1,
        config.width-length(scrolltext));
    end;
    result := scrolltext;

  end
  else result := scrollvar;
end;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
const
  baudRates: array [0..14] of Cardinal =(CBR_110, CBR_300, CBR_600, CBR_1200, CBR_2400,
    CBR_4800, CBR_9600, CBR_14400, CBR_19200, CBR_38400, CBR_56000, CBR_57600,
    CBR_115200, CBR_128000, CBR_256000);
var
  line: String;
  initfile: textfile;

begin
  Randomize;

  Application.OnMinimize := OnMinimize;

  SetCurrentDir(extractfilepath(application.exename));
  CreateDirectory('cache', nil);

  screenLcd[1] := @Panel1;
  screenLcd[2] := @Panel2;
  screenLcd[3] := @Panel3;
  screenLcd[4] := @Panel4;


//SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW and not W
//S_EX_APPWINDOW );
  try
    line := extractfilepath(application.exename);
    image1.picture.LoadFromFile(line + 'images\logo.bmp');
    image3.picture.LoadFromFile(line + 'images\small_arrow_left_up1.bmp');
    image4.picture.LoadFromFile(line + 'images\small_arrow_left_up2.bmp');
    image5.picture.LoadFromFile(line + 'images\small_arrow_left_up3.bmp');
    image6.picture.LoadFromFile(line + 'images\small_arrow_left_up4.bmp');
    image7.picture.LoadFromFile(line + 'images\small_arrow_right_up1.bmp');
    image8.picture.LoadFromFile(line + 'images\small_arrow_right_up2.bmp');
    image9.picture.LoadFromFile(line + 'images\small_arrow_right_up3.bmp');
    image10.picture.LoadFromFile(line + 'images\small_arrow_right_up4.bmp');
    image11.picture.LoadFromFile(line + 'images\big_arrow_right_up.bmp');
    image12.picture.LoadFromFile(line + 'images\big_arrow_left_up.bmp');
    image13.picture.LoadFromFile(line + 'images\bar_left.bmp');
    image14.picture.LoadFromFile(line + 'images\bar_right.bmp');
    image15.picture.LoadFromFile(line + 'images\bar_middle.bmp');
    image16.picture.LoadFromFile(line + 'images\setup_up.bmp');
    image17.picture.LoadFromFile(line + 'images\hide_up.bmp');
    cooltrayicon1.Icon.LoadFromFile(line + 'images\smartie.ico');
    application.Icon.LoadFromFile(line + 'images\smartie.ico');
    cooltrayicon1.Refresh;
  except
    on E: Exception do
    begin
      showmessage('Error: unable to access images subdirectory: ' +
        E.Message);
      application.terminate;
    end;
  end;
  form1.color := $00BFBFBF;

  parameter1 := lowercase(paramstr(1));
  parameter2 := lowercase(paramstr(2));
  parameter3 := lowercase(paramstr(3));
  parameter4 := lowercase(paramstr(4));
  aantalscreensheenweer := 1;


//register
  try
    assignfile(initfile, extractfilepath(application.exename) +
      'images\colors.cfg');
    reset(initfile);
    readln(initfile, line);
    panel5.Color := StrToInt('$00' + copy(line, 1, 6));
    readln(initfile, line);
    panel5.font.Color := StrToInt('$00' + copy(line, 1, 6));
    readln(initfile, line);
    forgroundcoloron := StrToInt('$00' + copy(line, 1, 6));
    readln(initfile, line);
    backgroundcoloron := StrToInt('$00' + copy(line, 1, 6));
    readln(initfile, line);
    forgroundcoloroff := StrToInt('$00' + copy(line, 1, 6));
    readln(initfile, line);
    backgroundcoloroff := StrToInt('$00' + copy(line, 1, 6));
    closefile(initfile);
  except
    on E: Exception do
    begin
      showmessage('Fatal Error:  Can`t find images\colors.cfg: ' + E.Message);
      application.Terminate;
    end;
  end;

  config := TConfig.Create();

  if (config.load() = false) then
  begin
    showmessage('Fatal Error:  Failed to load configuration');
    application.Terminate;
  end;

  Data := TData.Create();

  form1.WinampCtrl1.WinampLocation := config.winampLocation;
  file1 := config.distLog;

  iNrLines := config.height;

  screenLcd[2].visible := false;
  screenLcd[3].visible := false;
  screenLcd[4].visible := false;
  image4.enabled := false;
  image5.enabled := false;
  image6.enabled := false;
  image8.enabled := false;
  image9.enabled := false;
  image10.enabled := false;
  if config.height > 1 then
  begin
    screenLcd[2].visible := true;
    image4.enabled := true;
    image8.enabled := true;
  end;
  if config.height > 2 then
  begin
    screenLcd[3].visible := true;
    image5.enabled := true;
    image9.enabled := true;
  end;
  if config.height > 3 then
  begin
    screenLcd[4].visible := true;
    image6.enabled := true;
    image10.enabled := true;
  end;

  kleuren := config.colorOption;
  backlight := 1;
  kleur();

  // ensure start up position is sensible
  if form1.left < 0 then form1.left := 0;
  if form1.top < 0 then form1.top := 0;
  if form1.left + form1.Width > screen.desktopwidth then form1.left :=
    screen.desktopwidth-form1.width;
  if form1.top + form1.height > screen.desktopheight then form1.top :=
    screen.desktopheight-form1.height;

  if (config.isMO) or (config.isCF) then
  begin
    try
      if (config.isMO) and (config.isUsbPalm) then
      begin
        Lcd := TLCD_MO.CreateUsb;
      end
      else
      begin

        if (config.isCF) then
          Lcd := TLCD_CF.CreateSerial(config.comPort, baudRates[config.baudrate])
        else if (config.isMO) then
          Lcd := TLCD_MO.CreateSerial(config.comPort, baudRates[config.baudrate]);
      end;
    except
      on E: Exception do
      begin
        showmessage('Failed to open device: ' + E.Message);
        Lcd := TLCD.Create();

      end;
    end;
  end;

  if not (config.isCF or config.isMO or config.isHD) then
    Lcd := TLCD.Create();

  if (config.isMO) or (config.isCF) then
  begin
    customchar('1, 12, 18, 18, 12, 0, 0, 0, 0');
    customchar('2, 31, 31, 31, 31, 31, 31, 31, 31');
    customchar('3, 16, 16, 16, 16, 16, 16, 31, 16');
    customchar('4, 28, 28, 28, 28, 28, 28, 31, 28');
  end;

  if (config.isMO) then
  begin
    Lcd.setContrast(config.contrast);
    Lcd.setBrightness(config.brightness);
  end;

  if (config.isCF) then
  begin
    customchar('7, 4, 4, 4, 4, 4, 4, 4, 0');
    customchar('8, 14, 17, 1, 13, 21, 21, 14, 0');

    Lcd.setBrightness(config.CF_brightness);
    Lcd.setContrast(config.CF_contrast);
  end;

    //
    // Enable the timers...
    //
  if (not config.isHD) and (not config.isHD2) then
  begin
    timer1.enabled := true;
    timer2.enabled := true;
    timer3.enabled := true;
    timer6.enabled := true;
    timer7.enabled := true;
    timer8.enabled := true;
    timer9.enabled := true;
    timer10.enabled := true;
    timer12.enabled := true;
    timer13.enabled := true;
  end
  else
  begin
      // HD/HD2 have a delay start - they will setup the above timers later.
    if config.bootDriverDelay = 0 then timer11.interval := 10
    else timer11.interval := config.bootDriverDelay*1000;
    timer11.enabled := true;
  end;

  ChangeScreen(1);

end;

procedure TForm1.doInteractions;
var
  gokreg: Array[1..4] of String;
  tempstr: String;
  line: Integer;
  maxTransCycles: Integer;
  gokje: Integer;
  x: Integer;
  iContrast: Integer;

begin
  // Changing screen - do any interactions required.
  TransCycle := TransCycle + 1;
  maxTransCycles := timertrans.Interval div timer1.Interval;

  if (TransCycle > maxTransCycles) then Exit;

  for x := 1 to config.height do
  begin
    oldline[x] := copy(oldline[x] +
      '                                        ', 1, config.width);
    newline[x] := copy(newline[x] +
      '                                        ', 1, config.width);
  end;

  if transActietemp = 1 then
  begin                           //left-->right

    for x := 1 to config.height do
    begin
      tempstr := copy(newline[x] + '|' + oldline[x], round((config.width +
        2)-TransCycle*((config.width + 2)/maxTransCycles)), config.width);
      screenLcd[x].Caption := EscapeAmp(tempstr);
    end;

  end
  else
    if transActietemp = 2 then
    begin                                  //right-->left

      for x := 1 to config.height do
      begin
        tempstr := copy(oldline[x] + '|' + newline[x],
          round(TransCycle*((config.width + 2)/maxTransCycles)),
          config.width);
        screenLcd[x].Caption := EscapeAmp(tempstr);
      end;

    end
    else
      if transActietemp = 3 then
      begin                                //top-->bottom

        line := round(TransCycle*(config.height/maxTransCycles)) + 1;
        for x := 1 to line-1 do
        begin
          screenLcd[x].Caption := EscapeAmp(newline[config.height-(line-1)+ x]);
        end;

        if (line <= config.height) then
          screenLcd[line].Caption :=
            copy('----------------------------------------', 1, config.width);

        for x := line + 1 to config.height do
        begin
          screenLcd[x].Caption := EscapeAmp(oldline[x-(line + 1) + 1]);
        end;

      end
      else
        if transActietemp = 4 then
        begin                              //bottom-->top

          line := round(TransCycle*(config.height/maxTransCycles)) + 1;
          for x := 1 to config.height-line do
          begin
            screenLcd[x].Caption := EscapeAmp(oldline[x + line-1]);
          end;

          if (config.height-line + 1 > 0) then
            screenLcd[config.height-line + 1].Caption :=
              copy('----------------------------------------', 1, config.width);

          for x := config.height-line + 2 to config.height do
          begin
            screenLcd[x].Caption :=
              EscapeAmp(newline[x-(config.height-line + 2) + 1]);
          end;

        end
        else
          if transActietemp = 5 then
          begin                            //random blocks

            for x := 1 to 4 do
            begin
              gokreg[x] := copy(UnescapeAmp(screenLcd[x].caption) +
                '                                        ', 1, config.width);
            end;

            for x := round((config.width/maxTransCycles)*(TransCycle-1)) to
              round((config.width/maxTransCycles)*TransCycle)-1 do
            begin
              for line := 1 to 4 do
              begin
                gokje := doguess(line);
                gokreg[line] := copy(gokreg[line], 1, gokje-1) +
                  copy(newline[line], gokje, 1) + copy(gokreg[line], gokje +
                  1, config.width-gokje);
              end;
            end;
            for x := 1 to 4 do
            begin
              screenLcd[x].caption := EscapeAmp(gokreg[x]);
            end;

          end
          else
            if (transActietemp = 6) and (maxTransCycles >= 2) then
            begin                                                    //contrast fade
    // The fade is a two step process, so we need at least two cycles.

    // We only fade down to iMinFadeContrast; because many LCDs displays will be
    // blank long before we reach 0. (One user reported that their display was
    // blank at a contrast of 40).

    // For the first half of the cycles - lower the contrast

              if (TransCycle < maxTransCycles/2) then
              begin
                if (config.isMO)then x := config.contrast
                else x := config.CF_contrast;

                iContrast := round(x-(TransCycle*(x-config.iMinFadeContrast)
                  / (MaxTransCycles/2)));


                if iContrast < config.iMinFadeContrast then
                  iContrast := config.iMinFadeContrast
                else
                  if iContrast > x then iContrast := x;
                Lcd.setContrast(iContrast);
              end
              else
              begin
      // raise the contrast over the second half

                for x := 1 to 4 do
                begin
                  screenLcd[x].Caption := EscapeAmp(newline[x]);
                end;

                if (config.isMO) then x := config.contrast
                else x := config.CF_contrast;

                iContrast := round((TransCycle-(MaxTransCycles/2))
                  * (x-config.iMinFadeContrast)/(MaxTransCycles/2))
                  + config.iMinFadeContrast;

                if iContrast > x then iContrast := x
                else
                  if iContrast < config.iMinFadeContrast then
                    iContrast := config.iMinFadeContrast;
                Lcd.setContrast(iContrast);
              end;
              ResetContrast := True;// Just to be sure the contrast is back to correct levels.
            end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
  counter, h: Integer;
  line: String;
  scrollcount: Integer;

begin
  timer1.Interval := 0;
  timer1.Interval := config.refreshRate;

  // BUGBUG: Surely there's a better place for this parameter code
  // BUT it can't go in FormCreate or FormShow because it either
  // doesn't work (FormCreate) or causes an exception (FormShow).
  if (parameter1= '-hide') or (parameter2= '-hide') or (parameter3= '-hide')
    or (parameter4= '-hide') then
  begin
    if parameter1 = '-hide' then parameter1 :=  '';
    if parameter2 = '-hide' then parameter2 :=  '';
    if parameter3 = '-hide' then parameter3 :=  '';
    if parameter4 = '-hide' then parameter4 :=  '';
    application.minimize;
    coolTrayIcon1.HideMainForm;
  end;

  if (parameter1= '-totalhide') or (parameter2= '-totalhide') or (parameter3=
    '-totalhide') or (parameter4= '-totalhide') then
  begin
    if parameter1 = '-totalhide' then parameter1 :=  '';
    if parameter2 = '-totalhide' then parameter2 :=  '';
    if parameter3 = '-totalhide' then parameter3 :=  '';
    if parameter4 = '-totalhide' then parameter4 :=  '';
    application.minimize;
    coolTrayIcon1.HideMainForm;
    cooltrayicon1.HideTaskbarIcon;
    cooltrayicon1.enabled := False;
    cooltrayicon1.IconVisible := False;
    cooltrayicon1.Refresh;
  end;

  if ((gotnewlines = false) OR (timertrans.enabled = false))then
  begin
    if (bNewScreen) and (gotnewlines) then
    begin
       bNewScreen := False;
       customchar('1, 12, 18, 18, 12, 0, 0, 0, 0');
       customchar('2, 31, 31, 31, 31, 31, 31, 31, 31');
       customchar('3, 16, 16, 16, 16, 16, 16, 31, 16');
       customchar('4, 28, 28, 28, 28, 28, 28, 31, 28');
    end;

    if kleuren <> config.colorOption then
    begin
      kleuren := config.colorOption;
      kleur();
    end;

    if (config.alwaysOnTop) and (not form2.Visible) and (not form4.Visible)
      then
    begin
      form1.formStyle := fsStayOnTop;
    end
    else
    begin
      form1.formStyle := fsNormal;
    end;


    if (config.width = 40) then
    begin
      form1.Width := 389;
      image1.left := 356;
      image11.left := 368;
      image7.left := 352;
      image8.left := 352;
      image9.left := 352;
      image10.left := 352;
      image14.left := 266;
      image17.left := 323;
      for h := 1 to 4 do
      begin
        screenLcd[h].width := 321;
      end;
      image15.width := 220;
    end
    else
      if (config.width = 24) then
      begin
        form1.Width := 261;
        image1.left := 228;
        image11.left := 240;
        image7.left := 224;
        image8.left := 224;
        image9.left := 224;
        image10.left := 224;
        image14.left := 140;
        image17.left := 197;
        for h := 1 to 4 do
        begin
          screenLcd[h].width := 193;
        end;
        image15.width := 70;
      end
      else
      begin
        form1.Width := 231;
        image1.left := 198;
        image11.left := 210;
        image7.left := 194;
        image8.left := 194;
        image9.left := 194;
        image10.left := 194;
        for h := 1 to 4 do
        begin
          screenLcd[h].width := 162;
        end;
        image14.left := 108;
        image17.left := 165;
        image15.width := 20;
      end;


    if config.height <> iNrLines then
    begin
      iNrLines := config.height;
      screenLcd[2].visible := false;
      screenLcd[3].visible := false;
      screenLcd[4].visible := false;
      image4.visible := false;
      image5.visible := false;
      image6.visible := false;
      image8.visible := false;
      image9.visible := false;
      image10.visible := false;
      if config.height > 1 then
      begin
        screenLcd[2].visible := true;
        image4.Visible := true;
        image8.Visible := true;
      end;
      if config.height > 2 then
      begin
        screenLcd[3].visible := true;
        image5.Visible := true;
        image9.Visible := true;
      end;
      if config.height > 3 then
      begin
        screenLcd[4].visible := true;
        image6.Visible := true;
        image10.Visible := true;
      end;
    end;

    if (canflash) then
    begin
      canflash := false;
      doesflash := not doesflash;
      if (flash > 0) then
      begin
        flash := flash -1;
        backlit()
      end;
    end;

    Data.ScreenStart();
    for counter := 1 to config.height do
    begin
      //Application.ProcessMessages;
      line := config.screen[activeScreen][counter].text;
      line := Data.change(line, counter, true);

      // Center the line if requested.
      if config.screen[activeScreen][counter].center then
      begin
        if length(line) < config.width-1 then
        begin
          for h := 1 to round((config.width - length(line))/2 - 0.4) do
          begin
            line := ' ' + line + ' ';
          end;
        end;
      end;

      parsedLine[counter] := line;
      newline[counter] := line;  // Used by screen change interaction.
    end;
    if (not timertrans.enabled) then SendCustomChars();
    Data.ScreenEnd();

    for h := 1 to 4 do
    begin
      // handle continuing on the next line (if req)
      if (h < 4) and (config.screen[activeScreen][h].contNextLine) then
      begin
        parsedLine[h + 1] := copy(parsedLine[h], 1 + config.width,
          length(parsedLine[h]));
      end;
    end;

    gotnewlines := true;
  end;

  if timertrans.Enabled = false then
  begin
    if (ResetContrast) then
    begin
      // A contrast fade "interaction" has just happened so reset the contrast
      // just in case we failed to get the expected number of cycles (due to
      // high cpu loads etc).
      ResetContrast := False;
      if (config.isMO) then Lcd.setContrast(config.contrast)
      else
        if (config.isCF) then Lcd.setContrast(config.CF_contrast);
    end;

    if (canscroll) then
    begin
      canscroll := false;
      scrollcount := 1;

      doesgpoflash := not doesgpoflash;
      if (gpoflash > 0) then
      begin
        gpoflash := gpoflash -1;
        doGPO(whatgpo, 2)
      end;
    end
    else
    begin
      scrollcount := 0;
    end;

    // calculate scroll positions
    for counter := 1 to config.height do
    begin
      if (not config.screen[activeScreen][counter].noscroll) then
        screenLcd[counter].Caption := EscapeAmp(scroll(parsedLine[counter],
          counter, scrollcount))
      else
        if (scrollPos[counter]>1) then     // maintain manual scroll postion
          screenLcd[counter].Caption := EscapeAmp(scroll(parsedLine[counter], counter, 0))
        else
          screenLcd[counter].Caption := EscapeAmp(copy(parsedLine[counter], 1, config.width));
    end;

  end
  else
  begin          // timertrans.Enabled = true
    doInteractions();
  end;


  for h := 1 to config.height do
  begin
    if tmpline[h] <> copy(screenLcd[h].Caption +
      '                                        ', 1, config.width) then
    begin
      tmpline[h] := copy(UnescapeAmp(screenLcd[h].Caption)
        + '                                        ', 1, config.width);

      Lcd.setPosition(1, h);
      Lcd.write(tmpline[h]);
    end;
  end;

  //Application.ProcessMessages;
end;


// sets backlight - toggles if no parameter given
procedure TForm1.backlit(iOn: Integer = -1);
begin
  if (iOn = -1) then
    backlight := 1-backlight
  else
    backlight := iOn;

  Lcd.setbacklight(backlight >= 1);

  if backlight = 0 then
    Form1.popupmenu1.Items[0].Items[0].Caption := '&Backlight On'
  else
    Form1.popupmenu1.Items[0].Items[0].Caption := '&Backlight Off';
  Form1.kleur();
end;

procedure TForm1.FormShow(Sender: TObject);
var
  counter: Integer;

begin
  timer1.Interval := 0;
  timer1.Interval := config.refreshRate;

  cooltrayicon1.IconVisible := False;

  if config.height <> iNrLines then
  begin
    iNrLines := config.height;
    // only show used lines on the screen lcd.
    for counter := 1 to 4 do
    begin
      screenLcd[counter].visible := (counter <= config.height);
    end;
  end;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if (data.lcdSmartieUpdate) then
  begin
    data.lcdSmartieUpdate := False;

    timer1.enabled := false;
    timer2.enabled := false;
    timer3.enabled := false;
    timer4.enabled := false;
    timer5.enabled := false;
    timer6.enabled := false;
    timer7.enabled := false;
    timer8.enabled := false;
    timer9.enabled := false;
    if MessageDlg('A new version of LCD Smartie is detected. ' + chr(13) +
      data.lcdSmartieUpdateText + chr(13) + 'Go to download page?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ShellExecute(0, Nil, pchar('http://lcdsmartie.sourceforge.net/'), Nil,
        Nil, SW_NORMAL);
      Form1.close;
    end
    else
    begin
      timer1.enabled := true;
      timer2.enabled := true;
      timer3.enabled := true;
      timer6.enabled := true;
      timer7.enabled := true;
      timer8.enabled := true;
      timer9.enabled := true;
    end;
  end;

  Data.UpdateHTTP;
  timer2.Interval := 0;
  timer2.Interval := config.newsRefresh*1000*60;
end;

procedure TForm1.kleur;
begin
  if backlight = 1 then
  begin
    if kleuren = 0 then
    begin
      screenLcd[1].color := $0001FFA8;
      screenLcd[2].color := $0001FFA8;
      screenLcd[3].color := $0001FFA8;
      screenLcd[4].color := $0001FFA8;
      form1.Color := $0001FFA8;
      screenLcd[1].Font.Color := clBlack;
      screenLcd[2].Font.Color := clBlack;
      screenLcd[3].Font.Color := clBlack;
      screenLcd[4].Font.Color := clBlack;
    end
    else
      if kleuren = 1 then
      begin
        screenLcd[1].color := $00FDF103;
        screenLcd[2].color := $00FDF103;
        screenLcd[3].color := $00FDF103;
        screenLcd[4].color := $00FDF103;
        form1.Color := $00FDF103;
        screenLcd[1].Font.Color := clBlack;
        screenLcd[2].Font.Color := clBlack;
        screenLcd[3].Font.Color := clBlack;
        screenLcd[4].Font.Color := clBlack;
      end
      else
        if kleuren = 2 then
        begin
          screenLcd[1].color := clyellow;
          screenLcd[2].color := clyellow;
          screenLcd[3].color := clyellow;
          screenLcd[4].color := clyellow;
          form1.Color := clyellow;
          screenLcd[1].Font.Color := clBlack;
          screenLcd[2].Font.Color := clBlack;
          screenLcd[3].Font.Color := clBlack;
          screenLcd[4].Font.Color := clBlack;
        end
        else
          if kleuren = 3 then
          begin
            screenLcd[1].color := clwhite;
            screenLcd[2].color := clwhite;
            screenLcd[3].color := clwhite;
            screenLcd[4].color := clwhite;
            form1.Color := clwhite;
            screenLcd[1].Font.Color := clBlack;
            screenLcd[2].Font.Color := clBlack;
            screenLcd[3].Font.Color := clBlack;
            screenLcd[4].Font.Color := clBlack;
          end
          else
            if kleuren = 4 then
            begin
              screenLcd[1].color := backgroundcoloron;
              screenLcd[2].color := backgroundcoloron;
              screenLcd[3].color := backgroundcoloron;
              screenLcd[4].color := backgroundcoloron;
              form1.Color := backgroundcoloron;
              screenLcd[1].Font.Color := forgroundcoloron;
              screenLcd[2].Font.Color := forgroundcoloron;
              screenLcd[3].Font.Color := forgroundcoloron;
              screenLcd[4].Font.Color := forgroundcoloron;
            end;
  end
  else
  begin
    if kleuren = 0 then
    begin
      screenLcd[1].color := clgreen;
      screenLcd[2].color := clgreen;
      screenLcd[3].color := clgreen;
      screenLcd[4].color := clgreen;
      form1.Color := clgreen;
      screenLcd[1].Font.Color := clBlack;
      screenLcd[2].Font.Color := clBlack;
      screenLcd[3].Font.Color := clBlack;
      screenLcd[4].Font.Color := clBlack;
    end
    else
      if kleuren = 1 then
      begin
        screenLcd[1].color := $00C00000;
        screenLcd[2].color := $00C00000;
        screenLcd[3].color := $00C00000;
        screenLcd[4].color := $00C00000;
        form1.Color := $00C00000;
        screenLcd[1].Font.Color := clWhite;
        screenLcd[2].Font.Color := clWhite;
        screenLcd[3].Font.Color := clWhite;
        screenLcd[4].Font.Color := clWhite;
      end
      else
        if kleuren = 2 then
        begin
          screenLcd[1].color := clOlive;
          screenLcd[2].color := clOlive;
          screenLcd[3].color := clOlive;
          screenLcd[4].color := clOlive;
          form1.Color := clOlive;
          screenLcd[1].Font.Color := clBlack;
          screenLcd[2].Font.Color := clBlack;
          screenLcd[3].Font.Color := clBlack;
          screenLcd[4].Font.Color := clBlack;
        end
        else
          if kleuren = 3 then
          begin
            screenLcd[1].color := clsilver;
            screenLcd[2].color := clsilver;
            screenLcd[3].color := clsilver;
            screenLcd[4].color := clsilver;
            form1.Color := clsilver;
            screenLcd[1].Font.Color := clBlack;
            screenLcd[2].Font.Color := clBlack;
            screenLcd[3].Font.Color := clBlack;
            screenLcd[4].Font.Color := clBlack;
          end
          else
            if kleuren = 4 then
            begin
              screenLcd[1].color := backgroundcoloroff;
              screenLcd[2].color := backgroundcoloroff;
              screenLcd[3].color := backgroundcoloroff;
              screenLcd[4].color := backgroundcoloroff;
              form1.Color := backgroundcoloroff;
              screenLcd[1].Font.Color := forgroundcoloroff;
              screenLcd[2].Font.Color := forgroundcoloroff;
              screenLcd[3].Font.Color := forgroundcoloroff;
              screenLcd[4].Font.Color := forgroundcoloroff;
            end;
  end;
end;

// ShowMenu/Minimize has been selected from the tray/popup menu
procedure TForm1.Showwindow1Click(Sender: TObject);
begin
  if popupmenu1.Items[3].caption='&Minimize' then
    button1.Click
  else
    coolTrayIcon1.ShowMainForm;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  form1.close();
end;

// The LCD Smartie logo has been clicked - raise popup menu
procedure TForm1.Image1Click(Sender: TObject);
begin
  popupmenu1.Items[3].caption := 'Minimize';
  popupmenu1.Popup(form1.left + image1.left + round(image1.width/2), form1.top
    + image1.top + round(image1.height));
end;

// Only used when line scroll button is pressed.
procedure TForm1.scrollLine(line: Byte; direction: Integer);
begin
  tmpline[line] := copy (scroll(parsedLine[line], line, direction)
    + '                                        ', 1, config.width-1);
  screenLcd[line].caption := EscapeAmp(tmpline[line]);
  Lcd.setPosition(1, line);
  Lcd.write(tmpline[line]);
end;

// For scrolling right when a line scroll button is pressed.
procedure TForm1.Timer4Timer(Sender: TObject);
begin
  scrollLine(line2scroll, 1);
end;

// For scrolling left when a line scroll button is pressed.
procedure TForm1.Timer5Timer(Sender: TObject);
begin
  scrollLine(line2scroll, -1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  form1.formStyle := fsNormal;
  form1.enabled := false;
  form2.visible := true;
  form2.SetFocus;
end;

procedure TForm1.Timer6Timer(Sender: TObject);
begin
  Data.updateMBMStats(Sender);
  timer6.Interval := 0;
  timer6.Interval := config.mbmRefresh*1000;
end;


procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  aantalscreensheenweer := 1;
  frozen := true;
  freeze();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Application.Minimize;
  if (not form2.Visible) then CoolTrayIcon1.HideMainForm
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.minimize;
  coolTrayIcon1.HideMainForm;
  cooltrayicon1.HideTaskbarIcon;
  cooltrayicon1.enabled := False;
  cooltrayicon1.IconVisible := False;
  cooltrayicon1.Refresh;

  try
    while timer1.enabled = true do timer1.enabled := false;
    while timer2.enabled = true do timer2.enabled := false;
    while timer3.enabled = true do timer3.enabled := false;
    while timer4.enabled = true do timer4.enabled := false;
    while timer5.enabled = true do timer5.enabled := false;
    while timer6.enabled = true do timer6.enabled := false;
    while timer7.enabled = true do timer7.enabled := false;
    while timer8.enabled = true do timer8.enabled := false;
    while timer9.enabled = true do timer9.enabled := false;
    while timer10.enabled = true do timer10.enabled := false;
    while timer11.enabled = true do timer11.enabled := false;
    while timer12.enabled = true do timer12.enabled := false;
    while timer13.enabled = true do timer13.enabled := false;
    while timertrans.enabled = true do timertrans.enabled := false;
  except
  end;

  try
    if (Lcd <> nil) Then Lcd.Destroy();
  except
  end;

  if (Data <> nil) then Data.Destroy;
  if (config <> nil) then config.Destroy;
end;

procedure TForm1.Timer8Timer(Sender: TObject);
begin
  Data.updateGameStats;
  timer8.Interval := 0;
  timer8.Interval := config.gameRefresh*60000;
end;

procedure TForm1.Configure1Click(Sender: TObject);
begin
  Showwindow1.click();
  button2.click();
end;

procedure TForm1.ProcessAction(bDoAction: Boolean; sAction: String);
var
  temp1, temp2: String;
  iTemp: Integer;
  args: Array [0..maxArgs-1] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  sSecondAction: String;
begin
  // Handle actions have do something when they are activated and de-activated.
  if (pos('Backlight(', sAction) <> 0) then
  begin
    temp1 := copy(sAction, pos('(', sAction) + 1, 1);

    if (temp1 = '0') or (temp1 = '1') then
    begin
      iTemp := 1;
      if temp1 = '0' then iTemp := 0;

      if (not bDoAction) then
        iTemp := 1 - iTemp;

      backlit(iTemp);
    end;
  end;

  if (pos('GPO(', sAction) <> 0) and (config.isMO) then
  begin
    temp1 := copy(sAction, pos('(', sAction) + 1,
      pos(',', sAction)-pos('(', sAction)-1);
    temp2 := copy(sAction, pos(',', sAction) + 1,
      pos(')', sAction)-pos(',', sAction)-1);

    if (temp2 = '1') or (temp2 = '0') then
    begin
      if (not bDoAction) then
      begin
        // invert setting
        if temp2='1' then temp2 := '0'
        else temp2 := '1';
      end;

      try
        doGPO(StrToInt(temp1), StrToInt(temp2));
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;
  end;


  if (pos('EnableScreen(', sAction) <> 0) then
  begin
    try
      iTemp := StrToInt(copy(sAction, pos('EnableScreen(', sAction) + 13,
        pos(')', sAction)-pos('EnableScreen(', sAction)-13));
      if (iTemp >= 1) and (iTemp <= 20) then
      begin
        if (bDoAction) then
          ChangeScreen(iTemp);
        config.Screen[iTemp][1].Enabled := bDoAction;
      end;
    except
      on EConvertError do begin {ignore} end;
      else raise;
    end;
  end;

  if (pos('DisableScreen(', sAction) <> 0) then
  begin
    try
      iTemp := StrToInt(copy(sAction, pos('DisableScreen(', sAction) + 14,
        pos(')', sAction)-pos('DisableScreen(', sAction)-14));
      if (iTemp >= 1) and (iTemp <= 20) then
      begin
        config.Screen[iTemp][1].Enabled := not bDoAction;
      end;
    except
      on EConvertError do begin {ignore} end;
      else raise;
    end;
  end;


  // Handle actions that only do something when activated.
  if (bDoAction) then
  begin

    while decodeArgs(sAction, '$dll', maxArgs, args, prefix, postfix, numargs) do
    begin
      if (numargs = 4) then
      begin
        try
          sSecondAction := data.CallPlugin(args[0], StrToInt(args[1]), args[2], args[3]);
          ProcessAction(True, sSecondAction);
        except
          on EConvertError do begin {ignore} end;
          else raise;
        end;
      end;
      sAction := prefix + postfix;
    end;

    if (Pos('NextTheme', sAction) <> 0) then
    begin
      activetheme := activetheme + 1;
      if activetheme = 10 then activetheme := 0;
      frozen := true;
      freeze();
    end;

    if (pos('LastTheme', sAction) <> 0) then
    begin
      activetheme := activetheme-1;
      if activetheme=-1 then activetheme := 9;
      frozen := true;
      freeze();
    end;

    if (pos('NextScreen', sAction) <> 0) then
    begin
      aantalscreensheenweer := 1;
      frozen := true;
      freeze();
    end;

    if (pos('LastScreen', sAction) <> 0) then
    begin
      aantalscreensheenweer := -1;
      frozen := true;
      freeze();
    end;

    if (pos('GotoTheme(', sAction) <> 0) then
    begin
      try
        iTemp := StrToInt(copy(sAction, pos('GotoTheme(', sAction) + 10,
          pos(')', sAction)-pos('GotoTheme(', sAction)-10))-1;
        if (iTemp >= 0) and (iTemp < 10) then
          activetheme := iTemp;
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;

    if (pos('GotoScreen(', sAction) <> 0) then
    begin
      try
        iTemp := StrToInt(copy(sAction, pos('GotoScreen(', sAction) + 11,
          pos(')', sAction)-pos('GotoScreen(', sAction)-11));
        if (iTemp >= 1) and (iTemp <= 20) then
          ChangeScreen(iTemp);
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;

    if pos('FreezeScreen', sAction) <> 0 then
    begin
      freeze();
    end;

    if pos('RefreshAll', sAction) <> 0 then
    begin
      timer2.interval := 10;
      timer6.interval := 10;
      timer8.interval := 10;
      timer9.interval := 10;
      timer10.interval := 10;
    end;

    if pos('BacklightToggle', sAction) <> 0 then
    begin
      backlit();
    end;

    if pos('BLFlash(', sAction) <> 0 then
    begin
      temp1 := copy(sAction, pos('(', sAction) + 1, pos(')', sAction)
            - pos('(', sAction)-1);
      try
        flash := StrToInt(temp1)*2;
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;

    if pos('Wave[', sAction) <> 0 then
    begin
      temp1 := copy(sAction, pos('Wave[', sAction) + 5, pos(']', sAction)
         - pos('Wave[', sAction)-5);
      playsound(Pchar(temp1), 0, SND_FILENAME);
    end;

    if pos('Exec[', sAction) <> 0 then
    begin
      temp1 := copy(sAction, pos('Exec[', sAction) + 5, pos(']', sAction)
         - pos('Exec[', sAction)-5);
      shellexecute(0, 'open', PChar(temp1), '', '', SW_SHOW);
    end;

    if pos('WANextTrack', sAction) <> 0 then
      Winampctrl1.Next;

    if pos('WALastTrack', sAction) <> 0 then
      Winampctrl1.Previous;

    if pos('WAPlay', sAction) <> 0 then
      Winampctrl1.Play;

    if pos('WAStop', sAction) <> 0 then
      Winampctrl1.Stop;

    if pos('WAPause', sAction) <> 0 then
      Winampctrl1.Pause;

    if pos('WAShuffle', sAction) <> 0 then
      Winampctrl1.ToggleShufflE;

    if pos('WAVolDown', sAction) <> 0 then
    begin
      WinampCtrl1.VolumeDown;
      WinampCtrl1.VolumeDown;
      WinampCtrl1.VolumeDown;
      WinampCtrl1.VolumeDown;
      WinampCtrl1.VolumeDown;
    end;

    if pos('WAVolUp', sAction) <> 0 then
    begin
      WinampCtrl1.VolumeUp;
      WinampCtrl1.VolumeUp;
      WinampCtrl1.VolumeUp;
      WinampCtrl1.VolumeUp;
      WinampCtrl1.VolumeUp;
    end;

    if (pos('GPOFlash(', sAction) <> 0) and (config.isMO) then
    begin
      try
        whatgpo := StrToInt(copy(sAction, pos('(', sAction) + 1,
          pos(',', sAction)-pos('(', sAction)-1));
        temp2 := copy(sAction, pos(',', sAction) + 1,
          pos(')', sAction)-pos(',', sAction)-1);
        gpoflash := StrToInt(temp2)*2;
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;

    if pos('GPOToggle(', sAction) <> 0 then
    begin
      try
        temp1 := copy(sAction, pos('(', sAction) + 1, pos(')', sAction)
           - pos('(', sAction)-1);
        dogpo(StrToInt(temp1), 2)
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;

    if pos('Fan(', sAction) <> 0 then
    begin
      try
        temp1 := copy(sAction, pos('(', sAction) + 1, pos(',', sAction)
            - pos('(', sAction)-1);
        temp2 := copy(sAction, pos(',', sAction) + 1, pos(')', sAction)
            - pos(',', sAction)-1);

        Lcd.setFan(StrToInt(temp1), StrToInt(temp2));
      except
        on EConvertError do begin {ignore} end;
        else raise;
      end;
    end;
  end;

end;


procedure TForm1.Timer3Timer(Sender: TObject);
//ACTIONS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  counter: Integer;
  iTemp: Integer;
  cKey: Char;
  iLeftValue, iRightValue: Integer;
  sLeftValue, sRightValue, sAction: String;
  bNum: Boolean;
  bDoAction: Boolean;
  doAction: Array[1..99] of Boolean;

begin

  if (form2 <> nil) and (Lcd.readKey(cKey)) then
  begin
    form2.Edit17.text := cKey;
    data.cLastKeyPressed := cKey;
  end;


  if (form2.Visible = true) then Exit;


  //
  // Work out the state of each action condition.
  //
  for counter := 1 to config.totalactions do
  begin
    sLeftValue := Data.change(config.actionsArray[counter, 1]);
    sRightValue := config.actionsArray[counter, 3];

    bDoAction := false;

    // Check if both left and right are numberic.
    bNum := False;
    iTemp := 1;
    while (iTemp <= length(sLeftValue)) and (sLeftValue[iTemp]>='0')
      and (sLeftValue[iTemp]<='9') do Inc(iTemp);
    if (iTemp > length(sLeftValue)) then
    begin
      iTemp := 1;
      while (iTemp <= length(sRightValue)) and (sRightValue[iTemp]>='0')
        and (sRightValue[iTemp]<='9') do Inc(iTemp);

      if (iTemp > length(sRightValue)) then bNum := True;
    end;

    if (bNum) then
    try
      iLeftValue := StrToInt(sLeftValue);
      iRightValue := StrToInt(sRightValue);
      case StrToInt(config.actionsArray[counter, 2]) of
        0: if (iLeftValue > iRightValue) then bDoAction := true;
        1: if (iLeftValue < iRightValue) then bDoAction := true;
        2: if (iLeftValue = iRightValue) then bDoAction := true;
        3: if (iLeftValue <= iRightValue) then bDoAction := true;
        4: if (iLeftValue >= iRightValue) then bDoAction := true;
        5: if (iLeftValue <> iRightValue) then bDoAction := true;
      end;
    except
      on EConvertError do begin bNum:=False end;
      else raise;
    end;

    if (not bNum) then
    begin
      // not a numeric value - lets do a string comparsion
      case StrToInt(config.actionsArray[counter, 2]) of
        0: if (sLeftValue > sRightValue) then bDoAction := true;
        1: if (sLeftValue < sRightValue) then bDoAction := true;
        2: if (sLeftValue = sRightValue) then bDoAction := true;
        3: if (sLeftValue <= sRightValue) then bDoAction := true;
        4: if (sLeftValue >= sRightValue) then bDoAction := true;
        5: if (sLeftValue <> sRightValue) then bDoAction := true;
      end;
    end;

    doAction[counter] := bDoAction;
  end;

  // All actions have been processed using this key.
  // Delete it so a repeated press is processed.
  data.cLastKeyPressed := Chr(0);

  // Reset new screen - the following actions may set this again.
  data.bNewScreenEvent := False;

  //
  // Run any required actions.
  //
  for counter := 1 to config.totalactions do
  begin
    if (doAction[counter] <> didAction[counter]) then
    begin
      sAction :=  config.actionsArray[counter, 4];
      ProcessAction(doAction[counter], sAction);

      didAction[counter] := doAction[counter];
    end;

    // Ulgy special case - [the action code needs a rewrite]
    // If action was caused by a key press then don't record that we have
    // done it - this will reduce the delay required to reset actions.
    // This delay impacts the user experience when using keys.
    if (Pos('MObutton', config.actionsArray[counter, 1]) <> 0) then
      didAction[counter] := false;

  end;

end;


procedure TForm1.Timer9Timer(Sender: TObject);
//MAILS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
begin
  timer9.Interval := 0;
  timer9.Interval := config.emailPeriod*60000;
  Data.UpdateEmail;
end;

procedure TForm1.BacklightOn1Click(Sender: TObject);
begin
  backlit();
end;

procedure TForm1.Timer10Timer(Sender: TObject);
begin
  Data.updateNetworkStats(Sender);
  timer10.Interval := 0;
  timer10.interval := 1000;
end;


procedure TForm1.Timer7Timer(Sender: TObject);
//NEXT SCREEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Label opnieuwscreen;
var
  xx, x: Integer;
  y: Integer;
  ascreen: TScreenLine;
  tmpscreen: Integer;

begin
  tmpScreen := activeScreen;
  x := 0;
  xx := 0;
opnieuwscreen:
  x := x + 1;
  xx := xx + 1;
  if (config.randomScreens) and (x < 500) then
  begin
    tmpScreen := round(random(20) + 1);
    if tmpScreen > 20 then tmpScreen := 20;
    if tmpScreen < 1 then tmpScreen := 1;
  end
  else
  begin
    tmpScreen := tmpScreen + aantalscreensheenweer;
    if tmpScreen > 20 then tmpScreen := 1;
    if tmpScreen < 1 then tmpScreen := 20;
  end;

  if xx> 22 then
  begin
    activetheme := activetheme + 1;
    xx := 0;
  end;
  if (((x> 242) and (not config.randomScreens)) or ((x> 1000) and
    (config.randomScreens))) then
  begin

    // It seems that we are in a endless loop because no screen is able to be
    // displayed.  Force screen 1 to be displayed.
    x := 0;

    for y := 1 to 4 do
    begin
      config.screen[1][y].enabled := True;
      config.screen[1][y].skip := 0;
      //config.screen[1][y].noscroll := False;
    end;

    tmpScreen := 1;
    activetheme := 0;
  end;

  ascreen := config.screen[tmpScreen][1];

  if (ascreen.theme <> activetheme) then goto opnieuwscreen;
  if (not ascreen.enabled) then goto opnieuwscreen;
  if (ascreen.skip = 1) and (winampctrl1.GetSongInfo(1) = 0) then goto
    opnieuwscreen;
  if (ascreen.skip = 2) and (winampctrl1.GetSongInfo(1) <> 0) then goto
    opnieuwscreen;
  if (ascreen.skip = 3) and (not Data.mbmactive) then goto opnieuwscreen;
  if (ascreen.skip = 4) and (Data.mbmactive) then goto opnieuwscreen;
  if (ascreen.skip = 7) and (not Data.isconnected) then goto opnieuwscreen;
  if (ascreen.skip = 8) and (Data.isconnected) then goto opnieuwscreen;
  if (ascreen.skip = 5) and (not Data.gotEmail) then goto opnieuwscreen;
  if (ascreen.skip = 6) and (Data.gotEmail) then goto opnieuwscreen;

  aantalscreensheenweer := 1;

  if (activeScreen <> tmpScreen) then
  begin
    ChangeScreen(tmpScreen); // changes activeScreen
    timertrans.Enabled := True;
  end;
end;

procedure TForm1.Timer11Timer(Sender: TObject);
begin
  timer11.Enabled := false;

  Lcd := TLCD_HD.CreateParallel($ + config.parallelPort, config.width, config.height);
  Lcd.setbacklight(true);

  customchar('1, 12, 18, 18, 12, 0, 0, 0, 0');
  customchar('2, 31, 31, 31, 31, 31, 31, 31, 31');
  customchar('3, 16, 16, 16, 16, 16, 16, 31, 16');
  customchar('4, 28, 28, 28, 28, 28, 28, 31, 28');

  timer1.enabled := true;
  timer2.enabled := true;
  timer3.enabled := true;
  timer6.enabled := true;
  timer7.enabled := true;
  timer8.enabled := true;
  timer9.enabled := true;
  timer10.enabled := true;
  timer12.enabled := true;
  timer13.enabled := true;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canclose := true;
end;

procedure TForm1.Credits1Click(Sender: TObject);
begin
  form1.formStyle := fsNormal;
  form1.enabled := false;
  form4.visible := true;
  form4.BringToFront;
end;

procedure TForm1.NextTheme1Click(Sender: TObject);
begin
  activetheme := activetheme + 1;
  if activetheme = 10 then activetheme := 0;
  frozen := true;
  freeze();
end;

procedure TForm1.LastTheme1Click(Sender: TObject);
begin
  activetheme := activetheme-1;
  if activetheme=-1 then activetheme := 9;
  frozen := true;
  freeze();
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
  form1.formStyle := fsNormal;
  form1.enabled := false;
  form4.visible := true;
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
  if upcase(key)='K' then
  begin
    activetheme := activetheme-1;
    if activetheme=-1 then activetheme := 9;
    frozen := true;
    freeze();
  end;
  if upcase(key)='L' then
  begin
    activetheme := activetheme + 1;
    if activetheme = 10 then activetheme := 0;
    frozen := true;
    freeze();
  end;
  if upcase(key)=',' then speedbutton1.click();
  if upcase(key)='.' then speedbutton10.click();
  if (upcase(key)='?') or (upcase(key)='/') then
  begin
    form1.timer2.interval := 10;
    form1.timer8.interval := 10;
    form1.timer9.interval := 10;
    form1.timer6.interval := 10;
  end;
end;

procedure TForm1.freeze();
begin
  if frozen = false then
  begin
    frozen := true;
    form1.timer7.enabled := false;
    popupmenu1.Items[0].Items[1].Caption := 'Unfreeze';
    form1.caption := form1.caption + ' - frozen'
  end
  else
  begin
    frozen := false;
    form1.timer7.enabled := true;
    form1.timer7.interval := 0;
    form1.timer7.interval := 5;
    popupmenu1.Items[0].Items[1].Caption := 'Freeze';
    if pos('frozen', form1.caption) <> 0 then form1.caption :=
      copy(form1.caption, 1, length(form1.caption)-length(' - frozen'));
  end;
end;

procedure TForm1.Image12MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image12.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_left_up.bmp');
end;

procedure TForm1.Image12MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image12.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_left_down.bmp');
end;

procedure TForm1.Image16MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image16.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\setup_down.bmp');
end;

procedure TForm1.Image16MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image16.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\setup_up.bmp');
end;

procedure TForm1.Image17MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image17.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\hide_down.bmp');
end;

procedure TForm1.Image17MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image17.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\hide_up.bmp');
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image3.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down1.bmp');
  line2scroll := 1;
  timer5.enabled := true;
  timer1.enabled := false;
end;

procedure TForm1.Image3MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image3.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up1.bmp');
  timer5.enabled := false;
  timer1.enabled := true;
end;

procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image4.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down2.bmp');
  line2scroll := 2;
  timer5.enabled := true;
  timer1.enabled := false;
end;

procedure TForm1.Image5MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image5.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down3.bmp');
  line2scroll := 3;
  timer5.enabled := true;
  timer1.enabled := false;
end;

procedure TForm1.Image6MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image6.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down4.bmp');
  line2scroll := 4;
  timer5.enabled := true;
  timer1.enabled := false;
end;

procedure TForm1.Image7MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image7.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down1.bmp');
  line2scroll := 1;
  timer4.enabled := true;
end;

procedure TForm1.Image8MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image8.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down2.bmp');
  line2scroll := 2;
  timer4.enabled := true;
end;

procedure TForm1.Image9MouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image9.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down3.bmp');
  line2scroll := 3;
  timer4.enabled := true;
end;

procedure TForm1.Image10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image10.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down4.bmp');
  line2scroll := 4;
  timer4.enabled := true;
end;

procedure TForm1.Image4MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image4.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up2.bmp');
  timer5.enabled := false;
  timer1.enabled := true;
end;

procedure TForm1.Image5MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image5.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up3.bmp');
  timer5.enabled := false;
  timer1.enabled := true;
end;

procedure TForm1.Image6MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image6.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up4.bmp');
  timer5.enabled := false;
  timer1.enabled := true;
end;

procedure TForm1.Image7MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image7.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up1.bmp');
  timer4.enabled := false;
end;

procedure TForm1.Image8MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image8.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up2.bmp');
  timer4.enabled := false;
end;

procedure TForm1.Image9MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image9.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up3.bmp');
  timer4.enabled := false;
end;

procedure TForm1.Image10MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image10.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up4.bmp');
  timer4.enabled := false;
end;

procedure TForm1.Image11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image11.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_right_down.bmp');
end;

procedure TForm1.Image11MouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  image11.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_right_up.bmp');
end;

procedure TForm1.Image12Click(Sender: TObject);
begin
  speedbutton1.click;
end;

procedure TForm1.Image11Click(Sender: TObject);
begin
  speedbutton10.click;
end;

// Hide has been pressed.
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
  aantalscreensheenweer := -1;
  frozen := true;
  freeze();
end;

procedure tform1.dogpo(const ftemp1, ftemp2: Integer);
begin
  if ftemp1 < 9 then
  begin
    if ftemp2 = 0 then
    begin
      Lcd.setGPO(ftemp1, false);
      gpo[ftemp1] := false;
    end;
    if ftemp2 = 1 then
    begin
      Lcd.setGPO(ftemp1, true);
      gpo[ftemp1] := true;
    end;
    if ftemp2 = 2 then
    begin
      if (gpo[ftemp1]) then
      begin
        Lcd.setGPO(ftemp1, false);
        gpo[ftemp1] := false;
      end
      else
      begin
        Lcd.setGPO(ftemp1, true);
        gpo[ftemp1] := true;
      end;
    end;
  end;
end;

procedure TForm1.Timer13Timer(Sender: TObject);
begin
  timer13.Interval := 0;
  timer13.Interval := config.scrollPeriod;
  Data.dllcancheck := true;
end;

procedure TForm1.WMQueryEndSession (var M: TWMQueryEndSession);
begin
  inherited;
  form1.Close;
end;
procedure TForm1.TimertransTimer(Sender: TObject);
begin
  timertrans.Enabled := false;
end;

procedure TForm1.Timer12Timer(Sender: TObject);
begin
  timer12.Interval := 0;
  timer12.Interval := config.scrollPeriod;
  canscroll := true;
  Inc(flashdelay);
  if ((not doesflash) and (flashdelay >= 2)) or
    (doesflash and (flashdelay >= 1)) then
  begin
    flashdelay := 0;
    canflash := true;
  end;
end;

procedure TForm1.WinAmpTimerCheck(Sender: TObject);
begin
  WinampCtrl1.CheckIfSongChanged;
end;

procedure TForm1.OnMinimize(Sender: TObject);
begin
  // Only minimize to tray when setup isn't displayed
  if (Assigned(form2)) and (not form2.Visible) then
  begin
    cooltrayicon1.HideMainForm;
    popupmenu1.Items[3].caption := 'Show Main';
    cooltrayicon1.IconVisible := True;
  end
  else
    coolTrayIcon1.IconVisible := False;
end;


end.

