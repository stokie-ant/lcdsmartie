library lisvfd;

{$R *.res}

uses
  Windows,SysUtils,SyncObjs,Math,SERPORT;

(*

 revhist

1.0 initial driver

*)

const
  DLLProjectName = 'LIS VFD Display DLL';
  Version = 'v1.0';
type
  pboolean = ^boolean;
  TCustomArray = array[0..7] of byte;

var
  COMPort : TSerialPort = nil;

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

function DISPLAYDLL_CustomCharIndex(Index : byte) : byte; stdcall;
begin
  DISPLAYDLL_CustomCharIndex := Index+7;
end;

procedure DISPLAYDLL_Write(Str : pchar); stdcall;
// write string
var
  S : string;
begin
  S := string(Str);
  try
    COMPort.WriteByte(0);
    COMPort.WriteByte($A7);
    COMPort.Write(@S[1], length(S));
  except
  end;
end;

procedure DISPLAYDLL_SetPosition(X, Y: byte); stdcall;
// set cursor position
begin
  try
    if assigned(COMPort) then begin
      COMPort.WriteByte(0);
      if (Y = 1) then
        COMPort.WriteByte($A1)
      else
        COMPort.WriteByte($A2);
    end;
  except
  end;
end;

procedure DISPLAYDLL_CustomChar(Chr : byte; Data : TCustomArray); stdcall;
// define custom character
var
  Loop : longint;
begin
  try
    if assigned(COMPort) then begin
      COMPort.WriteByte(0);
      for Loop := 0 to 7 do begin
        COMPort.WriteByte($AB);
        COMPort.WriteByte(Chr - 1);
        COMPort.WriteByte(Loop);
        COMPort.WriteByte(Data[Loop] and $1F);
      end;
    end;
  except
  end;
end;

procedure DISPLAYDLL_SetBrightness(Brightness : byte); stdcall;
// VFD only
begin
  Brightness := Brightness div 64;  // 0-3 is the brightness
  try
    if assigned(COMPort) then begin
      COMPort.WriteByte(0);
      COMPort.WriteByte($A5);
      COMPort.WriteByte(59-Brightness);
    end;
  except
  end;
end;

function SubString(var S : string) : string;
var
  P : longint;
begin
  P := pos(',',S);
  if (P > 0) then begin
    SubString := uppercase(trim(copy(S,1,P-1)));
    delete(S,1,P);
  end else begin
    SubString := uppercase(trim(S));
    S := '';
  end;
end;

function DISPLAYDLL_Init(SizeX,SizeY : byte; StartupParameters : pchar; OK : pboolean) : pchar; stdcall;
// return startup error
// open port
var
  S,S2 : string;
begin
  OK^ := true;
  Result := PChar(DLLProjectName + ' ' + Version + #0);
  try
    S2 := uppercase(string(StartupParameters));
    S := substring(S2) + ',' + substring(S2);  // get COM1,9600
    S := S + ',8,N,1';
    COMPort := TSerialPort.Create;
    COMPort.OpenSerialPort(S);
  except
    on E: Exception do begin
      result := PChar('LISVFD.DLL Exception: ' + E.Message + #0);
      OK^ := false;
    end;
  end;
end;

procedure DISPLAYDLL_Done(); stdcall;
// close port
begin
  try
    if assigned(COMPort) then begin
      COMPort.Free;
      COMPort := nil;
    end;
  except
  end;
end;

function DISPLAYDLL_DefaultParameters : pchar; stdcall;
begin
  DISPLAYDLL_DefaultParameters := pchar('COM1,9600' + #0);
end;

function DISPLAYDLL_Usage : pchar; stdcall;
begin
  Result := pchar('Usage: COM1,9600' + #0);
end;

function DISPLAYDLL_DriverName : pchar; stdcall;
begin
  Result := PChar(DLLProjectName + ' ' + Version + #0);
end;

// don't forget to export the funtions, else nothing works :)
exports
  DISPLAYDLL_SetBrightness,
  DISPLAYDLL_CustomChar,
  DISPLAYDLL_CustomCharIndex,
  DISPLAYDLL_Write,
  DISPLAYDLL_SetPosition,
  DISPLAYDLL_DefaultParameters,
  DISPLAYDLL_Usage,
  DISPLAYDLL_DriverName,
  DISPLAYDLL_Done,
  DISPLAYDLL_Init;
begin
end.

