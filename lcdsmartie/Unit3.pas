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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/Unit3.pas,v $
 *  $Revision: 1.2 $ $Date: 2004/10/25 22:52:48 $
 *****************************************************************************}
unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, unit1, ComCtrls;

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
  combobox19temp:integer;

implementation

uses Unit2;

{$R *.DFM}

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then button2.click();
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  form3.visible:=false;
  form2.enabled:=true;
  form2.BringToFront;
end;

procedure TForm3.Button1Click(Sender: TObject);

begin
  form1.VaComm1.WriteChar(Chr($0FE));
  form1.VaComm1.WriteChar(chr($091));
  form1.VaComm1.WriteChar(chr(trackbar1.position));

  form1.VaComm1.WriteChar(Chr($0FE));
  form1.VaComm1.WriteChar(Chr($098));
  form1.VaComm1.WriteChar(chr(trackbar2.position));

  form3.visible:=false;
  form2.enabled:=true;
  form2.BringToFront;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  trackbar1.position:=strtoint(copy(configarray[3],pos('¿1',configarray[3])+2,pos('¿2',configarray[3])-pos('¿1',configarray[3])-2));
  trackbar2.position:=strtoint(copy(configarray[3],pos('¿2',configarray[3])+2,pos('¿3',configarray[3])-pos('¿2',configarray[3])-2));
end;

procedure TForm3.TrackBar1Change(Sender: TObject);
begin
  form1.VaComm1.WriteChar(Chr($0FE));
  form1.VaComm1.WriteChar('P');
  form1.VaComm1.WriteChar(chr(trackbar1.position));
  configarray[3]:=copy(configarray[3],1,pos('¿1',configarray[3])+1)+inttostr(trackbar1.position)+copy(configarray[3],pos('¿2',configarray[3]),length(configarray[3]));
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  button2.click;
end;

procedure TForm3.TrackBar2Change(Sender: TObject);
begin
  form1.VaComm1.WriteChar(Chr($0FE));
  form1.VaComm1.WriteChar(Chr($099));
  form1.VaComm1.WriteChar(chr(trackbar1.position));
  configarray[3]:=copy(configarray[3],1,pos('¿2',configarray[3])+1)+inttostr(trackbar2.position)+copy(configarray[3],pos('¿3',configarray[3]),length(configarray[3]));
end;

end.
