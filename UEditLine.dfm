object FormEdit: TFormEdit
  Left = 696
  Top = 643
  Width = 294
  Height = 180
  BorderStyle = bsSizeToolWin
  Caption = 'Edit LCD line'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = EditClose
  DesignSize = (
    278
    141)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 286
    Height = 116
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkFlat
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 0
  end
  object BtnOk: TButton
    Left = 147
    Top = 116
    Width = 65
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 214
    Top = 116
    Width = 64
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
