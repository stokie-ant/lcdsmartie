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
 *  $Revision: 1.68 $ $Date: 2006/03/01 13:48:09 $
 *****************************************************************************}

interface

uses
  Messages, CoolTrayIcon, Menus,
  WinampCtrl, ExtCtrls, Controls, StdCtrls, Buttons, Classes, Forms,
  UConfig, ULCD, UData;

const
  WM_ICONTRAY = WM_USER + 1;   // User-defined message
  OurVersMaj = 5;
  OurVersMin = 3;
  OurVersRel = 1;
  OurVersBuild = 16;

type
  TInitialWindowState = (NoChange, HideMainForm, TotalHideMainForm);

  TLCDSmartieDisplayForm = class(TForm)
    HTTPUpdateTimer: TTimer;
    NextScreenTimer: TTimer;
    MBMUpdateTimer: TTimer;
    GameUpdateTimer: TTimer;
    EMailTimer: TTimer;
    ScrollFlashTimer: TTimer;
    WinampCtrl1: TWinampCtrl;
    // These are only used by us:
    PopupMenu1: TPopupMenu;
    ShowWindow1: TMenuItem;
    Close1: TMenuItem;
    SetupButton: TButton;
    LogoImage: TImage;
    HideButton: TButton;
    CoolTrayIcon1: TCoolTrayIcon;
    Line1Panel: TPanel;
    Line2Panel: TPanel;
    Line3Panel: TPanel;
    Line4Panel: TPanel;   // aka ScreenLCD[4]
    Configure1: TMenuItem;
    BacklightOn1: TMenuItem;
    Commands1: TMenuItem;
    Freeze1: TMenuItem;
    NextTheme1: TMenuItem;
    LastTheme1: TMenuItem;
    N2: TMenuItem;
    Credits1: TMenuItem;
    Line1RightScrollImage: TImage;
    Line2RightScrollImage: TImage;
    Line3RightScrollImage: TImage;
    Line4RightScrollImage: TImage;
    Line1LeftScrollImage: TImage;
    Line2LeftScrollImage: TImage;
    Line3LeftScrollImage: TImage;
    Line4LeftScrollImage: TImage;
    NextScreenImage: TImage;
    PreviousImage: TImage;
    BarLeftImage: TImage;
    BarRightImage: TImage;
    BarMiddleImage: TImage;
    SetupImage: TImage;
    HideImage: TImage;
    ScreenNumberPanel: TPanel;
    TransitionTimer: TTimer;
    ActionsTimer: TTimer;
    LeftManualScrollTimer: TTimer;
    RightManualScrollTimer: TTimer;
    LPTStartupTimer: TTimer;
    TimerRefresh: TTimer;
    PreviousButton: TButton;
    NextButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowWindow1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure LogoImageClick(Sender: TObject);
    procedure HideButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BacklightOn1Click(Sender: TObject);
    procedure TimerRefreshTimer(Sender: TObject);
    procedure HTTPUpdateTimerTimer(Sender: TObject);
    procedure ActionsTimerTimer(Sender: TObject);
    procedure LeftManualScrollTimerTimer(Sender: TObject);
    procedure RightManualScrollTimerTimer(Sender: TObject);
    procedure MBMUpdateTimerTimer(Sender: TObject);
    procedure NextScreenTimerTimer(Sender: TObject);
    procedure GameUpdateTimerTimer(Sender: TObject);
    procedure EMailTimerTimer(Sender: TObject);
    procedure LPTStartupTimerTimer(Sender: TObject);
    procedure Credits1Click(Sender: TObject);
    procedure NextTheme1Click(Sender: TObject);
    procedure LastTheme1Click(Sender: TObject);
    procedure LogoImageDblClick(Sender: TObject);
    procedure Freeze1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PreviousImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure PreviousImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure SetupImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure SetupImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure HideImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure HideImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line1RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line1RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line2RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line3RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line4RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line1LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line2LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line3LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line4LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line2RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line3RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line4RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line1LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line2LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line3LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Line4LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure NextScreenImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure NextScreenImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure PreviousImageClick(Sender: TObject);
    procedure NextScreenImageClick(Sender: TObject);
    procedure TransitionTimerTimer(Sender: TObject);
    procedure ScrollFlashTimerTimer(Sender: TObject);
    procedure WMPowerBroadcast (var M: TMessage); message WM_POWERBROADCAST;
    procedure SetupButtonClick(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  public
    doesflash: Boolean;
    lcd: TLCD;
    procedure DoFullDisplayDraw;
    procedure UpdateTimersState(InSetupState : boolean);
    procedure ChangeScreen(scr: Integer);
    procedure ResetScrollPositions;
    procedure SetupAutoStart;
    procedure ReInitLCD();
    procedure customchar(fline: String);
  private
    InitialWindowState: TInitialWindowState;
    ScreenLCD: Array[1..4] of ^TPanel;
    canflash: Boolean;
    iSavedHeight, iSavedWidth: Integer;
    iSavedColorMode: Integer;
    didAction: Array [1..99] of Boolean;
    file1: String;
    parsedLine: Array[1..4] of String;
    scrollPos: Array[1..4] of Integer;
    line2scroll: Integer;
    tmpline: Array [1..4] of String;
    forgroundcoloroff, forgroundcoloron, backgroundcoloroff,
      backgroundcoloron: Integer;
    Oldline: Array[1..4] of String;
    Newline: Array[1..4] of String;
    Gotnewlines: Boolean;
    TransStart: Cardinal;
    TransitionTemp, TransitionTemp2 : TTransitionStyle;
    TransCycle, TempTransitionTimerInterval : Integer;
    GuessArray: Array[1..4, 1..40] of Boolean;
    activetheme: Integer; canscroll: Boolean;
    GPO: Array [1..8] of Boolean;
    customChars: Array [1..8, 0..7] of Byte;
    customCharsChanged: Array [1..8] of Boolean;
    doesGPOflash: Boolean;
    GPOflash, whatGPO: Integer;
    flash: Integer;
    ResetContrast: Boolean;
    flashdelay: Cardinal;
    bNewScreen: Boolean;
    frozen: Boolean;
    Backlight: boolean;
    data: TData;
    NumberOfScreensToShift: Integer;
    iLastRandomTranCycle: Integer;
    ConfigFileName: String;
    procedure SetOnscreenBacklight();
    function DoGuess(line: Integer): Integer;
    procedure freeze();
    procedure DoGPO(const ftemp1, ftemp2: Integer);
    function scroll(const scrollvar: String;const line, speed: Integer): String;
    procedure scrollLine(line: Byte; direction: Integer);
    procedure DoTransitions;
    procedure backlit(iOn: Integer = -1);
    function EscapeAmp(const sStr: string):String;
    function UnescapeAmp(const sStr: string): String;
    procedure SendCustomChars;
    procedure ProcessAction(bDoAction: Boolean; sAction: String);
    procedure InitLCD();
    procedure FiniLCD();
    procedure ResizeHeight;
    procedure ResizeWidth;
    procedure LoadSkin;
    procedure LoadColors;
    procedure ProcessCommandLineParams;
  end;

var
  LCDSmartieDisplayForm: TLCDSmartieDisplayForm;
  activeScreen : Integer;
  bTerminating: Boolean;

implementation

{$R *.DFM}

uses
  Windows, SysUtils, Graphics, Dialogs, ShellAPI, mmsystem, StrUtils,
  USetup, UCredits, ULCD_MO, ULCD_CF, ULCD_HD, ULCD_Test, ULCD_IR, ExtActns, UUtils;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      M A I N      F O R M     E V E N T S                             ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TLCDSmartieDisplayForm.FormCreate(Sender: TObject);
begin
  bTerminating := false;
  Randomize;

  SetCurrentDir(extractfilepath(application.exename));
  CreateDirectory('cache', nil);
  AddPluginsToPath();

  ScreenLCD[1] := @Line1Panel;
  ScreenLCD[2] := @Line2Panel;
  ScreenLCD[3] := @Line3Panel;
  ScreenLCD[4] := @Line4Panel;


//SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW and not W
//S_EX_APPWINDOW );
  LoadSkin;
  LCDSmartieDisplayForm.color := $00BFBFBF;
  NumberOfScreensToShift := 1;
  LoadColors;

  ConfigFileName := 'config.ini';
  ProcessCommandLineParams;  // can change config file name
  config := TConfig.Create(ConfigFileName);

  if (config.load() = false) then
  begin
    showmessage('Fatal Error:  Failed to load configuration');
    application.Terminate;
  end;

  if (config.bHideOnStartup) then
    InitialWindowState := HideMainForm;

  // delete/create startup shortcut as required.
  SetupAutoStart();

  Data := TData.Create();

  LCDSmartieDisplayForm.WinampCtrl1.WinampLocation := config.winampLocation;
  file1 := config.distLog;

  Backlight := true;
  SetOnscreenBacklight();

  InitLCD();

  ChangeScreen(1);
end;

procedure TLCDSmartieDisplayForm.LoadSkin;
var
  OurPath: String;
begin
  try
    OurPath := extractfilepath(application.exename);
    LogoImage.picture.LoadFromFile(OurPath + 'images\logo.bmp');
    Line1RightScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_left_up1.bmp');
    Line2RightScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_left_up2.bmp');
    Line3RightScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_left_up3.bmp');
    Line4RightScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_left_up4.bmp');
    Line1LeftScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_right_up1.bmp');
    Line2LeftScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_right_up2.bmp');
    Line3LeftScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_right_up3.bmp');
    Line4LeftScrollImage.picture.LoadFromFile(OurPath + 'images\small_arrow_right_up4.bmp');
    NextScreenImage.picture.LoadFromFile(OurPath + 'images\big_arrow_right_up.bmp');
    PreviousImage.picture.LoadFromFile(OurPath + 'images\big_arrow_left_up.bmp');
    BarLeftImage.picture.LoadFromFile(OurPath + 'images\bar_left.bmp');
    BarRightImage.picture.LoadFromFile(OurPath + 'images\bar_right.bmp');
    BarMiddleImage.picture.LoadFromFile(OurPath + 'images\bar_middle.bmp');
    SetupImage.picture.LoadFromFile(OurPath + 'images\setup_up.bmp');
    HideImage.picture.LoadFromFile(OurPath + 'images\hide_up.bmp');
    CoolTrayIcon1.Icon.LoadFromFile(OurPath + 'images\smartie.ico');
    application.Icon.LoadFromFile(OurPath + 'images\smartie.ico');
    CoolTrayIcon1.Refresh;
  except
    on E: Exception do
    begin
      showmessage('Error: unable to access images subdirectory: ' +
        E.Message);
      application.terminate;
    end;
  end;
end;

procedure TLCDSmartieDisplayForm.LoadColors;
var
  Line : string;
  initfile: textfile;
begin
//register
  try
    assignfile(initfile, extractfilepath(application.exename) +'images\colors.cfg');
    reset(initfile);
    readln(initfile, line);
    ScreenNumberPanel.Color := StrToInt('$00' + copy(line, 1, 6));
    readln(initfile, line);
    ScreenNumberPanel.font.Color := StrToInt('$00' + copy(line, 1, 6));
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
end;

procedure TLCDSmartieDisplayForm.ProcessCommandLineParams;
var
  I : integer;
  parameter: String;
begin
  InitialWindowState := NoChange;
  i := 1;
  while (i <= ParamCount) do
  begin
    parameter :=  lowercase(ParamStr(i));

    if (parameter = '-hide') then
      InitialWindowState := HideMainForm
    else if (parameter = '-totalhide') then
      InitialWindowState := TotalHideMainForm
    else if (parameter = '-config') then
    begin
      Inc(i);
      ConfigFileName := ParamStr(i);  // will give '' if out of range
    end;
    Inc(i);
  end;
end;

procedure TLCDSmartieDisplayForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bTerminating := true;

  //application.minimize;
  //CoolTrayIcon1.HideMainForm;
  //CoolTrayIcon1.HideTaskbarIcon;
  //CoolTrayIcon1.enabled := False;
  //CoolTrayIcon1.IconVisible := False;
  //CoolTrayIcon1.Refresh;

  while timerRefresh.enabled = true do timerRefresh.enabled := false;
  while HTTPUpdateTimer.enabled = true do HTTPUpdateTimer.enabled := false;
  while ActionsTimer.enabled = true do ActionsTimer.enabled := false;
  while LeftManualScrollTimer.enabled = true do LeftManualScrollTimer.enabled := false;
  while RightManualScrollTimer.enabled = true do RightManualScrollTimer.enabled := false;
  while MBMUpdateTimer.enabled = true do MBMUpdateTimer.enabled := false;
  while NextScreenTimer.enabled = true do NextScreenTimer.enabled := false;
  while GameUpdateTimer.enabled = true do GameUpdateTimer.enabled := false;
  while EMailTimer.enabled = true do EMailTimer.enabled := false;
  while LPTStartupTimer.enabled = true do LPTStartupTimer.enabled := false;
  while ScrollFlashTimer.enabled = true do ScrollFlashTimer.enabled := false;
  while TransitionTimer.enabled = true do TransitionTimer.enabled := false;

  FiniLCD();

  if (Data <> nil) then
  begin
    if (Data.CanExit()) then
    begin
      Data.Free();
      Data := nil;
    end;  // otherwise just leak it.
  end;
  if (Data = nil) and (config <> nil) then
  begin
    config.Free();
    config := nil;
  end;
end;

procedure TLCDSmartieDisplayForm.FormShow(Sender: TObject);
begin
  timerRefresh.Interval := 0; // reset timer
  timerRefresh.Interval := 1; // make it short in case minimized has been selected.
  CoolTrayIcon1.IconVisible := false;
end;

procedure TLCDSmartieDisplayForm.FormKeyPress(Sender: TObject; var Key: Char);
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
  if upcase(key)=',' then PreviousButton.click();
  if upcase(key)='.' then NextButton.click();
  if (upcase(key)='?') or (upcase(key)='/') then
  begin
    HTTPUpdateTimer.interval := 10;
    GameUpdateTimer.interval := 10;
    EMailTimer.interval := 10;
    MBMUpdateTimer.interval := 10;
  end;
end;

procedure TLCDSmartieDisplayForm.ResizeHeight;
var
  iDelta: Integer;
begin
  ScreenLCD[2].visible := false;
  ScreenLCD[3].visible := false;
  ScreenLCD[4].visible := false;
  Line2RightScrollImage.visible := false;
  Line3RightScrollImage.visible := false;
  Line4RightScrollImage.visible := false;
  Line2LeftScrollImage.visible := false;
  Line3LeftScrollImage.visible := false;
  Line4LeftScrollImage.visible := false;

  if config.height > 1 then
  begin
    ScreenLCD[2].visible := true;
    Line2RightScrollImage.Visible := true;
    Line2LeftScrollImage.Visible := true;
  end;
  if config.height > 2 then
  begin
    ScreenLCD[3].visible := true;
    Line3RightScrollImage.Visible := true;
    Line3LeftScrollImage.Visible := true;
  end;
  if config.height > 3 then
  begin
    ScreenLCD[4].visible := true;
    Line4RightScrollImage.Visible := true;
    Line4LeftScrollImage.Visible := true;
  end;

  iDelta := 16 * (4-config.height);

  SetupImage.Top := 69 - iDelta;
  BarLeftImage.Top := 64 - iDelta;
  BarMiddleImage.Top := 64 - iDelta;
  ScreenNumberPanel.Top := 72 - iDelta;
  BarRightImage.Top := 64 - iDelta;
  HideImage.Top := 69 - iDelta;
  LogoImage.Top := 64 - iDelta;
  ClientHeight := 90 - iDelta;

  NextScreenImage.Height := 64 - iDelta;
  PreviousImage.Height := 64 - iDelta;
  NextScreenImage.Stretch := (config.height <> 4);
  PreviousImage.Stretch := (config.height <> 4);
end;

procedure TLCDSmartieDisplayForm.ResizeWidth;
var
  h: Integer;
  iDelta: Integer;
  iTempWidth: Integer;
begin

  iTempWidth := config.width;
  if (iTempWidth < 20) then iTempWidth := 20;

  iDelta := 321 - ((321 * iTempWidth) div 40);

{  if (config.width = 40) then
    iDelta := 0
  else if (config.width = 24) then
    iDelta := 128
  else
    iDelta := 158;}

  Width := 389 - iDelta;
  LogoImage.left := 356 - iDelta;
  NextScreenImage.left := 368 - iDelta;
  Line1LeftScrollImage.left := 352 - iDelta;
  Line2LeftScrollImage.left := 352 - iDelta;
  Line3LeftScrollImage.left := 352 - iDelta;
  Line4LeftScrollImage.left := 352 - iDelta;
  BarRightImage.left := 266 - iDelta;
  HideImage.left := 323 - iDelta;
  for h := 1 to 4 do
  begin
    ScreenLCD[h].width := 321 - iDelta;
  end;
  BarMiddleImage.width := 220 - iDelta;


  if (config.width = 40) then
  begin
    ScreenNumberPanel.left := 115;
    ScreenNumberPanel.width := 130;
    ScreenNumberPanel.Caption := 'Theme: ' + IntToStr(activetheme + 1) + ' Screen: ' +
      IntToStr(activeScreen)
  end
  else
  begin
    ScreenNumberPanel.left := (87 * iTempWidth) div 20;
    ScreenNumberPanel.width := 33;
    ScreenNumberPanel.Caption := IntToStr(activetheme + 1) + ' | ' + IntToStr(activeScreen);
  end;
end;

procedure TLCDSmartieDisplayForm.WMPowerBroadcast (var M: TMessage);
const
  PBT_APMSUSPEND = 4;
  PBT_APMSTANDBY = 5;
  PBT_APMRESUMECRITICAL = 6;
  PBT_APMRESUMESUSPEND = 7;
  PBT_APMRESUMESTANDBY = 8;
  PBT_APMRESUMEAUTOMATIC = $012;
begin
  if (M.WParam = PBT_APMRESUMEAUTOMATIC) or (M.WParam = PBT_APMRESUMECRITICAL)
    or (M.WParam = PBT_APMRESUMESTANDBY) or (M.WParam = PBT_APMRESUMESUSPEND)
    then
  begin
    ReInitLCD();
  end
  else if (M.WParam = PBT_APMSUSPEND) or (M.WParam = PBT_APMSTANDBY) then
  begin
    FiniLCD();
    Lcd := TLCD.Create(); // replace with a dummy driver.
  end;
end;


procedure TLCDSmartieDisplayForm.PopupMenu1Popup(Sender: TObject);
begin
  if Visible then
    ShowWindow1.caption := '&Minimize'
  else
    ShowWindow1.caption := 'Show Main';
end;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      T I M E R      E V E N T S                                       ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TLCDSmartieDisplayForm.HTTPUpdateTimerTimer(Sender: TObject);
begin
  if (data.lcdSmartieUpdate) then
  begin
    data.lcdSmartieUpdate := False;

    if MessageDlg('A new version of LCD Smartie is detected. ' + chr(13) +
      data.lcdSmartieUpdateText + chr(13) + 'Go to LCD Smartie website?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ShellExecute(0, Nil, pchar('http://lcdsmartie.sourceforge.net/'), Nil,
        Nil, SW_NORMAL);
    end;

    if (bTerminating) then Exit;
  end;

  Data.UpdateHTTP();
  HTTPUpdateTimer.Interval := 0;
  HTTPUpdateTimer.Interval := config.newsRefresh*1000*60;
end;

procedure TLCDSmartieDisplayForm.GameUpdateTimerTimer(Sender: TObject);
begin
  Data.updateGameStats;
  GameUpdateTimer.Interval := 0;
  GameUpdateTimer.Interval := config.gameRefresh*60000;
end;


procedure TLCDSmartieDisplayForm.MBMUpdateTimerTimer(Sender: TObject);
begin
  Data.updateMBMStats(Sender);
  MBMUpdateTimer.Interval := 0;
  MBMUpdateTimer.Interval := config.mbmRefresh*1000;
end;

procedure TLCDSmartieDisplayForm.EMailTimerTimer(Sender: TObject);
//MAILS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
begin
  EMailTimer.Interval := 0;
  EMailTimer.Interval := config.emailPeriod*60000;
  Data.UpdateEmail;
end;

procedure TLCDSmartieDisplayForm.TransitionTimerTimer(Sender: TObject);
begin
  TransitionTimer.Enabled := false;
end;

procedure TLCDSmartieDisplayForm.ScrollFlashTimerTimer(Sender: TObject);
begin
  ScrollFlashTimer.Interval := 0;
  ScrollFlashTimer.Interval := config.scrollPeriod;
  canscroll := true;
  Inc(flashdelay);
  if ((not doesflash) and (flashdelay >= 2)) or
    (doesflash and (flashdelay >= 1)) then
  begin
    flashdelay := 0;
    canflash := true;
  end;
end;

procedure TLCDSmartieDisplayForm.LPTStartupTimerTimer(Sender: TObject);
begin
  LPTStartupTimer.Enabled := false;

  // check just in case they've changed they mind in the mean time.
  if (config.ScreenType in [stHD,stHD2]) then
  begin

    FiniLCD(); // get rid of the dummy one.
    try
      Lcd := TLCD_HD.CreateParallel($ + config.parallelPort, config.width, config.height);
    except
      on E: Exception do
      begin
        showmessage('Failed to open device: ' + E.Message);
        Lcd := TLCD.Create();
      end;
    end;
    Lcd.setbacklight(true);

    customchar('1, 12, 18, 18, 12, 0, 0, 0, 0');
    customchar('2, 31, 31, 31, 31, 31, 31, 31, 31');
    customchar('3, 16, 16, 16, 16, 16, 16, 31, 16');
    customchar('4, 28, 28, 28, 28, 28, 28, 31, 28');
  end;

  UpdateTimersState(PerformingSetup);
end;

procedure TLCDSmartieDisplayForm.ActionsTimerTimer(Sender: TObject);
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
  iLeftStrLen: Integer;
  iRightStrLen: Integer;

begin

  if (Lcd <> nil) and (Lcd.readKey(cKey)) then
  begin
    UpdateSetupForm(cKey);
    data.cLastKeyPressed := cKey;
  end;


  if PerformingSetup then Exit;


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
    iLeftStrLen := Length(sLeftValue);
    while (iTemp <= iLeftStrLen) and (sLeftValue[iTemp]>='0')
      and (sLeftValue[iTemp]<='9') do iTemp := iTemp +1 ;

    if (iTemp > iLeftStrLen) then
    begin
      iTemp := 1;
      iRightStrLen := Length(sRightValue);
      while (iTemp <= iRightStrLen) and (sRightValue[iTemp]>='0')
        and (sRightValue[iTemp]<='9') do iTemp := iTemp + 1;

      if (iTemp > iRightStrLen) then bNum := True;
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
  data.NewScreen(False);

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

// For scrolling right when a line scroll button is pressed.
procedure TLCDSmartieDisplayForm.LeftManualScrollTimerTimer(Sender: TObject);
begin
  scrollLine(line2scroll, 1);
end;

// For scrolling left when a line scroll button is pressed.
procedure TLCDSmartieDisplayForm.RightManualScrollTimerTimer(Sender: TObject);
begin
  scrollLine(line2scroll, -1);
end;

procedure TLCDSmartieDisplayForm.NextScreenTimerTimer(Sender: TObject);
//NEXT SCREEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  xx, x: Integer;
  y: Integer;
  ascreen: TScreenLine;
  tmpscreen: Integer;
  FindAnotherScreen : boolean;

begin
  tmpScreen := activeScreen;
  x := 0;
  xx := 0;
  FindAnotherScreen := true;
  while FindAnotherScreen do begin
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
      tmpScreen := tmpScreen + NumberOfScreensToShift;
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

    case ascreen.skip of
      1 : FindAnotherScreen := (winampctrl1.GetSongInfo(1) = 0);
      2 : FindAnotherScreen := (winampctrl1.GetSongInfo(1) <> 0);
      3 : FindAnotherScreen := (not Data.mbmactive);
      4 : FindAnotherScreen := (Data.mbmactive);
      5 : FindAnotherScreen := (not Data.gotEmail);
      6 : FindAnotherScreen := (Data.gotEmail);
      7 : FindAnotherScreen := (not Data.isconnected);
      8 : FindAnotherScreen := (Data.isconnected);
      else FindAnotherScreen := false;
    end;
    if (ascreen.theme <> activetheme) then FindAnotherScreen := true;
    if (not ascreen.enabled) then FindAnotherScreen := true;
  end;

  NumberOfScreensToShift := 1;

  if (activeScreen <> tmpScreen) then
  begin
    ChangeScreen(tmpScreen); // changes activeScreen
    TransitionTimer.Enabled := True;
  end;
end;

procedure TLCDSmartieDisplayForm.TimerRefreshTimer(Sender: TObject);
var
  counter, h: Integer;
  line: String;
  scrollcount: Integer;

begin
  //timerRefresh.Interval := 0;
  timerRefresh.Interval := config.refreshRate;

  // This code can't go in FormCreate or FormShow because it either
  // doesn't work (FormCreate) or causes an exception (FormShow).
  if (InitialWindowState <> NoChange) then
  begin
    case InitialWindowState of
      HideMainForm : Application.Minimize;
      TotalHideMainForm : CoolTrayIcon1.HideMainForm;
    end;
    InitialWindowState := NoChange;
  end;

  if ((gotnewlines = false) OR (TransitionTimer.enabled = false))then
  begin
    if (bNewScreen) and (gotnewlines) then
    begin
       bNewScreen := False;
       customchar('1, 12, 18, 18, 12, 0, 0, 0, 0');
       customchar('2, 31, 31, 31, 31, 31, 31, 31, 31');
       customchar('3, 16, 16, 16, 16, 16, 16, 31, 16');
       customchar('4, 28, 28, 28, 28, 28, 28, 31, 28');
    end;

    if iSavedColorMode <> config.colorOption then
    begin
      iSavedColorMode := config.colorOption;
      SetOnscreenBacklight();
    end;

    if (config.alwaysOnTop) {and (not form2.Visible) and (not form4.Visible)}
      then
    begin
      LCDSmartieDisplayForm.formStyle := fsStayOnTop;
    end
    else
    begin
      LCDSmartieDisplayForm.formStyle := fsNormal;
    end;

    if (config.width <> iSavedWidth) then
    begin
      iSavedWidth := config.width;
      ResizeWidth();
    end;

    if config.height <> iSavedHeight then
    begin
      iSavedHeight := config.height;
      ResizeHeight();
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
        line := CenterText(line, config.width);

      parsedLine[counter] := line;
      newline[counter] := line;  // Used by screen change transition.
    end;
    if (not TransitionTimer.enabled) then SendCustomChars();
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

  if TransitionTimer.Enabled = false then
  begin
    if (ResetContrast) then
    begin
      // A contrast fade "transition" has just happened so reset the contrast
      // just in case we failed to get the expected number of cycles (due to
      // high cpu loads etc).
      ResetContrast := False;
      if (config.ScreenType = stMO) then Lcd.setContrast(config.contrast)
      else
        if (config.ScreenType = stCF) then Lcd.setContrast(config.CF_contrast);
    end;

    if (canscroll) then
    begin
      canscroll := false;
      scrollcount := 1;

      doesGPOflash := not doesGPOflash;
      if (GPOflash > 0) then
      begin
        GPOflash := GPOflash -1;
        DoGPO(whatGPO, 2)
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
        ScreenLCD[counter].Caption := EscapeAmp(scroll(parsedLine[counter],
          counter, scrollcount))
      else
        if (scrollPos[counter]>1) then     // maintain manual scroll postion
          ScreenLCD[counter].Caption := EscapeAmp(scroll(parsedLine[counter], counter, 0))
        else
          ScreenLCD[counter].Caption := EscapeAmp(copy(parsedLine[counter], 1, config.width));
    end;

  end
  else
  begin          // TransitionTimer.Enabled = true
    DoTransitions();
  end;


  for h := 1 to config.height do
  begin
    if tmpline[h] <> copy(UnescapeAmp(ScreenLCD[h].Caption) +
      '                                        ', 1, config.width) then
    begin
      tmpline[h] := copy(UnescapeAmp(ScreenLCD[h].Caption)
        + '                                        ', 1, config.width);

      Lcd.setPosition(1, h);
      Lcd.write(tmpline[h]);
    end;
  end;
end;

procedure TLCDSmartieDisplayForm.UpdateTimersState(InSetupState : boolean);
begin
  if not InSetupState then
  begin    // We're not in setup
    // don't change timer states if we're waiting for a HD44780 to start.
    if (not LPTStartupTimer.enabled) then
    begin
      if not frozen then
      begin
        NextScreenTimer.enabled := true; // next screen
      end;
    end;
  end
  else
  begin    // We're in Setup
    LeftManualScrollTimer.enabled := false;     // left manual scroll
    RightManualScrollTimer.enabled := false;     // right manual scroll
    NextScreenTimer.enabled := false;     // next screen
    TransitionTimer.enabled := false; // "transitions"
  end;


  HTTPUpdateTimer.enabled := true;  // http update
  ActionsTimer.enabled := true;  // actions
  MBMUpdateTimer.enabled := true;  // mbm update
  GameUpdateTimer.enabled := true;  // game update
  EMailTimer.enabled := true;  // email update
  ScrollFlashTimer.enabled := true; // scroll/flash

  if (not LPTStartupTimer.enabled) then
    timerRefresh.enabled := true;  // update lcd and data
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////       B U T T O N  /  M E N U       H A N D L E R S                   ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TLCDSmartieDisplayForm.Close1Click(Sender: TObject);
begin
  Close;
end;

// ShowMenu/Minimize has been selected from the tray/popup menu
procedure TLCDSmartieDisplayForm.ShowWindow1Click(Sender: TObject);
begin
  if Visible then
    Application.Minimize
  else
    CoolTrayIcon1.ShowMainForm;
end;

// The LCD Smartie logo has been clicked - raise popup menu
procedure TLCDSmartieDisplayForm.LogoImageClick(Sender: TObject);
begin
  popupmenu1.Popup(LCDSmartieDisplayForm.left + LogoImage.left + round(LogoImage.width/2), LCDSmartieDisplayForm.top
    + LogoImage.top + round(LogoImage.height));
end;

procedure TLCDSmartieDisplayForm.SetupButtonClick(Sender: TObject);
begin
  if not (LPTStartupTimer.enabled) then begin
    UpdateTimersState(true); // turns off required timers as form2 is visible.
    if not Visible then
      CoolTrayIcon1.ShowMainForm;
    DoSetupForm;
    UpdateTimersState(false);
  end;
end;

procedure TLCDSmartieDisplayForm.HideButtonClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TLCDSmartieDisplayForm.PreviousImageClick(Sender: TObject);
begin
  PreviousButton.click;
end;

procedure TLCDSmartieDisplayForm.PreviousButtonClick(Sender: TObject);
begin
  NumberOfScreensToShift := -1;
  frozen := true;
  freeze();
end;

procedure TLCDSmartieDisplayForm.NextScreenImageClick(Sender: TObject);
begin
  NextButton.click;
end;

procedure TLCDSmartieDisplayForm.NextButtonClick(Sender: TObject);
begin
  NumberOfScreensToShift := 1;
  frozen := true;
  freeze();
end;

procedure TLCDSmartieDisplayForm.BacklightOn1Click(Sender: TObject);
begin
  backlit();
end;

procedure TLCDSmartieDisplayForm.Credits1Click(Sender: TObject);
begin
  DoCreditsForm;
end;

procedure TLCDSmartieDisplayForm.LogoImageDblClick(Sender: TObject);
begin
  DoCreditsForm;
end;

procedure TLCDSmartieDisplayForm.NextTheme1Click(Sender: TObject);
begin
  activetheme := activetheme + 1;
  if activetheme = 10 then activetheme := 0;
  frozen := true;
  freeze();
end;

procedure TLCDSmartieDisplayForm.LastTheme1Click(Sender: TObject);
begin
  activetheme := activetheme-1;
  if activetheme=-1 then activetheme := 9;
  frozen := true;
  freeze();
end;

procedure TLCDSmartieDisplayForm.Freeze1Click(Sender: TObject);
begin
  freeze();
end;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////    M O U S E    D O W N / U P    E V E N T    H A N D L E R S         ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TLCDSmartieDisplayForm.Line1RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line1RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down1.bmp');
  line2scroll := 1;
  RightManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line1RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line1RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up1.bmp');
  RightManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line1LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line1LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down1.bmp');
  line2scroll := 1;
  LeftManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line1LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line1LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up1.bmp');
  LeftManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line2RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line2RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down2.bmp');
  line2scroll := 2;
  RightManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line2RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line2RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up2.bmp');
  RightManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line2LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line2LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down2.bmp');
  line2scroll := 2;
  LeftManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line2LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line2LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up2.bmp');
  LeftManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line3RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line3RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down3.bmp');
  line2scroll := 3;
  RightManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line3RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line3RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up3.bmp');
  RightManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line3LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line3LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down3.bmp');
  line2scroll := 3;
  LeftManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line3LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line3LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up3.bmp');
  LeftManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line4RightScrollImageMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line4RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_down4.bmp');
  line2scroll := 4;
  RightManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line4RightScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line4RightScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_left_up4.bmp');
  RightManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.Line4LeftScrollImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Line4LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_down4.bmp');
  line2scroll := 4;
  LeftManualScrollTimer.enabled := true;
  timerRefresh.enabled := false;
end;

procedure TLCDSmartieDisplayForm.Line4LeftScrollImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  Line4LeftScrollImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\small_arrow_right_up4.bmp');
  LeftManualScrollTimer.enabled := false;
  timerRefresh.enabled := true;
end;

procedure TLCDSmartieDisplayForm.PreviousImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PreviousImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_left_down.bmp');
end;

procedure TLCDSmartieDisplayForm.PreviousImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  PreviousImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_left_up.bmp');
end;

procedure TLCDSmartieDisplayForm.SetupImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetupImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\setup_down.bmp');
end;

procedure TLCDSmartieDisplayForm.SetupImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  SetupImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\setup_up.bmp');
end;

procedure TLCDSmartieDisplayForm.HideImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  HideImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\hide_down.bmp');
end;

procedure TLCDSmartieDisplayForm.HideImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  HideImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\hide_up.bmp');
end;

procedure TLCDSmartieDisplayForm.NextScreenImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  NextScreenImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_right_down.bmp');
end;

procedure TLCDSmartieDisplayForm.NextScreenImageMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  NextScreenImage.picture.LoadFromFile(extractfilepath(application.exename) +
    'images\big_arrow_right_up.bmp');
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      L C D    I N I T I A L I Z A T I O N     P R O C E D U R E S     ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////



procedure TLCDSmartieDisplayForm.InitLCD();
const
  baudRates: array [0..14] of Cardinal =(CBR_110, CBR_300, CBR_600, CBR_1200, CBR_2400,
    CBR_4800, CBR_9600, CBR_14400, CBR_19200, CBR_38400, CBR_56000, CBR_57600,
    CBR_115200, CBR_128000, CBR_256000);
var
  i: Integer;
begin
  LPTStartupTimer.enabled := false; // stop any startup of the HD44780 driver

  // Sync the display to our current view of the custom chars.
  for i:= 1 to 8 do
    customCharsChanged[i] := true;

  // start connectivity
  try
    case config.ScreenType of
      stMO : begin
        if config.isUsbPalm then
          Lcd := TLCD_MO.CreateUsb
        else
          Lcd := TLCD_MO.CreateSerial(config.comPort, baudRates[config.baudrate]);
      end;
      stCF : Lcd := TLCD_CF.CreateSerial(config.comPort, baudRates[config.baudrate]);
      stTestDriver : Lcd := TLCD_Test.CreateSerial(config.comPort, baudRates[config.baudrate]);
      stIR : Lcd := TLCD_IR.CreateSocket(config.RemoteHost);
      stHD,stHD2 : begin
        Lcd := TLCD.Create(); // use a dummy LCD until the boot time has passed.
        // HD/HD2 have a delay start - they will setup the above timers later.
        LPTStartupTimer.interval := 0;
        if config.bootDriverDelay = 0 then LPTStartupTimer.interval := 10
        else LPTStartupTimer.interval := config.bootDriverDelay*1000;
        LPTStartupTimer.enabled := true;
      end;
      else Lcd := TLCD.Create(); // catchall case
    end; // case
  except
    on E: Exception do
    begin
      showmessage('Failed to open device: ' + E.Message);
      Lcd := TLCD.Create();
    end;
  end;

  // load custom characters if the display supports it
  if (config.ScreenType in [stMO,stCF,stIR]) then
  begin
    customchar('1, 12, 18, 18, 12, 0, 0, 0, 0');
    customchar('2, 31, 31, 31, 31, 31, 31, 31, 31');
    customchar('3, 16, 16, 16, 16, 16, 16, 31, 16');
    customchar('4, 28, 28, 28, 28, 28, 28, 31, 28');
  end;

  // set brightness and contrast if the display supports it
  case config.ScreenType of
    stMO : begin
      Lcd.setContrast(config.contrast);
      Lcd.setBrightness(config.brightness);
    end;
    stCF : begin
      Lcd.setBrightness(config.CF_brightness);
      Lcd.setContrast(config.CF_contrast);
    end;
    stIR : Lcd.setBrightness(config.IR_brightness);
  end; // case

  DoFullDisplayDraw();

  UpdateTimersState(PerformingSetup);
end;

procedure TLCDSmartieDisplayForm.FiniLCD();
begin
  LPTStartupTimer.enabled := false; // stop any startup of the HD44780 driver
  timerRefresh.enabled := false;  // stop updates to lcd
  try
    if (Lcd <> nil) Then Lcd.Destroy();
  except
  end;
  Lcd := nil;
end;

procedure TLCDSmartieDisplayForm.ReInitLCD();
begin
  FiniLCD();
  InitLCD();
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////      L C D    D I S P L A Y     G L O B A L   P R O C E D U R E S     ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////



procedure TLCDSmartieDisplayForm.customchar(fline: String);
var
  character: Integer;
  waarde: Array[0..7] of Byte;
  i: Integer;
  iPosStart, iPosEnd: Integer;

begin
  iPosEnd := pos(',', fline);
  character := StrToIntN(fline, 1, iPosEnd-1);
  for i := 0 to 6 do
  begin
    iPosStart := iPosEnd + 1;
    iPosEnd := PosEx(',', fline, iPosStart);
    waarde[i] := StrToIntN(fline, iPosStart, iPosEnd-iPosStart);
  end;
  waarde[7] := StrToIntN(fline, iPosEnd+1, length(fline)-iPosEnd);

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

procedure TLCDSmartieDisplayForm.SendCustomChars;
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


procedure TLCDSmartieDisplayForm.DoGPO(const ftemp1, ftemp2: Integer);
begin
  if ftemp1 < 9 then
  begin
    if ftemp2 = 0 then
    begin
      Lcd.setGPO(ftemp1, false);
      GPO[ftemp1] := false;
    end;
    if ftemp2 = 1 then
    begin
      Lcd.setGPO(ftemp1, true);
      GPO[ftemp1] := true;
    end;
    if ftemp2 = 2 then
    begin
      if (GPO[ftemp1]) then
      begin
        Lcd.setGPO(ftemp1, false);
        GPO[ftemp1] := false;
      end
      else
      begin
        Lcd.setGPO(ftemp1, true);
        GPO[ftemp1] := true;
      end;
    end;
  end;
end;


procedure TLCDSmartieDisplayForm.ProcessAction(bDoAction: Boolean; sAction: String);
var
  temp1, temp2: String;
  iTemp: Integer;
  args: Array [0..maxArgs-1] of String;
  prefix, postfix: String;
  numArgs: Cardinal;
  sSecondAction: String;
  uiPlugin: Cardinal;
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

  if (pos('GPO(', sAction) <> 0) and (config.ScreenType = stMO) then
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
        DoGPO(StrToInt(temp1), StrToInt(temp2));
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
          uiPlugin := data.FindPlugin(args[0]);
          sSecondAction := data.CallPlugin(uiPlugin, StrToInt(args[1]), args[2], args[3]);
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
      NumberOfScreensToShift := 1;
      frozen := true;
      freeze();
    end;

    if (pos('LastScreen', sAction) <> 0) then
    begin
      NumberOfScreensToShift := -1;
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
      HTTPUpdateTimer.interval := 10;
      MBMUpdateTimer.interval := 10;
      GameUpdateTimer.interval := 10;
      EMailTimer.interval := 10;
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

    if (pos('WA', sAction) <> 0) then
    begin
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
    end;

    if (pos('GPOFlash(', sAction) <> 0) and (config.ScreenType = stMO) then
    begin
      try
        whatGPO := StrToInt(copy(sAction, pos('(', sAction) + 1,
          pos(',', sAction)-pos('(', sAction)-1));
        temp2 := copy(sAction, pos(',', sAction) + 1,
          pos(')', sAction)-pos(',', sAction)-1);
        GPOflash := StrToInt(temp2)*2;
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
        DoGPO(StrToInt(temp1), 2)
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

// sets Backlight - toggles if no parameter given
procedure TLCDSmartieDisplayForm.backlit(iOn: Integer = -1);
begin
  if (iOn = -1) then
    Backlight := not Backlight
  else
    Backlight := boolean(iOn);

  Lcd.setbacklight(Backlight);

  if not Backlight then
    BacklightOn1.Caption := '&Backlight On'
  else
    BacklightOn1.Caption := '&Backlight Off';
  LCDSmartieDisplayForm.SetOnscreenBacklight();
end;


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////  S C R E E N    D I S P L A Y     G L O B A L   P R O C E D U R E S   ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TLCDSmartieDisplayForm.DoFullDisplayDraw;
var
  x: Integer;
begin
  // Wipe the our view of the display - this will cause a full redraw.
  for x := 1 to config.height do
  begin
    tmpline[x] := '';
  end;
end;

procedure TLCDSmartieDisplayForm.ResetScrollPositions;
var
  y: Integer;
begin
  for y := 1 to 4 do
  begin
    scrollPos[y] := 1; // Reset scroll postion.
  end;
end;

function TLCDSmartieDisplayForm.scroll(const scrollvar: String;const line, speed: Integer):
  String;
var
  scrolltext: String;
  len: Integer;
begin

  if length(scrollvar) > config.width then
  begin
    scrollPos[line] := scrollPos[line] + speed;
    if (scrollPos[line]<1) then scrollPos[line] := length(scrollvar);
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

procedure TLCDSmartieDisplayForm.freeze();
begin
  if frozen = false then
  begin
    frozen := true;
    NextScreenTimer.enabled := false;
    Freeze1.Caption := 'Unfreeze';
    LCDSmartieDisplayForm.caption := LCDSmartieDisplayForm.caption + ' - frozen'
  end
  else
  begin
    frozen := false;
    NextScreenTimer.enabled := true;
    NextScreenTimer.interval := 0;
    NextScreenTimer.interval := 5;
    Freeze1.Caption := 'Freeze';
    if pos('frozen', LCDSmartieDisplayForm.caption) <> 0 then LCDSmartieDisplayForm.caption :=
      copy(LCDSmartieDisplayForm.caption, 1, length(LCDSmartieDisplayForm.caption)-length(' - frozen'));
  end;
end;

// Only used when line scroll button is pressed.
procedure TLCDSmartieDisplayForm.scrollLine(line: Byte; direction: Integer);
begin
  tmpline[line] := copy (scroll(parsedLine[line], line, direction)
    + '                                        ', 1, config.width);
  ScreenLCD[line].caption := EscapeAmp(tmpline[line]);
  Lcd.setPosition(1, line);
  Lcd.write(tmpline[line]);
end;

procedure TLCDSmartieDisplayForm.SetOnscreenBacklight;
var
  ScreenColor,FontColor : TColor;
  Loop : byte;
begin
  ScreenColor := clWhite;
  FontColor := clBlack;
  if Backlight then begin // Backlight is on
    case (config.colorOption) of
      0  : begin
        ScreenColor := $0001FFA8;
        FontColor := clBlack;
      end;
      1  : begin
        ScreenColor := $00FDF103;
        FontColor := clBlack;
      end;
      2  : begin
        ScreenColor := clYellow;
        FontColor := clBlack;
      end;
      3  : begin
        ScreenColor := clWhite;
        FontColor := clBlack;
      end;
      4  : begin
        ScreenColor := BackgroundColorOn;
        FontColor := ForgroundColorOn;
      end;
    end; // case
  end else begin // Backlight is off
    case (config.colorOption) of
      0  : begin
        ScreenColor := clGreen;
        FontColor := clBlack;
      end;
      1  : begin
        ScreenColor := $00C00000;
        FontColor := clWhite;
      end;
      2  : begin
        ScreenColor := clOlive;
        FontColor := clBlack;
      end;
      3  : begin
        ScreenColor := clSilver;
        FontColor := clBlack;
      end;
      4  : begin
        ScreenColor := BackgroundColorOff;
        FontColor := ForgroundColorOff;
      end;
    end; // case
  end; // not background on

  LCDSmartieDisplayForm.Color := ScreenColor;
  for Loop := 1 to 4 do begin
    ScreenLCD[Loop].Color := ScreenColor;
    ScreenLCD[Loop].Font.Color := FontColor;
  end;
end;



///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////        S C R E E N     C H A N G E      P R O C E D U R E S           ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


procedure TLCDSmartieDisplayForm.ChangeScreen(scr: Integer);
var
  y: Integer;
  ascreen: TScreenLine;
begin

  if TempTransitionTimerInterval <> 0 then
  begin
    TransitionTimer.Interval := 0;
    TransitionTimer.Interval := TempTransitionTimerInterval;
  end;
  NextScreenTimer.Interval := 0; // reset timer

  if (not config.screen[scr][1].bSticky) then
    NextScreenTimer.Interval := config.screen[scr][1].showTime*1000 + TempTransitionTimerInterval;

  if (activeScreen = scr) then
    Exit;

  activeScreen := scr;
  ascreen := config.screen[activeScreen][1];

  for y := 1 to 4 do
  begin
    oldline[y] := UnescapeAmp(ScreenLCD[y].Caption);
  end;

  ResetScrollPositions();

  gotnewlines := false;
  TransStart := GetTickCount();
  TransCycle := 0;
  iLastRandomTranCycle := 0;

  for y := 1 to 40 do
  begin
    GuessArray[1, y] := false;
    GuessArray[2, y] := false;
    GuessArray[3, y] := false;
    GuessArray[4, y] := false;
  end;

  TempTransitionTimerInterval := ascreen.TransitionTime*100;

  TransitionTemp := TransitionTemp2;
  TransitionTemp2 := ascreen.TransitionStyle;

  if not ascreen.enabled then TransitionTemp2 := tsNone;
  if TransitionTemp2 = tsNone then TempTransitionTimerInterval := 1;

  if (config.width = 40) then
    ScreenNumberPanel.Caption := 'Theme: ' + IntToStr(activetheme + 1) + ' Screen: ' +
      IntToStr(activeScreen)
  else
    ScreenNumberPanel.Caption := IntToStr(activetheme + 1) + ' | ' + IntToStr(activeScreen);

  bNewScreen := True;
  data.NewScreen(True);

end;

function TLCDSmartieDisplayForm.DoGuess(line: Integer): Integer;
var
  GoodGuess: Boolean;
  x: Integer;
  loopcount: Integer;

begin
  GoodGuess := false;
  x := 0;
  loopcount := 0;

  while not GoodGuess do begin
    Inc(loopcount);
    x := round(random(config.width) + 1);
    if GuessArray[line, x] = false then begin
      GoodGuess := true;
    end else if (loopcount > config.width*2) then begin
      // it's taking too long - use first unset element
      x := 0;
      repeat
        Inc(x);
        if (GuessArray[line, x] = false) then GoodGuess := true;
      until (x >= config.width) or (GoodGuess);
      if (not GoodGuess) then
      begin
      // all the elements are set - use 1 (arb.)
        x := 1;
        GoodGuess := true;
      end;
    end;
  end;
  GuessArray[line, x] := true;
  result := x;
end;

procedure TLCDSmartieDisplayForm.DoTransitions;
var
  GuessRegister: Array[1..4] of String;
  tempstr: String;
  line: Integer;
  maxTransCycles: Integer;
  Guess: Integer;
  x: Integer;
  iContrast: Integer;
  now: Cardinal;

begin
  // Changing screen - do any transitions required.
  //TransCycle := TransCycle + 1;
  now := GetTickCount();
  if (now < TransStart) then
    TransCycle := (now + (MAXDWORD-TransStart)) div timerRefresh.Interval
  else
    TransCycle := (now-TransStart) div timerRefresh.Interval;

  maxTransCycles := TransitionTimer.Interval div timerRefresh.Interval;

  if (maxTransCycles = 0) then Exit;
  if (TransCycle > maxTransCycles) then Exit;

  if (TransCycle > maxTransCycles / 2) then SendCustomChars();

  for x := 1 to config.height do begin
    oldline[x] := copy(oldline[x] +
      '                                        ', 1, config.width);
    newline[x] := copy(newline[x] +
      '                                        ', 1, config.width);
  end;

  case TransitionTemp of

    tsLeftRight  : begin  //left-->right

      for x := 1 to config.height do
      begin
        tempstr := copy(newline[x] + '|' + oldline[x], round((config.width +
          2)-TransCycle*((config.width + 2)/maxTransCycles)), config.width);
        ScreenLCD[x].Caption := EscapeAmp(tempstr);
      end;
    end;

    tsRightLeft : begin  //right-->left

      for x := 1 to config.height do
      begin
        tempstr := copy(oldline[x] + '|' + newline[x],
          round(TransCycle*((config.width + 2)/maxTransCycles)),
          config.width);
        ScreenLCD[x].Caption := EscapeAmp(tempstr);
      end;
    end;

    tsTopBottom : begin //top-->bottom

      line := round(TransCycle*(config.height/maxTransCycles)) + 1;
      for x := 1 to line-1 do
      begin
        ScreenLCD[x].Caption := EscapeAmp(newline[config.height-(line-1)+ x]);
      end;

      if (line <= config.height) then
        ScreenLCD[line].Caption :=
          copy('----------------------------------------', 1, config.width);

      for x := line + 1 to config.height do
      begin
        ScreenLCD[x].Caption := EscapeAmp(oldline[x-(line + 1) + 1]);
      end;
    end;

    tsBottomTop : begin  //bottom-->top

      line := round(TransCycle*(config.height/maxTransCycles)) + 1;
      for x := 1 to config.height-line do
      begin
        ScreenLCD[x].Caption := EscapeAmp(oldline[x + line-1]);
      end;

      if (config.height-line + 1 > 0) then
        ScreenLCD[config.height-line + 1].Caption :=
          copy('----------------------------------------', 1, config.width);

      for x := config.height-line + 2 to config.height do
      begin
        ScreenLCD[x].Caption :=
          EscapeAmp(newline[x-(config.height-line + 2) + 1]);
      end;
    end;

    tsRandomChars : begin //random blocks

      for x := 1 to 4 do
      begin
        GuessRegister[x] := copy(UnescapeAmp(ScreenLCD[x].caption) +
          '                                        ', 1, config.width);
      end;

      for x := iLastRandomTranCycle to
        round((config.width/maxTransCycles)*TransCycle)-1 do
      begin
        for line := 1 to 4 do
        begin
          Guess := DoGuess(line);
          GuessRegister[line] := copy(GuessRegister[line], 1, Guess-1) +
            copy(newline[line], Guess, 1) + copy(GuessRegister[line], Guess +
            1, config.width-Guess);
        end;
      end;
      iLastRandomTranCycle := round((config.width/maxTransCycles)*TransCycle);
      for x := 1 to 4 do
      begin
        ScreenLCD[x].caption := EscapeAmp(GuessRegister[x]);
      end;
    end;

    tsFade : begin
      if (maxTransCycles >= 2) then begin  //contrast fade
  // The fade is a two step process, so we need at least two cycles.

  // We only fade down to iMinFadeContrast; because many LCDs displays will be
  // blank long before we reach 0. (One user reported that their display was
  // blank at a contrast of 40).

  // For the first half of the cycles - lower the contrast

        if (TransCycle < maxTransCycles/2) then
        begin
          if (config.ScreenType = stMO)then x := config.contrast
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
            ScreenLCD[x].Caption := EscapeAmp(newline[x]);
          end;

          if (config.ScreenType = stMO) then x := config.contrast
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
  end; // case
end;



///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////                                                                       ////
////        M I S C E L L A N E O U S        P R O C E D U R E S           ////
////                                                                       ////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////



function TLCDSmartieDisplayForm.EscapeAmp(const sStr: string): String;
begin
  Result := StringReplace(sStr, '&', '&&', [rfReplaceAll])
end;

function TLCDSmartieDisplayForm.UnescapeAmp(const sStr: string): String;
begin
  Result := StringReplace(sStr, '&&', '&', [rfReplaceAll])
end;


procedure TLCDSmartieDisplayForm.SetupAutoStart;
var
  sParameters: String;
  sShortCutName: String;
  bDelete: Boolean;
begin
  sParameters := '';
  sShortCutName := 'LCD Smartie';

  if (config.bAutoStartHide) then
    sParameters := sParameters + '-hide ';

  if (config.filename <> 'config.ini') then
  begin
    sParameters := sParameters + '-config '+config.filename;
    sShortCutName := sShortCutName + config.filename;
  end;

  bDelete := not (config.bAutoStart or config.bAutoStartHide);

  CreateShortcut(sShortCutName, application.exename, sParameters, bDelete);
end;

end.

