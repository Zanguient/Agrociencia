object DMUtil: TDMUtil
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 330
  Width = 495
  object frxReport1: TfrxReport
    Version = '5.2.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42379.957623009250000000
    ReportOptions.LastChange = 42379.957623009250000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 352
    Top = 24
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 352
    Top = 72
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 352
    Top = 120
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 352
    Top = 176
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 184
    Top = 152
  end
  object ImageList1: TImageList
    Left = 233
    Top = 57
    Bitmap = {
      494C0101020008000C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00F3F3F300CACA
      CA00A4A4A4005E5E5E0026262600EEEEEE00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C9
      C900A3A3A3005D5D5D0024242400FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ECECEC00DFDFDF00CDCDCD00CACACA00DEDE
      DE00ECECEC002B292900000000007D7D7D00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDE00CCCCCC00C9C9C900DDDD
      DD00FFFFFFFF2B292900000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008D8D8D00000000008F8F9000FBFBFB00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF8C8C8C00000000008F8F9000FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002B29
      2900000000006D6D6D00FBFBFB0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2B29
      2900000000006B6B6B00FFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E8E8E000000
      00008F8F9000FBFBFB000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D8D8D000000
      00008F8F9000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B9B3B1004A4443007777
      7700FDFDFD00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7B1AF00484241007676
      7600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD009A9A
      990099999800999998009B9B9B00F6F6F600E9E9E900342D2C00DFDCDB00FDFD
      FD0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF9898
      9700979797009797960099999900FFFFFFFFFFFFFFFF322B2A00DDD9D900FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B8B8900BFBEBB00C2C2
      C000C2C2C100C1C1C000C3C2C000C0C0BF008D8C8C00E1E1E000000000000000
      000000000000000000000000000000000000FFFFFFFF89898700BFBEBB00C2C2
      C000C2C2C100C1C1C000C3C2C000C0C0BF008B8A8A00DFDFDE00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B6B6B400BDBDBA00BABA
      B700B8B7B500B7B7B400B9B9B600BCBCB900B8B8B500F6F6F600000000000000
      000000000000000000000000000000000000FFFFFFFFB6B6B400BDBDBA00BABA
      B700B8B7B500B7B7B400B9B9B600BCBCB900B8B8B500FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00A8A8A500A7A7A400A7A7
      A400A7A7A400A8A8A400A8A8A500A8A8A500A8A8A50092929100000000000000
      00000000000000000000000000000000000098989800A8A8A500A7A7A400A7A7
      A400A7A7A400A8A8A400A8A8A500A8A8A500A8A8A50090908F00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F8F8E00A2A29F00A2A39F00A3A3
      A000A3A3A000A3A3A000A3A4A000A4A4A100A4A4A1008B8B8A00F9F9F9000000
      0000000000000000000000000000000000008D8D8C00A2A29F00A2A39F00A3A3
      A000A3A3A000A3A3A000A3A4A000A4A4A100A4A4A10089898800FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F8F8E009D9E9C009E9F9D00A1A1
      9E00A2A29F00A2A3A000A2A3A000A1A29F00A1A19F0087878600F9F9F9000000
      0000000000000000000000000000000000008D8D8C009D9E9C009E9F9D00A1A1
      9E00A2A29F00A2A3A000A2A3A000A1A29F00A1A19F0085858400FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000999A9900ABACAB00ABACAB00ACAD
      AB00ACADAB00ACADAB00ADADAB00ADADAB00ADADAB008B8B8B00000000000000
      00000000000000000000000000000000000097989700ABACAB00ABACAB00ACAD
      AB00ACADAB00ACADAB00ADADAB00ADADAB00ADADAB0089898900FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A5A300CBCBCA00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCCCB00B2B2B000F7F7F700000000000000
      000000000000000000000000000000000000FFFFFFFFA4A5A300CBCBCA00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCCCB00B2B2B000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000085858400A9AAA800E1E1
      E100E1E1E100E1E1E100E1E1E100B9B9B8008586850000000000000000000000
      000000000000000000000000000000000000FFFFFFFF83838200A9AAA800E1E1
      E100E1E1E100E1E1E100E1E1E100B9B9B80083848300FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009394
      9300858685008586850090908F00FBFBFB000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF9192
      910083848300848484008E8E8D00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF80000000000000FE00000000000000
      FFF0000000000000FFE1000000000000FFC3000000000000FF87000000000000
      C00F000000000000803F000000000000803F000000000000003F000000000000
      001F000000000000001F000000000000003F000000000000803F000000000000
      807F000000000000E0FF00000000000000000000000000000000000000000000
      000000000000}
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 352
    Top = 232
  end
end
