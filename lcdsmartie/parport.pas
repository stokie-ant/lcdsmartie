unit parport;

//////////////////////////////////////////////////////////////////////||
//                                                                    ||
//  made/'ported'/optimized by Teabeats                               ||
//  (p.f.schrijver@student.utwente.nl)                                ||
//                                                                    ||
//  many credits go to Randy Rasa(rrasa@sky.net) for sharing          ||
//  his c code, which gave me plenty of insight to the lcd's          ||
//  controller usage (go to http://www.sky.net/~rrasa for his code)   ||
//                                                                    ||
//  v1.4, build 3 (1 and 2 controller version)                        ||
//                                                                    ||
//  last updated: 20-apr-2002                                         ||
//                                                                    ||
//  note: DLPortIO.DLL should be in $windir/system32/                 ||
//        DLPortIO.SYS should be in $windir/system32/drivers/         ||
//                                                                    ||
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

interface

uses Windows;

procedure DlPortWritePortUchar(Port: Integer; Data: Byte); stdcall;  external 'dlportio.dll';
function DlPortReadPortUchar(Port: Integer): Byte stdcall;  external 'dlportio.dll';

type
  TParPort = class(TObject)
    private
      FBaseAddr: Word;
      FCtrlAddr: Word;
      cursorx, cursory: Word;
      backlight, lcd16, width, heigth: Byte;
      kut: Boolean;

      procedure init;
      procedure CtrlOut(const AValue: Byte);
      procedure DataOut(const AValue: Byte);
      procedure initClass;
   public
      procedure powerResume;
      procedure writectrl(const x: Byte);
      procedure writectrl2(const x: Byte);
      procedure writedata(const x: Byte);
      procedure writedata2(const x: Byte);
      procedure writestring1(s: String);
      procedure writestring2(s: String);
      procedure setcursor1(const x, y: Byte);
      procedure setcursor2(const x, y: Byte);
      procedure setcursor3(const x, y: Byte); //1 controller lcd's
      procedure writestring(s: String);
      procedure setcursor(const x, y: Byte);
      procedure clear;
      procedure setbacklight(const light: Boolean);
      function lcdpresent: Boolean;
      constructor Create(const poortadres: Word; const width, heigth: Byte);
      destructor Destroy; override;
end;

implementation

procedure TParPort.setbacklight(const light: Boolean);
begin
  if light and not kut then backlight := 0 else backlight := 8;
  clear; //update 'lightline'            
end;



procedure TParPort.init;
begin
  writectrl(56);
  writectrl(56);
  writectrl(56);
  writectrl(6);
  writectrl(12);

  if kut then begin
    writectrl2(56);
    writectrl2(56);
    writectrl2(56);
    writectrl2(6);
    writectrl2(12);
  end;
end;

procedure TParPort.clear;
begin
  writectrl(1);
  writectrl2(1);
end;

procedure TParPort.writectrl(const x: Byte);
begin
  CtrlOut(3 or backlight);  // 3/11 RS=0, R/W=0, E=0
  DataOut(x);
  CtrlOut(2 or backlight);  // 2/10 RS=0, R/W=0, E1=1, E2=0
  CtrlOut(3 or backlight);  // 3/11 RS=0, R/W=0, E=0
  CtrlOut(1 or backlight);  // 1/9 RS=0, R/W=1, E=0
  Sleep(3); //max execution time = 1,64 ms, so this should be safe
end;

procedure TParPort.writectrl2(const x: Byte);
begin
  CtrlOut(11);  // RS=0, R/W=0, E=0
  DataOut(x);
  CtrlOut(3);  // RS=0, R/W=0, E2=1, E1=0
  CtrlOut(11);  // RS=0, R/W=0, E=0
  CtrlOut(9);  // RS=0, R/W=1, E=0
  Sleep(3); //max execution time = 1,64 ms, so this should be safe
end;

procedure TParPort.writedata(const x: Byte);
var
  i: Integer;
begin
  CtrlOut(7 or backlight);     //7 + 8
  DataOut(x);
  CtrlOut(6 or backlight);     //6  RS=1, R/W=0, E=1  /0110
  CtrlOut(7 or backlight);     //7
  CtrlOut(5 or backlight);     //5

  //Sleep(1);  //instead of the line below because of faster processors
  for i := 0 to 65535 do begin { +/- 40 us } end;
  for i := 0 to 65535 do begin { +/- 40 us } end;
end;

procedure TParPort.writedata2(const x: Byte);
var
  i: Integer;
begin
  CtrlOut(15 );
  DataOut(x);
  CtrlOut(7 );
  CtrlOut(15 );
  CtrlOut(13 );
  //Sleep(1);  //instead of the line below because of faster processors
  for i := 0 to 65535 do begin { +/- 40 us } end;
  for i := 0 to 65535 do begin { +/- 40 us } end;
end;

procedure TParPort.writestring(s: String);
begin
  if (cursory < 3) or not kut then writestring1(s)
  else writestring2(s);
end;

procedure TParPort.writestring1(s: String);
var
  i: Byte;
begin
  i := 1;
  while (i <= length(s)) and (cursorx <= width) do begin
    writedata(ord(s[i]));
    inc(i);
    inc(cursorx);
  end;
  //for i := 1 to length(s) do writedata(ord(s[i]));
end;

procedure TParPort.writestring2(s: String);
var
  i: Byte;
begin
  i := 1;
  while (i <= length(s)) and (cursorx <= width) do begin
    writedata2(ord(s[i]));
    inc(i);
    inc(cursorx);
  end;
  //for i := 1 to length(s) do writedata2(ord(s[i]));
end;

procedure TParPort.setcursor(const x, y: Byte);
begin
  if not kut then setcursor3(x, y)
  else if y < 3 then setcursor1(x, y)
  else setcursor2(x, y);
  cursory := y;
end;

procedure TParPort.setcursor1(const x, y: Byte);
begin
  case y of
    1: writectrl(127 + x);
    2: writectrl(191 + x);
  end;
  cursorx := x;
end;

procedure TParPort.setcursor2(const x, y: Byte);
begin
  case y of
    3: writectrl2(127 + x);
    4: writectrl2(191 + x);
  end;
  cursorx := x;
end;

procedure TParPort.setcursor3(const x, y: Byte);
begin
  case y of
    1: writectrl(127 + x);
    2: writectrl(191 + x);
    3: writectrl(147 + x - lcd16);
    4: writectrl(211 + x - lcd16);
  end;
  cursorx := x;
end;

constructor TParPort.Create(const poortadres: Word; const width, heigth: Byte);
begin
  FBaseAddr := poortadres;
  FCtrlAddr := FBaseAddr + 2;
  self.width := width;
  self.heigth := heigth;
  initClass;
end;

procedure TParPort.powerResume;
begin
  initClass;
end;

procedure TParPort.initClass;
begin
  backlight := 0;
  cursorx := 1;
  cursory := 1;

  //defining wether lcd is 1 or 2 controller based
  if (width >= 40) and (heigth >= 4) then begin
    kut := True;
    backlight := 8;
  end
  else kut := False;

  //adjustment for 16 column lcd's
  if width > 16 then lcd16 := 0 else lcd16 := 4;
  init;
end;

procedure TParPort.CtrlOut(const AValue: Byte);
begin
  DlPortWritePortUchar(FCtrlAddr, AValue);
end;

procedure TParPort.DataOut(const AValue: Byte);
begin
  DlPortWritePortUchar(FBaseAddr, AValue);
end;

function TParPort.lcdpresent: Boolean;
begin
  Result := DlPortReadPortUchar(FCtrlAddr) < 255;
  init;
end;

destructor TParPort.Destroy;
begin
  inherited Destroy;
end;

end.

