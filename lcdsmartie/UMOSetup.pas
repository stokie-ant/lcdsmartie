unit UMOSetup;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/UMOSetup.pas,v $
 *  $Revision: 1.5 $ $Date: 2005/01/27 10:43:35 $
 *****************************************************************************}


interface

uses StdCtrls, ComCtrls, Classes, Controls, Forms;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    TrackBar1: TTrackBar;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    TrackBar2: TTrackBar;
    CheckBox1: TCheckBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses USetup, UMain;

{$R *.DFM}

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(27) then button2.click();
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  form3.visible := false;
  form2.enabled := true;
  form2.BringToFront;
end;

procedure TForm3.Button1Click(Sender: TObject);

begin
  if (config.isMO) then
  begin
    form1.lcd.setContrast(trackbar1.position);
    form1.lcd.setBrightness(trackbar2.position);
  end;

  form3.visible := false;
  form2.enabled := true;
  form2.BringToFront;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  trackbar1.position := config.contrast;
  trackbar2.position := config.brightness;
end;

// MO options - contrast bar.
procedure TForm3.TrackBar1Change(Sender: TObject);
begin
  if (config.isMO) then
    form1.lcd.setContrast(trackbar1.position);
  config.contrast := trackbar1.position;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  button2.click;
end;

// MO options - brightness bar.
procedure TForm3.TrackBar2Change(Sender: TObject);
begin
  if (config.isMO) then
    form1.lcd.setBrightness(trackbar2.position);
  config.brightness := trackbar2.position;
end;

end.
