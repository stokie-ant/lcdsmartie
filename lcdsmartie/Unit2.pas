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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/Unit2.pas,v $
 *  $Revision: 1.2 $ $Date: 2004/10/25 22:52:48 $
 *****************************************************************************}
unit Unit2;

interface

uses
  Registry, unit1, Controls, StdCtrls, ExtCtrls, Spin, Classes, Windows, Messages, SysUtils, Graphics, Forms, Dialogs, VaComm,
  ComCtrls, Buttons, ShellApi, Grids;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
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
    Label14: TLabel;
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
    Label3: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label35: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    TabSheet8: TTabSheet;
    ListBox3: TListBox;
    Edit1: TEdit;
    Label41: TLabel;
    Label49: TLabel;
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
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    SpinEdit1: TSpinEdit;
    ComboBox2: TComboBox;
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
    ComboBox7: TComboBox;
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
    ComboBox1: TComboBox;
    CheckBox14: TCheckBox;
    CheckBox2: TCheckBox;
    Button10: TButton;
    Label58: TLabel;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    Label59: TLabel;
    RadioButton4: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
    procedure Edit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public shit declarations }
  end;

var
  Form2: TForm2;
  proxytemp2,proxytemp1:string;
  GPOsaan:integer;

implementation

uses parport, Unit3, Unit5, Unit6, Unit7;

{$R *.DFM}

procedure TForm2.Button2Click(Sender: TObject);
begin
 form1.timer1.enabled:=true;
 form1.timer2.enabled:=true;
 form1.timer3.enabled:=true;
 form1.timer6.enabled:=true;
 if frozen =false then begin
   form1.timer7.enabled:=true;
   form1.timer7.interval:=500;
 end;
 form1.timer8.enabled:=true;
 form1.timer9.enabled:=true;
 form1.timer10.enabled:=true;
  form2.visible:=false;
  form1.enabled:=true;
  form1.BringToFront;
  form1.SetFocus;
end;

procedure TForm2.FormShow(Sender: TObject);
var
  i,blaat:integer;
  bestand:textfile;
  regel,regel2:string;
  laatstepacket:boolean;
  ch:char;


label
  nextpacket;

begin
  form1.timer2.enabled:=false;
  form1.timer4.enabled:=false;
  form1.timer5.enabled:=false;
  form1.timer6.enabled:=false;
  form1.timer7.enabled:=false;
  form1.timer8.enabled:=false;
  form1.timer9.enabled:=false;
  form1.timer10.enabled:=false;
  pagecontrol2.ActivePage:=tabsheet11;
  if pagecontrol1.activepage = tabsheet13 then pagecontrol1.ActivePage:=tabsheet1;
   tabsheet13.Enabled:=false;

  GPOsaan:=0;
  unit1.setupbutton:=1;
  setupscreen:=1;

  try
    assignfile(bestand, extractfilepath(application.exename)+'config.cfg');
    reset(bestand);
    for blaat:=1 to 100 do
      readln(bestand,configarray[blaat]);
    closefile(bestand);

    assignfile(bestand, extractfilepath(application.exename)+'servers.cfg');
    reset(bestand);
    for blaat:=1 to 80 do
      readln(bestand,serversarray[blaat]);
    closefile(bestand);
  except
    try closefile(bestand); except end;
  end;
  edit10.text:=serversarray[1];

  try
    form2.StringGrid1.rowcount:=0;
    for blaat:= 0 to 999 do begin
      form2.StringGrid1.Cells[0,blaat]:='';
      form2.StringGrid1.Cells[1,blaat]:='';
      form2.StringGrid1.Cells[2,blaat]:='';
      form2.StringGrid1.Cells[3,blaat]:='';
      form2.StringGrid1.Cells[4,blaat]:='';
    end;
    assignfile(bestand,extractfilepath(application.exename)+'actions.cfg');
      reset (bestand);
      while not eof(bestand) do begin
        readln(bestand,regel);
        edit16.text:=copy(regel,1,pos('¿',regel)-1);
        combobox9.itemindex:=StrToInt(copy(regel,pos('¿',regel)+1,1));
        edit19.text:=copy(regel,pos('¿¿',regel)+2,pos('¿¿¿',regel)-pos('¿¿',regel)-2);
        edit18.text:=copy(regel,pos('¿¿¿',regel)+3,length(regel));
        button8.click;
      end;
    closefile(bestand);
  except
    try closefile(bestand); except end;
  end;

  assignfile(bestand,extractfilepath(application.exename)+'config.cfg');
   application.ProcessMessages;
    reset (bestand);
   readln (bestand, regel);
     form2.spinEdit1.text:=copy(regel,1,pos('¿',regel)-1);
     form2.edit15.text:=copy(regel,pos('¿',regel)+1,length(regel));
   readln (bestand,regel);
     form6.spinEdit1.text:=copy(regel,1,pos('¿',regel)-1);
     edit1.text:=copy(regel,pos('¿',regel)+1,length(regel));
   readln (bestand, regel);
     regel:=copy(regel,1,pos('¿1',regel)-1);
     combobox2.itemindex:=strToInt(regel)-1;
   readln (bestand,regel);
  closefile(bestand);

  tempscreen:=0;
  combobox3.itemindex:=0;
  regel:=configarray[combobox3.itemindex*4+4];
  if copy(regel,pos('¿',regel)+1,1)='1' then checkbox1.checked:=true else checkbox1.checked:=false;
  spinedit7.value:=StrToInt(copy(regel,pos('¿',regel)+5,1))+1;
  spinedit2.value:=StrToInt(copy(regel,pos('¿',regel)+9,length(regel)));
  Combobox7.itemindex:=StrToInt(copy(regel,pos('¿',regel)+2,1));
  form7.ComboBox10.itemindex:=StrToInt(copy(regel,pos('¿',regel)+6,1));
      if form7.combobox10.ItemIndex=0 then
        form7.spinedit1.Enabled:=False
      else
        form7.spinedit1.Enabled:=True;
  form7.Spinedit1.text:=copy(regel,pos('¿',regel)+7,2);

  checkbox3.checked:=false;
  checkbox4.checked:=false;
  checkbox5.checked:=false;
  checkbox6.checked:=false;
  checkbox7.checked:=false;
  checkbox8.checked:=false;
  checkbox9.checked:=false;
  checkbox3.enabled:=true;
  checkbox3.checked:=false;
  edit6.enabled:=true;
  checkbox4.enabled:=true;
  checkbox4.checked:=false;
  edit7.enabled:=true;
  checkbox5.enabled:=true;
  checkbox5.checked:=false;
  edit8.enabled:=true;

  edit5.color:=$00A1D7A4;
  edit6.color:=clWhite;
  edit7.color:=clWhite;
  edit8.color:=clWhite;
  unit1.setupbutton:=1;
  edit10.text:=serversarray[combobox3.itemindex*4+1];

  regel:=configarray[combobox3.itemindex*4+4];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox3.checked:=true;
  if copy(regel,pos('¿',regel)+4,1)='1' then begin
    checkbox7.checked:=true;
    checkbox3.Checked:=true;
    checkbox3.enabled:=false;
    edit6.enabled:=false;
    edit6.color:=$00BBBBFF;
  end;
  if copy(regel,1,3)='%c%' then begin
    edit5.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox10.Checked:=true;
  end else begin
    edit5.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox10.Checked:=false;
  end;
  regel:=configarray[combobox3.itemindex*4+5];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox4.checked:=true;
  if copy(regel,pos('¿',regel)+4,1)='1' then begin
    checkbox8.checked:=true;
    checkbox4.Checked:=true;
    checkbox4.enabled:=false;
    edit7.enabled:=false;
    edit7.color:=$00BBBBFF;
  end;
  if copy(regel,1,3)='%c%' then begin
    edit6.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox11.Checked:=true;
  end else begin
    edit6.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox11.Checked:=false;
  end;
  regel:=configarray[combobox3.itemindex*4+6];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox5.checked:=true;
  if copy(regel,pos('¿',regel)+4,1)='1' then begin
    checkbox9.checked:=true;
    checkbox5.Checked:=true;
    checkbox5.enabled:=false;
    edit8.enabled:=false;
    edit8.color:=$00BBBBFF;
  end;
  if copy(regel,1,3)='%c%' then begin
    edit7.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox12.Checked:=true;
  end else begin
    edit7.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox12.Checked:=false;
  end;
  regel:=configarray[combobox3.itemindex*4+7];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox6.checked:=true;
  if copy(regel,1,3)='%c%' then begin
    edit8.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox13.Checked:=true;
  end else begin
    edit8.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox13.Checked:=false;
  end;

  edit14.text:=configarray[88];
  regel:=configarray[89];
    spinedit4.text:=copy(regel,1,pos('¿',regel)-1);
    spinedit8.text:=copy(regel,pos('¿',regel)+1,pos('¿¿',regel)-pos('¿',regel)-1);
    spinedit9.text:=copy(regel,pos('¿¿',regel)+2,length(regel));
  form6.edit1.text:=intToHex(StrToInt(configarray[91]),3);
 if copy(configarray[92],1,1)='1' then checkbox2.checked:=true else checkbox2.checked:=false;
 if copy(configarray[92],2,1)='1' then form3.checkbox1.checked:=true else form3.checkbox1.checked:=false;
  proxytemp1:=configarray[93];
  edit3.text:=configarray[93];
  edit4.text:=configarray[94];
  proxytemp2:=configarray[94];
  combobox8.itemindex:=0;
  regel:=configarray[95];
   edit11.text:=copy(regel,1,pos('¿', regel)-1);
  regel:=configarray[96];
   edit12.text:=copy(regel,1,pos('¿', regel)-1);
  regel:=configarray[97];
   edit13.text:=copy(regel,1,pos('¿', regel)-1);
  regel:=configarray[98];
  if (regel='1') or (regel='4') then begin
    radiobutton1.checked:=true;
    button6.enabled:=true;
    combobox4.enabled:=false;
    combobox5.enabled:=false;
    button4.enabled:=false;
    button5.enabled:=false;
  end;
  if regel='4' then begin
    radiobutton4.checked:=true;
  end;
  if regel='2' then begin
    radiobutton2.checked:=true;
    button6.enabled:=false;
    combobox4.enabled:=true;
    combobox5.enabled:=true;
    button4.enabled:=true;
    button5.enabled:=false;
  end;
  if regel='3' then begin
    radiobutton3.checked:=true;
    button6.enabled:=false;
    combobox4.enabled:=true;
    combobox5.enabled:=true;
    button4.enabled:=false;
    button5.enabled:=true;
  end;
  regel:=configarray[99];
  if regel='1' then combobox4.ItemIndex:=0;
  if regel='2' then combobox4.ItemIndex:=1;
  if regel='3' then combobox4.ItemIndex:=2;
  if regel='4' then combobox4.ItemIndex:=3;
  combobox5.ItemIndex:=StrToInt(configarray[100]);

 if combobox2.itemindex<5 then begin
   checkbox7.checked:=false;
   edit6.Visible:=false;
   edit7.Visible:=false;
   edit8.Visible:=false;
   checkbox4.Visible:=false;
   checkbox5.Visible:=false;
   checkbox6.Visible:=false;
   checkbox7.Visible:=false;
   checkbox8.Visible:=false;
   checkbox9.Visible:=false;
   checkbox11.visible:=false;
   checkbox12.visible:=false;
   checkbox13.visible:=false;
 end;
 if (combobox2.itemindex<9) and (combobox2.itemindex>4) then begin
   if checkbox7.checked=false then edit6.Visible:=true;
   checkbox8.checked:=false;
   edit7.Visible:=false;
   edit8.Visible:=false;
   checkbox4.Visible:=true;
   checkbox5.Visible:=false;
   checkbox6.Visible:=false;
   checkbox7.Visible:=true;
   checkbox8.Visible:=false;
   checkbox9.Visible:=false;
   checkbox11.visible:=true;
   checkbox12.visible:=false;
   checkbox13.visible:=false;
 end;
 if combobox2.itemindex>8 then begin
   if checkbox7.checked=false then edit6.Visible:=true;
   if checkbox8.checked=false then edit7.Visible:=true;
   if checkbox9.checked=false then edit8.Visible:=true;
   checkbox4.Visible:=true;
   checkbox5.Visible:=true;
   checkbox6.Visible:=true;
   checkbox7.Visible:=true;
   checkbox8.Visible:=true;
   checkbox9.Visible:=true;
   checkbox11.visible:=true;
   checkbox12.visible:=true;
   checkbox13.visible:=true;
 end;

 spinedit3.text:=copy(configarray[84],2,length(configarray[84]));
 if copy(configarray[84],1,1) = '1' then checkbox14.checked:=true else checkbox14.checked:=false;
 spinedit5.text:=copy(configarray[85],pos('¿', configarray[85])+1,length(configarray[85]));
 edit2.text:=copy(configarray[85],1,pos('¿', configarray[85])-1);
 spinedit6.text:=copy(configarray[86],2,length(configarray[86]));
 if copy(configarray[86],1,1) = '1' then checkbox15.checked:=true else checkbox15.checked:=false;



  for i:=1 to 24 do listbox12.Items.Delete(1);
  if (radiobutton2.checked) then begin
    tabsheet13.Enabled:=true;
    listbox12.Items.Add('FanSpeed(1,1) (nr, devider)');

    form1.VaComm1.WriteChar(chr($FE));   //probe 4 one-wire devices
    form1.VaComm1.WriteChar(chr($C8));
    form1.VaComm1.WriteChar(chr($02));


    laatstepacket:=false;
nextpacket:
    regel:='';
    regel2:='';
    while form1.VaComm1.ReadBufUsed>=1 do begin
      form1.VaComm1.ReadChar(Ch);
      regel:=regel+ch;
    end;
    if length(regel)>13 then begin
      if regel[1]+regel[2]='#*' then begin
        if regel[3]=chr(10) then laatstepacket:=true;
        if (regel[5]=chr(0)) and (regel[14]=chr(0)) then begin
          for i:= 0 to 7 do begin
            regel2:=regel2+IntToHex(ord(regel[i+6]),2)+' ';
          end;
          listbox12.Items.Add(regel2);
        end;
      end;
      if laatstepacket<>true then goto nextpacket;
    end;
  end;
end;

procedure TForm2.ComboBox2Change(Sender: TObject);
begin
 if combobox2.itemindex<5 then begin
   checkbox7.checked:=false;
   edit6.Visible:=false;
   edit7.Visible:=false;
   edit8.Visible:=false;
   checkbox4.Visible:=false;
   checkbox5.Visible:=false;
   checkbox6.Visible:=false;
   checkbox7.Visible:=false;
   checkbox8.Visible:=false;
   checkbox9.Visible:=false;
   checkbox11.visible:=false;
   checkbox12.visible:=false;
   checkbox13.visible:=false;
 end;
 if (combobox2.itemindex<9) and (combobox2.itemindex>4) then begin
   if checkbox7.checked=false then edit6.Visible:=true;
   checkbox8.checked:=false;
   edit7.Visible:=false;
   edit8.Visible:=false;
   checkbox4.Visible:=true;
   checkbox5.Visible:=false;
   checkbox6.Visible:=false;
   checkbox7.Visible:=true;
   checkbox8.Visible:=false;
   checkbox9.Visible:=false;
   checkbox11.visible:=true;
   checkbox12.visible:=false;
   checkbox13.visible:=false;
 end;
 if combobox2.itemindex>8 then begin
   if checkbox7.checked=false then edit6.Visible:=true;
   if checkbox8.checked=false then edit7.Visible:=true;
   if checkbox9.checked=false then edit8.Visible:=true;
   checkbox4.Visible:=true;
   checkbox5.Visible:=true;
   checkbox6.Visible:=true;
   checkbox7.Visible:=true;
   checkbox8.Visible:=true;
   checkbox9.Visible:=true;
   checkbox12.visible:=true;
   checkbox12.visible:=true;
   checkbox13.visible:=true;
 end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 form1.timer1.enabled:=true;
 form1.timer2.enabled:=true;
 form1.timer3.enabled:=true;
 form1.timer6.enabled:=true;
 form1.timer7.enabled:=true;
 form1.timer8.enabled:=true;
 form1.timer9.enabled:=true;

  form2.visible:=false;
  form1.enabled:=true;
  form1.refres(self);
  form1.BringToFront;
end;


procedure TForm2.ComboBox3Change(Sender: TObject);
  label opnieuwscreen;
var
  bestand:textfile;
  regel:string;
  x,teller:integer;

begin
  if form2.checkbox1.checked = true then regel:='¿1' else regel := '¿0';
  regel:=regel+IntToStr(combobox7.itemindex);
   edit5.text:=StringReplace(edit5.text,'¿','?',[rfReplaceAll]);
   edit6.text:=StringReplace(edit6.text,'¿','?',[rfReplaceAll]);
   edit7.text:=StringReplace(edit7.text,'¿','?',[rfReplaceAll]);
   edit8.text:=StringReplace(edit8.text,'¿','?',[rfReplaceAll]);
  if checkbox10.checked=true then configarray[(tempscreen*4)+4]:='%c%' else configarray[(tempscreen*4)+4]:='';
  if checkbox11.checked=true then configarray[(tempscreen*4)+5]:='%c%' else configarray[(tempscreen*4)+5]:='';
  if checkbox12.checked=true then configarray[(tempscreen*4)+6]:='%c%' else configarray[(tempscreen*4)+6]:='';
  if checkbox13.checked=true then configarray[(tempscreen*4)+7]:='%c%' else configarray[(tempscreen*4)+7]:='';

  if checkbox3.checked=true then configarray[(tempscreen*4)+4]:=configarray[(tempscreen*4)+4]+edit5.text+regel+'1' else configarray[(tempscreen*4)+4]:=configarray[(tempscreen*4)+4]+edit5.text+regel+'0';
  if checkbox4.checked=true then configarray[(tempscreen*4)+5]:=configarray[(tempscreen*4)+5]+edit6.text+regel+'1' else configarray[(tempscreen*4)+5]:=configarray[(tempscreen*4)+5]+edit6.text+regel+'0';
  if checkbox5.checked=true then configarray[(tempscreen*4)+6]:=configarray[(tempscreen*4)+6]+edit7.text+regel+'1' else configarray[(tempscreen*4)+6]:=configarray[(tempscreen*4)+6]+edit7.text+regel+'0';
  if checkbox6.checked=true then configarray[(tempscreen*4)+7]:=configarray[(tempscreen*4)+7]+edit8.text+regel+'1' else configarray[(tempscreen*4)+7]:=configarray[(tempscreen*4)+7]+edit8.text+regel+'0';

  form7spinedit:=form7.spinedit1.text;
  if copy(form7spinedit,1,1) = '0' then form7spinedit:=copy(form7spinedit,2,1);
  if StrToInt(form7spinedit) < 10 then form7spinedit:='0'+form7spinedit;

  if checkbox7.checked=true then configarray[(tempscreen*4)+4]:=configarray[(tempscreen*4)+4]+'1' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value) else configarray[(tempscreen*4)+4]:=configarray[(tempscreen*4)+4]+'0' + intToStr(spinedit7.value-1) +IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);
  if checkbox8.checked=true then configarray[(tempscreen*4)+5]:=configarray[(tempscreen*4)+5]+'1' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value) else configarray[(tempscreen*4)+5]:=configarray[(tempscreen*4)+5]+'0' + intToStr(spinedit7.value-1) +IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);
  if checkbox9.checked=true then configarray[(tempscreen*4)+6]:=configarray[(tempscreen*4)+6]+'1' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value) else configarray[(tempscreen*4)+6]:=configarray[(tempscreen*4)+6]+'0' + intToStr(spinedit7.value-1) +IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);
  configarray[(tempscreen*4)+7]:=configarray[(tempscreen*4)+7]+'0' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);

  assignfile(bestand,extractfilepath(application.exename)+'config.cfg');
  rewrite(bestand);
  for x:=1 to 100 do writeln(bestand,configarray[x]);
  closefile(bestand);

  setupscreen :=combobox3.itemindex +1;
  tempscreen :=combobox3.itemindex;

  regel:=configarray[combobox3.itemindex*4+4];
  if copy(regel,pos('¿',regel)+1,1)='1' then checkbox1.checked:=true else checkbox1.checked:=false;
  spinedit7.value:=StrToInt(copy(regel,pos('¿',regel)+5,1))+1;
  spinedit2.value:=StrToInt(copy(regel,pos('¿',regel)+9,length(regel)));
  Combobox7.itemindex:=StrToInt(copy(regel,pos('¿',regel)+2,1));
  form7.ComboBox10.itemindex:=StrToInt(copy(regel,pos('¿',regel)+6,1));
      if form7.combobox10.ItemIndex=0 then
        form7.spinedit1.Enabled:=False
      else
        form7.spinedit1.Enabled:=True;
  form7.Spinedit1.text:=copy(regel,pos('¿',regel)+7,2);

  checkbox3.checked:=false;
  checkbox4.checked:=false;
  checkbox5.checked:=false;
  checkbox6.checked:=false;
  checkbox7.checked:=false;
  checkbox8.checked:=false;
  checkbox9.checked:=false;
  checkbox3.enabled:=true;
  checkbox3.checked:=false;
  edit6.enabled:=true;
  checkbox4.enabled:=true;
  checkbox4.checked:=false;
  edit7.enabled:=true;
  checkbox5.enabled:=true;
  checkbox5.checked:=false;
  edit8.enabled:=true;

  edit5.color:=$00A1D7A4;
  edit6.color:=clWhite;
  edit7.color:=clWhite;
  edit8.color:=clWhite;
  unit1.setupbutton:=1;
  edit10.text:=serversarray[combobox3.itemindex*4+1];

  regel:=configarray[combobox3.itemindex*4+4];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox3.checked:=true;
  if copy(regel,pos('¿',regel)+4,1)='1' then begin
    checkbox7.checked:=true;
    checkbox3.Checked:=true;
    checkbox3.enabled:=false;
    edit6.enabled:=false;
    edit6.color:=$00BBBBFF;
  end;
  if copy(regel,1,3)='%c%' then begin
    edit5.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox10.Checked:=true;
  end else begin
    edit5.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox10.Checked:=false;
  end;
  regel:=configarray[combobox3.itemindex*4+5];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox4.checked:=true;
  if copy(regel,pos('¿',regel)+4,1)='1' then begin
    checkbox8.checked:=true;
    checkbox4.Checked:=true;
    checkbox4.enabled:=false;
    edit7.enabled:=false;
    edit7.color:=$00BBBBFF;
  end;
  if copy(regel,1,3)='%c%' then begin
    edit6.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox11.Checked:=true;
  end else begin
    edit6.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox11.Checked:=false;
  end;
  regel:=configarray[combobox3.itemindex*4+6];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox5.checked:=true;
  if copy(regel,pos('¿',regel)+4,1)='1' then begin
    checkbox9.checked:=true;
    checkbox5.Checked:=true;
    checkbox5.enabled:=false;
    edit8.enabled:=false;
    edit8.color:=$00BBBBFF;
  end;
  if copy(regel,1,3)='%c%' then begin
    edit7.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox12.Checked:=true;
  end else begin
    edit7.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox12.Checked:=false;
  end;
  regel:=configarray[combobox3.itemindex*4+7];
  if copy(regel,pos('¿',regel)+3,1)='1' then checkbox6.checked:=true;
  if copy(regel,1,3)='%c%' then begin
    edit8.text:=copy(regel,4,pos('¿',regel)-4);;
    checkbox13.Checked:=true;
  end else begin
    edit8.text:=copy(regel,1,pos('¿',regel)-1);;
    checkbox13.Checked:=false;
  end;

  x:=0;
opnieuwscreen:
  x:=x+1;
  welkescreen:=welkescreen+aantalscreensheenweer;
  if welkescreen=21 then welkescreen:=1;
  if welkescreen=0 then welkescreen:=20;
  regel:= configarray[(welkescreen-1)*4+4];

  if x> 25 then begin
    configarray[4]:=copy(configarray[4],1,pos('¿',configarray[4]))+'100'+copy(configarray[4],pos('¿',configarray[4])+3,length(configarray[4]));
    configarray[5]:=copy(configarray[5],1,pos('¿',configarray[5]))+'100'+copy(configarray[5],pos('¿',configarray[5])+3,length(configarray[5]));
    configarray[6]:=copy(configarray[6],1,pos('¿',configarray[6]))+'100'+copy(configarray[6],pos('¿',configarray[6])+3,length(configarray[6]));
    configarray[7]:=copy(configarray[7],1,pos('¿',configarray[7]))+'100'+copy(configarray[7],pos('¿',configarray[7])+3,length(configarray[7]));
    welkescreen:=1;
    assignfile(bestand,extractfilepath(application.exename)+'config.cfg');
    rewrite(bestand);
    for teller:= 1 to 100 do writeln(bestand,configarray[teller]);
    regel:='check your config file¿10001';
    closefile(bestand);
  end;

  if welkescreen <> combobox3.itemindex + 1 then goto opnieuwscreen;

  scrollline1:=StrToInt(copy(configarray[(welkescreen-1)*4+4],pos('¿',configarray[(welkescreen-1)*4+4])+3,1));
  scrollline2:=StrToInt(copy(configarray[(welkescreen-1)*4+5],pos('¿',configarray[(welkescreen-1)*4+5])+3,1));
  scrollline3:=StrToInt(copy(configarray[(welkescreen-1)*4+6],pos('¿',configarray[(welkescreen-1)*4+6])+3,1));
  scrollline4:=StrToInt(copy(configarray[(welkescreen-1)*4+7],pos('¿',configarray[(welkescreen-1)*4+7])+3,1));
  scrollline5:=0;
  aantalscreensheenweer:=1;
end;

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  if pagecontrol1.ActivePage=Tabsheet13 then pagecontrol1.ActivePage:=Tabsheet1;
  tabsheet13.Enabled:=false;
  button6.enabled:=true;
  combobox4.enabled:=false;
  combobox5.enabled:=false;
  button4.enabled:=false;
  button5.enabled:=false;
end;

procedure TForm2.RadioButton4Click(Sender: TObject);
begin
  button6.enabled:=true;
  combobox4.enabled:=false;
  combobox5.enabled:=false;
  button4.enabled:=false;
  button5.enabled:=false;
end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  tabsheet13.Enabled:=true;
  button6.enabled:=false;
  combobox4.enabled:=true;
  combobox5.enabled:=true;
  button4.enabled:=true;
  button5.enabled:=false;
end;

procedure TForm2.RadioButton3Click(Sender: TObject);
begin
  if pagecontrol1.ActivePage=Tabsheet13 then pagecontrol1.ActivePage:=Tabsheet1;
  tabsheet13.Enabled:=false;
  button6.enabled:=false;
  combobox4.enabled:=true;
  combobox5.enabled:=true;
  button4.enabled:=false;
  button5.enabled:=true;
end;

procedure TForm2.ListBox7Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox7.itemindex > -1 then begin
    if listbox7.itemindex = 0 then Edit9.Text:='$WinampTitle';
    if listbox7.itemindex = 1 then Edit9.Text:='$WinampChannels';
    if listbox7.itemindex = 2 then Edit9.Text:='$WinampKBPS';
    if listbox7.itemindex = 3 then Edit9.Text:='$WinampFreq';
    if listbox7.itemindex = 4 then Edit9.Text:='$Winamppos';
    if listbox7.itemindex = 5 then Edit9.Text:='$WinampPolo';
    if listbox7.itemindex = 6 then Edit9.Text:='$WinampPosh';
    if listbox7.itemindex = 7 then Edit9.Text:='$WinampRem';
    if listbox7.itemindex = 8 then Edit9.Text:='$WinampRelo';
    if listbox7.itemindex = 9 then Edit9.Text:='$WinampResh';
    if listbox7.itemindex = 10 then Edit9.Text:='$WinampLength';
    if listbox7.itemindex = 11 then Edit9.Text:='$WinampLengtl';
    if listbox7.itemindex = 12 then Edit9.Text:='$WinampLengts';
    if listbox7.itemindex = 13 then Edit9.Text:='$WinampPosition(10)';
    if listbox7.itemindex = 14 then Edit9.Text:='$WinampTracknr';
    if listbox7.itemindex = 15 then Edit9.Text:='$WinampTotalTracks';
    if listbox7.itemindex = 16 then Edit9.Text:='$WinampStat';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  tempint: integer;

begin
  if Edit9.Text<> 'Variable:' then begin
    if unit1.setupbutton=1 then begin
      tempint:=edit5.SelStart;
      edit5.text:=copy(edit5.text,1,tempint)+Edit9.Text+copy(edit5.text,tempint+1+edit5.SelLength,length(edit5.Text));
      edit5.SetFocus;
      edit5.selstart:=tempint+length(edit9.text);
    end;
    if unit1.setupbutton=2 then begin
      tempint:=edit6.SelStart;
      edit6.text:=copy(edit6.text,1,Edit6.SelStart)+Edit9.Text+copy(edit6.text,edit6.SelStart+1+edit6.SelLength,length(edit6.Text));
      edit6.SetFocus;
      edit6.selstart:=tempint+length(edit9.text);
    end;
    if unit1.setupbutton=3 then begin
      tempint:=edit7.SelStart;
      edit7.text:=copy(edit7.text,1,Edit7.SelStart)+Edit9.Text+copy(edit7.text,edit7.SelStart+1+edit7.SelLength,length(edit7.Text));
      edit7.SetFocus;
      edit7.selstart:=tempint+length(edit9.text);
    end;
    if unit1.setupbutton=4 then begin
      tempint:=edit8.SelStart;
      edit8.text:=copy(edit8.text,1,Edit8.SelStart)+Edit9.Text+copy(edit8.text,edit8.SelStart+1+edit8.SelLength,length(edit8.Text));
      edit8.SetFocus;
      edit8.selstart:=tempint+length(edit9.text);
    end;
    if unit1.setupbutton=5 then begin
      if (edit17.text='') and (edit9.text='$MObutton') then begin
        showmessage ('please press the button you want to bind');
      end else begin
        if pos('$MObutton',edit9.Text)<>0 then edit9.Text:='$MObutton('+edit17.text+')';
        edit16.text:=edit9.text;
      end;
    end;
  end;
end;

procedure TForm2.ListBox6Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox6.itemindex > -1 then begin
    if listbox6.itemindex = 0 then Edit9.Text:='$Username';
    if listbox6.itemindex = 1 then Edit9.Text:='$Computername';
    if listbox6.itemindex = 2 then Edit9.Text:='$CPUType';
    if listbox6.itemindex = 3 then Edit9.Text:='$CPUSpeed';
    if listbox6.itemindex = 4 then Edit9.Text:='$CPUUsage%';
    if listbox6.itemindex = 5 then Edit9.Text:='$Bar($CPUUsage%,100,10)';
    if listbox6.itemindex = 6 then Edit9.Text:='$MemFree';
    if listbox6.itemindex = 7 then Edit9.Text:='$MemUsed';
    if listbox6.itemindex = 8 then Edit9.Text:='$MemTotal';
    if listbox6.itemindex = 9 then Edit9.Text:='$MemF%';
    if listbox6.itemindex = 10 then Edit9.Text:='$MemU%';
    if listbox6.itemindex = 11 then Edit9.Text:='$Bar($MemFree,$PageTotal,10)';
    if listbox6.itemindex = 12 then Edit9.Text:='$Bar($MemUsed,$PageTotal,10)';
    if listbox6.itemindex = 13 then Edit9.Text:='$PageFree';
    if listbox6.itemindex = 14 then Edit9.Text:='$PageUsed';
    if listbox6.itemindex = 15 then Edit9.Text:='$PageTotal';
    if listbox6.itemindex = 16 then Edit9.Text:='$PageF%';
    if listbox6.itemindex = 17 then Edit9.Text:='$PageU%';
    if listbox6.itemindex = 18 then Edit9.Text:='$Bar($PageFree,$PageTotal,10)';
    if listbox6.itemindex = 19 then Edit9.Text:='$Bar($PageUsed,$PageTotal,10)';
    if listbox6.itemindex = 20 then Edit9.Text:='$HDFree(C)';
    if listbox6.itemindex = 21 then Edit9.Text:='$HDUsed(C)';
    if listbox6.itemindex = 22 then Edit9.Text:='$HDTotal(C)';
    if listbox6.itemindex = 23 then Edit9.Text:='$HDFreg(C)';
    if listbox6.itemindex = 24 then Edit9.Text:='$HDUseg(C)';
    if listbox6.itemindex = 25 then Edit9.Text:='$HDTotag(C)';
    if listbox6.itemindex = 26 then Edit9.Text:='$HDF%(C)';
    if listbox6.itemindex = 27 then Edit9.Text:='$HDU%(C)';
    if listbox6.itemindex = 28 then Edit9.Text:='$Bar($HDFree(C),$HDTotal(C),10)';
    if listbox6.itemindex = 29 then Edit9.Text:='$Bar($HDUsed(C),$HDTotal(C),10)';
    if listbox6.itemindex = 30 then Edit9.Text:='$ScreenReso';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.ListBox5Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox5.itemindex > -1 then begin
    if listbox5.itemindex = 0 then Edit9.Text:='$Temp1';
    if listbox5.itemindex = 1 then Edit9.Text:='$Temp2';
    if listbox5.itemindex = 2 then Edit9.Text:='$Temp3';
    if listbox5.itemindex = 3 then Edit9.Text:='$Temp4';
    if listbox5.itemindex = 4 then Edit9.Text:='$Temp5';
    if listbox5.itemindex = 5 then Edit9.Text:='$Temp6';
    if listbox5.itemindex = 6 then Edit9.Text:='$Temp7';
    if listbox5.itemindex = 7 then Edit9.Text:='$Temp8';
    if listbox5.itemindex = 8 then Edit9.Text:='$Temp9';
    if listbox5.itemindex = 9 then Edit9.Text:='$Temp10';
    if listbox5.itemindex = 10 then Edit9.Text:='$FanS1';
    if listbox5.itemindex = 11 then Edit9.Text:='$FanS2';
    if listbox5.itemindex = 12 then Edit9.Text:='$FanS3';
    if listbox5.itemindex = 13 then Edit9.Text:='$FanS4';
    if listbox5.itemindex = 14 then Edit9.Text:='$FanS5';
    if listbox5.itemindex = 15 then Edit9.Text:='$FanS6';
    if listbox5.itemindex = 16 then Edit9.Text:='$FanS7';
    if listbox5.itemindex = 17 then Edit9.Text:='$FanS8';
    if listbox5.itemindex = 18 then Edit9.Text:='$FanS9';
    if listbox5.itemindex = 19 then Edit9.Text:='$FanS10';
    if listbox5.itemindex = 20 then Edit9.Text:='$Voltage1';
    if listbox5.itemindex = 21 then Edit9.Text:='$Voltage2';
    if listbox5.itemindex = 22 then Edit9.Text:='$Voltage3';
    if listbox5.itemindex = 23 then Edit9.Text:='$Voltage4';
    if listbox5.itemindex = 24 then Edit9.Text:='$Voltage5';
    if listbox5.itemindex = 25 then Edit9.Text:='$Voltage6';
    if listbox5.itemindex = 26 then Edit9.Text:='$Voltage7';
    if listbox5.itemindex = 27 then Edit9.Text:='$Voltage8';
    if listbox5.itemindex = 28 then Edit9.Text:='$Voltage9';
    if listbox5.itemindex = 29 then Edit9.Text:='$Voltage10';
    if listbox5.itemindex = 30 then Edit9.Text:='$Tempname1';
    if listbox5.itemindex = 31 then Edit9.Text:='$Tempname2';
    if listbox5.itemindex = 32 then Edit9.Text:='$Tempname3';
    if listbox5.itemindex = 33 then Edit9.Text:='$Tempname4';
    if listbox5.itemindex = 34 then Edit9.Text:='$Tempname5';
    if listbox5.itemindex = 35 then Edit9.Text:='$Tempname6';
    if listbox5.itemindex = 36 then Edit9.Text:='$Tempname7';
    if listbox5.itemindex = 37 then Edit9.Text:='$Tempname8';
    if listbox5.itemindex = 38 then Edit9.Text:='$Tempname9';
    if listbox5.itemindex = 39 then Edit9.Text:='$Tempname10';
    if listbox5.itemindex = 40 then Edit9.Text:='$Fanname1';
    if listbox5.itemindex = 41 then Edit9.Text:='$Fanname2';
    if listbox5.itemindex = 42 then Edit9.Text:='$Fanname3';
    if listbox5.itemindex = 43 then Edit9.Text:='$Fanname4';
    if listbox5.itemindex = 44 then Edit9.Text:='$Fanname5';
    if listbox5.itemindex = 45 then Edit9.Text:='$Fanname6';
    if listbox5.itemindex = 46 then Edit9.Text:='$Fanname7';
    if listbox5.itemindex = 47 then Edit9.Text:='$Fanname8';
    if listbox5.itemindex = 48 then Edit9.Text:='$Fanname9';
    if listbox5.itemindex = 49 then Edit9.Text:='$Fanname10';
    if listbox5.itemindex = 50 then Edit9.Text:='$Voltname1';
    if listbox5.itemindex = 51 then Edit9.Text:='$Voltname2';
    if listbox5.itemindex = 52 then Edit9.Text:='$Voltname3';
    if listbox5.itemindex = 53 then Edit9.Text:='$Voltname4';
    if listbox5.itemindex = 54 then Edit9.Text:='$Voltname5';
    if listbox5.itemindex = 55 then Edit9.Text:='$Voltname6';
    if listbox5.itemindex = 56 then Edit9.Text:='$Voltname7';
    if listbox5.itemindex = 57 then Edit9.Text:='$Voltname8';
    if listbox5.itemindex = 58 then Edit9.Text:='$Voltname9';
    if listbox5.itemindex = 59 then Edit9.Text:='$Voltname10';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.ListBox2Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox2.itemindex > -1 then begin
    if listbox2.itemindex = 0 then Edit9.Text:='$CNN';
    if listbox2.itemindex = 1 then Edit9.Text:='$Stocks';
    if listbox2.itemindex = 2 then Edit9.Text:='$TomsHW';
    if listbox2.itemindex = 3 then Edit9.Text:='$T.netHL';
    if listbox2.itemindex = 4 then Edit9.Text:='$DutchWeather';
    if listbox2.itemindex = 5 then Edit9.Text:='$Weather.com(CAXX0504)';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.ComboBox6Change(Sender: TObject);
begin
  if listbox8.Itemindex = 1 then begin
    if combobox6.itemindex = 0 then Edit9.Text:='$Half-life2';
    if combobox6.itemindex = 1 then Edit9.Text:='$QuakeII2';
    if combobox6.itemindex = 2 then Edit9.Text:='$QuakeIII2';
    if combobox6.itemindex = 3 then Edit9.Text:='$Unreal2';
  end else begin
    listbox8.ItemIndex:=0;
    if combobox6.itemindex = 0 then Edit9.Text:='$Half-life1';
    if combobox6.itemindex = 1 then Edit9.Text:='$QuakeII1';
    if combobox6.itemindex = 2 then Edit9.Text:='$QuakeIII1';
    if combobox6.itemindex = 3 then Edit9.Text:='$Unreal1';
  end;
end;

procedure TForm2.Label16Click(Sender: TObject);
begin
  ShellExecute(0, Nil, pchar('www.qstat.org'), Nil, Nil, SW_NORMAL);
end;

procedure TForm2.ListBox1Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox1.itemindex > -1 then begin
    if listbox1.itemindex = 0 then Edit9.Text:='$DnetSpeed';
    if listbox1.itemindex = 1 then Edit9.Text:='$DnetDone';
    if listbox1.itemindex = 2 then Edit9.Text:='$Time(d mmmm yyyy hh:nn:ss)';
    if listbox1.itemindex = 3 then Edit9.Text:='$UpTime';
    if listbox1.itemindex = 4 then Edit9.Text:='$UpTims';
    if listbox1.itemindex = 5 then Edit9.Text:='°';
    if listbox1.itemindex = 6 then Edit9.Text:='ž';
    if listbox1.itemindex = 7 then Edit9.Text:='$Chr(20)';
    if listbox1.itemindex = 8 then Edit9.Text:='$File("C:\file.txt",1)';
    if listbox1.itemindex = 9 then Edit9.Text:='$LogFile("C:\file.log",0)';
    if listbox1.itemindex = 10 then Edit9.Text:='$dll(demo.dll,5,param1,param2)';
    if listbox1.itemindex = 11 then Edit9.Text:='$Count(101#$CPUSpeed#4)';
    if listbox1.itemindex = 12 then Edit9.Text:='$Bar(30,100,20)';
    if listbox1.itemindex = 13 then Edit9.Text:='$Right(ins variable(s) here,$3%)';
    if listbox1.itemindex = 14 then Edit9.Text:='$Fill(10)';
    if listbox1.itemindex = 15 then Edit9.Text:='$Flash(insert text here$)$';
    if listbox1.itemindex = 16 then Edit9.Text:='$CustomChar(1,31,31,31,31,31,31,31,31)';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.ListBox3Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox3.itemindex > -1 then begin
    if listbox3.itemindex = 0 then Edit9.Text:='$SETIResults';
    if listbox3.itemindex = 1 then Edit9.Text:='$SETICPUTime';
    if listbox3.itemindex = 2 then Edit9.Text:='$SETIAverage';
    if listbox3.itemindex = 3 then Edit9.Text:='$SETILastresult';
    if listbox3.itemindex = 4 then Edit9.Text:='$SETIusertime';
    if listbox3.itemindex = 5 then Edit9.Text:='$SETItotalusers';
    if listbox3.itemindex = 6 then Edit9.Text:='$SETIrank';
    if listbox3.itemindex = 7 then Edit9.Text:='$SETIsharingrank';
    if listbox3.itemindex = 8 then Edit9.Text:='$SETImoreWU%';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.PageControl1Change(Sender: TObject);
begin
  if Pagecontrol1.ActivePage=Tabsheet1 then begin
    if listbox7.itemindex > -1 then begin
      if listbox7.itemindex = 0 then Edit9.Text:='$WinampTitle';
      if listbox7.itemindex = 1 then Edit9.Text:='$WinampChannels';
      if listbox7.itemindex = 2 then Edit9.Text:='$WinampKBPS';
      if listbox7.itemindex = 3 then Edit9.Text:='$WinampFreq';
      if listbox7.itemindex = 4 then Edit9.Text:='$Winamppos';
      if listbox7.itemindex = 5 then Edit9.Text:='$WinampPolo';
      if listbox7.itemindex = 6 then Edit9.Text:='$WinampPosh';
      if listbox7.itemindex = 7 then Edit9.Text:='$WinampRem';
      if listbox7.itemindex = 8 then Edit9.Text:='$WinampRelo';
      if listbox7.itemindex = 9 then Edit9.Text:='$WinampResh';
      if listbox7.itemindex = 10 then Edit9.Text:='$WinampLength';
      if listbox7.itemindex = 11 then Edit9.Text:='$WinampLengtl';
      if listbox7.itemindex = 12 then Edit9.Text:='$WinampLengts';
      if listbox7.itemindex = 13 then Edit9.Text:='$WinampPosition(10)';
      if listbox7.itemindex = 14 then Edit9.Text:='$WinampTracknr';
      if listbox7.itemindex = 15 then Edit9.Text:='$WinampTotalTracks';
      if listbox7.itemindex = 16 then Edit9.Text:='$WinampStat';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet2 then begin
    if listbox6.itemindex > -1 then begin
    if listbox6.itemindex = 0 then Edit9.Text:='$Username';
    if listbox6.itemindex = 1 then Edit9.Text:='$Computername';
    if listbox6.itemindex = 2 then Edit9.Text:='$CPUType';
    if listbox6.itemindex = 3 then Edit9.Text:='$CPUSpeed';
    if listbox6.itemindex = 4 then Edit9.Text:='$CPUUsage%';
    if listbox6.itemindex = 5 then Edit9.Text:='$Bar($CPUUsage%,100,10)';
    if listbox6.itemindex = 6 then Edit9.Text:='$MemFree';
    if listbox6.itemindex = 7 then Edit9.Text:='$MemUsed';
    if listbox6.itemindex = 8 then Edit9.Text:='$MemTotal';
    if listbox6.itemindex = 9 then Edit9.Text:='$MemF%';
    if listbox6.itemindex = 10 then Edit9.Text:='$MemU%';
    if listbox6.itemindex = 11 then Edit9.Text:='$Bar($MemFree,$PageTotal,10)';
    if listbox6.itemindex = 12 then Edit9.Text:='$Bar($MemUsed,$PageTotal,10)';
    if listbox6.itemindex = 13 then Edit9.Text:='$PageFree';
    if listbox6.itemindex = 14 then Edit9.Text:='$PageUsed';
    if listbox6.itemindex = 15 then Edit9.Text:='$PageTotal';
    if listbox6.itemindex = 16 then Edit9.Text:='$PageF%';
    if listbox6.itemindex = 17 then Edit9.Text:='$PageU%';
    if listbox6.itemindex = 18 then Edit9.Text:='$Bar($PageFree,$PageTotal,10)';
    if listbox6.itemindex = 19 then Edit9.Text:='$Bar($PageUsed,$PageTotal,10)';
    if listbox6.itemindex = 20 then Edit9.Text:='$HDFree(C)';
    if listbox6.itemindex = 21 then Edit9.Text:='$HDUsed(C)';
    if listbox6.itemindex = 22 then Edit9.Text:='$HDTotal(C)';
    if listbox6.itemindex = 23 then Edit9.Text:='$HDFreg(C)';
    if listbox6.itemindex = 24 then Edit9.Text:='$HDUseg(C)';
    if listbox6.itemindex = 25 then Edit9.Text:='$HDTotag(C)';
    if listbox6.itemindex = 26 then Edit9.Text:='$HDF%(C)';
    if listbox6.itemindex = 27 then Edit9.Text:='$HDU%(C)';
    if listbox6.itemindex = 28 then Edit9.Text:='$Bar($HDFree(C),$HDTotal(C),10)';
    if listbox6.itemindex = 29 then Edit9.Text:='$Bar($HDUsed(C),$HDTotal(C),10)';
    if listbox6.itemindex = 30 then Edit9.Text:='$ScreenReso';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet3 then begin
    if listbox5.itemindex > -1 then begin
     if listbox5.itemindex = 0 then Edit9.Text:='$Temp1';
     if listbox5.itemindex = 1 then Edit9.Text:='$Temp2';
     if listbox5.itemindex = 2 then Edit9.Text:='$Temp3';
     if listbox5.itemindex = 3 then Edit9.Text:='$Temp4';
     if listbox5.itemindex = 4 then Edit9.Text:='$Temp5';
     if listbox5.itemindex = 5 then Edit9.Text:='$Temp6';
     if listbox5.itemindex = 6 then Edit9.Text:='$Temp7';
     if listbox5.itemindex = 7 then Edit9.Text:='$Temp8';
     if listbox5.itemindex = 8 then Edit9.Text:='$Temp9';
     if listbox5.itemindex = 9 then Edit9.Text:='$Temp10';
     if listbox5.itemindex = 10 then Edit9.Text:='$FanS1';
     if listbox5.itemindex = 11 then Edit9.Text:='$FanS2';
     if listbox5.itemindex = 12 then Edit9.Text:='$FanS3';
     if listbox5.itemindex = 13 then Edit9.Text:='$FanS4';
     if listbox5.itemindex = 14 then Edit9.Text:='$FanS5';
     if listbox5.itemindex = 15 then Edit9.Text:='$FanS6';
     if listbox5.itemindex = 16 then Edit9.Text:='$FanS7';
     if listbox5.itemindex = 17 then Edit9.Text:='$FanS8';
     if listbox5.itemindex = 18 then Edit9.Text:='$FanS9';
     if listbox5.itemindex = 19 then Edit9.Text:='$FanS10';
     if listbox5.itemindex = 20 then Edit9.Text:='$Voltage1';
     if listbox5.itemindex = 21 then Edit9.Text:='$Voltage2';
     if listbox5.itemindex = 22 then Edit9.Text:='$Voltage3';
     if listbox5.itemindex = 23 then Edit9.Text:='$Voltage4';
     if listbox5.itemindex = 24 then Edit9.Text:='$Voltage5';
     if listbox5.itemindex = 25 then Edit9.Text:='$Voltage6';
     if listbox5.itemindex = 26 then Edit9.Text:='$Voltage7';
     if listbox5.itemindex = 27 then Edit9.Text:='$Voltage8';
     if listbox5.itemindex = 28 then Edit9.Text:='$Voltage9';
     if listbox5.itemindex = 29 then Edit9.Text:='$Voltage10';
     if listbox5.itemindex = 30 then Edit9.Text:='$Tempname1';
     if listbox5.itemindex = 31 then Edit9.Text:='$Tempname2';
     if listbox5.itemindex = 32 then Edit9.Text:='$Tempname3';
     if listbox5.itemindex = 33 then Edit9.Text:='$Tempname4';
     if listbox5.itemindex = 34 then Edit9.Text:='$Tempname5';
     if listbox5.itemindex = 35 then Edit9.Text:='$Tempname6';
     if listbox5.itemindex = 36 then Edit9.Text:='$Tempname7';
     if listbox5.itemindex = 37 then Edit9.Text:='$Tempname8';
     if listbox5.itemindex = 38 then Edit9.Text:='$Tempname9';
     if listbox5.itemindex = 39 then Edit9.Text:='$Tempname10';
     if listbox5.itemindex = 40 then Edit9.Text:='$Fanname1';
     if listbox5.itemindex = 41 then Edit9.Text:='$Fanname2';
     if listbox5.itemindex = 42 then Edit9.Text:='$Fanname3';
     if listbox5.itemindex = 43 then Edit9.Text:='$Fanname4';
     if listbox5.itemindex = 44 then Edit9.Text:='$Fanname5';
     if listbox5.itemindex = 45 then Edit9.Text:='$Fanname6';
     if listbox5.itemindex = 46 then Edit9.Text:='$Fanname7';
     if listbox5.itemindex = 47 then Edit9.Text:='$Fanname8';
     if listbox5.itemindex = 48 then Edit9.Text:='$Fanname9';
     if listbox5.itemindex = 49 then Edit9.Text:='$Fanname10';
     if listbox5.itemindex = 50 then Edit9.Text:='$Voltname1';
     if listbox5.itemindex = 51 then Edit9.Text:='$Voltname2';
     if listbox5.itemindex = 52 then Edit9.Text:='$Voltname3';
     if listbox5.itemindex = 53 then Edit9.Text:='$Voltname4';
     if listbox5.itemindex = 54 then Edit9.Text:='$Voltname5';
     if listbox5.itemindex = 55 then Edit9.Text:='$Voltname6';
     if listbox5.itemindex = 56 then Edit9.Text:='$Voltname7';
     if listbox5.itemindex = 57 then Edit9.Text:='$Voltname8';
     if listbox5.itemindex = 58 then Edit9.Text:='$Voltname9';
     if listbox5.itemindex = 59 then Edit9.Text:='$Voltname10';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet13 then begin
    if radiobutton2.Checked=false then pagecontrol1.ActivePage:=Tabsheet1;
    if listbox12.itemindex > -1 then begin
      if listbox12.itemindex = 0 then Edit9.Text:='$MObutton';
      if listbox12.itemindex = 1 then Edit9.Text:='$FanSpeed(1,1)';
      if listbox12.itemindex = 2 then Edit9.Text:='$Sensor1';
      if listbox12.itemindex = 3 then Edit9.Text:='$Sensor2';
      if listbox12.itemindex = 4 then Edit9.Text:='$Sensor3';
      if listbox12.itemindex = 5 then Edit9.Text:='$Sensor4';
      if listbox12.itemindex = 6 then Edit9.Text:='$Sensor5';
      if listbox12.itemindex = 7 then Edit9.Text:='$Sensor6';
      if listbox12.itemindex = 8 then Edit9.Text:='$Sensor7';
      if listbox12.itemindex = 9 then Edit9.Text:='$Sensor8';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet5 then begin
    if listbox8.itemindex <= -1 then edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet6 then begin
    if listbox2.itemindex > -1 then begin
     if listbox2.itemindex = 0 then Edit9.Text:='$CNN';
     if listbox2.itemindex = 1 then Edit9.Text:='$Stocks';
     if listbox2.itemindex = 2 then Edit9.Text:='$TomsHW';
     if listbox2.itemindex = 3 then Edit9.Text:='$T.netHL';
     if listbox2.itemindex = 4 then Edit9.Text:='$DutchWeather';
     if listbox2.itemindex = 5 then Edit9.Text:='$Weather.com(CAXX0504)';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet7 then begin
    if listbox1.itemindex > -1 then begin
      if listbox1.itemindex = 0 then Edit9.Text:='$DnetSpeed';
      if listbox1.itemindex = 1 then Edit9.Text:='$DnetDone';
      if listbox1.itemindex = 2 then Edit9.Text:='$Time(d mmmm yyyy hh:nn:ss)';
      if listbox1.itemindex = 3 then Edit9.Text:='$UpTime';
      if listbox1.itemindex = 4 then Edit9.Text:='$UpTims';
      if listbox1.itemindex = 5 then Edit9.Text:='°';
      if listbox1.itemindex = 6 then Edit9.Text:='ž';
      if listbox1.itemindex = 7 then Edit9.Text:='$Chr(20)';
      if listbox1.itemindex = 8 then Edit9.Text:='$File("C:\file.txt",1)';
      if listbox1.itemindex = 9 then Edit9.Text:='$LogFile("C:\file.log",0)';
      if listbox1.itemindex = 10 then Edit9.Text:='$dll(demo.dll,5,param1,param2)';
      if listbox1.itemindex = 11 then Edit9.Text:='$Count(101#$CPUSpeed#4)';
      if listbox1.itemindex = 12 then Edit9.Text:='$Bar(30,100,20)';
      if listbox1.itemindex = 13 then Edit9.Text:='$Right(ins variable(s) here,$3%)';
      if listbox1.itemindex = 14 then Edit9.Text:='$Fill(10)';
      if listbox1.itemindex = 15 then Edit9.Text:='$Flash(insert text here$)$';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet8 then begin
    if listbox3.itemindex > -1 then begin
      if listbox3.itemindex = 0 then Edit9.Text:='$SETIResults';
      if listbox3.itemindex = 1 then Edit9.Text:='$SETICPUTime';
      if listbox3.itemindex = 2 then Edit9.Text:='$SETIAverage';
      if listbox3.itemindex = 3 then Edit9.Text:='$SETILastresult';
      if listbox3.itemindex = 4 then Edit9.Text:='$SETIusertime';
      if listbox3.itemindex = 5 then Edit9.Text:='$SETItotalusers';
      if listbox3.itemindex = 6 then Edit9.Text:='$SETIrank';
      if listbox3.itemindex = 7 then Edit9.Text:='$SETIsharingrank';
      if listbox3.itemindex = 8 then Edit9.Text:='$SETImoreWU%';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet10 then begin
    if listbox10.itemindex > -1 then begin
      if listbox10.itemindex = 0 then Edit9.Text:='$FOLDmemsince';
      if listbox10.itemindex = 1 then Edit9.Text:='$FOLDlastwu';
      if listbox10.itemindex = 2 then Edit9.Text:='$FOLDactproc';
      if listbox10.itemindex = 3 then Edit9.Text:='$FOLDteam';
      if listbox10.itemindex = 4 then Edit9.Text:='$FOLDscore';
      if listbox10.itemindex = 5 then Edit9.Text:='$FOLDrank';
      if listbox10.itemindex = 6 then Edit9.Text:='$FOLDwu';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet4 then begin
    if listbox4.itemindex > -1 then begin
      if listbox4.itemindex = 0 then Edit9.Text:='$Email1';
      if listbox4.itemindex = 1 then Edit9.Text:='$Email2';
      if listbox4.itemindex = 2 then Edit9.Text:='$Email3';
      if listbox4.itemindex = 3 then Edit9.Text:='$Email4';
      if listbox4.itemindex = 4 then Edit9.Text:='$Email5';
      if listbox4.itemindex = 5 then Edit9.Text:='$Email6';
      if listbox4.itemindex = 6 then Edit9.Text:='$Email7';
      if listbox4.itemindex = 7 then Edit9.Text:='$Email8';
      if listbox4.itemindex = 8 then Edit9.Text:='$Email9';
      if listbox4.itemindex = 9 then Edit9.Text:='$Email0';
    end else edit9.text:='Variable:';
  end;
  if Pagecontrol1.ActivePage=Tabsheet9 then begin
    if listbox9.itemindex > -1 then begin
      if listbox9.itemindex = 0 then Edit9.Text:='$NetAdapter(1)';
      if listbox9.itemindex = 1 then Edit9.Text:='$NetDownK(1)';
      if listbox9.itemindex = 2 then Edit9.Text:='$NetUpK(1)';
      if listbox9.itemindex = 3 then Edit9.Text:='$NetDownM(1)';
      if listbox9.itemindex = 4 then Edit9.Text:='$NetUpM(1)';
      if listbox9.itemindex = 5 then Edit9.Text:='$NetDownG(1)';
      if listbox9.itemindex = 6 then Edit9.Text:='$NetUpG(1)';
      if listbox9.itemindex = 7 then Edit9.Text:='$NetSpDownK(1)';
      if listbox9.itemindex = 8 then Edit9.Text:='$NetSpUpK(1)';
      if listbox9.itemindex = 9 then Edit9.Text:='$NetSpDownM(1)';
      if listbox9.itemindex = 10 then Edit9.Text:='$NetSpUpM(1)';
      if listbox9.itemindex = 11 then Edit9.Text:='$NetErrDown(1)';
      if listbox9.itemindex = 12 then Edit9.Text:='$NetErrUp(1)';
      if listbox9.itemindex = 13 then Edit9.Text:='$NetErrTot(1)';
      if listbox9.itemindex = 14 then Edit9.Text:='$NetUniDown(1)';
      if listbox9.itemindex = 15 then Edit9.Text:='$NetUniUp(1)';
      if listbox9.itemindex = 16 then Edit9.Text:='$NetUniTot(1)';
      if listbox9.itemindex = 17 then Edit9.Text:='$NetNuniDown(1)';
      if listbox9.itemindex = 18 then Edit9.Text:='$NetNuniUp(1)';
      if listbox9.itemindex = 19 then Edit9.Text:='$NetNuniTot(1)';
      if listbox9.itemindex = 20 then Edit9.Text:='$NetPackTot(1)';
      if listbox9.itemindex = 21 then Edit9.Text:='$NetDiscDown(1)';
      if listbox9.itemindex = 22 then Edit9.Text:='$NetDiscUp(1)';
      if listbox9.itemindex = 23 then Edit9.Text:='$NetDiscTot(1)';
      if listbox9.itemindex = 24 then Edit9.Text:='$NetIPaddress';
    end else edit9.text:='Variable:';
  end;
end;


procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then button2.click();
end;

procedure TForm2.Edit10Exit(Sender: TObject);
begin
  serversarray[combobox3.itemindex*4+unit1.setupbutton]:=edit10.text;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  form3.visible:=true;
  form2.enabled:=false;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
var
  regel, regel2:string;

begin
  regel:=edit14.text;
  regel2:='';
  while pos('\', regel) <> 0 do begin
    regel2:=regel2+copy(regel,1,pos('\',regel));
    regel:=copy(regel,pos('\', regel)+1,length(regel));
  end;
  opendialog2.InitialDir:=regel2;
  opendialog2.FileName:=edit14.text;
  Opendialog2.Execute;
  if opendialog2.FileName <> '' then edit14.text:=opendialog2.FileName;
end;

procedure TForm2.ListBox4Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox4.itemindex > -1 then begin
    if listbox4.itemindex = 0 then Edit9.Text:='$Email1';
    if listbox4.itemindex = 1 then Edit9.Text:='$Email2';
    if listbox4.itemindex = 2 then Edit9.Text:='$Email3';
    if listbox4.itemindex = 3 then Edit9.Text:='$Email4';
    if listbox4.itemindex = 4 then Edit9.Text:='$Email5';
    if listbox4.itemindex = 5 then Edit9.Text:='$Email6';
    if listbox4.itemindex = 6 then Edit9.Text:='$Email7';
    if listbox4.itemindex = 7 then Edit9.Text:='$Email8';
    if listbox4.itemindex = 8 then Edit9.Text:='$Email9';
    if listbox4.itemindex = 9 then Edit9.Text:='$Email0';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.ComboBox8Change(Sender: TObject);
var
  templine1, templine2, templine3, templine4, templine5, templine6: string;
  xx:integer;

begin
  for xx:= 1 to 9 do begin
    if combobox8temp = xx then begin
      templine1:=copy(configarray[95],1,pos('¿'+ intToStr(xx-1), configarray[95])+1);
      templine4:=copy(configarray[95],pos('¿'+ intToStr(xx), configarray[95]), length(configarray[95]));
      templine2:=copy(configarray[96],1,pos('¿'+ intToStr(xx-1), configarray[96])+1);
      templine5:=copy(configarray[96],pos('¿'+ intToStr(xx), configarray[96]), length(configarray[96]));
      templine3:=copy(configarray[97],1,pos('¿'+ intToStr(xx-1), configarray[97])+1);
      templine6:=copy(configarray[97],pos('¿'+ intToStr(xx), configarray[97]), length(configarray[97]));
    end;
  end;
  if combobox8temp = 0 then begin
    templine1:='';
    templine4:=copy(configarray[95],pos('¿'+ intToStr(0), configarray[95]), length(configarray[95]));
    templine2:='';
    templine5:=copy(configarray[96],pos('¿'+ intToStr(0), configarray[96]), length(configarray[96]));
    templine3:='';
    templine6:=copy(configarray[97],pos('¿'+ intToStr(0), configarray[97]), length(configarray[97]));
  end;
  configarray[95]:= templine1+edit11.text+templine4;
  configarray[96]:= templine2+edit12.text+templine5;
  configarray[97]:= templine3+edit13.text+templine6;

templine1:=configarray[95];
templine2:=configarray[96];
templine3:=configarray[97];
if combobox8.itemindex > -1 then begin
  edit11.text:=copy(templine1,1,pos('¿', templine1)-1);
  edit12.text:=copy(templine2,1,pos('¿', templine2)-1);
  edit13.text:=copy(templine3,1,pos('¿', templine3)-1);
end;
for xx:= 0 to 8 do begin
  if combobox8.itemindex > xx then begin
    templine1:=copy(templine1,pos('¿', templine1)+2,length(templine1));
    edit11.text:=copy(templine1,1,pos('¿', templine1)-1);
    templine2:=copy(templine2,pos('¿', templine2)+2,length(templine2));
    edit12.text:=copy(templine2,1,pos('¿', templine2)-1);
    templine3:=copy(templine3,pos('¿', templine3)+2,length(templine3));
    edit13.text:=copy(templine3,1,pos('¿', templine3)-1);
  end;
end;
combobox8temp:=combobox8.itemindex;

end;

procedure TForm2.CheckBox7Click(Sender: TObject);
var tempint1:integer;

begin
  if checkbox7.checked=true then begin
    checkbox3.Checked:=true;
    checkbox3.enabled:=false;
    if unit1.setupbutton=2 then begin
      tempint1:=edit5.SelStart;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
    end;
    edit6.enabled:=false;
    edit6.color:=$00BBBBFF;
  end else begin
    checkbox3.enabled:=true;
    checkbox3.checked:=false;
    edit6.enabled:=true;
    edit6.color:=clWhite;
  end;
end;

procedure TForm2.CheckBox8Click(Sender: TObject);
var tempint1:integer;

begin
  if checkbox8.checked=true then begin
    checkbox4.Checked:=true;
    checkbox4.enabled:=false;
    if unit1.setupbutton=3 then begin
      tempint1:=edit5.SelStart;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
    end;
    edit7.enabled:=false;
    edit7.color:=$00BBBBFF;
  end else begin
    checkbox4.enabled:=true;
    checkbox4.checked:=false;
    edit7.enabled:=true;
    edit7.color:=clWhite;
  end;
end;

procedure TForm2.CheckBox9Click(Sender: TObject);
var tempint1:integer;

begin
  if checkbox9.checked=true then begin
    checkbox5.Checked:=true;
    checkbox5.enabled:=false;
    if unit1.setupbutton=4 then begin
      tempint1:=edit5.SelStart;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
    end;
    edit8.enabled:=false;
    edit8.color:=$00BBBBFF;
  end else begin
    checkbox5.enabled:=true;
    checkbox5.checked:=false;
    edit8.enabled:=true;
    edit8.color:=clWhite;
  end;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
  opendialog1.Execute;
  if opendialog1.FileName<> '' then edit15.text:=opendialog1.FileName;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  form5.visible:=true;
  form2.enabled:=false;
end;

procedure TForm2.ListBox8Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox8.Itemindex = 0 then begin
    if combobox6.itemindex = 0 then Edit9.Text:='$Half-life1';
    if combobox6.itemindex = 1 then Edit9.Text:='$QuakeII1';
    if combobox6.itemindex = 2 then Edit9.Text:='$QuakeIII1';
    if combobox6.itemindex = 3 then Edit9.Text:='$Unreal1';
  end;
  if listbox8.Itemindex = 1 then begin
    if combobox6.itemindex = 0 then Edit9.Text:='$Half-life2';
    if combobox6.itemindex = 1 then Edit9.Text:='$QuakeII2';
    if combobox6.itemindex = 2 then Edit9.Text:='$QuakeIII2';
    if combobox6.itemindex = 3 then Edit9.Text:='$Unreal2';
  end;
  if listbox8.Itemindex = 2 then begin
    if combobox6.itemindex = 0 then Edit9.Text:='$Half-life3';
    if combobox6.itemindex = 1 then Edit9.Text:='$QuakeII3';
    if combobox6.itemindex = 2 then Edit9.Text:='$QuakeIII3';
    if combobox6.itemindex = 3 then Edit9.Text:='$Unreal3';
  end;
  if listbox8.Itemindex = 3 then begin
    if combobox6.itemindex = 0 then Edit9.Text:='$Half-life4';
    if combobox6.itemindex = 1 then Edit9.Text:='$QuakeII4';
    if combobox6.itemindex = 2 then Edit9.Text:='$QuakeIII4';
    if combobox6.itemindex = 3 then Edit9.Text:='$Unreal4';
  end;
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
end;


procedure TForm2.Edit5Enter(Sender: TObject);
begin
  edit10.text:=serversarray[combobox3.itemindex*4+1];
  unit1.setupbutton:=1;
  edit5.color:=$00A1D7A4;
  if edit6.enabled= true then edit6.color:=clWhite else edit6.color:=$00BBBBFF;
  if edit7.enabled= true then edit7.color:=clWhite else edit7.color:=$00BBBBFF;
  if edit8.enabled= true then edit8.color:=clWhite else edit8.color:=$00BBBBFF;
end;

procedure TForm2.Edit6Enter(Sender: TObject);
begin
  edit10.text:=serversarray[combobox3.itemindex*4+2];
  unit1.setupbutton:=2;
  edit6.color:=$00A1D7A4;
  if edit5.enabled= true then edit5.color:=clWhite else edit5.color:=$00BBBBFF;
  if edit7.enabled= true then edit7.color:=clWhite else edit7.color:=$00BBBBFF;
  if edit8.enabled= true then edit8.color:=clWhite else edit8.color:=$00BBBBFF;
end;

procedure TForm2.Edit7Enter(Sender: TObject);
begin
  edit10.text:=serversarray[combobox3.itemindex*4+3];
  unit1.setupbutton:=3;
  edit7.color:=$00A1D7A4;
  if edit6.enabled= true then edit6.color:=clWhite else edit6.color:=$00BBBBFF;
  if edit5.enabled= true then edit5.color:=clWhite else edit5.color:=$00BBBBFF;
  if edit8.enabled= true then edit8.color:=clWhite else edit8.color:=$00BBBBFF;
end;

procedure TForm2.Edit8Enter(Sender: TObject);
begin
  edit10.text:=serversarray[combobox3.itemindex*4+4];
  unit1.setupbutton:=4;
  edit8.color:=$00A1D7A4;
  if edit6.enabled= true then edit6.color:=clWhite else edit6.color:=$00BBBBFF;
  if edit7.enabled= true then edit7.color:=clWhite else edit7.color:=$00BBBBFF;
  if edit5.enabled= true then edit5.color:=clWhite else edit5.color:=$00BBBBFF;
end;

procedure TForm2.ListBox9Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox9.itemindex > -1 then begin
    if listbox9.itemindex = 0 then Edit9.Text:='$NetAdapter(1)';
    if listbox9.itemindex = 1 then Edit9.Text:='$NetDownK(1)';
    if listbox9.itemindex = 2 then Edit9.Text:='$NetUpK(1)';
    if listbox9.itemindex = 3 then Edit9.Text:='$NetDownM(1)';
    if listbox9.itemindex = 4 then Edit9.Text:='$NetUpM(1)';
    if listbox9.itemindex = 5 then Edit9.Text:='$NetDownG(1)';
    if listbox9.itemindex = 6 then Edit9.Text:='$NetUpG(1)';
    if listbox9.itemindex = 7 then Edit9.Text:='$NetSpDownK(1)';
    if listbox9.itemindex = 8 then Edit9.Text:='$NetSpUpK(1)';
    if listbox9.itemindex = 9 then Edit9.Text:='$NetSpDownM(1)';
    if listbox9.itemindex = 10 then Edit9.Text:='$NetSpUpM(1)';
    if listbox9.itemindex = 11 then Edit9.Text:='$NetErrDown(1)';
    if listbox9.itemindex = 12 then Edit9.Text:='$NetErrUp(1)';
    if listbox9.itemindex = 13 then Edit9.Text:='$NetErrTot(1)';
    if listbox9.itemindex = 14 then Edit9.Text:='$NetUniDown(1)';
    if listbox9.itemindex = 15 then Edit9.Text:='$NetUniUp(1)';
    if listbox9.itemindex = 16 then Edit9.Text:='$NetUniTot(1)';
    if listbox9.itemindex = 17 then Edit9.Text:='$NetNuniDown(1)';
    if listbox9.itemindex = 18 then Edit9.Text:='$NetNuniUp(1)';
    if listbox9.itemindex = 19 then Edit9.Text:='$NetNuniTot(1)';
    if listbox9.itemindex = 20 then Edit9.Text:='$NetPackTot(1)';
    if listbox9.itemindex = 21 then Edit9.Text:='$NetDiscDown(1)';
    if listbox9.itemindex = 22 then Edit9.Text:='$NetDiscUp(1)';
    if listbox9.itemindex = 23 then Edit9.Text:='$NetDiscTot(1)';
    if listbox9.itemindex = 24 then Edit9.Text:='$NetIPaddress';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  form6.visible:=true;
  form2.enabled:=false;
end;

procedure TForm2.ListBox10Click(Sender: TObject);
var
  tempint1,tempint2:integer;

  begin
  if listbox10.itemindex > -1 then begin
    if listbox10.itemindex = 0 then Edit9.Text:='$FOLDmemsince';
    if listbox10.itemindex = 1 then Edit9.Text:='$FOLDlastwu';
    if listbox10.itemindex = 2 then Edit9.Text:='$FOLDactproc';
    if listbox10.itemindex = 3 then Edit9.Text:='$FOLDteam';
    if listbox10.itemindex = 4 then Edit9.Text:='$FOLDscore';
    if listbox10.itemindex = 5 then Edit9.Text:='$FOLDrank';
    if listbox10.itemindex = 6 then Edit9.Text:='$FOLDwu';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.Button7Click(Sender: TObject);
var
  bestand:textfile;
  regel:string;
  relood:boolean;
  xx, x:integer;
  Tempradio, Tempcombobox4, Tempcombobox5, Tempedit2:string;
  templine1,templine2,templine3,templine4,templine5,templine6:string;

begin
  try
    assignfile(bestand, extractfilepath(application.exename)+'servers.cfg');
    rewrite(bestand);
    for x:=1 to 80 do
      writeln(bestand, serversarray[x]);
    closefile (bestand);
  except
    try closefile(bestand); except end;
  end;

  try
    assignfile(bestand,extractfilepath(application.exename)+'actions.cfg');
      rewrite (bestand);
      for x:=0 to form2.StringGrid1.RowCount do begin
        if (form2.stringgrid1.cells[0,x]<>'') and (form2.stringgrid1.cells[4,x]<>'') then begin
          regel:=form2.StringGrid1.Cells[0,x]+'¿';
          if form2.StringGrid1.Cells[1,x]='>' then regel:=regel+'0¿¿';
          if form2.StringGrid1.Cells[1,x]='<' then regel:=regel+'1¿¿';
          if form2.StringGrid1.Cells[1,x]='=' then regel:=regel+'2¿¿';
          if form2.StringGrid1.Cells[1,x]='<=' then regel:=regel+'3¿¿';
          if form2.StringGrid1.Cells[1,x]='>=' then regel:=regel+'4¿¿';
          if form2.StringGrid1.Cells[1,x]='<>' then regel:=regel+'5¿¿';
          regel:=regel+form2.StringGrid1.Cells[2,x]+'¿¿¿';
          regel:=regel+form2.StringGrid1.Cells[4,x];
          writeln(bestand,regel);
        end;
      end;
    closefile(bestand);
  except
    try closefile(bestand); except end;
  end;

  assignfile(bestand,extractfilepath(application.exename)+'config.cfg');
  reset (bestand);
    readln (bestand);
    readln (bestand);
    readln (bestand);
    for x:= 4 to 94 do readln (bestand, configarray[x]);
    readln (bestand);
    readln (bestand);
    readln (bestand);
    for x:= 98 to 100 do readln (bestand, configarray[x]);
  rewrite(bestand);
   regel:=Form2.spinEdit1.text+'¿'+edit15.text;
   form1.WinampCtrl1.WinampLocation:=edit15.text;
  writeln(bestand, regel);
   regel:=form6.spinedit1.text+'¿'+edit1.text;
  writeln(bestand, regel);
   regel:=IntToStr(combobox2.itemindex+1)+copy(configarray[3],pos('¿',configarray[3]),length(configarray[3]));
  writeln(bestand, regel);

  for x := 1 to combobox3.itemindex*4 do writeln(bestand,configarray[x+3]);
  regel:='';
  if form2.checkbox1.checked = true then regel:='¿1' else regel := '¿0';
  regel:=regel+IntToStr(combobox7.itemindex);
   edit5.text:=StringReplace(edit5.text,'¿','?',[rfReplaceAll]);
   edit6.text:=StringReplace(edit6.text,'¿','?',[rfReplaceAll]);
   edit7.text:=StringReplace(edit7.text,'¿','?',[rfReplaceAll]);
   edit8.text:=StringReplace(edit8.text,'¿','?',[rfReplaceAll]);

  if checkbox10.checked=true then templine1:='%c%' else templine1:='';
  if checkbox11.checked=true then templine2:='%c%' else templine2:='';
  if checkbox12.checked=true then templine3:='%c%' else templine3:='';
  if checkbox13.checked=true then templine4:='%c%' else templine4:='';
  if checkbox3.checked=true then templine1:=templine1+edit5.text+regel+'1' else templine1:=templine1+edit5.text+regel+'0';
  if checkbox4.checked=true then templine2:=templine2+edit6.text+regel+'1' else templine2:=templine2+edit6.text+regel+'0';
  if checkbox5.checked=true then templine3:=templine3+edit7.text+regel+'1' else templine3:=templine3+edit7.text+regel+'0';
  if checkbox6.checked=true then templine4:=templine4+edit8.text+regel+'1' else templine4:=templine4+edit8.text+regel+'0';

  form7spinedit:=form7.spinedit1.text;
  if copy(form7spinedit,1,1) = '0' then form7spinedit:=copy(form7spinedit,2,1);
  if StrToInt(form7spinedit) < 10 then form7spinedit:='0'+form7spinedit;

  if checkbox7.checked=true then templine1:=templine1+'1' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value) else templine1:=templine1+'0' + intToStr(spinedit7.value-1) +IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);
  if checkbox8.checked=true then templine2:=templine2+'1' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value) else templine2:=templine2+'0' + intToStr(spinedit7.value-1) +IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);
  if checkbox9.checked=true then templine3:=templine3+'1' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value) else templine3:=templine3+'0' + intToStr(spinedit7.value-1) +IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);
  templine4:=templine4+'0' + intToStr(spinedit7.value-1) + IntToStr(form7.Combobox10.itemindex) + Form7Spinedit + intToStr(form2.spinedit2.value);

  writeln(bestand,templine1);
  writeln(bestand,templine2);
  writeln(bestand,templine3);
  writeln(bestand,templine4);

  for x := (combobox3.itemindex+1)*4+1 to 80 do
    writeln(bestand,configarray[x+3]);
    if checkbox14.checked=true then regel:='1'+spinedit3.text;
    if checkbox14.checked=false then regel:='0'+spinedit3.text;
  writeln(bestand,regel);
   form1.timer2.interval:=1000;
   regel:=edit2.text+'¿'+spinedit5.text;
  writeln(bestand,regel);
   form1.timer8.interval:=1000;
   if checkbox15.checked=true then regel:='1';
   if checkbox15.checked=false then regel:='0';
  writeln(bestand, regel+spinedit6.text);
   form1.timer6.interval:=1000;
  if combobox1.itemindex <> -1 then begin
    writeln(bestand, IntToStr(combobox1.itemindex));
  end else begin
    writeln(bestand,configarray[87]);
  end;
  writeln(bestand, edit14.text);
    configarray[88]:=edit14.text;
  writeln(bestand, SpinEdit4.text+'¿'+SpinEdit8.text+'¿¿'+Spinedit9.text);
   form1.timer13.interval:=SpinEdit8.value;
   form1.timer12.interval:=SpinEdit9.value;
   form1.timer9.interval:=800;
  writeln(bestand, configarray[90]);
   Tempedit2:=IntToStr(StrToInt('$'+form6.edit1.text));
  writeln(bestand, IntToStr(StrToInt('$'+form6.edit1.text)));

  if form3.checkbox1.checked=true then regel:='1';
  if form3.checkbox1.checked=false then regel:='0';
  if checkbox2.checked=true then writeln(bestand, '1'+regel)
    else writeln(bestand, '0'+regel);
  if edit4.text='' then edit4.text:='0';
  if (edit3.text <> proxytemp1) or (edit4.text <> proxytemp2) then showmessage('You have to restart LCD Smartie for this option!');
  writeln(bestand, edit3.text);
  writeln(bestand, edit4.text);

  for xx:= 1 to 9 do begin
    if combobox8.itemindex = xx then begin
      templine1:=copy(configarray[95],1,pos('¿'+ intToStr(xx-1), configarray[95])+1);
      templine4:=copy(configarray[95],pos('¿'+ intToStr(xx), configarray[95]), length(configarray[95]));
      templine2:=copy(configarray[96],1,pos('¿'+ intToStr(xx-1), configarray[96])+1);
      templine5:=copy(configarray[96],pos('¿'+ intToStr(xx), configarray[96]), length(configarray[97]));
      templine3:=copy(configarray[97],1,pos('¿'+ intToStr(xx-1), configarray[97])+1);
      templine6:=copy(configarray[97],pos('¿'+ intToStr(xx), configarray[97]), length(configarray[97]));
    end;
  end;
  if combobox8.itemindex = 0 then begin
    templine1:='';
    templine4:=copy(configarray[95],pos('¿'+ intToStr(0), configarray[95]), length(configarray[95]));
    templine2:='';
    templine5:=copy(configarray[96],pos('¿'+ intToStr(0), configarray[96]), length(configarray[96]));
    templine3:='';
    templine6:=copy(configarray[97],pos('¿'+ intToStr(0), configarray[97]), length(configarray[97]));
  end;
  writeln(bestand, templine1+edit11.text+templine4);
  writeln(bestand, templine2+edit12.text+templine5);
  writeln(bestand, templine3+edit13.text+templine6);

  if radiobutton1.checked=true then begin
    writeln(bestand, '1');
    tempradio:='1';
  end;
  if radiobutton2.checked=true then begin
    writeln(bestand, '2');
    tempradio:='2';
  end;
  if radiobutton3.checked=true then begin
    writeln(bestand, '3');
    tempradio:='3';
  end;
  if radiobutton4.checked=true then begin
    writeln(bestand, '4');
    tempradio:='4';
  end;
  if combobox4.itemindex=0 then begin
    writeln(bestand, '1');
    tempcombobox4:='1';
  end;
  if combobox4.itemindex=1 then begin
    writeln(bestand, '2');
    tempcombobox4:='2';
  end;
  if combobox4.itemindex=2 then begin
    writeln(bestand, '3');
    tempcombobox4:='3';
  end;
  if combobox4.itemindex=3 then begin
    writeln(bestand, '4');
    tempcombobox4:='4';
  end;
  writeln(bestand, intToStr(combobox5.itemindex));
  tempcombobox5:=intToStr(combobox5.itemindex);
  application.ProcessMessages;
 relood:=false;
 if (configarray[91]<>tempedit2) or (configarray[98]<>tempradio) or (configarray[99]<>tempcombobox4) or (configarray[100]<>TempComboBox5) then begin
   tempradio:=configarray[98];
   relood:=true;
 end;

 reset(bestand);
 for x:= 1 to 100 do
   readln(bestand,configarray[x]);
 closefile(bestand);

 try
   assignfile(bestand,extractfilepath(application.exename)+'actions.cfg');
   reset (bestand);
   x:=0;
   while not eof(bestand) do begin
     readln(bestand,regel);
     x:=x+1;
     actionsarray[x,1]:=copy(regel,1,pos('¿',regel)-1);
     actionsarray[x,2]:=copy(regel,pos('¿',regel)+1,1);
     actionsarray[x,3]:=copy(regel,pos('¿¿',regel)+2,pos('¿¿¿',regel)-pos('¿¿',regel)-2);
     actionsarray[x,4]:=copy(regel,pos('¿¿¿',regel)+3,length(regel));
   end;
   closefile(bestand);
 except
   try closefile(bestand); except end;
   totalactions:=x;
 end;
 totalactions:=x;

 if relood=true then begin
   form1.timer1.enabled:=false;
   form1.timer2.enabled:=false;
   form1.timer3.enabled:=false;
   form1.timer4.enabled:=false;
   form1.timer5.enabled:=false;
   form1.timer6.enabled:=false;
   form1.timer7.enabled:=false;
   form1.timer8.enabled:=false;
   form1.timer9.enabled:=false;
   form1.timer10.enabled:=false;
   showmessage('You have to restart LCD Smartie when you change driver or driver settings!');
   configarray[98]:=tempradio;
   form1.close;
 end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
 button7.click();

 form1.timer1.enabled:=true;
 form1.timer2.enabled:=true;
 form1.timer2.interval:=500;
 form1.timer3.enabled:=true;
 form1.timer6.enabled:=true;
 if frozen =false then begin
   form1.timer7.enabled:=true;
   form1.timer7.interval:=500;
 end;
 form1.timer8.enabled:=true;
 form1.timer9.enabled:=true;
 form1.timer10.enabled:=true;

 form1.enabled:=true;
 form2.visible:=false;
 form1.BringToFront;
 form1.SetFocus;
end;

procedure TForm2.FormCreate(Sender: TObject);

begin
  form2.StringGrid1.RowCount:=0;
  form2.StringGrid1.ColWidths[0]:=104;
  form2.StringGrid1.ColWidths[1]:=20;
  form2.StringGrid1.ColWidths[2]:=56;
  form2.StringGrid1.ColWidths[3]:=36;
  form2.StringGrid1.ColWidths[4]:=144;
end;

procedure TForm2.ListBox11Click(Sender: TObject);
begin
  if listbox11.itemindex = 0 then Edit18.Text:='NextTheme';
  if listbox11.itemindex = 1 then Edit18.Text:='LastTheme';
  if listbox11.itemindex = 2 then Edit18.Text:='NextScreen';
  if listbox11.itemindex = 3 then Edit18.Text:='LastScreen';
  if listbox11.itemindex = 4 then Edit18.Text:='GotoTheme(2)';
  if listbox11.itemindex = 5 then Edit18.Text:='GotoScreen(2)';
  if listbox11.itemindex = 6 then Edit18.Text:='FreezeScreen';
  if listbox11.itemindex = 7 then Edit18.Text:='RefreshAll';
  if listbox11.itemindex = 8 then Edit18.Text:='Backlight(1)';
  if listbox11.itemindex = 9 then Edit18.Text:='BacklightToggle';
  if listbox11.itemindex = 10 then Edit18.Text:='BLFlash(5)';
  if listbox11.itemindex = 11 then Edit18.Text:='Wave[c:\wave.wav]';
  if listbox11.itemindex = 12 then Edit18.Text:='Exec[c:\autoexec.bat]';
  if listbox11.itemindex = 13 then Edit18.Text:='WANextTrack';
  if listbox11.itemindex = 14 then Edit18.Text:='WALastTrack';
  if listbox11.itemindex = 15 then Edit18.Text:='WAPlay';
  if listbox11.itemindex = 16 then Edit18.Text:='WAStop';
  if listbox11.itemindex = 17 then Edit18.Text:='WAPause';
  if listbox11.itemindex = 18 then Edit18.Text:='WAShuffle';
  if listbox11.itemindex = 19 then Edit18.Text:='WAVolDown';
  if listbox11.itemindex = 20 then Edit18.Text:='WAVolUp';
  if listbox11.itemindex = 21 then Edit18.Text:='GPO(4,1)';
  if listbox11.itemindex = 22 then Edit18.Text:='GPOToggle(4)';
  if listbox11.itemindex = 23 then Edit18.Text:='GPOFlash(4,5)';
  if listbox11.itemindex = 24 then Edit18.Text:='Fan(1,255)';
end;

procedure TForm2.PageControl2Change(Sender: TObject);
begin
  if Pagecontrol2.ActivePage=Tabsheet12 then begin
    unit1.setupbutton:=5;
    combobox9.ItemIndex:=0;
    try
      listbox11.Items.Delete(21);
      listbox11.Items.Delete(21);
      listbox11.Items.Delete(21);
      listbox11.Items.Delete(21);
    except end;
    if (radiobutton2.Checked) then begin
      listbox11.Items.Add('GPO(4-8,0/1) (0=off 1=on)');
      listbox11.Items.Add('GPOToggle(4-8)');
      listbox11.Items.Add('GPOFlash(4-8,2) (nr. of times)');
      if (form3.CheckBox1.Checked) then begin
        listbox11.Items.Add('Fan(1-3,0-255) (0-255=speed)');
      end;
    end;
  end;
  if Pagecontrol2.ActivePage=Tabsheet11 then begin
    if pagecontrol1.activepage=tabsheet13 then begin
      if pos('$MObutton',edit9.text) <> 0 then edit9.text:='Variable:';
      pagecontrol1.ActivePage:=Tabsheet1;
    end;
    edit10.text:=serversarray[combobox3.itemindex*4+1];
    unit1.setupbutton:=1;
    edit5.color:=$00A1D7A4;
    if edit6.enabled= true then edit6.color:=clWhite else edit6.color:=$00BBBBFF;
    if edit7.enabled= true then edit7.color:=clWhite else edit7.color:=$00BBBBFF;
    if edit8.enabled= true then edit8.color:=clWhite else edit8.color:=$00BBBBFF;
  end;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  if (edit16.text<>'') and (combobox9.itemindex<>-1) then begin
    form2.StringGrid1.Cells[0,form2.StringGrid1.RowCount-1]:=edit16.text;
    form2.StringGrid1.Cells[1,form2.StringGrid1.RowCount-1]:=form2.combobox9.Items.Strings[form2.combobox9.itemindex];
    form2.StringGrid1.Cells[2,form2.StringGrid1.RowCount-1]:=edit19.text;
    form2.StringGrid1.Cells[3,form2.StringGrid1.RowCount-1]:='then';
    form2.StringGrid1.Cells[4,form2.StringGrid1.RowCount-1]:=edit18.text;
    form2.StringGrid1.RowCount:=form2.StringGrid1.RowCount+1;
  end;
end;

procedure TForm2.Button9Click(Sender: TObject);
var
  teller,teller2,teller3:integer;

begin
  teller2:=form2.stringgrid1.Selection.Bottom-form2.stringgrid1.Selection.Top+1;
  for teller:= form2.stringgrid1.Selection.Top to form2.stringgrid1.Selection.Bottom do
    form2.stringGrid1.Rows[teller].clear;
  for teller3:= 1 to teller2 do begin
    for teller:= form2.stringgrid1.Selection.Top to form2.stringgrid1.RowCount do begin
      form2.stringGrid1.Cells[0,teller]:=form2.stringGrid1.Cells[0,teller+1];
      form2.stringGrid1.Cells[1,teller]:=form2.stringGrid1.Cells[1,teller+1];
      form2.stringGrid1.Cells[2,teller]:=form2.stringGrid1.Cells[2,teller+1];
      form2.stringGrid1.Cells[3,teller]:=form2.stringGrid1.Cells[3,teller+1];
      form2.stringGrid1.Cells[4,teller]:=form2.stringGrid1.Cells[4,teller+1];
    end;
  end;
  form2.StringGrid1.rowcount:=form2.StringGrid1.rowcount-teller2;
end;

procedure TForm2.ListBox12Click(Sender: TObject);
var
  tempint1,tempint2:integer;

begin
  if listbox12.itemindex > -1 then begin
    if listbox12.itemindex = 0 then Edit9.Text:='$MObutton';
    if unit1.setupbutton=1 then begin
      tempint1:=edit5.SelStart;
      tempint2:=edit5.SelLength;
      edit5.setfocus;
      edit5.SelStart:=tempint1;
      edit5.SelLength:=tempint2;
    end;
    if unit1.setupbutton=2 then begin
      tempint1:=edit6.SelStart;
      tempint2:=edit6.SelLength;
      edit6.setfocus;
      edit6.SelStart:=tempint1;
      edit6.SelLength:=tempint2;
    end;
    if unit1.setupbutton=3 then begin
      tempint1:=edit7.SelStart;
      tempint2:=edit7.SelLength;
      edit7.setfocus;
      edit7.SelStart:=tempint1;
      edit7.SelLength:=tempint2;
    end;
    if unit1.setupbutton=4 then begin
      tempint1:=edit8.SelStart;
      tempint2:=edit8.SelLength;
      edit8.setfocus;
      edit8.SelStart:=tempint1;
      edit8.SelLength:=tempint2;
    end;
  end;
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
  form7.visible:=true;
  form2.enabled:=false;
end;

procedure TForm2.Edit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(key)=38 then edit7.SetFocus;
  if ord(key)=40 then edit5.SetFocus;
end;

procedure TForm2.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(key)=38 then edit8.SetFocus;
  if ord(key)=40 then edit6.SetFocus;
end;

procedure TForm2.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(key)=38 then edit5.SetFocus;
  if ord(key)=40 then edit7.SetFocus;
end;

procedure TForm2.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(key)=38 then edit6.SetFocus;
  if ord(key)=40 then edit8.SetFocus;
end;

end.
