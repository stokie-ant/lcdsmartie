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
    constructor CreateUsb(sDevice: String);
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
    sUsbPalmDeviceFile: String;           // for Usb
    procedure doReadThread;               // for Usb
    procedure writeDevice(str: String); overload;
    procedure writeDevice(byte: Byte); overload;
    function readDevice(var chr: Char): Boolean;
    function errMsg(uError: Cardinal): String;
    Function DumpIoCtrl(fOutput: Cardinal; uiCode: Cardinal; uiBytes: Cardinal): String;
    procedure GetUsbPalmFiles(const sDevice: String;
      var sReadFile: String; var sWriteFile: String);
    function UsbPalmConnected: Boolean;
  end;

implementation

uses UMain, Dialogs, Forms;

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
  if (uError <> 0) then
  begin
    FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
      nil, uError, 0, @psError, 0, nil );
    sError := '#' + IntToStr(uError) + ': ' + PChar(psError);
    LocalFree(Cardinal(psError));
    Result := sError;
  end
  else
    Result := '#0'; // don't put "operation completed successfully! It's too confusing!
end;

Function TLCD_MO.DumpIoCtrl(fOutput: Cardinal; uiCode: Cardinal; uiBytes: Cardinal): String;
var
  buffer: Array [1..100] of Byte;
  uiBytesOut: Cardinal;
  sString: String;
  x: Integer;
begin
  FillChar(buffer, SizeOf(buffer), 0);

  sString := '';
  uiBytesOut := 0;
  if (DeviceIoControl(fOutput, uiCode, @buffer[1], uiBytes, @buffer[1], uiBytes,
                    uiBytesOut, nil)) then
  begin
    sString := IntToStr(uiBytesOut) + ': ';
    for x:= 1 to uiBytesOut do
    begin
      sString := sString + IntToHex(buffer[x], 2) + ' ';
    end;
  end
  else
  begin
     sString := IntToStr(uiBytesOut) + ': [Error: ' + ErrMsg(getLasterror) +']';
  end;

  Result := sString;
end;

function TLCD_MO.UsbPalmConnected: Boolean;
var
  device: Cardinal;
begin
  device := CreateFile (PChar(sUsbPalmDeviceFile), GENERIC_WRITE or GENERIC_READ,
    FILE_SHARE_WRITE or FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  if (device = INVALID_HANDLE_VALUE) then
  begin
    Result := false;
  end
  else
  begin
    Result := true;
    CloseHandle(device);
  end;
end;

procedure TLCD_MO.GetUsbPalmFiles(const sDevice: String;
  var sReadFile: String; var sWriteFile: String);
var
  device, test: Cardinal;
  fUsbLog: TextFile;
  x: Integer;
  iWorkedIn, iWorkedOut: Integer;
begin
  // Create a log file with possibly interesting information, it may be useful
  // when users are having problems.

  AssignFile(fUsbLog, 'usb.log');
  Rewrite(fUsbLog);
  WriteLn(fUsbLog, sDevice);
  WriteLn(fUsbLog, '');

  device := CreateFile (PChar(sDevice), GENERIC_WRITE or GENERIC_READ,
    FILE_SHARE_WRITE or FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  if (device = INVALID_HANDLE_VALUE) then
  begin
   if (GetLastError = ERROR_PATH_NOT_FOUND) then
      raise exception.Create('Failed to open USB Palm.' + #10+#13
        + 'Please ensure that Hotsync manager is not running, and that '
        + 'PalmOrb is already running on your Palm.')
    else
      raise exception.Create('Failed to open USB Palm: '
        + errMsg(GetLastError));
  end;

  WriteLn(fUsbLog, '424: ' + DumpIoCtrl(device, $222424, $12));
  WriteLn(fUsbLog, '004: ' + DumpIoCtrl(device, $222004, $8));
  WriteLn(fUsbLog, '40C: ' + DumpIoCtrl(device, $22240C, $2));
  WriteLn(fUsbLog, '00C: ' + DumpIoCtrl(device, $22200C, $8));
  WriteLn(fUsbLog, '000: ' + DumpIoCtrl(device, $222000, $14));
  WriteLn(fUsbLog, '');
  CloseHandle(device);

  iWorkedIn:=99;
  iWorkedOut:=99;
  for x:= 0 to 10 do
  begin
    test := CreateFile (PChar(sDevice+'\PIPE'+IntToHex(x,2)),
       GENERIC_WRITE or GENERIC_READ, FILE_SHARE_WRITE or FILE_SHARE_READ,
       nil, OPEN_EXISTING, 0, 0);
    if (test = INVALID_HANDLE_VALUE) then
    begin
      WriteLn(fUsbLog, 'PIPE'+IntToHex(x,2)+': Failed: ' + errMsg(GetLastError));
    end
    else
    begin
      WriteLn(fUsbLog, 'PIPE'+IntToHex(x,2)+': Success');
    end;
    CloseHandle(test);

    test := CreateFile (PChar(sDevice+'\IN_'+IntToHex(x,2)),
       GENERIC_WRITE or GENERIC_READ, FILE_SHARE_WRITE or FILE_SHARE_READ,
       nil, OPEN_EXISTING, 0, 0);
    if (test = INVALID_HANDLE_VALUE) then
    begin
      WriteLn(fUsbLog, 'IN_'+IntToHex(x,2)+': Failed: ' + errMsg(GetLastError));
    end
    else
    begin
      WriteLn(fUsbLog, 'IN_'+IntToHex(x,2)+': Success');
      if (iWorkedIn>x) then iWorkedIn := x;
    end;
    CloseHandle(test);

    test := CreateFile (PChar(sDevice+'\OUT_'+IntToHex(x,2)),
       GENERIC_WRITE or GENERIC_READ, FILE_SHARE_WRITE or FILE_SHARE_READ,
       nil, OPEN_EXISTING, 0, 0);
    if (test = INVALID_HANDLE_VALUE) then
    begin
      WriteLn(fUsbLog, 'OUT_'+IntToHex(x,2)+': Failed: ' + errMsg(GetLastError));
    end
    else
    begin
      WriteLn(fUsbLog, 'OUT_'+IntToHex(x,2)+': Success');
      if (iWorkedOut>x) then iWorkedOut := x;
    end;
    CloseHandle(test);
  end;

  WriteLn(fUsbLog, 'Using: IN_'+IntToHex(iWorkedIn,2)+' & OUT_'+IntToHex(iWorkedOut,2));
  CloseFile(fUsbLog);

  sWriteFile := sDevice + '\OUT_' +IntToHex(iWorkedOut,2);
  sReadFile := sDevice + '\IN_' + IntToHex(iWorkedIn,2);
end;


constructor TLCD_MO.CreateUsb(sDevice: String);
var
  sReadFile, sWriteFile: String;
begin
  eStopReadThread := INVALID_HANDLE_VALUE;
  input := INVALID_HANDLE_VALUE;
  output := INVALID_HANDLE_VALUE;
  bUsbReadSupport := False;
  bUsb := True;

  sDevice := StringReplace(sDevice, '\??\', '\\.\', []);
  sUsbPalmDeviceFile := sDevice;
  //'\\.\USB#Vid_054c&Pid_0066#6&673a0bd&0&4#{a5dcbf10-6530-11d2-901f-00c04fb951ed}';

  GetUsbPalmFiles(sDevice, sReadFile, sWriteFile);

  input := CreateFile (PChar(sReadFile),  GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if (input = INVALID_HANDLE_VALUE) then
  begin
    if (GetLastError = ERROR_PATH_NOT_FOUND) then
      raise exception.Create('Failed to open USB Palm for reading.' + #10+#13
        + 'Please ensure that Hotsync manager is not running, and that '
        + 'PalmOrb is already running on your Palm.')
    else
      raise exception.Create('Failed to open USB Palm for reading: '
        + errMsg(GetLastError));
  end;
  bUsbReadSupport := True;

  output := CreateFile (PChar(sWriteFile), GENERIC_WRITE or GENERIC_READ,
      FILE_SHARE_WRITE or FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  if (output = INVALID_HANDLE_VALUE) then
    raise exception.Create('Failed to open USB Palm for writing: '
          + errMsg(GetLastError));


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
  bConnected := True;

  try
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
  except
    bConnected := False;
    raise;
  end;

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
    writeDevice(Chr($0FE)+'F');
  end
  else
  begin
    writeDevice(Chr($0FE)+'B'+Chr(0));
  end;
end;

procedure TLCD_MO.setPosition(x, y: Integer);
begin
  writeDevice(Chr($0FE)+'G'+Chr(x)+Chr(y));
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
  if (not bConnected) then Exit;

  if not bUsb then
  begin

    serial.WriteText(str);

  end
  else
  begin

    if (not WriteFile(output, str[1], length(str), bytesWritten, nil)) then
    begin
      if (UsbPalmConnected()) then
        raise Exception.Create('Failed writing to USB Palm: ['
          + IntToStr(length(str)) + ':' + IntToStr(bytesWritten) + ']: '
          + errMsg(GetLastError))
      else
      begin
        bConnected := False;
        showmessage('The USB Palm has disconnected. LCD Smartie will now exit.');
        application.Terminate;
      end;
    end
    else if (bytesWritten <> Cardinal(length(str))) then
    begin
      // This can happen when the USB Palm is connected but powered off.
      // just ignore - but sleep to avoid a busy loop.
      Sleep(10);
    end;

  end;

end;

procedure TLCD_MO.writeDevice(byte: Byte);
var
  bytesWritten: Cardinal;
begin
  if (not bConnected) then Exit;

  if not bUsb then
  begin

    serial.WriteChar(Chr(byte));

  end
  else
  begin

    if (not WriteFile(output, byte, 1, bytesWritten, nil)) then
    begin
      if (UsbPalmConnected()) then
        raise Exception.Create('Failed writing to USB Palm: [1:'
          + IntToStr(bytesWritten) + ']: ' + errMsg(GetLastError))
      else
      begin
        bConnected := False;
        showmessage('The USB Palm has disconnected. LCD Smartie will now exit.');
        application.Terminate;
      end;
    end
    else if (bytesWritten <> 1) then
    begin
      // This can happen when the USB Palm is connected but powered off.
      // just ignore - but sleep to avoid a busy loop.
      Sleep(1);
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
          if (UsbPalmConnected()) then
            raise Exception.create('Failed reading from USB Palm: '+errMsg(GetLastError))
          else  // Sleep to avoid a busy loop, wait for write to detect loss of Palm.
            Sleep(100);
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
