library matrix;

uses
  SysUtils,SERPORT;

{$R *.res}

const
  DLLProjectName = 'Matrix Orbital Display DLL';
  Version = 'v1.0';
type
  pboolean = ^boolean;
  TCustomArray = array[0..7] of byte;
var
  COMPort : TSerialPort = nil;
  InittedOK : boolean;

function DISPLAYDLL_Usage : pchar; stdcall;
begin
  Result := pchar('Usage: COM1,9600,8,N,1');
end;

procedure DISPLAYDLL_SetPosition(X, Y: byte); stdcall;
// set cursor position
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($0FE);
      COMPort.WriteByte(ord('G'));
      COMPort.WriteByte(X);
      COMPort.WriteByte(Y);
    except
    end;
  end;
end;

procedure DISPLAYDLL_Write(Str : pchar); stdcall;
// write string
var
  S : string;
  Loop : longint;
begin
  if InittedOK then begin
    try
      S := string(Str);
      for Loop := 1 to length(S) do begin
        case Ord(Str[Loop]) of
          Ord('°'): Str[Loop]:= Chr(0);
          Ord('ž'): Str[Loop]:= Chr(1);
          131: Str[Loop]:= Chr(2);
          132: Str[Loop]:= Chr(3);
          133: Str[Loop]:= Chr(4);
          134: Str[Loop]:= Chr(5);
          135: Str[Loop]:= Chr(6);
          136: Str[Loop]:= Chr(7);
        end;
        COMPort.WriteByte(ord(S[Loop]));
      end;
    except
    end;
  end;
end;

procedure DISPLAYDLL_CustomChar(Chr : byte; Data : TCustomArray); stdcall;
// define custom character
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($0FE);       //command prefix
      COMPort.WriteByte($04E);       //this starts the custom characters
      COMPort.WriteByte(Chr-1);      //00 to 07 for 8 custom characters.
      COMPort.WriteByte(Data[0]);
      COMPort.WriteByte(Data[1]);
      COMPort.WriteByte(Data[2]);
      COMPort.WriteByte(Data[3]);
      COMPort.WriteByte(Data[4]);
      COMPort.WriteByte(Data[5]);
      COMPort.WriteByte(Data[6]);
      COMPort.WriteByte(Data[7]);
    except
    end;
  end;
end;

function DISPLAYDLL_ReadKey : word; stdcall;
// return 00xx upon success, FF00 on fail
var
  B : byte;
begin
  Result := $FF00;
  if InittedOK then begin
    try
      B := 0;
      if COMPort.ReadByte(B) and (B > 0) then
        Result := B;
    except
    end;
  end;
end;

procedure DISPLAYDLL_SetBacklight(LightOn : boolean); stdcall;
// turn on backlighting
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($0FE);
      if not LightOn then COMPort.WriteByte(ord('F'))
      else begin
        COMPort.WriteByte(ord('B'));
        COMPort.WriteByte(0);
      end;
    except
    end;
  end;
end;

procedure DISPLAYDLL_SetContrast(Contrast : byte); stdcall;
// 0 - 255
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($0FE);
      COMPort.WriteByte(ord('P'));
      COMPort.WriteByte(Contrast);
    except
    end;
  end;
end;

procedure DISPLAYDLL_SetBrightness(Brightness : byte); stdcall;
// 0 - 255
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($0FE);
      COMPort.WriteByte($098);
      COMPort.WriteByte(Brightness);
    except
    end;
  end;
end;

procedure DISPLAYDLL_PowerResume; stdcall;
// resume power
begin
end;

procedure DISPLAYDLL_SetGPO(GPO : byte; GPOOn : boolean); stdcall;
// turn on GPO
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($0FE);
      if GPOOn then COMPort.WriteByte(ord('W'))
      else COMPort.WriteByte(ord('V'));
      COMPort.WriteByte(GPO);
    except
    end;
  end;
end;

procedure DISPLAYDLL_SetFan(T1,T2 : byte); stdcall;
// set fan output
begin
  if InittedOK then begin
    try
      COMPort.WriteByte($FE);                         //set speed
      COMPort.WriteByte($C0);
      COMPort.WriteByte(T1);
      COMPort.WriteByte(T2);
    except
    end;
  end;
end;

function DISPLAYDLL_Init(StartupParameters : pchar; OK : pboolean) : pchar; stdcall;
// return startup error
// open port
var
   GPO : byte;
begin
  COMPort := TSerialPort.Create;
  OK^ := true;
  Result := PChar(DLLProjectName + ' ' + Version);
  try
    COMPort.OpenSerialPort(string(StartupParameters));
  except
    on E: Exception do begin
      result := PChar('MATRIX.DLL Exception: ' + E.Message);
      OK^ := false;
    end;
  end;
  InittedOK := OK^;
  if InittedOK then begin
    try
      for GPO := 1 to 8 do
        DISPLAYDLL_SetGPO(GPO, false);

      COMPort.WriteByte($0FE);     //Cursor blink off
      COMPort.WriteByte(ord('T'));

      COMPort.WriteByte($0FE);     //clear screen
      COMPort.WriteByte(ord('X'));

      COMPort.WriteByte($0FE);     //Cursor off
      COMPort.WriteByte(ord('K'));

      COMPort.WriteByte($0FE);     //auto scroll off
      COMPort.WriteByte(ord('R'));

      COMPort.WriteByte($0FE);     //auto line wrap off
      COMPort.WriteByte(ord('D'));

      COMPort.WriteByte($0FE);   //auto transmit keys
      COMPort.WriteByte($041);

      COMPort.WriteByte($0FE);     //auto repeat off
      COMPort.WriteByte(ord('`'));

      DISPLAYDLL_SetBacklight(true);
    except
      on E: Exception do begin
        result := PChar('MATRIX.DLL Exception: ' + E.Message);
        OK^ := false;
      end;
    end;
  end;
end;

procedure DISPLAYDLL_Done(); stdcall;
// close port
var
  GPO : byte;
begin
  try
    if InittedOK then begin
      for GPO := 1 to 8 do
        DISPLAYDLL_SetGPO(GPO, false);
      DISPLAYDLL_SetBacklight(false);
      COMPort.WriteByte($0FE);  //clear screen
      COMPort.WriteByte(ord('X'));
    end;
    COMPort.Free;
  except
  end;
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
  DISPLAYDLL_Usage,
  DISPLAYDLL_Done,
  DISPLAYDLL_Init;
begin
end.

