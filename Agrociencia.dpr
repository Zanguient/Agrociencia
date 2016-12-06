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
  uEncerramentoOPMC in 'uEncerramentoOPMC.pas' {frmEncerramentoOPMC};

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
