object frmPrincipal: TfrmPrincipal
  Left = 431
  Top = 199
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SoundNix'
  ClientHeight = 327
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 88
    Top = 160
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Label4: TLabel
    Left = 227
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label4'
    Visible = False
  end
  object Label5: TLabel
    Left = 227
    Top = 24
    Width = 31
    Height = 13
    Caption = 'Label5'
    Visible = False
  end
  object Label6: TLabel
    Left = 64
    Top = 8
    Width = 131
    Height = 23
    Caption = 'MACRO PUBG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 48
    Width = 249
    Height = 185
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'HotKey'
      object Label1: TLabel
        Left = 118
        Top = 57
        Width = 48
        Height = 13
        Caption = 'Delay(ms)'
      end
      object Label8: TLabel
        Left = 115
        Top = 126
        Width = 48
        Height = 13
        Caption = 'Delay(ms)'
      end
      object EdtSensiX1: TEdit
        Left = 16
        Top = 16
        Width = 93
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object EdtDelay1: TEdit
        Left = 16
        Top = 54
        Width = 93
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object EdtSensiX2: TEdit
        Left = 16
        Top = 89
        Width = 93
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object EdtSensiY1: TEdit
        Left = 136
        Top = 16
        Width = 97
        Height = 21
        TabOrder = 3
        Text = '0'
      end
      object EdtSensiY2: TEdit
        Left = 136
        Top = 89
        Width = 97
        Height = 21
        TabOrder = 4
        Text = '0'
      end
      object EdtDelay2: TEdit
        Left = 16
        Top = 123
        Width = 93
        Height = 21
        TabOrder = 5
        Text = '0'
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 239
    Width = 245
    Height = 69
    Caption = 'Scope 3x 4x'
    TabOrder = 1
    object Label3: TLabel
      Left = 99
      Top = 33
      Width = 79
      Height = 13
      Caption = 'Sensibility Scope'
    end
    object EdtScope: TEdit
      Left = 9
      Top = 30
      Width = 77
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      TabOrder = 0
      OnChange = EdtScopeChange
    end
  end
  object Recoil: TTimer
    Enabled = False
    Interval = 1
    OnTimer = RecoilTimer
    Left = 240
    Top = 328
  end
  object Status: TTimer
    Interval = 1
    OnTimer = StatusTimer
    Left = 256
    Top = 288
  end
  object Scope: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ScopeTimer
    Left = 24
    Top = 296
  end
  object RapidFire: TTimer
    Enabled = False
    Interval = 30
    OnTimer = RapidFireTimer
    Left = 304
    Top = 320
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 136
    Top = 312
  end
end
