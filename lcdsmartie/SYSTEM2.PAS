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
 *  $Revision: 1.2 $ $Date: 2004/10/25 22:52:48 $
 *****************************************************************************}
unit System2;

interface

uses
  shellapi,mmsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

Const
     InfoStrings: Array[0..1] of String = ('FDIV instruction is Flawed',
                                           'FDIV instruction is OK');

Const
  // Constants to be used with Feature Flag set of a CPU
  // eg. IF (Features and FPU_FLAG = FPU_FLAG) THEN CPU has Floating-Point unit on chip
  // However, Intel claims that in future models, a zero in the feature flags will
  // mean that the chip has that feature, however, the following flags will work for
  // any production 80x86 chip or clone.
  // eg. IF (Features and FPU_FLAG = 0) then CPU has Floating-Point unit on chip
  FPU_FLAG = $00000001; // Floating-Point unit on chip
  VME_FLAG = $00000002; // Virtual Mode Extention
   DE_FLAG = $00000004; // Debugging Extention
  PSE_FLAG = $00000008; // Page Size Extention
  TSC_FLAG = $00000010; // Time Stamp Counter
  MSR_FLAG = $00000020; // Model Specific Registers
  PAE_FLAG = $00000040; // Physical Address Extention
  MCE_FLAG = $00000080; // Machine Check Exception
  CX8_FLAG = $00000100; // CMPXCHG8 Instruction
 APIC_FLAG = $00000200; // Software-accessible local APIC on Chip
  BIT_10   = $00000400; // Reserved, do not count on value
  SEP_FLAG = $00000800; // Fast System Call
 MTRR_FLAG = $00001000; // Memory Type Range Registers
  PGE_FLAG = $00002000; // Page Global Enable
  MCA_FLAG = $00004000; // Machine Check Architecture
 CMOV_FLAG = $00008000; // Conditional Move Instruction
  BIT_16   = $00010000; // Reserved, do not count on value
  BIT_17   = $00020000; // Reserved, do not count on value
  BIT_18   = $00040000; // Reserved, do not count on value
  BIT_19   = $00080000; // Reserved, do not count on value
  BIT_20   = $00100000; // Reserved, do not count on value
  BIT_21   = $00200000; // Reserved, do not count on value
  BIT_22   = $00400000; // Reserved, do not count on value
  MMX_FLAG = $00800000; // MMX technology
  BIT_24   = $01000000; // Reserved, do not count on value
  BIT_25   = $02000000; // Reserved, do not count on value
  BIT_26   = $04000000; // Reserved, do not count on value
  BIT_27   = $08000000; // Reserved, do not count on value
  BIT_28   = $10000000; // Reserved, do not count on value
  BIT_29   = $20000000; // Reserved, do not count on value
  BIT_30   = $40000000; // Reserved, do not count on value
  BIT_31   = $80000000; // Reserved, do not count on value

type

  Freq_info = Record
    Raw_Freq: Cardinal;       // Raw frequency of CPU in MHz.
    Norm_Freq: Cardinal;      // Normalized frequency of CPU in MHz.
    In_Cycles: Cardinal;      // Internal clock cycles during test
    Ex_Ticks: Cardinal;       // Microseconds elapsed during test
  end;

  TCpuInfo = Record
    VendorIDString: String;
    Manufacturer: String;
    CPU_Name: String;
    PType: Byte;
    Family: Byte;
    Model: Byte;
    Stepping: Byte;
    Features: Cardinal;
    MMX: Boolean;
    Frequency_Info: Freq_Info;
    IDFDIVOK: Boolean;
  end;
 TDragDropEvent=procedure(files:tstringlist) of object;
 TBetriebsSystem=(bsWin95,bsWinNT,bsWin32);
  TSystem = class(TComponent)
  private
    { Private-Deklarationen }
    FOnDragDrop:TDragDropEvent;
     FFiles:TStringList;
     FHide:boolean;
     procedure SetHide(status:boolean);
     function GetColorCount:integer;
     function getTotalPhysMemory:longint;
     function getAvailPhysMemory:longint;
     function getTotalPageFile:longint;
     function getAvailPageFile:longint;
     function getwindowsdirectory:string;
     function getSystemdirectory:string;
     function getUsername:string;
     function getComputername:string;
     function GetCPUSpeed: Freq_Info;
     function CPUID: TCpuInfo;
     function TestFDIVInstruction: Boolean;
     function getprocessorType:string;
     function getprocessorcount:integer;
     function getsystem:tBetriebssystem;
     procedure Appmessage(var Msg:tmsg; var handled:boolean);

  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
     constructor create(Aowner:TComponent);override;
  published
    { Published-Deklarationen }
     // GetCPUInfo liest alle Prozessordaten aus
     procedure GetCPUInfo(Var CPUInfo: TCpuInfo);
     property OnDragDrop:TDragDropEvent read FOnDragDrop write FOnDragDrop;
     property colorcount:integer read getcolorcount;
     property Hide:boolean read FHide write SetHide;
     property totalPhysmemory:longint read gettotalphysmemory;
     property AvailPhysmemory:longint read getavailphysmemory;
     property totalPageFile:longint read gettotalPageFile;
     property AvailPageFile:longint read getAvailPageFile;
     property windowsdirectory:string read getwindowsdirectory;
     property Systemdirectory:string read getSystemdirectory;
     property Username:string read getUsername;
     property Computername:string read getComputername;
     property Processortype:string read getProcessortype;
     property Processorcount:integer read getProcessorcount;
     property system:TBetriebsSystem read getsystem;
     procedure shutdown;
     procedure reboot;
     procedure logoff;
     function sound:boolean;
     function diskindrive(lw:char;statusanzeige:boolean):boolean;
     function disktyp(lw:char):string;
     function diskserialnumber(lw:char):integer;
     function diskfilesystem(lw:char):string;
     function disknamelength(lw:char):integer;
     function diskfreespace(lw:char):int64;
     function disktotalspace(lw:char):int64;
     function setComputername(name:string):boolean;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Beispiele', [TSystem]);
end;


constructor TSystem.create(Aowner:TComponent);
      begin
        inherited;
        FFiles:=TStringlist.create;
        DragAcceptFiles((AOwner as Tform).handle,true);
        DraGAcceptFiles(Application.handle,true);
        application.onmessage:=appmessage;
      end;

function TSYstem.GetColorCount:integer;
begin
  getcolorcount:=1 SHL getDeviceCaps(GetDC(0),bitspixel);
end;

procedure Tsystem.sethide(status:boolean);
begin
     fhide:=status;
     if status then
        showwindow(application.handle,sw_hide)
     else
         showwindow(application.handle,sw_show);
end;


procedure TSystem.GetCPUInfo(Var CPUInfo: TCpuInfo);
begin
  CPUInfo := CPUID;
  CPUInfo.IDFDIVOK := TestFDIVInstruction;
  iF (CPUInfo.Features and TSC_FLAG = TSC_FLAG) then
     CPUInfo.Frequency_Info := GetCPUSpeed;
  if (CPUInfo.Features and MMX_FLAG) = MMX_FLAG then
     CPUInfo.MMX := True
  else
    CPUInfo.MMX := False;
end;

function TSystem.GetCPUSpeed: Freq_Info;
var
  Cpu_Speed: Freq_Info;
  t0, t1: Int64;
  freq, freq2, freq3, Total: Cardinal;
  Total_Cycles, Cycles: Cardinal;
  Stamp0, Stamp1: Cardinal;
  Total_Ticks, Ticks: Cardinal;
  Count_Freq: Int64;
  Tries, IPriority, hThread: Integer;
begin
  freq  := 0;
  freq2 := 0;
  freq3 := 0;
  tries := 0;
  total_cycles := 0;
  total_ticks := 0;
  Total := 0;
  hThread := GetCurrentThread();
  if (not QueryPerformanceFrequency(count_freq)) then
    begin
      Result := cpu_speed;
    end
  else
    begin
      while ((tries < 3 ) or ((tries < 20) and ((abs(3 * freq - total) > 3) or
             (abs(3 * freq2-total) > 3) or (abs(3 * freq3-total) > 3)))) do
      begin
        inc(tries);
        freq3 := freq2;
        freq2 := freq;
        QueryPerformanceCounter(t0);
        t1 := t0;
        iPriority := GetThreadPriority(hThread);
        if ( iPriority <> THREAD_PRIORITY_ERROR_RETURN ) then
          begin
             SetThreadPriority(hThread, THREAD_PRIORITY_TIME_CRITICAL);
          end;
        while (( t1 - t0) < 50) do
        begin
           QueryPerformanceCounter(t1);
           asm
              push eax
              push edx
              db   0Fh        // Read Time
              db   31h        // Stamp Counter
              MOV stamp0, EAX
              pop  edx
              pop  eax
           end;
        end;
        t0 := t1;
        while ((t1 - t0) < 1000) do
        begin
          QueryPerformanceCounter(t1);
          asm
            push eax
            push edx
            db   0Fh // Read Time
            db   31h // Stamp Counter
            MOV stamp1, EAX
            pop  edx
            pop  eax
          end;
        end;
        if ( iPriority <> THREAD_PRIORITY_ERROR_RETURN ) then
        begin
          SetThreadPriority(hThread, iPriority);
        end;
        cycles := stamp1 - stamp0;
        ticks :=  t1 - t0;
        ticks := ticks * 100000;
        ticks := Round(Ticks / (count_freq/10));
        total_ticks := Total_Ticks + ticks;
        total_cycles := Total_Cycles + cycles;
        freq := Round(cycles / ticks);
        total := (freq + freq2 + freq3);
      end;
      freq3 := Round((total_cycles * 10) / total_ticks);
      freq2 := Round((total_cycles * 100) / total_ticks);
      if (freq2 - (freq3 * 10) >= 6) then
        inc(freq3);
      cpu_speed.raw_freq := Round(total_cycles / total_ticks);
      cpu_speed.norm_freq := cpu_speed.raw_freq;
      freq := cpu_speed.raw_freq * 10;
      if((freq3 - freq) >= 6) then
        inc(cpu_speed.norm_freq);
      cpu_speed.ex_ticks := total_ticks;
      cpu_speed.in_cycles := total_cycles;
      Result := cpu_speed;
    end;
end;

Function TSystem.CPUID: TCpuInfo;
type
    regconvert = record
          bits0_7: Byte;
          bits8_15: Byte;
          bits16_23: Byte;
          bits24_31: Byte;
    end;
var
   CPUInfo: TCpuInfo;
   TEBX, TEDX, TECX: Cardinal;
   TString: String;
   VString: String;
begin
     asm
        MOV  [CPUInfo.PType], 0
        MOV  [CPUInfo.Model], 0
        MOV  [CPUInfo.Stepping], 0
        MOV  [CPUInfo.Features], 0
        MOV  [CPUInfo.Frequency_Info.Raw_Freq], 0
        MOV  [CPUInfo.Frequency_Info.Norm_Freq], 0
        MOV  [CPUInfo.Frequency_Info.In_Cycles], 0
        MOV  [CPUInfo.Frequency_Info.Ex_Ticks], 0

        push eax
        push ebp
        push ebx
        push ecx
        push edi
        push edx
        push esi

     @@Check_80486:
        MOV  [CPUInfo.Family], 4
        MOV  TEBX, 0
        MOV  TEDX, 0
        MOV  TECX, 0
        PUSHFD
        POP  EAX
        MOV  ECX,  EAX
        XOR  EAX,  200000H
        PUSH EAX
        POPFD
        PUSHFD
        POP  EAX
        XOR  EAX,  ECX
        JE   @@DONE_CPU_TYPE

     @@Has_CPUID_Instruction:
        MOV  EAX,  0
        DB   0FH
        DB   0A2H

        MOV  TEBX, EBX
        MOV  TEDX, EDX
        MOV  TECX, ECX

        MOV  EAX,  1
        DB   0FH
        DB   0A2H

        MOV  [CPUInfo.Features], EDX

        MOV  ECX,  EAX

        AND  EAX,  3000H
        SHR  EAX,  12
        MOV  [CPUInfo.PType], AL

        MOV  EAX,  ECX

        AND  EAX,  0F00H
        SHR  EAX,  8
        MOV  [CPUInfo.Family], AL

        MOV  EAX,  ECX

        AND  EAX,  00F0H
        SHR  EAX,  4
        MOV  [CPUInfo.MODEL], AL

        MOV  EAX,  ECX

        AND  EAX,  000FH
        MOV  [CPUInfo.Stepping], AL

     @@DONE_CPU_TYPE:

        pop  esi
        pop  edx
        pop  edi
        pop  ecx
        pop  ebx
        pop  ebp
        pop  eax
     end;

     If (TEBX = 0) and (TEDX = 0) and (TECX = 0) and (CPUInfo.Family = 4) then
     begin
          CPUInfo.VendorIDString := 'Unknown';
          CPUInfo.Manufacturer := 'Unknown';
          CPUInfo.CPU_Name := 'Generic 486';
     end
     else
     begin
          With regconvert(TEBX) do
          begin
               TString := CHR(bits0_7) + CHR(bits8_15) + CHR(bits16_23) + CHR(bits24_31);
          end;
          With regconvert(TEDX) do
          begin
               TString := TString + CHR(bits0_7) + CHR(bits8_15) + CHR(bits16_23) + CHR(bits24_31);
          end;
          With regconvert(TECX) do
          begin
               TString := TString + CHR(bits0_7) + CHR(bits8_15) + CHR(bits16_23) + CHR(bits24_31);
          end;
          VString := TString;
          CPUInfo.VendorIDString := TString;
          If (CPUInfo.VendorIDString = 'GenuineIntel') then
          begin
               CPUInfo.Manufacturer := 'Intel';
               Case CPUInfo.Family of
               4: Case CPUInfo.Model of
                  1: CPUInfo.CPU_Name := 'Intel 486DX Processor';
                  2: CPUInfo.CPU_Name := 'Intel 486SX Processor';
                  3: CPUInfo.CPU_Name := 'Intel DX2 Processor';
                  4: CPUInfo.CPU_Name := 'Intel 486 Processor';
                  5: CPUInfo.CPU_Name := 'Intel SX2 Processor';
                  7: CPUInfo.CPU_Name := 'Write-Back Enhanced Intel DX2 Processor';
                  8: CPUInfo.CPU_Name := 'Intel DX4 Processor';
                  else CPUInfo.CPU_Name := 'Intel 486 Processor';
                  end;
               5: CPUInfo.CPU_Name := 'Pentium';
               6: Case CPUInfo.Model of
                  1: CPUInfo.CPU_Name := 'Pentium Pro';
                  3: CPUInfo.CPU_Name := 'Pentium II';
                  else CPUInfo.CPU_Name := Format('P6 (Model %d)', [CPUInfo.Model]);
                  end;
               else CPUInfo.CPU_Name := Format('P%d', [CPUInfo.Family]);
               end;
          end
          else if (CPUInfo.VendorIDString = 'CyrixInstead') then
          begin
                CPUInfo.Manufacturer := 'Cyrix';
                Case CPUInfo.Family of
                5: CPUInfo.CPU_Name := 'Cyrix 6x86';
                6: CPUInfo.CPU_Name := 'Cyrix M2';
                else CPUInfo.CPU_Name := Format('%dx86', [CPUInfo.Family]);
                end;
          end
          else if (CPUInfo.VendorIDString = 'AuthenticAMD') then
          begin
               CPUInfo.Manufacturer := 'AMD';
               Case CPUInfo.Family of
               4: CPUInfo.CPU_Name := 'Am486 or Am5x86';
               5: Case CPUInfo.Model of
                  0: CPUInfo.CPU_Name := 'AMD-K5 (Model 0)';
                  1: CPUInfo.CPU_Name := 'AMD-K5 (Model 1)';
                  2: CPUInfo.CPU_Name := 'AMD-K5 (Model 2)';
                  3: CPUInfo.CPU_Name := 'AMD-K5 (Model 3)';
                  6: CPUInfo.CPU_Name := 'AMD-K6';
                  else CPUInfo.CPU_Name := 'Unknown AMD Model';
                  end;
               else CPUInfo.CPU_Name := 'Unknown AMD Chip';
               end;
          end
          else
          begin
               CPUInfo.VendorIDString := TString;
               CPUInfo.Manufacturer := 'Unknown';
               CPUInfo.CPU_Name := 'Unknown';
          end;
     end;
     Result := CPUInfo;
end;

Function TSystem.TestFDIVInstruction: Boolean;
var
   TopNum:    Double;
   BottomNum: Double;
   One:       Double;
   ISOK:      Boolean;
begin
     { The following code was found in Borlands
       fdiv.asm file in the Delphi 3\Source\RTL\SYS
       directory, ( I made some minor modifications )
       therefor I cannot take credit for it }

     TopNum     := 2658955;
     BottomNum  := PI;
     One        := 1;

     asm
        PUSH    EAX
        FLD     [TopNum]
        FDIV    [BottomNum]
        FMUL    [BottomNum]
        FSUBR   [TopNum]
        FCOMP   [One]
        FSTSW   AX
        SHR     EAX, 8
        AND     EAX, 01H
        MOV     ISOK, AL
        POP     EAX
     end;
     Result := ISOK;
end;

procedure TSystem.Appmessage(var MSG:tmsg;var handled:boolean);
var
   i:integer;
   anzahl:word;
   Pfilename:Pchar;
begin
     if msg.message=WM_DROPFILES then begin
     PFilename:=stralloc(255);
     FFILES.clear;
     anzahl:=DRagQueryFile(MSG.Wparam,$FFFFFFFF,PFilename,255);
     for i:=0 to (anzahl-1) do begin
         DragQueryFile(MSG.WPARAM,i,Pfilename,255);
         FFiles.add(STRPAS(PFilename));
     end;
     DragFinish(Msg.wparam);
     handled:=true;
     if assigned(Fondragdrop) then Fondragdrop(FFiles);
     strdispose(pFilename);
end;
end;

function tsystem.gettotalphysmemory:longint;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     gettotalphysmemory:=memory.dwtotalphys;
end;

function tsystem.getavailphysmemory:longint;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     getavailphysmemory:=memory.dwavailphys;
end;

function tsystem.gettotalpagefile:longint;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     gettotalpagefile:=memory.dwtotalpagefile;
end;

function tsystem.getavailpagefile:longint;
var
memory:TMEMORYSTATUS;
begin
     globalmemorystatus(memory);
     getavailpagefile:=memory.dwavailpagefile;
end;
function tsystem.getwindowsdirectory:string;
var
p:Pchar;
begin
     p:=stralloc(MAX_PATH+1);
     windows.getwindowsdirectory(p,max_path+1);
     getwindowsdirectory:=p;
     strdispose(p);
end;


function tsystem.getsystemdirectory:string;
var
p:Pchar;
begin
     p:=stralloc(MAX_PATH+1);
     windows.getsystemdirectory(p,max_path+1);
     getsystemdirectory:=p;
     strdispose(p);
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

function tsystem.getprocessortype:string;
var
   systeminfo:tsysteminfo;
   zw:string;
begin
     getsysteminfo(systeminfo);
     case systeminfo.dwprocessortype of
          386:zw:='Intel 80386';
          486:zw:='Intel 80486';
          586:zw:='Intel Pentium';
          860:zw:='Intel 860';
          2000:zw:='MIPS R2000';
          3000:zw:='MIPS R3000';
          4000:zw:='MIPS R4000';
         21064:zw:='ALPHA 21064';
     else ZW:='Processor nicht klassifiziert';
     end;

     result:=zw;
end;

function tsystem.getprocessorcount:integer;
var
systeminfo:tsysteminfo;
begin
     getsysteminfo(systeminfo);
     result:=systeminfo.dwnumberofprocessors;
end;

function tsystem.getsystem:tBetriebssystem;
var
os:TOSVERSIONINFO;
begin
     os.dwosversioninfosize:=sizeof(os);
     getversionex(os);
     case os.dwplatformid of
     VER_PLATFORM_WIN32s:result:=bswin32;
     ver_PLATFORM_WIN32_Windows:result:=bswin95;
     VER_PLATFORM_Win32_nt:result:=bswinNT;
     else result:=bswin95;
     end;
end;

procedure TSystem.shutdown;
begin
exitwindowsex(EWX_SHUTDOWN,0);
end;

procedure TSystem.reboot;
begin
exitwindowsex(EWX_REBOOT,0);
end;

procedure TSystem.logoff;
begin
exitwindows(0,0)
end;

function TSystem.sound: boolean;
begin
     result:=waveoutgetnumdevs>0;
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
i,typ:integer;
s:string;
begin
if diskindrive(lw,false) then begin
s:=lw+':\';
typ:=getdrivetype(Pchar(s));
if typ <>0 then
   case typ of
   DRIVE_REMOVABLE:result:='Diskette';
   DRIVE_FIXED:result:='Festplatte';
   DRIVE_CDROM:result:='CDROM';
   DRIVE_RAMDISK:result:='RAMDisk';
   DRIVE_REMOTE:result:='Netzlaufwerk';
   else result:='Laufwerktyp unbekannt';
   end;
end;
end;

function TSystem.diskserialnumber(lw: char): integer;
var
root:string;
volumenamebuffer,filesystemnamebuffer:pchar;
filesystemflags,maximumcomponentlength:Dword;
sectorspercluster,bytespersector,numberoffreeclusters,totalnumberofclusters:dword;
volumeserialnumber:pdword;
begin
if diskindrive(lw,false)then begin
root:=lw+':\';
volumenamebuffer:=stralloc(256);
filesystemnamebuffer:=stralloc(256);
getvolumeinformation(pchar(root),volumenamebuffer,255,volumeserialnumber,maximumcomponentlength,filesystemflags,filesystemnamebuffer,255);
result:=dword(volumeserialnumber);
strdispose(volumenamebuffer);
strdispose(filesystemnamebuffer);
end;

end;

function TSystem.diskfilesystem(lw: char): string;
var
root:string;
volumenamebuffer,filesystemnamebuffer:pchar;
filesystemflags,maximumcomponentlength:Dword;
sectorspercluster,bytespersector,numberoffreeclusters,totalnumberofclusters:dword;
volumeserialnumber:pdword;
begin
if diskindrive(lw,false)then begin
root:=lw+':\';
volumenamebuffer:=stralloc(256);
filesystemnamebuffer:=stralloc(256);
getvolumeinformation(pchar(root),volumenamebuffer,255,volumeserialnumber,maximumcomponentlength,filesystemflags,filesystemnamebuffer,255);
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
sectorspercluster,bytespersector,numberoffreeclusters,totalnumberofclusters:dword;
volumeserialnumber:pdword;
begin
if diskindrive(lw,false)then begin
root:=lw+':\';
volumenamebuffer:=stralloc(256);
filesystemnamebuffer:=stralloc(256);
getvolumeinformation(pchar(root),volumenamebuffer,255,volumeserialnumber,maximumcomponentlength,filesystemflags,filesystemnamebuffer,255);
result:=maximumcomponentlength;  
strdispose(volumenamebuffer);
strdispose(filesystemnamebuffer);
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

function TSystem.setComputername(name: string): boolean;
begin
     result:=windows.SetComputerName(pchar(name));

end;

end.
