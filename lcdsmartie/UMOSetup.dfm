object Form3: TForm3
  Left = 536
  Top = 38
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Matrix Orbital settings'
  ClientHeight = 172
  ClientWidth = 167
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 153
    Height = 49
    Caption = 'Contrast'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 144
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object TrackBar1: TTrackBar
    Left = 10
    Top = 23
    Width = 149
    Height = 25
    Max = 255
    Frequency = 10
    TabOrder = 2
    ThumbLength = 15
    OnChange = TrackBar1Change
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 64
    Width = 153
    Height = 49
    Caption = 'Brightness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object TrackBar2: TTrackBar
    Left = 10
    Top = 80
    Width = 149
    Height = 25
    Max = 255
    Frequency = 10
    TabOrder = 5
    ThumbLength = 15
    OnChange = TrackBar2Change
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 120
    Width = 153
    Height = 17
    Caption = '202-USB MX3 connected'
    TabOrder = 6
    Visible = False
  end
end
