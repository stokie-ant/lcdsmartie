object LCDSmartieDisplayForm: TLCDSmartieDisplayForm
  Left = 368
  Top = 240
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'LCD Smartie 5.3'
  ClientHeight = 191
  ClientWidth = 228
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BarLeftImage: TImage
    Left = 0
    Top = 64
    Width = 97
    Height = 27
  end
  object BarMiddleImage: TImage
    Left = 88
    Top = 64
    Width = 25
    Height = 27
  end
  object BarRightImage: TImage
    Left = 108
    Top = 64
    Width = 97
    Height = 27
  end
  object LogoImage: TImage
    Left = 196
    Top = 64
    Width = 32
    Height = 27
    Hint = 'Access menu'
    ParentShowHint = False
    ShowHint = True
    OnClick = LogoImageClick
    OnDblClick = LogoImageDblClick
  end
  object Line1RightScrollImage: TImage
    Left = 16
    Top = 0
    Width = 16
    Height = 16
    Hint = 'Scroll line right.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line1RightScrollImageMouseDown
    OnMouseUp = Line1RightScrollImageMouseUp
  end
  object Line2RightScrollImage: TImage
    Left = 16
    Top = 16
    Width = 16
    Height = 16
    Hint = 'Scroll line right.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line2RightScrollImageMouseDown
    OnMouseUp = Line2RightScrollImageMouseUp
  end
  object Line3RightScrollImage: TImage
    Left = 16
    Top = 32
    Width = 16
    Height = 16
    Hint = 'Scroll line right.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line3RightScrollImageMouseDown
    OnMouseUp = Line3RightScrollImageMouseUp
  end
  object Line4RightScrollImage: TImage
    Left = 16
    Top = 48
    Width = 16
    Height = 16
    Hint = 'Scroll line right.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line4RightScrollImageMouseDown
    OnMouseUp = Line4RightScrollImageMouseUp
  end
  object Line1LeftScrollImage: TImage
    Left = 193
    Top = 0
    Width = 16
    Height = 17
    Hint = 'Scroll line left.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line1LeftScrollImageMouseDown
    OnMouseUp = Line1LeftScrollImageMouseUp
  end
  object Line2LeftScrollImage: TImage
    Left = 193
    Top = 16
    Width = 16
    Height = 16
    Hint = 'Scroll line left.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line2LeftScrollImageMouseDown
    OnMouseUp = Line2LeftScrollImageMouseUp
  end
  object Line3LeftScrollImage: TImage
    Left = 193
    Top = 32
    Width = 16
    Height = 16
    Hint = 'Scroll line left.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line3LeftScrollImageMouseDown
    OnMouseUp = Line3LeftScrollImageMouseUp
  end
  object Line4LeftScrollImage: TImage
    Left = 193
    Top = 48
    Width = 16
    Height = 16
    Hint = 'Scroll line left.'
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = Line4LeftScrollImageMouseDown
    OnMouseUp = Line4LeftScrollImageMouseUp
  end
  object NextScreenImage: TImage
    Left = 208
    Top = 0
    Width = 16
    Height = 64
    Hint = 'Next Screen.'
    ParentShowHint = False
    ShowHint = True
    OnClick = NextScreenImageClick
    OnMouseDown = NextScreenImageMouseDown
    OnMouseUp = NextScreenImageMouseUp
  end
  object PreviousImage: TImage
    Left = 0
    Top = 0
    Width = 16
    Height = 64
    Hint = 'Previous Screen.'
    ParentShowHint = False
    ShowHint = True
    OnClick = PreviousImageClick
    OnMouseDown = PreviousImageMouseDown
    OnMouseUp = PreviousImageMouseUp
  end
  object SetupImage: TImage
    Left = 10
    Top = 69
    Width = 34
    Height = 16
    Hint = 'Configure the display and/or screen content/layout.'
    ParentShowHint = False
    ShowHint = True
    OnClick = SetupButtonClick
    OnMouseDown = SetupImageMouseDown
    OnMouseUp = SetupImageMouseUp
  end
  object HideImage: TImage
    Left = 165
    Top = 69
    Width = 32
    Height = 16
    Hint = 'Disappear! Will appear as an icon in the system tray.'
    ParentShowHint = False
    ShowHint = True
    OnClick = HideButtonClick
    OnMouseDown = HideImageMouseDown
    OnMouseUp = HideImageMouseUp
  end
  object SetupButton: TButton
    Left = 4
    Top = 92
    Width = 49
    Height = 17
    Caption = 'setup'
    TabOrder = 0
    TabStop = False
    OnClick = SetupButtonClick
  end
  object Line2Panel: TPanel
    Left = 32
    Top = 16
    Width = 161
    Height = 17
    Hint = 'Virtual display.'
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = clNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object Line3Panel: TPanel
    Left = 32
    Top = 32
    Width = 161
    Height = 17
    Hint = 'Virtual display.'
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = clNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object Line4Panel: TPanel
    Left = 32
    Top = 48
    Width = 161
    Height = 17
    Hint = 'Virtual display.'
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = clNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object HideButton: TButton
    Left = 156
    Top = 92
    Width = 49
    Height = 17
    Caption = 'hide'
    TabOrder = 1
    TabStop = False
    OnClick = HideButtonClick
  end
  object Line1Panel: TPanel
    Left = 32
    Top = 0
    Width = 161
    Height = 17
    Hint = 'Virtual display.'
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'LCD Smartie'
    Color = clNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
  end
  object ScreenNumberPanel: TPanel
    Left = 84
    Top = 72
    Width = 33
    Height = 17
    Hint = 'Active theme number, Active screen Number'
    BevelOuter = bvNone
    Caption = '1 | 1'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object PreviousButton: TButton
    Left = 56
    Top = 92
    Width = 51
    Height = 17
    Caption = 'Previous'
    TabOrder = 7
    OnClick = PreviousButtonClick
  end
  object NextButton: TButton
    Left = 108
    Top = 92
    Width = 45
    Height = 17
    Caption = 'Next'
    TabOrder = 8
    OnClick = NextButtonClick
  end
  object TimerRefresh: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerRefreshTimer
    Left = 164
    Top = 176
  end
  object HTTPUpdateTimer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = HTTPUpdateTimerTimer
    Left = 4
    Top = 144
  end
  object WinampCtrl1: TWinampCtrl
    FreeLists = True
    WinampLocation = 'C:\Program Files\Winamp\winamp.exe'
    Left = 4
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 68
    Top = 112
    object Commands1: TMenuItem
      Caption = 'Commands'
      object BacklightOn1: TMenuItem
        Caption = '&Backlight Off'
        OnClick = BacklightOn1Click
      end
      object Freeze1: TMenuItem
        Caption = 'Freeze'
        OnClick = Freeze1Click
      end
      object NextTheme1: TMenuItem
        Caption = 'Next Theme'
        OnClick = NextTheme1Click
      end
      object LastTheme1: TMenuItem
        Caption = 'Last Theme'
        OnClick = LastTheme1Click
      end
      object Credits1: TMenuItem
        Caption = 'Credits'
        OnClick = Credits1Click
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Configure1: TMenuItem
      Caption = 'Configure'
      OnClick = SetupButtonClick
    end
    object ShowWindow1: TMenuItem
      Caption = '&Show main'
      Default = True
      OnClick = ShowWindow1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = '&Close'
      OnClick = Close1Click
    end
  end
  object LeftManualScrollTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = LeftManualScrollTimerTimer
    Left = 68
    Top = 176
  end
  object RightManualScrollTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = RightManualScrollTimerTimer
    Left = 100
    Top = 176
  end
  object MBMUpdateTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = MBMUpdateTimerTimer
    Left = 36
    Top = 144
  end
  object NextScreenTimer: TTimer
    Enabled = False
    OnTimer = NextScreenTimerTimer
    Left = 132
    Top = 176
  end
  object CoolTrayIcon1: TCoolTrayIcon
    CycleInterval = 0
    Hint = 'LCD Smartie 5.3'
    Icon.Data = {
      0000010001002020000000000000A80800001600000028000000200000004000
      0000010008000000000080040000000000000000000000010000000000000000
      0000080000000008000008080000001000000000080000080800080808000000
      10000800100000100800000C1000001810000000180000081800000021001000
      0000180000002100000010080000180800001010000018100000100213002900
      0000230A0000310800003908000025140C0029230B0039100000452908000000
      29000000310000003900001336000D153600251C4300332B390044283B001020
      4C0018374A000D2E54001123730029294E00332B4F003933560039316B003D3D
      29002B394F001C4656002F3E58004239350055532C004E3B4900565744001647
      7E00295077003F3F7000325D76004C476300454078004A677B00487D87007B39
      0500833F160065413100813927008E4F0A007E741D007B4A31007B692B009C5D
      10009E572A009C731E00B27722009C842000B1841C00C5840800C3812700654C
      3F00645A53006B694C006F6F5700625A6B005F5F7E00646F67005E767E008343
      45009A73410091894100B3843F0077795800737F7B009F7A530086807600B190
      0000B18F1300A4902200B78E1C00CA8C0000CE910800C58C1B00C99A15009696
      3E00B3903F00739A78009A977100C08C2B00C2992D00BF974600C3A17000D694
      0000DA981200D4962500E1A22600DEA52900D2983400D1944500DAA34300D3A1
      4F00D19F5F00E1A85500E6AD6500E4AF6B00DAA47800E0BB7100EDBD80000833
      A4000E439A001831BD001047BD00484AA2003940B6002641C800443FC5001B60
      AF000E76B5003562B7003682AC00525AAC004E5EBE004E78A300576DBA000C41
      D6002137DA002939D6002339E9002F3BD6003139E700373DE0004439DB000D4F
      D300254BDC00185ADE001F74E6003E4FCE00354DE3004156E3004376D90008A5
      C000209EC50010B7C50023BEC5004C96A40050B0B40045A2CA0041B7CA0025AB
      E1002AC4D9004CC0D00048BFE00010CED60029D4E10037D2E0004CD6E50015B7
      EF002BA8F9000CCAF70025C9FA0036A7FF0041BBFB0031C8F70043C5F7001ED8
      F40022E6F50031D6F90034E1F80042CEEF004ACEFB0044D6F5004BDFFC006756
      B9005B4ED6006667AE00677EA60061B5BD0060BCD10060C3E1005DC3EF007E76
      A400799496008390BF007BBBC700BFB19400A4B3CC00E1BA9100F0B99C0077CA
      C1006CCECE0062D0DE0073CADE0065CEEC0064DCEA005AD6F90064D8FB008EC8
      AD008DCCCA0090CEDC008AD2ED00DED0A200F8D19400B0CEE600F0CEB3006BE2
      ED0062EDFF007BE5EF0081EFFF0097E1D30098E8ED008CFCFF00A9FFFF00EDE5
      B600D6F0DC00C3F2FB00ECECFF00C5FBFF00D6FCFF00E2FBFF00EFF7FF00FBE2
      AD00FDEAC300FFF4D000FFFFD600FFEBDE00FFFFDE00FFFCE900F7F7F700FFF7
      F700FBEFFF00F7F7FF00FFF7FF00EFFFFF00F7FFFF00FFFFF700FFFFFF009499
      9D9E9D86809FBDB3BBBDE3E0E6D2D2D5ABC53B0C374743434358585034C99691
      939D9D94809FB7B6BABCE0E6E3E3AAD5D3D13F30354143495858584234339491
      959595968288B5B5BDBCBFAAE3E2E6D2A6E4CD351F47404144464950362C8292
      959195978689C7BDD6B7D6E1AFE6E6D1E4D9D85A454948444040435842338292
      959591959D38A8C7C7BDBFAFE1D5E3E5EA565C476962634D48484143422C9C94
      879797958681C5DBC7D6BCBCD5D1E7E76A515269596D6D67634F49414236C187
      87C197918621082020BDBCE2080202E96A1414101C45616060756C4942C8C1C1
      849797869C20080D0FD6D70D0E0202045C101216161D4C6760665B4B595F2FC0
      87859D83810F06E2ABC70F0ED9D3DA045C011C4A69191E6367636C5B5B502284
      848D8083380D06AFAEE22008D3A7E2E45304196E4B1A197572766E4F595E2A2B
      388F8D888A0806AFADD60F0EE2BDAFD96A0414754B1A1975777E7C765B5E2839
      283DDE9FDB0D0EA7BAAE0F0ED3AAD204C904034A791A1A787B7A7EDD7E59293C
      2E2FCAEAD30D08ABB6BFAF0B0C0A0404D8050615151F6C78687B7FDDF0CE3F23
      543625CDDA0D0FD6B3B9A9AF040404D0D9040404154A746D6E787EDDDFF3A432
      3236263BDADBD4B6B2B2B2B9AEAAD1D5C46A5268626771637A7B7DCFDFDFC43F
      235426313FD3ABBAB0B8B9ACB9ACAEAFD1D83568606764726E797DCFCFE8CBC9
      24513C2D2C8ED4BDB3A9ACADB9A2ADAFA7E46A456261647474767DCECEDCC4C3
      33332E2E2C8E9FA8B7BABAA9ACBBBBAED7D06A45686171647376797E6FDCAAD0
      57323C3C2E8E8889A8BDB5B3B0B6B0A8D7C4D86A45606465717275787ECCA3DB
      CB24332C2FC28A8398B1B4B5B5B3B6B5C7CBE96B6862677065716D777ECEAEA7
      D03233313CC09C9A98839B9BB4B4B1B5C7C5CB5C4762744E4E67727A7A7DE1A7
      D0A4312E2FC28D99999A989A9A9B9BA18BA43330475A6C75664E72767C6FBEAA
      C4CB29313AC0C19C999C85838899998181392C2630595B4B754D4A6C5B6F0F07
      0CCB330E25C284C19C228D218D9C9F223821C32611505E1E5B4C1F5E1E1AE6E7
      EC0A3EEF0D3DCA8584EE0DEF208F8FEE08EE0D54F71950F61859F612FEF5C6CB
      CBEE05EF0D2E20C28CF705FD050F20EF0BEF0556F80136FE115EF611FE19DB0B
      00EA0EFF052DEB0F55FD01FEFDFAEBEF05FD0017F70034FF016BF610F61609E7
      ED07C9F90505FB0D55FF00FF0855C8FC08FDFDFE005D36FF015FF615F2F3E70A
      C9DAC9FB01FF17EB0DFA08EB0D550FEF08EE00CDFE0855FB0954F816F519E604
      0206C9F710FF05EF0FEB20C2EB0FED0FC3EF0508EF0D00F917250153F31DA3E7
      ECEA0636F8123625EB2284C19CED228D8FEEEFEB0FC8EBF9F917FB19F3F2A3D1
      A4E45D1D5151273A84C2C09E9E8D8D8D8D8FCADEDECD3DC85427274247590000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E557
      EAAF17E2FF34443FF20829999727365EE5ABF7712F34443FF202878974033513
      F22ABF7E1234443FF2000441400E3367E4C7ABE77134463FF200000C4033616E
      E02E2ABB7E346C63F20000024455167E2020B2ABF7F54463F200000343356C3E
      04102F2ABEF364C63C40000FC55C455E22702E12AFFE36443424000E664645E0
      000017E17FFF356443624006444453001C22E722B0FFF356445333344CC53300
      E77EF42FFFFFFF336444444C4653F400204F04FFFFFFFFFF333333333EEE4000
      12F02FFFFFFFFFFFF4000000000000001E22FFFFFFFFFFFFF124242424242424
      E44FFFFFFFFFFE07FFFFFC01FFFFFC01FFFFF800FFFE000007FC000003FC}
    IconIndex = 0
    PopupMenu = PopupMenu1
    MinimizeToTray = True
    Left = 36
    Top = 112
  end
  object ActionsTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = ActionsTimerTimer
    Left = 4
    Top = 176
  end
  object TransitionTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TransitionTimerTimer
    Left = 132
    Top = 144
  end
  object ScrollFlashTimer: TTimer
    Enabled = False
    OnTimer = ScrollFlashTimerTimer
    Left = 36
    Top = 176
  end
end
