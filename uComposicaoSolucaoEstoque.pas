unit uComposicaoSolucaoEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, JvExStdCtrls,
  JvEdit, JvValidateEdit, FireDAC.Comp.Client;

type
  TfrmComposicaoSolucaoEstoque = class(TForm)
    pnPesquisa: TPanel;
    pnPequisaDados: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btAlterar: TSpeedButton;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    btExportar: TSpeedButton;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaDESCRICAO: TStringField;
    cds_PesquisaFINALIDADE: TIntegerField;
    cds_PesquisaUNIDADEMEDIDA: TIntegerField;
    cds_PesquisaCODIGOEXTERNO: TStringField;
    cds_Componentes: TClientDataSet;
    cds_ComponentesIDPRODUTO: TIntegerField;
    cds_ComponentesNOMEPRODUTO: TStringField;
    cds_ComponentesQUANTIDADE: TFloatField;
    cds_ComponentesID: TIntegerField;
    cds_ComponentesUNIDADE: TStringField;
    ds_Componentes: TDataSource;
    ds_Pesquisa: TDataSource;
    Panel2: TPanel;
    pnCadastro: TPanel;
    dg_Componentes: TDBGrid;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    btNovo: TBitBtn;
    btExcluir: TBitBtn;
    edt_UnidadeMedida: TEdit;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
    procedure edtMateriaPrimaRightButtonClick(Sender: TObject);
    procedure edtMateriaPrimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMateriaPrimaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaDados;
    procedure SelecionaComponentes;
    procedure LimpaEdits;
    procedure InvertePaineis;
    procedure Filtrar;
    procedure GravarComponentes;
    procedure SelecionaMateriaPrima;
  end;

var
  frmComposicaoSolucaoEstoque: TfrmComposicaoSolucaoEstoque;

implementation

uses
  uFWConnection, uBeanProdutos, uMensagem, uBeanEstagio,
  uBeanProdutoComposicao, uFuncoes, uBeanUnidadeMedida, uDMUtil;

{$R *.dfm}

{ TfrmComposicaoSolucaoEstoque }

procedure TfrmComposicaoSolucaoEstoque.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    InvertePaineis;
    pnCadastro.Tag := cds_PesquisaID.Value;
    SelecionaComponentes;
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.btCancelarClick(Sender: TObject);
begin
  LimpaEdits;
end;

procedure TfrmComposicaoSolucaoEstoque.btExcluirClick(Sender: TObject);
begin
  if not cds_Componentes.IsEmpty then
    cds_Componentes.Delete;
end;

procedure TfrmComposicaoSolucaoEstoque.btExportarClick(Sender: TObject);
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

procedure TfrmComposicaoSolucaoEstoque.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmComposicaoSolucaoEstoque.btGravarClick(Sender: TObject);
begin
  if btGravar.Tag = 0 then begin
    btGravar.Tag := 1;
    try
      GravarComponentes;
    finally
      btGravar.Tag := 0;
    end;
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.btNovoClick(Sender: TObject);
begin
  if not cds_Componentes.Locate(cds_ComponentesIDPRODUTO.FieldName, edtMateriaPrima.Text, []) then begin
    cds_Componentes.Append;
    cds_ComponentesIDPRODUTO.Value  := StrToInt(edtMateriaPrima.Text);
    cds_ComponentesNOMEPRODUTO.Value:= edtNomeMateriaPrima.Text;
    cds_ComponentesQUANTIDADE.Value := edt_Quantidade.Value;
    cds_ComponentesUNIDADE.Value    := edt_UnidadeMedida.Text;
    cds_Componentes.Post;

    edtMateriaPrima.Clear;
    edt_Quantidade.Clear;

  end else
    DisplayMsg(MSG_WAR, 'Produto ' + edtMateriaPrima.Text + ' - ' + edtNomeMateriaPrima.Text + ' j� Adicionado, Verifique!');

  if edtMateriaPrima.CanFocus then
    edtMateriaPrima.SetFocus;
end;

procedure TfrmComposicaoSolucaoEstoque.CarregaDados;
Var
  FWC : TFWConnection;
  P   : TPRODUTO;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    P   := TPRODUTO.Create(FWC);
    cds_Pesquisa.DisableControls;
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      P.SelectList('ID > 0 AND FINALIDADE = 5', 'ID');
      if P.Count > 0 then begin
        for I := 0 to P.Count -1 do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value              := TPRODUTO(P.Itens[I]).ID.Value;
          cds_PesquisaDESCRICAO.Value       := TPRODUTO(P.Itens[I]).DESCRICAO.Value;
          cds_PesquisaFINALIDADE.Value      := TPRODUTO(P.Itens[I]).FINALIDADE.Value;
          cds_PesquisaUNIDADEMEDIDA.Value   := TPRODUTO(P.Itens[I]).UNIDADEMEDIDA_ID.Value;
          cds_PesquisaCODIGOEXTERNO.Value   := TPRODUTO(P.Itens[I]).CODIGOEXTERNO.Value;
          cds_Pesquisa.Post;
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
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.edtMateriaPrimaChange(Sender: TObject);
begin
  edtNomeMateriaPrima.Clear;
end;

procedure TfrmComposicaoSolucaoEstoque.edtMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaMateriaPrima;
end;

procedure TfrmComposicaoSolucaoEstoque.edtMateriaPrimaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMateriaPrima;
end;

procedure TfrmComposicaoSolucaoEstoque.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmComposicaoSolucaoEstoque.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
  cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.Open;

  cds_Componentes.CreateDataSet;
  cds_Componentes.Open;
end;

procedure TfrmComposicaoSolucaoEstoque.FormKeyDown(Sender: TObject;
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
      VK_ESCAPE : LimpaEdits;
      VK_RETURN : begin
        SelectNext(ActiveControl as TWinControl, True, True);
      end;
    end;
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.FormShow(Sender: TObject);
begin
  pnPesquisa.Visible := True;
  pnCadastro.Visible := not pnPesquisa.Visible;
  AutoSizeDBGrid(dg_Componentes);
  AutoSizeDBGrid(gdPesquisa);

  CarregaDados;
end;

procedure TfrmComposicaoSolucaoEstoque.GravarComponentes;
var
  FWC : TFWConnection;
  PC  : TPRODUTOCOMPOSICAO;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  PC  := TPRODUTOCOMPOSICAO.Create(FWC);
  try
    DisplayMsg(MSG_WAIT, 'Gravando dados no banco de dados...');
    FWC.StartTransaction;
    try
      PC.SelectList('id_produto = ' + IntToStr(pnCadastro.Tag));
      for I := 0 to Pred(PC.Count) do begin
        if not cds_Componentes.Locate(cds_ComponentesID.FieldName, TPRODUTOCOMPOSICAO(PC.Itens[I]).ID.Value, []) then begin
          PC.ID.Value := TPRODUTOCOMPOSICAO(PC.Itens[I]).ID.Value;
          PC.Delete;
        end;
      end;

      cds_Componentes.First;
      while not cds_Componentes.Eof do begin
        PC.ID_COMPONENTE.Value := cds_ComponentesIDPRODUTO.Value;
        PC.QUANTIDADE.Value    := cds_ComponentesQUANTIDADE.Value;
        if cds_ComponentesID.IsNull then begin
          PC.ID.isNull         := True;
          PC.ID_PRODUTO.Value  := pnCadastro.Tag;
          PC.Insert;
        end else begin
          PC.ID.Value          := cds_ComponentesID.Value;
          PC.Update;
        end;
        cds_Componentes.Next;
      end;
      FWC.Commit;
      DisplayMsgFinaliza;
      LimpaEdits;
    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Ocorreram erros ao gravar componentes!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(PC);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.InvertePaineis;
begin
  pnPesquisa.Visible            := not pnPesquisa.Visible;
  pnBotoesVisualizacao.Visible  := pnPesquisa.Visible;
  pnCadastro.Visible            := not pnCadastro.Visible;
  pnBotoesEdicao.Visible        := pnCadastro.Visible;
  if pnCadastro.Visible then begin
    if edtMateriaPrima.CanFocus then
      edtMateriaPrima.SetFocus;
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.LimpaEdits;
begin
  cds_Componentes.EmptyDataSet;
  pnCadastro.Tag := 0;
  InvertePaineis;
end;

procedure TfrmComposicaoSolucaoEstoque.SelecionaComponentes;
var
  FWC : TFWConnection;
  SQL : TFDQuery;
  P   : TPRODUTO;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  P   := TPRODUTO.Create(FWC);
  try
    cds_Componentes.EmptyDataSet;
    try
      SQL.Close;
      SQL.SQL.Clear;
      SQL.Connection := FWC.FDConnection;
      SQL.SQL.Add('SELECT p.id, p.descricao, pc.quantidade, pc.id, un.simbolo FROM produto p');
      SQL.SQL.Add('INNER JOIN unidademedida un ON p.unidademedida_id = un.id');
      SQL.SQL.Add('INNER JOIN produtocomposicao pc ON p.id = pc.id_componente WHERE pc.id_produto = :PRODUTO');
      SQL.ParamByName('PRODUTO').AsInteger := pnCadastro.Tag;
      SQL.Prepare;
      SQL.Open();

      SQL.First;
      while not SQL.Eof do begin
        cds_Componentes.Append;
        cds_ComponentesID.Value           := SQL.Fields[3].Value;
        cds_ComponentesIDPRODUTO.Value    := SQL.Fields[0].Value;
        cds_ComponentesNOMEPRODUTO.Value  := SQL.Fields[1].Value;
        cds_ComponentesQUANTIDADE.Value   := SQL.Fields[2].Value;
        cds_ComponentesUNIDADE.Value      := SQL.Fields[4].Value;

        cds_Componentes.Post;

        SQL.Next;
      end;
    except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Erro ao executar consulta!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoSolucaoEstoque.SelecionaMateriaPrima;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  UM  : TUNIDADEMEDIDA;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  UM     := TUNIDADEMEDIDA.Create(FWC);
  edtNomeMateriaPrima.Clear;
  try
    Filtro := 'finalidade in (2,5) and id not in (' + IntToStr(pnCadastro.Tag) + ')';
    edtMateriaPrima.Tag := DMUtil.Selecionar(P, edtMateriaPrima.Text, Filtro);
    if edtMateriaPrima.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMateriaPrima.Tag));
      if P.Count > 0 then begin
        edtMateriaPrima.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edtNomeMateriaPrima.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
        UM.SelectList('ID = ' + TPRODUTO(P.Itens[0]).UNIDADEMEDIDA_ID.asSQL);
        if UM.Count > 0 then
          edt_UnidadeMedida.Text  := TUNIDADEMEDIDA(UM.Itens[0]).SIMBOLO.Value;
        if edt_Quantidade.CanFocus then
          edt_Quantidade.SetFocus;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(UM);
    FreeAndNil(FWC);
  end;
end;

end.
