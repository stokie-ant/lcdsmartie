unit ULCD_CF;

interface

uses ULCD, USerial;

const
  MaxPacketLen = 23;
  MaxKeys = 20;

type
  TLCD_CF = class(TLCD)
    procedure customChar(character: Integer; data: Array of Byte); override;
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String); override;
    procedure setbacklight(on: Boolean); override;
    procedure setContrast(level: Integer); override;
    procedure setBrightness(level: Integer); override;
    function readKey(var key: Char): Boolean; override;
    procedure ClearScreen;
    constructor CreateSerial(uiPort: Cardinal; baudRate: Cardinal);
    destructor Destroy; override;
  private
    xPos: Cardinal;
    yPos: Cardinal;
    serial: TSerial;
    bPackets: Boolean;
    packet: array [1..MaxPacketLen] of Byte;
    keyBuf: String;
    uiBytesAvail: Cardinal;
    uiMaxContrast: Cardinal;
    uiVersion: Cardinal;
    function CalcCrc(buffer: PByte; uiSize: Cardinal):Word;
    function PacketCmd(cmdCode: Byte): Boolean;  overload;
    function PacketCmd(cmdCode: Byte; data: Byte): Boolean;  overload;
    function PacketCmd(cmdCode: Byte; sData: String): Boolean;  overload;
    function PacketCmd(cmdCode: Byte; dataLen: Byte; buffer: PByte): Boolean; overload;
    function PacketReply(cmdCode: Byte): Boolean;
    procedure AddKey(key: Char);
  end;

implementation

uses UMain, SysUtils, Forms, Windows;

const
  CmdPing = 0;
  CmdGetVersion = 1;
  CmdClearScreen = 6;
  CmdSetCustomChar = 9;
  CmdSetCursor = 12;
  CmdSetContrast = 13;
  CmdSetBrightness = 14;
  CmdKeyReporting = 23;
  CmdSendText = 31;

procedure TLCD_CF.AddKey(key: char);
begin
  keyBuf := keyBuf + key;
end;

function TLCD_CF.readKey(var key: Char): Boolean;
begin
  // send/receive a ping - a side effect of this is processing of key events.
  if (bPackets) then
    PacketCmd(CmdPing);

  if (Length(keyBuf) > 0) then
  begin
    key := keyBuf[1];
    keyBuf := copy(keyBuf,2,length(keyBuf)-1);
    Result := true;
  end
  else
    Result := false;
end;

function TLCD_CF.PacketCmd(cmdCode: Byte): Boolean;
begin
  result := PacketCmd(cmdCode, 0, nil);
end;

function TLCD_CF.PacketCmd(cmdCode: Byte; data: Byte): Boolean;
begin
  result := PacketCmd(cmdCode, 1, @data);
end;

function TLCD_CF.PacketCmd(cmdCode: Byte; sData: String): Boolean;
begin
  result := PacketCmd(cmdCode, Length(sData), @sData[1]);
end;

function TLCD_CF.PacketCmd(cmdCode: Byte; dataLen: Byte; buffer: PByte): Boolean;
var
  command: array of Byte;
  crc: Word;
  tries: Integer;
  pCmd: ^Byte;
  bOk: Boolean;
begin
  SetLength(command, dataLen+4);
  pCmd := @command[0];
  Inc(pCmd, 2);

  command[0] := cmdCode;
  command[1] := dataLen;
  if (dataLen > 0) then
    Move(buffer^, pCmd^, dataLen);
  crc := CalcCrc(@command[0], dataLen+2);
  command[dataLen+2] := Lo(crc);
  command[dataLen+3] := Hi(crc);

  tries := 0;
  repeat
    serial.Write(command, dataLen+4);
    Inc(tries);
    bOk := PacketReply(cmdCode)
  until (bOk) or (tries >= 3);

  Result := bOk;
end;

function TLCD_CF.PacketReply(cmdCode: Byte): Boolean;
const
  CMDCODEPOS = 1;
  DATALENPOS = 2;
  KEY_UL = 13;  KEY_UR = 14;
  KEY_LL = 15;  KEY_LR = 16;
  KEY_UP = 1; KEY_DOWN = 2;
  KEY_LEFT = 3; KEY_RIGHT = 4;
  KEY_ENTER = 5; KEY_CANCEL = 6;

var
  uiStartTime: Cardinal;
  bDone: Boolean;
  uiBytesRead: Cardinal;
  wCrc: Word;
  uiBytesToRemove: Cardinal;
begin
  uiStartTime := GetTickCount();
  bDone := false;
  uiBytesAvail := 0;
  uiBytesToRemove := 0;
  repeat
    // give the display a chance to do some work.
    Sleep(1);

    assert(uiBytesAvail < MaxPacketLen);
    uiBytesRead := serial.Read(@packet[uiBytesAvail+1], MaxPacketLen - uiBytesAvail);
    uiBytesAvail := uiBytesAvail + uiBytesRead;

    //Check if we have enough data for a packet
    if (uiBytesAvail >= 4) then
    begin

      if (packet[DATALENPOS] < MaxPacketLen-4) then
      begin
        if (uiBytesAvail >= (packet[DATALENPOS]+4)) then
        begin
          // we have enough data for the packet.
          // check then crc
          wCrc := CalcCrc(@packet[1], packet[DATALENPOS]+2);

          if (packet[packet[DATALENPOS]+3] = Lo(wCrc))
            and (packet[packet[DATALENPOS]+4] = Hi(wCrc)) then
          begin
            // packet is valid.
            // Is it the wanted packet?
            if (packet[CMDCODEPOS] = ($40 or cmdCode)) then
            begin
              bDone := true;               // success

              if (cmdCode = 1) and (packet[DATALENPOS]=16) then // version packet
              begin
                //  Data will be 'CFA633:hX.X,fY.Y'
                if (packet[3] = Byte('C'))
                  and (packet[4] = Byte('F'))
                  and (packet[5] = Byte('A'))
                  and (packet[6] = Byte('6'))
                  and (packet[7] = Byte('3')) then
                begin
                  if (packet[8] = Byte('1')) then
                  begin
                    uiMaxContrast := 255;
                    uiVersion := 631;
                  end
                  else if (packet[8] = Byte('3')) then
                  begin
                    uiMaxContrast := 50;
                    uiVersion := 633;
                  end;
                end;
              end;
            end
            else  // unhandled packet - ignore it
            begin
              if (packet[CMDCODEPOS] = $80) and (packet[DATALENPOS]=1) then
              begin
                // keyboard event
                case packet[3] of
                    // CFA631
                   KEY_UL: AddKey('A');
                   KEY_UR: AddKey('B');
                   KEY_LL: AddKey('C');
                   KEY_LR: AddKey('D');
                    // CFA633
                   KEY_UP: AddKey('E');
                   KEY_DOWN: AddKey('F');
                   KEY_LEFT: AddKey('G');
                   KEY_RIGHT: AddKey('H');
                   KEY_ENTER: AddKey('I');
                   KEY_CANCEL: AddKey('J');
                   // else ignore
                end;
              end;
              {else
                raise exception.create('unexpected packet: '
                  + IntToStr(packet[CMDCODEPOS]) + ':cmd=' + IntToStr(cmdCode));}
            end;

            uiBytesToRemove := packet[DATALENPOS] + 4;
          end
          else // crc is invaild, stream may be out of sync - remove discard one byte.
            uiBytesToRemove := 1;
        end;
      end
      else // data len is invaild, stream may be out of sync - remove discard one byte.
        uiBytesToRemove := 1;
    end;


    // Remove any unwanted data.
    if (uiBytesToRemove <> 0) then
    begin
      Dec(uiBytesAvail, uiBytesToRemove);
      if (uiBytesAvail > 0) then
        Move(packet[uiBytesToRemove+1], packet[1], uiBytesAvail);
      uiBytesToRemove := 0;
    end;

  until (bDone) or (GetTickCount() > uiStartTime + 250);

  //if (not bDone) then
   // raise exception.create('read timedout');

  Result := bDone;
end;

constructor TLCD_CF.CreateSerial(uiPort: Cardinal; baudRate: Cardinal);
begin
  serial := TSerial.Create(uiPort, baudRate, [RTS_ENABLE, DTR_ENABLE]);

  bPackets := false;
  // Test what kind of display we have:
  // we send: 0x0, 0x0, 0x47, 0x0f, which:
  //  - on a packet based display will cause an ack packet to be sent back.
  //  - on an 'ascii' based display it will mean:
  //    0x0: null
  //    0x0: null
  //    0x47: G
  //    0x0f: set contrast - wants one more character
  //   and no ack will be sent.
  if (PacketCmd(CmdPing)) then
  begin
    // understands packet protocol
    bPackets := true;
  end;

  if (bPackets) then
  begin
    PacketCmd(CmdGetVersion); // this is ugly; the reply is handled in the reading code
    PacketCmd(CmdSetCursor, 0); // hide cursor
    // ask for all keys to be reported
    if (uiVersion = 633) then
      PacketCmd(CmdKeyReporting, ''+#$3f+#0)
    else if (uiVersion = 631) then
      PacketCmd(CmdKeyReporting, ''+#$f+#0);

  end
  else
  begin
    serial.Write(0);   // sync up the ascii stream (it's waiting for contrast level)
    serial.Write(4);   // Hide cursor
    serial.Write(20);  // Scroll off.
    serial.Write(24);  // Wrap off.
    serial.Write(''+#22+#255+#1+#50);  // Disable scrolling marquee
    serial.Write(3);   // Restore display
  end;

  ClearScreen;

  inherited Create;
end;


destructor TLCD_CF.Destroy;
begin
  if (Assigned(serial)) then
  begin
    setbacklight(false);
    ClearScreen;
    serial.Destroy;
  end;
 
  inherited;
end;

procedure TLCD_CF.ClearScreen;
begin
  if (bPackets) then
    PacketCmd(CmdClearScreen)
  else
    serial.Write(12);
end;


// level is in the range of 0-100
procedure TLCD_CF.setContrast(level: Integer);
begin
  if (bPackets) then
  begin
    // range 0-255 on CFA631, 0-50 on CFA633!
    if (uiMaxContrast > 0) then
      PacketCmd(CmdSetContrast, (Cardinal(level)*uiMaxContrast) div 100);
  end
  else
  begin
    // range 0-100
    serial.Write(15);
    serial.Write(level);
  end;
end;

procedure TLCD_CF.setBrightness(level: Integer);
begin
  if (bPackets) then
  begin
    PacketCmd(CmdSetBrightness, level);
  end
  else
  begin
    serial.Write(14);
    serial.Write(level);
  end;
end;




procedure TLCD_CF.setbacklight(on: Boolean);
begin

  if (on) then
    setBrightness(100)
  else
    setBrightness(0);
end;

procedure TLCD_CF.setPosition(x, y: Integer);
begin
  if (bPackets) then
  begin
    xPos := x;
    yPos := y;
  end
  else
  begin
    // This is what basiep used to do...
    if (x=1) and (y=1) then
    begin
      serial.Write(3);   // Restore display
      serial.Write(4);   // Hide cursor
      serial.Write(20);  // Scroll off.
    end;

    serial.Write(17);
    serial.Write(x-1);
    serial.Write(y-1);
  end;
end;

procedure TLCD_CF.write(str: String);
var
  buffer: array of Byte;
  i: Cardinal;
begin

  {================ map characters onto displays character set =============}

  // Now handle all simple byte to byte mappings
  for i:= 1 to Length(str) do
  begin
    // Custom characters - these mapping exists only to be compatible with older
    // smartie releases.
    case Ord(str[i]) of
      131: str[i]:=Chr(2);
      132: str[i]:=Chr(3);
      133: str[i]:=Chr(4);
      134: str[i]:=Chr(5);
      135: str[i]:=Chr(6);
      136: str[i]:=Chr(7);
    end;

    // packet based display, with cgrom v2
    if (bPackets) and (config.iCF_cgrom = 2) then
    begin
      case Ord(str[i]) of
        Ord('^') {94}: str[i]:= Chr(29);
        Ord('ž') {158}: str[i]:= Chr(31);
      end;
    end;

      // custom chars
      //Ord('°') {176}: str[i]:=Chr(0);
      //Ord('ž') {158}: str[i]:=Chr(1);

    // v1 cgrom
    if (config.iCF_cgrom = 1) then
    begin
       { // map to cgrom - v1.0 displays
           '\' and '~' are not ascii mapped, but also don't appear in the cgrom...
       }
       if (str[i] = '°') {176} then str[i] := Chr(0); // custom char
       if (str[i] = 'ž') then str[i] := Chr(255);
    end
    else
    begin
      // v2 cgrom
      case Ord(str[i]) of
        Ord('°') {176}: str[i]:=Chr(0); // custom char

        Ord('$') {36}: str[i]:= Chr(162); // was 202
        Ord('@') {64}: str[i]:= Chr(160);
        Ord('[') {91}: str[i]:= Chr(250);
        Ord('\') {92}: str[i]:= Chr(251);
        Ord(']') {93}: str[i]:= Chr(252);
        Ord('_') {95}: str[i]:= Chr(196);
        Ord('`') {96}: str[i]:= Chr(39); // ` not in cgrom, mapped to ' instead
        Ord('’') {146}: str[i]:= Chr(39);
        Ord('{') {123}: str[i]:= Chr(253);
        Ord('|') {124}: str[i]:= Chr(254);
        Ord('}') {125}: str[i]:= Chr(255);
        Ord('~') {126}: str[i]:= Chr(206);
        Ord('£') {163}: str[i]:= Chr(161);
      end;
    end;
    // on ascii based displays, map on to special char locations
    if (not bPackets) and (Ord(str[i])<=7) then str[i]:=Chr(Ord(str[i])+128);
  end;

  // ascii based display with cgrom v2
  if (not bPackets) and (config.iCF_cgrom = 2) then
  begin
    str := StringReplace(str, '^', #30+#1+#29, [rfReplaceAll]);
    str := StringReplace(str, Chr(158) {ž}, #30+#1+#31, [rfReplaceAll]);
    assert(Pos('^', str)=0);
    assert(Pos(Chr(158), str)=0);
  end;

  if (bPackets) then
  begin
    SetLength(buffer, Length(str)+2);
    buffer[0] := xPos-1;
    buffer[1] := yPos-1;
    Move(str[1], buffer[2], Length(str));
    PacketCmd(CmdSendText, Length(str)+2, @buffer[0]);
    xPos := xPos + Cardinal(Length(str));
  end
  else
  begin
    serial.Write(@str[1], Length(str));
  end;
end;


procedure TLCD_CF.customChar(character: Integer; data: Array of Byte);
var
  buffer: Array [0..8] of Byte;
begin

  if (bPackets) then
  begin
    buffer[0] := character-1;
    Move(data[0], buffer[1], 8);
    PacketCmd(CmdSetCustomChar, 9, @buffer[0]);
  end
  else
  begin
    serial.Write(25);           //this starts the custom characters
    serial.Write(character-1);  //00 to 07 for 8 custom characters.
    serial.Write(@data[0], 8);
  end;
end;

function TLCD_CF.CalcCrc(buffer: PByte; uiSize: Cardinal):Word;
const
  crcs: array [0..$ff] of word =
    ($0000, $1189, $2312, $329b, $4624, $57ad, $6536, $74bf,
    $8c48, $9dc1, $af5a, $bed3, $ca6c, $dbe5, $e97e, $f8f7,
    $1081, $0108, $3393, $221a, $56a5, $472c, $75b7, $643e,
    $9cc9, $8d40, $bfdb, $ae52, $daed, $cb64, $f9ff, $e876,
    $2102, $308b, $0210, $1399, $6726, $76af, $4434, $55bd,
    $ad4a, $bcc3, $8e58, $9fd1, $eb6e, $fae7, $c87c, $d9f5,
    $3183, $200a, $1291, $0318, $77a7, $662e, $54b5, $453c,
    $bdcb, $ac42, $9ed9, $8f50, $fbef, $ea66, $d8fd, $c974,
    $4204, $538d, $6116, $709f, $0420, $15a9, $2732, $36bb,
    $ce4c, $dfc5, $ed5e, $fcd7, $8868, $99e1, $ab7a, $baf3,
    $5285, $430c, $7197, $601e, $14a1, $0528, $37b3, $263a,
    $decd, $cf44, $fddf, $ec56, $98e9, $8960, $bbfb, $aa72,
    $6306, $728f, $4014, $519d, $2522, $34ab, $0630, $17b9,
    $ef4e, $fec7, $cc5c, $ddd5, $a96a, $b8e3, $8a78, $9bf1,
    $7387, $620e, $5095, $411c, $35a3, $242a, $16b1, $0738,
    $ffcf, $ee46, $dcdd, $cd54, $b9eb, $a862, $9af9, $8b70,
    $8408, $9581, $a71a, $b693, $c22c, $d3a5, $e13e, $f0b7,
    $0840, $19c9, $2b52, $3adb, $4e64, $5fed, $6d76, $7cff,
    $9489, $8500, $b79b, $a612, $d2ad, $c324, $f1bf, $e036,
    $18c1, $0948, $3bd3, $2a5a, $5ee5, $4f6c, $7df7, $6c7e,
    $a50a, $b483, $8618, $9791, $e32e, $f2a7, $c03c, $d1b5,
    $2942, $38cb, $0a50, $1bd9, $6f66, $7eef, $4c74, $5dfd,
    $b58b, $a402, $9699, $8710, $f3af, $e226, $d0bd, $c134,
    $39c3, $284a, $1ad1, $0b58, $7fe7, $6e6e, $5cf5, $4d7c,
    $c60c, $d785, $e51e, $f497, $8028, $91a1, $a33a, $b2b3,
    $4a44, $5bcd, $6956, $78df, $0c60, $1de9, $2f72, $3efb,
    $d68d, $c704, $f59f, $e416, $90a9, $8120, $b3bb, $a232,
    $5ac5, $4b4c, $79d7, $685e, $1ce1, $0d68, $3ff3, $2e7a,
    $e70e, $f687, $c41c, $d595, $a12a, $b0a3, $8238, $93b1,
    $6b46, $7acf, $4854, $59dd, $2d62, $3ceb, $0e70, $1ff9,
    $f78f, $e606, $d49d, $c514, $b1ab, $a022, $92b9, $8330,
    $7bc7, $6a4e, $58d5, $495c, $3de3, $2c6a, $1ef1, $0f78);

var
  x: Cardinal;
  crc: Word;
begin
  crc := $ffff;
  for x := 0 to uiSize-1 do
  begin
    crc := Hi(crc) xor crcs[ buffer^ xor Lo(crc) ];
    Inc(buffer);
  end;

  Result := not crc;
end;

end.

