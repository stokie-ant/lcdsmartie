unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses Unit3, Unit2;

{$R *.DFM}

procedure TForm6.Button1Click(Sender: TObject);
begin
  form6.visible:=false;
  form2.enabled:=true;
  form2.BringToFront;
end;

end.
