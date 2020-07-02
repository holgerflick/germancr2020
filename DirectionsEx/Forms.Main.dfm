object FrmMain: TFrmMain
  Left = 0
  Top = 0
  ActiveControl = Map
  Caption = 'FNC Maps: Directions Example'
  ClientHeight = 445
  ClientWidth = 940
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Droid Sans Mono'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object AdvSplitter1: TAdvSplitter
    Left = 476
    Top = 0
    Height = 445
    Align = alRight
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = 12895944
    Appearance.ColorTo = 12895944
    Appearance.ColorHot = 15917525
    Appearance.ColorHotTo = 15917525
    GripStyle = sgDots
    UIStyle = tsOffice2019White
    ExplicitLeft = 472
    ExplicitTop = 168
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 479
    Top = 0
    Width = 461
    Height = 445
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      461
      445)
    object txtInfo: TAdvMemo
      Left = 6
      Top = 96
      Width = 449
      Height = 341
      Cursor = crIBeam
      ActiveLineSettings.ShowActiveLine = False
      ActiveLineSettings.ShowActiveLineIndicator = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoCompletion.Font.Charset = DEFAULT_CHARSET
      AutoCompletion.Font.Color = clWindowText
      AutoCompletion.Font.Height = -11
      AutoCompletion.Font.Name = 'Tahoma'
      AutoCompletion.Font.Style = []
      AutoCompletion.StartToken = '(.'
      AutoCorrect.Active = True
      AutoHintParameterPosition = hpBelowCode
      BookmarkGlyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFD25252525
        2525252525252525FDFDFD2E25FFFFFFFFFFFFFFFFFFFF25FDFDFD2525252525
        2525252525252525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25B7B7B7B7
        B7B7B7B7B7B72525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25BFB7BFBF
        B7B7B7B7B7B72525FDFD9A9ABFBFBFB7BFBFB7B7B7B72525FDFDFD25BFBFBFBF
        BFB7BFBFB7B72525FDFD9A9ABFBFBFB7BFBFBFB7BFB72525FDFDFD25BFBFBFBF
        BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFB7BFBFB7B72525FDFDFD25BFBFBFBF
        BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFBFBFBFBFB725FDFDFDFD2525252525
        25252525252525FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
      BorderColor = 10724259
      BorderStyle = bsSingle
      ClipboardFormats = [cfText]
      CodeFolding.Enabled = False
      CodeFolding.LineColor = clGray
      Ctl3D = False
      DelErase = True
      EnhancedHomeKey = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -13
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.BorderColor = 10724259
      Gutter.GutterColor = clWhite
      Gutter.LineNumberTextColor = 3881787
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Droid Sans Mono'
      Font.Style = []
      HiddenCaret = False
      Lines.Strings = (
        '')
      MarkerList.UseDefaultMarkerImageIndex = False
      MarkerList.DefaultMarkerImageIndex = -1
      MarkerList.ImageTransparentColor = 33554432
      OleDropTarget = []
      PrintOptions.MarginLeft = 0
      PrintOptions.MarginRight = 0
      PrintOptions.MarginTop = 0
      PrintOptions.MarginBottom = 0
      PrintOptions.PageNr = False
      PrintOptions.PrintLineNumbers = False
      ReadOnly = True
      RightMarginColor = 14869218
      ScrollHint = False
      SelColor = clWhite
      SelBkColor = clNavy
      ShowRightMargin = True
      SmartTabs = False
      TabOrder = 0
      TabStop = True
      TrimTrailingSpaces = False
      UILanguage.ScrollHint = 'Row'
      UILanguage.Undo = 'Undo'
      UILanguage.Redo = 'Redo'
      UILanguage.Copy = 'Copy'
      UILanguage.Cut = 'Cut'
      UILanguage.Paste = 'Paste'
      UILanguage.Delete = 'Delete'
      UILanguage.SelectAll = 'Select All'
      UIStyle = tsOffice2019White
      UrlStyle.TextColor = clBlue
      UrlStyle.BkColor = clWhite
      UrlStyle.Style = [fsUnderline]
      UseStyler = True
      Version = '3.7.4.0'
      WordWrap = wwNone
    end
    object btnCosts: TAdvGlowButton
      Left = 7
      Top = 64
      Width = 142
      Height = 26
      Caption = 'Estimate costs'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Rounded = False
      TabOrder = 1
      OnClick = btnCostsClick
      Appearance.BorderColor = 11382963
      Appearance.BorderColorHot = 11565130
      Appearance.BorderColorCheckedHot = 11565130
      Appearance.BorderColorDown = 11565130
      Appearance.BorderColorChecked = 13744549
      Appearance.BorderColorDisabled = 13948116
      Appearance.ColorChecked = 13744549
      Appearance.ColorCheckedTo = 13744549
      Appearance.ColorDisabled = clWhite
      Appearance.ColorDisabledTo = clNone
      Appearance.ColorDown = 11565130
      Appearance.ColorDownTo = 11565130
      Appearance.ColorHot = 16444643
      Appearance.ColorHotTo = 16444643
      Appearance.ColorMirror = clWhite
      Appearance.ColorMirrorTo = clWhite
      Appearance.ColorMirrorHot = 16444643
      Appearance.ColorMirrorHotTo = 16444643
      Appearance.ColorMirrorDown = 11565130
      Appearance.ColorMirrorDownTo = 11565130
      Appearance.ColorMirrorChecked = 13744549
      Appearance.ColorMirrorCheckedTo = 13744549
      Appearance.ColorMirrorDisabled = clWhite
      Appearance.ColorMirrorDisabledTo = clNone
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 13948116
      UIStyle = tsOffice2019White
    end
    object btnReport: TAdvGlowButton
      Left = 319
      Top = 64
      Width = 138
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Report...'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Rounded = False
      TabOrder = 2
      OnClick = btnReportClick
      Appearance.BorderColor = 11382963
      Appearance.BorderColorHot = 11565130
      Appearance.BorderColorCheckedHot = 11565130
      Appearance.BorderColorDown = 11565130
      Appearance.BorderColorChecked = 13744549
      Appearance.BorderColorDisabled = 13948116
      Appearance.ColorChecked = 13744549
      Appearance.ColorCheckedTo = 13744549
      Appearance.ColorDisabled = clWhite
      Appearance.ColorDisabledTo = clNone
      Appearance.ColorDown = 11565130
      Appearance.ColorDownTo = 11565130
      Appearance.ColorHot = 16444643
      Appearance.ColorHotTo = 16444643
      Appearance.ColorMirror = clWhite
      Appearance.ColorMirrorTo = clWhite
      Appearance.ColorMirrorHot = 16444643
      Appearance.ColorMirrorHotTo = 16444643
      Appearance.ColorMirrorDown = 11565130
      Appearance.ColorMirrorDownTo = 11565130
      Appearance.ColorMirrorChecked = 13744549
      Appearance.ColorMirrorCheckedTo = 13744549
      Appearance.ColorMirrorDisabled = clWhite
      Appearance.ColorMirrorDisabledTo = clNone
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 13948116
      Enabled = False
      UIStyle = tsOffice2019White
    end
    object txtCustomer: TAdvEdit
      Left = 8
      Top = 35
      Width = 449
      Height = 23
      EmptyTextStyle = []
      FlatLineColor = 11250603
      FocusColor = clWindow
      FocusFontColor = 3881787
      LabelCaption = 'Customer address'
      LabelPosition = lpTopLeft
      LabelTransparent = True
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -16
      LabelFont.Name = 'Droid Sans'
      LabelFont.Style = [fsBold]
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Anchors = [akLeft, akTop, akRight]
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4474440
      Font.Height = -13
      Font.Name = 'Droid Sans Mono'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
      Visible = True
      Version = '3.5.4.3'
      UIStyle = tsOffice2019White
    end
  end
  object Map: TTMSFNCMaps
    Left = 0
    Top = 0
    Width = 476
    Height = 445
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 0
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    Options.DefaultLatitude = 40.689247000000000000
    Options.DefaultLongitude = -74.044501999999990000
  end
  object Directions: TTMSFNCDirections
    Left = 728
    Top = 264
    Width = 26
    Height = 26
    Visible = True
    OnGetDirections = DirectionsGetDirections
    DirectionsRequests = <>
  end
  object Geocoding: TTMSFNCGeocoding
    Left = 728
    Top = 216
    Width = 26
    Height = 26
    Visible = True
    OnGetGeocoding = GeocodingGetGeocoding
    GeocodingRequests = <>
  end
  object FormStyler: TAdvFormStyler
    AppColor = 14851584
    AutoThemeAdapt = True
    Style = tsOffice2019White
    Left = 615
    Top = 208
  end
  object dlgSave: TFileSaveDialog
    DefaultExtension = 'pdf'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Adobe PDF (*.pdf)'
        FileMask = '*.pdf'
      end>
    OkButtonLabel = 'Save'
    Options = [fdoOverWritePrompt, fdoPathMustExist]
    Title = 'Save Report'
    Left = 623
    Top = 144
  end
end
