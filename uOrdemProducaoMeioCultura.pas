unit uOrdemProducaoMeioCultura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, JvExStdCtrls, JvEdit, JvValidateEdit, Vcl.Mask,
  JvExMask, JvToolEdit, Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    SpeedButton2: TSpeedButton;
    btFechar: TSpeedButton;
    btExportar: TSpeedButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Filtrar;
    procedure BuscarDados;
    procedure BuscaMateriaPrima;
    procedure InvertePaineis;
    procedure LimpaEdits;
    procedure CarregaDadosOrdemProducao(Codigo : Integer);
    procedure GravarDados;
    procedure DeletarOrdemProducao;

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
  uConstantes,
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
begin
  if btGravar.Tag = 0 then begin
    btGravar.Tag  := 1;
    try
      GravarDados;
    finally
      btGravar.Tag := 0;
    end;
  end;
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
  LimpaEdits;
  InvertePaineis;
end;

procedure TfrmOrdemProducaoMeioCultura.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    CarregaDadosOrdemProducao(cds_PesquisaID.Value);
    InvertePaineis;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.btPesquisarClick(Sender: TObject);
begin
  Filtrar;
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

procedure TfrmOrdemProducaoMeioCultura.BuscarDados;
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
    SQL.SQL.Add('SELECT MC.ID, MC.DATAINICIO, MC.DATAFIM, P.ID, P.DESCRICAO FROM ORDEMPRODUCAOMC MC');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON MC.ID_PRODUTO = P.ID');
    SQL.SQL.Add('WHERE 1 = 1');

    case cbStatus.ItemIndex of
      0 : SQL.SQL.Add('AND NOT MC.ENCERRADO');
      1 : SQL.SQL.Add('AND MC.ENCERRADO');
    end;

    SQL.Connection := FW.FDConnection;
    SQL.Prepare;
    SQL.Open();

    if not SQL.IsEmpty then begin
      SQL.First;
      while not SQL.Eof do begin
        cds_Pesquisa.Append;
        cds_PesquisaID.Value             := SQL.Fields[0].Value;
        cds_PesquisaDATAINICIO.Value     := SQL.Fields[1].AsDateTime;
        cds_PesquisaDATAFINAL.Value      := SQL.Fields[2].AsDateTime;
        cds_PesquisaID_MEIOCULTURA.Value := SQL.Fields[3].Value;
        cds_PesquisaMEIOCULTURA.Value    := SQL.Fields[4].Value;
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

procedure TfrmOrdemProducaoMeioCultura.CarregaDadosOrdemProducao(
  Codigo: Integer);
var
  FW : TFWConnection;
  MC : TORDEMPRODUCAOMC;
  MI : TORDEMPRODUCAOMC_ITENS;
  PR : TPRODUTO;
  UN : TUNIDADEMEDIDA;
  FU : TUSUARIO;
  E  : TESTERILIZACAO;
  I  : Integer;
begin
  FW := TFWConnection.Create;
  MC := TORDEMPRODUCAOMC.Create(FW);
  MI := TORDEMPRODUCAOMC_ITENS.Create(FW);
  FU := TUSUARIO.Create(FW);
  PR := TPRODUTO.Create(FW);
  UN := TUNIDADEMEDIDA.Create(FW);
  E  := TESTERILIZACAO.Create(FW);
  try
    MC.SelectList('ID = ' + IntToStr(Codigo));
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
        edt_NomeEsterilizacao.Text     := TESTERILIZACAO(E.Itens[0]).DESCRICAO.asString;

      cds_MateriaPrima.EmptyDataSet;
      MI.SelectList('ID_ORDEMPRODUCAOMC = ' + IntToStr(Codigo));
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
    end;
  finally
    FreeAndNil(MI);
    FreeAndNil(MC);
    FreeAndNil(PR);
    FreeAndNil(UN);
    FreeAndNil(FU);
    FreeAndNil(E);
    FreeAndNil(FW);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.cbStatusChange(Sender: TObject);
begin
  BuscarDados;
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
  FW : TFWConnection;
  MC : TORDEMPRODUCAOMC;
begin
  if cds_Pesquisa.IsEmpty then begin
    DisplayMsg(MSG_INF, 'Não existem dados para excluir!');
    Exit;
  end;

  FW := TFWConnection.Create;
  MC := TORDEMPRODUCAOMC.Create(FW);
  DisplayMsg(MSG_WAIT, 'Excluindo ordem de produção de meio de cultura!');
  try
    FW.StartTransaction;
    try
      MC.ID.Value := cds_PesquisaID.Value;
      MC.Delete;

      FW.Commit;
      DisplayMsgFinaliza;
      BuscarDados;
    except
      on E : Exception do begin
        FW.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao excluir Ordem de Produção!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(MC);
    FreeAndNil(FW);
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.edtMateriaPrimaChange(Sender: TObject);
begin
  edtNomeMateriaPrima.Clear;
end;

procedure TfrmOrdemProducaoMeioCultura.edtMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then SelecionaMateriaPrima;  
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
  if Key = VK_RETURN then SelecionaEsterilizacao;
  
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
  if Key = VK_RETURN then SelecionaMeioCultura;
  
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

procedure TfrmOrdemProducaoMeioCultura.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := edPesquisa.Text <> EmptyStr;
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
      VK_F5 : BuscarDados;
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
      VK_ESCAPE : begin
        LimpaEdits;
        InvertePaineis;
      end;
    end;
  end;
end;

procedure TfrmOrdemProducaoMeioCultura.FormShow(Sender: TObject);
begin
  AjustaForm(frmOrdemProducaoMeioCultura);
  AutoSizeDBGrid(dg_MateriaPrima);
  AutoSizeDBGrid(gdPesquisa);

  cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.Open;

  cds_MateriaPrima.CreateDataSet;
  cds_MateriaPrima.Open;

  BuscarDados;
end;

procedure TfrmOrdemProducaoMeioCultura.GravarDados;
var
  FW : TFWConnection;
  MC : TORDEMPRODUCAOMC;
  MI : TORDEMPRODUCAOMC_ITENS;
begin
  FW := TFWConnection.Create;
  MC := TORDEMPRODUCAOMC.Create(FW);
  MI := TORDEMPRODUCAOMC_ITENS.Create(FW);
  try
    DisplayMsg(MSG_WAIT, 'Gravando dados...', 'Aguarde...');
    FW.StartTransaction;
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
      FW.Commit;
      DisplayMsgFinaliza;
      LimpaEdits;
      InvertePaineis;
      BuscarDados;
    except
      on E : Exception do begin
        FW.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao Gravar Dados!', '', e.Message);
      end;
    end;
  finally
    FreeAndNil(MI);
    FreeAndNil(MC);
    FreeAndNil(FW);
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
  end;
  AutoSizeDBGrid(dg_MateriaPrima);
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmOrdemProducaoMeioCultura.LimpaEdits;
begin
  pnDados.Tag := 0;
//  edt_CodigoFuncionario.Clear;
//  edt_DescricaoFuncionario.Clear;
//  edt_PHInicial.Clear;
//  edt_PHFinal.Clear;
//  edt_PHRec.Clear;
  edt_DataInicio.Clear;
//  edt_DataFinal.Clear;
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
    Filtro := 'finalidade = 2';
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
    edt_CodigoMeioCultura.Tag := DMUtil.SelecionarMeioCultura();
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
  InvertePaineis;
end;

procedure TfrmOrdemProducaoMeioCultura.SpeedButton2Click(Sender: TObject);
begin
  DeletarOrdemProducao;
end;

end.
