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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/Unit4.pas,v $
 *  $Revision: 1.3 $ $Date: 2004/10/29 19:08:35 $
 *****************************************************************************}
unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,shellapi;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm4.FormClick(Sender: TObject);
begin
form1.enabled:=true;
form4.visible:=false;
form1.BringToFront;
end;

procedure TForm4.Label1Click(Sender: TObject);
begin
form1.enabled:=true;
form4.visible:=false;
form1.BringToFront;
end;

procedure TForm4.Image1Click(Sender: TObject);
begin
form1.enabled:=true;
form4.visible:=false;
form1.BringToFront;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.enabled:=true;
form4.visible:=false;
form1.BringToFront;

end;

procedure TForm4.Label2Click(Sender: TObject);

begin
  ShellExecute(0, Nil, pchar('http://lcdsmartie.sourceforge.net/'), Nil, Nil, SW_NORMAL);
end;

end.
