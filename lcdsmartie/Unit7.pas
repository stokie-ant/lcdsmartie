unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox10: TComboBox;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses Unit6, Unit2;

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
  foo:integer;

begin
  try
    foo:=StrToInt(spinedit1.text);
  except
    SpinEdit1.text:='1';
  end;
  if SpinEdit1.Text='0' then SpinEdit1.Text:='1';
  if copy(SpinEdit1.Text,1,1) = '0' then Form7.SpinEdit1.Text:=copy(SpinEdit1.Text,2,1);
  form7.visible:=false;
  form2.enabled:=true;
  form2.BringToFront;
end;

procedure TForm7.ComboBox10Change(Sender: TObject);
begin
  if combobox10.ItemIndex=0 then
    spinedit1.Enabled:=False
  else
    spinedit1.Enabled:=True;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  if copy(form7.SpinEdit1.Text,1,1) = '0' then Form7.SpinEdit1.Text:=copy(form7.SpinEdit1.Text,2,1);
end;

end.
