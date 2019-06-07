object FormShowStuffs: TFormShowStuffs
  Left = 328
  Top = 192
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'HLHLReborn - Inventory'
  ClientHeight = 280
  ClientWidth = 475
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
  object LabelMoney: TLabel
    Left = 4
    Top = 259
    Width = 70
    Height = 13
    Caption = 'LabelMoney'
  end
  object StringGridStuffs: TStringGrid
    Left = 3
    Top = 7
    Width = 470
    Height = 244
    Color = clInfoBk
    ColCount = 10
    DefaultRowHeight = 14
    FixedCols = 0
    RowCount = 16
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
      105
      69
      45
      36
      40
      39
      37
      35
      30)
    RowHeights = (
      15
      14
      14
      14
      14
      14
      14
      14
      14
      14
      14
      14
      14
      14
      14
      14)
  end
  object ButtonHide: TButton
    Left = 424
    Top = 256
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
    Left = 360
    Top = 256
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
end
