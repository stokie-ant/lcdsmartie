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
 *  $Revision: 1.20 $ $Date: 2006/03/02 19:41:12 $
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
 *
 *  The addidion of inpout32.dll support requires that the dll file be
 *  placed in the program directory or the %windir/system32 directory.
 *****************************************************************************}

interface

uses ULCD;

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
  TDlPortWritePortUchar = procedure (Port: Integer; Data: Byte); stdcall;//  external 'IOPlugin.dll';
  TDlPortReadPortUchar = function (Port: Integer): Byte; stdcall;//  external 'IOPlugin.dll';

  TControllers = (All, C1, C2);

  TLCD_HD = class(TLCD)
      procedure customChar(character: Integer; data: Array of Byte); override;
      procedure setPosition(x, y: Integer); override;
      procedure write(str: String); override;
      procedure setbacklight(state: Boolean); override;
      constructor CreateParallel(const poortadres: Word; const width, heigth: Byte);
      destructor Destroy; override;
    private
      IOPlugin: HMODULE;
      FBaseAddr: Word;
      FCtrlAddr: Word;
      cursorx, cursory: Word;
      backlight, width, height: Byte;
      bTwoControllers: Boolean;
      bHighResTimers: Boolean;
      iHighResTimerFreq: Int64;
      DlPortWritePortUchar: TDlPortWritePortUchar;
      DlPortReadPortUchar: TDlPortReadPortUchar;
      bHasIOPlugin: Boolean;
      bHasIO: Boolean;
      procedure writectrl(const controllers: TControllers; const x: Byte);
      procedure writedata(const controllers: TControllers; const x: Byte);
      procedure writestring(const controllers: TControllers; s: String);
      procedure clear;
      procedure UsecDelay(uiUsecs: Cardinal);
      procedure init;
      procedure CtrlOut(const AValue: Byte);
      procedure DataOut(const AValue: Byte);
      procedure initClass;
      procedure LoadIO;
      procedure UnloadIO;
  end;

implementation

uses UConfig, SysUtils, Windows;

constructor TLCD_HD.CreateParallel(const poortadres: Word; const width, heigth: Byte);
{var
  x, y: integer; }
begin
  bHasIO := False;
  bHighResTimers := QueryPerformanceFrequency(iHighResTimerFreq);

  FBaseAddr := poortadres;
  FCtrlAddr := FBaseAddr + 2;
  self.width := width;
  self.height := heigth;

  LoadIO();
  bHasIO := True;

  initClass;

     {    // DEBUG CODE for checking addressing.
    for y:=1 to height do
      for x:=1 to width do
         SetPosition(x, y);
         }
end;

destructor TLCD_HD.Destroy;
begin
  clear;

  setbacklight(false);

  writectrl(All, OnOffCtrl or OODisplayOff);
  UsecDelay(uiDelayShort);

  UnloadIO();


  inherited;
end;

procedure TLCD_HD.LoadIO;
begin
  { Try inpout32.dll first, since it supports x64 }
  IOPlugin := LoadLibrary(PChar('inpout32.dll'));
  if (IOPlugin <> 0) then
  begin
    DlPortWritePortUchar := TDlPortWritePortUchar(GetProcAddress(IOPlugin,'Inp32'));
    DlPortReadPortUchar := TDlPortReadPortUchar(GetProcAddress(IOPlugin,'Out32'));
    if (not Assigned(DlPortWritePortUchar)) or (not Assigned(DlPortReadPortUchar)) then
      raise Exception.Create('Loaded inpout32, but unable to obtain API.')
    else
    begin
      bHasIOPlugin := True;
      Exit; { Got our plugin, we're done }
    end;
  end;

  { Try good old dlportio.dll next, for backwards compatiability }
  IOPlugin := LoadLibrary(PChar('dlportio.dll'));
  if (IOPlugin <> 0) then
  begin
    DlPortWritePortUchar := TDlPortWritePortUchar(GetProcAddress(IOPlugin,
      'DlPortWritePortUchar'));
    DlPortReadPortUchar := TDlPortReadPortUchar(GetProcAddress(IOPlugin,
      'DlPortReadPortUchar'));
    if (not Assigned(DlPortWritePortUchar)) or (not Assigned(DlPortReadPortUchar)) then
      raise Exception.Create('Loaded dlportio, but unable to obtain API.')
    else
    begin
      bHasIOPlugin := True;
      Exit;
    end;
  end;

  { Last resort: fallback to low-level I/O and warn user.
    TODO: Should check that this is not NT/XP before attempting low-level I/O! }
  bHasIOPlugin := False;
  raise Exception.Create('Couldn''t find inpout32.dll or dlportio.dll, attempting to use low-level I/O routines.');

end;

procedure TLCD_HD.UnloadIO;
begin
  if (bHasIOPlugin = True) then FreeLibrary(IOPlugin);
  IOPlugin := 0;
  bHasIOPlugin := False;
  bHasIO := False;
  DlPortWritePortUchar := nil;
  DlPortReadPortUchar := nil;
end;

procedure TLCD_HD.initClass;
begin
  backlight := 8;
  cursorx := 1;
  cursory := 1;

  //defining wether lcd is 1 or 2 controller based
  if (width * height > 80) then begin
    bTwoControllers := True;

    // the line usually used for the backlight is used to enable the second
    // controller.
    backlight := 0;
  end
  else bTwoControllers := False;

  init;
end;

procedure TLCD_HD.init;
const
  FuncSet = 32;
  FSInterface8Bit = 16;
  FSInterface4Bit = 0;
  FSTwoLine = 8;
  FSOneLine = 0;
  FSSmallFont = 0;
  FSBigFont = 4;
  EntryMode = 4;
  EMIncrement = 2;
  EMDecrement = 0;
  EMShift = 1;
  EMNoShift = 0;
  HomeCursor = 2;
  { Extra functions of KS0073 }
  ExtFuncSet = 8;
  FSExtReg = 4;
  EFSFourLine = 1;
  EFSOneTwoLine = 0;
  EFSFontWidth6 = 4;
  EFSFontWidth5 = 0;

begin
  // perform initalising by instruction, just in case std power reset failed.

  writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont);
  UsecDelay(uiDelayInit);

  writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont);
  UsecDelay(uiDelayMed);

  writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont);
  UsecDelay(uiDelayShort);

  writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont);
  UsecDelay(uiDelayShort);

  if (config.bHDKS0073Addressing = True) then
  begin
    { Need to set extended functions }
    writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont
      or FSExtReg);
    UsecDelay(uiDelayShort);
    if height = 4
    then
      writectrl(All, ExtFuncSet or EFSFourLine)
    else
      writectrl(All, ExtFuncSet);
    UsecDelay(uiDelayShort);
    writectrl(All, FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont);
  end;

  writectrl(All, OnOffCtrl or OODisplayOff);
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

  {
   // was:
  writectrl(C1,56 xor CtrlMask);// 111000 = FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont
  writectrl(C1,56 xor CtrlMask);// 111000 = FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont
  writectrl(C1,56 xor CtrlMask);// 111000 = FuncSet or FSInterface8Bit or FSTwoLine or FSSmallFont
  writectrl(C1,6 xor CtrlMask); // 000110 = EntryMode or EMIncrement or EMNoShift
  writectrl(C1,12 xor CtrlMask);// 001100 = OnOffCtrl or OODisplayOn or OOCursorOff or OOCursorNoBlick
 }
end;

procedure TLCD_HD.setbacklight(state: Boolean);
begin
  if state = True and not bTwoControllers then
    backlight := 8
  else
    backlight := 0;

  if (not bTwoControllers) then
      CtrlOut(backlight);; //update 'lightline'
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

  if (not bTwoControllers) or (cursory < ((height div 2)+1)) then
    writestring(C1, str)
  else
    writestring(C2, str);
end;


procedure TLCD_HD.customChar(character: Integer; data: Array of Byte);
var
  i: Byte;
begin
    writectrl(All, SetCGRamAddr + ((character-1) * 8));
    for i := 0 to 7 do
      writedata(All, data[i]);

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
  uiElapsed: int64;
  uiUsecsScaled: int64;
  iBegin, iCurr: int64;
begin
  {$R-}
  uiUsecsScaled := int64(uiUsecs) * int64(config.iHDTimingMultiplier);

  if (uiUsecs <= 0) then Exit;

  if (bHighResTimers) then
  begin
    QueryPerformanceCounter(iBegin);

	  repeat
      QueryPerformanceCounter(iCurr);

      if (iCurr < iBegin) then iBegin := 0;
		  uiElapsed := ((iCurr - iBegin) * 1000000) div iHighResTimerFreq;

	  until (uiElapsed > uiUsecsScaled);
  end
  else
  begin
    raise exception.create('PerformanceCounter not supported on this system');
  end;

  {$R+}
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
  UsecDelay(uiDelayShort);

  // Some displays may to need this
  //CtrlOut(RW or portControl);
  // UsecDelay(200);
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
  UsecDelay(uiDelayShort);

  // Some displays may to need this
  //if (bTwoControllers) then
  //  CtrlOut(RW)
  //else
  //  CtrlOut(RW or backlight);
  //    UsecDelay(200);
{
  CtrlOut(7 or backlight);     //7 + 8   B111 === B100  RS | backlight
  DataOut(x);
  CtrlOut(6 or backlight);     //6  RS=1, R/W=0, E=1  B110 == 101      RS | E1
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

    // special case for 1 chip 1x16 displays
    if (config.bHDAltAddressing) and (width = 16) and (height = 1)
      and (cursorx = 9) then
      setPosition(cursorx, cursory);

    writedata(controllers, ord(s[i]));
    inc(i);
    inc(cursorx);
  end;
  //for i := 1 to length(s) do writedata(ord(s[i]));
end;


procedure TLCD_HD.setPosition(x, y: Integer);
var
  tempX, tempY: Byte;
  DDaddr: Byte;
  controller: TControllers;
begin
  // store theses values as they are used when a write occurs.
  cursory := y;
  cursorx := x;

  tempX := x - 1;
  tempY := y - 1;

  if (bTwoControllers) and (tempY >= (height div 2)) then
  begin
    tempY := tempY mod (height div 2);
    controller := C2;
  end
  else
    controller := C1;
  if (config.bHDKS0073Addressing = False) then
  begin
    // Find DDRAM address for HDD44780

    // special case for 1 chip 1x16 displays, acts like 2x8 display
    if (config.bHDAltAddressing) and (width = 16) and (height = 1)
      and (tempX >= 8) then
    begin
      tempX := tempX - 8;
      tempY := tempY + 1;
    end;

    DDaddr := tempX + (tempY mod 2) * 64;

    // line 3 logically follows line 1, (same for 4 and 2)
    if ((tempY mod 4) >= 2) then
      DDaddr := DDaddr + width;
  end
  else
  begin
    // Find DDRAM address for KS0073
    { Addressing:
      Line 1 - 0x00
      Line 2 - 0x20
      Line 3 - 0x40
      Line 4 - 0x60 }
    DDaddr := tempX + 32 * tempY;
  end;

  writectrl(controller, SetPos or DDaddr);
end;

procedure PortOut(IOport:word; Value:byte); assembler;
asm
  xchg ax,dx
  out dx,al
end;

procedure TLCD_HD.CtrlOut(const AValue: Byte);
begin
  if (not bHasIO) then exit;
  if (bHasIOPlugin) then
  begin
    if (@DlPortWritePortUchar <> nil) then
      DlPortWritePortUchar(FCtrlAddr, AValue xor CtrlMask);
  end
  else
    PortOut(FCtrlAddr, AValue xor CtrlMask);
end;

procedure TLCD_HD.DataOut(const AValue: Byte);
begin
  if (not bHasIO) then exit;
  if (bHasIOPlugin) then
  begin
    if (@DlPortWritePortUchar <> nil) then
      DlPortWritePortUchar(FBaseAddr, AValue);
  end
  else
    PortOut(FBaseAddr, AValue);
end;

{
function TLCD_HD.lcdpresent: Boolean;
begin
  Result := DlPortReadPortUchar(FCtrlAddr) < 255;
  init;
end;  }

end.

