{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kDefault.pas                                        }
{ Part of the CarbonSoft Processor Detection Toolkit release 3.0                 }
{                                                                                }
{ The Initial Developer of the Original Code is Kev French (kev@carbonsoft.com)  }
{ Portions created by Kev French are                                             }
{ Copyright (C) 1995-2001 Kev French, CarbonSoft. All Rights Reserved.           }
{                                                                                }
{ Contributor(s):                                                                }
{   <real name>       <email address>                                            }
{                                                                                }
{                                                                                }
{********************************************************************************}
unit cxcpu2kDefault;

interface

uses Windows, SysUtils, cxCpu2kConst;

  function GetSignature: String;
  function GetVendorPrefix: String;
  function GetVendorName: String;
  function GetCPUName: String;
  function GetCPUSpeed(ADelay: DWORD): Single;

implementation

uses cxCpu2kIntf;

  function GetSignature: String;
  begin
    Result := 'Unknown';
  end;

  function GetVendorPrefix: String;
  begin
    Result := 'Unknown ';
  end;

  function GetVendorName: String;
  begin
    Result := 'Unknown Vendor';
  end;

  function GetCPUName: String;
  var
    lpSysInfo: TSYSTEMINFO;
  begin
    GetSystemInfo(lpSysInfo);
    case lpSysInfo.dwProcessorType of
      386: Result := '386 class';
      486: Result := '486 class';
      586: Result := 'Pentium class';
      686: Result := 'Pentium II class';
    else
      Result := IntToStr(lpSysInfo.dwProcessorType) + ' class';
    end;
  end;

  function GetCPUSpeed(ADelay: DWORD): Single;
  var
    t: DWORD;
    mhi, mlo, nhi, nlo: LongInt;
    t0, t1, chi, clo, shr32: Comp;
    PriorityClass, Priority: Integer;
begin
    { This routine depends on the RTDSC instruction }
    if (cxGetStdFeatureSupportEx(USE_DEFAULT, SFS_TSC)) then begin
      shr32 := 65536;
      shr32 := shr32 * 65536;

      PriorityClass := GetPriorityClass(GetCurrentProcess);
      Priority := GetThreadPriority(GetCurrentThread);
      SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
      SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

      t := GetTickCount;
      while (t = GetTickCount) do begin end;
      asm
        DB 	  0FH
        DB 	  031H
        mov   mhi, EDX
        mov   mlo, EAX
      end;

      while (GetTickCount < (t + ADelay)) do begin end;
      asm
        DB 	  0FH
        DB 	  031H
        mov   nhi, EDX
        mov   nlo, EAX
      end;

      SetThreadPriority(GetCurrentThread, Priority);
      SetPriorityClass(GetCurrentProcess, PriorityClass);

      chi := mhi; if (mhi < 0) then chi := chi + shr32;
      clo := mlo; if (mlo < 0) then clo := clo + shr32;

      t0 := chi * shr32 + clo;

      chi := nhi; if (nhi < 0) then chi := chi + shr32;
      clo := nlo; if (nlo < 0) then clo := clo + shr32;

      t1 := chi * shr32 + clo;

      Result := ((t1 - t0) / (1E6 / (1000/ADelay)));


    end else
      Result := ERR_CPUIDNOTSUPPORTED;
  end;

end.

