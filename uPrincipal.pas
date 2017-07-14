unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls, Math,
  FireDAC.Comp.Client, ShellAPI;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Relatrios1: TMenuItem;
    Configuraes1: TMenuItem;
    Usuario1: TMenuItem;
    ConfigGerais1: TMenuItem;
    miSair: TMenuItem;
    IMFundo: TImage;
    RedefinirSenha: TMenuItem;
    BackupdoBancodeDados1: TMenuItem;
    Movimentao1: TMenuItem;
    UnidadedeMedida1: TMenuItem;
    Observaes1: TMenuItem;
    Cliente1: TMenuItem;
    Produtos1: TMenuItem;
    Estoque1: TMenuItem;
    ComposiodeMeiosdeCultura1: TMenuItem;
    OrdemdeProduodeMeiodeCultura1: TMenuItem;
    Esterilizacao1: TMenuItem;
    OrdemdeProduo1: TMenuItem;
    Estgio1: TMenuItem;
    OrdemdeProduoMeiodeCultura1: TMenuItem;
    EncerrarOrdemdeProduo1: TMenuItem;
    OrdemdeProduo2: TMenuItem;
    EstgiodaProduo1: TMenuItem;
    Multiplicaes1: TMenuItem;
    Etiquetas1: TMenuItem;
    MotivosdeDescarte1: TMenuItem;
    Descartes: TMenuItem;
    AgendaSemanal1: TMenuItem;
    Aniversariantes1: TMenuItem;
    CadastrodePlantas1: TMenuItem;
    ControledeQualidadePositivo1: TMenuItem;
    PlanejamentodaProduo1: TMenuItem;
    ComposiodeSoluodeEstoque1: TMenuItem;
    SoluodeEstoque1: TMenuItem;
    PosiodeEstoque1: TMenuItem;
    EstoquedeProduo1: TMenuItem;
    Sair: TMenuItem;
    TrocarUsuario1: TMenuItem;
    ProduoporOperador1: TMenuItem;
    ProduoporOP1: TMenuItem;
    PerdaporOperador1: TMenuItem;
    procedure Usuario1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RedefinirSenhaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfigGerais1Click(Sender: TObject);
    procedure BackupdoBancodeDados1Click(Sender: TObject);
    procedure UnidadedeMedida1Click(Sender: TObject);
    procedure Observaes1Click(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Estoque1Click(Sender: TObject);
    procedure ComposiodeMeiosdeCultura1Click(Sender: TObject);
    procedure Esterilizacao1Click(Sender: TObject);
    procedure Estgio1Click(Sender: TObject);
    procedure OrdemdeProduoMeiodeCultura1Click(Sender: TObject);
    procedure EncerrarOrdemdeProduo1Click(Sender: TObject);
    procedure OrdemdeProduo2Click(Sender: TObject);
    procedure EstgiodaProduo1Click(Sender: TObject);
    procedure Multiplicaes1Click(Sender: TObject);
    procedure Etiquetas1Click(Sender: TObject);
    procedure MotivosdeDescarte1Click(Sender: TObject);
    procedure DescartesClick(Sender: TObject);
    procedure AgendaSemanal1Click(Sender: TObject);
    procedure Aniversariantes1Click(Sender: TObject);
    procedure CadastrodePlantas1Click(Sender: TObject);
    procedure ControledeQualidadePositivo1Click(Sender: TObject);
    procedure Agendamento1Click(Sender: TObject);
    procedure ComposiodeSoluodeEstoque1Click(Sender: TObject);
    procedure SoluodeEstoque1Click(Sender: TObject);
    procedure PosiodeEstoque1Click(Sender: TObject);
    procedure EstoquedeProduo1Click(Sender: TObject);
    procedure TrocarUsuario1Click(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure ProduoporOperador1Click(Sender: TObject);
    procedure ProduoporOP1Click(Sender: TObject);
    procedure PerdaporOperador1Click(Sender: TObject);
  private
    procedure FecharSistema;
    { Private declarations }
  public
    procedure CriarComandoSequenciaMenu(Menu: TMainMenu);
    procedure DefinirPermissoes;
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uConstantes,
  uFuncoes,
  uMensagem,
  uCadastroUsuario,
  uBeanUsuario,
  uRedefinirSenha,
  uFWConnection,
  uDMUtil,
  uConfiguracoesSistema,
  uRelatorios,
  uCadastroUnidadeMedida,
  uBeanObservacao,
  uCadastroObservacoes,
  uCadastroCliente,
  uCadastroProdutos,
  uMovimentacaoEstoque,
  uOrdemProducaoMeioCultura,
  uComposicaoMeioCultura,
  uCadastroEsterilizacao,
  uOrdemProducao,
  uCadastroEstagio,
  uEncerramentoOPMC,
  uControleEstagioOPF,
  uControleMultiplicacao,
  uImpressaoEtiquetas,
  uCadastroMotivoDescarte,
  uControleDescarte,
  uRelAgendaSemanal,
  uRelAniversariantes,
  uRelCadastrodePlantas,
  uControleQualidadePositivo,
  uPlanejamentoProducao,
  uComposicaoSolucaoEstoque,
  uOrdemProducaoSolucao,
  uRelPosicaoEstoque,
  uRelEstoquedeProducao,
  uRelProducaoOperador,
  uRelProducaoOP,
  uRelPerdaOperador;

{$R *.dfm}

procedure TfrmPrincipal.DefinirPermissoes;
begin
  RedefinirSenha.Visible  := False; //Usuário 0 é Administrador e não tem Cadastro
  if USUARIO.CODIGO > 0 then begin
    DefinePermissaoMenu(MainMenu1);
    miSair.Visible          := True;
  end;
end;

procedure TfrmPrincipal.EncerrarOrdemdeProduo1Click(Sender: TObject);
begin
  if not Assigned(frmEncerramentoOPMC) then
    frmEncerramentoOPMC := TfrmEncerramentoOPMC.Create(nil);
  try
    frmEncerramentoOPMC.ShowModal;
  finally
    FreeAndNil(frmEncerramentoOPMC);
  end;
end;

procedure TfrmPrincipal.Esterilizacao1Click(Sender: TObject);
begin
  try
    if frmCadastroEsterilizacao = nil then
      frmCadastroEsterilizacao := TfrmCadastroEsterilizacao.Create(Self);
    frmCadastroEsterilizacao.ShowModal;
  finally
    FreeAndNil(frmCadastroEsterilizacao);
  end;
end;

procedure TfrmPrincipal.Estgio1Click(Sender: TObject);
begin
  try
    if frmCadastroEstagio = nil then
      frmCadastroEstagio := TfrmCadastroEstagio.Create(Self);
    frmCadastroEstagio.ShowModal;
  finally
    FreeAndNil(frmCadastroEstagio);
  end;
end;

procedure TfrmPrincipal.EstgiodaProduo1Click(Sender: TObject);
begin
  if not Assigned(frmControleEstagioOPF) then
    frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
  try
    frmControleEstagioOPF.ShowModal;
  finally
    FreeAndNil(frmControleEstagioOPF);
  end;
end;

procedure TfrmPrincipal.Estoque1Click(Sender: TObject);
begin
  try
    if frmMovimentacaoEstoque = nil then
      frmMovimentacaoEstoque := TfrmMovimentacaoEstoque.Create(Self);
    frmMovimentacaoEstoque.ShowModal;
  finally
    FreeAndNil(frmMovimentacaoEstoque);
  end;
end;

procedure TfrmPrincipal.EstoquedeProduo1Click(Sender: TObject);
begin
  try
    if frmRelEstoquedeProducao = nil then
      frmRelEstoquedeProducao := TfrmRelEstoquedeProducao.Create(Self);
    frmRelEstoquedeProducao.ShowModal;
  finally
    FreeAndNil(frmRelEstoquedeProducao);
  end;
end;

procedure TfrmPrincipal.Etiquetas1Click(Sender: TObject);
begin
  if not Assigned(frmImpressaoEtiquetas) then
    frmImpressaoEtiquetas := TfrmImpressaoEtiquetas.Create(nil);
  try
    frmImpressaoEtiquetas.ShowModal;
  finally
    FreeAndNil(frmImpressaoEtiquetas);
  end;
end;

procedure TfrmPrincipal.FecharSistema;
begin
  DisplayMsg(MSG_CONF, 'Deseja realmente sair do sistema?', 'Sair do Sistema');

  if (ResultMsgModal = mrYes) then
    Close;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : FecharSistema;
    VK_F11 : begin
      if (ssCtrl in Shift) then begin
        DESIGNREL       := not DESIGNREL;
        if DESIGNREL then
          DisplayMsg(MSG_INF, 'Design de Relatórios Ativado!')
        else
          DisplayMsg(MSG_INF, 'Design de Relatórios Desativado!');
      end;
    end;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  if FileExists(DirInstall + 'Fundo.jpg') then
    IMFundo.Picture.LoadFromFile(DirInstall + 'Fundo.jpg');

  CarregaArrayMenus(MainMenu1);

  DefinirPermissoes;

  CriarComandoSequenciaMenu(MainMenu1);

  Caption := 'Sistema Vivetech Agrociências - Usuário: ' + IntToStr(USUARIO.CODIGO) + ' - ' + USUARIO.NOME;
end;

procedure TfrmPrincipal.Agendamento1Click(Sender: TObject);
begin
  if not Assigned(frmPlanejamentoProducao) then
    frmPlanejamentoProducao := TfrmPlanejamentoProducao.Create(nil);
  try
    frmPlanejamentoProducao.ShowModal;
  finally
    FreeAndNil(frmPlanejamentoProducao);
  end;
end;

procedure TfrmPrincipal.AgendaSemanal1Click(Sender: TObject);
begin
  if not Assigned(frmRelAgendaSemanal) then
    frmRelAgendaSemanal := TfrmRelAgendaSemanal.Create(nil);
  try
    frmRelAgendaSemanal.ShowModal;
  finally
    FreeAndNil(frmRelAgendaSemanal);
  end;
end;

procedure TfrmPrincipal.Aniversariantes1Click(Sender: TObject);
begin
  try
    if frmRelAniversariantes = nil then
      frmRelAniversariantes     := TfrmRelAniversariantes.Create(Self);
    frmRelAniversariantes.ShowModal;
  finally
    FreeAndNil(frmRelAniversariantes);
  end;
end;

procedure TfrmPrincipal.BackupdoBancodeDados1Click(Sender: TObject);
begin
  DisplayMsg(MSG_WAIT, 'Realizando Backup');

  try

    if not DirectoryExists(CONFIG_LOCAL.DirBackup) then
      CreateDir(CONFIG_LOCAL.DirBackup);

    if not FileExists(ExtractFilePath(Application.ExeName) + 'pg_dump.exe') then begin
      DisplayMsg(MSG_INF, 'Executavel do Backup (PG_Dump.exe) não encontrado na pasta do executável!' + sLineBreak + 'Para continuar o executável é necessário!');
      Exit;
    end;

    ShellExecute(0, 'OPEN', pchar( ExtractFilePath(Application.ExeName) + 'pg_dump.exe'), pchar(' --host ' + CONEXAO.Server + ' --port 5432 --username ' + CONEXAO.User_Name + ' --format custom --file "' + CONEXAO.Database + '_' + FormatDateTime('yyyymmdd_hhmm', Now) + '.backup" ' + CONEXAO.Database), pchar(CONFIG_LOCAL.DirBackup), SW_SHOWNORMAL);
  finally
    DisplayMsgFinaliza;
  end;
end;

procedure TfrmPrincipal.CadastrodePlantas1Click(Sender: TObject);
begin
  try
    if frmRelCadastrodePlantas = nil then
      frmRelCadastrodePlantas := TfrmRelCadastrodePlantas.Create(Self);
    frmRelCadastrodePlantas.ShowModal;
  finally
    FreeAndNil(frmRelCadastrodePlantas);
  end;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  try
    if frmCadastroCliente = nil then
      frmCadastroCliente     := TfrmCadastroCliente.Create(Self);
    frmCadastroCliente.ShowModal;
  finally
    FreeAndNil(frmCadastroCliente);
  end;
end;

procedure TfrmPrincipal.ComposiodeMeiosdeCultura1Click(Sender: TObject);
begin
  if not Assigned(frmComposicaoMeioCultura) then
    frmComposicaoMeioCultura := TfrmComposicaoMeioCultura.Create(nil);
  try
    frmComposicaoMeioCultura.ShowModal;
  finally
    FreeAndNil(frmComposicaoMeioCultura);
  end;
end;

procedure TfrmPrincipal.ComposiodeSoluodeEstoque1Click(Sender: TObject);
begin
  if frmComposicaoSolucaoEstoque = nil then
    frmComposicaoSolucaoEstoque := TfrmComposicaoSolucaoEstoque.Create(nil);
  try
    frmComposicaoSolucaoEstoque.ShowModal;
  finally
    FreeAndNil(frmComposicaoSolucaoEstoque);
  end;
end;

procedure TfrmPrincipal.ConfigGerais1Click(Sender: TObject);
begin
  try
    if frmConfiguracoesSistema = nil then
      frmConfiguracoesSistema := TfrmConfiguracoesSistema.Create(Self);
    frmConfiguracoesSistema.ShowModal;
  finally
    FreeAndNil(frmConfiguracoesSistema);
  end;
end;

procedure TfrmPrincipal.DescartesClick(Sender: TObject);
begin
  if frmControleDescarte = nil then
    frmControleDescarte := TfrmControleDescarte.Create(Self);
  try
    frmControleDescarte.ShowModal;
  finally
    FreeAndNil(frmControleDescarte);
  end;
end;

procedure TfrmPrincipal.ControledeQualidadePositivo1Click(Sender: TObject);
begin
  if not Assigned(frmControleQualidadePositivo) then
    frmControleQualidadePositivo := TfrmControleQualidadePositivo.Create(nil);
  try
    frmControleQualidadePositivo.ShowModal;
  finally
    FreeAndNil(frmControleQualidadePositivo);
  end;
end;

procedure TfrmPrincipal.MotivosdeDescarte1Click(Sender: TObject);
begin
  if frmCadastroMotivoDescarte = nil then
    frmCadastroMotivoDescarte := TfrmCadastroMotivoDescarte.Create(nil);
  try
    frmCadastroMotivoDescarte.ShowModal;
  finally
    FreeAndNil(frmCadastroMotivoDescarte);
  end;
end;

procedure TfrmPrincipal.Multiplicaes1Click(Sender: TObject);
begin
  try
    if frmControleMultiplicacao = nil then
      frmControleMultiplicacao     := TfrmControleMultiplicacao.Create(Self);
    frmControleMultiplicacao.ShowModal;
  finally
    FreeAndNil(frmControleMultiplicacao);
  end;
end;

procedure TfrmPrincipal.Observaes1Click(Sender: TObject);
begin
  try
    if frmCadastroObservacoes = nil then
      frmCadastroObservacoes     := TfrmCadastroObservacoes.Create(Self);
    frmCadastroObservacoes.ShowModal;
  finally
    FreeAndNil(frmCadastroObservacoes);
  end;
end;

procedure TfrmPrincipal.OrdemdeProduo2Click(Sender: TObject);
begin
  if not Assigned(frmOrdemProducao) then
    frmOrdemProducao := TfrmOrdemProducao.Create(nil);
  try
    frmOrdemProducao.ShowModal;
  finally
    FreeAndNil(frmOrdemProducao);
  end;
end;

procedure TfrmPrincipal.OrdemdeProduoMeiodeCultura1Click(Sender: TObject);
begin
  if not Assigned(frmOrdemProducaoMeioCultura) then
    frmOrdemProducaoMeioCultura := TfrmOrdemProducaoMeioCultura.Create(nil);
  try
    frmOrdemProducaoMeioCultura.ShowModal;
  finally
    FreeAndNil(frmOrdemProducaoMeioCultura);
  end;
end;

procedure TfrmPrincipal.PerdaporOperador1Click(Sender: TObject);
begin
  try
    if frmRelPerdaOperador = nil then
      frmRelPerdaOperador := TfrmRelPerdaOperador.Create(Self);
    frmRelPerdaOperador.ShowModal;
  finally
    FreeAndNil(frmRelPerdaOperador);
  end;
end;

procedure TfrmPrincipal.PosiodeEstoque1Click(Sender: TObject);
begin
  try
    if frmRelPosicaoEstoque = nil then
      frmRelPosicaoEstoque := TfrmRelPosicaoEstoque.Create(Self);
    frmRelPosicaoEstoque.ShowModal;
  finally
    FreeAndNil(frmRelPosicaoEstoque);
  end;
end;

procedure TfrmPrincipal.ProduoporOP1Click(Sender: TObject);
begin
  if frmRelProducaoOP = nil then
    frmRelProducaoOP := TfrmRelProducaoOP.Create(Self);
  try
    frmRelProducaoOP.ShowModal;
  finally
    FreeAndNil(frmRelProducaoOP);
  end;
end;

procedure TfrmPrincipal.ProduoporOperador1Click(Sender: TObject);
begin
  try
    if frmRelProducaoOperador = nil then
      frmRelProducaoOperador := TfrmRelProducaoOperador.Create(Self);
    frmRelProducaoOperador.ShowModal;
  finally
    FreeAndNil(frmRelProducaoOperador);
  end;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  try
    if frmCadastroProdutos = nil then
      frmCadastroProdutos     := TfrmCadastroProdutos.Create(Self);
    frmCadastroProdutos.ShowModal;
  finally
    FreeAndNil(frmCadastroProdutos);
  end;
end;

procedure TfrmPrincipal.RedefinirSenhaClick(Sender: TObject);
begin
  try
    if FrmRedefinirSenha = nil then
      FrmRedefinirSenha := TFrmRedefinirSenha.Create(Self);
    FrmRedefinirSenha.ShowModal;
  finally
    FreeAndNil(FrmRedefinirSenha);
  end;
end;

procedure TfrmPrincipal.SairClick(Sender: TObject);
begin
  FecharSistema;
end;

procedure TfrmPrincipal.SoluodeEstoque1Click(Sender: TObject);
begin
  if frmOrdemProducaoSolucao = nil then
    frmOrdemProducaoSolucao := TfrmOrdemProducaoSolucao.Create(nil);
  try
    frmOrdemProducaoSolucao.ShowModal;
  finally
    FreeAndNil(frmOrdemProducaoSolucao);
  end;
end;

procedure TfrmPrincipal.TrocarUsuario1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open', PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

procedure TfrmPrincipal.UnidadedeMedida1Click(Sender: TObject);
begin
  try
    if frmCadastroUnidadeMedida = nil then
      frmCadastroUnidadeMedida     := TfrmCadastroUnidadeMedida.Create(Self);
    frmCadastroUnidadeMedida.ShowModal;
  finally
    FreeAndNil(frmCadastroUnidadeMedida);
  end;
end;

procedure TfrmPrincipal.Usuario1Click(Sender: TObject);
begin
  try
    if FrmCadastroUsuario = nil then
      FrmCadastroUsuario     := TFrmCadastroUsuario.Create(Self);
    FrmCadastroUsuario.ShowModal;
  finally
    FreeAndNil(FrmCadastroUsuario);
  end;
end;

procedure TfrmPrincipal.CriarComandoSequenciaMenu(Menu: TMainMenu);
Var
  I, J, K,
  PosMenu1,
  PosMenu2,
  PosMenu3 : Integer;
Const
  Alfabeto : String = 'ABCDEFGHIJKLMNOPQRSTUVXYWZ';
begin
  if Menu is TMainMenu then begin
    PosMenu1 := 1;
    for I := 0 to Menu.Items.Count - 1 do begin
      if ((Menu.Items[I].Visible) and (Menu.Items[I].Enabled)) then begin
        Menu.Items[I].Caption := '&' + Alfabeto[PosMenu1] + ' - ' + Trim(Menu.Items[I].Caption);
        Inc(PosMenu1);
        PosMenu2 := 1;
        for J := 0 to Menu.Items[I].Count - 1 do begin
          if ((Menu.Items[I].Items[J].Visible) and (Menu.Items[I].Items[J].Enabled)) then begin
            if Pos('&', Menu.Items[I].Items[J].Caption) = 0 then begin
              Menu.Items[I].Items[J].Caption := '&' + Alfabeto[PosMenu2] + ' - ' + Trim(Menu.Items[I].Items[J].Caption);
              Inc(PosMenu2);
              PosMenu3 := 1;
              for K := 0 to Menu.Items[I].Items[J].Count - 1 do begin
                if ((Menu.Items[I].Items[J].Items[K].Visible) and (Menu.Items[I].Items[J].Items[K].Enabled)) then begin
                  if Pos('&', Menu.Items[I].Items[J].Items[K].Caption) = 0 then begin
                    Menu.Items[I].Items[J].Items[K].Caption := '&' + Alfabeto[PosMenu3] + ' - ' + Trim(Menu.Items[I].Items[J].Items[K].Caption);
                    Inc(PosMenu3);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end else begin
    DisplayMsg(MSG_WAR, 'Menu não Específicado, Verifique!');
    Exit;
  end;
end;

end.
