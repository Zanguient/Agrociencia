unit uCadastroModeloEstimativa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExStdCtrls,
  JvEdit, JvValidateEdit;

type
  TfrmCadModeloEstimativa = class(TForm)
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    ds_Pesquisa: TDataSource;
    cds_PesquisaID_PRODUTO: TIntegerField;
    cds_PesquisaNOME: TStringField;
    cds_PesquisaESPECIE: TStringField;
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btAlterar: TSpeedButton;
    btNovo: TSpeedButton;
    Panel9: TPanel;
    btExcluir: TSpeedButton;
    btFechar: TSpeedButton;
    btExportar: TSpeedButton;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel2: TPanel;
    pnEdicao: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    GridPanel1: TGridPanel;
    pnUsuarioEsquerda: TPanel;
    Label2: TLabel;
    edDescricao: TEdit;
    pnUsuarioDireita: TPanel;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    gbProduto: TGroupBox;
    edCodigoProduto: TButtonedEdit;
    edNomeProduto: TEdit;
    pnPrincipal: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edCodigoEstagio: TButtonedEdit;
    edDescEstagio: TEdit;
    edDias: TEdit;
    btnAdicionar: TBitBtn;
    btRemover: TBitBtn;
    edPerda: TJvValidateEdit;
    edFatorX: TJvValidateEdit;
    dgEstimativa: TDBGrid;
    cdsEstimativa: TClientDataSet;
    cdsEstimativaID: TIntegerField;
    cdsEstimativaSEQUENCIA: TIntegerField;
    cdsEstimativaID_ESTAGIO: TIntegerField;
    cdsEstimativaESTAGIO: TStringField;
    cdsEstimativaDIA: TIntegerField;
    cdsEstimativaPERCPERDA: TFloatField;
    cdsEstimativaFATORX: TFloatField;
    dsEstimativa: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure edCodigoProdutoRightButtonClick(Sender: TObject);
    procedure edCodigoProdutoChange(Sender: TObject);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btRemoverClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure cds_PesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btGravarClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure dgEstimativaCellClick(Column: TColumn);
    procedure btExportarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaDados;
    procedure CarregarItens;
    procedure InvertePaineis;
    procedure Cancelar;
    procedure Filtrar;
    procedure AtualizarEdits(Limpar : Boolean);
    procedure ReordenarEstimativa;
  end;

var
  frmCadModeloEstimativa: TfrmCadModeloEstimativa;

implementation
uses
  uFuncoes,
  uConstantes,
  uDMUtil,
  uFWConnection,
  uBeanProdutos,
  uBeanEstagio,
  uBeanModelo_Est,
  uBeanModelo_Est_Estagio,
  uMensagem,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.UI,
  FireDAC.Stan.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Error;

{$R *.dfm}

procedure TfrmCadModeloEstimativa.AtualizarEdits(Limpar: Boolean);
begin
  AutoSizeDBGrid(dgEstimativa);
  if Limpar then begin
    edDescricao.Clear;
    edCodigoProduto.Clear;
    edNomeProduto.Clear;
    edCodigoEstagio.Clear;
    edDescEstagio.Clear;
    edPerda.Value := 0;
    edFatorX.Value := 0;
    edDias.Text := '';
    cdsEstimativa.EmptyDataSet;
    btGravar.Tag              := 0;
  end else begin
    edDescricao.Text := cds_PesquisaNOME.AsString;
    edCodigoProduto.Text := cds_PesquisaID_PRODUTO.AsString;
    edNomeProduto.Text := cds_PesquisaESPECIE.AsString;
    edCodigoEstagio.Clear;
    edDescEstagio.Clear;
    edPerda.Value := 0;
    edFatorX.Value := 0;
    edDias.Text := '';
    btGravar.Tag              := cds_PesquisaID.Value;
    CarregarItens;
  end;
end;

procedure TfrmCadModeloEstimativa.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadModeloEstimativa.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadModeloEstimativa.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  MODELO   : TMODELO_EST;
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir o Modelo Selecionado?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        MODELO   := TMODELO_EST.Create(FWC);
        FWC.StartTransaction;
        try

          MODELO.ID.Value := cds_PesquisaID.Value;
          MODELO.Delete;

          FWC.Commit;

          cds_Pesquisa.Delete;
        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir o Estágio, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(MODELO);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadModeloEstimativa.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cds_Pesquisa, Caption + '_' +  cds_PesquisaID.AsString +  '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmCadModeloEstimativa.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadModeloEstimativa.btGravarClick(Sender: TObject);
var
  FWC: TFWConnection;
  MODELO: TMODELO_EST;
  ITENS: TMODELO_EST_ESTAGIO;
  I: Integer;
begin
  ReordenarEstimativa;
  if edDescricao.Text = EmptyStr then
  begin
    DisplayMsg(MSG_INF, 'Descrição não informada!');
    if edDescricao.CanFocus then
      edDescricao.SetFocus;
    Exit;
  end;
  if edNomeProduto.Text = EmptyStr then
  begin
    DisplayMsg(MSG_INF, 'Espécie não informada!');
    if edCodigoProduto.CanFocus then
      edCodigoProduto.SetFocus;
    Exit;
  end;
  if cdsEstimativa.IsEmpty then
  begin
    DisplayMsg(MSG_INF, 'Estágios não informados!');
    Exit;
  end;

  DisplayMsg(MSG_WAIT, 'Salvando dados!', 'Aguarde..');

  FWC := TFWConnection.Create;
  MODELO := TMODELO_EST.Create(FWC);
  ITENS := TMODELO_EST_ESTAGIO.Create(FWC);
  try
    FWC.StartTransaction;
    try
      MODELO.ID_PRODUTO.Value := StrToIntDef(edCodigoProduto.Text, 0);
      MODELO.NOME.Value := edDescricao.Text;
      if btGravar.Tag > 0 then
      begin
        MODELO.ID.Value := btGravar.Tag;
        MODELO.Update;
      end
      else
      begin
        MODELO.ID.isNull := True;
        MODELO.Insert;
      end;

      if btGravar.Tag > 0 then
      begin
        ITENS.SelectList('id_modelo_est = ' + MODELO.ID.asString);
        for I := 0 to ITENS.Count - 1 do
        begin
          if not cdsEstimativa.Locate(cdsEstimativaID.FieldName,
           TMODELO_EST_ESTAGIO(ITENS.Itens[I]).ID.Value, []) then
          begin
            ITENS.ID.Value := TMODELO_EST_ESTAGIO(ITENS.Itens[I]).ID.Value;
            ITENS.Delete;
          end;
        end;
      end;

      cdsEstimativa.First;
      while not cdsEstimativa.Eof do
      begin
        ITENS.ID_ESTAGIO.Value := cdsEstimativaID_ESTAGIO.Value;
        ITENS.ID_MODELO_EST.Value := MODELO.ID.Value;
        ITENS.SEQUENCIA.Value := cdsEstimativaSEQUENCIA.Value;
        ITENS.FATORX.Value := cdsEstimativaFATORX.Value;
        ITENS.PERDA.Value := cdsEstimativaPERCPERDA.Value;
        ITENS.DIAS.Value := cdsEstimativaDIA.Value;
        if cdsEstimativaID.IsNull then
        begin
          ITENS.ID.isNull := True;
          ITENS.Insert;
        end
        else
        begin
          ITENS.ID.Value := cdsEstimativaID.Value;
          ITENS.Update;
        end;

        cdsEstimativa.Next;
      end;

      FWC.Commit;

      DisplayMsgFinaliza;

      InvertePaineis;

      CarregaDados;
    except
      on E: Exception do
      begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao Salvar Dados!');
      end;
    end;

  finally
    FreeAndNil(ITENS);
    FreeAndNil(MODELO);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadModeloEstimativa.btnAdicionarClick(Sender: TObject);
var
 nSequencia: Integer;
begin
  if edDescEstagio.Text = EmptyStr then
  begin
    DisplayMsg(MSG_INF, 'Estágio não informado!');
    if edCodigoEstagio.CanFocus then
      edCodigoEstagio.SetFocus;
    Exit;
  end;
  if edFatorX.Value < 0 then
  begin
    DisplayMsg(MSG_INF, 'Fator X não informado!');
    if edFatorX.CanFocus then
      edFatorX.SetFocus;
    Exit;
  end;
  if edPerda.Value < 0 then
  begin
    DisplayMsg(MSG_INF, 'Percentual de perda não informado!');
    if edPerda.CanFocus then
      edPerda.SetFocus;
    Exit;
  end;
  if StrToIntDef(edDias.Text, 0) < 0 then
  begin
    DisplayMsg(MSG_INF, 'Dias não informado!');
    if edDias.CanFocus then
      edDias.SetFocus;
    Exit;
  end;

  nSequencia := cdsEstimativa.RecordCount + 1;

  cdsEstimativa.Append;
  cdsEstimativaSEQUENCIA.Value := nSequencia;
  cdsEstimativaID_ESTAGIO.Value := StrToIntDef(edCodigoEstagio.Text, 0);
  cdsEstimativaESTAGIO.AsString := edDescEstagio.Text;
  cdsEstimativaFATORX.AsFloat := edFatorX.Value;
  cdsEstimativaPERCPERDA.AsFloat := edPerda.Value;
  cdsEstimativaDIA.AsInteger := StrToIntDef(edDias.Text, 0);
  cdsEstimativa.Post;

  ReordenarEstimativa;

  edCodigoEstagio.Clear;
  edFatorX.Clear;
  edPerda.Clear;
  edDias.Clear;
end;

procedure TfrmCadModeloEstimativa.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadModeloEstimativa.btPesquisarClick(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmCadModeloEstimativa.btRemoverClick(Sender: TObject);
begin
  if not cdsEstimativa.IsEmpty then
  begin
    cdsEstimativa.Delete;
    ReordenarEstimativa;
  end;
end;

procedure TfrmCadModeloEstimativa.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmCadModeloEstimativa.CarregaDados;
var
  FWC: TFWConnection;
  SQL: TFDQuery;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    DisplayMsg(MSG_WAIT, 'Consultando dados...', 'Aguarde...');
    try
      SQL.SQL.Clear;
      SQL.Connection := FWC.FDConnection;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('EST.ID,');
      SQL.SQL.Add('EST.ID_PRODUTO,');
      SQL.SQL.Add('EST.NOME,');
      SQL.SQL.Add('PR.DESCRICAO AS ESPECIE');
      SQL.SQL.Add('FROM MODELO_EST EST');
      SQL.SQL.Add('INNER JOIN PRODUTO PR ON EST.ID_PRODUTO = PR.ID');
      SQL.Open();

      cds_Pesquisa.EmptyDataSet;
      SQL.First;
      while not SQL.Eof do
      begin
        cds_Pesquisa.Append;
        cds_PesquisaID.Assign(SQL.FieldByName('ID'));
        cds_PesquisaID_PRODUTO.Assign(SQL.FieldByName('ID_PRODUTO'));
        cds_PesquisaNOME.Assign(SQL.FieldByName('NOME'));
        cds_PesquisaESPECIE.Assign(SQL.FieldByName('ESPECIE'));
        cds_Pesquisa.Post;
        SQL.Next;
      end;
      DisplayMsgFinaliza;
    except
      on E:  Exception do
      begin
        DisplayMsg(MSG_WAR, 'Erro ao buscar dados!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadModeloEstimativa.CarregarItens;
var
  FWC: TFWConnection;
  ITEM: TMODELO_EST_ESTAGIO;
  SQL: TFDQuery;
  I: Integer;
begin
  cdsEstimativa.EmptyDataSet;

  FWC := TFWConnection.Create;
  ITEM := TMODELO_EST_ESTAGIO.Create(FWC);
  SQL := TFDQuery.Create(nil);
  try
    SQL.SQL.Clear;
    SQL.Connection := FWC.FDConnection;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('item.id,');
    SQL.SQL.Add('item.sequencia,');
    SQL.SQL.Add('item.id_estagio,');
    SQL.SQL.Add('item.fatorx,');
    SQL.SQL.Add('item.perda,');
    SQL.SQL.Add('item.dias,');
    SQL.SQL.Add('est.descricao');
    SQL.SQL.Add('FROM modelo_est_estagio item');
    SQL.SQL.Add('INNER JOIN estagio est on item.id_estagio = est.id');
    SQL.SQL.Add('WHERE item.id_modelo_est = :id');
    SQL.ParamByName('id').AsInteger := btGravar.Tag;
    SQL.Open();

    SQL.First;

    while not SQL.Eof do
    begin
      cdsEstimativa.Append;
      cdsEstimativaID.Value := SQL.FieldByName('ID').Value;
      cdsEstimativaSEQUENCIA.Value := SQL.FieldByName('SEQUENCIA').Value;
      cdsEstimativaID_ESTAGIO.Value := SQL.FieldByName('ID_ESTAGIO').Value;
      cdsEstimativaESTAGIO.Value := SQL.FieldByName('DESCRICAO').Value;
      cdsEstimativaDIA.Value := SQL.FieldByName('DIAS').Value;
      cdsEstimativaPERCPERDA.Value := SQL.FieldByName('PERDA').Value;
      cdsEstimativaFATORX.Value := SQL.FieldByName('FATORX').Value;
      cdsEstimativa.Post;

      SQL.Next;
    end;
  finally
    FreeAndNil(ITEM);
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadModeloEstimativa.cds_PesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadModeloEstimativa.dgEstimativaCellClick(Column: TColumn);
begin
  if Pos(Column.FieldName, '|SEQUENCIA|QUANTIDADE|PERCPERDA') > 0 then
    dgEstimativa.Options := dgEstimativa.Options + [dgEditing]
  else
    dgEstimativa.Options := dgEstimativa.Options - [dgEditing];
end;

procedure TfrmCadModeloEstimativa.edCodigoEstagioChange(Sender: TObject);
begin
  edDescEstagio.Clear;
end;

procedure TfrmCadModeloEstimativa.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoProdutoRightButtonClick(Sender);
end;

procedure TfrmCadModeloEstimativa.edCodigoEstagioRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin

  FWC := TFWConnection.Create;
  E   := TESTAGIO.Create(FWC);
  try
    edCodigoEstagio.Text := IntToStr(DMUtil.Selecionar(E, edCodigoEstagio.Text));
    E.SelectList('id = ' + edCodigoEstagio.Text);
    if E.Count = 1 then
      edDescEstagio.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadModeloEstimativa.edCodigoProdutoChange(Sender: TObject);
begin
  edNomeProduto.Clear;
end;

procedure TfrmCadModeloEstimativa.edCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoProdutoRightButtonClick(Sender);
end;

procedure TfrmCadModeloEstimativa.edCodigoProdutoRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin
  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  try
    edCodigoProduto.Text := IntToStr(DMUtil.Selecionar(P, edCodigoProduto.Text, 'finalidade = ' + IntToStr(Integer(eProdutoFinal)) ));
    P.SelectList('id = ' + edCodigoProduto.Text);
    if P.Count = 1 then
      edNomeProduto.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadModeloEstimativa.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadModeloEstimativa.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadModeloEstimativa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pnVisualizacao.Visible then begin
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
      VK_F5 : CarregaDados;
      VK_UP : begin
        if (not cds_Pesquisa.IsEmpty) and (not gdPesquisa.Focused) then begin
          if cds_Pesquisa.RecNo > 1 then
            cds_Pesquisa.Prior;
        end;
      end;
      VK_DOWN : begin
        if (not cds_Pesquisa.IsEmpty) and (not gdPesquisa.Focused) then begin
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

procedure TfrmCadModeloEstimativa.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  cdsEstimativa.CreateDataSet;

  cdsEstimativa.IndexDefs.Add('sequencia_idx', 'sequencia', []);
  cdsEstimativa.IndexName := 'sequencia_idx';
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadModeloEstimativa.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edDescricao.CanFocus then
      edDescricao.SetFocus;
  end;
end;

procedure TfrmCadModeloEstimativa.ReordenarEstimativa;
begin
  cdsEstimativa.First;
  while not cdsEstimativa.Eof do
  begin
    cdsEstimativa.Edit;
    cdsEstimativaSEQUENCIA.Value := cdsEstimativa.RecNo;
    cdsEstimativa.Post;
    cdsEstimativa.Next;
  end;
end;

end.
