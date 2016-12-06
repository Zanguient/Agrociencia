object frmEncerramentoOPMC: TfrmEncerramentoOPMC
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Encerramento de Ordens de Produ'#231#227'o de Meio de Cultura'
  ClientHeight = 328
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 902
    Height = 328
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object gbPrincipal: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 896
      Height = 58
      Align = alTop
      Caption = '  Dados Principais  '
      TabOrder = 0
      object Label18: TLabel
        Left = 8
        Top = 12
        Width = 70
        Height = 13
        Caption = 'C'#243'd. OP. MC.:'
      end
      object Label14: TLabel
        Left = 112
        Top = 12
        Width = 47
        Height = 13
        Caption = 'PH Inicial:'
      end
      object Label1: TLabel
        Left = 215
        Top = 12
        Width = 42
        Height = 13
        Caption = 'PH Final:'
      end
      object edt_CodigoOrdem: TButtonedEdit
        AlignWithMargins = True
        Left = 8
        Top = 26
        Width = 97
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Images = DMUtil.ImageList1
        ParentFont = False
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 0
        OnChange = edt_CodigoOrdemChange
        OnKeyDown = edt_CodigoOrdemKeyDown
        OnRightButtonClick = edt_CodigoOrdemRightButtonClick
      end
      object edt_PHInicial: TJvValidateEdit
        Left = 112
        Top = 26
        Width = 97
        Height = 27
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edt_PHFinal: TJvValidateEdit
        Left = 215
        Top = 26
        Width = 97
        Height = 27
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object pnGridPanel: TPanel
      Left = 0
      Top = 64
      Width = 902
      Height = 65
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object GridPanel1: TGridPanel
        Left = 0
        Top = 0
        Width = 902
        Height = 65
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
            Column = 0
            Control = gbMeioCultura
            Row = 0
          end
          item
            Column = 1
            Control = GroupBox1
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 0
        object gbMeioCultura: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 445
          Height = 59
          Align = alClient
          Caption = 'Meio de Cultura'
          TabOrder = 0
          DesignSize = (
            445
            59)
          object Label7: TLabel
            Left = 9
            Top = 12
            Width = 37
            Height = 13
            Caption = 'C'#243'digo:'
          end
          object Label8: TLabel
            Left = 69
            Top = 12
            Width = 50
            Height = 13
            Caption = 'Descri'#231#227'o:'
          end
          object Label9: TLabel
            Left = 355
            Top = 12
            Width = 60
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Quantidade:'
          end
          object edt_CodigoMeioCultura: TButtonedEdit
            AlignWithMargins = True
            Left = 9
            Top = 25
            Width = 56
            Height = 27
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            Images = DMUtil.ImageList1
            ParentFont = False
            RightButton.ImageIndex = 0
            RightButton.Visible = True
            TabOrder = 0
          end
          object edt_DescricaoMeioCultura: TEdit
            Left = 69
            Top = 25
            Width = 280
            Height = 27
            Anchors = [akLeft, akTop, akRight]
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object edt_QuantidadeMeioCultura: TJvValidateEdit
            Left = 355
            Top = 25
            Width = 84
            Height = 27
            Anchors = [akTop, akRight]
            CriticalPoints.MaxValueIncluded = False
            CriticalPoints.MinValueIncluded = False
            DisplayFormat = dfFloat
            DecimalPlaces = 3
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 454
          Top = 3
          Width = 445
          Height = 59
          Align = alClient
          Caption = '  Recipientes  '
          TabOrder = 1
          DesignSize = (
            445
            59)
          object Label3: TLabel
            Left = 8
            Top = 12
            Width = 37
            Height = 13
            Caption = 'C'#243'digo:'
          end
          object Label4: TLabel
            Left = 60
            Top = 12
            Width = 50
            Height = 13
            Caption = 'Descri'#231#227'o:'
          end
          object Label6: TLabel
            Left = 376
            Top = 12
            Width = 60
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Quantidade:'
          end
          object Label17: TLabel
            Left = 308
            Top = 12
            Width = 46
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'ML/ Rec.:'
          end
          object edt_CodigoRecipientes: TButtonedEdit
            AlignWithMargins = True
            Left = 8
            Top = 25
            Width = 49
            Height = 27
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            Images = DMUtil.ImageList1
            ParentFont = False
            RightButton.ImageIndex = 0
            RightButton.Visible = True
            TabOrder = 0
          end
          object edt_NomeRecipiente: TEdit
            Left = 60
            Top = 25
            Width = 244
            Height = 27
            Anchors = [akLeft, akTop, akRight]
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object edt_QuantidadeRecipiente: TJvValidateEdit
            Left = 376
            Top = 25
            Width = 64
            Height = 27
            Anchors = [akTop, akRight]
            CriticalPoints.MaxValueIncluded = False
            CriticalPoints.MinValueIncluded = False
            DecimalPlaces = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object edt_MLPorRecipiente: TJvValidateEdit
            Left = 308
            Top = 25
            Width = 64
            Height = 27
            Anchors = [akTop, akRight]
            CriticalPoints.MaxValueIncluded = False
            CriticalPoints.MinValueIncluded = False
            DisplayFormat = dfFloat
            DecimalPlaces = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
        end
      end
    end
    object pnBotoesVisualizacao: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 265
      Width = 896
      Height = 60
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 3
      object gpBotoes: TGridPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 890
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
        TabOrder = 0
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 445
          Height = 54
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object btEncerrar: TSpeedButton
            AlignWithMargins = True
            Left = 342
            Top = 3
            Width = 100
            Height = 48
            Align = alRight
            Caption = '&Encerrar'
            Glyph.Data = {
              F6060000424DF606000000000000360000002800000018000000180000000100
              180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF9F9F9FEFEFEFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8F8F8F6F6F6F5F5F5F5F5F5
              F5F5F5F5F5F5F5F5F5F5F5F5F3F3F3EBEBEBDCDCDCC8C8C8B2B2B2B2B2B2ECEC
              ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F29F9F9F89
              89898989898989898989898989898989898888888686868989899D9D9DCCCCCC
              E8E8E8F2F2F2D8D8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFA
              FAD9D9D9DBDBDBF3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F1F1F1EEEEEEEB
              EBEBD8D8D8C5C5C5EDEDEDFEFEFED3D3D3FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFD5D5D5A6A6A6E3E3E3FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFCFC
              FCFBFBFBF9F9F9F7F7F7F6F6F6E1E1E1C9C9C9E2E2E2D6D6D6FAFAFAFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4F3F3F3ECECECFDFDFDFDFDFDFDFDFD
              FDFDFDFDFDFDFCFCFCFAFAFAEBEBEBC5C5C5E0E0E0ECECECEDEDEDD1D1D1BBBB
              BBE8E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8E8F0F0F0ECECECFD
              FDFDFDFDFDFDFDFDFDFDFDFCFCFCECECEC939393B0B0B0EDEDEDF6F6F6F1F1F1
              FAFAFAF1F1F1CFCFCFA2A2A2F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1
              F1E8E8E8EBEBEBFCFCFCFCFCFCFCFCFCF7F7F7BFBFBF2F2F2F171717CCCCCCF8
              F8F8F6F6F6F4F4F4F9F9F9F8F8F8F2F2F2CDCDCDCBCBCBFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFF9F9F9E1E1E1EBEBEBFBFBFBFBFBFBF1F1F18B8B8B0E0E0E2E2E
              2EA0A0A0F8F8F8F9F9F9F7F7F7F6F6F6F5F5F5F4F4F4F3F3F3F2F2F2CECECEFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEDEDEDEE9E9E9F8F8F8EDEDED9D9D9D
              181818595959C2C2C2FBFBFBFAFAFAF9F9F9F8F8F8F7F7F7F5F5F5F5F5F5F4F4
              F4F5F5F5CFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDE5E5E5E5
              E5E5BBBBBBD8D8D8C2C2C2E0E0E0FAFAFAFAFAFAFAFAFAF9F9F9F8F8F8F7F7F7
              F6F6F6F5F5F5F5F5F5F5F5F5CFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFD
              FDCDCDCDC9C9C9BCBCBCE4E4E4F0F0F0F8F8F8FAFAFAFAFAFAFAFAFAFAFAFAFA
              FAFAF9F9F9F8F8F8F7F7F7F6F6F6F6F6F6F6F6F6D0D0D0FFFFFFFFFFFFFFFFFF
              FFFFFFF8F8F8C9C9C9989898C5C5C5E9E9E9E8E8E8F2F2F2F9F9F9F9F9F9F9F9
              F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F8F8F8F7F7F7F6F6F6F7F7F7CFCFCFFF
              FFFFFFFFFFFFFFFFEFEFEFB4B4B49F9F9FD8D8D8E8E8E8C1C1C18888C4A3A3B9
              F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F8F8F8F8F8
              F8F8F8F8C8C8C8FDFDFDFEFEFEE2E2E2A2A2A2AEAEAEE7E7E7D4D4D4D6D6D6C4
              C4C8BCBCD56262BBECECF4F8F8F8F8F8F8F8F8F8F8F8F8F7F7F7F6F5F2F7F7F7
              F8F8F8F8F8F8F8F8F8F8F8F8C5C5C5FAFAFAE6E6E6959595C1C1C1ECECECD0D0
              D0D1D1D1E2E2E2F0F0F0E7E7E7E9E9EBE4E4F2F7F7F7F7F7F7F7F7F7F7F7F7F4
              EFE8EDD2AFEFDBBFF6F4F1F7F7F7F7F7F7F7F4F0CAC8C5F2F2F2B1B1B1AFAFAF
              E0E0E0D0D0D0F1F1F1ECECECE4E4E4F4F4F4F1F1F1F2F2F2F7F7F7F7F7F7F7F7
              F7F7F7F7F5F3F0F0D7B1E3A757DD9738E9C18BF4EFE9F6F4F2EEB36FD8C3A5E5
              E5E5E1E1E1F3F3F3F8F8F8FBFBFBFFFFFFEDEDEDE4E4E4CBCBCB9191C9A6A6BB
              F6F6F6F6F6F6F6F6F6F6F6F6F5F3F1EDCA96E79C27DB8613DA8D26E5B26CEABD
              82E59518E3C494D8D8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDEDE4E4E4C6
              C6CAC0C0DB6666BEEBEBF3F6F6F6F6F6F6F6F6F6F6F6F6F5F2EFEBBC75E7981A
              DD8913D9871DDC8316E08D15E5BD83E1E0E0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFEEEEEEE4E4E4EEEEEEE5E5E5E5E5E8E2E2F0F5F5F5F5F5F5F5F5F5F5F5F5F5
              F5F5F4F4F3EDCD9EE89C21E08D14D88012DB8513DDAC69F7F7F6FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFF9F9F9E8E8E8EBEBEBEDEDEDEDEDEDEDEDEDEDEDEDEDED
              EDECECECE9E9E9EDEDEDEEEEEEECE6E2EBAF4BEEA119E39115D98212E2A559FE
              FDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDEDE8E8E8E7E7E7
              E7E7E7EBEBEBEFEFEFF3F3F3FBFBFBFEFEFEFEFDFCEBBA73FCB820F7B222EDA4
              25E59B2FE6B06BFEFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
              FDFDF5F5F5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFAF1D6B4
              F5E0C2F7E8D7FAF2EAFDFAF7FFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            OnClick = btEncerrarClick
            ExplicitLeft = 11
            ExplicitTop = 6
            ExplicitHeight = 46
          end
        end
        object Panel9: TPanel
          Left = 445
          Top = 0
          Width = 445
          Height = 54
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object btFechar: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 100
            Height = 48
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
    end
    object gbObservacao: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 132
      Width = 896
      Height = 127
      Align = alClient
      Caption = '  Observa'#231#227'o  '
      TabOrder = 2
      ExplicitLeft = 376
      ExplicitTop = 184
      ExplicitWidth = 185
      ExplicitHeight = 105
      object edt_Observacao: TEdit
        Left = 2
        Top = 15
        Width = 892
        Height = 110
        Align = alClient
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 318
        ExplicitTop = 26
        ExplicitWidth = 573
        ExplicitHeight = 27
      end
    end
  end
end
