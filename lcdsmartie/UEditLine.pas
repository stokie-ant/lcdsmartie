unit UEditLine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UConfig;

type
  TFormEdit = class(TForm)
    Memo1: TMemo;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure EditClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  FormEdit: TFormEdit;

implementation

{$R *.dfm}
uses
  UFormPos;

procedure TFormEdit.EditClose(Sender: TObject; var Action: TCloseAction);
var
  FEdit: TFormEdit;
  Pos : TFormPos;

begin
  FEdit := Sender AS TFormEdit;
  Pos := TFormPos.Create('forms.ini');
  Pos.Tag := 'edit';
  Pos.Width := FEdit.Width;
  Pos.Height := Fedit.Height;
  Pos.saveSize;
end;

end.
