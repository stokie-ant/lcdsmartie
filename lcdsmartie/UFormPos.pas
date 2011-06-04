unit UFormPos;


interface
type
 TFormPos = class(TObject)
  private
    sFileName: String;

  public
    Tag: string;
    Top: Integer;    // last main form position
    Left: Integer;
    Height : Integer;
    Width: Integer;

    function load: Boolean;
    procedure save;
    procedure savePos;
    procedure saveSize;
    property filename: String read sFileName;
    constructor Create(filename: String);
  end;

var
  FormPos: TFormPos;

implementation

uses Forms,SysUtils, INIFiles, StrUtils;

constructor TFormPos.Create(filename: String);
begin
  sFileName := filename;
  Tag :='form';
  inherited Create();
end;

function TFormPos.load: Boolean;
var
  initfile: TMemINIFile;
begin

  try
    initfile := TMemINIFile.Create(ExtractFilePath(Application.EXEName) +
      sFileName);
  except
    result := false;
    Exit;
  end;

  Top    := initfile.ReadInteger(Tag, 'Top', -1);
  Left   := initfile.ReadInteger(Tag, 'Left', -1);
  Width  := initfile.ReadInteger(Tag, 'Width', 300);
  Height := initfile.ReadInteger(Tag, 'Height', 200);

  result := true;
  initfile.Free;
end;

procedure TFormPos.save();
var
  initfile : TMemINIFile;
begin
  initfile := TMemINIFile.Create(ExtractFilePath(Application.EXEName) +
    sFileName);
  initfile.WriteInteger(Tag, 'Top',    Top);
  initfile.WriteInteger(Tag, 'Left',   Left);
  initfile.WriteInteger(Tag, 'Width',  Width);
  initfile.WriteInteger(Tag, 'Height', Height);
  initfile.UpdateFile;
  initfile.Free;
end;


// save current form position
procedure TFormPos.savePos();
var
  initfile : TMemINIFile;
begin
  initfile := TMemINIFile.Create(ExtractFilePath(Application.EXEName) +
    sFileName);
  initfile.WriteInteger(Tag, 'Top',  Top);
  initfile.WriteInteger(Tag, 'Left', Left);
  initfile.UpdateFile;
  initfile.Free;
end;


procedure TFormPos.saveSize();
var
  initfile : TMemINIFile;
begin
  initfile := TMemINIFile.Create(ExtractFilePath(Application.EXEName) +
    sFileName);

  initfile.WriteInteger(Tag, 'Width',  Width);
  initfile.WriteInteger(Tag, 'Height', Height);
  initfile.UpdateFile;
  initfile.Free;
end;

end.
