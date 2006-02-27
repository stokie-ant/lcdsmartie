unit UIRSetup;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/UIRSetup.pas,v $
 *  $Revision: 1.2 $ $Date: 2006/02/27 14:15:29 $
 *****************************************************************************}


interface

uses StdCtrls, ComCtrls, Classes, Controls, Forms;

type
  TIRTransForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    IRBrightnessTrackBar: TTrackBar;
    Host: TLabel;
    HostEdit: TEdit;
    procedure IRBrightnessTrackBarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoIRTransForm : boolean;

implementation

uses
  USetup, UMain;

{$R *.DFM}

function DoIRTransForm : boolean;
var
  IRTransForm: TIRTransForm;
begin
  Result := false;
  IRTransForm := TIRTransForm.Create(nil);
  with IRTransForm do begin
    IRBrightnessTrackBar.Position := config.IR_brightness;
    HostEdit.Text := config.remotehost;
    ShowModal;
    if (ModalResult = mrOK) then begin
      Result := true;
      if (config.isIR) then begin
        Form1.lcd.setBrightness(IRBrightnessTrackBar.Position);
      end;
      config.remotehost := HostEdit.Text;
    end;
    Free;
  end;
end;

// MO options - brightness bar.
procedure TIRTransForm.IRBrightnessTrackBarChange(Sender: TObject);
begin
  if (config.isIR) then begin
    Form1.lcd.setBrightness(IRBrightnessTrackBar.Position);
  end;
  config.IR_brightness := IRBrightnessTrackBar.Position;
end;

end.
