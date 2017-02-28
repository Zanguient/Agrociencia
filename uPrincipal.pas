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
    ControledeQualidade1: TMenuItem;
    AgendaSemanal1: TMenuItem;
    Aniversariantes1: TMenuItem;
    CadastrodePlantas1: TMenuItem;
    ControledeQualidadePositivo1: TMenuItem;
    PlanejamentodaProduo1: TMenuItem;
    procedure Usuario1Click(Sender: TObject);
    procedure miSairClick(Sender: TObject);
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
    procedure ControledeQualidade1Click(Sender: TObject);
    procedure AgendaSemanal1Click(Sender: TObject);
    procedure Aniversariantes1Click(Sender: TObject);
    procedure CadastrodePlantas1Click(Sender: TObject);
    procedure ControledeQualidadePositivo1Click(Sender: TObject);
    procedure Agendamento1Click(Sender: TObject);
  private
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
  uControleQualidade,
  uRelAgendaSemanal,
  uRelAniversariantes,
  uRelCadastrodePlantas,
  uControleQualidadePositivo,
  uPlanejamentoProducao;

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

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_F11) then begin
    DESIGNREL       := not DESIGNREL;
    if DESIGNREL then
      DisplayMsg(MSG_INF, 'Design de Relatórios Ativado!')
    else
      DisplayMsg(MSG_INF, 'Design de Relatórios Desativado!');
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  if FileExists(DirInstall + 'Imagens\Fundo.jpg') then
    IMFundo.Picture.LoadFromFile(DirInstall + 'Imagens\Fundo.jpg');

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
var
  DirBkp : String;
begin
  DisplayMsg(MSG_WAIT, 'Realizando Backup');

  DirBkp := ExtractFilePath(Application.ExeName) +  'backups\';

 if not DirectoryExists(DirBkp) then
   CreateDir(DirBkp);

 if not FileExists(ExtractFilePath(Application.ExeName) + 'pg_dump.exe') then begin
   DisplayMsg(MSG_INF, 'Executavel do Backup (PG_Dump.exe) não encontrado na pasta do executável!' + sLineBreak + 'Para continuar o executável é necessário!');
   Exit;
 end;

 ShellExecute(0, 'OPEN', pchar( ExtractFilePath(Application.ExeName) + 'pg_dump.exe'), pchar(' --host ' + CONEXAO.Server + ' --port 5432 --username ' + CONEXAO.User_Name + ' --format custom --file "' + CONEXAO.Database + '_' + FormatDateTime('yyyymmdd_hhmm', Now) + '.backup" ' + CONEXAO.Database), pchar(DirBkp), SW_SHOWNORMAL);

 DisplayMsgFinaliza;
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

procedure TfrmPrincipal.ControledeQualidade1Click(Sender: TObject);
begin
  if frmControleQualidade = nil then
    frmControleQualidade := TfrmControleQualidade.Create(Self);
  try
    frmControleQualidade.ShowModal;
  finally
    FreeAndNil(frmControleQualidade);
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

procedure TfrmPrincipal.miSairClick(Sender: TObject);
begin
  DisplayMsg(MSG_CONF, 'Deseja realmente sair do sistema?', 'Sair do Sistema');

  if (ResultMsgModal = mrYes) then
    Close;
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
