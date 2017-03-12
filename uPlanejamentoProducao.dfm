object frmPlanejamentoProducao: TfrmPlanejamentoProducao
  Left = 0
  Top = 0
  ActiveControl = edDataInicial
  BorderStyle = bsNone
  Caption = 'Planejamento da Produ'#231#227'o'
  ClientHeight = 461
  ClientWidth = 902
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 902
    Height = 461
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object gbPrincipal: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 896
      Height = 86
      Align = alTop
      Caption = '  Per'#237'odo do Planejamento  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 129
        Top = 35
        Width = 21
        Height = 19
        Alignment = taCenter
        Caption = 'at'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edDataFinal: TJvDateEdit
        Left = 156
        Top = 32
        Width = 118
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ShowNullDate = False
        TabOrder = 1
      end
      object edDataInicial: TJvDateEdit
        AlignWithMargins = True
        Left = 5
        Top = 32
        Width = 118
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ShowNullDate = False
        TabOrder = 0
      end
      object btConsulta: TBitBtn
        AlignWithMargins = True
        Left = 280
        Top = 21
        Width = 100
        Height = 54
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFEFEFEF3F3F3E0E0E0CACACAA4A4A47F7F7F5E5E5E2626264D4C4CEE
          EEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF3F3F3DBDBDBC6C6C6B5B5B59B9B9B8484847373736D6D6D4747
          472B29290404048C8C8CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFBFBFBECECECDFDFDFD4D4D4CDCDCDCACACAD1D1D1DEDEDE
          ECECEC7E7E7E2B29290000008F8F907D7D7DFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF8D8D8D2B29290000008F8F906D6D6DFBFBFBFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8E2B29290000008F8F906D6D6DFBFBFBFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8E2B29290000008F8F906D6D
          6DFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8E2B2929000000
          8F8F906D6D6DFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA19E9E3A
          38380000008F8F90777777FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC3C1C1B9B3B14A4443979798777777FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFDFDFDB6B6B59A9A999999989898969999989B9B9B
          ABABABF6F6F6E9E9E9ADA4A3342D2CDFDCDBAFACACFDFDFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6E68C8B8BB4B4B2CAC9C7CECECCCE
          CECCCCCCCBC9C9C8BBBBB88E8E8D9C9795362D2DD7D5D4B3B0B0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA8B8B89BFBEBBC6C6
          C5C2C2C0C2C2C1C2C2C0C1C1C0C3C2C0C4C4C2C0C0BF8D8C8C979393E1E1E0FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D8D8C
          B6B6B4BDBDBABBBBB9BABAB7B8B7B5B7B7B4B7B7B4B9B9B6BBBBB9BCBCB9B8B8
          B58F8E8EF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC0C0C09E9E9DB5B5B2B0B0ADADACA9ACACA8ACACA8ACACA9ACACA9ACACA9
          AEADAAB0AFACB2B2AFACACA9A5A5A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF9A9A9AA9A9A5A8A8A5A7A7A4A7A7A4A7A7A4A7A7A4A8
          A8A4A8A8A4A8A8A5A8A8A5A8A8A5A8A8A5A8A8A5929291FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8EA2A29FA2A29FA2A39FA3A3
          A0A3A3A0A3A3A0A3A3A0A3A3A0A3A4A0A3A4A0A4A4A1A4A4A1A4A4A18B8B8AF9
          F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B8B8A9E9E9B
          9E9E9B9E9E9B9E9E9B9E9F9B9E9F9C9E9F9C9F9F9C9F9F9C9F9F9C9FA09C9FA0
          9C9FA09D8C8C8AEBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF8F8F8E9B9B999D9E9C9E9F9DA0A09EA1A19EA2A29FA2A2A0A2A3A0A2A3A0
          A1A2A0A1A29FA1A19FA0A09E878786F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF999A999FA09DABACABABACABACADABACADABACADABAC
          ADABACADABADADABADADABADADABADADABA6A6A48B8B8BFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7C7C790918FB7B7B6B9B9B8B9B9
          B8B9B9B8B9BAB8B9BAB8B9BAB8B9BAB8B9BAB8B9BAB9B9BAB9999A98A8A8A8FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8E
          A4A5A3CBCBCACBCBCACBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCCCBCBCCCBB2B2
          B0888988F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFEDEDED858584A9AAA8DEDEDDE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
          E0E0E0B9B9B8858685D6D6D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDED898A89949494C2C3C2DFE0DFEC
          ECEBE4E4E4CACACA9D9D9D858685DADADAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C2
          C293949385868587888785868590908FB3B3B3FBFBFBFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 2
        OnClick = btConsultaClick
      end
    end
    object gpBotoes: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 406
      Width = 896
      Height = 52
      Align = alBottom
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
          Column = 0
          Control = Panel8
          Row = 0
        end
        item
          Column = 1
          Control = Panel9
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 1
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 52
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel9: TPanel
        Left = 448
        Top = 0
        Width = 448
        Height = 52
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object btFechar: TSpeedButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 100
          Height = 46
          Align = alLeft
          Caption = '&Fechar'
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
          OnClick = btFecharClick
          ExplicitLeft = 118
          ExplicitTop = 8
          ExplicitHeight = 42
        end
      end
    end
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 95
      Width = 896
      Height = 305
      ActivePage = TSNOP
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = PageControl1Change
      object TSRP: TTabSheet
        Caption = 'Cadastro e Recebimento de Plantas'
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 882
          Height = 42
          Align = alTop
          Caption = 'Cadastro e Recebimento de Plantas'
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
        object gdRecebimentoPlantas: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 882
          Height = 220
          Align = alClient
          Color = clMoneyGreen
          DataSource = DS_PLANTAS
          DrawingStyle = gdsGradient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = gdRecebimentoPlantasCellClick
          OnDrawColumnCell = gdRecebimentoPlantasDrawColumnCell
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLIENTE'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ESPECIE'
              Width = 250
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'SELECAOPOSITIVA'
              Title.Alignment = taCenter
              Width = 125
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CODIGOSELECAOCAMPO'
              Title.Alignment = taCenter
              Width = 200
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DATA'
              Title.Alignment = taCenter
              Width = 128
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ABRIRCADASTRO'
              Title.Alignment = taCenter
              Title.Caption = 'Abrir Cadastro'
              Width = 217
              Visible = True
            end>
        end
      end
      object TSMC: TTabSheet
        Caption = 'Ordem de Produ'#231#227'o do Meio de Cultura'
        ImageIndex = 1
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 882
          Height = 42
          Align = alTop
          Caption = 'Ordem de Produ'#231#227'o do Meio de Cultura'
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
        object gdMeioCultura: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 882
          Height = 220
          Align = alClient
          Color = clMoneyGreen
          DataSource = DS_MEIOCULTURA
          DrawingStyle = gdsGradient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = gdMeioCulturaCellClick
          OnDrawColumnCell = gdMeioCulturaDrawColumnCell
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DATA'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CODIGOMC'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'VOLUMEFINAL'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ABRIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'IMPRIMIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end>
        end
      end
      object TSNOP: TTabSheet
        Caption = 'Finalizando Est'#225'gio (Gerar Nova OP)'
        ImageIndex = 2
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 882
          Height = 42
          Align = alTop
          Caption = 'Finalizando Est'#225'gio (Gerar Nova OP)'
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
        object gdGerarOP: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 882
          Height = 220
          Align = alClient
          Color = clMoneyGreen
          DataSource = DS_NOVAOP
          DrawingStyle = gdsGradient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = gdGerarOPCellClick
          OnDrawColumnCell = gdGerarOPDrawColumnCell
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DATA'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ESPECIE'
              Title.Alignment = taCenter
              Width = 200
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ESTAGIOATUAL'
              Title.Alignment = taCenter
              Width = 200
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CODIGOMC'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'SALDOPOTES'
              Title.Alignment = taCenter
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ABRIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'GERAROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end>
        end
      end
      object TSOPG: TTabSheet
        Caption = 'Novo Est'#225'gio (OP Gerada)'
        ImageIndex = 3
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 882
          Height = 42
          Align = alTop
          Caption = 'Novo Est'#225'gio (OP Gerada)'
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
        object gdOPGerada: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 882
          Height = 220
          Align = alClient
          Color = clMoneyGreen
          DataSource = DS_OPGERADA
          DrawingStyle = gdsGradient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = gdOPGeradaCellClick
          OnDrawColumnCell = gdOPGeradaDrawColumnCell
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DATA'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ESPECIE'
              Title.Alignment = taCenter
              Width = 200
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ESTAGIOATUAL'
              Title.Alignment = taCenter
              Width = 200
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CODIGOMC'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ABRIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'IMPRIMIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end>
        end
      end
      object TSOPESOL: TTabSheet
        Caption = 'Ordem de Produ'#231#227'o de Solu'#231#227'o Estoque'
        ImageIndex = 4
        object gdOPESolEstoque: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 882
          Height = 220
          Align = alClient
          Color = clMoneyGreen
          DataSource = DS_ESOLESTOQUE
          DrawingStyle = gdsGradient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = gdOPESolEstoqueCellClick
          OnDrawColumnCell = gdOPESolEstoqueDrawColumnCell
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DATA'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SOLUCAO'
              Width = 228
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'VOLUMEFINAL'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ABRIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'IMPRIMIROP'
              Title.Alignment = taCenter
              Width = 120
              Visible = True
            end>
        end
        object Panel5: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 882
          Height = 42
          Align = alTop
          Caption = 'Ordem de Produ'#231#227'o de Solu'#231#227'o Estoque'
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  object CDS_PLANTAS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 207
    Top = 226
    object CDS_PLANTASID: TIntegerField
      DisplayLabel = 'Cadastro N'
      DisplayWidth = 70
      FieldName = 'ID'
    end
    object CDS_PLANTASCLIENTE: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'CLIENTE'
      Size = 100
    end
    object CDS_PLANTASESPECIE: TStringField
      DisplayLabel = 'Esp'#233'cie'
      FieldName = 'ESPECIE'
      Size = 100
    end
    object CDS_PLANTASSELECAOPOSITIVA: TStringField
      DisplayLabel = 'Sele'#231#227'o Positiva'
      FieldName = 'SELECAOPOSITIVA'
      Size = 3
    end
    object CDS_PLANTASCODIGOSELECAOCAMPO: TStringField
      DisplayLabel = 'C'#243'digo Sele'#231#227'o Campo'
      FieldName = 'CODIGOSELECAOCAMPO'
      Size = 100
    end
    object CDS_PLANTASDATA: TDateField
      DisplayLabel = 'Data Estimada'
      DisplayWidth = 80
      FieldName = 'DATA'
    end
    object CDS_PLANTASABRIRCADASTRO: TIntegerField
      DisplayWidth = 100
      FieldName = 'ABRIRCADASTRO'
    end
  end
  object CDS_MEIOCULTURA: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 295
    Top = 226
    object CDS_MEIOCULTURAID: TIntegerField
      DisplayLabel = 'C'#243'digo OP'
      DisplayWidth = 70
      FieldName = 'ID'
    end
    object CDS_MEIOCULTURADATA: TDateField
      DisplayLabel = 'Data'
      DisplayWidth = 80
      FieldName = 'DATA'
    end
    object CDS_MEIOCULTURACODIGOMC: TStringField
      DisplayLabel = 'C'#243'digo do MC'
      FieldName = 'CODIGOMC'
      Size = 5
    end
    object CDS_MEIOCULTURAVOLUMEFINAL: TStringField
      DisplayLabel = 'Volume Final'
      FieldName = 'VOLUMEFINAL'
    end
    object CDS_MEIOCULTURAABRIROP: TIntegerField
      DisplayLabel = 'Abrir OP'
      FieldName = 'ABRIROP'
    end
    object CDS_MEIOCULTURAIMPRIMIROP: TIntegerField
      DisplayLabel = 'Imprimir OP'
      FieldName = 'IMPRIMIROP'
    end
  end
  object CDS_NOVAOP: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 391
    Top = 226
    object CDS_NOVAOPID: TIntegerField
      DisplayLabel = 'C'#243'digo OP'
      DisplayWidth = 70
      FieldName = 'ID'
    end
    object CDS_NOVAOPIDOPF: TIntegerField
      FieldName = 'IDOPF'
    end
    object CDS_NOVAOPDATA: TDateField
      DisplayLabel = 'Data (Final)'
      DisplayWidth = 80
      FieldName = 'DATA'
    end
    object CDS_NOVAOPESPECIE: TStringField
      DisplayLabel = 'Esp'#233'cie'
      FieldName = 'ESPECIE'
      Size = 100
    end
    object CDS_NOVAOPESTAGIOATUAL: TStringField
      DisplayLabel = 'Est'#225'gio Atual'
      FieldName = 'ESTAGIOATUAL'
      Size = 100
    end
    object CDS_NOVAOPCODIGOMC: TStringField
      DisplayLabel = 'C'#243'digo do MC'
      FieldName = 'CODIGOMC'
      Size = 5
    end
    object CDS_NOVAOPABRIROP: TIntegerField
      DisplayLabel = 'Abrir OP'
      FieldName = 'ABRIROP'
    end
    object CDS_NOVAOPGERAROP: TIntegerField
      DisplayLabel = 'Gerar OP'
      FieldName = 'GERAROP'
    end
    object CDS_NOVAOPSALDOPOTES: TIntegerField
      DisplayLabel = 'Saldo de Potes'
      FieldName = 'SALDOPOTES'
    end
  end
  object CDS_OPGERADA: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 495
    Top = 226
    object CDS_OPGERADAID: TIntegerField
      DisplayLabel = 'C'#243'digo OP'
      DisplayWidth = 70
      FieldName = 'ID'
    end
    object CDS_OPGERADADATA: TDateField
      DisplayLabel = 'Data (In'#237'cial)'
      DisplayWidth = 80
      FieldName = 'DATA'
    end
    object CDS_OPGERADAESPECIE: TStringField
      DisplayLabel = 'Esp'#233'cie'
      FieldName = 'ESPECIE'
      Size = 100
    end
    object CDS_OPGERADAESTAGIOATUAL: TStringField
      DisplayLabel = 'Est'#225'gio Previsto'
      FieldName = 'ESTAGIOATUAL'
      Size = 100
    end
    object CDS_OPGERADACODIGOMC: TStringField
      DisplayLabel = 'C'#243'digo do MC'
      FieldName = 'CODIGOMC'
      Size = 5
    end
    object CDS_OPGERADAABRIROP: TIntegerField
      DisplayLabel = 'Abrir OP'
      FieldName = 'ABRIROP'
    end
    object CDS_OPGERADAIMPRIMIROP: TIntegerField
      DisplayLabel = 'Imprimir OP'
      FieldName = 'IMPRIMIROP'
    end
  end
  object DS_PLANTAS: TDataSource
    DataSet = CDS_PLANTAS
    Left = 207
    Top = 282
  end
  object DS_MEIOCULTURA: TDataSource
    DataSet = CDS_MEIOCULTURA
    Left = 295
    Top = 282
  end
  object DS_NOVAOP: TDataSource
    DataSet = CDS_NOVAOP
    Left = 391
    Top = 282
  end
  object DS_OPGERADA: TDataSource
    DataSet = CDS_OPGERADA
    Left = 495
    Top = 282
  end
  object CDS_ESOLESTOQUE: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 591
    Top = 226
    object CDS_ESOLESTOQUEID: TIntegerField
      DisplayLabel = 'C'#243'digo OP'
      DisplayWidth = 70
      FieldName = 'ID'
    end
    object CDS_ESOLESTOQUEDATA: TDateField
      DisplayLabel = 'Data'
      DisplayWidth = 80
      FieldName = 'DATA'
    end
    object CDS_ESOLESTOQUESOLUCAO: TStringField
      DisplayLabel = 'Solu'#231#227'o'
      FieldName = 'SOLUCAO'
      Size = 100
    end
    object CDS_ESOLESTOQUEVOLUMEFINAL: TStringField
      DisplayLabel = 'Volume Final'
      FieldName = 'VOLUMEFINAL'
    end
    object CDS_ESOLESTOQUEABRIROP: TIntegerField
      DisplayLabel = 'Abrir OP'
      FieldName = 'ABRIROP'
    end
    object CDS_ESOLESTOQUEIMPRIMIROP: TIntegerField
      DisplayLabel = 'Imprimir OP'
      FieldName = 'IMPRIMIROP'
    end
  end
  object DS_ESOLESTOQUE: TDataSource
    DataSet = CDS_ESOLESTOQUE
    Left = 591
    Top = 282
  end
end
