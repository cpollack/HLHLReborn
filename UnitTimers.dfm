object FormTimers: TFormTimers
  Left = 430
  Top = 356
  Caption = 'FormTimers'
  ClientHeight = 29
  ClientWidth = 139
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TimerWork: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerWorkTimer
    Left = 35
    Top = 7
  end
  object TimerDoTransaction: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerDoTransactionTimer
    Left = 72
    Top = 7
  end
  object TimerReadMapInfo: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerReadMapInfoTimer
    Top = 7
  end
end
