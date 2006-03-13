object SetupForm: TSetupForm
  Left = 228
  Top = 330
  Anchors = []
  BiDiMode = bdLeftToRight
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'LCD Smartie 5.3 Setup'
  ClientHeight = 412
  ClientWidth = 813
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LeftPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 233
    Height = 409
    ActivePage = EmailTabSheet
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    TabPosition = tpRight
    TabStop = False
    OnChange = LeftPageControlChange
    object WinampTabSheet: TTabSheet
      Caption = 'Winamp'
      object WinampLocationBrowseButton: TSpeedButton
        Left = 160
        Top = 328
        Width = 23
        Height = 22
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          88888888888888888888000000000008888800333333333088880B0333333333
          08880FB03333333330880BFB0333333333080FBFB000000000000BFBFBFBFB08
          88880FBFBFBFBF0888880BFB0000000888888000888888880008888888888888
          8008888888880888080888888888800088888888888888888888}
        OnClick = WinampLocationBrowseButtonClick
      end
      object WinampLocationLabel: TLabel
        Left = 8
        Top = 312
        Width = 104
        Height = 13
        Caption = 'Winamp.exe location:'
      end
      object WinampListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 265
        ItemHeight = 13
        Items.Strings = (
          'TrackTitle'
          'Channels (stereo/mono)'
          'kbps'
          'KHz'
          'Time (seconds)'
          'Time (hrs + min + sec) (long)'
          'Time (hrs + min + sec) (short)'
          'Remaining Time (seconds)'
          'Remaining (hrs+min+sec) (long)'
          'Remaining (hrs+min+sec) (short)'
          'Total length (seconds)'
          'Total length (hrs + min + sec)(long)'
          'Total length (hrs + min + sec)(short)'
          'Position(10) (bar) '
          'playlist number of current track'
          'total tracks in playlist'
          'Current Status')
        TabOrder = 0
        OnClick = WinampListBoxClick
        OnDblClick = InsertButtonClick
      end
      object WinampLocationEdit: TEdit
        Left = 8
        Top = 328
        Width = 153
        Height = 21
        TabOrder = 1
        Text = 'WinampLocationEdit'
      end
    end
    object SysInfoTabSheet: TTabSheet
      Caption = 'Sysinfo'
      ImageIndex = 1
      object SysInfoListBox: TListBox
        Left = 0
        Top = 0
        Width = 185
        Height = 329
        ItemHeight = 13
        Items.Strings = (
          'Username'
          'Computername'
          'CPU Type'
          'CPU Speed'
          'CPU usage (%)'
          'CPU usage Bar (length)'
          'Free Memory'
          'Used Memory'
          'Total Memory'
          'Free Memory (%)'
          'Used Memory (%)'
          'Free Memory bar (length)'
          'Used Memory bar (length)'
          'Free Pagefile'
          'Used Pagefile'
          'Total Pagefile'
          'Free Pagefile (%)'
          'Used Pagefile (%)'
          'Free Pagefile Bar (length)'
          'Used Pagefile Bar (length)'
          'Free space on drive(X) (MB)'
          'Used space on drive(X) (MB)'
          'Total space on drive(X) (MB)'
          'Free space on drive(X) (GB)'
          'Used space on drive(X) (GB)'
          'Total space on drive(X) (GB)'
          'Free space on drive(X) (%)'
          'Used space on drive(X) (%)'
          'Free space Bar drive(X,Length)'
          'Used space Bar drive(X,Length)'
          'Screen Resolution')
        TabOrder = 0
        OnClick = SysInfoListBoxClick
        OnDblClick = InsertButtonClick
      end
    end
    object MBMTabSheet: TTabSheet
      Caption = 'MBM'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      object RefreshTimeLabel: TLabel
        Left = 8
        Top = 332
        Width = 97
        Height = 13
        Caption = 'Refresh time (secs):'
      end
      object MBMListBox: TListBox
        Left = 0
        Top = 0
        Width = 185
        Height = 321
        ItemHeight = 13
        Items.Strings = (
          'Temperature 1'
          'Temperature 2'
          'Temperature 3'
          'Temperature 4'
          'Temperature 5'
          'Temperature 6'
          'Temperature 7'
          'Temperature 8'
          'Temperature 9'
          'Temperature 10'
          'Fan speed 1'
          'Fan speed 2'
          'Fan speed 3'
          'Fan speed 4'
          'Fan speed 5'
          'Fan speed 6'
          'Fan speed 7'
          'Fan speed 8'
          'Fan speed 9'
          'Fan speed 10'
          'Voltage 1'
          'Voltage 2'
          'Voltage 3'
          'Voltage 4'
          'Voltage 5'
          'Voltage 6'
          'Voltage 7'
          'Voltage 8'
          'Voltage 9'
          'Voltage 10'
          'Temperature name 1'
          'Temperature name 2'
          'Temperature name 3'
          'Temperature name 4'
          'Temperature name 5'
          'Temperature name 6'
          'Temperature name 7'
          'Temperature name 8'
          'Temperature name 9'
          'Temperature name 10'
          'Fan name 1'
          'Fan name 2'
          'Fan name 3'
          'Fan name 4'
          'Fan name 5'
          'Fan name 6'
          'Fan name 7'
          'Fan name 8'
          'Fan name 9'
          'Fan name 10'
          'Voltage name 1'
          'Voltage name 2'
          'Voltage name 3'
          'Voltage name 4'
          'Voltage name 5'
          'Voltage name 6'
          'Voltage name 7'
          'Voltage name 8'
          'Voltage name 9'
          'Voltage name 10')
        TabOrder = 0
        OnClick = MBMListBoxClick
        OnDblClick = InsertButtonClick
      end
      object MBMRefreshTimeSpinEdit: TSpinEdit
        Left = 120
        Top = 328
        Width = 55
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 3
        MaxValue = 360
        MinValue = 10
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        Value = 10
      end
    end
    object GameStatsTabSheet: TTabSheet
      Caption = 'Gamestats'
      ImageIndex = 4
      object Label11: TLabel
        Left = 8
        Top = 312
        Width = 36
        Height = 13
        Caption = 'Server:'
      end
      object Label12: TLabel
        Left = 8
        Top = 120
        Width = 149
        Height = 13
        Caption = 'The gamestats are made by an'
      end
      object Label13: TLabel
        Left = 8
        Top = 136
        Width = 87
        Height = 13
        Caption = 'external program;'
      end
      object Label15: TLabel
        Left = 128
        Top = 136
        Width = 4
        Height = 13
        Caption = '.'
      end
      object QStatLabel: TLabel
        Left = 100
        Top = 136
        Width = 28
        Height = 13
        Cursor = crHandPoint
        Caption = 'QStat'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = QStatLabelClick
      end
      object Label37: TLabel
        Left = 8
        Top = 236
        Width = 97
        Height = 13
        Caption = 'Refresh time (mins):'
      end
      object Label35: TLabel
        Left = 32
        Top = 192
        Width = 3
        Height = 13
      end
      object Label40: TLabel
        Left = 8
        Top = 272
        Width = 56
        Height = 13
        Caption = 'Game type:'
      end
      object GameServerEdit: TEdit
        Left = 16
        Top = 328
        Width = 161
        Height = 21
        Hint = 'servername:portnumber portnumber is optional.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = 'GameServerEdit'
        OnExit = GameServerEditExit
      end
      object GameTypeComboBox: TComboBox
        Left = 16
        Top = 288
        Width = 161
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = GamestatsListBoxClick
        Items.Strings = (
          'Half-life'
          'Quake II'
          'Quake III'
          'Unreal / Unreal Tournament')
      end
      object GamestatsRefreshTimeSpinEdit: TSpinEdit
        Left = 122
        Top = 232
        Width = 55
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        MaxValue = 10080
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 3
      end
      object GamestatsListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 57
        ItemHeight = 13
        Items.Strings = (
          'server name'
          'current map'
          'number of players on server'
          'number of frags for each player')
        TabOrder = 0
        OnClick = GamestatsListBoxClick
        OnDblClick = InsertButtonClick
      end
    end
    object InternetTabSheet: TTabSheet
      Caption = 'Internet'
      ImageIndex = 5
      object Label36: TLabel
        Left = 8
        Top = 284
        Width = 97
        Height = 13
        Caption = 'Refresh time (mins):'
      end
      object InternetListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 265
        ItemHeight = 13
        Items.Strings = (
          'BBC World News'
          'BBC UK News'
          'Tweakers.net headlines (Dutch)'
          'The Register headlines'
          'Slashdot'
          'Wired News'
          'The Monty Fool (top item)'
          'The Monty Fool (all items)'
          'Latest LCD Smartie News'
          'Latest PalmOrb News'
          'Latest Weather: FL (US)'
          'BBC News business'
          'The Washington Post business'
          'Yahoo! entertainment'
          'New York Times health'
          'New York Times sports'
          'SecurityFocus news'
          'Volkskrant economie (Dutch)'
          '3voor12 (Dutch)'
          'Algemeen Dagblad (Dutch)'
          'Atletiek nieuws (Dutch)'
          'RTL (French)'
          'Tagesschau (German)')
        TabOrder = 0
        OnClick = InternetListBoxClick
        OnDblClick = InsertButtonClick
      end
      object InternetRefreshTimeSpinEdit: TSpinEdit
        Left = 120
        Top = 280
        Width = 55
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        MaxValue = 10080
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 3
      end
      object LCDSmartieUpdateCheckBox: TCheckBox
        Left = 2
        Top = 328
        Width = 177
        Height = 17
        Caption = 'Check for LCD Smartie updates'
        TabOrder = 2
      end
    end
    object SetiAtHomeTabSheet: TTabSheet
      Caption = 'Seti@Home'
      ImageIndex = 7
      object Label41: TLabel
        Left = 3
        Top = 312
        Width = 171
        Height = 13
        Caption = 'Email address used with Seti@home'
      end
      object SetiAtHomeListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 265
        ItemHeight = 13
        Items.Strings = (
          'Total number of WU'#39's done'
          'Total CPU time'
          'Average CPU Time per work unit '
          'time of last result returned'
          'time you are SETI@home user'
          'Total users'
          'Your rank'
          'users you share your rank with'
          'completed more work then ...')
        TabOrder = 0
        OnClick = SetiAtHomeListBoxClick
        OnDblClick = InsertButtonClick
      end
      object SetiAtHomeEmailEdit: TEdit
        Left = 0
        Top = 328
        Width = 177
        Height = 21
        TabOrder = 1
      end
    end
    object FoldingAtHomeTabSheet: TTabSheet
      Caption = 'Folding@Home'
      ImageIndex = 9
      object Label23: TLabel
        Left = 8
        Top = 312
        Width = 143
        Height = 13
        Caption = 'Username for Folding@Home:'
      end
      object FoldingAtHomeEmailEdit: TEdit
        Left = 8
        Top = 328
        Width = 169
        Height = 21
        TabOrder = 1
        Text = 'BobC'
      end
      object FoldingAtHomeListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 265
        ItemHeight = 13
        Items.Strings = (
          'WU'
          'Date of last work unit'
          'Active processors (within a week)'
          'Team'
          'Score'
          'User Rank'
          '')
        TabOrder = 0
        OnClick = FoldingAtHomeListBoxClick
        OnDblClick = InsertButtonClick
      end
    end
    object EmailTabSheet: TTabSheet
      Caption = 'Email'
      ImageIndex = 7
      object Label31: TLabel
        Left = 25
        Top = 228
        Width = 36
        Height = 13
        Caption = 'Server:'
      end
      object Label32: TLabel
        Left = 7
        Top = 276
        Width = 55
        Height = 13
        Caption = 'Loginname:'
      end
      object Label33: TLabel
        Left = 12
        Top = 300
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object Label48: TLabel
        Left = 8
        Top = 332
        Width = 113
        Height = 13
        Caption = 'Email check time (mins):'
      end
      object Label50: TLabel
        Left = 8
        Top = 204
        Width = 69
        Height = 13
        Caption = 'Email account:'
      end
      object Label28: TLabel
        Left = 56
        Top = 184
        Width = 56
        Height = 13
        Caption = 'POP3 only'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 21
        Top = 251
        Width = 40
        Height = 13
        Caption = 'Ssl Port:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object EmailPasswordEdit: TEdit
        Left = 64
        Top = 296
        Width = 113
        Height = 21
        Color = 16708585
        PasswordChar = '*'
        TabOrder = 5
        Text = 'Ur passw'
      end
      object EmailLoginEdit: TEdit
        Left = 64
        Top = 272
        Width = 113
        Height = 21
        TabOrder = 4
        Text = 'Ur loginname'
      end
      object EmailServerEdit: TEdit
        Left = 64
        Top = 224
        Width = 113
        Height = 21
        TabOrder = 2
        Text = 'Ur Server'
      end
      object EmailCheckTimeSpinEdit: TSpinEdit
        Left = 120
        Top = 328
        Width = 55
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        MaxValue = 10080
        MinValue = 1
        ParentFont = False
        TabOrder = 6
        Value = 3
      end
      object EmailListBox: TListBox
        Left = 0
        Top = 0
        Width = 185
        Height = 177
        ItemHeight = 13
        TabOrder = 0
        OnClick = EmailListBoxClick
        OnDblClick = InsertButtonClick
      end
      object EmailAccountComboBox: TComboBox
        Left = 104
        Top = 200
        Width = 73
        Height = 21
        Style = csDropDownList
        DropDownCount = 10
        ItemHeight = 13
        TabOrder = 1
        OnChange = EmailAccountComboBoxChange
      end
      object EmailSSLEdit: TEdit
        Left = 64
        Top = 248
        Width = 113
        Height = 21
        Hint = 
          'if disabled please put "libeay32.dll" and "ssleay32.dll" with lc' +
          'dsmartie.exe'
        Color = 16708585
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
    object NetworkStatsTabSheet: TTabSheet
      Caption = 'Network Stats'
      ImageIndex = 8
      object NetworkStatsListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 353
        ItemHeight = 13
        Items.Strings = (
          'Adapter name (adapterNr)'
          'Total Down (adapterNr)  (KB)'
          'Total up (adapterNr)  (KB)'
          'Total Down (adapterNr)  (MB)'
          'Total up (adapterNr)  (MB)'
          'Total Down (adapterNr)  (GB)'
          'Total up (adapterNr)  (GB)'
          'Speed Down (adapterNr)  (KB)'
          'Speed Up (adapterNr)  (KB)'
          'Speed Down (adapterNr)  (MB)'
          'Speed Up (adapterNr)  (MB)'
          'Errors down (adapterNr)'
          'Errors up (adapterNr)'
          'Total Errors (adapterNr)'
          'Unicast Packets down (adapterNr)'
          'Unicast Packets up (adapterNr)'
          'Total Uni. Packets (adapterNr)'
          'Non-Uni. Packets down (adapterNr)'
          'Non-Uni. Packets up (adapterNr)'
          'Total Non-Uni. Packets (adapterNr)'
          'Total nr of Packets (adapterNr)'
          'Discards down (adapterNr)'
          'Discards up (adapterNr)'
          'Total Discards (adapterNr)'
          'IP address')
        TabOrder = 0
        OnClick = NetworkStatsListBoxClick
        OnDblClick = InsertButtonClick
      end
    end
    object MiscTabSheet: TTabSheet
      Caption = 'Misc.'
      ImageIndex = 6
      object DistributedNetBrowseButton: TSpeedButton
        Left = 160
        Top = 328
        Width = 23
        Height = 22
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          88888888888888888888000000000008888800333333333088880B0333333333
          08880FB03333333330880BFB0333333333080FBFB000000000000BFBFBFBFB08
          88880FBFBFBFBF0888880BFB0000000888888000888888880008888888888888
          8008888888880888080888888888800088888888888888888888}
        OnClick = DistributedNetBrowseButtonClick
      end
      object Label34: TLabel
        Left = 8
        Top = 312
        Width = 107
        Height = 13
        Caption = 'Distributed.net logfile:'
      end
      object Label58: TLabel
        Left = 8
        Top = 284
        Width = 114
        Height = 13
        Caption = 'DLL check interval (ms):'
      end
      object MiscListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 265
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'Distributed.net RC5/OGR speed'
          'Distributed.net RC5/OGR done'
          'DateTime'
          'Uptime long (wks, dys, hrs, min, sec)'
          'Uptime short (days, hours, minutes)'
          'Degree symbol ('#176')'
          'Block ('#382')'
          '$Chr(20)'
          '$File(C:\file.txt,2)  (2=2nd line)'
          '$LogFile(C:\file.txt,0-3) (last-2 line)'
          '$dll(demo.dll,5,param1,param2)'
          '$Count(101#$CPUSpeed#4)'
          '$Bar(current,total,length)'
          '$Right(text here,$length)'
          '$Fill(10) places next text at pos 10'
          '$Flash(text here$)$'
          '$CustomChar(1,31,31,31,31,31,31,31,31)'
          '$Rss(URL,t|d|b,ITEM#,MAXFREQHRS)'
          '$Center(text here,width)'
          '$ScreenChanged')
        ParentFont = False
        ScrollWidth = 250
        TabOrder = 0
        OnClick = MiscListBoxClick
        OnDblClick = InsertButtonClick
      end
      object DistributedNetLogfileEdit: TEdit
        Left = 4
        Top = 328
        Width = 153
        Height = 21
        TabOrder = 2
      end
      object DLLCheckIntervalSpinEdit: TSpinEdit
        Left = 128
        Top = 280
        Width = 49
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 4
        MaxValue = 1000
        MinValue = 5
        ParentFont = False
        TabOrder = 1
        Value = 200
      end
    end
    object LCDFeaturesTabSheet: TTabSheet
      Caption = 'LCD Features'
      Enabled = False
      ImageIndex = 10
      object Label27: TLabel
        Left = 8
        Top = 184
        Width = 157
        Height = 13
        Caption = 'When you insert a button please'
      end
      object Label29: TLabel
        Left = 8
        Top = 200
        Width = 161
        Height = 13
        Caption = 'first press the button (see below)'
      end
      object Label56: TLabel
        Left = 8
        Top = 320
        Width = 85
        Height = 13
        Caption = 'Last key pressed:'
      end
      object Label30: TLabel
        Left = 8
        Top = 232
        Width = 167
        Height = 13
        Caption = 'The buttons get the value '#39'1'#39' when'
      end
      object Label57: TLabel
        Left = 8
        Top = 248
        Width = 83
        Height = 13
        Caption = 'they are pushed.'
      end
      object ButtonsListBox: TListBox
        Left = 0
        Top = 0
        Width = 180
        Height = 177
        ItemHeight = 13
        Items.Strings = (
          'Buttons')
        TabOrder = 0
        OnClick = ButtonsListBoxClick
        OnDblClick = InsertButtonClick
      end
      object LastKeyPressedEdit: TEdit
        Left = 96
        Top = 316
        Width = 33
        Height = 21
        Enabled = False
        MaxLength = 1
        TabOrder = 1
      end
    end
  end
  object OKButton: TButton
    Left = 576
    Top = 384
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 5
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 656
    Top = 384
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 6
  end
  object VariableEdit: TEdit
    Left = 8
    Top = 376
    Width = 121
    Height = 17
    TabStop = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = '[Variable]'
  end
  object InsertButton: TButton
    Left = 128
    Top = 368
    Width = 59
    Height = 25
    Hint = 
      'Insert the above chosen variable into the currently active scree' +
      'n line.'
    Caption = '&Insert -->'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = InsertButtonClick
  end
  object ApplyButton: TButton
    Left = 736
    Top = 384
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 7
    OnClick = ApplyButtonClick
  end
  object MainPageControl: TPageControl
    Left = 232
    Top = 0
    Width = 577
    Height = 377
    ActivePage = ScreensTabSheet
    TabOrder = 0
    TabStop = False
    OnChange = MainPageControlChange
    object ScreensTabSheet: TTabSheet
      Caption = 'Screens'
      object ScreenSettingsGroupBox: TGroupBox
        Left = 3
        Top = 168
        Width = 561
        Height = 177
        BiDiMode = bdLeftToRight
        Caption = 'Screens settings'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        object Label5: TLabel
          Left = 9
          Top = 46
          Width = 67
          Height = 13
          Caption = 'Time to show:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 200
          Top = 52
          Width = 90
          Height = 13
          Caption = 'Skip this screen if: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label43: TLabel
          Left = 19
          Top = 57
          Width = 47
          Height = 13
          Caption = '(seconds)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label44: TLabel
          Left = 432
          Top = 8
          Width = 25
          Height = 13
          Caption = 'Don'#39't'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label45: TLabel
          Left = 432
          Top = 24
          Width = 24
          Height = 13
          Caption = 'scroll'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label47: TLabel
          Left = 436
          Top = 56
          Width = 20
          Height = 13
          Caption = 'line:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 436
          Top = 40
          Width = 17
          Height = 13
          Caption = 'this'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label51: TLabel
          Left = 467
          Top = 8
          Width = 43
          Height = 13
          Caption = 'Continue'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label52: TLabel
          Left = 482
          Top = 24
          Width = 12
          Height = 13
          Caption = 'on'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label53: TLabel
          Left = 477
          Top = 40
          Width = 22
          Height = 13
          Caption = 'next'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label54: TLabel
          Left = 480
          Top = 56
          Width = 20
          Height = 13
          Caption = 'line:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 520
          Top = 8
          Width = 33
          Height = 13
          Caption = 'Center'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 526
          Top = 24
          Width = 24
          Height = 13
          Caption = 'text:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 200
          Top = 19
          Width = 49
          Height = 13
          Caption = 'Theme nr.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ScreenLabel: TLabel
          Left = 8
          Top = 19
          Width = 37
          Height = 13
          Caption = 'Screen:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DontScrollLine1CheckBox: TCheckBox
          Left = 436
          Top = 80
          Width = 17
          Height = 17
          Hint = 'Don'#39't scroll this line.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
        end
        object DontScrollLine2CheckBox: TCheckBox
          Left = 436
          Top = 104
          Width = 17
          Height = 17
          Hint = 'Don'#39't scroll this line.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
        end
        object DontScrollLine3CheckBox: TCheckBox
          Left = 436
          Top = 128
          Width = 17
          Height = 17
          Hint = 'Don'#39't scroll this line.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
        end
        object DontScrollLine4CheckBox: TCheckBox
          Left = 436
          Top = 152
          Width = 17
          Height = 17
          Hint = 'Don'#39't scroll this line.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 18
        end
        object GroupBox4: TGroupBox
          Left = 464
          Top = 8
          Width = 2
          Height = 161
          Enabled = False
          TabOrder = 21
        end
        object ContinueLine1CheckBox: TCheckBox
          Left = 480
          Top = 80
          Width = 17
          Height = 17
          Hint = 'Continue text that doesn'#39't fit on line 1 onto line 2.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = ContinueLine1CheckBoxClick
        end
        object ContinueLine2CheckBox: TCheckBox
          Left = 480
          Top = 104
          Width = 17
          Height = 17
          Hint = 'Continue text that doesn'#39't fit on line 2 onto line 3.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = ContinueLine2CheckBoxClick
        end
        object ContinueLine3CheckBox: TCheckBox
          Left = 480
          Top = 128
          Width = 17
          Height = 17
          Hint = 'Continue text that doesn'#39't fit on line 3 onto line 4.'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          OnClick = ContinueLine3CheckBoxClick
        end
        object GroupBox5: TGroupBox
          Left = 512
          Top = 8
          Width = 2
          Height = 161
          Enabled = False
          TabOrder = 22
        end
        object CenterLine1CheckBox: TCheckBox
          Left = 528
          Top = 80
          Width = 17
          Height = 17
          Hint = 'Center the text in this line (if it'#39's shorter than a full line).'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
        end
        object CenterLine2CheckBox: TCheckBox
          Left = 528
          Top = 104
          Width = 17
          Height = 17
          Hint = 'Center the text in this line (if it'#39's shorter than a full line).'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
        end
        object CenterLine3CheckBox: TCheckBox
          Left = 528
          Top = 128
          Width = 17
          Height = 17
          Hint = 'Center the text in this line (if it'#39's shorter than a full line).'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
        end
        object CenterLine4CheckBox: TCheckBox
          Left = 528
          Top = 152
          Width = 17
          Height = 17
          Hint = 'Center the text in this line (if it'#39's shorter than a full line).'
          Caption = ' '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 19
        end
        object GroupBox6: TGroupBox
          Left = 424
          Top = 8
          Width = 2
          Height = 57
          Enabled = False
          TabOrder = 23
        end
        object ThemeNumberSpinEdit: TSpinEdit
          Left = 256
          Top = 15
          Width = 41
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          MaxValue = 10
          MinValue = 1
          ParentFont = False
          TabOrder = 0
          Value = 1
        end
        object TransitionButton: TButton
          Left = 336
          Top = 16
          Width = 83
          Height = 25
          Hint = 'Choose an effect to display when changing from this screen.'
          Caption = 'Transition'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = TransitionButtonClick
        end
        object StickyCheckbox: TCheckBox
          Left = 128
          Top = 53
          Width = 49
          Height = 17
          Hint = 'Don'#39't automatically change from this screen.'
          Caption = 'Sticky'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = StickyCheckboxClick
        end
        object SkipScreenComboBox: TComboBox
          Left = 292
          Top = 49
          Width = 129
          Height = 21
          Hint = 
            'Skip this screen for automatic selection if the condition is tru' +
            'e.'
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnChange = SkipScreenComboBoxChange
          Items.Strings = (
            'Don'#39't skip'
            'Winamp is inactive'
            'Winamp is active'
            'MBM is inactive'
            'MBM is active'
            'There is no new E-Mail'
            'There is new E-Mail'
            'Not connected'
            'Connected')
        end
        object ScreenEnabledCheckBox: TCheckBox
          Left = 128
          Top = 14
          Width = 65
          Height = 25
          Hint = 'Show this screen automatically'
          Caption = 'Enabled'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 20
        end
        object TimeToShowSpinEdit: TSpinEdit
          Left = 77
          Top = 48
          Width = 41
          Height = 22
          Hint = 
            'How long the screen should be shown for before moving to the nex' +
            't.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          MaxValue = 99
          MinValue = 1
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 3
        end
        object Line1Edit: TEdit
          Left = 4
          Top = 74
          Width = 417
          Height = 23
          BevelEdges = []
          Color = 10606500
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnEnter = Line1EditEnter
          OnKeyDown = Line1EditKeyDown
        end
        object Line2Edit: TEdit
          Left = 4
          Top = 98
          Width = 417
          Height = 23
          BevelEdges = []
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnEnter = Line2EditEnter
          OnKeyDown = Line2EditKeyDown
        end
        object Line3Edit: TEdit
          Left = 4
          Top = 122
          Width = 417
          Height = 23
          BevelEdges = []
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          OnEnter = Line3EditEnter
          OnKeyDown = Line3EditKeyDown
        end
        object Line4Edit: TEdit
          Left = 4
          Top = 146
          Width = 417
          Height = 23
          BevelEdges = []
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          OnEnter = Line4EditEnter
          OnKeyDown = Line4EditKeyDown
        end
        object ScreenSpinEdit: TSpinEdit
          Left = 52
          Top = 15
          Width = 49
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          MaxValue = 20
          MinValue = 1
          ParentFont = False
          TabOrder = 24
          Value = 1
          OnChange = ScreenSpinEditChange
        end
      end
      object ProgramSettingsGroupBox: TGroupBox
        Left = 3
        Top = 0
        Width = 270
        Height = 166
        Caption = 'Program settings'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          270
          166)
        object Label1: TLabel
          Left = 8
          Top = 52
          Width = 134
          Height = 13
          Caption = 'Scroll interval (milliseconds):'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 8
          Top = 112
          Width = 91
          Height = 13
          Caption = 'Web proxy server:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 8
          Top = 140
          Width = 80
          Height = 13
          Caption = 'Web proxy port:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 8
          Top = 84
          Width = 68
          Height = 13
          Caption = 'Color scheme:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label59: TLabel
          Left = 8
          Top = 20
          Width = 147
          Height = 13
          Caption = 'Refresh interval (milliseconds):'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object WebProxyServerEdit: TEdit
          Left = 104
          Top = 108
          Width = 157
          Height = 21
          Hint = 'Web proxy for web access (such as for Rss feeds).'
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object WebProxyPortEdit: TEdit
          Left = 180
          Top = 136
          Width = 81
          Height = 21
          Hint = 'Web proxy port for web access (such as for Rss feeds).'
          Anchors = [akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Text = '0'
        end
        object ColorSchemeComboBox: TComboBox
          Left = 84
          Top = 79
          Width = 177
          Height = 21
          Hint = 'The colors used in the virtual display.'
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnChange = ColorSchemeComboBoxChange
          Items.Strings = (
            'Green'
            'Blue'
            'Yellow'
            'White'
            'Custom for this skin')
        end
        object ProgramRefreshIntervalSpinEdit: TSpinEdit
          Left = 192
          Top = 17
          Width = 69
          Height = 22
          Hint = 'How often screen text is sent to display (in mSec).'
          Anchors = [akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 4
          MaxValue = 1000
          MinValue = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 200
        end
        object ProgramScrollIntervalSpinEdit: TSpinEdit
          Left = 192
          Top = 46
          Width = 69
          Height = 22
          Hint = 
            'How fast to scroll (in mSec). Should be greater than refresh int' +
            'erval.'
          Anchors = [akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 4
          MaxValue = 50000
          MinValue = 20
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 200
        end
      end
      object DisplayGroup2: TGroupBox
        Left = 280
        Top = 0
        Width = 285
        Height = 165
        Caption = 'Display settings'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Panel1: TPanel
          Left = 2
          Top = 15
          Width = 281
          Height = 148
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 3
          TabOrder = 0
          object DisplayPageControl: TPageControl
            Left = 3
            Top = 3
            Width = 275
            Height = 142
            ActivePage = PluginTabsheet
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MultiLine = True
            ParentFont = False
            TabHeight = 16
            TabOrder = 0
            TabPosition = tpLeft
            object PluginTabsheet: TTabSheet
              Caption = 'Plugin'
              DesignSize = (
                251
                134)
              object DisplayPluginsLabel: TLabel
                Left = 8
                Top = 8
                Width = 81
                Height = 13
                Caption = 'Display Plugin:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object IDLabel: TLabel
                Left = 8
                Top = 32
                Width = 63
                Height = 13
                Caption = 'DLL Identifier'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label14: TLabel
                Left = 8
                Top = 48
                Width = 116
                Height = 13
                Caption = 'Startup Parameters:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object UsageLabel: TLabel
                Left = 8
                Top = 83
                Width = 30
                Height = 13
                Caption = 'Usage'
              end
              object DisplayPluginList: TComboBox
                Left = 92
                Top = 4
                Width = 153
                Height = 21
                Style = csDropDownList
                Anchors = [akLeft, akTop, akRight]
                ItemHeight = 13
                TabOrder = 0
                OnChange = DisplayPluginListChange
              end
              object ParametersEdit: TEdit
                Left = 8
                Top = 60
                Width = 237
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 1
                Text = 'ParametersEdit'
              end
            end
            object ScreenTabsheet: TTabSheet
              Caption = 'Screen'
              ImageIndex = 1
              DesignSize = (
                251
                134)
              object Label3: TLabel
                Left = 89
                Top = 7
                Width = 44
                Height = 13
                Caption = 'LCD size:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object LCDSizeComboBox: TComboBox
                Left = 134
                Top = 4
                Width = 77
                Height = 21
                Hint = 'The size of your display in characters (lines X width). '
                Style = csDropDownList
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ItemHeight = 0
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnChange = LCDSizeComboBoxChange
              end
              object GroupBox3: TGroupBox
                Left = 8
                Top = 28
                Width = 237
                Height = 49
                Anchors = [akLeft, akTop, akRight]
                Caption = 'Contrast'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                DesignSize = (
                  237
                  49)
                object ContrastTrackBar: TTrackBar
                  Left = 3
                  Top = 15
                  Width = 230
                  Height = 25
                  Anchors = [akLeft, akTop, akRight]
                  Max = 254
                  Min = 1
                  Frequency = 10
                  Position = 1
                  TabOrder = 0
                  ThumbLength = 15
                  OnChange = ContrastTrackBarChange
                end
              end
              object GroupBox1: TGroupBox
                Left = 8
                Top = 80
                Width = 237
                Height = 49
                Anchors = [akLeft, akTop, akRight]
                Caption = 'Brightness'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                DesignSize = (
                  237
                  49)
                object BrightnessTrackBar: TTrackBar
                  Left = 3
                  Top = 16
                  Width = 230
                  Height = 25
                  Anchors = [akLeft, akTop, akRight]
                  Max = 254
                  Min = 1
                  Frequency = 10
                  Position = 1
                  TabOrder = 0
                  ThumbLength = 15
                  OnChange = BrightnessTrackBarChange
                end
              end
            end
          end
        end
      end
    end
    object ActionsTabSheet: TTabSheet
      Caption = 'Actions'
      ImageIndex = 1
      object Label24: TLabel
        Left = 4
        Top = 294
        Width = 8
        Height = 13
        Caption = 'If'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 244
        Top = 294
        Width = 24
        Height = 13
        Caption = 'Then'
      end
      object Label26: TLabel
        Left = 397
        Top = 1
        Width = 42
        Height = 13
        Caption = 'Output:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ActionsStringGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 393
        Height = 281
        DefaultColWidth = 77
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 7
        OnClick = ActionsStringGridClick
      end
      object OutputListBox: TListBox
        Left = 397
        Top = 16
        Width = 169
        Height = 329
        ItemHeight = 13
        Items.Strings = (
          'Next Theme'
          'Last Theme'
          'Next screen'
          'Last screen'
          'Goto Theme(2)'
          'Goto Screen(2)'
          'Freeze/unfreeze screen'
          'Refresh all data'
          'Backlight(0/1) (0=off 1=on)'
          'BacklightToggle'
          'Backlight Flash(5) (nr. of times)'
          'PlayWave[c:\wave.wav]'
          'Execute[c:\autoexec.bat]'
          'Winamp next track'
          'Winamp last track'
          'Winamp play'
          'Winamp stop'
          'Winamp pause'
          'Winamp Shuffle (toggle)'
          'Winamp volume down'
          'Winamp volume up'
          'EnableScreen(1-20)'
          'DisableScreen(1-20)'
          '$dll(name.dll,2,param1,param2)'
          'GPO(1-8,0/1)  (0=off 1=on)'
          'GPOToggle(1-8)'
          'GPOFlash(1-8,2)  (nr. of times)'
          'Fan(1-3,0-255) (0-255=speed)')
        TabOrder = 6
        OnClick = OutputListBoxClick
      end
      object Operand1Edit: TEdit
        Left = 16
        Top = 288
        Width = 105
        Height = 21
        TabOrder = 0
      end
      object OperatorComboBox: TComboBox
        Left = 124
        Top = 288
        Width = 41
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = OperatorComboBoxChange
        Items.Strings = (
          '>'
          '<'
          '='
          '<='
          '>='
          '<>')
      end
      object StatementEdit: TEdit
        Left = 272
        Top = 288
        Width = 113
        Height = 21
        TabOrder = 3
        Text = 'Backlight(1)'
      end
      object ActionAddButton: TButton
        Left = 312
        Top = 312
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 5
        OnClick = ActionAddButtonClick
      end
      object ActionDeleteButton: TButton
        Left = 232
        Top = 312
        Width = 75
        Height = 25
        Caption = '&Delete'
        TabOrder = 4
        OnClick = ActionDeleteButtonClick
      end
      object Operand2Edit: TEdit
        Left = 168
        Top = 288
        Width = 73
        Height = 21
        TabOrder = 2
        Text = 'Operand2Edit'
      end
    end
    object StartupTabSheet: TTabSheet
      Caption = 'Startup'
      ImageIndex = 2
      object GroupBox7: TGroupBox
        Left = 8
        Top = 16
        Width = 201
        Height = 81
        Hint = 'These settings are for when starting with windows.'
        Caption = 'Autostart'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object NoAutoStart: TRadioButton
          Left = 8
          Top = 24
          Width = 169
          Height = 17
          Caption = 'Don'#39't autostart with windows'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object AutoStart: TRadioButton
          Left = 8
          Top = 40
          Width = 113
          Height = 17
          Caption = 'Autostart'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object AutoStartHide: TRadioButton
          Left = 8
          Top = 56
          Width = 177
          Height = 17
          Caption = 'Autostart hidden (in system tray)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object GroupBox8: TGroupBox
        Left = 8
        Top = 104
        Width = 201
        Height = 49
        Hint = 
          'These settings are for when starting apply to all start methods ' +
          '(by hand or autostart).'
        Caption = 'Start options'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object HideOnStartup: TCheckBox
          Left = 8
          Top = 24
          Width = 185
          Height = 17
          Caption = 'Always start hidden'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object RandomizeScreensCheckBox: TCheckBox
    Left = 384
    Top = 384
    Width = 113
    Height = 17
    Hint = 
      'Rather than automatically selecting in sequence, chose them rand' +
      'omly.'
    Caption = '&Randomize screens'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object StayOnTopCheckBox: TCheckBox
    Left = 240
    Top = 384
    Width = 81
    Height = 17
    Caption = '&Stay on top'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = '*.*'
    Filter = 
      'All files (*.*)|*.*|Text files (*.txt)|*.txt|Log files (*.log)|*' +
      '.log'
    InitialDir = 'C:\'
    Title = 'Open distributed.net logfile'
    Left = 512
    Top = 384
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.exe'
    FileName = 'Winamp.exe'
    Filter = 'Executables (*.exe)|*.exe|All Files (*.*)|*.*'
    InitialDir = 'C:\program files\winamp'
    Left = 540
    Top = 384
  end
end
