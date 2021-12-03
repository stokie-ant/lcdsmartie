{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/SYSTEM2.PAS,v $
 *  $Revision: 1.10 $ $Date: 2005/01/25 23:02:50 $
 *****************************************************************************}
unit System2;

interface

uses Windows, SysUtils, Classes;

type

  TSystem = class(TComponent)
  private
    function getIsWin2kXP: Boolean;
    function getTotalPhysMemory: Int64;
    function getAvailPhysMemory: Int64;
    function getTotalPageFile: Int64;
    function getAvailPageFile: Int64;
    function getUsername: String;
    function getComputername: String;
  public
    constructor Create(Aowner: TComponent); override;
  published
    property bIsWin2kXP: Boolean read getIsWin2kXP;
    property totalPhysmemory: Int64 read gettotalphysmemory;
    property AvailPhysmemory: Int64 read getavailphysmemory;
    property totalPageFile: Int64 read gettotalPageFile;
    property AvailPageFile: Int64 read getAvailPageFile;
    property Username: String read getUsername;
    property Computername: String read getComputername;
    function diskindrive(lw: char;statusanzeige: Boolean): Boolean;
    function disktyp(lw: char): String;
    function diskserialnumber(lw: char): Integer;
    function diskfilesystem(lw: char): String;
    function disknamelength(lw: char): Integer;
    function diskfreespace(lw: char): int64;
    function disktotalspace(lw: char): int64;
  end;

implementation

constructor TSystem.create(Aowner: TComponent);
begin
  inherited;
end;

type
  PMemoryStatusEx = ^TMemoryStatusEx;
  LPMEMORYSTATUSEX = PMemoryStatusEx;
  {$EXTERNALSYM LPMEMORYSTATUSEX}
  _MEMORYSTATUSEX = packed Record
    dwLength : DWORD;
    dwMemoryLoad : DWORD;
    ullTotalPhys : Int64;
    ullAvailPhys : Int64;
    ullTotalPageFile: Int64;
    ullAvailPageFile: Int64;
    ullTotalVirtual : Int64;
    ullAvailVirtual : Int64;
    ullAvailExtenededVirtual : Int64;
  end;
  {$EXTERNALSYM _MEMORYSTATUSEX}
  TMemoryStatusEx = _MEMORYSTATUSEX;
  MEMORYSTATUSEX = _MEMORYSTATUSEX;
  {$EXTERNALSYM MEMORYSTATUSEX}

//---

function GlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): BOOL; stdcall;
type
  TFNGlobalMemoryStatusEx = function(var msx: TMemoryStatusEx): BOOL;
  stdcall;
var
  FNGlobalMemoryStatusEx: TFNGlobalMemoryStatusEx;
begin
  lpBuffer.dwLength := SizeOf(TMemoryStatusEx);

  FNGlobalMemoryStatusEx := TFNGlobalMemoryStatusEx(
    GetProcAddress(GetModuleHandle(kernel32), 'GlobalMemoryStatusEx'));
  if not Assigned(FNGlobalMemoryStatusEx) then
  begin
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
    Result := False;
  end
  else
  begin
    Result := FNGlobalMemoryStatusEx(lpBuffer);
  end;
end;

function TSystem.getIsWin2kXP: Boolean;
var
  oviVersionInfo: TOSVERSIONINFO;
begin
  oviVersionInfo.dwOSVersionInfoSize := SizeOf(oviVersionInfo);
  if not GetVersionEx(oviVersionInfo) then raise
    Exception.Create('Can''t get the Windows version');
  if (oviVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and
    (oviVersionInfo.dwMajorVersion >= 5) then getIsWin2kXP := true
  else getIsWin2kXP := false;
end;

function TSystem.gettotalphysmemory: Int64;
var
  memory: TMemoryStatus;
  memoryEx: TMemoryStatusEx;
begin
  if getIsWin2kXP then
  begin
    memoryEx.dwLength := sizeof(TMemoryStatusEx);
    if GlobalMemoryStatusEx(memoryEx) then gettotalphysmemory :=
      memoryEx.ulltotalphys
    else gettotalphysmemory := 0;
  end
  else
  begin
    memory.dwLength := sizeof(TMemoryStatus);
    GlobalMemoryStatus(memory);
    gettotalphysmemory := memory.dwtotalphys;
  end;
end;

function TSystem.getavailphysmemory: Int64;
var
  memory: TMemoryStatus;
  memoryEx: TMemoryStatusEx;
begin
  if getIsWin2kXP then
  begin
    memoryEx.dwLength := sizeof(TMemoryStatusEx);
    if GlobalMemoryStatusEx(memoryEx) then getavailphysmemory :=
      memoryEx.ullavailphys
    else getavailphysmemory := 0;
  end
  else
  begin
    memory.dwLength := sizeof(TMemoryStatus);
    GlobalMemoryStatus(memory);
    getavailphysmemory := memory.dwavailphys;
  end;
end;

function TSystem.gettotalpagefile: Int64;
var
  memory: TMemoryStatus;
  memoryEx: TMemoryStatusEx;
begin
  if getIsWin2kXP then
  begin
    memoryEx.dwLength := sizeof(TMemoryStatusEx);
    if GlobalMemoryStatusEx(memoryEx) then gettotalpagefile :=
      memoryEx.ulltotalpagefile
    else gettotalpagefile := 0;
  end
  else
  begin
    memory.dwLength := sizeof(TMemoryStatus);
    GlobalMemoryStatus(memory);
    gettotalpagefile := memory.dwtotalpagefile;
  end;
end;

function TSystem.getavailpagefile: Int64;
var
  memory: TMemoryStatus;
  memoryEx: TMemoryStatusEx;
begin
  if getIsWin2kXP then
  begin
    memoryEx.dwLength := sizeof(TMemoryStatusEx);
    if GlobalMemoryStatusEx(memoryEx) then getavailpagefile :=
      memoryEx.ullavailpagefile
    else getavailpagefile := 0;
  end
  else
  begin
    memory.dwLength := sizeof(TMemoryStatus);
    GlobalMemoryStatus(memory);
    getavailpagefile := memory.dwavailpagefile;
  end;
end;

function tsystem.getusername: String;
var
  p: Pchar;
  size: Dword;
begin
  size := 1024;
  p := stralloc(size);
  windows.getusername(p, size);
  getusername := p;
  strdispose(p);
end;

function tsystem.getcomputername: String;
var
  p: Pchar;
  size: Dword;
begin
  size := MAX_COMPUTERNAME_LENGTH + 1;
  p := stralloc(size);
  windows.getcomputername(p, size);
  getcomputername := p;
  strdispose(p);
end;

function TSystem.diskindrive(lw: char; statusanzeige: Boolean): Boolean;
var
  sRec: TsearchRec;
  i: Integer;
begin
  result := false;
     {$I-}
  i := findfirst(lw + ':\*.*', faAnyfile, Srec);
  findclose(Srec);
     {$I+}
  case i of
    0: result := true;
    2, 18:
      begin
        if statusanzeige then
//               showmessage('Diskette im Laufwerk ' + lw + ' ist leer !');
          result := true;
      end;
    21, 3:
      if statusanzeige then
      begin
      end // showmessage('Keine Diskette im Laufwerk ' + lw + ' !');
      else
        if statusanzeige then
        begin
        end// showmessage('Diskette nicht formatiert !' + inttostr(i));
  end;
end;

function TSystem.disktyp(lw: char): String;
var
  typ: Integer;
  s: String;
begin
  if diskindrive(lw, false) then
  begin
    s := lw + ':\';
    typ := getdrivetype(Pchar(s));
    if typ <> 0 then
      case typ of
        DRIVE_REMOVABLE: result := 'Diskette';
        DRIVE_FIXED: result := 'HardDisk';
        DRIVE_CDROM: result := 'CDROM';
        DRIVE_RAMDISK: result := 'RAMDisk';
        DRIVE_REMOTE: result := 'Network';
        else result := 'Unknown';
      end;
  end;
end;

function TSystem.diskserialnumber(lw: char): Integer;
var
  root: String;
  volumenamebuffer, filesystemnamebuffer: pchar;
  filesystemflags, maximumcomponentlength: Dword;
  volumeserialnumber: dword;
begin
  volumeserialnumber := 0;
  if diskindrive(lw, false)then
  begin
    root := lw + ':\';
    volumenamebuffer := stralloc(256);
    filesystemnamebuffer := stralloc(256);
    Windows.GetVolumeInformation(pchar(root),volumenamebuffer, 255,
      @volumeserialnumber, maximumcomponentlength, filesystemflags,
      filesystemnamebuffer, 255);
    strdispose(volumenamebuffer);
    strdispose(filesystemnamebuffer);
  end;
  result := volumeserialnumber;
end;

function TSystem.diskfilesystem(lw: char): String;
var
  root: String;
  volumenamebuffer, filesystemnamebuffer: pchar;
  filesystemflags, maximumcomponentlength: Dword;
  volumeserialnumber: dword;
begin
  if diskindrive(lw, false)then
  begin
    root := lw + ':\';
    volumenamebuffer := stralloc(256);
    filesystemnamebuffer := stralloc(256);
    GetVolumeInformation(pchar(root),volumenamebuffer, 255,
      @volumeserialnumber, maximumcomponentlength, filesystemflags,
      filesystemnamebuffer, 255);
    result := filesystemnamebuffer;
    strdispose(volumenamebuffer);
    strdispose(filesystemnamebuffer);
  end;
end;

function TSystem.disknamelength(lw: char): Integer;
var
  root: String;
  volumenamebuffer, filesystemnamebuffer: pchar;
  filesystemflags, maximumcomponentlength: Dword;
  volumeserialnumber: dword;
begin
  if diskindrive(lw, false)then
  begin
    root := lw + ':\';
    volumenamebuffer := stralloc(256);
    filesystemnamebuffer := stralloc(256);
    GetVolumeInformation(pchar(root),volumenamebuffer, 255,
      @volumeserialnumber, maximumcomponentlength, filesystemflags,
      filesystemnamebuffer, 255);
    result := maximumcomponentlength;
    strdispose(volumenamebuffer);
    strdispose(filesystemnamebuffer);
  end
  else
  begin
    result := 0;
  end;
end;

function TSystem.diskfreespace(lw: char): int64;
var
  la: byte;
  lw2: char;
  uiOldMode: Cardinal;
begin
  // We don't want any system dislogs poping up if a file or drive isn't found.
  uiOldMode := SetErrorMode(SEM_NOOPENFILEERRORBOX or SEM_FAILCRITICALERRORS);
  lw2 := upcase(lw);
  la := ord(lw2)-64;
  result := diskfree(la);
  if (result = -1) then result := 0;
  SetErrorMode(uiOldMode);
end;

function TSystem.disktotalspace(lw: char): int64;
var
  la: byte;
  lw2: char;
  uiOldMode: Cardinal;
begin
  // We don't want any system dislogs poping up if a file or drive isn't found.
  uiOldMode := SetErrorMode(SEM_NOOPENFILEERRORBOX or SEM_FAILCRITICALERRORS);
  lw2 := upcase(lw);
  la := ord(lw2)-64;
  result := disksize(la);
  if (result = -1) then result := 0;
  SetErrorMode(uiOldMode);
end;

end.
