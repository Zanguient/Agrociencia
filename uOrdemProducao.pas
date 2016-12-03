unit uOrdemProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Comp.Client;

type
  TfrmOrdemProducao = class(TForm)
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
    edQuantidade: TEdit;
    pnUsuarioDireita: TPanel;
    btExportar: TSpeedButton;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    cds_PesquisaDATAHORA: TDateTimeField;
    cds_PesquisaQUANTIDADE: TIntegerField;
    cds_PesquisaPRODUTO: TStringField;
    cds_PesquisaCLIENTE: TStringField;
    edIntervaloCrescimento: TEdit;
    Label1: TLabel;
    gbProduto: TGroupBox;
    edCodigoProduto: TButtonedEdit;
    edNomeProduto: TEdit;
    gbCliente: TGroupBox;
    edCodigoCliente: TButtonedEdit;
    edNomeCliente: TEdit;
    Label3: TLabel;
    pnObservacao: TPanel;
    edObservacao: TEdit;
    btObservacao: TBitBtn;
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
    procedure btObservacaoClick(Sender: TObject);
  private
    procedure SelecionarObservacao;
    { Private declarations }
  public
    procedure CarregaDados;
    procedure InvertePaineis;
    procedure Cancelar;
    procedure Filtrar;
    procedure AtualizarEdits(Limpar : Boolean);
  end;

var
  frmOrdemProducao: TfrmOrdemProducao;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanOPFinal,
  uMensagem,
  uFuncoes, uBeanObservacao, uDMUtil;

{$R *.dfm}

procedure TfrmOrdemProducao.AtualizarEdits(Limpar: Boolean);
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin
  if Limpar then begin
    edQuantidade.Clear;
    edIntervaloCrescimento.Clear;
    edCodigoCliente.Clear;
    edNomeCliente.Clear;
    edCodigoProduto.Clear;
    edNomeProduto.Clear;
    btGravar.Tag  := 0;
  end else begin

    btGravar.Tag  := cds_PesquisaID.Value;

    FWC := TFWConnection.Create;
    SQL := TFDQuery.Create(nil);

    try
      try
        SQL.Close;
        SQL.SQL.Clear;
        SQL.SQL.Add('SELECT');
        SQL.SQL.Add('	OPF.ID AS CODIGO,');
        SQL.SQL.Add('	OPF.QUANTIDADE,');
        SQL.SQL.Add('	OPF.INTERVALOCRESCIMENTO,');
        SQL.SQL.Add('	OPF.CLIENTE_ID,');
        SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
        SQL.SQL.Add('	OPF.PRODUTO_ID,');
        SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
        SQL.SQL.Add('	OPF.OBSERVACAO');
        SQL.SQL.Add('FROM OPFINAL OPF');
        SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
        SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
        SQL.SQL.Add('WHERE 1 = 1');
        SQL.SQL.Add('AND APF.ID = :OPID');
        SQL.Connection  := FWC.FDConnection;
        SQL.ParamByName('OPID').DataType  := ftInteger;
        SQL.Prepare;
        SQL.ParamByName('OPID').AsInteger := btGravar.Tag;
        SQL.Open;

        if not SQL.IsEmpty then begin
          if SQL.FieldByName('CODIGO').AsInteger = btGravar.Tag then begin
            edQuantidade.Text           := SQL.FieldByName('QUANTIDADE').AsString;
            edIntervaloCrescimento.Text := SQL.FieldByName('INTERVALOCRESCIMENTO').AsString;
            edCodigoCliente.Text        := SQL.FieldByName('CLIENTE_ID').AsString;
            edNomeCliente.Text          := SQL.FieldByName('NOMECLIENTE').AsString;
            edCodigoProduto.Text        := SQL.FieldByName('PRODUTO_ID').AsString;
            edNomeProduto.Text          := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
            edObservacao.Text           := SQL.FieldByName('OBSERVACAO').AsString;
          end;
        end;
      except
        on E : Exception do begin
          DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados para Alteração.', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(SQL);
      FreeAndNil(FWC);
    end;
  end;
end;

procedure TfrmOrdemProducao.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmOrdemProducao.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmOrdemProducao.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir a Ordem de Produção Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        OPF := TOPFINAL.Create(FWC);
        try

          OPF.ID.Value := cds_PesquisaID.Value;
          OPF.Delete;

          FWC.Commit;

          cds_Pesquisa.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir a Ordem de Produção, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(OPF);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmOrdemProducao.btExportarClick(Sender: TObject);
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

procedure TfrmOrdemProducao.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOrdemProducao.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
begin

  FWC := TFWConnection.Create;
  OPF := TOPFINAL.Create(FWC);

  try
    try

      if Length(Trim(edNomeCliente.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Cliente não informado, Verifique!');
        if edCodigoCliente.CanFocus then
          edCodigoCliente.SetFocus;
        Exit;
      end;

      if Length(Trim(edNomeProduto.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Produto não informado, Verifique!');
        if edCodigoProduto.CanFocus then
          edCodigoProduto.SetFocus;
        Exit;
      end;

      OPF.DATAHORA.Value              := Now;
      OPF.QUANTIDADE.Value            := StrToIntDef(edQuantidade.Text,0);
      OPF.INTERVALOCRESCIMENTO.Value  := StrToIntDef(edIntervaloCrescimento.Text,0);
      OPF.CLIENTE_ID.Value            := StrToIntDef(edCodigoCliente.Text,0);
      OPF.PRODUTO_ID.Value            := StrToIntDef(edCodigoProduto.Text,0);
      OPF.USUARIO_ID.Value            := USUARIO.CODIGO;
      OPF.OBSERVACAO.Value            := edObservacao.Text;

      if (Sender as TSpeedButton).Tag > 0 then begin
        OPF.ID.Value          := (Sender as TSpeedButton).Tag;
        OPF.Update;
      end else begin
        OPF.ID.isNull := True;
        OPF.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar a Ordem de Produção!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(OPF);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducao.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmOrdemProducao.btObservacaoClick(Sender: TObject);
begin
  if btObservacao.Tag = 0 then begin
    btObservacao.Tag := 1;
    try
      SelecionarObservacao;
    finally
      btObservacao.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducao.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmOrdemProducao.CarregaDados;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I,
  Codigo  : Integer;
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
      SQL.SQL.Add('	OPF.ID AS CODIGO,');
      SQL.SQL.Add('	OPF.DATAHORA,');
      SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
      SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
      SQL.SQL.Add('	OPF.QUANTIDADE');
      SQL.SQL.Add('FROM OPFINAL OPF');
      SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('ORDER BY OPF.ID ASC');
      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value          := SQL.FieldByName('ID').AsInteger;
          cds_PesquisaDATAHORA.Value    := SQL.FieldByName('DATAHORA').AsDateTime;
          cds_PesquisaCLIENTE.Value     := SQL.FieldByName('NOMECLIENTE').AsString;
          cds_PesquisaPRODUTO.Value     := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
          cds_PesquisaQUANTIDADE.Value  := SQL.FieldByName('QUANTIDADE').AsInteger;
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

procedure TfrmOrdemProducao.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmOrdemProducao.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmOrdemProducao.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmOrdemProducao.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmOrdemProducao.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmOrdemProducao.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmOrdemProducao.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edQuantidade.CanFocus then
      edQuantidade.SetFocus;
  end;
end;

procedure TfrmOrdemProducao.SelecionarObservacao;
var
  FWC     : TFWConnection;
  OBS     : TOBSERVACAO;
  CodOBS  : Integer;
begin

  FWC     := TFWConnection.Create;
  OBS     := TOBSERVACAO.Create(FWC);
  try
    try

      CodOBS := DMUtil.Selecionar(OBS);
      if CodOBS > 0 then begin
        OBS.SelectList('id = ' + IntToStr(CodOBS));
        if OBS.Count = 1 then begin
          if Pos(TOBSERVACAO(OBS.Itens[0]).OBSERVACAO.Value, edObservacao.Text) = 0 then begin
            if Length(Trim(edObservacao.Text)) = 0 then
              edObservacao.Text := TOBSERVACAO(OBS.Itens[0]).OBSERVACAO.Value
            else
              edObservacao.Text := edObservacao.Text + ' ' + TOBSERVACAO(OBS.Itens[0]).OBSERVACAO.Value
          end;
        end;
      end;
    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Selecionar a Observação', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(OBS);
    FreeAndNil(FWC);
  end;

end;

end.
