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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/Unit5.pas,v $
 *  $Revision: 1.2 $ $Date: 2004/10/25 22:52:48 $
 *****************************************************************************}
unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TForm5 = class(TForm)
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    TrackBar2: TTrackBar;
    TrackBar1: TTrackBar;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit2,unit1;

{$R *.DFM}

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  button1.click;
end;


procedure TForm5.FormShow(Sender: TObject);
begin
  trackbar1.position:=strtoint(copy(configarray[3],pos('¿3',configarray[3])+2,pos('¿4',configarray[3])-pos('¿3',configarray[3])-2));
  trackbar2.position:=strtoint(copy(configarray[3],pos('¿4',configarray[3])+2,3));
end;

procedure TForm5.TrackBar1Change(Sender: TObject);
begin
  Form1.VaComm2.WriteChar(chr(15));
  Form1.VaComm2.WriteChar(chr(trackbar1.Position));
  configarray[3]:=copy(configarray[3],1,pos('¿3',configarray[3])+1)+inttostr(trackbar1.position)+copy(configarray[3],pos('¿4',configarray[3]),length(configarray[3]));
end;

procedure TForm5.TrackBar2Change(Sender: TObject);
begin
  Form1.VaComm2.WriteChar(chr(14));
  Form1.VaComm2.WriteChar(chr(trackbar2.Position));
  configarray[3]:=copy(configarray[3],1,pos('¿4',configarray[3])+1)+inttostr(trackbar2.position);
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  form5.visible:=false;
  form2.enabled:=true;
  form2.BringToFront;
end;

end.
