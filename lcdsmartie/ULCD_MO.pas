unit ULCD_MO;

interface

uses ULCD, Classes, SyncObjs, SysUtils, Windows, VaClasses, VaComm;

const
  readBufferSize=100;

type
  TThreadMethod = procedure of object;

  TMyThread = class(TTHREAD)
  public
    constructor Create(myMethod: TThreadMethod);
  private
    method: TThreadMethod;
  published
    procedure execute; override;
  end;

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
    constructor CreateSerial(serial: PTVACOMM; uiPort: Cardinal; baudRate: TVaBaudrate);
    constructor CreateUsb(device: String);
    constructor Create; override;
    destructor Destroy; override;
  private
    bConnected: Boolean;
    serial: PTVACOMM;
    bUsb: Boolean;                        // for Usb
    bUsbReadSupport: Boolean;             // for Usb
    input, output: Cardinal;              // for Usb
    eStopReadThread: THandle;             // for Usb
    csRead: TCriticalSection;             // for Usb
    readThread: TMyThread;                // for Usb
    readBuffer: array [0..readBufferSize-1] of Byte; // for Usb
    uInPos, uOutPos: Cardinal;            // for Usb
    procedure doReadThread;               // for Usb
    procedure writeDevice(str: String); overload;
    procedure writeDevice(byte: Byte); overload;
    function readDevice(var chr: Char): Boolean;
    function errMsg(uError: Cardinal): String;

  end;

implementation

uses UMain;

constructor TMyThread.Create(myMethod: TThreadMethod);
begin
  method:=myMethod;
  inherited Create(true);   // Create suspended.
end;

procedure TMyThread.Execute;
begin
  method();
end;

constructor TLCD_MO.CreateSerial(serial: PTVACOMM; uiPort: Cardinal; baudRate: TVaBaudrate);
begin
  self.serial := serial;
  serial.Baudrate := baudRate;
  serial.PortNum := uiPort;
  //VaComm1.Close;
  serial.Open;

  Create();
end;

function TLCD_MO.errMsg(uError: Cardinal): String;
var
  psError: pointer;
  sError: String;
begin
  FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
    nil, uError, 0, @psError, 0, nil );
  sError := '#' + IntToStr(uError) + ': ' + PChar(psError);
  LocalFree(Cardinal(psError));
  Result := sError;
end;

constructor TLCD_MO.CreateUsb(device: String);
var
  symName: String;
begin
  eStopReadThread := INVALID_HANDLE_VALUE;
  input := INVALID_HANDLE_VALUE;
  output := INVALID_HANDLE_VALUE;
  bUsbReadSupport := False;
  bUsb := True;

  symName := StringReplace(device, '\??\', '\\.\', []);
  //'\\.\USB#Vid_054c&Pid_0066#6&673a0bd&0&4#{a5dcbf10-6530-11d2-901f-00c04fb951ed}';


  // So far we have found two different kinds of Palms:
  //   old usb handspring/visor (pre-PalmOS 4.0) and
  //   usb palms with PalmOS 4.0 and later.
  // These two use different device files.

  // This file works on both types of usb palm:
  output := CreateFile (PChar(symName + '\PIPE01'), GENERIC_WRITE,
    FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);

  if (output <> INVALID_HANDLE_VALUE) then
  begin
    input := CreateFile (PChar(symName + '\PIPE00'), GENERIC_READ,
      FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
    if (input = INVALID_HANDLE_VALUE) then
      bUsbReadSupport := False
    else
      bUsbReadSupport := True;
  end
  else
  begin
    // This code only works for the newer usb palms:
    // DON'T THINK THIS CODE IS NEEDED ANY MORE!
    output := CreateFile (PChar(symName + '\PIPE03'), GENERIC_WRITE,
      FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
    if (output = INVALID_HANDLE_VALUE) then
    begin
      if (GetLastError = ERROR_PATH_NOT_FOUND) then
        raise exception.Create('Failed to open USB Palm for writing: Please '
          + 'ensure that ' + #10 + #13 + 'PalmOrb is running on your Palm.')
      else
        raise exception.Create('Failed to open USB Palm for writing: '
          + errMsg(GetLastError));

    end;

    input := CreateFile (PChar(symName + '\PIPE02'), GENERIC_READ,
      FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
    if (input = INVALID_HANDLE_VALUE) then
      raise exception.Create('Failed to open USB Palm for reading: '
          + errMsg(GetLastError));
    bUsbReadSupport := True;
  end;



  // Do the standard setup now before creating the read thead.
  // The standard setup writes to the device, and so will detect any problems
  // communicating with it.
  Create;


  // CriticalSection to protect read buffer
  csRead := TCriticalSection.Create;

  if (bUsbReadSupport) then
  begin
    // event to wait up read Thread so we can exit it.
    eStopReadThread := CreateEvent(nil, True, False, nil);

    // start read thread
    readThread:= TMyThread.Create(self.doReadThread);
    readThread.Resume;
  end;
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

  writeDevice($0FE);   //auto transmit keys
  writeDevice($041);

  writeDevice($0FE);     //auto repeat off
  writeDevice('`');

  setbacklight(true);

  bConnected := True;
  inherited Create;
end;

destructor TLCD_MO.Destroy;
var
  g: Integer;
begin

  if (bConnected) then
  begin
    bConnected := False;
    setbacklight(false);

    for g := 1 to 8 do
    begin
      setGPO(g, false);
    end;

    writeDevice($0FE);  //clear screen
    writeDevice('X');
  end;

  if (bUsb) then
  begin
    if bUsbReadSupport then
    begin

      if Assigned(readThread) then
      begin
        if (eStopReadThread <> INVALID_HANDLE_VALUE) then SetEvent(eStopReadThread);

        // This is ugly but the palm driver doesn't seem to support cancelling,
        // WaitFor..., or any other means we can use to avoid blocking on a read
        // request.
        // So instead we send the palm a command that causes it to send a byte.
        // (we're asking for it's version).
        writeDevice(#254+#54);

        readThread.Terminate;
        readThread.WaitFor;
        readThread.Destroy;
      end;

      if (input <> INVALID_HANDLE_VALUE) then CloseHandle(input);
      if (eStopReadThread <> INVALID_HANDLE_VALUE) then CloseHandle(eStopReadThread);

    end;
    if (output <> INVALID_HANDLE_VALUE) then CloseHandle(output);
    if Assigned(csRead) then csRead.Free;
  end
  else
  begin
    sleep(500);
    serial.close;
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
begin
  if not bUsb then
  begin

    serial.WriteText(str);

  end
  else
  begin

    if (not WriteFile(output, str[1], length(str), bytesWritten, nil))
        or (bytesWritten <> Cardinal(length(str))) then
    begin
      raise Exception.Create('Write USB Palm failed [' + IntToStr(length(str))
        + ':' + IntToStr(bytesWritten) + ']: ' + errMsg(GetLastError));
    end;

  end;

end;

procedure TLCD_MO.writeDevice(byte: Byte);
var
  bytesWritten: Cardinal;
begin

  if not bUsb then
  begin

    serial.WriteChar(Chr(byte));

  end
  else
  begin

    if (not WriteFile(output, byte, 1, bytesWritten, nil))
        or (bytesWritten <> 1) then
    begin
      raise Exception.Create('Write USB Palm failed: ' + errMsg(GetLastError));
    end;

  end;
end;

function TLCD_MO.readDevice(var chr: Char): Boolean;
var
  gotdata: Boolean;
begin
  gotdata := False;
  if bUsb then
  begin
      csRead.Enter;
      try
        if (uInPos<>uOutPos) then
        begin
          // There's data waiting
          chr:=Char(readBuffer[uOutPos]);
          Inc(uOutPos);
          if (uOutPos>=ReadBufferSize) then uOutPos:=0;
          gotdata:=True;
        end;
      finally
        csRead.Leave;
      end;
  end
  else
  begin

    if serial.ReadBufUsed>0 then
    begin
      if (serial.ReadChar(chr)) then gotdata:=true;
    end;

  end;

  Result := gotdata;
end;

procedure TLCD_MO.doReadThread;
var
  bytesRead: Cardinal;
  buffer: Byte;
  handles: TWOHandleArray;
  res: DWORD;

begin
  handles[0] := eStopReadThread;
  handles[1] := input;

  try
    While (bConnected) and (not readThread.Terminated) do
    begin
      bytesRead := 0;
      res := WaitForMultipleObjects(2, @handles, False, INFINITE);

      if (res = WAIT_OBJECT_0)
        or (readThread.Terminated)
        or (not bConnected) then Exit
      else if (res = WAIT_OBJECT_0+1) then
      begin
        // There's something to read - sadly this doesn't work with the Palm
        // driver - the WaitFor... doesn't block and the input handle is always
        // signalled.
        if (not ReadFile(input, buffer, 1, bytesRead, nil)) then
        begin
          raise Exception.create('Reading USB Palm failed: '+errMsg(GetLastError));
        end;
      end
      else
      begin
        raise Exception.create('Unexpected return from WaitForMultipleObjects: ' + errMsg(res));
      end;

      if (bytesRead>0) then
      begin
        // We finally have our data!
        csRead.Enter;
        try
          if (((uInPos+1) mod ReadBufferSize) = uOutPos) then
            raise Exception.Create('Read buffer is full');
          readBuffer[uInPos] := buffer;
          Inc(uInPos);
          if (uInPos >= ReadBufferSize) then uInPos := 0;
        finally
          csRead.Leave;
        end;
      end;

      // When the Palm is switched off then we get bytesRead=0 and
      // WaitForMultipleObjects doesn't block - this causes a busy
      // loop, hence the ugly sleep.
      // [We could exit the thread instead, but when the palm is switched
      // back on everything works again - so it's a shame to break that].
      if (bytesRead<=0) then Sleep(10);
    end;
  finally
    //CancelIO(input);
  end;
end;



end.
