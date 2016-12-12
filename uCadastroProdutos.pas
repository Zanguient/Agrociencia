unit uCadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ImgList, FireDAC.Comp.Client;

type
  TfrmCadastroProdutos = class(TForm)
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel2: TPanel;
    pnEdicao: TPanel;
    pnBotoesEdicao: TPanel;
    ds_Pesquisa: TDataSource;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaDESCRICAO: TStringField;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btExcluir: TSpeedButton;
    btFechar: TSpeedButton;
    btAlterar: TSpeedButton;
    btNovo: TSpeedButton;
    Panel1: TPanel;
    Panel3: TPanel;
    GridPanel1: TGridPanel;
    pnUsuarioEsquerda: TPanel;
    Label2: TLabel;
    edDescricao: TEdit;
    pnUsuarioDireita: TPanel;
    btExportar: TSpeedButton;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    edCodigoExterno: TEdit;
    Label3: TLabel;
    cds_PesquisaCODIGOEXTERNO: TStringField;
    Label1: TLabel;
    cbFinalidadeProduto: TComboBox;
    cds_PesquisaFINALIDADE: TIntegerField;
    lbUnidadeMedida: TLabel;
    edUnidadeMedida: TButtonedEdit;
    Label5: TLabel;
    ImageList: TImageList;
    cds_PesquisaUNIDADEMEDIDA: TIntegerField;
    cds_PesquisaESTOQUE: TCurrencyField;
    cbTipoProduto: TComboBox;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure csPesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure gdPesquisaTitleClick(Column: TColumn);
    procedure btExportarClick(Sender: TObject);
    procedure edUnidadeMedidaChange(Sender: TObject);
    procedure edUnidadeMedidaRightButtonClick(Sender: TObject);
    procedure edUnidadeMedidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbTipoProdutoChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CarregaDados;
    procedure InvertePaineis;
    procedure Cancelar;
    procedure Filtrar;
    procedure AtualizarEdits(Limpar : Boolean);
    procedure CarregaDescricoes;
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanProdutos,
  uMensagem,
  uFuncoes,
  uBeanUnidadeMedida,
  uDMUtil;

{$R *.dfm}

procedure TfrmCadastroProdutos.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edDescricao.Clear;
    cbFinalidadeProduto.ItemIndex := 0;
    edUnidadeMedida.Clear;
    lbUnidadeMedida.Caption := EmptyStr;
    edCodigoExterno.Clear;
    btGravar.Tag  := 0;
  end else begin
    edDescricao.Text              := cds_PesquisaDESCRICAO.Value;
    cbFinalidadeProduto.ItemIndex := cds_PesquisaFINALIDADE.Value;
    edUnidadeMedida.Text          := cds_PesquisaUNIDADEMEDIDA.AsString;
    edCodigoExterno.Text          := cds_PesquisaCODIGOEXTERNO.Value;
    btGravar.Tag                  := cds_PesquisaID.Value;
    CarregaDescricoes;
  end;
end;

procedure TfrmCadastroProdutos.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroProdutos.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroProdutos.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir o Produto Selecionado?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        P   := TPRODUTO.Create(FWC);
        try

          P.ID.Value := cds_PesquisaID.Value;
          P.Delete;

          FWC.Commit;

          cds_Pesquisa.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir o Produto, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(P);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadastroProdutos.btExportarClick(Sender: TObject);
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

procedure TfrmCadastroProdutos.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroProdutos.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin

  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  try
    try

      if Length(Trim(edDescricao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Descrição não informada, Verifique!');
        if edDescricao.CanFocus then
          edDescricao.SetFocus;
        Exit;
      end;

      if cbFinalidadeProduto.ItemIndex = 0 then begin
        DisplayMsg(MSG_WAR, 'Finalidade Inválida, Verifique!');
        if cbFinalidadeProduto.CanFocus then
          cbFinalidadeProduto.SetFocus;
        Exit;
      end;

      if lbUnidadeMedida.Caption = EmptyStr then begin
        DisplayMsg(MSG_WAR, 'Unidade de Medida Inválida, Verifique!');
        if edUnidadeMedida.CanFocus then
          edUnidadeMedida.SetFocus;
        Exit;
      end;

      P.DESCRICAO.Value        := edDescricao.Text;
      P.FINALIDADE.Value       := cbFinalidadeProduto.ItemIndex;
      p.UNIDADEMEDIDA_ID.Value := StrToIntDef(edUnidadeMedida.Text, 0);
      P.CODIGOEXTERNO.Value    := edCodigoExterno.Text;

      if (Sender as TSpeedButton).Tag > 0 then begin
        P.ID.Value          := (Sender as TSpeedButton).Tag;
        P.Update;
      end else begin
        P.ID.isNull := True;
        P.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar o Produto!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroProdutos.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroProdutos.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroProdutos.CarregaDados;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I,
  Codigo  : Integer;
  F : TFinalidadeProduto;
begin

  try
    FWC := TFWConnection.Create;
    SQL := TFDQuery.Create(nil);
    cds_Pesquisa.DisableControls;
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('        P.ID,');
      SQL.SQL.Add('        P.DESCRICAO,');
      SQL.SQL.Add('        P.FINALIDADE,');
      SQL.SQL.Add('        P.UNIDADEMEDIDA_ID,');
      SQL.SQL.Add('        P.CODIGOEXTERNO,');
      SQL.SQL.Add('        (COALESCE((SELECT SUM(COALESCE(CEP.QUANTIDADE, 0.00))');
      SQL.SQL.Add('	  FROM CONTROLEESTOQUE CE INNER JOIN CONTROLEESTOQUEPRODUTO CEP ON (CEP.CONTROLEESTOQUE_ID = CE.ID)');
      SQL.SQL.Add('	  WHERE CE.CANCELADO = FALSE AND CEP.PRODUTO_ID = P.ID),0.00)) AS ESTOQUE');
      SQL.SQL.Add('FROM PRODUTO P');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND P.ID > 0');
      if cbTipoProduto.ItemIndex > 0 then
        SQL.SQL.Add('AND P.FINALIDADE = ' + IntToStr(cbTipoProduto.ItemIndex));
      SQL.SQL.Add('ORDER BY P.ID ASC');
      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value              := SQL.FieldByName('ID').AsInteger;
          cds_PesquisaDESCRICAO.Value       := SQL.FieldByName('DESCRICAO').AsString;
          cds_PesquisaFINALIDADE.Value      := SQL.FieldByName('FINALIDADE').AsInteger;
          cds_PesquisaUNIDADEMEDIDA.Value   := SQL.FieldByName('UNIDADEMEDIDA_ID').AsInteger;
          cds_PesquisaCODIGOEXTERNO.Value   := SQL.FieldByName('CODIGOEXTERNO').AsString;
          cds_PesquisaESTOQUE.Value         := SQL.FieldByName('ESTOQUE').AsCurrency;
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

procedure TfrmCadastroProdutos.CarregaDescricoes;
var
  UM  : TUNIDADEMEDIDA;
  FWC : TFWConnection;
begin

  //Carrega Descrição Unidade de Medida
  if edUnidadeMedida.Text <> EmptyStr then begin
    if edUnidadeMedida.Text = SoNumeros(edUnidadeMedida.Text) then begin
      FWC := TFWConnection.Create;
      UM  := TUNIDADEMEDIDA.Create(FWC);

      try
        UM.SelectList('id = ' + edUnidadeMedida.Text);
        if UM.Count = 1 then
          lbUnidadeMedida.Caption := TUNIDADEMEDIDA(UM.Itens[0]).DESCRICAO.asString;
      finally
        FreeAndNil(UM);
        FreeAndNil(FWC);
      end;
    end;
  end;

end;

procedure TfrmCadastroProdutos.cbTipoProdutoChange(Sender: TObject);
begin
  CarregaDados;
end;

procedure TfrmCadastroProdutos.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroProdutos.edUnidadeMedidaChange(Sender: TObject);
begin
  lbUnidadeMedida.Caption := EmptyStr;
end;

procedure TfrmCadastroProdutos.edUnidadeMedidaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edUnidadeMedidaRightButtonClick(nil);
end;

procedure TfrmCadastroProdutos.edUnidadeMedidaRightButtonClick(Sender: TObject);
var
  UM  : TUNIDADEMEDIDA;
  FWC : TFWConnection;
begin
  FWC := TFWConnection.Create;
  UM  := TUNIDADEMEDIDA.Create(FWC);

  try
    edUnidadeMedida.Text := IntToStr(DMUtil.Selecionar(UM, edUnidadeMedida.Text));
    UM.SelectList('id = ' + edUnidadeMedida.Text);
    if UM.Count = 1 then
      lbUnidadeMedida.Caption := TUNIDADEMEDIDA(UM.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(UM);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroProdutos.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroProdutos.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroProdutos.FormKeyDown(Sender: TObject; var Key: Word;
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
    end;
  end;
end;

procedure TfrmCadastroProdutos.FormShow(Sender: TObject);
var
  F : TFinalidadeProduto;
begin
  cds_Pesquisa.CreateDataSet;
  cbFinalidadeProduto.Items.Clear;
  cbTipoProduto.Items.Clear;
  for F := Low(TFinalidadeProduto) to High(TFinalidadeProduto) do
    cbFinalidadeProduto.Items.Add(GetEnumName(TypeInfo(TFinalidadeProduto), Integer(F)));

  cbTipoProduto.Items := cbFinalidadeProduto.Items;

  cbFinalidadeProduto.ItemIndex := 0;
  cbTipoProduto.ItemIndex       := 0;

  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroProdutos.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroProdutos.InvertePaineis;
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

end.
