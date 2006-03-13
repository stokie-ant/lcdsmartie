object CrystalFontzSetupForm: TCrystalFontzSetupForm
  Left = 515
  Top = 32
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Crystalfontz settings'
  ClientHeight = 179
  ClientWidth = 179
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    179
    179)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 8
    Top = 6
    Width = 166
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
      166
      49)
    object ContrastTrackBar: TTrackBar
      Left = 4
      Top = 18
      Width = 157
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      LineSize = 2
      Max = 100
      Frequency = 4
      TabOrder = 0
      ThumbLength = 15
      OnChange = ContrastTrackBarChange
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 62
    Width = 166
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Backlight'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      166
      49)
    object BacklightTrackBar: TTrackBar
      Left = 4
      Top = 20
      Width = 157
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      LineSize = 2
      Max = 100
      Frequency = 4
      TabOrder = 0
      ThumbLength = 15
      OnChange = BacklightTrackBarChange
    end
  end
  object OKButton: TButton
    Left = 12
    Top = 152
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object V2CGROMCheckbox: TCheckBox
    Left = 8
    Top = 120
    Width = 105
    Height = 17
    Hint = 
      'If the @ symbol (and others) aren'#39't displaying correctly, change' +
      ' this.'
    Caption = 'v2 character set'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = V2CGROMCheckboxClick
  end
  object CancelButton: TButton
    Left = 96
    Top = 152
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
