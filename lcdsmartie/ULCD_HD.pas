unit ULCD_HD;

interface

uses ULCD;

type
  TLCD_HD = class(TLCD)
    procedure customChar(character: Integer; data: array of Byte); override;
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String);  override;
    procedure setbacklight(on: Boolean);  override;
  end;

implementation

uses UMain, SysUtils;

procedure TLCD_HD.setbacklight(on: Boolean);
begin
  poort1.setbacklight(on)
end;

procedure TLCD_HD.write(str: String);
begin
  str:=StringReplace(str,'°',chr(0),[rfReplaceAll]);
  str:=StringReplace(str,'ž',chr(1),[rfReplaceAll]);
  str:=StringReplace(str,chr(131),chr(2),[rfReplaceAll]);
  str:=StringReplace(str,chr(132),chr(3),[rfReplaceAll]);
  str:=StringReplace(str,chr(133),chr(4),[rfReplaceAll]);
  str:=StringReplace(str,chr(134),chr(5),[rfReplaceAll]);
  str:=StringReplace(str,chr(135),chr(6),[rfReplaceAll]);
  str:=StringReplace(str,chr(136),chr(7),[rfReplaceAll]);

  poort1.writestring(str);
  inherited;
end;

procedure TLCD_HD.setPosition(x, y: Integer);
begin
  poort1.setcursor(x, y);
  inherited;
end;

procedure TLCD_HD.customChar(character: Integer; data: array of Byte);
var
  i: Byte;
begin

  with poort1 do begin
    // for 1st controller
    writectrl(64 + ((character-1) * 8));
    for i := 1 to 8 do
      writedata(data[i]);

    // for 2nd controller
    writectrl2(64 + ((character-1) * 8));
    for i := 1 to 8 do
      writedata2(data[i]);
    { why twice?
    writectrl2(64 + ((adr-1) * 8));
    for i := 1 to 8 do
      writedata2(data[i]);
    }
  end;

  inherited;
end;

end.

