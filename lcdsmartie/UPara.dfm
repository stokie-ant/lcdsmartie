object HD44780SetupForm: THD44780SetupForm
  Left = 312
  Top = 252
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'HD44780 Settings'
  ClientHeight = 201
  ClientWidth = 176
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 20
    Width = 22
    Height = 13
    Caption = '&Port:'
    FocusControl = PortEdit
  end
  object Label2: TLabel
    Left = 8
    Top = 57
    Width = 97
    Height = 13
    Caption = '&Driver boot delay: (s)'
    FocusControl = BootDelaySpinEdit
  end
  object Label3: TLabel
    Left = 8
    Top = 93
    Width = 77
    Height = 13
    Caption = '&Timing multiplier:'
    FocusControl = TimingMultiplierSpinEdit
  end
  object PortEdit: TEdit
    Left = 120
    Top = 16
    Width = 49
    Height = 21
    TabOrder = 0
    Text = 'PortEdit'
  end
  object BootDelaySpinEdit: TSpinEdit
    Left = 120
    Top = 52
    Width = 49
    Height = 22
    EditorEnabled = False
    MaxLength = 2
    MaxValue = 30
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object OKButton: TButton
    Left = 8
    Top = 168
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object AltAddressingCheckbox: TCheckBox
    Left = 8
    Top = 112
    Width = 153
    Height = 25
    Hint = 'Some displays (esp the 1x16s) are addressed differently.'
    Caption = '&Fix 16x1 line addressing'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object TimingMultiplierSpinEdit: TSpinEdit
    Left = 120
    Top = 88
    Width = 49
    Height = 22
    Hint = 
      'Some displays need longer to do a command - set this to 5 if you' +
      #39're having trouble.'
    EditorEnabled = False
    MaxLength = 2
    MaxValue = 5
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 1
  end
  object CancelButton: TButton
    Left = 92
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object KS0073AddressingCheckbox: TCheckBox
    Left = 8
    Top = 136
    Width = 153
    Height = 25
    Hint = 'Some displays (esp the 1x16s) are addressed differently.'
    Caption = 'Use &KS0073 addressing'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
  end
end
