unit ULCD_Test;

interface

uses ULCD, USerial;

type
  TLCD_Test = class(TLCD)
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String); override;
    constructor CreateSerial(uiPort: Cardinal; baudRate: Cardinal);
    destructor Destroy; override;
  private
    sInit: String;
    sFini: String;
    sGotoLine1, sGotoLine2, sGotoLine3, sGotoLine4: String;
    charmap: Array [0..255] of Char;
    serial: TSerial;
    function Parse(str: String): String;
  end;

implementation

uses UConfig, SysUtils, Forms, Windows, StrUtils;

constructor TLCD_Test.CreateSerial(uiPort: Cardinal; baudRate: Cardinal);
var
  flags: TSerialFlags;
  sCharMap: String;
  i: Integer;
begin

  // parse config settings
  sInit := Parse(config.testDriver.sInit);
  sFini := Parse(config.testDriver.sFini);
  sGotoLine1 := Parse(config.testDriver.sGotoLine1);
  sGotoLine2 := Parse(config.testDriver.sGotoLine2);
  sGotoLine3 := Parse(config.testDriver.sGotoLine3);
  sGotoLine4 := Parse(config.testDriver.sGotoLine4);

  // set to defaults
  for i:=0 to 255 do
    charmap[i] := Chr(i);

  // replace custom chars with space
  charmap[Ord('°')] := ' ';
  charmap[Ord('ž')] := ' ';
  charmap[131] := ' ';
  charmap[132] := ' ';
  charmap[133] := ' ';
  charmap[134] := ' ';
  charmap[135] := ' ';
  charmap[136] := ' ';

  // Process their mapping
  sCharMap := Parse(config.testDriver.sCharMap);
  for i:=0 to (Length(sCharMap) div 2)-1 do
  begin
    charmap[Ord(sCharMap[i*2+1])] := sCharMap[i*2+2];
  end;

  flags := [RTS_ENABLE, DTR_ENABLE];

  if (config.testDriver.iStopBits = 2) then
    flags := flags + [TWO_STOPBITS];

  if (config.testDriver.iParity = 1) then
    flags := flags + [ODD_PARITY]
  else if (config.testDriver.iParity = 2) then
    flags := flags + [EVEN_PARITY];

  serial := TSerial.Create(uiPort, baudRate, flags);

  serial.Write(sInit);

  inherited Create;
end;


destructor TLCD_Test.Destroy;
begin
  if (Assigned(serial)) then
  begin
    serial.Write(sFini);
    serial.Destroy;
  end;

  inherited;
end;


procedure TLCD_Test.setPosition(x, y: Integer);
begin
  assert(x = 1);

  case y of
  1: serial.Write(sGotoLine1);
  2: serial.Write(sGotoLine2);
  3: serial.Write(sGotoLine3);
  4: serial.Write(sGotoLine4);
  end;
end;

procedure TLCD_Test.write(str: String);
var
  i: Integer;
begin
  // Replace all custom chars as spaces.
  for i:= 1 to Length(str) do
    str[i] := charmap[Ord(str[i])];

  serial.Write(str);
end;

// take a string of the form:
// D1,D2,D3...D5,D6 where Dx is 0 to 255
// and convert into a string
// C1C2C3C4C5C6  where Cx is the character with value Dx
function TLCD_Test.Parse(str: String): String;
var
  comma: Integer;
  s: String;
  value: Integer;
begin
  s := '';

  while (str <> '') do
  begin
    comma := Pos(',', str);
    if (comma = 0) then comma := Length(str)+1;
    value := StrToInt(copy(str, 1, comma-1));
    s := s + Chr(value);
    str := copy(str,comma+1, Length(str));
  end;

  Result := s;
end;

end.
