{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kIntel.pas,                                         }
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
unit cxcpu2kIntel;

interface

uses cxCpu2kConst, cxCpu2kDefault;

const
  CELERON_LIMIT = 128;
  XEON_LIMIT    = 1024;

  function GetSignature: String;
  function GetVendorPrefix: String;
  function GetVendorName: String;
  function GetCPUName(AProcessor: Byte): String;
  function GetCPUSpeed(ADelay: LongInt): Single;

implementation

uses cxCpu2kIntf;

  function GetSignature: String;
  begin
    Result := 'GenuineIntel';
  end;

  function GetVendorPrefix: String;
  begin
    Result := 'Intel ';
  end;

  function GetVendorName: String;
  begin
    Result := 'Intel Corporation';
  end;

  function GetCPUName(AProcessor: Byte): String;
  var
    cpuFamily: LongInt;
    cpuModel: LongInt;
    cpuBrand: LongInt;
    L2Cache: LongInt;
  begin
    cpuFamily := cxGetProcessorFamily(AProcessor);
    cpuModel := cxGetProcessorModel(AProcessor);
    cpuBrand := cxGetProcessorBrand(AProcessor);

    if (cpuFamily = CPU_486CLASS) then
      case cpuModel of
        4: Result := '80486SL';
        7: Result := '80486DX2';
        8: Result := '80486DX4';
      else
        Result := '486 class';
      end;

    if (cpuFamily = CPU_PENTIUMCLASS) then
      case cpuModel of
        0, 1: Result := 'Pentium (P5)';
        2, 7: Result := 'Pentium (P54C)';
        3: Result := 'Pentium 486 OverDrive';
        4: Result := 'Pentium MMX';
      else
        Result := 'Pentium class';
      end;

    if (cpuFamily = CPU_PENTIUMIICLASS) then begin
      { Require L2 cache value to differentiate Intel processors }
      L2Cache := cxGetLevel2UnifiedCache(AProcessor);

      case cpuModel of
        0, 1: Result := 'Pentium Pro';
        3:    if (cxGetOverdriveFlag(AProcessor)) then
                Result := 'Pentium II Overdrive'
              else
                Result := 'Pentium II (Model 3)';
        5:    if (L2Cache < CELERON_LIMIT) then
                Result := 'Celeron (Model 5)'
              else
                if (L2Cache < XEON_LIMIT) then
                  Result := 'Pentium II (Model 5)'
                else
                  Result := 'Pentium II Xeon';
        6:    if (L2Cache <= CELERON_LIMIT) then begin
                if (cxGetStdFeatureSupportEx(USE_DEFAULT, SFS_SERIAL)) then
                  Result := 'Mobile Celeron'
                else
                  Result := 'Celeron';
              end else
                Result := 'Mobile Pentium II';
        7, 8: if (cpuBrand = BRAND_UNSUPPORTED) then begin
                if (L2Cache < XEON_LIMIT) then
                  Result := 'Pentium III'
                else
                  Result := 'Pentium III Xeon';
              end else begin
                case cpuBrand of
                  { 12-12-00:KevF: Replaced numerics with constants }
                  BRAND_CELERON: Result := 'Celeron';
                  BRAND_PENTIUMIII: Result := 'Pentium III';
                  BRAND_PENTIUMIIIXEON: Result := 'Pentium III Xeon';
                  { Not sure if this should really be here }
                  BRAND_PENTIUMIV: Result := 'Pentium 4';
                else
                  Result := 'Pentium III class';
                end;
              end;
        $A:   Result := 'Pentium III Xeon';
      else
        Result := 'Pentium II/III class';
      end;
    end;

    { 12-12-00:KevF: Added P4 class }
    if (cpuFamily = CPU_PENTIUMIVCLASS) then begin
      case cpuModel of
        0: Result := 'Pentium 4';
      else
        Result := 'Pentium 4 class';
      end;
    end;
  end;

  function GetCPUSpeed(ADelay:LongInt): Single;
  begin
    if (cxGetStdFeatureSupportEx(USE_DEFAULT, SFS_TSC)) then
      Result := cxCpu2kDefault.GetCPUSpeed(ADelay)
    else
      Result := (-1);
  end;

end.

