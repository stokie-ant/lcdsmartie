unit ULCD_HD;

{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/ULCD_HD.pas,v $
 *  $Revision: 1.6 $ $Date: 2004/12/15 20:06:06 $
 *
 *  Based on code from the following (open-source) projects:
 *     WinAmp LCD Plugin
 *     LCDproc
 *     lcdtext
 *     lcdtime 
 *  by the following authors:
 *     Teabeats (p.f.schrijver@student.utwente.nl)
 *     andy Rasa(rrasa@sky.net)
 *     Markus Zehnder in lcdplugin
 *     Andrew McmMeikan <andrewm@engineer.com>
 *     Richard Rognlie <rrognlie@gamerz.net>
 *     Matthias Prinke <m.prinke@trashcan.mcnet.de>
 *     Benjamin Tse (blt@mundil.cs.mu.oz.au)
 *
 *  note: DLPortIO.DLL should be in $windir/system32/
 *        DLPortIO.SYS should be in $windir/system32/drivers/
 *****************************************************************************}

interface

uses ULCD;

procedure DlPortWritePortUchar(Port: Integer; Data: Byte); stdcall;  external 'dlportio.dll';
function DlPortReadPortUchar(Port: Integer): Byte stdcall;  external 'dlportio.dll';


const
  // control pins
  RS = 4; // pin 16
  RW = 2; // pin 14
  E1 = 1; // pin 1,  Enable device 1
  E2 = 8; // pin 17, Enable device 2, or backlight on 1 controller devices
  CtrlMask = 11; // The parallel hardware inverts some of the outputs.
  // delays required by device
  uiDelayShort = 40;
  uiDelayMed = 100;
  uiDelayLong = 1600;
  uiDelayInit = 4100;
  uiDelayBus = 17;
  // control functions
  ClearScreen = 1;
  SetPos = 128;
  SetCGRamAddr = 64;
  OnOffCtrl = 8;
  OODisplayOn = 4;
  OODisplayOff = 0;
  OOCursorOn = 2;
  OOCursorOff = 0;
  OOCursorBlink = 1;
  OOCursorNoBlink = 0;

type
  TControllers = (All, C1, C2);

  TLCD_HD = class(TLCD)
      procedure customChar(character: Integer; data: Array of Byte); override;
      procedure setPosition(x, y: Integer); override;
      procedure write(str: String); override;
      procedure setbacklight(on: Boolean); override;
      procedure powerResume; override;
      constructor CreateParallel(const poortadres: Word; const width, heigth: Byte);
      destructor Destroy; override;
    private
      FBaseAddr: Word;
      FCtrlAddr: Word;
      cursorx, cursory: Word;
      backlight, lcd16, width, heigth: Byte;
      bTwoControllers: Boolean;
      bHighResTimers: Boolean;
      iHighResTimerFreq: Int64;
      procedure writectrl(const controllers: TControllers; const x: Byte);
      procedure writedata(const controllers: TControllers; const x: Byte);
      procedure writestring(const controllers: TControllers; s: String);
      procedure setcursor1(const x, y: Byte);
      procedure setcursor2(const x, y: Byte);
      procedure setcursor3(const x, y: Byte); //1 controller lcd's
      procedure clear;
      procedure UsecDelay(uiUsecs: Cardinal);
      procedure init;
      procedure CtrlOut(const AValue: Byte);
      procedure DataOut(const AValue: Byte);
      procedure initClass;
  end;

implementation

uses UMain, SysUtils, Windows;

constructor TLCD_HD.CreateParallel(const poortadres: Word; const width, heigth: Byte);
begin
  FBaseAddr := poortadres;
  FCtrlAddr := FBaseAddr + 2;
  self.width := width;
  self.heigth := heigth;
  bHighResTimers := QueryPerformanceFrequency(iHighResTimerFreq);
  initClass;
end;

destructor TLCD_HD.Destroy;
begin
  clear;

  setbacklight(false);

  writectrl(All, OnOffCtrl or OODisplayOff);
  UsecDelay(uiDelayShort);

  inherited;
end;


procedure TLCD_HD.powerResume;
begin
  initClass;
end;


procedure TLCD_HD.initClass;
begin
  backlight := 8;
  cursorx := 1;
  cursory := 1;

  //defining wether lcd is 1 or 2 controller based
  if (width >= 40) and (heigth >= 4) then begin
    bTwoControllers := True;
    backlight := 0;
  end
  else bTwoControllers := False;

  //adjustment for 16 column lcd's
  if width > 16 then lcd16 := 0 else lcd16 := 4;
  init;
end;

procedure TLCD_HD.init;
const
  FuncSet = 32;
  FSInterface8Bit = 16;
  FSInterface4Bit = 0;
  FSTwoLine = 8;
  FSOneLine = 0;
  FSSmallFont = 4;
  FSBigFont = 0;
  EntryMode = 4;
  EMIncrement = 2;
  EMDecrement = 0;
  EMShift = 1;
  EMNoShift = 0;
  HomeCursor = 2;
begin
  // perform initalising by instruction, just in case std power reset failed.
  writectrl(All, FuncSet or FSInterface8Bit);
  UsecDelay(uiDelayInit);

  writectrl(All, FuncSet or FSInterface8Bit);
  UsecDelay(uiDelayMed);

  writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont);
  UsecDelay(uiDelayShort);

  writectrl(All, OnOffCtrl);
  UsecDelay(uiDelayShort);

  writectrl(All, ClearScreen);
  UsecDelay(uiDelayLong);

  writectrl(All, EntryMode or EMIncrement or EMNoShift);
  UsecDelay(uiDelayMed);

  // initialization finished.

  writectrl(All, OnOffCtrl or  OODisplayOn or OOCursorOff or OOCursorNoBlink);
  UsecDelay(uiDelayLong);

  writectrl(All, HomeCursor);
  UsecDelay(uiDelayLong);

end;

procedure TLCD_HD.setbacklight(on: Boolean);
begin
  if on and not bTwoControllers then
    backlight := 8
  else
    backlight := 0;

  if (not bTwoControllers) then
    clear; //update 'lightline'
end;

procedure TLCD_HD.write(str: String);
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

  if (cursory < 3) or not bTwoControllers then
    writestring(C1, str)
  else
    writestring(C2, str);
end;

procedure TLCD_HD.setPosition(x, y: Integer);
begin
  if not bTwoControllers then setcursor3(x, y)
  else if y <= 2 then setcursor1(x, y)
  else setcursor2(x, y);
  cursory := y;
end;

procedure TLCD_HD.customChar(character: Integer; data: Array of Byte);
var
  i: Byte;
begin


    writectrl(All, SetCGRamAddr + ((character-1) * 8));
    for i := 0 to 7 do writedata(All, data[i]);

    {
    // for 2nd controller
    writectrl2(SetCGRamAddr + ((character-1) * 8));
    for i := 0 to 7 do writedata2(data[i]);
    }

    { why twice?
    writectrl2(64 + ((adr-1) * 8));
    for i := 1 to 8 do
      writedata2(data[i]);
    }

end;

procedure TLCD_HD.clear;
begin
  writectrl(All, ClearScreen);
  UsecDelay(uiDelayLong);
end;

procedure TLCD_HD.UsecDelay(uiUsecs: Cardinal);
var
  uiElapsed: Cardinal;
  iBegin, iCurr: int64;
begin
  if (bHighResTimers) then
  begin
    QueryPerformanceCounter(iBegin);

	  repeat
      QueryPerformanceCounter(iCurr);

		  uiElapsed := (((iCurr - iBegin) * 1000 * 1000) div iHighResTimerFreq);

	  until (uiElapsed > uiUsecs);
  end
  else
  begin
    raise exception.create('PerformanceCounter not supported on this system');
  end;
end;

procedure TLCD_HD.writectrl(const controllers: TControllers; const x: Byte);
var
  enableLines, portControl: Byte;
begin

  if bTwoControllers then
  begin
    case controllers of
      All: enableLines := E1 or E2;
      C1: enableLines := E1;
      C2: enableLines := E2;
      else enableLines := E1;
    end;
    portControl := 0;
  end
  else
  begin
    assert(controllers <> C2);
    enableLines := E1;
    portControl := backlight;
  end;

  CtrlOut(portControl);
  DataOut(x);
  UsecDelay(uiDelayBus);
  CtrlOut(enableLines or portControl);
  UsecDelay(uiDelayBus);
  CtrlOut(portControl);

  {
  CtrlOut(3 or backlight);  // 3/11 RS=0, R/W=0, E=0,         0000 0011
  DataOut(x);
  CtrlOut(2 or backlight);  // 2/10 RS=0, R/W=0, E1=1, E2=0,  0000 0010
  CtrlOut(3 or backlight);  // 3/11 RS=0, R/W=0, E=0          0000 0011
  CtrlOut(1 or backlight);  // 1/9 RS=0, R/W=1, E=0           0000 0001
  Sleep(3); //max execution time = 1,64 ms, so this should be safe
  }
end;

procedure TLCD_HD.writedata(const controllers: TControllers; const x: Byte);
var
  enableLines, portControl: Byte;
begin

  if bTwoControllers then
  begin
    case controllers of
      All: enableLines := E1 or E2;
      C1: enableLines := E1;
      C2: enableLines := E2;
      else enableLines := E1;
    end;
    portControl := RS;
  end
  else
  begin
    assert(controllers <> C2);
    enableLines := E1;
    portControl := RS or backlight;
  end;

  CtrlOut(portControl);
  DataOut(x);
  UsecDelay(uiDelayBus);
  CtrlOut(enableLines or portControl);
  UsecDelay(uiDelayBus);
  CtrlOut(portControl);

{
  CtrlOut(7 or backlight);     //7 + 8   B111 === B100  RS | backlight
  DataOut(x);
  //bus delay
  CtrlOut(6 or backlight);     //6  RS=1, R/W=0, E=1  B110 == 101      RS | E1
  //bus delay
  CtrlOut(7 or backlight);     //7  B111 = B100 = RS
  CtrlOut(5 or backlight);     //5  101 = 110 RS|RW  ?????

  //Sleep(1);  //instead of the line below because of faster processors

  for i := 0 to 65535 do begin  +/- 40 us  end;
  for i := 0 to 65535 do begin  +/- 40 us  end;
  }
end;

procedure TLCD_HD.writestring(const controllers: TControllers; s: String);
var
  i: Byte;
begin
  i := 1;
  while (i <= length(s)) and (cursorx <= width) do begin
    writedata(controllers, ord(s[i]));
    inc(i);
    inc(cursorx);
  end;
  //for i := 1 to length(s) do writedata(ord(s[i]));
end;


procedure TLCD_HD.setcursor1(const x, y: Byte);
begin
  case y of
    1: writectrl(C1, SetPos or (x-1));
    2: writectrl(C1, SetPos or (64 + (x-1)));
  end;
  cursorx := x;
end;

procedure TLCD_HD.setcursor2(const x, y: Byte);
begin
  case y of
    3: writectrl(C2, SetPos or (x-1));
    4: writectrl(C2, SetPos or (64 + (x-1)));
  end;
  cursorx := x;
end;

procedure TLCD_HD.setcursor3(const x, y: Byte);
begin
  case y of
    1: writectrl(C1, SetPos or (x-1));
    2: writectrl(C1, SetPos or (64 + (x-1)));
    3: writectrl(C1, SetPos or (20 + (x-1) - lcd16));
    4: writectrl(C1, SetPos or (84 + (x-1) - lcd16));
  end;
  cursorx := x;
end;



procedure TLCD_HD.CtrlOut(const AValue: Byte);
begin
  DlPortWritePortUchar(FCtrlAddr, AValue xor CtrlMask);
end;

procedure TLCD_HD.DataOut(const AValue: Byte);
begin
  DlPortWritePortUchar(FBaseAddr, AValue);
end;

{
function TLCD_HD.lcdpresent: Boolean;
begin
  Result := DlPortReadPortUchar(FCtrlAddr) < 255;
  init;
end;  }

end.

