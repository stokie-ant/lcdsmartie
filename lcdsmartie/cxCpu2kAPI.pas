{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kApi.pas,                                           }
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
unit cxcpu2kAPI;

interface

{ Disable this symbol to revert to old speed normalisation routines }
{$DEFINE NEWNORMALISE}

uses Windows, SysUtils, cxCpu2kConst, cxVersionInfo;

  function GetCPUCount: LongInt;

  function GetCPUIDSupport: Boolean; register;
  function ExecuteCPUID: TCPUIDResult;
  function ExecuteCPUIDEx(AExecutionLevel: Cardinal; AIterations: Byte; var AResult: TCPUIDResult): Boolean;
  function GetMaxCPUIDLevel: LongInt;
  function GetMaxExCPUIDLevel: Cardinal;
  function GetMaxExCPUIDLevelI: LongInt;

  function GetVendorIDString: String;
  function GetCPUSignature: LongInt;
  function GetCPUBrandIdentifier: LongInt;

  function GetCPUType(ASignature: LongInt): LongInt;
  function GetCPUTypeEx: LongInt;
  function GetCPUFamily(ASignature: LongInt): LongInt;
  function GetCPUFamilyEx: LongInt;
  function GetCPUExFamily(ASignature: LongInt): LongInt;
  function GetCPUExFamilyEx: LongInt;
  function GetCPUModel(ASignature: LongInt): LongInt;
  function GetCPUExModelEx: LongInt;
  function GetCPUModelEx: LongInt;
  function GetCPUStepping(ASignature: LongInt): LongInt;
  function GetCPUSteppingEx: LongInt;

  function GetOverDrive(ASignature: LongInt): Boolean;
  function GetOverDriveEx: Boolean;
  function GetMMXSupport(AFeatureSet: LongInt): Boolean;
  function GetMMXSupportEx: Boolean;
  function GetSIMDSupport(AFeatureSet: LongInt): Boolean;
  function GetSIMDSupportEx: Boolean;

  function GetMMXExSupportAMD(AFeatureSet: LongInt): Boolean;
  function GetMMXExSupportCyrix(AFeatureSet: LongInt): Boolean;
  function GetMMXExSupportExAMD: Boolean;
  function GetMMXExSupportExCyrix: Boolean;
  function Get3DNowSupport(AFeatureSet: LongInt): Boolean;
  function Get3DNowSupportEx: Boolean;
  function Get3DNowExSupport(AFeatureSet: LongInt): Boolean;
  function Get3DNowExSupportEx: Boolean;

  function GetFDIVBugPresent: Boolean;
  function GetCyrixFlagPresent: Boolean;

  function GetFeatureSet: LongInt;
  function GetExtendedFeatureSet: LongInt;
  function TestFeatureBit(AFeatureSet: LongInt; ABit: Byte): Boolean;
  function TestFeatureBitEx(ABit: Byte): Boolean;
  function TestExtendedFeatureBitEx(ABit: Byte): Boolean;

  function DecodeRegister(ARegister: LongInt): String;
  function GetNormalisedCPUSpeed(AValue: Single): Integer;
  function GetNormalisedCPUSpeedEx(AValue: Single): Integer;

  function GetCPUSerialNumber: String;
  function GetCPUSerialNumberRaw: String;
  function GetCPUMarketName: String;

  function GetCacheInfo(var ACacheInfo: TCPUIDResult): Boolean;
  function GetCacheInfoEx(ALevel: LongInt): TCPUIDResult;
  function GetCacheDetectExSupport: Boolean;

  function GetCacheDescriptors(ACacheInfo: TCPUIDResult; var ADescriptors: TCacheDescriptors): Boolean;
  function GetCacheDescriptorsEx(var ADescriptors: TCacheDescriptors): Boolean;

  function GetLevel1DataCache(ADescriptors: TCacheDescriptors): LongInt;
  function GetLevel1DataCacheEx: LongInt;
  function GetLevel1InstructionCache(ADescriptors: TCacheDescriptors): LongInt;
  function GetLevel1InstructionCacheEx: LongInt;
  function GetLevel1UnifiedCache(ADescriptors: TCacheDescriptors): LongInt;
  function GetLevel2UnifiedCache(ADescriptors: TCacheDescriptors): LongInt;
  function GetLevel2UnifiedCacheEx: LongInt;

  function GetAPIVersionInfo: TcxVersionInfoStruct;
  function GetAPIVersionMajor: LongInt;
  function GetAPIVersionMinor: LongInt;

var
  CPUID_Level: Cardinal;
  CPUID_LastError: LongInt;

implementation

  function GetAPIVersionInfo: TcxVersionInfoStruct;
  begin
    Result.Product := 'CarbonSoft Processor Detection API';
    Result.Copyright := 'Copyright © 1999-2000 CarbonSoft';
    Result.Version := 1.0;
    Result.Build := 45;
    Result.Status := bsFinal;
    Result.Release := rsPublic;
  end;

  function GetAPIVersionMajor: LongInt;
  begin
    Result := 1;
  end;

  function GetAPIVersionMinor: LongInt;
  begin
    Result := 0;
  end;


  function GetCPUCount: LongInt;
  var
    lpSysInfo: TSYSTEMINFO;
  begin
    GetSystemInfo(lpSysInfo);
    Result := lpSysInfo.dwNumberOfProcessors;
  end;

  function GetCPUIDSupport: Boolean;
  { Returns TRUE if the CPU supports the CPUID instruction, FALSE otherwise }
  asm
    PUSHFD
    POP     EAX
    MOV     EDX, EAX
    XOR     EAX, CPUIDID_BIT
    PUSH    EAX
    POPFD
    PUSHFD
    POP     EAX
    XOR     EAX, EDX
    JZ      @exit
    MOV     AL, TRUE
  @exit:
  end; //------------

  function ExecuteCPUID: TCPUIDResult; assembler;
  { Executes the CPUID instruction at the required level }
  asm
    PUSH    EBX
    PUSH    EDI
    MOV     EDI, EAX
    MOV     EAX, CPUID_LEVEL
    DW      $A20F
    STOSD
    MOV     EAX, EBX
    STOSD
    MOV     EAX, ECX
    STOSD
    MOV     EAX, EDX
    STOSD
    POP     EDI
    POP     EBX
  end; //------------

  function ExecuteCPUIDEx(AExecutionLevel: Cardinal; AIterations: Byte; var AResult: TCPUIDResult): Boolean;
  { Verifies whether the CPUID instruction is supported at the required level and and if it is
    then it is executed the number of times specified by AIterations }
  var
    Iteration: Byte;
  begin
    if not(GetCPUIDSupport) then begin
      CPUID_LastError := ERR_CPUIDNOTSUPPORTED;
      Result := FALSE;
      Exit;
    end;

    if (LongInt(AExecutionLevel) > GetMaxCPUIDLevel) and (AExecutionLevel > GetMaxExCPUIDLevel) then begin
      CPUID_LastError := ERR_EXECUTIONLEVELNOTSUPPORTED;
      Result := FALSE;
      Exit;
    end;

    // Execute the CPUID instruction
    CPUID_LEVEL := AExecutionLevel;
    for Iteration := 1 to AIterations do
      AResult := ExecuteCPUID;

    CPUID_LastError := ERR_NOERROR;
    Result := TRUE;
  end;

  function GetMaxCPUIDLevel: LongInt;
  { Returns the maximum supported standard CPUID level }
  var
    Signature: TCPUIDResult;
  begin
    if (GetCPUIDSupport) then begin
      CPUID_Level := CPUID_MAXLEVEL;
      Signature := ExecuteCPUID;
      Result := Signature.EAX;
    end else begin
      CPUID_LastError := ERR_CPUIDNOTSUPPORTED;
      Result := VAL_NOVALUE;
    end;
  end;  //------------

  function GetMaxExCPUIDLevel: Cardinal;
  { Returns the maximum supported extended CPUID level }
  var
    Signature: TCPUIDResult;
  begin
    if (GetCPUIDSupport) then begin
      CPUID_LEVEL := CPUID_MAXLEVELEX;
      Signature := ExecuteCPUID;
      Result := Signature.EAX;
    end else begin
      CPUID_LastError := ERR_CPUIDNOTSUPPORTED;
      Result := VAL_NOVALUE;
    end;
  end;  //------------

  function GetMaxExCPUIDLevelI: LongInt;
  { Returns a normal longint representing the maximum extended CPUID level }
  var
    MaxLevel: Cardinal;
  begin
    MaxLevel := GetMaxExCPUIDLevel;
    if ((MaxLevel and not(CPUID_MAXLEVELEX)) >= 8) then
      Result := 0
    else
      Result := (MaxLevel and not(CPUID_MAXLEVELEX));
  end;

  function GetVendorIDString: String;
  { Returns the vendor identification string }
  var
    VendorSignature: TCPUIDResult;
  begin
    if (ExecuteCPUIDEx(CPUID_VENDORSIGNATURE, 1, VendorSignature)) then begin
      Result := '';
      Result := Result + DecodeRegister(VendorSignature.EBX);
      Result := Result + DecodeRegister(VendorSignature.EDX);
      Result := Result + DecodeRegister(VendorSignature.ECX);
      if (Length(Result) < 12) then
        Result := 'Unknown';
    end else
      Result := 'Unknown';
  end;  //------------

  function GetCPUSignature: LongInt;
  { Returns the CPU signature }
  var
    CPUSignature: TCPUIDResult;
  begin
    if (ExecuteCPUIDEx(CPUID_CPUSIGNATURE, 1, CPUSignature)) then
      Result := CPUSignature.EAX
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetCPUBrandIdentifier: LongInt;
  { Returns the CPU brand identifier }
  var
    CPUBrand: TCPUIDResult;
  begin
    if (ExecuteCPUIDEx(CPUID_CPUSIGNATURE, 1, CPUBrand)) then
      Result := LoByte(LoWord(CPUBrand.EBX))
    else
      Result := BRAND_UNSUPPORTED;
  end;

  function GetCPUType(ASignature: LongInt): LongInt;
  { Returns the CPU Type from the supplied Signature }
  begin
    Result := (ASignature shr 12 and 3);
  end;  //------------

  function GetCPUTypeEx: LongInt;
  { Returns the CPU Type without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := GetCPUType(Signature)
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetCPUFamily(ASignature: LongInt): LongInt;
  { Returns the CPU Family from the supplied Signature }
  begin
    Result := (ASignature shr 8 and $F);
  end;  //------------

  function GetCPUExFamily(ASignature: LongInt): LongInt;
  { Returns extended CPU Family from the supplied signature }
  begin
    Result := ((ASignature shr 20) and $FF);
  end;  //------------

  function GetCPUFamilyEx: LongInt;
  { Returns the CPU Family without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := GetCPUFamily(Signature)
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetCPUExFamilyEx: LongInt;
  { Returns the CPU Family without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := GetCPUExFamily(Signature)
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetCPUModel(ASignature: LongInt): LongInt;
  { Returns the CPU Model from the supplied Signature }
  begin
    Result := (ASignature shr 4 and $F);
  end;  //------------

  function GetCPUModelEx: LongInt;
  { Returns the CPU Model without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := GetCPUModel(Signature)
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetCPUExModel(ASignature: LongInt): LongInt;
  { Returns the CPU Model from the supplied Signature }
  begin
    Result := (ASignature shr 16 and $F);
  end;  //------------

  function GetCPUExModelEx: LongInt;
  { Returns the CPU Model without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := GetCPUExModel(Signature)
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetCPUStepping(ASignature: LongInt): LongInt;
  { Returns the CPU Stepping from the supplied Signature }
  begin
    Result := (ASignature and $F);
  end;  //------------

  function GetCPUSteppingEx: LongInt;
  { Returns the CPU Stepping without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := GetCPUStepping(Signature)
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetOverDrive(ASignature: LongInt): Boolean;
  { Gets the CPU OverDrive flag from the supplied Signature }
  begin
    Result := (GetCPUType(ASignature) = CPU_OVERDRIVE)
  end;  //------------

  function GetOverDriveEx: Boolean;
  { Gets the CPU OverDrive flag without requiring a Signature }
  var
    Signature: LongInt;
  begin
    Signature := GetCPUSignature;
    if (Signature <> VAL_NOVALUE) then
      Result := (GetCPUType(Signature) = CPU_OVERDRIVE)
    else
      Result := FALSE;
  end;  //------------

  function GetMMXSupport(AFeatureSet: LongInt): Boolean;
  { Gets the CPU MMX flag from the supplied signature }
  begin
    Result := TestFeatureBit(AFeatureSet, SFS_MMX);
  end;  //------------

  function GetMMXSupportEx: Boolean;
  { Gets the CPU MMX flag without requiring a Signature }
  begin
    Result := TestFeatureBitEx(SFS_MMX);
  end;  //------------

  function GetSIMDSupport(AFeatureSet: LongInt): Boolean;
  { Gets the SIMD flag from the supplied signature }
  begin
    Result := TestFeatureBit(AFeatureSet, SFS_SIMD);
  end;  //------------

  function GetSIMDSupportEx: Boolean;
  { Gets the SIMD flag without requiring a feature set }
  begin
    Result := TestFeatureBitEx(SFS_SIMD);
  end;  //------------

  function GetMMXExSupportAMD(AFeatureSet: LongInt): Boolean;
  { Gets the Extended MMX flag from the supplied feature set }
  begin
    Result := TestFeatureBit(AFeatureSet, EFS_EXMMXA);
  end;  //------------

  function GetMMXExSupportCyrix(AFeatureSet: LongInt): Boolean;
  { Gets the Extended MMX flag from the supplied feature set }
  begin
    Result := TestFeatureBit(AFeatureSet, EFS_EXMMXC);
  end;  //------------

  function GetMMXExSupportExAMD: Boolean;
  { Gets the Extended MMX flag without requiring a feature set }
  begin
    Result := TestExtendedFeatureBitEx(EFS_EXMMXA);
  end;  //------------

  function GetMMXExSupportExCyrix: Boolean;
  { Gets the Extended MMX flag without requiring a feature set }
  begin
    Result := TestExtendedFeatureBitEx(EFS_EXMMXC);
  end;  //------------

  function Get3DNowSupport(AFeatureSet: LongInt): Boolean;
  { Gets the 3DNow flag from the supplied feature set }
  begin
    Result := TestFeatureBit(AFeatureSet, EFS_3DNOW);
  end;  //------------

  function Get3DNowSupportEx: Boolean;
  { Gets the 3DNow flag without requiring a feature set }
  begin
    Result := TestExtendedFeatureBitEx(EFS_3DNOW);
  end;  //------------

  function Get3DNowExSupport(AFeatureSet: LongInt): Boolean;
  { Gets the extended 3DNow flag from the supplied feature set }
  begin
    Result := TestFeatureBit(AFeatureSet, EFS_EX3DNOW);
  end;  //------------

  function Get3DNowExSupportEx: Boolean;
  { Gets the extended 3DNow flag without requiring a feature set }
  begin
    Result := TestExtendedFeatureBitEx(EFS_EX3DNOW);
  end;  //------------

  function GetFDIVBugPresent: Boolean;
  { Checks for the Pentium FDIV bug }
  const
    N1: Real = 4195835.0;
    N2: Real = 3145727.0;
  begin
    Result := ((((N1 / N2) * N2) - N1) <> 0.0);
  end;  //------------

  function GetCyrixFlagPresent: Boolean; assembler;
  { Uses alternatve method to detect Cyrix processors }
  asm
    XOR   AX, AX
    SAHF
    MOV   AX, 5
    MOV   BX, 2
    DIV   BL
    LAHF
    CMP   AH, 2
    JNE   @not_cyrix
    MOV   AX, TRUE
    JMP   @end
    @not_cyrix:
      MOV   AX, FALSE
    @end:
      RET
  end;  //------------

  function GetFeatureSet: LongInt;
  { Returns the CPU Standard Feature Set }
  var
    FeatureSet: TCPUIDResult;
  begin
    if (ExecuteCPUIDEx(CPUID_CPUFEATURESET, 1, FeatureSet)) then
      Result := FeatureSet.EDX
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function GetExtendedFeatureSet: LongInt;
  { Returns the CPU Extended Feature Set (if supported) }
  var
    ExtendedFeatureSet: TCPUIDResult;
  begin
    if (ExecuteCPUIDEx(CPUID_CPUSIGNATUREEX, 1, ExtendedFeatureSet)) then
      Result := ExtendedFeatureSet.EDX
    else
      Result := VAL_NOVALUE;
  end;  //------------

  function TestFeatureBit(AFeatureSet: LongInt; ABit: Byte): Boolean;
  { Tests bit ABit of feature set AFeatureSet }
  begin
    Result := ((AFeatureSet and (1 shl ABit)) <> 0);
  end;  //------------

  function TestFeatureBitEx(ABit: Byte): Boolean;
  { Tests bit ABit without requiring a feature set }
  var
    FeatureSet: LongInt;
  begin
    FeatureSet := GetFeatureSet;
    if (FeatureSet <> VAL_NOVALUE) then
      Result := TestFeatureBit(FeatureSet, ABit)
    else
      Result := FALSE;
  end;  //------------

  function TestExtendedFeatureBitEx(ABit: Byte): Boolean;
  { Tests bit ABit without requiring a feature set }
  var
    ExtendedFeatureSet: LongInt;
  begin
    ExtendedFeatureSet := GetExtendedFeatureSet;
    if (ExtendedFeatureSet <> VAL_NOVALUE) then
      Result := TestFeatureBit(ExtendedFeatureSet, ABit)
    else
      Result := FALSE;
  end;  //------------

  function DecodeRegister(ARegister: LongInt): String;
  { Decodes a register value into a 4-character string }
  begin
    Result := '';
    Result := Result + Char((LoByte(LoWord(ARegister))));
    Result := Result + Char((HiByte(LoWord(ARegister))));
    Result := Result + Char((LoByte(HiWord(ARegister))));
    Result := Result + Char((HiByte(HiWord(ARegister))));
  end;  //------------

  function GetNormalisedCPUSpeed(AValue: Single): Integer;
  { Converts the raw processor speed to the nearest (known) equivalent }
  {$IFDEF NEWNORMALISE}
    begin
      Result := GetNormalisedCPUSpeedEx(AValue);
  {$ELSE}
    var
      iIndex: Integer;          // Normalised speed index
      iClosest: Integer;        // Index to the closest speed so far
    begin
      iClosest := 0;
      for iIndex := 0 to MAX_SPEEDS - 1 do
        if (Abs(AValue - CPUSPEEDS[iIndex]) < Abs(AValue - CPUSPEEDS[iClosest]))
          then iClosest := iIndex;
      Result := CPUSPEEDS[iClosest];
  {$ENDIF}
  end;  //------------

  function GetNormalisedCPUSpeedEx(AValue: Single): Integer;
  { Attempts to calculate the normalised speed rather than using the lookup
    [Kev French 12-12-2000]: Avoids having to update the normalised speeds array }
  var
    iIndex: Integer;          // Normalised speed index
    iClosest: Integer;        // Index to the closest speed so far
    iHundreds: Integer;       // Hundreds of Mhz
    iUnits: Integer;          // Units part of raw speed
  begin
    iClosest := 0;
    iHundreds := Trunc(AValue) div 100;
    iUnits := Trunc(AValue - (iHundreds * 100));
    if ((iHundreds * 100) < SPEED_LO_THRESHOLD) then begin
      for iIndex := 0 to MAX_SPEEDS_LO - 1 do
        if (Abs(iUnits - CPUSPEEDS_LO[iIndex]) <= Abs(iUnits - CPUSPEEDS_LO[iClosest]))
          then iClosest := iIndex;
      if (iHundreds > 0) then
        Result := CPUSPEEDS_LO[iClosest] + (iHundreds * 100)
      else
        Result := CPUSPEEDS_LO[iClosest];
    end else begin
      for iIndex := 0 to MAX_SPEEDS_HI - 1 do
        if (Abs(iUnits - CPUSPEEDS_HI[iIndex]) <= Abs(iUnits - CPUSPEEDS_HI[iClosest]))
          then iClosest := iIndex;
      { Assumes that CPUSPEEDS_HI[MAX_SPEEDS_HI] = 100 }
      if (iClosest = MAX_SPEEDS_HI) then
        iClosest := 0;
      Result := CPUSPEEDS_HI[iClosest] + (iHundreds * 100);
      { Some people are too superstitious by far :) }
      if (Result = 666) then
        Result := 667;
    end;
  end;  //------------

  function GetCPUSerialNumber: String;
  { Returns the processor serial number (Intel PIII only)
    Based on code submitted by Pierrick Lucas }
    function SplitToNibble(ANumber: String): String;
    { Formats 8-digit number into 4-digit nibbles XXXX-XXXX }
    begin
      Result := Copy(ANumber, 0, 4) + '-' + Copy(ANumber, 5, 4);
    end;
  var
    SerialNumber: TCPUIDResult;
  begin
    Result := '';
    if (ExecuteCPUIDEx(CPUID_CPUSIGNATURE, 1, SerialNumber)) then begin
      Result := SplitToNibble(IntToHex(SerialNumber.EAX, 8)) + '-';
      if (ExecuteCPUIDEx(CPUID_CPUSIGNATURE, 1, SerialNumber)) then begin
        Result := Result + SplitToNibble(IntToHex(SerialNumber.EDX, 8)) + '-';
        Result := Result + SplitToNibble(IntToHex(SerialNumber.ECX, 8));
      end else
        Result := '';
    end else
      Result := '';
  end;  //------------

  function GetCPUSerialNumberRaw: String;
  { Returns the processor serial number (Intel PIII+) only without formatting }
  var
    SerialNumber: TCPUIDResult;
  begin
    Result := '';
    if (ExecuteCPUIDEx(CPUID_CPUSIGNATURE, 1, SerialNumber)) then begin
      Result := IntToHex(SerialNumber.EAX, 8);
      if (ExecuteCPUIDEx(CPUID_CPUSIGNATURE, 1, SerialNumber)) then begin
        Result := Result + IntToHex(SerialNumber.EDX, 8);
        Result := Result + IntToHex(SerialNumber.ECX, 8);
      end else
        Result := '';
    end else
      Result := '';
  end;  //------------

  function GetCPUMarketName: String;
  { Returns the CPU Marketting name }
    function GetCPUMarketNameSection(ASection: DWORD): String;
    { Returns the section ASection of the CPU Marketting name }
    var
      MarketNameSection: TCPUIDResult;
    begin
      Result := '';
      if (ExecuteCPUIDEx(ASection, 1, MarketNameSection)) then begin
        Result := Result + DecodeRegister(MarketNameSection.EAX);
        Result := Result + DecodeRegister(MarketNameSection.EBX);
        Result := Result + DecodeRegister(MarketNameSection.ECX);
        Result := Result + DecodeRegister(MarketNameSection.EDX);
      end else
        Result := '';
    end;  //------------
  var
    RawName: String;
  begin
    RawName := '';
    RawName := RawName + GetCPUMarketNameSection(CPUID_CPUMARKETNAME1);
    RawName := RawName + GetCPUMarketNameSection(CPUID_CPUMARKETNAME2);
    RawName := RawName + GetCPUMarketNameSection(CPUID_CPUMARKETNAME3);
    Result := RawName;
  end;  //------------

  function GetCacheDetectExSupport: Boolean;
  { Returns TRUE if the processor supports cache detection using extended CPUID }
  { [Bryan Mayland 22-12-2000]: Fixed incorrect result on AMD Athlons }
  { [Kev French 10-02-2001]: Fixed (my bad) Celeron error }
  begin
    Result := (GetMaxExCPUIDLevelI >= 6);
    (*-----
    if (GetMaxCPUIDLevel >= 1) then
      Result := (GetMaxExCPUIDLevel and not(CPUID_MAXLEVELEX)) >= (CPUID_LEVEL1CACHETLB and not(CPUID_MAXLEVELEX))
    else
      Result := FALSE;
    -----*)
  end;

  function GetCacheInfo(var ACacheInfo: TCPUIDResult): Boolean;
  { Returns the raw cache descriptors }
  var
    Iterations: Byte;
  begin
    if (ExecuteCPUIDEx(CPUID_CACHETLB, 1, ACacheInfo)) then begin
      Result := TRUE;
      Iterations := LoByte(LoWord(ACacheInfo.EAX));
      if (Iterations > 1) then begin
        Result := ExecuteCPUIDEx(CPUID_CACHETLB, Iterations, ACacheInfo);
      end;
    end else
      Result := FALSE;
  end;  //------------

  function GetCacheInfoEx(ALevel: LongInt): TCPUIDResult;
  { Returns the cache information for the specified level using extended CPUID }
  begin
    if (GetCPUIDSupport) then begin
      if (ALevel = CACHE_LEVEL1) then
        CPUID_LEVEL := CPUID_LEVEL1CACHETLB
      else
        CPUID_LEVEL := CPUID_LEVEL2CACHETLB;

      Result := ExecuteCPUID;
    end;
  end;  //------------

  function GetCacheDescriptors(ACacheInfo: TCPUIDResult; var ADescriptors: TCacheDescriptors): Boolean;
  { Returns the cache descriptors for the processor }
    procedure DecodeDescriptor(ARawDescriptors: Cardinal; AIndex: LongInt; var ADescriptors: TCacheDescriptors);
    begin
      ADescriptors[(AIndex * 4) - 3] := LoByte(LoWord(ARawDescriptors));
      ADescriptors[(AIndex * 4) - 2] := HiByte(LoWord(ARawDescriptors));
      ADescriptors[(AIndex * 4) - 1] := LoByte(HiWord(ARawDescriptors));
      ADescriptors[(AIndex * 4)] := HiByte(HiWord(ARawDescriptors));
    end;
  var
    Subscript: LongInt;
  begin
    for Subscript := EAX to EDX do begin
      DecodeDescriptor(ACacheInfo.EAX, Subscript, ADescriptors);
      DecodeDescriptor(ACacheInfo.EBX, Subscript, ADescriptors);
      DecodeDescriptor(ACacheInfo.ECX, Subscript, ADescriptors);
      DecodeDescriptor(ACacheInfo.EDX, Subscript, ADescriptors);
    end;
    Result := TRUE;
  end;  //------------

  function GetCacheDescriptorsEx(var ADescriptors: TCacheDescriptors): Boolean;
  { Returns the cache descriptors for the processor without requiring CacheInfo }
  var
    CacheInfo: TCPUIDResult;
  begin
    if (GetCacheInfo(CacheInfo)) then
      Result := GetCacheDescriptors(CacheInfo, ADescriptors)
    else
      Result := FALSE;
  end;

  function GetLevel1DataCache(ADescriptors: TCacheDescriptors): LongInt;
  { Returns level 1 data cache size (in Kb) }
  var
    Subscript: LongInt;
  begin
    Result := 0;
    for Subscript := 1 to 16 do
      if (ADescriptors[Subscript] in [$0A, $0C]) then begin
        if (ADescriptors[Subscript] = $0A) then
          Result := 8
        else
          Result := 16;
        Exit;
      end;
  end;  //------------

  function GetLevel1DataCacheEx: LongInt;
  { Returns level 1 data cache size (in Kb) using extended CPUID }
  var
    Level1DataCache: TCPUIDResult;
  begin
    Level1DataCache := GetCacheInfoEx(CACHE_LEVEL1);
    Result := HiByte(HiWord(Level1DataCache.ECX));
  end;  //------------

  function GetLevel1InstructionCache(ADescriptors: TCacheDescriptors): LongInt;
  { Returns level 1 instruction cache size (in Kb) }
  var
    Subscript: LongInt;
  begin
    Result := 0;
    for Subscript := 1 to 16 do
      if (ADescriptors[Subscript] in [$6, $8]) then begin
        if (ADescriptors[Subscript] = $06) then
          Result := 8
        else
          Result := 16;
        Exit;
      end;
  end;  //------------

  function GetLevel1UnifiedCache(ADescriptors: TCacheDescriptors): LongInt;
  { Returns level 1 unified cache (Cyrix-specific) }
  var
    Subscript: LongInt;
  begin
    Result := 0;
    for Subscript := 1 to 16 do
      if (ADescriptors[Subscript] = $80) then begin
        Result := 16;
        Exit;
      end;
  end;  //------------

  function GetLevel1InstructionCacheEx: LongInt;
  { Returns level 1 data cache size (in Kb) using extended CPUID }
  var
    Level1InstructionCache: TCPUIDResult;
  begin
    Level1InstructionCache := GetCacheInfoEx(CACHE_LEVEL1);
    Result := HiByte(HiWord(Level1InstructionCache.EDX));
  end;  //------------

  function GetLevel2UnifiedCache(ADescriptors: TCacheDescriptors): LongInt;
  { Returns the level 2 cache size (in Kb) }
  { [Bryan Coutch 10-3-2001] Fixed procedural error }
  var
    Subscript: LongInt;
  begin
    Result := 0;
    for Subscript := 1 to 16 do
      if (ADescriptors[Subscript] in [$40..$45, $82..$85]) then begin
        case ADescriptors[Subscript] of
          $40: Result := 0;
          $41: Result := 128;
          $42: Result := 256;
          $43: Result := 512;
          $44: Result := 1024;
          $45: Result := 2048;
          $82: Result := 256;
          $83: Result := 512;
          $84: Result := 1024;
          $85: Result := 2048;
        else
          Result := 0;
        end;
        Exit;
      end;
  end;  //------------

  function GetLevel2UnifiedCacheEx: LongInt;
  { Returns level 2 cache size (in Kb) using extended CPUID }
  { [Bryan Mayland 22-12-2000]: Changed Hibyte(Hiword(... to HiWord(... }
  var
    Level2UnifiedCache: TCPUIDResult;
  begin
    if (ExecuteCPUIDEx(CPUID_LEVEL2CACHETLB, 1, Level2UnifiedCache)) then
      Result := HiWord(Level2UnifiedCache.ECX)
    else
      Result := VAL_NOVALUE;
  end;  //------------

end.

