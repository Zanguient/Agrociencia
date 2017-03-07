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
    gbCabecalho: TGroupBox;
    edt_NomeEstagio: TEdit;
    Label1: TLabel;
    edt_CodigoEstagio: TButtonedEdit;
    Label2: TLabel;
    edt_PHRec: TJvValidateEdit;
    Label14: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edt_CodigoEspecie: TButtonedEdit;
    edt_NomeEspecie: TEdit;
    btnNovaEspecie: TBitBtn;
    btnRetiraEspecie: TBitBtn;
    dg_Especies: TDBGrid;
    cds_Especies: TClientDataSet;
    ds_Especies: TDataSource;
    cds_EspeciesID: TIntegerField;
    cds_EspeciesID_ESPECIE: TIntegerField;
    cds_EspeciesESPECIE: TStringField;
    Label8: TLabel;
    edt_CodigoMeioCutura: TEdit;
    Label9: TLabel;
    edt_Observacao: TMemo;
    edt_UnidadeMedida: TEdit;
    Label10: TLabel;
    cds_ComponentesUNIDADE: TStringField;
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
    procedure edt_CodigoEstagioRightButtonClick(Sender: TObject);
    procedure edt_CodigoEstagioChange(Sender: TObject);
    procedure edt_CodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CodigoEspecieChange(Sender: TObject);
    procedure edt_CodigoEspecieRightButtonClick(Sender: TObject);
    procedure edt_CodigoEspecieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovaEspecieClick(Sender: TObject);
    procedure btnRetiraEspecieClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaEstagio;
    procedure SelecionaEspecie;
    procedure SelecionaMateriaPrima;
    procedure SelecionaComponentes;
    procedure GravarComponentes;
    procedure CarregaDados;
    procedure Filtrar;
    procedure InvertePaineis;
    procedure LimpaEdits;
  end;

var
  frmComposicaoMeioCultura: TfrmComposicaoMeioCultura;

implementation
uses
  uFWConnection,
  uBeanProdutos,
  uBeanEstagio,
  uBeanMeioCultura,
  uBeanMeioCulturaEspecie,
  uDMUtil,
  uBeanProdutoComposicao,
  uSeleciona,
  uFuncoes,
  uMensagem, uBeanUnidadeMedida;
{$R *.dfm}

{ TfrmComposicaoMeioCultura }

procedure TfrmComposicaoMeioCultura.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    InvertePaineis;
    pnCadastro.Tag := cds_PesquisaID.Value;
    SelecionaComponentes;
  end;
end;

procedure TfrmComposicaoMeioCultura.btCancelarClick(Sender: TObject);
begin
  LimpaEdits;
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

procedure TfrmComposicaoMeioCultura.btnNovaEspecieClick(Sender: TObject);
begin
  if edt_NomeEspecie.Text = EmptyStr then begin
    DisplayMsg(MSG_INF, 'Informe um produto final para continuar!');
    Exit;
  end;
  if cds_Especies.Locate(cds_EspeciesID_ESPECIE.FieldName, edt_CodigoEspecie.Text, []) then begin
    DisplayMsg(MSG_INF, 'Especie já adicionada ao meio de cultura!');
    Exit;
  end;
  cds_Especies.Append;
  cds_EspeciesID_ESPECIE.AsString := edt_CodigoEspecie.Text;
  cds_EspeciesESPECIE.Value       := edt_NomeEspecie.Text;
  cds_Especies.Post;

  edt_CodigoEspecie.Clear;
  edt_NomeEspecie.Clear;
end;

procedure TfrmComposicaoMeioCultura.btNovoClick(Sender: TObject);
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
    DisplayMsg(MSG_WAR, 'Produto ' + edtMateriaPrima.Text + ' - ' + edtNomeMateriaPrima.Text + ' já Adicionado, Verifique!');

  if edtMateriaPrima.CanFocus then
    edtMateriaPrima.SetFocus;
end;

procedure TfrmComposicaoMeioCultura.btnRetiraEspecieClick(Sender: TObject);
begin
  if not cds_Especies.IsEmpty then
    cds_Especies.Delete
  else
    DisplayMsg(MSG_INF, 'Não existem dados para alterar!');
end;

procedure TfrmComposicaoMeioCultura.btPesquisarClick(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmComposicaoMeioCultura.LimpaEdits;
begin
  cds_Especies.EmptyDataSet;
  cds_Componentes.EmptyDataSet;
  pnCadastro.Tag := 0;
  edt_CodigoEstagio.Clear;
  edt_PHRec.Value  := 0;
  edt_CodigoEstagio.Clear;
  edt_CodigoMeioCutura.Clear;
  edt_Observacao.Clear;
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

procedure TfrmComposicaoMeioCultura.edt_CodigoEspecieChange(Sender: TObject);
begin
  edt_NomeEspecie.Clear;
end;

procedure TfrmComposicaoMeioCultura.edt_CodigoEspecieKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then SelecionaEspecie;

end;

procedure TfrmComposicaoMeioCultura.edt_CodigoEspecieRightButtonClick(
  Sender: TObject);
begin
  SelecionaEspecie;
end;

procedure TfrmComposicaoMeioCultura.edt_CodigoEstagioChange(Sender: TObject);
begin
  edt_NomeEstagio.Clear;
end;

procedure TfrmComposicaoMeioCultura.edt_CodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then SelecionaEstagio;
end;

procedure TfrmComposicaoMeioCultura.edt_CodigoEstagioRightButtonClick(
  Sender: TObject);
begin
  SelecionaEstagio;
end;

procedure TfrmComposicaoMeioCultura.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmComposicaoMeioCultura.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
  cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.Open;

  cds_Especies.CreateDataSet;
  cds_Especies.Open;

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
      VK_ESCAPE : LimpaEdits;
      VK_RETURN : begin
        SelectNext(ActiveControl as TWinControl, True, True);
      end;
    end;
  end;
end;

procedure TfrmComposicaoMeioCultura.FormShow(Sender: TObject);
begin
  pnPesquisa.Visible := True;
  pnCadastro.Visible := not pnPesquisa.Visible;
  AutoSizeDBGrid(dg_Componentes);
  AutoSizeDBGrid(gdPesquisa);
  AutoSizeDBGrid(dg_Especies);

  CarregaDados;
end;

procedure TfrmComposicaoMeioCultura.GravarComponentes;
var
  FWC : TFWConnection;
  PC  : TPRODUTOCOMPOSICAO;
  M   : TMEIOCULTURA;
  ME  : TMEIOCULTURAESPECIE;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  PC  := TPRODUTOCOMPOSICAO.Create(FWC);
  M   := TMEIOCULTURA.Create(FWC);
  ME  := TMEIOCULTURAESPECIE.Create(FWC);
  try
    DisplayMsg(MSG_WAIT, 'Gravando dados no banco de dados...');
    FWC.StartTransaction;
    try
      M.ID_ESTAGIO.Value      := StrToInt(edt_CodigoEstagio.Text);
      M.PHRECOMENDADO.Value   := edt_PHRec.Value;
      M.CODIGO.Value          := edt_CodigoMeioCutura.Text;
      M.OBSERVACAO.Value      := edt_Observacao.Text;
      M.SelectList('ID_PRODUTO = ' + QuotedStr(IntToStr(pnCadastro.Tag)));
      if M.Count > 0 then begin
        M.ID.Value := TMEIOCULTURA(M.Itens[0]).ID.Value;
        M.Update;
      end else begin
        M.ID.isNull  := True;
        M.ID_PRODUTO.Value := pnCadastro.Tag;
        M.Insert;
      end;

      ME.SelectList('ID_MEIOCULTURA = ' + M.ID.asSQL);
      if ME.Count > 0 then begin
        for I := 0 to Pred(ME.Count) do begin
          if not cds_Especies.Locate(cds_EspeciesID.FieldName, TMEIOCULTURAESPECIE(ME.Itens[0]).ID.Value, []) then begin
            ME.ID.Value := TMEIOCULTURAESPECIE(ME.Itens[0]).ID.Value;
            ME.Delete;
          end;
        end;
      end;

      cds_Especies.First;
      while not cds_Especies.Eof do begin
        ME.ID_MEIOCULTURA.Value := M.ID.Value;
        ME.ID_ESPECIE.Value     := cds_EspeciesID_ESPECIE.Value;
        if cds_EspeciesID.IsNull then begin
          ME.ID.isNull := True;
          ME.Insert;
        end else begin
          ME.ID.Value  := cds_EspeciesID.Value;
          ME.Update;
        end;
        cds_Especies.Next;
      end;

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
    FreeAndNil(ME);
    FreeAndNil(M);
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
  E   : TESTAGIO;
  M   : TMEIOCULTURA;
  ME  : TMEIOCULTURAESPECIE;
  P   : TPRODUTO;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  E   := TESTAGIO.Create(FWC);
  M   := TMEIOCULTURA.Create(FWC);
  P   := TPRODUTO.Create(FWC);
  ME  := TMEIOCULTURAESPECIE.Create(FWC);
  try
    cds_Componentes.EmptyDataSet;
//    if edtMeioCultura.Text = EmptyStr then begin
//      DisplayMsg(MSG_INF, 'Informe um meio de cultura para continuar!');
//      Exit;
//    end;
    try

      M.SelectList('ID_PRODUTO = ' + QuotedStr(IntToStr(pnCadastro.Tag)));
      if M.Count > 0 then begin
        edt_CodigoMeioCutura.Text := TMEIOCULTURA(M.Itens[0]).CODIGO.asString;
        edt_CodigoEstagio.Text := TMEIOCULTURA(M.Itens[0]).ID_ESTAGIO.asString;
        E.SelectList('ID = ' + TMEIOCULTURA(M.Itens[0]).ID_ESTAGIO.asSQL);
        if E.Count > 0 then
          edt_NomeEstagio.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;

        edt_PHRec.Value        := TMEIOCULTURA(M.Itens[0]).PHRECOMENDADO.Value;
        edt_Observacao.Text    := TMEIOCULTURA(M.Itens[0]).OBSERVACAO.asString;

        ME.SelectList('ID_MEIOCULTURA = ' + TMEIOCULTURA(M.Itens[0]).ID.asSQL);
        if ME.Count > 0 then begin
          for I := 0 to Pred(ME.Count) do begin
            cds_Especies.Append;
            cds_EspeciesID.Value              := TMEIOCULTURAESPECIE(ME.Itens[I]).ID.Value;
            cds_EspeciesID_ESPECIE.Value      := TMEIOCULTURAESPECIE(ME.Itens[I]).ID_ESPECIE.Value;
            P.SelectList('ID = ' + TMEIOCULTURAESPECIE(ME.Itens[I]).ID_ESPECIE.asSQL);
            if P.Count > 0 then
              cds_EspeciesESPECIE.Value       := TPRODUTO(P.Itens[0]).DESCRICAO.Value;
            cds_Especies.Post;
          end;
        end;
      end;

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
    FreeAndNil(ME);
    FreeAndNil(P);
    FreeAndNil(M);
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoMeioCultura.SelecionaEspecie;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  edt_NomeEspecie.Clear;
  try
    Filtro := 'finalidade = 1';
    edt_CodigoEspecie.Tag := DMUtil.Selecionar(P, edt_CodigoEspecie.Text, Filtro);
    if edt_CodigoEspecie.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edt_CodigoEspecie.Tag));
      if P.Count > 0 then begin
        edt_CodigoEspecie.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edt_NomeEspecie.Text       := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoMeioCultura.SelecionaEstagio;
var
  FW : TFWConnection;
  E : TESTAGIO;
begin
  FW := TFWConnection.Create;
  E  := TESTAGIO.Create(FW);
  edt_NomeEstagio.Clear;
  try
    edt_CodigoEstagio.Tag := DMUtil.Selecionar(E, edt_CodigoEstagio.Text);
    if edt_CodigoEstagio.Tag > 0 then begin
      E.SelectList('id = ' + IntToStr(edt_CodigoEstagio.Tag));
      if E.Count > 0 then begin
        edt_CodigoEstagio.Text     := TESTAGIO(E.Itens[0]).ID.asString;
        edt_NomeEstagio.Text       := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(E);
    FreeAndNil(FW);
  end;
end;

procedure TfrmComposicaoMeioCultura.SelecionaMateriaPrima;
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
    Filtro := 'finalidade in (2,5)';
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
