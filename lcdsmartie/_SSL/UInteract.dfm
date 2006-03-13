object TransitionConfigForm: TTransitionConfigForm
  Left = 449
  Top = 102
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Transition config'
  ClientHeight = 150
  ClientWidth = 222
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
    Top = 16
    Width = 188
    Height = 13
    Caption = 'Here can you set the transition between'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 169
    Height = 13
    Caption = 'the current screen and the next one'
  end
  object Label3: TLabel
    Left = 8
    Top = 60
    Width = 73
    Height = 13
    Caption = 'Transition &style:'
    FocusControl = TransitionStyleComboBox
  end
  object Label4: TLabel
    Left = 8
    Top = 92
    Width = 134
    Height = 13
    Caption = 'Transition &time:(1/10th secs)'
    FocusControl = TransitionTimeSpinEdit
  end
  object TransitionStyleComboBox: TComboBox
    Left = 89
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
    OnChange = TransitionStyleComboBoxChange
    Items.Strings = (
      'None'
      'Left->Right'
      'Right->Left'
      'Top->Bottom'
      'Bottom->Top'
      'Random chars'
      'Contrast fade light')
  end
  object TransitionTimeSpinEdit: TSpinEdit
    Left = 156
    Top = 88
    Width = 57
    Height = 22
    MaxLength = 2
    MaxValue = 99
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object OKButton: TButton
    Left = 56
    Top = 120
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelButton: TButton
    Left = 140
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
