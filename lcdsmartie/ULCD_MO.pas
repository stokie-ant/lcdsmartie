unit ULCD_MO;

{ Much of the USB Palm code in this file is based on the code in
  EmTransportUSBWin.cpp of pose (The Palm OS Emulator).}


interface

uses ULCD, Classes, SyncObjs, SysUtils, Windows, USerial, UUtils;

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
  UsbErrDontMatchFilter	 = $00000010;		// Creator ID provided doesnt
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
    constructor CreateSerial(uiPort: Byte; baudRate: Cardinal);
    constructor CreateUsb;
    constructor Create; override;
    destructor Destroy; override;
  private
    serial: TSerial;
    bConnected: Boolean;
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
    procedure writeDevice(buffer: string); overload;
    procedure writeDevice(byte: Byte); overload;
    function readDevice(var chr: Char): Boolean;
    Function OpenUsbPort: Boolean;
    procedure initLCD;
  end;

implementation

uses UMain, Dialogs, Forms, Registry;

constructor TLCD_MO.CreateSerial(uiPort: Byte; baudRate: Cardinal);
begin
  serial := TSerial.Create(uiPort, baudRate, [RTS_ENABLE, DTR_ENABLE]);

  Create();
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
    raise Exception.Create('Failed whilst locating USB palms: '+IntToStr(ret)
      + ':'+errMsg(GetLastError));

  if (deviceCount > 0) then
  begin

    // $504F7262   == 'POrb'
    usbPalm := FNOpenPort(@buffer[1], $504F7262);

    // Some Palms incorrectly don't use an app id, also PalmOrb didn't use
    // to use an app id in older versions. So we try to connect with 0 id.
    if (usbPalm = INVALID_HANDLE_VALUE) then
      usbPalm := FNOpenPort(@buffer[1], 0);

    // Some Palms incorrectly use the app id, and so we have to
    // connect using 'sync'
    if (usbPalm = INVALID_HANDLE_VALUE) then
      usbPalm := FNOpenPort(@buffer[1], $73796e63); // $73796e63 == 'sync'
   
    if (usbPalm = INVALID_HANDLE_VALUE) then
       raise Exception.Create(
         'An USB palm was detected but we failed to connect to PalmOrb.'+#10+#13
         + 'Please ensure PalmOrb is already running on your Palm.');

    // Set read/write time outs so LCD Smartie doesnt hang
    timeouts.uiReadTimeout:=500; // 0.5 seconds
    timeouts.uiWriteTimeout:=1000;  // 1 second

    FNSetTimeouts(usbPalm, @timeouts);

    bConnected := true;

    initLcd();
  end;

  Result := bConnected;
end;

function GetVersion(sFile: String):String;
var
  iVerSize: Integer;
  iLen: Cardinal;
  verInfo: pointer;
  sVer: String;
  fixedInfo: PVSFIXEDFILEINFO;
  dummy: Cardinal;
  ptr: pointer;
begin
  sVer := 'unknown';
  
  iVerSize := GetFileVersionInfoSize(PChar(sFile), dummy);
  if iVerSize <> 0 then
  begin
    GetMem(verInfo, iVerSize);
    GetFileVersionInfo(PChar(sFile), 0, iVerSize, verInfo);
    if (VerQueryValue(verInfo, '\', ptr, iLen))
       and (iLen<>0) then
    begin
      fixedInfo := PVSFixedFileInfo(ptr);
      sVer := Format('%d.%d.%d.%d : %d.%d.%d.%d', [
        (fixedInfo.dwFileVersionMS and not $FFFF) shr 16, (fixedInfo.dwFileVersionMS and $FFFF),
        (fixedInfo.dwFileVersionLS and not $FFFF)  shr 16, (fixedInfo.dwFileVersionLS and $FFFF),
        (fixedInfo.dwProductVersionMS and not $FFFF) shr 16, (fixedInfo.dwProductVersionMS and $FFFF),
        (fixedInfo.dwFileVersionLS and not $FFFF) shr 16, (fixedInfo.dwFileVersionLS and $FFFF)
        ]);
    end;
    FreeMem(verInfo);
  end;
  Result := sVer;
end;

procedure LogInfo(sPath: String; sDll: String);
var
  fLog: textfile;
  winDir: PChar;
begin
  assignfile(fLog,  extractfilepath(application.exename) + 'usb.log');
  rewrite(fLog);

  writeln(fLog, 'Path: ' + sPath);
  writeln(fLog, 'DLL: ' + sDll + ' [' + GetVersion(sDll) + ']');
  GetMem(winDir, 144);
  GetWindowsDirectory(winDir, 144);

  writeln(fLog, winDir+'\system32\drivers\PalmUSBD.sys: [' + GetVersion(windir+'\system32\drivers\PalmUSBD.sys') + ']');
  FreeMem(winDir);

  closefile(fLog);
end;




constructor TLCD_MO.CreateUsb;
const
  PALMDESKTOPKEY='\Software\U.S. Robotics\Pilot Desktop\Core';
var

  reg: TRegistry;
  path: String;
  sFile: String;
begin
  usbPortLib := 0;
  usbPalm := INVALID_HANDLE_VALUE;
  bUsb := True;

  // This is a hopeless attempt to get round the fact that the current
  // USBPalmd.sys isn't multiprocessor or hyperthread-enabled safe.
  SetThreadAffinityMask(GetCurrentThread(),1);

  // Check if hotsync is running
  if FindWindow('KittyHawk', Nil) <> 0 then
    raise Exception.Create('Detected Hotsync running - please terminate it and restart LCD Smartie.');



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

  sFile := 'USBPort.dll';
  usbPortLib := LoadLibrary(PChar(sFile));
  if (usbPortLib = 0) then
  begin
    sFile := path+'\USBPort.dll';
    usbPortLib := LoadLibrary(PChar(sFile));
  end;
  if (usbPortLib = 0) then
  begin
    sFile := 'c:\Program Files\palmOne\USBPort.dll';
    usbPortLib := LoadLibrary(PChar(sFile));
  end;
  if (usbPortLib = 0) then
  begin
    sFile := 'c:\Palm\USBPort.dll';
    usbPortLib := LoadLibrary(PChar(sFile));
  end;

  if (usbPortLib = 0) then
    raise Exception.create('Can not find USBPort.dll.');

  LogInfo(path, sFile);

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
    raise Exception.Create('Failed to get required APIs.');

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
      writeDevice('X');
    except
    end;
    bConnected := false;
  end;

  if (bUsb) then
  begin
    if Assigned(readThread) then
    begin
      readThread.Terminate;
      // wait for upto 5 seconds, read timeout is set 0.5 seconds.
      if (readThread.exited.WaitFor(5000) = wrSignaled) then
        readThread.Free();
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
    serial.Destroy;
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
  if (t1 >= 0) and (t1 <= 255)
    and (t2 >= 0) and (t2 <= 255) then
  begin
    writeDevice($FE);                         //set speed
    writeDevice($C0);
    writeDevice(t1);
    writeDevice(t2);
  end;

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

procedure TLCD_MO.writeDevice(buffer: string);
var
  bytesWritten: Cardinal;
  ret, len: Cardinal;
begin
  len := length(buffer);

  if (not bConnected) then
  begin
    if (not bUsb) then Exit;

    // See if we can reconnect.
    if (not OpenUsbPort()) then Exit;
  end;

  if (len = 0) then Exit;

  if not bUsb then
  begin

    serial.Write(@buffer[1], len);

  end
  else
  begin

    ret:=FNSendBytes(usbPalm, @buffer[1], len, @bytesWritten);
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
  writeDevice(Char(byte));
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

    if (serial.Read(Byte(chr))) then gotdata:=true;

  end;

  Result := gotdata;
end;

procedure TLCD_MO.doReadThread;
var
  bytesRead: Cardinal;
  buffer: Byte;
  ret: Cardinal;
begin
    // This is a hopeless attempt to get round the fact that the current
    // USBPalmd.sys isn't multiprocessor or hyperthread-enabled safe.
    SetThreadAffinityMask(GetCurrentThread(),1);

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
