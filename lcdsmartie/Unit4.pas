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
  ShellExecute(0, Nil, pchar('http://backupteam.gamepoint.net/smartie/'), Nil, Nil, SW_NORMAL);
end;

end.
