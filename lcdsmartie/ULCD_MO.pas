unit ULCD_MO;

{ Much of the USB Palm code in this file is based on the code in
  EmTransportUSBWin.cpp of pose (The Palm OS Emulator).}


interface

uses ULCD, Classes, SyncObjs, SysUtils, Windows, VaClasses, VaComm;

const
  readBufferSize=100;
  UsbNoError				     = $00000000;		// No error
  UsbErrUnknown			     = $00000001;		// Unknown error
  UsbErrSendTimedOut	   = $00000002;		// Send timed out
  UsbErrRecvTimedOut	   = $00000003;		// Receive timed out
  UsbErrPortNotOpen		   = $00000004;		// USB port is not open
  UsbErrIOError			     = $00000005;		// I/O or line error
  UsbErrPortBusy			   = $00000006;		// USB port is already in use
  UsbErrNotSupported		 = $00000007;		// IOCTL code unsupported
  UsbErrBufferTooSmall	 = $00000008;		// Buffer size too small
  UsbErrNoAttachedDevices= $00000009;		// No devices currently attached
  UsbErrDontMatchFilter	 = $00000010;		// Creator ID provided doesn't
              						  						// match the USB-active device
							                					// application creator ID

type
  PUSBTimeouts = ^USBTimeouts;
  USBTimeouts = packed record
    uiReadTimeout: DWORD;
    uiWriteTimeout: DWORD;
  end;
  HANDLE = Cardinal;



  TFNOpenPort = function (device: PCHAR; who: ULONG) : HANDLE; cdecl;
  TFNGetAttachedDevices = function (pDeviceCount: PULONG; pBuffer: PCHAR; pBufferSize: PULONG):ULONG; cdecl;
  TFNClosePort = function (devicehandle: HANDLE):BOOL; cdecl;
  TFNReceiveBytes = function (devicehandle: HANDLE; buffer: PChar; size: ULONG; bytes: PULONG): ULONG; cdecl;
  TFNSendBytes = function (devicehandle: HANDLE; buffer: PChar; size: ULONG; bytes: PULONG):ULONG; cdecl;
  TFNSetTimeouts = function (devicehandle: HANDLE; timeout: PUSBTimeouts):ULONG; cdecl;
  //TFNGetTimeouts = function (devicehandle: HANDLE; timeout: PUSBTimeouts):ULONG; cdecl;
  //tyypedef HDEVNOTIFY				(*RegisterDeviceInterfaceProc)		(HWND);
  //typedef VOID					(*UnRegisterDeviceInterfaceProc)	(HDEVNOTIFY);
  //typedef BOOL					(*IsPalmOSDeviceNotificationProc)	(ULONG, ULONG, PTCHAR, GUID*);
  //TFNGetDeviceFriendlyName = function ( pDeviceName:PCHAR; pFriendlyName: PCHAR):ULONG; cdecl;

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
    class function getUsbPalms(var names, devicenames: Array of String; max:
      Integer): Integer;
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
    constructor CreateUsb;
    constructor Create; override;
    destructor Destroy; override;
  private
    bConnected: Boolean;
    serial: PTVACOMM;
    bUsb: Boolean;                        // for Usb
    usbPalm: Cardinal;              // for Usb
    csRead: TCriticalSection;             // for Usb
    readThread: TMyThread;                // for Usb
    readBuffer: array [0..readBufferSize-1] of Byte; // for Usb
    uInPos, uOutPos: Cardinal;            // for Usb
    usbPortLib: HANDLE;
    FNGetAttachedDevices: TFNGetAttachedDevices;
    FNOpenPort: TFNOpenPort;
    FNClosePort: TFNClosePort;
    FNReceiveBytes: TFNReceiveBytes;
    FNSendBytes: TFNSendBytes;
    FNSetTimeouts: TFNSetTimeouts;

    procedure doReadThread;               // for Usb
    procedure writeDevice(buffer: PChar; len: Cardinal); overload;
    procedure writeDevice(byte: Byte); overload;
    procedure writeDevice(str: String); overload;
    function readDevice(var chr: Char): Boolean;
    function errMsg(uError: Cardinal): String;
    Function OpenUsbPort: Boolean;
    procedure initLCD;
  end;

implementation

uses UMain, Dialogs, Forms, Registry;

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

Function TLCD_MO.OpenUsbPort: Boolean;
var
  ret: ULONG;
  deviceCount: ULONG;
  bufferSize: ULONG;
  timeouts: USBTimeouts;
  buffer: array [1..200] of Char;

begin
  bufferSize := SizeOf(buffer);

  ret := FNGetAttachedDevices(@deviceCount, @buffer[1], @bufferSize);


  if (ret <> UsbNoError) then
    raise Exception.Create('Failed whilst locating palms: '+IntToStr(ret));

  if (deviceCount > 0) then
  begin

    // $62724F50   == 'POrb'
    usbPalm := FNOpenPort(@buffer[1], $62724F50);
    if (usbPalm = INVALID_HANDLE_VALUE) then
       raise Exception.Create('USB Palm open failed: '+errMsg(GetLastError));


    // Set read/write time outs so LCD Smartie doesn't hang
    timeouts.uiReadTimeout:=8000; // 8 seconds
    timeouts.uiWriteTimeout:=1000;  // 1 second

    FNSetTimeouts(usbPalm, @timeouts);

    bConnected := true;

    initLcd();
  end;

  Result := bConnected;
end;



constructor TLCD_MO.CreateUsb;
const
  PALMDESKTOPKEY='\Software\U.S. Robotics\Pilot Desktop\Core';
var

  reg: TRegistry;
  path: String;
begin
  usbPortLib := 0;
  usbPalm := INVALID_HANDLE_VALUE;
  bUsb := True;

  // Check if there are any Usb Palm entries in the registry.
  Reg := TRegistry.Create;

  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKeyReadOnly(PALMDESKTOPKEY) then
  begin
    path := Reg.ReadString('DesktopPath');
    if (path = '') then
      path := Reg.ReadString('Path');
    if (path = '') then
      path := 'c:\Program Files\palmOne';

    Reg.CloseKey;
    Reg.Free;
  end;

  usbPortLib := LoadLibrary(PChar('USBPort.dll'));
  if (usbPortLib = 0) then
    usbPortLib := LoadLibrary(PChar(path+'\USBPort.dll'));
  if (usbPortLib = 0) then
    usbPortLib := LoadLibrary('c:\Program Files\palmOne\USBPort.dll');
  if (usbPortLib = 0) then
    usbPortLib := LoadLibrary('c:\Palm\USBPort.dll');

  if (usbPortLib = 0) then
    raise Exception.create('Can not find USBPort.dll: '+ErrMsg(GetLastError));

  FNGetAttachedDevices := TFNGetAttachedDevices(
    GetProcAddress(usbPortLib, 'PalmUsbGetAttachedDevices'));
  FNOpenPort := TFNOpenPort(
    GetProcAddress(usbPortLib, 'PalmUsbOpenPort'));
  FNClosePort := TFNClosePort(
    GetProcAddress(usbPortLib, 'PalmUsbClosePort'));
  FNReceiveBytes := TFNReceiveBytes(
    GetProcAddress(usbPortLib, 'PalmUsbReceiveBytes'));
  FNSendBytes := TFNSendBytes(
    GetProcAddress(usbPortLib, 'PalmUsbSendBytes'));
  FNSetTimeouts := TFNSetTimeouts(
    GetProcAddress(usbPortLib, 'PalmUsbSetTimeouts'));

  if (not Assigned(FNGetAttachedDevices))
    or (not Assigned(FNOpenPort))
    or (not Assigned(FNClosePort))
    or (not Assigned(FNReceiveBytes))
    or (not Assigned(FNSendBytes))
    or (not Assigned(FNSetTimeouts)) then
    raise Exception.Create('Failed to get required APIs: ' + errMsg(GetLastError));

  if (not OpenUsbPort()) then
    raise exception.Create('No connected USB Palms were detected.' + #10+#13
      + 'Please ensure PalmOrb is already running on your Palm.');

  // CriticalSection to protect read buffer
  csRead := TCriticalSection.Create;

  // start read thread
  readThread:= TMyThread.Create(self.doReadThread);
  readThread.Resume;
end;

procedure TLCD_MO.initLCD;
var
  g: Cardinal;
begin
  if (not bConnected) then Exit;
  
  for g := 1 to 8 do
  begin
    setGPO(g, false);
  end;

  writeDevice($0FE);     //Cursor blink off
  writeDevice('T', 1);

  writeDevice($0FE);     //clear screen
  writeDevice('X', 1);

  writeDevice($0FE);     //Cursor off
  writeDevice('K', 1);

  writeDevice($0FE);     //auto scroll off
  writeDevice('R', 1);

  writeDevice($0FE);     //auto line wrap off
  writeDevice('D', 1);

  writeDevice($0FE);   //auto transmit keys
  writeDevice($041);

  writeDevice($0FE);     //auto repeat off
  writeDevice('`', 1);

  setbacklight(true);
end;

constructor TLCD_MO.Create;
begin
  bConnected := True;

  try
    initLcd;
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
    try
      setbacklight(false);

      for g := 1 to 8 do
      begin
        setGPO(g, false);
      end;

      writeDevice($0FE);  //clear screen
      writeDevice('X', 1); 
    except
    end;
    bConnected := false;
  end;

  if (bUsb) then
  begin
    if Assigned(readThread) then
    begin
      readThread.Terminate;
      readThread.WaitFor;
      readThread.Destroy;
    end;

    if (usbPalm <> INVALID_HANDLE_VALUE) then
    begin
      if (usbPortLib <> 0) and (Assigned(FNClosePort)) then
        FNClosePort(usbPalm);
      usbPalm := INVALID_HANDLE_VALUE;
    end;
    if (usbPortLib <> 0) then
    begin
      FreeLibrary(usbPortLib);
      usbPortLib := 0;
    end;

    if (usbPalm <> INVALID_HANDLE_VALUE) then
    begin
      FNClosePort(usbPalm);
      usbPalm := INVALID_HANDLE_VALUE;
    end;

    if Assigned(csRead) then csRead.Free;
  end
  else
  begin
    // Ensure all serial data has been writen out
    // (close discards all remaining data)
    g := 0;
    While (serial.WriteBufUsed > 0) and (g<100) do
    begin
      Inc(g);
      Application.ProcessMessages;
      Sleep(10);
    end;
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

procedure TLCD_MO.writeDevice(buffer: PChar; len: Cardinal);
var
  bytesWritten: Cardinal;
  ret: Cardinal;
begin
  if (not bConnected) then
  begin
    if (not bUsb) then Exit;

    // See if we can reconnect.
    if (not OpenUsbPort()) then Exit;
  end;

  if (len = 0) then Exit;

  if not bUsb then
  begin

    serial.WriteBuf(buffer, len);

  end
  else
  begin

    ret:=FNSendBytes(usbPalm, buffer, len, @bytesWritten);
    if (ret <> UsbNoError)
      and (ret <> UsbErrSendTimedOut)
      and (ret <> UsbErrPortNotOpen) then
    begin
      raise Exception.create('Write failed with '+IntToStr(ret));
    end
    else if (ret = UsbErrPortNotOpen) then
    begin
      bConnected := False;
      FNClosePort(usbPalm);
      usbPalm := INVALID_HANDLE_VALUE;
    end;
  end;
end;

procedure TLCD_MO.writeDevice(byte: Byte);
begin
  writeDevice(@byte, 1);
end;

procedure TLCD_MO.writeDevice(str: String);
begin
  writeDevice(@str[1], length(str));
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
  ret: Cardinal;
begin
    While (not readThread.Terminated) do
    begin
      if (bConnected) then
      begin
        bytesRead := 0;
        ret:=  FNReceiveBytes(usbPalm, @buffer, 1, @bytesRead);
        if (ret <> UsbNoError)
          and (ret <> UsbErrRecvTimedOut)
          and (ret <> UsbErrPortNotOpen) then
        begin
          raise Exception.create('Read failed with '+IntToStr(ret));
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
        // Update: The read returns 0 bytes also when the read has timed out.
        if (bytesRead<=0) then Sleep(10);
      end
      else
      begin
        // Not connected - wait to be reconnected or if the thread must exit.
        Sleep(10);
      end;
  end;
end;




class function TLCD_MO.getUsbPalms(var names, devicenames: Array of String; max:
  Integer): Integer;
const
  USBKEY='\SYSTEM\CurrentControlSet\Enum\USB';
var
  i, j: Integer;
  Reg: TRegistry;
  subkeys: TStringList;
  subsubkeys: TStringList;
  symName: String;
  count: Integer;

begin
  count := 0;

  // Check if there are any Usb Palm entries in the registry.
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly(USBKEY) then
    begin
      subkeys := TStringList.Create;
      subsubkeys := TStringList.Create;

      Reg.GetKeyNames(subkeys);
      Reg.CloseKey;
      for i := 0 to subkeys.Count-1 do
      begin
        // Examine each USB Device type

        if Reg.OpenKeyReadOnly(USBKEY + '\' + subkeys.Strings[i]) then
        begin
          Reg.GetKeyNames(subsubkeys);
          Reg.CloseKey;
          for j := 0 to subsubkeys.Count -1 do
          begin

            // Examine each USB Device
            if Reg.OpenKeyReadOnly(USBKEY + '\' + subkeys.Strings[i] + '\' +
              subsubkeys.Strings[j]) then
            begin
              // Check if it's a USB Palm device
              if (Reg.ReadString('Service') = 'PalmUSBD') or
                (Reg.ReadString('LocationInformation') = 'Palm Handheld') or
                (Reg.ReadString('Class') = 'Palm OS Handlheld Devices') then
              begin
                with TRegistry.Create do
                begin
                  RootKey := HKEY_LOCAL_MACHINE;
                  if (OpenKeyReadOnly(USBKEY + '\' + subkeys.Strings[i] + '\'
                    + subsubkeys.Strings[j] + '\Device Parameters')) then
                  begin
                    symName := ReadString('SymbolicName')
                  end
                  else
                  begin
                    symName := '';
                  end;
                  CloseKey;
                  Free;
                end;
                if (count < max) and (symName <> '') and
                  (Reg.ReadString('DeviceDesc') <> '') then
                begin
                  Inc(count);
                  names[count-1] := Reg.ReadString('DeviceDesc') +
                    IntToStr(count);
                  devicenames[count-1] := symName;
                end;
              end;
            end;
            Reg.CloseKey;
          end;
          subsubkeys.Clear;
        end;
      end;
      subkeys.Free;
    end;
  finally
    Reg.Free;
  end;

  Result := count;
end;

end.
