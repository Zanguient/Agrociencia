object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  ClientHeight = 467
  ClientWidth = 1035
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object IMFundo: TImage
    Left = 0
    Top = 0
    Width = 1035
    Height = 467
    Align = alClient
    Stretch = True
    ExplicitLeft = 448
    ExplicitTop = 128
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object MainMenu1: TMainMenu
    Left = 320
    Top = 128
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Usuario1: TMenuItem
        Caption = 'Usu'#225'rio'
        OnClick = Usuario1Click
      end
      object UnidadedeMedida1: TMenuItem
        Caption = 'Unidade de Medida'
        OnClick = UnidadedeMedida1Click
      end
      object Recipientes1: TMenuItem
        Caption = 'Recipiente'
        OnClick = Recipientes1Click
      end
      object Observaes1: TMenuItem
        Caption = 'Observa'#231#245'es'
        OnClick = Observaes1Click
      end
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produto'
        OnClick = Produtos1Click
      end
      object ComposiodeMeiosdeCultura1: TMenuItem
        Caption = 'Composi'#231#227'o de Meios de Cultura'
        OnClick = ComposiodeMeiosdeCultura1Click
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Estoque1: TMenuItem
        Caption = 'Estoque'
        OnClick = Estoque1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object Configuraes1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object ConfigGerais1: TMenuItem
        Caption = 'Configura'#231#245'es do Sistema'
        OnClick = ConfigGerais1Click
      end
      object RedefinirSenha: TMenuItem
        Caption = 'Redefinir Senha'
        OnClick = RedefinirSenhaClick
      end
      object BackupdoBancodeDados1: TMenuItem
        Caption = 'Backup do Banco de Dados'
        OnClick = BackupdoBancodeDados1Click
      end
    end
    object miSair: TMenuItem
      Caption = 'Sair'
      ShortCut = 27
      OnClick = miSairClick
    end
  end
end
