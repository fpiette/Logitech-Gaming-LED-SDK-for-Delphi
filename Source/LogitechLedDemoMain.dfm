object LogiLedMainForm: TLogiLedMainForm
  Left = 0
  Top = 0
  Caption = 'Demo - Logitech Gaming LED SDK for Delphi'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RainbowButton: TButton
    Left = 20
    Top = 8
    Width = 90
    Height = 25
    Caption = 'Rainbow'
    TabOrder = 0
    OnClick = RainbowButtonClick
  end
  object Memo1: TMemo
    Left = 10
    Top = 64
    Width = 617
    Height = 227
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object BlackoutButton: TButton
    Left = 109
    Top = 8
    Width = 90
    Height = 25
    Caption = 'Blackout'
    TabOrder = 2
    OnClick = BlackoutButtonClick
  end
  object OptionCheckButton: TButton
    Left = 376
    Top = 8
    Width = 90
    Height = 25
    Caption = 'OptionCheck'
    TabOrder = 3
    OnClick = OptionCheckButtonClick
  end
  object SaveLightingButton: TButton
    Left = 198
    Top = 8
    Width = 90
    Height = 25
    Caption = 'Save Lighting'
    TabOrder = 4
    OnClick = SaveLightingButtonClick
  end
  object RestoreLightingButton: TButton
    Left = 287
    Top = 8
    Width = 90
    Height = 25
    Caption = 'Restore Lighting'
    TabOrder = 5
    OnClick = RestoreLightingButtonClick
  end
  object FlashEffectButton: TButton
    Left = 20
    Top = 32
    Width = 90
    Height = 25
    Caption = 'Flash Effect'
    TabOrder = 6
    OnClick = FlashEffectButtonClick
  end
  object StopEffectButton: TButton
    Left = 198
    Top = 33
    Width = 90
    Height = 25
    Caption = 'Stop Effect'
    TabOrder = 7
    OnClick = StopEffectButtonClick
  end
  object PulseEffectButton: TButton
    Left = 109
    Top = 32
    Width = 90
    Height = 25
    Caption = 'Pulse Effect'
    TabOrder = 8
    OnClick = PulseEffectButtonClick
  end
end
