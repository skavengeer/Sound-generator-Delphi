object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1043#1077#1085#1077#1088#1072#1090#1086#1088' '#1085#1072' '#1079#1074#1091#1082
  ClientHeight = 290
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblFrequency: TLabel
    Left = 128
    Top = 21
    Width = 42
    Height = 13
    Caption = #1063#1077#1089#1090#1086#1090#1072
  end
  object lblDuration: TLabel
    Left = 100
    Top = 67
    Width = 94
    Height = 13
    Caption = #1055#1088#1086#1076#1098#1083#1078#1080#1090#1077#1083#1085#1086#1089#1090
  end
  object lblHz: TLabel
    Left = 233
    Top = 43
    Width = 12
    Height = 13
    Caption = 'Hz'
  end
  object lblMSec: TLabel
    Left = 233
    Top = 89
    Width = 25
    Height = 13
    Caption = 'MSec'
  end
  object lblVolume: TLabel
    Left = 56
    Top = 117
    Width = 72
    Height = 13
    Caption = #1057#1080#1083#1072' '#1085#1072' '#1079#1074#1091#1082#1072
  end
  object lblSampleRate: TLabel
    Left = 296
    Top = 117
    Width = 111
    Height = 13
    Caption = #1073#1088#1086#1081' '#1087#1088#1086#1073#1080' '#1074' '#1089#1077#1082#1091#1085#1076#1072
  end
  object btnGenerate: TButton
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object edFrequency: TEdit
    Left = 89
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
    Text = ' '
  end
  object edDuration: TEdit
    Left = 89
    Top = 86
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object trckbrVolume: TTrackBar
    Left = 8
    Top = 136
    Width = 150
    Height = 21
    Max = 100
    Position = 100
    TabOrder = 3
  end
  object cmbxSampleRate: TComboBox
    Left = 281
    Top = 136
    Width = 145
    Height = 21
    TabOrder = 4
    Items.Strings = (
      'sr8KHz'
      'sr11_025KHz'
      'sr22_05KHz'
      'sr44_1KHz')
  end
  object rdgrpChannel: TRadioGroup
    Left = 176
    Top = 177
    Width = 185
    Height = 105
    Caption = #1050#1072#1085#1072#1083#1080
    Items.Strings = (
      #1084#1086#1085#1086
      #1089#1090#1077#1088#1077#1086)
    TabOrder = 5
  end
end
