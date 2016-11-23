unit uComposicaoMeioCultura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  JvExStdCtrls, JvEdit, JvValidateEdit, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmComposicaoMeioCultura = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    cds_Componentes: TClientDataSet;
    cds_ComponentesIDPRODUTO: TIntegerField;
    cds_ComponentesNOMEPRODUTO: TStringField;
    cds_ComponentesQUANTIDADE: TFloatField;
    dg_Componentes: TDBGrid;
    ds_Componentes: TDataSource;
    cds_ComponentesID: TIntegerField;
    btNovo: TBitBtn;
    btExcluir: TBitBtn;
    pnCadastro: TPanel;
    pnPesquisa: TPanel;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaDESCRICAO: TStringField;
    cds_PesquisaFINALIDADE: TIntegerField;
    cds_PesquisaUNIDADEMEDIDA: TIntegerField;
    cds_PesquisaCODIGOEXTERNO: TStringField;
    ds_Pesquisa: TDataSource;
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
    procedure edtMeioCulturaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure edtMateriaPrimaRightButtonClick(Sender: TObject);
    procedure edtMateriaPrimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMateriaPrimaChange(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cds_PesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure btPesquisarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaMateriaPrima;
    procedure SelecionaComponentes;
    procedure GravarComponentes;
    procedure CarregaDados;
    procedure Filtrar;
    procedure InvertePaineis;
    procedure Cancelar;
  end;

var
  frmComposicaoMeioCultura: TfrmComposicaoMeioCultura;

implementation
uses
  uFWConnection,
  uBeanProdutos,
  uDMUtil,
  uBeanProdutoComposicao,
  uSeleciona,
  uFuncoes,
  uMensagem;
{$R *.dfm}

{ TfrmComposicaoMeioCultura }

procedure TfrmComposicaoMeioCultura.btAlterarClick(Sender: TObject);
begin
  InvertePaineis;
  pnCadastro.Tag := cds_PesquisaID.Value;
  SelecionaComponentes;
end;

procedure TfrmComposicaoMeioCultura.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmComposicaoMeioCultura.btExcluirClick(Sender: TObject);
begin
  if not cds_Componentes.IsEmpty then
    cds_Componentes.Delete;
end;

procedure TfrmComposicaoMeioCultura.btExportarClick(Sender: TObject);
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

procedure TfrmComposicaoMeioCultura.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmComposicaoMeioCultura.btGravarClick(Sender: TObject);
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

procedure TfrmComposicaoMeioCultura.btNovoClick(Sender: TObject);
begin
  if not cds_Componentes.Locate(cds_ComponentesIDPRODUTO.FieldName, edtMateriaPrima.Text, []) then begin
    cds_Componentes.Append;
    cds_ComponentesIDPRODUTO.Value := StrToInt(edtMateriaPrima.Text);
    cds_ComponentesNOMEPRODUTO.Value:= edtNomeMateriaPrima.Text;
    cds_ComponentesQUANTIDADE.Value := edt_Quantidade.Value;
    cds_Componentes.Post;

    edtMateriaPrima.Clear;
    edt_Quantidade.Clear;
  end;
end;

procedure TfrmComposicaoMeioCultura.btPesquisarClick(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmComposicaoMeioCultura.Cancelar;
begin
  cds_Componentes.EmptyDataSet;
  pnCadastro.Tag := 0;
  InvertePaineis;
end;

procedure TfrmComposicaoMeioCultura.CarregaDados;
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

      P.SelectList('ID > 0 AND FINALIDADE = 3', 'ID');
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

procedure TfrmComposicaoMeioCultura.cds_PesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmComposicaoMeioCultura.edtMateriaPrimaChange(Sender: TObject);
begin
  edtMateriaPrima.Tag := 0;
  edtNomeMateriaPrima.Clear;
end;

procedure TfrmComposicaoMeioCultura.edtMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN : SelecionaMateriaPrima;
  end;
end;

procedure TfrmComposicaoMeioCultura.edtMateriaPrimaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMateriaPrima;
end;

procedure TfrmComposicaoMeioCultura.edtMeioCulturaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  case Key of
//    VK_RETURN : SelecionaMeioCultura;
//  end;
end;

procedure TfrmComposicaoMeioCultura.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmComposicaoMeioCultura.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
  cds_Componentes.CreateDataSet;
  cds_Componentes.Open;
end;

procedure TfrmComposicaoMeioCultura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
      VK_ESCAPE : Cancelar;
    end;
  end;
end;

procedure TfrmComposicaoMeioCultura.FormShow(Sender: TObject);
begin
  pnPesquisa.Visible := True;
  pnCadastro.Visible := not pnPesquisa.Visible;
  AutoSizeDBGrid(dg_Componentes);
  AutoSizeDBGrid(gdPesquisa);
  cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.Open;

  CarregaDados;
end;

procedure TfrmComposicaoMeioCultura.GravarComponentes;
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

      cds_Componentes.EmptyDataSet;
      DisplayMsgFinaliza;
      InvertePaineis;
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

procedure TfrmComposicaoMeioCultura.InvertePaineis;
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

procedure TfrmComposicaoMeioCultura.SelecionaComponentes;
var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    cds_Componentes.EmptyDataSet;
//    if edtMeioCultura.Text = EmptyStr then begin
//      DisplayMsg(MSG_INF, 'Informe um meio de cultura para continuar!');
//      Exit;
//    end;
    DisplayMsg(MSG_WAIT, 'Consultando componentes no banco de dados!');
    try
      SQL.Close;
      SQL.SQL.Clear;
      SQL.Connection := FWC.FDConnection;
      SQL.SQL.Add('SELECT p.id, p.descricao, pc.quantidade, pc.id FROM produto p INNER JOIN produtocomposicao pc ON p.id = pc.id_componente WHERE pc.id_produto = :PRODUTO');
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
        cds_Componentes.Post;

        SQL.Next;
      end;
      DisplayMsgFinaliza;
    except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Erro ao executar consulta!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoMeioCultura.SelecionaMateriaPrima;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  edtNomeMateriaPrima.Clear;
  try
    Filtro := 'finalidade = 2';
    edtMateriaPrima.Tag := DMUtil.Selecionar(P, edtMateriaPrima.Text, Filtro);
    if edtMateriaPrima.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMateriaPrima.Tag));
      if P.Count > 0 then begin
        edtMateriaPrima.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edtNomeMateriaPrima.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
        if edt_Quantidade.CanFocus then edt_Quantidade.SetFocus;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;
end.
