object frmDescarteSE: TfrmDescarteSE
  Left = 0
  Top = 0
  ActiveControl = edQuantidade
  BorderStyle = bsNone
  Caption = 'Descarte de Solu'#231#227'o Estoque'
  ClientHeight = 354
  ClientWidth = 659
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 653
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Descarte de Solu'#231#227'o Estoque'
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
    Width = 653
    Height = 234
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      653
      234)
    object Label8: TLabel
      Left = 110
      Top = 67
      Width = 62
      Height = 13
      Caption = 'C'#243'd. Motivo:'
    end
    object Label1: TLabel
      Left = 182
      Top = 67
      Width = 36
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Motivo:'
    end
    object Label2: TLabel
      Left = 5
      Top = 67
      Width = 60
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Quantidade:'
    end
    object Label3: TLabel
      Left = 5
      Top = 12
      Width = 68
      Height = 13
      Caption = 'C'#243'd. Produto:'
    end
    object Label4: TLabel
      Left = 110
      Top = 12
      Width = 42
      Height = 13
      Caption = 'Produto:'
    end
    object edMotivo: TEdit
      Left = 181
      Top = 82
      Width = 466
      Height = 27
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edCodigoMotivo: TButtonedEdit
      AlignWithMargins = True
      Left = 110
      Top = 82
      Width = 65
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
      TabOrder = 3
      OnChange = edCodigoMotivoChange
      OnKeyDown = edCodigoMotivoKeyDown
      OnRightButtonClick = edCodigoMotivoRightButtonClick
    end
    object edQuantidade: TJvValidateEdit
      Left = 5
      Top = 82
      Width = 99
      Height = 27
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edCodigoProduto: TButtonedEdit
      AlignWithMargins = True
      Left = 5
      Top = 31
      Width = 99
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
      OnChange = edCodigoProdutoChange
      OnKeyDown = edCodigoProdutoKeyDown
      OnRightButtonClick = edCodigoProdutoRightButtonClick
    end
    object edNomeProduto: TEdit
      Left = 110
      Top = 31
      Width = 537
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
  end
  object pnBotoesVisualizacao: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 291
    Width = 653
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object gpBotoes: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 647
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
        Width = 323
        Height = 54
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object btDescartar: TSpeedButton
          AlignWithMargins = True
          Left = 220
          Top = 3
          Width = 100
          Height = 48
          Align = alRight
          Caption = '&Descartar'
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFE3E3E3AEAEAE7E7E7E6262623939393030303030
            30303030373737626262757575A3A3A3D8D8D8FFFFFFFFFFFFFAFAFAB2B2B373
            7373878788ADADADB2B2B2C2C2C2E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFE1E1E16C6C6C6868689A9A9AB4B3B3C4C4C4B9B9B9A4A4A49090
            907F7F7F7474747171717373737A7A7A7575756D6D6DD5D5D5A3A3A55B5B5D73
            7373A9A9A9A5A5A5AEAEAEBDBDBDC4C4C4ECECECFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF1F1F1676767A5A5A5D6D6D6EFEFEFE9E9E9D7D8D8C1C1C1A8A8A89090
            907C7C7C6F6F6F6C6C6C767676949494C0C0C0BBBBBB7575756262645C5C5EAE
            AEAEA3A3A3A1A1A1ADADADBEBEBEC2C2C2C5C5C5FCFCFCFFFFFFFFFFFFFFFFFF
            FFFFFFACACACACACACC1C1C1DEDEDEE7E7E7D6D6D6DADADAC1C1C18F8F8F8C8C
            8C7C7C7C6E6E6E6666666B6B6B7A7A7AABABABBABABA7A7A7C444446A2A2A3AC
            ACACA2A2A2A0A0A0B0B0B0C1C1C1C1C1C1BBBBBBE9E9E9FFFFFFFFFFFFFFFFFF
            FFFFFF898989B2B2B2A8A8A8E1E1E18D8D8DADADADDBDBDBC1C1C1676767B5B5
            B57C7C7C6C6C6C6464647C7C7C6565659090908A8A8A6060626E6E70BEBEBEA9
            A9A9A0A0A09F9F9FB2B2B2C2C2C2BEBEBEBABABAD9D9D9FFFFFFFFFFFFFFFFFF
            FFFFFF909090B5B5B57F7F7FE3E3E3828282B0B0B0DEDEDEC4C4C4656565B8B8
            B87C7C7C6B6B6B6363637B7B7B5D5D5D7E7E7E868687515152BABABBBCBCBCAD
            ADADA3A3A3A2A2A2A6A6A6CBCBCBC2C2C2C0C0C0D6D6D6FFFFFFFFFFFFFFFFFF
            FFFFFF979797B6B6B67F7F7FE7E7E7828282AEAEAEE1E1E1C6C6C6656565B8B8
            B87C7C7C6A6A6A6363637E7E7E5858587878798F8F91696969D8D8D8BEBEBEB1
            B1B1A6A6A69E9E9E888888D9D9D9C9C9C9CFCFCFDEDEDEFFFFFFFFFFFFFFFFFF
            FFFFFF9B9B9BB9B9B9808080E9E9E97C7C7CB1B1B1E5E5E4C9C9C9656565B8B8
            B87C7C7C6A6A6A6363637F7F7F565656888888909090ABABACD7D7D7C4C4C4B9
            B9B9ADADAD9898989999999C9C9CEAEAEAE3E3E3E8E8E8FFFFFFFFFFFFFFFFFF
            FFFFFFA0A0A0BABABA808080EDEDED7A7A7AB2B2B2E8E8E8CDCDCD656565B8B8
            B87C7C7C6A6A6A636363818181525252A0A0A1989899CECECED8D8D8CBCBCBC3
            C3C3B8B8B88D8D8DC1C1C1929292DDDDDDEFEFEFF0F0F0FFFFFFFFFFFFFFFFFF
            FFFFFFA6A6A6BCBCBC818181EFEFEF7B7B7BB3B3B3ECECECCFCFCF656565B8B8
            B87C7C7C6A6A6A6363638383834D4D4DC6C6C6ABABABE4E4E4D9D9D9D0D0D0CC
            CCCCC7C7C7848484C8C8C8888888F0F0F0F3F3F3F3F3F3FFFFFFFFFFFFFFFFFF
            FFFFFFACACACBEBEBE818181F1F1F17B7B7BB3B3B3EFEFEFD3D2D3656565B8B8
            B87C7C7C696969636363858585484848E9E9E9C4C4C4EDEDEDD9D9D9D2D2D2CF
            CFCFCECECE727272C1C1C1878787FDFDFDF4F4F4F8F8F8FFFFFFFFFFFFFFFFFF
            FFFFFFB0B0B0BFBFBF828282F2F2F27B7B7BB2B3B3F1F1F1D5D5D5656565B8B8
            B87C7C7C6969696363638B8B8B454545FDFDFDD6D6D6EDEDEDDADADAD4D4D4D2
            D2D2CACACA4E4E4E9F9F9F9A9A9AFDFDFDF3F3F3F9F9F9FFFFFFFFFFFFFFFFFF
            FFFFFFB2B2B2C0C0C0838383F3F3F37C7C7CB2B2B2F2F2F2D7D7D7656565B8B8
            B87D7D7D6A6A6A6363638E8E8E474747FBFBFBDADADAECECECDCDCDCD7D7D7CF
            CFCFC4C4C44F4F4F898989DFDFDFF9F9F9F1F1F1FBFBFBFFFFFFFFFFFFFFFFFF
            FFFFFFB2B2B2C2C2C2838383F4F4F47C7C7CB3B3B3F3F3F3D8D8D8656565B8B8
            B87F7F7F6B6B6B6464649595953E3E3EF6F6F6D5D5D5EBEBEBDDDDDDD5D5D5C8
            C8C8C1C1C1969696F6F6F6D6D6D6E1E1E1EEEEEEFDFDFDFFFFFFFFFFFFFFFFFF
            FFFFFFB4B4B4C2C2C2848484F4F4F47C7C7CB3B3B3F4F4F4DBDBDB656565B8B8
            B88181817070706464649C9C9C404040DCDCDCC7C7C7EBEBEBDDDDDDD3D3D3C9
            C9C9D4D4D4D3D3D3D5D5D5D8D8D8E2E2E2F1F1F1FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB4B4B4C4C4C4838383F5F5F57C7C7BB3B3B3F5F5F5DDDDDD656565B8B8
            B8878787757575656565A7A7A7474747ADADADAAAAAAE5E5E5DDDDDDD4D4D4D1
            D1D1DDDDDDE0E0E0DADADADEDEDEE5E5E5F8F8F8FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB5B5B5C5C5C5838383F6F6F67B7B7BB3B3B3F5F5F5E0E0E0656565B9B9
            B99090907D7D7D666666B1B1B15555558C8C8CAFAFAFD5D5D5DFDFDFD8D8D8DB
            DBDBE3E3E3E4E4E4DFDFDFE1E1E1EAEAEAFDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB6B6B6C6C6C6848484F7F7F77C7C7CB3B3B3F6F6F6E2E2E2656565B9B9
            B99D9D9D888888666666B4B4B46B6B6B717171C7C7C7C0C0C0E3E3E3DFDFDFE3
            E3E3E8E8E8E7E7E7E5E5E5E7E7E7F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB7B7B7C7C7C7848484F8F8F87B7B7BB3B3B3F6F6F6E5E5E5656565BABA
            BAAAAAAA979797676767B5B5B5838383828282AFAFAFB5B5B5DADADAE6E6E6EA
            EAEAECECECEBEBEBEAEAEAF2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB7B7B7C8C8C8858585F9F9F97B7B7BB3B3B3F7F7F7E8E8E8656565BBBB
            BBB4B4B4A4A4A4686868B5B5B5969696A2A2A26D6D6DCBCBCBC1C1C1EBEBEBEE
            EEEEF0F0F0EFEFEFF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB8B8B8CACACA868686FAFAFA7C7C7CB4B4B4F8F7F7E8E8E8696969B9B9
            B9BABABAAEAEAE6E6E6EADADADA4A4A4BABABA6C6C6CB4B4B4A1A1A1E5E5E5EE
            EEEEF2F2F2FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFB9B9B9CCCCCC8D8D8DFAFAFAAFAFAFCDCDCDF7F6F7E8E8E8C0C0C0BDBD
            BDBFBFBFB5B5B5A1A1A19E9E9EAFAFAFC3C3C3A7A7A7A8A8A8A6A6A6FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFBABABACDCDCDD0D0D0FBFBFBFDFDFDFCFCFCF6F6F6E6E6E6D5D5D5CACA
            CAC0C0C0B8B8B8B1B1B1B1B1B1B8B8B8C9C9C9DFDFDFD3D3D3AAAAAAFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFBABABAC3C3C3C1C1C1B5B5B5A8A8A8A0A0A099999A9090908888888282
            837D7D7E7777787575757575767C7C7D8E8E8FACACACBDBDBDADADADFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF8C8C8C7878799B9B9ABDBDBDD4D4D5DCDCDCECECECEDEDEDEDEDEDEDED
            EDEDEDEDEDEDEDECECECD9D9D9CACACBB0B0B1A1A1A2828282717172FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            F6F6F67E7E80AAAAAAA6A6A68181826565666767697070715D5D616161626464
            6665656877777979797A717173818182909092ABABACCACACAABABABF6F6F6FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            B0B0B05E5E5E32323539393B41414249494A5252545B5B5D6464666B6B6D6E6E
            706F6F726C6C6E6666685D5D6055555649494C4242443A3A3C6B6B6BB3B3B3FC
            FCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            9F9FA139393A3E3E414646484E4E4F5656586060616868697070737777797A7A
            7C7B7B7D78787A7272746B6B6C6262635757594E4E504646483F3F41969698FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            F4F4F46A6A6B3D3D3F4444464F4F515D5D5E6666686F6F717777797E7E7F8181
            828282847F7F8079797A72727369696A57575949494C4242456A6A6DECECECFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF7F7F7B1B1B278787A58585A5151534A4A4D5050544D4D4F5454
            565252544E4E4F58585A5555555A5A5C777778A5A5A6F6F6F6FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          OnClick = btDescartarClick
          ExplicitLeft = 0
        end
      end
      object Panel9: TPanel
        Left = 323
        Top = 0
        Width = 324
        Height = 54
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object btCancelar: TSpeedButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 100
          Height = 48
          Align = alLeft
          Caption = '&Cancelar'
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFEFEFF86868C03E3EB75A5ABCE3E3F4FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEBF85C
            5CC73737C15757C6DFDFF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF4F4FA5B5BB74646D23B3BF93A3ADD4141B1DFDFF2FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDF84B4BC041
            41DD6363F85858E14343BEE5E5F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF7F7FC6161B74F4FCE3232FD0000F11B1BF73939DB4141B2E2E2F3FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1FA4F4FC03737D84F
            4FF73E3EEF6464FC5F5FDE4646BDE8E8F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            EAEAF65D5DB45656CD3535FD0000F40000EF0000EB1717F32F2FDD3D3DB1DBDB
            F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6F64949BC2F2FD94242F337
            37EA4040EE4343F16D6DFC6A6ADF4545BDDCDCF3FFFFFFFFFFFFFFFFFFFFFFFF
            7070BC5959CE3C3CFF0000F70000F20000EF0000EB0000E61313F02929E03D3D
            B2E1E1F2FFFFFFFFFFFFFFFFFFFFFFFFEFEFF94D4DBD2A2ADB3939F12F2FE539
            39EA4141EE4848F14B4BF57979FF7272E15757C4FFFFFFFFFFFFFFFFFFFFFFFF
            4444A76464F40000FF0000F60000F20000EF0000EB0000E80000E30E0EED2020
            DC3F3FB2E2E2F3FFFFFFFFFFFFECECF84F4FBB2020D62E2EEE2727E23131E639
            39EA4141EE4848F14F4FF55454FC9494FF4242C0FFFFFFFFFFFFFFFFFFFFFFFF
            7979BF5656C54343FF0000F90000F20000EF0000EB0000E80000E40000DE0C0C
            E91818DA3E3EB2E4E4F4F1F1F95151BA1717D42323EB2020DD2929E33131E739
            39EA4141EE4848F14C4CF67F7FFF6C6CDC5F5FC7FFFFFFFFFFFFFFFFFFFFFFFF
            F4F4FA6C6CB75252C13D3DFD0000F40000EE0000EB0000E80000E40000E00000
            DA0808E61010DC3535B03D3DAF1010D61818E91919DA2222E02929E33131E739
            39EA4040EE4444F17171FD6060D84D4DBFE7E7F7FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF7F7FB6D6DB84C4CC43737FD0000F10000EB0000E80000E40000E00000
            DC0000D60404E20808DA0909D60E0EE51111D61919DC2222E02929E33131E739
            39EA3D3DEE6767FB5959D94E4EBEEDEDF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFBFBFD6868B54949C93232FB0000EC0000E70000E40000E00000
            DC0000D90000D20000DF0303E10B0BD21212D81919DB2222E02929E33030E735
            35EA5C5CF95656DC4D4DBDEFEFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF2F2F96868B54040C32B2BF60000E80000E40000E00000
            DC0000D80000D50000CF0303CE0B0BD41212D81919DB2222E02929E32E2EE651
            51F64949D74A4ABBE6E6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFAFAFD6E6EB73838C22525F60000E50000DF0000
            DC0000D70000D40000CE0000CE0808D31111D81919DB2222DF2727E24646F340
            40D55050BBF1F1FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FC6C6CB73434C91E1EF30000E00000
            DB0000D70707D60B0BD40C0CD30D0DD50F0FD71717DB2020DE3A3AF03A3AD74F
            4FB8EDEDF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9FC5353AA2E2EC71313EC1818
            E55555F55F5FF76363F86464F85F5FF75959F43232E52828EA3333D63B3BAEF4
            F4FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F84C4CA82929CD1717ED5A5A
            F68888FF8282FF8181FF8181FF8282FF8585FF6C6CF83434ED3030D93939AFE6
            E6F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEF65858AB3333D11A1AF35D5DF59090
            FF8888FF8888FF8989FF8989FF8888FF8888FF8E8EFF7373F73E3EF13C3CDD3F
            3FB1DFDFF2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF2F2F85D5DAB3838CB1F1FF76363F69D9DFF9393
            FF9292FF9393FF9999FF9B9BFF9393FF9292FF9292FF9A9AFF7C7CF84A4AF444
            44DB4040B1E1E1F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFE8E8F35A5AA84141CC2727F86D6DF9A7A7FF9F9FFF9E9E
            FF9F9FFFA9A9FF6B6BEF6060EBA7A7FF9F9FFF9E9EFF9D9DFFA4A4FF8787F953
            53F64F4FDC3E3EB1DADAF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFF0F0F75D5DA84A4AD12828FC7373F9B6B6FFA9A9FFA8A8FFA9A9
            FFB8B8FF7979F00606E30101E36A6AECB6B6FFABABFFA8A8FFA9A9FFB1B1FF90
            90FA5E5EFA5C5CE04040B1E0E0F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFEDEDF55D5DA55050CB2C2CFF7777FBC0C0FFB5B5FFB3B3FFB4B4FFC0C0
            FF7F7FF10A0AE80707CB0A0AC40A0AE77272EEBFBFFFB4B4FFB3B3FFB4B4FFBB
            BBFF9A9AFB6969FD6161DE4040B1E1E1F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            EFEFF66060A45757C73232FE7F7FFBCCCCFFBEBEFFBEBEFFBFBFFFD0D0FF8989
            F40D0DEC0D0DD04B4BA95454AA1010C81313EC8080F1CECEFFC0C0FFBEBEFFBE
            BEFFC7C7FFA3A3FC7373FE6969DB4141B1DFDFF2FFFFFFFFFFFFFFFFFFFFFFFF
            7575B15A5AC74444FF8888FED9D9FFCCCCFFCACAFFCACAFFDADAFF8E8EF41515
            ED1313CA5858ACEEEEF7F9F9FC6C6CB71515C12323EC8787F1D6D6FFCCCCFFCA
            CAFFCBCBFFD3D3FFAEAEFE8787FF7373DD5A5ABCFFFFFFFFFFFFFFFFFFFFFFFF
            4E4E9A5858F24848FFEAEAFFD8D8FFD5D5FFD7D7FFE6E6FF9393F61515F21C1C
            CB5B5BAAEEEEF7FFFFFFFFFFFFF8F8FB7070B81F1FC32A2AF18E8EF4E1E1FFD7
            D7FFD5D5FFD6D6FFE4E4FF9595FF8E8EFE4747B5FFFFFFFFFFFFFFFFFFFFFFFF
            8888BA5757B74646FF7A7AFFF2F2FFE3E3FFF2F2FF9B9BF71A1AF52323CF5B5B
            A9F0F0F7FFFFFFFFFFFFFFFFFFFFFFFFFBFBFD6969B62626C83535F39A9AF5EE
            EEFFE2E2FFEDEDFFAFAFFE8383FF6666D16868C0FFFFFFFFFFFFFFFFFFFFFFFF
            F5F5F97878B05252B43939FB8181FCFFFFFFA3A3F91F1FF62C2CCA5A5AA6E8E8
            F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F96868B52C2CC34444F4A7
            A7F8FDFDFFB5B5FC7474FD5B5BCD5858B7EAEAF6FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFDFDFE7F7FB24A4AB53A3AFD5656FB3131FB3232C56161A8F2F2F8FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFD6D6DB83131C256
            56F98787FA7171FE5353CC5F5FB7F7F7FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFDFDFE7A7AB04646B83737ED3939C75F5FA5EFEFF6FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FC6B6BB73D
            3DC75959EF4F4FCD5C5CB4F4F4FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF6F6FA8787BA4D4D9D7575B2F1F1F7FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FA79
            79BF3838A76A6ABAEFEFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          OnClick = btCancelarClick
          ExplicitLeft = 11
          ExplicitTop = 6
          ExplicitHeight = 46
        end
      end
    end
  end
end
