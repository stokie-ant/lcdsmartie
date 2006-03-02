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
 *  $Revision: 1.42 $ $Date: 2006/03/02 13:39:51 $
 *****************************************************************************}

interface

uses Dialogs, Grids, StdCtrls, Controls, Spin, Buttons, ComCtrls, Classes,
  Forms;

const
  USBPALM = 'USB Palm';
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
    TransitionButton: TButton;
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
    procedure TransitionButtonClick(Sender: TObject);
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
    CurrentScreen: Integer;
    Procedure FocusToInputField;
    procedure SaveScreen(scr: Integer);
    procedure LoadScreen(scr: Integer);
    procedure DetectCommPorts;
  end;

function DoSetupForm : boolean;
procedure UpdateSetupForm(cKey : char);
function PerformingSetup : boolean;

implementation

uses
  Windows, ShellApi, graphics, sysutils, Registry, UMain, UMOSetup,
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

const
  SerialDeviceRoot = '\HARDWARE\DEVICEMAP\SERIALCOMM';

procedure TSetupForm.DetectCommPorts;
var
  Reg : TRegistry;
  Names : TStrings;
  S : string;
  I : byte;
  LoopCounter : integer;
  ComPorts : array[0..255] of boolean;
begin
  fillchar(ComPorts,sizeof(ComPorts),$00);
  Reg := TRegistry.Create;
  with Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    if not OpenKeyReadOnly(SerialDeviceRoot) then exit;
    Names := TStringList.Create;
    GetValueNames(Names);
    fillchar(Comports,sizeof(Comports),$00);
    for LoopCounter := 1 to Names.Count do begin
      S := ReadString(Names[LoopCounter-1]);
      if (pos('COM',S) = 1) then begin
        delete(S,1,3);
        try
          I := StrToInt(S);
        except
          I := 0;
        end;
        ComPorts[I] := true;
      end;
    end;
    CloseKey;
  end;
  Reg.Free;
  Names.Free;
  for LoopCounter := 1 to 255 do begin
    if ComPorts[LoopCounter] then
      COMPortComboBox.Items.Add('COM'+IntToStr(LoopCounter));
  end;
end;

procedure TSetupForm.FormShow(Sender: TObject);
var
  i, blaat: Integer;
  iSelection: Integer;
  sLookFor: String;
  uiTestPort: Cardinal;
begin
  { Try to limit the displayed COM port to only those that are useable }

  DetectCommPorts;
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

  case Config.ScreenType of
    stHD,
    stHD2 : begin
      HD44780RadioButton.checked := true;
      HD44780ConfigButton.enabled := true;
    end;
    stMO : begin
      MatrixOrbitalRadioButton.checked := true;
      MatrixOrbitalConfigButton.enabled := true;

      COMPortComboBox.enabled := true;
      BaudRateComboBox.enabled := true;
    end;
    stCF : begin
      CrystalFontzRadioButton.checked := true;
      CrystalFontzConfigButton.enabled := true;

      COMPortComboBox.enabled := true;
      BaudRateComboBox.enabled := true;
    end;
    stIR : begin
      IRTransRadioButton.Checked := true;
      IRTransConfigButton.Enabled := true;
    end;
  end; // case

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
  LCDSizeComboBoxChange(Sender);

  InternetRefreshTimeSpinEdit.Value := config.newsRefresh;
  RandomizeScreensCheckBox.checked := config.randomScreens;
  GamestatsRefreshTimeSpinEdit.Value := config.gameRefresh;
  FoldingAtHomeEmailEdit.text := config.foldUsername;
  MBMRefreshTimeSpinEdit.Value := config.mbmRefresh;
  LCDSmartieUpdateCheckBox.checked := config.checkUpdates;



  for i := 1 to 24 do ButtonsListBox.Items.Delete(1);
  if (config.ScreenType = stMO) then
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
  SaveScreen(CurrentScreen);

  if ScreenNumberComboBox.itemIndex < 0 then ScreenNumberComboBox.itemIndex := 0;
  CurrentScreen := ScreenNumberComboBox.itemindex+1;

  LoadScreen(CurrentScreen);
  LCDSmartieDisplayForm.ChangeScreen(CurrentScreen);
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
  case WinampListBox.itemindex of
    0 : VariableEdit.Text := '$WinampTitle';
    1 : VariableEdit.Text := '$WinampChannels';
    2 : VariableEdit.Text := '$WinampKBPS';
    3 : VariableEdit.Text := '$WinampFreq';
    4 : VariableEdit.Text := '$Winamppos';
    5 : VariableEdit.Text := '$WinampPolo';
    6 : VariableEdit.Text := '$WinampPosh';
    7 : VariableEdit.Text := '$WinampRem';
    8 : VariableEdit.Text := '$WinampRelo';
    9 : VariableEdit.Text := '$WinampResh';
    10 : VariableEdit.Text := '$WinampLength';
    11 : VariableEdit.Text := '$WinampLengtl';
    12 : VariableEdit.Text := '$WinampLengts';
    13 : VariableEdit.Text := '$WinampPosition(10)';
    14 : VariableEdit.Text := '$WinampTracknr';
    15 : VariableEdit.Text := '$WinampTotalTracks';
    16 : VariableEdit.Text := '$WinampStat';
    else VariableEdit.Text := NoVariable;
  end; // case

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
begin
  case MBMListBox.itemindex of
    0 : VariableEdit.Text := '$Temp1';
    1 : VariableEdit.Text := '$Temp2';
    2 : VariableEdit.Text := '$Temp3';
    3 : VariableEdit.Text := '$Temp4';
    4 : VariableEdit.Text := '$Temp5';
    5 : VariableEdit.Text := '$Temp6';
    6 : VariableEdit.Text := '$Temp7';
    7 : VariableEdit.Text := '$Temp8';
    8 : VariableEdit.Text := '$Temp9';
    9 : VariableEdit.Text := '$Temp10';
    10 : VariableEdit.Text := '$FanS1';
    11 : VariableEdit.Text := '$FanS2';
    12 : VariableEdit.Text := '$FanS3';
    13 : VariableEdit.Text := '$FanS4';
    14 : VariableEdit.Text := '$FanS5';
    15 : VariableEdit.Text := '$FanS6';
    16 : VariableEdit.Text := '$FanS7';
    17 : VariableEdit.Text := '$FanS8';
    18 : VariableEdit.Text := '$FanS9';
    19 : VariableEdit.Text := '$FanS10';
    20 : VariableEdit.Text := '$Voltage1';
    21 : VariableEdit.Text := '$Voltage2';
    22 : VariableEdit.Text := '$Voltage3';
    23 : VariableEdit.Text := '$Voltage4';
    24 : VariableEdit.Text := '$Voltage5';
    25 : VariableEdit.Text := '$Voltage6';
    26 : VariableEdit.Text := '$Voltage7';
    27 : VariableEdit.Text := '$Voltage8';
    28 : VariableEdit.Text := '$Voltage9';
    29 : VariableEdit.Text := '$Voltage10';
    30 : VariableEdit.Text := '$Tempname1';
    31 : VariableEdit.Text := '$Tempname2';
    32 : VariableEdit.Text := '$Tempname3';
    33 : VariableEdit.Text := '$Tempname4';
    34 : VariableEdit.Text := '$Tempname5';
    35 : VariableEdit.Text := '$Tempname6';
    36 : VariableEdit.Text := '$Tempname7';
    37 : VariableEdit.Text := '$Tempname8';
    38 : VariableEdit.Text := '$Tempname9';
    39 : VariableEdit.Text := '$Tempname10';
    40 : VariableEdit.Text := '$Fanname1';
    41 : VariableEdit.Text := '$Fanname2';
    42 : VariableEdit.Text := '$Fanname3';
    43 : VariableEdit.Text := '$Fanname4';
    44 : VariableEdit.Text := '$Fanname5';
    45 : VariableEdit.Text := '$Fanname6';
    46 : VariableEdit.Text := '$Fanname7';
    47 : VariableEdit.Text := '$Fanname8';
    48 : VariableEdit.Text := '$Fanname9';
    49 : VariableEdit.Text := '$Fanname10';
    50 : VariableEdit.Text := '$Voltname1';
    51 : VariableEdit.Text := '$Voltname2';
    52 : VariableEdit.Text := '$Voltname3';
    53 : VariableEdit.Text := '$Voltname4';
    54 : VariableEdit.Text := '$Voltname5';
    55 : VariableEdit.Text := '$Voltname6';
    56 : VariableEdit.Text := '$Voltname7';
    57 : VariableEdit.Text := '$Voltname8';
    58 : VariableEdit.Text := '$Voltname9';
    59 : VariableEdit.Text := '$Voltname10';
    else VariableEdit.Text := NoVariable;
  end; // case

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
  if (ScreenNumberComboBox.itemIndex >= 0 ) and
     (setupbutton >= 0) and (setupbutton <= 4) then
  begin
    config.gameServer[ScreenNumberComboBox.itemindex + 1, setupbutton] := GameServerEdit.text;
  end;
end;

procedure TSetupForm.MatrixOrbitalConfigButtonClick(Sender: TObject);
begin
  if (not (config.ScreenType = stMO)) then
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
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
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
  if (not (config.ScreenType = stCF)) then
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
  if (not (config.ScreenType = stIR)) then
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
    config.ScreenType := stNone;
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
  case NetworkStatsListBox.itemindex of
    0 : VariableEdit.Text := '$NetAdapter(1)';
    1 : VariableEdit.Text := '$NetDownK(1)';
    2 : VariableEdit.Text := '$NetUpK(1)';
    3 : VariableEdit.Text := '$NetDownM(1)';
    4 : VariableEdit.Text := '$NetUpM(1)';
    5 : VariableEdit.Text := '$NetDownG(1)';
    6 : VariableEdit.Text := '$NetUpG(1)';
    7 : VariableEdit.Text := '$NetSpDownK(1)';
    8 : VariableEdit.Text := '$NetSpUpK(1)';
    9 : VariableEdit.Text := '$NetSpDownM(1)';
    10 : VariableEdit.Text := '$NetSpUpM(1)';
    11 : VariableEdit.Text := '$NetErrDown(1)';
    12 : VariableEdit.Text := '$NetErrUp(1)';
    13 : VariableEdit.Text := '$NetErrTot(1)';
    14 : VariableEdit.Text := '$NetUniDown(1)';
    15 : VariableEdit.Text := '$NetUniUp(1)';
    16 : VariableEdit.Text := '$NetUniTot(1)';
    17 : VariableEdit.Text := '$NetNuniDown(1)';
    18 : VariableEdit.Text := '$NetNuniUp(1)';
    19 : VariableEdit.Text := '$NetNuniTot(1)';
    20 : VariableEdit.Text := '$NetPackTot(1)';
    21 : VariableEdit.Text := '$NetDiscDown(1)';
    22 : VariableEdit.Text := '$NetDiscUp(1)';
    23 : VariableEdit.Text := '$NetDiscTot(1)';
    24 : VariableEdit.Text := '$NetIPaddress';
    else VariableEdit.Text := NoVariable;
  end; // case

  if not (VariableEdit.Text = NoVariable) then
    FocusToInputField();
end;

procedure TSetupForm.HD44780ConfigButtonClick(Sender: TObject);
begin
  if (not (config.ScreenType = stHD)) then
  begin
    if MessageDlg('The HD44780 driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      ApplyButton.click();
    end;
  end;
  if DoHD44780SetupForm then begin
    config.ScreenType := stNone; // force reload
    ApplyButton.click();
  end;
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
  if (HD44780RadioButton.checked) and not (config.ScreenType = stHD) then relood := true;
  if (MatrixOrbitalRadioButton.checked) and not (config.ScreenType = stMO) then relood := true;
  if (CrystalFontzRadioButton.checked) and not (config.ScreenType = stCF) then relood := true;
  if (HD66712RadioButton.checked) and not (config.ScreenType = stHD2) then relood := true;
  if (IRTransRadioButton.checked) and not (config.ScreenType = stIR) then relood := true;


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

  if HD44780RadioButton.checked then config.ScreenType := stHD
  else if MatrixOrbitalRadioButton.checked then config.ScreenType := stMO
  else if CrystalFontzRadioButton.checked then config.ScreenType := stCF
  else if HD66712RadioButton.checked then config.ScreenType := stHD2
  else if IRTransRadioButton.checked then config.ScreenType := stIR;

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

  ApplyButtonClick(Sender);
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
      if pos('$MObutton', VariableEdit.text) <> 0 then VariableEdit.text := NoVariable;
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
    for Loop := 1 to 4 do begin
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



