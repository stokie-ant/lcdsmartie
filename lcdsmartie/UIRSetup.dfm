object IRTransForm: TIRTransForm
  Left = 426
  Top = 349
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'IRTrans settings'
  ClientHeight = 142
  ClientWidth = 167
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    167
    142)
  PixelsPerInch = 96
  TextHeight = 13
  object Host: TLabel
    Left = 8
    Top = 60
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object OKButton: TButton
    Left = 8
    Top = 114
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 88
    Top = 114
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 153
    Height = 49
    Caption = 'Brightness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object IRBrightnessTrackBar: TTrackBar
      Left = 4
      Top = 16
      Width = 145
      Height = 25
      Max = 3
      PageSize = 1
      TabOrder = 0
      ThumbLength = 15
      OnChange = IRBrightnessTrackBarChange
    end
  end
  object HostEdit: TEdit
    Left = 8
    Top = 76
    Width = 153
    Height = 21
    TabOrder = 3
  end
end
