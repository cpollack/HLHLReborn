object FormShowWGs: TFormShowWGs
  Left = 494
  Top = 277
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27426#20048#24187#28789#183#26174#31034#27494#21151
  ClientHeight = 199
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
  object StringGridWGs: TStringGrid
    Left = 3
    Top = 7
    Width = 268
    Height = 169
    Color = clInfoBk
    ColCount = 6
    DefaultRowHeight = 14
    FixedCols = 0
    RowCount = 11
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
      34
      34
      32
      35)
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
      14)
  end
  object ButtonHide: TButton
    Left = 222
    Top = 176
    Width = 49
    Height = 22
    Caption = #38544#34255
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonHideClick
  end
end
