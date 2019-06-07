object FormShowUniverseStove: TFormShowUniverseStove
  Left = 291
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27426#20048#24187#28789#183#26174#31034#20094#22372#20116#34892#28809
  ClientHeight = 257
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 97
    Top = 16
    Width = 60
    Height = 13
    Caption = '0. '#20094#183#37329
  end
  object Label8: TLabel
    Left = 41
    Top = 56
    Width = 60
    Height = 13
    Caption = '1. '#20817#183#37329
  end
  object Label11: TLabel
    Left = 153
    Top = 56
    Width = 60
    Height = 13
    Caption = '4. '#24061#183#26408
  end
  object Label12: TLabel
    Left = 185
    Top = 96
    Width = 60
    Height = 13
    Caption = '5. '#22350#183#27700
  end
  object Label9: TLabel
    Left = 9
    Top = 96
    Width = 60
    Height = 13
    Caption = '2. '#31163#183#28779
  end
  object Label13: TLabel
    Left = 153
    Top = 136
    Width = 60
    Height = 13
    Caption = '6. '#33390#183#22303
  end
  object Label10: TLabel
    Left = 41
    Top = 136
    Width = 60
    Height = 13
    Caption = '3. '#38663#183#26408
  end
  object Label14: TLabel
    Left = 97
    Top = 176
    Width = 60
    Height = 13
    Caption = '7. '#22372#183#22303
  end
  object LabelAnimator: TLabel
    Left = 107
    Top = 115
    Width = 52
    Height = 13
    Caption = #26410#22312#28860#21270
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label34: TLabel
    Left = 69
    Top = 229
    Width = 20
    Height = 13
    Caption = '0'#31186
  end
  object Label35: TLabel
    Left = 182
    Top = 229
    Width = 20
    Height = 13
    Caption = '5'#31186
  end
  object Label1: TLabel
    Left = 5
    Top = 228
    Width = 65
    Height = 13
    Caption = #28860#21270#24310#26102#65306
  end
  object Edit1: TEdit
    Left = 40
    Top = 72
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 8
    Top = 112
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 40
    Top = 152
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 152
    Top = 72
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 3
    Text = 'Edit4'
  end
  object Edit5: TEdit
    Left = 184
    Top = 112
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 4
    Text = 'Edit5'
  end
  object Edit6: TEdit
    Left = 152
    Top = 152
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 5
    Text = 'Edit6'
  end
  object Edit7: TEdit
    Left = 96
    Top = 192
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 6
    Text = 'Edit7'
  end
  object Edit0: TEdit
    Left = 96
    Top = 32
    Width = 73
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 7
    Text = 'Edit0'
  end
  object TrackBarForgeDelay: TTrackBar
    Left = 89
    Top = 224
    Width = 92
    Height = 27
    Max = 5000
    PageSize = 1000
    Frequency = 1000
    Position = 3200
    TabOrder = 8
  end
  object Button1: TButton
    Left = 211
    Top = 227
    Width = 49
    Height = 22
    Caption = #38544#34255
    TabOrder = 9
    OnClick = Button1Click
  end
end
