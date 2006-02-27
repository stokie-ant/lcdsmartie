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
 *  $Revision: 1.37 $ $Date: 2006/02/27 22:10:51 $
 *****************************************************************************}

interface

uses Dialogs, Grids, StdCtrls, Controls, Spin, Buttons, ComCtrls, Classes,
  Forms;

const
  USBPALM = 'USB Palm';


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
    SpeedButton2: TSpeedButton;
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
    LCDSettingsGroupBox: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    HD44780RadioButton: TRadioButton;
    MatrixOrbitalRadioButton: TRadioButton;
    COMPortComboBox: TComboBox;
    BaudRateComboBox: TComboBox;
    MatrixOrbitalConfigButton: TButton;
    CrystalFontzRadioButton: TRadioButton;
    CrystalFontzConfigButton: TButton;
    HD44780ConfigButton: TButton;
    ScreenNumberComboBox: TComboBox;
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
    InteractionsButton: TButton;
    Label58: TLabel;
    DLLCheckIntervalSpinEdit: TSpinEdit;
    ProgramScrollIntervalSpinEdit: TSpinEdit;
    Label59: TLabel;
    HD66712RadioButton: TRadioButton;
    Label28: TLabel;
    StickyCheckbox: TCheckBox;
    StartupTabSheet: TTabSheet;
    GroupBox7: TGroupBox;
    NoAutoStart: TRadioButton;
    AutoStart: TRadioButton;
    AutoStartHide: TRadioButton;
    GroupBox8: TGroupBox;
    HideOnStartup: TCheckBox;
    Label2: TLabel;
    ColorSchemeComboBox: TComboBox;
    LCDSizeComboBox: TComboBox;
    SkipScreenComboBox: TComboBox;
    IRTransRadioButton: TRadioButton;
    IRTransConfigButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure LCDSizeComboBoxChange(Sender: TObject);
    procedure ScreenNumberComboBoxChange(Sender: TObject);
    procedure HD44780RadioButtonClick(Sender: TObject);
    procedure MatrixOrbitalRadioButtonClick(Sender: TObject);
    procedure WinampListBoxClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure SysInfoListBoxClick(Sender: TObject);
    procedure MBMListBoxClick(Sender: TObject);
    procedure InternetListBoxClick(Sender: TObject);
    procedure GameTypeComboBoxChange(Sender: TObject);
    procedure QStatLabelClick(Sender: TObject);
    procedure MiscListBoxClick(Sender: TObject);
    procedure LeftPageControlChange(Sender: TObject);
    procedure GameServerEditExit(Sender: TObject);
    procedure MatrixOrbitalConfigButtonClick(Sender: TObject);
    procedure CrystalFontzRadioButtonClick(Sender: TObject);
    procedure SetiAtHomeListBoxClick(Sender: TObject);
    procedure DistributedNetBrowseButtonClick(Sender: TObject);
    procedure EmailListBoxClick(Sender: TObject);
    procedure EmailAccountComboBoxChange(Sender: TObject);
    procedure ContinueLine1CheckBoxClick(Sender: TObject);
    procedure ContinueLine2CheckBoxClick(Sender: TObject);
    procedure ContinueLine3CheckBoxClick(Sender: TObject);
    procedure WinampLocationBrowseButtonClick(Sender: TObject);
    procedure CrystalFontzConfigButtonClick(Sender: TObject);
    procedure GamestatsListBoxClick(Sender: TObject);
    procedure Line1EditEnter(Sender: TObject);
    procedure Line2EditEnter(Sender: TObject);
    procedure Line3EditEnter(Sender: TObject);
    procedure Line4EditEnter(Sender: TObject);
    procedure NetworkStatsListBoxClick(Sender: TObject);
    procedure HD44780ConfigButtonClick(Sender: TObject);
    procedure FoldingAtHomeListBoxClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OutputListBoxClick(Sender: TObject);
    procedure MainPageControlChange(Sender: TObject);
    procedure ActionAddButtonClick(Sender: TObject);
    procedure ActionDeleteButtonClick(Sender: TObject);
    procedure ButtonsListBoxClick(Sender: TObject);
    procedure InteractionsButtonClick(Sender: TObject);
    procedure HD66712RadioButtonClick(Sender: TObject);
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
    procedure COMPortComboBoxChange(Sender: TObject);
    procedure BaudRateComboBoxChange(Sender: TObject);
    procedure ColorSchemeComboBoxChange(Sender: TObject);
    procedure IRTransRadioButtonClick(Sender: TObject);
    procedure IRTransConfigButtonClick(Sender: TObject);
  private
    setupbutton: Integer;
    EMailAccountComboboxTemp: Integer;
    tempscreen: Integer;
    Procedure FocusToInputField;
    procedure SaveScreen(scr: Integer);
    procedure LoadScreen(scr: Integer);
  end;

function DoSetupForm : boolean;
procedure UpdateSetupForm(cKey : char);
function PerformingSetup : boolean;

implementation

uses Windows, ShellApi, graphics, sysutils, UMain, UMOSetup,
  UCFSetup, UPara, UIRSetup, UInteract, UConfig, ULCD_MO, StrUtils;

{$R *.DFM}

var
  SetupForm : TSetupForm = nil;

function DoSetupForm : boolean;
begin
  SetupForm := TSetupForm.Create(nil);
  with SetupForm do begin
    ShowModal;
    Result := (ModalResult = mrOK);
    LCDSmartieDisplayForm.HTTPUpdateTimer.interval := 500;
    LCDSmartieDisplayForm.NextScreenTimer.interval := 0;
    if (not config.screen[activeScreen][1].bSticky) then
      LCDSmartieDisplayForm.NextScreenTimer.interval := config.screen[activeScreen][1].showTime*1000;
    Free;
  end;
  SetupForm := nil;
end;

procedure TSetupForm.FormShow(Sender: TObject);
var
  i, blaat: Integer;
  iSelection: Integer;
  sLookFor: String;
  uiTestPort: Cardinal;
begin
  { Try to limit the displayed COM port to only those that are useable }

  // Delete all entries in the Com Port list
  for i:= COMPortComboBox.Items.Count-1 downto 0 do
    COMPortComboBox.Items.Delete(i);

  // Check for COM Ports 1-20.
  for i:=1 to 20 do
  begin
      uiTestPort := CreateFile (PChar('\\.\COM'+IntToStr(i)),
                      GENERIC_READ or GENERIC_WRITE,
                      FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                      OPEN_EXISTING, 0, 0);
      if (uiTestPort <> INVALID_HANDLE_VALUE) then
      begin
        // Port successfully opened - add to list.
        COMPortComboBox.Items.Add('COM'+IntToStr(i));
        CloseHandle(uiTestPort);
      end
      else if (GetLastError <> ERROR_FILE_NOT_FOUND)
        and (GetLastError <> ERROR_PATH_NOT_FOUND) then
      begin
	// Add them to the list - its better to have too many than not enough.
        // This case is also used when the port is already used by smartie.
        COMPortComboBox.Items.Add('COM'+IntToStr(i));
      end;
  end;
  COMPortComboBox.Items.Add(USBPALM);

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

  ScreenNumberComboBox.itemindex := 0;
  tempscreen := 0;
  LoadScreen( 1 );   // setup screen in setup form
  LCDSmartieDisplayForm.ChangeScreen(1);   // setup screen in main form

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

  WebProxyServerEdit.text := config.httpProxy;
  WebProxyPortEdit.text := IntToStr(config.httpProxyPort);
  EmailAccountComboBox.itemindex := 0;
  EmailServerEdit.text := config.pop[1].server;
  EmailLoginEdit.text := config.pop[1].user;
  EmailPasswordEdit.text := config.pop[1].pword;

  MatrixOrbitalConfigButton.enabled := false;
  CrystalFontzConfigButton.enabled := false;
  HD44780ConfigButton.enabled := false;
  IRTransConfigButton.Enabled := false;
  BaudRateComboBox.enabled := false;
  COMPortComboBox.enabled := false;

  if (config.isHD) or (config.isHD2) then
  begin
    HD44780RadioButton.checked := true;
    HD44780ConfigButton.enabled := true;
  end;
  if config.isMO then
  begin
    MatrixOrbitalRadioButton.checked := true;
    MatrixOrbitalConfigButton.enabled := true;

    COMPortComboBox.enabled := true;
    BaudRateComboBox.enabled := true;
  end;
  if config.isCF then
  begin
    CrystalFontzRadioButton.checked := true;
    CrystalFontzConfigButton.enabled := true;

    COMPortComboBox.enabled := true;
    BaudRateComboBox.enabled := true;
  end;

  if config.isIR then
  begin
    IRTransRadioButton.Checked := true;
    IRTransConfigButton.Enabled := true;
  end;

  if config.isIR then
  begin
    IRTransRadioButton.Checked := true;
    IRTransConfigButton.Enabled := true;
  end;

  // Set up the com port selection
  if (config.isUsbPalm) then slookFor := USBPALM
  else sLookFor := 'COM'+IntToStr(config.comPort);

  iSelection := -1;
  for i := 0 to COMPortComboBox.Items.Count-1 do
  begin
    if (sLookFor = COMPortComboBox.Items[i]) then
      iSelection := i;
  end;

  if (iSelection = -1) then
  begin
    showmessage(sLookFor + ' is no longer a valid COM Port option, please reselect.');
    iSelection := 0;
  end;

  COMPortComboBox.ItemIndex := iSelection;

  BaudRateComboBox.ItemIndex := config.baudrate;
  LCDSizeComboBox.itemindex := config.sizeOption-1;

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

  InternetRefreshTimeSpinEdit.Value := config.newsRefresh;
  RandomizeScreensCheckBox.checked := config.randomScreens;
  GamestatsRefreshTimeSpinEdit.Value := config.gameRefresh;
  FoldingAtHomeEmailEdit.text := config.foldUsername;
  MBMRefreshTimeSpinEdit.Value := config.mbmRefresh;
  LCDSmartieUpdateCheckBox.checked := config.checkUpdates;



  for i := 1 to 24 do ButtonsListBox.Items.Delete(1);
  if (config.isMO) then
  begin
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

  for y := 1 to 4 do
  begin
    config.screen[scr][y].enabled := ScreenEnabledCheckBox.checked;
    config.screen[scr][y].skip := SkipScreenComboBox.itemindex;
    config.screen[scr][y].theme := ThemeNumberSpinEdit.value-1;
    config.screen[scr][y].interaction := GlobalInteractionStyle;
    config.screen[scr][y].interactionTime := GlobalInteractionTime;
    config.screen[scr][y].showTime := TimeToShowSpinEdit.value;
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
  GlobalInteractionStyle := ascreen.interaction;
  GlobalInteractionTime := ascreen.interactionTime;
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

procedure TSetupForm.ScreenNumberComboBoxChange(Sender: TObject);
begin
  SaveScreen(tempscreen + 1);

  if ScreenNumberComboBox.itemIndex < 0 then ScreenNumberComboBox.itemIndex := 0;
  tempscreen := ScreenNumberComboBox.itemindex;

  LoadScreen(tempscreen + 1);

  LCDSmartieDisplayForm.ChangeScreen(tempscreen + 1);
end;

procedure TSetupForm.HD44780RadioButtonClick(Sender: TObject);
begin
  //if pagecontrol1.ActivePage = LCDFeaturesTabSheet then pagecontrol1.ActivePage :=
  //  Tabsheet1;
  //LCDFeaturesTabSheet.Enabled := false;
  HD44780ConfigButton.enabled := true;
  COMPortComboBox.enabled := false;
  BaudRateComboBox.enabled := false;
  MatrixOrbitalConfigButton.enabled := false;
  CrystalFontzConfigButton.enabled := false;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.HD66712RadioButtonClick(Sender: TObject);
begin
  HD44780ConfigButton.enabled := true;
  COMPortComboBox.enabled := false;
  BaudRateComboBox.enabled := false;
  MatrixOrbitalConfigButton.enabled := false;
  CrystalFontzConfigButton.enabled := false;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.MatrixOrbitalRadioButtonClick(Sender: TObject);
begin
  //LCDFeaturesTabSheet.Enabled := true;
  HD44780ConfigButton.enabled := false;
  COMPortComboBox.enabled := true;
  BaudRateComboBox.enabled := true;
  MatrixOrbitalConfigButton.enabled := true;
  CrystalFontzConfigButton.enabled := false;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.CrystalFontzRadioButtonClick(Sender: TObject);
begin
  //if pagecontrol1.ActivePage = LCDFeaturesTabSheet then pagecontrol1.ActivePage :=
  //  Tabsheet1;
  //LCDFeaturesTabSheet.Enabled := false;
  HD44780ConfigButton.enabled := false;
  COMPortComboBox.enabled := true;
  BaudRateComboBox.enabled := true;
  MatrixOrbitalConfigButton.enabled := false;
  CrystalFontzConfigButton.enabled := true;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.IRTransRadioButtonClick(Sender: TObject);
begin
  COMPortComboBox.enabled := false;
  BaudRateComboBox.enabled := false;
  MatrixOrbitalConfigButton.enabled := false;
  CrystalFontzConfigButton.enabled := false;
  HD44780ConfigButton.enabled := false;
  IRTransConfigButton.Enabled := true;
end;

procedure TSetupForm.WinampListBoxClick(Sender: TObject);
begin
  if WinampListBox.itemindex > -1 then
  begin
    if WinampListBox.itemindex = 0 then VariableEdit.Text := '$WinampTitle';
    if WinampListBox.itemindex = 1 then VariableEdit.Text := '$WinampChannels';
    if WinampListBox.itemindex = 2 then VariableEdit.Text := '$WinampKBPS';
    if WinampListBox.itemindex = 3 then VariableEdit.Text := '$WinampFreq';
    if WinampListBox.itemindex = 4 then VariableEdit.Text := '$Winamppos';
    if WinampListBox.itemindex = 5 then VariableEdit.Text := '$WinampPolo';
    if WinampListBox.itemindex = 6 then VariableEdit.Text := '$WinampPosh';
    if WinampListBox.itemindex = 7 then VariableEdit.Text := '$WinampRem';
    if WinampListBox.itemindex = 8 then VariableEdit.Text := '$WinampRelo';
    if WinampListBox.itemindex = 9 then VariableEdit.Text := '$WinampResh';
    if WinampListBox.itemindex = 10 then VariableEdit.Text := '$WinampLength';
    if WinampListBox.itemindex = 11 then VariableEdit.Text := '$WinampLengtl';
    if WinampListBox.itemindex = 12 then VariableEdit.Text := '$WinampLengts';
    if WinampListBox.itemindex = 13 then VariableEdit.Text := '$WinampPosition(10)';
    if WinampListBox.itemindex = 14 then VariableEdit.Text := '$WinampTracknr';
    if WinampListBox.itemindex = 15 then VariableEdit.Text := '$WinampTotalTracks';
    if WinampListBox.itemindex = 16 then VariableEdit.Text := '$WinampStat';

    FocusToInputField();
  end;
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
  if VariableEdit.Text <> 'Variable: ' then
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
  if SysInfoListBox.itemindex > -1 then
  begin
    if SysInfoListBox.itemindex = 0 then VariableEdit.Text := '$Username';
    if SysInfoListBox.itemindex = 1 then VariableEdit.Text := '$Computername';
    if SysInfoListBox.itemindex = 2 then VariableEdit.Text := '$CPUType';
    if SysInfoListBox.itemindex = 3 then VariableEdit.Text := '$CPUSpeed';
    if SysInfoListBox.itemindex = 4 then VariableEdit.Text := '$CPUUsage%';
    if SysInfoListBox.itemindex = 5 then VariableEdit.Text := '$Bar($CPUUsage%,100,10)';
    if SysInfoListBox.itemindex = 6 then VariableEdit.Text := '$MemFree';
    if SysInfoListBox.itemindex = 7 then VariableEdit.Text := '$MemUsed';
    if SysInfoListBox.itemindex = 8 then VariableEdit.Text := '$MemTotal';
    if SysInfoListBox.itemindex = 9 then VariableEdit.Text := '$MemF%';
    if SysInfoListBox.itemindex = 10 then VariableEdit.Text := '$MemU%';
    if SysInfoListBox.itemindex = 11 then VariableEdit.Text :=
      '$Bar($MemFree,$MemTotal,10)';
    if SysInfoListBox.itemindex = 12 then VariableEdit.Text :=
      '$Bar($MemUsed,$MemTotal,10)';
    if SysInfoListBox.itemindex = 13 then VariableEdit.Text := '$PageFree';
    if SysInfoListBox.itemindex = 14 then VariableEdit.Text := '$PageUsed';
    if SysInfoListBox.itemindex = 15 then VariableEdit.Text := '$PageTotal';
    if SysInfoListBox.itemindex = 16 then VariableEdit.Text := '$PageF%';
    if SysInfoListBox.itemindex = 17 then VariableEdit.Text := '$PageU%';
    if SysInfoListBox.itemindex = 18 then VariableEdit.Text :=
      '$Bar($PageFree,$PageTotal,10)';
    if SysInfoListBox.itemindex = 19 then VariableEdit.Text :=
      '$Bar($PageUsed,$PageTotal,10)';
    if SysInfoListBox.itemindex = 20 then VariableEdit.Text := '$HDFree(C)';
    if SysInfoListBox.itemindex = 21 then VariableEdit.Text := '$HDUsed(C)';
    if SysInfoListBox.itemindex = 22 then VariableEdit.Text := '$HDTotal(C)';
    if SysInfoListBox.itemindex = 23 then VariableEdit.Text := '$HDFreg(C)';
    if SysInfoListBox.itemindex = 24 then VariableEdit.Text := '$HDUseg(C)';
    if SysInfoListBox.itemindex = 25 then VariableEdit.Text := '$HDTotag(C)';
    if SysInfoListBox.itemindex = 26 then VariableEdit.Text := '$HDF%(C)';
    if SysInfoListBox.itemindex = 27 then VariableEdit.Text := '$HDU%(C)';
    if SysInfoListBox.itemindex = 28 then VariableEdit.Text :=
      '$Bar($HDFree(C),$HDTotal(C),10)';
    if SysInfoListBox.itemindex = 29 then VariableEdit.Text :=
      '$Bar($HDUsed(C),$HDTotal(C),10)';
    if SysInfoListBox.itemindex = 30 then VariableEdit.Text := '$ScreenReso';

    FocusToInputField();

  end;
end;

procedure TSetupForm.MBMListBoxClick(Sender: TObject);
begin
  if MBMListBox.itemindex > -1 then
  begin
    if MBMListBox.itemindex = 0 then VariableEdit.Text := '$Temp1';
    if MBMListBox.itemindex = 1 then VariableEdit.Text := '$Temp2';
    if MBMListBox.itemindex = 2 then VariableEdit.Text := '$Temp3';
    if MBMListBox.itemindex = 3 then VariableEdit.Text := '$Temp4';
    if MBMListBox.itemindex = 4 then VariableEdit.Text := '$Temp5';
    if MBMListBox.itemindex = 5 then VariableEdit.Text := '$Temp6';
    if MBMListBox.itemindex = 6 then VariableEdit.Text := '$Temp7';
    if MBMListBox.itemindex = 7 then VariableEdit.Text := '$Temp8';
    if MBMListBox.itemindex = 8 then VariableEdit.Text := '$Temp9';
    if MBMListBox.itemindex = 9 then VariableEdit.Text := '$Temp10';
    if MBMListBox.itemindex = 10 then VariableEdit.Text := '$FanS1';
    if MBMListBox.itemindex = 11 then VariableEdit.Text := '$FanS2';
    if MBMListBox.itemindex = 12 then VariableEdit.Text := '$FanS3';
    if MBMListBox.itemindex = 13 then VariableEdit.Text := '$FanS4';
    if MBMListBox.itemindex = 14 then VariableEdit.Text := '$FanS5';
    if MBMListBox.itemindex = 15 then VariableEdit.Text := '$FanS6';
    if MBMListBox.itemindex = 16 then VariableEdit.Text := '$FanS7';
    if MBMListBox.itemindex = 17 then VariableEdit.Text := '$FanS8';
    if MBMListBox.itemindex = 18 then VariableEdit.Text := '$FanS9';
    if MBMListBox.itemindex = 19 then VariableEdit.Text := '$FanS10';
    if MBMListBox.itemindex = 20 then VariableEdit.Text := '$Voltage1';
    if MBMListBox.itemindex = 21 then VariableEdit.Text := '$Voltage2';
    if MBMListBox.itemindex = 22 then VariableEdit.Text := '$Voltage3';
    if MBMListBox.itemindex = 23 then VariableEdit.Text := '$Voltage4';
    if MBMListBox.itemindex = 24 then VariableEdit.Text := '$Voltage5';
    if MBMListBox.itemindex = 25 then VariableEdit.Text := '$Voltage6';
    if MBMListBox.itemindex = 26 then VariableEdit.Text := '$Voltage7';
    if MBMListBox.itemindex = 27 then VariableEdit.Text := '$Voltage8';
    if MBMListBox.itemindex = 28 then VariableEdit.Text := '$Voltage9';
    if MBMListBox.itemindex = 29 then VariableEdit.Text := '$Voltage10';
    if MBMListBox.itemindex = 30 then VariableEdit.Text := '$Tempname1';
    if MBMListBox.itemindex = 31 then VariableEdit.Text := '$Tempname2';
    if MBMListBox.itemindex = 32 then VariableEdit.Text := '$Tempname3';
    if MBMListBox.itemindex = 33 then VariableEdit.Text := '$Tempname4';
    if MBMListBox.itemindex = 34 then VariableEdit.Text := '$Tempname5';
    if MBMListBox.itemindex = 35 then VariableEdit.Text := '$Tempname6';
    if MBMListBox.itemindex = 36 then VariableEdit.Text := '$Tempname7';
    if MBMListBox.itemindex = 37 then VariableEdit.Text := '$Tempname8';
    if MBMListBox.itemindex = 38 then VariableEdit.Text := '$Tempname9';
    if MBMListBox.itemindex = 39 then VariableEdit.Text := '$Tempname10';
    if MBMListBox.itemindex = 40 then VariableEdit.Text := '$Fanname1';
    if MBMListBox.itemindex = 41 then VariableEdit.Text := '$Fanname2';
    if MBMListBox.itemindex = 42 then VariableEdit.Text := '$Fanname3';
    if MBMListBox.itemindex = 43 then VariableEdit.Text := '$Fanname4';
    if MBMListBox.itemindex = 44 then VariableEdit.Text := '$Fanname5';
    if MBMListBox.itemindex = 45 then VariableEdit.Text := '$Fanname6';
    if MBMListBox.itemindex = 46 then VariableEdit.Text := '$Fanname7';
    if MBMListBox.itemindex = 47 then VariableEdit.Text := '$Fanname8';
    if MBMListBox.itemindex = 48 then VariableEdit.Text := '$Fanname9';
    if MBMListBox.itemindex = 49 then VariableEdit.Text := '$Fanname10';
    if MBMListBox.itemindex = 50 then VariableEdit.Text := '$Voltname1';
    if MBMListBox.itemindex = 51 then VariableEdit.Text := '$Voltname2';
    if MBMListBox.itemindex = 52 then VariableEdit.Text := '$Voltname3';
    if MBMListBox.itemindex = 53 then VariableEdit.Text := '$Voltname4';
    if MBMListBox.itemindex = 54 then VariableEdit.Text := '$Voltname5';
    if MBMListBox.itemindex = 55 then VariableEdit.Text := '$Voltname6';
    if MBMListBox.itemindex = 56 then VariableEdit.Text := '$Voltname7';
    if MBMListBox.itemindex = 57 then VariableEdit.Text := '$Voltname8';
    if MBMListBox.itemindex = 58 then VariableEdit.Text := '$Voltname9';
    if MBMListBox.itemindex = 59 then VariableEdit.Text := '$Voltname10';

    FocusToInputField();

  end;
end;

procedure TSetupForm.InternetListBoxClick(Sender: TObject);
begin
  if InternetListBox.itemindex > -1 then
  begin
    case InternetListBox.itemindex of
      0: VariableEdit.Text :=
   '$Rss(http://news.bbc.co.uk/rss/newsonline_uk_edition/world/rss091.xml,b)'
        ;
      1: VariableEdit.Text :=
      '$Rss(http://news.bbc.co.uk/rss/newsonline_uk_edition/uk/rss091.xml,b)'
        ;
      2: VariableEdit.Text := '$Rss(http://www.tweakers.net/feeds/mixed.xml,b)';
      3: VariableEdit.Text := '$Rss(http://www.theregister.co.uk/headlines.rss,b)';
      4: VariableEdit.Text := '$Rss(http://slashdot.org/index.rss,b)';
      5: VariableEdit.Text :=
        '$Rss(http://www.wired.com/news_drop/netcenter/netcenter.rdf,b)';
      6: VariableEdit.Text :=
        '$Rss(http://www.fool.com/xml/foolnews_rss091.xml,b,1)';
      7: VariableEdit.Text := '$Rss(http://www.fool.com/xml/foolnews_rss091.xml,b)';
      8: VariableEdit.Text :=
'$Rss(http://sourceforge.net/export/rss2_projnews.php?group_id=122330&rss_fulltext=1,b,1)'
        ;
      9: VariableEdit.Text :=
'$Rss(http://sourceforge.net/export/rss2_projnews.php?group_id=2987&rss_fulltext=1,b,1)'
        ;
      10: VariableEdit.Text :=
'$Rss(http://www.weatherclicks.com/xml/fort+lauderdale,t,2): $Rss(http://www.weatherclicks.com/xml/fort+lauderdale,d,2) | '
        ;
      11: VariableEdit.Text :=
'$Rss(http://news.bbc.co.uk/rss/newsonline_world_edition/business/rss091.xml,b)'
        ;
      12: VariableEdit.Text :=
'$Rss(http://www.washingtonpost.com/wp-srv/business/rssheadlines.xml,b)'
        ;
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
    end;

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

    FocusToInputField();


  end;
end;

procedure TSetupForm.GameTypeComboBoxChange(Sender: TObject);
begin
  if GamestatsListBox.Itemindex = 1 then
  begin
    if GameTypeComboBox.itemindex = 0 then VariableEdit.Text := '$Half-life2';
    if GameTypeComboBox.itemindex = 1 then VariableEdit.Text := '$QuakeII2';
    if GameTypeComboBox.itemindex = 2 then VariableEdit.Text := '$QuakeIII2';
    if GameTypeComboBox.itemindex = 3 then VariableEdit.Text := '$Unreal2';
  end
  else
  begin
    GamestatsListBox.ItemIndex := 0;
    if GameTypeComboBox.itemindex = 0 then VariableEdit.Text := '$Half-life1';
    if GameTypeComboBox.itemindex = 1 then VariableEdit.Text := '$QuakeII1';
    if GameTypeComboBox.itemindex = 2 then VariableEdit.Text := '$QuakeIII1';
    if GameTypeComboBox.itemindex = 3 then VariableEdit.Text := '$Unreal1';
  end;
end;

procedure TSetupForm.QStatLabelClick(Sender: TObject);
begin
  ShellExecute(0, Nil, pchar('www.qstat.org'), Nil, Nil, SW_NORMAL);
end;

procedure TSetupForm.MiscListBoxClick(Sender: TObject);
begin
  if MiscListBox.itemindex > -1 then
  begin
    if MiscListBox.itemindex = 0 then VariableEdit.Text := '$DnetSpeed';
    if MiscListBox.itemindex = 1 then VariableEdit.Text := '$DnetDone';
    if MiscListBox.itemindex = 2 then VariableEdit.Text :=
      '$Time(d mmmm yyyy hh: nn: ss)';
    if MiscListBox.itemindex = 3 then VariableEdit.Text := '$UpTime';
    if MiscListBox.itemindex = 4 then VariableEdit.Text := '$UpTims';
    if MiscListBox.itemindex = 5 then VariableEdit.Text := '°';
    if MiscListBox.itemindex = 6 then VariableEdit.Text := 'ž';
    if MiscListBox.itemindex = 7 then VariableEdit.Text := '$Chr(20)';
    if MiscListBox.itemindex = 8 then VariableEdit.Text := '$File(C:\file.txt,1)';
    if MiscListBox.itemindex = 9 then VariableEdit.Text := '$LogFile(C:\file.log,0)';
    if MiscListBox.itemindex = 10 then VariableEdit.Text :=
      '$dll(demo.dll,5,param1,param2)';
    if MiscListBox.itemindex = 11 then VariableEdit.Text := '$Count(101#$CPUSpeed#4)';
    if MiscListBox.itemindex = 12 then VariableEdit.Text := '$Bar(30,100,20)';
    if MiscListBox.itemindex = 13 then VariableEdit.Text :=
      '$Right(ins variable(s) here,$3%)';
    if MiscListBox.itemindex = 14 then VariableEdit.Text := '$Fill(10)';
    if MiscListBox.itemindex = 15 then VariableEdit.Text :=
      '$Flash(insert text here$)$';
    if MiscListBox.itemindex = 16 then VariableEdit.Text :=
      '$CustomChar(1, 31, 31, 31, 31, 31, 31, 31, 31)';
    if MiscListBox.itemindex = 17 then VariableEdit.Text :=
      '$Rss(URL,t|d|b,ITEM#,MAXFREQHRS)';
    if MiscListBox.ItemIndex = 18 then VariableEdit.Text := '$Center(text here,15)';
    if MiscListBox.ItemIndex = 19 then VariableEdit.Text := '$ScreenChanged';
    FocusToInputField();

  end;
end;

procedure TSetupForm.SetiAtHomeListBoxClick(Sender: TObject);
begin
  if SetiAtHomeListBox.itemindex > -1 then
  begin
    if SetiAtHomeListBox.itemindex = 0 then VariableEdit.Text := '$SETIResults';
    if SetiAtHomeListBox.itemindex = 1 then VariableEdit.Text := '$SETICPUTime';
    if SetiAtHomeListBox.itemindex = 2 then VariableEdit.Text := '$SETIAverage';
    if SetiAtHomeListBox.itemindex = 3 then VariableEdit.Text := '$SETILastresult';
    if SetiAtHomeListBox.itemindex = 4 then VariableEdit.Text := '$SETIusertime';
    if SetiAtHomeListBox.itemindex = 5 then VariableEdit.Text := '$SETItotalusers';
    if SetiAtHomeListBox.itemindex = 6 then VariableEdit.Text := '$SETIrank';
    if SetiAtHomeListBox.itemindex = 7 then VariableEdit.Text := '$SETIsharingrank';
    if SetiAtHomeListBox.itemindex = 8 then VariableEdit.Text := '$SETImoreWU%';

    FocusToInputField();
  end;
end;

procedure TSetupForm.LeftPageControlChange(Sender: TObject);
begin
  if LeftPageControl.ActivePage = WinampTabSheet then
  begin
    if WinampListBox.itemindex > -1 then
    begin
      if WinampListBox.itemindex = 0 then VariableEdit.Text := '$WinampTitle';
      if WinampListBox.itemindex = 1 then VariableEdit.Text := '$WinampChannels';
      if WinampListBox.itemindex = 2 then VariableEdit.Text := '$WinampKBPS';
      if WinampListBox.itemindex = 3 then VariableEdit.Text := '$WinampFreq';
      if WinampListBox.itemindex = 4 then VariableEdit.Text := '$Winamppos';
      if WinampListBox.itemindex = 5 then VariableEdit.Text := '$WinampPolo';
      if WinampListBox.itemindex = 6 then VariableEdit.Text := '$WinampPosh';
      if WinampListBox.itemindex = 7 then VariableEdit.Text := '$WinampRem';
      if WinampListBox.itemindex = 8 then VariableEdit.Text := '$WinampRelo';
      if WinampListBox.itemindex = 9 then VariableEdit.Text := '$WinampResh';
      if WinampListBox.itemindex = 10 then VariableEdit.Text := '$WinampLength';
      if WinampListBox.itemindex = 11 then VariableEdit.Text := '$WinampLengtl';
      if WinampListBox.itemindex = 12 then VariableEdit.Text := '$WinampLengts';
      if WinampListBox.itemindex = 13 then VariableEdit.Text := '$WinampPosition(10)';
      if WinampListBox.itemindex = 14 then VariableEdit.Text := '$WinampTracknr';
      if WinampListBox.itemindex = 15 then VariableEdit.Text := '$WinampTotalTracks';
      if WinampListBox.itemindex = 16 then VariableEdit.Text := '$WinampStat';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = SysInfoTabSheet then
  begin
    if SysInfoListBox.itemindex > -1 then
    begin
      if SysInfoListBox.itemindex = 0 then VariableEdit.Text := '$Username';
      if SysInfoListBox.itemindex = 1 then VariableEdit.Text := '$Computername';
      if SysInfoListBox.itemindex = 2 then VariableEdit.Text := '$CPUType';
      if SysInfoListBox.itemindex = 3 then VariableEdit.Text := '$CPUSpeed';
      if SysInfoListBox.itemindex = 4 then VariableEdit.Text := '$CPUUsage%';
      if SysInfoListBox.itemindex = 5 then VariableEdit.Text :=
        '$Bar($CPUUsage%,100,10)';
      if SysInfoListBox.itemindex = 6 then VariableEdit.Text := '$MemFree';
      if SysInfoListBox.itemindex = 7 then VariableEdit.Text := '$MemUsed';
      if SysInfoListBox.itemindex = 8 then VariableEdit.Text := '$MemTotal';
      if SysInfoListBox.itemindex = 9 then VariableEdit.Text := '$MemF%';
      if SysInfoListBox.itemindex = 10 then VariableEdit.Text := '$MemU%';
      if SysInfoListBox.itemindex = 11 then VariableEdit.Text :=
        '$Bar($MemFree,$MemTotal,10)';
      if SysInfoListBox.itemindex = 12 then VariableEdit.Text :=
        '$Bar($MemUsed,$MemTotal,10)';
      if SysInfoListBox.itemindex = 13 then VariableEdit.Text := '$PageFree';
      if SysInfoListBox.itemindex = 14 then VariableEdit.Text := '$PageUsed';
      if SysInfoListBox.itemindex = 15 then VariableEdit.Text := '$PageTotal';
      if SysInfoListBox.itemindex = 16 then VariableEdit.Text := '$PageF%';
      if SysInfoListBox.itemindex = 17 then VariableEdit.Text := '$PageU%';
      if SysInfoListBox.itemindex = 18 then VariableEdit.Text :=
        '$Bar($PageFree,$PageTotal,10)';
      if SysInfoListBox.itemindex = 19 then VariableEdit.Text :=
        '$Bar($PageUsed,$PageTotal,10)';
      if SysInfoListBox.itemindex = 20 then VariableEdit.Text := '$HDFree(C)';
      if SysInfoListBox.itemindex = 21 then VariableEdit.Text := '$HDUsed(C)';
      if SysInfoListBox.itemindex = 22 then VariableEdit.Text := '$HDTotal(C)';
      if SysInfoListBox.itemindex = 23 then VariableEdit.Text := '$HDFreg(C)';
      if SysInfoListBox.itemindex = 24 then VariableEdit.Text := '$HDUseg(C)';
      if SysInfoListBox.itemindex = 25 then VariableEdit.Text := '$HDTotag(C)';
      if SysInfoListBox.itemindex = 26 then VariableEdit.Text := '$HDF%(C)';
      if SysInfoListBox.itemindex = 27 then VariableEdit.Text := '$HDU%(C)';
      if SysInfoListBox.itemindex = 28 then VariableEdit.Text :=
        '$Bar($HDFree(C),$HDTotal(C),10)';
      if SysInfoListBox.itemindex = 29 then VariableEdit.Text :=
        '$Bar($HDUsed(C),$HDTotal(C),10)';
      if SysInfoListBox.itemindex = 30 then VariableEdit.Text := '$ScreenReso';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = MBMTabSheet then
  begin
    if MBMListBox.itemindex > -1 then
    begin
      if MBMListBox.itemindex = 0 then VariableEdit.Text := '$Temp1';
      if MBMListBox.itemindex = 1 then VariableEdit.Text := '$Temp2';
      if MBMListBox.itemindex = 2 then VariableEdit.Text := '$Temp3';
      if MBMListBox.itemindex = 3 then VariableEdit.Text := '$Temp4';
      if MBMListBox.itemindex = 4 then VariableEdit.Text := '$Temp5';
      if MBMListBox.itemindex = 5 then VariableEdit.Text := '$Temp6';
      if MBMListBox.itemindex = 6 then VariableEdit.Text := '$Temp7';
      if MBMListBox.itemindex = 7 then VariableEdit.Text := '$Temp8';
      if MBMListBox.itemindex = 8 then VariableEdit.Text := '$Temp9';
      if MBMListBox.itemindex = 9 then VariableEdit.Text := '$Temp10';
      if MBMListBox.itemindex = 10 then VariableEdit.Text := '$FanS1';
      if MBMListBox.itemindex = 11 then VariableEdit.Text := '$FanS2';
      if MBMListBox.itemindex = 12 then VariableEdit.Text := '$FanS3';
      if MBMListBox.itemindex = 13 then VariableEdit.Text := '$FanS4';
      if MBMListBox.itemindex = 14 then VariableEdit.Text := '$FanS5';
      if MBMListBox.itemindex = 15 then VariableEdit.Text := '$FanS6';
      if MBMListBox.itemindex = 16 then VariableEdit.Text := '$FanS7';
      if MBMListBox.itemindex = 17 then VariableEdit.Text := '$FanS8';
      if MBMListBox.itemindex = 18 then VariableEdit.Text := '$FanS9';
      if MBMListBox.itemindex = 19 then VariableEdit.Text := '$FanS10';
      if MBMListBox.itemindex = 20 then VariableEdit.Text := '$Voltage1';
      if MBMListBox.itemindex = 21 then VariableEdit.Text := '$Voltage2';
      if MBMListBox.itemindex = 22 then VariableEdit.Text := '$Voltage3';
      if MBMListBox.itemindex = 23 then VariableEdit.Text := '$Voltage4';
      if MBMListBox.itemindex = 24 then VariableEdit.Text := '$Voltage5';
      if MBMListBox.itemindex = 25 then VariableEdit.Text := '$Voltage6';
      if MBMListBox.itemindex = 26 then VariableEdit.Text := '$Voltage7';
      if MBMListBox.itemindex = 27 then VariableEdit.Text := '$Voltage8';
      if MBMListBox.itemindex = 28 then VariableEdit.Text := '$Voltage9';
      if MBMListBox.itemindex = 29 then VariableEdit.Text := '$Voltage10';
      if MBMListBox.itemindex = 30 then VariableEdit.Text := '$Tempname1';
      if MBMListBox.itemindex = 31 then VariableEdit.Text := '$Tempname2';
      if MBMListBox.itemindex = 32 then VariableEdit.Text := '$Tempname3';
      if MBMListBox.itemindex = 33 then VariableEdit.Text := '$Tempname4';
      if MBMListBox.itemindex = 34 then VariableEdit.Text := '$Tempname5';
      if MBMListBox.itemindex = 35 then VariableEdit.Text := '$Tempname6';
      if MBMListBox.itemindex = 36 then VariableEdit.Text := '$Tempname7';
      if MBMListBox.itemindex = 37 then VariableEdit.Text := '$Tempname8';
      if MBMListBox.itemindex = 38 then VariableEdit.Text := '$Tempname9';
      if MBMListBox.itemindex = 39 then VariableEdit.Text := '$Tempname10';
      if MBMListBox.itemindex = 40 then VariableEdit.Text := '$Fanname1';
      if MBMListBox.itemindex = 41 then VariableEdit.Text := '$Fanname2';
      if MBMListBox.itemindex = 42 then VariableEdit.Text := '$Fanname3';
      if MBMListBox.itemindex = 43 then VariableEdit.Text := '$Fanname4';
      if MBMListBox.itemindex = 44 then VariableEdit.Text := '$Fanname5';
      if MBMListBox.itemindex = 45 then VariableEdit.Text := '$Fanname6';
      if MBMListBox.itemindex = 46 then VariableEdit.Text := '$Fanname7';
      if MBMListBox.itemindex = 47 then VariableEdit.Text := '$Fanname8';
      if MBMListBox.itemindex = 48 then VariableEdit.Text := '$Fanname9';
      if MBMListBox.itemindex = 49 then VariableEdit.Text := '$Fanname10';
      if MBMListBox.itemindex = 50 then VariableEdit.Text := '$Voltname1';
      if MBMListBox.itemindex = 51 then VariableEdit.Text := '$Voltname2';
      if MBMListBox.itemindex = 52 then VariableEdit.Text := '$Voltname3';
      if MBMListBox.itemindex = 53 then VariableEdit.Text := '$Voltname4';
      if MBMListBox.itemindex = 54 then VariableEdit.Text := '$Voltname5';
      if MBMListBox.itemindex = 55 then VariableEdit.Text := '$Voltname6';
      if MBMListBox.itemindex = 56 then VariableEdit.Text := '$Voltname7';
      if MBMListBox.itemindex = 57 then VariableEdit.Text := '$Voltname8';
      if MBMListBox.itemindex = 58 then VariableEdit.Text := '$Voltname9';
      if MBMListBox.itemindex = 59 then VariableEdit.Text := '$Voltname10';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = LCDFeaturesTabSheet then
  begin
    //if MatrixOrbitalRadioButton.Checked = false then LeftPageControl.ActivePage := WinampTabSheet;
    if ButtonsListBox.itemindex > -1 then
    begin
      if ButtonsListBox.itemindex = 0 then VariableEdit.Text := '$MObutton';
      if ButtonsListBox.itemindex = 1 then VariableEdit.Text := '$FanSpeed(1,1)';
      if ButtonsListBox.itemindex = 2 then VariableEdit.Text := '$Sensor1';
      if ButtonsListBox.itemindex = 3 then VariableEdit.Text := '$Sensor2';
      if ButtonsListBox.itemindex = 4 then VariableEdit.Text := '$Sensor3';
      if ButtonsListBox.itemindex = 5 then VariableEdit.Text := '$Sensor4';
      if ButtonsListBox.itemindex = 6 then VariableEdit.Text := '$Sensor5';
      if ButtonsListBox.itemindex = 7 then VariableEdit.Text := '$Sensor6';
      if ButtonsListBox.itemindex = 8 then VariableEdit.Text := '$Sensor7';
      if ButtonsListBox.itemindex = 9 then VariableEdit.Text := '$Sensor8';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = GameStatsTabSheet then
  begin
    if GamestatsListBox.itemindex <= -1 then VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = InternetTabSheet then
  begin
    if InternetListBox.itemindex > -1 then
    begin
      if InternetListBox.itemindex = 0 then VariableEdit.Text := '$CNN';
      if InternetListBox.itemindex = 1 then VariableEdit.Text := '$Stocks';
      if InternetListBox.itemindex = 2 then VariableEdit.Text := '$TomsHW';
      if InternetListBox.itemindex = 3 then VariableEdit.Text := '$T.netHL';
      if InternetListBox.itemindex = 4 then VariableEdit.Text := '$DutchWeather';
      if InternetListBox.itemindex = 5 then VariableEdit.Text := '$Weather.com(CAXX0504)';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = MiscTabSheet then
  begin
    if MiscListBox.itemindex > -1 then
    begin
      if MiscListBox.itemindex = 0 then VariableEdit.Text := '$DnetSpeed';
      if MiscListBox.itemindex = 1 then VariableEdit.Text := '$DnetDone';
      if MiscListBox.itemindex = 2 then VariableEdit.Text :=
        '$Time(d mmmm yyyy hh: nn: ss)';
      if MiscListBox.itemindex = 3 then VariableEdit.Text := '$UpTime';
      if MiscListBox.itemindex = 4 then VariableEdit.Text := '$UpTims';
      if MiscListBox.itemindex = 5 then VariableEdit.Text := '°';
      if MiscListBox.itemindex = 6 then VariableEdit.Text := 'ž';
      if MiscListBox.itemindex = 7 then VariableEdit.Text := '$Chr(20)';
      if MiscListBox.itemindex = 8 then VariableEdit.Text := '$File(C:\file.txt,1)';
      if MiscListBox.itemindex = 9 then VariableEdit.Text :=
        '$LogFile("C:\file.log",0)';
      if MiscListBox.itemindex = 10 then VariableEdit.Text :=
        '$dll(demo.dll,5,param1,param2)';
      if MiscListBox.itemindex = 11 then VariableEdit.Text := '$Count(101#$CPUSpeed#4)';
      if MiscListBox.itemindex = 12 then VariableEdit.Text := '$Bar(30,100,20)';
      if MiscListBox.itemindex = 13 then VariableEdit.Text :=
        '$Right(ins variable(s) here,$3%)';
      if MiscListBox.itemindex = 14 then VariableEdit.Text := '$Fill(10)';
      if MiscListBox.itemindex = 15 then VariableEdit.Text :=
        '$Flash(insert text here$)$';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = SetiAtHomeTabSheet then
  begin
    if SetiAtHomeListBox.itemindex > -1 then
    begin
      if SetiAtHomeListBox.itemindex = 0 then VariableEdit.Text := '$SETIResults';
      if SetiAtHomeListBox.itemindex = 1 then VariableEdit.Text := '$SETICPUTime';
      if SetiAtHomeListBox.itemindex = 2 then VariableEdit.Text := '$SETIAverage';
      if SetiAtHomeListBox.itemindex = 3 then VariableEdit.Text := '$SETILastresult';
      if SetiAtHomeListBox.itemindex = 4 then VariableEdit.Text := '$SETIusertime';
      if SetiAtHomeListBox.itemindex = 5 then VariableEdit.Text := '$SETItotalusers';
      if SetiAtHomeListBox.itemindex = 6 then VariableEdit.Text := '$SETIrank';
      if SetiAtHomeListBox.itemindex = 7 then VariableEdit.Text := '$SETIsharingrank';
      if SetiAtHomeListBox.itemindex = 8 then VariableEdit.Text := '$SETImoreWU%';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = FoldingAtHomeTabSheet then
  begin
    if FoldingAtHomeListBox.itemindex > -1 then
    begin
      if FoldingAtHomeListBox.itemindex = 0 then VariableEdit.Text := '$FOLDmemsince';
      if FoldingAtHomeListBox.itemindex = 1 then VariableEdit.Text := '$FOLDlastwu';
      if FoldingAtHomeListBox.itemindex = 2 then VariableEdit.Text := '$FOLDactproc';
      if FoldingAtHomeListBox.itemindex = 3 then VariableEdit.Text := '$FOLDteam';
      if FoldingAtHomeListBox.itemindex = 4 then VariableEdit.Text := '$FOLDscore';
      if FoldingAtHomeListBox.itemindex = 5 then VariableEdit.Text := '$FOLDrank';
      if FoldingAtHomeListBox.itemindex = 6 then VariableEdit.Text := '$FOLDwu';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = EmailTabSheet then
  begin
    if EmailListBox.itemindex > -1 then
    begin
      if EmailListBox.itemindex = 0 then VariableEdit.Text := '$Email1';
      if EmailListBox.itemindex = 1 then VariableEdit.Text := '$Email2';
      if EmailListBox.itemindex = 2 then VariableEdit.Text := '$Email3';
      if EmailListBox.itemindex = 3 then VariableEdit.Text := '$Email4';
      if EmailListBox.itemindex = 4 then VariableEdit.Text := '$Email5';
      if EmailListBox.itemindex = 5 then VariableEdit.Text := '$Email6';
      if EmailListBox.itemindex = 6 then VariableEdit.Text := '$Email7';
      if EmailListBox.itemindex = 7 then VariableEdit.Text := '$Email8';
      if EmailListBox.itemindex = 8 then VariableEdit.Text := '$Email9';
      if EmailListBox.itemindex = 9 then VariableEdit.Text := '$Email0';
    end
    else VariableEdit.text := 'Variable: ';
  end;
  if LeftPageControl.ActivePage = NetworkStatsTabSheet then
  begin
    if NetworkStatsListBox.itemindex > -1 then
    begin
      if NetworkStatsListBox.itemindex = 0 then VariableEdit.Text := '$NetAdapter(1)';
      if NetworkStatsListBox.itemindex = 1 then VariableEdit.Text := '$NetDownK(1)';
      if NetworkStatsListBox.itemindex = 2 then VariableEdit.Text := '$NetUpK(1)';
      if NetworkStatsListBox.itemindex = 3 then VariableEdit.Text := '$NetDownM(1)';
      if NetworkStatsListBox.itemindex = 4 then VariableEdit.Text := '$NetUpM(1)';
      if NetworkStatsListBox.itemindex = 5 then VariableEdit.Text := '$NetDownG(1)';
      if NetworkStatsListBox.itemindex = 6 then VariableEdit.Text := '$NetUpG(1)';
      if NetworkStatsListBox.itemindex = 7 then VariableEdit.Text := '$NetSpDownK(1)';
      if NetworkStatsListBox.itemindex = 8 then VariableEdit.Text := '$NetSpUpK(1)';
      if NetworkStatsListBox.itemindex = 9 then VariableEdit.Text := '$NetSpDownM(1)';
      if NetworkStatsListBox.itemindex = 10 then VariableEdit.Text := '$NetSpUpM(1)';
      if NetworkStatsListBox.itemindex = 11 then VariableEdit.Text := '$NetErrDown(1)';
      if NetworkStatsListBox.itemindex = 12 then VariableEdit.Text := '$NetErrUp(1)';
      if NetworkStatsListBox.itemindex = 13 then VariableEdit.Text := '$NetErrTot(1)';
      if NetworkStatsListBox.itemindex = 14 then VariableEdit.Text := '$NetUniDown(1)';
      if NetworkStatsListBox.itemindex = 15 then VariableEdit.Text := '$NetUniUp(1)';
      if NetworkStatsListBox.itemindex = 16 then VariableEdit.Text := '$NetUniTot(1)';
      if NetworkStatsListBox.itemindex = 17 then VariableEdit.Text := '$NetNuniDown(1)';
      if NetworkStatsListBox.itemindex = 18 then VariableEdit.Text := '$NetNuniUp(1)';
      if NetworkStatsListBox.itemindex = 19 then VariableEdit.Text := '$NetNuniTot(1)';
      if NetworkStatsListBox.itemindex = 20 then VariableEdit.Text := '$NetPackTot(1)';
      if NetworkStatsListBox.itemindex = 21 then VariableEdit.Text := '$NetDiscDown(1)';
      if NetworkStatsListBox.itemindex = 22 then VariableEdit.Text := '$NetDiscUp(1)';
      if NetworkStatsListBox.itemindex = 23 then VariableEdit.Text := '$NetDiscTot(1)';
      if NetworkStatsListBox.itemindex = 24 then VariableEdit.Text := '$NetIPaddress';
    end
    else VariableEdit.text := 'Variable: ';
  end;
end;


procedure TSetupForm.GameServerEditExit(Sender: TObject);
begin
  if (ScreenNumberComboBox.itemIndex >= 0 ) and
     (setupbutton >= 0) and (setupbutton <= 4) then
  begin
    config.gameServer[ScreenNumberComboBox.itemindex + 1, setupbutton] := GameServerEdit.text;
  end;
end;

procedure TSetupForm.MatrixOrbitalConfigButtonClick(Sender: TObject);
begin
  if (not config.isMO) then
  begin
    if MessageDlg('The Matrix Orbital driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      ApplyButton.click();
    end;
  end;
  DoMatrixOrbitalSetupForm;
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
  if EmailListBox.itemindex > -1 then
  begin
    case EmailListBox.itemindex of
      0: VariableEdit.Text := '$Email1';
      1: VariableEdit.Text := '$EmailSub1';
      2: VariableEdit.Text := '$EmailFrom1';
      3: VariableEdit.Text := '$Email2';
      4: VariableEdit.Text := '$EmailSub2';
      5: VariableEdit.Text := '$EmailFrom2';
      6: VariableEdit.Text := '$Email3';
      7: VariableEdit.Text := '$EmailSub3';
      8: VariableEdit.Text := '$EmailFrom3';
      9: VariableEdit.Text := '$Email4';
      10: VariableEdit.Text := '$EmailSub4';
      11: VariableEdit.Text := '$EmailFrom4';
      12: VariableEdit.Text := '$Email5';
      13: VariableEdit.Text := '$EmailSub5';
      14: VariableEdit.Text := '$EmailFrom5';
      15: VariableEdit.Text := '$Email6';
      16: VariableEdit.Text := '$EmailSub6';
      17: VariableEdit.Text := '$EmailFrom6';
      18: VariableEdit.Text := '$Email7';
      19: VariableEdit.Text := '$EmailSub7';
      20: VariableEdit.Text := '$EmailFrom7';
      21: VariableEdit.Text := '$Email8';
      22: VariableEdit.Text := '$EmailSub8';
      23: VariableEdit.Text := '$EmailFrom8';
      24: VariableEdit.Text := '$Email9';
      25: VariableEdit.Text := '$EmailSub9';
      26: VariableEdit.Text := '$EmailFrom9';
      27: VariableEdit.Text := '$Email0';
      28: VariableEdit.Text := '$EmailSub0';
      29: VariableEdit.Text := '$EmailFrom0';
    end;

    FocusToInputField();

  end;
end;

procedure TSetupForm.EmailAccountComboBoxChange(Sender: TObject);

begin
  config.pop[(EMailAccountComboboxTemp + 1) mod 10].server := EmailServerEdit.text;
  config.pop[(EMailAccountComboboxTemp + 1) mod 10].user := EmailLoginEdit.text;
  config.pop[(EMailAccountComboboxTemp + 1) mod 10].pword := EmailPasswordEdit.text;

  if EmailAccountComboBox.itemIndex < 0 then EmailAccountComboBox.itemindex := 0;

  EMailAccountComboboxTemp := EmailAccountComboBox.itemindex;
  EmailServerEdit.text := config.pop[(EMailAccountComboboxTemp + 1) mod 10].server;
  EmailLoginEdit.text := config.pop[(EMailAccountComboboxTemp + 1) mod 10].user;
  EmailPasswordEdit.text := config.pop[(EMailAccountComboboxTemp + 1) mod 10].pword;
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

procedure TSetupForm.CrystalFontzConfigButtonClick(Sender: TObject);
begin
 if (not config.isCF) then
  begin
    if MessageDlg('The Crystalfontz driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      ApplyButton.click();
    end;
  end;
  DoCrystalFontzSetupForm;
end;

procedure TSetupForm.IRTransConfigButtonClick(Sender: TObject);
begin
  if (not config.isIR) then
  begin
    if MessageDlg('The IRTrans driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      ApplyButton.click();
    end;
  end;
  if DoIRTransForm then begin
    config.isIR := false;  // force a reload with a potential new hostname
    ApplyButton.click();
  end;
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
  end;
  VariableEdit.Text := S + IntToStr(GamestatsListBox.Itemindex+1);
  FocusToInputField();
end;


procedure TSetupForm.Line1EditEnter(Sender: TObject);
begin
  GameServerEdit.text := config.gameServer[ScreenNumberComboBox.itemindex + 1, 1];
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
  GameServerEdit.text := config.gameServer[ScreenNumberComboBox.itemindex + 1, 2];
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
  GameServerEdit.text := config.gameServer[ScreenNumberComboBox.itemindex + 1, 3];
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
  GameServerEdit.text := config.gameServer[ScreenNumberComboBox.itemindex + 1, 4];
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
begin
  if NetworkStatsListBox.itemindex > -1 then
  begin
    if NetworkStatsListBox.itemindex = 0 then VariableEdit.Text := '$NetAdapter(1)';
    if NetworkStatsListBox.itemindex = 1 then VariableEdit.Text := '$NetDownK(1)';
    if NetworkStatsListBox.itemindex = 2 then VariableEdit.Text := '$NetUpK(1)';
    if NetworkStatsListBox.itemindex = 3 then VariableEdit.Text := '$NetDownM(1)';
    if NetworkStatsListBox.itemindex = 4 then VariableEdit.Text := '$NetUpM(1)';
    if NetworkStatsListBox.itemindex = 5 then VariableEdit.Text := '$NetDownG(1)';
    if NetworkStatsListBox.itemindex = 6 then VariableEdit.Text := '$NetUpG(1)';
    if NetworkStatsListBox.itemindex = 7 then VariableEdit.Text := '$NetSpDownK(1)';
    if NetworkStatsListBox.itemindex = 8 then VariableEdit.Text := '$NetSpUpK(1)';
    if NetworkStatsListBox.itemindex = 9 then VariableEdit.Text := '$NetSpDownM(1)';
    if NetworkStatsListBox.itemindex = 10 then VariableEdit.Text := '$NetSpUpM(1)';
    if NetworkStatsListBox.itemindex = 11 then VariableEdit.Text := '$NetErrDown(1)';
    if NetworkStatsListBox.itemindex = 12 then VariableEdit.Text := '$NetErrUp(1)';
    if NetworkStatsListBox.itemindex = 13 then VariableEdit.Text := '$NetErrTot(1)';
    if NetworkStatsListBox.itemindex = 14 then VariableEdit.Text := '$NetUniDown(1)';
    if NetworkStatsListBox.itemindex = 15 then VariableEdit.Text := '$NetUniUp(1)';
    if NetworkStatsListBox.itemindex = 16 then VariableEdit.Text := '$NetUniTot(1)';
    if NetworkStatsListBox.itemindex = 17 then VariableEdit.Text := '$NetNuniDown(1)';
    if NetworkStatsListBox.itemindex = 18 then VariableEdit.Text := '$NetNuniUp(1)';
    if NetworkStatsListBox.itemindex = 19 then VariableEdit.Text := '$NetNuniTot(1)';
    if NetworkStatsListBox.itemindex = 20 then VariableEdit.Text := '$NetPackTot(1)';
    if NetworkStatsListBox.itemindex = 21 then VariableEdit.Text := '$NetDiscDown(1)';
    if NetworkStatsListBox.itemindex = 22 then VariableEdit.Text := '$NetDiscUp(1)';
    if NetworkStatsListBox.itemindex = 23 then VariableEdit.Text := '$NetDiscTot(1)';
    if NetworkStatsListBox.itemindex = 24 then VariableEdit.Text := '$NetIPaddress';

    FocusToInputField();
  end;
end;

procedure TSetupForm.HD44780ConfigButtonClick(Sender: TObject);
begin
 if (not config.isHD) then
  begin
    if MessageDlg('The HD44780 driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      ApplyButton.click();
    end;
  end;
  if DoHD44780SetupForm then
    config.isHD := false;  // force reload
end;

procedure TSetupForm.FoldingAtHomeListBoxClick(Sender: TObject);
begin
  if FoldingAtHomeListBox.itemindex > -1 then
  begin
    if FoldingAtHomeListBox.itemindex = 0 then VariableEdit.Text := '$FOLDwu';
    if FoldingAtHomeListBox.itemindex = 1 then VariableEdit.Text := '$FOLDlastwu';
    if FoldingAtHomeListBox.itemindex = 2 then VariableEdit.Text := '$FOLDactproc';
    if FoldingAtHomeListBox.itemindex = 3 then VariableEdit.Text := '$FOLDteam';
    if FoldingAtHomeListBox.itemindex = 4 then VariableEdit.Text := '$FOLDscore';
    if FoldingAtHomeListBox.itemindex = 5 then VariableEdit.Text := '$FOLDrank';

    FocusToInputField();

  end;
end;


// Apply pressed.
procedure TSetupForm.ApplyButtonClick(Sender: TObject);
var
  relood: Boolean;
  x: Integer;
  sComPort: String;
  iMaxUsedRow: Integer;

begin
  relood := false;

  if (COMPortComboBox.items[COMPortComboBox.itemIndex] = USBPALM)
    and (CrystalFontzRadioButton.checked) then
  begin
    showmessage('Matrix Orbital must be selected if USB Palm is selected.');
    Exit;
  end;

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
  sComPort := COMPortComboBox.items[COMPortComboBox.itemIndex];
  if (config.isUsbPalm) <> (sComPort = USBPALM) then
  begin
    relood := true;
  end
  else if (MidStr(sComPort, 1, 3) = 'COM')
      and (StrToInt(MidStr(sComPort, 4, length(sComPort)-3)) <> config.comPort) then
  begin
      relood := true;
  end;

  if (config.baudrate <> BaudRateComboBox.itemindex) then relood := true;
  if (HD44780RadioButton.checked) and (not config.isHD) then relood := true;
  if (MatrixOrbitalRadioButton.checked) and (not config.isMO) then relood := true;
  if (CrystalFontzRadioButton.checked) and (not config.isCF) then relood := true;
  if (HD66712RadioButton.checked) and (not config.isHD2) then relood := true;
  if (IRTransRadioButton.checked) and (not config.isIR) then relood := true;


  LCDSmartieDisplayForm.WinampCtrl1.WinampLocation := WinampLocationEdit.text;
  config.winampLocation := WinampLocationEdit.text;
  config.refreshRate := ProgramRefreshIntervalSpinEdit.Value;
  config.setiEmail := SetiAtHomeEmailEdit.text;

  config.sizeOption := LCDSizeComboBox.itemindex + 1;
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

  LCDSmartieDisplayForm.SetupAutoStart();

  // Check if Com settings have changed.
  sComPort := COMPortComboBox.items[COMPortComboBox.itemIndex];
  config.isUsbPalm := (sComPort = USBPALM);
  if (not config.isUsbPalm) then
  begin
    config.comPort := StrToInt( midstr(sComPort, 4, length(sComPort)-3));
  end;

  config.baudrate := BaudRateComboBox.itemindex;
  config.pop[(EmailAccountComboBox.itemindex + 1) mod 10].server := EmailServerEdit.text;
  config.pop[(EmailAccountComboBox.itemindex + 1) mod 10].user := EmailLoginEdit.text;
  config.pop[(EmailAccountComboBox.itemindex + 1) mod 10].pword := EmailPasswordEdit.text;

  config.isHD := HD44780RadioButton.checked;
  config.isMO := MatrixOrbitalRadioButton.checked;
  config.isCF := CrystalFontzRadioButton.checked;
  config.isHD2 := HD66712RadioButton.checked;
  config.isIR := IRTransRadioButton.checked;

  if (WebProxyPortEdit.text = '') then WebProxyPortEdit.text := '0';
  config.httpProxy := WebProxyServerEdit.text;
  config.httpProxyPort := StrToInt(WebProxyPortEdit.text);

  SaveScreen(ScreenNumberComboBox.itemindex + 1);
  LCDSmartieDisplayForm.HTTPUpdateTimer.interval := 1000;
  LCDSmartieDisplayForm.GameUpdateTimer.interval := 1000;
  LCDSmartieDisplayForm.MBMUpdateTimer.interval := 1000;
  LCDSmartieDisplayForm.ScrollFlashTimer.interval := config.scrollPeriod;
  LCDSmartieDisplayForm.EMailTimer.interval := 800;

  config.save();

  if relood = true then
  begin
    LCDSmartieDisplayForm.ReInitLCD();
  end;

end;

// ok has been pressed.
procedure TSetupForm.OKButtonClick(Sender: TObject);
begin
  if (COMPortComboBox.items[COMPortComboBox.itemIndex] = USBPALM)
    and (CrystalFontzRadioButton.checked) then
  begin
    showmessage('Matrix Orbital must be selected if USB Palm is selected.');
    Exit;
  end;

  ApplyButton.click();
end;

procedure TSetupForm.FormCreate(Sender: TObject);
begin
  ActionsStringGrid.RowCount := 0;
  ActionsStringGrid.ColWidths[0] := 116;
  ActionsStringGrid.ColWidths[1] := 20;
  ActionsStringGrid.ColWidths[2] := 56;
  ActionsStringGrid.ColWidths[3] := 36;
  ActionsStringGrid.ColWidths[4] := 156;
end;

procedure TSetupForm.OutputListBoxClick(Sender: TObject);
begin
  if OutputListBox.itemindex = 0 then StatementEdit.Text := 'NextTheme';
  if OutputListBox.itemindex = 1 then StatementEdit.Text := 'LastTheme';
  if OutputListBox.itemindex = 2 then StatementEdit.Text := 'NextScreen';
  if OutputListBox.itemindex = 3 then StatementEdit.Text := 'LastScreen';
  if OutputListBox.itemindex = 4 then StatementEdit.Text := 'GotoTheme(2)';
  if OutputListBox.itemindex = 5 then StatementEdit.Text := 'GotoScreen(2)';
  if OutputListBox.itemindex = 6 then StatementEdit.Text := 'FreezeScreen';
  if OutputListBox.itemindex = 7 then StatementEdit.Text := 'RefreshAll';
  if OutputListBox.itemindex = 8 then StatementEdit.Text := 'Backlight(1)';
  if OutputListBox.itemindex = 9 then StatementEdit.Text := 'BacklightToggle';
  if OutputListBox.itemindex = 10 then StatementEdit.Text := 'BLFlash(5)';
  if OutputListBox.itemindex = 11 then StatementEdit.Text := 'Wave[c:\wave.wav]';
  if OutputListBox.itemindex = 12 then StatementEdit.Text := 'Exec[c:\autoexec.bat]';
  if OutputListBox.itemindex = 13 then StatementEdit.Text := 'WANextTrack';
  if OutputListBox.itemindex = 14 then StatementEdit.Text := 'WALastTrack';
  if OutputListBox.itemindex = 15 then StatementEdit.Text := 'WAPlay';
  if OutputListBox.itemindex = 16 then StatementEdit.Text := 'WAStop';
  if OutputListBox.itemindex = 17 then StatementEdit.Text := 'WAPause';
  if OutputListBox.itemindex = 18 then StatementEdit.Text := 'WAShuffle';
  if OutputListBox.itemindex = 19 then StatementEdit.Text := 'WAVolDown';
  if OutputListBox.itemindex = 20 then StatementEdit.Text := 'WAVolUp';
  if OutputListBox.itemindex = 21 then StatementEdit.Text := 'EnableScreen(1)';
  if OutputListBox.itemindex = 22 then StatementEdit.Text := 'DisableScreen(1)';
  if OutputListBox.itemindex = 23 then StatementEdit.Text := '$dll(name.dll,2,param1,param2)';

  if OutputListBox.itemindex = 24 then StatementEdit.Text := 'GPO(4,1)';
  if OutputListBox.itemindex = 25 then StatementEdit.Text := 'GPOToggle(4)';
  if OutputListBox.itemindex = 26 then StatementEdit.Text := 'GPOFlash(4,5)';
  if OutputListBox.itemindex = 27 then StatementEdit.Text := 'Fan(1,255)';

end;

procedure TSetupForm.MainPageControlChange(Sender: TObject);
begin
  if MainPageControl.ActivePage = ActionsTabSheet then
  begin
    setupbutton := 5;
    OperatorComboBox.ItemIndex := 0;

    while (OutputListBox.Items.Count > 24) do
      OutputListBox.Items.Delete(24);

    if (MatrixOrbitalRadioButton.Checked) then
    begin
      OutputListBox.Items.Add('GPO(4-8,0/1) (0=off 1=on)');
      OutputListBox.Items.Add('GPOToggle(4-8)');
      OutputListBox.Items.Add('GPOFlash(4-8,2) (nr. of times)');
      if (config.mx3Usb) then
      begin
        OutputListBox.Items.Add('Fan(1-3,0-255) (0-255=speed)');
      end;
    end;
  end;
  if MainPageControl.ActivePage = ScreensTabSheet then
  begin
    if LeftPageControl.activepage = LCDFeaturesTabSheet then
    begin
      if pos('$MObutton', VariableEdit.text) <> 0 then VariableEdit.text := 'Variable: ';
      LeftPageControl.ActivePage := WinampTabSheet;
    end;
    GameServerEdit.text := config.gameServer[ScreenNumberComboBox.itemindex + 1, 1];
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
  if ButtonsListBox.itemindex > -1 then
  begin
    if ButtonsListBox.itemindex = 0 then VariableEdit.Text := '$MObutton';

    FocusToInputField();

  end;
end;

procedure TSetupForm.InteractionsButtonClick(Sender: TObject);
begin
  DoInteractionConfigForm;
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

procedure TSetupForm.COMPortComboBoxChange(Sender: TObject);
begin
  if (COMPortComboBox.ItemIndex < 0) then COMPortComboBox.ItemIndex := 0;
end;

procedure TSetupForm.BaudRateComboBoxChange(Sender: TObject);
begin
  if BaudRateComboBox.itemindex < 0 then BaudRateComboBox.ItemIndex := 0;
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

end.



