object Form6: TForm6
  Left = 530
  Top = 13
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'HD44780 Settings'
  ClientHeight = 197
  ClientWidth = 175
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object Label2: TLabel
    Left = 8
    Top = 61
    Width = 97
    Height = 13
    Caption = 'Driver boot delay: (s)'
  end
  object Label3: TLabel
    Left = 8
    Top = 97
    Width = 77
    Height = 13
    Caption = 'Timing multiplier:'
  end
  object Edit1: TEdit
    Left = 120
    Top = 16
    Width = 49
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object SpinEdit1: TSpinEdit
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
  object Button1: TButton
    Left = 96
    Top = 168
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object AltAddressing: TCheckBox
    Left = 8
    Top = 136
    Width = 153
    Height = 25
    Caption = 'Use alternative addressing'
    TabOrder = 3
  end
  object SpinEdit2: TSpinEdit
    Left = 120
    Top = 88
    Width = 49
    Height = 22
    EditorEnabled = False
    MaxLength = 2
    MaxValue = 5
    MinValue = 0
    TabOrder = 4
    Value = 1
  end
end
