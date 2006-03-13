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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/_SSL/Attic/UInteract.pas,v $
 *  $Revision: 1.1 $ $Date: 2006/03/13 14:10:15 $
 *****************************************************************************}

interface

uses Forms, StdCtrls, Spin, Controls, Classes, UConfig;

type
  TTransitionConfigForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TransitionStyleComboBox: TComboBox;
    TransitionTimeSpinEdit: TSpinEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure TransitionStyleComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoTransitionConfigForm(var Style : TTransitionStyle;
                                var Time : byte) : boolean;

implementation

uses
  SysUtils, USetup;

{$R *.dfm}

function DoTransitionConfigForm(var Style : TTransitionStyle;
                                var Time : byte) : boolean;
var
  TransitionConfigForm : TTransitionConfigForm;
begin
  TransitionConfigForm := TTransitionConfigForm.Create(nil);
  with TransitionConfigForm do begin
    // put settings on screen
    TransitionStyleComboBox.ItemIndex := ord(Style);
    TransitionTimeSpinEdit.Value := Time;
    TransitionTimeSpinEdit.Enabled := not (TransitionStyleComboBox.ItemIndex = 0);
    ShowModal;
    Result := (ModalResult = mrOK);
    if Result then begin
      Style := TTransitionStyle(TransitionStyleComboBox.ItemIndex);
      Time := TransitionTimeSpinEdit.Value;
    end;
    Free;
  end;
end;

procedure TTransitionConfigForm.TransitionStyleComboBoxChange(Sender: TObject);
begin
  TransitionTimeSpinEdit.Enabled := not (TransitionStyleComboBox.ItemIndex = 0);
end;

end.
