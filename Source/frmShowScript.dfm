object fShowScript: TfShowScript
  Left = 259
  Top = 107
  Caption = 'Scripts'
  ClientHeight = 441
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object Splitter1: TSplitter
    Left = 161
    Top = 0
    Height = 400
    ExplicitHeight = 412
  end
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 680
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    DesignSize = (
      680
      41)
    object bbtnSave: TBitBtn
      Left = 315
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      Constraints.MaxWidth = 75
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnSaveClick
    end
    object bbtnClose: TBitBtn
      Left = 499
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 1
    end
    object bbtnRefresh: TBitBtn
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = bbtnRefreshClick
    end
  end
  object Memo1: TMemo
    Left = 164
    Top = 0
    Width = 516
    Height = 400
    Align = alClient
    Color = clInfoBk
    HideSelection = False
    OEMConvert = True
    ScrollBars = ssVertical
    TabOrder = 1
    OnKeyDown = Memo1KeyDown
  end
  object lstScripts: TListBox
    Left = 0
    Top = 0
    Width = 161
    Height = 400
    Align = alLeft
    Color = clInfoBk
    ItemHeight = 20
    TabOrder = 2
    OnDblClick = lstScriptsDblClick
  end
end
