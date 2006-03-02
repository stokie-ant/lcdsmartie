unit UDLLSetup;
{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/UDLLSetup.pas,v $
 *  $Revision: 1.1 $ $Date: 2006/03/02 21:44:20 $
 *****************************************************************************}


interface

uses StdCtrls, ComCtrls, Classes, Controls, Forms;

type
  TDisplayPluginSetupForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    ContrastTrackBar: TTrackBar;
    BrightnessTrackBar: TTrackBar;
    Label1: TLabel;
    ParametersEdit: TEdit;
    DisplayPluginsLabel: TLabel;
    DisplayPluginList: TComboBox;
    HintLabel: TLabel;
    procedure ContrastTrackBarChange(Sender: TObject);
    procedure BrightnessTrackBarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DisplayPluginListChange(Sender: TObject);
  private
    { Private declarations }
    DLLPath : string;
    procedure LoadHint(DisplayDLLName : string);
  public
    { Public declarations }
  end;

function DoDLLSetupForm : boolean;

implementation

uses
  Windows, SysUtils, USetup, UConfig, UMain;

{$R *.DFM}

function DoDLLSetupForm : boolean;
var
  DisplayPluginSetupForm : TDisplayPluginSetupForm;
begin
  DisplayPluginSetupForm := TDisplayPluginSetupForm.Create(nil);
  with DisplayPluginSetupForm do begin
    ShowModal;
    Result := (ModalResult = mrOK);
    if Result then begin
      config.DLL_contrast := ContrastTrackBar.position;
      config.DLL_brightness := BrightnessTrackBar.position;
      config.DisplayDLLParameters := ParametersEdit.Text;
      config.DisplayDLLName := DisplayPluginList.Text;
    end else begin
      if (config.ScreenType = stDLL) then begin
        LCDSmartieDisplayForm.lcd.setContrast(config.DLL_contrast);
        LCDSmartieDisplayForm.lcd.setBrightness(config.DLL_brightness);
      end;
    end;
    Free;
  end;
end;

// DLL options - contrast bar.
procedure TDisplayPluginSetupForm.ContrastTrackBarChange(Sender: TObject);
begin
  if (config.ScreenType = stDLL) then
    LCDSmartieDisplayForm.lcd.setContrast(ContrastTrackBar.position);
end;

// DLL options - brightness bar.
procedure TDisplayPluginSetupForm.BrightnessTrackBarChange(Sender: TObject);
begin
  if (config.ScreenType = stDLL) then
    LCDSmartieDisplayForm.lcd.setBrightness(BrightnessTrackBar.position);
end;

procedure TDisplayPluginSetupForm.LoadHint(DisplayDLLName : string);
type
  TUsageFunc = function : pchar; stdcall;
var
  MyDLL : HMODULE;
  UsageFunc : TUsageFunc;
begin
  HintLabel.Caption := '';
  if FileExists(DisplayDLLName) then begin
    try
      MyDLL := LoadLibrary(pchar(DisplayDLLName));
      if not (MyDll = 0) then begin
        UsageFunc := GetProcAddress(MyDLL,pchar('DISPLAYDLL_Usage'));
        if assigned(UsageFunc) then
          HintLabel.Caption := 'Hint: '+ string(UsageFunc);
        FreeLibrary(MyDLL);
      end;
    except
    end;
  end;
end;

procedure TDisplayPluginSetupForm.FormShow(Sender: TObject);
var
  SR : TSearchRec;
  Loop,FindResult : integer;
begin
  // put settings on screen
  ContrastTrackBar.position := config.DLL_contrast;
  BrightnessTrackBar.position := config.DLL_brightness;
  ParametersEdit.Text := config.DisplayDLLParameters;
  DLLPath := extractfilepath(paramstr(0))+'displays\';
  FindResult := findfirst(DLLPath+'*.dll',0,SR);
  while (FindResult = 0) do begin
    DisplayPluginList.Items.Add(extractfilename(SR.Name));
    FindResult := FindNext(SR);
  end;
  DisplayPluginList.ItemIndex := 0;
  for Loop := 0 to DisplayPluginList.Items.Count-1 do begin
    if lowercase(config.DisplayDLLName) = lowercase(DisplayPluginList.Items[Loop]) then begin
      DisplayPluginList.ItemIndex := Loop;
      LoadHint(DLLPath+config.DisplayDLLName);
    end;
  end;
  findclose(SR);
end;

procedure TDisplayPluginSetupForm.DisplayPluginListChange(Sender: TObject);
begin
  LoadHint(DLLPath+DisplayPluginList.Text);
end;

end.
