program Agrociencia;

uses
  Vcl.Forms,
  Vcl.Controls,
  MidasLib,
  System.SysUtils,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uConstantes in 'Units\uConstantes.pas',
  uFuncoes in 'Units\uFuncoes.pas',
  uRelatorios in 'Units\uRelatorios.pas',
  uDMUtil in 'Diversos\uDMUtil.pas' {DMUtil: TDataModule},
  uDomains in 'Diversos\uDomains.pas',
  uFWConnection in 'Diversos\uFWConnection.pas',
  uFWPersistence in 'Diversos\uFWPersistence.pas',
  uMensagem in 'Diversos\uMensagem.pas' {frmMensagem},
  uBeanUsuario in 'Beans\uBeanUsuario.pas',
  uBeanUsuario_Permissao in 'Beans\uBeanUsuario_Permissao.pas',
  uRedefinirSenha in 'uRedefinirSenha.pas' {frmRedefinirSenha},
  uLogin in 'uLogin.pas' {frmLogin},
  uCadastroUnidadeMedida in 'uCadastroUnidadeMedida.pas' {frmCadastroUnidadeMedida},
  uBeanUnidadeMedida in 'Beans\uBeanUnidadeMedida.pas',
  uCadastroRecipientes in 'uCadastroRecipientes.pas' {frmCadastroRecipientes},
  uBeanRecipientes in 'Beans\uBeanRecipientes.pas',
  uBeanObservacao in 'Beans\uBeanObservacao.pas',
  uCadastroObservacoes in 'uCadastroObservacoes.pas' {frmCadastroObservacoes},
  uBeanCliente in 'Beans\uBeanCliente.pas',
  uCadastroCliente in 'uCadastroCliente.pas' {frmCadastroCliente},
  uCadastroProdutos in 'uCadastroProdutos.pas' {frmCadastroProdutos},
  uBeanProdutos in 'Beans\uBeanProdutos.pas',
  uBeanControleEstoque in 'Beans\uBeanControleEstoque.pas',
  uBeanControleEstoqueProduto in 'Beans\uBeanControleEstoqueProduto.pas',
  uMovimentacaoEstoque in 'uMovimentacaoEstoque.pas' {frmMovimentacaoEstoque},
  uBeanControleEstoqueCancelamento in 'Beans\uBeanControleEstoqueCancelamento.pas',
  uComposicaoMeioCultura in 'uComposicaoMeioCultura.pas' {frmComposicaoMeioCultura},
  uBeanProdutoComposicao in 'Beans\uBeanProdutoComposicao.pas',
  uOrdemProducaoMeioCultura in 'uOrdemProducaoMeioCultura.pas' {frmOrdemProducaoMeioCultura},
  uBeanEsterilizacao in 'Beans\uBeanEsterilizacao.pas',
  uCadastroEsterilizacao in 'uCadastroEsterilizacao.pas' {frmCadastroEsterilizacao},
  uOrdemProducao in 'uOrdemProducao.pas' {frmOrdemProducao},
  uBeanOrdemProducaoFinal in 'Beans\uBeanOrdemProducaoFinal.pas',
  uBeanOrdemProducaoMC_Itens in 'Beans\uBeanOrdemProducaoMC_Itens.pas',
  uBeanOrdemProducaoMC in 'Beans\uBeanOrdemProducaoMC.pas',
  uBeanOPFinal in 'Beans\uBeanOPFinal.pas',
  uBeanEstagio in 'Beans\uBeanEstagio.pas',
  uBeanMeioCultura in 'Beans\uBeanMeioCultura.pas',
  uBeanMeioCulturaEspecie in 'Beans\uBeanMeioCulturaEspecie.pas',
  uCadastroEstagio in 'uCadastroEstagio.pas' {frmCadastroEstagio},
  uEncerramentoOPMC in 'uEncerramentoOPMC.pas' {frmEncerramentoOPMC},
  uBeanOPFinal_Estagio in 'Beans\uBeanOPFinal_Estagio.pas',
  uControleEstagioOPF in 'uControleEstagioOPF.pas' {frmControleEstagioOPF},
  uBeanOrdemProducaoMC_Estoque in 'Beans\uBeanOrdemProducaoMC_Estoque.pas',
  uBeanOrdemProducaoMC_Estoque_OP in 'Beans\uBeanOrdemProducaoMC_Estoque_OP.pas',
  uSeleciona in 'uSeleciona.pas' {frmSeleciona},
  uSelecionaMeioCultura in 'uSelecionaMeioCultura.pas' {frmSelecionaMeioCultura},
  uSelecionaOPMC in 'uSelecionaOPMC.pas' {frmSelecionaOPMC},
  uBeanOPFinal_Estagio_Lote in 'Beans\uBeanOPFinal_Estagio_Lote.pas',
  uBeanOPFinal_Estagio_Lote_E in 'Beans\uBeanOPFinal_Estagio_Lote_E.pas',
  uBeanOPFinal_Estagio_Lote_S in 'Beans\uBeanOPFinal_Estagio_Lote_S.pas',
  uBeanOPFinal_Estagio_Lote_Intervalo in 'Beans\uBeanOPFinal_Estagio_Lote_Intervalo.pas',
  uControleMultiplicacao in 'uControleMultiplicacao.pas' {frmControleMultiplicacao},
  uImpressaoEtiquetas in 'uImpressaoEtiquetas.pas' {frmImpressaoEtiquetas},
  uControleDescarte in 'uControleDescarte.pas' {frmControleDescarte},
  uBeanMotivoDescarte in 'Beans\uBeanMotivoDescarte.pas',
  uCadastroMotivoDescarte in 'uCadastroMotivoDescarte.pas' {frmCadastroMotivoDescarte},
  uBeanOPFinal_Estagio_Lote_S_Qualidade in 'Beans\uBeanOPFinal_Estagio_Lote_S_Qualidade.pas',
  uRelAgendaSemanal in 'uRelAgendaSemanal.pas' {frmRelAgendaSemanal},
  CapturaCam in 'Diversos\CapturaCam.pas' {fCaptura},
  uBeanOpFinal_Estagio_Imagens in 'Beans\uBeanOpFinal_Estagio_Imagens.pas',
  uSelecionaCadastroPlantas in 'uSelecionaCadastroPlantas.pas' {frmSelecionaCadastroPlantas},
  uBeanImagem in 'Beans\uBeanImagem.pas',
  uBeanOPFinal_Imagem in 'Beans\uBeanOPFinal_Imagem.pas',
  uBeanOPFinal_E_L_S_Q_Imagem in 'Beans\uBeanOPFinal_E_L_S_Q_Imagem.pas',
  uRelAniversariantes in 'uRelAniversariantes.pas' {frmRelAniversariantes},
  uRelCadastrodePlantas in 'uRelCadastrodePlantas.pas' {frmRelCadastrodePlantas},
  uBeanOPFinal_Estagio_Lote_S_Positivo in 'Beans\uBeanOPFinal_Estagio_Lote_S_Positivo.pas',
  uControleQualidadePositivo in 'uControleQualidadePositivo.pas' {frmControleQualidadePositivo},
  uPlanejamentoProducao in 'uPlanejamentoProducao.pas' {frmPlanejamentoProducao},
  uComposicaoSolucaoEstoque in 'uComposicaoSolucaoEstoque.pas' {frmComposicaoSolucaoEstoque},
  uBeanOrdemProducaoSolucao in 'Beans\uBeanOrdemProducaoSolucao.pas',
  uBeanOrdemProducaoSolucao_Itens in 'Beans\uBeanOrdemProducaoSolucao_Itens.pas',
  uOrdemProducaoSolucao in 'uOrdemProducaoSolucao.pas' {frmOrdemProducaoSolucao},
  uFotosEstagio in 'uFotosEstagio.pas' {Form1},
  uRelPosicaoEstoque in 'uRelPosicaoEstoque.pas' {frmRelPosicaoEstoque},
  uRelEstoquedeProducao in 'uRelEstoquedeProducao.pas' {frmRelEstoquedeProducao},
  uRelProducaoOperador in 'uRelProducaoOperador.pas' {frmRelProducaoOperador},
  uRelProducaoOP in 'uRelProducaoOP.pas' {frmRelProducaoOP},
  uDetalhesEstagio in 'uDetalhesEstagio.pas' {frmDetalhesEstagio},
  uRelPerdaOperador in 'uRelPerdaOperador.pas' {frmRelPerdaOperador},
  uConfiguracoesSistema in 'uConfiguracoesSistema.pas' {frmConfiguracoesSistema},
  uWebCam in 'uWebCam.pas' {frmWebCam},
  VFrames in 'WebCam\VFrames.pas',
  VSample in 'WebCam\VSample.pas',
  uBeanVariedade in 'Beans\uBeanVariedade.pas',
  uCadastroVariedade in 'uCadastroVariedade.pas' {frmCadastroVariedade};

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMUtil, DMUtil);
  Application.CreateForm(TfrmLogin, frmLogin);
  if FrmLogin.ShowModal = mrOk then begin
    FreeAndNil(FrmLogin);
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    Application.Run;
  end else
    Application.Terminate; //Encerra a aplicação

end.
