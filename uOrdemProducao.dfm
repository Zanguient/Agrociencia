object frmOrdemProducao: TfrmOrdemProducao
  Left = 0
  Top = 0
  ActiveControl = edPesquisa
  BorderStyle = bsNone
  Caption = 'Ordem de Produ'#231#227'o'
  ClientHeight = 714
  ClientWidth = 897
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnEdicao: TPanel
    Left = 0
    Top = 0
    Width = 897
    Height = 714
    Align = alClient
    TabOrder = 1
    Visible = False
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 895
      Height = 646
      Align = alClient
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 889
        Height = 42
        Align = alTop
        Caption = 'Cadastro de Recebimento de Plantas'
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
      object ScrollBox2: TScrollBox
        Left = 1
        Top = 43
        Width = 889
        Height = 598
        Align = alClient
        TabOrder = 1
        object GridPanel1: TGridPanel
          Left = 0
          Top = 0
          Width = 885
          Height = 521
          Align = alTop
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
              Control = pnUsuarioEsquerda
              Row = 0
            end
            item
              Column = 1
              Control = pnUsuarioDireita
              Row = 0
            end>
          RowCollection = <
            item
              Value = 100.000000000000000000
            end>
          TabOrder = 0
          object pnUsuarioEsquerda: TPanel
            Left = 1
            Top = 1
            Width = 441
            Height = 519
            Align = alClient
            TabOrder = 0
            object Label2: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 206
              Width = 433
              Height = 19
              Align = alTop
              Caption = 'Quantidade estimada de Produ'#231#227'o:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 248
            end
            object Label3: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 322
              Width = 433
              Height = 19
              Align = alTop
              Caption = 'Observa'#231#227'o:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 88
            end
            object Label14: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 264
              Width = 433
              Height = 19
              Align = alTop
              Caption = 'Limite de Multiplica'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 167
            end
            object edQuantidade: TEdit
              AlignWithMargins = True
              Left = 4
              Top = 231
              Width = 433
              Height = 27
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              NumbersOnly = True
              ParentFont = False
              TabOrder = 3
            end
            object gbProduto: TGroupBox
              AlignWithMargins = True
              Left = 4
              Top = 68
              Width = 433
              Height = 63
              Align = alTop
              Caption = ' Esp'#233'cie '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object edCodigoProduto: TButtonedEdit
                AlignWithMargins = True
                Left = 4
                Top = 31
                Width = 56
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
                Left = 66
                Top = 31
                Width = 364
                Height = 27
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
            object gbCliente: TGroupBox
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 433
              Height = 58
              Align = alTop
              Caption = ' Cliente '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              DesignSize = (
                433
                58)
              object edCodigoCliente: TButtonedEdit
                AlignWithMargins = True
                Left = 4
                Top = 24
                Width = 56
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
                OnChange = edCodigoClienteChange
                OnKeyDown = edCodigoClienteKeyDown
                OnRightButtonClick = edCodigoClienteRightButtonClick
              end
              object edNomeCliente: TEdit
                Left = 66
                Top = 24
                Width = 359
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
            object pnObservacao: TPanel
              AlignWithMargins = True
              Left = 4
              Top = 347
              Width = 433
              Height = 98
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 5
              object edObservacao: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 321
                Height = 92
                Align = alClient
                AutoSize = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                MaxLength = 512
                ParentFont = False
                TabOrder = 0
              end
              object btObservacao: TBitBtn
                AlignWithMargins = True
                Left = 330
                Top = 3
                Width = 100
                Height = 92
                Align = alRight
                Glyph.Data = {
                  360C0000424D360C000000000000360000002800000020000000200000000100
                  180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFDFDFDFDFDFCFCFCFCFCFCFBFB
                  FBFBFBFBFBFAFAFBFAFAFBFAFAFBFAFAFBFBFBFBFBFBFCFCFCFCFCFCFDFDFDFD
                  FDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FEFDFDFCFCFCFAFAFAF8F8F8F6F6F6F4F4F4F2F2F2F0F0EFEFEEEEEDEDECECEB
                  EBEBEAEAEAEAEAEAE9E9EAE9E9EAEAE9EBEAEAECEBEBEDECECEEEEEEF0F0EFF2
                  F1F1F4F3F3F6F6F5F8F7F7FAF9F9FCFCFBFDFDFDFEFEFEFFFFFFFDFDFDFBFBFB
                  F9F9F8F6F6F6F4F3F3F1F0F0EEEEEDEBEBEAE9E8E8E6E5E5E4E3E3E2E1E1E1E0
                  E0E0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE1E0E0E2E1E1E4E3E2E6E5E4E8
                  E7E7EBEAEAEDEDECF0EFEFF3F2F2F6F5F5F8F8F8FBFAFAFDFDFDFEFEFEFCFCFC
                  CDC8C2A0988CA0988CA0988CA0988CA0988CA0988CA0988CA0988CA0988CA098
                  8CA0988CA0988CA0988CA0988CA0988CA0988CA0988CA0988CA0988CA0988CA0
                  988CA0988CC7C3BDF1F1F0F4F4F3F7F6F6F9F9F9FBFBFBFEFEFEFFFFFFFFFFFF
                  A0988CD4CEC6ECE8E0EDE9E1EDEAE3EFEBE5F0EDE6F1EEE8F2EFEAF3F0EBF4F2
                  EDF5F3EFF6F4F0F7F5F2F8F7F4F9F8F5FAF9F7FBFAF9FCFBFAFCFCFBFDFDFCF9
                  F8F7DDD9D5A0988CFAFAFAFCFCFCFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE3DED3E2DCD0E3DED3E5E0D5E6E2D8E8E4DAEAE6DDEBE8DFEDEAE2EEEB
                  E5EAE7E1F2EFEAF3F1ECF5F3EFF6F5F1F8F7F4F9F8F6FBFAF9FCFCFBFDFDFCFD
                  FDFCFCFBFAA0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACEE2DCD0D2CCC1D4CEC3D5CFC5D6D1C6D7D2C8D8D4CADAD5CCDAD6
                  CEBAB6B19A9794AEABA6D5D5D1E0DDD8E2DFDAE3E0DBE4E1DDE5E3DFE6E4E1FD
                  FDFCFBFBFAA0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE2DCD0E3DED2E5E0D5E6E2D8E8E4DAEAE6DDEBE7DFEDE9E2EEEB
                  E4E3E1DB94918E979D9F91A6B1B0BEC3E8EAE9F9F8F6FBFAF8FCFBFAFCFCFBFC
                  FCFAFBFAF9A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE1DCD0E3DED2E5E0D5E6E2D7E8E3DAE9E5DCEBE7DFECE9E1EEEB
                  E4F0EDE6B3BBBCA7C0CDB7CFDB96ACB7839AA5A9B7BDF1F2F0FAFAF8FBFAF9FB
                  FAF8FAF9F7A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE1DCCFD2CCC0D3CDC2D4CFC4D5D0C6D7D1C8D8D3C9D9D4CBDAD5
                  CDDBD7CFC8CCCC90AEBEBBD6E5C5DFEC9DB4C0839AA5878649DBD8CDE3E0DBF9
                  F8F6F9F7F5A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE1DBCFE2DDD1E4DFD4E6E1D6E7E2D9E9E4DBEAE6DDECE8E0EDEA
                  E2EEEBE5F0EDE7A2BBC899B9CAB5D0DF9EB2BD9AA07C7F7311898232EFEDE4F8
                  F6F3F7F6F2A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE0DBCEE2DCD1E4DED3E5E0D5E7E2D8E8E4DAE9E5DCEBE7DFECE9
                  E1EEEAE4EFECE6D6DCDD88AABD90AEBEACB08AC0A835A895247F7311898232ED
                  EBE2F6F4F0A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE0DACDD1CBBFD2CCC0D3CDC2D4CFC4D5D0C6D7D1C8D7D2C9D9D4
                  CBDAD5CCDAD6CEDBD7CFA8B8B88F8F52B6980FC5A92EC0A835A895247F731189
                  8231ECE9DFA0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE0DACDE1DBCFE2DDD1E4DFD3E5E0D6E7E2D8E8E4DAE9E5DCEBE7
                  DEECE8E1EDEAE3EEEBE4EFEDE6B6A556967C00B6980FC5A92EC0A835A895247F
                  73118881309C9483FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE0DACDE0DACDE0DACEE2DCD0E3DED2E4DFD4E6E1D7E7E3D9E8E4DBEAE6
                  DDEBE7DFECE9E1EDEAE2EEEBE4EFECE6B6A556967C00B6980FC5A92EC0A835A8
                  95247F731179711EF6F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE6E1D6E2DDD1D0C9BDD1CABED1CBC0D3CCC1D4CEC3D4CFC4D6D0C6D6D1
                  C7D7D2C9D8D3CAD9D4CBDAD5CCDAD5CDDAD6CEAE9C4D967C00B6980FC5A92EC0
                  A835A895247F73118E884BF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE8E3DAE8E3DAE7E2D8E5E0D5E2DDD1E3DDD2E4DFD4E5E0D6E6E2D8E8E3
                  DAE9E4DBEAE6DDEBE7DEEBE8E0ECE9E1EDEAE2EDEAE3B5A455967C00B6980FC5
                  A92EC0A835A6973C9390899A9897F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CE9E4DBE9E4DBE9E4DBE9E4DBE9E5DCE9E5DCE8E3DAE7E3D9E7E2D8E6E2
                  D8E7E3D9E8E4DBE9E5DCEAE6DEEBE7DFEBE8E0ECE8E1ECE9E1B5A354967C00B6
                  980FC3AD48B8B6AFAFAEAD9795949A9897F6F7FAFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CEAE5DDEAE5DDDFDAD2DFDAD2DFDAD2DFDBD3E0DCD4E1DCD4E1DDD5E2DD
                  D6E0DCD5E0DBD3E0DCD4E0DCD5E1DCD5E1DDD6E1DDD6E2DDD7E2DED7B2A0529A
                  841FB2AFA5C5C4C3D2D1D0A7A6A5878B9D8190BAF6F7FAFFFFFFFFFFFFFFFFFF
                  A0988CEAE7DEEAE7DEEAE7DEEAE7DEEAE7DEEAE7DFEBE8E0ECE8E1EDE9E2EEEA
                  E3EEEAE4EFEBE5EFECE6F0EDE6F0EDE7F0EEE8F1EEE8F1EFE8F1EFE9F1EFE9C2
                  BFB4A9A8A6C5C4C3BCBBBBB3B8CB97A8DC7282B3B3BCD5FFFFFFFFFFFFFFFFFF
                  A0988CECE8E0ECE8E0ECE8E0ECE8E0ECE8E0ECE8E0ECE8E0ECE9E1EDEAE2EDEA
                  E3EEEBE4EFEBE5EFECE5F0ECE6F0EDE6F1EDE7F1EDE7F1EEE8F1EEE8F1EEE8F1
                  EEE8C4C2BEA9A8A6AAB0C1AEBDEDA4B3E37F8DBAC2C9DDFFFFFFFFFFFFFFFFFF
                  A0988CEDE9E2EDE9E2EDE9E2EDE9E2EDE9E2EDE9E2EDE9E2EDE9E2EEE9E2EEEA
                  E3EEEBE4EFEBE5EFECE5EFEDE6F0EDE7F0EDE7F0EEE8F0EEE8F0EEE8F0EEE8F0
                  EEE8F0EEE89A9B9F808EB696A5D28D99C09EA9C9F7F8FBFFFFFFFFFFFFFFFFFF
                  A0988CEEEAE3E6E3DCD8D5CED7D3CDD8D5CEE8E5DDE6E3DCD8D5CED7D3CDD8D5
                  CFE9E5DFE8E4DED9D6D0D8D5CFD9D7D1EAE7E1E9E6E0DAD8D2D9D7D0DAD8D2EB
                  E8E2F0EEE7A0988CB3BBD17E8CB3B3BAD3F8F9FBFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CEEECE5D9D6D0AAA398A0988CAAA398D9D6D0D9D6D0AAA398A0988CAAA3
                  98D9D6D0D9D6D0AAA398A0988CAAA398DAD8D1DAD8D2AAA398A0988CAAA398DA
                  D8D2F1EEE8A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CF0EDE6D8D6CFA0988CC8C1B4A0988CD8D6CFD8D6CFA0988CC8C1B4A098
                  8CD8D6CFD8D6CFA0988CC8C1B4A0988CD8D6D0D9D6D1A0988CC8C1B4A0988CD9
                  D7D1F1EEE8A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  A0988CF1EEE8DBD8D2A0988CE0DACDA0988CDBD8D2DBD8D2A0988CE0DACDA098
                  8CDBD8D2DBD8D2A0988CE0DACDA0988CDBD8D2DBD8D2A0988CE0DACDA0988CDB
                  D9D3F1EEE8A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F8
                  A0988CF2EFEAEAE8E2A0988CE2DDD1A0988CECE9E4EAE8E2A0988CE2DDD1A098
                  8CECE9E4EAE8E2A0988CE2DDD1A0988CECE9E4EAE8E2A0988CE2DDD1A0988CEC
                  E9E4F0EEE8A0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F8
                  A0988CE3E0DAEDEAE5A0988CF3F0EBA0988CEDEAE5EDEAE5A0988CF3F0EBA098
                  8CEDEAE5EDEAE5A0988CF3F0EBA0988CEDEAE5EDEAE5A0988CF3F0EBA0988CED
                  EAE5E3E0DAA0988CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  D0CCC6A0988CA0988CA0988CF3F0EBA0988CA0988CA0988CA0988CF3F0EBA098
                  8CA0988CA0988CA0988CF3F0EBA0988CA0988CA0988CA0988CF3F0EBA0988CA0
                  988CA0988CD0CCC6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFF3F2F1A0988CC6C0B4A0988CFFFFFFF3F2F1A0988CC6C0B4A098
                  8CFFFFFFF3F2F1A0988CC6C0B4A0988CFFFFFFF3F2F1A0988CC6C0B4A0988CFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFB2ABA2A0988CB2ABA2FFFFFFFFFFFFB2ABA2A0988CB2AB
                  A2FFFFFFFFFFFFB2ABA2A0988CB2ABA2FFFFFFFFFFFFB2ABA2A0988CB2ABA2FF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
                TabOrder = 1
                OnClick = btObservacaoClick
              end
            end
            object edLimiteMultiplicacao: TEdit
              AlignWithMargins = True
              Left = 4
              Top = 289
              Width = 433
              Height = 27
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              NumbersOnly = True
              ParentFont = False
              TabOrder = 4
            end
            object Panel6: TPanel
              AlignWithMargins = True
              Left = 4
              Top = 451
              Width = 433
              Height = 64
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 6
              DesignSize = (
                433
                64)
              object Label6: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 5
                Width = 118
                Height = 19
                Caption = 'Sele'#231#227'o Positiva:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                AlignWithMargins = True
                Left = 130
                Top = 5
                Width = 214
                Height = 19
                Caption = 'C'#243'digo da Sele'#231#227'o no Campo:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label7: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 63
                Width = 142
                Height = 19
                Caption = 'Origem do Material:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object cbSelecaoPositiva: TComboBox
                Left = 6
                Top = 29
                Width = 118
                Height = 27
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ItemIndex = 0
                ParentFont = False
                TabOrder = 0
                Text = 'Sim'
                Items.Strings = (
                  'Sim'
                  'N'#227'o')
              end
              object edCodSelecaoCampo: TEdit
                AlignWithMargins = True
                Left = 130
                Top = 30
                Width = 302
                Height = 27
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object edOrigemMaterial: TEdit
                AlignWithMargins = True
                Left = 6
                Top = 86
                Width = 426
                Height = 27
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
            end
            object gbVariedade: TGroupBox
              AlignWithMargins = True
              Left = 4
              Top = 137
              Width = 433
              Height = 63
              Align = alTop
              Caption = '  Variedade  '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              object edCodigoVariedade: TButtonedEdit
                AlignWithMargins = True
                Left = 4
                Top = 31
                Width = 56
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
                OnChange = edCodigoVariedadeChange
                OnKeyDown = edCodigoVariedadeKeyDown
                OnRightButtonClick = edCodigoVariedadeRightButtonClick
              end
              object edDescricaoVariedade: TEdit
                Left = 66
                Top = 31
                Width = 361
                Height = 27
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
          end
          object pnUsuarioDireita: TPanel
            Left = 442
            Top = 1
            Width = 442
            Height = 519
            Align = alClient
            TabOrder = 1
            object Panel7: TPanel
              Left = 1
              Top = 1
              Width = 440
              Height = 295
              Align = alTop
              BevelOuter = bvLowered
              TabOrder = 0
              DesignSize = (
                440
                295)
              object Label4: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 63
                Width = 153
                Height = 19
                Caption = 'Fazenda/'#225'rea/Talh'#227'o:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label5: TLabel
                AlignWithMargins = True
                Left = 130
                Top = 5
                Width = 97
                Height = 19
                Caption = 'Coletado por:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label9: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 5
                Width = 109
                Height = 19
                Caption = 'Data de Coleta:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label1: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 126
                Width = 85
                Height = 19
                Caption = 'Localizador:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label10: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 184
                Width = 114
                Height = 19
                Caption = 'Quant. Material:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label11: TLabel
                AlignWithMargins = True
                Left = 130
                Top = 184
                Width = 115
                Height = 19
                Caption = 'Transportadora:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label12: TLabel
                AlignWithMargins = True
                Left = 6
                Top = 242
                Width = 112
                Height = 19
                Caption = 'Data de Receb.:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label13: TLabel
                AlignWithMargins = True
                Left = 130
                Top = 242
                Width = 107
                Height = 19
                Caption = 'Data Estimada:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object edFazendaAreaTalhao: TEdit
                AlignWithMargins = True
                Left = 6
                Top = 88
                Width = 432
                Height = 27
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object edDataColeta: TJvDateEdit
                Left = 6
                Top = 30
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
              object edColetadoPor: TEdit
                AlignWithMargins = True
                Left = 130
                Top = 30
                Width = 308
                Height = 27
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object edLocalizador: TEdit
                AlignWithMargins = True
                Left = 6
                Top = 151
                Width = 432
                Height = 27
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
              object edQuantidadeMaterial: TEdit
                AlignWithMargins = True
                Left = 6
                Top = 209
                Width = 118
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                NumbersOnly = True
                ParentFont = False
                TabOrder = 4
              end
              object edTransportadora: TEdit
                AlignWithMargins = True
                Left = 130
                Top = 209
                Width = 308
                Height = 27
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object edDataRecebimento: TJvDateEdit
                Left = 6
                Top = 267
                Width = 118
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ShowNullDate = False
                TabOrder = 6
              end
              object edDataEstimada: TJvDateEdit
                Left = 130
                Top = 267
                Width = 118
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ShowNullDate = False
                TabOrder = 7
              end
            end
            object pnFotos: TPanel
              Left = 1
              Top = 296
              Width = 440
              Height = 225
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              Visible = False
              object ScrollBox1: TScrollBox
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 434
                Height = 69
                Align = alTop
                TabOrder = 0
              end
              object pnImagem: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 78
                Width = 434
                Height = 144
                Align = alClient
                BevelOuter = bvNone
                Color = 16250871
                ParentBackground = False
                TabOrder = 1
                object Image1: TImage
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 142
                  Height = 138
                  Align = alLeft
                  Center = True
                  Proportional = True
                  ExplicitHeight = 115
                end
                object btnImagemWebCam: TBitBtn
                  AlignWithMargins = True
                  Left = 151
                  Top = 51
                  Width = 100
                  Height = 40
                  Caption = 'Buscar WebCam'
                  TabOrder = 0
                  OnClick = btnImagemWebCamClick
                end
                object btnSalvarImagem: TBitBtn
                  AlignWithMargins = True
                  Left = 151
                  Top = 97
                  Width = 100
                  Height = 40
                  Caption = 'Salvar Imagem'
                  TabOrder = 1
                  OnClick = btnSalvarImagemClick
                end
                object btnImagemArquivo: TBitBtn
                  AlignWithMargins = True
                  Left = 151
                  Top = 5
                  Width = 100
                  Height = 40
                  Caption = 'Buscar Arquivo'
                  TabOrder = 2
                  OnClick = btnImagemArquivoClick
                end
              end
            end
          end
        end
      end
    end
    object pnBotoesEdicao: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 650
      Width = 889
      Height = 60
      Align = alBottom
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      TabStop = True
      Visible = False
      object GridPanel2: TGridPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 881
        Height = 52
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
          Left = 440
          Top = 0
          Width = 441
          Height = 52
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object btCancelar: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 100
            Height = 46
            Align = alLeft
            Caption = '&Cancelar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Glyph.Data = {
              36300000424D3630000000000000360000002800000080000000200000000100
              18000000000000300000120B0000120B00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFEFEFEF2F2F2E7E7E7E1E1E1E5E5E5EFEFEFFBFBFBFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFEFEFEF2F2F2E7E7E7E1E1E1E5E5E5EFEFEFFBFBFBFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFEFEFEF2F2F2E7E7E7E1E1E1E5E5E5EFEFEFFBFBFBFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFEFEFEF2F2F2E7E7E7E1E1E1E5E5E5EFEFEFFBFBFBFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8DADADAA7A7
              AF6F6F8D5050813B3B7D2F2F7938387C4B4B7F6767899999A5CECECFEFEFEFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8DADADAA9A9
              A97B7B7B6565655A5A5A5151515757576262627575759C9C9CCECECEEFEFEFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8DADADAA7A7
              A86F6F7550505E3B3B522F2F4A38384F4B4B5B67676F99999ACECECEEFEFEFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8DADADAA7A7
              A86F6F7550505E3B3B522F2F4A38384F4B4B5B67676F99999ACECECEEFEFEFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCC3C3C665658A23237C0101
              860000970000A10000A40000A40000A50000A100009900008918187D535382AE
              AEB4F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCC3C3C37575754C4C4C4242
              424A4A4A5050505151515151515151514F4F4F4C4C4C434343484848676767B0
              B0B0F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCC3C3C365656E2323480101
              4900005B00006700006B00006B00006C00006700005D00004B181844535360AE
              AEAEF2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCC3C3C365656E2323480101
              4900005B00006700006B00006B00006C00006700005D00004B181844535360AE
              AEAEF2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA77779211117F0000970000A20000
              AC0000B50000BB0000C00000C00000C00000BC0000B60000AE0000A400009A08
              08825C5C84D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA8282824545454B4B4B5050505555
              555A5A5A5E5E5E6060606161616060605E5E5E5C5C5C5757575151514C4C4C42
              42426D6D6DD5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA77777C11114500005B0000680000
              7500008200008A00009200009200009200008C00008300007800006B00005E08
              08455C5C66D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA77777C11114500005B0000680000
              7500008200008A00009200009200009200008C00008300007800006B00005E08
              08455C5C66D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFD7D7D845457F00008E0000A20000B10000BD0000
              C60000CF0000D20000D50000D50000D60000D30000CF0000C80000BF0000B300
              00A50000932D2D7ABBBBBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFD7D7D76060604646465050505858585E5E5E6363
              636767676B6B6B6B6B6B6B6B6B6D6D6D6A6A6A6868686464645E5E5E59595952
              5252474747505050BCBCBCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFD7D7D745455800005000006800007C00008D0000
              9B0000A90000AE0000B30000B30000B40000AF0000A900009E00009000007F00
              006C0000562D2D4ABBBBBBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFD7D7D745455800005000006800007C00008D0000
              9B0000A90000AE0000B30000B30000B40000AF0000A900009E00009000007F00
              006C0000562D2D4ABBBBBBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFD8D8D935357C0000960000A70000B90000C90000D10000
              D81B1BE25252EB7171EF7F7FF17272F05555EB1D1DE30000DA0000D20000CB00
              00BD0000AA0000991D1D7AB8B8BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFD8D8D85656564B4B4B5252525C5C5C6565656969696D6D
              6D767676898989999999A2A2A29999998A8A8A7575756D6D6D6A6A6A6666665E
              5E5E5555554A4A4A494949B9B9B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFD8D8D835354F00005A00006F00008700009F0000AC0000
              B80303C91B1BD93333E04040E43434E21D1DD90303CB0000BB0000AE0000A200
              008D00007300005D1D1D44B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFD8D8D835354F00005A00006F00008700009F0000AC0000
              B80303C91B1BD93333E04040E43434E21D1DD90303CB0000BB0000AE0000A200
              008D00007300005D1D1D44B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFECECEC41417F0000960000A80000BD0000CC0000D73232E39B9B
              F3EAEAFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDFEA0A0F43535E50000D900
              00CE0000C00000AB000099242479D1D1D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFECECEC5E5E5E4949495353535F5F5F6767676C6C6C7A7A7AB4B4
              B4EEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1B8B8B87C7C7C6E6E6E67
              67676060605555554B4B4B4C4C4CD1D1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFECECEC41415600005A00007000008D0000A40000B60A0ACB5F5F
              E8D7D7FAFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEDCDCFC6666E90B0BCE0000B900
              00A700009200007400005D242445D1D1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFECECEC41415600005A00007000008D0000A40000B60A0ACB5F5F
              E8D7D7FAFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEDCDCFC6666E90B0BCE0000B900
              00A700009200007400005D242445D1D1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFEFEFE73739100008E0000A40000BA0000CB0A0AD89898F2F8F8FFFFFF
              FFFFFFFFFFFFFFEFEFFEE4E4FDEFEFFDFFFFFFFFFFFFFFFFFFFAFAFF9E9EF30E
              0EDA0000CE0000BE0000A70000944A4A7FF0F0F0FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFEFEFE7F7F7F4545455151515D5D5D6666666D6D6DB0B0B0FAFAFAFFFF
              FFFFFFFFFFFFFFF2F2F2E9E9E9F3F3F3FFFFFFFFFFFFFFFFFFFBFBFBB5B5B56F
              6F6F6868685F5F5F525252484848616161F0F0F0FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFEFEFE73737A00005000006B0000890000A20000B85C5CE6F1F1FEFEFE
              FEFEFEFEFEFEFEE0E0FCCCCCFAE0E0FAFEFEFEFEFEFEFEFEFEF5F5FE6363E800
              00BB0000A700008F00006F0000574A4A5AF0F0F0FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFEFEFE73737A00005000006B0000890000A20000B85C5CE6F1F1FEFEFE
              FEFEFEFEFEFEFEE0E0FCCCCCFAE0E0FAFEFEFEFEFEFEFEFEFEF5F5FE6363E800
              00BB0000A700008F00006F0000574A4A5AF0F0F0FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFC5C5C90A0A7F00009D0000B30000C60C0CD4B2B2F4FFFFFFFFFFFFF2F2
              FE9292F24444EA1818E60C0CE41616E54242E98787F1EFEFFDFFFFFFFFFFFFBB
              BBF61010D70000C80000B70000A00000859D9DA9FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFC6C6C64242424E4E4E5959596363636C6C6CC4C4C4FFFFFFFFFFFFF5F5
              F5ADADAD848484767676737373757575828282A6A6A6F2F2F2FFFFFFFFFFFFCA
              CACA6D6D6D6464645C5C5C4F4F4F404040A1A1A1FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFC5C5C50A0A4400006200007F00009B0000B17E7EE9FEFEFEFEFEFEE6E6
              FC5555E61313D70202D00000CC0202CE1111D54949E4E0E0FAFEFEFEFEFEFE8A
              8AED0101B600009E0000850000660000479D9D9EFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFC5C5C50A0A4400006200007F00009B0000B17E7EE9FEFEFEFEFEFEE6E6
              FC5555E61313D70202D00000CC0202CE1111D54949E4E0E0FAFEFEFEFEFEFE8A
              8AED0101B600009E0000850000660000479D9D9EFFFFFFFFFFFFFFFFFFFFFFFF
              FCFCFC5C5C890000940000A80000BD0000CB9A9AEEFFFFFFFFFFFFCACAF83535
              E40000DC0000DD0000DD0000DE0000DE0000DB2A2AE3EAEAFCFFFFFFFFFFFFFF
              FFFFA4A4F10101CE0000C00000AC00009834347CEBEBEBFFFFFFFFFFFFFFFFFF
              FCFCFC7070704848485353535F5F5F666666B0B0B0FFFFFFFFFFFFD5D5D57C7C
              7C7070707070707171717171717070706F6F6F797979EFEFEFFFFFFFFFFFFFFF
              FFFFB9B9B96767675F5F5F5656564B4B4B555555EBEBEBFFFFFFFFFFFFFFFFFF
              FCFCFC5C5C6900005700007000008D0000A25E5EDEFEFEFEFEFEFEA1A1F10B0B
              CC0000BE0000C00000C00000C20000C20000BD0707CBD7D7F9FEFEFEFEFEFEFE
              FEFE6B6BE40000A700009200007500005C34344EEBEBEBFFFFFFFFFFFFFFFFFF
              FCFCFC5C5C6900005700007000008D0000A25E5EDEFEFEFEFEFEFEA1A1F10B0B
              CC0000BE0000C00000C00000C20000C20000BD0707CBD7D7F9FEFEFEFEFEFEFE
              FEFE6B6BE40000A700009200007500005C34344EEBEBEBFFFFFFFFFFFFFFFFFF
              E0E0E115157D00009A0000AF0000C03131D6FDFDFFFFFFFFCCCCF81111DB0000
              D80000D90000D90000D90000D90000D90707D9C6C6F7FFFFFFFFFFFFF2F2FDFF
              FFFFFFFFFF3939D90000C20000B200009D02027FBABABFFFFFFFFFFFFFFFFFFF
              E0E0E04646464C4C4C575757616161747474FDFDFDFFFFFFD7D7D77171716D6D
              6D6D6D6D6D6D6D6E6E6E6D6D6D6D6D6D6E6E6ED2D2D2FFFFFFFFFFFFF5F5F5FF
              FFFFFFFFFF7777776262625959594D4D4D3F3F3FBBBBBBFFFFFFFFFFFFFFFFFF
              E0E0E015154400005E0000790000920A0AB4FAFAFEFEFEFEA4A4F10101BD0000
              B80000B90000B90000B90000B90000B90000B99B9BEFFEFEFEFEFEFEE6E6FAFE
              FEFEFEFEFE0D0DB900009500007E000062020241BABABAFFFFFFFFFFFFFFFFFF
              E0E0E015154400005E0000790000920A0AB4FAFAFEFEFEFEA4A4F10101BD0000
              B80000B90000B90000B90000B90000B90000B99B9BEFFEFEFEFEFEFEE6E6FAFE
              FEFEFEFEFE0D0DB900009500007E000062020241BABABAFFFFFFFFFFFFFFFFFF
              A1A1AF0000870000A00000B40000C2A3A3EDFFFFFFF0F0FD3030DC0000D20000
              D50000D50000D50000D50000D40000D29797EEFFFFFFFFFFFF8787EA3434DCEB
              EBFCFFFFFFADADEF0000C40000B70000A200008E777794FFFFFFFFFFFFFFFFFF
              A6A6A64141414F4F4F5A5A5A626262B8B8B8FFFFFFF4F4F47777776A6A6A6C6C
              6C6B6B6B6B6B6B6B6B6B6B6B6B6A6A6AAFAFAFFFFFFFFFFFFFA4A4A4787878EF
              EFEFFFFFFFBEBEBE6262625B5B5B505050454545838383FFFFFFFFFFFFFFFFFF
              A1A1A30000490000660000800000956A6ADCFEFEFEE2E2FA0909BE0000AE0000
              B30000B30000B30000B30000B10000AE5B5BDEFEFEFEFEFEFE4949D70B0BBED9
              D9F9FEFEFE7777E000009800008500006800005077777DFFFFFFFFFFFFFFFFFF
              A1A1A30000490000660000800000956A6ADCFEFEFEE2E2FA0909BE0000AE0000
              B30000B30000B30000B30000B10000AE5B5BDEFEFEFEFEFEFE4949D70B0BBED9
              D9F9FEFEFE7777E000009800008500006800005077777DFFFFFFFFFFFFFFFFFF
              6A6A900000920000A30000B41F1FCAF2F2FDFFFFFF9292EA0000CB0000CF0000
              CF0000CF0000CF0000CE0000CC7373E5FFFFFFFFFFFFA1A1ED0000CC0000CA85
              85E8FFFFFFF8F8FE2727CD0000B70000A7000095434380F5F5F5FFFFFFFFFFFF
              7A7A7A4747475151515A5A5A696969F5F5F5FFFFFFACACAC6666666868686868
              68686868686868676767666666969696FFFFFFFFFFFFB5B5B5676767666666A3
              A3A3FFFFFFFAFAFA6C6C6C5B5B5B5252524949495E5E5EF5F5F5FFFFFFFFFFFF
              6A6A7400005500006A0000800404A1E6E6FAFEFEFE5555D70000A20000A90000
              A90000A90000A90000A70000A43535CEFEFEFEFEFEFE6767DC0000A40000A147
              47D3FEFEFEF1F1FC0606A600008500006F000058434358F5F5F5FFFFFFFFFFFF
              6A6A7400005500006A0000800404A1E6E6FAFEFEFE5555D70000A20000A90000
              A90000A90000A90000A70000A43535CEFEFEFEFEFEFE6767DC0000A40000A147
              47D3FEFEFEF1F1FC0606A600008500006F000058434358F5F5F5FFFFFFF9F9F9
              4242820000940000A40000B25A5AD5FFFFFFFDFDFF3B3BD50000C60000C90000
              C90000C90000C90000C55555DBFCFCFEFFFFFFBDBDF10C0CCA0000C70000C631
              31D3FCFCFEFFFFFF6161D80000B40000A70000961E1E7CE3E3E3FFFFFFF9F9F9
              606060484848515151595959838383FFFFFFFEFEFE7676766363636565656464
              64656565656565626262848484FDFDFDFFFFFFCACACA66666664646463636373
              7373FCFCFCFFFFFF8888885959595252524949494A4A4AE3E3E3FFFFFFF9F9F9
              42425800005700006B00007E2121B3FEFEFEFAFAFE0E0EB300009B00009F0000
              9F00009F00009F0000991D1DBDF9F9FCFEFEFE8D8DE40000A100009C00009B0A
              0AAFF9F9FCFEFEFE2626B800008000006F00005A1E1E46E3E3E3FFFFFFF9F9F9
              42425800005700006B00007E2121B3FEFEFEFAFAFE0E0EB300009B00009F0000
              9F00009F00009F0000991D1DBDF9F9FCFEFEFE8D8DE40000A100009C00009B0A
              0AAFF9F9FCFEFEFE2626B800008000006F00005A1E1E46E3E3E3FFFFFFF1F1F1
              2A2A7F0000930000A30000AE7676DAFFFFFFEAEAFA1010C60000C20000C20000
              C20000C20000BF3737CFF0F0FCFFFFFFDADAF61C1CC80000C00000C30000C20A
              0AC5E0E0F7FFFFFF8585DE0000B10000A60000950A0A7CD3D3D5FFFFFFF1F1F1
              535353474747515151565656949494FFFFFFEFEFEF6666666161616262626262
              62616161606060717171F2F2F2FFFFFFDFDFDF68686861616162626262626263
              6363E6E6E6FFFFFF9F9F9F585858525252494949424242D4D4D4FFFFFFF1F1F1
              2A2A4D00005600006A0000783838BBFEFEFED7D7F501019B0000950000950000
              950000950000900C0CA9E2E2F9FEFEFEBBBBED03039E00009200009600009500
              0099C5C5EFFEFEFE4747C200007C00006D0000580A0A41D3D3D3FFFFFFF1F1F1
              2A2A4D00005600006A0000783838BBFEFEFED7D7F501019B0000950000950000
              950000950000900C0CA9E2E2F9FEFEFEBBBBED03039E00009200009600009500
              0099C5C5EFFEFEFE4747C200007C00006D0000580A0A41D3D3D3FFFFFFEFEFEF
              25257F0000920000A10000AA8080DAFFFFFFD5D5F40707BE0000BC0101BD0202
              BD0000BA2121C4DBDBF6FFFFFFEFEFFB3636CA0000BA0202BD0101BD0000BC04
              04BDCDCDF2FFFFFF9B9BE20000AD0000A300009406067BCBCBCEFFFFFFEFEFEF
              5050504848484F4F4F545454999999FFFFFFDCDCDC5F5F5F5E5E5E5F5F5F5F5F
              5F5D5D5D686868E1E1E1FFFFFFF1F1F17070705D5D5D5E5E5E5F5F5F5E5E5E5F
              5F5FD7D7D7FFFFFFAEAEAE5555555151514949493E3E3ECCCCCCFFFFFFEFEFEF
              25254B0000550000670000734141BBFEFEFEB3B3E900008F00008C00008D0000
              8D000089040498BDBDEDFEFEFEE0E0F70C0CA100008900008D00008D00008C00
              008DA6A6E6FEFEFE5F5FC900007700006A00005706063FCBCBCBFFFFFFEFEFEF
              25254B0000550000670000734141BBFEFEFEB3B3E900008F00008C00008D0000
              8D000089040498BDBDEDFEFEFEE0E0F70C0CA100008900008D00008D00008C00
              008DA6A6E6FEFEFE5F5FC900007700006A00005706063FCBCBCBFFFFFFF1F1F1
              27277F00009000009E0000A47878D5FFFFFFE6E6F80E0EBA0000B60101B70000
              B60D0DB9C2C2EEFFFFFFF9F9FD5353CE0000B30101B70303B80303B80000B609
              09B9DCDCF5FFFFFF8989DA0000A700009F00009107077CD0D0D2FFFFFFF1F1F1
              5151514747474E4E4E515151939393FFFFFFE9E9E95E5E5E5B5B5B5C5C5C5A5A
              5A5E5E5ECCCCCCFFFFFFFAFAFA7D7D7D5A5A5A5B5B5B5B5B5B5D5D5D5A5A5A5D
              5D5DE2E2E2FFFFFF9F9F9F5353534E4E4E4848483F3F3FD1D1D1FFFFFFF1F1F1
              27274B00005300006300006B3A3AB3FEFEFED0D0F10000890000830000850000
              830000879595DEFEFEFEF3F3FA1C1CA700007F00008500008600008600008300
              0087BEBEEBFEFEFE4B4BBB00006F00006400005407073FD0D0D0FFFFFFF1F1F1
              27274B00005300006300006B3A3AB3FEFEFED0D0F10000890000830000850000
              830000879595DEFEFEFEF3F3FA1C1CA700007F00008500008600008600008300
              0087BEBEEBFEFEFE4B4BBB00006F00006400005407073FD0D0D0FFFFFFF7F7F7
              36368100008D00009800009F5F5FC9FFFFFFFCFCFE3535C10000AE0000AF0202
              AFA3A3E3FFFFFFFFFFFF7373D30000AD0101B10101B10202B10303B10000AF2B
              2BBDF9F9FDFFFFFF6565CC0000A000009A00008E14147BE1E1E2FFFFFFF7F7F7
              5959594545454A4A4A4E4E4E818181FFFFFFFCFCFC6A6A6A5656565757575757
              57B4B4B4FFFFFFFFFFFF8F8F8F55555557575758585858585859595957575766
              6666FAFAFAFFFFFF8585854F4F4F4C4C4C464646454545E1E1E1FFFFFFF7F7F7
              36365200004F00005C00006424249FFEFEFEF9F9FC0B0B930000780000790000
              796A6ACBFEFEFEFEFEFE3535AF00007700007C00007C00007C00007C00007907
              078DF3F3FAFEFEFE2929A400006600005E000050141442E1E1E1FFFFFFF7F7F7
              36365200004F00005C00006424249FFEFEFEF9F9FC0B0B930000780000790000
              796A6ACBFEFEFEFEFEFE3535AF00007700007C00007C00007C00007C00007907
              078DF3F3FAFEFEFE2929A400006600005E000050141442E1E1E1FFFFFFFFFFFF
              5C5C8D00008B00009300009B2626B1F7F7FCFFFFFF8787D80000A60000A78383
              D6FFFFFFFFFFFF9393DB0000AA0404AC0505AC0505AC0606AD0606AD0000A779
              79D3FFFFFFFBFBFE2F2FB500009C00009400008B34347FF4F4F4FFFFFFFFFFFF
              7272724444444949494D4D4D5D5D5DF8F8F8FFFFFF9E9E9E5252525252529A9A
              9AFFFFFFFFFFFFA7A7A755555557575756565655555558585857575752525293
              9393FFFFFFFCFCFC6363634D4D4D494949434343585858F4F4F4FFFFFFFFFFFF
              5C5C6B00004D00005600005F06067CEFEFF9FEFEFE4949B800006D00006F4545
              B4FEFEFEFEFEFE5656BD00007300007500007500007500007700007700006F3B
              3BAFFEFEFEF7F7FC09098200006100005700004D343450F4F4F4FFFFFFFFFFFF
              5C5C6B00004D00005600005F06067CEFEFF9FEFEFE4949B800006D00006F4545
              B4FEFEFEFEFEFE5656BD00007300007500007500007500007700007700006F3B
              3BAFFEFEFEF7F7FC09098200006100005700004D343450F4F4F4FFFFFFFFFFFF
              8B8BA300008500008D00009500009CB3B3E3FFFFFFE8E8F72B2BB56969CBFFFF
              FFFFFFFFB8B8E60E0EAA0A0AA80F0FAA0E0EAA0E0EAA0E0EAA0707A72626B3E2
              E2F5FFFFFFBDBDE701019E00009700008E00008866668FFFFFFFFFFFFFFFFFFF
              9595954141414444444949494D4D4DBFBFBFFFFFFFECECEC626262868686FFFF
              FFFFFFFFC3C3C35757575555555656565555555757575555555353535F5F5FE7
              E7E7FFFFFFC7C7C74D4D4D4A4A4A454545424242787878FFFFFFFFFFFFFFFFFF
              8B8B9000004700004F0000580000617F7FCBFEFEFED3D3EF0707822C2CA2FEFE
              FEFEFEFE8686D000007300007000007300007300007300007300006F06067FC9
              C9EBFEFEFE8D8DD100006300005B00005000004A666671FFFFFFFFFFFFFFFFFF
              8B8B9000004700004F0000580000617F7FCBFEFEFED3D3EF0707822C2CA2FEFE
              FEFEFEFE8686D000007300007000007300007300007300007300006F06067FC9
              C9EBFEFEFE8D8DD100006300005B00005000004A666671FFFFFFFFFFFFFFFFFF
              CECED204047B00008800008F0606995656BDFFFFFFFFFFFFE6E6F6FEFEFEFFFF
              FFE2E2F42D2DB11717A82020AB1F1FAB1F1FAB1F1FAB1919A91717A9B5B5E3FF
              FFFFFFFFFF5F5FC109099B000091000088000080A2A2B0FFFFFFFFFFFFFFFFFF
              CFCFCF3D3D3D4242424646464C4C4C787878FFFFFFFFFFFFEAEAEAFEFEFEFFFF
              FFE6E6E66161615656565B5B5B5A5A5A5959595A5A5A565656575757C0C0C0FF
              FFFFFFFFFF7D7D7D4D4D4D4747474242423E3E3EA7A7A7FFFFFFFFFFFFFFFFFF
              CECECE04043E00004A00005100005D1E1E8DFEFEFEFEFEFED0D0EDFCFCFCFEFE
              FEC9C9E908087C0202700404740404740404740404740202710202718282CBFE
              FEFEFEFEFE24249300005F00005400004A000041A2A2A4FFFFFFFFFFFFFFFFFF
              CECECE04043E00004A00005100005D1E1E8DFEFEFEFEFEFED0D0EDFCFCFCFEFE
              FEC9C9E908087C0202700404740404740404740404740202710202718282CBFE
              FEFEFEFEFE24249300005F00005400004A000041A2A2A4FFFFFFFFFFFFFFFFFF
              F9F9F93737820000860000892323A03636ADC0C0E5FFFFFFFFFFFFFFFFFFF6F6
              FC6E6EC62828AB3636B13737B13636B03434AF2D2DAD4949B8B9B9E4FFFFFFFF
              FFFFC7C7E83838AE2C2CA501018B00008517177AE2E2E3FFFFFFFFFFFFFFFFFF
              F9F9F95A5A5A414141434343555555626262C8C8C8FFFFFFFFFFFFFFFFFFF7F7
              F78989895D5D5D6464646464646363636262625E5E5E6E6E6EC5C5C5FFFFFFFF
              FFFFCFCFCF6363635A5A5A434343414141444444E2E2E2FFFFFFFFFFFFFFFFFF
              F9F9F937375300004800004B0505660C0C779292CEFEFEFEFEFEFEFEFEFEEDED
              F930309B0606740C0C7C0C0C7C0C0C7B0B0B790808771515868787CCFEFEFEFE
              FEFE9C9CD30D0D7808086C00004D000047171743E2E2E2FFFFFFFFFFFFFFFFFF
              F9F9F937375300004800004B0505660C0C779292CEFEFEFEFEFEFEFEFEFEEDED
              F930309B0606740C0C7C0C0C7C0C0C7B0B0B790808771515868787CCFEFEFEFE
              FEFE9C9CD30D0D7808086C00004D000047171743E2E2E2FFFFFFFFFFFFFFFFFF
              FFFFFFA6A6B500007F0000823F3FA66060BA6868BFDBDBF0FFFFFFFFFFFFF3F3
              FAA2A2D97575C66363BF6060BD6262BE7373C6A3A3DAE9E9F6FFFFFFFFFFFFE0
              E0F26B6BC15D5DB94E4EAE0202850000827B7B9AFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFABABAB3E3E3E3F3F3F6262627C7C7C828282E0E0E0FFFFFFFFFFFFF5F5
              F5B0B0B08C8C8C8080807D7D7D7E7E7E8B8B8BB1B1B1EDEDEDFFFFFFFFFFFFE4
              E4E48484847A7A7A6C6C6C4141413E3E3E888888FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFA6A6A800004000004410106D2525892B2B90BDBDE2FEFEFEFEFEFEE8E8
              F56868B937379B27279025258D27278F35359B6A6ABBD5D5EDFEFEFEFEFEFEC5
              C5E62E2E932323871818780000470000447B7B82FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFA6A6A800004000004410106D2525892B2B90BDBDE2FEFEFEFEFEFEE8E8
              F56868B937379B27279025258D27278F35359B6A6ABBD5D5EDFEFEFEFEFEFEC5
              C5E62E2E932323871818780000470000447B7B82FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFF9F9F93E3E8300007E4141A19494CE8484C79191CFDDDDF0FEFEFFFFFF
              FFFFFFFFFDFDFEEAEAF6E2E2F3E9E9F6FBFBFEFFFFFFFFFFFFFFFFFFE0E0F194
              94D08484C89595CE5656AC00007E1F1F7BE7E7E8FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFF9F9F95E5E5E3D3D3D626262A3A3A3979797A2A2A2E1E1E1FEFEFEFFFF
              FFFFFFFFFDFDFDECECECE6E6E6ECECECFDFDFDFFFFFFFFFFFFFFFFFFE3E3E3A5
              A5A5969696A3A3A37171713C3C3C4B4B4BE7E7E7FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFF9F9F93E3E5700003F1111675757A746469C5454A9C0C0E2FCFCFEFEFE
              FEFEFEFEFAFAFCD7D7EDC9C9E8D5D5EDF7F7FCFEFEFEFEFEFEFEFEFEC5C5E457
              57AB46469E5858A71E1E7500003F1F1F46E7E7E7FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFF9F9F93E3E5700003F1111675757A746469C5454A9C0C0E2FCFCFEFEFE
              FEFEFEFEFAFAFCD7D7EDC9C9E8D5D5EDF7F7FCFEFEFEFEFEFEFEFEFEC5C5E457
              57AB46469E5858A71E1E7500003F1F1F46E7E7E7FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFD3D3D713137B161689A6A6D3BABADFAEAEDAAFAFDAC9C9E6ECEC
              F6FDFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFEECECF7CBCBE7B0B0DBAE
              AED9B6B6DDB5B5DB292992040478B1B1BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFD4D4D4444444464646B2B2B2C4C4C4B9B9B9BABABAD0D0D0EDED
              EDFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEEEEEED1D1D1BABABAB8
              B8B8BFBFBFBEBEBE5151513B3B3BB5B5B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFD3D3D313134102024B6D6DAF8989C37878BB7979BB9F9FD0DADA
              EDFAFAFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFAFAFCDADAEFA2A2D17B7BBD78
              78B98383C08282BD07075504043BB1B1B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFD3D3D313134102024B6D6DAF8989C37878BB7979BB9F9FD0DADA
              EDFAFAFCFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFAFAFCDADAEFA2A2D17B7BBD78
              78B98383C08282BD07075504043BB1B1B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFADADBA08087743439FD5D5EADBDBEED1D1E9CDCDE7CFCF
              E9DBDBEEE7E7F3EDEDF6EFEFF8EDEDF7E6E6F4DCDCEECFCFE9CDCDE7D0D0E8D8
              D8EDDDDDEE5F5FAD0000798888A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFB2B2B23D3D3D626262D9D9D9E0E0E0D6D6D6D4D4D4D5D5
              D5DEDEDEEAEAEAF0F0F0F0F0F0EFEFEFE9E9E9E0E0E0D5D5D5D3D3D3D5D5D5DD
              DDDDE1E1E1767676393939939393FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFADADAF08083B121264B3B3D7BDBDDEACACD5A6A6D1A9A9
              D5BDBDDED1D1E8DCDCEDE0E0F1DCDCEFD0D0E9BEBEDEA9A9D5A6A6D1ABABD3B8
              B8DCC0C0DE24247700003B88888EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFADADAF08083B121264B3B3D7BDBDDEACACD5A6A6D1A9A9
              D5BDBDDED1D1E8DCDCEDE0E0F1DCDCEFD0D0E9BEBEDEA9A9D5A6A6D1ABABD3B8
              B8DCC0C0DE24247700003B88888EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFA8A8B70F0F784A4AA2D0D0E6F7F7FBEEEEF7E9E9
              F4E5E5F2E3E3F2E3E3F2E4E4F2E3E3F2E3E3F1E5E5F2E8E8F4ECECF6F7F7FBDD
              DDEE6363AF0202778787A1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFAEAEAE424242686868D6D6D6F8F8F8F0F0F0ECEC
              ECE8E8E8E7E7E7E7E7E7E8E8E8E6E6E6E5E5E5E8E8E8EBEBEBEFEFEFF8F8F8E1
              E1E17A7A7A3A3A3A919191FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFA8A8AA0F0F3E161668ABABD0EFEFF7DEDEEFD5D5
              E9CECEE6CBCBE6CBCBE6CCCCE6CBCBE6CBCBE4CECEE6D3D3E9DADAEDEFEFF7C0
              C0DE27277902023A87878DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFA8A8AA0F0F3E161668ABABD0EFEFF7DEDEEFD5D5
              E9CECEE6CBCBE6CBCBE6CCCCE6CBCBE6CBCBE4CECEE6D3D3E9DADAEDEFEFF7C0
              C0DE27277902023A87878DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C5CD2F2F7D1A1A888686C0D6D6E9F5F5
              FAFFFFFFFFFFFFFFFFFFFDFDFEFEFEFFFFFFFFFFFFFFF8F8FBDEDEEE9797CA2A
              2A911E1E79ABABB8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8C8C8535353474747959595DADADAF7F7
              F7FFFFFFFFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFFAFAFAE2E2E2A5A5A550
              5050494949B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C5C62F2F4D02024A484892B4B4D5EBEB
              F5FEFEFEFEFEFEFEFEFEFAFAFCFCFCFEFEFEFEFEFEFEF1F1F7C2C2DE5B5BA107
              07541E1E44ABABADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C5C62F2F4D02024A484892B4B4D5EBEB
              F5FEFEFEFEFEFEFEFEFEFAFAFCFCFCFEFEFEFEFEFEFEF1F1F7C2C2DE5B5BA107
              07541E1E44ABABADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFF08787A51C1C780D0D7E3F3F
              9C7878B8A0A0CDB6B6D9C1C1DFB9B9DBA4A4CF8080BC4949A11414851212776F
              6F96E1E1E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9595954848483F3F3F5E5E
              5E8A8A8AABABABBFBFBFC9C9C9C2C2C2AEAEAE90909066666644444442424281
              8181E1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF87878F1C1C4200003F1010
              613A3A866666A68383B99393C38787BD6B6BA941418C15156701014712123F6F
              6F7AE1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF87878F1C1C4200003F1010
              613A3A866666A68383B99393C38787BD6B6BA941418C15156701014712123F6F
              6F7AE1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E9A4A4B86363
              9329297A0A0A7703037803037601017709097822227759598C9696ADDCDCDFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADADAD7878
              784F4F4F3D3D3D3A3A3A3A3A3A3A3A3A3E3E3E494949717171A0A0A0DDDDDDFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7A4A4A96363
              722929480A0A3B03033A00003801013909093C22224459596996969BDCDCDCFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7A4A4A96363
              722929480A0A3B03033A00003801013909093C22224459596996969BDCDCDCFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF6F6F7DDDDE1C4C4CCB5B5BFC0C0C8D9D9DDF2F2F3FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF6F6F6DEDEDEC7C7C7B8B8B8C3C3C3DADADAF2F2F2FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF6F6F6DDDDDDC4C4C5B5B5B6C0C0C1D9D9D9F2F2F2FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFF6F6F6DDDDDDC4C4C5B5B5B6C0C0C1D9D9D9F2F2F2FFFFFFFFFFFFFFFFFFFF
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
            NumGlyphs = 4
            ParentFont = False
            OnClick = btCancelarClick
            ExplicitHeight = 44
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 440
          Height = 52
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object btGravar: TSpeedButton
            AlignWithMargins = True
            Left = 337
            Top = 3
            Width = 100
            Height = 46
            Align = alRight
            Caption = '&Gravar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Glyph.Data = {
              36100000424D3610000000000000360000002800000020000000200000000100
              20000000000000100000C40E0000C40E00000000000000000000B29496FF662C
              2DFF662C2DFF662C2DFF88605FFF928282FF928282FF928282FF928282FF9282
              82FF928282FF928282FF928282FF928282FF928282FF928282FF928282FF9282
              82FF928282FF928282FF928282FF928282FF928282FF928282FF928282FF9282
              82FF928282FF88605FFF895858FF895858FFB29496FFFFFFFFFF88605FFFCBA2
              99FFCBA299FFCBA299FFCBA299FF693A3AFFB4ADACFFB4ADACFFB4ADACFFB4AD
              ACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4AD
              ACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4ADACFFB4AD
              ACFF693A3AFF976869FFA66E6DFFA5746EFFA07472FFFFFFFFFF8C5F61FFCBA2
              99FFB58E83FFB58E83FFB18182FF693A3AFFECECEBFFE4E4E3FFE4E4E3FFE4E4
              E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4
              E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE7E7
              E6FF693A3AFFB18182FFC89387FFCBA299FFA07472FFFFFFFFFF976869FFCBA2
              99FF4E4D4CFF424242FFB18182FF693A3AFFECECEBFFE4E4E3FFE4E4E3FFE4E4
              E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4
              E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE7E7
              E6FF693A3AFFB18182FFBD857CFFCBA299FFA07472FFFFFFFFFF976869FFCBA2
              99FF554E4DFF4D4645FFB18182FF693A3AFFECECEBFFE5E5E4FFE5E5E4FFE5E5
              E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5
              E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFE5E5E4FFECEC
              EBFF693A3AFFB18182FFBD857CFFCBA299FFA07472FFFFFFFFFF8C5F61FFCBA2
              99FFAA7E73FFAA7E73FFB18182FF693A3AFFEEEEEDFFE7E7E6FFE7E7E6FFE7E7
              E6FFE7E7E6FFE7E7E6FFE7E7E6FFE7E7E6FFE7E7E6FFE8E7E7FFE7E7E6FFE7E7
              E6FFE7E7E6FFE7E7E6FFE7E7E6FFE7E7E6FFE7E7E6FFE7E7E6FFE7E7E6FFECEC
              EBFF693A3AFFB18182FFB67D77FFCBA299FFA07472FFFFFFFFFF8C5F61FFCBA2
              99FFBD857CFFBD857CFFB18182FF693A3AFFEEEEEDFFE9E8E8FFE9E8E8FFE9E8
              E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8
              E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFEEEE
              EDFF693A3AFFB18182FFB67D77FFCBA299FFA07472FFFFFFFFFF8C5F61FFCBA2
              99FFB67D77FFB67D77FFB18182FF693A3AFFF5F5F5FFEBEAEAFFEBEAEAFFEBEA
              EAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEA
              EAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFEBEAEAFFF0EF
              EFFF693A3AFFB18182FFB67D77FFCBA299FFA07472FFFFFFFFFF8C5F61FFCBA2
              99FFB67D77FFB67D77FFB18182FF693A3AFFF5F5F5FFECECEBFFECECEBFFECEC
              EBFFECECEBFFECECEBFFECECEBFFECECEBFFECECEBFFECECEBFFECECEBFFECEC
              EBFFECECEBFFECECEBFFECECEBFFECECEBFFECECEBFFECECEBFFECECEBFFF5F5
              F5FF693A3AFFB18182FFB07772FFCBA299FF976869FFFFFFFFFF8C5F61FFCBA2
              99FFB07772FFB07772FFB18182FF693A3AFFF5F5F5FFEEEEEDFFEEEEEDFFEEEE
              EDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEE
              EDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFEEEEEDFFF5F5
              F5FF693A3AFFB18182FFB07772FFCBA299FF976869FFFFFFFFFF8C5F61FFC396
              90FFB07772FFA66E6DFFB18182FF693A3AFFF5F5F5FFF0EFEFFFF0EFEFFFF0EF
              EFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EF
              EFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF5F5
              F5FF693A3AFFB18182FFA66E6DFFCBA299FF976869FFFFFFFFFF8C5F61FFC396
              90FFA66E6DFFA66E6DFFB18182FF693A3AFFFFFFFFFFF0EFEFFFF0EFEFFFF0EF
              EFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EF
              EFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF0EFEFFFF5F5
              F5FF693A3AFFB18182FFA36768FFC39690FF976869FFFFFFFFFF8C5F61FFC396
              90FFA66E6DFFA66E6DFFB18182FF693A3AFFFFFFFFFFF5F5F5FFF5F5F5FFF5F5
              F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
              F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFFFFF
              FFFF693A3AFFB18182FFA36768FFC39690FF976869FFFFFFFFFF8C5F61FFC396
              90FFA36768FFA36768FFB18182FF693A3AFFFFFFFFFFF5F5F5FFF5F5F5FFF5F5
              F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
              F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFFFFF
              FFFF693A3AFFB18182FFA36768FFC39690FF976869FFFFFFFFFF8C5F61FFC396
              90FFA36768FFA06365FFB18182FF693A3AFFFFFFFFFFD5CECEFFD5CECEFFD5CE
              CEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CE
              CEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFD5CECEFFFFFF
              FFFF693A3AFFB18182FFA06365FFC39690FF976869FFFFFFFFFF8C5F61FFB98A
              89FFA06365FFA06365FF935D5CFF928282FF884A4EFF884A4EFF884A4EFF884A
              4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A
              4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A4EFF884A
              4EFF928282FF986668FF975A5FFFB98A89FF976869FFFFFFFFFF8C5F61FFB98A
              89FF975A5FFF975A5FFF975A5FFF8D5155FF8D5155FF8D5155FF8D5155FF8D51
              55FF8D5155FF8D5155FF8D5155FF8D5155FF8D5155FF8D5155FF8D5155FF8D51
              55FF8D5155FF8D5155FF8D5155FF8D5155FF8D5155FF8D5155FF8D5155FF8D51
              55FF884A4EFF975A5FFF915258FFB98A89FF986668FFFFFFFFFF8C5F61FFB98A
              89FF975A5FFF915258FF915258FF915258FF915258FF915258FF915258FF9152
              58FF915258FF915258FF915258FF915258FF915258FF915258FF915258FF9152
              58FF915258FF915258FF915258FF915258FF915258FF915258FF915258FF9152
              58FF915258FF915258FF915258FFB98A89FF976869FFFFFFFFFF8C5F61FFB98A
              89FF975A5FFF915258FF915258FF975E64FFA06C75FFA06C75FFA06C75FFA06C
              75FFA06C75FFA06C75FFA06C75FFA06C75FFA06C75FFA06C75FFA06C75FFA06C
              75FFA06C75FFA06C75FFA06C75FFA06C75FFA06C75FFA06C75FF915258FF9152
              58FF915258FF915258FF915258FFB98A89FF986668FFFFFFFFFF8C5F61FFB98A
              89FF915258FF884A4EFF975E64FFA06C75FF975E64FF975E64FF975E64FF8C6C
              70FF8C787BFF8C787BFF8C787BFF8C787BFF8C787BFF8C787BFF8C787BFF8C78
              7BFF8C787BFF8C787BFF8C787BFF8C787BFF8C787BFF8C787BFFA06C75FF884A
              4EFF915258FF915258FF884A4EFFB18182FF986668FFFFFFFFFF8C5F61FFB98A
              89FF915258FF915258FFA06C75FF8D5155FF975A5FFF975A5FFF985659FF7E6D
              6DFFE4E7E7FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E4E3FFE4E7
              E7FFE4E7E7FFE4E7E7FFE7E7E6FFE4E4E3FFE4E7E7FF969393FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFB98A
              89FF915258FF87464FFFA06C75FF935D5CFFA06365FFA06365FFA06365FF8C78
              7BFFE4E7E7FFEBEAEAFFE9E8E8FFE9E8E8FFE9E8E8FFE9E8E8FFEEEEEDFF935D
              5CFF935D5CFF935D5CFF935D5CFFCFCBCBFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FF975E64FFA36768FFA36768FFA36768FF8C78
              7BFFE4E7E7FFE9E8E8FFE8E7E7FFE8E7E7FFE8E7E7FFE8E7E7FFEEEEEDFF935D
              5CFF99746BFF99746BFF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FF935D5CFFA66E6DFFA66E6DFFA36768FF8C78
              7BFFE4E7E7FFE9E8E8FFE8E7E7FFE8E7E7FFE8E7E7FFE8E7E7FFEEEEEDFF935D
              5CFF976869FFA5746EFF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FF986668FFB07772FFB07772FFA66E6DFF8C78
              7BFFE4E7E7FFE9E8E8FFE8E7E7FFE8E7E7FFE8E7E7FFE8E7E7FFEEEEEDFF935D
              5CFFA5746EFFA5746EFF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FFA66E6DFFB07772FFB07772FFB07772FF9282
              82FFE4E7E7FFE9E8E8FFE8E7E7FFE8E7E7FFE8E7E7FFE8E7E7FFEEEEEDFF935D
              5CFFA5746EFFB18182FF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FFA66E6DFFBD857CFFB67D77FFB67D77FF9282
              82FFE4E7E7FFE9E8E8FFE8E7E7FFE8E7E7FFE8E7E7FFE8E7E7FFEEEEEDFF935D
              5CFFAA7E73FFB18182FF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FFA5746EFFBD857CFFBD857CFFBD857CFF9282
              82FFE4E7E7FFE9E8E8FFE8E7E7FFE8E7E7FFE8E7E7FFE8E7E7FFEEEEEDFF935D
              5CFFAA7E73FFB98A89FF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF8C5F61FFFFFFFFFF8C5F61FFA06C
              75FF915258FF884A4EFFA06C75FFA5746EFFC89387FFBD857CFFBD857CFF9282
              82FFE4E7E7FFE8E7E7FFE5E5E4FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FF935D
              5CFFAA7E73FF99746BFF935D5CFFC2BCBAFFF5F5F5FF9E9697FF895159FFA06C
              75FF87464FFF87464FFF87464FFFA9797DFF976869FFFFFFFFFF8C5F61FFA06C
              75FF915258FF87464FFFA06C75FFB67D77FFC89387FFC89387FFC89387FF9282
              82FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FF935D
              5CFF935D5CFF935D5CFF935D5CFFE4E7E7FFE4E7E7FF9E9697FF895159FFA06C
              75FF87464FFF87464FFFA9797DFF976869FFD4C3C4FFFFFFFFFF895858FFA06C
              75FFA06C75FFA06C75FFA06C75FFAA7E73FFCD9786FFCD9786FFCD9786FF9282
              82FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E7
              E7FFE4E7E7FFE4E7E7FFE4E7E7FFE4E4E3FFECECEBFF9E9697FF895159FFA06C
              75FFA9797DFFA9797DFF976869FFE4DADAFFFFFFFFFFFFFFFFFFC4AEAFFF9B74
              78FF8C5F61FF8C5F61FF8C5F61FF8C5F61FF976869FF976869FF986668FF7E6D
              6DFF969393FF969393FF969393FF969393FF969393FF969393FF969393FF9693
              93FF969393FF969393FF969393FF969393FF969393FF7E7879FF8C5F61FF8C5F
              61FF8C5F61FF8C5F61FFE4DADAFFFFFFFFFFFFFFFFFFFFFFFFFF}
            ParentFont = False
            OnClick = btGravarClick
            ExplicitLeft = 12
            ExplicitTop = 8
            ExplicitHeight = 36
          end
        end
      end
    end
  end
  object pnVisualizacao: TPanel
    Left = 0
    Top = 0
    Width = 897
    Height = 714
    Align = alClient
    TabOrder = 0
    object gdPesquisa: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 92
      Width = 889
      Height = 552
      Align = alClient
      DataSource = ds_Pesquisa
      DrawingStyle = gdsGradient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnTitleClick = gdPesquisaTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Width = 120
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
          Expanded = False
          FieldName = 'CULTIVAR'
          Title.Caption = 'Cultivar/Variedade'
          Width = 250
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SELECAOPOSITIVA'
          Title.Alignment = taCenter
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CODIGOSELECAOCAMPO'
          Title.Alignment = taCenter
          Width = 135
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Alignment = taCenter
          Visible = True
        end>
    end
    object pnBotoesVisualizacao: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 650
      Width = 889
      Height = 60
      Align = alBottom
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object gpBotoes: TGridPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 881
        Height = 52
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
          Width = 440
          Height = 52
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object btAlterar: TSpeedButton
            AlignWithMargins = True
            Left = 231
            Top = 3
            Width = 100
            Height = 46
            Align = alRight
            Caption = '&Alterar'
            Glyph.Data = {
              F6060000424DF606000000000000360000002800000018000000180000000100
              180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFE8F7E8E3F4E2F8FCF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFEFB
              CFECCD82D47F4CCC493CCB393ACA3650C84C83C57FC2DEC0FBFCFAFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFEAF7EA76CD724ED54C6FE96E76E7755EDF5D2CD12B2DCD2B51D34F93D390
              82B87EF8FBF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFD1ECCF7BCD7786E0846BC96750AE4B74B86F8BC98851C94D2C
              CB2A2FC62D47CB4590CC8C7CB577FBFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFD5EED36CC26855BC504DAB47ADD3AAEEF5EDFEFF
              FEFFFFFFF3FAF267CA6330C82D5CD559A0E59E51A44AB6D7B3FFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF55AB4F41A33A5BAA55E5F0E4
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEEACC42CD3E76E1738FE68D71BC6C5BA4
              54FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6F1E6A4
              CCA0E9F3E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFEFC58CB5375E473
              81E57E94D091439B3CCCE2CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FAF4ECF6
              EBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF73CC6F6DE76B83E681A4E0A269B66391C78DB4D5B1EFF6EFFFFFFFFFFFFF
              FFFFFFA5DCA279C4759AC596FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFAFDFA7CCE786AE96988E886A4EEA3BDF2BC6AB864439A3BA8
              CDA4FFFFFFFFFFFFF6FDF63DCC396ADF6866B261BBD9B9FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFABDDA849C64452DB4F7EE97C8CEA8A91EB8FA3E0
              A046A13E5AA453F1F7F0FFFFFFFFFFFFA4E0A224D9212ECF2C8BDC895CA656E8
              F2E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3EED246CF4286EA848EEB8C
              90EB8EA9EFA86DBA68449D3CAED0ABFFFFFFFFFFFFF3FBF34BD14726D4252ACE
              283CCE3A8ECF8B7FB87AFEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF92
              D48F5FE15D91EC9094ED93AAE1A847A23F5CA455F4F8F3FFFFFFFFFFFFAAE6A9
              24D82227D2262ACE282DCA2B65D46371B96CB4D5B1FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFF4FAF360C95C7DEC7BAFF1AE6AB865449E3DB4D3B1FFFFFFFF
              FFFFF4FCF34BD34923DB2227D3262ACE2856D4547FD77C9AD99751AA4CEAF4E9
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCEACA4CD248AAE0A848A2405EA5
              58FBFDFBFFFFFFFFFFFFB1E4AF2DCC2926D62327D3252ECF2C8DD48A4AA34362
              A75C94C391E4F0E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFD9AD397
              6EC96A4AAD43B7D5B4FFFFFFFFFFFFFFFFFFADDAAA55A74F35BD3027D3252ACE
              2887D384449C3CC1DCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFF7FBF7B6D5B48ABE86F9FCF9FFFFFFFFFFFFFFFFFFFFFFFFF2F8F1
              6DD16A25D7233DD33BA3E8A149A2429EC99BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFCFEFCFCFEFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFADE1AB2FDE2D72E1708CE78A91CE8C63A85CFAFCFAFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFDFEFD89C6846EB168B8D7B6FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2FAF143CF407CE67A84E782A9EDA781
              C17EADD1AAFFFFFFFFFFFFFFFFFFFFFFFFD4EED37EC47A3EAA38459F3EC3DEC1
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA2DEA053E2
              5189EA888DEA8CA7EEA672CE6EA9D9A6DCF0DBB7E1B489D18680CC7C48BB4342
              A63BAED3ABFEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFF9FCF983CE809DE49B93ED9294ED938FEE8E71E06E63DB608AE48880DD
              7E3EC1393EA537B7D7B4FEFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFAA4CEA0A3D5A0ACE7AAACEBABA8E4A6
              91D68E4CBD4738B03372B76DDDEDDCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAEAD99E
              C89A71B06C5DA75769AD6498C994D6E8D4FBFDFBFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            OnClick = btAlterarClick
            ExplicitLeft = 12
            ExplicitTop = 8
            ExplicitHeight = 42
          end
          object btNovo: TSpeedButton
            AlignWithMargins = True
            Left = 125
            Top = 3
            Width = 100
            Height = 46
            Align = alRight
            Caption = '&Novo'
            Glyph.Data = {
              F6060000424DF606000000000000360000002800000018000000180000000100
              180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8C4B0C4652EC6662FC86830CA69
              30CC6B31CE6C31EDC8B2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2632EF7C183
              F5A543F6A440F7A641F8A842F6A645D06E32FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFC2632EFAC889E58539E78A3DE98E40EF9844F9AA49D06E32FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFC2632EFAC889E07C38E3823DE68841ED9546F9AB4BD0
              6E32FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1632EFAC889E07C39E3833DE689
              42ED9547F9AB4CCF6D32FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1622EFAC889
              E07C39E3833DE68942ED9547F9AB4CCE6D31FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFC1622EFAC889E07C38E3823DE68841ED9546F9AB4BCD6C31FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFC0612DFAC889DF7B37E2803CE58640EC9344F9AA49CC
              6B31FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1BFAEB25729
              C3682DC4692DC66B2EC76C2FC96E2FCB6F30CC7031FAC889DE7936E17E3AE484
              3EEB9142F8A946D67A37D87B38D97C38DA7D39DA7E3ADB7E39DB7E39D16F32EE
              C9B2AF5529F4C18AF1A44FF2A24AF2A146F19B3AF19C39F29D3AF39E3BF8B96C
              DD7634DF7B38E2813CE98D40F8A843F8A946F9AB49F9AB4CFAAC4DFAAC4EFAAC
              4DF9AB4BF6A647CF6D32AF5428F8C890D97639DA7739DB793ADD7A3ADC7733DC
              742DDE772FE07B32DC7332DE7836E07D39E4843DE98E40EB9143EC9445ED9647
              EE9748EE9849EE9748ED9647F8A945CD6C31AE5328F8C890D16632D26833D36A
              34D56D36D66F37D87037D86F32D86D2EDA7030DC7533DE7936E07D39E2813CE4
              853FE68841E78A43E78B44E88C44E78B43E68942F7A742CB6A30AD5328F8C890
              D16532D26733D36934D46B35D66E37D77038D9733ADA773CDB773ADC7738DD78
              37DE7937E07C39E17F3BE3823DE4843EE4853FE4853FE4853FE3833EF6A642C9
              6930AC5228F8C890DC875AD77747D87948D97B49DA7D4ADB7F4BDD814CDE844E
              DA773CDC7A3EDD7D40DF7F41E08143E18141E28342E28443E38544E38543E386
              45E38645F6A94AC7672FAB5127F3C18AF8C890F8C890F8C890F8C990F9C990F9
              C98FF9C98FF9CA90D9743ADA773CDC793EE38642F8BE76FACB90FACB8FFACB8F
              FACB8FFACC90FACB8FFACB8FF7C589C5652FDFBDAEAC5228AE5328AF5529B156
              29B25729B4582AB5592AB75A2BF9C98FD87239D9743ADA763CE18340F4A74BC0
              612DC0622DC1622EC2632EC2632EC3642EC3642EC3642EE8C5B0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5592AF9C98FD67038D77139D973
              3AE0813FF3A64BBE602DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4582AF9C990
              D56D37D66F38D77038DE7E3DF3A54BBC5E2CFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFB35729F8C990D36B36D56C36D66E37DD7C3CF3A44BBA5D2CFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFB15629F8C890D36934D36A35D46B36DC7A3BF2A34BB8
              5C2BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF5529F8C890D16733D26834D369
              34DB783AF2A34BB65A2BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB25B2FF8C990
              E1905EDB7F4ADB7F4AE18B4FF3AC5DB4582AFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFB1592EF4C28CF8C890F8C990F8C990F8C890F4C18AB25729FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFDFBDAEAB5227AD5328AE5328AE5428AF5529B05529E2
              BFAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            OnClick = btNovoClick
            ExplicitLeft = 12
            ExplicitTop = 8
            ExplicitHeight = 42
          end
          object btMenu: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 60
            Height = 46
            Align = alLeft
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
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEDEEDCDCDCFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFDEDEDE29292C201F23979698FDFDFD69696B3938
              3E39383E39383E39383E39383E39383E39383E39383E39383E39383E39383E39
              383E4D4C4FE7E7E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFAAAAAB201F23201F23585659EEEDEE201F23201F
              23201F23201F23201F23201F23201F23201F23201F23201F23201F23201F2320
              1F23201F23B4B3B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFEFEFEF4F4F52313133BDBCBDFFFFFFA09FA17272
              7572727572727572727572727572727572727572727572727572727572727572
              7275838284F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA6A5A788888AEBEBEBFFFFFFE7E6E7C7C7
              C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7
              C7C8D8D7D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFBDBCBD201F23201F236A6A6CF5F5F62B2A30201F
              23201F23201F23201F23201F23201F23201F23201F23201F23201F23201F2320
              1F23201F23C9C9CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFBCBBBD201F23201F2369696BF5F5F62B2A30201F
              23201F23201F23201F23201F23201F23201F23201F23201F23201F23201F2320
              1F23201F23C9C9CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA3A3A4868688EAEAEAFFFFFFE6E6E6C7C7
              C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7C7C8C7
              C7C8D7D7D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF0F0F0555558383739C0C0C1FFFFFFA4A4A57776
              7877767877767877767877767877767877767877767877767877767877767877
              767888888AF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFAAAAAB201F23201F23585659EEEDEE201F23201F
              23201F23201F23201F23201F23201F23201F23201F23201F23201F23201F2320
              1F23201F23B4B3B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFDBDBDC2A292C201F23939395FDFDFD6464663837
              3938373938373938373938373938373938373938373938373938373938373938
              373947474AE6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAD7D7D7FEFEFEFFFFFFFFFFFFFFFF
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
            PopupMenu = PopupMenu
            OnClick = btMenuClick
          end
          object btExcluir: TSpeedButton
            AlignWithMargins = True
            Left = 337
            Top = 3
            Width = 100
            Height = 46
            Align = alRight
            Caption = '&Excluir'
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
            OnClick = btExcluirClick
            ExplicitLeft = 340
            ExplicitTop = 6
          end
        end
        object Panel9: TPanel
          Left = 440
          Top = 0
          Width = 441
          Height = 52
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object btFechar: TSpeedButton
            AlignWithMargins = True
            Left = 109
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
          object btExportar: TSpeedButton
            AlignWithMargins = True
            Left = 338
            Top = 3
            Width = 100
            Height = 46
            Align = alRight
            Caption = 'E&xportar'
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFBFBFBF2F2F2EAEAEAE9E9E9E9E9E9E9E9E9E9E9E9E9E9
              E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
              E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9EAEAEAF2F2F2FBFBFBFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFF2F2F2D4D4D4C0C0C0BCBCBCBCBCBCBCBCBCBCBCBCBCBC
              BCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBC
              BCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCC0C0C0D4D4D4F2F2F2FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFEAEAEABB964CB67E0EB47B09B47A07B47A07B47A07B47A
              07B47A08B47B08B47A08B47A07B47A07B47A08B47B08B47A08B47A07B47A07B4
              7A08B47B08B47A08B47A07B47A07B47B09B67E0EBB964CEAEAEAFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B67E0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB67E0EE9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47B09FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFD5BDA2FFFFFFFFFFFFFFFFFFFFFFFFD5BDA2FFFFFFFFFFFFFFFFFFFF
              FFFFD5BDA2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB47B09E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A07FFFFFFFFFFFFFFFFFCFFFFFCFFFFFCFFFF
              FDFFFFFFD6BDA0FFFFFFFFFFFDFFFFFDFFFFFFD6BDA0FFFFFFFFFFFDFFFFFDFF
              FFFFD6BDA0FFFFFFFFFFFDFFFFFCFFFFFFFFFFFFB47A07E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFF
              FFFFFFFFD7BEA2FFFFFFFFFFFFFFFFFFFFFFFFD7BEA2FFFFFFFFFFFFFFFFFFFF
              FFFFD7BEA2FFFFFFFFFFFFFFFFFEFFFFFFFFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47B08FFFFFFD5BB9CD6BC9CD6BC9CD6BC9CD6BC
              9DD8BFA0D9C1A3D8BFA0D6BC9DD6BC9DD8BFA0D9C1A3D8BFA0D6BC9DD6BC9DD8
              BFA0D9C1A3D8BFA0D6BC9DD6BC9CD5BB9CFFFFFFB47B08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFFFFAFFFFF9FFFFF9FFFFF9FFFF
              FBFFFFFED6BEA0FFFFFEFFFFFBFFFFFBFFFFFED6BEA0FFFFFEFFFFFBFFFFFBFF
              FFFED6BEA0FFFFFEFFFFFBFFFFF9FFFFFAFFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFFCF3FEFBF1FEFBF1FEFBF1FFFC
              F2FFFFF7D5BA99FFFFF7FFFCF2FFFCF2FFFFF7D5BA99FFFFF7FFFCF2FFFCF2FF
              FFF7D5BA99FFFFF7FFFCF2FEFBF1FFFCF3FFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFFBF0FEFAEEFEFAEEFEFAEEFFFB
              EFFFFEF4D5B999FFFEF4FFFBEFFFFBEFFFFEF4D5B999FFFEF4FFFBEFFFFBEFFF
              FEF4D5B999FFFEF4FFFBEFFEFAEEFFFBF0FFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFFDF1FFFCF1FFFDF1FFFDF1FFFD
              F2FFFFF6D6BB9AFFFFF6FFFDF2FFFDF2FFFFF6D6BB9AFFFFF6FFFDF2FFFDF2FF
              FFF6D6BB9AFFFFF6FFFDF2FFFCF1FFFDF1FFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47B08FFFFFFD4B792D4B893D5B895D5B895D5B8
              95D7BB98D8BD9BD7BB98D5B895D5B895D7BB98D8BD9BD7BB98D5B895D5B895D7
              BB98D8BD9BD7BB98D5B895D4B893D4B792FFFFFFB47B08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFFBEAFFFAEAFFFBEBFFFBEBFFFB
              ECFFFEF0D6BA96FFFEF0FFFBECFFFBECFFFEF0D6BA96FFFEF0FFFBECFFFBECFF
              FEF0D6BA96FFFEF0FFFBECFFFAEAFFFBEAFFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFF7E4FEF6E3FEF6E3FEF6E3FFF7
              E4FFFAE9D5B691FFFAE9FFF7E4FFF7E4FFFAE9D5B691FFFAE9FFF7E4FFF7E4FF
              FAE9D5B691FFFAE9FFF7E4FEF6E3FFF7E4FFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B47A08FFFFFFFFF6E1FEF5E1FFF5E1FFF5E1FFF6
              E2FFF9E7D5B590FFF9E7FFF6E2FFF6E2FFF9E7D5B590FFF9E7FFF6E2FFF6E2FF
              F9E7D5B590FFF9E7FFF6E2FEF5E1FFF6E1FFFFFFB47A08E9E9E9FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFE9E9E9B57A08FFFFFFFFF7E1FFF7E2FFF8E3FFF8E3FFF8
              E4FFFBE7D7B890FFFBE7FFF8E4FFF8E4FFFBE7D7B890FFFBE7FFF8E4FFF8E4FF
              FBE7D7B890FFFBE7FFF8E4FFF7E2FFF7E1FFFFFFB47A08E9E9E9FBFBFBF2F2F2
              EAEAEAE9E9E9E9E9E9D8D8D8BD7B08FFFFFFD7B48AD7B58CD8B68ED8B68ED8B6
              8ED9B890D9BA92D6B78FD4B58CD4B58CD5B78ED7B991D5B78ED4B58CD4B58CD5
              B78ED7B991D5B78ED4B58CD3B48AD3B288FFFFFFB47B09E9E9E9F2F2F2D4D4D4
              C0C0C0BCBCBCBCBCBCB7B7B7CC7C06FFFFFFFFFEE8FFFEE9FFFEEAFFFEEAFFFF
              EBFFFFEDE1BA94FFFAE4FFF6DFFFF6DFFFF9E2D5B68EFFF9E2FFF6DFFFF6DFFF
              F9E2D5B68EFFF9E2FFF6DFFFF5DDFFF5DCFFFFFFB47A08E9E9E9EAEAEA469865
              058134007E2F007E2E007D2E007A2A00752200741F0074200075220075220076
              230077264A9050FFF8E0FFF2D8FEF2D7FFF5DBD4B389FFF5DBFEF2D7FEF2D7FF
              F5DBD4B389FFF5DBFEF2D7FDF0D5FEF1D5FFFFFFB47A08E9E9E9E9E9E9068134
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF007928FFF9DFFFF1D5FEF1D4FFF4D8D4B287FFF4D8FEF1D4FEF1D4FF
              F4D8D4B287FFF4D8FEF1D4FDEFD2FEF0D2FFFFFFB47A08E9E9E9E9E9E9017F30
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00752400792A007B
              2D017F31007D2FFFFCE1FFF4D6FFF3D5FFF6D9D7B487FFF6D9FFF3D5FFF3D5FF
              F6D9D7B487FFF6D9FFF3D5FFF2D3FFF2D2FFFFFFB47B09E9E9E9E9E9E9017F30
              FFFFFF00741F007826007828007929007A2A007A2B00792B52CB7E55CC7F70D7
              95098136018031F5BC8CE6B681E3B680E1B783E0B887E1B783E3B680E3B680E1
              B783E0B887E1B783E3B680E3B47EDEB27CFFFFFFB57B09E9E9E9E9E9E9017F30
              FFFFFF0075226FD3964DC57C50C67F53C9820A7F3550C57E4DC37C74D49A077E
              339EE6B9057F2C64CFFF5ACAFF56C9FF51CAFFEBB97F51CAFF56C9FF56C9FF51
              CAFFEBB97F51CAFF56C9FF56C8FF4DC5FFFFFFFFB67B08E9E9E9E9E9E9007E2F
              FFFFFFFFFFFF0074227CD2A14DC07D0A7E354DC07D48BD797BD1A000792A007A
              2A007C2C017D2862CCFF58C7FF55C6FF4FC6FFE9B5794FC6FF55C6FF55C6FF4F
              C6FFE9B5794FC6FF55C6FF54C5FF4CC3FFFFFFFFB67C09EAEAEAE9E9E9007E2E
              FFFFFFFFFFFFFFFFFF007B2C097F3448B87843B6758AD3AA007A2AFFFFFFFFFF
              FFFFFFFF007A26FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB67E0EF2F2F2E9E9E9007E2E
              FFFFFFFFFFFFFFFFFF007B2B41B2753EB07296D6B4067F31007C2CFFFFFFFFFF
              FFFFFFFF007B2CC67C07BA7C07B67B07B67B08B57B08B67B08B67B07B67B07B6
              7B08B57B08B67B08B67B07B67B07B67C09B67E0ECBA65CFBFBFBE9E9E9007E2F
              FFFFFFFFFFFF00752031A86B34A96DA0D8BB047E3037AC7133A96D007521FFFF
              FFFFFFFF007E31E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9017F30
              FFFFFF00751FB2DFCCB5DFCDA4D6C0007927007A29A6D8C2A6D8C2A3D7C10075
              20FFFFFF007F31E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA028031
              FFFFFF007621007926007926007520FFFFFFFFFFFF0075210079260079270076
              22FFFFFF018031EAEAEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2078235
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF068235F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB57A875
              068234028031027F31027F31017F30007E2F007E2F017F30027F31027F310280
              3106823457A875FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            OnClick = btExportarClick
            ExplicitLeft = 321
            ExplicitTop = -2
            ExplicitHeight = 44
          end
          object btEstimativa: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 100
            Height = 46
            Align = alLeft
            Caption = '&Estimativa'
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFE2E2E25957577B7777807C7B837F7E8582818885848B87868C88878C88
              878C88878C88878C88878C88878C88878C88878C88878C88878C88878B878688
              8483848180817E7D7D7978615E5EB8B7B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7A7979928D8C9993929993929993929993929993929993929993929993
              9299939299939299939299939299939299939299939299939299939299939299
              9392999392999392999392989291625F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7572729A94939B95949791949791949791939B95949892919791909791
              909B95949A94939791909791909B95949A94938984838983828C86859B95948E
              89888983828983829993929B95946D6A6AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7575759D97968F8A961D1D891D1D8A2424889E989766655F7777716D6D
              669893916A69656D6D666D6D668A86837A77760E0E0E0D0D0D1514149A949319
              19190C0C0C0B0B0B6C68679E98976F6C6CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF787575A099998E889A3F3FAD3535A826269BA29B9B7A797393918B8583
              7C9E989678757185837C85837C95908C7F7A7A1F1E1D4A49482423229E97971E
              1D1D101010101010706C6CA19A9A726D6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF787575A29C9B938D9F2323B52323B52B2BAEA49E9D8D88859B95919B95
              91A49E9D847F7E9B95919B9591A29C9A858180353331353331393735A09C9B26
              252419181719181774706FA39D9C74706FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF797878A59F9EA6A09FA39DA1A39DA1A49EA1A6A09FA7A1A0A8A2A0A8A2
              A0A6A09FA7A1A0A8A2A0A8A2A0A7A09FA39D9C918C8A908B8B928D8CA6A09F3D
              3B3A3A393821201F797575A6A09F757172FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7B7979A7A1A08A8584302F2F302F2F303030A8A2A16F6E6C7372717372
              71A7A1A07C7977737271737271A09B9BA6A1A07271707372716F6D6CA8A2A135
              33322A28272A28277E7A79A8A2A1777474FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7C7979AAA4A3807C7B1D1C1B2F2E2D252423ACA6A57C79748F8D878381
              7AA6A09E7D7B7683817A918F89989590A7A1A083817A9A98937E7C76ACA6A53C
              3B3932312F32312F837F7DABA5A47A7575FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7E7B7BADA6A688838332312F32312F383735AFA8A88E8A86A5A19C9894
              8EADA7A68A868498948EA4A19BA6A19EACA5A498948EA7A49E928E89B0A9A943
              42403B39373B3937888483AEA7A77B7676FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7F7B7EAFA9A8A09A99726F6D726F6D73706EB1ABAAA29D9AA6A19FA6A1
              9FB4AFAFA19D9BA6A19FA6A19FBCB7B5B1ABAAA6A19FA6A19FA19C99B1ABAA75
              7271726F6D726E6DA29D9BB0AAA97D7979FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF827E7EB2ABABA39E9E5957575A57575D5B5BB3ACAC8A85858885858885
              85B2ACAC999494888585888585B0AAAAB3ACAC878484878484898585B3ACAC62
              5E5E5A57575A5757A09999B3ACAC7F7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF838080B4AEAD8783811E1D1B3433312D2C2AB6B0AF7C7A739291898180
              77ADA9A7827F7B8988808180779C9894B0ABA98180779190887D7C75B6B0AF2C
              2A281E1D1B1E1D1B817D7CB5AFAE807D7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF838282B7B1B08E8A8933312F5452503B3A38B9B4B38B8882A7A49F918E
              87B5B0AD8D8A869D9A94918E87A7A39FB5AEAD918E87A7A59F8C8A84BAB4B33D
              3C3A33312F33312F8B8785B8B2B1847F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF868383BAB3B39D9595545250545250565553BDB6B69894919E99959E99
              95BEB7B79C97969E99959E9995BAB4B2BAB3B39E99959E9995999491BDB6B65A
              59575452505452509C9696BBB4B4878080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF868585BCB6B5BDB7B6B0AAA9AFAAA9B4AEADBDB7B6BCB6B5BCB6B5BCB6
              B5BDB7B6BCB6B5BCB6B5BCB6B5BDB7B6BDB7B6BCB6B5BCB6B5BCB6B5BDB7B6B5
              AFAEAFAAA9AFAAA9BCB6B5BDB7B6898481FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF898686BFB8B8908B8B21211F21201E282726C0BABA7C7B748282797F7F
              76B9B4B28785817F7F7685857CA6A29EBBB5B47F7E7588887F7D7C74C1BABA2C
              2B2A21201E21201E898584C0B9B98C8686FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF898689C0BBBA95908F302F2D302F2D383634C3BDBC918F89A29F999693
              8CBEB8B695928E96938CA4A19BAEAAA6BEB8B696938CABA8A393908AC3BEBD3C
              3A3950504E302F2D908C8BC2BCBB8E8889FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF8C8989C3BDBD9B96964643414643414C4948C7C0C0A49F9CACA6A1ACA6
              A1C5BFBFA39D9BACA6A1ACA6A1BDB7B4C3BCBCACA6A1ACA6A1A7A29DC7C0C050
              4D4B4643414643419B9494C5BEBE908B8AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF8C8989C6BFBFC0BABAA8A3A2A8A3A2ABA5A5C8C1C1C9C2C1C9C2C2C9C2
              C2C8C1C1C8C1C1C9C2C2C9C2C2C9C2C2C8C1C1C9C2C2C9C2C2C9C1C1C8C1C1AE
              A7A6A8A3A2A8A3A2BEB8B8C8C1C1918D8DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7B77778783828783838783838783838783838783838783838783838783
              8387838387838387838387838387838387838387838387838387838387838387
              8383878383878383878383878383706E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF5F5E5D2E2E2C706E6E7574747473737473737473737473737473737473
              7374737374737374737374737374737374737374737374737374737374737374
              7373747373747373747373434240434241FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF615F5F343330707070A4A4A4A7A7A79F9F9F9A9A9AA7A7A7A4A4A49797
              97A5A5A5A7A7A79696969090908989898888889696968888888787878D8D8D8F
              8F8F8787878989897979794C4A4A474543FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF646160373735818181BABABAABABABBBBBBBB4B4B4ADADADB0B0B0B1B1
              B1B9B9B9ABABAB8181818B8B8B9595959F9F9FB1B1B1ADADAD9C9C9C7F7F7F86
              86869A9A9A8D8D8D8A8A8A4E4D4C4A4846FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF6765643B3A38898989BBBBBBAEAEAEBCBCBCBABABAAFAFAFB1B1B1B7B7
              B7BBBBBBAEAEAE8D8D8D8E8E8E9696969E9E9EB7B7B7A9A9A99595958383838B
              8B8BAEAEAEA1A1A1909090514F4E4D4B4AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF6866653E3D3B8F8F8FC0C5C3B8BDBBC1C6C4BFC4C2B9BEBCBABFBDBEC3
              C1C0C5C3B8BDBB959A98BCC1BF9A9F9D919694A3A8A68489879DA2A0B4B9B798
              9D9BB8BDBBADB2B0999C9A5251504F4D4CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF6C686741403F969696C6CBC9C2C7C5C7CCCAC5CAC8C2C7C5C4C9C7C5CA
              C8C6CBC9C2C7C58C918FC5CAC8B9BEBCA6ABA9A3A8A68B908EB3B8B6C1C6C491
              9694BABFBDA4A9A7999C9B555352535150FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF6F6C6B4341418C8C8CC6CAC8C8CCCAC7CBC9C5C9C7C8CCCAC8CCCAC6CA
              C8C7CBC9C8CCCAB8BCBAB5B9B7999D9B9DA19FBABEBC9FA3A19CA09EB3B7B5B0
              B4B2929694989D9B9D9F9E575654575352FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF6F6D6D4846447271716F6F6F6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E
              6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E
              6E6E6E6E6E6E6E6E7373735D5A5A595655FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF736F6F4543414442404442404442404442404442404442404442404442
              4044424044424044424044424044424044424044424044424044424044424044
              42404442404442404442404442405D5A58FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF7775734A47454845434845434845434845434845434845434845434845
              4348454348454348454348454348454348454348454348454348454348454348
              4543484543484543484543494644615D5BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD7D6D55855544B49474B49474B49474B49474B49474B49474B49474B49
              474B49474B49474B49474B49474B49474B49474B49474B49474B49474B49474B
              49474B49474B49474B494754514FAAA9A9FFFFFFFFFFFFFFFFFF}
            OnClick = btEstimativaClick
            ExplicitLeft = 11
            ExplicitTop = 6
          end
        end
      end
    end
    object pnPequisa: TPanel
      Left = 1
      Top = 49
      Width = 895
      Height = 40
      Align = alTop
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
      object btPesquisar: TSpeedButton
        AlignWithMargins = True
        Left = 792
        Top = 3
        Width = 100
        Height = 34
        Align = alRight
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
        Layout = blGlyphRight
        OnClick = btPesquisarClick
        ExplicitLeft = 685
      end
      object edPesquisa: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 620
        Height = 34
        Align = alClient
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object cbStatus: TComboBox
        AlignWithMargins = True
        Left = 629
        Top = 3
        Width = 157
        Height = 31
        Align = alRight
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = 'Em Andamento'
        OnChange = cbStatusChange
        Items.Strings = (
          'Em Andamento'
          'Encerradas'
          'Canceladas'
          'Todas')
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 889
      Height = 42
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Recebimento de Plantas'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
  end
  object ds_Pesquisa: TDataSource
    DataSet = cds_Pesquisa
    Left = 296
    Top = 192
  end
  object cds_Pesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = csPesquisaFilterRecord
    Left = 400
    Top = 192
    object cds_PesquisaID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
    end
    object cds_PesquisaDATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object cds_PesquisaCLIENTE: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'CLIENTE'
      Size = 100
    end
    object cds_PesquisaESPECIE: TStringField
      DisplayLabel = 'Esp'#233'cie'
      FieldName = 'ESPECIE'
      Size = 100
    end
    object cds_PesquisaQUANTIDADE: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
    end
    object cds_PesquisaSELECAOPOSITIVA: TStringField
      DisplayLabel = 'Sel Positiva'
      FieldName = 'SELECAOPOSITIVA'
      Size = 3
    end
    object cds_PesquisaCODIGOSELECAOCAMPO: TStringField
      DisplayLabel = 'C'#243'digo no Campo'
      FieldName = 'CODIGOSELECAOCAMPO'
      Size = 100
    end
    object cds_PesquisaIDESPECIE: TIntegerField
      FieldName = 'IDESPECIE'
    end
    object cds_PesquisaID_VARIEDADE: TIntegerField
      FieldName = 'ID_VARIEDADE'
    end
    object cds_PesquisaVARIEDADE: TStringField
      FieldName = 'VARIEDADE'
      Size = 100
    end
    object cds_Pesquisadataestimadaprocessamento: TDateField
      FieldName = 'dataestimadaprocessamento'
    end
  end
  object PopupMenu: TPopupMenu
    Images = ImageList1
    Left = 544
    Top = 240
    object ENCERRAR1: TMenuItem
      Caption = 'Encerrar'
      ImageIndex = 1
      OnClick = ENCERRAR1Click
    end
    object IMPRIMIRETIQUETAS1: TMenuItem
      Caption = 'Etiquetas'
      ImageIndex = 0
      OnClick = IMPRIMIRETIQUETAS1Click
    end
    object Cancelar1: TMenuItem
      Caption = 'Cancelar'
      ImageIndex = 2
      OnClick = Cancelar1Click
    end
    object EstimativavsRealidade1: TMenuItem
      Caption = 'Estimativa vs Realidade'
      ImageIndex = 4
      OnClick = EstimativavsRealidade1Click
    end
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 360
    Top = 304
    Bitmap = {
      494C010105001400080120002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000004000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009B9B9A009B9B9A009B9B9A009B9B9A009B9B
      9A009B9B9A009B9B9A009B9B9A009B9B9A009B9B9A009B9B9A009B9B9A009B9B
      9A009B9B9A009B9B9A009B9B9A009B9B9A009B9B9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBE00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00F9F9F9009B9B9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBE00FAFAFA007F675F007F675F007F67
      5F007F675F007F675F007F675F007F675F007F675F007F675F007F675F007F67
      5F007F675F007F675F007F675F00F9F9F9009B9B9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700F4F4F400F2F2F200EFEF
      EF00EDEDED00EAEAEA00E8E8E800BFBFBE00FAFAFA00F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800FDFDFD00F5F5F5009B9B9A00EDEDED00EFEFEF00F2F2
      F200F5F5F500F7F7F700F9F9F900FCFCFC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDE00D5D5D500CACACA00C0C0
      C000B6B6B600AEAEAE00A3A3A300BFBFBE00FAFAFA007F675F007F675F007F67
      5F007F675F007F675F007F675F007F675F007F675F007F675F007F675F007F67
      5F007F675F007F675F007F675F00EAEAEA009B9B9A00B6B6B600C0C0C000CBCB
      CB00D6D6D600E1E1E100E9E9E900F4F4F4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B3A59B0078685800786858007868
      5800786858007868580048403800B6B6B400EDECEC00EBEAEA00EBEAEA00EBEA
      EA00EBEAEA00EBEAEA00EBEAEA00EBEAEA00EBEAEA00EBEAEA00EBEAEA00EBEA
      EA00EBEAEA00EBEAEA00F0EFEE00D7D4D2009594930048403800786858007868
      580078685800786858007D6D5D00A29187000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6A59D0098867E0098867E009786
      7E0097867E0096847C0048403800A4A2A000D2D0CE00725E5600725E5600725E
      5600725E5600725E5600725E5600725E5600725E5600725E5600725E5600725E
      5600725E5600725E5600725E5600C1BDBA00888684004840380088786D008777
      6D0087776D0087776D0095857B00958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBACA400A3948C00A3948C00A394
      8C00A3958D00A3958D00484038008C898500AEAAA700ADA9A600ADA9A600ADA9
      A600ADA9A600ADA9A600ADA9A600ADA9A600ADA9A600ADA9A600ADA9A600ADA9
      A600ADA9A600ADA9A600B0ACA900A7A29E00787470004840380096867D009585
      7D0094847D0094847D009E8E8600958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BEAFA700AA9B9300AA9B9300AB9B
      9300AB9C9400AB9C950048403800484038004840380048403800484038004840
      3800484038004840380048403800484038004840380048403800484038004840
      3800484038004840380048403800484038004840380048403800A0918800A090
      88009F8F88009F8F8800A5958D00958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C1B1A900B1A19900B1A19900B1A1
      9900B1A09800B1A09900B1A09900B1A19900B1A19900B1A19800B1A09800B1A1
      9900B0A19800B0A19800B1A19900B2A09900B2A09900B0A09800AFA19700AEA1
      9500ADA19400ACA29400A9A19100A89F9000A89D9000A89D9000A89B9100A99A
      9100A9999100A9999100AD9C9400958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C5B5AD00B9A9A100B9A9A100B9A9
      A100B7A99F00B7A99F00B6A99E00B5A99D00B5A99D00B5AA9D00B5AA9D00B5AB
      9E00B5AA9E00B5AA9E00B6A99F00B7A79F00B7A89F00B7A69F00B6A69E00B4A6
      9D00B3A69C00B2A79C00B1A79B00B0A69A00B0A59A00B0A59A00B2A49A00B2A2
      9A00B2A29A00B2A29A00B2A29B00958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C7B7AF00BEAEA600BEAEA600BCAE
      A400C5BAB100CFC8BF00E7E4DF00E7E4DE00E7E4DE00E7E4DE00E7E4DE00E7E4
      DE00E7E4DF00E7E3DF00E7E3DF00E7E2DF00E7E2DF00E7E1DF00E7E1DF00E7E1
      DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00E7E1DE00CDC2BD00C1B3
      AD00B6A69E00B6A69E00B6A59D00958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C9B9B100C2B1A900C2B1A900C0B1
      A800D4CAC300C3954800C6851000C6851000C6851000C6851000C6851000C685
      1000C6851000C6851000C6851000C6851000C6851000C6851000C6851000C685
      1000C6851000C6851000C6851000C6851000C6851000C6851000C3944700D1C6
      C100BCACA400BCACA400BAAAA100958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCBCB400C8B8B000C8B8B000C8B8
      AF00EDE7E400C88A1A00DBAF3C00DEB34100DEB34100DEB34100DEB34100DEB3
      4100DEB34100DEB34100DEB34100DEB34100DEB34100DEB34100DEB34100DEB3
      4100DEB34100DEB34100DEB34100DDB13F00DEB44200DEB44200C6871800EDE6
      E400C8B7AF00C8B7AF00C2B1A800958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D0C3BB00D2C8C000D2C8C000D3C6
      BF00F0EBE900C6851000DFB34200D5982700D5982700D5982700D5982700D598
      2700D5982700D5982700D5982700D5982700D5982700D5982700D5982700D598
      2700D5982700D5982700D5982700D5982700D69A2A00E0B54500C6851000EFEA
      E800CEC3BB00CEC3BB00C6B9B100958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D4C8C000DBD2CA00DBD2CA00DCD1
      C900F3EFEC00C6851000E1B54600D99F3200D99F3200D99F3200D99F3200D99F
      3200D99F3200D99F3200D99F3200D99F3200D99F3100D99F3100D99F3100D99F
      3100D99F3100D99F3100D99F3100D99F3100D99E3000E2B64600C6851000F0ED
      EA00D3CBC200D3CBC200C9BFB500958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DCD1C900ECE8E000ECE8E000EDE8
      E000F9F6F400C6851000E5C05C00E3B65E00E3B65E00E3B65E00E3B65E00E3B6
      5E00E3B55E00E3B55E00E3B55E00E3B55E00E3B55E00E3B55D00E3B55D00E3B6
      5D00E3B65D00E3B65D00E3B65D00E3B55D00E3B55D00E7C36100C6851000F6F2
      F100E4DBD800E4DBD800D5CAC500958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1D9D400F8F8F700F8F8F700F8F8
      F700FCFBFB00C6851000E9C66B00EAC37900EAC37900EAC37900EAC37900EAC3
      7900EAC37900EAC37900EAC37A00EAC37A00EAC37A00EAC37900EAC37900EAC3
      7900EAC37800EAC37800EAC37700EAC37700EAC37700EBCB7100C6851000FBFA
      F900F6F5F000F6F5F000E2DCD500958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5DCD70000000000000000000000
      0000FEFEFE00C6851000EBCD7A00EFCF9100EFCF9100EFCF9100EFCF9100EFCF
      9100EFCF9100EFCF9100EFCF9100EFCF9100EFCF9100EFCF9100EFCF9100EFCF
      9100EFCF9100EFCF9100EFCF9100EFCF9100EFCF9100EFD28300C68510000000
      000041D5B60000000000E7E3E000958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E3DAD500FBFAFA00FBFAFA00FBFA
      FA00FDFCFC00C6851000EDCE7C00F1D19400F1D19400F1D19400F1D19400F1D1
      9400F1D19400F1D19400F1D19400F1D19400F1D19400F1D19400F1D19400F1D1
      9400F1D19400F1D19400F1D19400F1D19400F1D19400F0D38600C6851000FFFE
      FE00FEFEFE00FAFAFA00E4E0DD00958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1D5D000F6EFEE00F6EFEE00F7EF
      EF00FCF8F800C6851000ECC97000F0C97F00F0C97E00F0C97E00F0C97E00F0C9
      7E00F0C97D00F0C97D00F0C97D00F0C97D00F0C97D00F0C97D00F0C97D00F0C9
      7D00F0C97D00F0C97D00F0C87D00F0C87D00F0C87D00EFCD7700C6851000F9F6
      F600EEE7E600EEE7E600DCD3CF00958175000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E0D9D200EBE9E300EBE9E300EBE8
      E300F8F6F500C6851000EABF5700ECBA5600ECBA5600ECBA5600ECBA5600ECBA
      5600ECBA5500ECBA5500ECBA5500ECBA5500ECBA5500ECBA5500ECBA5500ECBA
      5500ECBA5500ECBA5500ECBA5500ECBA5500ECBA5600EEC76600C6851000F5F2
      F000E3DAD400E3DAD400D4C9C200A49388000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000047341900473419009D9B9800D4D2D000CFCDCC00CFCDCC00CFCD
      CC00CFCDCC00CFCDCC00CFCDCC00CFCDCC00CFCDCC00CFCDCC00CFCDCC00CFCD
      CC00CFCDCC00CFCDCC00CCCAC800D0CECC009B9B9A0047341900473419000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000804A000047341900A4A2A000D8D6D400D2D0CF00D2D0CF00D2D0
      CF00D2D0CF00D2D0CF00D2D0CF00D2D0CF00D2D0CF00D2D0CF00D2D0CF00D2D0
      CF00D2D0CF00D2D0CF00CFCDCC00DDDCDA009B9B9A0047341900804A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000804A000047341900B2B1AF00ECECEB00E6E5E400E6E5E400E6E5
      E400E6E5E400E6E5E400E6E5E400E6E5E400E6E5E400E6E5E400E6E5E400E6E5
      E400E6E5E400E6E5E400E4E3E200EFEFEE009B9B9A0047341900804A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000804A000047341900BABAB900F8F8F700F1F1F000F1F1F000F1F1
      F000F1F1F000F1F1F000F1F1F000F1F1F000F1F1F000F1F1F000F1F1F000F1F1
      F000F1F1F000F1F1F000F1F1F000F9F9F9009B9B9A0047341900804A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000047341900BFBFBE0000000000F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800000000009B9B9A0047341900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000047341900BFBFBE0000000000F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800000000009B9B9A0047341900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBE0000000000F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800000000009B9B9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBE0000000000F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800000000009B9B9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBE00BFBFBE00BFBFBE00BFBFBE00BFBF
      BE00BFBFBE00BFBFBE00BFBFBE00BFBFBE00BFBFBE00BFBFBE00BFBFBE00BFBF
      BE00BFBFBE00BFBFBE00BFBFBE00BFBFBE00B6B6B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DADA
      DA00EAEAEA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700ECECEC00E5E5
      E500E0E0E000DCDCDC00D8D8D800D5D5D500D2D2D200D0D0D000CECECE00CDCD
      CD00CCCCCC00CBCBCB00CBCBCB00CACACA00C9C9C900CACACA00CBCBCB00CBCB
      CB00CCCCCC00CDCDCD00CECECE00D1D1D100D3D3D300D5D5D500D9D9D900DCDC
      DC00E1E0E000E8E9EC00F0F2F600F9F9FA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE002828
      2800878787000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8E8E800CBCBCB00BEBE
      BE00B7B7B700B5B5B500B1B1B100AEAEAE00ABABAB00AAAAAA00A8A8A800A7A7
      A700A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A7A7A700A8A8A800AAAAAA00ACACAC00AEAEAE00B1B1B100B5B5
      B400BCBDC200BBB8B000C2BBAB00EEEFF2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CCCCCC000000
      0000D5D5D5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFEFF8006868C0003E3EB7005A5ABC00E3E3F400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EBEBF8005C5CC7003737C1005757C600DFDFF4000000
      00000000000000000000000000000000000000000000FDFDFD00FAFAFA00F6F6
      F600F3F3F300D5D5D500C8C8C800C8C8C800C7C7C700C6C6C600C5C5C500C4C4
      C400C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
      C300C4C4C400C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C8C8C700DBDE
      E400E2DCCE00A8853800AE842D00DAC39500D3D3D300D3D3D300D3D3D300F4F4
      F4000000000000000000E6E6E600E5E5E50000000000D6D6D600D3D3D300D3D3
      D300F7F7F700DCDCDC00D3D3D300D3D3D300D8D8D8000000000000000000F6F6
      F600D5D5D50000000000EFEFEF00D3D3D300D3D3D300EEEEEE0000000000D8D8
      D800D3D3D300D3D3D300D3D3D300D3D3D3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000707070003131
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F4F4FA005B5BB7004646D2003B3BF9003A3ADD004141B100DFDFF2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EDEDF8004B4BC0004141DD006363F8005858E1004343BE00E5E5
      F600000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700C0C0C000C0C0C000C1C1C100C1C1C100C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C1C1C100C1C1C100C2C4C800C0BE
      BA00AC8B4200AC832D00BC934100CA9E4D00000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00181818008D8D
      8D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      FC006161B7004F4FCE003232FD000000F1001B1BF7003939DB004141B200E2E2
      F300000000000000000000000000000000000000000000000000000000000000
      0000F1F1FA004F4FC0003737D8004F4FF7003E3EEF006464FC005F5FDE004646
      BD00E8E8F7000000000000000000000000000000000000000000000000000000
      0000F2F2F200BFBFBF00C2C2C200C2C2C200C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C100C3C4C600C2C3C500A98C
      4D00AA812900BB934300CA9E4B00E2BD7B00000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B9B9B90002020200E5E5
      E500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EAEAF6005D5D
      B4005656CD003535FD000000F4000000EF000000EB001717F3002F2FDD003D3D
      B100DBDBF000000000000000000000000000000000000000000000000000E6E6
      F6004949BC002F2FD9004242F3003737EA004040EE004343F1006D6DFC006A6A
      DF004545BD00DCDCF30000000000000000000000000000000000000000000000
      0000F3F3F300C0C0C000C2C2C200C3C3C300C6C6C600C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C2C3C400C4C7CD00AD966300A980
      2700B9924100C69A4800E2BC7200FBF2E200000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005D5D5D00444444000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007070BC005959
      CE003C3CFF000000F7000000F2000000EF000000EB000000E6001313F0002929
      E0003D3DB200E1E1F20000000000000000000000000000000000EFEFF9004D4D
      BD002A2ADB003939F1002F2FE5003939EA004141EE004848F1004B4BF5007979
      FF007272E1005757C40000000000000000000000000000000000000000000000
      0000F3F3F300C4C4C400C6C6C600C3C3C300C1C1C100C1C1C100C1C1C100C1C1
      C100C1C1C100C1C1C100C5C5C500C6C6C600C6C6C600C5C5C500C6C6C600C7C7
      C700C8C8C800C7C7C700C7C7C700C7C7C700C9CBD200B4A27B00A77E2500B790
      3F00C4984600DDB46600F8EBD10000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4F4F4000B0B0B00A0A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004444A7006464
      F4000000FF000000F6000000F2000000EF000000EB000000E8000000E3000E0E
      ED002020DC003F3FB200E2E2F3000000000000000000ECECF8004F4FBB002020
      D6002E2EEE002727E2003131E6003939EA004141EE004848F1004F4FF5005454
      FC009494FF004242C00000000000000000000000000000000000000000000000
      0000F4F4F400C9C9C900CBCBCB00C3C3C300B9B9B900BABABA00BABABA00BABA
      BA00BABABA00BABABA00C8C8C800CACACA00C9C9C900CACACA00CBCBCB00C4C4
      C400BDBDBD00BBBBBB00BBBBBB00C3C5CA00BBB09700A67C2100B58D3B00C297
      4600D8AD5C00F5E2BF000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A6A6A60008080800F1F1F1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007979BF005656
      C5004343FF000000F9000000F2000000EF000000EB000000E8000000E4000000
      DE000C0CE9001818DA003E3EB200E4E4F400F1F1F9005151BA001717D4002323
      EB002020DD002929E3003131E7003939EA004141EE004848F1004C4CF6007F7F
      FF006C6CDC005F5FC70000000000000000000000000000000000000000000000
      0000F5F5F500CBCBCB00CCCCCC00CDCDCD00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CCCCCC00CCCCCC00CDCDCD00CBCBCB00BDBDBD00B5B5
      B500B3B3B300B3B3B300B3B3B300B4B6B700B3AFA700B49B6700C1943E00D5A8
      5500F1D9AB00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003636360053535300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F4F4FA006C6C
      B7005252C1003D3DFD000000F4000000EE000000EB000000E8000000E4000000
      E0000000DA000808E6001010DC003535B0003D3DAF001010D6001818E9001919
      DA002222E0002929E3003131E7003939EA004040EE004444F1007171FD006060
      D8004D4DBF00E7E7F70000000000000000000000000000000000000000000000
      0000F5F5F500CECECE00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CFCF
      CF00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CECECE00BDBDBD00B8B8B800B8B8
      B800BCBCBC00C0C0C000BFBFBF00B9B8B800BABBBE00B9BDC400C9B08200E3C4
      8700F7F7F600000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4D4D400000000000A0A0A00E3E3E3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      FB006D6DB8004C4CC4003737FD000000F1000000EB000000E8000000E4000000
      E0000000DC000000D6000404E2000808DA000909D6000E0EE5001111D6001919
      DC002222E0002929E3003131E7003939EA003D3DEE006767FB005959D9004E4E
      BE00EDEDF9000000000000000000000000000000000000000000000000000000
      0000F6F6F600D0D0D000D1D1D100D3D3D300D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D5D5D500C5C5C500BDBDBD00BDBDBD00CCCC
      CC00DEDEDE00E3E3E300E2E2E200D8D8D800C2C2C200BDBDBF00C0C0C000CFCC
      C800F7F8FB00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005353530000000000040404000E0E0E00ABAB
      AB00FEFEFE000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE00E7E7E700D9D9D900E4E4E400FCFCFC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFD006868B5004949C9003232FB000000EC000000E7000000E4000000
      E0000000DC000000D9000000D2000000DF000303E1000B0BD2001212D8001919
      DB002222E0002929E3003030E7003535EA005C5CF9005656DC004D4DBD00EFEF
      F900000000000000000000000000000000000000000000000000000000000000
      0000F6F6F600D3D3D300D5D5D500CBCBCB00BDBDBD00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00C1C1C100C3C3C300C1C1C100C6C6C600D9D9
      D900D8D8D800D7D7D700D9D9D900DDDDDD00D1D1D100C0C0C000C0C0C200C7C8
      CA00F8F8F800000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000A0A0A000000000000000000000000000101
      010039393900B0B0B000F6F6F6000000000000000000FCFCFC00D7D7D7009595
      95004A4A4A000C0C0C0000000000000000000000000007070700383838008C8C
      8C00E8E8E8000000000000000000000000000000000000000000000000000000
      000000000000F2F2F9006868B5004040C3002B2BF6000000E8000000E4000000
      E0000000DC000000D8000000D5000000CF000303CE000B0BD4001212D8001919
      DB002222E0002929E3002E2EE6005151F6004949D7004A4ABB00E6E6F6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700D5D5D500D6D6D600D3D3D300CECECE00CFCFCF00CFCFCF00CFCF
      CF00CFCFCF00CFCFCF00CFCFCF00CBCBCB00C7C7C700C7C7C700DADADA00DFDF
      DF00DFDFDF00DFDFDF00E1E1E100E2E2E200E5E5E500D0D0D000C5C5C500CACA
      CA00F7F7F700000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BABABA00000000000000000000000000000000000000
      00000303030003030300040404001E1E1E001D1D1D0007070700000000000303
      03000303030000000000B5B5B500DCDCDC00D0D0D0003B3B3B00000000000606
      060000000000B6B6B60000000000000000000000000000000000000000000000
      00000000000000000000FAFAFD006E6EB7003838C2002525F6000000E5000000
      DF000000DC000000D7000000D4000000CE000000CE000808D3001111D8001919
      DB002222DF002727E2004646F3004040D5005050BB00F1F1FA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700D7D7D700D8D8D800D9D9D900DADADA00DADADA00DADADA00DADA
      DA00DADADA00DADADA00DBDBDB00D2D2D200C9C9C900CDCDCD00E2E2E200E4E4
      E400E5E5E500E6E6E600E7E7E700E7E7E700EFEFEF00DBDBDB00C8C8C800D0D0
      D000F7F7F700000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F3F3F00010101000000000000000000000000000000
      000000000000ABABAB00B4B4B4009797970097979700A8A8A800202020000000
      0000000000002222220000000000000000000000000045454500000000000000
      0000000000008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000F8F8FC006C6CB7003434C9001E1EF3000000
      E0000000DB000000D7000707D6000B0BD4000C0CD3000D0DD5000F0FD7001717
      DB002020DE003A3AF0003A3AD7004F4FB800EDEDF80000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F800D9D9D900DADADA00DBDBDB00DDDDDD00DDDDDD00DDDDDD00DDDD
      DD00DDDDDD00DDDDDD00DEDEDE00D8D8D800CDCDCD00CECECE00E5E5E500EAEA
      EA00E5E5E500E6E6E600E7E7E700ECECEC00F3F3F300D9D9D900CBCBCB00D6D6
      D600F8F8F800000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD0005050500040404000000000000000000000000000000
      00001C1C1C00FDFDFD00000000000000000000000000E4E4E400000000000000
      0000000000005C5C5C0000000000000000000000000030303000000000000000
      0000080808008F8F8F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F9FC005353AA002E2EC7001313
      EC001818E5005555F5005F5FF7006363F8006464F8005F5FF7005959F4003232
      E5002828EA003333D6003B3BAE00F4F4FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F800DCDCDC00DDDDDD00D9D9D900D3D3D300D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400CFCFCF00D8D8D800EAEA
      EA00EBEBEB00EAEAEA00ECECEC00F1F1F100E5E5E500D1D1D100D2D2D200DCDC
      DC00F8F8F800000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00000000009D9D9D002929290000000000000000000000
      00007B7B7B00000000000000000000000000000000009F9F9F00000000000000
      000000000000969696000000000000000000000000001C1C1C00000000000000
      0000080808008F8F8F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F8004C4CA8002929CD001717
      ED005A5AF6008888FF008282FF008181FF008181FF008282FF008585FF006C6C
      F8003434ED003030D9003939AF00E6E6F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F8F800DEDEDE00E1E1E100D4D4D400C3C3C300C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C4C4C400C5C5C500DADADA00D5D5D500CDCDCD00D0D0
      D000E2E2E200E8E8E800E8E8E800DBDBDB00CCCCCC00D0D0D000DEDEDE00DEDE
      DE00F9F9F900000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      0000000000002D2D2D000B0B0B0000000000F4F4F40066666600010101000101
      0100DCDCDC00000000000000000000000000000000005B5B5B00000000000000
      000000000000D1D1D100F8F8F800F5F5F500FEFEFE0007070700000000000000
      0000080808008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000EEEEF6005858AB003333D1001A1AF3005D5D
      F5009090FF008888FF008888FF008989FF008989FF008888FF008888FF008E8E
      FF007373F7003E3EF1003C3CDD003F3FB100DFDFF20000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900DFDFDF00E0E0E000E1E1E100E1E1E100E1E1E100E1E1E100E1E1
      E100E1E1E100E1E1E100E1E1E100E1E1E100DFDFDF00E0E0E000D7D7D700D1D1
      D100D7D7D700DDDDDD00DBDBDB00D3D3D300D3D3D300E0E0E000E1E1E100DFDF
      DF00FAFAFA00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      0000F5F5F5000202020052525200000000000000000000000000CACACA007474
      7400F8F8F800000000000000000000000000FEFEFE0018181800282828006B6B
      6B00A5A5A5001919190000000000000000001C1C1C00BBBBBB006F6F6F001515
      1500080808008F8F8F0000000000000000000000000000000000000000000000
      00000000000000000000F2F2F8005D5DAB003838CB001F1FF7006363F6009D9D
      FF009393FF009292FF009393FF009999FF009B9BFF009393FF009292FF009292
      FF009A9AFF007C7CF8004A4AF4004444DB004040B100E1E1F300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9F9F900E1E1E100E2E2E200E2E2E200E2E2E200E2E2E200E2E2E200E2E2
      E200E2E2E200E2E2E200E2E2E200E2E2E200E2E2E200E1E1E100E3E3E300DFDF
      DF00D9D9D900D6D6D600D7D7D700DCDCDC00E4E4E400E3E3E300E0E0E000E2E2
      E200FAFAFA00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00007F7F7F0000000000D3D3D300000000000000000000000000000000005C5C
      5C000A0A0A003F3F3F005A5A5A005454540066666600EBEBEB00000000000000
      0000B9B9B9000000000000000000000000001F1F1F000000000000000000F7F7
      F7001C1C1C008F8F8F0000000000000000000000000000000000000000000000
      000000000000E8E8F3005A5AA8004141CC002727F8006D6DF900A7A7FF009F9F
      FF009E9EFF009F9FFF00A9A9FF006B6BEF006060EB00A7A7FF009F9FFF009E9E
      FF009D9DFF00A4A4FF008787F9005353F6004F4FDC003E3EB100DADAF0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAFAFA00E3E3E300E4E4E400E5E5E500E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E5E5E500E7E7
      E700E8E8E800E7E7E700E8E8E800E8E8E800E6E6E600E4E4E400E4E4E400E4E4
      E400FAFAFA00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000000000
      00001F1F1F001515150000000000000000000000000000000000EFEFEF000909
      0900000000000000000000000000000000007070700000000000000000000000
      00007E7E7E000000000000000000000000003434340000000000000000000000
      0000272727008F8F8F0000000000000000000000000000000000000000000000
      0000F0F0F7005D5DA8004A4AD1002828FC007373F900B6B6FF00A9A9FF00A8A8
      FF00A9A9FF00B8B8FF007979F0000606E3000101E3006A6AEC00B6B6FF00ABAB
      FF00A8A8FF00A9A9FF00B1B1FF009090FA005E5EFA005C5CE0004040B100E0E0
      F200000000000000000000000000000000000000000000000000000000000000
      0000FAFAFA00E4E4E400E7E7E700DBDBDB00CCCCCC00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CDCD
      CD00CCCCCC00CCCCCC00CCCCCC00CDCDCD00CCCCCC00DEDEDE00E7E7E700E5E5
      E500FAFAFA00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      170000000000000000000000000000000000000000000000000000000000E6E6
      E600000000006464640000000000000000000000000000000000949494000000
      000000000000000000000000000000000000B4B4B40000000000000000000000
      0000434343000000000000000000000000004848480000000000000000000000
      0000272727008F8F8F000000000000000000000000000000000000000000EDED
      F5005D5DA5005050CB002C2CFF007777FB00C0C0FF00B5B5FF00B3B3FF00B4B4
      FF00C0C0FF007F7FF1000A0AE8000707CB000A0AC4000A0AE7007272EE00BFBF
      FF00B4B4FF00B3B3FF00B4B4FF00BBBBFF009A9AFB006969FD006161DE004040
      B100E1E1F3000000000000000000000000000000000000000000000000000000
      0000FAFAFA00E6E6E600E8E8E800E1E1E100D6D6D600D8D8D800D8D8D800D8D8
      D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800D8D8D800D8D8D800D8D8D800D7D7D700E2E2E200E8E8E800E7E7
      E700FBFBFB00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000006666
      66000000000021212100CBCBCB00000000000000000000000000313131000000
      000000000000000000000000000005050500F3F3F3000000000000000000FCFC
      FC000C0C0C000D0D0D002E2E2E00272727006262620000000000000000000000
      0000272727008F8F8F0000000000000000000000000000000000EFEFF6006060
      A4005757C7003232FE007F7FFB00CCCCFF00BEBEFF00BEBEFF00BFBFFF00D0D0
      FF008989F4000D0DEC000D0DD0004B4BA9005454AA001010C8001313EC008080
      F100CECEFF00C0C0FF00BEBEFF00BEBEFF00C7C7FF00A3A3FC007373FE006969
      DB004141B100DFDFF20000000000000000000000000000000000000000000000
      0000FAFAFA00E7E7E700E8E8E800E9E9E900EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00E9E9E900E8E8E800E8E8
      E800FBFBFB00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000000000001212
      12000101010000000000020202006B6B6B00E7E7E700CCCCCC00000000000000
      00000000000000000000000000003C3C3C000000000000000000FEFEFE00C2C2
      C200BEBEBE00FCFCFC000000000000000000989898005E5E5E00CFCFCF000000
      0000272727008F8F8F00000000000000000000000000000000007575B1005A5A
      C7004444FF008888FE00D9D9FF00CCCCFF00CACAFF00CACAFF00DADAFF008E8E
      F4001515ED001313CA005858AC00EEEEF700F9F9FC006C6CB7001515C1002323
      EC008787F100D6D6FF00CCCCFF00CACAFF00CBCBFF00D3D3FF00AEAEFE008787
      FF007373DD005A5ABC0000000000000000000000000000000000000000000000
      0000FBFBFB00E8E8E800E9E9E900EAEAEA00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00EBEB
      EB00EAEAEA00E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900FBFBFB00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      1700000000000000000000000000000000000000000000000000CFCFCF000000
      0000000000000000000000000000000000000808080093939300505050001414
      14000000000000000000000000007F7F7F00E7E7E7008E8E8E00262626006C6C
      6C00000000000000000000000000000000007878780000000000010101005C5C
      5C00242424008F8F8F00000000000000000000000000000000004E4E9A005858
      F2004848FF00EAEAFF00D8D8FF00D5D5FF00D7D7FF00E6E6FF009393F6001515
      F2001C1CCB005B5BAA00EEEEF7000000000000000000F8F8FB007070B8001F1F
      C3002A2AF1008E8EF400E1E1FF00D7D7FF00D5D5FF00D6D6FF00E4E4FF009595
      FF008E8EFE004747B50000000000000000000000000000000000000000000000
      0000FBFBFB00E9E9E900EBEBEB00E8E8E800E4E4E400E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E4E4
      E400E8E8E800EBEBEB00EBEBEB00F2F2F200F3F3F300F3F3F300F4F4F400F1F1
      F100FBFBFB00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      17000000000000000000000000000000000000000000000000004F4F4F000000
      00000000000000000000000000000000000008080800EFEFEF00000000000000
      0000E8E8E800CECECE00C9C9C9004A4A4A00010101000000000000000000A6A6
      A600000000000000000000000000000000006363630000000000000000000000
      0000090909008F8F8F00000000000000000000000000000000008888BA005757
      B7004646FF007A7AFF00F2F2FF00E3E3FF00F2F2FF009B9BF7001A1AF5002323
      CF005B5BA900F0F0F70000000000000000000000000000000000FBFBFD006969
      B6002626C8003535F3009A9AF500EEEEFF00E2E2FF00EDEDFF00AFAFFE008383
      FF006666D1006868C00000000000000000000000000000000000000000000000
      0000FBFBFB00EBEBEB00EEEEEE00DFDFDF00CACACA00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00C9C9
      C900DBDBDB00EFEFEF00EBEBEB00C9C9C900BFBFBF00C4C4C400C0C0C000C4C4
      C400FAFAFA00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      17000000000000000000000000000000000000000000000000000B0B0B000000
      0000000000000000000000000000000000005B5B5B0000000000000000000000
      00000000000000000000F2F2F20004040400000000000000000000000000E1E1
      E100000000000000000000000000000000004E4E4E0000000000000000000000
      0000080808008F8F8F0000000000000000000000000000000000F5F5F9007878
      B0005252B4003939FB008181FC0000000000A3A3F9001F1FF6002C2CCA005A5A
      A600E8E8F300000000000000000000000000000000000000000000000000F2F2
      F9006868B5002C2CC3004444F400A7A7F800FDFDFF00B5B5FC007474FD005B5B
      CD005858B700EAEAF60000000000000000000000000000000000000000000000
      0000FBFBFB00ECECEC00ECECEC00EBEBEB00E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900EBEBEB00F4F4F400C8C8C8007373730072727200676767005C5C5C00C1C1
      C100FEFEFE00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000006B6B6B0063636300000000000F0F0F00000000000000
      0000CFCFCF002F2F2F0000000000000000001B1B1B000000000000000000C7C7
      C70007070700000000009F9F9F0000000000000000009B9B9B00000000001717
      17000000000000000000000000000000000000000000D6D6D600000000000A0A
      0A0004040400000000000000000000000000BFBFBF0000000000000000000000
      00000000000000000000B2B2B2000000000000000000000000001B1B1B00F7F7
      F700B9B9B9008A8A8A007E7E7E00969696002E2E2E0000000000000000000000
      0000080808008F8F8F000000000000000000000000000000000000000000FDFD
      FE007F7FB2004A4AB5003A3AFD005656FB003131FB003232C5006161A800F2F2
      F800000000000000000000000000000000000000000000000000000000000000
      0000FAFAFD006D6DB8003131C2005656F9008787FA007171FE005353CC005F5F
      B700F7F7FC000000000000000000000000000000000000000000000000000000
      0000FBFBFB00EDEDED00EDEDED00EDEDED00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EDEDED00F6F6F600B9B9B9006B6B6B00686868005B5B5B00C5C5C5000000
      000000000000000000000000000000000000CFCFCF00CFCFCF00CFCFCF00F3F3
      F3000000000000000000E4E4E400E2E2E20000000000D2D2D200CFCFCF00CFCF
      CF00F6F6F600D8D8D800CFCFCF00CFCFCF00D5D5D5000000000000000000F5F5
      F500D1D1D10000000000EDEDED00CFCFCF00CFCFCF00EDEDED0000000000D4D4
      D400CFCFCF00CFCFCF00CFCFCF00CFCFCF00000000009090900028282800DCDC
      DC0034343400020202000000000020202000FDFDFD0000000000000000000000
      000000000000000000006E6E6E00000000000000000000000000262626001010
      10000000000025252500363636001A1A1A000000000006060600000000000000
      0000080808008F8F8F0000000000000000000000000000000000000000000000
      0000FDFDFE007A7AB0004646B8003737ED003939C7005F5FA500EFEFF6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F8F8FC006B6BB7003D3DC7005959EF004F4FCD005C5CB400F4F4
      FA00000000000000000000000000000000000000000000000000000000000000
      0000FBFBFB00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00F7F7F700B6B6B6005656560051515100C2C2C200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F6F6F600E8E8E8000000
      0000FDFDFD009E9E9E0019191900020202004C4C4C0099999900D2D2D200F7F7
      F700000000000000000028282800000000000202020002020200101010007F7F
      7F00E4E4E400000000000000000000000000DADADA007B7B7B000B0B0B000505
      0500000000008F8F8F0000000000000000000000000000000000000000000000
      000000000000F6F6FA008787BA004D4D9D007575B200F1F1F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F5F5FA007979BF003838A7006A6ABA00EFEFF8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFB00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00FAFAFA00A8A8A8003B3B3B00BEBEBE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FAFAFA00ADADAD005555550010101000000000000000
      00000A0A0A001212120000000000000000002A2A2A0092929200F4F4F4000000
      0000000000000000000000000000000000000000000000000000EDEDED006464
      6400000000006A6A6A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00F0F0F000EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00FAFAFA00A4A4A400AEAEAE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00DADADA00B7B7
      B700A5A5A500A2A2A200B5B5B500E4E4E4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C1C1C100EAEAEA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00F8F8F800F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F0F0F000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000400000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00FE00007F000000000000000000000000
      FEFFFF7F000000000000000000000000FE00007F000000000000000000000000
      FE00007F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7000001400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      F800001F000000000000000000000000F800001F000000000000000000000000
      F800001F000000000000000000000000F800001F000000000000000000000000
      FC80013F000000000000000000000000FC80013F000000000000000000000000
      FE80017F000000000000000000000000FE80017F000000000000000000000000
      FE00007F000000000000000000000000FFFFFFFFFFE7FFFFFFFFFFFF80000000
      FFFFFFFFFFC7FFFFFFFFFFFF80000000FFFFFFFFFFC7FFFFF83FFC1F80000000
      0C806420FFCFFFFFF01FF80FF00000000C806420FF8FFFFFE00FF007F0000000
      0C806420FF8FFFFFC007E003F00000000C806420FF9FFFFFC003C003F0000001
      0C806420FF1FFFFFC0018003F00000030C806420FF1FFFFFC0000003F0000007
      0C806420FF3FFFFFC0000003F00000070C806420FE1FFFFFE0000007F0000007
      0C806420FE07F83FF000000FF00000070C806420FE018007F800001FF0000007
      0C806420FC000003FC00003FF00000070C806420FC000383FE00007FF0000007
      0C806420F8038383FF0000FFF00000070C806420F8078383FF0000FFF0000007
      0C806420F9078003FE00007FF00000070C806420F1C70003FC00003FF0000007
      0C806420F1E03063F800001FF00000070C806420F3C07073F000000FF0000007
      0C806420E3C07073E0000007F00000070C806420E1C06073C0000003F0000007
      0C806420E000C313C0000003F00000070C806420C0000F03C0018003F0000007
      0C806420C0300F03C003C003F00000070C806420C07C0F03C107E003F0000007
      0C806420807C0003E00FF007F000001F0C806420807C0003F01FF80FF000003F
      FFFFFFFF900C0703F83FFC1FF000007FFFFFFFFFFC001FC3FFFFFFFFF00000FF
      FFFFFFFFFF80FFF3FFFFFFFFF80001FF00000000000000000000000000000000
      000000000000}
  end
  object cds_Etiqueta1: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = csPesquisaFilterRecord
    Left = 520
    Top = 320
    object cds_Etiqueta1CODIGOOP: TStringField
      FieldName = 'CODIGOOP'
      Size = 13
    end
    object cds_Etiqueta1PRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 100
    end
  end
end
