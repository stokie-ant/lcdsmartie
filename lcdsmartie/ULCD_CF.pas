unit ULCD_CF;

interface

uses ULCD, VaClasses, VaComm;

type
  TLCD_CF = class(TLCD)
    procedure customChar(character: Integer; data: Array of Byte); override;
    procedure setPosition(x, y: Integer); override;
    procedure write(str: String); override;
    procedure setbacklight(on: Boolean); override;
    procedure setContrast(level: Integer); override;
    procedure setBrightness(level: Integer); override;
    constructor CreateSerial(serial: PTVACOMM; uiPort: Cardinal; baudRate: TVaBaudrate);
    destructor Destroy; override;
  private
    serial: PTVACOMM;
  end;

implementation

uses UMain, SysUtils, Forms;

constructor TLCD_CF.CreateSerial(serial: PTVACOMM; uiPort: Cardinal; baudRate: TVaBaudrate);
begin
  self.serial := serial;
  serial.Baudrate := baudRate;
  serial.PortNum := uiPort;
  //VaComm1.Close;
  serial.Open;

  serial.WriteChar(Chr(3));   // Restore display
  serial.WriteChar(Chr(4));   // Hide cursor
  serial.WriteChar(Chr(20));  // Scroll off.

  inherited Create;
end;

destructor TLCD_CF.Destroy;
var
  x: Cardinal;
begin
  setbacklight(false);

  // Ensure all serial data has been writen out
  // (close discards all remaining data)
  x := 0;
  While (serial.WriteBufUsed > 0) and (x<100) do
  begin
    Inc(x);
    Application.ProcessMessages;
    Sleep(10);
  end;
  serial.close;
  inherited;
end;

procedure TLCD_CF.setContrast(level: Integer);
begin
  serial.WriteChar(chr(15));
  serial.WriteChar(chr(level));
end;

procedure TLCD_CF.setBrightness(level: Integer);
begin
  serial.WriteChar(chr(14));
  serial.WriteChar(chr(level));
end;




procedure TLCD_CF.setbacklight(on: Boolean);
begin
  serial.WriteChar(chr(14));
  if (on) then
    serial.WriteChar(chr(100))
  else
    serial.WriteChar(chr(0));
end;

procedure TLCD_CF.setPosition(x, y: Integer);
begin
  // This is what basiep used to do...
  if (x=1) and (y=1) then
  begin
    serial.WriteChar(Chr(3));   // Restore display
    serial.WriteChar(Chr(4));   // Hide cursor
    serial.WriteChar(Chr(20));  // Scroll off.
  end;

  serial.WriteChar(chr(17));
  serial.WriteChar(chr(x-1));
  serial.WriteChar(chr(y-1));
end;

procedure TLCD_CF.write(str: String);
begin
  str := StringReplace(str, '°', chr(128), [rfReplaceAll]);
  str := StringReplace(str, '', chr(129), [rfReplaceAll]);
  str := StringReplace(str, chr(131), chr(130), [rfReplaceAll]);
  str := StringReplace(str, chr(132), chr(131), [rfReplaceAll]);
  str := StringReplace(str, chr(133), chr(132), [rfReplaceAll]);
  str := StringReplace(str, chr(134), chr(133), [rfReplaceAll]);
  str := StringReplace(str, chr(135), chr(134), [rfReplaceAll]);
  str := StringReplace(str, chr(136), chr(135), [rfReplaceAll]);
  str := StringReplace(str, '{', chr(253), [rfReplaceAll]);
  str := StringReplace(str, '|', chr(254), [rfReplaceAll]);
  str := StringReplace(str, '}', chr(255), [rfReplaceAll]);
  str := StringReplace(str, '$', chr(202), [rfReplaceAll]);
  str := StringReplace(str, '@', chr(160), [rfReplaceAll]);
  str := StringReplace(str, '_', 'Ä', [rfReplaceAll]);
  str := StringReplace(str, '’', chr(39), [rfReplaceAll]);
  str := StringReplace(str, '`', chr(39), [rfReplaceAll]);
  str := StringReplace(str, '~', chr(206), [rfReplaceAll]);
  str := StringReplace(str, '[', 'ú', [rfReplaceAll]);
  str := StringReplace(str, ']', 'ü', [rfReplaceAll]);
  str := StringReplace(str, '\', 'û', [rfReplaceAll]);
  str := StringReplace(str, '^', chr(206), [rfReplaceAll]);

  serial.WriteText(str);
end;


procedure TLCD_CF.customChar(character: Integer; data: Array of Byte);
begin
  serial.WriteChar(chr(25));           //this starts the custom characters
  serial.WriteChar(chr(character-1));  //00 to 07 for 8 custom characters.
  serial.WriteChar(chr(data[0]));
  serial.WriteChar(chr(data[1]));
  serial.WriteChar(chr(data[2]));
  serial.WriteChar(chr(data[3]));
  serial.WriteChar(chr(data[4]));
  serial.WriteChar(chr(data[5]));
  serial.WriteChar(chr(data[6]));
  serial.WriteChar(chr(data[7]));
end;

end.

