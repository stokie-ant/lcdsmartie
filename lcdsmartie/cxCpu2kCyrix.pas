{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kCyrix.pas,                                         }
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
unit cxCpu2kCyrix;

interface

uses cxCpu2kConst, cxCpu2kDefault;

  function GetSignature: String;
  function GetVendorPrefix: String;
  function GetVendorName: String;
  function GetCPUName(AProcessor: Byte): String;
  function GetCPUSpeed(ADelay: LongInt): Single;

implementation

uses cxCpu2kIntf;

  function GetSignature: String;
  begin
    Result := 'CyrixInstead';
  end;

  function GetVendorPrefix: String;
  begin
    Result := 'Cyrix ';
  end;

  function GetVendorName: String;
  begin
    Result := 'Cyrix Corporation';
  end;

  function GetCPUName(AProcessor: Byte): String;
  var
    cpuFamily,
    cpuModel: LongInt;
  begin
    cpuFamily := cxGetProcessorFamily(AProcessor);
    cpuModel := cxGetProcessorModel(AProcessor);

    if (cpuFamily = CPU_486CLASS) then
      case cpuModel of
        4: Result := 'Media GX';
        9: Result := 'Cx5x86';
      else
        Result := '486 class';
      end;

    if (cpuFamily = CPU_PENTIUMCLASS) then
      case cpuModel of
        2: Result := '6x86';
        4: Result := 'GXm'
      else
        Result := 'Pentium class';
      end;

    if (cpuFamily = CPU_PENTIUMIICLASS) then
      case cpuModel of
        0: Result := '6x86MX';
        5: Result := 'VIA Cyrix III';
      else
        Result := 'M2 Class';
      end;
  end;

  function GetCPUSpeed(ADelay: LongInt): Single;
  begin
    if (cxGetStdFeatureSupportEx(USE_DEFAULT, SFS_TSC)) then
      Result := cxCpu2kDefault.GetCPUSpeed(ADelay)
    else
      Result := (-1);
  end;

end.
