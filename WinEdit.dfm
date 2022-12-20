object FmWinEdit: TFmWinEdit
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1088#1072#1073#1086#1090#1099' '#1087#1086#1080#1089#1082' '#1076#1091#1073#1083#1080#1082#1072#1090#1086#1074
  ClientHeight = 752
  ClientWidth = 1384
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 103
  TextHeight = 13
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 1384
    Height = 752
    Align = alClient
    BorderOuter = fsNone
    Color = 15987699
    TabOrder = 0
    object RzRichEditEchoWin: TRzRichEdit
      Left = 0
      Top = 0
      Width = 1384
      Height = 733
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenuEcho
      ScrollBars = ssBoth
      TabOrder = 0
      StyleElements = []
      Zoom = 100
    end
    object StatusBar1: TStatusBar
      Left = 0
      Top = 733
      Width = 1384
      Height = 19
      Panels = <
        item
          Text = 'Alt-X '#1042#1099#1093#1086#1076
          Width = 50
        end>
    end
  end
  object MainMenu1: TMainMenu
    Left = 416
    Top = 112
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object mnOpen: TMenuItem
        Action = ActionOpen
      end
      object mnSaveAs: TMenuItem
        Action = ActionSaveAs
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnClose: TMenuItem
        Action = ActionClose
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'rtf'
    Filter = 'RTF '#1092#1072#1081#1083'|*.rtf|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 32
    Top = 24
  end
  object ImageList1: TImageList
    Left = 224
    Top = 144
  end
  object PopupMenuEcho: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PopupMenuEchoPopup
    Left = 435
    Top = 57
    object PopUndo: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 51
      OnClick = PopUndoClick
    end
    object MenuItem1: TMenuItem
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
    object PopClearAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102
      ImageIndex = 12
      OnClick = PopClearAllClick
    end
    object PopSelectAll: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      OnClick = PopSelectAllClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object popOpenFile: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#1080#1079' '#1089#1090#1088#1086#1082#1080' '#1083#1086#1075' '#1092#1072#1081#1083#1072
      OnClick = popOpenFileClick
    end
    object popFoundFile: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1074' '#1087#1088#1086#1074#1086#1076#1085#1080#1082#1077
      OnClick = popFoundFileClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object e1: TMenuItem
      Caption = #1091#1084#1077#1085#1100#1096#1080#1090#1100' '#1074#1099#1089#1086#1090#1091' '#1096#1088#1080#1092#1090#1072
      OnClick = e1Click
    end
    object N7: TMenuItem
      Caption = #1091#1074#1077#1083#1080#1095#1080#1090#1100' '#1074#1099#1089#1086#1090#1091' '#1096#1088#1080#1092#1090#1072
      OnClick = N7Click
    end
  end
  object ShellResources1: TShellResources
    Left = 464
    Top = 520
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'rtf'
    Filter = 'RTF '#1092#1072#1081#1083'|*.rtf|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 112
    Top = 24
  end
  object ActionList1: TActionList
    Left = 664
    Top = 48
    object ActionOpen: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ShortCut = 16463
      OnExecute = ActionOpenExecute
    end
    object ActionSaveAs: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      ShortCut = 16467
      OnExecute = ActionSaveAsExecute
    end
    object ActionClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ShortCut = 32856
      OnExecute = ActionCloseExecute
    end
  end
end
