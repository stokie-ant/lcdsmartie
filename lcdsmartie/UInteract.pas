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
 *  $Revision: 1.5 $ $Date: 2006/02/27 18:35:47 $
 *****************************************************************************}

interface

uses Forms, StdCtrls, Spin, Controls, Classes;

// these should be passed in as variables instead of globals
var
  GlobalInteractionStyle : byte = 0;
  GlobalInteractionTime : byte = 1;

type
  TInteractionConfigForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    InteractionStyleComboBox: TComboBox;
    InteractionTimeSpinEdit: TSpinEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure InteractionStyleComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoInteractionConfigForm : boolean;

implementation

uses SysUtils, USetup;

{$R *.dfm}

function DoInteractionConfigForm : boolean;
var
  InteractionConfigForm : TInteractionConfigForm;
begin
  InteractionConfigForm := TInteractionConfigForm.Create(nil);
  with InteractionConfigForm do begin
    // put settings on screen
    InteractionStyleComboBox.ItemIndex := GlobalInteractionStyle;
    InteractionTimeSpinEdit.Value := GlobalInteractionTime;
    InteractionTimeSpinEdit.Enabled := not (InteractionStyleComboBox.ItemIndex = 0);
    ShowModal;
    Result := (ModalResult = mrOK);
    if Result then begin
      GlobalInteractionStyle := InteractionStyleComboBox.ItemIndex;
      GlobalInteractionTime := InteractionTimeSpinEdit.Value;
    end;
    Free;
  end;
end;

procedure TInteractionConfigForm.InteractionStyleComboBoxChange(Sender: TObject);
begin
  InteractionTimeSpinEdit.Enabled := not (InteractionStyleComboBox.ItemIndex = 0);
end;

end.
