object LCDLineFrame: TLCDLineFrame
  Left = 0
  Top = 0
  Width = 160
  Height = 18
  TabOrder = 0
  Visible = False
  object LCDPanel: TPanel
    Left = 0
    Top = 0
    Width = 160
    Height = 18
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object PaintBox: TPaintBox
      Left = 0
      Top = 0
      Width = 160
      Height = 18
      Align = alClient
      OnPaint = PaintBoxPaint
    end
  end
end
