{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kAMD.pas,                                           }
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
unit cxcpu2kAMD;

interface

uses Controls, StdCtrls, ExtCtrls, Spin, Classes, Windows, Messages, SysUtils, Graphics, Forms, Dialogs, 
  ComCtrls, Buttons,
  cxCpu2kConst, cxCpu2kDefault;

  function GetSignature: String;
  function GetVendorPrefix: String;
  function GetVendorName: String;
  function GetCPUName(AProcessor: Byte): String;
  function GetCPUSpeed(ADelay: LongInt): Single;

implementation

uses cxCpu2kIntf,unit1;

  function GetSignature: String;
  begin
    Result := 'AuthenticAMD';
  end;

  function GetVendorPrefix: String;
  begin
    Result := 'AMD ';
  end;

  function GetVendorName: String;
  begin
    Result := 'Advanced Micro Devices';
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
        3, 7, 8, 9: Result := 'Am486';
        14, 15: Result := 'Am5x86';
      else
        Result := '486 class';
      end;

    if (cpuFamily = CPU_PENTIUMCLASS) then
      case cpuModel of
        0: Result := 'K5 (Model 0)';
        1: Result := 'K5 (Model 1)';
        2: Result := 'K5 (Model 2)';
        3: Result := 'K5 (Model 3)';
        6: Result := 'K6 (Model 6)';
        7: Result := 'K6 (Model 7)';
        8: Result := 'K6-2';
        9: Result := 'K6-III';
        $D: Result := 'K6-2+/K6-III+';
      else
        Result := 'Pentium class';
      end;

    if (cpuFamily = CPU_PENTIUMIICLASS) then
      case cpuModel of
        1, 2, 4: Result := 'Athlon';
        3: Result := 'Duron';
        5, 6, 7, 8: Result := 'XP';
      else
        Result := 'Athlon class';
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


