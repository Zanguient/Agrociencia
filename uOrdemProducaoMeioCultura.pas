unit uOrdemProducaoMeioCultura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, JvExStdCtrls, JvEdit, JvValidateEdit, Vcl.Mask,
  JvExMask, JvToolEdit, Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, Vcl.Menus,
  Vcl.ImgList, uConstantes;

type
  TfrmOrdemProducaoMeioCultura = class(TForm)
    pnDados: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    btNovo: TBitBtn;
    btExcluir: TBitBtn;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    edt_DataInicio: TJvDateEdit;
    Label15: TLabel;
    btGravar: TBitBtn;
    btn_Cancelar: TBitBtn;
    Panel2: TPanel;
    GridPanel1: TGridPanel;
    gbMeioCultura: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edt_CodigoMeioCultura: TButtonedEdit;
    edt_DescricaoMeioCultura: TEdit;
    edt_QuantidadeMeioCultura: TJvValidateEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    edt_CodigoRecipientes: TButtonedEdit;
    edt_NomeRecipiente: TEdit;
    edt_QuantidadeRecipiente: TJvValidateEdit;
    cds_MateriaPrima: TClientDataSet;
    Panel3: TPanel;
    pnPesquisa: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    ds_Pesquisa: TDataSource;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btAlterar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    cds_PesquisaDATAINICIO: TDateField;
    cds_PesquisaDATAFINAL: TDateField;
    cds_PesquisaID_MEIOCULTURA: TIntegerField;
    cds_PesquisaMEIOCULTURA: TStringField;
    ds_MateriaPrima: TDataSource;
    cds_MateriaPrimaIDPRODUTO: TIntegerField;
    cds_MateriaPrimaNOMEPRODUTO: TStringField;
    cds_MateriaPrimaQUANTIDADE: TFloatField;
    cds_MateriaPrimaID: TIntegerField;
    edt_MLPorRecipiente: TJvValidateEdit;
    Label17: TLabel;
    btBuscar: TBitBtn;
    Label18: TLabel;
    edt_CodigoEsterilizacao: TButtonedEdit;
    Label19: TLabel;
    edt_NomeEsterilizacao: TEdit;
    cbStatus: TComboBox;
    dg_MateriaPrima: TDBGrid;
    cds_MateriaPrimaUNIDADE: TStringField;
    edt_UnidadeMedida: TEdit;
    Label10: TLabel;
    cds_PesquisaENCERRADO: TBooleanField;
    PopupMenu: TPopupMenu;
    Etiquetas1: TMenuItem;
    OrdemdeProduo1: TMenuItem;
    ImageList1: TImageList;
    SpeedButton2: TSpeedButton;
    cds_PesquisaVOLUMEFINAL: TStringField;
    btRelatorio: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn_CancelarClick(Sender: TObject);
    procedure cds_PesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure btPesquisarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure edt_CodigoMeioCulturaRightButtonClick(Sender: TObject);
    procedure edt_CodigoMeioCulturaChange(Sender: TObject);
    procedure edt_CodigoRecipientesChange(Sender: TObject);
    procedure edt_CodigoRecipientesRightButtonClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure edtMateriaPrimaRightButtonClick(Sender: TObject);
    procedure edtMateriaPrimaChange(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure edt_CodigoEsterilizacaoChange(Sender: TObject);
    procedure edt_CodigoEsterilizacaoRightButtonClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edt_MLPorRecipienteChange(Sender: TObject);
    procedure cbStatusChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_CodigoEsterilizacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CodigoMeioCulturaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CodigoRecipientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMateriaPrimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btRelatorioClick(Sender: TObject);
    procedure ds_PesquisaDataChange(Sender: TObject; Field: TField);
    procedure OrdemdeProduo1Click(Sender: TObject);
    procedure Etiquetas1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function AtualizarEdits(Limpar : Boolean) : Boolean;
    function Alterar : Boolean;
    procedure Cancelar;
    { Private declarations }
  public
    { Public declarations }
    Parametros : TPARAMETROS;
    procedure Filtrar;
    procedure CarregarDados;
    procedure BuscaMateriaPrima;
    procedure InvertePaineis;
    procedure DeletarOrdemProducao;
    procedure ImprimirEtiqueta;
    procedure SelecionaMeioCultura;
    procedure SelecionaRecipiente;
    procedure SelecionaMateriaPrima;
    procedure SelecionaEsterilizacao;
  end;

var
  frmOrdemProducaoMeioCultura: TfrmOrdemProducaoMeioCultura;

implementation
uses
  uFWConnection,
  uBeanProdutos,
  uDMUtil,
  uBeanProdutoComposicao,
  uSeleciona,
  uFuncoes,
  uMensagem,
  uBeanUsuario,
  uBeanUnidadeMedida,
  uBeanOrdemProducaoMC,
  uBeanOrdemProducaoMC_Itens,
  uBeanEsterilizacao, uBeanControleEstoque, uBeanControleEstoqueProduto;
{$R *.dfm}

procedure TfrmOrdemProducaoMeioCultura.btBuscarClick(Sender: TObject);
begin
  BuscaMateriaPrima;
end;

procedure TfrmOrdemProducaoMeioCultura.btExcluirClick(Sender: TObject);
begin
  if not cds_MateriaPrima.IsEmpty then
    cds_MateriaPrima.Delete;
end;

procedure TfrmOrdemProducaoMeioCultura.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOrdemProducaoMeioCultura.btGravarClick(Sender: TObject);
var
  FWC : TFWConnection;
  MC : TORDEMPRODUCAOMC;
  MI : TORDEMPRODUCAOMC_ITENS;
  FecharTela : Boolean;
begin

  if Length(Trim(edt_NomeEsterilizacao.Text)) = 0 then begin
    DisplayMsg(MSG_WAR, 'Obrigatório informar a Esterilização, Verifique!');
    if edt_CodigoEsterilizacao.CanFocus then
      edt_CodigoEsterilizacao.SetFocus;
    Exit;
  end;

  try
    StrToDate(edt_DataInicio.Text);
  except
    DisplayMsg(MSG_WAR, 'Data de Início Inválida, Verifique!');
    if edt_DataInicio.CanFocus then
      edt_DataInicio.SetFocus;
    Exit;
  end;

  if Length(Trim(edt_DescricaoMeioCultura.Text)) = 0 then begin
    DisplayMsg(MSG_WAR, 'Obrigatório informar o Meio de Cultura, Verifique!');
    if edt_CodigoMeioCultura.CanFocus then
      edt_CodigoMeioCultura.SetFocus;
    Exit;
  end;

  if Length(Trim(edt_NomeRecipiente.Text)) = 0 then begin
    DisplayMsg(MSG_WAR, 'Obrigatório informar o Recipiente, Verifique!');
    if edt_CodigoRecipientes.CanFocus then
      edt_CodigoRecipientes.SetFocus;
    Exit;
  end;

  FWC := TFWConnection.Create;
  MC  := TORDEMPRODUCAOMC.Create(FWC);
  MI  := TORDEMPRODUCAOMC_ITENS.Create(FWC);

  FecharTela := False;

  try
    try

      MC.ID_RECIPIENTE.Value      := StrToInt(edt_CodigoRecipientes.Text);
      MC.QUANTRECIPIENTES.Value   := edt_QuantidadeRecipiente.Value;
      MC.MLRECIPIENTE.Value       := edt_MLPorRecipiente.Value;
      MC.ID_USUARIOEXECUTAR.Value := USUARIO.CODIGO;
      MC.ID_USUARIO.Value         := USUARIO.CODIGO;
      MC.ID_PRODUTO.Value         := StrToInt(edt_CodigoMeioCultura.Text);
      MC.QUANTPRODUTO.Value       := edt_QuantidadeMeioCultura.Value;
      MC.DATAINICIO.Value         := edt_DataInicio.Date;
      MC.DATAHORA.Value           := Now;
      MC.ENCERRADO.Value          := False;
      MC.ID_ESTERILIZACAO.Value   := StrToInt(edt_CodigoEsterilizacao.Text);

      if pnDados.Tag > 0 then begin
        MC.ID.Value               := pnDados.Tag;
        MC.Update;
      end else begin
        MC.Insert;
      end;

      cds_MateriaPrima.First;
      while not cds_MateriaPrima.Eof do begin
        if not cds_MateriaPrimaID.IsNull then begin
          MI.SelectList('ID = ' + cds_MateriaPrimaID.AsString);
          if MI.Count > 0 then begin
            MI.ID.Value         := cds_MateriaPrimaID.Value;
            MI.ID_PRODUTO.Value := cds_MateriaPrimaIDPRODUTO.Value;
            MI.QUANTIDADE.Value := cds_MateriaPrimaQUANTIDADE.Value;
            MI.Update;
          end else begin
            MI.ID.Value         := cds_MateriaPrimaID.Value;
            MI.Delete;
          end;
        end else begin
          MI.ID.Value                       := cds_MateriaPrimaID.Value;
          MI.ID_ORDEMPRODUCAOMC.Value       := MC.ID.Value;
          MI.ID_PRODUTO.Value               := cds_MateriaPrimaIDPRODUTO.Value;
          MI.QUANTIDADE.Value               := cds_MateriaPrimaQUANTIDADE.Value;
          MI.Insert;
        end;
        cds_MateriaPrima.Next;
      end;

      FWC.Commit;

      if Parametros.Codigo = 0 then begin
        InvertePaineis;
        CarregarDados;
      end else
        FecharTela := True;

    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao Gravar Dados!', '', e.Message);
      end;
    end;
  finally
    FreeAndNil(MI);
    FreeAndNil(MC);
    FreeAndNil(FWC);
  end;

  if FecharTela then
    Close;

end;

procedure TfrmOrdemProducaoMeioCultura.btNovoClick(Sender: TObject);
begin
  if not cds_MateriaPrima.Locate(cds_MateriaPrimaIDPRODUTO.FieldName, edtMateriaPrima.Text, []) then begin
    cds_MateriaPrima.Append;
    cds_MateriaPrimaIDPRODUTO.Value  := StrToInt(edtMateriaPrima.Text);
    cds_MateriaPrimaNOMEPRODUTO.Value:= edtNomeMateriaPrima.Text;
    cds_MateriaPrimaQUANTIDADE.Value := edt_Quantidade.Value;
    cds_MateriaPrimaUNIDADE.Value    := edt_UnidadeMedida.Text;
    cds_MateriaPrima.Post;

    edtMateriaPrima.Clear;
    edt_Quantidade.Clear;
  end else
    DisplayMsg(MSG_WAR, 'Materia Prima ' + edtMateriaPrima.Text + ' - ' + edtNomeMateriaPrima.Text + ' já Adicionado, Verifique!');
end;

procedure TfrmOrdemProducaoMeioCultura.btn_CancelarClick(Sender: TObject);
begin
  Cancelar;
end;

function TfrmOrdemProducaoMeioCultura.Alterar : Boolean;
Var
  FWC   : TFWConnection;
  OPMC  : TORDEMPRODUCAOMC;
begin

  Result := False;

  if not cds_Pesquisa.IsEmpty then begin

    FWC   := TFWConnection.Create;
    OPMC  := TORDEMPRODUCAOMC.Create(FWC);
    try
      try
        OPMC.SelectList('ID = ' + cds_PesquisaID.AsString);
        if OPMC.Count = 1 then begin
          if TORDEMPRODUCAOMC(OPMC.Itens[0]).ENCERRADO.Value then begin
            DisplayMsg(MSG_ERR, 'Ordem de Produção já Encerrada, Não pode ser Alterada!');
            Exit;
          end;
        end;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_ERR, 'Erro ao Verificar Ordem de Produção, Verifique!', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(OPMC);
      FreeAndNil(FWC);
    end;

    if AtualizarEdits(False) then begin//Se Conseguiu Carregar os Dados Inverte os Painéis
      InvertePaineis;
      Result := True;
      AutoSizeDBGrid(dg_MateriaPrima);
    end;
  end;
end;

function TfrmOrdemProducaoMeioCultura.AtualizarEdits(Limpar: Boolean): Boolean;
var
  FWC : TFWConnection;
  MC : TORDEMPRODUCAOMC;
  MI : TORDEMPRODUCAOMC_ITENS;
  PR : TPRODUTO;
  UN : TUNIDADEMEDIDA;
  E  : TESTERILIZACAO;
  I  : Integer;
begin

  Result := False;

  if Limpar then begin

    btGravar.Tag := 0;
    pnDados.Tag := 0;
    edt_DataInicio.Clear;
    edt_CodigoEsterilizacao.Clear;
    edt_NomeEsterilizacao.Clear;
    edt_MLPorRecipiente.Clear;
    edt_CodigoMeioCultura.Clear;
    edt_DescricaoMeioCultura.Clear;
    edt_QuantidadeMeioCultura.Clear;
    edt_CodigoRecipientes.Clear;
    edt_NomeRecipiente.Clear;
    edt_QuantidadeRecipiente.Clear;
    edtMateriaPrima.Clear;
    edtNomeMateriaPrima.Clear;
    edt_Quantidade.Clear;

    cds_MateriaPrima.EmptyDataSet;

    Result := True;

  end else begin

    btGravar.Tag  := cds_PesquisaID.Value;

    FWC := TFWConnection.Create;
    MC  := TORDEMPRODUCAOMC.Create(FWC);
    MI  := TORDEMPRODUCAOMC_ITENS.Create(FWC);
    PR  := TPRODUTO.Create(FWC);
    UN  := TUNIDADEMEDIDA.Create(FWC);
    E   := TESTERILIZACAO.Create(FWC);

    try
      try
        MC.SelectList('ID = ' + IntToStr(btGravar.Tag));
        if MC.Count > 0 then begin
          pnDados.Tag                      := TORDEMPRODUCAOMC(MC.Itens[0]).ID.Value;
          edt_CodigoMeioCultura.Text       := TORDEMPRODUCAOMC(MC.Itens[0]).ID_PRODUTO.asString;

          PR.SelectList('ID = ' + edt_CodigoMeioCultura.Text);
          if PR.Count > 0 then
            edt_DescricaoMeioCultura.Text  := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;

          edt_QuantidadeMeioCultura.Value  := TORDEMPRODUCAOMC(MC.Itens[0]).QUANTPRODUTO.Value;
          edt_CodigoRecipientes.Text       := TORDEMPRODUCAOMC(MC.Itens[0]).ID_RECIPIENTE.asString;
          edt_MLPorRecipiente.Value        := TORDEMPRODUCAOMC(MC.Itens[0]).MLRECIPIENTE.Value;
          edt_DataInicio.Date              := TORDEMPRODUCAOMC(MC.Itens[0]).DATAINICIO.Value;

          PR.SelectList('ID = ' + edt_CodigoRecipientes.Text);
          if PR.Count > 0 then
            edt_NomeRecipiente.Text        := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;

          edt_QuantidadeRecipiente.Value   := TORDEMPRODUCAOMC(MC.Itens[0]).QUANTRECIPIENTES.Value;
          edt_CodigoEsterilizacao.Text     := TORDEMPRODUCAOMC(MC.Itens[0]).ID_ESTERILIZACAO.asString;

          E.SelectList('ID = ' + edt_CodigoEsterilizacao.Text);
          if E.Count > 0 then
            edt_NomeEsterilizacao.Text     := TESTERILIZACAO(E.Itens[0]).METODO.asString;

          cds_MateriaPrima.EmptyDataSet;
          MI.SelectList('ID_ORDEMPRODUCAOMC = ' + IntToStr(TORDEMPRODUCAOMC(MC.Itens[0]).ID.Value));
          if MI.Count > 0 then begin
            for I := 0 to Pred(MI.Count) do begin
              cds_MateriaPrima.Append;
              cds_MateriaPrimaID.Value             := TORDEMPRODUCAOMC_ITENS(MI.Itens[I]).ID.Value;
              cds_MateriaPrimaIDPRODUTO.Value      := TORDEMPRODUCAOMC_ITENS(MI.Itens[I]).ID_PRODUTO.Value;

              PR.SelectList('ID = ' + cds_MateriaPrimaIDPRODUTO.AsString);
              if PR.Count > 0 then begin
                cds_MateriaPrimaNOMEPRODUTO.Value  := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;

                UN.SelectList('ID = ' + TPRODUTO(PR.Itens[0]).UNIDADEMEDIDA_ID.asSQL);
                if UN.Count > 0 then
                  cds_MateriaPrimaUNIDADE.Value    := TUNIDADEMEDIDA(UN.Itens[0]).SIMBOLO.asString;
              end;
              cds_MateriaPrimaQUANTIDADE.Value     := TORDEMPRODUCAOMC_ITENS(MI.Itens[I]).QUANTIDADE.Value;
              cds_MateriaPrima.Post;
            end;
          end;

          Result := True;

        end;
      except
        on E : Exception do begin
          DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados para Alteração.', '', E.Message);
          Exit;
        end;
      end;
    finally
      FreeAndNil(MI);
      FreeAndNil(MC);
      FreeAndNil(PR);
      FreeAndNil(UN);
      FreeAndNil(E);
      FreeAndNil(FWC);
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.btAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TfrmOrdemProducaoMeioCultura.btPesquisarClick(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmOrdemProducaoMeioCultura.btRelatorioClick(Sender: TObject);
begin
  PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmOrdemProducaoMeioCultura.BuscaMateriaPrima;
var
  FW  : TFWConnection;
  PC  : TPRODUTOCOMPOSICAO;
  C   : TPRODUTO;
  UN  : TUNIDADEMEDIDA;
  I: Integer;
begin
  if edt_DescricaoMeioCultura.Text = EmptyStr then begin
    DisplayMsg(MSG_INF, 'Informe o Meio de Cultura!');
    if edt_CodigoMeioCultura.CanFocus then edt_CodigoMeioCultura.SetFocus;
    Exit;
  end;
  if edt_QuantidadeMeioCultura.Value <= 0 then begin
    DisplayMsg(MSG_INF, 'Informe a Quantidade!');
    if edt_QuantidadeMeioCultura.CanFocus then edt_QuantidadeMeioCultura.SetFocus;
    Exit;
  end;

  FW := TFWConnection.Create;
  PC := TPRODUTOCOMPOSICAO.Create(FW);
  C  := TPRODUTO.Create(FW);
  UN := TUNIDADEMEDIDA.Create(FW);
  try
    PC.SelectList('ID_PRODUTO = ' + edt_CodigoMeioCultura.Text);
    if PC.Count > 0 then begin
      for I := 0 to Pred(PC.Count) do begin
        if cds_MateriaPrima.Locate(cds_MateriaPrimaIDPRODUTO.FieldName, TPRODUTOCOMPOSICAO(PC.Itens[I]).ID_COMPONENTE.Value, []) then
          cds_MateriaPrima.Edit
        else begin
          cds_MateriaPrima.Append;
          cds_MateriaPrimaIDPRODUTO.Value := TPRODUTOCOMPOSICAO(PC.Itens[I]).ID_COMPONENTE.Value;
        end;
        C.SelectList('ID = ' + cds_MateriaPrimaIDPRODUTO.AsString);
        if C.Count > 0 then begin
          cds_MateriaPrimaNOMEPRODUTO.Value := TPRODUTO(C.Itens[0]).DESCRICAO.Value;
          UN.SelectList('ID = ' + TPRODUTO(C.Itens[0]).UNIDADEMEDIDA_ID.asSQL);
          if UN.Count > 0 then
            cds_MateriaPrimaUNIDADE.Value   := TUNIDADEMEDIDA(UN.Itens[0]).SIMBOLO.asString;
        end;
        cds_MateriaPrimaQUANTIDADE.Value    := TPRODUTOCOMPOSICAO(PC.Itens[I]).QUANTIDADE.Value * edt_QuantidadeMeioCultura.Value;
        cds_MateriaPrima.Post;
      end;
    end;
  finally
    FreeAndNil(PC);
    FreeAndNil(C);
    FreeAndNil(UN);
    FreeAndNil(FW);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.CarregarDados;
var
  SQL : TFDQuery;
  FW : TFWConnection;
begin
  SQL := TFDQuery.Create(nil);
  FW  := TFWConnection.Create;
  cds_Pesquisa.EmptyDataSet;
  cds_Pesquisa.DisableControls;
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	MC.ID AS IDMC,');
    SQL.SQL.Add('	MC.DATAINICIO,');
    SQL.SQL.Add('	MC.DATAFIM,');
    SQL.SQL.Add('	P.ID AS IDPRODUTO,');
    SQL.SQL.Add('	P.DESCRICAO DESCRICAOPRODUTO,');
    SQL.SQL.Add('	(MC.QUANTPRODUTO || '' '' || UN.SIMBOLO) AS VOLUMEFINAL,');
    SQL.SQL.Add('	MC.ENCERRADO');
    SQL.SQL.Add('FROM ORDEMPRODUCAOMC MC');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON MC.ID_PRODUTO = P.ID');
    SQL.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON (UN.ID = P.UNIDADEMEDIDA_ID)');
    SQL.SQL.Add('WHERE 1 = 1');

    case Parametros.Acao of
      eNada : begin
        case cbStatus.ItemIndex of
          0 : SQL.SQL.Add('AND NOT MC.ENCERRADO');
          1 : SQL.SQL.Add('AND MC.ENCERRADO');
        end;
      end;
      eNovo : SQL.SQL.Add('AND 1 = 2'); //Não Precisa trazer nada na tela
      eAlterar : begin
        if Parametros.Codigo > 0 then //Parametro quando tela Chamada de outro Cadastro
          SQL.SQL.Add('AND MC.ID = ' + IntToStr(Parametros.Codigo));
      end;
    end;

    SQL.Connection := FW.FDConnection;
    SQL.Prepare;
    SQL.Open();

    if not SQL.IsEmpty then begin
      SQL.First;
      while not SQL.Eof do begin
        cds_Pesquisa.Append;
        cds_PesquisaID.Value             := SQL.FieldByName('IDMC').AsInteger;
        cds_PesquisaDATAINICIO.Value     := SQL.FieldByName('DATAINICIO').AsDateTime;
        cds_PesquisaDATAFINAL.Value      := SQL.FieldByName('DATAFIM').AsDateTime;
        cds_PesquisaID_MEIOCULTURA.Value := SQL.FieldByName('IDPRODUTO').AsInteger;
        cds_PesquisaMEIOCULTURA.Value    := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
        cds_PesquisaVOLUMEFINAL.Value    := SQL.FieldByName('VOLUMEFINAL').Value;
        cds_PesquisaENCERRADO.Value      := SQL.FieldByName('ENCERRADO').AsBoolean;
        cds_Pesquisa.Post;

        SQL.Next;
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FW);
    cds_Pesquisa.EnableControls;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;

  if Parametros.Codigo > 0 then //Se Foi Chamada de outra Tela Fecha.
    Close;

  InvertePaineis;
end;

procedure TfrmOrdemProducaoMeioCultura.cbStatusChange(Sender: TObject);
begin
  CarregarDados;
end;

procedure TfrmOrdemProducaoMeioCultura.cds_PesquisaFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
Var
  I : Integer;
begin
  Accept := False;
  for I := 0 to DataSet.Fields.Count - 1 do begin
    if not DataSet.Fields[I].IsNull then begin
      if Pos(AnsiLowerCase(edPesquisa.Text),AnsiLowerCase(DataSet.Fields[I].AsVariant)) > 0 then begin
        Accept := True;
        Break;
      end;
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.DeletarOrdemProducao;
var
  FWC : TFWConnection;
  MC  : TORDEMPRODUCAOMC;
begin

  FWC := TFWConnection.Create;
  MC  := TORDEMPRODUCAOMC.Create(FWC);

  try
    try
      MC.ID.Value := cds_PesquisaID.Value;
      MC.Delete;

      FWC.Commit;

      CarregarDados;

    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao excluir Ordem de Produção!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(MC);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.ds_PesquisaDataChange(Sender: TObject;
  Field: TField);
begin
  btAlterar.Enabled := not cds_PesquisaENCERRADO.Value;
  SpeedButton2.Enabled := not cds_PesquisaENCERRADO.Value;
end;

procedure TfrmOrdemProducaoMeioCultura.edtMateriaPrimaChange(Sender: TObject);
begin
  edtNomeMateriaPrima.Clear;
end;

procedure TfrmOrdemProducaoMeioCultura.edtMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaMateriaPrima;
end;

procedure TfrmOrdemProducaoMeioCultura.edtMateriaPrimaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMateriaPrima;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoEsterilizacaoChange(
  Sender: TObject);
begin
  edt_NomeEsterilizacao.Clear;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoEsterilizacaoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaEsterilizacao;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoEsterilizacaoRightButtonClick(
  Sender: TObject);
begin
  SelecionaEsterilizacao;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoMeioCulturaChange(
  Sender: TObject);
begin
  edt_DescricaoMeioCultura.Clear;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoMeioCulturaKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaMeioCultura;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoMeioCulturaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMeioCultura;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoRecipientesChange(
  Sender: TObject);
begin
  edt_NomeRecipiente.Clear;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoRecipientesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then SelecionaRecipiente;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_CodigoRecipientesRightButtonClick(
  Sender: TObject);
begin
  SelecionaRecipiente;
end;

procedure TfrmOrdemProducaoMeioCultura.edt_MLPorRecipienteChange(
  Sender: TObject);
begin
  if Panel2.Tag = 0 then begin
    Panel2.Tag := 1;
    try
      if Sender = edt_MLPorRecipiente then begin
        if (edt_MLPorRecipiente.Value > 0) and (edt_QuantidadeMeioCultura.Value > 0) then
          edt_QuantidadeRecipiente.Value := (edt_QuantidadeMeioCultura.Value / edt_MLPorRecipiente.Value) * 1000;
      end
      else if Sender = edt_QuantidadeRecipiente then begin
        if (edt_QuantidadeRecipiente.Value > 0) and (edt_QuantidadeMeioCultura.Value > 0) then
          edt_MLPorRecipiente.Value := edt_QuantidadeMeioCultura.Value / (edt_QuantidadeRecipiente.Value / 1000);
      end
      else if Sender = edt_QuantidadeMeioCultura then begin
        if (edt_MLPorRecipiente.Value > 0) and (edt_QuantidadeMeioCultura.Value > 0) then
          edt_QuantidadeRecipiente.Value := (edt_QuantidadeMeioCultura.Value / edt_MLPorRecipiente.Value) * 1000;
      end;
    finally
      Panel2.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.Etiquetas1Click(Sender: TObject);
begin
  if Etiquetas1.Tag = 0 then begin
    Etiquetas1.Tag := 1;
    try
      ImprimirEtiqueta;
    finally
      Etiquetas1.Tag := 0;
    end;
  end;

end;

procedure TfrmOrdemProducaoMeioCultura.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := edPesquisa.Text <> EmptyStr;
end;

procedure TfrmOrdemProducaoMeioCultura.FormCreate(Sender: TObject);
begin
  Parametros.Codigo := 0;
  Parametros.Acao   := eNada;
  cds_Pesquisa.CreateDataSet;
  cds_MateriaPrima.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmOrdemProducaoMeioCultura.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if pnPesquisa.Visible then begin
    case Key of
      VK_ESCAPE : Close;
      VK_RETURN : begin
        if edPesquisa.Focused then begin
          Filtrar;
        end else begin
          if edPesquisa.CanFocus then begin
            edPesquisa.SetFocus;
            edPesquisa.SelectAll;
          end;
        end;
      end;
      VK_F5 : CarregarDados;
      VK_UP : begin
        if not ((cds_Pesquisa.IsEmpty) or (gdPesquisa.Focused)) then begin
          if cds_Pesquisa.RecNo > 1 then
            cds_Pesquisa.Prior;
        end;
      end;
      VK_DOWN : begin
        if not ((cds_Pesquisa.IsEmpty) or (gdPesquisa.Focused)) then begin
          if cds_Pesquisa.RecNo < cds_Pesquisa.RecordCount then
            cds_Pesquisa.Next;
        end;
      end;
    end;
  end else begin
    case Key of
      VK_ESCAPE : Cancelar;
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.FormShow(Sender: TObject);
begin

  CarregarDados;

  case Parametros.Acao of
    eNada : AutoSizeDBGrid(gdPesquisa);
    eAlterar : begin
      if Parametros.Codigo > 0 then begin
        if Parametros.Codigo = cds_PesquisaID.AsInteger then begin
          if not Alterar then
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
        end else
          PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end else
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.ImprimirEtiqueta;
var
  FWC   : TFWConnection;
  SQL   : TFDQuery;
begin
  FWC   := TFWConnection.Create;
  SQL   := TFDQuery.Create(nil);
  try
    try

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('CASE CHAR_LENGTH(CAST(OPMC.ID AS VARCHAR))');
      SQL.SQL.Add('	WHEN 1 THEN ''00'' || CAST(OPMC.ID AS VARCHAR)');
      SQL.SQL.Add('	WHEN 2 THEN ''0'' || CAST(OPMC.ID AS VARCHAR)');
      SQL.SQL.Add('	ELSE CAST(OPMC.ID AS VARCHAR) END AS ID,');
      SQL.SQL.Add('	OPMC.DATAHORA,');
      SQL.SQL.Add('	MC.CODIGO AS CODIGOMC,');
      SQL.SQL.Add('	PR.DESCRICAO AS TIPOFRASCO,');
      SQL.SQL.Add('	OPMC.QUANTRECIPIENTES,');
      SQL.SQL.Add('	E.METODO AS METODOESTERILIZACAO');
      SQL.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
      SQL.SQL.Add('INNER JOIN MEIOCULTURA MC ON OPMC.ID_PRODUTO = MC.ID_PRODUTO');
      SQL.SQL.Add('INNER JOIN ESTERILIZACAO E ON OPMC.ID_ESTERILIZACAO = E.ID');
      SQL.SQL.Add('INNER JOIN PRODUTO PR ON OPMC.ID_RECIPIENTE = PR.ID');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPMC.ID = :ID');
      SQL.ParamByName('ID').DataType  := ftInteger;
      SQL.ParamByName('ID').AsInteger := cds_PesquisaID.AsInteger;
      SQL.Connection := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open();

      if not SQL.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := SQL;
        DMUtil.ImprimirRelatorio('frEtiquetaOPMC.fr3');
      end else begin
        DisplayMsg(MSG_WAR, 'Não há dados para Exibir, Verifique os Filtros!');
        Exit;
      end;
    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao montar Dados para o Relatório.', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.InvertePaineis;
var
  FW : TFWConnection;
  U  : TUSUARIO;
begin
  pnPesquisa.Visible               := not pnPesquisa.Visible;
  pnBotoesVisualizacao.Visible     := pnDados.Visible;
  pnDados.Visible                  := not pnDados.Visible;
  pnBotoesEdicao.Visible           := pnDados.Visible;

  if pnDados.Visible then begin
    FW := TFWConnection.Create;
    U  := TUSUARIO.Create(FW);
    try
      U.SelectList('ID = ' + QuotedStr(IntToStr(USUARIO.CODIGO)));
      if U.Count > 0 then begin
        btNovo.Enabled    := TUSUARIO(U.Itens[0]).PERMITEPRODUTOALEMCOMPOSICAO.Value;
        btExcluir.Enabled := TUSUARIO(U.Itens[0]).PERMITEPRODUTOALEMCOMPOSICAO.Value;
      end;
    finally
      FreeAndNil(U);
      FreeAndNil(FW);
    end;

    if edt_CodigoEsterilizacao.CanFocus then
      edt_CodigoEsterilizacao.SetFocus;
  end;
  AutoSizeDBGrid(dg_MateriaPrima);
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmOrdemProducaoMeioCultura.OrdemdeProduo1Click(Sender: TObject);
begin
  if OrdemdeProduo1.Tag = 0 then begin
    OrdemdeProduo1.Tag := 1;
    try
      ImprimirOPMC(cds_PesquisaID.AsInteger);
    finally
      OrdemdeProduo1.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.SelecionaEsterilizacao;
var
  FWC : TFWConnection;
  E   : TESTERILIZACAO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  E      := TESTERILIZACAO.Create(FWC);
  try
    edt_CodigoEsterilizacao.Tag := DMUtil.Selecionar(E, edt_CodigoEsterilizacao.Text, Filtro);
    if edt_CodigoEsterilizacao.Tag > 0 then begin
      E.SelectList('id = ' + IntToStr(edt_CodigoEsterilizacao.Tag));
      if E.Count > 0 then begin
        edt_CodigoEsterilizacao.Text     := TESTERILIZACAO(E.Itens[0]).ID.asString;
        edt_NomeEsterilizacao.Text       := TESTERILIZACAO(E.Itens[0]).METODO.asString;
      end;
    end;
  finally
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.SelecionaMateriaPrima;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  UN  : TUNIDADEMEDIDA;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  UN     := TUNIDADEMEDIDA.Create(FWC);
  try
    Filtro := 'finalidade in (2,5)';
    edtMateriaPrima.Tag := DMUtil.Selecionar(P, edtMateriaPrima.Text, Filtro);
    if edtMateriaPrima.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMateriaPrima.Tag));
      if P.Count > 0 then begin
        edtMateriaPrima.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edtNomeMateriaPrima.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
        UN.SelectList('ID = ' + TPRODUTO(P.Itens[0]).UNIDADEMEDIDA_ID.asSQL);
        if UN.Count > 0 then
          edt_UnidadeMedida.Text := TUNIDADEMEDIDA(UN.Itens[0]).SIMBOLO.asString;
        if edt_Quantidade.CanFocus then edt_Quantidade.SetFocus;
      end;
    end;
  finally
    FreeAndNil(UN);
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.SelecionaMeioCultura;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  try
    edt_CodigoMeioCultura.Tag := DMUtil.SelecionarMeioCultura(0, 0, edt_CodigoMeioCultura.Text);
    if edt_CodigoMeioCultura.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edt_CodigoMeioCultura.Tag));
      if P.Count > 0 then begin
        edt_CodigoMeioCultura.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edt_DescricaoMeioCultura.Text  := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.SelecionaRecipiente;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  try
    Filtro := 'finalidade = 4';
    edt_CodigoRecipientes.Tag := DMUtil.Selecionar(P, edt_CodigoRecipientes.Text, Filtro);
    if edt_CodigoRecipientes.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edt_CodigoRecipientes.Tag));
      if P.Count > 0 then begin
        edt_CodigoRecipientes.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edt_NomeRecipiente.Text        := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.SpeedButton1Click(Sender: TObject);
begin
  if AtualizarEdits(True) then //Se Conseguiu Carregar os Dados Inverte os Painéis
    InvertePaineis;
end;

procedure TfrmOrdemProducaoMeioCultura.SpeedButton2Click(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Deseja Realmente Excluir a Ordem de Produção Nº ' + cds_PesquisaID.AsString + '?');

    if ResultMsgModal = mrYes then
      DeletarOrdemProducao;
  end;
end;

end.
