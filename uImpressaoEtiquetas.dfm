object frmImpressaoEtiquetas: TfrmImpressaoEtiquetas
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Impress'#227'o de Etiquetas do Lote'
  ClientHeight = 304
  ClientWidth = 667
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 661
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Impress'#227'o de Etiquetas'
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnSuperior: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 51
    Width = 661
    Height = 184
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 109
    DesignSize = (
      661
      184)
    object edNumeroLoteEstagio: TLabeledEdit
      Left = 2
      Top = 76
      Width = 151
      Height = 27
      EditLabel.Width = 30
      EditLabel.Height = 19
      EditLabel.Caption = 'Lote'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
    end
    object edCodigoOrdemProducao: TLabeledEdit
      Left = 2
      Top = 24
      Width = 151
      Height = 27
      EditLabel.Width = 142
      EditLabel.Height = 19
      EditLabel.Caption = 'Ordem de Produ'#231#227'o'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edProduto: TLabeledEdit
      Left = 159
      Top = 24
      Width = 493
      Height = 27
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 56
      EditLabel.Height = 19
      EditLabel.Caption = 'Produto'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edt_Quantidade: TLabeledEdit
      Left = 159
      Top = 76
      Width = 151
      Height = 27
      EditLabel.Width = 81
      EditLabel.Height = 19
      EditLabel.Caption = 'Quantidade'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnAdicionar: TBitBtn
      AlignWithMargins = True
      Left = 316
      Top = 65
      Width = 50
      Height = 38
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBDBDB9494947070
        70707070707070707070707070707070707070707070707070949494DBDBDBFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0051040051040051
        04005104005104005104005104005104005104005104005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F76D0
        7F76D07F76D07F76D07F76D07F76D07F76D07F76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F08A2
        13079C1106960F06920E06920E06950F079A1176D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F09A4
        1408A013079A1106940F06920E06920E06950F76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F09A6
        1508A314089F1207991006940F06910E06920E76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F09A7
        1509A51408A314089E1207991006940F06910E76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F09A7
        1509A61509A61508A314089E1207991006940F76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F09A7
        1509A71509A61509A51408A314089F1207991076D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3DBDBDB
        CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCF00510476D07F09A7
        1509A71509A71509A61509A51408A214089F1276D07F005104646464ABABABCF
        CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFDBDBDBDBDBDB949494
        70707070707070707070707070707070707070707070707000510476D07F09A7
        1509A71509A71509A71509A71509A51408A31476D07F0051044C4C4C64646470
        7070707070707070707070707070707070707070707070949494005104005104
        00510400510400510400510400510400510400510400510400510476D07F09A7
        1509A71509A71509A71509A71509A71509A51476D07F00510400510400510400
        510400510400510400510400510400510400510400510470707000510476D07F
        76D07F76D07F76D07F76D07F76D07F76D07F76D07F76D07F76D07F76D07F09A7
        1509A71509A71509A71509A71509A71509A71576D07F76D07F76D07F76D07F76
        D07F76D07F76D07F76D07F76D07F76D07F76D07F00510470707000510476D07F
        73CD7A6FCC766ACA7268C96F4ABE521EAF2909A71509A71509A71509A71509A7
        1509A71509A71509A71509A71509A71509A71509A61509A51408A314089F1207
        9A1106950F06910E06910E06940F07981076D07F00510470707000510476D07F
        78CF7F74CD7B70CC776CCB7469C97050C15925B13009A71509A71509A71509A7
        1509A71509A71509A71509A71509A71509A71509A71509A71509A61508A31408
        A013079B1106950F06930E06920E06940F76D07F00510470707000510476D07F
        7DD08379CF7F75CE7C71CC786DCB746ACA725AC46232B53C0BA81709A71509A7
        1509A71509A71509A71509A71509A71509A71509A71509A71509A71509A61508
        A41408A013079B1106960F06930E06920E76D07F00510470707000510476D07F
        82D2887ED1847ACF8076CE7D73CD7A6FCC766ACA7268C96F41BB4A1BAE2609A7
        1509A71509A71509A71509A71509A71509A71509A71509A71509A71509A71509
        A61508A41408A013079C1106971006930E76D07F00510470707000510476D07F
        86D48C83D2897FD1857BD08178CF7F74CD7B6FCC766CCB7469C97054C25D30B5
        3A0FA91B09A71509A71509A71509A71509A71509A71509A71509A71509A71509
        A71509A61509A41408A113079C1107971076D07F00510470707000510476D07F
        8BD69187D48D84D38A80D1867DD08379CF7F75CE7C71CC786DCB746ACA7266C8
        6D48BD5127B23109A71509A71509A71509A71509A71509A71509A71509A71509
        A71509A61509A61509A41408A113079D1276D07F00510470707000510476D07F
        90D7958CD69288D58E85D48B82D2887ED1847ACF8076CE7D72CD796FCC766ACA
        7267C86E64C76B43BC4C25B1300BA81709A71509A71509A71509A71509A71509
        A71509A71509A71509A61509A51408A11376D07F00510470707000510476D07F
        76D07F76D07F76D07F76D07F76D07F76D07F76D07F76D07F76D07F76D07F6FCC
        766CCB7469C97065C86C61C66945BC4E2BB33576D07F76D07F76D07F76D07F76
        D07F76D07F76D07F76D07F76D07F76D07F76D07F005104949494005104005104
        00510400510400510400510400510400510400510400510400510476D07F74CD
        7B71CC786DCB7469CA7166C86D62C7695FC66776D07F00510400510400510400
        5104005104005104005104005104005104005104005104DBDBDBFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F79CF
        7F76CE7D72CD796FCC766ACA7267C86E64C76B76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F7FD1
        857BD08177CE7E74CD7B6FCC766BCA7369C97076D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F84D3
        8A80D1867CD08279CF7F74CD7B71CC786DCB7476D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F88D5
        8E84D38A82D2887ED18479CF7F76CE7D72CD7976D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F8DD6
        9389D58F86D48C83D2897ED1847BD08177CE7E76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F92D8
        978ED7948BD69187D48D84D38A80D1867CD08276D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F96D9
        9B93D89890D7958CD69287D48D84D38A81D28776D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F9BDB
        A098DA9D94D99991D8968CD69289D58F85D48B76D07F005104707070CFCFCFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00510476D07F76D0
        7F76D07F76D07F76D07F76D07F76D07F76D07F76D07F005104949494DBDBDBFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0051040051040051
        04005104005104005104005104005104005104005104005104DBDBDBF3F3F3FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 4
      Visible = False
      OnClick = btnAdicionarClick
    end
    object btnExcluir: TBitBtn
      AlignWithMargins = True
      Left = 372
      Top = 65
      Width = 50
      Height = 38
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100AF0301CD0000CA0000CA0000
        C90000C90000C80000C80000C80000C60000C60000C40000C40000C40000C300
        00C20000C20100C00100BF0200BE0300BD0200BC0200BD0000AD0C0CD96288FF
        274CFF2A4CFF294AFF2748FF2342FF223FFF1F3DFF1E3BFF1C36FF1A33FF1930
        FF172DFF1528FF1424FF1220FF111BFF1018FF0F14FF0E12FF0D0DFF0909FF05
        00CD1D1CE35E84FF2A4DFF2C4FFF2749FF2749FF2645FF2443FF233EFF203BFF
        1D39FF1C37FF1B33FF1830FF172DFF152AFF1426FF1323FF111EFF101BFF0F17
        FF0E14FF0E12FF0200DB534FF086A3FF3057FF2C50FF2C4FFF2B4EFF2A49FF27
        49FF2645FF2542FF233EFF203BFF1C39FF1D37FF1B36FF1830FF172DFF152AFF
        1426FF1323FF111EFF101BFF1019FF0300E54D4AF5A2BAFF7994FF5F7EFF456A
        FF3257FF294EFF284CFF2847FF2547FF2545FF2441FF2340FF203BFF1C39FF1D
        37FF1B36FF1830FF172EFF152BFF1426FF1323FF1221FF0200EE4E4BFAA0BAFF
        7594FF7897FF7995FF7594FF6B8BFF6080FF4A6CFF4467FF3356FF3453FF2041
        FF203DFF1E3BFF1B36FF1934FF1832FF1630FF132BFF1229FF1226FF1025FF00
        00F74F4CFF9FB9FF7292FF7494FF7594FF7493FF7491FF6E8FFF6F8EFF6D8CFF
        6C8BFF6B89FF6B87FF6786FF6683FF647FFF637DFF6079FF5F78FF5D75FF5A72
        FF556EFF5771FF3F3EFF5755FFB4CCFF9EB8FFA0B9FFA0B9FFA0B9FF9FB7FF9F
        B7FF9AB5FF9BB4FF98B3FF97B1FF94ADFF93ABFF92AAFF91A8FF8FA6FF8EA6FF
        8C9FFF8A9FFF889EFF889DFF86A0FF514EFF463EFF5D5BFF5B58FF5B58FF5B58
        FF5B58FF5B58FF5B58FF5C58FF5C58FF5C58FF5B58FF5B58FF5B58FF5B58FF5A
        58FF5A58FF5A58FF5B58FF5B56FF5B56FF5A56FF5C58FF463EFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 5
      Visible = False
      OnClick = btnExcluirClick
    end
    object edCodigoUsuario: TLabeledEdit
      Left = 2
      Top = 127
      Width = 151
      Height = 27
      EditLabel.Width = 109
      EditLabel.Height = 19
      EditLabel.Caption = 'C'#243'digo Usu'#225'rio'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object edNomeUsuario: TLabeledEdit
      Left = 159
      Top = 127
      Width = 493
      Height = 27
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 101
      EditLabel.Height = 19
      EditLabel.Caption = 'Nome Usuario'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object pnBotoesEdicao: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 241
    Width = 661
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    TabStop = True
    ExplicitTop = 166
    object GridPanel2: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 655
      Height = 54
      Align = alClient
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = Panel4
          Row = 0
        end
        item
          Column = 0
          Control = Panel5
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 0
      object Panel4: TPanel
        Left = 327
        Top = 0
        Width = 328
        Height = 54
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object btFechar: TSpeedButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 100
          Height = 48
          Align = alLeft
          Caption = '&Fechar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FCFCFCF9F9F9F6F6F6F2F2F2EDEDEDE9E9E9E6E6E6E6E6E6E7E7E7EAEAEAEEEE
            EEF3F3F3F7F7F7FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFDFDFDF9F9F9F2F2F2EAEAEAE1E1E1D9D9D9D0D0D0CBCBCBC9C9C9
            CCCCCCD2D2D2DADADAE3E3E3ECECECF4F4F4FBFBFBFEFEFEFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF9F9F9F1F1F1E9E9E9E0E0E0D7D7D7CF
            CFCFC9C9C9C7C7C7CACACAD0D0D0D9D9D9E1E1E1EAEAEAF3F3F3FAFAFAFEFEFE
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFCFCFCF8F8F8F4F4
            F4F0F0F0EBEBEBE6E6E6DBDBDBE0E0E0E3E3E3DDDDDD7373738C8C8C90909092
            92929595959696969898989999999999999A9A9A9A9A9ABFBFBFFFFFFFFFFFFF
            FEFEFEFEFEFEFDFDFDFCFCFCFAFAFAF8F8F8D7D7D7616984F4F4F4D2D2D22A31
            362125280B0C0C0C0C0C1111111515151919191D1D1D2222222626262A2A2A6C
            6C6CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEDDDDDD0E33A2
            687799D4D4D4414A505D6A734A545C23262A1111111414141919191D1D1D2121
            212525252828286B6B6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFDEDEDE0C39BD0648DE5E6B894B535965737C6370795E6B74464F5722272A
            1818191C1C1C2020202323232727276A6A6AFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFDEDEDE0C38BC014CF8225BDC2F3E596F7D856B788165
            737C5E6B7454606A2D33391B1B1B1E1E1E222222242424696969DEDEDE292970
            292984292A86292E8A29328F293692293A97293E9A0335D50049F61C5FF8366A
            DD45546D7180886D7B8365727B5B6771333A401919191D1D1D20202022222268
            6868DEDEDE0C0C940000B80001B90009C20011CA0019D20021DB0028E30034EB
            0044F41057F82F6DF94674DE46566D73818A6C7982616E77353B411818181B1B
            1B1E1E1E202020676767DEDEDE0C0C940000B80000B80007BF000FC80016D000
            1ED80026E0002EE8003DF0004CF81C60F83873F94876DD46566D717F8867757E
            383F451616161919191C1C1C1E1E1E676767DEDEDE0C0C940000B80000B80004
            BD000CC50013CD001BD50022DC0029E40034EB0042F30650F81F62F83571F93F
            70DD42526D6C7A833B43481414141717171A1A1A1B1B1B656565DEDEDE19199A
            4B4BCD4646CB4142CB3A41CF323FD42B3ED9243EDE1B3CE2143CE80C40EE0547
            F3044FF8175CF82667F92A48886672793E454A13131315151517171719191964
            6464DEDEDE1D1D9B6060D35D5DD25757D04F52D14750D53E4CD83448DC2B46E0
            2142E51840E90E41ED0443F10048F61940956B7A8678868F41474D1111111313
            13151515161616646464DEDEDE1E1E9C6E6ED76B6BD66363D45959D15055D446
            50D63C4BDA3247DC2843E01F40E4143BE70938EB1A39937988958B9AA27D8C94
            424A4F0F0F0F111111131313141414636363DEDEDE19199A5252CF5454CF4E4E
            CE4747CC4041CC383FCF313DD33040D72D42DC233EDE1636E11E349092A0AB9D
            AEB590A0A7829199444D520C0C0C0F0F0F101010111111626262EFEFEF80809C
            7E7E9C7E7E9C7E7E9C7E7E9C7E7E9C7E7F9D71728E212BA8303FD62136D81626
            819DAAB4BFCDD2A8B8BE95A5AC86959D464E540A0A0A0C0C0C0E0E0E0F0F0F61
            6161FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDE2429A4
            2A35CF252E876A737ECADADEC4D2D7B7C6CB9AABB28999A04850560808080A0A
            0A0B0B0B0C0C0C606060FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFDEDEDE1D1E9B2D3089ACACB4889598D1E0E4C9D8DCBECCD1ACBABF909FA6
            4A52570606060808080909090A0A0A5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFDEDEDE252563CCCCD3D7D7D78E999CD6E6EACDDCE1C1
            CFD4B3C1C6A5B2B851595D0404040505050707070707075E5E5EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6E6D0D0D5FFFFFFD7D7D7929F
            A2DCECF0D1E0E4C3D2D6B5C2C8A7B3B9535C610101010303030404040505055D
            5D5DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFD7D7D797A3A6E0F1F4D2E2E6C4D2D7B6C3C9A7B4BA545C610101010101
            010202020202025D5D5DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFD7D7D799A5A8E2F1F5D3E2E6C4D3D7B6C3C9A7B4BA
            545C610101010101010101010101015C5C5CFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8E8565A5B6266675D626359
            5D5F55595B515556494C4D5C5C5C5C5C5C5C5C5C5C5C5C8A8A8A}
          ParentFont = False
          OnClick = btFecharClick
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 327
        Height = 54
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object btEtiquetas: TBitBtn
          AlignWithMargins = True
          Left = 224
          Top = 3
          Width = 100
          Height = 48
          Align = alRight
          Caption = '&Imprimir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000130B0000130B00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3D3D3D3D3D3
            D3D3D3F4F4F4FFFFFFFFFFFFE6E6E6E5E5E5FFFFFFD6D6D6D3D3D3D3D3D3F7F7
            F7DCDCDCD3D3D3D3D3D3D8D8D8FFFFFFFFFFFFF6F6F6D5D5D5FFFFFFEFEFEFD3
            D3D3D3D3D3EEEEEEFFFFFFD8D8D8D3D3D3D3D3D3D3D3D3D3D3D3000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000000000000000
            000000BFBFBFFFFFFFFFFFFF6B6B6B636363FFFFFF0F0F0F000000000000CFCF
            CF2F2F2F0000000000001B1B1BFFFFFFFFFFFFC7C7C7070707FFFFFF9F9F9F00
            00000000009B9B9BFFFFFF171717000000000000000000000000CFCFCFCFCFCF
            CFCFCFF3F3F3FFFFFFFFFFFFE4E4E4E2E2E2FFFFFFD2D2D2CFCFCFCFCFCFF6F6
            F6D8D8D8CFCFCFCFCFCFD5D5D5FFFFFFFFFFFFF5F5F5D1D1D1FFFFFFEDEDEDCF
            CFCFCFCFCFEDEDEDFFFFFFD4D4D4CFCFCFCFCFCFCFCFCFCFCFCFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentFont = False
          TabOrder = 0
          OnClick = btEtiquetasClick
        end
      end
    end
  end
  object cds_Itens: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cds_ItensAfterPost
    Left = 504
    Top = 112
    object cds_ItensCODIGOBARRAS: TStringField
      FieldName = 'CODIGOBARRAS'
      Size = 128
    end
    object cds_ItensORDEMPRODUCAO: TIntegerField
      FieldName = 'ORDEMPRODUCAO'
    end
    object cds_ItensPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cds_ItensDATALOTE: TDateField
      FieldName = 'DATALOTE'
    end
    object cds_ItensCODIGOMC: TStringField
      FieldName = 'CODIGOMC'
      Size = 5
    end
  end
  object ds_Itens: TDataSource
    DataSet = cds_Itens
    Left = 424
    Top = 120
  end
end
