object SetupForm: TSetupForm
  Left = 902
  Top = 372
  ActiveControl = LeftPageControl
  Anchors = []
  BiDiMode = bdLeftToRight
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'LCD Smartie 5.x Setup'
  ClientHeight = 411
  ClientWidth = 849
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
    Width = 265
    Height = 409
    ActivePage = NetworkStatsTabSheet
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    TabPosition = tpRight
    TabStop = False
    OnChange = LeftPageControlChange
    object SysInfoTabSheet: TTabSheet
      Caption = 'Sysinfo'
      ImageIndex = 1
      object SysInfoListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
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
          'Screen Resolution'
		  'Screen Saver Active')
        TabOrder = 0
        OnClick = SysInfoListBoxClick
        OnDblClick = InsertButtonClick
      end
    end
    object WinampTabSheet: TTabSheet
      Caption = 'Winamp'
      object WinampLocationBrowseButton: TSpeedButton
        Left = 160
        Top = 320
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
        Top = 304
        Width = 104
        Height = 13
        Caption = 'Winamp.exe location:'
      end
      object WinampListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
        Height = 265
        ItemHeight = 13
        TabOrder = 0
        OnClick = WinampListBoxClick
        OnDblClick = InsertButtonClick
      end
      object WinampLocationEdit: TEdit
        Left = 8
        Top = 320
        Width = 153
        Height = 21
        TabOrder = 1
        Text = 'WinampLocationEdit'
      end
    end
    object MBMTabSheet: TTabSheet
      Caption = 'MBM'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      object RefreshTimeLabel: TLabel
        Left = 8
        Top = 324
        Width = 97
        Height = 13
        Caption = 'Refresh time (secs):'
      end
      object MBMListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
        Height = 313
        ItemHeight = 13
        TabOrder = 0
        OnClick = MBMListBoxClick
        OnDblClick = InsertButtonClick
      end
      object MBMRefreshTimeSpinEdit: TSpinEdit
        Left = 120
        Top = 320
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
    object InternetTabSheet: TTabSheet
      Caption = 'RSS'
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
        Width = 209
        Height = 265
        ItemHeight = 13
        Items.Strings = (
          'BBC World News'
          'BBC UK News'
          'Tweakers.net headlines (Dutch)'
          'The Register headlines'
          'Slashdot'
          'Wired News'
          'Latest LCD Smartie News'
          'Latest PalmOrb News'
          'BBC News business'
          'The Washington Post business'
          'Yahoo! entertainment'
          'New York Times health'
          'New York Times sports'
          'Volkskrant economie (Dutch)'
          '3voor12 (Dutch)'
          'Algemeen Dagblad (Dutch)')
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
        Top = 320
        Width = 177
        Height = 17
        Caption = 'Check for LCD Smartie updates'
        TabOrder = 2
        Visible = False
      end
    end
    object GameStatsTabSheet: TTabSheet
      Caption = 'Gamestats'
      ImageIndex = 4
      object Label11: TLabel
        Left = 8
        Top = 304
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
        Top = 264
        Width = 56
        Height = 13
        Caption = 'Game type:'
      end
      object GameServerEdit: TEdit
        Left = 16
        Top = 320
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
        Top = 280
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
        Width = 209
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
    object SetiAtHomeTabSheet: TTabSheet
      Caption = 'Seti@Home'
      ImageIndex = 7
      object Label41: TLabel
        Left = 3
        Top = 304
        Width = 171
        Height = 13
        Caption = 'Email address used with Seti@home'
      end
      object SetiAtHomeListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
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
        Top = 320
        Width = 209
        Height = 21
        TabOrder = 1
      end
    end
    object FoldingAtHomeTabSheet: TTabSheet
      Caption = 'Folding@Home'
      ImageIndex = 9
      object Label23: TLabel
        Left = 8
        Top = 304
        Width = 143
        Height = 13
        Caption = 'Username for Folding@Home:'
      end
      object FoldingAtHomeEmailEdit: TEdit
        Left = 8
        Top = 320
        Width = 201
        Height = 21
        TabOrder = 1
        Text = 'BobC'
      end
      object FoldingAtHomeListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
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
        Left = 26
        Top = 62
        Width = 36
        Height = 13
        Caption = 'Server:'
      end
      object Label32: TLabel
        Left = 7
        Top = 111
        Width = 55
        Height = 13
        Caption = 'Loginname:'
      end
      object Label33: TLabel
        Left = 12
        Top = 136
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object Label48: TLabel
        Left = 8
        Top = 306
        Width = 113
        Height = 13
        Caption = 'Email check time (mins):'
      end
      object Label50: TLabel
        Left = 8
        Top = 36
        Width = 69
        Height = 13
        Caption = 'Email account:'
      end
      object Label28: TLabel
        Left = 72
        Top = 3
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
        Left = 18
        Top = 87
        Width = 44
        Height = 13
        Caption = 'SSL port:'
      end
      object EmailPasswordEdit: TEdit
        Left = 64
        Top = 128
        Width = 145
        Height = 21
        Color = 16706270
        PasswordChar = '*'
        TabOrder = 4
        Text = 'Ur passw'
      end
      object EmailLoginEdit: TEdit
        Left = 64
        Top = 104
        Width = 145
        Height = 21
        TabOrder = 3
        Text = 'Ur loginname'
      end
      object EmailServerEdit: TEdit
        Left = 64
        Top = 56
        Width = 145
        Height = 21
        TabOrder = 1
        Text = 'Ur Server'
      end
      object EmailCheckTimeSpinEdit: TSpinEdit
        Left = 128
        Top = 304
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
        TabOrder = 5
        Value = 10
      end
      object EmailAccountComboBox: TComboBox
        Left = 80
        Top = 32
        Width = 49
        Height = 21
        Style = csDropDownList
        DropDownCount = 10
        ItemHeight = 13
        TabOrder = 0
        OnChange = EmailAccountComboBoxChange
      end
      object EmailSSLEdit: TEdit
        Left = 64
        Top = 80
        Width = 145
        Height = 21
        Hint = 'SSL addon for gmail (995)'
        Color = 16706270
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object EmailLastSubjectRadioButton: TRadioButton
        Left = 64
        Top = 200
        Width = 113
        Height = 17
        Caption = 'Last subject'
        TabOrder = 6
        OnClick = EmailAccountComboBoxChange
      end
      object EmailLastFromRadioButton: TRadioButton
        Left = 64
        Top = 224
        Width = 113
        Height = 17
        Caption = 'Last from'
        TabOrder = 7
        OnClick = EmailAccountComboBoxChange
      end
      object EmailMessageCountRadioButton: TRadioButton
        Left = 64
        Top = 176
        Width = 113
        Height = 17
        Caption = 'Message count'
        TabOrder = 8
        OnClick = EmailAccountComboBoxChange
      end
    end
    object NetworkStatsTabSheet: TTabSheet
      Caption = 'Net Stats'
      ImageIndex = 8
      object NetworkStatsListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
        Height = 305
        ItemHeight = 13
        TabOrder = 0
        OnClick = NetworkStatsListBoxClick
        OnDblClick = InsertButtonClick
      end
      object NetworkStatsAdapterListButton: TButton
        Left = 56
        Top = 312
        Width = 75
        Height = 25
        Caption = 'Adapter List'
        TabOrder = 1
        OnClick = NetworkStatsAdapterListButtonClick
      end
    end
    object MiscTabSheet: TTabSheet
      Caption = 'Misc.'
      ImageIndex = 6
      object MiscListBox: TListBox
        Left = 0
        Top = 0
        Width = 209
        Height = 317
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
        TabOrder = 0
        OnClick = MiscListBoxClick
        OnDblClick = InsertButtonClick
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
        Width = 209
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
    object PluginsTabSheet: TTabSheet
      Caption = 'Plugins'
      ImageIndex = 11
      object PluginListBox: TFileListBox
        Left = 0
        Top = 0
        Width = 209
        Height = 281
        ItemHeight = 13
        Mask = '*.dll'
        TabOrder = 0
        OnClick = PluginListBoxClick
        OnDblClick = PluginListBoxDblClick
      end
      object Btn_PluginRefresh: TButton
        Left = 0
        Top = 288
        Width = 75
        Height = 25
        Caption = 'Refresh'
        TabOrder = 1
        OnClick = Btn_PluginRefreshClick
      end
    end
    object CCharTabSheet: TTabSheet
      Caption = 'Char editor'
      ImageIndex = 12
      object Label20: TLabel
        Left = 32
        Top = 8
        Width = 119
        Height = 13
        Caption = 'Create Character in slot:'
      end
      object Label21: TLabel
        Left = 32
        Top = 201
        Width = 102
        Height = 13
        Caption = 'Use character in slot:'
      end
      object Panel2: TPanel
        Left = 56
        Top = 40
        Width = 105
        Height = 145
        Caption = 'Panel2'
        TabOrder = 0
        object CCharCheckBox1: TCheckBox
          Left = 16
          Top = 8
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 0
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox2: TCheckBox
          Left = 32
          Top = 8
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 1
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox3: TCheckBox
          Left = 48
          Top = 8
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 2
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox4: TCheckBox
          Left = 64
          Top = 8
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 3
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox5: TCheckBox
          Left = 80
          Top = 8
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 4
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox6: TCheckBox
          Left = 16
          Top = 24
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 5
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox7: TCheckBox
          Left = 32
          Top = 24
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 6
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox8: TCheckBox
          Left = 48
          Top = 24
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 7
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox9: TCheckBox
          Left = 64
          Top = 24
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 8
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox10: TCheckBox
          Left = 80
          Top = 24
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 9
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox11: TCheckBox
          Left = 16
          Top = 40
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 10
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox12: TCheckBox
          Left = 32
          Top = 40
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 11
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox13: TCheckBox
          Left = 48
          Top = 40
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 12
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox14: TCheckBox
          Left = 64
          Top = 40
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 13
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox15: TCheckBox
          Left = 80
          Top = 40
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 14
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox16: TCheckBox
          Left = 16
          Top = 56
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 15
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox17: TCheckBox
          Left = 32
          Top = 56
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 16
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox18: TCheckBox
          Left = 48
          Top = 56
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 17
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox19: TCheckBox
          Left = 64
          Top = 56
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 18
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox20: TCheckBox
          Left = 80
          Top = 56
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 19
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox21: TCheckBox
          Left = 16
          Top = 72
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 20
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox22: TCheckBox
          Left = 32
          Top = 72
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 21
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox23: TCheckBox
          Left = 48
          Top = 72
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 22
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox24: TCheckBox
          Left = 64
          Top = 72
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 23
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox25: TCheckBox
          Left = 80
          Top = 72
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 24
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox26: TCheckBox
          Left = 16
          Top = 88
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 25
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox27: TCheckBox
          Left = 32
          Top = 88
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 26
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox28: TCheckBox
          Left = 48
          Top = 88
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 27
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox29: TCheckBox
          Left = 64
          Top = 88
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 28
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox30: TCheckBox
          Left = 80
          Top = 88
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 29
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox31: TCheckBox
          Left = 16
          Top = 104
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 30
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox32: TCheckBox
          Left = 32
          Top = 104
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 31
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox33: TCheckBox
          Left = 48
          Top = 104
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 32
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox34: TCheckBox
          Left = 64
          Top = 104
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 33
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox35: TCheckBox
          Left = 80
          Top = 104
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 34
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox36: TCheckBox
          Left = 16
          Top = 120
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 35
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox37: TCheckBox
          Left = 32
          Top = 120
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 36
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox38: TCheckBox
          Left = 48
          Top = 120
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 37
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox39: TCheckBox
          Left = 64
          Top = 120
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 38
          OnClick = CCharEditGridChange
        end
        object CCharCheckBox40: TCheckBox
          Left = 80
          Top = 120
          Width = 17
          Height = 17
          Caption = 'CCharCheckBox1'
          TabOrder = 39
          OnClick = CCharEditGridChange
        end
      end
      object CreateCCharLocSpinEdit: TSpinEdit
        Left = 160
        Top = 6
        Width = 31
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        MaxValue = 8
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
        OnChange = CCharEditGridChange
      end
      object CreateCCharRadioButton: TRadioButton
        Left = 8
        Top = 8
        Width = 17
        Height = 17
        Caption = 'CreateCCharRadioButton'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = CCharEditGridChange
      end
      object UseCCharRadioButton2: TRadioButton
        Left = 8
        Top = 200
        Width = 17
        Height = 17
        Caption = 'UseCCharRadioButton2'
        TabOrder = 3
        OnClick = CCharEditGridChange
      end
      object UseCCharLocSpinEdit: TSpinEdit
        Left = 152
        Top = 199
        Width = 31
        Height = 22
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 5
        MaxValue = 8
        MinValue = 1
        ParentFont = False
        TabOrder = 4
        Value = 1
        OnChange = CCharEditGridChange
      end
    end
  end
  object OKButton: TButton
    Left = 572
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
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 652
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
    TabOrder = 5
  end
  object VariableEdit: TEdit
    Left = 8
    Top = 356
    Width = 185
    Height = 17
    TabStop = False
    BorderStyle = bsNone
    Color = clBtnFace
    Ctl3D = True
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    Text = '[Variable]'
  end
  object InsertButton: TButton
    Left = 72
    Top = 376
    Width = 59
    Height = 25
    Hint = 
      'Insert the above chosen variable into the currently active scree' +
      'n line.'
    Caption = '&Insert -->'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = InsertButtonClick
  end
  object ApplyButton: TButton
    Left = 732
    Top = 384
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 6
    OnClick = ApplyButtonClick
  end
  object MainPageControl: TPageControl
    Left = 264
    Top = 0
    Width = 581
    Height = 381
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
        TabOrder = 2
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
          TabOrder = 8
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
          TabOrder = 12
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
          TabOrder = 16
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
          TabOrder = 20
        end
        object GroupBox4: TGroupBox
          Left = 464
          Top = 8
          Width = 2
          Height = 161
          Enabled = False
          TabOrder = 22
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
          TabOrder = 9
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
          TabOrder = 13
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
          TabOrder = 17
          OnClick = ContinueLine3CheckBoxClick
        end
        object GroupBox5: TGroupBox
          Left = 512
          Top = 8
          Width = 2
          Height = 161
          Enabled = False
          TabOrder = 23
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
          TabOrder = 10
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
          TabOrder = 14
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
          TabOrder = 18
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
          TabOrder = 21
        end
        object GroupBox6: TGroupBox
          Left = 424
          Top = 8
          Width = 2
          Height = 57
          Enabled = False
          TabOrder = 24
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
          TabOrder = 2
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
          TabOrder = 3
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
          TabOrder = 5
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
          TabOrder = 6
          OnChange = SkipScreenComboBoxChange
          Items.Strings = (
            'Don'#39't skip'
            'Winamp is inactive'
            'Winamp is active'
            'MBM is inactive'
            'MBM is active'
            'There is no new E-Mail'
            'There is new E-Mail')
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
          TabOrder = 1
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
          TabOrder = 4
          Value = 3
        end
        object Line1Edit: TEdit
          Left = 4
          Top = 74
          Width = 417
          Height = 23
          Hint = 'double click to open edit window'
          BevelEdges = []
          Color = 10606500
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnDblClick = LineEditClick
          OnEnter = Line1EditEnter
          OnKeyDown = Line1EditKeyDown
        end
        object Line2Edit: TEdit
          Left = 4
          Top = 98
          Width = 417
          Height = 23
          Hint = 'double click to open edit window'
          BevelEdges = []
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnDblClick = LineEditClick
          OnEnter = Line2EditEnter
          OnKeyDown = Line2EditKeyDown
        end
        object Line3Edit: TEdit
          Left = 4
          Top = 122
          Width = 417
          Height = 23
          Hint = 'double click to open edit window'
          BevelEdges = []
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          OnDblClick = LineEditClick
          OnEnter = Line3EditEnter
          OnKeyDown = Line3EditKeyDown
        end
        object Line4Edit: TEdit
          Left = 4
          Top = 146
          Width = 417
          Height = 23
          Hint = 'double click to open edit window'
          BevelEdges = []
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 19
          OnDblClick = LineEditClick
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
          TabOrder = 0
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
        TabOrder = 0
        DesignSize = (
          270
          166)
        object Label1: TLabel
          Left = 8
          Top = 48
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
          Top = 72
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
          TabOrder = 4
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
          TabOrder = 5
          Text = '0'
        end
        object ColorSchemeComboBox: TComboBox
          Left = 84
          Top = 67
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
          Top = 42
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
        object EmulateLCDCheckbox: TCheckBox
          Left = 8
          Top = 90
          Width = 257
          Height = 17
          Caption = 'Emulate LCD  (more CPU intensive)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
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
        TabOrder = 1
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
            ActivePage = ScreenTabsheet
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
                ItemHeight = 0
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
                ItemHeight = 13
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
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
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
      end
    end
    object StartupTabSheet: TTabSheet
      Caption = 'Startup/Shutdown'
      ImageIndex = 2
      DesignSize = (
        573
        353)
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
      object ShutdownMessageGroup: TGroupBox
        Left = 8
        Top = 164
        Width = 437
        Height = 117
        Hint = 'Custom message to be displayed when LCD Smartie is shut down.'
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Shut down message'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        object ShutdownEdit1: TEdit
          Left = 8
          Top = 14
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
          TabOrder = 0
          OnEnter = ShutdownEditEnter
          OnKeyDown = ShutdownEdit1KeyDown
        end
        object ShutdownEdit2: TEdit
          Left = 8
          Top = 38
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
          TabOrder = 1
          OnEnter = ShutdownEditEnter
          OnKeyDown = ShutdownEdit2KeyDown
        end
        object ShutdownEdit3: TEdit
          Left = 8
          Top = 62
          Width = 417
          Height = 23
          BevelEdges = []
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnEnter = ShutdownEditEnter
          OnKeyDown = ShutdownEdit3KeyDown
        end
        object ShutdownEdit4: TEdit
          Left = 8
          Top = 86
          Width = 417
          Height = 23
          BevelEdges = []
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnEnter = ShutdownEditEnter
          OnKeyDown = ShutdownEdit4KeyDown
        end
      end
    end
    object MyTabSheet: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 3
      DesignSize = (
        573
        353)
      object Label9: TLabel
        Left = 16
        Top = 83
        Width = 50
        Height = 13
        Caption = 'Tray Icon:'
      end
      object TrayIconPreview32: TImage
        Left = 272
        Top = 96
        Width = 32
        Height = 32
        AutoSize = True
      end
      object TrayIconBrowseButton: TSpeedButton
        Left = 232
        Top = 103
        Width = 23
        Height = 22
        Hint = 'Click to choose the tray icon for this program instance.'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          88888888888888888888000000000008888800333333333088880B0333333333
          08880FB03333333330880BFB0333333333080FBFB000000000000BFBFBFBFB08
          88880FBFBFBFBF0888880BFB0000000888888000888888880008888888888888
          8008888888880888080888888888800088888888888888888888}
        ParentShowHint = False
        ShowHint = True
        OnClick = TrayIconBrowseButtonClick
      end
      object TrayIconPreview16: TImage
        Left = 312
        Top = 112
        Width = 16
        Height = 16
        Anchors = [akLeft, akBottom]
        AutoSize = True
      end
      object Label10: TLabel
        Left = 16
        Top = 27
        Width = 48
        Height = 13
        Caption = 'Skin Path:'
      end
      object SkinPathBrowseButton: TSpeedButton
        Left = 232
        Top = 47
        Width = 23
        Height = 22
        Hint = 'Click to choose skin path for this program instance.'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          88888888888888888888000000000008888800333333333088880B0333333333
          08880FB03333333330880BFB0333333333080FBFB000000000000BFBFBFBFB08
          88880FBFBFBFBF0888880BFB0000000888888000888888880008888888888888
          8008888888880888080888888888800088888888888888888888}
        ParentShowHint = False
        ShowHint = True
        OnClick = SkinPathBrowseButtonClick
      end
      object DistributedNetBrowseButton: TSpeedButton
        Left = 232
        Top = 260
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
        Left = 20
        Top = 244
        Width = 107
        Height = 13
        Caption = 'Distributed.net logfile:'
      end
      object Label58: TLabel
        Left = 20
        Top = 216
        Width = 114
        Height = 13
        Caption = 'DLL check interval (ms):'
      end
      object TrayIcon: TEdit
        Left = 16
        Top = 102
        Width = 217
        Height = 21
        BevelEdges = []
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 1
      end
      object StayOnTopCheckBox: TCheckBox
        Left = 16
        Top = 148
        Width = 81
        Height = 17
        Caption = '&Stay on top'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object RandomizeScreensCheckBox: TCheckBox
        Left = 16
        Top = 180
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
        TabOrder = 3
      end
      object SkinPath: TEdit
        Left = 16
        Top = 46
        Width = 217
        Height = 21
        BevelEdges = []
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 0
      end
      object DistributedNetLogfileEdit: TEdit
        Left = 16
        Top = 260
        Width = 217
        Height = 21
        TabOrder = 5
      end
      object DLLCheckIntervalSpinEdit: TSpinEdit
        Left = 140
        Top = 212
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
        TabOrder = 4
        Value = 200
      end
    end
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
  object OpenIco: TOpenPictureDialog
    DefaultExt = 'ico'
    Filter = 'Icons (*.ico)|*.ico'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofNoNetworkButton, ofEnableSizing]
    OptionsEx = [ofExNoPlacesBar]
    Title = 'Choose Icon for Tray Area'
    OnFolderChange = OpeIcoFolderChange
    Left = 480
    Top = 384
  end
end
