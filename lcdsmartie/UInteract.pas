unit UInteract;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/UInteract.pas,v $
 *  $Revision: 1.2 $ $Date: 2004/11/11 22:48:33 $
 *****************************************************************************}

interface

uses Forms, StdCtrls, Spin, Controls, Classes;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox10: TComboBox;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses SysUtils, USetup;

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  try
    // Using StrInt to ensure the text is a number - otherwise an exception will occur.
    if StrToInt(spinedit1.text)=0 then SpinEdit1.Text:='1';
  except
    SpinEdit1.text:='1';
  end;

  if copy(SpinEdit1.Text,1,1) = '0' then Form7.SpinEdit1.Text:=copy(SpinEdit1.Text,2,1);
  form7.visible:=false;
  form2.enabled:=true;
  form2.BringToFront;
end;

procedure TForm7.ComboBox10Change(Sender: TObject);
begin
  if combobox10.ItemIndex=0 then
    spinedit1.Enabled:=False
  else
    spinedit1.Enabled:=True;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  if copy(form7.SpinEdit1.Text,1,1) = '0' then Form7.SpinEdit1.Text:=copy(form7.SpinEdit1.Text,2,1);
end;

end.
