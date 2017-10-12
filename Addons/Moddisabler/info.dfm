object infoFrm: TinfoFrm
  Left = 489
  Top = 305
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Addon Informationen'
  ClientHeight = 151
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 251
    Height = 151
    BevelOuter = bvNone
    Color = 16643823
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UseDockManager = True
    Version = '2.1.0.4'
    BorderColor = 13087391
    Caption.Color = 16643823
    Caption.ColorTo = 15784647
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = 5978398
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = 15784647
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = 16643823
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 5978398
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 16643823
    StatusBar.ColorTo = 15784647
    StatusBar.GradientDirection = gdVertical
    Styler = AdvPanelStyler1
    FullHeight = 200
    object Label1: TLabel
      Left = 15
      Top = 15
      Width = 107
      Height = 16
      Caption = 'Mod Disabler 1.0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 15
      Top = 35
      Width = 222
      Height = 13
      Caption = 'Programmiert und entwickelt von Andreas Hiller'
    end
    object Label3: TLabel
      Left = 15
      Top = 50
      Width = 185
      Height = 13
      Caption = 'Copyright '#169' 2017 AndHill Development'
    end
    object Label4: TLabel
      Left = 15
      Top = 65
      Width = 114
      Height = 13
      Caption = 'Alle Rechte vorbehalten'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 90
      Width = 251
      Height = 6
      Shape = bsTopLine
    end
    object BitBtn1: TBitBtn
      Left = 145
      Top = 105
      Width = 91
      Height = 31
      Caption = 'Schlie'#223'en'
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        4242DE2C2CD3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2C2C
        B04242B5FF00FFFF00FFFF00FF3E3EE60000FC0000F52828D9FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF2828BE0000B00000A93E3EB7FF00FF4242E20000FC
        0000FC0000FC0000FC2828D9FF00FFFF00FFFF00FFFF00FF2828CD0000C80000
        C00000B80000B04242BB2828D90000F50000F50000FC0000FC0000FC2929E0FF
        00FFFF00FF2828D90000DE0000D60000C80000C80000C02828BEFF00FF2828D9
        0000F50000F50000F50000FC0000FC2929E02828E90000F50101ED0000E50000
        E50000D62828C7FF00FFFF00FFFF00FF2828D90101ED0000F50000F50000F500
        00FC0000FC0000FC0000FC0000F50101ED2C2CD3FF00FFFF00FFFF00FFFF00FF
        FF00FF2828D90101ED0101ED0000F50000F50000F50000FC0000FC0000FC2828
        D9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2828D90101ED0101ED01
        01ED0000F50000F50000F52828D9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF2828D90101ED0606F00101ED0101ED0101ED0000F52828D9FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2929E00707FB0707FB0707F506
        06F00606F00101ED0101ED0000F52828D9FF00FFFF00FFFF00FFFF00FFFF00FF
        3434DF1919FA1616FB1919FA1919FA1919FA1D1DFA1919FA1D1DFA1D1DFA1D1D
        FA3E3EDEFF00FFFF00FFFF00FF3E3EDE1D1DFA2D2DF81D1DFA2D2DF82D2DF83E
        3EDE4242DE2E2EF73030F73030F73030F73030F74242DEFF00FF4848D83939F6
        3939F63939F64141F43939F64848D8FF00FFFF00FF4848D84141F44141F44141
        F44141F44141F45353DC5D5DD64A4AF34A4AF34A4AF35353F15353DCFF00FFFF
        00FFFF00FFFF00FF5353DC5353F15353F15D5DF05353F16666D4FF00FF6666D4
        5D5DF05D5DF05C5CDAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6060D96666
        EF6666EF6A6AD5FF00FFFF00FFFF00FF6A6AD56666D4FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF6666D46A6AD5FF00FFFF00FF}
    end
  end
  object AdvPanelStyler1: TAdvPanelStyler
    Tag = 0
    Settings.AnchorHint = False
    Settings.BevelInner = bvNone
    Settings.BevelOuter = bvNone
    Settings.BevelWidth = 1
    Settings.BorderColor = 13087391
    Settings.BorderShadow = False
    Settings.BorderStyle = bsNone
    Settings.BorderWidth = 0
    Settings.CanMove = False
    Settings.CanSize = False
    Settings.Caption.Color = 16643823
    Settings.Caption.ColorTo = 15784647
    Settings.Caption.Font.Charset = DEFAULT_CHARSET
    Settings.Caption.Font.Color = 5978398
    Settings.Caption.Font.Height = -11
    Settings.Caption.Font.Name = 'MS Sans Serif'
    Settings.Caption.Font.Style = []
    Settings.Caption.GradientDirection = gdVertical
    Settings.Caption.Indent = 2
    Settings.Caption.ShadeLight = 255
    Settings.Collaps = False
    Settings.CollapsColor = clNone
    Settings.CollapsDelay = 0
    Settings.CollapsSteps = 0
    Settings.Color = 16643823
    Settings.ColorTo = 15784647
    Settings.ColorMirror = clNone
    Settings.ColorMirrorTo = clNone
    Settings.Cursor = crDefault
    Settings.Font.Charset = DEFAULT_CHARSET
    Settings.Font.Color = clBlack
    Settings.Font.Height = -11
    Settings.Font.Name = 'MS Sans Serif'
    Settings.Font.Style = []
    Settings.FixedTop = False
    Settings.FixedLeft = False
    Settings.FixedHeight = False
    Settings.FixedWidth = False
    Settings.Height = 120
    Settings.Hover = False
    Settings.HoverColor = clNone
    Settings.HoverFontColor = clNone
    Settings.Indent = 0
    Settings.ShadowColor = clBlack
    Settings.ShadowOffset = 0
    Settings.ShowHint = False
    Settings.ShowMoveCursor = False
    Settings.StatusBar.BorderColor = 16643823
    Settings.StatusBar.BorderStyle = bsSingle
    Settings.StatusBar.Font.Charset = DEFAULT_CHARSET
    Settings.StatusBar.Font.Color = 5978398
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 16643823
    Settings.StatusBar.ColorTo = 15784647
    Settings.StatusBar.GradientDirection = gdVertical
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Style = psOffice2010Blue
    Left = 200
    Top = 25
  end
  object AdvFormStyler1: TAdvFormStyler
    Style = tsOffice2010Blue
    Left = 200
    Top = 85
  end
end
