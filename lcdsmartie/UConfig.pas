unit UConfig;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/UConfig.pas,v $
 *  $Revision: 1.50 $ $Date: 2006/03/10 14:35:36 $
 *****************************************************************************}

interface

Uses  Windows,SysUtils;

const
  sMyConfigFileFormatVersion = '1.0';
  sMyScreenTextSyntaxVersion = '1.0';

  MaxScreens = 20;
  MaxLines = 4;
  MaxCols = 40;
  MaxThemes = 10;
  MaxActions = 99;
  MaxScreenSizes = 12;
  MaxEmailAccounts = 10;

type
  TScreenSize = record
    SizeName : string[6];
    YSize : byte;
    XSize : byte;
  end;

const
  ScreenSizes : array[1..MaxScreenSizes] of TScreenSize = (
    (SizeName : '1x10'; YSize : 1; XSize : 10),
    (SizeName : '1x16'; YSize : 1; XSize : 16),
    (SizeName : '1x20'; YSize : 1; XSize : 20),
    (SizeName : '1x24'; YSize : 1; XSize : 24),
    (SizeName : '1x40'; YSize : 1; XSize : 40),
    (SizeName : '2x16'; YSize : 2; XSize : 16),
    (SizeName : '2x20'; YSize : 2; XSize : 20),
    (SizeName : '2x24'; YSize : 2; XSize : 24),
    (SizeName : '2x40'; YSize : 2; XSize : 40),
    (SizeName : '4x16'; YSize : 4; XSize : 16),
    (SizeName : '4x20'; YSize : 4; XSize : 20),
    (SizeName : '4x40'; YSize : 4; XSize : 40));


const
  BaudRates: array [0..14] of Cardinal =(CBR_110, CBR_300, CBR_600, CBR_1200, CBR_2400,
    CBR_4800, CBR_9600, CBR_14400, CBR_19200, CBR_38400, CBR_56000, CBR_57600,
    CBR_115200, CBR_128000, CBR_256000);

type
  TTransitionStyle = (tsNone,tsLeftRight,tsRightLeft,tsTopBottom,tsBottomTop,tsRandomChars,tsFade);

  TScreenType = (xxNone,xxHD,xxMO,xxCF,xxHD2,xxTestDriver,xxIR,xxDLL);

  TScreenLine = Record
    text: String;
    enabled: Boolean;
    skip: Integer;
    noscroll: Boolean;
    contNextLine: Boolean;
    theme: Integer;
    TransitionStyle : TTransitionStyle;
    TransitionTime : Integer;
    showTime: Integer;
    bSticky: Boolean;
    center: Boolean;
  end;

  TPopAccount = Record
    server: String;
    user: String;
    pword: String;
  end;

  TTestDriverSettings = Record
    iStopBits: Integer;  // 1 or 2
    iParity: Integer; // 0 = none, 1 = odd, 2 = even
    sInit: String;
    sFini: String;
    sGotoLine1, sGotoLine2, sGotoLine3, sGotoLine4: String;
    sCharMap: String;
  end;

  TConfig = class(TObject)
  private
    fScreenSize: Integer;
    P_width: Integer;
    P_height: Integer;
    uiActionsLoaded: Cardinal;
    sFileName: String;
    function loadINI: Boolean;
    function loadCCFG: Boolean;
    function loadACFG: Boolean;
    procedure saveINI;
    procedure SetScreenSize(con: Integer);
    procedure ConvertToDisplayDLL;
  public
    sSkinPath: String;
    localeFormat: TFormatSettings;
    bHideOnStartup: Boolean;
    bAutoStart, bAutoStartHide: Boolean;
    testDriver: TTestDriverSettings;
    isUsbPalm: Boolean;
    gameServer: Array[1..MaxScreens, 1..MaxLines] of String;
    pop: Array [0..MaxEmailAccounts-1] of TPopAccount;
    comPort: Integer;
    baudrate: Integer;
    refreshRate: Integer;
    bootDriverDelay: Integer;
    emailPeriod: Integer;
    dllPeriod: Integer;
    scrollPeriod: Integer;
    colorOption: Integer;
    alwaysOnTop: Boolean;
    httpProxy: String;
    httpProxyPort: Integer;
    newsRefresh: Integer;
    randomScreens: Boolean;
    gameRefresh: Integer;
    mbmRefresh: Integer;
    foldUsername: String;
    checkUpdates: Boolean;
    distLog: String;
    screen: Array[1..MaxScreens] of Array[1..MaxLines] of TScreenLine;
    winampLocation: String;
    setiEmail: String;
    actionsArray: Array[1..MaxActions, 1..4] of String;
    totalactions: Integer;
    // screen settings
    xScreenType : TScreenType;
    xiMinFadeContrast: Integer;  // can only set this in config file?
    // these apply to LPT displays
    xparallelPort: Integer;
    xbHDAltAddressing: Boolean;
    xbHDKS0073Addressing: Boolean;
    xiHDTimingMultiplier: Integer;
    // these apply to Matrix displays
    xcontrast: Integer;
    xbrightness: Integer;
    xmx3Usb: Boolean;
    // these apply to Crystal Fontz displays
    xCF_contrast: Integer;
    xCF_brightness: Integer;
    xiCF_cgrom: Integer;
    // these apply to IRTrans displays
    xIR_brightness: Integer;
    xremotehost : string;
    // these apply to DLL Plugin displays
    DisplayDLLName : string;
    DisplayDLLParameters : string;
    DLL_Contrast: integer;
    DLL_Brightness: integer;
    function load: Boolean;
    procedure save;
    property ScreenSize: Integer read fScreenSize write SetScreenSize;
    property width: Integer read P_width;
    property height: Integer read P_height;
    property filename: String read sFileName;
    constructor Create(filename: String);
  end;

var
  Config: TConfig;

implementation

uses Forms, INIFiles, StrUtils;

constructor TConfig.Create(filename: String);
begin
  sFileName := filename;
  xiMinFadeContrast := 0;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, localeFormat);
  inherited Create();
end;

procedure TConfig.SetScreenSize(con: Integer);
begin
  fScreenSize := con;
  P_width := ScreenSizes[fScreenSize].XSize;
  P_height := ScreenSizes[fScreenSize].YSize;
end;

function TConfig.loadACFG: Boolean;
var
  initfile: textfile;
  counter: Integer;
  configline: String;
begin
  // Load Actions
  counter := 0;
  try
    assignfile(initfile, extractfilepath(application.exename) +
      'actions.cfg');
    try
      reset (initfile);
      while not eof(initfile) do
      begin
        readln(initfile, configline);
        counter := counter + 1;
        actionsArray[counter, 1] := copy(configline, 1,
          pos('¿', configline)-1);
        actionsArray[counter, 2] := copy(configline, pos('¿',
          configline) + 1, 1);
        actionsArray[counter, 3] := copy(configline, pos('¿¿',
          configline) + 2, pos('¿¿¿', configline)-pos('¿¿', configline)-2);
        actionsArray[counter, 4] := copy(configline, pos('¿¿¿',
          configline) + 3, length(configline));
      end;
    finally
      closefile(initfile);
    end;
  except
  end;
  totalactions := counter;
  uiActionsLoaded := counter;

  result := true;

end;

function TConfig.loadCCFG: Boolean;
var
  initfile: textfile;
  ConfigLineCount, ScreenCount, LineCount: Integer;
  configline: String;
  configArray: Array[1..100] of String;
begin
  // Load Game server list.
  try
    assignfile(initfile, extractfilepath(application.exename) +
      'servers.cfg');
    try
      reset(initfile);
      for ScreenCount := 1 to MaxScreens do
        for LineCount := 1 to MaxLines do readln(initfile, gameServer[ScreenCount, LineCount]);
    finally
      closefile (initfile);
    end;
  except
    result := false;
    Exit;
  end;

  try
    assignfile(initfile, extractfilepath(application.exename) + 'config.cfg');
    reset(initfile);
  except
    result := false;
    Exit;
  end;

  for ConfigLineCount := 1 to 100 do readln(initfile, configArray[ConfigLineCount]);

  closefile(initfile);



  refreshRate := StrToInt(copy(configArray[1], 1, pos('¿',
    configArray[1])-1));
  winampLocation := copy(configArray[1], pos('¿', configArray[1]) + 1,
    length(configArray[1]));

  bootDriverDelay := StrToInt(copy(configArray[2], 1, pos('¿',
    configArray[2])-1));
  setiEmail := copy(configArray[2], pos('¿', configArray[2]) + 1,
    length(configArray[2]));

  SetScreenSize(strtoInt(copy(configArray[3], 1, pos('¿1',
    configArray[3])-1)));

  xcontrast := strtoint(copy(configArray[3], pos('¿1', configArray[3]) + 2,
    pos('¿2', configArray[3])-pos('¿1', configArray[3])-2));
  xbrightness := strtoint(copy(configArray[3], pos('¿2', configArray[3]) + 2,
    pos('¿3', configArray[3])-pos('¿2', configArray[3])-2));

  xCF_contrast := strtoint(copy(configArray[3], pos('¿3', configArray[3]) + 2,
    pos('¿4', configArray[3])-pos('¿3', configArray[3])-2));
  xCF_brightness := strtoint(copy(configArray[3], pos('¿4', configArray[3]) +
    2, 3));


  // Lines 4..83
  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to MaxLines do
    begin
      configline := configArray[ScreenCount*4 + (LineCount-1)];
      screen[ScreenCount][LineCount].enabled := copy(configline, pos('¿', configline) + 1,
        1)='1';
      screen[ScreenCount][LineCount].theme := StrToInt(copy(configline, pos('¿', configline) +
        5, 1));
      screen[ScreenCount][LineCount].showTime := StrToInt(copy(configline, pos('¿', configline)
        + 9, length(configline)));
      screen[ScreenCount][LineCount].skip := StrToInt(copy(configline, pos('¿', configline) + 2,
        1));
      screen[ScreenCount][LineCount].TransitionTime := StrToInt(copy(configline, pos('¿',
        configline) + 7, 2));
      screen[ScreenCount][LineCount].TransitionStyle := TTransitionStyle(StrToInt(copy(configline, pos('¿',
        configline) + 6, 1)));
      screen[ScreenCount][LineCount].noscroll := copy(configline, pos('¿', configline) + 3,
        1)='1';
      screen[ScreenCount][LineCount].contNextLine := copy(configline, pos('¿', configline) + 4,
        1)='1';
      screen[ScreenCount][LineCount].center := copy(configline, 1, 3)='%c%';
      if (screen[ScreenCount][LineCount].center) then screen[ScreenCount][LineCount].text := copy(configline, 4,
        pos('¿', configline)-4)
      else screen[ScreenCount][LineCount].text := copy(configline, 1, pos('¿', configline)-1);

    end;
  end;

  newsRefresh := StrToInt(copy(configArray[84], 2, length(configArray[84])));
  randomScreens := copy(configArray[84], 1, 1)='1';

  foldUsername := copy(configArray[85], 1, pos('¿', configArray[85])-1);
  gameRefresh := StrToInt(copy(configArray[85], pos('¿', configArray[85]) + 1,
    length(configArray[85])));

  mbmRefresh := StrToInt(copy(configArray[86], 2, length(configArray[86])));
  checkUpdates := copy(configArray[86], 1, 1)='1';

  colorOption := StrToInt(configArray[87]);


  distLog := configArray[88];

  emailPeriod := StrToInt(copy(configArray[89], 1, pos('¿',
    configArray[89])-1));
  dllPeriod := StrToInt(copy(configArray[89], pos('¿', configArray[89]) + 1,
    pos('¿¿', configArray[89])-pos('¿', configArray[89])-1));
  scrollPeriod := StrToInt(copy(configArray[89], pos('¿¿', configArray[89]) +
    2, length(configArray[89])));

  xparallelPort := StrToInt(configArray[91]);

  if (copy(configArray[92], 2, 1)='1') then xmx3Usb := true
  else xmx3Usb := false;

  if (copy(configArray[92], 1, 1)='1') then alwaysOnTop := true
  else alwaysOnTop := false;

  httpProxy := configArray[93];
  httpProxyPort := StrToInt(configArray[94]);

  // Pop accounts
  pop[1].server := copy(configArray[95], 1, pos('¿0', configArray[95])-1);
  pop[1].user := copy(configArray[96], 1, pos('¿0', configArray[96])-1);
  pop[1].pword := copy(configArray[97], 1, pos('¿0', configArray[97])-1);

  pop[2].server := copy(configArray[95], pos('¿0', configArray[95]) + 2,
    pos('¿1', configArray[95])-pos('¿0', configArray[95])-2);
  pop[2].user := copy(configArray[96], pos('¿0', configArray[96]) + 2,
    pos('¿1', configArray[96])-pos('¿0', configArray[96])-2);
  pop[2].pword := copy(configArray[97], pos('¿0', configArray[97]) + 2,
    pos('¿1', configArray[97])-pos('¿0', configArray[97])-2);

  pop[3].server := copy(configArray[95], pos('¿1', configArray[95]) + 2,
    pos('¿2', configArray[95])-pos('¿1', configArray[95])-2);
  pop[3].user := copy(configArray[96], pos('¿1', configArray[96]) + 2,
    pos('¿2', configArray[96])-pos('¿1', configArray[96])-2);
  pop[3].pword := copy(configArray[97], pos('¿1', configArray[97]) + 2,
    pos('¿2', configArray[97])-pos('¿1', configArray[97])-2);

  pop[4].server := copy(configArray[95], pos('¿2', configArray[95]) + 2,
    pos('¿3', configArray[95])-pos('¿2', configArray[95])-2);
  pop[4].user := copy(configArray[96], pos('¿2', configArray[96]) + 2,
    pos('¿3', configArray[96])-pos('¿2', configArray[96])-2);
  pop[4].pword := copy(configArray[97], pos('¿2', configArray[97]) + 2,
    pos('¿3', configArray[97])-pos('¿2', configArray[97])-2);

  pop[5].server := copy(configArray[95], pos('¿3', configArray[95]) + 2,
    pos('¿4', configArray[95])-pos('¿3', configArray[95])-2);
  pop[5].user := copy(configArray[96], pos('¿3', configArray[96]) + 2,
    pos('¿4', configArray[96])-pos('¿3', configArray[96])-2);
  pop[5].pword := copy(configArray[97], pos('¿3', configArray[97]) + 2,
    pos('¿4', configArray[97])-pos('¿3', configArray[97])-2);

  pop[6].server := copy(configArray[95], pos('¿4', configArray[95]) + 2,
    pos('¿5', configArray[95])-pos('¿4', configArray[95])-2);
  pop[6].user := copy(configArray[96], pos('¿4', configArray[96]) + 2,
    pos('¿5', configArray[96])-pos('¿4', configArray[96])-2);
  pop[6].pword := copy(configArray[97], pos('¿4', configArray[97]) + 2,
    pos('¿5', configArray[97])-pos('¿4', configArray[97])-2);

  pop[7].server := copy(configArray[95], pos('¿5', configArray[95]) + 2,
    pos('¿6', configArray[95])-pos('¿5', configArray[95])-2);
  pop[7].user := copy(configArray[96], pos('¿5', configArray[96]) + 2,
    pos('¿6', configArray[96])-pos('¿5', configArray[96])-2);
  pop[7].pword := copy(configArray[97], pos('¿5', configArray[97]) + 2,
    pos('¿6', configArray[97])-pos('¿5', configArray[97])-2);

  pop[8].server := copy(configArray[95], pos('¿6', configArray[95]) + 2,
    pos('¿7', configArray[95])-pos('¿6', configArray[95])-2);
  pop[8].user := copy(configArray[96], pos('¿6', configArray[96]) + 2,
    pos('¿7', configArray[96])-pos('¿6', configArray[96])-2);
  pop[8].pword := copy(configArray[97], pos('¿6', configArray[97]) + 2,
    pos('¿7', configArray[97])-pos('¿6', configArray[97])-2);

  pop[9].server := copy(configArray[95], pos('¿7', configArray[95]) + 2,
    pos('¿8', configArray[95])-pos('¿7', configArray[95])-2);
  pop[9].user := copy(configArray[96], pos('¿7', configArray[96]) + 2,
    pos('¿8', configArray[96])-pos('¿7', configArray[96])-2);
  pop[9].pword := copy(configArray[97], pos('¿7', configArray[97]) + 2,
    pos('¿8', configArray[97])-pos('¿7', configArray[97])-2);

  pop[0].server := copy(configArray[95], pos('¿8', configArray[95]) + 2,
    pos('¿9', configArray[95])-pos('¿8', configArray[95])-2);
  pop[0].user := copy(configArray[96], pos('¿8', configArray[96]) + 2,
    pos('¿9', configArray[96])-pos('¿8', configArray[96])-2);
  pop[0].pword := copy(configArray[97], pos('¿8', configArray[97]) + 2,
    pos('¿9', configArray[97])-pos('¿8', configArray[97])-2);

  xScreenType := TScreenType(StrToInt(configArray[98]));
  comPort := StrToInt(configArray[99]);
  baudrate := StrToInt(configArray[100]);

  result := true;
end;

const
  BoolStr : array[false..true] of string = ('0','1');

procedure TConfig.ConvertToDisplayDLL;
begin
  case xScreenType of
    xxHD2,
    xxHD : begin
      DisplayDLLName := 'HD44780.dll';
      DisplayDLLParameters := '$'+IntToHex(xParallelPort,3) + ',' +
                              IntToStr(xiHDTimingMultiplier)+ ',' +
                              BoolStr[xbHDAltAddressing]+ ',' +
                              BoolStr[xbHDKS0073Addressing];
    end;
    xxMO : begin
      DisplayDLLName := 'matrix.dll';
      DisplayDLLParameters := 'COM'+IntToStr(COMPort)+','+IntToStr(BaudRates[BAUDRate]);
      DLL_Contrast := xcontrast;
      DLL_Brightness := xbrightness;
    end;
    xxCF : begin
      DisplayDLLName := 'crystal.dll';
      DisplayDLLParameters := 'COM'+IntToStr(COMPort)+','+IntToStr(BaudRates[BAUDRate]);
      DLL_Contrast := xCF_contrast*255 div 100;
      DLL_Brightness := xCF_brightness*255 div 100;
    end;
    xxIR : begin
      DisplayDLLName := 'irtrans.dll';
      DisplayDLLParameters := xremotehost;
      DLL_Brightness := xIR_brightness * 64;
    end;
  end;
  xScreenType := xxDLL;
end;

function TConfig.load: Boolean;
var
  bResult1, bResult2: Boolean;
begin
  if (FileExists(ExtractFilePath(Application.EXEName) + sFileName)) or (not
    FileExists(ExtractFilePath(Application.EXEName) + 'config.cfg')) then
  begin
    bResult1 := loadINI;
  end
  else
  begin
    bResult1 := loadCCFG;
  end;
  if (FileExists(ExtractFilePath(Application.EXEName) + 'actions.cfg')) then
    bResult2 := loadACFG
  else
    bResult2 := true;

  ConvertToDisplayDLL;

  result := bResult1 and bResult2;
end;

procedure TConfig.save;
begin
  saveINI;
  if FileExists(ExtractFilePath(Application.EXEName) + 'config.cfg') then
    DeleteFile(PChar(ExtractFilePath(Application.EXEName) + 'config.cfg'));
  if FileExists(ExtractFilePath(Application.EXEName) + 'actions.cfg') then
    DeleteFile(PChar(ExtractFilePath(Application.EXEName) + 'actions.cfg'))
end;


function TConfig.loadINI: Boolean;
var
  initfile: TINIFile;
  ActionsCount, MailCount, ScreenCount, LineCount: Integer;
  sConfigFileFormatVersion, sScreenTextSyntaxVersion: String;
  sScreen, sLine, sPOPAccount, sGameLine: String;
  iTemp: Integer;
begin

  try
    // We can't use the faster TMemINIFile - because it leaves quoted strings
    // with their quotes...
    initfile := TINIFile.Create(ExtractFilePath(Application.EXEName) +
      sFileName);
  except
    result := false;
    Exit;
  end;

  sConfigFileFormatVersion := initfile.ReadString('Versions',
    'ConfigFileFormat', '1.0');
  sScreenTextSyntaxVersion := initfile.ReadString('Versions',
    'ScreenTextSyntax', '1.0');

  sSkinPath := initfile.ReadString('General Settings', 'SkinPath', 'images\');
  sSkinPath := IncludeTrailingPathDelimiter(sSkinPath);
  baudrate := initfile.ReadInteger('Communication Settings', 'Baudrate', 8);
  comPort := initfile.ReadInteger('Communication Settings', 'COMPort', 1);

  iTemp := initfile.ReadInteger('Communication Settings', 'USBPalm', -1);
  if (iTemp <> -1) then
  begin
    isUsbPalm := (iTemp > 0);
  end
  else
  begin
    // If they were using a previous version then this value was used for USB Palms
    isUsbPalm :=
      (initfile.ReadString('Communication Settings', 'USBPalmDevice', '') <> '');
  end;

  xparallelPort := initfile.ReadInteger('Communication Settings',
    'ParallelPort', 888);

  xmx3Usb := initFile.ReadBool('Communication Settings', 'MX3USB', false);

  xbHDAltAddressing := initFile.ReadBool('Communication Settings',
   'HDAlternativeAddressing', false);
  xbHDKS0073Addressing := initFile.ReadBool('Communication Settings',
   'HDKS0073Addressing', false);
  xiHDTimingMultiplier := initFile.ReadInteger('Communication Settings',
   'HDTimingMultiplier', 1);

  refreshRate := initfile.ReadInteger('General Settings', 'RefreshRate', 75);
  winampLocation := initfile.ReadString('General Settings', 'WinAmpLocation',
    'C:\Program Files\Winamp\winamp.exe');

  bootDriverDelay := initfile.ReadInteger('General Settings',
    'BootDriverDelay', 3);
  setiEmail := initfile.ReadString('General Settings', 'SETIEmail',
    'test@test.com');

  for ScreenCount := 1 to MaxScreens do
  begin
    sScreen := 'Screen ' + Format('%.2u', [ScreenCount], localeFormat);
    screen[ScreenCount][1].enabled := initFile.ReadBool(sScreen, 'Enabled', false);
    screen[ScreenCount][1].theme := initFile.ReadInteger(sScreen, 'Theme', 1)-1;
    screen[ScreenCount][1].showTime := initFile.ReadInteger(sScreen, 'ShowTime', 10);
    screen[ScreenCount][1].bSticky := initFile.ReadBool(sScreen, 'Sticky', false);
    screen[ScreenCount][1].skip := initFile.ReadInteger(sScreen, 'Skip', 0);
    screen[ScreenCount][1].TransitionTime := initFile.ReadInteger(sScreen,
      'InteractionTime', 7);
    screen[ScreenCount][1].TransitionStyle := TTransitionStyle(initFile.ReadInteger(sScreen, 'Interaction',1));

    for LineCount := 1 to MaxLines do
    begin
      sLine := Format('%.2u', [LineCount], localeFormat);
      screen[ScreenCount][LineCount].text := initFile.ReadString(sScreen, 'Text' + sLine, '');
      screen[ScreenCount][LineCount].noscroll := initFile.ReadBool(sScreen, 'NoScroll' + sLine,
        true);
      screen[ScreenCount][LineCount].contNextLine := initFile.ReadBool(sScreen,
        'ContinueNextLine' + sLine, false);
      screen[ScreenCount][LineCount].center := initFile.ReadBool(sScreen, 'Center' + sLine,
        false);
    end;

    // BUGBUG: Remove me - once the data organisation is corrected.
    // Currently these values are stored per line rather than per screen.
    for LineCount := 2 to MaxLines do
    begin
      screen[ScreenCount][LineCount].enabled := screen[ScreenCount][1].enabled;
      screen[ScreenCount][LineCount].theme := screen[ScreenCount][1].theme;
      screen[ScreenCount][LineCount].showTime := screen[ScreenCount][1].showTime;
      screen[ScreenCount][LineCount].skip := screen[ScreenCount][1].skip;
      screen[ScreenCount][LineCount].TransitionTime := screen[ScreenCount][1].TransitionTime;
      screen[ScreenCount][LineCount].TransitionStyle := screen[ScreenCount][1].TransitionStyle
    end;
  end;

  distLog := initfile.ReadString('General Settings', 'DistLog',
    'C:\repllog.txt');
  emailPeriod := initfile.ReadInteger('General Settings', 'EmailPeriod', 10);
  dllPeriod := initfile.ReadInteger('General Settings', 'DLLPeriod', 250);
  scrollPeriod := initfile.ReadInteger('General Settings', 'ScrollPeriod',
    200);

  alwaysOnTop := initFile.ReadBool('General Settings', 'AlwaysOnTop', false);

  httpProxy := initFile.ReadString('Communication Settings', 'HTTPProxy', '');
  httpProxyPort := initFile.ReadInteger('Communication Settings',
    'HTTPProxyPort', 0);
  xremotehost := initFile.ReadString('Communication Settings', 'RemoteHost', 'localhost');
  DisplayDLLName := initFile.ReadString('Communication Settings', 'DisplayDLLName', 'matrix.dll');
  DisplayDLLParameters := initFile.ReadString('Communication Settings', 'DisplayDLLParameters', 'COM1,9600,8,N,1');


  xScreenType := TScreenType(initFile.ReadInteger('General Settings', 'LCDType', 0));

  // Readonly settings - not set at all.
{
  if (ScreenType = stTestDriver) then
  begin
    testDriver.iStopBits := initFile.ReadInteger('Test Driver', 'StopBits', 1);
    testDriver.iParity := initFile.ReadInteger('Test Driver', 'Parity', 0);
    testDriver.sInit := initFile.ReadString('Test Driver', 'Init', '');
    testDriver.sFini := initFile.ReadString('Test Driver', 'Fini', '');
    testDriver.sGotoLine1 := initFile.ReadString('Test Driver', 'GotoLine1', '');
    testDriver.sGotoLine2 := initFile.ReadString('Test Driver', 'GotoLine2', '');
    testDriver.sGotoLine3 := initFile.ReadString('Test Driver', 'GotoLine3', '');
    testDriver.sGotoLine4 := initFile.ReadString('Test Driver', 'GotoLine4', '');
    testDriver.sCharMap := initFile.ReadString('Test Driver', 'CharMap', '');
  end;
}

  SetScreenSize(initFile.ReadInteger('General Settings', 'Size', 11));

  xcontrast := initFile.ReadInteger('General Settings', 'Contrast', 88);
  xbrightness := initFile.ReadInteger('General Settings', 'Brightness', 26);

  xCF_contrast := initFile.ReadInteger('General Settings', 'CFContrast', 66);
  xCF_brightness := initFile.ReadInteger('General Settings', 'CFBrightness',
    61);
  xiCF_cgrom := initFile.ReadInteger('General Settings', 'CFCGRomVersion', 2);
  xiMinFadeContrast := initFile.ReadInteger('General Settings', 'MinFadeContrast',
    0);

  xIR_brightness := initFile.ReadInteger('General Settings', 'IRBrightness', 3);

  DLL_contrast := initFile.ReadInteger('General Settings', 'DLLContrast', 127);
  DLL_brightness := initFile.ReadInteger('General Settings', 'DLLBrightness',127);

  newsRefresh := initFile.ReadInteger('General Settings', 'NewsRefresh', 120);
  randomScreens := initFile.ReadBool('General Settings', 'RandomScreens',
    false);

  foldUsername := initFile.ReadString('General Settings', 'FoldUsername',
    'Test');
  gameRefresh := initFile.ReadInteger('General Settings', 'GameRefresh', 1);

  mbmRefresh := initFile.ReadInteger('General Settings', 'MBMRefresh', 30);
  checkUpdates := initFile.ReadBool('General Settings', 'CheckUpdates', true);

  colorOption := initFile.ReadInteger('General Settings', 'ColorOption', 4);
  bHideOnStartup := initFile.ReadBool('General Settings', 'HideOnStartup', false);
  bAutoStart := initFile.ReadBool('General Settings', 'AutoStart', false);
  bAutoStartHide := initFile.ReadBool('General Settings', 'AutoStartHidden', false);


  // Pop accounts
  for MailCount := 0 to MaxEmailAccounts-1 do
  begin
    sPOPAccount := Format('%.2u', [MailCount], localeFormat);
    pop[MailCount].server := initFile.ReadString('POP Accounts', 'Server' +
      sPOPAccount, '');
    pop[MailCount].user := initFile.ReadString('POP Accounts', 'User' + sPOPAccount,
      '');
    pop[MailCount].pword := initFile.ReadString('POP Accounts', 'Password' +
      sPOPAccount, '');
  end;


  // Load Game server list.
  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to MaxLines do
    begin
      sGameLine := 'GameServer' + Format('%.2u', [ScreenCount], localeFormat) + '-'
        + Format('%.2u', [LineCount], localeFormat);
      gameServer[ScreenCount, LineCount] := initfile.ReadString('Game Servers', sGameLine, '');
    end;
  end;

  // Load Actions
  ActionsCount := 0;
  repeat
    ActionsCount := ActionsCount + 1;
    actionsArray[ActionsCount, 1] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [ActionsCount], localeFormat) + 'Variable', '');
    actionsArray[ActionsCount, 2] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [ActionsCount], localeFormat) + 'Condition', '0');
    actionsArray[ActionsCount, 3] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [ActionsCount], localeFormat) + 'ConditionValue', '');
    actionsArray[ActionsCount, 4] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [ActionsCount], localeFormat) + 'Action', '')
  until (actionsArray[ActionsCount, 1] = '') or (ActionsCount = MaxActions);
  totalactions := ActionsCount - 1;
  uiActionsLoaded := totalactions;

  result := true;

  initfile.Free;
end;


procedure TConfig.saveINI;
var
  initfile : TMemINIFile;
  sScreen, sLine, sPOPAccount, sGameLine: String;
  ActionsCount, MailCount, ScreenCount, LineCount: Integer;
  sPrefix: String;
begin
  initfile := TMemINIFile.Create(ExtractFilePath(Application.EXEName) +
    sFileName);

  initfile.WriteString('Versions', 'ConfigFileFormat',
    sMyConfigFileFormatVersion);
  initfile.WriteString('Versions', 'ScreenTextSyntax',
    sMyScreenTextSyntaxVersion);

  initfile.WriteString('General Settings', 'SkinPath', sSkinPath);
  initfile.WriteInteger('Communication Settings', 'Baudrate', baudrate);
  initfile.WriteInteger('Communication Settings', 'COMPort', comPort);
  if (isUsbPalm) then initfile.WriteInteger('Communication Settings',
    'USBPalm', 1)
  else initfile.WriteInteger('Communication Settings', 'USBPalm', 0);

  initfile.WriteInteger('Communication Settings', 'ParallelPort',
    xparallelPort);

  initFile.WriteBool('Communication Settings', 'HDAlternativeAddressing',
    xbHDAltAddressing);
  initFile.WriteBool('Communication Settings', 'HDKS0073Addressing',
    xbHDKS0073Addressing);
  initfile.WriteInteger('Communication Settings', 'HDTimingMultiplier',
    xiHDTimingMultiplier);

  initFile.WriteBool('Communication Settings', 'MX3USB', xmx3Usb);

  initfile.WriteInteger('General Settings', 'RefreshRate', refreshRate);
  initfile.WriteString('General Settings', 'WinAmpLocation', winampLocation);

  initfile.WriteInteger('General Settings', 'BootDriverDelay',
    bootDriverDelay);

  initfile.WriteString('General Settings', 'SETIEmail', setiEmail);

  for ScreenCount := 1 to MaxScreens do
  begin
    sScreen := 'Screen ' + Format('%.2u', [ScreenCount], localeFormat);
    initfile.WriteBool(sScreen, 'Enabled', screen[ScreenCount][1].enabled);
    initFile.WriteInteger(sScreen, 'Theme', screen[ScreenCount][1].theme + 1);
    initFile.WriteInteger(sScreen, 'ShowTime', screen[ScreenCount][1].showTime);
    initfile.WriteBool(sScreen, 'Sticky', screen[ScreenCount][1].bSticky);
    initFile.WriteInteger(sScreen, 'Skip', screen[ScreenCount][1].skip);
    initFile.WriteInteger(sScreen, 'InteractionTime',
      screen[ScreenCount][1].TransitionTime);
    initFile.WriteInteger(sScreen, 'Interaction', ord(screen[ScreenCount][1].TransitionStyle));

    for LineCount := 1 to MaxLines do
    begin
      sLine := Format('%.2u', [LineCount], localeFormat);
      initFile.WriteString(sScreen, 'Text' + sLine, '"' + screen[ScreenCount][LineCount].text + '"');

      sLine := Format('%.2u', [LineCount], localeFormat);
      initFile.WriteBool(sScreen, 'NoScroll' + sLine, screen[ScreenCount][LineCount].noscroll);

      sLine := Format('%.2u', [LineCount], localeFormat);
      initFile.WriteBool(sScreen, 'ContinueNextLine' + sLine,
        screen[ScreenCount][LineCount].contNextLine);

      sLine := Format('%.2u', [LineCount], localeFormat);
      initFile.WriteBool(sScreen, 'Center' + sLine, screen[ScreenCount][LineCount].center);
    end;

  end;

  initfile.WriteString('General Settings', 'DistLog', distLog);
  initfile.WriteInteger('General Settings', 'EmailPeriod', emailPeriod);
  initfile.WriteInteger('General Settings', 'DLLPeriod', dllPeriod);
  initfile.WriteInteger('General Settings', 'ScrollPeriod', scrollPeriod);

  initFile.WriteBool('General Settings', 'AlwaysOnTop', alwaysOnTop);

  initFile.WriteString('Communication Settings', 'HTTPProxy', httpProxy);
  initFile.WriteInteger('Communication Settings', 'HTTPProxyPort',
    httpProxyPort);
  initFile.WriteString('Communication Settings', 'RemoteHost', xremotehost);
  initFile.WriteString('Communication Settings', 'DisplayDLLName', DisplayDLLName);
  initFile.WriteString('Communication Settings', 'DisplayDLLParameters', DisplayDLLParameters);

  initFile.WriteInteger('General Settings', 'LCDType', ord(xScreenType));
  initFile.WriteInteger('General Settings', 'Size', ScreenSize);
  initFile.WriteInteger('General Settings', 'Contrast', xcontrast);
  initFile.WriteInteger('General Settings', 'Brightness', xbrightness);

  initFile.WriteInteger('General Settings', 'CFContrast', xCF_contrast);
  initFile.WriteInteger('General Settings', 'CFBrightness', xCF_brightness);
  initFile.WriteInteger('General Settings', 'CFCGRomVersion', xiCF_cgrom);
  initFile.WriteInteger('General Settings', 'MinFadeContrast', xiMinFadeContrast);

  initFile.WriteInteger('General Settings', 'IRBrightness', xIR_brightness);

  initFile.WriteInteger('General Settings', 'DLLContrast', DLL_contrast);
  initFile.WriteInteger('General Settings', 'DLLBrightness', DLL_brightness);

  initFile.WriteInteger('General Settings', 'NewsRefresh', newsRefresh);
  initFile.WriteBool('General Settings', 'RandomScreens', randomScreens);

  initFile.WriteString('General Settings', 'FoldUsername', foldUsername);
  initFile.WriteInteger('General Settings', 'GameRefresh', gameRefresh);

  initFile.WriteInteger('General Settings', 'MBMRefresh', mbmRefresh);
  initFile.WriteBool('General Settings', 'CheckUpdates', checkUpdates);

  initFile.WriteInteger('General Settings', 'ColorOption', colorOption);
  initFile.WriteBool('General Settings', 'HideOnStartup', bHideOnStartup);
  initFile.WriteBool('General Settings', 'AutoStart', bAutoStart);
  initFile.WriteBool('General Settings', 'AutoStartHidden', bAutoStartHide);

  // Pop accounts
  for MailCount := 0 to MaxEmailAccounts-1 do
  begin
    sPOPAccount := Format('%.2u', [MailCount], localeFormat);
    initFile.WriteString('POP Accounts', 'Server' + sPOPAccount,
      pop[MailCount].server);
    initFile.WriteString('POP Accounts', 'User' + sPOPAccount, '"' +
      pop[MailCount].user + '"');
    initFile.WriteString('POP Accounts', 'Password' + sPOPAccount, '"' +
      pop[MailCount].pword + '"');
  end;

  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to MaxLines do
    begin
      sGameLine := 'GameServer' + Format('%.2u', [ScreenCount], localeFormat) + '-'
        + Format('%.2u', [LineCount], localeFormat);
      initfile.WriteString('Game Servers', sGameLine, gameServer[ScreenCount, LineCount]);
    end;
  end;

  // Save Actions
  // and delete those we loaded but aren't now used.
  // [ and delete two further sets of keys - to clean up from older builds which
  // stored unused actions ]
  for ActionsCount := 1 to uiActionsLoaded + 2 do
  begin
    sPrefix := 'Action' + Format('%.2u', [ActionsCount], localeFormat);
    if (ActionsCount <= totalactions) then
    begin
      initfile.WriteString('Actions', sPrefix + 'Variable', actionsArray[ActionsCount, 1]);
      initfile.WriteString('Actions', sPrefix + 'Condition', actionsArray[ActionsCount, 2]);
      initfile.WriteString('Actions', sPrefix + 'ConditionValue',
        actionsArray[ActionsCount, 3]);
      initfile.WriteString('Actions', sPrefix + 'Action', actionsArray[ActionsCount, 4]);
    end
    else
    begin
      initfile.DeleteKey('Actions', sPrefix + 'Variable');
      initfile.DeleteKey('Actions', sPrefix + 'Condition');
      initfile.DeleteKey('Actions', sPrefix + 'ConditionValue');
      initfile.DeleteKey('Actions', sPrefix + 'Action');
    end;
  end;

  initfile.UpdateFile;
  initfile.Free;

end;


end.

