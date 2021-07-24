object FormShowPets: TFormShowPets
  Left = 388
  Top = 242
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'HLHLReborn - Show Pets'
  ClientHeight = 266
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 9
    Top = 115
    Width = 16
    Height = 13
    Caption = 'Pet'
  end
  object LabelPetName: TLabel
    Left = 44
    Top = 115
    Width = 32
    Height = 13
    Caption = '[name]'
  end
  object Label10: TLabel
    Left = 8
    Top = 134
    Width = 26
    Height = 13
    Caption = 'Level'
  end
  object LabelCurrLevel: TLabel
    Left = 49
    Top = 133
    Width = 16
    Height = 13
    Caption = '[lvl]'
  end
  object Label15: TLabel
    Left = 108
    Top = 133
    Width = 34
    Height = 13
    Caption = 'Current'
  end
  object Label16: TLabel
    Left = 174
    Top = 133
    Width = 34
    Height = 13
    Caption = 'Growth'
  end
  object Label13: TLabel
    Left = 8
    Top = 152
    Width = 17
    Height = 13
    Caption = 'Life'
  end
  object LabelCurrLIfe: TLabel
    Left = 118
    Top = 152
    Width = 14
    Height = 13
    Caption = '[l1]'
  end
  object LabelGrLife: TLabel
    Left = 172
    Top = 152
    Width = 14
    Height = 13
    Caption = '[l2]'
  end
  object LabelGrAttack: TLabel
    Left = 172
    Top = 169
    Width = 18
    Height = 13
    Caption = '[a2]'
  end
  object LabelCurrAttack: TLabel
    Left = 118
    Top = 169
    Width = 18
    Height = 13
    Caption = '[a1]'
  end
  object Label9: TLabel
    Left = 8
    Top = 170
    Width = 31
    Height = 13
    Caption = 'Attack'
  end
  object Label11: TLabel
    Left = 8
    Top = 189
    Width = 41
    Height = 13
    Caption = 'Defence'
  end
  object LabelCurrDefence: TLabel
    Left = 118
    Top = 188
    Width = 18
    Height = 13
    Caption = '[d1]'
  end
  object LabelGrDefence: TLabel
    Left = 172
    Top = 188
    Width = 18
    Height = 13
    Caption = '[d2]'
  end
  object LabelGrDexterity: TLabel
    Left = 172
    Top = 207
    Width = 17
    Height = 13
    Caption = '[x2]'
  end
  object LabelCurrDexterity: TLabel
    Left = 118
    Top = 207
    Width = 17
    Height = 13
    Caption = '[x1]'
  end
  object Label12: TLabel
    Left = 8
    Top = 208
    Width = 41
    Height = 13
    Caption = 'Dexterity'
  end
  object Label28: TLabel
    Left = 6
    Top = 232
    Width = 50
    Height = 13
    Caption = '3A Growth'
  end
  object Label3AGr: TLabel
    Left = 75
    Top = 232
    Width = 18
    Height = 13
    Caption = '[3a]'
  end
  object Label26: TLabel
    Left = 116
    Top = 232
    Width = 29
    Height = 13
    Caption = 'Medal'
  end
  object LabelMedalGr: TLabel
    Left = 157
    Top = 232
    Width = 34
    Height = 13
    Caption = '[medal]'
  end
  object StringGridWGs: TStringGrid
    Left = 3
    Top = 7
    Width = 268
    Height = 94
    Color = clInfoBk
    DefaultRowHeight = 14
    FixedCols = 0
    RowCount = 6
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    ColWidths = (
      21
      114
      30
      26
      70)
    RowHeights = (
      15
      14
      14
      14
      14
      14)
  end
  object ButtonHide: TButton
    Left = 218
    Top = 236
    Width = 49
    Height = 22
    Caption = 'Hide'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonHideClick
  end
  object btnRefresh: TButton
    Left = 208
    Top = 107
    Width = 59
    Height = 22
    Caption = 'Refresh'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnRefreshClick
  end
  object EditPetLife: TEdit
    Left = 75
    Top = 147
    Width = 25
    Height = 21
    TabOrder = 3
    Text = '50'
    OnChange = PetBaseStatsChange
  end
  object EditPetAttack: TEdit
    Left = 75
    Top = 167
    Width = 25
    Height = 21
    TabOrder = 4
    Text = '7'
    OnChange = PetBaseStatsChange
  end
  object EditPetDefence: TEdit
    Left = 75
    Top = 187
    Width = 25
    Height = 21
    TabOrder = 5
    Text = '6'
    OnChange = PetBaseStatsChange
  end
  object EditPetDexterity: TEdit
    Left = 75
    Top = 206
    Width = 25
    Height = 21
    TabOrder = 6
    Text = '5'
    OnChange = PetBaseStatsChange
  end
  object btnRecord: TButton
    Left = 148
    Top = 107
    Width = 53
    Height = 22
    Caption = 'Record'
    TabOrder = 7
    OnClick = btnRecordClick
  end
end
