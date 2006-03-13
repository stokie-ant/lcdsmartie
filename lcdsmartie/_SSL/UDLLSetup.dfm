object DisplayPluginSetupForm: TDisplayPluginSetupForm
  Left = 349
  Top = 222
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Display Plugin settings'
  ClientHeight = 274
  ClientWidth = 229
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    229
    274)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 168
    Width = 116
    Height = 13
    Caption = 'Startup Parameters:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DisplayPluginsLabel: TLabel
    Left = 8
    Top = 104
    Width = 81
    Height = 13
    Caption = 'Display Plugin:'
  end
  object UsageLabel: TLabel
    Left = 8
    Top = 208
    Width = 31
    Height = 13
    Caption = 'Usage'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object IDLabel: TLabel
    Left = 8
    Top = 144
    Width = 63
    Height = 13
    Caption = 'DLL Identifier'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 0
    Width = 215
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Contrast'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      215
      49)
    object ContrastTrackBar: TTrackBar
      Left = 1
      Top = 15
      Width = 211
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Max = 254
      Min = 1
      Frequency = 10
      Position = 1
      TabOrder = 0
      ThumbLength = 15
      OnChange = ContrastTrackBarChange
    end
  end
  object OKButton: TButton
    Left = 36
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&OK'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
  end
  object CancelButton: TButton
    Left = 120
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 52
    Width = 215
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Brightness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      215
      49)
    object BrightnessTrackBar: TTrackBar
      Left = 1
      Top = 16
      Width = 211
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Max = 254
      Min = 1
      Frequency = 10
      Position = 1
      TabOrder = 0
      ThumbLength = 15
      OnChange = BrightnessTrackBarChange
    end
  end
  object ParametersEdit: TEdit
    Left = 8
    Top = 184
    Width = 209
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Text = 'ParametersEdit'
  end
  object DisplayPluginList: TComboBox
    Left = 8
    Top = 120
    Width = 213
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    OnChange = DisplayPluginListChange
  end
end
