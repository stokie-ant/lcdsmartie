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
 *  $Revision: 1.36 $ $Date: 2006/02/27 18:35:47 $
 *****************************************************************************}

interface

uses Dialogs, Grids, StdCtrls, Controls, Spin, Buttons, ComCtrls, Classes,
  Forms;

const
  UPKEY = 38;
  DOWNKEY = 40;
  USBPALM = 'USB Palm';


type
  TSetupForm = class(TForm)
    Button1: TButton;
    CancelButton: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox5: TListBox;
    ListBox6: TListBox;
    ListBox7: TListBox;
    Edit9: TEdit;
    Edit10: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButton1: TSpeedButton;
    OpenDialog2: TOpenDialog;
    Edit14: TEdit;
    Label34: TLabel;
    ComboBox6: TComboBox;
    SpeedButton2: TSpeedButton;
    Button3: TButton;
    SpinEdit3: TSpinEdit;
    Label36: TLabel;
    SpinEdit5: TSpinEdit;
    Label37: TLabel;
    Label38: TLabel;
    SpinEdit6: TSpinEdit;
    Label35: TLabel;
    Label40: TLabel;
    TabSheet8: TTabSheet;
    ListBox3: TListBox;
    Edit1: TEdit;
    Label41: TLabel;
    TabSheet4: TTabSheet;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Edit13: TEdit;
    Edit12: TEdit;
    Edit11: TEdit;
    SpinEdit4: TSpinEdit;
    Label48: TLabel;
    ListBox4: TListBox;
    ComboBox8: TComboBox;
    Label50: TLabel;
    OpenDialog1: TOpenDialog;
    Edit15: TEdit;
    SpeedButton3: TSpeedButton;
    Label55: TLabel;
    ListBox8: TListBox;
    TabSheet9: TTabSheet;
    ListBox9: TListBox;
    TabSheet10: TTabSheet;
    Edit2: TEdit;
    ListBox10: TListBox;
    Label23: TLabel;
    Button7: TButton;
    PageControl2: TPageControl;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    GroupBox1: TGroupBox;
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
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    GroupBox5: TGroupBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    GroupBox6: TGroupBox;
    SpinEdit7: TSpinEdit;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    SpinEdit1: TSpinEdit;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Button4: TButton;
    RadioButton3: TRadioButton;
    Button5: TButton;
    Button6: TButton;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    SpinEdit2: TSpinEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    StringGrid1: TStringGrid;
    ListBox11: TListBox;
    Edit16: TEdit;
    Label24: TLabel;
    ComboBox9: TComboBox;
    Edit18: TEdit;
    Label25: TLabel;
    Button8: TButton;
    Button9: TButton;
    Label26: TLabel;
    CheckBox15: TCheckBox;
    TabSheet13: TTabSheet;
    ListBox12: TListBox;
    Label27: TLabel;
    Label29: TLabel;
    Edit17: TEdit;
    Label56: TLabel;
    Label30: TLabel;
    Label57: TLabel;
    Edit19: TEdit;
    Label6: TLabel;
    CheckBox14: TCheckBox;
    CheckBox2: TCheckBox;
    Button10: TButton;
    Label58: TLabel;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    Label59: TLabel;
    RadioButton4: TRadioButton;
    Label28: TLabel;
    Sticky: TCheckBox;
    TabSheet14: TTabSheet;
    GroupBox7: TGroupBox;
    NoAutoStart: TRadioButton;
    AutoStart: TRadioButton;
    AutoStartHide: TRadioButton;
    GroupBox8: TGroupBox;
    HideOnStartup: TCheckBox;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox7: TComboBox;
    IRTransRadioButton: TRadioButton;
    IRTransConfigButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ListBox7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox6Click(Sender: TObject);
    procedure ListBox5Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListBox8Click(Sender: TObject);
    procedure Edit5Enter(Sender: TObject);
    procedure Edit6Enter(Sender: TObject);
    procedure Edit7Enter(Sender: TObject);
    procedure Edit8Enter(Sender: TObject);
    procedure ListBox9Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ListBox10Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox11Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ListBox12Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure Edit8KeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure StickyClick(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure IRTransRadioButtonClick(Sender: TObject);
    procedure IRTransConfigButtonClick(Sender: TObject);
  private
    setupbutton: Integer;
    combobox8temp: Integer;
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
    Free;
  end;
  SetupForm := nil;
end;

// Cancel has been pressed.
procedure TSetupForm.CancelButtonClick(Sender: TObject);
begin
  LCDSmartieDisplayForm.timer2.interval := 500;

  LCDSmartieDisplayForm.timer7.interval := 0;
  if (not config.screen[activeScreen][1].bSticky) then
    LCDSmartieDisplayForm.timer7.interval := config.screen[activeScreen][1].showTime*1000;


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
  for i:= combobox4.Items.Count-1 downto 0 do
    combobox4.Items.Delete(i);

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
        comboBox4.Items.Add('COM'+IntToStr(i));
        CloseHandle(uiTestPort);
      end
      else if (GetLastError <> ERROR_FILE_NOT_FOUND)
        and (GetLastError <> ERROR_PATH_NOT_FOUND) then 
      begin
	// Add them to the list - its better to have too many than not enough.
        // This case is also used when the port is already used by smartie.
        comboBox4.Items.Add('COM'+IntToStr(i));
      end;
  end;
  comboBox4.Items.Add(USBPALM);

  pagecontrol2.ActivePage := tabsheet11;
  //if pagecontrol1.activepage = tabsheet13 then pagecontrol1.ActivePage :=
   // tabsheet1;
  //tabsheet13.Enabled := false;
  tabsheet13.Enabled := true;

  setupbutton := 1;

  edit10.text := config.gameServer[1, 1];

  StringGrid1.rowcount := 0;
  for blaat := 0 to 999 do
  begin
    StringGrid1.Cells[0, blaat] := '';
    StringGrid1.Cells[1, blaat] := '';
    StringGrid1.Cells[2, blaat] := '';
    StringGrid1.Cells[3, blaat] := '';
    StringGrid1.Cells[4, blaat] := '';
  end;

  for i := 1 to config.totalactions do
  begin
      edit16.text := config.actionsArray[i, 1];
      combobox9.itemindex := StrToInt(config.actionsArray[i, 2]);
      edit19.text := config.actionsArray[i, 3];
      edit18.text := config.actionsArray[i, 4];
      button8.click;
  end;

  //application.ProcessMessages;

  combobox3.itemindex := 0;
  tempscreen := 0;
  LoadScreen( 1 );   // setup screen in setup form
  LCDSmartieDisplayForm.ChangeScreen(1);   // setup screen in main form

  spinEdit1.text := IntToStr(config.refreshRate);
  edit15.text := config.winampLocation;
  combobox1.itemindex := config.colorOption;


  edit1.text := config.setiEmail;

  edit14.text := config.distLog;

  spinedit4.text := IntToStr(config.emailPeriod);
  spinedit8.text := IntToStr(config.dllPeriod);
  spinedit9.text := IntToStr(config.scrollPeriod);

  checkbox2.checked := config.alwaysOnTop;
  HideOnStartup.Checked := config.bHideOnStartup;
  NoAutoStart.Checked := True;
  AutoStart.Checked := config.bAutoStart;
  AutoStartHide.Checked := config.bAutoStartHide;

  edit3.text := config.httpProxy;
  edit4.text := IntToStr(config.httpProxyPort);
  combobox8.itemindex := 0;
  edit11.text := config.pop[1].server;
  edit12.text := config.pop[1].user;
  edit13.text := config.pop[1].pword;

  button4.enabled := false;
  button5.enabled := false;
  button6.enabled := false;
  IRTransConfigButton.Enabled := false;
  combobox5.enabled := false;
  combobox4.enabled := false;

  if (config.isHD) or (config.isHD2) then
  begin
    radiobutton1.checked := true;
    button6.enabled := true;
  end;
  if config.isMO then
  begin
    radiobutton2.checked := true;
    button4.enabled := true;

    combobox4.enabled := true;
    combobox5.enabled := true;
  end;
  if config.isCF then
  begin
    radiobutton3.checked := true;
    button5.enabled := true;

    combobox4.enabled := true;
    combobox5.enabled := true;
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
  for i := 0 to combobox4.Items.Count-1 do
  begin
    if (sLookFor = combobox4.Items[i]) then
      iSelection := i;
  end;

  if (iSelection = -1) then
  begin
    showmessage(sLookFor + ' is no longer a valid COM Port option, please reselect.');
    iSelection := 0;
  end;

  combobox4.ItemIndex := iSelection;

  combobox5.ItemIndex := config.baudrate;
  combobox2.itemindex := config.sizeOption-1;

  if combobox2.itemindex < 5 then
  begin
    checkbox7.checked := false;
    edit6.Visible := false;
    edit7.Visible := false;
    edit8.Visible := false;
    checkbox4.Visible := false;
    checkbox5.Visible := false;
    checkbox6.Visible := false;
    checkbox7.Visible := false;
    checkbox8.Visible := false;
    checkbox9.Visible := false;
    checkbox11.visible := false;
    checkbox12.visible := false;
    checkbox13.visible := false;
  end;
  if (combobox2.itemindex < 9) and (combobox2.itemindex > 4) then
  begin
    if checkbox7.checked = false then edit6.Visible := true;
    checkbox8.checked := false;
    edit7.Visible := false;
    edit8.Visible := false;
    checkbox4.Visible := true;
    checkbox5.Visible := false;
    checkbox6.Visible := false;
    checkbox7.Visible := true;
    checkbox8.Visible := false;
    checkbox9.Visible := false;
    checkbox11.visible := true;
    checkbox12.visible := false;
    checkbox13.visible := false;
  end;
  if combobox2.itemindex > 8 then
  begin
    if checkbox7.checked = false then edit6.Visible := true;
    if checkbox8.checked = false then edit7.Visible := true;
    if checkbox9.checked = false then edit8.Visible := true;
    checkbox4.Visible := true;
    checkbox5.Visible := true;
    checkbox6.Visible := true;
    checkbox7.Visible := true;
    checkbox8.Visible := true;
    checkbox9.Visible := true;
    checkbox11.visible := true;
    checkbox12.visible := true;
    checkbox13.visible := true;
  end;

  spinedit3.text := IntToStr(config.newsRefresh);
  checkbox14.checked := config.randomScreens;
  spinedit5.text := IntToStr(config.gameRefresh);
  edit2.text := config.foldUsername;
  spinedit6.text := IntToStr(config.mbmRefresh);
  checkbox15.checked := config.checkUpdates;



  for i := 1 to 24 do listbox12.Items.Delete(1);
  if (config.isMO) then
  begin
    //tabsheet13.Enabled := true;
    listbox12.Items.Add('FanSpeed(1,1) (nr,divider)');

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
          listbox12.Items.Add(line2);
        end;
      end;
      if laatstepacket <> true then goto nextpacket;
    end;}
  end;
end;

procedure TSetupForm.ComboBox2Change(Sender: TObject);
begin
  if combobox2.itemindex < 0 then combobox2.itemindex := 0;

  if combobox2.itemindex < 5 then
  begin
    checkbox7.checked := false;
    edit6.Visible := false;
    edit7.Visible := false;
    edit8.Visible := false;
    checkbox4.Visible := false;
    checkbox5.Visible := false;
    checkbox6.Visible := false;
    checkbox7.Visible := false;
    checkbox8.Visible := false;
    checkbox9.Visible := false;
    checkbox11.visible := false;
    checkbox12.visible := false;
    checkbox13.visible := false;
  end;
  if (combobox2.itemindex < 9) and (combobox2.itemindex > 4) then
  begin
    if checkbox7.checked = false then edit6.Visible := true;
    checkbox8.checked := false;
    edit7.Visible := false;
    edit8.Visible := false;
    checkbox4.Visible := true;
    checkbox5.Visible := false;
    checkbox6.Visible := false;
    checkbox7.Visible := true;
    checkbox8.Visible := false;
    checkbox9.Visible := false;
    checkbox11.visible := true;
    checkbox12.visible := false;
    checkbox13.visible := false;
  end;
  if combobox2.itemindex > 8 then
  begin
    if checkbox7.checked = false then edit6.Visible := true;
    if checkbox8.checked = false then edit7.Visible := true;
    if checkbox9.checked = false then edit8.Visible := true;
    checkbox4.Visible := true;
    checkbox5.Visible := true;
    checkbox6.Visible := true;
    checkbox7.Visible := true;
    checkbox8.Visible := true;
    checkbox9.Visible := true;
    checkbox11.visible := true;
    checkbox12.visible := true;
    checkbox13.visible := true;
  end;
end;

procedure TSetupForm.SaveScreen(scr: Integer);
var
  y: Integer;

begin

  config.screen[scr][1].text := edit5.text;
  config.screen[scr][2].text := edit6.text;
  config.screen[scr][3].text := edit7.text;
  config.screen[scr][4].text := edit8.text;

  for y := 1 to 4 do
  begin
    config.screen[scr][y].enabled := checkbox1.checked;
    config.screen[scr][y].skip := combobox7.itemindex;
    config.screen[scr][y].theme := spinedit7.value-1;
    config.screen[scr][y].interaction := GlobalInteractionStyle;
    config.screen[scr][y].interactionTime := GlobalInteractionTime;
    config.screen[scr][y].showTime := spinedit2.value;
    config.screen[scr][y].bSticky := Sticky.Checked;

    // ensure no ¿s occur in the text.
    config.screen[scr][y].text := StringReplace(config.screen[scr][y].text,
      '¿', '?', [rfReplaceAll]);
  end;

  config.screen[scr][1].center := checkbox10.checked;
  config.screen[scr][2].center := checkbox11.checked;
  config.screen[scr][3].center := checkbox12.checked;
  config.screen[scr][4].center := checkbox13.checked;

  config.screen[scr][1].noscroll := checkbox3.checked;
  config.screen[scr][2].noscroll := checkbox4.checked;
  config.screen[scr][3].noscroll := checkbox5.checked;
  config.screen[scr][4].noscroll := checkbox6.checked;
  LCDSmartieDisplayForm.ResetScrollPositions();

  config.screen[scr][1].contNextLine := checkbox7.checked;
  config.screen[scr][2].contNextLine := checkbox8.checked;
  config.screen[scr][3].contNextLine := checkbox9.checked;
  config.screen[scr][4].contNextLine := False;
end;

procedure TSetupForm.LoadScreen(scr: Integer);
var
  ascreen: TScreenLine;
begin
  ascreen := config.screen[scr][1];
  checkbox1.checked := ascreen.enabled;
  combobox7.itemindex := ascreen.skip;
  spinedit7.value := ascreen.theme + 1;
  GlobalInteractionStyle := ascreen.interaction;
  GlobalInteractionTime := ascreen.interactionTime;
  spinedit2.value := ascreen.showTime;
  Sticky.checked := ascreen.bSticky;
  spinedit2.enabled := not ascreen.bSticky;

  checkbox3.checked := false;
  checkbox4.checked := false;
  checkbox5.checked := false;
  checkbox6.checked := false;
  checkbox7.checked := false;
  checkbox8.checked := false;
  checkbox9.checked := false;
  checkbox3.enabled := true;
  checkbox3.checked := false;
  edit6.enabled := true;
  checkbox4.enabled := true;
  checkbox4.checked := false;
  edit7.enabled := true;
  checkbox5.enabled := true;
  checkbox5.checked := false;
  edit8.enabled := true;

  edit5.color := $00A1D7A4;
  edit6.color := clWhite;
  edit7.color := clWhite;
  edit8.color := clWhite;
  setupbutton := 1;
  edit10.text := config.gameServer[scr, 1];

  ascreen := config.screen[scr][1];
  checkbox3.checked := ascreen.noscroll;
  if ascreen.contNextLine then
  begin
    checkbox7.checked := true;
    checkbox3.Checked := true;
    checkbox3.enabled := false;
    edit6.enabled := false;
    edit6.color := $00BBBBFF;
  end;
  edit5.text := ascreen.text;
  checkbox10.Checked := ascreen.center;

  ascreen := config.screen[scr][2];
  checkbox4.checked := ascreen.noscroll;
  if ascreen.contNextLine then
  begin
    checkbox8.checked := true;
    checkbox4.Checked := true;
    checkbox4.enabled := false;
    edit7.enabled := false;
    edit7.color := $00BBBBFF;
  end;
  edit6.text := ascreen.text;
  checkbox11.Checked := ascreen.center;

  ascreen := config.screen[scr][3];
  checkbox5.checked := ascreen.noscroll;
  if ascreen.contNextLine then
  begin
    checkbox9.checked := true;
    checkbox5.Checked := true;
    checkbox5.enabled := false;
    edit8.enabled := false;
    edit8.color := $00BBBBFF;
  end;
  edit7.text := ascreen.text;
  checkbox12.Checked := ascreen.center;

  ascreen := config.screen[scr][4];
  checkbox6.checked := ascreen.noscroll;
  edit8.text := ascreen.text;
  checkbox13.Checked := ascreen.center;
end;

procedure TSetupForm.ComboBox3Change(Sender: TObject);
begin
  SaveScreen(tempscreen + 1);

  if combobox3.itemIndex < 0 then combobox3.itemIndex := 0;
  tempscreen := combobox3.itemindex;

  LoadScreen(tempscreen + 1);

  LCDSmartieDisplayForm.ChangeScreen(tempscreen + 1);
end;

procedure TSetupForm.RadioButton1Click(Sender: TObject);
begin
  //if pagecontrol1.ActivePage = Tabsheet13 then pagecontrol1.ActivePage :=
  //  Tabsheet1;
  //tabsheet13.Enabled := false;
  button6.enabled := true;
  combobox4.enabled := false;
  combobox5.enabled := false;
  button4.enabled := false;
  button5.enabled := false;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.RadioButton4Click(Sender: TObject);
begin
  button6.enabled := true;
  combobox4.enabled := false;
  combobox5.enabled := false;
  button4.enabled := false;
  button5.enabled := false;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.RadioButton2Click(Sender: TObject);
begin
  //tabsheet13.Enabled := true;
  button6.enabled := false;
  combobox4.enabled := true;
  combobox5.enabled := true;
  button4.enabled := true;
  button5.enabled := false;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.RadioButton3Click(Sender: TObject);
begin
  //if pagecontrol1.ActivePage = Tabsheet13 then pagecontrol1.ActivePage :=
  //  Tabsheet1;
  //tabsheet13.Enabled := false;
  button6.enabled := false;
  combobox4.enabled := true;
  combobox5.enabled := true;
  button4.enabled := false;
  button5.enabled := true;
  IRTransConfigButton.Enabled := false;
end;

procedure TSetupForm.IRTransRadioButtonClick(Sender: TObject);
begin
  combobox4.enabled := false;
  combobox5.enabled := false;
  button4.enabled := false;
  button5.enabled := false;
  button6.enabled := false;
  IRTransConfigButton.Enabled := true;
end;

procedure TSetupForm.ListBox7Click(Sender: TObject);
begin
  if listbox7.itemindex > -1 then
  begin
    if listbox7.itemindex = 0 then Edit9.Text := '$WinampTitle';
    if listbox7.itemindex = 1 then Edit9.Text := '$WinampChannels';
    if listbox7.itemindex = 2 then Edit9.Text := '$WinampKBPS';
    if listbox7.itemindex = 3 then Edit9.Text := '$WinampFreq';
    if listbox7.itemindex = 4 then Edit9.Text := '$Winamppos';
    if listbox7.itemindex = 5 then Edit9.Text := '$WinampPolo';
    if listbox7.itemindex = 6 then Edit9.Text := '$WinampPosh';
    if listbox7.itemindex = 7 then Edit9.Text := '$WinampRem';
    if listbox7.itemindex = 8 then Edit9.Text := '$WinampRelo';
    if listbox7.itemindex = 9 then Edit9.Text := '$WinampResh';
    if listbox7.itemindex = 10 then Edit9.Text := '$WinampLength';
    if listbox7.itemindex = 11 then Edit9.Text := '$WinampLengtl';
    if listbox7.itemindex = 12 then Edit9.Text := '$WinampLengts';
    if listbox7.itemindex = 13 then Edit9.Text := '$WinampPosition(10)';
    if listbox7.itemindex = 14 then Edit9.Text := '$WinampTracknr';
    if listbox7.itemindex = 15 then Edit9.Text := '$WinampTotalTracks';
    if listbox7.itemindex = 16 then Edit9.Text := '$WinampStat';

    FocusToInputField();
  end;
end;


// Select currently active text field that will receive variable if 'insert'
// is pressed.
Procedure TSetupForm.FocusToInputField;
var
  tempint1, tempint2: Integer;
begin
  if (TabSheet11.visible) then // in Screens tab
  begin
    // not all the lines will be enabled/visible because of different size
    // displays.

    if (setupbutton = 2) and (edit6.Enabled) and (edit6.visible) then
    begin
      tempint1 := edit6.SelStart;
      tempint2 := edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart := tempint1;
      edit6.SelLength := tempint2;
    end
    else if (setupbutton = 3) and (edit7.enabled) and (edit7.visible) then
    begin
      tempint1 := edit7.SelStart;
      tempint2 := edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart := tempint1;
      edit7.SelLength := tempint2;
    end
    else if (setupbutton = 4) and (edit8.enabled) and (edit8.visible) then
    begin
      tempint1 := edit8.SelStart;
      tempint2 := edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart := tempint1;
      edit8.SelLength := tempint2;
    end
    else if (edit5.Enabled) and (edit5.visible) then // default to line 1 of screen section
    begin // setupbutton = 1
      tempint1 := edit5.SelStart;
      tempint2 := edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart := tempint1;
      edit5.SelLength := tempint2;
    end;
  end
  else if (TabSheet12.visible) then // in Actions tab
  begin
    if (edit16.Enabled) and (edit16.visible) then
    begin
      tempint1 := edit16.SelStart;
      tempint2 := edit16.SelLength;
      edit16.setfocus;
      edit16.SelStart := tempint1;
      edit16.SelLength := tempint2;
    end
  end;
end;

procedure TSetupForm.Button3Click(Sender: TObject);
var
  tempint: Integer;

begin
  if Edit9.Text <> 'Variable: ' then
  begin
    if (tabsheet11.visible) then // in Screens tab
    begin
      if (setupbutton = 2) and (edit6.enabled) and (edit6.visible) then
      begin
        tempint := edit6.SelStart;
        edit6.text := copy(edit6.text, 1, Edit6.SelStart) + Edit9.Text +
          copy(edit6.text, edit6.SelStart + 1 + edit6.SelLength,
          length(edit6.Text));
        edit6.SetFocus;
        edit6.selstart := tempint + length(edit9.text);
      end
      else if (setupbutton = 3) and (edit7.enabled) and (edit7.visible) then
      begin
        tempint := edit7.SelStart;
        edit7.text := copy(edit7.text, 1, Edit7.SelStart) + Edit9.Text +
          copy(edit7.text, edit7.SelStart + 1 + edit7.SelLength,
          length(edit7.Text));
        edit7.SetFocus;
        edit7.selstart := tempint + length(edit9.text);
      end
      else if (setupbutton = 4) and (edit8.enabled) and (edit8.visible) then
      begin
        tempint := edit8.SelStart;
        edit8.text := copy(edit8.text, 1, Edit8.SelStart) + Edit9.Text +
          copy(edit8.text, edit8.SelStart + 1 + edit8.SelLength,
          length(edit8.Text));
        edit8.SetFocus;
        edit8.selstart := tempint + length(edit9.text);
      end
      else if (edit5.enabled) and (edit5.visible) then // default to line 1
      begin
        tempint := edit5.SelStart;
        edit5.text := copy(edit5.text, 1, tempint) + Edit9.Text +
          copy(edit5.text, tempint + 1 + edit5.SelLength, length(edit5.Text));
        edit5.SetFocus;
        edit5.selstart := tempint + length(edit9.text);
      end;
    end
    else if (tabsheet12.Visible) then // in Actions tab
    begin
      if (edit17.text='') and (edit9.text='$MObutton') then
      begin
        showmessage ('please press the button you want to bind');
      end
      else
      begin
        if pos('$MObutton', edit9.Text) <> 0 then
          edit9.Text := '$MObutton(' + edit17.text + ')';
        edit16.text := edit9.text;
      end;
    end;
  end;
end;

procedure TSetupForm.ListBox6Click(Sender: TObject);
begin
  if listbox6.itemindex > -1 then
  begin
    if listbox6.itemindex = 0 then Edit9.Text := '$Username';
    if listbox6.itemindex = 1 then Edit9.Text := '$Computername';
    if listbox6.itemindex = 2 then Edit9.Text := '$CPUType';
    if listbox6.itemindex = 3 then Edit9.Text := '$CPUSpeed';
    if listbox6.itemindex = 4 then Edit9.Text := '$CPUUsage%';
    if listbox6.itemindex = 5 then Edit9.Text := '$Bar($CPUUsage%,100,10)';
    if listbox6.itemindex = 6 then Edit9.Text := '$MemFree';
    if listbox6.itemindex = 7 then Edit9.Text := '$MemUsed';
    if listbox6.itemindex = 8 then Edit9.Text := '$MemTotal';
    if listbox6.itemindex = 9 then Edit9.Text := '$MemF%';
    if listbox6.itemindex = 10 then Edit9.Text := '$MemU%';
    if listbox6.itemindex = 11 then Edit9.Text :=
      '$Bar($MemFree,$MemTotal,10)';
    if listbox6.itemindex = 12 then Edit9.Text :=
      '$Bar($MemUsed,$MemTotal,10)';
    if listbox6.itemindex = 13 then Edit9.Text := '$PageFree';
    if listbox6.itemindex = 14 then Edit9.Text := '$PageUsed';
    if listbox6.itemindex = 15 then Edit9.Text := '$PageTotal';
    if listbox6.itemindex = 16 then Edit9.Text := '$PageF%';
    if listbox6.itemindex = 17 then Edit9.Text := '$PageU%';
    if listbox6.itemindex = 18 then Edit9.Text :=
      '$Bar($PageFree,$PageTotal,10)';
    if listbox6.itemindex = 19 then Edit9.Text :=
      '$Bar($PageUsed,$PageTotal,10)';
    if listbox6.itemindex = 20 then Edit9.Text := '$HDFree(C)';
    if listbox6.itemindex = 21 then Edit9.Text := '$HDUsed(C)';
    if listbox6.itemindex = 22 then Edit9.Text := '$HDTotal(C)';
    if listbox6.itemindex = 23 then Edit9.Text := '$HDFreg(C)';
    if listbox6.itemindex = 24 then Edit9.Text := '$HDUseg(C)';
    if listbox6.itemindex = 25 then Edit9.Text := '$HDTotag(C)';
    if listbox6.itemindex = 26 then Edit9.Text := '$HDF%(C)';
    if listbox6.itemindex = 27 then Edit9.Text := '$HDU%(C)';
    if listbox6.itemindex = 28 then Edit9.Text :=
      '$Bar($HDFree(C),$HDTotal(C),10)';
    if listbox6.itemindex = 29 then Edit9.Text :=
      '$Bar($HDUsed(C),$HDTotal(C),10)';
    if listbox6.itemindex = 30 then Edit9.Text := '$ScreenReso';

    FocusToInputField();

  end;
end;

procedure TSetupForm.ListBox5Click(Sender: TObject);
begin
  if listbox5.itemindex > -1 then
  begin
    if listbox5.itemindex = 0 then Edit9.Text := '$Temp1';
    if listbox5.itemindex = 1 then Edit9.Text := '$Temp2';
    if listbox5.itemindex = 2 then Edit9.Text := '$Temp3';
    if listbox5.itemindex = 3 then Edit9.Text := '$Temp4';
    if listbox5.itemindex = 4 then Edit9.Text := '$Temp5';
    if listbox5.itemindex = 5 then Edit9.Text := '$Temp6';
    if listbox5.itemindex = 6 then Edit9.Text := '$Temp7';
    if listbox5.itemindex = 7 then Edit9.Text := '$Temp8';
    if listbox5.itemindex = 8 then Edit9.Text := '$Temp9';
    if listbox5.itemindex = 9 then Edit9.Text := '$Temp10';
    if listbox5.itemindex = 10 then Edit9.Text := '$FanS1';
    if listbox5.itemindex = 11 then Edit9.Text := '$FanS2';
    if listbox5.itemindex = 12 then Edit9.Text := '$FanS3';
    if listbox5.itemindex = 13 then Edit9.Text := '$FanS4';
    if listbox5.itemindex = 14 then Edit9.Text := '$FanS5';
    if listbox5.itemindex = 15 then Edit9.Text := '$FanS6';
    if listbox5.itemindex = 16 then Edit9.Text := '$FanS7';
    if listbox5.itemindex = 17 then Edit9.Text := '$FanS8';
    if listbox5.itemindex = 18 then Edit9.Text := '$FanS9';
    if listbox5.itemindex = 19 then Edit9.Text := '$FanS10';
    if listbox5.itemindex = 20 then Edit9.Text := '$Voltage1';
    if listbox5.itemindex = 21 then Edit9.Text := '$Voltage2';
    if listbox5.itemindex = 22 then Edit9.Text := '$Voltage3';
    if listbox5.itemindex = 23 then Edit9.Text := '$Voltage4';
    if listbox5.itemindex = 24 then Edit9.Text := '$Voltage5';
    if listbox5.itemindex = 25 then Edit9.Text := '$Voltage6';
    if listbox5.itemindex = 26 then Edit9.Text := '$Voltage7';
    if listbox5.itemindex = 27 then Edit9.Text := '$Voltage8';
    if listbox5.itemindex = 28 then Edit9.Text := '$Voltage9';
    if listbox5.itemindex = 29 then Edit9.Text := '$Voltage10';
    if listbox5.itemindex = 30 then Edit9.Text := '$Tempname1';
    if listbox5.itemindex = 31 then Edit9.Text := '$Tempname2';
    if listbox5.itemindex = 32 then Edit9.Text := '$Tempname3';
    if listbox5.itemindex = 33 then Edit9.Text := '$Tempname4';
    if listbox5.itemindex = 34 then Edit9.Text := '$Tempname5';
    if listbox5.itemindex = 35 then Edit9.Text := '$Tempname6';
    if listbox5.itemindex = 36 then Edit9.Text := '$Tempname7';
    if listbox5.itemindex = 37 then Edit9.Text := '$Tempname8';
    if listbox5.itemindex = 38 then Edit9.Text := '$Tempname9';
    if listbox5.itemindex = 39 then Edit9.Text := '$Tempname10';
    if listbox5.itemindex = 40 then Edit9.Text := '$Fanname1';
    if listbox5.itemindex = 41 then Edit9.Text := '$Fanname2';
    if listbox5.itemindex = 42 then Edit9.Text := '$Fanname3';
    if listbox5.itemindex = 43 then Edit9.Text := '$Fanname4';
    if listbox5.itemindex = 44 then Edit9.Text := '$Fanname5';
    if listbox5.itemindex = 45 then Edit9.Text := '$Fanname6';
    if listbox5.itemindex = 46 then Edit9.Text := '$Fanname7';
    if listbox5.itemindex = 47 then Edit9.Text := '$Fanname8';
    if listbox5.itemindex = 48 then Edit9.Text := '$Fanname9';
    if listbox5.itemindex = 49 then Edit9.Text := '$Fanname10';
    if listbox5.itemindex = 50 then Edit9.Text := '$Voltname1';
    if listbox5.itemindex = 51 then Edit9.Text := '$Voltname2';
    if listbox5.itemindex = 52 then Edit9.Text := '$Voltname3';
    if listbox5.itemindex = 53 then Edit9.Text := '$Voltname4';
    if listbox5.itemindex = 54 then Edit9.Text := '$Voltname5';
    if listbox5.itemindex = 55 then Edit9.Text := '$Voltname6';
    if listbox5.itemindex = 56 then Edit9.Text := '$Voltname7';
    if listbox5.itemindex = 57 then Edit9.Text := '$Voltname8';
    if listbox5.itemindex = 58 then Edit9.Text := '$Voltname9';
    if listbox5.itemindex = 59 then Edit9.Text := '$Voltname10';

    FocusToInputField();

  end;
end;

procedure TSetupForm.ListBox2Click(Sender: TObject);
begin
  if listbox2.itemindex > -1 then
  begin
    case listbox2.itemindex of
      0: Edit9.Text :=
   '$Rss(http://news.bbc.co.uk/rss/newsonline_uk_edition/world/rss091.xml,b)'
        ;
      1: Edit9.Text :=
      '$Rss(http://news.bbc.co.uk/rss/newsonline_uk_edition/uk/rss091.xml,b)'
        ;
      2: Edit9.Text := '$Rss(http://www.tweakers.net/feeds/mixed.xml,b)';
      3: Edit9.Text := '$Rss(http://www.theregister.co.uk/headlines.rss,b)';
      4: Edit9.Text := '$Rss(http://slashdot.org/index.rss,b)';
      5: Edit9.Text :=
        '$Rss(http://www.wired.com/news_drop/netcenter/netcenter.rdf,b)';
      6: Edit9.Text :=
        '$Rss(http://www.fool.com/xml/foolnews_rss091.xml,b,1)';
      7: Edit9.Text := '$Rss(http://www.fool.com/xml/foolnews_rss091.xml,b)';
      8: Edit9.Text :=
'$Rss(http://sourceforge.net/export/rss2_projnews.php?group_id=122330&rss_fulltext=1,b,1)'
        ;
      9: Edit9.Text :=
'$Rss(http://sourceforge.net/export/rss2_projnews.php?group_id=2987&rss_fulltext=1,b,1)'
        ;
      10: Edit9.Text :=
'$Rss(http://www.weatherclicks.com/xml/fort+lauderdale,t,2): $Rss(http://www.weatherclicks.com/xml/fort+lauderdale,d,2) | '
        ;
      11: Edit9.Text :=
'$Rss(http://news.bbc.co.uk/rss/newsonline_world_edition/business/rss091.xml,b)'
        ;
      12: Edit9.Text :=
'$Rss(http://www.washingtonpost.com/wp-srv/business/rssheadlines.xml,b)'
        ;
      13: Edit9.Text := '$Rss(http://rss.news.yahoo.com/rss/entertainment,b)';
      14: Edit9.Text := '$Rss(http://partners.userland.com/nytRss/health.xml,b)';
      15: Edit9.Text := '$Rss(http://partners.userland.com/nytRss/sports.xml,b)';
      16: Edit9.Text := '$Rss(http://www.securityfocus.com/rss/news.xml,b)';
      17: Edit9.Text := '$Rss(http://volkskrant.nl/rss/economie.rss,b)';
      18: Edit9.Text := '$Rss(http://www.vpro.nl/3voor12/rss/index.jsp?images=false,b)';
      19: Edit9.Text := '$Rss(http://www.ad.nl/index.xml,b)';
      20: Edit9.Text := '$Rss(http://www.atletiek.nl/rss.xml,b)';
      21: Edit9.Text := '$Rss(http://www.rtl.fr/referencement/rtl.asp,b)';
      22: Edit9.Text := '$Rss(http://www.tagesschau.de/xml/tagesschau-meldungen/,b)';
    end;

{Stock Indexes
Tom's Hardware headlines
Tweakers.net headlines (in dutch)
Weather (Holland)
Weather.com(locationcode)

   if listbox2.itemindex = 1 then Edit9.Text := '$Stocks';
    if listbox2.itemindex = 2 then Edit9.Text := '$TomsHW';
    if listbox2.itemindex = 3 then Edit9.Text := '$T.netHL';
    if listbox2.itemindex = 4 then Edit9.Text := '$DutchWeather';
    if listbox2.itemindex = 5 then Edit9.Text := '$Weather.com(CAXX0504)';
    }

    FocusToInputField();


  end;
end;

procedure TSetupForm.ComboBox6Change(Sender: TObject);
begin
  if listbox8.Itemindex = 1 then
  begin
    if combobox6.itemindex = 0 then Edit9.Text := '$Half-life2';
    if combobox6.itemindex = 1 then Edit9.Text := '$QuakeII2';
    if combobox6.itemindex = 2 then Edit9.Text := '$QuakeIII2';
    if combobox6.itemindex = 3 then Edit9.Text := '$Unreal2';
  end
  else
  begin
    listbox8.ItemIndex := 0;
    if combobox6.itemindex = 0 then Edit9.Text := '$Half-life1';
    if combobox6.itemindex = 1 then Edit9.Text := '$QuakeII1';
    if combobox6.itemindex = 2 then Edit9.Text := '$QuakeIII1';
    if combobox6.itemindex = 3 then Edit9.Text := '$Unreal1';
  end;
end;

procedure TSetupForm.Label16Click(Sender: TObject);
begin
  ShellExecute(0, Nil, pchar('www.qstat.org'), Nil, Nil, SW_NORMAL);
end;

procedure TSetupForm.ListBox1Click(Sender: TObject);
begin
  if listbox1.itemindex > -1 then
  begin
    if listbox1.itemindex = 0 then Edit9.Text := '$DnetSpeed';
    if listbox1.itemindex = 1 then Edit9.Text := '$DnetDone';
    if listbox1.itemindex = 2 then Edit9.Text :=
      '$Time(d mmmm yyyy hh: nn: ss)';
    if listbox1.itemindex = 3 then Edit9.Text := '$UpTime';
    if listbox1.itemindex = 4 then Edit9.Text := '$UpTims';
    if listbox1.itemindex = 5 then Edit9.Text := '°';
    if listbox1.itemindex = 6 then Edit9.Text := 'ž';
    if listbox1.itemindex = 7 then Edit9.Text := '$Chr(20)';
    if listbox1.itemindex = 8 then Edit9.Text := '$File(C:\file.txt,1)';
    if listbox1.itemindex = 9 then Edit9.Text := '$LogFile(C:\file.log,0)';
    if listbox1.itemindex = 10 then Edit9.Text :=
      '$dll(demo.dll,5,param1,param2)';
    if listbox1.itemindex = 11 then Edit9.Text := '$Count(101#$CPUSpeed#4)';
    if listbox1.itemindex = 12 then Edit9.Text := '$Bar(30,100,20)';
    if listbox1.itemindex = 13 then Edit9.Text :=
      '$Right(ins variable(s) here,$3%)';
    if listbox1.itemindex = 14 then Edit9.Text := '$Fill(10)';
    if listbox1.itemindex = 15 then Edit9.Text :=
      '$Flash(insert text here$)$';
    if listbox1.itemindex = 16 then Edit9.Text :=
      '$CustomChar(1, 31, 31, 31, 31, 31, 31, 31, 31)';
    if listbox1.itemindex = 17 then Edit9.Text :=
      '$Rss(URL,t|d|b,ITEM#,MAXFREQHRS)';
    if listbox1.ItemIndex = 18 then Edit9.Text := '$Center(text here,15)';
    if listbox1.ItemIndex = 19 then Edit9.Text := '$ScreenChanged';
    FocusToInputField();

  end;
end;

procedure TSetupForm.ListBox3Click(Sender: TObject);
begin
  if listbox3.itemindex > -1 then
  begin
    if listbox3.itemindex = 0 then Edit9.Text := '$SETIResults';
    if listbox3.itemindex = 1 then Edit9.Text := '$SETICPUTime';
    if listbox3.itemindex = 2 then Edit9.Text := '$SETIAverage';
    if listbox3.itemindex = 3 then Edit9.Text := '$SETILastresult';
    if listbox3.itemindex = 4 then Edit9.Text := '$SETIusertime';
    if listbox3.itemindex = 5 then Edit9.Text := '$SETItotalusers';
    if listbox3.itemindex = 6 then Edit9.Text := '$SETIrank';
    if listbox3.itemindex = 7 then Edit9.Text := '$SETIsharingrank';
    if listbox3.itemindex = 8 then Edit9.Text := '$SETImoreWU%';

    FocusToInputField();
  end;
end;

procedure TSetupForm.PageControl1Change(Sender: TObject);
begin
  if Pagecontrol1.ActivePage = Tabsheet1 then
  begin
    if listbox7.itemindex > -1 then
    begin
      if listbox7.itemindex = 0 then Edit9.Text := '$WinampTitle';
      if listbox7.itemindex = 1 then Edit9.Text := '$WinampChannels';
      if listbox7.itemindex = 2 then Edit9.Text := '$WinampKBPS';
      if listbox7.itemindex = 3 then Edit9.Text := '$WinampFreq';
      if listbox7.itemindex = 4 then Edit9.Text := '$Winamppos';
      if listbox7.itemindex = 5 then Edit9.Text := '$WinampPolo';
      if listbox7.itemindex = 6 then Edit9.Text := '$WinampPosh';
      if listbox7.itemindex = 7 then Edit9.Text := '$WinampRem';
      if listbox7.itemindex = 8 then Edit9.Text := '$WinampRelo';
      if listbox7.itemindex = 9 then Edit9.Text := '$WinampResh';
      if listbox7.itemindex = 10 then Edit9.Text := '$WinampLength';
      if listbox7.itemindex = 11 then Edit9.Text := '$WinampLengtl';
      if listbox7.itemindex = 12 then Edit9.Text := '$WinampLengts';
      if listbox7.itemindex = 13 then Edit9.Text := '$WinampPosition(10)';
      if listbox7.itemindex = 14 then Edit9.Text := '$WinampTracknr';
      if listbox7.itemindex = 15 then Edit9.Text := '$WinampTotalTracks';
      if listbox7.itemindex = 16 then Edit9.Text := '$WinampStat';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet2 then
  begin
    if listbox6.itemindex > -1 then
    begin
      if listbox6.itemindex = 0 then Edit9.Text := '$Username';
      if listbox6.itemindex = 1 then Edit9.Text := '$Computername';
      if listbox6.itemindex = 2 then Edit9.Text := '$CPUType';
      if listbox6.itemindex = 3 then Edit9.Text := '$CPUSpeed';
      if listbox6.itemindex = 4 then Edit9.Text := '$CPUUsage%';
      if listbox6.itemindex = 5 then Edit9.Text :=
        '$Bar($CPUUsage%,100,10)';
      if listbox6.itemindex = 6 then Edit9.Text := '$MemFree';
      if listbox6.itemindex = 7 then Edit9.Text := '$MemUsed';
      if listbox6.itemindex = 8 then Edit9.Text := '$MemTotal';
      if listbox6.itemindex = 9 then Edit9.Text := '$MemF%';
      if listbox6.itemindex = 10 then Edit9.Text := '$MemU%';
      if listbox6.itemindex = 11 then Edit9.Text :=
        '$Bar($MemFree,$MemTotal,10)';
      if listbox6.itemindex = 12 then Edit9.Text :=
        '$Bar($MemUsed,$MemTotal,10)';
      if listbox6.itemindex = 13 then Edit9.Text := '$PageFree';
      if listbox6.itemindex = 14 then Edit9.Text := '$PageUsed';
      if listbox6.itemindex = 15 then Edit9.Text := '$PageTotal';
      if listbox6.itemindex = 16 then Edit9.Text := '$PageF%';
      if listbox6.itemindex = 17 then Edit9.Text := '$PageU%';
      if listbox6.itemindex = 18 then Edit9.Text :=
        '$Bar($PageFree,$PageTotal,10)';
      if listbox6.itemindex = 19 then Edit9.Text :=
        '$Bar($PageUsed,$PageTotal,10)';
      if listbox6.itemindex = 20 then Edit9.Text := '$HDFree(C)';
      if listbox6.itemindex = 21 then Edit9.Text := '$HDUsed(C)';
      if listbox6.itemindex = 22 then Edit9.Text := '$HDTotal(C)';
      if listbox6.itemindex = 23 then Edit9.Text := '$HDFreg(C)';
      if listbox6.itemindex = 24 then Edit9.Text := '$HDUseg(C)';
      if listbox6.itemindex = 25 then Edit9.Text := '$HDTotag(C)';
      if listbox6.itemindex = 26 then Edit9.Text := '$HDF%(C)';
      if listbox6.itemindex = 27 then Edit9.Text := '$HDU%(C)';
      if listbox6.itemindex = 28 then Edit9.Text :=
        '$Bar($HDFree(C),$HDTotal(C),10)';
      if listbox6.itemindex = 29 then Edit9.Text :=
        '$Bar($HDUsed(C),$HDTotal(C),10)';
      if listbox6.itemindex = 30 then Edit9.Text := '$ScreenReso';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet3 then
  begin
    if listbox5.itemindex > -1 then
    begin
      if listbox5.itemindex = 0 then Edit9.Text := '$Temp1';
      if listbox5.itemindex = 1 then Edit9.Text := '$Temp2';
      if listbox5.itemindex = 2 then Edit9.Text := '$Temp3';
      if listbox5.itemindex = 3 then Edit9.Text := '$Temp4';
      if listbox5.itemindex = 4 then Edit9.Text := '$Temp5';
      if listbox5.itemindex = 5 then Edit9.Text := '$Temp6';
      if listbox5.itemindex = 6 then Edit9.Text := '$Temp7';
      if listbox5.itemindex = 7 then Edit9.Text := '$Temp8';
      if listbox5.itemindex = 8 then Edit9.Text := '$Temp9';
      if listbox5.itemindex = 9 then Edit9.Text := '$Temp10';
      if listbox5.itemindex = 10 then Edit9.Text := '$FanS1';
      if listbox5.itemindex = 11 then Edit9.Text := '$FanS2';
      if listbox5.itemindex = 12 then Edit9.Text := '$FanS3';
      if listbox5.itemindex = 13 then Edit9.Text := '$FanS4';
      if listbox5.itemindex = 14 then Edit9.Text := '$FanS5';
      if listbox5.itemindex = 15 then Edit9.Text := '$FanS6';
      if listbox5.itemindex = 16 then Edit9.Text := '$FanS7';
      if listbox5.itemindex = 17 then Edit9.Text := '$FanS8';
      if listbox5.itemindex = 18 then Edit9.Text := '$FanS9';
      if listbox5.itemindex = 19 then Edit9.Text := '$FanS10';
      if listbox5.itemindex = 20 then Edit9.Text := '$Voltage1';
      if listbox5.itemindex = 21 then Edit9.Text := '$Voltage2';
      if listbox5.itemindex = 22 then Edit9.Text := '$Voltage3';
      if listbox5.itemindex = 23 then Edit9.Text := '$Voltage4';
      if listbox5.itemindex = 24 then Edit9.Text := '$Voltage5';
      if listbox5.itemindex = 25 then Edit9.Text := '$Voltage6';
      if listbox5.itemindex = 26 then Edit9.Text := '$Voltage7';
      if listbox5.itemindex = 27 then Edit9.Text := '$Voltage8';
      if listbox5.itemindex = 28 then Edit9.Text := '$Voltage9';
      if listbox5.itemindex = 29 then Edit9.Text := '$Voltage10';
      if listbox5.itemindex = 30 then Edit9.Text := '$Tempname1';
      if listbox5.itemindex = 31 then Edit9.Text := '$Tempname2';
      if listbox5.itemindex = 32 then Edit9.Text := '$Tempname3';
      if listbox5.itemindex = 33 then Edit9.Text := '$Tempname4';
      if listbox5.itemindex = 34 then Edit9.Text := '$Tempname5';
      if listbox5.itemindex = 35 then Edit9.Text := '$Tempname6';
      if listbox5.itemindex = 36 then Edit9.Text := '$Tempname7';
      if listbox5.itemindex = 37 then Edit9.Text := '$Tempname8';
      if listbox5.itemindex = 38 then Edit9.Text := '$Tempname9';
      if listbox5.itemindex = 39 then Edit9.Text := '$Tempname10';
      if listbox5.itemindex = 40 then Edit9.Text := '$Fanname1';
      if listbox5.itemindex = 41 then Edit9.Text := '$Fanname2';
      if listbox5.itemindex = 42 then Edit9.Text := '$Fanname3';
      if listbox5.itemindex = 43 then Edit9.Text := '$Fanname4';
      if listbox5.itemindex = 44 then Edit9.Text := '$Fanname5';
      if listbox5.itemindex = 45 then Edit9.Text := '$Fanname6';
      if listbox5.itemindex = 46 then Edit9.Text := '$Fanname7';
      if listbox5.itemindex = 47 then Edit9.Text := '$Fanname8';
      if listbox5.itemindex = 48 then Edit9.Text := '$Fanname9';
      if listbox5.itemindex = 49 then Edit9.Text := '$Fanname10';
      if listbox5.itemindex = 50 then Edit9.Text := '$Voltname1';
      if listbox5.itemindex = 51 then Edit9.Text := '$Voltname2';
      if listbox5.itemindex = 52 then Edit9.Text := '$Voltname3';
      if listbox5.itemindex = 53 then Edit9.Text := '$Voltname4';
      if listbox5.itemindex = 54 then Edit9.Text := '$Voltname5';
      if listbox5.itemindex = 55 then Edit9.Text := '$Voltname6';
      if listbox5.itemindex = 56 then Edit9.Text := '$Voltname7';
      if listbox5.itemindex = 57 then Edit9.Text := '$Voltname8';
      if listbox5.itemindex = 58 then Edit9.Text := '$Voltname9';
      if listbox5.itemindex = 59 then Edit9.Text := '$Voltname10';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet13 then
  begin
    //if radiobutton2.Checked = false then pagecontrol1.ActivePage := Tabsheet1;
    if listbox12.itemindex > -1 then
    begin
      if listbox12.itemindex = 0 then Edit9.Text := '$MObutton';
      if listbox12.itemindex = 1 then Edit9.Text := '$FanSpeed(1,1)';
      if listbox12.itemindex = 2 then Edit9.Text := '$Sensor1';
      if listbox12.itemindex = 3 then Edit9.Text := '$Sensor2';
      if listbox12.itemindex = 4 then Edit9.Text := '$Sensor3';
      if listbox12.itemindex = 5 then Edit9.Text := '$Sensor4';
      if listbox12.itemindex = 6 then Edit9.Text := '$Sensor5';
      if listbox12.itemindex = 7 then Edit9.Text := '$Sensor6';
      if listbox12.itemindex = 8 then Edit9.Text := '$Sensor7';
      if listbox12.itemindex = 9 then Edit9.Text := '$Sensor8';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet5 then
  begin
    if listbox8.itemindex <= -1 then edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet6 then
  begin
    if listbox2.itemindex > -1 then
    begin
      if listbox2.itemindex = 0 then Edit9.Text := '$CNN';
      if listbox2.itemindex = 1 then Edit9.Text := '$Stocks';
      if listbox2.itemindex = 2 then Edit9.Text := '$TomsHW';
      if listbox2.itemindex = 3 then Edit9.Text := '$T.netHL';
      if listbox2.itemindex = 4 then Edit9.Text := '$DutchWeather';
      if listbox2.itemindex = 5 then Edit9.Text := '$Weather.com(CAXX0504)';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet7 then
  begin
    if listbox1.itemindex > -1 then
    begin
      if listbox1.itemindex = 0 then Edit9.Text := '$DnetSpeed';
      if listbox1.itemindex = 1 then Edit9.Text := '$DnetDone';
      if listbox1.itemindex = 2 then Edit9.Text :=
        '$Time(d mmmm yyyy hh: nn: ss)';
      if listbox1.itemindex = 3 then Edit9.Text := '$UpTime';
      if listbox1.itemindex = 4 then Edit9.Text := '$UpTims';
      if listbox1.itemindex = 5 then Edit9.Text := '°';
      if listbox1.itemindex = 6 then Edit9.Text := 'ž';
      if listbox1.itemindex = 7 then Edit9.Text := '$Chr(20)';
      if listbox1.itemindex = 8 then Edit9.Text := '$File(C:\file.txt,1)';
      if listbox1.itemindex = 9 then Edit9.Text :=
        '$LogFile("C:\file.log",0)';
      if listbox1.itemindex = 10 then Edit9.Text :=
        '$dll(demo.dll,5,param1,param2)';
      if listbox1.itemindex = 11 then Edit9.Text := '$Count(101#$CPUSpeed#4)';
      if listbox1.itemindex = 12 then Edit9.Text := '$Bar(30,100,20)';
      if listbox1.itemindex = 13 then Edit9.Text :=
        '$Right(ins variable(s) here,$3%)';
      if listbox1.itemindex = 14 then Edit9.Text := '$Fill(10)';
      if listbox1.itemindex = 15 then Edit9.Text :=
        '$Flash(insert text here$)$';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet8 then
  begin
    if listbox3.itemindex > -1 then
    begin
      if listbox3.itemindex = 0 then Edit9.Text := '$SETIResults';
      if listbox3.itemindex = 1 then Edit9.Text := '$SETICPUTime';
      if listbox3.itemindex = 2 then Edit9.Text := '$SETIAverage';
      if listbox3.itemindex = 3 then Edit9.Text := '$SETILastresult';
      if listbox3.itemindex = 4 then Edit9.Text := '$SETIusertime';
      if listbox3.itemindex = 5 then Edit9.Text := '$SETItotalusers';
      if listbox3.itemindex = 6 then Edit9.Text := '$SETIrank';
      if listbox3.itemindex = 7 then Edit9.Text := '$SETIsharingrank';
      if listbox3.itemindex = 8 then Edit9.Text := '$SETImoreWU%';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet10 then
  begin
    if listbox10.itemindex > -1 then
    begin
      if listbox10.itemindex = 0 then Edit9.Text := '$FOLDmemsince';
      if listbox10.itemindex = 1 then Edit9.Text := '$FOLDlastwu';
      if listbox10.itemindex = 2 then Edit9.Text := '$FOLDactproc';
      if listbox10.itemindex = 3 then Edit9.Text := '$FOLDteam';
      if listbox10.itemindex = 4 then Edit9.Text := '$FOLDscore';
      if listbox10.itemindex = 5 then Edit9.Text := '$FOLDrank';
      if listbox10.itemindex = 6 then Edit9.Text := '$FOLDwu';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet4 then
  begin
    if listbox4.itemindex > -1 then
    begin
      if listbox4.itemindex = 0 then Edit9.Text := '$Email1';
      if listbox4.itemindex = 1 then Edit9.Text := '$Email2';
      if listbox4.itemindex = 2 then Edit9.Text := '$Email3';
      if listbox4.itemindex = 3 then Edit9.Text := '$Email4';
      if listbox4.itemindex = 4 then Edit9.Text := '$Email5';
      if listbox4.itemindex = 5 then Edit9.Text := '$Email6';
      if listbox4.itemindex = 6 then Edit9.Text := '$Email7';
      if listbox4.itemindex = 7 then Edit9.Text := '$Email8';
      if listbox4.itemindex = 8 then Edit9.Text := '$Email9';
      if listbox4.itemindex = 9 then Edit9.Text := '$Email0';
    end
    else edit9.text := 'Variable: ';
  end;
  if Pagecontrol1.ActivePage = Tabsheet9 then
  begin
    if listbox9.itemindex > -1 then
    begin
      if listbox9.itemindex = 0 then Edit9.Text := '$NetAdapter(1)';
      if listbox9.itemindex = 1 then Edit9.Text := '$NetDownK(1)';
      if listbox9.itemindex = 2 then Edit9.Text := '$NetUpK(1)';
      if listbox9.itemindex = 3 then Edit9.Text := '$NetDownM(1)';
      if listbox9.itemindex = 4 then Edit9.Text := '$NetUpM(1)';
      if listbox9.itemindex = 5 then Edit9.Text := '$NetDownG(1)';
      if listbox9.itemindex = 6 then Edit9.Text := '$NetUpG(1)';
      if listbox9.itemindex = 7 then Edit9.Text := '$NetSpDownK(1)';
      if listbox9.itemindex = 8 then Edit9.Text := '$NetSpUpK(1)';
      if listbox9.itemindex = 9 then Edit9.Text := '$NetSpDownM(1)';
      if listbox9.itemindex = 10 then Edit9.Text := '$NetSpUpM(1)';
      if listbox9.itemindex = 11 then Edit9.Text := '$NetErrDown(1)';
      if listbox9.itemindex = 12 then Edit9.Text := '$NetErrUp(1)';
      if listbox9.itemindex = 13 then Edit9.Text := '$NetErrTot(1)';
      if listbox9.itemindex = 14 then Edit9.Text := '$NetUniDown(1)';
      if listbox9.itemindex = 15 then Edit9.Text := '$NetUniUp(1)';
      if listbox9.itemindex = 16 then Edit9.Text := '$NetUniTot(1)';
      if listbox9.itemindex = 17 then Edit9.Text := '$NetNuniDown(1)';
      if listbox9.itemindex = 18 then Edit9.Text := '$NetNuniUp(1)';
      if listbox9.itemindex = 19 then Edit9.Text := '$NetNuniTot(1)';
      if listbox9.itemindex = 20 then Edit9.Text := '$NetPackTot(1)';
      if listbox9.itemindex = 21 then Edit9.Text := '$NetDiscDown(1)';
      if listbox9.itemindex = 22 then Edit9.Text := '$NetDiscUp(1)';
      if listbox9.itemindex = 23 then Edit9.Text := '$NetDiscTot(1)';
      if listbox9.itemindex = 24 then Edit9.Text := '$NetIPaddress';
    end
    else edit9.text := 'Variable: ';
  end;
end;


procedure TSetupForm.Edit10Exit(Sender: TObject);
begin
  if (combobox3.itemIndex >= 0 ) and
     (setupbutton >= 0) and (setupbutton <= 4) then
  begin
    config.gameServer[combobox3.itemindex + 1, setupbutton] := edit10.text;
  end;
end;

procedure TSetupForm.Button4Click(Sender: TObject);
begin
  if (not config.isMO) then
  begin
    if MessageDlg('The Matrix Orbital driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      button7.click();
    end;
  end;
  DoMatrixOrbitalSetupForm;
end;

procedure TSetupForm.SpeedButton1Click(Sender: TObject);
var
  line, line2: String;

begin
  line := edit14.text;
  line2 := '';
  while pos('\', line) <> 0 do
  begin
    line2 := line2 + copy(line, 1, pos('\', line));
    line := copy(line, pos('\', line) + 1, length(line));
  end;
  opendialog2.InitialDir := line2;
  opendialog2.FileName := edit14.text;
  Opendialog2.Execute;
  if opendialog2.FileName <> '' then edit14.text := opendialog2.FileName;
end;

procedure TSetupForm.ListBox4Click(Sender: TObject);
begin
  if listbox4.itemindex > -1 then
  begin
    case listbox4.itemindex of
      0: Edit9.Text := '$Email1';
      1: Edit9.Text := '$EmailSub1';
      2: Edit9.Text := '$EmailFrom1';
      3: Edit9.Text := '$Email2';
      4: Edit9.Text := '$EmailSub2';
      5: Edit9.Text := '$EmailFrom2';
      6: Edit9.Text := '$Email3';
      7: Edit9.Text := '$EmailSub3';
      8: Edit9.Text := '$EmailFrom3';
      9: Edit9.Text := '$Email4';
      10: Edit9.Text := '$EmailSub4';
      11: Edit9.Text := '$EmailFrom4';
      12: Edit9.Text := '$Email5';
      13: Edit9.Text := '$EmailSub5';
      14: Edit9.Text := '$EmailFrom5';
      15: Edit9.Text := '$Email6';
      16: Edit9.Text := '$EmailSub6';
      17: Edit9.Text := '$EmailFrom6';
      18: Edit9.Text := '$Email7';
      19: Edit9.Text := '$EmailSub7';
      20: Edit9.Text := '$EmailFrom7';
      21: Edit9.Text := '$Email8';
      22: Edit9.Text := '$EmailSub8';
      23: Edit9.Text := '$EmailFrom8';
      24: Edit9.Text := '$Email9';
      25: Edit9.Text := '$EmailSub9';
      26: Edit9.Text := '$EmailFrom9';
      27: Edit9.Text := '$Email0';
      28: Edit9.Text := '$EmailSub0';
      29: Edit9.Text := '$EmailFrom0';
    end;

    FocusToInputField();

  end;
end;

procedure TSetupForm.ComboBox8Change(Sender: TObject);

begin
  config.pop[(combobox8temp + 1) mod 10].server := edit11.text;
  config.pop[(combobox8temp + 1) mod 10].user := edit12.text;
  config.pop[(combobox8temp + 1) mod 10].pword := edit13.text;

  if combobox8.itemIndex < 0 then combobox8.itemindex := 0;

  combobox8temp := combobox8.itemindex;
  edit11.text := config.pop[(combobox8temp + 1) mod 10].server;
  edit12.text := config.pop[(combobox8temp + 1) mod 10].user;
  edit13.text := config.pop[(combobox8temp + 1) mod 10].pword;
end;

procedure TSetupForm.CheckBox7Click(Sender: TObject);
var
  tempint1: Integer;

begin
  if checkbox7.checked = true then
  begin
    checkbox3.Checked := true;
    checkbox3.enabled := false;
    if setupbutton = 2 then
    begin
      tempint1 := edit5.SelStart;
      edit5.setfocus;
      edit5.SelStart := tempint1;
    end;
    edit6.enabled := false;
    edit6.color := $00BBBBFF;
  end
  else
  begin
    checkbox3.enabled := true;
    checkbox3.checked := false;
    edit6.enabled := true;
    edit6.color := clWhite;
  end;
end;

procedure TSetupForm.CheckBox8Click(Sender: TObject);
var
  tempint1: Integer;

begin
  if checkbox8.checked = true then
  begin
    checkbox4.Checked := true;
    checkbox4.enabled := false;
    if setupbutton = 3 then
    begin
      tempint1 := edit5.SelStart;
      edit5.setfocus;
      edit5.SelStart := tempint1;
    end;
    edit7.enabled := false;
    edit7.color := $00BBBBFF;
  end
  else
  begin
    checkbox4.enabled := true;
    checkbox4.checked := false;
    edit7.enabled := true;
    edit7.color := clWhite;
  end;
end;

procedure TSetupForm.CheckBox9Click(Sender: TObject);
var
  tempint1: Integer;

begin
  if checkbox9.checked = true then
  begin
    checkbox5.Checked := true;
    checkbox5.enabled := false;
    if setupbutton = 4 then
    begin
      tempint1 := edit5.SelStart;
      edit5.setfocus;
      edit5.SelStart := tempint1;
    end;
    edit8.enabled := false;
    edit8.color := $00BBBBFF;
  end
  else
  begin
    checkbox5.enabled := true;
    checkbox5.checked := false;
    edit8.enabled := true;
    edit8.color := clWhite;
  end;
end;

procedure TSetupForm.SpeedButton3Click(Sender: TObject);
begin
  opendialog1.Execute;
  if opendialog1.FileName <> '' then edit15.text := opendialog1.FileName;
end;

procedure TSetupForm.Button5Click(Sender: TObject);
begin
 if (not config.isCF) then
  begin
    if MessageDlg('The Crystalfontz driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      button7.click();
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
      button7.click();
    end;
  end;
  if DoIRTransForm then begin
    config.isIR := false;  // force a reload with a potential new hostname
    button7.click();
  end;
end;

procedure TSetupForm.ListBox8Click(Sender: TObject);
begin
  if listbox8.Itemindex = 0 then
  begin
    if combobox6.itemindex = 0 then Edit9.Text := '$Half-life1';
    if combobox6.itemindex = 1 then Edit9.Text := '$QuakeII1';
    if combobox6.itemindex = 2 then Edit9.Text := '$QuakeIII1';
    if combobox6.itemindex = 3 then Edit9.Text := '$Unreal1';
  end;
  if listbox8.Itemindex = 1 then
  begin
    if combobox6.itemindex = 0 then Edit9.Text := '$Half-life2';
    if combobox6.itemindex = 1 then Edit9.Text := '$QuakeII2';
    if combobox6.itemindex = 2 then Edit9.Text := '$QuakeIII2';
    if combobox6.itemindex = 3 then Edit9.Text := '$Unreal2';
  end;
  if listbox8.Itemindex = 2 then
  begin
    if combobox6.itemindex = 0 then Edit9.Text := '$Half-life3';
    if combobox6.itemindex = 1 then Edit9.Text := '$QuakeII3';
    if combobox6.itemindex = 2 then Edit9.Text := '$QuakeIII3';
    if combobox6.itemindex = 3 then Edit9.Text := '$Unreal3';
  end;
  if listbox8.Itemindex = 3 then
  begin
    if combobox6.itemindex = 0 then Edit9.Text := '$Half-life4';
    if combobox6.itemindex = 1 then Edit9.Text := '$QuakeII4';
    if combobox6.itemindex = 2 then Edit9.Text := '$QuakeIII4';
    if combobox6.itemindex = 3 then Edit9.Text := '$Unreal4';
  end;

  FocusToInputField();

end;


procedure TSetupForm.Edit5Enter(Sender: TObject);
begin
  edit10.text := config.gameServer[combobox3.itemindex + 1, 1];
  setupbutton := 1;
  edit5.color := $00A1D7A4;
  if edit6.enabled= true then edit6.color := clWhite
  else edit6.color := $00BBBBFF;
  if edit7.enabled= true then edit7.color := clWhite
  else edit7.color := $00BBBBFF;
  if edit8.enabled= true then edit8.color := clWhite
  else edit8.color := $00BBBBFF;
end;

procedure TSetupForm.Edit6Enter(Sender: TObject);
begin
  edit10.text := config.gameServer[combobox3.itemindex + 1, 2];
  setupbutton := 2;
  edit6.color := $00A1D7A4;
  if edit5.enabled= true then edit5.color := clWhite
  else edit5.color := $00BBBBFF;
  if edit7.enabled= true then edit7.color := clWhite
  else edit7.color := $00BBBBFF;
  if edit8.enabled= true then edit8.color := clWhite
  else edit8.color := $00BBBBFF;
end;

procedure TSetupForm.Edit7Enter(Sender: TObject);
begin
  edit10.text := config.gameServer[combobox3.itemindex + 1, 3];
  setupbutton := 3;
  edit7.color := $00A1D7A4;
  if edit6.enabled= true then edit6.color := clWhite
  else edit6.color := $00BBBBFF;
  if edit5.enabled= true then edit5.color := clWhite
  else edit5.color := $00BBBBFF;
  if edit8.enabled= true then edit8.color := clWhite
  else edit8.color := $00BBBBFF;
end;

procedure TSetupForm.Edit8Enter(Sender: TObject);
begin
  edit10.text := config.gameServer[combobox3.itemindex + 1, 4];
  setupbutton := 4;
  edit8.color := $00A1D7A4;
  if edit6.enabled= true then edit6.color := clWhite
  else edit6.color := $00BBBBFF;
  if edit7.enabled= true then edit7.color := clWhite
  else edit7.color := $00BBBBFF;
  if edit5.enabled= true then edit5.color := clWhite
  else edit5.color := $00BBBBFF;
end;

procedure TSetupForm.ListBox9Click(Sender: TObject);
begin
  if listbox9.itemindex > -1 then
  begin
    if listbox9.itemindex = 0 then Edit9.Text := '$NetAdapter(1)';
    if listbox9.itemindex = 1 then Edit9.Text := '$NetDownK(1)';
    if listbox9.itemindex = 2 then Edit9.Text := '$NetUpK(1)';
    if listbox9.itemindex = 3 then Edit9.Text := '$NetDownM(1)';
    if listbox9.itemindex = 4 then Edit9.Text := '$NetUpM(1)';
    if listbox9.itemindex = 5 then Edit9.Text := '$NetDownG(1)';
    if listbox9.itemindex = 6 then Edit9.Text := '$NetUpG(1)';
    if listbox9.itemindex = 7 then Edit9.Text := '$NetSpDownK(1)';
    if listbox9.itemindex = 8 then Edit9.Text := '$NetSpUpK(1)';
    if listbox9.itemindex = 9 then Edit9.Text := '$NetSpDownM(1)';
    if listbox9.itemindex = 10 then Edit9.Text := '$NetSpUpM(1)';
    if listbox9.itemindex = 11 then Edit9.Text := '$NetErrDown(1)';
    if listbox9.itemindex = 12 then Edit9.Text := '$NetErrUp(1)';
    if listbox9.itemindex = 13 then Edit9.Text := '$NetErrTot(1)';
    if listbox9.itemindex = 14 then Edit9.Text := '$NetUniDown(1)';
    if listbox9.itemindex = 15 then Edit9.Text := '$NetUniUp(1)';
    if listbox9.itemindex = 16 then Edit9.Text := '$NetUniTot(1)';
    if listbox9.itemindex = 17 then Edit9.Text := '$NetNuniDown(1)';
    if listbox9.itemindex = 18 then Edit9.Text := '$NetNuniUp(1)';
    if listbox9.itemindex = 19 then Edit9.Text := '$NetNuniTot(1)';
    if listbox9.itemindex = 20 then Edit9.Text := '$NetPackTot(1)';
    if listbox9.itemindex = 21 then Edit9.Text := '$NetDiscDown(1)';
    if listbox9.itemindex = 22 then Edit9.Text := '$NetDiscUp(1)';
    if listbox9.itemindex = 23 then Edit9.Text := '$NetDiscTot(1)';
    if listbox9.itemindex = 24 then Edit9.Text := '$NetIPaddress';

    FocusToInputField();
  end;
end;

procedure TSetupForm.Button6Click(Sender: TObject);
begin
 if (not config.isHD) then
  begin
    if MessageDlg('The HD44780 driver is not currently loaded.' + chr(13) +
      'Should I apply your settings and load the driver?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // press apply for them
      button7.click();
    end;
  end;
  if DoHD44780SetupForm then
    config.isHD := false;  // force reload
end;

procedure TSetupForm.ListBox10Click(Sender: TObject);
begin
  if listbox10.itemindex > -1 then
  begin
    if listbox10.itemindex = 0 then Edit9.Text := '$FOLDwu';
    if listbox10.itemindex = 1 then Edit9.Text := '$FOLDlastwu';
    if listbox10.itemindex = 2 then Edit9.Text := '$FOLDactproc';
    if listbox10.itemindex = 3 then Edit9.Text := '$FOLDteam';
    if listbox10.itemindex = 4 then Edit9.Text := '$FOLDscore';
    if listbox10.itemindex = 5 then Edit9.Text := '$FOLDrank';

    FocusToInputField();

  end;
end;


// Apply pressed.
procedure TSetupForm.Button7Click(Sender: TObject);
var
  relood: Boolean;
  x: Integer;
  sComPort: String;
  iMaxUsedRow: Integer;

begin
  relood := false;

  if (comboBox4.items[combobox4.itemIndex] = USBPALM)
    and (radiobutton3.checked) then
  begin
    showmessage('Matrix Orbital must be selected if USB Palm is selected.');
    Exit;
  end;

  iMaxUsedRow := -1;
  for x := 0 to StringGrid1.RowCount-1 do
  begin
    if (Stringgrid1.cells[0, x] <> '') and (Stringgrid1.cells[4,
      x] <> '') then
    begin
        iMaxUsedRow := x;
        config.actionsArray[x + 1, 1] := StringGrid1.Cells[0, x];

        if StringGrid1.Cells[1, x]='>' then
           config.actionsArray[x + 1, 2] := '0';
        if StringGrid1.Cells[1, x]='<' then
           config.actionsArray[x + 1, 2] := '1';
        if StringGrid1.Cells[1, x]='=' then
           config.actionsArray[x + 1, 2] := '2';
        if StringGrid1.Cells[1, x]='<=' then
           config.actionsArray[x + 1, 2] := '3';
        if StringGrid1.Cells[1, x]='>=' then
           config.actionsArray[x + 1, 2] := '4';
        if StringGrid1.Cells[1, x]='<>' then
           config.actionsArray[x + 1, 2] := '5';

        config.actionsArray[x + 1, 3] := StringGrid1.Cells[2, x];
        config.actionsArray[x + 1, 4] := StringGrid1.Cells[4, x];
    end;
  end;
  config.totalactions := iMaxUsedRow + 1;

  // Check if Com settings have changed.
  sComPort := comboBox4.items[comboBox4.itemIndex];
  if (config.isUsbPalm) <> (sComPort = USBPALM) then
  begin
    relood := true;
  end
  else if (MidStr(sComPort, 1, 3) = 'COM')
      and (StrToInt(MidStr(sComPort, 4, length(sComPort)-3)) <> config.comPort) then
  begin
      relood := true;
  end;

  if (config.baudrate <> combobox5.itemindex) then relood := true;
  if (radiobutton1.checked) and (not config.isHD) then relood := true;
  if (radiobutton2.checked) and (not config.isMO) then relood := true;
  if (radiobutton3.checked) and (not config.isCF) then relood := true;
  if (radiobutton4.checked) and (not config.isHD2) then relood := true;
  if (IRTransRadioButton.checked) and (not config.isIR) then relood := true;


  LCDSmartieDisplayForm.WinampCtrl1.WinampLocation := edit15.text;
  config.winampLocation := edit15.text;
  config.refreshRate := StrToInt(spinEdit1.text);
  config.setiEmail := edit1.text;

  config.sizeOption := combobox2.itemindex + 1;
  config.randomScreens := checkbox14.checked;
  config.newsRefresh := StrToInt(spinedit3.text);
  config.foldUsername := edit2.text;
  config.gameRefresh := StrToInt(spinedit5.text);
  config.checkUpdates := checkbox15.checked;
  config.mbmRefresh := StrToInt(spinedit6.text);
  config.colorOption := combobox1.itemindex;
  config.distLog := edit14.text;
  config.dllPeriod := SpinEdit8.value;
  config.emailPeriod := StrToInt(SpinEdit4.text);
  config.scrollPeriod := SpinEdit9.value;
  config.alwaysOnTop := checkbox2.checked;
  config.bHideOnStartup := HideOnStartup.Checked;
  config.bAutoStart := AutoStart.checked;
  config.bAutoStartHide := AutoStartHide.checked;

  LCDSmartieDisplayForm.SetupAutoStart();

  // Check if Com settings have changed.
  sComPort := comboBox4.items[comboBox4.itemIndex];
  config.isUsbPalm := (sComPort = USBPALM);
  if (not config.isUsbPalm) then
  begin
    config.comPort := StrToInt( midstr(sComPort, 4, length(sComPort)-3));
  end;

  config.baudrate := combobox5.itemindex;
  config.pop[(combobox8.itemindex + 1) mod 10].server := edit11.text;
  config.pop[(combobox8.itemindex + 1) mod 10].user := edit12.text;
  config.pop[(combobox8.itemindex + 1) mod 10].pword := edit13.text;

  config.isHD := radiobutton1.checked;
  config.isMO := radiobutton2.checked;
  config.isCF := radiobutton3.checked;
  config.isHD2 := radiobutton4.checked;
  config.isIR := IRTransRadioButton.checked;

  if edit4.text='' then edit4.text := '0';
  config.httpProxy := edit3.text;
  config.httpProxyPort := StrToInt(edit4.text);

  SaveScreen(combobox3.itemindex + 1);
  LCDSmartieDisplayForm.timer2.interval := 1000;
  LCDSmartieDisplayForm.timer8.interval := 1000;
  LCDSmartieDisplayForm.timer6.interval := 1000;
  LCDSmartieDisplayForm.timer12.interval := config.scrollPeriod;
  LCDSmartieDisplayForm.timer9.interval := 800;

  config.save();

  if relood = true then
  begin
    LCDSmartieDisplayForm.ReInitLCD();
  end;

end;

// ok has been pressed.
procedure TSetupForm.Button1Click(Sender: TObject);
begin
  if (comboBox4.items[combobox4.itemIndex] = USBPALM)
    and (radiobutton3.checked) then
  begin
    showmessage('Matrix Orbital must be selected if USB Palm is selected.');
    Exit;
  end;

  // ok is the same as apply followed by cancel.
  button7.click();

  CancelButton.Click()
end;

procedure TSetupForm.FormCreate(Sender: TObject);
begin
  StringGrid1.RowCount := 0;
  StringGrid1.ColWidths[0] := 116;
  StringGrid1.ColWidths[1] := 20;
  StringGrid1.ColWidths[2] := 56;
  StringGrid1.ColWidths[3] := 36;
  StringGrid1.ColWidths[4] := 156;
end;

procedure TSetupForm.ListBox11Click(Sender: TObject);
begin
  if listbox11.itemindex = 0 then Edit18.Text := 'NextTheme';
  if listbox11.itemindex = 1 then Edit18.Text := 'LastTheme';
  if listbox11.itemindex = 2 then Edit18.Text := 'NextScreen';
  if listbox11.itemindex = 3 then Edit18.Text := 'LastScreen';
  if listbox11.itemindex = 4 then Edit18.Text := 'GotoTheme(2)';
  if listbox11.itemindex = 5 then Edit18.Text := 'GotoScreen(2)';
  if listbox11.itemindex = 6 then Edit18.Text := 'FreezeScreen';
  if listbox11.itemindex = 7 then Edit18.Text := 'RefreshAll';
  if listbox11.itemindex = 8 then Edit18.Text := 'Backlight(1)';
  if listbox11.itemindex = 9 then Edit18.Text := 'BacklightToggle';
  if listbox11.itemindex = 10 then Edit18.Text := 'BLFlash(5)';
  if listbox11.itemindex = 11 then Edit18.Text := 'Wave[c:\wave.wav]';
  if listbox11.itemindex = 12 then Edit18.Text := 'Exec[c:\autoexec.bat]';
  if listbox11.itemindex = 13 then Edit18.Text := 'WANextTrack';
  if listbox11.itemindex = 14 then Edit18.Text := 'WALastTrack';
  if listbox11.itemindex = 15 then Edit18.Text := 'WAPlay';
  if listbox11.itemindex = 16 then Edit18.Text := 'WAStop';
  if listbox11.itemindex = 17 then Edit18.Text := 'WAPause';
  if listbox11.itemindex = 18 then Edit18.Text := 'WAShuffle';
  if listbox11.itemindex = 19 then Edit18.Text := 'WAVolDown';
  if listbox11.itemindex = 20 then Edit18.Text := 'WAVolUp';
  if listbox11.itemindex = 21 then Edit18.Text := 'EnableScreen(1)';
  if listbox11.itemindex = 22 then Edit18.Text := 'DisableScreen(1)';
  if listbox11.itemindex = 23 then Edit18.Text := '$dll(name.dll,2,param1,param2)';

  if listbox11.itemindex = 24 then Edit18.Text := 'GPO(4,1)';
  if listbox11.itemindex = 25 then Edit18.Text := 'GPOToggle(4)';
  if listbox11.itemindex = 26 then Edit18.Text := 'GPOFlash(4,5)';
  if listbox11.itemindex = 27 then Edit18.Text := 'Fan(1,255)';

end;

procedure TSetupForm.PageControl2Change(Sender: TObject);
begin
  if Pagecontrol2.ActivePage = Tabsheet12 then
  begin
    setupbutton := 5;
    combobox9.ItemIndex := 0;

    while (listbox11.Items.Count > 24) do
      listbox11.Items.Delete(24);

    if (radiobutton2.Checked) then
    begin
      listbox11.Items.Add('GPO(4-8,0/1) (0=off 1=on)');
      listbox11.Items.Add('GPOToggle(4-8)');
      listbox11.Items.Add('GPOFlash(4-8,2) (nr. of times)');
      if (config.mx3Usb) then
      begin
        listbox11.Items.Add('Fan(1-3,0-255) (0-255=speed)');
      end;
    end;
  end;
  if Pagecontrol2.ActivePage = Tabsheet11 then
  begin
    if pagecontrol1.activepage = tabsheet13 then
    begin
      if pos('$MObutton', edit9.text) <> 0 then edit9.text := 'Variable: ';
      pagecontrol1.ActivePage := Tabsheet1;
    end;
    edit10.text := config.gameServer[combobox3.itemindex + 1, 1];
    setupbutton := 1;
    edit5.color := $00A1D7A4;
    if edit6.enabled= true then edit6.color := clWhite
    else edit6.color := $00BBBBFF;
    if edit7.enabled= true then edit7.color := clWhite
    else edit7.color := $00BBBBFF;
    if edit8.enabled= true then edit8.color := clWhite
    else edit8.color := $00BBBBFF;
  end;
end;

procedure TSetupForm.Button8Click(Sender: TObject);
begin
  if (edit16.text <> '') and (combobox9.itemindex <> -1) then
  begin
    StringGrid1.Cells[0, StringGrid1.RowCount-1] := edit16.text;
    StringGrid1.Cells[1, StringGrid1.RowCount-1] :=
      combobox9.Items.Strings[combobox9.itemindex];
    StringGrid1.Cells[2, StringGrid1.RowCount-1] := edit19.text;
    StringGrid1.Cells[3, StringGrid1.RowCount-1] := 'then';
    StringGrid1.Cells[4, StringGrid1.RowCount-1] := edit18.text;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
  end;
end;

procedure TSetupForm.Button9Click(Sender: TObject);
var
  counter, counter2, counter3: Integer;

begin
  counter2 :=
    Stringgrid1.Selection.Bottom-Stringgrid1.Selection.Top + 1;
  for counter := Stringgrid1.Selection.Top to
    Stringgrid1.Selection.Bottom do
    StringGrid1.Rows[counter].clear;
  for counter3 := 1 to counter2 do
  begin
    for counter := Stringgrid1.Selection.Top to
      Stringgrid1.RowCount do
    begin
      StringGrid1.Cells[0, counter] := StringGrid1.Cells[0, counter
        + 1];
      StringGrid1.Cells[1, counter] := StringGrid1.Cells[1, counter
        + 1];
      StringGrid1.Cells[2, counter] := StringGrid1.Cells[2, counter
        + 1];
      StringGrid1.Cells[3, counter] := StringGrid1.Cells[3, counter
        + 1];
      StringGrid1.Cells[4, counter] := StringGrid1.Cells[4, counter
        + 1];
    end;
  end;
  StringGrid1.rowcount := StringGrid1.rowcount-counter2;
end;

procedure TSetupForm.ListBox12Click(Sender: TObject);
begin
  if listbox12.itemindex > -1 then
  begin
    if listbox12.itemindex = 0 then Edit9.Text := '$MObutton';

    FocusToInputField();

  end;
end;

procedure TSetupForm.Button10Click(Sender: TObject);
begin
  DoInteractionConfigForm;
end;


procedure TSetupForm.Edit5KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = UPKEY then
  begin
    // select bottom row
    if (edit8.Enabled) and (edit8.Visible) then edit8.SetFocus
    else if (edit7.Enabled) and (edit7.Visible) then edit7.SetFocus
    else if (edit6.Enabled) and (edit6.Visible) then edit6.SetFocus;
  end
  else if ord(key) = DOWNKEY then
  begin
    // Select next row if used.
    if (edit6.Enabled) and (edit6.Visible) then edit6.SetFocus;
  end;
end;

procedure TSetupForm.Edit6KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = UPKEY then edit5.SetFocus
  else if ord(key) = DOWNKEY then
  begin
    // Select next row if used otherwise go to top.
    if (edit7.Enabled) and (edit7.Visible) then edit7.SetFocus
    else edit5.SetFocus;
  end;
end;

procedure TSetupForm.Edit7KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = UPKEY then edit6.SetFocus
  else if ord(key) = DOWNKEY then
  begin
    // Select next row if used otherwise go to top.
    if (edit8.Enabled) and (edit8.Visible) then edit8.SetFocus
    else edit5.SetFocus;
  end;
end;

procedure TSetupForm.Edit8KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if ord(key) = UPKEY then edit7.SetFocus;
  if ord(key) = DOWNKEY then edit5.SetFocus;
end;

procedure TSetupForm.StickyClick(Sender: TObject);
begin
  SpinEdit2.enabled := not Sticky.checked;
end;

procedure TSetupForm.StringGrid1Click(Sender: TObject);
var
  selected: Integer;
begin

  selected := StringGrid1.Selection.Top;

  edit16.text := StringGrid1.Cells[0, selected];

  if StringGrid1.Cells[1, selected]='>' then
    combobox9.itemindex := 0
  else if StringGrid1.Cells[1, selected]='<' then
    combobox9.itemindex := 1
  else if StringGrid1.Cells[1, selected]='=' then
    combobox9.itemindex := 2
  else if StringGrid1.Cells[1, selected]='<=' then
    combobox9.itemindex := 3
  else if StringGrid1.Cells[1, selected]='>=' then
    combobox9.itemindex := 4
  else if StringGrid1.Cells[1, selected]='<>' then
    combobox9.itemindex := 5;

  edit19.text := StringGrid1.Cells[2, selected];
  edit18.text := StringGrid1.Cells[4, selected];
end;

procedure TSetupForm.ComboBox7Change(Sender: TObject);
begin
  if (combobox7.ItemIndex < 0) then combobox7.ItemIndex := 0;
end;

procedure TSetupForm.ComboBox9Change(Sender: TObject);
begin
  if combobox9.ItemIndex < 0 then combobox9.itemIndex := 0;
end;

procedure TSetupForm.ComboBox4Change(Sender: TObject);
begin
  if (combobox4.ItemIndex < 0) then combobox4.ItemIndex := 0;
end;

procedure TSetupForm.ComboBox5Change(Sender: TObject);
begin
  if combobox5.itemindex < 0 then combobox5.ItemIndex := 0;
end;

procedure TSetupForm.ComboBox1Change(Sender: TObject);
begin
  if combobox1.ItemIndex < 0 then combobox1.ItemIndex := 0;
end;

procedure UpdateSetupForm(cKey : char);
begin
  if assigned(SetupForm) then
    SetupForm.Edit17.text := cKey;
end;

function PerformingSetup : boolean;
begin
  Result := assigned(SetupForm);
end;

end.
