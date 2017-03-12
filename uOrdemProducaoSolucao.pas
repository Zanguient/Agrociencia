unit uOrdemProducaoSolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, Datasnap.DBClient, JvExStdCtrls, JvEdit,
  JvValidateEdit, Vcl.Mask, JvExMask, JvToolEdit, FireDAC.Comp.Client,
  frxDBSet, uConstantes;

type
  TfrmOrdemProducaoSolucao = class(TForm)
    Panel3: TPanel;
    pnPesquisa: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    cbStatus: TComboBox;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btAlterar: TSpeedButton;
    btNovo: TSpeedButton;
    btRelatorio: TSpeedButton;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    btExcluir: TSpeedButton;
    ds_Pesquisa: TDataSource;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaID_PRODUTO: TIntegerField;
    cds_PesquisaPRODUTO: TStringField;
    cds_PesquisaDATAPREVISAO: TDateField;
    cds_PesquisaQUANTIDADE: TCurrencyField;
    pnDados: TPanel;
    gbMateriaPrima: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    btAdd: TBitBtn;
    btDel: TBitBtn;
    btBuscar: TBitBtn;
    edt_UnidadeMedida: TEdit;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btn_Cancelar: TBitBtn;
    Panel5: TPanel;
    btGravar: TBitBtn;
    gdMateriaPrima: TDBGrid;
    gbSolucaoEstoque: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edt_CodigoSolucaoEstoque: TButtonedEdit;
    edt_DescricaoSolucaoEstoque: TEdit;
    edt_QuantidadeSolucaoEstoque: TJvValidateEdit;
    edt_DataInicio: TJvDateEdit;
    Label15: TLabel;
    cds_MateriaPrima: TClientDataSet;
    cds_MateriaPrimaIDPRODUTO: TIntegerField;
    cds_MateriaPrimaNOMEPRODUTO: TStringField;
    cds_MateriaPrimaQUANTIDADE: TFloatField;
    cds_MateriaPrimaID: TIntegerField;
    cds_MateriaPrimaUNIDADE: TStringField;
    ds_MateriaPrima: TDataSource;
    cds_PesquisaENCERRADO: TBooleanField;
    btEncerrar: TSpeedButton;
    mmObservacao: TMemo;
    Label1: TLabel;
    procedure edt_CodigoSolucaoEstoqueChange(Sender: TObject);
    procedure edt_CodigoSolucaoEstoqueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CodigoSolucaoEstoqueRightButtonClick(Sender: TObject);
    procedure edtMateriaPrimaChange(Sender: TObject);
    procedure edtMateriaPrimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMateriaPrimaRightButtonClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btn_CancelarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btEncerrarClick(Sender: TObject);
    procedure cbStatusChange(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure cds_PesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btRelatorioClick(Sender: TObject);
  private
    function AtualizarEdits(Limpar : Boolean) : Boolean;
    function Alterar : Boolean;
    procedure Cancelar;
    { Private declarations }
  public
    { Public declarations }
    Parametros : TPARAMETROS;
    procedure SelecionaSolucaoEstoque;
    procedure SelecionaMateriaPrima;
    procedure BuscaMateriaPrima;
    procedure InvertePaineis;
    procedure CarregarDados;
    procedure DeletarOrdemProducao;
    procedure Filtrar;
  end;

var
  frmOrdemProducaoSolucao: TfrmOrdemProducaoSolucao;

implementation

uses
  uFWConnection, uBeanProdutos, uDMUtil, uBeanUnidadeMedida, uMensagem,
  uBeanProdutoComposicao, uBeanOrdemProducaoSolucao,
  uBeanOrdemProducaoSolucao_Itens, uFuncoes, uBeanControleEstoque,
  uBeanControleEstoqueProduto, uBeanUsuario;

{$R *.dfm}

{ TfrmOrdemProducaoSolucao }

function TfrmOrdemProducaoSolucao.Alterar: Boolean;
Var
  FWC   : TFWConnection;
  OPSOL : TORDEMPRODUCAOSOLUCAO;
begin

  Result := False;

  if not cds_Pesquisa.IsEmpty then begin

    FWC   := TFWConnection.Create;
    OPSOL := TORDEMPRODUCAOSOLUCAO.Create(FWC);
    try
      try
        OPSOL.SelectList('ID = ' + cds_PesquisaID.AsString);
        if OPSOL.Count = 1 then begin
          if TORDEMPRODUCAOSOLUCAO(OPSOL.Itens[0]).ENCERRADO.Value then begin
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
      FreeAndNil(OPSOL);
      FreeAndNil(FWC);
    end;

    if AtualizarEdits(False) then begin//Se Conseguiu Carregar os Dados Inverte os Painéis
      InvertePaineis;
      Result := True;
      AutoSizeDBGrid(gdMateriaPrima);
    end;
  end;
end;

function TfrmOrdemProducaoSolucao.AtualizarEdits(Limpar: Boolean) : Boolean;
var
  FWC : TFWConnection;
  SOL : TORDEMPRODUCAOSOLUCAO;
  SOLI: TORDEMPRODUCAOSOLUCAO_ITENS;
  PR  : TPRODUTO;
  UN  : TUNIDADEMEDIDA;
  I   : Integer;
begin

  Result := False;

  if Limpar then begin

    btGravar.Tag := 0;
    pnDados.Tag := 0;
    edt_DataInicio.Clear;
    edtMateriaPrima.Clear;
    edtNomeMateriaPrima.Clear;
    edt_Quantidade.Clear;
    edt_UnidadeMedida.Clear;
    edt_CodigoSolucaoEstoque.Clear;
    edt_DescricaoSolucaoEstoque.Clear;
    edt_QuantidadeSolucaoEstoque.Clear;
    mmObservacao.Clear;

    cds_MateriaPrima.EmptyDataSet;

    Result := True;

  end else begin

    btGravar.Tag  := cds_PesquisaID.Value;

    FWC  := TFWConnection.Create;
    SOL  := TORDEMPRODUCAOSOLUCAO.Create(FWC);
    SOLI := TORDEMPRODUCAOSOLUCAO_ITENS.Create(FWC);
    PR   := TPRODUTO.Create(FWC);
    UN   := TUNIDADEMEDIDA.Create(FWC);

    try
      try
        SOL.SelectList('ID = ' + IntToStr(btGravar.Tag));
        if SOL.Count > 0 then begin
          pnDados.Tag                        := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID.Value;
          edt_CodigoSolucaoEstoque.Text      := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID_PRODUTO.asString;

          PR.SelectList('ID = ' + edt_CodigoSolucaoEstoque.Text);
          if PR.Count > 0 then
            edt_DescricaoSolucaoEstoque.Text := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;

          edt_QuantidadeSolucaoEstoque.Value := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).QUANTIDADE.Value;
          edt_DataInicio.Date                := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).DATAPREVISAO.Value;
          mmObservacao.Text                  := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).OBSERVACAO.Value;

          cds_MateriaPrima.EmptyDataSet;
          SOLI.SelectList('ID_ORDEMPRODUCAOSOLUCAO = ' + IntToStr(TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID.Value));
          if SOLI.Count > 0 then begin
            for I := 0 to Pred(SOLI.Count) do begin
              cds_MateriaPrima.Append;
              cds_MateriaPrimaID.Value             := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).ID.Value;
              cds_MateriaPrimaIDPRODUTO.Value      := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).ID_PRODUTO.Value;

              PR.SelectList('ID = ' + cds_MateriaPrimaIDPRODUTO.AsString);
              if PR.Count > 0 then begin
                cds_MateriaPrimaNOMEPRODUTO.Value  := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;

                UN.SelectList('ID = ' + TPRODUTO(PR.Itens[0]).UNIDADEMEDIDA_ID.asSQL);
                if UN.Count > 0 then
                  cds_MateriaPrimaUNIDADE.Value    := TUNIDADEMEDIDA(UN.Itens[0]).SIMBOLO.asString;
              end;
              cds_MateriaPrimaQUANTIDADE.Value     := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).QUANTIDADE.Value;
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
      FreeAndNil(SOLI);
      FreeAndNil(SOL);
      FreeAndNil(PR);
      FreeAndNil(UN);
      FreeAndNil(FWC);
    end;
  end;
end;

procedure TfrmOrdemProducaoSolucao.btAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TfrmOrdemProducaoSolucao.btBuscarClick(Sender: TObject);
begin
  BuscaMateriaPrima;
end;

procedure TfrmOrdemProducaoSolucao.btEncerrarClick(Sender: TObject);
var
  FWC       : TFWConnection;
  SOL       : TORDEMPRODUCAOSOLUCAO;
  SOLI      : TORDEMPRODUCAOSOLUCAO_ITENS;
  CE        : TCONTROLEESTOQUE;
  CEP       : TCONTROLEESTOQUEPRODUTO;
  I         : Integer;
  Mensagem  : string;
begin

  if cds_PesquisaENCERRADO.Value then begin
    DisplayMsg(MSG_WAR, 'Ordem de Produção já foi encerrada!');
    Exit;
  end;

  DisplayMsg(MSG_INPUT_TEXT, 'Informe a Observação do Encerramento!');

  if ResultMsgModal = mrOk then begin

    Mensagem := ResultMsgInputText;

    FWC := TFWConnection.Create;
    SOL := TORDEMPRODUCAOSOLUCAO.Create(FWC);
    SOLI:= TORDEMPRODUCAOSOLUCAO_ITENS.Create(FWC);
    CE  := TCONTROLEESTOQUE.Create(FWC);
    CEP := TCONTROLEESTOQUEPRODUTO.Create(FWC);
    try
      FWC.StartTransaction;
      try
        SOL.SelectList('ID = ' + cds_PesquisaID.AsString);
        if SOL.Count > 0 then begin
          SOL.ID.Value                      := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID.Value;
          SOL.OBSERVACAOENCERRAMENTO.Value  := Mensagem;
          SOL.ID_USUARIOENCERRAMENTO.Value  := USUARIO.CODIGO;
          SOL.DATAENCERRAMENTO.Value        := Now;
          SOL.ENCERRADO.Value               := True;
          SOL.Update;

          SOLI.SelectList('ID_ORDEMPRODUCAOSOLUCAO = ' + TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID.asString);
          if SOLI.Count > 0 then begin
            CE.ID.isNull                    := True;
            CE.USUARIO_ID.Value             := USUARIO.CODIGO;
            CE.TIPOMOVIMENTACAO.Value       := 0;
            CE.CANCELADO.Value              := False;
            CE.DATAHORA.Value               := Now;
            CE.OBSERVACAO.Value             := 'Ordem de Produção de Solução de Estoque ' + cds_PesquisaID.AsString;
            CE.Insert;

            CEP.ID.isNull                   := True;
            CEP.CONTROLEESTOQUE_ID.Value    := CE.ID.Value;
            CEP.PRODUTO_ID.Value            := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID_PRODUTO.Value;
            CEP.QUANTIDADE.Value            := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).QUANTIDADE.Value;
            CEP.Insert;

            for I := 0 to Pred(SOLI.Count) do begin
              CEP.ID.isNull                 := True;
              CEP.CONTROLEESTOQUE_ID.Value  := CE.ID.Value;
              CEP.PRODUTO_ID.Value          := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).ID_PRODUTO.Value;
              CEP.QUANTIDADE.Value          := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).QUANTIDADE.Value * -1;
              CEP.Insert;
            end;
          end;
        end;

        FWC.Commit;

        CarregarDados;

      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_WAR, 'Erro ao Encerrar Ordem de Produção', '', E.Message);
          Exit;
        end;
      end;
    finally
      FreeAndNil(SOL);
      FreeAndNil(SOLI);
      FreeAndNil(CEP);
      FreeAndNil(CE);
      FreeAndNil(FWC);
    end;
  end;
end;

procedure TfrmOrdemProducaoSolucao.btDelClick(Sender: TObject);
begin
  if not cds_MateriaPrima.IsEmpty then
    cds_MateriaPrima.Delete;
end;

procedure TfrmOrdemProducaoSolucao.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOrdemProducaoSolucao.btGravarClick(Sender: TObject);
var
  FWC        : TFWConnection;
  SOL        : TORDEMPRODUCAOSOLUCAO;
  SOLI       : TORDEMPRODUCAOSOLUCAO_ITENS;
  FecharTela : Boolean;
begin

  if Length(Trim(edt_DescricaoSolucaoEstoque.Text)) = 0 then begin
    DisplayMsg(MSG_WAR, 'Obrigatório informar a Solução Estoque, Verifique!');
    if edt_CodigoSolucaoEstoque.CanFocus then
      edt_CodigoSolucaoEstoque.SetFocus;
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

  FWC   := TFWConnection.Create;
  SOL   := TORDEMPRODUCAOSOLUCAO.Create(FWC);
  SOLI  := TORDEMPRODUCAOSOLUCAO_ITENS.Create(FWC);

  FecharTela := False;

  try
    try

      SOL.ID_USUARIOINCLUSAO.Value      := USUARIO.CODIGO;
      SOL.ID_USUARIOENCERRAMENTO.Value  := USUARIO.CODIGO;
      SOL.ID_PRODUTO.Value              := StrToInt(edt_CodigoSolucaoEstoque.Text);
      SOL.QUANTIDADE.Value              := edt_QuantidadeSolucaoEstoque.Value;
      SOL.DATAPREVISAO.Value            := edt_DataInicio.Date;
      SOL.DATAINCLUSAO.Value            := Now;
      SOL.ENCERRADO.Value               := False;
      SOL.OBSERVACAO.Value              := mmObservacao.Text;

      if pnDados.Tag > 0 then begin
        SOL.ID.Value                    := pnDados.Tag;
        SOL.Update;
      end else begin
        SOL.Insert;
      end;

      cds_MateriaPrima.First;
      while not cds_MateriaPrima.Eof do begin
        if not cds_MateriaPrimaID.IsNull then begin
          SOLI.SelectList('ID = ' + cds_MateriaPrimaID.AsString);
          if SOLI.Count > 0 then begin
            SOLI.ID.Value         := cds_MateriaPrimaID.Value;
            SOLI.ID_PRODUTO.Value := cds_MateriaPrimaIDPRODUTO.Value;
            SOLI.QUANTIDADE.Value := cds_MateriaPrimaQUANTIDADE.Value;
            SOLI.Update;
          end else begin
            SOLI.ID.Value         := cds_MateriaPrimaID.Value;
            SOLI.Delete;
          end;
        end else begin
          SOLI.ID.Value                       := cds_MateriaPrimaID.Value;
          SOLI.ID_ORDEMPRODUCAOSOLUCAO.Value  := SOL.ID.Value;
          SOLI.ID_PRODUTO.Value               := cds_MateriaPrimaIDPRODUTO.Value;
          SOLI.QUANTIDADE.Value               := cds_MateriaPrimaQUANTIDADE.Value;
          SOLI.Insert;
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
    FreeAndNil(SOLI);
    FreeAndNil(SOL);
    FreeAndNil(FWC);
  end;

  if FecharTela then
    Close;

end;

procedure TfrmOrdemProducaoSolucao.btAddClick(Sender: TObject);
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

procedure TfrmOrdemProducaoSolucao.btn_CancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmOrdemProducaoSolucao.btPesquisarClick(Sender: TObject);
begin
  if btPesquisar.Tag = 0 then begin
    btPesquisar.Tag := 1;
    try
      Filtrar;
    finally
      btPesquisar.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducaoSolucao.btRelatorioClick(Sender: TObject);
begin
  if btRelatorio.Tag = 0 then begin
    btRelatorio.Tag := 1;
    try
      ImprimirOPSOL(cds_PesquisaID.AsInteger);
    finally
      btRelatorio.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducaoSolucao.BuscaMateriaPrima;
var
  FW  : TFWConnection;
  PC  : TPRODUTOCOMPOSICAO;
  C   : TPRODUTO;
  UN  : TUNIDADEMEDIDA;
  I: Integer;
begin
  if edt_DescricaoSolucaoEstoque.Text = EmptyStr then begin
    DisplayMsg(MSG_INF, 'Informe o Meio de Cultura!');
    if edt_CodigoSolucaoEstoque.CanFocus then edt_CodigoSolucaoEstoque.SetFocus;
    Exit;
  end;
  if edt_QuantidadeSolucaoEstoque.Value <= 0 then begin
    DisplayMsg(MSG_INF, 'Informe a Quantidade!');
    if edt_QuantidadeSolucaoEstoque.CanFocus then edt_QuantidadeSolucaoEstoque.SetFocus;
    Exit;
  end;

  FW := TFWConnection.Create;
  PC := TPRODUTOCOMPOSICAO.Create(FW);
  C  := TPRODUTO.Create(FW);
  UN := TUNIDADEMEDIDA.Create(FW);
  try
    PC.SelectList('ID_PRODUTO = ' + edt_CodigoSolucaoEstoque.Text);
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
        cds_MateriaPrimaQUANTIDADE.Value    := TPRODUTOCOMPOSICAO(PC.Itens[I]).QUANTIDADE.Value * (edt_QuantidadeSolucaoEstoque.Value / 1000);
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

procedure TfrmOrdemProducaoSolucao.Cancelar;
begin

  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;

  if Parametros.Codigo > 0 then //Se Foi Chamada de outra Tela Fecha.
    Close;

  InvertePaineis;
end;

procedure TfrmOrdemProducaoSolucao.CarregarDados;
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
    SQL.SQL.Add('	SOL.ID AS IDSOL,');
    SQL.SQL.Add('	SOL.DATAPREVISAO,');
    SQL.SQL.Add('	P.ID AS IDPRODUTO,');
    SQL.SQL.Add('	P.DESCRICAO DESCRICAOPRODUTO,');
    SQL.SQL.Add('	SOL.QUANTIDADE,');
    SQL.SQL.Add('	SOL.ENCERRADO');
    SQL.SQL.Add('FROM ORDEMPRODUCAOSOLUCAO SOL');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON SOL.ID_PRODUTO = P.ID');
    SQL.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON (UN.ID = P.UNIDADEMEDIDA_ID)');
    SQL.SQL.Add('WHERE 1 = 1');

    case Parametros.Acao of
      eNada : begin
        case cbStatus.ItemIndex of
          0 : SQL.SQL.Add('AND NOT SOL.ENCERRADO');
          1 : SQL.SQL.Add('AND SOL.ENCERRADO');
        end;
      end;
      eNovo : SQL.SQL.Add('AND 1 = 2'); //Não Precisa trazer nada na tela
      eAlterar : begin
        if Parametros.Codigo > 0 then //Parametro quando tela Chamada de outro Cadastro
          SQL.SQL.Add('AND SOL.ID = ' + IntToStr(Parametros.Codigo));
      end;
    end;

    SQL.Connection := FW.FDConnection;
    SQL.Prepare;
    SQL.Open();

    if not SQL.IsEmpty then begin
      SQL.First;
      while not SQL.Eof do begin
        cds_Pesquisa.Append;
        cds_PesquisaID.Value             := SQL.FieldByName('IDSOL').AsInteger;
        cds_PesquisaID_PRODUTO.Value     := SQL.FieldByName('IDPRODUTO').AsInteger;
        cds_PesquisaPRODUTO.Value        := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
        cds_PesquisaDATAPREVISAO.Value   := SQL.FieldByName('DATAPREVISAO').AsDateTime;
        cds_PesquisaQUANTIDADE.Value     := SQL.FieldByName('QUANTIDADE').Value;
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

procedure TfrmOrdemProducaoSolucao.cbStatusChange(Sender: TObject);
begin
  CarregarDados;
end;

procedure TfrmOrdemProducaoSolucao.cds_PesquisaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
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

procedure TfrmOrdemProducaoSolucao.DeletarOrdemProducao;
var
  FWC : TFWConnection;
  SOL  : TORDEMPRODUCAOSOLUCAO;
begin

  FWC := TFWConnection.Create;
  SOL := TORDEMPRODUCAOSOLUCAO.Create(FWC);

  try
    try
      SOL.ID.Value := cds_PesquisaID.Value;
      SOL.Delete;

      FWC.Commit;

      CarregarDados;

    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao excluir Ordem de Produção!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SOL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoSolucao.edtMateriaPrimaChange(Sender: TObject);
begin
  edtNomeMateriaPrima.Clear;
end;

procedure TfrmOrdemProducaoSolucao.edtMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaMateriaPrima;
end;

procedure TfrmOrdemProducaoSolucao.edtMateriaPrimaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMateriaPrima;
end;

procedure TfrmOrdemProducaoSolucao.edt_CodigoSolucaoEstoqueChange(
  Sender: TObject);
begin
  edt_DescricaoSolucaoEstoque.Clear;
end;

procedure TfrmOrdemProducaoSolucao.edt_CodigoSolucaoEstoqueKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaSolucaoEstoque;
end;

procedure TfrmOrdemProducaoSolucao.edt_CodigoSolucaoEstoqueRightButtonClick(
  Sender: TObject);
begin
  SelecionaSolucaoEstoque;
end;

procedure TfrmOrdemProducaoSolucao.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmOrdemProducaoSolucao.FormCreate(Sender: TObject);
begin
  Parametros.Codigo := 0;
  Parametros.Acao   := eNada;
  cds_Pesquisa.CreateDataSet;
  cds_MateriaPrima.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmOrdemProducaoSolucao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then begin
    if pnPesquisa.Visible then
      Close
    else btn_CancelarClick(nil);
  end;
end;

procedure TfrmOrdemProducaoSolucao.FormShow(Sender: TObject);
begin

  CarregarDados;

  case Parametros.Acao of
    eNada : AutoSizeDBGrid(gdPesquisa);
    eAlterar: begin
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

procedure TfrmOrdemProducaoSolucao.InvertePaineis;
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
        btAdd.Enabled    := TUSUARIO(U.Itens[0]).PERMITEPRODUTOALEMCOMPOSICAO.Value;
        btDel.Enabled    := TUSUARIO(U.Itens[0]).PERMITEPRODUTOALEMCOMPOSICAO.Value;
      end;
    finally
      FreeAndNil(U);
      FreeAndNil(FW);
    end;

    if edt_CodigoSolucaoEstoque.CanFocus then
      edt_CodigoSolucaoEstoque.SetFocus;
  end;


  AutoSizeDBGrid(gdMateriaPrima);
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmOrdemProducaoSolucao.SelecionaMateriaPrima;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  UN  : TUNIDADEMEDIDA;
  Filtro : string;
begin
  if edt_CodigoSolucaoEstoque.Text = EmptyStr then begin
    DisplayMsg(MSG_WAR, 'Selecione a Solução de Estoque!');
    Exit;
  end;

  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  UN     := TUNIDADEMEDIDA.Create(FWC);
  try
    Filtro := 'finalidade in (2,5) and id not in (' + edt_CodigoSolucaoEstoque.Text + ')';
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

procedure TfrmOrdemProducaoSolucao.SelecionaSolucaoEstoque;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  try
    Filtro := 'finalidade = 5';
    edt_CodigoSolucaoEstoque.Tag := DMUtil.Selecionar(P, edt_CodigoSolucaoEstoque.Text, Filtro);
    if edt_CodigoSolucaoEstoque.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edt_CodigoSolucaoEstoque.Tag));
      if P.Count > 0 then begin
        edt_CodigoSolucaoEstoque.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edt_DescricaoSolucaoEstoque.Text  := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoSolucao.btNovoClick(Sender: TObject);
begin
  if AtualizarEdits(True) then //Se Conseguiu Carregar os Dados Inverte os Painéis
    InvertePaineis;
end;

procedure TfrmOrdemProducaoSolucao.btExcluirClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    if cds_PesquisaENCERRADO.Value then begin
      DisplayMsg(MSG_WAR, 'Ordem de Produção já foi encerrada!');
      Exit;
    end;
    DisplayMsg(MSG_CONF, 'Deseja Realmente Excluir a Ordem de Produção Nº ' + cds_PesquisaID.AsString + '?');

    if ResultMsgModal = mrYes then
      DeletarOrdemProducao;
  end;
end;

end.
