unit ULCD_HD;

interface

uses ULCD;

type
  TLCD_HD = class(TLCD)
    procedure customChar(character: Integer; data: Array of Byte); override;
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String); override;
    procedure setbacklight(on: Boolean); override;
    procedure powerResume; override;
  end;

implementation

uses UMain, SysUtils;

procedure TLCD_HD.powerResume;
begin
  poort1.powerResume;
end;

procedure TLCD_HD.setbacklight(on: Boolean);
begin
  poort1.setbacklight(on)
end;

procedure TLCD_HD.write(str: String);
var
 i: Cardinal;
begin
  for i:= 1 to Length(str) do
  begin
    case Ord(str[i]) of
      Ord('°'): str[i]:=Chr(0);
      Ord('ž'): str[i]:=Chr(1);
      131: str[i]:=Chr(2);
      132: str[i]:=Chr(3);
      133: str[i]:=Chr(4);
      134: str[i]:=Chr(5);
      135: str[i]:=Chr(6);
      136: str[i]:=Chr(7);
    end;
  end;

  poort1.writeString(str);
  inherited;
end;

procedure TLCD_HD.setPosition(x, y: Integer);
begin
  poort1.setcursor(x, y);
  inherited;
end;

procedure TLCD_HD.customChar(character: Integer; data: Array of Byte);
var
  i: Byte;
begin

  with poort1 do
  begin
    // for 1st controller
    writectrl(64 + ((character-1) * 8));
    for i := 0 to 7 do writedata(data[i]);

    // for 2nd controller
    writectrl2(64 + ((character-1) * 8));
    for i := 0 to 7 do writedata2(data[i]);
    { why twice?
    writectrl2(64 + ((adr-1) * 8));
    for i := 1 to 8 do
      writedata2(data[i]);
    }
  end;

  inherited;
end;

end.

