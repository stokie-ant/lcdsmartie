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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/Unit7.pas,v $
 *  $Revision: 1.2 $ $Date: 2004/10/25 22:52:48 $
 *****************************************************************************}
unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

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

uses Unit6, Unit2;

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
  foo:integer;

begin
  try
    foo:=StrToInt(spinedit1.text);
  except
    SpinEdit1.text:='1';
  end;
  if SpinEdit1.Text='0' then SpinEdit1.Text:='1';
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
