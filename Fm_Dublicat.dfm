object FmDublicat: TFmDublicat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1076#1091#1073#1083#1080#1082#1072#1090#1086#1074' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 790
  ClientWidth = 891
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 103
  TextHeight = 13
  object Panel_ListPath: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 885
    Height = 166
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    object RzLabelVersion: TRzLabel
      Left = 816
      Top = 10
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'RzLabel5'
      Transparent = True
    end
    object ListBoxListPath: TListBox
      Left = 6
      Top = 6
      Width = 684
      Height = 154
      Margins.Left = 15
      Margins.Top = 15
      Margins.Right = 15
      Align = alLeft
      DragMode = dmAutomatic
      ExtendedSelect = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 17
      Items.Strings = (
        #1087#1077#1088#1077#1090#1072#1097#1080' '#1080#1079' '#1087#1088#1086#1074#1086#1076#1085#1080#1082#1072)
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      StyleElements = []
      OnDblClick = ListBoxListPathDblClick
      OnDragDrop = ListBoxListPathDragDrop
    end
    object ButtonRun: TButton
      Left = 708
      Top = 29
      Width = 164
      Height = 41
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonRunClick
    end
    object ButtonClose: TButton
      Left = 708
      Top = 88
      Width = 164
      Height = 41
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ButtonCloseClick
    end
  end
  object RzPanelConfig: TRzPanel
    AlignWithMargins = True
    Left = 5
    Top = 175
    Width = 881
    Height = 236
    Margins.Left = 5
    Margins.Right = 5
    Align = alTop
    BorderInner = fsFlat
    BorderOuter = fsNone
    Color = 15987699
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 1
    object RzGroupBox1: TRzGroupBox
      Left = 15
      Top = 7
      Width = 506
      Height = 103
      Caption = #1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072' '#1080' '#1089#1088#1072#1074#1085#1077#1085#1080#1103
      Color = 15987699
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = True
      object RzBorder1: TRzBorder
        Left = 270
        Top = 13
        Width = 227
        Height = 83
        BorderOuter = fsFlat
      end
      object RzLabel6: TRzLabel
        Left = 282
        Top = 26
        Width = 211
        Height = 32
        Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1088#1072#1079#1084#1077#1088#1072' '#1092#1072#1081#1083#1072' '#1087#1088#1080' '#1089#1088#1072#1074#1085#1077#1085#1080#1080' '#1087#1086' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1102
        WordWrap = True
      end
      object RzLabel7: TRzLabel
        Left = 288
        Top = 71
        Width = 14
        Height = 16
        Caption = #1076#1086
      end
      object CheckBoxName: TCheckBox
        Left = 13
        Top = 33
        Width = 87
        Height = 17
        Caption = #1087#1086' '#1080#1084#1077#1085#1080
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object CheckBoxData: TCheckBox
        Left = 119
        Top = 33
        Width = 145
        Height = 17
        Caption = #1087#1086' '#1076#1072#1090#1077' '#1080' '#1074#1088#1077#1084#1077#1085#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object CheckBoxCRC: TCheckBox
        Left = 119
        Top = 71
        Width = 145
        Height = 17
        Caption = #1087#1086' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1102
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object CheckBoxCompSize: TCheckBox
        Left = 13
        Top = 70
        Width = 98
        Height = 17
        Caption = #1087#1086' '#1088#1072#1079#1084#1077#1088#1091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object RzEditSizeLimit: TRzEdit
        Left = 317
        Top = 66
        Width = 161
        Height = 24
        Text = ''
        TabOrder = 4
        OnKeyPress = RzEditSizeLimitKeyPress
      end
    end
    object RzGroupBoxModeCompare: TRzGroupBox
      Left = 527
      Top = 7
      Width = 338
      Height = 103
      Caption = #1076#1077#1081#1089#1090#1074#1080#1103' '#1089' '#1085#1072#1081#1076#1077#1085#1085#1099#1084#1080' '#1092#1072#1081#1083#1072#1084#1080
      Color = 15987699
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Transparent = True
      object RadioButtonMove: TRadioButton
        Left = 133
        Top = 31
        Width = 94
        Height = 17
        Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object RadioButtonCopy: TRadioButton
        Left = 13
        Top = 31
        Width = 108
        Height = 17
        Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButtonDelete: TRadioButton
        Left = 242
        Top = 31
        Width = 80
        Height = 17
        Caption = #1059#1076#1072#1083#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object RadioButtonAnaliz: TRadioButton
        AlignWithMargins = True
        Left = 13
        Top = 71
        Width = 133
        Height = 17
        Caption = #1040#1085#1072#1083#1080#1079
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = True
      end
      object ActivityIndicator1: TActivityIndicator
        Left = 290
        Top = 61
      end
    end
    object RzGroupBox3: TRzGroupBox
      Left = 16
      Top = 119
      Width = 849
      Height = 109
      Caption = #1092#1080#1083#1100#1090#1088
      Color = 15987699
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object RzLabel1: TRzLabel
        Left = 9
        Top = 19
        Width = 177
        Height = 17
        Caption = #1060#1080#1083#1100#1090#1088' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072' '#1092#1072#1081#1083#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object RzLabelBreak: TRzLabel
        Left = 657
        Top = 78
        Width = 134
        Height = 16
        Caption = #1087#1088#1077#1088#1074#1072#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1102
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 26367
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object CheckBoxInFolder: TCheckBox
        Left = 14
        Top = 80
        Width = 246
        Height = 17
        Caption = #1089#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100' '#1074#1083#1086#1078#1077#1085#1085#1099#1077' '#1087#1072#1087#1082#1080
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object RzEditFilter: TRzEdit
        Left = 9
        Top = 42
        Width = 825
        Height = 24
        Text = '*.*'
        TabOrder = 1
      end
      object RzBitBtnStopCompare: TRzBitBtn
        Left = 803
        Top = 73
        Width = 31
        TabOrder = 2
        Visible = False
        OnClick = RzBitBtnStopCompareClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000430B0000430B00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8090909
          09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8090909
          09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
        Margin = 3
        NumGlyphs = 2
      end
    end
  end
  object RzPanelEditEcho: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 676
    Width = 885
    Height = 111
    Align = alClient
    BorderOuter = fsNone
    Color = 15987699
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 2
    object RzRichEditEchoCom: TRzRichEdit
      Left = 2
      Top = 2
      Width = 881
      Height = 107
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenuEcho
      ScrollBars = ssBoth
      TabOrder = 0
      StyleElements = []
      Zoom = 100
    end
  end
  object RzPanelDistPath: TRzPanel
    AlignWithMargins = True
    Left = 5
    Top = 417
    Width = 881
    Height = 64
    Margins.Left = 5
    Margins.Right = 5
    Align = alTop
    BorderInner = fsFlat
    BorderOuter = fsNone
    Color = 15987699
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 3
    object RzLabel4: TRzLabel
      Left = 16
      Top = 6
      Width = 286
      Height = 16
      Caption = #1050#1091#1076#1072' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100'/'#1087#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1091#1073#1083#1080#1082#1072#1090#1099' '#1092#1072#1081#1083#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object EditDistPath: TEdit
      Left = 15
      Top = 28
      Width = 836
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit1'
    end
  end
  object RzPanelProgress: TRzPanel
    AlignWithMargins = True
    Left = 5
    Top = 487
    Width = 881
    Height = 112
    Margins.Left = 5
    Margins.Right = 5
    Align = alTop
    BorderInner = fsFlat
    BorderOuter = fsNone
    Color = 15987699
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 4
    object RzLabel2: TRzLabel
      Left = 12
      Top = 9
      Width = 40
      Height = 16
      Caption = #1060#1072#1081#1083': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object RzLabelNameFile: TRzLabel
      Left = 58
      Top = 9
      Width = 793
      Height = 16
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object RzBtnStopCopy: TRzRapidFireButton
      Left = 841
      Top = 31
      Width = 23
      Height = 66
      Hint = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000430B0000430B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8090909
        09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8090909
        09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = RzBtnStopCopyClick
    end
    object RzLabel3: TRzLabel
      Left = 12
      Top = 55
      Width = 242
      Height = 16
      Caption = #1054#1073#1097#1080#1081' '#1080#1085#1076#1080#1082#1072#1090#1086#1088' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object ProgressBarFile: TProgressBar
      Left = 7
      Top = 31
      Width = 828
      Height = 18
      Position = 50
      TabOrder = 0
    end
    object ProgressBarAll: TProgressBar
      Left = 7
      Top = 77
      Width = 828
      Height = 18
      Position = 50
      TabOrder = 1
    end
  end
  object RzPanelProgressCreateList: TRzPanel
    AlignWithMargins = True
    Left = 5
    Top = 605
    Width = 881
    Height = 65
    Margins.Left = 5
    Margins.Right = 5
    Align = alTop
    BorderInner = fsFlat
    BorderOuter = fsNone
    Color = 15987699
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 5
    object RzLabel5: TRzLabel
      Left = 12
      Top = 9
      Width = 40
      Height = 16
      Caption = #1060#1072#1081#1083': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object RzLblNameFileList: TRzLabel
      Left = 58
      Top = 9
      Width = 777
      Height = 16
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object RzButtonBreakCrList: TRzRapidFireButton
      Left = 841
      Top = 9
      Width = 23
      Height = 48
      Hint = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000430B0000430B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8090909
        09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
        10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8090909
        09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = RzBtnStopCopyClick
    end
    object ProgressBar2: TProgressBar
      Left = 7
      Top = 30
      Width = 828
      Height = 18
      Position = 50
      TabOrder = 0
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 595
    Top = 43
    object N1: TMenuItem
      Caption = #1086#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      OnClick = N1Click
    end
  end
  object PopupMenuEcho: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PopupMenuEchoPopup
    Left = 411
    Top = 41
    object PopUndo: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 51
      OnClick = PopUndoClick
    end
    object N2: TMenuItem
      Caption = '-'
      Visible = False
    end
    object PopCut: TMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      ImageIndex = 53
      OnClick = PopCutClick
    end
    object PopCopy: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 55
      OnClick = PopCopyClick
    end
    object PopPast: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 57
      OnClick = PopPastClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object PopSelectAll: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      OnClick = PopSelectAllClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object PopClearAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102
      OnClick = PopClearAllClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object popWinEdit: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' '#1086#1090#1076#1077#1083#1100#1085#1086#1084' '#1086#1082#1085#1077
      OnClick = popWinEditClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2800
    OnTimer = Timer1Timer
    Left = 477
    Top = 43
  end
  object RzVersionInfo1: TRzVersionInfo
    Left = 539
    Top = 43
  end
end
