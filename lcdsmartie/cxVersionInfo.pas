{********************************************************************************}
{ The contents of this file are subject to the Mozilla Public License Version    }
{ 1.1 (the "License"); you may not use this file except in compliance with the   }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/   }
{                                                                                }
{ Software distributed under the License is distributed on an "AS IS" basis,     }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for   }
{ the specific language governing rights and limitations under the License.      }
{                                                                                }
{ The Original Code is cxVersionInfo.pas,                                        }
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
unit cxVersionInfo;

interface

uses Windows, Classes;

type
  TReleaseStatus = (rsPrivate, rsPublic);
  TBuildStatus = (bsAlpha, bsBeta, bsFinal);

  TcxVersionInfo = class(TPersistent)
  private
    { Private declarations }
    FCopyright: String;
    FProductName: String;
    FProductVersion: Single;
    FProductBuild: LongInt;
    FProductStatus: TBuildStatus;
    FReleaseStatus: TReleaseStatus;
    procedure SetString(AValue: String);
    procedure SetSingle(AValue: Single);
    procedure SetLongInt(AValue: LongInt);
    procedure SetBuildStatus(AValue: TBuildStatus);
    procedure SetReleaseStatus(AValue: TReleaseStatus);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Init(ACopyright, AProduct: String; AVersion: Single; ABuild: LongInt;
                   AStatus: TBuildStatus; ARelease: TReleaseStatus);
  published
    { Published declarations }
    property Copyright: String read FCopyright write SetString;
    property Product: String read FProductName write SetString;
    property Version: Single read FProductVersion write SetSingle;
    property Build: LongInt read FProductBuild write SetLongInt;
    property Status: TBuildStatus read FProductStatus write SetBuildStatus;
    property Release: TReleaseStatus read FReleaseStatus write SetReleaseStatus;
  end;

  TcxVersionInfoStruct = packed record
    Copyright: String;
    Product: String;
    Version: Single;
    Build: LongInt;
    Status: TBuildStatus;
    Release: TReleaseStatus;
  end;

const
  ReleaseTypes: array[rsPrivate..rsPublic] of String = ('Private ', 'Public');
  BuildTypes: array[bsAlpha..bsFinal] of String = ('Alpha ', 'Beta ', 'Final');

implementation

  { TcxVersionInfo **************************************************}
  constructor TcxVersionInfo.Create;
  begin
    inherited Create;
  end;

  destructor TcxVersionInfo.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TcxVersionInfo.SetString(AValue: String);
  begin
    { Do nothing }
  end;

  procedure TcxVersionInfo.SetSingle(AValue: Single);
  begin
    { Do nothing }
  end;

  procedure TcxVersionInfo.SetLongInt(AValue: LongInt);
  begin
    { Do nothing }
  end;

  procedure TcxVersionInfo.SetBuildStatus(AValue: TBuildStatus);
  begin
    { Do nothing }
  end;

  procedure TcxVersionInfo.SetReleaseStatus(AValue: TReleaseStatus);
  begin
    { Do nothing }
  end;

  procedure TcxVersionInfo.Init(ACopyright, AProduct: String; AVersion: Single; ABuild: LongInt;
                                AStatus: TBuildStatus; ARelease: TReleaseStatus);
  begin
    FCopyright := ACopyright;
    FProductName := AProduct;
    FProductVersion := AVersion;
    FProductBuild := ABuild;
    FProductStatus := AStatus;
    FReleaseStatus := ARelease;
  end;

end.
