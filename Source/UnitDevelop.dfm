object FormDevelop: TFormDevelop
  Left = 73
  Top = 212
  Caption = #27426#20048#24187#28789#183#24320#21457#31383#21475
  ClientHeight = 403
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 667
    Height = 403
    ActivePage = TabSheet6
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 675
    ExplicitHeight = 415
    object TabSheet1: TTabSheet
      Caption = #31383#21475#31649#29702
      object Label6: TLabel
        Left = 608
        Top = 349
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label6'
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 8
        Width = 137
        Height = 76
        Caption = #38190#30424#21160#20316
        TabOrder = 0
        object edtInputChar: TEdit
          Left = 8
          Top = 18
          Width = 20
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 0
          Text = 'A'
        end
        object btnInputChar: TButton
          Left = 34
          Top = 18
          Width = 63
          Height = 22
          Caption = #38190#20837#23383#31526
          TabOrder = 1
          OnClick = btnInputCharClick
        end
        object Edit2: TEdit
          Left = 7
          Top = 47
          Width = 50
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 2
          Text = 'Test'
        end
        object btnInputString: TButton
          Left = 64
          Top = 47
          Width = 65
          Height = 22
          Caption = #36755#20837#25991#26412
          TabOrder = 3
          OnClick = btnInputStringClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 144
        Top = 8
        Width = 137
        Height = 77
        Caption = #40736#26631#21160#20316
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 24
          Width = 14
          Height = 13
          Caption = 'X:'
        end
        object Label5: TLabel
          Left = 73
          Top = 24
          Width = 14
          Height = 13
          Caption = 'Y:'
        end
        object btnMouseLeftClick: TButton
          Left = 9
          Top = 48
          Width = 50
          Height = 22
          Caption = #24038#21333#20987
          TabOrder = 0
          OnClick = btnMouseLeftClickClick
        end
        object EditX: TEdit
          Left = 25
          Top = 19
          Width = 37
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 1
          Text = '10'
        end
        object EditY: TEdit
          Left = 90
          Top = 19
          Width = 37
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 2
          Text = '10'
        end
        object btnMouseLeftDoubleClick: TButton
          Left = 80
          Top = 48
          Width = 47
          Height = 22
          Caption = #24038#21452#20987
          TabOrder = 3
          OnClick = btnMouseLeftDoubleClickClick
        end
      end
      object lstWindows: TListBox
        Left = 8
        Top = 120
        Width = 649
        Height = 225
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemHeight = 13
        TabOrder = 2
      end
      object btnLocateToPlayWindow: TButton
        Left = 3
        Top = 92
        Width = 105
        Height = 22
        Caption = #23450#20301#21040#28216#25103#31383#21475
        TabOrder = 3
        OnClick = btnLocateToPlayWindowClick
      end
      object btnLocateToMainPanel: TButton
        Left = 120
        Top = 92
        Width = 75
        Height = 22
        Caption = #23450#20301#21040#38754#26495
        TabOrder = 4
        OnClick = btnLocateToMainPanelClick
      end
      object ButtonRefreshWindow: TButton
        Left = 588
        Top = 91
        Width = 61
        Height = 22
        Caption = #21047#26032#31383#21475
        TabOrder = 5
        OnClick = ButtonRefreshWindowClick
      end
      object btnGetWindowText: TButton
        Left = 256
        Top = 93
        Width = 97
        Height = 22
        Caption = #31383#21475#25991#23383
        TabOrder = 6
        OnClick = btnGetWindowTextClick
      end
      object edtWindowText: TEdit
        Left = 360
        Top = 93
        Width = 121
        Height = 21
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        TabOrder = 7
        Text = 'edtWindowText'
      end
      object ButtonDisableWindow: TButton
        Left = 296
        Top = 16
        Width = 89
        Height = 25
        Caption = #31105#27490#31383#21475#28040#24687
        TabOrder = 8
        OnClick = ButtonDisableWindowClick
      end
      object ButtonEnableWindow: TButton
        Left = 392
        Top = 16
        Width = 89
        Height = 25
        Caption = #24674#22797#31383#21475#28040#24687
        TabOrder = 9
        OnClick = ButtonEnableWindowClick
      end
      object btnHideWindow: TButton
        Left = 504
        Top = 16
        Width = 75
        Height = 25
        Caption = #38544#34255#31383#21475
        TabOrder = 10
        OnClick = btnHideWindowClick
      end
      object btnShowWindow: TButton
        Left = 584
        Top = 16
        Width = 75
        Height = 25
        Caption = #26174#31034#31383#21475
        TabOrder = 11
        OnClick = btnShowWindowClick
      end
      object btnCloseWindow: TButton
        Left = 296
        Top = 56
        Width = 75
        Height = 25
        Caption = #20851#38381#31383#21475
        TabOrder = 12
        OnClick = btnCloseWindowClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20869#23384#31649#29702
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 2
        Top = 12
        Width = 59
        Height = 13
        Caption = #20869#23384#21306#22495':'
      end
      object Label2: TLabel
        Left = 145
        Top = 11
        Width = 33
        Height = 13
        Caption = #23383#33410':'
      end
      object Label19: TLabel
        Left = 2
        Top = 42
        Width = 59
        Height = 13
        Caption = #20889#20837#22320#22336':'
      end
      object Label26: TLabel
        Left = 137
        Top = 41
        Width = 20
        Height = 13
        Caption = #20540':'
      end
      object Label30: TLabel
        Left = 368
        Top = 40
        Width = 33
        Height = 13
        Caption = #22686#37327':'
      end
      object Label29: TLabel
        Left = 264
        Top = 40
        Width = 33
        Height = 13
        Caption = #22522#22336':'
      end
      object Label33: TLabel
        Left = 570
        Top = 41
        Width = 20
        Height = 13
        Caption = #20540':'
      end
      object Memo1: TMemo
        Left = 0
        Top = 64
        Width = 665
        Height = 321
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object MaskEdit1: TMaskEdit
        Left = 66
        Top = 7
        Width = 65
        Height = 21
        EditMask = '!A!A!A!A!A!A!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 1
        Text = '00400000'
      end
      object Edit1: TEdit
        Left = 182
        Top = 7
        Width = 35
        Height = 21
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        TabOrder = 2
        Text = '256'
        OnKeyPress = Edit1KeyPress
      end
      object btnReadGameData: TButton
        Left = 230
        Top = 7
        Width = 51
        Height = 22
        Caption = #35835#25968#25454
        TabOrder = 3
        OnClick = btnReadGameDataClick
      end
      object btnPrevPage: TButton
        Left = 286
        Top = 7
        Width = 43
        Height = 22
        Caption = #19978#39029
        TabOrder = 4
        OnClick = btnPrevPageClick
      end
      object btnNextPage: TButton
        Left = 334
        Top = 7
        Width = 43
        Height = 22
        Caption = #19979#39029
        TabOrder = 5
        OnClick = btnNextPageClick
      end
      object Edit12: TEdit
        Left = 394
        Top = 8
        Width = 65
        Height = 21
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        TabOrder = 6
      end
      object Edit13: TEdit
        Left = 578
        Top = 8
        Width = 81
        Height = 21
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        TabOrder = 7
      end
      object Button12: TButton
        Left = 466
        Top = 8
        Width = 49
        Height = 22
        Caption = '16->10'
        TabOrder = 8
        OnClick = Button12Click
      end
      object Button14: TButton
        Left = 522
        Top = 8
        Width = 49
        Height = 22
        Caption = '10>16'
        TabOrder = 9
        OnClick = Button14Click
      end
      object MaskEditWriteAddr: TMaskEdit
        Left = 66
        Top = 37
        Width = 65
        Height = 21
        EditMask = '!A!A!A!A!A!A!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 10
        Text = '00400000'
      end
      object ButtonWriteByte: TButton
        Left = 190
        Top = 37
        Width = 51
        Height = 22
        Caption = #20889#25968#25454
        TabOrder = 11
        OnClick = ButtonWriteByteClick
      end
      object MaskEditByteToWrite: TMaskEdit
        Left = 163
        Top = 37
        Width = 22
        Height = 21
        EditMask = '!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 2
        TabOrder = 12
        Text = '00'
      end
      object MaskEdit2: TMaskEdit
        Left = 402
        Top = 37
        Width = 64
        Height = 21
        EditMask = '!A!A!A!A!A!A!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 13
        Text = '00000000'
      end
      object MaskEdit3: TMaskEdit
        Left = 498
        Top = 37
        Width = 65
        Height = 21
        EditMask = '!A!A!A!A!A!A!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 14
        Text = '00400000'
      end
      object Button26: TButton
        Left = 472
        Top = 37
        Width = 17
        Height = 22
        Caption = '='
        TabOrder = 15
        OnClick = Button26Click
      end
      object MaskEdit4: TMaskEdit
        Left = 298
        Top = 37
        Width = 63
        Height = 21
        EditMask = '!A!A!A!A!A!A!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 16
        Text = '00400000'
      end
      object MaskEdit5: TMaskEdit
        Left = 594
        Top = 37
        Width = 64
        Height = 21
        EditMask = '!A!A!A!A!A!A!A!A;1;_'
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 17
        Text = '00000000'
      end
    end
    object TabSheet3: TTabSheet
      Caption = #30636#31227
      ImageIndex = 2
      object GroupBox6: TGroupBox
        Left = 0
        Top = 8
        Width = 657
        Height = 137
        Caption = #22320#22270#25968#25454
        TabOrder = 0
        object Label18: TLabel
          Left = 8
          Top = 18
          Width = 65
          Height = 13
          Caption = #25152#26377#22320#22270#65306
        end
        object Label20: TLabel
          Left = 376
          Top = 18
          Width = 65
          Height = 13
          Caption = #32454#33410#20449#24687#65306
        end
        object Label23: TLabel
          Left = 192
          Top = 18
          Width = 65
          Height = 13
          Caption = #25152#26377#20256#36865#28857
        end
        object ListBox2: TListBox
          Left = 8
          Top = 34
          Width = 177
          Height = 97
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox2Click
        end
        object ListBox4: TListBox
          Left = 376
          Top = 34
          Width = 273
          Height = 97
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ItemHeight = 13
          TabOrder = 1
        end
        object ListBox6: TListBox
          Left = 192
          Top = 34
          Width = 177
          Height = 97
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ItemHeight = 13
          TabOrder = 2
          OnClick = ListBox6Click
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 152
        Width = 372
        Height = 209
        Caption = #22320#22270#38388#31227#21160
        TabOrder = 1
        object Label21: TLabel
          Left = 6
          Top = 24
          Width = 13
          Height = 13
          Caption = #20174
        end
        object Label22: TLabel
          Left = 6
          Top = 49
          Width = 13
          Height = 13
          Caption = #21040
        end
        object Label24: TLabel
          Left = 147
          Top = 24
          Width = 13
          Height = 13
          Caption = #30340
        end
        object Label25: TLabel
          Left = 147
          Top = 49
          Width = 13
          Height = 13
          Caption = #30340
        end
        object ComboBox3: TComboBox
          Left = 165
          Top = 20
          Width = 120
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 0
          Text = 'ComboBox3'
        end
        object ComboBox5: TComboBox
          Left = 165
          Top = 44
          Width = 120
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 1
          Text = 'ComboBox5'
        end
        object btnMapMove: TButton
          Left = 299
          Top = 43
          Width = 64
          Height = 22
          Caption = #20934#22791#31227#21160
          TabOrder = 2
          OnClick = btnMapMoveClick
        end
        object ListBox5: TListBox
          Left = 7
          Top = 72
          Width = 357
          Height = 129
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ItemHeight = 13
          TabOrder = 3
        end
        object ComboBox6: TComboBox
          Left = 24
          Top = 20
          Width = 120
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 4
          Text = 'ComboBox6'
          OnChange = ComboBox6Change
        end
        object ComboBox7: TComboBox
          Left = 23
          Top = 46
          Width = 121
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 5
          Text = 'ComboBox7'
          OnChange = ComboBox7Change
        end
      end
      object GroupBox7: TGroupBox
        Left = 384
        Top = 152
        Width = 269
        Height = 77
        Caption = #22320#22270#20869#31227#21160
        TabOrder = 2
        object Label15: TLabel
          Left = 89
          Top = 51
          Width = 14
          Height = 13
          Caption = 'X:'
        end
        object Label16: TLabel
          Left = 150
          Top = 51
          Width = 14
          Height = 13
          Caption = 'Y:'
        end
        object Label17: TLabel
          Left = 10
          Top = 22
          Width = 132
          Height = 13
          Caption = #29616#22312'X'#22320#22270#65292#22352#26631#20026'X,Y'
        end
        object Edit10: TEdit
          Left = 106
          Top = 46
          Width = 37
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 0
          Text = '10'
          OnKeyPress = Edit1KeyPress
        end
        object Edit11: TEdit
          Left = 167
          Top = 46
          Width = 37
          Height = 21
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          TabOrder = 1
          Text = '10'
          OnKeyPress = Edit1KeyPress
        end
        object btnPosMove: TButton
          Left = 212
          Top = 46
          Width = 49
          Height = 22
          Caption = #30636#31227
          TabOrder = 2
          OnClick = btnPosMoveClick
        end
        object Button9: TButton
          Left = 8
          Top = 47
          Width = 65
          Height = 22
          Caption = #21047#26032#20301#32622
          TabOrder = 3
          OnClick = Button9Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #20154#29289
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox9: TGroupBox
        Left = 0
        Top = 16
        Width = 161
        Height = 361
        Caption = #20154#29289#25968#25454
        TabOrder = 0
        object Button21: TButton
          Left = 78
          Top = 327
          Width = 75
          Height = 22
          Caption = #21047#26032#29366#24577
          TabOrder = 0
          OnClick = Button21Click
        end
        object GroupBox10: TGroupBox
          Left = 8
          Top = 24
          Width = 81
          Height = 113
          Caption = #32431#28857
          TabOrder = 1
          object Label36: TLabel
            Left = 8
            Top = 18
            Width = 39
            Height = 13
            Caption = #20307#21147#65306
          end
          object Label37: TLabel
            Left = 8
            Top = 36
            Width = 39
            Height = 13
            Caption = #20869#21151#65306
          end
          object Label38: TLabel
            Left = 8
            Top = 55
            Width = 39
            Height = 13
            Caption = #25915#20987#65306
          end
          object Label31: TLabel
            Left = 44
            Top = 36
            Width = 28
            Height = 13
            Caption = '0000'
          end
          object Label32: TLabel
            Left = 44
            Top = 55
            Width = 28
            Height = 13
            Caption = '0000'
          end
          object Label27: TLabel
            Left = 8
            Top = 73
            Width = 39
            Height = 13
            Caption = #38450#24481#65306
          end
          object Label28: TLabel
            Left = 8
            Top = 92
            Width = 39
            Height = 13
            Caption = #36731#21151#65306
          end
          object Label39: TLabel
            Left = 44
            Top = 18
            Width = 28
            Height = 13
            Caption = '0000'
          end
          object Label40: TLabel
            Left = 44
            Top = 73
            Width = 28
            Height = 13
            Caption = '0000'
          end
          object Label41: TLabel
            Left = 44
            Top = 92
            Width = 28
            Height = 13
            Caption = '0000'
          end
        end
        object GroupBox11: TGroupBox
          Left = 8
          Top = 152
          Width = 145
          Height = 161
          Caption = #23646#24615
          TabOrder = 2
          object Label42: TLabel
            Left = 8
            Top = 63
            Width = 53
            Height = 13
            Caption = #29983'  '#21629#65306
          end
          object Label43: TLabel
            Left = 8
            Top = 81
            Width = 53
            Height = 13
            Caption = #20869'  '#21147#65306
          end
          object Label44: TLabel
            Left = 8
            Top = 100
            Width = 52
            Height = 13
            Caption = #25915#20987#21147#65306
          end
          object Label45: TLabel
            Left = 60
            Top = 81
            Width = 77
            Height = 13
            Caption = '00000/00000'
          end
          object Label46: TLabel
            Left = 60
            Top = 100
            Width = 77
            Height = 13
            Caption = '00000/00000'
          end
          object Label47: TLabel
            Left = 8
            Top = 118
            Width = 52
            Height = 13
            Caption = #38450#24481#21147#65306
          end
          object Label48: TLabel
            Left = 8
            Top = 137
            Width = 52
            Height = 13
            Caption = #25935#25463#24230#65306
          end
          object Label49: TLabel
            Left = 60
            Top = 63
            Width = 77
            Height = 13
            Caption = '00000/00000'
          end
          object Label50: TLabel
            Left = 60
            Top = 118
            Width = 77
            Height = 13
            Caption = '00000/00000'
          end
          object Label51: TLabel
            Left = 60
            Top = 137
            Width = 77
            Height = 13
            Caption = '00000/00000'
          end
          object Label34: TLabel
            Left = 9
            Top = 24
            Width = 42
            Height = 13
            Caption = 'Level:'
          end
          object Label35: TLabel
            Left = 60
            Top = 24
            Width = 7
            Height = 13
            Caption = '0'
          end
          object Label52: TLabel
            Left = 9
            Top = 39
            Width = 28
            Height = 13
            Caption = 'Xiu:'
          end
          object Label53: TLabel
            Left = 60
            Top = 39
            Width = 7
            Height = 13
            Caption = '0'
          end
        end
      end
      object GroupBox1: TGroupBox
        Left = 192
        Top = 16
        Width = 473
        Height = 297
        Caption = #29289#21697#26639#20449#24687
        TabOrder = 1
        object Button22: TButton
          Left = 387
          Top = 269
          Width = 75
          Height = 22
          Caption = #26597#30475#29289#21697#26639
          TabOrder = 0
          OnClick = Button22Click
        end
        object StringGrid1: TStringGrid
          Left = 10
          Top = 16
          Width = 453
          Height = 245
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
          TabOrder = 1
          ColWidths = (
            22
            80
            77
            28
            34
            34
            34
            34
            33
            64)
          RowHeights = (
            16
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
      end
    end
    object TabSheet5: TTabSheet
      Caption = #20854#23427
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Button6: TButton
        Left = 128
        Top = 64
        Width = 75
        Height = 22
        Caption = #21462#28040#23545#35805
        TabOrder = 0
        OnClick = Button6Click
      end
      object Button16: TButton
        Left = 24
        Top = 64
        Width = 75
        Height = 22
        Caption = #24471#21040#23545#35805
        TabOrder = 1
        OnClick = Button16Click
      end
      object MemoDialog: TMemo
        Left = 24
        Top = 96
        Width = 289
        Height = 89
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        Lines.Strings = (
          'MemoDialog')
        TabOrder = 2
      end
      object ListBoxBattleCreatures: TListBox
        Left = 344
        Top = 80
        Width = 283
        Height = 113
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemHeight = 13
        TabOrder = 3
      end
      object ButtonDisplayBattleCreatures: TButton
        Left = 536
        Top = 48
        Width = 91
        Height = 22
        Caption = #21047#26032#25112#26007#29983#29289
        TabOrder = 4
        OnClick = ButtonDisplayBattleCreaturesClick
      end
      object Button19: TButton
        Left = 136
        Top = 232
        Width = 75
        Height = 25
        Caption = 'Button19'
        TabOrder = 5
        OnClick = Button19Click
      end
      object Button27: TButton
        Left = 192
        Top = 16
        Width = 75
        Height = 22
        Caption = 'PatchShop'
        TabOrder = 6
        OnClick = Button27Click
      end
      object Button36: TButton
        Left = 280
        Top = 16
        Width = 89
        Height = 22
        Caption = 'UnpatchShop'
        TabOrder = 7
        OnClick = Button36Click
      end
      object Button38: TButton
        Left = 448
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Button38'
        TabOrder = 8
        OnClick = Button38Click
      end
      object Button39: TButton
        Left = 296
        Top = 232
        Width = 75
        Height = 25
        Caption = 'PatchItem'
        TabOrder = 9
        OnClick = Button39Click
      end
      object Button40: TButton
        Left = 400
        Top = 232
        Width = 89
        Height = 25
        Caption = 'UnPatchItem'
        TabOrder = 10
        OnClick = Button40Click
      end
      object ButtonTestInnerScript: TButton
        Left = 8
        Top = 8
        Width = 99
        Height = 25
        Caption = #27979#35797#20869#37096#33050#26412
        TabOrder = 11
        OnClick = ButtonTestInnerScriptClick
      end
      object Button41: TButton
        Left = 296
        Top = 272
        Width = 113
        Height = 25
        Caption = 'PatchCreateWG'
        TabOrder = 12
        OnClick = Button41Click
      end
      object Button42: TButton
        Left = 296
        Top = 304
        Width = 113
        Height = 25
        Caption = 'UnPatchCreateWG'
        TabOrder = 13
        OnClick = Button42Click
      end
    end
    object TabSheet6: TTabSheet
      Caption = #28860#21270
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 8
        Top = 303
        Width = 65
        Height = 13
        Caption = #20027#28860#20301#32622#65306
      end
      object Label7: TLabel
        Left = 129
        Top = 40
        Width = 60
        Height = 13
        Caption = '0. '#20094#183#37329
      end
      object Label8: TLabel
        Left = 33
        Top = 88
        Width = 60
        Height = 13
        Caption = '1. '#20817#183#37329
      end
      object Label9: TLabel
        Left = 1
        Top = 136
        Width = 60
        Height = 13
        Caption = '2. '#31163#183#28779
      end
      object Label10: TLabel
        Left = 65
        Top = 184
        Width = 60
        Height = 13
        Caption = '3. '#38663#183#26408
      end
      object Label11: TLabel
        Left = 225
        Top = 88
        Width = 60
        Height = 13
        Caption = '4. '#24061#183#26408
      end
      object Label12: TLabel
        Left = 257
        Top = 136
        Width = 60
        Height = 13
        Caption = '5. '#22350#183#27700
      end
      object Label13: TLabel
        Left = 225
        Top = 184
        Width = 60
        Height = 13
        Caption = '6. '#33390#183#22303
      end
      object Label14: TLabel
        Left = 129
        Top = 232
        Width = 60
        Height = 13
        Caption = '7. '#22372#183#22303
      end
      object ComboBoxStoveRoom0: TComboBox
        Left = 128
        Top = 56
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 0
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom1: TComboBox
        Left = 32
        Top = 104
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 1
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom2: TComboBox
        Left = 0
        Top = 152
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 2
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom3: TComboBox
        Left = 32
        Top = 200
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 3
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom6: TComboBox
        Left = 224
        Top = 200
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 4
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom5: TComboBox
        Left = 256
        Top = 152
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 5
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom4: TComboBox
        Left = 224
        Top = 104
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 6
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ComboBoxStoveRoom7: TComboBox
        Left = 128
        Top = 248
        Width = 161
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 7
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveRoom0Change
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object ButtonShowStuffsToBeChozen: TButton
        Left = 8
        Top = 24
        Width = 75
        Height = 25
        Caption = #21047#26032#29289#21697
        TabOrder = 8
        OnClick = ButtonShowStuffsToBeChozenClick
      end
      object ListBoxItemsInStove: TListBox
        Left = 440
        Top = 40
        Width = 217
        Height = 113
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemHeight = 13
        TabOrder = 9
      end
      object ButtonShowStoveInstuction: TButton
        Left = 544
        Top = 8
        Width = 113
        Height = 22
        Caption = #29983#25104#28860#21270#25351#20196
        TabOrder = 10
        OnClick = ButtonShowStoveInstuctionClick
      end
      object ComboBoxStoveMainRoom: TComboBox
        Left = 72
        Top = 300
        Width = 105
        Height = 21
        Style = csDropDownList
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 11
        Text = '--'#26410#36873#25321'--'
        OnChange = ComboBoxStoveMainRoomChange
        Items.Strings = (
          '--'#26410#36873#25321'--')
      end
      object Button18: TButton
        Left = 544
        Top = 168
        Width = 113
        Height = 22
        Caption = #26597#30475#24403#21069#28860#21270#25351#20196
        TabOrder = 12
        OnClick = Button18Click
      end
      object ListBoxCurrInstruction: TListBox
        Left = 392
        Top = 200
        Width = 265
        Height = 153
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        ItemHeight = 13
        TabOrder = 13
      end
      object Button20: TButton
        Left = 424
        Top = 168
        Width = 113
        Height = 22
        Caption = #20889#20837#28860#21270#25351#20196
        TabOrder = 14
        OnClick = Button20Click
      end
      object ButtonUniverseStoveMemPatch: TButton
        Left = 288
        Top = 16
        Width = 75
        Height = 22
        Caption = 'MemPatch'
        TabOrder = 15
        OnClick = ButtonUniverseStoveMemPatchClick
      end
    end
    object TabSheet7: TTabSheet
      Caption = #21628#21483'NPC'
      ImageIndex = 6
      object Button28: TButton
        Left = 456
        Top = 200
        Width = 81
        Height = 22
        Caption = 'Patch1'
        TabOrder = 0
        OnClick = Button28Click
      end
      object Button29: TButton
        Left = 560
        Top = 200
        Width = 73
        Height = 22
        Caption = 'UnPatch1'
        TabOrder = 1
        OnClick = Button29Click
      end
      object Button30: TButton
        Left = 456
        Top = 320
        Width = 81
        Height = 22
        Caption = #21628#21483#29664#23453#21830
        TabOrder = 2
        OnClick = Button30Click
      end
      object Button31: TButton
        Left = 560
        Top = 304
        Width = 73
        Height = 22
        Caption = 'UnPatch2'
        TabOrder = 3
        OnClick = Button31Click
      end
      object Button32: TButton
        Left = 456
        Top = 256
        Width = 81
        Height = 22
        Caption = #21628#21483#38081#21280
        TabOrder = 4
        OnClick = Button32Click
      end
      object Button33: TButton
        Left = 456
        Top = 288
        Width = 81
        Height = 22
        Caption = #21628#21483#22823#22827
        TabOrder = 5
        OnClick = Button33Click
      end
      object Button34: TButton
        Left = 456
        Top = 352
        Width = 81
        Height = 22
        Caption = #21628#21483#23456#29289#21592
        TabOrder = 6
        OnClick = Button34Click
      end
      object ComboBox1: TComboBox
        Left = 16
        Top = 56
        Width = 145
        Height = 201
        Style = csSimple
        ImeName = #32043#20809#25340#38899#36755#20837#27861
        TabOrder = 7
        Text = 'ComboBox1'
      end
      object btnCallNPC: TButton
        Left = 168
        Top = 55
        Width = 97
        Height = 22
        Caption = #21628#21483#21830#24215'NPC'
        TabOrder = 8
        OnClick = btnCallNPCClick
      end
      object Button37: TButton
        Left = 16
        Top = 24
        Width = 97
        Height = 22
        Caption = #26174#31034#21830#24215'NPC'
        TabOrder = 9
        OnClick = Button37Click
      end
    end
  end
end
