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
 *  $Revision: 1.4 $ $Date: 2004/11/16 21:44:21 $
 *****************************************************************************}
unit System2;

interface

uses
  Windows, SysUtils, Classes;

type

  TSystem = class(TComponent)
  private
     function getTotalPhysMemory:DWORD;
     function getAvailPhysMemory:DWORD;
     function getTotalPageFile:DWORD;
     function getAvailPageFile:DWORD;
     function getUsername:string;
     function getComputername:string;
  public
     constructor create(Aowner:TComponent);override;
  published
     property totalPhysmemory:DWORD read gettotalphysmemory;
     property AvailPhysmemory:DWORD read getavailphysmemory;
     property totalPageFile:DWORD read gettotalPageFile;
     property AvailPageFile:DWORD read getAvailPageFile;
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

constructor TSystem.create(Aowner:TComponent);
begin
 inherited;
end;



function tsystem.gettotalphysmemory:DWORD;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     gettotalphysmemory:=memory.dwtotalphys;
end;

function tsystem.getavailphysmemory:DWORD;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     getavailphysmemory:=memory.dwavailphys;
end;

function tsystem.gettotalpagefile:DWORD;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     gettotalpagefile:=memory.dwtotalpagefile;
end;

function tsystem.getavailpagefile:DWORD;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     getavailpagefile:=memory.dwavailpagefile;
end;

function tsystem.getusername:string;
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

function tsystem.getcomputername:string;
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

function TSystem.diskindrive(lw: char; statusanzeige: boolean): boolean;
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

function TSystem.disktyp(lw: char): string;
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

function TSystem.diskserialnumber(lw: char): integer;
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

function TSystem.diskfilesystem(lw: char): string;
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

function TSystem.disknamelength(lw: char): integer;
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

function TSystem.diskfreespace(lw: char): int64;
var
la:byte;
lw2:char;
begin
     lw2:=upcase(lw);
     la:=ord(lw2)-64;
     result:=diskfree(la);
end;

function TSystem.disktotalspace(lw: char): int64;
var
la:byte;
lw2:char;
begin
     lw2:=upcase(lw);
     la:=ord(lw2)-64;
     result:=disksize(la);
end;

end.
