unit uMovimentacaoEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ImgList, FireDAC.Comp.Client;

type
  TfrmMovimentacaoEstoque = class(TForm)
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    pnPequisa: TPanel;
    Panel2: TPanel;
    pnEdicao: TPanel;
    pnBotoesEdicao: TPanel;
    ds_Pesquisa: TDataSource;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    btCancelarControle: TSpeedButton;
    btNovo: TSpeedButton;
    Panel1: TPanel;
    Panel3: TPanel;
    btExportar: TSpeedButton;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    pnControleEstoque: TPanel;
    edObservacao: TEdit;
    Label2: TLabel;
    gdProdutos: TDBGrid;
    ImageList1: TImageList;
    edCodigoProduto: TButtonedEdit;
    edQuantidade: TJvCalcEdit;
    ds_Produtos: TDataSource;
    cds_Produtos: TClientDataSet;
    cds_ProdutosID: TIntegerField;
    cds_ProdutosDESCRICAO: TStringField;
    cds_ProdutosQUANTIDADE: TCurrencyField;
    cds_PesquisaDATAHORA: TDateTimeField;
    cds_PesquisaUSUARIO: TStringField;
    cds_PesquisaOBSERVACAO: TStringField;
    edDescricaoProduto: TEdit;
    btAdicionar: TBitBtn;
    btRemover: TBitBtn;
    cds_PesquisaCANCELADO: TBooleanField;
    Panel6: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel7: TPanel;
    pnFiltroData: TPanel;
    edDataF: TJvDateEdit;
    edDataI: TJvDateEdit;
    Label1: TLabel;
    rgStatus: TRadioGroup;
    btRefresh: TSpeedButton;
    rgTipoMovimentacao: TRadioGroup;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure csPesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure gdPesquisaTitleClick(Column: TColumn);
    procedure btExportarClick(Sender: TObject);
    procedure edCodigoProdutoRightButtonClick(Sender: TObject);
    procedure edCodigoProdutoChange(Sender: TObject);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAdicionarClick(Sender: TObject);
    procedure btRemoverClick(Sender: TObject);
    procedure gdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btCancelarControleClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CarregaDados;
    procedure InvertePaineis;
    procedure Cancelar;
    procedure Filtrar;
    procedure AtualizarEdits(Limpar : Boolean);
  end;

var
  frmMovimentacaoEstoque: TfrmMovimentacaoEstoque;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanProdutos,
  uMensagem,
  uFuncoes,
  uDMUtil,
  uBeanControleEstoque,
  uBeanControleEstoqueProduto, uBeanControleEstoqueCancelamento;

{$R *.dfm}

procedure TfrmMovimentacaoEstoque.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    rgTipoMovimentacao.ItemIndex := 0;
    edObservacao.Clear;
    edCodigoProduto.Clear;
    edDescricaoProduto.Clear;
    edQuantidade.Clear;
    cds_Produtos.EmptyDataSet;
  end else begin
    edObservacao.Text      := cds_PesquisaOBSERVACAO.Value;
  end;
end;

procedure TfrmMovimentacaoEstoque.btAdicionarClick(Sender: TObject);
begin
  if btAdicionar.Tag = 0 then begin
    btAdicionar.Tag := 1;
    try

      if Length(Trim(edDescricaoProduto.Text)) > 0 then begin
        if edQuantidade.Value > 0.00 then begin
          cds_Produtos.Insert;
          cds_ProdutosID.Value          := StrToIntDef(edCodigoProduto.Text, 0);
          cds_ProdutosDESCRICAO.Value   := edDescricaoProduto.Text;
          cds_ProdutosQUANTIDADE.Value  := edQuantidade.Value;
          cds_Produtos.Post;

          edCodigoProduto.Clear;
          edDescricaoProduto.Clear;
          edQuantidade.Clear;

          if edCodigoProduto.CanFocus then
            edCodigoProduto.SetFocus;

        end else begin
          DisplayMsg(MSG_WAR, 'Quantidade Inválida, Verifique!');
          if edQuantidade.CanFocus then
            edQuantidade.SetFocus;
          Exit;
        end;
      end;
    finally
      btAdicionar.Tag := 0;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmMovimentacaoEstoque.btCancelarControleClick(Sender: TObject);
Var
  FWC     : TFWConnection;
  CE      : TCONTROLEESTOQUE;
  CEC     : TCONTROLEESTOQUECANCELAMENTO;
  Motivo  : string;
  ID      : Integer;
begin
  if btCancelar.Tag = 0 then begin
    btCancelar.Tag := 1;

    if USUARIO.CODIGO = 0 then begin
      DisplayMsg(MSG_WAR, 'Usuário inválido para Cancelamento, Verifique!');
      Exit;
    end;

    try
      if not cds_Pesquisa.IsEmpty then begin

        if not cds_PesquisaCANCELADO.Value then begin

          FWC   := TFWConnection.Create;
          CE    := TCONTROLEESTOQUE.Create(FWC);
          CEC   := TCONTROLEESTOQUECANCELAMENTO.Create(FWC);
          try
            try
              CE.SelectList('ID = ' + cds_PesquisaID.AsString);
              if CE.Count > 0 then begin
                if not TCONTROLEESTOQUE(CE.Itens[0]).CANCELADO.Value then begin

                  repeat
                    Motivo := EmptyStr;
                    DisplayMsg(MSG_INPUT_TEXT, 'Informe o motivo do Cancelamento!' + sLineBreak + 'Motivo Obrigatório.');
                    if ResultMsgModal = mrOk then begin
                      if Length(Trim(ResultMsgInputText)) > 0  then
                        Motivo := ResultMsgInputText;
                    end else
                      Exit;
                  until Motivo <> EmptyStr;

                  ID := cds_PesquisaID.Value;

                  CE.ID.Value         := TCONTROLEESTOQUE(CE.Itens[0]).ID.Value;
                  CE.CANCELADO.Value  := True;
                  CE.Update;

                  CEC.ID.isNull                 := True;
                  CEC.CONTROLEESTOQUE_ID.Value  := CE.ID.Value;
                  CEC.DATAHORA.Value            := Now;
                  CEC.USUARIO_ID.Value          := USUARIO.CODIGO;
                  CEC.OBSERVACAO.Value          := Motivo;
                  CEC.Insert;

                  FWC.Commit;

                  CarregaDados;

                  cds_Pesquisa.Locate('ID', ID, []);//Voltar ao Resgistro atual

                end else begin
                  DisplayMsg(MSG_WAR, 'Movimentação de Estoque já Cancelada!');
                  Exit;
                end;

              end;
            except
              on E : Exception do begin
                FWC.Rollback;
                DisplayMsg(MSG_ERR, 'Erro ao Cancelar a Movimentação de Estoque!', '', E.Message);
              end;
            end;
          finally
            FreeAndNil(CEC);
            FreeAndNil(CE);
            FreeAndNil(FWC);
          end;
        end;
      end;
    finally
      btCancelar.Tag  := 0;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cds_Pesquisa, Caption + '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMovimentacaoEstoque.btGravarClick(Sender: TObject);
Var
  FWC   : TFWConnection;
  CE    : TCONTROLEESTOQUE;
  CEP   : TCONTROLEESTOQUEPRODUTO;
begin

  if btGravar.Tag = 0 then begin
    btGravar.Tag := 1;

    FWC   := TFWConnection.Create;
    CE    := TCONTROLEESTOQUE.Create(FWC);
    CEP   := TCONTROLEESTOQUEPRODUTO.Create(FWC);

    cds_Produtos.DisableControls;

    try
      try

        if Length(Trim(edObservacao.Text)) = 0 then begin
          DisplayMsg(MSG_WAR, 'Observação não informada, Verifique!');
          if edObservacao.CanFocus then
            edObservacao.SetFocus;
          Exit;
        end;

        if cds_Produtos.IsEmpty then begin
          DisplayMsg(MSG_WAR, 'Não há Produtos Adicionados na Movimentação, Verifique!');
          if edCodigoProduto.CanFocus then
            edCodigoProduto.SetFocus;
          Exit;
        end;

        CE.ID.isNull              := True;
        CE.DATAHORA.Value         := Now;
        CE.USUARIO_ID.Value       := USUARIO.CODIGO;
        CE.TIPOMOVIMENTACAO.Value := rgTipoMovimentacao.ItemIndex;
        CE.CANCELADO.Value        := False;
        CE.OBSERVACAO.Value       := edObservacao.Text;
        CE.Insert;

        cds_Produtos.First;
        while not cds_Produtos.Eof do begin
          CEP.ID.isNull                 := True;
          CEP.CONTROLEESTOQUE_ID.Value  := CE.ID.Value;
          CEP.PRODUTO_ID.Value          := cds_ProdutosID.Value;
          case rgTipoMovimentacao.ItemIndex of
            0 : CEP.QUANTIDADE.Value    := Abs(cds_ProdutosQUANTIDADE.Value);//Entrada
            1 : CEP.QUANTIDADE.Value    := -Abs(cds_ProdutosQUANTIDADE.Value);//Saída
          end;
          CEP.Insert;
          cds_Produtos.Next;
        end;

        FWC.Commit;

        InvertePaineis;

        CarregaDados;

        DisplayMsg(MSG_OK, 'Movimentação Registrada com Sucesso!');

      Except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_ERR, 'Erro ao Gravar a Movimentação de Estoque!', '', E.Message);
        end;
      end;
    finally
      cds_Produtos.EnableControls;
      FreeAndNil(CEP);
      FreeAndNil(CE);
      FreeAndNil(FWC);
      btGravar.Tag  := 0;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmMovimentacaoEstoque.btRefreshClick(Sender: TObject);
begin
  if btRefresh.Tag = 0 then begin
    btRefresh.Tag := 1;
    try
      CarregaDados;
    finally
      btRefresh.Tag := 0;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.btRemoverClick(Sender: TObject);
begin
  if btRemover.Tag = 0 then begin
    btRemover.Tag := 1;
    try
      if not cds_Produtos.IsEmpty then begin
        edCodigoProduto.Text    := cds_ProdutosID.AsString;
        edDescricaoProduto.Text := cds_ProdutosDESCRICAO.AsString;
        edQuantidade.Value      := cds_ProdutosQUANTIDADE.Value;

        cds_Produtos.Delete;

        if edCodigoProduto.CanFocus then
          edCodigoProduto.SetFocus;
      end;
    finally
      btRemover.Tag := 0;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  cds_Produtos.EmptyDataSet;
  InvertePaineis;
end;

procedure TfrmMovimentacaoEstoque.CarregaDados;
Var
  FWC     : TFWConnection;
  SQL     : TFDQuery;
  Codigo  : Integer;
begin

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);

  cds_Pesquisa.DisableControls;

  try
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	CE.ID,');
      SQL.SQL.Add('	CE.DATAHORA,');
      SQL.SQL.Add('	U.NOME AS USUARIO,');
      SQL.SQL.Add('	CE.CANCELADO,');
      SQL.SQL.Add('	CE.OBSERVACAO');
      SQL.SQL.Add('FROM CONTROLEESTOQUE CE');
      SQL.SQL.Add('INNER JOIN USUARIO U ON (U.ID = CE.USUARIO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND CAST(CE.DATAHORA AS DATE) BETWEEN :DATAI AND :DATAF');

      case rgStatus.ItemIndex of
        0 : SQL.SQL.Add('AND CE.CANCELADO = True');
        1 : SQL.SQL.Add('AND CE.CANCELADO = False');
      end;

      SQL.ParamByName('DATAI').DataType := ftDate;
      SQL.ParamByName('DATAF').DataType := ftDate;
      SQL.ParamByName('DATAI').Value    := edDataI.Date;
      SQL.ParamByName('DATAF').Value    := edDataF.Date;

      SQL.Connection                    := FWC.FDConnection;
      SQL.Prepare;

      SQL.SQL.Add('ORDER BY CE.ID ASC');
      SQL.Connection    := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open();
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value        := SQL.FieldByName('ID').AsInteger;
          cds_PesquisaDATAHORA.Value  := SQL.FieldByName('DATAHORA').AsDateTime;
          cds_PesquisaUSUARIO.Value   := SQL.FieldByName('USUARIO').AsString;
          cds_PesquisaCANCELADO.Value := SQL.FieldByName('CANCELADO').AsBoolean;
          cds_PesquisaOBSERVACAO.Value:= SQL.FieldByName('OBSERVACAO').AsString;
          cds_Pesquisa.Post;
          SQL.Next;
        end;
      end;

      if Codigo > 0 then
        cds_Pesquisa.Locate('ID', Codigo, []);

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados da Tela.', '', E.Message);
      end;
    end;

  finally
    cds_Pesquisa.EnableControls;
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmMovimentacaoEstoque.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmMovimentacaoEstoque.edCodigoProdutoChange(Sender: TObject);
begin
  edDescricaoProduto.Clear;
end;

procedure TfrmMovimentacaoEstoque.edCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoProdutoRightButtonClick(nil);
end;

procedure TfrmMovimentacaoEstoque.edCodigoProdutoRightButtonClick(Sender: TObject);
var
  P   : TPRODUTO;
  FWC : TFWConnection;
begin
  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  edDescricaoProduto.Text := '';

  try
    edCodigoProduto.Text  := IntToStr(DMUtil.Selecionar(P, edCodigoProduto.Text));
    P.SelectList('id = ' + edCodigoProduto.Text);
    if P.Count = 1 then
      edDescricaoProduto.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmMovimentacaoEstoque.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmMovimentacaoEstoque.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmMovimentacaoEstoque.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not cds_Pesquisa.IsEmpty then begin
          if cds_Pesquisa.RecNo > 1 then
            cds_Pesquisa.Prior;
        end;
      end;
      VK_DOWN : begin
        if not cds_Pesquisa.IsEmpty then begin
          if cds_Pesquisa.RecNo < cds_Pesquisa.RecordCount then
            cds_Pesquisa.Next;
        end;
      end;
    end;
  end else begin
    case Key of
      VK_ESCAPE : Cancelar;
      VK_RETURN : begin
        SelectNext(ActiveControl as TWinControl, True, True);
      end;
    end;
  end;
end;

procedure TfrmMovimentacaoEstoque.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  cds_Produtos.CreateDataSet;
  rgStatus.ItemIndex := 2;
  edDataI.Date  := Date;
  edDataF.Date  := Date;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmMovimentacaoEstoque.gdPesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if cds_PesquisaCANCELADO.Value then
    gdPesquisa.Canvas.Font.Color  := clRed
  else
    gdPesquisa.Canvas.Font.Color  := clBlack;

  gdPesquisa.DefaultDrawColumnCell( Rect, DataCol, Column, State);
end;

procedure TfrmMovimentacaoEstoque.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmMovimentacaoEstoque.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edObservacao.CanFocus then
      edObservacao.SetFocus;
    AutoSizeDBGrid(gdProdutos);
  end;
end;

end.
