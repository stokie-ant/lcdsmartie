unit ULCD_IR;

interface

uses
  Windows,Sockets,ExtCtrls,ULCD;

const
  STATUS_RECEIVE = 4;

  LCD_BACKLIGHT = 1;
  LCD_TEXT = 2;

  COMMAND_LCD = 15;
  COMMAND_BRIGHTNESS = 44;
  COMMAND_DEFINECHAR = 45;

type
  TSTATUSBUFFER = record
    clientid : dword;
    statuslen : word;
    statustype : word;
    adress : word;
    align : array[1..2] of byte;
    data : array[1..32768] of char
  end;

  TNETWORKCOMMAND = record
    netcommand : byte;
    mode : byte;
    timeout : word;
    adress : dword;
    protocol_version : dword;
    remote : array[0..79] of byte;
    command : array[0..19] of byte;
    trasmit_freq : byte;
  end;

  TLCDCOMMAND = record
    netcommand : byte;
    mode : byte;
    lcdcommand : byte;
    timeout : byte;
    adress : dword;
    protocol_version : dword;
    wid : byte;
    hgt : byte;
    framebuffer : array[0..199] of char;
  end;

  TLCD_IR = class(TLCD)
  public
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String); override;
    procedure customChar(chr: Integer; data: Array of Byte); override;
//  procedure setbacklight(on: Boolean); override;
    procedure setBrightness(level: Integer); override;
    constructor CreateSocket(HostAddress : string);
    destructor Destroy; override;
  private
    ID : longint;
    MyX,MyY : integer;
    SocketHealthTimer: TTimer;
    ClientSocket: TTcpClient;
    LCDComRec : TLCDCOMMAND;
    NetworkCommand : TNETWORKCOMMAND;
    InSocketHealthTimer : boolean;
    WritingAlready : boolean;
    procedure SocketHealthTimerTimer(Sender: TObject);
    procedure ClientSocketError(Sender: TObject; SocketError: Integer);
    procedure ClientSocketConnect(Sender: TObject);
  end;

implementation

uses
  SysUtils;

constructor TLCD_IR.CreateSocket(HostAddress : string);
var
  Loop : integer;
begin
  InSocketHealthTimer := false;
  WritingAlready := false;
  MyX := 1;
  MyY := 1;

  // our ID to the IRTrans server.  Anything but 0 seems to fail
  ID := 0;

  // custom characters, sent when the socket is established (in case the connection drops while LCDSmartie is running)
  fillchar(NetworkCommand,sizeof(NetworkCommand),$00);
  NetworkCommand.netcommand := COMMAND_DEFINECHAR;
  NetworkCommand.protocol_version := 200;
  NetworkCommand.Remote[0] := 8;
  for Loop := 1 to 8 do
    NetworkCommand.Remote[Loop*9-8] := Loop;

  // custom characters, sent when the socket is established (in case the connection drops while LCDSmartie is running)
  fillchar(LCDComRec,sizeof(LCDComRec),$00);
  // these are 4x40 regardless of the size of the display.  The IRTrans server sorts out the actual display size!
  LCDComRec.hgt := 4;
  LCDComRec.wid := 40;
  LCDComRec.lcdcommand := LCD_BACKLIGHT + LCD_TEXT;
  LCDComRec.protocol_version := 200;

  // create the socket, try to bring it up
  try
    ClientSocket := TTcpClient.Create(nil);
    with ClientSocket do begin
      BlockMode := bmBlocking;
      RemoteHost := HostAddress;
      RemotePort := '21000';
      OnError := ClientSocketError;
      OnConnect := ClientSocketConnect;
      Active := true;
    end;
  except
  end;

  // monitor the socket, if it's closed, bring it back up
  SocketHealthTimer := TTimer.Create(nil);
  with SocketHealthTimer do begin
    Interval := 5000;
    Enabled := true;
    OnTimer := SocketHealthTimerTimer;
  end;

  inherited Create;
end;

destructor TLCD_IR.Destroy;
begin
  try
    SocketHealthTimer.Free;
    ClientSocket.Free;
  except
  end;
  inherited;
end;

procedure TLCD_IR.ClientSocketConnect(Sender: TObject);
begin
  try
    // we've just connected, send our ID and the custom character set
    ClientSocket.SendBuf(ID,4);
    ClientSocket.SendBuf(NetworkCommand,sizeof(NetworkCommand));
  except
  end;
end;

procedure TLCD_IR.ClientSocketError(Sender: TObject; SocketError: Integer);
begin
  // got an error, close the socket
  ClientSocket.Close;
end;

procedure TLCD_IR.SocketHealthTimerTimer(Sender: TObject);
begin
  if InSocketHealthTimer then exit;
  InSocketHealthTimer := true;
  try
    if not ClientSocket.Active then ClientSocket.Active := true;
  except
  end;
  InSocketHealthTimer := false;
end;

procedure TLCD_IR.setBrightness(level: Integer);
begin
  LCDComRec.netcommand := COMMAND_BRIGHTNESS;
  LCDComRec.adress := level mod 4;  // 0-3 is the brightness
  try
    if ClientSocket.Connected then
      ClientSocket.SendBuf(LCDComRec,sizeof(LCDComRec));
  except
  end;
end;

{
procedure TLCD_IR.setbacklight(on: Boolean);
// this command exists, but I have no way to test it since I have a VFD.
begin
end;
}

procedure TLCD_IR.customChar(chr: Integer; data: Array of Byte);
begin
  chr := ((chr - 1) mod 8) + 1;  // characters 1-8
  Move(data[0], NetworkCommand.Remote[Chr*9-7], 8);
  try
    if ClientSocket.Connected then
      ClientSocket.SendBuf(NetworkCommand,sizeof(NetworkCommand));
  except
  end;
end;

procedure TLCD_IR.setPosition(x, y: Integer);
begin
  MyX := X;
  MyY := Y;
end;

procedure TLCD_IR.write(str: String);
var
  B : byte;
  Loop,Index : integer;
  buf : TSTATUSBUFFER;
  res : integer;
  statustimeout : dword;
begin
  if WritingAlready then exit;
  WritingAlready  := true;
  // characters 1-8 (custom chars) and 32-127 are the only valid on screen characters
  for Loop := 1 to length(str) do begin
    B := ord(str[Loop]);
    if (B < 32) or (B > 127) then begin
      B := ((B - 1) mod 8) + 1;
      str[Loop] := char(b);
    end;
  end;
  try
    LCDComRec.netcommand := COMMAND_LCD;
    LCDComRec.adress := ord('L');
    Index := (MyY-1)*40 + (MyX-1);
    strcopy(pchar(@LCDComRec.framebuffer[Index]),pchar(str));
    if ClientSocket.Connected then begin
      // send the displays' frame buffer
      ClientSocket.SendBuf(LCDComRec,sizeof(LCDComRec));
      // wait for the servers response
      statustimeout := gettickcount;
      repeat
        res := ClientSocket.ReceiveBuf(buf,32768);
        if (res = 8) then break;
      until (buf.statustype = STATUS_RECEIVE) or ((gettickcount - statustimeout) > 2000);
    end;
  except
  end;
  WritingAlready := false;
end;

end.
