{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxcpu2kVcl.pas,                                           }
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
unit cxCPU2kVcl;

interface

uses
  Windows, Messages, Classes, cxCpu2kIntf, cxCpu2kConst, cxCpu2kAPI, cxVersionInfo;

{$IFDEF BCB}
  {$ObjExportAll On}
{$ENDIF}

type
  TcxAutoBench = class(TPersistent)
  private
    { Private declarations }
    FEnabled: Boolean;
    FDelay: LongInt;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  published
    { Published declarations }
    property Enabled: Boolean read FEnabled write FEnabled;
    property Delay: LongInt read FDelay write FDelay;
  end;

  TcxCpu2kVersionInfo = class(TPersistent)
  private
    { Private declarations }
    FAPI,
    FVCL: TcxVersionInfo;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Init;
  published
    { Published declarations }
    property API: TcxVersionInfo read FAPI;
    property VCL: TcxVersionInfo read FVCL;
  end;

  TcxCPUID = class(TPersistent)
  private
    { Private declarations }
    FSupported: Boolean;
    FMaxLevel: LongInt;
    FMaxLevelEx: LongInt;
    procedure SetBoolean(AValue: Boolean);
    procedure SetLongInt(AValue: LongInt);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Init;
  published
    { Published declarations }
    property Available: Boolean read FSupported write SetBoolean stored FALSE;
    property MaxLevel: LongInt read FMaxLevel write SetLongInt stored FALSE;
    property MaxLevelEx: LongInt read FMaxLevelEx write SetLongInt stored FALSE;
  end;

  TcxDetectedInfo = class(TPersistent)
  private
    { Private declarations }
    FFamily: LongInt;
    FFamilyEx: LongInt;
    FModel: LongInt;
    FModelEx: LongInt;
    FStepping: LongInt;
    FType: LongInt;
    FFeatureSet: LongInt;
    FFeatureSetEx: LongInt;
    FSignature: LongInt;
    FVendorString: String;
    FBrandIdentifier: LongInt;
    procedure SetLongInt(AValue: LongInt);
    procedure SetString(AValue: String);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Init;
  published
    { Published declarations }
    property Brand: LongInt read FBrandIdentifier write SetLongInt stored FALSE;
    property cpuFamily: LongInt read FFamily write SetLongInt stored FALSE;
    property cpuFamilyEx: LongInt read FFamilyEx write SetLongInt stored FALSE;
    property cpuModel: LongInt read FModel write SetLongInt stored FALSE;
    property cpuModelEx: LongInt read FModelEx write SetLongInt stored FALSE;
    property cpuStepping: LongInt read FStepping write SetLongInt stored FALSE;
    property cpuType: LongInt read FType write SetLongInt stored FALSE;
    property FeatureSet: LongInt read FFeatureSet write SetLongInt stored FALSE;
    property FeatureSetEx: LongInt read FFeatureSetEx write SetLongInt stored FALSE;
    property Signature: LongInt read FSignature write SetLongInt stored FALSE;
    property VendorID: String read FVendorString write SetString stored FALSE;
  end;

  TcxFeatureSet = class(TPersistent)
  private
    { Private declarations }
    FFPU: Boolean;
    FVME: Boolean;
    FDE: Boolean;
    FPSE: Boolean;
    FTSC: Boolean;
    FMSR: Boolean;
    FPAE: Boolean;
    FMCE: Boolean;
    FCX8: Boolean;
    FAPIC: Boolean;
    FSEP: Boolean;
    FMTRR: Boolean;
    FPGE: Boolean;
    FMCA: Boolean;
    FCMOV: Boolean;
    FPAT: Boolean;
    FPSE36: Boolean;
    FSERIAL: Boolean;
    FMMX: Boolean;
    FXSR: Boolean;
    FSIMD: Boolean;
    FSIMD2: Boolean;
    FCLFLUSH: Boolean;
    FDTS: Boolean;
    FACPI: Boolean;
    FSS: Boolean;
    FTM: Boolean;
    procedure SetBoolean(AValue: Boolean);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Init;
  published
    { Published declarations }
    property FPU: Boolean read FFPU write SetBoolean stored FALSE;
    property VME: Boolean read FVME write SetBoolean stored FALSE;
    property DE: Boolean read FDE write SetBoolean stored FALSE;
    property PSE: Boolean read FPSE write SetBoolean stored FALSE;
    property TSC: Boolean read FTSC write SetBoolean stored FALSE;
    property MSR: Boolean read FMSR write SetBoolean stored FALSE;
    property PAE: Boolean read FPAE write SetBoolean stored FALSE;
    property MCE: Boolean read FMCE write SetBoolean stored FALSE;
    property CX8: Boolean read FCX8 write SetBoolean stored FALSE;
    property APIC: Boolean read FAPIC write SetBoolean stored FALSE;
    property SEP: Boolean read FSEP write SetBoolean stored FALSE;
    property MTRR: Boolean read FMTRR write SetBoolean stored FALSE;
    property PGE: Boolean read FPGE write SetBoolean stored FALSE;
    property MCA: Boolean read FMCA write SetBoolean stored FALSE;
    property CMOV: Boolean read FCMOV write SetBoolean stored FALSE;
    property PAT: Boolean read FPAT write SetBoolean stored FALSE;
    property PSE36: Boolean read FPSE36 write SetBoolean stored FALSE;
    property SERIAL: Boolean read FSERIAL write SetBoolean stored FALSE;
    property MMX: Boolean read FMMX write SetBoolean stored FALSE;
    property XSR: Boolean read FXSR write SetBoolean stored FALSE;
    property SIMD: Boolean read FSIMD write SetBoolean stored FALSE;
    property SIMD2: Boolean read FSIMD2 write SetBoolean stored FALSE;
    property CLFLUSH: Boolean read FCLFLUSH write SetBoolean stored FALSE;
    property DTS: Boolean read FDTS write SetBoolean stored FALSE;
    property ACPI: Boolean read FACPI write SetBoolean stored FALSE;
    property SS: Boolean read FSS write SetBoolean stored FALSE;
    property TM: Boolean read FTM write SetBoolean stored FALSE;
  end;

  TcxExFeatureSet = class(TPersistent)
  private
    { Private declarations }
    FEXMMX: Boolean;
    F3DNOW: Boolean;
    FEX3DNOW: Boolean;
    procedure SetBoolean(AValue: Boolean);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Init;
  published
    { Published declarations }
    property AMD3DNow: Boolean read F3DNOW write SetBoolean stored FALSE;
    property AMD3DNowEx: Boolean read FEX3DNOW write SetBoolean stored FALSE;
    property MMXEx: Boolean read FEXMMX write SetBoolean stored FALSE;
  end;

  TcxCacheInfo = class(TPersistent)
  private
    { Private declarations }
    FLevel1Data: LongInt;
    FLevel1Code: LongInt;
    FLevel1: LongInt;
    FLevel2: LongInt;
    procedure SetLongInt(AValue: LongInt);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  published
    { Published declarations }
    property L1Data: LongInt read FLevel1Data write SetLongInt stored FALSE;
    property L1Code: LongInt read FLevel1Code write SetLongInt stored FALSE;
    property Level1: LongInt read FLevel1 write SetLongInt stored FALSE;
    property Level2: LongInt read FLevel2 write SetLongInt stored FALSE;
  end;

  TcxCPU2000 = class(TComponent)
  private
    { Private declarations }
    FAutoBench: TcxAutoBench;
    FCache: TcxCacheInfo;
    FCount: LongInt;
    FCPUID: TcxCPUID;
    FResults: TcxDetectedInfo;
    FFeatureSet: TcxFeatureSet;
    FFeatureSetEx: TcxExFeatureSet;
    FCPUName: String;
    FFDivBug: Boolean;
    FFullName: String;
    FOverDrive: Boolean;
    FMMX: Boolean;
    FSpeed: LongInt;
    FSerial: String;
    FVendor: String;
    FVersion: TcxCpu2kVersionInfo;
    procedure SetBoolean(AValue: Boolean);
    procedure SetLongInt(AValue: LongInt);
    procedure SetString(AValue: String);
  protected
    { Protected declarations }
    procedure Loaded; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Identify;
    procedure IdentifyEx;
    procedure IdentifyCache;

    procedure GetSpeedEx(ADelay: LongInt);
    procedure GetSpeed;
  published
    { Published declarations }
    property AutoBench: TcxAutoBench read FAutoBench write FAutoBench;
    property Cache: TcxCacheInfo read FCache write FCache stored FALSE;
    property Count: LongInt read FCount write SetLongInt stored FALSE;
    property CPU: String read FCPUName write SetString stored FALSE;
    property CPUID: TcxCPUID read FCPUID write FCPUID stored FALSE;
    property FDivBug: Boolean read FFDivBug write SetBoolean stored FALSE;
    property FeatureSet: TcxFeatureSet read FFeatureSet write FFeatureSet stored FALSE;
    property FeatureSetEx: TcxExFeatureSet read FFeatureSetEx write FFeatureSetEx stored FALSE;
    property FullName: String read FFullName write SetString stored FALSE;
    property InternalResults: TcxDetectedInfo read FResults write FResults stored FALSE;
    property MMX: Boolean read FMMX write SetBoolean stored FALSE;
    property OverDrive: Boolean read FOverDrive write SetBoolean stored FALSE;
    property Serial: String read FSerial write SetString stored FALSE;
    property Speed: LongInt read FSpeed write SetLongInt stored FALSE;
    property Vendor: String read FVendor write SetString stored FALSE;
    property VersionInfo: TcxCpu2kVersionInfo read FVersion write FVersion stored FALSE;
  end;

  function GetVclVersionInfo: TcxVersionInfoStruct;

implementation

  { Internal version information ************************************}
  function GetVclVersionInfo: TcxVersionInfoStruct;
  begin
    Result.Product := 'CarbonSoft cxCpu2000 Vcl Extension';
    Result.Copyright := 'Copyright © 1995-2000 CarbonSoft';
    Result.Version := 3.0;
    Result.Build := 44;
    Result.Status := bsFinal;
    Result.Release := rsPublic;
  end;


  { TcxAutoBench ****************************************************}
  constructor TcxAutoBench.Create;
  begin
    inherited Create;

    FEnabled := FALSE;
    FDelay := BENCHMARK_DELAY;
  end;

  destructor TcxAutoBench.Destroy;
  begin
    inherited Destroy;
  end;

  { TcxCppu2kVersionInfo ********************************************}
  constructor TcxCpu2kVersionInfo.Create;
  begin
    inherited Create;

    FAPI := TcxVersionInfo.Create;
    FVCL := TcxVersionInfo.Create;
    Init;
  end;

  destructor TcxCpu2kVersionInfo.Destroy;
  begin
    FAPI.Free;
    FVCL.Free;

    inherited Destroy;
  end;

  procedure TcxCpu2kVersionInfo.Init;
  var
    VCL: TcxVersionInfoStruct;
    API: TcxVersionInfoStruct;
  begin
    API := GetAPIVersionInfo;
    FAPI.Init(API.Copyright,
              API.Product,
              API.Version,
              API.Build,
              API.Status,
              API.Release);
    Vcl := GetVclVersionInfo;
    FVCL.Init(VCL.Copyright,
              VCL.Product,
              VCL.Version,
              VCL.Build,
              VCL.Status,
              VCL.Release);
  end;

  { TcxCPUID  *******************************************************}
  constructor TcxCPUID.Create;
  begin
    inherited Create;
    Init;
  end;

  destructor TcxCPUID.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TcxCPUID.SetBoolean(AValue: Boolean);
  begin
    { Do nothing }
  end;

  procedure TcxCPUID.SetLongInt(AValue: LongInt);
  begin
    { Do nothing }
  end;

  procedure TcxCPUID.Init;
  var
    CPUIDInfo: TCPUIDInfo;
  begin
    CPUIDInfo.dwSize := SizeOf(TCPUIDInfo);
    CPUIDInfo.iProcessor := USE_DEFAULT;

    if (cxGetCPUIDInfo(CPUIDInfo) = ERR_NOERROR) then begin
      FSupported := CPUIDInfo.bAvailable;
      FMaxLevel := CPUIDInfo.iMaxLevel;
      FMaxLevelEx := CPUIDInfo.iMaxExLevel;
    end else
      FMaxLevel := cxCpu2kAPI.CPUID_LastError;
  end;

  { TcxDetectedInfo *************************************************}
  constructor TcxDetectedInfo.Create;
  begin
    inherited Create;
    Init;
  end;

  destructor TcxDetectedInfo.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TcxDetectedInfo.SetLongInt(AValue: LongInt);
  begin
    { Do nothing }
  end;

  procedure TcxDetectedInfo.SetString(AValue: String);
  begin
    { Do nothing }
  end;

  procedure TcxDetectedInfo.Init;
  var
    SignatureInfo: TSignatureInfo;
  begin
    SignatureInfo.dwSize := SizeOf(TSignatureInfo);
    SignatureInfo.iProcessor := USE_DEFAULT;

    if (cxGetSignatureInfo(SignatureInfo) = ERR_NOERROR) then begin

      FSignature := SignatureInfo.iSignature;
      FType := SignatureInfo.iType;
      FFamily := SignatureInfo.iFamily;
      FFamilyEx := SignatureInfo.iFamilyEx;
      FModel := SignatureInfo.iModel;
      FModelEx := SignatureInfo.iModelEx;
      FStepping := SignatureInfo.iStepping;
      FBrandIdentifier := SignatureInfo.iBrand;

      FFeatureSet := cxGetStdFeatureSet(USE_DEFAULT);
      FFeatureSetEx := cxGetExtFeatureSet(USE_DEFAULT);
      FVendorString := String(cxGetVendorIdentification(USE_DEFAULT));
    end;
  end;

  { TcxFeatureSet ***************************************************}
  constructor TcxFeatureSet.Create;
  begin
    inherited Create;
    Init;
  end;

  destructor TcxFeatureSet.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TcxFeatureSet.SetBoolean(AValue: Boolean);
  begin
    { Do nothing }
  end;

  procedure TcxFeatureSet.Init;
  var
    FeatureSetInfo: TFeatureSetInfo;
  begin
    FeatureSetInfo.dwSize := SizeOf(TFeatureSetInfo);
    FeatureSetInfo.iProcessor := USE_DEFAULT;

    if (cxGetFeatureSetInfo(FeatureSetInfo) = ERR_NOERROR) then begin
      with FeatureSetInfo do begin
        FFPU     := bFPU;
        FVME     := bVME;
        FDE      := bDE;
        FPSE     := bPSE;
        FTSC     := bTSC;
        FMSR     := bMSR;
        FPAE     := bPAE;
        FMCE     := bMCE;
        FCX8     := bCX8;
        FAPIC    := bAPIC;
        FSEP     := bSEP;
        FMTRR    := bMTRR;
        FPGE     := bPGE;
        FMCA     := bMCA;
        FCMOV    := bCMOV;
        FPAT     := bPAT;
        FPSE36   := bPSE36;
        FSERIAL  := bSERIAL;
        FMMX     := bMMX;
        FXSR     := bXSR;
        FSIMD    := bSIMD;
        FSIMD2   := bSIMD2;
        FDTS     := bDTS;
        FACPI    := bACPI;
        FSS      := bSS;
        FTM      := bTM;
        FCLFLUSH := bCLFLUSH;
      end;
    end;
  end;

  { TcxFeatureSet ***************************************************}
  constructor TcxExFeatureSet.Create;
  begin
    inherited Create;
    Init;
  end;

  destructor TcxExFeatureSet.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TcxExFeatureSet.SetBoolean(AValue: Boolean);
  begin
    { Do nothing }
  end;

  procedure TcxExFeatureSet.Init;
  var
    FeatureSetInfo: TFeatureSetInfo;
  begin
    FeatureSetInfo.dwSize := SizeOf(TFeatureSetInfo);
    FeatureSetInfo.iProcessor := USE_DEFAULT;

    if (cxGetFeatureSetInfo(FeatureSetInfo) = ERR_NOERROR) then begin
      with FeatureSetInfo do begin
        FEXMMX    := bEXMMX;
        F3DNOW    := b3DNOW;
        FEX3DNOW  := bEX3DNOW;
      end;
    end;
  end;

  { TcxCacheInfo ****************************************************}
  constructor TcxCacheInfo.Create;
  begin
    inherited Create;
  end;

  destructor TcxCacheInfo.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TcxCacheInfo.SetLongInt(AValue: LongInt);
  begin
    { Do nothing }
  end;

  { TcxCPU2000 ******************************************************}

  constructor TcxCPU2000.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);

    FAutoBench := TcxAutoBench.Create;
    FCPUID := TcxCPUID.Create;
    FResults := TcxDetectedInfo.Create;
    FFeatureSet := TcxFeatureSet.Create;
    FFeatureSetEx := TcxExFeatureSet.Create;
    FVersion := TcxCpu2kVersionInfo.Create;
    FCache := TcxCacheInfo.Create;

    FCount := cxGetProcessorCount;
    FFDivBug := cxGetFDIVBugPresent(USE_DEFAULT);
    FOverDrive := cxGetOverDriveFlag(USE_DEFAULT);
    FMMX := cxGetMMXSupport(USE_DEFAULT);

    { Prevent bugged mobile PIIs and Celerons returning garbage }
    if (cxGetProcessorModel(USE_DEFAULT) >= CPU_PENTIUMIIIMODEL) and
       (cxGetStdFeatureSupportEx(USE_DEFAULT, SFS_SERIAL)) then
      FSerial := cxGetSerialNumber(USE_DEFAULT);

    Identify;
    IdentifyCache;
  end;

  destructor TcxCPU2000.Destroy;
  begin
    FCache.Free;
    FVersion.Free;
    FFeatureSetEx.Free;
    FFeatureSet.Free;
    FResults.Free;
    FCPUID.Free;
    FAutoBench.Free;

    inherited Destroy;
  end;

  procedure TcxCPU2000.SetBoolean(AValue: Boolean);
  begin
    { Do nothing }
  end;

  procedure TcxCPU2000.SetLongInt(AValue: LongInt);
  begin
    { Do nothing }
  end;

  procedure TcxCPU2000.SetString(AValue: String);
  begin
    { Do nothing }
  end;

  procedure TcxCPU2000.Loaded;
  begin
    if (AutoBench.Enabled) then
      GetSpeedEx(AutoBench.Delay);
    if (FCPUID.FMaxLevelEx >= 4) then IdentifyEx;
  end;

  procedure TcxCPU2000.Identify;
  begin
    FVendor := cxGetVendorName(USE_DEFAULT);
    FCPUName := cxGetProcessorName(USE_DEFAULT);
    FFullName := cxGetProcessorFullName(USE_DEFAULT);
  end;

  procedure TcxCpu2000.IdentifyEx;
  begin
    if (FCPUID.FMaxLevelEx >= 4) then
      FFullName := cxGetMarketingName(USE_DEFAULT);
  end;

  procedure TcxCpu2000.IdentifyCache;
  var
    CacheInfo: TCacheInfo;
  begin
    CacheInfo.dwSize := SizeOf(TCacheInfo);
    CacheInfo.iProcessor := USE_DEFAULT;

    if (cxGetCacheInfo(CacheInfo) = ERR_NOERROR) then begin
      FCache.FLevel1Data := CacheInfo.iLevel1Data;
      FCache.FLevel1Code := CacheInfo.iLevel1Code;
      FCache.FLevel1 := CacheInfo.iLevel1;
      FCache.FLevel2 := CacheInfo.iLevel2;
    end;
  end;

  procedure TcxCpu2000.GetSpeedEx(ADelay: LongInt);
  begin
    FSpeed := cxGetNormalisedProcessorSpeed(USE_DEFAULT, ADelay);
  end;

  procedure TcxCpu2000.GetSpeed;
  begin
    GetSpeedEx(BENCHMARK_DELAY);
  end;

end.
