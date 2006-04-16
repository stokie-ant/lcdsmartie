unit USetup;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/USetup.pas,v $
 *  $Revision: 1.61 $ $Date: 2006/04/16 13:24:27 $
 *****************************************************************************}

interface

uses Dialogs, Grids, StdCtrls, Controls, Spin, Buttons, ComCtrls, Classes,
     Forms, ExtCtrls, FileCtrl, JvDriveCtrls;

const
  NoVariable = 'Variable: ';

type
  TSetupForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    LeftPageControl: TPageControl;
    WinampTabSheet: TTabSheet;
    SysInfoTabSheet: TTabSheet;
    MBMTabSheet: TTabSheet;
    GameStatsTabSheet: TTabSheet;
    InternetTabSheet: TTabSheet;
    MiscTabSheet: TTabSheet;
    MiscListBox: TListBox;
    InternetListBox: TListBox;
    MBMListBox: TListBox;
    SysInfoListBox: TListBox;
    WinampListBox: TListBox;
    VariableEdit: TEdit;
    GameServerEdit: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    QStatLabel: TLabel;
    DistributedNetBrowseButton: TSpeedButton;
    OpenDialog2: TOpenDialog;
    DistributedNetLogfileEdit: TEdit;
    Label34: TLabel;
    GameTypeComboBox: TComboBox;
    InsertButton: TButton;
    InternetRefreshTimeSpinEdit: TSpinEdit;
    Label36: TLabel;
    GamestatsRefreshTimeSpinEdit: TSpinEdit;
    Label37: TLabel;
    RefreshTimeLabel: TLabel;
    MBMRefreshTimeSpinEdit: TSpinEdit;
    Label35: TLabel;
    Label40: TLabel;
    SetiAtHomeTabSheet: TTabSheet;
    SetiAtHomeListBox: TListBox;
    SetiAtHomeEmailEdit: TEdit;
    Label41: TLabel;
    EmailTabSheet: TTabSheet;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    EmailPasswordEdit: TEdit;
    EmailLoginEdit: TEdit;
    EmailServerEdit: TEdit;
    EmailCheckTimeSpinEdit: TSpinEdit;
    Label48: TLabel;
    EmailListBox: TListBox;
    EmailAccountComboBox: TComboBox;
    Label50: TLabel;
    OpenDialog1: TOpenDialog;
    WinampLocationEdit: TEdit;
    WinampLocationBrowseButton: TSpeedButton;
    WinampLocationLabel: TLabel;
    GamestatsListBox: TListBox;
    NetworkStatsTabSheet: TTabSheet;
    NetworkStatsListBox: TListBox;
    FoldingAtHomeTabSheet: TTabSheet;
    FoldingAtHomeEmailEdit: TEdit;
    FoldingAtHomeListBox: TListBox;
    Label23: TLabel;
    ApplyButton: TButton;
    MainPageControl: TPageControl;
    ScreensTabSheet: TTabSheet;
    ActionsTabSheet: TTabSheet;
    ScreenSettingsGroupBox: TGroupBox;
    Label5: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label47: TLabel;
    Label46: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label4: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DontScrollLine1CheckBox: TCheckBox;
    DontScrollLine2CheckBox: TCheckBox;
    DontScrollLine3CheckBox: TCheckBox;
    DontScrollLine4CheckBox: TCheckBox;
    GroupBox4: TGroupBox;
    ContinueLine1CheckBox: TCheckBox;
    ContinueLine2CheckBox: TCheckBox;
    ContinueLine3CheckBox: TCheckBox;
    GroupBox5: TGroupBox;
    CenterLine1CheckBox: TCheckBox;
    CenterLine2CheckBox: TCheckBox;
    CenterLine3CheckBox: TCheckBox;
    CenterLine4CheckBox: TCheckBox;
    GroupBox6: TGroupBox;
    ThemeNumberSpinEdit: TSpinEdit;
    ProgramSettingsGroupBox: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    WebProxyServerEdit: TEdit;
    WebProxyPortEdit: TEdit;
    ProgramRefreshIntervalSpinEdit: TSpinEdit;
    ScreenEnabledCheckBox: TCheckBox;
    TimeToShowSpinEdit: TSpinEdit;
    Line1Edit: TEdit;
    Line2Edit: TEdit;
    Line3Edit: TEdit;
    Line4Edit: TEdit;
    ActionsStringGrid: TStringGrid;
    OutputListBox: TListBox;
    Operand1Edit: TEdit;
    Label24: TLabel;
    OperatorComboBox: TComboBox;
    StatementEdit: TEdit;
    Label25: TLabel;
    ActionAddButton: TButton;
    ActionDeleteButton: TButton;
    Label26: TLabel;
    LCDSmartieUpdateCheckBox: TCheckBox;
    LCDFeaturesTabSheet: TTabSheet;
    ButtonsListBox: TListBox;
    Label27: TLabel;
    Label29: TLabel;
    LastKeyPressedEdit: TEdit;
    Label56: TLabel;
    Label30: TLabel;
    Label57: TLabel;
    Operand2Edit: TEdit;
    Label6: TLabel;
    RandomizeScreensCheckBox: TCheckBox;
    StayOnTopCheckBox: TCheckBox;
    TransitionButton: TButton;
    Label58: TLabel;
    DLLCheckIntervalSpinEdit: TSpinEdit;
    ProgramScrollIntervalSpinEdit: TSpinEdit;
    Label59: TLabel;
    Label28: TLabel;
    StickyCheckbox: TCheckBox;
    StartupTabSheet: TTabSheet;
    GroupBox7: TGroupBox;
    NoAutoStart: TRadioButton;
    AutoStart: TRadioButton;
    AutoStartHide: TRadioButton;
    GroupBox8: TGroupBox;
    HideOnStartup: TCheckBox;
    ColorSchemeComboBox: TComboBox;
    SkipScreenComboBox: TComboBox;
    ScreenLabel: TLabel;
    ScreenSpinEdit: TSpinEdit;
    DisplayGroup2: TGroupBox;
    Panel1: TPanel;
    DisplayPageControl: TPageControl;
    PluginTabsheet: TTabSheet;
    DisplayPluginsLabel: TLabel;
    IDLabel: TLabel;
    Label14: TLabel;
    UsageLabel: TLabel;
    DisplayPluginList: TComboBox;
    ParametersEdit: TEdit;
    ScreenTabsheet: TTabSheet;
    Label3: TLabel;
    LCDSizeComboBox: TComboBox;
    GroupBox3: TGroupBox;
    ContrastTrackBar: TTrackBar;
    GroupBox1: TGroupBox;
    BrightnessTrackBar: TTrackBar;
    EmailSSLEdit: TEdit;
    Label2: TLabel;
    EmulateLCDCheckbox: TCheckBox;
    TabSheet1: TTabSheet;
    PluginListBox: TJvFileListBox;
    Btn_PluginRefresh: TButton;
    Panel2: TPanel;
    Label9: TLabel;
    pluginDotNetVer: TLabel;
    Label10: TLabel;
    PluginDotNetRequired: TLabel;
    procedure FormShow(Sender: TObject);
    procedure LCDSizeComboBoxChange(Sender: TObject);
    procedure ScreenSpinEditChange(Sender: TObject);
    procedure WinampListBoxClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure SysInfoListBoxClick(Sender: TObject);
    procedure MBMListBoxClick(Sender: TObject);
    procedure InternetListBoxClick(Sender: TObject);
    procedure QStatLabelClick(Sender: TObject);
    procedure MiscListBoxClick(Sender: TObject);
    procedure LeftPageControlChange(Sender: TObject);
    procedure GameServerEditExit(Sender: TObject);
    procedure SetiAtHomeListBoxClick(Sender: TObject);
    procedure DistributedNetBrowseButtonClick(Sender: TObject);
    procedure EmailListBoxClick(Sender: TObject);
    procedure EmailAccountComboBoxChange(Sender: TObject);
    procedure ContinueLine1CheckBoxClick(Sender: TObject);
    procedure ContinueLine2CheckBoxClick(Sender: TObject);
    procedure ContinueLine3CheckBoxClick(Sender: TObject);
    procedure WinampLocationBrowseButtonClick(Sender: TObject);
    procedure GamestatsListBoxClick(Sender: TObject);
    procedure Line1EditEnter(Sender: TObject);
    procedure Line2EditEnter(Sender: TObject);
    procedure Line3EditEnter(Sender: TObject);
    procedure Line4EditEnter(Sender: TObject);
    procedure NetworkStatsListBoxClick(Sender: TObject);
    procedure FoldingAtHomeListBoxClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OutputListBoxClick(Sender: TObject);
    procedure MainPageControlChange(Sender: TObject);
    procedure ActionAddButtonClick(Sender: TObject);
    procedure ActionDeleteButtonClick(Sender: TObject);
    procedure ButtonsListBoxClick(Sender: TObject);
    procedure TransitionButtonClick(Sender: TObject);
    procedure Line4EditKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure Line1EditKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure Line2EditKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure Line3EditKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure StickyCheckboxClick(Sender: TObject);
    procedure ActionsStringGridClick(Sender: TObject);
    procedure SkipScreenComboBoxChange(Sender: TObject);
    procedure OperatorComboBoxChange(Sender: TObject);
    procedure ColorSchemeComboBoxChange(Sender: TObject);
    procedure DisplayPluginListChange(Sender: TObject);
    procedure ContrastTrackBarChange(Sender: TObject);
    procedure BrightnessTrackBarChange(Sender: TObject);
    procedure Btn_PluginRefreshClick(Sender: TObject);
    procedure PluginListBoxDblClick(Sender: TObject);
    procedure PluginListBoxClick(Sender: TObject);
  private
    DLLPath : string;
    setupbutton: Integer;
    CurrentlyShownEmailAccount: Integer;
    CurrentScreen: Integer;
    Procedure FocusToInputField;
    procedure SaveScreen(scr: Integer);
    procedure LoadScreen(scr: Integer);
    procedure LoadHint(DisplayDLLName : string);
  end;

function DoSetupForm : boolean;
procedure UpdateSetupForm(cKey : char);
function PerformingSetup : boolean;

implementation

uses
  Math, Windows, ShellApi, graphics, sysutils, Registry, StrUtils,
  UMain, UInteract, UConfig, UDataEmail, UDataNetwork, UDataWinamp,
  UDataMBM;

{$R *.DFM}

var
  SetupForm : TSetupForm = nil;

function DoSetupForm : boolean;
begin
  SetupForm := TSetupForm.Create(nil);
  with SetupForm do begin
    ShowModal;
    Result := (ModalResult = mrOK);
    LCDSmartieDisplayForm.NextScreenTimer.interval := 0;
    if (not config.screen[activeScreen][1].bSticky) then
      LCDSmartieDisplayForm.NextScreenTimer.interval := config.screen[activeScreen][1].showTime*1000;
    Free;
  end;
  SetupForm := nil;
end;

procedure TSetupForm.LoadHint(DisplayDLLName : string);
type
  TUsageFunc = function : pchar; stdcall;
var
  MyDLL : HMODULE;
  UsageFunc : TUsageFunc;
begin
  UsageLabel.Caption := 'no parameters';
  IDLabel.Caption := 'Warning: DLL may not be compatible!';
  ParametersEdit.Text := '';
  if FileExists(DisplayDLLName) then begin
    try
      MyDLL := LoadLibrary(pchar(DisplayDLLName));
      if not (MyDll = 0) then begin
        UsageFunc := GetProcAddress(MyDLL,pchar('DISPLAYDLL_Usage'));
        if assigned(UsageFunc) then
          UsageLabel.Caption := string(UsageFunc);
        UsageFunc := GetProcAddress(MyDLL,pchar('DISPLAYDLL_DriverName'));
        if assigned(UsageFunc) then
          IDLabel.Caption := string(UsageFunc);
        UsageFunc := GetProcAddress(MyDLL,pchar('DISPLAYDLL_DefaultParameters'));
        if assigned(UsageFunc) then
          ParametersEdit.Text := string(UsageFunc);
        FreeLibrary(MyDLL);
      end;
    except
    end;
  end;
end;

procedure TSetupForm.FormShow(Sender: TObject);
var
  i, blaat: Integer;
  SR : TSearchRec;
  Loop,FindResult : integer;
  NetStat : TNetworkStatistics;
  WinampStat : TWinampStat;
  MBMStat : TMBMStat;
begin
  MainPageControl.ActivePage := ScreensTabSheet;
  //if pagecontrol1.activepage = tabsheet13 then pagecontrol1.ActivePage :=
   // tabsheet1;
  //tabsheet13.Enabled := false;
  LCDFeaturesTabSheet.Enabled := true;

  setupbutton := 1;

  GameServerEdit.text := config.gameServer[1, 1];

  ActionsStringGrid.rowcount := 0;
  for blaat := 0 to 999 do
  begin
    ActionsStringGrid.Cells[0, blaat] := '';
    ActionsStringGrid.Cells[1, blaat] := '';
    ActionsStringGrid.Cells[2, blaat] := '';
    ActionsStringGrid.Cells[3, blaat] := '';
    ActionsStringGrid.Cells[4, blaat] := '';
  end;

  for i := 1 to config.totalactions do
  begin
      Operand1Edit.text := config.actionsArray[i, 1];
      OperatorComboBox.itemindex := StrToInt(config.actionsArray[i, 2]);
      Operand2Edit.text := config.actionsArray[i, 3];
      StatementEdit.text := config.actionsArray[i, 4];
      ActionAddButton.click;
  end;

  //application.ProcessMessages;

  ScreenSpinEdit.MaxValue := MaxScreens;
  ScreenSpinEdit.Value := 1;
  CurrentScreen := 1;
  LoadScreen( CurrentScreen );   // setup screen in setup form
  LCDSmartieDisplayForm.ChangeScreen(CurrentScreen);   // setup screen in main form

  ProgramRefreshIntervalSpinEdit.Value := config.refreshRate;
  WinampLocationEdit.text := config.winampLocation;
  ColorSchemeComboBox.itemindex := config.colorOption;


  SetiAtHomeEmailEdit.text := config.setiEmail;

  DistributedNetLogfileEdit.text := config.distLog;

  EmailCheckTimeSpinEdit.Value := config.emailPeriod;
  DLLCheckIntervalSpinEdit.Value := config.dllPeriod;
  ProgramScrollIntervalSpinEdit.Value := config.scrollPeriod;

  StayOnTopCheckBox.checked := config.alwaysOnTop;
  HideOnStartup.Checked := config.bHideOnStartup;
  NoAutoStart.Checked := True;
  AutoStart.Checked := config.bAutoStart;
  AutoStartHide.Checked := config.bAutoStartHide;
  EmulateLCDCheckbox.Checked := config.EmulateLCD;

  WebProxyServerEdit.text := config.httpProxy;
  WebProxyPortEdit.text := IntToStr(config.httpProxyPort);

  EmailListBox.Clear;
  EmailAccountComboBox.Clear;
  for i := 1 to MaxEmailAccounts do begin
    EmailListBox.Items.Add('Email '+IntToStr(i)+': Message Count');
    EmailListBox.Items.Add('Email '+IntToStr(i)+': Last Subject');
    EmailListBox.Items.Add('Email '+IntToStr(i)+': Last From');
    EmailAccountComboBox.Items.Add(IntToStr(i));
  end;
  EmailAccountComboBox.itemindex := 0;
  EmailServerEdit.text := config.pop[1].server;
  EmailLoginEdit.text := config.pop[1].user;
  EmailPasswordEdit.text := config.pop[1].pword;
  EmailSSLEdit.Text := config.pop[1].port_ssl;

  NetworkStatsListBox.Clear;
  for NetStat := FirstNetworkStat to LastNetworkStat do begin
    NetworkStatsListBox.Items.Add(NetworkUserHints[NetStat]);
  end;

  WinampListBox.Clear;
  for WinampStat := FirstWinampStat to LastWinampStat do begin
    WinampListBox.Items.Add(WinampHints[WinampStat]);
  end;

  MBMListBox.Clear;
  for Loop := 1 to MaxMBMStat-1 do begin
    for MBMStat := FirstMBMStat to LastMBMStat do begin
      MBMListBox.Items.Add(MBMHints[MBMStat] + ' ' + IntToStr(Loop));
    end;
  end;


  LCDSizeComboBox.Items.Clear;
  for i := 1 to MaxScreenSizes do
    LCDSizeComboBox.Items.Add(ScreenSizes[i].SizeName);
  LCDSizeComboBox.itemindex := config.ScreenSize-1;
  LCDSizeComboBoxChange(Sender);


  // put display plugin settings on screen
  ContrastTrackBar.position := config.DLL_contrast;
  BrightnessTrackBar.position := config.DLL_brightness;
  DisplayPluginList.Items.Clear;
  DisplayPluginList.Items.Add('None');
  DLLPath := extractfilepath(paramstr(0))+'displays\';
  FindResult := findfirst(DLLPath+'*.dll',0,SR);
  while (FindResult = 0) do begin
    DisplayPluginList.Items.Add(extractfilename(SR.Name));
    FindResult := FindNext(SR);
  end;
  findclose(SR);
  DisplayPluginList.ItemIndex := 0;
  for Loop := 0 to DisplayPluginList.Items.Count-1 do begin
    if lowercase(config.DisplayDLLName) = lowercase(DisplayPluginList.Items[Loop]) then begin
      DisplayPluginList.ItemIndex := Loop;
    end;
  end;
  DisplayPluginListChange(Sender);
  ParametersEdit.Text := config.DisplayDLLParameters; // set our original parameters back

  InternetRefreshTimeSpinEdit.Value := config.newsRefresh;
  RandomizeScreensCheckBox.checked := config.randomScreens;
  GamestatsRefreshTimeSpinEdit.Value := config.gameRefresh;
  FoldingAtHomeEmailEdit.text := config.foldUsername;
  MBMRefreshTimeSpinEdit.Value := config.mbmRefresh;
  LCDSmartieUpdateCheckBox.checked := config.checkUpdates;



  for i := 1 to 24 do ButtonsListBox.Items.Delete(1);
  //LCDFeaturesTabSheet.Enabled := true;
  ButtonsListBox.Items.Add('FanSpeed(1,1) (nr,divider)');

  { The below is commented out as it is reading/writing directly to the device.
    We need to know more details so we can move it in to the lcd code.

     // var section move down to here:
      var
        line, line2: String;
        ch: char;
        laatstepacket: Boolean;

      label nextpacket;

  LCDSmartieDisplayForm.VaComm1.WriteChar(chr($FE));   //probe 4 one-wire devices
  LCDSmartieDisplayForm.VaComm1.WriteChar(chr($C8));
  LCDSmartieDisplayForm.VaComm1.WriteChar(chr($02));


  laatstepacket := false;
nextpacket:
  line := '';
  line2 := '';
  while LCDSmartieDisplayForm.VaComm1.ReadBufUsed >= 1 do
  begin
    LCDSmartieDisplayForm.VaComm1.ReadChar(Ch);
    line := line + ch;
  end;
  if length(line)>13 then
  begin
    if line[1] + line[2]='#*' then
    begin
      if line[3] = chr(10) then laatstepacket := true;
      if (line[5] = chr(0)) and (line[14] = chr(0)) then
      begin
        for i := 0 to 7 do
        begin
          line2 := line2 + IntToHex(ord(line[i + 6]), 2) + ' ';
        end;
        ButtonsListBox.Items.Add(line2);
      end;
    end;
    if laatstepacket <> true then goto nextpacket;
  end;}

end;

procedure TSetupForm.DisplayPluginListChange(Sender: TObject);
begin
  if (DisplayPluginList.ItemIndex > 0) then
    LoadHint(DLLPath+DisplayPluginList.Text)
  else begin
    UsageLabel.Caption := 'no parameters';
    IDLabel.Caption := '';
    ParametersEdit.Text := '';
  end;
end;

procedure TSetupForm.LCDSizeComboBoxChange(Sender: TObject);
begin
  if LCDSizeComboBox.itemindex < 0 then LCDSizeComboBox.itemindex := 0;

  if LCDSizeComboBox.itemindex < 5 then
  begin
    ContinueLine1CheckBox.checked := false;
    Line2Edit.Visible := false;
    Line3Edit.Visible := false;
    Line4Edit.Visible := false;
    DontScrollLine2CheckBox.Visible := false;
    DontScrollLine3CheckBox.Visible := false;
    DontScrollLine4CheckBox.Visible := false;
    ContinueLine1CheckBox.Visible := false;
    ContinueLine2CheckBox.Visible := false;
    ContinueLine3CheckBox.Visible := false;
    CenterLine2CheckBox.visible := false;
    CenterLine3CheckBox.visible := false;
    CenterLine4CheckBox.visible := false;
  end;
  if (LCDSizeComboBox.itemindex < 9) and (LCDSizeComboBox.itemindex > 4) then
  begin
    if ContinueLine1CheckBox.checked = false then Line2Edit.Visible := true;
    ContinueLine2CheckBox.checked := false;
    Line3Edit.Visible := false;
    Line4Edit.Visible := false;
    DontScrollLine2CheckBox.Visible := true;
    DontScrollLine3CheckBox.Visible := false;
    DontScrollLine4CheckBox.Visible := false;
    ContinueLine1CheckBox.Visible := true;
    ContinueLine2CheckBox.Visible := false;
    ContinueLine3CheckBox.Visible := false;
    CenterLine2CheckBox.visible := true;
    CenterLine3CheckBox.visible := false;
    CenterLine4CheckBox.visible := false;
  end;
  if LCDSizeComboBox.itemindex > 8 then
  begin
    if ContinueLine1CheckBox.checked = false then Line2Edit.Visible := true;
    if ContinueLine2CheckBox.checked = false then Line3Edit.Visible := true;
    if ContinueLine3CheckBox.checked = false then Line4Edit.Visible := true;
    DontScrollLine2CheckBox.Visible := true;
    DontScrollLine3CheckBox.Visible := true;
    DontScrollLine4CheckBox.Visible := true;
    ContinueLine1CheckBox.Visible := true;
    ContinueLine2CheckBox.Visible := true;
    ContinueLine3CheckBox.Visible := true;
    CenterLine2CheckBox.visible := true;
    CenterLine3CheckBox.visible := true;
    CenterLine4CheckBox.visible := true;
  end;
end;

procedure TSetupForm.SaveScreen(scr: Integer);
var
  y: Integer;

begin

  config.screen[scr][1].text := Line1Edit.text;
  config.screen[scr][2].text := Line2Edit.text;
  config.screen[scr][3].text := Line3Edit.text;
  config.screen[scr][4].text := Line4Edit.text;

  for y := 1 to MaxLines do
  begin
    config.screen[scr][y].enabled := ScreenEnabledCheckBox.checked;
    config.screen[scr][y].skip := SkipScreenComboBox.itemindex;
    try
      config.screen[scr][y].theme := ThemeNumberSpinEdit.value-1;
    except
      config.screen[scr][y].theme := 0;
    end;
    try
      config.screen[scr][y].showTime := TimeToShowSpinEdit.value;
    except
      config.screen[scr][y].showTime := 10;
    end;
    config.screen[scr][y].bSticky := StickyCheckbox.Checked;

    // ensure no ¿s occur in the text.
    config.screen[scr][y].text := StringReplace(config.screen[scr][y].text,
      '¿', '?', [rfReplaceAll]);
  end;

  config.screen[scr][1].center := CenterLine1CheckBox.checked;
  config.screen[scr][2].center := CenterLine2CheckBox.checked;
  config.screen[scr][3].center := CenterLine3CheckBox.checked;
  config.screen[scr][4].center := CenterLine4CheckBox.checked;

  config.screen[scr][1].noscroll := DontScrollLine1CheckBox.checked;
  config.screen[scr][2].noscroll := DontScrollLine2CheckBox.checked;
  config.screen[scr][3].noscroll := DontScrollLine3CheckBox.checked;
  config.screen[scr][4].noscroll := DontScrollLine4CheckBox.checked;
  LCDSmartieDisplayForm.ResetScrollPositions();

  config.screen[scr][1].contNextLine := ContinueLine1CheckBox.checked;
  config.screen[scr][2].contNextLine := ContinueLine2CheckBox.checked;
  config.screen[scr][3].contNextLine := ContinueLine3CheckBox.checked;
  config.screen[scr][4].contNextLine := False;
end;

procedure TSetupForm.LoadScreen(scr: Integer);
var
  ascreen: TScreenLine;
begin
  ascreen := config.screen[scr][1];
  ScreenEnabledCheckBox.checked := ascreen.enabled;
  SkipScreenComboBox.itemindex := ascreen.skip;
  ThemeNumberSpinEdit.value := ascreen.theme + 1;
  TimeToShowSpinEdit.value := ascreen.showTime;
  StickyCheckbox.checked := ascreen.bSticky;
  TimeToShowSpinEdit.enabled := not ascreen.bSticky;

  DontScrollLine1CheckBox.checked := false;
  DontScrollLine2CheckBox.checked := false;
  DontScrollLine3CheckBox.checked := false;
  DontScrollLine4CheckBox.checked := false;
  ContinueLine1CheckBox.checked := false;
  ContinueLine2CheckBox.checked := false;
  ContinueLine3CheckBox.checked := false;
  DontScrollLine1CheckBox.enabled := true;
  DontScrollLine1CheckBox.checked := false;
  Line2Edit.enabled := true;
  DontScrollLine2CheckBox.enabled := true;
  DontScrollLine2CheckBox.checked := false;
  Line3Edit.enabled := true;
  DontScrollLine3CheckBox.enabled := true;
  DontScrollLine3CheckBox.checked := false;
  Line4Edit.enabled := true;

  Line1Edit.color := $00A1D7A4;
  Line2Edit.color := clWhite;
  Line3Edit.color := clWhite;
  Line4Edit.color := clWhite;
  setupbutton := 1;
  GameServerEdit.text := config.gameServer[scr, 1];

  ascreen := config.screen[scr][1];
  DontScrollLine1CheckBox.checked := ascreen.noscroll;
  if ascreen.contNextLine then
  begin
    ContinueLine1CheckBox.checked := true;
    DontScrollLine1CheckBox.Checked := true;
    DontScrollLine1CheckBox.enabled := false;
    Line2Edit.enabled := false;
    Line2Edit.color := $00BBBBFF;
  end;
  Line1Edit.text := ascreen.text;
  CenterLine1CheckBox.Checked := ascreen.center;

  ascreen := config.screen[scr][2];
  DontScrollLine2CheckBox.checked := ascreen.noscroll;
  if ascreen.contNextLine then
  begin
    ContinueLine2CheckBox.checked := true;
    DontScrollLine2CheckBox.Checked := true;
    DontScrollLine2CheckBox.enabled := false;
    Line3Edit.enabled := false;
    Line3Edit.color := $00BBBBFF;
  end;
  Line2Edit.text := ascreen.text;
  CenterLine2CheckBox.Checked := ascreen.center;

  ascreen := config.screen[scr][3];
  DontScrollLine3CheckBox.checked := ascreen.noscroll;
  if ascreen.contNextLine then
  begin
    ContinueLine3CheckBox.checked := true;
    DontScrollLine3CheckBox.Checked := true;
    DontScrollLine3CheckBox.enabled := false;
    Line4Edit.enabled := false;
    Line4Edit.color := $00BBBBFF;
  end;
  Line3Edit.text := ascreen.text;
  CenterLine3CheckBox.Checked := ascreen.center;

  ascreen := config.screen[scr][4];
  DontScrollLine4CheckBox.checked := ascreen.noscroll;
  Line4Edit.text := ascreen.text;
  CenterLine4CheckBox.Checked := ascreen.center;
end;

procedure TSetupForm.ScreenSpinEditChange(Sender: TObject);
begin
  SaveScreen(CurrentScreen);

  try
    CurrentScreen := max(1,min(MaxScreens,ScreenSpinEdit.Value));
  except
    CurrentScreen := 1;
  end;

  LoadScreen(CurrentScreen);
  LCDSmartieDisplayForm.ChangeScreen(CurrentScreen);
end;

procedure TSetupForm.WinampListBoxClick(Sender: TObject);
var
  WinampStat : TWinampStat;
begin
  WinampStat := TWinampStat(WinampListBox.itemindex);
  if (WinampStat >= FirstWinampStat) and (WinampStat <= LastWinampStat) then begin
    VariableEdit.Text := WinampKeys[WinampStat];
    if (WinampStat = wsWinampPosition) then  // special case, should be resolved elsewhere
      VariableEdit.Text := VariableEdit.Text + '(10)';
  end else
    VariableEdit.Text := NoVariable;

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;


// Select currently active text field that will receive variable if 'insert'
// is pressed.
Procedure TSetupForm.FocusToInputField;
var
  tempint1, tempint2: Integer;
begin
  if (ScreensTabSheet.visible) then // in Screens tab
  begin
    // not all the lines will be enabled/visible because of different size
    // displays.

    if (setupbutton = 2) and (Line2Edit.Enabled) and (Line2Edit.visible) then
    begin
      tempint1 := Line2Edit.SelStart;
      tempint2 := Line2Edit.SelLength;
      Line2Edit.setfocus;
      Line2Edit.SelStart := tempint1;
      Line2Edit.SelLength := tempint2;
    end
    else if (setupbutton = 3) and (Line3Edit.enabled) and (Line3Edit.visible) then
    begin
      tempint1 := Line3Edit.SelStart;
      tempint2 := Line3Edit.SelLength;
      Line3Edit.setfocus;
      Line3Edit.SelStart := tempint1;
      Line3Edit.SelLength := tempint2;
    end
    else if (setupbutton = 4) and (Line4Edit.enabled) and (Line4Edit.visible) then
    begin
      tempint1 := Line4Edit.SelStart;
      tempint2 := Line4Edit.SelLength;
      Line4Edit.setfocus;
      Line4Edit.SelStart := tempint1;
      Line4Edit.SelLength := tempint2;
    end
    else if (Line1Edit.Enabled) and (Line1Edit.visible) then // default to line 1 of screen section
    begin // setupbutton = 1
      tempint1 := Line1Edit.SelStart;
      tempint2 := Line1Edit.SelLength;
      Line1Edit.setfocus;
      Line1Edit.SelStart := tempint1;
      Line1Edit.SelLength := tempint2;
    end;
  end
  else if (ActionsTabSheet.visible) then // in Actions tab
  begin
    if (Operand1Edit.Enabled) and (Operand1Edit.visible) then
    begin
      tempint1 := Operand1Edit.SelStart;
      tempint2 := Operand1Edit.SelLength;
      Operand1Edit.setfocus;
      Operand1Edit.SelStart := tempint1;
      Operand1Edit.SelLength := tempint2;
    end
  end;
end;

procedure TSetupForm.InsertButtonClick(Sender: TObject);
var
  tempint: Integer;

begin
  if VariableEdit.Text <> NoVariable then
  begin
    if (ScreensTabSheet.visible) then // in Screens tab
    begin
      if (setupbutton = 2) and (Line2Edit.enabled) and (Line2Edit.visible) then
      begin
        tempint := Line2Edit.SelStart;
        Line2Edit.text := copy(Line2Edit.text, 1, Line2Edit.SelStart) + VariableEdit.Text +
          copy(Line2Edit.text, Line2Edit.SelStart + 1 + Line2Edit.SelLength,
          length(Line2Edit.Text));
        Line2Edit.SetFocus;
        Line2Edit.selstart := tempint + length(VariableEdit.text);
      end
      else if (setupbutton = 3) and (Line3Edit.enabled) and (Line3Edit.visible) then
      begin
        tempint := Line3Edit.SelStart;
        Line3Edit.text := copy(Line3Edit.text, 1, Line3Edit.SelStart) + VariableEdit.Text +
          copy(Line3Edit.text, Line3Edit.SelStart + 1 + Line3Edit.SelLength,
          length(Line3Edit.Text));
        Line3Edit.SetFocus;
        Line3Edit.selstart := tempint + length(VariableEdit.text);
      end
      else if (setupbutton = 4) and (Line4Edit.enabled) and (Line4Edit.visible) then
      begin
        tempint := Line4Edit.SelStart;
        Line4Edit.text := copy(Line4Edit.text, 1, Line4Edit.SelStart) + VariableEdit.Text +
          copy(Line4Edit.text, Line4Edit.SelStart + 1 + Line4Edit.SelLength,
          length(Line4Edit.Text));
        Line4Edit.SetFocus;
        Line4Edit.selstart := tempint + length(VariableEdit.text);
      end
      else if (Line1Edit.enabled) and (Line1Edit.visible) then // default to line 1
      begin
        tempint := Line1Edit.SelStart;
        Line1Edit.text := copy(Line1Edit.text, 1, tempint) + VariableEdit.Text +
          copy(Line1Edit.text, tempint + 1 + Line1Edit.SelLength, length(Line1Edit.Text));
        Line1Edit.SetFocus;
        Line1Edit.selstart := tempint + length(VariableEdit.text);
      end;
    end
    else if (ActionsTabSheet.Visible) then // in Actions tab
    begin
      if (LastKeyPressedEdit.text='') and (VariableEdit.text='$MObutton') then
      begin
        showmessage ('please press the button you want to bind');
      end
      else
      begin
        if pos('$MObutton', VariableEdit.Text) <> 0 then
          VariableEdit.Text := '$MObutton(' + LastKeyPressedEdit.text + ')';
        Operand1Edit.text := VariableEdit.text;
      end;
    end;
  end;
end;

procedure TSetupForm.SysInfoListBoxClick(Sender: TObject);
begin
  case SysInfoListBox.itemindex of
    0 : VariableEdit.Text := '$Username';
    1 : VariableEdit.Text := '$Computername';
    2 : VariableEdit.Text := '$CPUType';
    3 : VariableEdit.Text := '$CPUSpeed';
    4 : VariableEdit.Text := '$CPUUsage%';
    5 : VariableEdit.Text := '$Bar($CPUUsage%,100,10)';
    6 : VariableEdit.Text := '$MemFree';
    7 : VariableEdit.Text := '$MemUsed';
    8 : VariableEdit.Text := '$MemTotal';
    9 : VariableEdit.Text := '$MemF%';
    10 : VariableEdit.Text := '$MemU%';
    11 : VariableEdit.Text := '$Bar($MemFree,$MemTotal,10)';
    12 : VariableEdit.Text := '$Bar($MemUsed,$MemTotal,10)';
    13 : VariableEdit.Text := '$PageFree';
    14 : VariableEdit.Text := '$PageUsed';
    15 : VariableEdit.Text := '$PageTotal';
    16 : VariableEdit.Text := '$PageF%';
    17 : VariableEdit.Text := '$PageU%';
    18 : VariableEdit.Text := '$Bar($PageFree,$PageTotal,10)';
    19 : VariableEdit.Text := '$Bar($PageUsed,$PageTotal,10)';
    20 : VariableEdit.Text := '$HDFree(C)';
    21 : VariableEdit.Text := '$HDUsed(C)';
    22 : VariableEdit.Text := '$HDTotal(C)';
    23 : VariableEdit.Text := '$HDFreg(C)';
    24 : VariableEdit.Text := '$HDUseg(C)';
    25 : VariableEdit.Text := '$HDTotag(C)';
    26 : VariableEdit.Text := '$HDF%(C)';
    27 : VariableEdit.Text := '$HDU%(C)';
    28 : VariableEdit.Text := '$Bar($HDFree(C),$HDTotal(C),10)';
    29 : VariableEdit.Text := '$Bar($HDUsed(C),$HDTotal(C),10)';
    30 : VariableEdit.Text := '$ScreenReso';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.MBMListBoxClick(Sender: TObject);
var
  MBMStat : TMBMStat;
  Index : integer;
begin
  MBMStat := TMBMStat(MBMListBox.itemindex mod (ord(LastMBMStat)+1));
  Index := MBMListBox.itemindex div (ord(LastMBMStat)+1) + 1;

  if (MBMStat >= FirstMBMStat) and (MBMStat <= LastMBMStat) then begin
    VariableEdit.Text := MBMStatKey[MBMStat]+IntToStr(Index);
  end else
    VariableEdit.Text := NoVariable;

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.InternetListBoxClick(Sender: TObject);
{Stock Indexes
Tom's Hardware headlines
Tweakers.net headlines (in dutch)
Weather (Holland)
Weather.com(locationcode)

   if InternetListBox.itemindex = 1 then VariableEdit.Text := '$Stocks';
    if InternetListBox.itemindex = 2 then VariableEdit.Text := '$TomsHW';
    if InternetListBox.itemindex = 3 then VariableEdit.Text := '$T.netHL';
    if InternetListBox.itemindex = 4 then VariableEdit.Text := '$DutchWeather';
    if InternetListBox.itemindex = 5 then VariableEdit.Text := '$Weather.com(CAXX0504)';
    }
begin
  case InternetListBox.itemindex of
    0: VariableEdit.Text := '$Rss(http://news.bbc.co.uk/rss/newsonline_uk_edition/world/rss091.xml,b)';
    1: VariableEdit.Text := '$Rss(http://news.bbc.co.uk/rss/newsonline_uk_edition/uk/rss091.xml,b)';
    2: VariableEdit.Text := '$Rss(http://www.tweakers.net/feeds/mixed.xml,b)';
    3: VariableEdit.Text := '$Rss(http://www.theregister.co.uk/headlines.rss,b)';
    4: VariableEdit.Text := '$Rss(http://slashdot.org/index.rss,b)';
    5: VariableEdit.Text := '$Rss(http://www.wired.com/news_drop/netcenter/netcenter.rdf,b)';
    6: VariableEdit.Text := '$Rss(http://www.fool.com/xml/foolnews_rss091.xml,b,1)';
    7: VariableEdit.Text := '$Rss(http://www.fool.com/xml/foolnews_rss091.xml,b)';
    8: VariableEdit.Text := '$Rss(http://sourceforge.net/export/rss2_projnews.php?group_id=122330&rss_fulltext=1,b,1)';
    9: VariableEdit.Text := '$Rss(http://sourceforge.net/export/rss2_projnews.php?group_id=2987&rss_fulltext=1,b,1)';
    10: VariableEdit.Text := '$Rss(http://www.weatherclicks.com/xml/fort+lauderdale,t,2): $Rss(http://www.weatherclicks.com/xml/fort+lauderdale,d,2) | ';
    11: VariableEdit.Text := '$Rss(http://news.bbc.co.uk/rss/newsonline_world_edition/business/rss091.xml,b)';
    12: VariableEdit.Text := '$Rss(http://www.washingtonpost.com/wp-srv/business/rssheadlines.xml,b)';
    13: VariableEdit.Text := '$Rss(http://rss.news.yahoo.com/rss/entertainment,b)';
    14: VariableEdit.Text := '$Rss(http://partners.userland.com/nytRss/health.xml,b)';
    15: VariableEdit.Text := '$Rss(http://partners.userland.com/nytRss/sports.xml,b)';
    16: VariableEdit.Text := '$Rss(http://www.securityfocus.com/rss/news.xml,b)';
    17: VariableEdit.Text := '$Rss(http://volkskrant.nl/rss/economie.rss,b)';
    18: VariableEdit.Text := '$Rss(http://www.vpro.nl/3voor12/rss/index.jsp?images=false,b)';
    19: VariableEdit.Text := '$Rss(http://www.ad.nl/index.xml,b)';
    20: VariableEdit.Text := '$Rss(http://www.atletiek.nl/rss.xml,b)';
    21: VariableEdit.Text := '$Rss(http://www.rtl.fr/referencement/rtl.asp,b)';
    22: VariableEdit.Text := '$Rss(http://www.tagesschau.de/xml/tagesschau-meldungen/,b)';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.QStatLabelClick(Sender: TObject);
begin
  ShellExecute(0, Nil, pchar('www.qstat.org'), Nil, Nil, SW_NORMAL);
end;

procedure TSetupForm.MiscListBoxClick(Sender: TObject);
begin
  case MiscListBox.itemindex of
    0 : VariableEdit.Text := '$DnetSpeed';
    1 : VariableEdit.Text := '$DnetDone';
    2 : VariableEdit.Text := '$Time(d mmmm yyyy hh: nn: ss)';
    3 : VariableEdit.Text := '$UpTime';
    4 : VariableEdit.Text := '$UpTims';
    5 : VariableEdit.Text := '°';
    6 : VariableEdit.Text := 'ž';
    7 : VariableEdit.Text := '$Chr(20)';
    8 : VariableEdit.Text := '$File(C:\file.txt,1)';
    9 : VariableEdit.Text := '$LogFile(C:\file.log,0)';
    10 : VariableEdit.Text := '$dll(demo.dll,5,param1,param2)';
    11 : VariableEdit.Text := '$Count(101#$CPUSpeed#4)';
    12 : VariableEdit.Text := '$Bar(30,100,20)';
    13 : VariableEdit.Text := '$Right(ins variable(s) here,$3%)';
    14 : VariableEdit.Text := '$Fill(10)';
    15 : VariableEdit.Text := '$Flash(insert text here$)$';
    16 : VariableEdit.Text := '$CustomChar(1, 31, 31, 31, 31, 31, 31, 31, 31)';
    17 : VariableEdit.Text := '$Rss(URL,t|d|b,ITEM#,MAXFREQHRS)';
    18 : VariableEdit.Text := '$Center(text here,15)';
    19 : VariableEdit.Text := '$ScreenChanged';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.SetiAtHomeListBoxClick(Sender: TObject);
begin
  case SetiAtHomeListBox.itemindex of
    0 : VariableEdit.Text := '$SETIResults';
    1 : VariableEdit.Text := '$SETICPUTime';
    2 : VariableEdit.Text := '$SETIAverage';
    3 : VariableEdit.Text := '$SETILastresult';
    4 : VariableEdit.Text := '$SETIusertime';
    5 : VariableEdit.Text := '$SETItotalusers';
    6 : VariableEdit.Text := '$SETIrank';
    7 : VariableEdit.Text := '$SETIsharingrank';
    8 : VariableEdit.Text := '$SETImoreWU%';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.LeftPageControlChange(Sender: TObject);
begin
  if LeftPageControl.ActivePage = WinampTabSheet then
    WinampListBoxClick(Sender);
  if LeftPageControl.ActivePage = SysInfoTabSheet then
    SysInfoListBoxClick(Sender);
  if LeftPageControl.ActivePage = MBMTabSheet then
    MBMListBoxClick(Sender);
  if LeftPageControl.ActivePage = LCDFeaturesTabSheet then
    ButtonsListBoxClick(Sender);
  if LeftPageControl.ActivePage = GameStatsTabSheet then
    GamestatsListBoxClick(Sender);
  if LeftPageControl.ActivePage = InternetTabSheet then
    InternetListBoxClick(Sender);
  if LeftPageControl.ActivePage = MiscTabSheet then
    MiscListBoxClick(Sender);
  if LeftPageControl.ActivePage = SetiAtHomeTabSheet then
    SetiAtHomeListBoxClick(Sender);
  if LeftPageControl.ActivePage = FoldingAtHomeTabSheet then
    FoldingAtHomeListBoxClick(Sender);
  if LeftPageControl.ActivePage = EmailTabSheet then
    EmailListBoxClick(Sender);
  if LeftPageControl.ActivePage = NetworkStatsTabSheet then
    NetworkStatsListBoxClick(Sender);
end;


procedure TSetupForm.GameServerEditExit(Sender: TObject);
begin
  if (setupbutton >= 0) and (setupbutton <= 4) then
  begin
    config.gameServer[ScreenSpinEdit.Value, setupbutton] := GameServerEdit.text;
  end;
end;

procedure TSetupForm.DistributedNetBrowseButtonClick(Sender: TObject);
var
  line, line2: String;

begin
  line := DistributedNetLogfileEdit.text;
  line2 := '';
  while pos('\', line) <> 0 do
  begin
    line2 := line2 + copy(line, 1, pos('\', line));
    line := copy(line, pos('\', line) + 1, length(line));
  end;
  opendialog2.InitialDir := line2;
  opendialog2.FileName := DistributedNetLogfileEdit.text;
  Opendialog2.Execute;
  if opendialog2.FileName <> '' then DistributedNetLogfileEdit.text := opendialog2.FileName;
end;

procedure TSetupForm.EmailListBoxClick(Sender: TObject);
begin
  if (EmailListBox.itemindex >= 0) and (EmailListBox.itemindex < MaxEmailAccounts*3) then begin
    case EmailListBox.itemindex mod 3 of
      0: VariableEdit.Text := EmailCountKey+IntToStr((EmailListBox.itemindex div 3 + 1) mod MaxEmailAccounts);
      1: VariableEdit.Text := EmailSubjectKey+IntToStr((EmailListBox.itemindex div 3 + 1) mod MaxEmailAccounts);
      2: VariableEdit.Text := EmailFromKey+IntToStr((EmailListBox.itemindex div 3 + 1) mod MaxEmailAccounts);
    end;
  end else
    VariableEdit.Text := NoVariable;

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.EmailAccountComboBoxChange(Sender: TObject);

begin
  config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].server := EmailServerEdit.text;
  config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].user := EmailLoginEdit.text;
  config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].pword := EmailPasswordEdit.text;
  config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].port_ssl := EmailSSLEdit.text;

  if EmailAccountComboBox.itemIndex < 0 then EmailAccountComboBox.itemindex := 0;

  CurrentlyShownEmailAccount := EmailAccountComboBox.itemindex;
  EmailServerEdit.text := config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].server;
  EmailLoginEdit.text := config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].user;
  EmailPasswordEdit.text := config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].pword;
  EmailSSLEdit.text := config.pop[(CurrentlyShownEmailAccount + 1) mod MaxEmailAccounts].port_ssl;
end;

procedure TSetupForm.ContinueLine1CheckBoxClick(Sender: TObject);
var
  tempint1: Integer;

begin
  if ContinueLine1CheckBox.checked = true then
  begin
    DontScrollLine1CheckBox.Checked := true;
    DontScrollLine1CheckBox.enabled := false;
    if setupbutton = 2 then
    begin
      tempint1 := Line1Edit.SelStart;
      Line1Edit.setfocus;
      Line1Edit.SelStart := tempint1;
    end;
    Line2Edit.enabled := false;
    Line2Edit.color := $00BBBBFF;
  end
  else
  begin
    DontScrollLine1CheckBox.enabled := true;
    DontScrollLine1CheckBox.checked := false;
    Line2Edit.enabled := true;
    Line2Edit.color := clWhite;
  end;
end;

procedure TSetupForm.ContinueLine2CheckBoxClick(Sender: TObject);
var
  tempint1: Integer;

begin
  if ContinueLine2CheckBox.checked = true then
  begin
    DontScrollLine2CheckBox.Checked := true;
    DontScrollLine2CheckBox.enabled := false;
    if setupbutton = 3 then
    begin
      tempint1 := Line1Edit.SelStart;
      Line1Edit.setfocus;
      Line1Edit.SelStart := tempint1;
    end;
    Line3Edit.enabled := false;
    Line3Edit.color := $00BBBBFF;
  end
  else
  begin
    DontScrollLine2CheckBox.enabled := true;
    DontScrollLine2CheckBox.checked := false;
    Line3Edit.enabled := true;
    Line3Edit.color := clWhite;
  end;
end;

procedure TSetupForm.ContinueLine3CheckBoxClick(Sender: TObject);
var
  tempint1: Integer;

begin
  if ContinueLine3CheckBox.checked = true then
  begin
    DontScrollLine3CheckBox.Checked := true;
    DontScrollLine3CheckBox.enabled := false;
    if setupbutton = 4 then
    begin
      tempint1 := Line1Edit.SelStart;
      Line1Edit.setfocus;
      Line1Edit.SelStart := tempint1;
    end;
    Line4Edit.enabled := false;
    Line4Edit.color := $00BBBBFF;
  end
  else
  begin
    DontScrollLine3CheckBox.enabled := true;
    DontScrollLine3CheckBox.checked := false;
    Line4Edit.enabled := true;
    Line4Edit.color := clWhite;
  end;
end;

procedure TSetupForm.WinampLocationBrowseButtonClick(Sender: TObject);
begin
  opendialog1.Execute;
  if opendialog1.FileName <> '' then WinampLocationEdit.text := opendialog1.FileName;
end;

procedure TSetupForm.GamestatsListBoxClick(Sender: TObject);
var
  S : string;
begin
  case GameTypeComboBox.itemindex of
    0 : S := '$Half-life';
    1 : S := '$QuakeII';
    2 : S := '$QuakeIII';
    3 : S := '$Unreal';
    else S := NoVariable;
  end; // case

  if not (S = NoVariable) then begin
    VariableEdit.Text := S + IntToStr(GamestatsListBox.Itemindex+1);
    FocusToInputField();
  end else
    VariableEdit.Text := S;
end;


procedure TSetupForm.Line1EditEnter(Sender: TObject);
begin
  GameServerEdit.text := config.gameServer[ScreenSpinEdit.Value, 1];
  setupbutton := 1;
  Line1Edit.color := $00A1D7A4;
  if Line2Edit.enabled= true then Line2Edit.color := clWhite
  else Line2Edit.color := $00BBBBFF;
  if Line3Edit.enabled= true then Line3Edit.color := clWhite
  else Line3Edit.color := $00BBBBFF;
  if Line4Edit.enabled= true then Line4Edit.color := clWhite
  else Line4Edit.color := $00BBBBFF;
end;

procedure TSetupForm.Line2EditEnter(Sender: TObject);
begin
  GameServerEdit.text := config.gameServer[ScreenSpinEdit.Value, 2];
  setupbutton := 2;
  Line2Edit.color := $00A1D7A4;
  if Line1Edit.enabled= true then Line1Edit.color := clWhite
  else Line1Edit.color := $00BBBBFF;
  if Line3Edit.enabled= true then Line3Edit.color := clWhite
  else Line3Edit.color := $00BBBBFF;
  if Line4Edit.enabled= true then Line4Edit.color := clWhite
  else Line4Edit.color := $00BBBBFF;
end;

procedure TSetupForm.Line3EditEnter(Sender: TObject);
begin
  GameServerEdit.text := config.gameServer[ScreenSpinEdit.Value, 3];
  setupbutton := 3;
  Line3Edit.color := $00A1D7A4;
  if Line2Edit.enabled= true then Line2Edit.color := clWhite
  else Line2Edit.color := $00BBBBFF;
  if Line1Edit.enabled= true then Line1Edit.color := clWhite
  else Line1Edit.color := $00BBBBFF;
  if Line4Edit.enabled= true then Line4Edit.color := clWhite
  else Line4Edit.color := $00BBBBFF;
end;

procedure TSetupForm.Line4EditEnter(Sender: TObject);
begin
  GameServerEdit.text := config.gameServer[ScreenSpinEdit.Value, 4];
  setupbutton := 4;
  Line4Edit.color := $00A1D7A4;
  if Line2Edit.enabled= true then Line2Edit.color := clWhite
  else Line2Edit.color := $00BBBBFF;
  if Line3Edit.enabled= true then Line3Edit.color := clWhite
  else Line3Edit.color := $00BBBBFF;
  if Line1Edit.enabled= true then Line1Edit.color := clWhite
  else Line1Edit.color := $00BBBBFF;
end;

procedure TSetupForm.NetworkStatsListBoxClick(Sender: TObject);
var
  NetStat : TNetworkStatistics;
begin
  NetStat := TNetworkStatistics(NetworkStatsListBox.itemindex);
  if (NetStat >= FirstNetworkStat) and (NetStat <= LastNetworkStat) then begin
    VariableEdit.Text := NetworkStatisticsKeys[NetStat];
    if not (NetStat = nsNetIPAddress) then  // special case, should be resolved elsewhere
      VariableEdit.Text := VariableEdit.Text + '(1)';
  end else
    VariableEdit.Text := NoVariable;

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.FoldingAtHomeListBoxClick(Sender: TObject);
begin
  case FoldingAtHomeListBox.itemindex of
    0 : VariableEdit.Text := '$FOLDwu';
    1 : VariableEdit.Text := '$FOLDlastwu';
    2 : VariableEdit.Text := '$FOLDactproc';
    3 : VariableEdit.Text := '$FOLDteam';
    4 : VariableEdit.Text := '$FOLDscore';
    5 : VariableEdit.Text := '$FOLDrank';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;


// Apply pressed.
procedure TSetupForm.ApplyButtonClick(Sender: TObject);
var
  relood: Boolean;
  x: Integer;
  iMaxUsedRow: Integer;
begin
  relood := false;
  iMaxUsedRow := -1;
  for x := 0 to ActionsStringGrid.RowCount-1 do
  begin
    if (ActionsStringGrid.cells[0, x] <> '') and (ActionsStringGrid.cells[4,
      x] <> '') then
    begin
        iMaxUsedRow := x;
        config.actionsArray[x + 1, 1] := ActionsStringGrid.Cells[0, x];

        if ActionsStringGrid.Cells[1, x]='>' then
           config.actionsArray[x + 1, 2] := '0';
        if ActionsStringGrid.Cells[1, x]='<' then
           config.actionsArray[x + 1, 2] := '1';
        if ActionsStringGrid.Cells[1, x]='=' then
           config.actionsArray[x + 1, 2] := '2';
        if ActionsStringGrid.Cells[1, x]='<=' then
           config.actionsArray[x + 1, 2] := '3';
        if ActionsStringGrid.Cells[1, x]='>=' then
           config.actionsArray[x + 1, 2] := '4';
        if ActionsStringGrid.Cells[1, x]='<>' then
           config.actionsArray[x + 1, 2] := '5';

        config.actionsArray[x + 1, 3] := ActionsStringGrid.Cells[2, x];
        config.actionsArray[x + 1, 4] := ActionsStringGrid.Cells[4, x];
    end;
  end;
  config.totalactions := iMaxUsedRow + 1;

  // Check if Com settings have changed.
  if (config.DisplayDLLParameters <> ParametersEdit.Text) then relood := true;
  if (config.DisplayDLLName <> DisplayPluginList.Text) then relood := true;

  LCDSmartieDisplayForm.WinampCtrl1.WinampLocation := WinampLocationEdit.text;
  config.winampLocation := WinampLocationEdit.text;
  config.refreshRate := ProgramRefreshIntervalSpinEdit.Value;
  config.setiEmail := SetiAtHomeEmailEdit.text;

  config.ScreenSize := LCDSizeComboBox.itemindex + 1;
  config.randomScreens := RandomizeScreensCheckBox.checked;
  config.newsRefresh := InternetRefreshTimeSpinEdit.Value;
  config.foldUsername := FoldingAtHomeEmailEdit.text;
  config.gameRefresh := GamestatsRefreshTimeSpinEdit.Value;
  config.checkUpdates := LCDSmartieUpdateCheckBox.checked;
  config.mbmRefresh := MBMRefreshTimeSpinEdit.Value;
  config.colorOption := ColorSchemeComboBox.itemindex;
  config.distLog := DistributedNetLogfileEdit.text;
  config.dllPeriod := DLLCheckIntervalSpinEdit.value;
  config.emailPeriod := EmailCheckTimeSpinEdit.Value;
  config.scrollPeriod := ProgramScrollIntervalSpinEdit.value;
  config.alwaysOnTop := StayOnTopCheckBox.checked;
  config.bHideOnStartup := HideOnStartup.Checked;
  config.bAutoStart := AutoStart.checked;
  config.bAutoStartHide := AutoStartHide.checked;
  config.EmulateLCD := EmulateLCDCheckbox.Checked;

  config.DLL_contrast := ContrastTrackBar.position;
  config.DLL_brightness := BrightnessTrackBar.position;
  config.DisplayDLLParameters := ParametersEdit.Text;
  config.DisplayDLLName := DisplayPluginList.Text;
  if (config.DisplayDLLName = 'None') then
    config.DisplayDLLName := '';

  LCDSmartieDisplayForm.SetupAutoStart();

  // Check if Com settings have changed.
  config.pop[(EmailAccountComboBox.itemindex + 1) mod MaxEmailAccounts].server := EmailServerEdit.text;
  config.pop[(EmailAccountComboBox.itemindex + 1) mod MaxEmailAccounts].user := EmailLoginEdit.text;
  config.pop[(EmailAccountComboBox.itemindex + 1) mod MaxEmailAccounts].pword := EmailPasswordEdit.text;
  config.pop[(EmailAccountComboBox.itemindex + 1) mod MaxEmailAccounts].port_ssl := EmailSSLEdit.text;


  if (WebProxyPortEdit.text = '') then WebProxyPortEdit.text := '0';
  config.httpProxy := WebProxyServerEdit.text;
  config.httpProxyPort := StrToInt(WebProxyPortEdit.text);

  SaveScreen(ScreenSpinEdit.Value);
  LCDSmartieDisplayForm.ScrollFlashTimer.interval := config.scrollPeriod;
  LCDSmartieDisplayForm.Data.RefreshDataThreads;

  config.save();

  if relood = true then
  begin
    LCDSmartieDisplayForm.ReInitLCD();
  end;

  LCDSmartieDisplayForm.ShowTrueLCD := Config.EmulateLCD;
end;

// ok has been pressed.
procedure TSetupForm.OKButtonClick(Sender: TObject);
begin
  ApplyButtonClick(Sender);
end;

procedure TSetupForm.FormCreate(Sender: TObject);
var pathssl :string;
    RG      :Tregistry;
begin
  pathssl := ExtractFilePath(ParamStr(0));
  ActionsStringGrid.RowCount := 0;
  ActionsStringGrid.ColWidths[0] := 116;
  ActionsStringGrid.ColWidths[1] := 20;
  ActionsStringGrid.ColWidths[2] := 56;
  ActionsStringGrid.ColWidths[3] := 36;
  ActionsStringGrid.ColWidths[4] := 156;
 // check if ssl dll exists , if not block the ssl edit !!!
  if not fileExists(pathssl+'libeay32.dll') or
     not fileExists(pathssl+'ssleay32.dll') then EmailSSLEdit.Enabled :=False ;

  //point ListBox to the plugin dirs
  PluginListBox.Directory := pathssl+'plugins\';

  //.net check (if installed
  RG := Tregistry.Create;
  RG.RootKey := HKEY_LOCAL_MACHINE;
  if RG.OpenKey('SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.0.3705\', FALSE)
  then begin
  if RG.ReadInteger('install') = 1 then pluginDotNetVer.Caption:='v1.0.3705';
  end else
  begin

  if RG.OpenKey('SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322\', FALSE)
  then begin
  if RG.ReadInteger('install') = 1 then pluginDotNetVer.Caption:='v1.1.4322';
  end else
  begin

  if RG.OpenKey('SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\', FALSE)
  then begin
  if RG.ReadInteger('install') = 1 then pluginDotNetVer.Caption:='v2.0.50727';
  end else pluginDotNetVer.Caption:='none';

  end;
  end;

  RG.CloseKey;
  RG.Destroy;

end;

procedure TSetupForm.OutputListBoxClick(Sender: TObject);
begin
  case OutputListBox.itemindex of
    0 : StatementEdit.Text := 'NextTheme';
    1 : StatementEdit.Text := 'LastTheme';
    2 : StatementEdit.Text := 'NextScreen';
    3 : StatementEdit.Text := 'LastScreen';
    4 : StatementEdit.Text := 'GotoTheme(2)';
    5 : StatementEdit.Text := 'GotoScreen(2)';
    6 : StatementEdit.Text := 'FreezeScreen';
    7 : StatementEdit.Text := 'RefreshAll';
    8 : StatementEdit.Text := 'Backlight(1)';
    9 : StatementEdit.Text := 'BacklightToggle';
    10 : StatementEdit.Text := 'BLFlash(5)';
    11 : StatementEdit.Text := 'Wave[c:\wave.wav]';
    12 : StatementEdit.Text := 'Exec[c:\autoexec.bat]';
    13 : StatementEdit.Text := 'WANextTrack';
    14 : StatementEdit.Text := 'WALastTrack';
    15 : StatementEdit.Text := 'WAPlay';
    16 : StatementEdit.Text := 'WAStop';
    17 : StatementEdit.Text := 'WAPause';
    18 : StatementEdit.Text := 'WAShuffle';
    19 : StatementEdit.Text := 'WAVolDown';
    20 : StatementEdit.Text := 'WAVolUp';
    21 : StatementEdit.Text := 'EnableScreen(1)';
    22 : StatementEdit.Text := 'DisableScreen(1)';
    23 : StatementEdit.Text := '$dll(name.dll,2,param1,param2)';
    24 : StatementEdit.Text := 'GPO(4,1)';
    25 : StatementEdit.Text := 'GPOToggle(4)';
    26 : StatementEdit.Text := 'GPOFlash(4,5)';
    27 : StatementEdit.Text := 'Fan(1,255)';
  end; // case
end;

procedure TSetupForm.MainPageControlChange(Sender: TObject);
begin
  if MainPageControl.ActivePage = ActionsTabSheet then
  begin
    setupbutton := 5;
    OperatorComboBox.ItemIndex := 0;

    while (OutputListBox.Items.Count > 24) do
      OutputListBox.Items.Delete(24);

    OutputListBox.Items.Add('GPO(4-8,0/1) (0=off 1=on)');
    OutputListBox.Items.Add('GPOToggle(4-8)');
    OutputListBox.Items.Add('GPOFlash(4-8,2) (nr. of times)');
    OutputListBox.Items.Add('Fan(1-3,0-255) (0-255=speed)');
  end;
  if MainPageControl.ActivePage = ScreensTabSheet then
  begin
    if LeftPageControl.activepage = LCDFeaturesTabSheet then
    begin
      if pos('$MObutton', VariableEdit.text) <> 0 then VariableEdit.text := NoVariable;
      LeftPageControl.ActivePage := WinampTabSheet;
    end;
    GameServerEdit.text := config.gameServer[ScreenSpinEdit.Value, 1];
    setupbutton := 1;
    Line1Edit.color := $00A1D7A4;
    if Line2Edit.enabled= true then Line2Edit.color := clWhite
    else Line2Edit.color := $00BBBBFF;
    if Line3Edit.enabled= true then Line3Edit.color := clWhite
    else Line3Edit.color := $00BBBBFF;
    if Line4Edit.enabled= true then Line4Edit.color := clWhite
    else Line4Edit.color := $00BBBBFF;
  end;
end;

procedure TSetupForm.ActionAddButtonClick(Sender: TObject);
begin
  if (Operand1Edit.text <> '') and (OperatorComboBox.itemindex <> -1) then
  begin
    ActionsStringGrid.Cells[0, ActionsStringGrid.RowCount-1] := Operand1Edit.text;
    ActionsStringGrid.Cells[1, ActionsStringGrid.RowCount-1] :=
      OperatorComboBox.Items.Strings[OperatorComboBox.itemindex];
    ActionsStringGrid.Cells[2, ActionsStringGrid.RowCount-1] := Operand2Edit.text;
    ActionsStringGrid.Cells[3, ActionsStringGrid.RowCount-1] := 'then';
    ActionsStringGrid.Cells[4, ActionsStringGrid.RowCount-1] := StatementEdit.text;
    ActionsStringGrid.RowCount := ActionsStringGrid.RowCount + 1;
  end;
end;

procedure TSetupForm.ActionDeleteButtonClick(Sender: TObject);
var
  counter, counter2, counter3: Integer;

begin
  counter2 :=
    ActionsStringGrid.Selection.Bottom-ActionsStringGrid.Selection.Top + 1;
  for counter := ActionsStringGrid.Selection.Top to
    ActionsStringGrid.Selection.Bottom do
    ActionsStringGrid.Rows[counter].clear;
  for counter3 := 1 to counter2 do
  begin
    for counter := ActionsStringGrid.Selection.Top to
      ActionsStringGrid.RowCount do
    begin
      ActionsStringGrid.Cells[0, counter] := ActionsStringGrid.Cells[0, counter
        + 1];
      ActionsStringGrid.Cells[1, counter] := ActionsStringGrid.Cells[1, counter
        + 1];
      ActionsStringGrid.Cells[2, counter] := ActionsStringGrid.Cells[2, counter
        + 1];
      ActionsStringGrid.Cells[3, counter] := ActionsStringGrid.Cells[3, counter
        + 1];
      ActionsStringGrid.Cells[4, counter] := ActionsStringGrid.Cells[4, counter
        + 1];
    end;
  end;
  ActionsStringGrid.rowcount := ActionsStringGrid.rowcount-counter2;
end;

procedure TSetupForm.ButtonsListBoxClick(Sender: TObject);
begin
  case ButtonsListBox.itemindex of
    0 : VariableEdit.Text := '$MObutton';
    1 : VariableEdit.Text := '$FanSpeed(1,1)';
    2 : VariableEdit.Text := '$Sensor1';
    3 : VariableEdit.Text := '$Sensor2';
    4 : VariableEdit.Text := '$Sensor3';
    5 : VariableEdit.Text := '$Sensor4';
    6 : VariableEdit.Text := '$Sensor5';
    7 : VariableEdit.Text := '$Sensor6';
    8 : VariableEdit.Text := '$Sensor7';
    9 : VariableEdit.Text := '$Sensor8';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.TransitionButtonClick(Sender: TObject);
var
  Style : TTransitionStyle;
  Time : byte;
  Loop : byte;
begin
  Style := config.screen[CurrentScreen][1].TransitionStyle;
  Time := config.screen[CurrentScreen][1].TransitionTime;
  if DoTransitionConfigForm(Style,Time) then begin
    for Loop := 1 to MaxLines do begin
      config.screen[CurrentScreen][Loop].TransitionStyle := Style;
      config.screen[CurrentScreen][Loop].TransitionTime := Time;
    end;
  end;
end;


procedure TSetupForm.Line1EditKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = VK_UP then
  begin
    // select bottom row
    if (Line4Edit.Enabled) and (Line4Edit.Visible) then Line4Edit.SetFocus
    else if (Line3Edit.Enabled) and (Line3Edit.Visible) then Line3Edit.SetFocus
    else if (Line2Edit.Enabled) and (Line2Edit.Visible) then Line2Edit.SetFocus;
  end
  else if ord(key) = VK_DOWN then
  begin
    // Select next row if used.
    if (Line2Edit.Enabled) and (Line2Edit.Visible) then Line2Edit.SetFocus;
  end;
end;

procedure TSetupForm.Line2EditKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = VK_UP then Line1Edit.SetFocus
  else if ord(key) = VK_DOWN then
  begin
    // Select next row if used otherwise go to top.
    if (Line3Edit.Enabled) and (Line3Edit.Visible) then Line3Edit.SetFocus
    else Line1Edit.SetFocus;
  end;
end;

procedure TSetupForm.Line3EditKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = VK_UP then Line2Edit.SetFocus
  else if ord(key) = VK_DOWN then
  begin
    // Select next row if used otherwise go to top.
    if (Line4Edit.Enabled) and (Line4Edit.Visible) then Line4Edit.SetFocus
    else Line1Edit.SetFocus;
  end;
end;

procedure TSetupForm.Line4EditKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = VK_UP then Line3Edit.SetFocus;
  if ord(key) = VK_DOWN then Line1Edit.SetFocus;
end;

procedure TSetupForm.StickyCheckboxClick(Sender: TObject);
begin
  TimeToShowSpinEdit.enabled := not StickyCheckbox.checked;
end;

procedure TSetupForm.ActionsStringGridClick(Sender: TObject);
var
  selected: Integer;
begin

  selected := ActionsStringGrid.Selection.Top;

  Operand1Edit.text := ActionsStringGrid.Cells[0, selected];

  if ActionsStringGrid.Cells[1, selected]='>' then
    OperatorComboBox.itemindex := 0
  else if ActionsStringGrid.Cells[1, selected]='<' then
    OperatorComboBox.itemindex := 1
  else if ActionsStringGrid.Cells[1, selected]='=' then
    OperatorComboBox.itemindex := 2
  else if ActionsStringGrid.Cells[1, selected]='<=' then
    OperatorComboBox.itemindex := 3
  else if ActionsStringGrid.Cells[1, selected]='>=' then
    OperatorComboBox.itemindex := 4
  else if ActionsStringGrid.Cells[1, selected]='<>' then
    OperatorComboBox.itemindex := 5;

  Operand2Edit.text := ActionsStringGrid.Cells[2, selected];
  StatementEdit.text := ActionsStringGrid.Cells[4, selected];
end;

procedure TSetupForm.SkipScreenComboBoxChange(Sender: TObject);
begin
  if (SkipScreenComboBox.ItemIndex < 0) then SkipScreenComboBox.ItemIndex := 0;
end;

procedure TSetupForm.OperatorComboBoxChange(Sender: TObject);
begin
  if OperatorComboBox.ItemIndex < 0 then OperatorComboBox.itemIndex := 0;
end;

procedure TSetupForm.ColorSchemeComboBoxChange(Sender: TObject);
begin
  if ColorSchemeComboBox.ItemIndex < 0 then ColorSchemeComboBox.ItemIndex := 0;
end;

procedure UpdateSetupForm(cKey : char);
begin
  if assigned(SetupForm) then
    SetupForm.LastKeyPressedEdit.text := cKey;
end;

function PerformingSetup : boolean;
begin
  Result := assigned(SetupForm);
end;

procedure TSetupForm.ContrastTrackBarChange(Sender: TObject);
begin
  LCDSmartieDisplayForm.lcd.setContrast(ContrastTrackBar.position);
end;

procedure TSetupForm.BrightnessTrackBarChange(Sender: TObject);
begin
  LCDSmartieDisplayForm.lcd.setBrightness(BrightnessTrackBar.position);
end;

procedure TSetupForm.Btn_PluginRefreshClick(Sender: TObject);
begin
PluginListBox.Refresh;
end;

procedure TSetupForm.PluginListBoxDblClick(Sender: TObject);
var plugin_name :string;
begin
plugin_name := Lowercase(ExtractFileName(PluginListBox.FileName));
plugin_name := copy(plugin_name,0,Length(plugin_name)-4)+'.txt';

if FileExists(ExtractFilePath(ParamStr(0))+'plugins\'+plugin_name)
then ShellExecute(0, Nil, pchar(plugin_name), Nil, Nil, SW_NORMAL)
else ShowMessage('IL file : '+plugin_name+' non esiste');
end;


procedure TSetupForm.PluginListBoxClick(Sender: TObject);
begin
if Lowercase(ExtractFileName(PluginListBox.FileName)) = 'escalate.dll'
then begin
PluginDotNetRequired.Caption := 'yes';
if pluginDotNetVer.Caption = 'none' then ShowMessage('.NET Framework is required')
end;

if Lowercase(ExtractFileName(PluginListBox.FileName)) = 'nvtemp.dll'
then begin
PluginDotNetRequired.Caption := 'yes';
if pluginDotNetVer.Caption = 'none' then ShowMessage('.NET Framework is required')
end;

if Lowercase(ExtractFileName(PLuginListBox.FileName)) = 'sandr.dll'
then begin
PluginDotNetRequired.Caption := 'yes';
if pluginDotNetVer.Caption = 'none' then ShowMessage('.NET Framework is required')
end;

if Lowercase(ExtractFileName(PluginListBox.FileName)) = 'mem.dll'
then begin
VariableEdit.Text := '$dll(mem.dll,1,0,0)';
exit;
end else VariableEdit.text := 'Variable: ';

if Lowercase(ExtractFileName(PluginListBox.FileName)) = 'nvtemp.dll'
then begin
VariableEdit.Text := '$dll(nvtemp.dll,1,0,1)';
exit;
end else VariableEdit.text := 'Variable: ';

if Lowercase(ExtractFileName(PluginListBox.FileName)) = 'wanip.dll'
then begin
VariableEdit.Text := '$dll(wanip.dll,1,0,0)';
exit;
end else VariableEdit.text := 'Variable: ';

if (Lowercase(ExtractFileName(PluginListBox.FileName)) <> 'escalate.dll') and
   (Lowercase(ExtractFileName(PluginListBox.FileName)) <> 'sandr.dll')    and
   (Lowercase(ExtractFileName(PluginListBox.FileName)) <> 'nvtemp.dll')
then PluginDotNetRequired.Caption := 'no';
end;

end.



