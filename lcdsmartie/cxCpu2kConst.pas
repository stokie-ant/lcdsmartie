{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kConst.pas,                                         }
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
unit cxcpu2kConst;

interface

uses Windows;

const
  { Error flags }
  ERR_NOERROR = 0;
  ERR_CPUIDNOTSUPPORTED = (-1);
  ERR_EXECUTIONLEVELNOTSUPPORTED = (-2);
  ERR_BADINFOSTRUCTURE = (-3);

  { Return value identifiers }
  VAL_NOVALUE = 0;

  { CPUID EFLAGS Id bit }
  CPUIDID_BIT	=	$200000;

  { Default Benchmark delay }
  BENCHMARK_DELAY = 500;

  { Processor flags (temporary - for future SMP support) }
  USE_DEFAULT = 0;

  { CPUID execution levels }
  CPUID_MAXLEVEL        : DWORD = $0;
  CPUID_VENDORSIGNATURE : DWORD = $0;
  CPUID_CPUSIGNATURE    : DWORD = $1;
  CPUID_CPUFEATURESET   : DWORD = $1;
  CPUID_CACHETLB        : DWORD = $2;
  CPUID_CPUSERIALNUMBER : DWORD = $3;
  CPUID_MAXLEVELEX      : DWORD = $80000000;
  CPUID_CPUSIGNATUREEX  : DWORD = $80000001;
  CPUID_CPUMARKETNAME1  : DWORD = $80000002;
  CPUID_CPUMARKETNAME2  : DWORD = $80000003;
  CPUID_CPUMARKETNAME3  : DWORD = $80000004;
  CPUID_LEVEL1CACHETLB  : DWORD = $80000005;
  CPUID_LEVEL2CACHETLB  : DWORD = $80000006;

  { CPUID result indexes }
  EAX = 1;
  EBX = 2;
  ECX = 3;
  EDX = 4;

  { Standard feature set flags }
  SFS_FPU     = 0;
  SFS_VME     = 1;
  SFS_DE      = 2;
  SFS_PSE     = 3;
  SFS_TSC     = 4;
  SFS_MSR     = 5;
  SFS_PAE     = 6;
  SFS_MCE     = 7;
  SFS_CX8     = 8;
  SFS_APIC    = 9;
  SFS_SEP     = 11;
  SFS_MTRR    = 12;
  SFS_PGE     = 13;
  SFS_MCA     = 14;
  SFS_CMOV    = 15;
  SFS_PAT     = 16;
  SFS_PSE36   = 17;
  SFS_SERIAL  = 18;
  SFS_CLFLUSH = 19;
  SFS_DTS     = 21;
  SFS_ACPI    = 22;
  SFS_MMX     = 23;
  SFS_XSR     = 24;
  SFS_SIMD    = 25;
  SFS_SIMD2   = 26;
  SFS_SS      = 27;
  SFS_TM      = 29;


  { Extended feature set flags (duplicates removed) }
  EFS_EXMMXA  = 22; { AMD Specific }
  EFS_EXMMXC  = 24; { Cyrix Specific }
  EFS_3DNOW   = 31;
  EFS_EX3DNOW = 30;

  { Processor family values }
  CPU_486CLASS        = 4;
  CPU_PENTIUMCLASS    = 5;
  CPU_PENTIUMIICLASS  = 6;
  CPU_PENTIUMIVCLASS  = 15;

  { Pentium III-specific model }
  CPU_PENTIUMIIIMODEL = 7;

  { Processor type values }
  CPU_OVERDRIVE       = 1;

  { Extended Cache Levels }
  CACHE_LEVEL1        = 0;
  CACHE_LEVEL2        = 1;

  { Brand ID Identifiers }
  BRAND_UNSUPPORTED    = 0;
  BRAND_CELERON        = 1;
  BRAND_PENTIUMIII     = 2;
  BRAND_PENTIUMIIIXEON = 3;
  BRAND_PENTIUMIV      = 8;

  { Extended Model & Family Indicator }
  EXTENDED_FIELDS      = $f;

  { Normalised processor speeds }
  MAX_SPEEDS = 47;
  CPUSPEEDS: array[0..MAX_SPEEDS - 1] of Integer = (
              25,  33,  60,  66,  75,  82,  90,  100, 110, 116, 120, 133, 150, 166, 180,
              188, 200, 225, 233, 266, 300, 333, 350, 366, 400, 415, 433, 450, 466, 500,
              533, 550, 600, 650, 667, 700, 733, 750, 800, 833, 850, 866, 900, 933, 950,
              966, 1000);

  { Speeds below this value use the CPUSPEEDS_LO array, above uses CPUSPEEDS_HI }
  SPEED_LO_THRESHOLD = 300;

  { Possible normalised unit values for speeds < SPEED_LO_THRESHOLD }
  MAX_SPEEDS_LO = 15;
  CPUSPEEDS_LO: array[0..MAX_SPEEDS_LO - 1] of Integer = (
                 0, 10, 16, 20, 25, 33, 40, 50, 60, 66, 75, 80, 82, 88, 90);

  { Possible normalised unit values for speeds >= SPEED_LO_THRESHOLD }
  MAX_SPEEDS_HI = 5;
  CPUSPEEDS_HI: array[0..MAX_SPEEDS_HI - 1] of Integer = (0, 33, 50, 66, 100);

type
  TCPUIDResult = packed record
    EAX: Cardinal;
    EBX: Cardinal;
    ECX: Cardinal;
    EDX: Cardinal;
  end;

  TCacheDescriptors = array[1..16] of LongInt;

  TProcessorInfo = packed record
    dwSize:       DWORD;
    iProcessor:   Byte;
    lpName:       String;
    lpFullName:   String;
    lpSerial:     String;
    lpVendor:     String;
  end;

  TProcessorSpeedInfo = packed record
    dwSize:       DWORD;
    iProcessor:   Byte;
    iDelay:       LongInt;
    sRaw:         Single;
    iNormalised:  LongInt;
  end;

  TCacheInfo = packed record
    dwSize:       DWORD;
    iProcessor:   Byte;
    iLevel1Code:  LongInt;
    iLevel1Data:  LongInt;
    iLevel1:      LongInt;
    iLevel2:      LongInt;
  end;

  TCPUIDInfo = packed record
    dwSize:       DWORD;
    iProcessor:   Byte;
    bAvailable:   Boolean;
    iMaxLevel:    LongInt;
    iMaxExLevel:  LongInt;
  end;

  TFeatureSetInfo = packed record
    dwSize:       DWORD;
    iProcessor:   Byte;
    bFPU:         Boolean;
    bVME:         Boolean;
    bDE:          Boolean;
    bPSE:         Boolean;
    bTSC:         Boolean;
    bMSR:         Boolean;
    bPAE:         Boolean;
    bMCE:         Boolean;
    bCX8:         Boolean;
    bAPIC:        Boolean;
    bSEP:         Boolean;
    bMTRR:        Boolean;
    bPGE:         Boolean;
    bMCA:         Boolean;
    bCMOV:        Boolean;
    bPAT:         Boolean;
    bPSE36:       Boolean;
    bSERIAL:      Boolean;
    bMMX:         Boolean;
    bXSR:         Boolean;
    bSIMD:        Boolean;
    bEXMMX:       Boolean;
    b3DNOW:       Boolean;
    bEX3DNOW:     Boolean;
    bCLFLUSH:     Boolean;
    bDTS:         Boolean;
    bACPI:        Boolean;
    bSIMD2:       Boolean;
    bSS:          Boolean;
    bTM:          Boolean;
  end;

  TSignatureInfo = packed record
    dwSize:       DWORD;
    iProcessor:   Byte;
    iSignature:   LongInt;
    iType:        LongInt;
    iFamily:      LongInt;
    iFamilyEx:    LongInt;
    iModel:       LongInt;
    iModelEx:     LongInt;
    iStepping:    LongInt;
    iBrand:       LongInt;
  end;

  TcxVersionInfo = packed record
    dwSize:       DWORD;
    APIMajor:     LongInt;
    APIMinor:     LongInt;
    IntMajor:    LongInt;
    IntMinor:    LongInt;
  end;

implementation

end.
