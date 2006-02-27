object MatrixOrbitalSetupForm: TMatrixOrbitalSetupForm
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
  Position = poScreenCenter
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
    TabOrder = 0
    object ContrastTrackBar: TTrackBar
      Left = 1
      Top = 15
      Width = 149
      Height = 25
      Max = 255
      Frequency = 10
      TabOrder = 0
      ThumbLength = 15
      OnChange = ContrastTrackBarChange
    end
  end
  object OKButton: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelButton: TButton
    Left = 88
    Top = 144
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
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
    TabOrder = 1
    object BrightnessTrackBar: TTrackBar
      Left = 1
      Top = 16
      Width = 149
      Height = 25
      Max = 255
      Frequency = 10
      TabOrder = 0
      ThumbLength = 15
      OnChange = BrightnessTrackBarChange
    end
  end
  object MOUSBCheckbox: TCheckBox
    Left = 8
    Top = 120
    Width = 153
    Height = 17
    Caption = '202-&USB MX3 connected'
    TabOrder = 2
    Visible = False
  end
end
