unit UPara;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/UPara.pas,v $
 *  $Revision: 1.8 $ $Date: 2006/03/03 04:03:41 $
 *****************************************************************************}

interface

uses Forms, StdCtrls, Spin, Controls, Classes;

type
  THD44780SetupForm = class(TForm)
    Label1: TLabel;
    PortEdit: TEdit;
    BootDelaySpinEdit: TSpinEdit;
    Label2: TLabel;
    OKButton: TButton;
    AltAddressingCheckbox: TCheckBox;
    TimingMultiplierSpinEdit: TSpinEdit;
    Label3: TLabel;
    CancelButton: TButton;
    KS0073AddressingCheckbox: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoHD44780SetupForm : boolean;

implementation

uses
  UConfig, USetup, SysUtils;

{$R *.DFM}

function DoHD44780SetupForm : boolean;
var
  HD44780SetupForm : THD44780SetupForm;
begin
  HD44780SetupForm := THD44780SetupForm.Create(nil);
  with HD44780SetupForm do begin
    // put settings on screen
    PortEdit.text := IntToHex(config.parallelPort, 3);
    BootDelaySpinEdit.Value := config.bootDriverDelay;
    TimingMultiplierSpinEdit.value := config.iHDTimingMultiplier;
    AltAddressingCheckbox.checked := config.bHDAltAddressing;
    KS0073AddressingCheckbox.checked := config.bHDKS0073Addressing;
    ShowModal;
    Result := (ModalResult = mrOK);
    if Result then begin
      try
        config.parallelPort := StrToInt('$' + PortEdit.text);
      except
        config.parallelPort := $378;
      end;
      config.bootDriverDelay := BootDelaySpinEdit.Value;
      config.iHDTimingMultiplier := TimingMultiplierSpinEdit.value;
      config.bHDAltAddressing := AltAddressingCheckbox.checked;
      config.bHDKS0073Addressing := KS0073AddressingCheckbox.checked;
    end;
    Free;
  end;
end;

end.
