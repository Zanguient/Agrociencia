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
    Recipientes1: TMenuItem;
    Observaes1: TMenuItem;
    Cliente1: TMenuItem;
    Produtos1: TMenuItem;
    Estoque1: TMenuItem;
    ComposiodeMeiosdeCultura1: TMenuItem;
    procedure Usuario1Click(Sender: TObject);
    procedure miSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RedefinirSenhaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfigGerais1Click(Sender: TObject);
    procedure BackupdoBancodeDados1Click(Sender: TObject);
    procedure UnidadedeMedida1Click(Sender: TObject);
    procedure Recipientes1Click(Sender: TObject);
    procedure Observaes1Click(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Estoque1Click(Sender: TObject);
    procedure ComposiodeMeiosdeCultura1Click(Sender: TObject);
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
  uCadastroRecipientes,
  uBeanObservacao,
  uCadastroObservacoes,
  uCadastroCliente,
  uCadastroProdutos,
  uMovimentacaoEstoque,
  uComposicaoMeioCultura;

{$R *.dfm}

procedure TfrmPrincipal.DefinirPermissoes;
begin
  RedefinirSenha.Visible  := False; //Usuário 0 é Administrador e não tem Cadastro
  if USUARIO.CODIGO > 0 then begin
    DefinePermissaoMenu(MainMenu1);
    miSair.Visible          := True;
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

  Caption := 'Sistema Agrociência - Usuário: ' + IntToStr(USUARIO.CODIGO) + ' - ' + USUARIO.NOME;
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

procedure TfrmPrincipal.miSairClick(Sender: TObject);
begin
  DisplayMsg(MSG_CONF, 'Deseja realmente sair do sistema?', 'Sair do Sistema');

  if (ResultMsgModal = mrYes) then
    Close;
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

procedure TfrmPrincipal.Recipientes1Click(Sender: TObject);
begin
  try
    if frmCadastroRecipientes = nil then
      frmCadastroRecipientes     := TfrmCadastroRecipientes.Create(Self);
    frmCadastroRecipientes.ShowModal;
  finally
    FreeAndNil(frmCadastroRecipientes);
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
