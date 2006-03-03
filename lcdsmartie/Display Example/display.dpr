library display;

uses
  SysUtils,Classes,SERPORT;

{$R *.res}

type
  pboolean = ^boolean;
  TCustomArray = array[1..8] of byte;
var
  COMPort : TSerialPort = nil;

function DISPLAYDLL_Init(SizeX,SizeY : byte; StartupParameters : pchar; OK : pboolean) : pchar; stdcall;
// return startup error
// open port
begin
  COMPort := TSerialPort.Create;
  OK^ := true;
  Result := PChar('DISPLAY.DLL v1.0');
  try
    COMPort.OpenSerialPort(string(StartupParameters));
  except
    on E: Exception do begin
      result := PChar('DISPLAY.DLL Exception: ' + E.Message);
      OK^ := false;
    end;
  end;
end;

procedure DISPLAYDLL_Done(); stdcall;
// close port
begin
  COMPort.Free;
end;

procedure DISPLAYDLL_SetPosition(X, Y: byte); stdcall;
// set cursor position
begin
end;

procedure DISPLAYDLL_Write(Str : pchar); stdcall;
// write string
var
  S : string;
  Loop : longint;
begin
  S := string(Str);
  for Loop := 1 to length(S) do
    COMPort.WriteByte(ord(S[Loop]));
end;

procedure DISPLAYDLL_CustomChar(Chr : byte; Data : TCustomArray); stdcall;
// define custom character
begin
end;

function DISPLAYDLL_ReadKey : word; stdcall;
// return 00xx upon success, FF00 on fail
begin
  Result := $FF00;
end;

procedure DISPLAYDLL_SetBacklight(LightOn : boolean); stdcall;
// turn on backlighting
begin
end;

procedure DISPLAYDLL_SetContrast(Contrast : byte); stdcall;
// 0 - 255
begin
end;

procedure DISPLAYDLL_SetBrightness(Brightness : byte); stdcall;
// 0 - 255
begin
end;

procedure DISPLAYDLL_PowerResume; stdcall;
// resume power
begin
end;

procedure DISPLAYDLL_SetGPO(GPO : byte; GPOOn : boolean); stdcall;
// turn on backlighting
begin
end;

procedure DISPLAYDLL_SetFan(T1,T2 : integer); stdcall;
// set fan output
begin
end;


// don't forget to export the funtions, else nothing works :)
exports
  DISPLAYDLL_SetFan,
  DISPLAYDLL_SetGPO,
  DISPLAYDLL_PowerResume,
  DISPLAYDLL_SetBrightness,
  DISPLAYDLL_SetContrast,
  DISPLAYDLL_SetBacklight,
  DISPLAYDLL_ReadKey,
  DISPLAYDLL_CustomChar,
  DISPLAYDLL_Write,
  DISPLAYDLL_SetPosition,
  DISPLAYDLL_Done,
  DISPLAYDLL_Init;
begin
end.

