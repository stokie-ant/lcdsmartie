unit ULCD_MO;

interface

uses ULCD;

type
  TLCD_MO = class(TLCD)
  public
    procedure customChar(character: Integer; data: Array of Byte); override;
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String); override;
    procedure setbacklight(on: Boolean); override;
    function readKey(var key: Char): Boolean; override;
    procedure setFan(t1, t2: Integer); override;
    procedure setGPO(gpo: Byte; on: Boolean); override;
    procedure setContrast(level: Integer); override;
    procedure setBrightness(level: Integer); override;
    constructor Create; override;
    constructor CreateUsb(device: String);
    destructor Destroy; override;
  private
    Usb: Boolean; input, output: Cardinal;
    procedure writeDevice(str: String); overload;
    procedure writeDevice(byte: Byte); overload;
    function readDevice(var char: Char): Boolean;
  end;

implementation

uses UMain, SysUtils, Windows;

constructor TLCD_MO.CreateUsb(device: String);
var
  symName: String;
  error: String;
  errorp: pointer;
  lastErr: Cardinal;
begin
  Usb := True;

  symName := StringReplace(device, '\??\', '\\.\', []);
  //'\\.\USB#Vid_054c&Pid_0066#6&673a0bd&0&4#{a5dcbf10-6530-11d2-901f-00c04fb951ed}';

  input := CreateFile (PChar(symName + '\PIPE02'), GENERIC_READ,
    FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);

  if (input = INVALID_HANDLE_VALUE) then
  begin
    lastErr := GetLastError();
    FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or
      FORMAT_MESSAGE_FROM_SYSTEM, nil, lastErr, 0, @errorp, 0, nil );
    error :=  'USB Palm: #' + IntToStr(lastErr) + ':' + PChar(errorp);
    // need to free errorp...

    raise exception.Create(error)
  end;

  output := CreateFile (PChar(symName + '\PIPE03'), GENERIC_WRITE,
    FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if (output = INVALID_HANDLE_VALUE) then
  begin
    lastErr := GetLastError();
    FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or
      FORMAT_MESSAGE_FROM_SYSTEM, nil, lastErr, 0, @errorp, 0, nil );
    error :=  'USBPalm: #' + IntToStr(lastErr) + ':' + PChar(errorp);
    // need to free errorp...

    raise exception.Create(error)
  end;

  Create;
end;

constructor TLCD_MO.Create;
var
  g: Integer;
begin
  for g := 1 to 8 do
  begin
    setGPO(g, false);
  end;

  writeDevice($0FE);     //Cursor blink off
  writeDevice('T');

  writeDevice($0FE);     //clear screen
  writeDevice('X');

  writeDevice($0FE);     //Cursor off
  writeDevice('K');

  writeDevice($0FE);     //auto scroll off
  writeDevice('R');

  writeDevice($0FE);     //auto line wrap off
  writeDevice('D');

  writeDevice($0FE);     //keypad polling on
  writeDevice('O');

  writeDevice($0FE);     //auto repeat off
  writeDevice('`');

  setbacklight(true);

  inherited Create;
end;

destructor TLCD_MO.Destroy;
var
  g: Integer;
begin
  setbacklight(false);

  for g := 1 to 8 do
  begin
    setGPO(g, false);
  end;

  writeDevice($0FE);  //clear screen
  writeDevice('X');

  if (Usb) then
  begin
    CloseHandle(output);
    CloseHandle(input);
  end;

  inherited;
end;

procedure TLCD_MO.setContrast(level: Integer);
begin
  writeDevice($0FE);
  writeDevice('P');
  writeDevice(level);
end;

procedure TLCD_MO.setBrightness(level: Integer);
begin
  writeDevice($0FE);
  writeDevice($098);
  writeDevice(level);
end;

procedure TLCD_MO.setGPO(gpo: Byte; on: Boolean);
begin
  writeDevice($0FE);
  if (on) then writeDevice('W')
  else writeDevice('V');
  writeDevice(gpo);
end;

procedure TLCD_MO.setFan(t1, t2: Integer);
begin
  writeDevice($FE);                         //set speed
  writeDevice($C0);
  writeDevice(t1);
  writeDevice(t2);

  {
    form1.VaComm1.WriteChar(chr($FE));                         //remember startup state
    form1.VaComm1.WriteChar(chr($C3));
    form1.VaComm1.WriteChar(chr(StrToInt(temp1)));
    form1.VaComm1.WriteChar(chr(strToInt(temp2)));
  }
end;

function TLCD_MO.readKey(var key: Char): Boolean;
var
  gotkey: Boolean;
begin

{  form1.VaComm1.WriteChar(chr($0FE));
  form1.VaComm1.WriteChar(chr($026));
  Sleep(200);
  }

  gotkey := readDevice(key);
  // but ignore 0.
  if (gotkey) and (key = Chr(0)) then gotkey := False;

  {
  if (config.mx3Usb) then begin
    for counter := 1 to 3 do begin
      VaComm1.WriteChar(chr($FE));
      VaComm1.WriteChar(chr($C1));
      VaComm1.WriteChar(chr($03));

      temp1 := '';
      while form1.VaComm1.ReadBufUsed >= 1 do begin
        form1.VaComm1.ReadChar(kar);
        temp1 := temp1 + kar;
      end;
    end;
  end;
  }

  Result := gotkey;
end;

procedure TLCD_MO.setbacklight(on: Boolean);
begin
  if (not on) then
  begin
    writeDevice($0FE);
    writeDevice('F');
  end
  else
  begin
    writeDevice($0FE);
    writeDevice('B');
    writeDevice(0);
  end;
end;

procedure TLCD_MO.setPosition(x, y: Integer);
begin
  writeDevice($0FE);
  writeDevice('G');
  writeDevice(x);
  writeDevice(y);

  inherited;
end;


procedure TLCD_MO.write(str: String);
begin
  str := StringReplace(str, '\', '/', [rfReplaceAll]);
  str := StringReplace(str, '°', chr(0), [rfReplaceAll]);
  str := StringReplace(str, 'ž', chr(1), [rfReplaceAll]);
  str := StringReplace(str, chr(131), chr(2), [rfReplaceAll]);
  str := StringReplace(str, chr(132), chr(3), [rfReplaceAll]);
  str := StringReplace(str, chr(133), chr(4), [rfReplaceAll]);
  str := StringReplace(str, chr(134), chr(5), [rfReplaceAll]);
  str := StringReplace(str, chr(135), chr(6), [rfReplaceAll]);
  str := StringReplace(str, chr(136), chr(7), [rfReplaceAll]);
  writeDevice(str);
end;

procedure TLCD_MO.customChar(character: Integer; data: Array of Byte);
begin
  writeDevice($0FE);       //command prefix
  writeDevice($04E);       //this starts the custom characters
  writeDevice(character-1);      //00 to 07 for 8 custom characters.
  writeDevice(data[0]);
  writeDevice(data[1]);
  writeDevice(data[2]);
  writeDevice(data[3]);
  writeDevice(data[4]);
  writeDevice(data[5]);
  writeDevice(data[6]);
  writeDevice(data[7]);

end;

procedure TLCD_MO.writeDevice(str: String);
var
  bytesWritten: Cardinal;
  {error: String;
  errorp: pointer;
  lastErr: Cardinal;}
begin
  if not Usb then
  begin
    Form1.VaComm1.WriteText(str);
  end
  else
  begin
    if (not WriteFile(output, str[1], length(str), bytesWritten, nil)) or
      (bytesWritten <> Cardinal(length(str))) then
    begin
      {lastErr := GetLastError();
      FormatMessage(
            FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM, 
            nil, 
            lastErr, 
            0, 
            @errorp, 
            0, 
            nil
        );
      error :=  'failed to write (wrote: ' + IntToStr(bytesWritten) + 'bytes): #' + IntToStr(lastErr) + ':' + PChar(errorp);
      // need to free errorp...

      raise exception.Create(error)    }
    end;
  end;

end;

procedure TLCD_MO.writeDevice(byte: Byte);
var
  bytesWritten: Cardinal;
  {error: String;
  errorp: pointer;
  lastErr: Cardinal; }
begin

  if not Usb then
  begin
    Form1.VaComm1.WriteChar(Chr(byte));
  end
  else
  begin
    if (not WriteFile(output, byte, 1, bytesWritten, nil)) or (bytesWritten <>
      1) then
    begin
      {lastErr := GetLastError();
      FormatMessage(
            FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM, 
            nil, 
            lastErr, 
            0, 
            @errorp, 
            0, 
            nil
        );
      error :=  'failed to write (wrote: ' + IntToStr(bytesWritten) + 'bytes): #' + IntToStr(lastErr) + ':' + PChar(errorp);
      // need to free errorp...

      raise exception.Create(error)  }
    end;
  end;
end;

function TLCD_MO.readDevice(var char: Char): Boolean;
var
  gotdata: Boolean;
begin
  gotdata := False;
  if Usb then
  begin
    // do nothing for the moment.
  end
  else
  begin
    if form1.VaComm1.ReadBufUsed > 0 then
    begin
      if (form1.VaComm1.ReadChar(char)) then gotdata := true;
    end;
  end;

  Result := gotdata;
end;


end.
