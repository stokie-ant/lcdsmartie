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
 *  $Revision: 1.22 $ $Date: 2004/12/16 14:34:02 $
 *****************************************************************************}

interface

const
  sMyConfigFileFormatVersion = '1.0';
  sMyScreenTextSyntaxVersion = '1.0';

type
  TScreenLine = Record
    text: String;
    enabled: Boolean;
    skip: Integer;
    noscroll: Boolean;
    contNextLine: Boolean;
    theme: Integer;
    interaction: Integer;
    interactionTime: Integer;
    showTime: Integer;
    center: Boolean;
  end;

  TPopAccount = Record
    server: String;
    user: String;
    pword: String;
  end;

  TConfig = class(TObject)
  private
    P_sizeOption: Integer;
    P_width: Integer;
    P_height: Integer;
    uiActionsLoaded: Cardinal;
    function loadINI: Boolean;
    function loadCCFG: Boolean;
    function loadACFG: Boolean;
    procedure saveINI;
    procedure setSizeOption(con: Integer);
  public
    isUsbPalm: Boolean;
    gameServer: Array[1..20, 1..4] of String;
    pop: Array [0..9] of TPopAccount;
    comPort: Integer;
    baudrate: Integer;
    refreshRate: Integer;
    bootDriverDelay: Integer;
    emailPeriod: Integer;
    dllPeriod: Integer;
    scrollPeriod: Integer;
    parallelPort: Integer;
    colorOption: Integer;
    alwaysOnTop: Boolean;
    mx3Usb: Boolean;
    httpProxy: String;
    httpProxyPort: Integer;
    brightness: Integer;
    CF_contrast: Integer;
    CF_brightness: Integer;
    iCF_cgrom: Integer;
    newsRefresh: Integer;
    randomScreens: Boolean;
    gameRefresh: Integer;
    mbmRefresh: Integer;
    foldUsername: String;
    isMO: Boolean;
    isCF: Boolean;
    isHD: Boolean;
    isHD2: Boolean;   // not used.
    checkUpdates: Boolean;
    distLog: String;
    screen: Array[1..20] of Array[1..4] of TScreenLine;
    winampLocation: String;
    setiEmail: String;
    contrast: Integer;
    actionsArray: Array[1..99, 1..4] of String;
    totalactions: Integer;
    iMinFadeContrast: Integer;
    bHDAltAddressing: Boolean;
    function load: Boolean;
    procedure save;
    property sizeOption: Integer read P_sizeOption write setSizeOption;
    property width: Integer read P_width;
    property height: Integer read P_height;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses SysUtils, Forms, INIFiles, StrUtils;

constructor TConfig.Create;
begin
  iMinFadeContrast := 0;
  inherited;
end;

destructor TConfig.Destroy;
begin
  inherited;
end;


procedure TConfig.setSizeOption(con: Integer);
begin
  P_sizeOption := con;
  if P_sizeOption = 1 then
  begin
    P_height := 1;
    P_width := 10;
  end;
  if P_sizeOption = 2 then
  begin
    P_height := 1;
    P_width := 16;
  end;
  if P_sizeOption = 3 then
  begin
    P_height := 1;
    P_width := 20;
  end;
  if P_sizeOption = 4 then
  begin
    P_height := 1;
    P_width := 24;
  end;
  if P_sizeOption = 5 then
  begin
    P_height := 1;
    P_width := 40;
  end;
  if P_sizeOption = 6 then
  begin
    P_height := 2;
    P_width := 16;
  end;
  if P_sizeOption = 7 then
  begin
    P_height := 2;
    P_width := 20;
  end;
  if P_sizeOption = 8 then
  begin
    P_height := 2;
    P_width := 24;
  end;
  if P_sizeOption = 9 then
  begin
    P_height := 2;
    P_width := 40;
  end;
  if P_sizeOption = 10 then
  begin
    P_height := 4;
    P_width := 16;
  end;
  if P_sizeOption = 11 then
  begin
    P_height := 4;
    P_width := 20;
  end;
  if P_sizeOption = 12 then
  begin
    P_height := 4;
    P_width := 40;
  end;
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
  x, y: Integer;
  configline: String;
  configArray: Array[1..100] of String;
begin
  // Load Game server list.
  try
    assignfile(initfile, extractfilepath(application.exename) +
      'servers.cfg');
    try
      reset(initfile);
      for x := 1 to 20 do
        for y := 1 to 4 do readln(initfile, gameServer[x, y]);
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

  for x := 1 to 100 do readln(initfile, configArray[x]);

  closefile(initfile);



  refreshRate := StrToInt(copy(configArray[1], 1, pos('¿',
    configArray[1])-1));
  winampLocation := copy(configArray[1], pos('¿', configArray[1]) + 1,
    length(configArray[1]));

  bootDriverDelay := StrToInt(copy(configArray[2], 1, pos('¿',
    configArray[2])-1));
  setiEmail := copy(configArray[2], pos('¿', configArray[2]) + 1,
    length(configArray[2]));

  setSizeOption(strtoInt(copy(configArray[3], 1, pos('¿1',
    configArray[3])-1)));

  contrast := strtoint(copy(configArray[3], pos('¿1', configArray[3]) + 2,
    pos('¿2', configArray[3])-pos('¿1', configArray[3])-2));
  brightness := strtoint(copy(configArray[3], pos('¿2', configArray[3]) + 2,
    pos('¿3', configArray[3])-pos('¿2', configArray[3])-2));

  CF_contrast := strtoint(copy(configArray[3], pos('¿3', configArray[3]) + 2,
    pos('¿4', configArray[3])-pos('¿3', configArray[3])-2));
  CF_brightness := strtoint(copy(configArray[3], pos('¿4', configArray[3]) +
    2, 3));


  // Lines 4..83
  for x := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      configline := configArray[x*4 + (y-1)];
      screen[x][y].enabled := copy(configline, pos('¿', configline) + 1,
        1)='1';
      screen[x][y].theme := StrToInt(copy(configline, pos('¿', configline) +
        5, 1));
      screen[x][y].showTime := StrToInt(copy(configline, pos('¿', configline)
        + 9, length(configline)));
      screen[x][y].skip := StrToInt(copy(configline, pos('¿', configline) + 2,
        1));
      screen[x][y].interactionTime := StrToInt(copy(configline, pos('¿',
        configline) + 7, 2));
      screen[x][y].interaction := StrToInt(copy(configline, pos('¿',
        configline) + 6, 1));
      screen[x][y].noscroll := copy(configline, pos('¿', configline) + 3,
        1)='1';
      screen[x][y].contNextLine := copy(configline, pos('¿', configline) + 4,
        1)='1';
      screen[x][y].center := copy(configline, 1, 3)='%c%';
      if (screen[x][y].center) then screen[x][y].text := copy(configline, 4,
        pos('¿', configline)-4)
      else screen[x][y].text := copy(configline, 1, pos('¿', configline)-1);

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

  parallelPort := StrToInt(configArray[91]);

  if (copy(configArray[92], 2, 1)='1') then mx3Usb := true
  else mx3Usb := false;

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

  isMO := false;
  isCF := false;
  isHD := false;
  isHD2 := false;
  case StrToInt(configArray[98]) of
    1: isHD := true;
    2: isMO := true;
    3: isCF := true;
    4: isHD2 := true;
  end;


  comPort := StrToInt(configArray[99]);
  baudrate := StrToInt(configArray[100]);

  result := true;
end;

function TConfig.load: Boolean;
var
  bResult1, bResult2: Boolean;
begin
  if (FileExists(ExtractFilePath(Application.EXEName) + 'config.ini')) or (not
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

  result := bResult1 and bResult2;
end;

procedure TConfig.save;
begin
  saveINI;
  if FileExists(ExtractFilePath(Application.EXEName) + 'config.cfg') then
    DeleteFile(ExtractFilePath(Application.EXEName) + 'config.cfg');
  if FileExists(ExtractFilePath(Application.EXEName) + 'actions.cfg') then
    DeleteFile(ExtractFilePath(Application.EXEName) + 'actions.cfg')
end;


function TConfig.loadINI: Boolean;
var
  initfile: TINIFile;
  x, y: Integer;
  sConfigFileFormatVersion, sScreenTextSyntaxVersion: String;
  sScreen, sLine, sPOPAccount, sGameLine: String;
  iTemp: Integer;
begin

  try
    // We can't use the faster TMemINIFile - because it leaves quoted strings
    // with their quotes...
    initfile := TINIFile.Create(ExtractFilePath(Application.EXEName) +
      'config.ini');
  except
    result := false;
    Exit;
  end;

  sConfigFileFormatVersion := initfile.ReadString('Versions',
    'ConfigFileFormat', '1.0');
  sScreenTextSyntaxVersion := initfile.ReadString('Versions',
    'ScreenTextSyntax', '1.0');

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

  parallelPort := initfile.ReadInteger('Communication Settings',
    'ParallelPort', 888);

  mx3Usb := initFile.ReadBool('Communication Settings', 'MX3USB', false);

  bHDAltAddressing := initFile.ReadBool('Communication Settings',
   'HDAlternativeAddressing', false);

  refreshRate := initfile.ReadInteger('General Settings', 'RefreshRate', 75);
  winampLocation := initfile.ReadString('General Settings', 'WinAmpLocation',
    'C:\Program Files\Winamp\winamp.exe');

  bootDriverDelay := initfile.ReadInteger('General Settings',
    'BootDriverDelay', 3);
  setiEmail := initfile.ReadString('General Settings', 'SETIEmail',
    'test@test.com');

  for x := 1 to 20 do
  begin
    sScreen := 'Screen ' + Format('%.2u', [x]);
    screen[x][1].enabled := initFile.ReadBool(sScreen, 'Enabled', false);
    screen[x][1].theme := initFile.ReadInteger(sScreen, 'Theme', 1)-1;
    screen[x][1].showTime := initFile.ReadInteger(sScreen, 'ShowTime', 10);
    screen[x][1].skip := initFile.ReadInteger(sScreen, 'Skip', 1);
    screen[x][1].interactionTime := initFile.ReadInteger(sScreen,
      'InteractionTime', 7);
    screen[x][1].interaction := initFile.ReadInteger(sScreen, 'Interaction',
      1);

    for y := 1 to 4 do
    begin
      sLine := Format('%.2u', [y]);
      screen[x][y].text := initFile.ReadString(sScreen, 'Text' + sLine, '');
      screen[x][y].noscroll := initFile.ReadBool(sScreen, 'NoScroll' + sLine,
        true);
      screen[x][y].contNextLine := initFile.ReadBool(sScreen,
        'ContinueNextLine' + sLine, false);
      screen[x][y].center := initFile.ReadBool(sScreen, 'Center' + sLine,
        false);
    end;

    // BUGBUG: Remove me - once the data organisation is corrected.
    // Currently these values are stored per line rather than per screen.
    for y := 2 to 4 do
    begin
      screen[x][y].enabled := screen[x][1].enabled;
      screen[x][y].theme := screen[x][1].theme;
      screen[x][y].showTime := screen[x][1].showTime;
      screen[x][y].skip := screen[x][1].skip;
      screen[x][y].interactionTime := screen[x][1].interactionTime;
      screen[x][y].interaction := screen[x][1].interaction
    end;
  end;

  distLog := initfile.ReadString('General Settings', 'DistLog',
    'C:\repllog.txt');
  emailPeriod := initfile.ReadInteger('General Settings', 'EmailPeriod', 10);
  dllPeriod := initfile.ReadInteger('General Settings', 'DLLPeriod', 75);
  scrollPeriod := initfile.ReadInteger('General Settings', 'ScrollPeriod',
    200);

  alwaysOnTop := initFile.ReadBool('General Settings', 'AlwaysOnTop', false);

  httpProxy := initFile.ReadString('Communication Settings', 'HTTPProxy', '');
  httpProxyPort := initFile.ReadInteger('Communication Settings',
    'HTTPProxyPort', 0);

  isMO := false;
  isCF := false;
  isHD := false;
  isHD2 := false;
  case initFile.ReadInteger('General Settings', 'LCDType', 0) of
    1: isHD := true;
    2: isMO := true;
    3: isCF := true;
    4: isHD2 := true;
  end;

  setSizeOption(initFile.ReadInteger('General Settings', 'Size', 11));

  contrast := initFile.ReadInteger('General Settings', 'Contrast', 88);
  brightness := initFile.ReadInteger('General Settings', 'Brightness', 26);

  CF_contrast := initFile.ReadInteger('General Settings', 'CFContrast', 66);
  CF_brightness := initFile.ReadInteger('General Settings', 'CFBrightness',
    61);
  iCF_cgrom := initFile.ReadInteger('General Settings', 'CFCGRomVersion', 2);
  iMinFadeContrast := initFile.ReadInteger('General Settings', 'MinFadeContrast',
    0);

  newsRefresh := initFile.ReadInteger('General Settings', 'NewsRefresh', 120);
  randomScreens := initFile.ReadBool('General Settings', 'RandomScreens',
    false);

  foldUsername := initFile.ReadString('General Settings', 'FoldUsername',
    'Test');
  gameRefresh := initFile.ReadInteger('General Settings', 'GameRefresh', 1);

  mbmRefresh := initFile.ReadInteger('General Settings', 'MBMRefresh', 30);
  checkUpdates := initFile.ReadBool('General Settings', 'CheckUpdates', true);

  colorOption := initFile.ReadInteger('General Settings', 'ColorOption', 4);

  // Pop accounts
  for x := 0 to 9 do
  begin
    sPOPAccount := Format('%.2u', [x]);
    pop[x].server := initFile.ReadString('POP Accounts', 'Server' +
      sPOPAccount, '');
    pop[x].user := initFile.ReadString('POP Accounts', 'User' + sPOPAccount,
      '');
    pop[x].pword := initFile.ReadString('POP Accounts', 'Password' +
      sPOPAccount, '');
  end;


  // Load Game server list.
  for x := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      sGameLine := 'GameServer' + Format('%.2u', [x]) + '-' + Format('%.2u',
        [y]);
      gameServer[x, y] := initfile.ReadString('Game Servers', sGameLine, '');
    end;
  end;

  // Load Actions
  x := 0;
  repeat
    x := x + 1;
    actionsArray[x, 1] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [x]) + 'Variable', '');
    actionsArray[x, 2] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [x]) + 'Condition', '0');
    actionsArray[x, 3] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [x]) + 'ConditionValue', '');
    actionsArray[x, 4] := initfile.ReadString('Actions', 'Action' +
      Format('%.2u', [x]) + 'Action', '')
  until (actionsArray[x, 1] = '') or (x = 99);
  totalactions := x - 1;
  uiActionsLoaded := totalactions;

  result := true;

  initfile.Free;
end;


procedure TConfig.saveINI;
var
  initfile : TMemINIFile;
  sScreen, sLine, sPOPAccount, sGameLine: String;
  x, y: Integer;
  sPrefix: String;
begin
  initfile := TMemINIFile.Create(ExtractFilePath(Application.EXEName) +
    'config.ini');

  initfile.WriteString('Versions', 'ConfigFileFormat',
    sMyConfigFileFormatVersion);
  initfile.WriteString('Versions', 'ScreenTextSyntax',
    sMyScreenTextSyntaxVersion);

  initfile.WriteInteger('Communication Settings', 'Baudrate', baudrate);
  initfile.WriteInteger('Communication Settings', 'COMPort', comPort);
  if (isUsbPalm) then initfile.WriteInteger('Communication Settings',
    'USBPalm', 1)
  else initfile.WriteInteger('Communication Settings', 'USBPalm', 0);

  initfile.WriteInteger('Communication Settings', 'ParallelPort',
    parallelPort);

  initFile.WriteBool('Communication Settings',
   'HDAlternativeAddressing', bHDAltAddressing);

  initFile.WriteBool('Communication Settings', 'MX3USB', mx3Usb);

  initfile.WriteInteger('General Settings', 'RefreshRate', refreshRate);
  initfile.WriteString('General Settings', 'WinAmpLocation', winampLocation);

  initfile.WriteInteger('General Settings', 'BootDriverDelay',
    bootDriverDelay);
  initfile.WriteString('General Settings', 'SETIEmail', setiEmail);

  for x := 1 to 20 do
  begin
    sScreen := 'Screen ' + Format('%.2u', [x]);
    initfile.WriteBool(sScreen, 'Enabled', screen[x][1].enabled);
    initFile.WriteInteger(sScreen, 'Theme', screen[x][1].theme + 1);
    initFile.WriteInteger(sScreen, 'ShowTime', screen[x][1].showTime);
    initFile.WriteInteger(sScreen, 'Skip', screen[x][1].skip);
    initFile.WriteInteger(sScreen, 'InteractionTime',
      screen[x][1].interactionTime);
    initFile.WriteInteger(sScreen, 'Interaction', screen[x][1].interaction);

    for y := 1 to 4 do
    begin
      sLine := Format('%.2u', [y]);
      initFile.WriteString(sScreen, 'Text' + sLine, '"' + screen[x][y].text +
        '"');
    end;

    for y := 1 to 4 do
    begin
      sLine := Format('%.2u', [y]);
      initFile.WriteBool(sScreen, 'NoScroll' + sLine, screen[x][y].noscroll);
    end;

    for y := 1 to 4 do
    begin
      sLine := Format('%.2u', [y]);
      initFile.WriteBool(sScreen, 'ContinueNextLine' + sLine,
        screen[x][y].contNextLine);
    end;

    for y := 1 to 4 do
    begin
      sLine := Format('%.2u', [y]);
      initFile.WriteBool(sScreen, 'Center' + sLine, screen[x][y].center);
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

  if isHD then initFile.WriteInteger('General Settings', 'LCDType', 1);
  if isMO then initFile.WriteInteger('General Settings', 'LCDType', 2);
  if isCF then initFile.WriteInteger('General Settings', 'LCDType', 3);
  if isHD2 then initFile.WriteInteger('General Settings', 'LCDType', 4);

  initFile.WriteInteger('General Settings', 'Size', sizeOption);

  initFile.WriteInteger('General Settings', 'Contrast', contrast);
  initFile.WriteInteger('General Settings', 'Brightness', brightness);

  initFile.WriteInteger('General Settings', 'CFContrast', CF_contrast);
  initFile.WriteInteger('General Settings', 'CFBrightness', CF_brightness);
  initFile.WriteInteger('General Settings', 'CFCGRomVersion', iCF_cgrom);
  initFile.WriteInteger('General Settings', 'MinFadeContrast', iMinFadeContrast);

  initFile.WriteInteger('General Settings', 'NewsRefresh', newsRefresh);
  initFile.WriteBool('General Settings', 'RandomScreens', randomScreens);

  initFile.WriteString('General Settings', 'FoldUsername', foldUsername);
  initFile.WriteInteger('General Settings', 'GameRefresh', gameRefresh);

  initFile.WriteInteger('General Settings', 'MBMRefresh', mbmRefresh);
  initFile.WriteBool('General Settings', 'CheckUpdates', checkUpdates);

  initFile.WriteInteger('General Settings', 'ColorOption', colorOption);

  // Pop accounts
  for x := 0 to 9 do
  begin
    sPOPAccount := Format('%.2u', [x]);
    initFile.WriteString('POP Accounts', 'Server' + sPOPAccount,
      pop[x].server);
    initFile.WriteString('POP Accounts', 'User' + sPOPAccount, '"' +
      pop[x].user + '"');
    initFile.WriteString('POP Accounts', 'Password' + sPOPAccount, '"' +
      pop[x].pword + '"');
  end;

  for x := 1 to 20 do
  begin
    for y := 1 to 4 do
    begin
      sGameLine := 'GameServer' + Format('%.2u', [x]) + '-' + Format('%.2u',
        [y]);
      initfile.WriteString('Game Servers', sGameLine, gameServer[x, y]);
    end;
  end;

  // Save Actions
  // and delete those we loaded but aren't now used.
  // [ and delete two further sets of keys - to clean up from older builds which
  // stored unused actions ]
  for x := 1 to uiActionsLoaded + 2 do
  begin
    sPrefix := 'Action' + Format('%.2u', [x]);
    if (x <= totalactions) then
    begin
      initfile.WriteString('Actions', sPrefix + 'Variable', actionsArray[x, 1]);
      initfile.WriteString('Actions', sPrefix + 'Condition', actionsArray[x, 2]);
      initfile.WriteString('Actions', sPrefix + 'ConditionValue',
        actionsArray[x, 3]);
      initfile.WriteString('Actions', sPrefix + 'Action', actionsArray[x, 4]);
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

