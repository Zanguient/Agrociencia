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
  KeyPreview = True
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
      object Esterilizacao1: TMenuItem
        Caption = 'Esteriliza'#231#227'o'
        OnClick = Esterilizacao1Click
      end
      object Estgio1: TMenuItem
        Caption = 'Est'#225'gio'
        OnClick = Estgio1Click
      end
      object ComposiodeMeiosdeCultura1: TMenuItem
        Caption = 'Composi'#231#227'o de Meios de Cultura'
        OnClick = ComposiodeMeiosdeCultura1Click
      end
      object MotivosdeDescarte1: TMenuItem
        Caption = 'Motivos de Descarte'
        OnClick = MotivosdeDescarte1Click
      end
      object ComposiodeSoluodeEstoque1: TMenuItem
        Caption = 'Composi'#231#227'o de Solu'#231#227'o de Estoque'
        OnClick = ComposiodeSoluodeEstoque1Click
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Estoque1: TMenuItem
        Caption = 'Estoque'
        OnClick = Estoque1Click
      end
      object OrdemdeProduodeMeiodeCultura1: TMenuItem
        Caption = 'Meio de Cultura'
        object OrdemdeProduoMeiodeCultura1: TMenuItem
          Caption = 'Ordem de Produ'#231#227'o'
          OnClick = OrdemdeProduoMeiodeCultura1Click
        end
        object EncerrarOrdemdeProduo1: TMenuItem
          Caption = 'Encerrar Ordem de Produ'#231#227'o'
          OnClick = EncerrarOrdemdeProduo1Click
        end
      end
      object OrdemdeProduo1: TMenuItem
        Caption = 'Cadastro de Produ'#231#227'o'
        object OrdemdeProduo2: TMenuItem
          Caption = 'Recebimento de Plantas'
          OnClick = OrdemdeProduo2Click
        end
        object EstgiodaProduo1: TMenuItem
          Caption = 'Gerar Ordem de Produ'#231#227'o'
          OnClick = EstgiodaProduo1Click
        end
      end
      object Multiplicaes1: TMenuItem
        Caption = 'Produ'#231#227'o'
        OnClick = Multiplicaes1Click
      end
      object Etiquetas1: TMenuItem
        Caption = 'Etiquetas'
        OnClick = Etiquetas1Click
      end
      object ControledeQualidade1: TMenuItem
        Caption = 'Controle de Qualidade'
        OnClick = ControledeQualidade1Click
      end
      object ControledeQualidadePositivo1: TMenuItem
        Caption = 'Controle de Qualidade Positivo'
        OnClick = ControledeQualidadePositivo1Click
      end
      object PlanejamentodaProduo1: TMenuItem
        Caption = 'Planejamento da Produ'#231#227'o'
        OnClick = Agendamento1Click
      end
      object SoluodeEstoque1: TMenuItem
        Caption = 'Solu'#231#227'o de Estoque'
        OnClick = SoluodeEstoque1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object AgendaSemanal1: TMenuItem
        Caption = 'Agenda Semanal'
        OnClick = AgendaSemanal1Click
      end
      object Aniversariantes1: TMenuItem
        Caption = 'Aniversariantes'
        OnClick = Aniversariantes1Click
      end
      object CadastrodePlantas1: TMenuItem
        Caption = 'Cadastro de Plantas'
        OnClick = CadastrodePlantas1Click
      end
      object PosiodeEstoque1: TMenuItem
        Caption = 'Posi'#231#227'o de Estoque'
        OnClick = PosiodeEstoque1Click
      end
      object EstoquedeProduo1: TMenuItem
        Caption = 'Estoque de Produ'#231#227'o'
        OnClick = EstoquedeProduo1Click
      end
      object ProduoporOperador1: TMenuItem
        Caption = 'Produ'#231#227'o por Operador'
        OnClick = ProduoporOperador1Click
      end
      object ProduoporOP1: TMenuItem
        Caption = 'Produ'#231#227'o por OP'
        OnClick = ProduoporOP1Click
      end
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
      object TrocarUsuario1: TMenuItem
        Caption = 'Trocar Usu'#225'rio'
        OnClick = TrocarUsuario1Click
      end
      object Sair: TMenuItem
        Caption = 'Sair'
        OnClick = SairClick
      end
    end
  end
end
