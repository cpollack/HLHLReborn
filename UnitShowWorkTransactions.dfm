object FormShowWorkTransactions: TFormShowWorkTransactions
  Left = 517
  Top = 303
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'HLHLReborn - Transactions'
  ClientHeight = 210
  ClientWidth = 275
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
  object lblRepeatCount: TLabel
    Left = 3
    Top = 188
    Width = 98
    Height = 13
    Caption = 'lblRepeatCount'
  end
  object StringGridTransactions: TStringGrid
    Left = 3
    Top = 7
    Width = 268
    Height = 169
    Color = clInfoBk
    ColCount = 3
    DefaultRowHeight = 14
    FixedCols = 0
    RowCount = 12
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    ColWidths = (
      21
      204
      21)
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
      14)
  end
  object ButtonHide: TButton
    Left = 222
    Top = 184
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
end
