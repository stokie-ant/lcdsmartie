{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kIntf.pas,                                          }
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
unit cxCpu2kIntf;

interface

uses cxCpu2kConst, cxCpu2kAPI, cxCpu2kDefault, cxCpu2kIntel, cxCpu2kAMD,
  cxCpu2kCyrix, cxCpu2kIDT, cxCpu2kNexGen, cxCpu2kUMC, cxCpu2kRise;

const
  { Internal version information }
  PRODUCT_NAME = 'CarbonSoft Processor Detection API Interface';
  PRODUCT_VERSION = 1;
  PRODUCT_BUILD = 9;
  PRODUCT_COPYRIGHT = 'Copyright © 2000 CarbonSoft';

  { Vendor constants (used internally) }
  VENDOR_NOVENDOR   = (-1);
  VENDOR_UNKNOWN    = 0;
  VENDOR_INTEL      = 1;
  VENDOR_AMD        = 2;
  VENDOR_CYRIX      = 3;
  VENDOR_IDT        = 4;
  VENDOR_NEXGEN     = 5;
  VENDOR_UMC        = 6;
  VENDOR_RISE       = 7;

  { Internal functions (not for export) }
  function dneGetVendor(AProcessor: Byte): LongInt;

  { Information functions }
  function cxGetProcessorInfo(var AProcessorInfo: TProcessorInfo): LongInt;
  function cxGetSpeedInfo(var AProcessorSpeedInfo: TProcessorSpeedInfo): LongInt;
  function cxGetCacheInfo(var ACacheInfo: TCacheInfo): LongInt;
  function cxGetCPUIDInfo(var ACPUIDInfo: TCPUIDInfo): LongInt;
  function cxGetFeatureSetInfo(var AFeatureSetInfo: TFeatureSetInfo): LongInt;
  function cxGetSignatureInfo(var ASignatureInfo: TSignatureInfo): LongInt;
  function cxGetVersionInfo(var AVersionInfo: TcxVersionInfo): LongInt;

  { Exposed API function - wrapped for isolation }
  { CPUID functions }
  function cxGetCPUIDSupport(AProcessor: Byte): Boolean;
  function cxGetMaxStdCPUIDLevel(AProcessor: Byte): LongInt;
  function cxGetMaxExtCPUIDLevel(AProcessor: Byte): LongInt;
  function cxExecuteCPUID(AProcessor: Byte;
                          AExecutionLevel: Cardinal;
                          AIterations: Byte;
                          var AResult: TCPUIDResult): Boolean;

  { Signature functions }
  function cxGetProcessorSignature(AProcessor: Byte): LongInt;
  function cxGetProcessorType(AProcessor: Byte): LongInt;
  function cxGetProcessorFamily(AProcessor: Byte): LongInt;
  function cxGetProcessorExFamily(AProcessor: Byte): LongInt;
  function cxGetProcessorModel(AProcessor: Byte): LongInt;
  function cxGetProcessorExModel(AProcessor: Byte): LongInt;
  function cxGetProcessorStepping(AProcessor: Byte): LongInt;
  function cxGetProcessorBrand(AProcessor: Byte): LongInt;

  { Processor functions }
  function cxGetProcessorCount: Byte;
  function cxGetProcessorName(AProcessor: Byte): String;
  function cxGetProcessorFullName(AProcessor: Byte): String;
  function cxGetVendorName(AProcessor: Byte): String;
  function cxGetVendorIdentification(AProcessor: Byte): String;

  { Benchmark functions }
  function cxGetRawProcessorSpeed(AProcessor: Byte; ADelay: LongInt): Single;
  function cxGetNormalisedProcessorSpeed(AProcessor: Byte; ADelay: LongInt): LongInt;
  function cxGetRawProcessorSpeedEx(AProcessor: Byte): Single;
  function cxGetNormalisedProcessorSpeedEx(AProcessor: Byte): LongInt;

  { Misc functions }
  function cxGetOverdriveFlag(AProcessor: Byte): Boolean;
  function cxGetFDivBugPresent(AProcessor: Byte): Boolean;

  { Feature set functions }
  function cxGetStdFeatureSet(AProcessor: Byte): LongInt;
  function cxGetExtFeatureSet(AProcessor: Byte): LongInt;
  function cxGetStdFeatureSupport(AFeatureSet: LongInt; ABit: Byte): Boolean;
  function cxGetStdFeatureSupportEx(AProcessor: Byte; ABit: Byte): Boolean;
  function cxGetExtFeatureSupport(AFeatureSet: LongInt; ABit: Byte): Boolean;
  function cxGetExtFeatureSupportEx(AProcessor: Byte; ABit: Byte): Boolean;

  { Feature set shortcut functions }
  function cxGetMMXSupport(AProcessor: Byte): Boolean;
  function cxGetExtMMXSupport(AProcessor: Byte): Boolean;
  function cxGetSIMDSUpport(AProcessor: Byte): Boolean;
  function cxGet3DNowSupport(AProcessor: Byte): Boolean;
  function cxGetExt3DNowSupport(AProcessor: Byte): Boolean;

  { Advanced information functions }
  function cxGetSerialNumber(AProcessor: Byte): String;
  function cxGetMarketingName(AProcessor: Byte): String;

  { Cache functions }
  function cxGetLevel1DataCache(AProcessor: Byte): LongInt;
  function cxGetLevel1CodeCache(AProcessor: Byte): LongInt;
  function cxGetLevel1UnifiedCache(AProcessor: Byte): LongInt;
  function cxGetLevel2UnifiedCache(AProcessor: Byte): LongInt;

  { Version functions }
  function cxGetAPIVersionMajor: LongInt;
  function cxGetAPIVersionMinor: LongInt;
  function cxGetIntfVersionMajor: LongInt;
  function cxGetIntfVersionMinor: LongInt;

implementation

function dneGetVendor(AProcessor: Byte): LongInt;
{ INTERNAL: Returns a numberic value indicating the processor vendor }
var
  sVendor: String;
begin
  sVendor := GetVendorIDString;
  if (sVendor = cxCpu2kIntel.GetSignature) then
    Result := VENDOR_INTEL
  else
    if (sVendor = cxCpu2kAMD.GetSignature) then
      Result := VENDOR_AMD
    else
      if (sVendor = cxCpu2kCyrix.GetSignature) then
        Result := VENDOR_CYRIX
      else
        if (sVendor = cxCpu2kIDT.GetSignature) then
          Result := VENDOR_IDT
        else
          if (sVendor = cxCpu2kNexGen.GetSignature) then
            Result := VENDOR_NEXGEN
          else
            if (sVendor = cxCpu2kUMC.GetSignature) then
              Result := VENDOR_UMC
            else
              if (sVendor = cxCpu2kRise.GetSignature) then
                Result := VENDOR_RISE
              else
                Result := VENDOR_UNKNOWN;
end;  //------------

function cxGetProcessorInfo(var AProcessorInfo: TProcessorInfo): LongInt;
{ Fills the AProcessorInfo structure with the relevent information }
begin
  if (AProcessorInfo.dwSize <> SizeOf(TProcessorInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  AProcessorInfo.lpName := cxGetProcessorName(AProcessorInfo.iProcessor);
  AprocessorInfo.lpFullName := cxGetProcessorFullName(AProcessorInfo.iProcessor);
  AProcessorInfo.lpSerial := cxGetSerialNumber(AProcessorInfo.iProcessor);
  AProcessorInfo.lpVendor := cxGetVendorName(AProcessorInfo.iProcessor);

  Result := ERR_NOERROR;
end;  //------------

function cxGetSpeedInfo(var AProcessorSpeedInfo: TProcessorSpeedInfo): LongInt;
{ Fills the AProcessorSpeedInfo structure with the relevent information }
begin
  if (AProcessorSpeedInfo.dwSize <> SizeOf(TProcessorSpeedInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  if (AProcessorSpeedInfo.iDelay = USE_DEFAULT) then
    AProcessorSpeedInfo.sRaw := cxGetRawProcessorSpeedEx(USE_DEFAULT)
  else
    AProcessorSpeedInfo.sRaw := cxGetRawProcessorSpeed(USE_DEFAULT, AProcessorSpeedInfo.iDelay);
  AProcessorSpeedInfo.iNormalised := GetNormalisedCPUSpeed(AProcessorSpeedInfo.sRaw);

  Result := ERR_NOERROR;
end;  //------------

function cxGetCacheInfo(var ACacheInfo: TCacheInfo): LongInt;
{ Fills the ACacheInfo structure with the relevent information }
begin
  if (ACacheInfo.dwSize <> SizeOf(TCacheInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  ACacheInfo.iLevel1Code := cxGetLevel1CodeCache(ACacheInfo.iProcessor);
  ACacheInfo.iLevel1Data := cxGetLevel1DataCache(ACacheInfo.iProcessor);
  ACacheInfo.iLevel1 := cxGetLevel1UnifiedCache(ACacheInfo.iProcessor);
  ACacheInfo.iLevel2 := cxGetLevel2UnifiedCache(ACacheInfo.iProcessor);

  Result := ERR_NOERROR;
end;  //------------

function cxGetCPUIDInfo(var ACPUIDInfo: TCPUIDInfo): LongInt;
{ Fills the ACPUIDInfo structure with the relevent information }
begin
  if (ACPUIDInfo.dwSize <> SizeOf(TCPUIDInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  ACPUIDInfo.bAvailable := cxGetCPUIDSupport(ACPUIDInfo.iProcessor);
  ACPUIDInfo.iMaxLevel := cxGetMaxStdCPUIDLevel(ACPUIDInfo.iProcessor);
  ACPUIDInfo.iMaxExLevel := cxGetMaxExtCPUIDLevel(ACPUIDInfo.iProcessor);

  Result := ERR_NOERROR;
end;  //------------

function cxGetFeatureSetInfo(var AFeatureSetInfo: TFeatureSetInfo): LongInt;
{ Fills the AFeatureSet structure with the relevent info }
var
  StdFeatureSet: LongInt;
  ExtFeatureSet: LongInt;
  iVendor: LongInt;
begin
  if (AFeatureSetInfo.dwSize <> SizeOf(TFeatureSetInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  StdFeatureSet := cxGetStdFeatureSet(AFeatureSetInfo.iProcessor);
  ExtFeatureSet := cxGetExtFeatureSet(AFeatureSetInfo.iProcessor);
  iVendor := dneGetVendor(AFeatureSetInfo.iProcessor);

  with AFeatureSetInfo do begin
    bFPU := cxGetStdFeatureSupport(StdFeatureSet, SFS_FPU);
    bVME := cxGetStdFeatureSupport(StdFeatureSet, SFS_VME);
    bDE := cxGetStdFeatureSupport(StdFeatureSet, SFS_DE);
    bPSE := cxGetStdFeatureSupport(StdFeatureSet, SFS_PSE);
    bTSC := cxGetStdFeatureSupport(StdFeatureSet, SFS_TSC);
    bMSR := cxGetStdFeatureSupport(StdFeatureSet, SFS_MSR);
    bPAE := cxGetStdFeatureSupport(StdFeatureSet, SFS_PAE);
    bMCE := cxGetStdFeatureSupport(StdFeatureSet, SFS_MCE);
    bCX8 := cxGetStdFeatureSupport(StdFeatureSet, SFS_CX8);
    bAPIC := cxGetStdFeatureSupport(StdFeatureSet, SFS_APIC);
    bSEP := cxGetStdFeatureSupport(StdFeatureSet, SFS_SEP);
    bMTRR := cxGetStdFeatureSupport(StdFeatureSet, SFS_MTRR);
    bPGE := cxGetStdFeatureSupport(StdFeatureSet, SFS_PGE);
    bMCA := cxGetStdFeatureSupport(StdFeatureSet, SFS_MCA);
    bCMOV := cxGetStdFeatureSupport(StdFeatureSet, SFS_CMOV);
    bPAT := cxGetStdFeatureSupport(StdFeatureSet, SFS_PAT);
    bPSE36 := cxGetStdFeatureSupport(StdFeatureSet, SFS_PSE36);
    bSERIAL := cxGetStdFeatureSupport(StdFeatureSet, SFS_SERIAL);
    bMMX := cxGetStdFeatureSupport(StdFeatureSet, SFS_MMX);
    bXSR := cxGetStdFeatureSupport(StdFeatureSet, SFS_XSR);
    bSIMD := cxGetStdFeatureSupport(StdFeatureSet, SFS_SIMD);
    bSIMD2 := cxGetStdFeatureSupport(StdFeatureSet, SFS_SIMD2);
    bDTS := cxGetStdFeatureSupport(StdFeatureSet, SFS_DTS);
    bACPI := cxGetStdFeatureSupport(StdFeatureSet, SFS_ACPI);
    bSS := cxGetStdFeatureSupport(StdFeatureSet, SFS_SS);
    bTM := cxGetStdFeatureSupport(StdFeatureSet, SFS_TM);
    bCLFLUSH := cxGetStdFeatureSupport(StdFeatureSet, SFS_CLFLUSH);
    if (iVendor <> VENDOR_AMD) and (iVendor <> VENDOR_CYRIX) then
      bEXMMX := FALSE
    else
      if (iVendor = VENDOR_AMD) then
        bEXMMX := cxGetExtFeatureSupport(ExtFeatureSet, EFS_EXMMXA)
      else
        bEXMMX := cxGetExtFeatureSupport(ExtFeatureSet, EFS_EXMMXC);
    b3DNOW := cxGetStdFeatureSupport(ExtFeatureSet, EFS_3DNOW);
    bEX3DNOW := cxGetExtFeatureSupport(ExtFeatureSet, EFS_EX3DNOW);
  end;

  Result := ERR_NOERROR;
end;  //------------

function cxGetSignatureInfo(var ASignatureInfo: TSignatureInfo): LongInt;
{ Fills the ASignatureInfo structure with the relevent information }
begin
  if (ASignatureInfo.dwSize <> SizeOf(TSignatureInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  ASignatureInfo.iSignature := cxGetProcessorSignature(ASignatureInfo.iProcessor);
  ASignatureInfo.iType := cxGetProcessorType(ASignatureInfo.iProcessor);
  ASignatureInfo.iFamily := cxGetProcessorFamily(ASignatureInfo.iProcessor);
  ASignatureInfo.iFamilyEx := cxGetProcessorExFamily(ASignatureInfo.iProcessor);
  ASignatureInfo.iModel := cxGetProcessorModel(ASignatureInfo.iProcessor);
  ASignatureInfo.iModelEx := cxGetProcessorExModel(ASignatureInfo.iProcessor);
  ASignatureInfo.iStepping := cxGetProcessorStepping(ASignatureInfo.iProcessor);
  ASignatureInfo.iBrand := cxGetProcessorBrand(ASignatureInfo.iProcessor);

  Result := ERR_NOERROR;
end;  //------------

function cxGetVersionInfo(var AVersionInfo: TcxVersionInfo): LongInt;
{ Fills the AVersionInfo structure with the relevent details }
begin
  if (AVersionInfo.dwSize <> SizeOf(TcxVersionInfo)) then begin
    Result := ERR_BADINFOSTRUCTURE;
    Exit;
  end;

  AVersionInfo.APIMajor := cxGetAPIVersionMajor;
  AVersionInfo.APIMinor := cxGetAPIVersionMinor;
  AVersionInfo.IntMajor := cxGetIntfVersionMajor;
  AVersionInfo.IntMinor := cxGetIntfVersionMinor;

  Result := ERR_NOERROR;
end;  //------------

function cxGetCPUIDSupport(AProcessor: Byte): Boolean;
{ Returns TRUE if the CPUID instruction is supported, FALSE otherwise }
begin
  Result := GetCPUIDSupport;
end;  //------------

function cxGetMaxStdCPUIDLevel(AProcessor: Byte): LongInt;
{ Returns the maximum supported CPUID execution level }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetMaxCPUIDLevel
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetMaxExtCPUIDLevel(AProcessor: Byte): LongInt;
{ Returns the maximum supported extended CPUID execution level }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetMaxExCPUIDLevelI
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorSignature(AProcessor: Byte): LongInt;
{ Returns the processor signature }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUSignature
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorType(AProcessor: Byte): LongInt;
{ Returns the processor type (0 = OEM or Retail, 1 = OverDrive) }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUTypeEx
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorFamily(AProcessor: Byte): LongInt;
{ Returns the processor family }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUFamilyEx
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorExFamily(AProcessor: Byte): LongInt;
{ Returns the extended processor family }
begin
  if (cxGetCPUIDSupport(AProcessor)) then begin
    // Check if extended fields are supported
    if (cxGetProcessorFamily(AProcessor) >= EXTENDED_FIELDS) then
      Result := GetCPUExFamilyEx
    else
      Result := 0;
  end else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorExModel(AProcessor: Byte): LongInt;
{ Returns the extended processor family }
begin
  if (cxGetCPUIDSupport(AProcessor)) then begin
    // Check if extended fields are supported
    if (cxGetProcessorModel(AProcessor) >= EXTENDED_FIELDS) then
      Result := GetCPUExModelEx
    else
      Result := 0;
  end else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorModel(AProcessor: Byte): LongInt;
{ Returns the processor model }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUModelEx
  else
    Result := ERR_CPUIDNOTSUPPORTED;

end;  //------------

function cxGetProcessorStepping(AProcessor: Byte): LongInt;
{ Returns the processor stepping }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUSteppingEx
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorBrand(AProcessor: Byte): LongInt;
{ Returns the processor brand identifier }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUBrandIdentifier
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetProcessorCount: Byte;
{ Returns the number of processors in the system }
begin
  Result := GetCPUCount;
end;  //------------

function cxExecuteCPUID(AProcessor: Byte;
                        AExecutionLevel: Cardinal;
                        AIterations: Byte;
                        var AResult: TCPUIDResult): Boolean;
{ Executes the CPUID instruction and returns the result }
begin
  Result := ExecuteCPUIDEx(AExecutionLevel, AIterations, AResult);
end;  //------------

function cxGetProcessorName(AProcessor: Byte): String;
{ Returns the processor name }
var
  iVendor: LongInt;
begin
  iVendor := dneGetVendor(USE_DEFAULT);
  case iVendor of
    VENDOR_INTEL:   Result := cxCpu2kIntel.GetCPUName(AProcessor);
    VENDOR_AMD:     Result := cxCpu2kAMD.GetCPUName(AProcessor);
    VENDOR_CYRIX:   Result := cxCpu2kCyrix.GetCPUName(AProcessor);
    VENDOR_IDT:     Result := cxCpu2kIDT.GetCPUName(AProcessor);
    VENDOR_NEXGEN:  Result := cxCpu2kNexGen.GetCPUName(AProcessor);
    VENDOR_UMC:     Result := cxCpu2kUMC.GetCPUName(AProcessor);
    VENDOR_RISE:    Result := cxCpu2kRise.GetCPUName(AProcessor);
  else
    Result := cxCpu2kDefault.GetCPUName;
  end;
end;  //------------

function cxGetProcessorFullName(AProcessor: Byte): String;
{ Returns the processor name prefixed by the vendor name }
var
  iVendor: LongInt;
begin
  iVendor := dneGetVendor(USE_DEFAULT);
  case iVendor of
    VENDOR_INTEL:   Result := cxCpu2kIntel.GetVendorPrefix + cxCpu2kIntel.GetCPUName(AProcessor);
    VENDOR_AMD:     Result := cxCpu2kAMD.GetVendorPrefix + cxCpu2kAMD.GetCPUName(AProcessor);
    VENDOR_CYRIX:   Result := cxCpu2kCyrix.GetVendorPrefix + cxCpu2kCyrix.GetCPUName(AProcessor);
    VENDOR_IDT:     Result := cxCpu2kIDT.GetVendorPrefix + cxCpu2kIDT.GetCPUName(AProcessor);
    VENDOR_NEXGEN:  Result := cxCpu2kNexGen.GetVendorPrefix + cxCpu2kNexGen.GetCPUName(AProcessor);
    VENDOR_UMC:     Result := cxCpu2kUMC.GetVendorPrefix + cxCpu2kUMC.GetCPUName(AProcessor);
    VENDOR_RISE:    Result := cxCpu2kRise.GetVendorPrefix + cxCpu2kRise.GetCPUName(AProcessor);
  else
    Result := cxCpu2kDefault.GetVendorPrefix + cxCpu2kDefault.GetCPUName;
  end;
end;  //------------

function cxGetVendorName(AProcessor: Byte): String;
{ Returns the processor vendor name }
var
  iVendor: LongInt;
begin
  iVendor := dneGetVendor(USE_DEFAULT);
  case iVendor of
    VENDOR_INTEL:   Result := cxCpu2kIntel.GetVendorName;
    VENDOR_AMD:     Result := cxCpu2kAMD.GetVendorName;
    VENDOR_CYRIX:   Result := cxCpu2kCyrix.GetVendorName;
    VENDOR_IDT:     Result := cxCpu2kIDT.GetVendorName;
    VENDOR_NEXGEN:  Result := cxCpu2kNexGen.GetVendorName;
    VENDOR_UMC:     Result := cxCpu2kUMC.GetVendorName;
    VENDOR_RISE:    Result := cxCpu2kRise.GetVendorName;
  else
    Result := PChar(cxCpu2kDefault.GetVendorName);
  end;
end;  //------------

function cxGetVendorIdentification(AProcessor: Byte): String;
{ Returns the processor vendor identification string }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetVendorIDString
  else
    Result := '';
end;  //------------

function cxGetRawProcessorSpeed(AProcessor: Byte; ADelay: LongInt): Single;
{ Returns the raw processor speed (Pentium level processors and higher only) }
var
  iVendor: LongInt;
begin
  iVendor := dneGetVendor(USE_DEFAULT);
  case iVendor of
    VENDOR_INTEL:   Result := cxCpu2kIntel.GetCPUSpeed(ADelay);
    VENDOR_AMD:     Result := cxCpu2kAMD.GetCPUSpeed(ADelay);
    VENDOR_CYRIX:   Result := cxCpu2kCyrix.GetCPUSpeed(ADelay);
    VENDOR_IDT:     Result := cxCpu2kIDT.GetCPUSpeed(ADelay);
    VENDOR_NEXGEN:  Result := cxCpu2kNexGen.GetCPUSpeed(ADelay);
    VENDOR_UMC:     Result := cxCpu2kUMC.GetCPUSpeed(ADelay);
    VENDOR_RISE:    Result := cxCpu2kRise.GetCPUSpeed(ADelay);
  else
    Result := cxCpu2kDefault.GetCPUSpeed(ADelay);
  end;
end;  //------------

function cxGetNormalisedProcessorSpeed(AProcessor: Byte; ADelay: LongInt): LongInt;
{ Returns a normalised processor speed (Pentium level processors and higher only) }
var
  iVendor: LongInt;
begin
  iVendor := dneGetVendor(USE_DEFAULT);
  case iVendor of
    VENDOR_INTEL:   Result := GetNormalisedCPUSpeed(cxCpu2kIntel.GetCPUSpeed(ADelay));
    VENDOR_AMD:     Result := GetNormalisedCPUSpeed(cxCpu2kAMD.GetCPUSpeed(ADelay));
    VENDOR_CYRIX:   Result := GetNormalisedCPUSpeed(cxCpu2kCyrix.GetCPUSpeed(ADelay));
    VENDOR_IDT:     Result := GetNormalisedCPUSpeed(cxCpu2kIDT.GetCPUSpeed(ADelay));
    VENDOR_NEXGEN:  Result := GetNormalisedCPUSpeed(cxCpu2kNexGen.GetCPUSpeed(ADelay));
    VENDOR_UMC:     Result := GetNormalisedCPUSpeed(cxCpu2kUMC.GetCPUSpeed(ADelay));
    VENDOR_RISE:    Result := GetNormalisedCPUSpeed(cxCpu2kRise.GetCPUSpeed(ADelay));
  else
    Result := GetNormalisedCPUSpeedEx(cxCpu2kDefault.GetCPUSpeed(ADelay));
  end;
end;  //------------

function cxGetRawProcessorSpeedEx(AProcessor: Byte): Single;
{ Returns the raw processor speed using the default bewnchmark delay (500ms) }
begin
  Result := cxGetRawProcessorSpeed(USE_DEFAULT, BENCHMARK_DELAY);
end;  //------------

function cxGetNormalisedProcessorSpeedEx(AProcessor: Byte): LongInt;
{ Returns a normalised processor speed using the default benchmark delay (500ms) }
begin
  Result := cxGetNormalisedProcessorSpeed(USE_DEFAULT, BENCHMARK_DELAY);
end;  //------------


function cxGetOverdriveFlag(AProcessor: Byte): Boolean;
{ Returns TRUE if the processor is an OverDrive model, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetOverDriveEx
  else
    Result := FALSE;
end;  //------------

function cxGetFDivBugPresent(AProcessor: Byte): Boolean;
{ Returns TRUE if the Pentium FDIV bug is present, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetFDIVBugPresent
  else
    Result := FALSE;
end;  //------------

function cxGetStdFeatureSet(AProcessor: Byte): LongInt;
{ Returns the standard feature set }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetFeatureSet
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetExtFeatureSet(AProcessor: Byte): LongInt;
{ Returns the extended feature set }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetExtendedFeatureSet
  else
    Result := ERR_CPUIDNOTSUPPORTED;
end;  //------------

function cxGetStdFeatureSupport(AFeatureSet: LongInt; ABit: Byte): Boolean;
{ Returns TRUE if ABit is supported in feature set AFeatureSet, FALSE otherwise }
begin
  Result := TestFeatureBit(AFeatureSet, ABit)
end;  //------------

function cxGetStdFeatureSupportEx(AProcessor: Byte; ABit: Byte): Boolean;
{ Returns TRUE if ABit is supported, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := TestFeatureBitEx(ABit)
  else
    Result := FALSE;
end;  //------------

function cxGetExtFeatureSupport(AFeatureSet: LongInt; ABit: Byte): Boolean;
{ Returns TRUE if ABit is supported in feature set AFeatureSet, FALSE otherwise }
begin
  Result := TestFeatureBit(AFeatureSet, ABit)
end;  //------------

function cxGetExtFeatureSupportEx(AProcessor: Byte; ABit: Byte): Boolean;
{ Returns TRUE if ABit is supported, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := TestExtendedFeatureBitEx(ABit)
  else
    Result := FALSE;
end;  //------------

function cxGetMMXSupport(AProcessor: Byte): Boolean;
{ Returns TRUE if the processor supports MMX instructions, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetMMXSupportEx
  else
    Result := FALSE;
end;  //------------

function cxGetExtMMXSupport(AProcessor: Byte): Boolean;
{ Returns TRUE if the processor supported the Extended MMX instructions, FALSE otherwise }
var
  iVendor: LongInt;
begin
  if (cxGetCPUIDSupport(AProcessor)) then begin
    iVendor := dneGetVendor(USE_DEFAULT);
    if (iVendor <> VENDOR_AMD) and (iVendor <> VENDOR_CYRIX) then
      Result := FALSE
    else 
      if (iVendor = VENDOR_AMD) then
        Result := GetMMXExSupportExAMD
      else
        Result := GetMMXExSupportExCyrix;
  end else
    Result := FALSE;
end;  //------------

function cxGetSIMDSupport(AProcessor: Byte): Boolean;
{ Returns TRUE if the processor supports the SIMD instructions, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetSIMDSupportEx
  else
    Result := FALSE;
end;  //------------

function cxGet3DNowSupport(AProcessor: Byte): Boolean;
{ Returns TRUE if the processor supports the 3DNow! instructions, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := Get3DNowSupportEx
  else
    Result := FALSE;
end;  //------------

function cxGetExt3DNowSupport(AProcessor: Byte): Boolean;
{ Returns TRUE if the processor supports the extended 3DNow! instructions, FALSE otherwise }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := Get3DNowExSupportEx
  else
    Result := FALSE;
end;  //------------

function cxGetSerialNumber(AProcessor: Byte): String;
{ Returns the processor serial number (if available and/or enabled) }
begin
  if (cxGetCPUIDSupport(AProcessor)) then begin
    if (cxGetStdFeatureSupportEx(AProcessor, SFS_SERIAL)) and (cxGetProcessorModel(AProcessor) >= CPU_PENTIUMIIIMODEL) then
      Result := GetCPUSerialNumber
    else
      Result := '';
  end else
    Result := '';
end;  //------------

function cxGetMarketingName(AProcessor: Byte): String;
{ Returns the processor marketing name (if available) }
begin
  if (cxGetCPUIDSupport(AProcessor)) then
    Result := GetCPUMarketName
  else
    Result := '';
end;  //------------

function cxGetLevel1DataCache(AProcessor: Byte): LongInt;
{ Returns the size of the level 1 data cache (in Kb) or 0 if not supported }
var
  CacheInfo: TCPUIDResult;
  CacheDescriptors: TCacheDescriptors;
begin
  if (GetCacheDetectExSupport) then begin
    // Detect using extended CPUID
    if (GetVendorIDString <> cxCpu2kCyrix.GetSignature) then
      Result := GetLevel1DataCacheEx
    else begin
      // Cyrix returns standard-level results in extended data
      CacheInfo := GetCacheInfoEx(CACHE_LEVEL1);
      GetCacheDescriptors(CacheInfo, CacheDescriptors);
      Result := GetLevel1DataCache(CacheDescriptors);
    end;
  end else begin
    // Detect using standard CPUID
    GetCacheDescriptorsEx(CacheDescriptors);
    Result := GetLevel1DataCache(CacheDescriptors);
  end;
end;  //------------

function cxGetLevel1CodeCache(AProcessor: Byte): LongInt;
{ Returns the size of the level 1 instruction cache (in Kb) or 0 if not supported }
var
  CacheInfo: TCPUIDResult;
  CacheDescriptors: TCacheDescriptors;
begin
  if (GetCacheDetectExSupport) then begin
    // Detect using extended CPUID
    if (GetVendorIDString <> cxCpu2kCyrix.GetSignature) then
      Result := GetLevel1InstructionCacheEx
    else begin
      // Cyrix returns standard-level results in extended data
      CacheInfo := GetCacheInfoEx(CACHE_LEVEL1);
      GetCacheDescriptors(CacheInfo, CacheDescriptors);
      Result := GetLevel1InstructionCache(CacheDescriptors);
    end;
  end else begin
    // Detect using standard CPUID
    GetCacheDescriptorsEx(CacheDescriptors);
    Result := GetLevel1InstructionCache(CacheDescriptors);
  end;
end;  //------------

function cxGetLevel1UnifiedCache(AProcessor: Byte): LongInt;
{ Returns the size of the level 1 unified cache (in Kb) or 0 if not supported }
var
  CacheInfo: TCPUIDResult;
  CacheDescriptors: TCacheDescriptors;
begin
  CacheInfo := GetCacheInfoEx(CACHE_LEVEL1);
  GetCacheDescriptors(CacheInfo, CacheDescriptors);
  Result := GetLevel1UnifiedCache(CacheDescriptors);
end;  //------------

function cxGetLevel2UnifiedCache(AProcessor: Byte): LongInt;
{ Returns the size of the level 2 unified cache (in Kb) or 0 if not supported }
var
  CacheInfo: TCPUIDResult;
  CacheDescriptors: TCacheDescriptors;
begin
  if (GetCacheDetectExSupport) then begin
    // Detect using extended CPUID
    if (GetVendorIDString <> cxCpu2kCyrix.GetSignature) then begin
      // AMD Duron processors return incorrect L2 cache size
      if (dneGetVendor(AProcessor) = VENDOR_AMD) and (cxGetProcessorFamily(AProcessor) = CPU_PENTIUMIICLASS) and
         (cxGetProcessorModel(AProcessor) = 3) then
        Result := 64
      else
        Result := GetLevel2UnifiedCacheEx;
    end else begin
      // Cyrix returns standard-level results in extended data
      CacheInfo := GetCacheInfoEx(CACHE_LEVEL2);
      GetCacheDescriptors(CacheInfo, CacheDescriptors);
      Result := GetLevel2UnifiedCache(CacheDescriptors);
    end;
  end else begin
    // Detect using standard CPUID
    GetCacheDescriptorsEx(CacheDescriptors);
    Result := GetLevel2UnifiedCache(CacheDescriptors);
  end;
end;  //------------

function cxGetAPIVersionMajor: LongInt;
{ Returns the product version of the detection API }
begin
  Result := GetAPIVersionMajor;
end;  //------------

function cxGetAPIVersionMinor: LongInt;
{ Returns the minor version (build) of the detection API }
begin
  Result := GetAPIVersionMinor;
end;  //------------

function cxGetIntfVersionMajor: LongInt;
{ Returns the product version of the Interface unit }
begin
  Result := PRODUCT_VERSION;
end;  //------------

function cxGetIntfVersionMinor: LongInt;
{ Returns the minor version (build) of the Interface unit }
begin
  Result := PRODUCT_BUILD;
end;  //------------

end.
