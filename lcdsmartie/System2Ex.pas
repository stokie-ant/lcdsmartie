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
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/System2Ex.pas,v $
 *  $Revision: 1.1 $ $Date: 2004/11/17 11:42:47 $
 *****************************************************************************}
unit SYSTEM2EX;

interface

uses
  Windows, SysUtils, Classes;

type

  TSystemEx = class(TComponent)
  private
     function getTotalPhysMemory:Int64;
     function getAvailPhysMemory:Int64;
     function getTotalPageFile:Int64;
     function getAvailPageFile:Int64;
     function getUsername:string;
     function getComputername:string;
  public
     constructor create(Aowner:TComponent);override;
  published
     property totalPhysmemory:Int64 read gettotalphysmemory;
     property AvailPhysmemory:Int64 read getavailphysmemory;
     property totalPageFile:Int64 read gettotalPageFile;
     property AvailPageFile:Int64 read getAvailPageFile;
     property Username:string read getUsername;
     property Computername:string read getComputername;
     function diskindrive(lw:char;statusanzeige:boolean):boolean;
     function disktyp(lw:char):string;
     function diskserialnumber(lw:char):integer;
     function diskfilesystem(lw:char):string;
     function disknamelength(lw:char):integer;
     function diskfreespace(lw:char):int64;
     function disktotalspace(lw:char):int64;
  end;

implementation

constructor TSystemEx.create(Aowner:TComponent);
begin
 inherited;
end;

type
  PMemoryStatusEx = ^TMemoryStatusEx;
  LPMEMORYSTATUSEX = PMemoryStatusEx;
  {$EXTERNALSYM LPMEMORYSTATUSEX}
  _MEMORYSTATUSEX = packed record
    dwLength        : DWORD;
    dwMemoryLoad    : DWORD;
    ullTotalPhys    : Int64;
    ullAvailPhys    : Int64;
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
  TFNGlobalMemoryStatusEx = function(var msx: TMemoryStatusEx): BOOL; stdcall;
var
  FNGlobalMemoryStatusEx: TFNGlobalMemoryStatusEx;
begin
  lpBuffer.dwLength:=SizeOf(TMemoryStatusEx);

  FNGlobalMemoryStatusEx := TFNGlobalMemoryStatusEx(
    GetProcAddress(GetModuleHandle(kernel32), 'GlobalMemoryStatusEx'));
  if not Assigned(FNGlobalMemoryStatusEx) then
  begin
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
    Result := False;
  end
  else
  begin
    lpBuffer.dwLength := sizeof(TMemoryStatusEx);
    Result := FNGlobalMemoryStatusEx(lpBuffer);
  end;
end;

function TSystemEx.gettotalphysmemory:Int64;
var
memory:TMemoryStatusEx;
begin
     if GlobalMemoryStatusEx(memory) then
       gettotalphysmemory:=memory.ulltotalphys
     else 
       gettotalphysmemory:=0;
end;

function TSystemEx.getavailphysmemory:Int64;
var
memory:TMemoryStatusEx;
begin
     if GlobalMemoryStatusEx(memory) then
       getavailphysmemory:=memory.ullavailphys
     else
       getavailphysmemory:=0;
end;

function TSystemEx.gettotalpagefile:Int64;
var
memory:TMemoryStatusEx;
begin
     if GlobalMemoryStatusEx(memory) then
       gettotalpagefile:=memory.ulltotalpagefile
     else
       gettotalpagefile:=0;
end;

function TSystemEx.getavailpagefile:Int64;
var
memory:TMemoryStatusEx;
begin
     if GlobalMemoryStatusEx(memory) then
       getavailpagefile:=memory.ullavailpagefile
     else
       getavailpagefile:=0;
end;

function TSystemEx.getusername:string;
var
p:Pchar;
size:Dword;
begin
     size:=1024;
     p:=stralloc(size);
     windows.getusername(p,size);
     getusername:=p;
     strdispose(p);
end;

function TSystemEx.getcomputername:string;
var
p:Pchar;
size:Dword;
begin
     size:=MAX_COMPUTERNAME_LENGTH+1;
     p:=stralloc(size);
     windows.getcomputername(p,size);
     getcomputername:=p;
     strdispose(p);
end;

function TSystemEx.diskindrive(lw: char; statusanzeige: boolean): boolean;
var
sRec:TsearchRec;
i:integer;
begin
     result:=false;
     {$I-}
     i:=findfirst(lw+':\*.*',faAnyfile,Srec);
     findclose(Srec);
     {$I+}
     case i of
     0:result:=true;
     2,18:begin
               if statusanzeige then
//               showmessage('Diskette im Laufwerk '+lw+' ist leer !');
               result:=true;
          end;
     21,3:if statusanzeige then
     begin
     end  // showmessage('Keine Diskette im Laufwerk '+lw+' !');
     else if statusanzeige then
     begin
     end  // showmessage('Diskette nicht formatiert !'+inttostr(i));
     end;
end;

function TSystemEx.disktyp(lw: char): string;
var
  typ:integer;
  s:string;
begin
  if diskindrive(lw,false) then begin
    s:=lw+':\';
    typ:=getdrivetype(Pchar(s));
    if typ <>0 then
      case typ of
        DRIVE_REMOVABLE:result:='Diskette';
        DRIVE_FIXED:result:='HardDisk';
        DRIVE_CDROM:result:='CDROM';
        DRIVE_RAMDISK:result:='RAMDisk';
        DRIVE_REMOTE:result:='Network';
      else result:='Unknown';
    end;
  end;
end;

function TSystemEx.diskserialnumber(lw: char): integer;
var
  root:string;
  volumenamebuffer,filesystemnamebuffer:pchar;
  filesystemflags,maximumcomponentlength:Dword;
  volumeserialnumber:dword;
begin
  volumeserialnumber:=0;
  if diskindrive(lw,false)then begin
    root:=lw+':\';
    volumenamebuffer:=stralloc(256);
    filesystemnamebuffer:=stralloc(256);
    Windows.GetVolumeInformation(pchar(root),volumenamebuffer,255,
                        @volumeserialnumber,maximumcomponentlength,
                        filesystemflags,filesystemnamebuffer,255);
    strdispose(volumenamebuffer);
    strdispose(filesystemnamebuffer);
  end;
  result:=volumeserialnumber;
end;

function TSystemEx.diskfilesystem(lw: char): string;
var
  root:string;
  volumenamebuffer,filesystemnamebuffer:pchar;
  filesystemflags,maximumcomponentlength:Dword;
  volumeserialnumber:dword;
begin
  if diskindrive(lw,false)then begin
    root:=lw+':\';
    volumenamebuffer:=stralloc(256);
    filesystemnamebuffer:=stralloc(256);
    GetVolumeInformation(pchar(root),volumenamebuffer,255,@volumeserialnumber,
                        maximumcomponentlength,filesystemflags,
                        filesystemnamebuffer,255);
    result:=filesystemnamebuffer;
    strdispose(volumenamebuffer);
    strdispose(filesystemnamebuffer);
  end;
end;

function TSystemEx.disknamelength(lw: char): integer;
var
  root:string;
  volumenamebuffer,filesystemnamebuffer:pchar;
  filesystemflags,maximumcomponentlength:Dword;
  volumeserialnumber:dword;
begin
  if diskindrive(lw,false)then begin
    root:=lw+':\';
    volumenamebuffer:=stralloc(256);
    filesystemnamebuffer:=stralloc(256);
    GetVolumeInformation(pchar(root),volumenamebuffer,255,@volumeserialnumber,
                          maximumcomponentlength,filesystemflags,
                          filesystemnamebuffer,255);
    result:=maximumcomponentlength;
    strdispose(volumenamebuffer);
    strdispose(filesystemnamebuffer);
  end else begin
    result:=0;
  end;
end;

function TSystemEx.diskfreespace(lw: char): int64;
var
la:byte;
lw2:char;
begin
     lw2:=upcase(lw);
     la:=ord(lw2)-64;
     result:=diskfree(la);
end;

function TSystemEx.disktotalspace(lw: char): int64;
var
la:byte;
lw2:char;
begin
     lw2:=upcase(lw);
     la:=ord(lw2)-64;
     result:=disksize(la);
end;

end.
