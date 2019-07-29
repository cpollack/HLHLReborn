object FormSetWGAttr: TFormSetWGAttr
  Left = 428
  Top = 351
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Kungfu Creation Params'
  ClientHeight = 327
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 236
    Height = 129
    Align = alTop
    Caption = 'Kungfu Params'
    TabOrder = 0
    object Label7: TLabel
      Left = 7
      Top = 20
      Width = 35
      Height = 13
      Caption = 'Name:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 123
      Top = 47
      Width = 42
      Height = 13
      Caption = 'Start:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 123
      Top = 75
      Width = 49
      Height = 13
      Caption = 'Flight:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 123
      Top = 103
      Width = 70
      Height = 13
      Caption = 'Explosion:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 7
      Top = 74
      Width = 49
      Height = 13
      Caption = 'Attack:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 7
      Top = 103
      Width = 35
      Height = 13
      Caption = 'Mana:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 8
      Top = 56
      Width = 107
      Height = 10
      Shape = bsBottomLine
    end
    object EditWGName: TEdit
      Left = 7
      Top = 37
      Width = 109
      Height = 21
      Color = clInfoBk
      TabOrder = 0
      Text = 'DivinePalm'
    end
    object EditWGXS: TEdit
      Left = 70
      Top = 71
      Width = 45
      Height = 21
      Color = clInfoBk
      TabOrder = 1
      Text = '1'
      OnKeyPress = EditWGXSKeyPress
    end
    object EditWGNL: TEdit
      Left = 71
      Top = 99
      Width = 44
      Height = 21
      Color = clInfoBk
      TabOrder = 2
      Text = '100'
      OnKeyPress = EditWGNLKeyPress
    end
    object ComboBoxWGQS: TComboBox
      Left = 187
      Top = 44
      Width = 41
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      ItemIndex = 0
      TabOrder = 3
      Text = '1'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
    object ComboBoxWGGJ: TComboBox
      Left = 187
      Top = 71
      Width = 41
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      ItemIndex = 0
      TabOrder = 4
      Text = '1'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19')
    end
    object ComboBoxWGBZ: TComboBox
      Left = 187
      Top = 99
      Width = 41
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      ItemIndex = 0
      TabOrder = 5
      Text = '1'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20')
    end
  end
  object gbGJConfig: TGroupBox
    Left = 0
    Top = 278
    Width = 236
    Height = 49
    Align = alBottom
    Caption = 'Override'
    TabOrder = 1
    object Label55: TLabel
      Left = 8
      Top = 23
      Width = 35
      Height = 13
      Caption = 'Title'
      Enabled = False
    end
    object Label56: TLabel
      Left = 136
      Top = 22
      Width = 28
      Height = 13
      Caption = 'Rank'
      Enabled = False
    end
    object ComboBoxGJRank: TComboBox
      Left = 44
      Top = 19
      Width = 83
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      Enabled = False
      TabOrder = 0
      OnChange = ComboBoxGJRankChange
      Items.Strings = (
        'Basic God'
        'Junior God'
        'Junior Devil'
        'Senior God'
        'Senior Devil'
        'Super God'
        'Super Devil'
        'Master God'
        'Master Devil')
    end
    object ComboBoxGJLevel: TComboBox
      Left = 172
      Top = 19
      Width = 52
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      Enabled = False
      TabOrder = 1
    end
  end
  object GroupBox14: TGroupBox
    Left = 0
    Top = 129
    Width = 236
    Height = 149
    Align = alClient
    Caption = 'Other Settings'
    TabOrder = 2
    object Label53: TLabel
      Left = 109
      Top = 20
      Width = 91
      Height = 13
      Caption = 'Auto Deletion'
    end
    object Label14: TLabel
      Left = 91
      Top = 103
      Width = 91
      Height = 13
      Caption = 'Stop creation'
    end
    object Label1: TLabel
      Left = 201
      Top = 75
      Width = 35
      Height = 13
      Caption = 'skill'
    end
    object CheckBoxAutoDeleteWG: TCheckBox
      Left = 7
      Top = 24
      Width = 49
      Height = 17
      Caption = 'First'
      TabOrder = 0
      OnClick = CheckBoxAutoDeleteWGClick
    end
    object ComboBoxDeleteFromPos: TComboBox
      Left = 62
      Top = 24
      Width = 41
      Height = 21
      Style = csDropDownList
      Color = clInfoBk
      DropDownCount = 10
      Enabled = False
      TabOrder = 1
    end
    object CheckBoxRemainEasyWG: TCheckBox
      Left = 33
      Top = 51
      Width = 123
      Height = 17
      Caption = 'Easy to make'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBoxRemainEasyWGClick
    end
    object CheckBoxLevelLimit: TCheckBox
      Left = 6
      Top = 103
      Width = 50
      Height = 15
      Caption = 'Drop to'
      TabOrder = 3
      OnClick = CheckBoxLevelLimitClick
    end
    object EditLevelLimited: TEdit
      Left = 54
      Top = 98
      Width = 33
      Height = 21
      Color = clInfoBk
      Enabled = False
      TabOrder = 4
      Text = '800'
      OnKeyPress = EditWGNLKeyPress
    end
    object CheckBoxDoFateCreateWG: TCheckBox
      Left = 6
      Top = 127
      Width = 195
      Height = 17
      Caption = 'Overtaking'
      TabOrder = 5
      OnClick = CheckBoxDoFateCreateWGClick
    end
    object CheckBoxRemainXS: TCheckBox
      Left = 33
      Top = 74
      Width = 121
      Height = 17
      Caption = 'Retain coefic'
      Enabled = False
      TabOrder = 6
      OnClick = CheckBoxRemainXSClick
    end
    object EditRemainedXS: TEdit
      Left = 156
      Top = 71
      Width = 41
      Height = 21
      Color = clInfoBk
      Enabled = False
      TabOrder = 7
      Text = '2.5'
      OnKeyPress = EditWGXSKeyPress
    end
  end
end
