object FormMain: TFormMain
  Left = 634
  Top = 329
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'HLHL'
  ClientHeight = 373
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelCreateWG: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object ButtonShowWGs: TButton
      Left = 7
      Top = 46
      Width = 116
      Height = 22
      Caption = 'Show Kungfu'
      TabOrder = 0
      OnClick = ButtonShowWGsClick
    end
    object ButtonSetWGAttr: TButton
      Left = 10
      Top = 24
      Width = 113
      Height = 22
      Caption = 'Create Params'
      TabOrder = 1
      OnClick = ButtonSetWGAttrClick
    end
    object CheckBoxBeginCreateWG: TCheckBox
      Left = 144
      Top = 52
      Width = 73
      Height = 16
      Caption = 'Start'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CheckBoxBeginCreateWGClick
    end
  end
  object PanelCapture: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object Label2: TLabel
      Left = 8
      Top = 7
      Width = 63
      Height = 13
      Caption = 'Pet Name:'
    end
    object Label3: TLabel
      Left = 9
      Top = 40
      Width = 77
      Height = 13
      Caption = 'Catch level'
    end
    object Label4: TLabel
      Left = 64
      Top = 62
      Width = 14
      Height = 13
      Caption = 'to'
    end
    object Label5: TLabel
      Left = 133
      Top = 62
      Width = 21
      Height = 13
      Caption = 'pet'
    end
    object EditMonsterToCapture: TEdit
      Left = 77
      Top = 6
      Width = 87
      Height = 21
      Color = clInfoBk
      ImeName = #32043#20809#25340#38899#36755#20837#27861
      TabOrder = 0
      Text = 'Toturtle'
    end
    object CheckBoxBeginCapture: TCheckBox
      Left = 92
      Top = 86
      Width = 72
      Height = 17
      Caption = 'Start'
      TabOrder = 1
      OnClick = CheckBoxBeginCaptureClick
    end
    object EditCaptureLevelFrom: TEdit
      Left = 92
      Top = 37
      Width = 35
      Height = 21
      Color = clInfoBk
      ImeName = #32043#20809#25340#38899#36755#20837#27861
      TabOrder = 2
      Text = '1'
      OnKeyPress = EditCaptureLevelFromKeyPress
    end
    object EditCaptureLevelTo: TEdit
      Left = 91
      Top = 59
      Width = 35
      Height = 21
      Color = clInfoBk
      ImeName = #32043#20809#25340#38899#36755#20837#27861
      TabOrder = 3
      Text = '1200'
      OnKeyPress = EditCaptureLevelFromKeyPress
    end
  end
  object PanelTigerMachine: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 208
      Height = 45
      Caption = 'Note: please do not select the machine on the far side.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #38582#20070
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object ButtonShowImage: TButton
      Left = 8
      Top = 56
      Width = 101
      Height = 22
      Caption = 'Locat Icon(?)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonShowImageClick
    end
    object CheckBoxBeginTigerMachine: TCheckBox
      Left = 132
      Top = 60
      Width = 73
      Height = 17
      Caption = 'Start'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CheckBoxBeginTigerMachineClick
    end
  end
  object PanelAux: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object ButtonGetNPCDialog: TButton
      Left = 70
      Top = 86
      Width = 147
      Height = 22
      Caption = 'Get Convo Content'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonGetNPCDialogClick
    end
    object ButtonUnPatchAll: TButton
      Left = 2
      Top = 86
      Width = 68
      Height = 22
      Caption = 'Restore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ButtonUnPatchAllClick
    end
    object MemoWinInfo: TMemo
      Left = 4
      Top = 8
      Width = 213
      Height = 73
      Color = clInfoBk
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      Lines.Strings = (
        'Move the mouse to the game '
        'window,'
        'Press '#39'Grab Hotkey'#39' to display '
        'the location'
        'In the map ID, the selected '
        'window name'
        'The coordinates of the window '
        'are relative to the mouse')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object PanelWork: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label6: TLabel
      Left = 4
      Top = 8
      Width = 98
      Height = 13
      Caption = 'Select Script:'
    end
    object CheckBoxBeginWork: TCheckBox
      Left = 89
      Top = 88
      Width = 72
      Height = 17
      Caption = 'Run'
      TabOrder = 0
      OnClick = CheckBoxBeginWorkClick
    end
    object ComboBoxScripts: TComboBox
      Left = 5
      Top = 25
      Width = 156
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      DropDownCount = 12
      ImeName = #32043#20809#25340#38899#36755#20837#27861
      TabOrder = 1
      OnChange = ButtonReadScriptClick
    end
    object ButtonReadScript: TButton
      Left = 4
      Top = 54
      Width = 59
      Height = 22
      Caption = 'Read'
      TabOrder = 2
      OnClick = ButtonReadScriptClick
    end
    object chkSort: TCheckBox
      Left = 89
      Top = 54
      Width = 72
      Height = 17
      Caption = 'Sort'
      TabOrder = 3
      OnClick = chkSortClick
    end
    object btnShowScript: TButton
      Left = 4
      Top = 86
      Width = 59
      Height = 22
      Caption = 'Display'
      TabOrder = 4
      OnClick = btnShowScriptClick
    end
  end
  object PanelMove: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object LabelMap: TLabel
      Left = 4
      Top = 39
      Width = 28
      Height = 13
      Caption = 'Map:'
    end
    object Label8: TLabel
      Left = 0
      Top = 16
      Width = 35
      Height = 13
      Caption = 'Zone:'
    end
    object ComboBoxZone: TComboBox
      Left = 43
      Top = 6
      Width = 117
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      DropDownCount = 12
      TabOrder = 0
      OnChange = ComboBoxZoneChange
    end
    object ButtonMove: TButton
      Left = 115
      Top = 64
      Width = 45
      Height = 22
      Caption = 'Move'
      TabOrder = 1
      OnClick = ButtonMoveClick
    end
    object ComboBoxMap: TComboBox
      Left = 43
      Top = 35
      Width = 117
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      DropDownCount = 12
      TabOrder = 2
    end
    object ButtonStopMove: TButton
      Left = 59
      Top = 64
      Width = 50
      Height = 22
      Caption = 'Cancel'
      TabOrder = 3
      OnClick = ButtonStopMoveClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 221
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object LabelTitle: TLabel
      Left = 0
      Top = 4
      Width = 205
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'HLHLReborn Version 1.02'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
    end
    object RadioGroupWorkMode: TRadioGroup
      Left = 3
      Top = 23
      Width = 213
      Height = 74
      Caption = 'Mode'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Script'
        'Move'
        'Casino'
        'Battle'
        'Capture'
        'Kungfu'
        'Stats'
        'Misc')
      TabOrder = 0
      OnClick = RadioGroupWorkModeClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 260
    Width = 221
    Height = 113
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    object ButtonHide: TButton
      Left = 170
      Top = 56
      Width = 46
      Height = 22
      Caption = 'Hide'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonHideClick
    end
    object ButtonGeneralSet: TButton
      Left = 2
      Top = 82
      Width = 69
      Height = 22
      Caption = 'Settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonGeneralSetClick
    end
    object ButtonShowUniverseStove: TButton
      Left = 129
      Top = 2
      Width = 89
      Height = 22
      Caption = 'Wuxing Oven'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ButtonShowUniverseStoveClick
    end
    object ButtonShowStuff: TButton
      Left = 2
      Top = 2
      Width = 69
      Height = 22
      Caption = 'Inventory'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ButtonShowStuffClick
    end
    object btnPet: TButton
      Left = 77
      Top = 2
      Width = 50
      Height = 22
      Caption = 'Pet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnPetClick
    end
    object ButtonCancelNPCDialog: TButton
      Left = 2
      Top = 30
      Width = 109
      Height = 22
      Caption = 'Close Dialogue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = ButtonCancelNPCDialogClick
    end
    object ButtonShowTransactions: TButton
      Left = 117
      Top = 30
      Width = 99
      Height = 22
      Caption = 'Show Script'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = ButtonShowTransactionsClick
    end
    object btnClose: TButton
      Left = 166
      Top = 82
      Width = 51
      Height = 22
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = btnCloseClick
    end
    object btnDevelop: TButton
      Left = 123
      Top = 82
      Width = 41
      Height = 22
      Caption = 'Edit'
      TabOrder = 8
      OnClick = btnDevelopClick
    end
    object Button1: TButton
      Left = 2
      Top = 56
      Width = 147
      Height = 22
      Caption = 'Patch Battle Speed'
      TabOrder = 9
      OnClick = Button1Click
    end
  end
  object PanelBattle: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 8
    object Label7: TLabel
      Left = 3
      Top = 27
      Width = 21
      Height = 13
      Caption = 'Pet'
    end
    object Label9: TLabel
      Left = 2
      Top = 82
      Width = 42
      Height = 13
      Caption = 'Attack'
    end
    object Label10: TLabel
      Left = 2
      Top = 46
      Width = 35
      Height = 13
      Caption = 'Level'
    end
    object Label11: TLabel
      Left = 2
      Top = 101
      Width = 49
      Height = 13
      Caption = 'Defence'
    end
    object Label12: TLabel
      Left = 2
      Top = 120
      Width = 63
      Height = 13
      Caption = 'Dexterity'
    end
    object Label13: TLabel
      Left = 2
      Top = 64
      Width = 28
      Height = 13
      Caption = 'Life'
    end
    object LabelPetName: TLabel
      Left = 38
      Top = 27
      Width = 42
      Height = 13
      Caption = '[name]'
    end
    object Label15: TLabel
      Left = 100
      Top = 40
      Width = 49
      Height = 13
      Caption = 'Current'
    end
    object Label16: TLabel
      Left = 166
      Top = 40
      Width = 42
      Height = 13
      Caption = 'Growth'
    end
    object LabelCurrLIfe: TLabel
      Left = 112
      Top = 64
      Width = 28
      Height = 13
      Caption = '[l1]'
    end
    object LabelCurrAttack: TLabel
      Left = 112
      Top = 81
      Width = 28
      Height = 13
      Caption = '[a1]'
    end
    object LabelCurrDefence: TLabel
      Left = 112
      Top = 100
      Width = 28
      Height = 13
      Caption = '[d1]'
    end
    object LabelCurrDexterity: TLabel
      Left = 112
      Top = 119
      Width = 28
      Height = 13
      Caption = '[x1]'
    end
    object LabelGrLife: TLabel
      Left = 166
      Top = 64
      Width = 28
      Height = 13
      Caption = '[l2]'
    end
    object LabelGrAttack: TLabel
      Left = 166
      Top = 81
      Width = 28
      Height = 13
      Caption = '[a2]'
    end
    object LabelGrDefence: TLabel
      Left = 166
      Top = 100
      Width = 28
      Height = 13
      Caption = '[d2]'
    end
    object LabelGrDexterity: TLabel
      Left = 166
      Top = 119
      Width = 28
      Height = 13
      Caption = '[x2]'
    end
    object Label3AGr: TLabel
      Left = 69
      Top = 144
      Width = 28
      Height = 13
      Caption = '[3a]'
    end
    object Label26: TLabel
      Left = 110
      Top = 144
      Width = 35
      Height = 13
      Caption = 'Medal'
    end
    object LabelMedalGr: TLabel
      Left = 151
      Top = 144
      Width = 49
      Height = 13
      Caption = '[medal]'
    end
    object Label28: TLabel
      Left = 0
      Top = 144
      Width = 63
      Height = 13
      Caption = '3A Growth'
    end
    object Label14: TLabel
      Left = 120
      Top = 9
      Width = 49
      Height = 13
      Caption = 'Stop at'
    end
    object LabelCurrLevel: TLabel
      Left = 43
      Top = 45
      Width = 35
      Height = 13
      Caption = '[lvl]'
    end
    object CheckBoxStartBattle: TCheckBox
      Left = 7
      Top = 6
      Width = 116
      Height = 17
      Caption = 'Start Battle'
      TabOrder = 0
      OnClick = CheckBoxStartBattleClick
    end
    object EditPetLife: TEdit
      Left = 69
      Top = 59
      Width = 25
      Height = 21
      TabOrder = 1
      Text = '50'
      OnChange = PetBaseStatsChange
    end
    object EditPetAttack: TEdit
      Left = 69
      Top = 79
      Width = 25
      Height = 21
      TabOrder = 2
      Text = '7'
      OnChange = PetBaseStatsChange
    end
    object EditPetDefence: TEdit
      Left = 69
      Top = 99
      Width = 25
      Height = 21
      TabOrder = 3
      Text = '6'
      OnChange = PetBaseStatsChange
    end
    object EditPetDexterity: TEdit
      Left = 69
      Top = 118
      Width = 25
      Height = 21
      TabOrder = 4
      Text = '5'
      OnChange = PetBaseStatsChange
    end
    object EditBattleStopLevel: TEdit
      Left = 175
      Top = 6
      Width = 35
      Height = 21
      NumbersOnly = True
      TabOrder = 5
      Text = '5000'
    end
  end
  object PanelStats: TPanel
    Left = 0
    Top = 97
    Width = 221
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 9
    object Label17: TLabel
      Left = 10
      Top = 8
      Width = 77
      Height = 13
      Caption = 'Apply Stats'
    end
    object Label18: TLabel
      Left = 46
      Top = 48
      Width = 28
      Height = 13
      Caption = 'Life'
    end
    object Label19: TLabel
      Left = 46
      Top = 71
      Width = 28
      Height = 13
      Caption = 'Mana'
    end
    object Label20: TLabel
      Left = 32
      Top = 93
      Width = 42
      Height = 13
      Caption = 'Attack'
    end
    object Label21: TLabel
      Left = 25
      Top = 113
      Width = 49
      Height = 13
      Caption = 'Defense'
    end
    object Label22: TLabel
      Left = 11
      Top = 138
      Width = 63
      Height = 13
      Caption = 'Dexterity'
    end
    object Label23: TLabel
      Left = 11
      Top = 26
      Width = 63
      Height = 13
      Caption = 'Available'
    end
    object EditStatAvailable: TEdit
      Left = 80
      Top = 25
      Width = 46
      Height = 21
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object EditStatAttack: TEdit
      Left = 80
      Top = 90
      Width = 46
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      Text = '0'
      OnChange = UpdateUserAttributes
    end
    object EditStatDefense: TEdit
      Left = 80
      Top = 112
      Width = 46
      Height = 21
      NumbersOnly = True
      TabOrder = 2
      Text = '0'
      OnChange = UpdateUserAttributes
    end
    object EditStatDexterity: TEdit
      Left = 80
      Top = 134
      Width = 46
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      Text = '0'
      OnChange = UpdateUserAttributes
    end
    object EditStatLife: TEdit
      Left = 80
      Top = 46
      Width = 46
      Height = 21
      NumbersOnly = True
      TabOrder = 4
      Text = '0'
      OnChange = UpdateUserAttributes
    end
    object ButtonApplyStats: TButton
      Left = 146
      Top = 134
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 5
      OnClick = ButtonApplyStatsClick
    end
    object EditStatMana: TEdit
      Left = 80
      Top = 68
      Width = 46
      Height = 21
      NumbersOnly = True
      TabOrder = 6
      Text = '0'
      OnChange = UpdateUserAttributes
    end
  end
end
