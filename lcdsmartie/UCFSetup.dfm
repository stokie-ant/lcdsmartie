object Form5: TForm5
  Left = 787
  Top = 125
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Crystalfontz settings'
  ClientHeight = 179
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 8
    Top = 6
    Width = 177
    Height = 49
    Caption = 'Contrast'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 62
    Width = 177
    Height = 49
    Caption = 'Backlight'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object TrackBar2: TTrackBar
    Left = 9
    Top = 78
    Width = 173
    Height = 25
    LineSize = 2
    Max = 100
    Frequency = 4
    TabOrder = 2
    ThumbLength = 15
    OnChange = TrackBar2Change
  end
  object TrackBar1: TTrackBar
    Left = 10
    Top = 22
    Width = 173
    Height = 25
    LineSize = 2
    Max = 100
    Frequency = 4
    TabOrder = 3
    ThumbLength = 15
    OnChange = TrackBar1Change
  end
  object Button1: TButton
    Left = 112
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 4
    OnClick = Button1Click
  end
  object v2cgrom: TCheckBox
    Left = 8
    Top = 120
    Width = 105
    Height = 17
    Caption = 'v2 character set'
    TabOrder = 5
  end
end
