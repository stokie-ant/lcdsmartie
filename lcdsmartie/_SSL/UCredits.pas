unit UCredits;
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/_SSL/Attic/UCredits.pas,v $
 *  $Revision: 1.1 $ $Date: 2006/03/13 14:10:15 $
 *****************************************************************************}

interface

uses Forms, ExtCtrls, Classes, StdCtrls, Graphics, Controls;

type
  TCreditsForm = class(TForm)
    Label2: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure CloseClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoCreditsForm;

implementation

uses Windows, ShellApi;

{$R *.DFM}

procedure DoCreditsForm;
var
  CreditsForm: TCreditsForm;
begin
  CreditsForm := TCreditsForm.Create(nil);
  with CreditsForm do begin
    ShowModal;
    Free;
  end;
end;

procedure TCreditsForm.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCreditsForm.Label2Click(Sender: TObject);

begin
  ShellExecute(0, Nil, pchar('http://lcdsmartie.sourceforge.net/'), Nil, Nil,
    SW_NORMAL);
end;

end.
