object Form7: TForm7
  Left = 523
  Top = 163
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Interaction config'
  ClientHeight = 150
  ClientWidth = 222
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 210
    Height = 13
    Caption = 'Here can you config the interaction between'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 173
    Height = 13
    Caption = 'The current screen and the next one'
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 77
    Height = 13
    Caption = 'Interaction style:'
  end
  object Label4: TLabel
    Left = 8
    Top = 96
    Width = 138
    Height = 13
    Caption = 'Interaction time:(1/10th secs)'
  end
  object ComboBox10: TComboBox
    Left = 96
    Top = 56
    Width = 123
    Height = 21
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnChange = ComboBox10Change
    Items.Strings = (
      'None'
      'Left->Right'
      'Right->Left'
      'Top->Bottom'
      'Bottom->Top'
      'Random chars'
      'Contrast fade light')
  end
  object SpinEdit1: TSpinEdit
    Left = 160
    Top = 88
    Width = 57
    Height = 22
    MaxLength = 2
    MaxValue = 99
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object Button1: TButton
    Left = 144
    Top = 120
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
end
