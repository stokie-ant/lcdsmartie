{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kUMC.pas,                                           }
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
unit cxCpu2kUMC;

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
    Result := 'UMC UMC UMC ';
  end;

  function GetVendorPrefix: String;
  begin
    Result := 'UMC ';
  end;

  function GetVendorName: String;
  begin
    Result := 'United Microelectronics Corp';
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
        1: Result := 'U5D';
        2: Result := 'U5S';
      else
        Result := 'Pentium class';
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
