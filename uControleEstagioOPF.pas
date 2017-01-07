unit uControleEstagioOPF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Comp.Client;

type
  TfrmControleEstagioOPF = class(TForm)
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
    cds_PesquisaNOMECLIENTE: TStringField;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btRelatorio: TSpeedButton;
    btFechar: TSpeedButton;
    btAlterar: TSpeedButton;
    btNovo: TSpeedButton;
    Panel1: TPanel;
    Panel3: TPanel;
    GridPanel1: TGridPanel;
    pnUsuarioEsquerda: TPanel;
    pnUsuarioDireita: TPanel;
    btExportar: TSpeedButton;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    cds_PesquisaNOMEPRODUTO: TStringField;
    cds_PesquisaSEQUENCIA: TIntegerField;
    cds_PesquisaESTAGIO: TStringField;
    cds_PesquisaCODIGOOP: TIntegerField;
    gbOPF: TGroupBox;
    edCodigoOPF: TButtonedEdit;
    edDescOPF: TEdit;
    gbOPMC: TGroupBox;
    edCodigoOPMC: TButtonedEdit;
    edDescOPMC: TEdit;
    gbEstagio: TGroupBox;
    edCodigoEstagio: TButtonedEdit;
    edDescEstagio: TEdit;
    cds_PesquisaDATAINICIO: TDateTimeField;
    cds_PesquisaDATAFINAL: TDateTimeField;
    Panel6: TPanel;
    edObservacao: TEdit;
    btObservacao: TBitBtn;
    Label1: TLabel;
    gbPeriodoEstagio: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    edQuantidadeEstimada: TEdit;
    edDataPrevistaTermino: TJvDateEdit;
    edIntervaloCrescimento: TEdit;
    edDataPrevistaInicio: TJvDateEdit;
    gbEspecie: TGroupBox;
    edt_CodigoEspecie: TButtonedEdit;
    edt_NomeEspecie: TEdit;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure csPesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btRelatorioClick(Sender: TObject);
    procedure gdPesquisaTitleClick(Column: TColumn);
    procedure btExportarClick(Sender: TObject);
    procedure edCodigoOPFChange(Sender: TObject);
    procedure edCodigoOPMCChange(Sender: TObject);
    procedure edCodigoOPFRightButtonClick(Sender: TObject);
    procedure edCodigoOPMCRightButtonClick(Sender: TObject);
    procedure edCodigoOPMCKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCodigoOPFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btObservacaoClick(Sender: TObject);
    procedure edIntervaloCrescimentoChange(Sender: TObject);
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
  frmControleEstagioOPF: TfrmControleEstagioOPF;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uMensagem,
  uFuncoes,
  uBeanEstagio,
  uBeanOPFinal,
  uDMUtil,
  uBeanOrdemProducaoMC,
  uBeanOPFinal_Estagio,
  uBeanObservacao;

{$R *.dfm}

procedure TfrmControleEstagioOPF.AtualizarEdits(Limpar: Boolean);
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin
  if Limpar then begin
    edCodigoOPF.Clear;
    edDescOPF.Clear;
    edCodigoEstagio.Clear;
    edDescEstagio.Clear;
    edCodigoOPMC.Clear;
    edDescOPMC.Clear;
    edIntervaloCrescimento.Clear;
    edDataPrevistaInicio.Clear;
    edDataPrevistaTermino.Clear;
    edObservacao.Clear;
    btGravar.Tag  := 0;
  end else begin

    btGravar.Tag          := cds_PesquisaID.Value;

    FWC := TFWConnection.Create;
    SQL := TFDQuery.Create(nil);

    try
      try
        SQL.Close;
        SQL.SQL.Clear;
        SQL.SQL.Add('SELECT');
        SQL.SQL.Add('	OPFE.ID AS CODIGO,');
        SQL.SQL.Add('	OPF.ID AS IDOPF,');
        SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
        SQL.SQL.Add('	E.ID AS IDESTAGIO,');
        SQL.SQL.Add('	E.DESCRICAO AS DESCRICAOESTAGIO,');
        SQL.SQL.Add('	OPMC.ID AS IDOPMC,');
        SQL.SQL.Add('	P.ID AS ID_PRODUTO,');
        SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
        SQL.SQL.Add('	OPFE.INTERVALOCRESCIMENTO,');
        SQL.SQL.Add('	OPFE.OBSERVACAO,');
        SQL.SQL.Add('	OPFE.QUANTIDADEESTIMADA,');
        SQL.SQL.Add('	OPFE.PREVISAOINICIO,');
        SQL.SQL.Add('	OPFE.PREVISAOTERMINO');
        SQL.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
        SQL.SQL.Add('INNER JOIN OPFINAL OPF ON (OPF.ID = OPFE.OPFINAL_ID)');
        SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
        SQL.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
        SQL.SQL.Add('INNER JOIN ORDEMPRODUCAOMC OPMC ON (OPMC.ID = OPFE.OPMC_ID)');
        SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPMC.ID_PRODUTO)');
        SQL.SQL.Add('WHERE 1 = 1');
        SQL.SQL.Add('AND OPFE.ID = :IDOPFE');
        SQL.Connection                      := FWC.FDConnection;
        SQL.ParamByName('IDOPFE').DataType  := ftInteger;
        SQL.Prepare;
        SQL.ParamByName('IDOPFE').AsInteger := btGravar.Tag;
        SQL.Open;

        if not SQL.IsEmpty then begin
          if SQL.FieldByName('CODIGO').AsInteger = btGravar.Tag then begin
            edCodigoOPF.Text            := SQL.FieldByName('IDOPF').AsString;
            edDescOPF.Text              := SQL.FieldByName('NOMECLIENTE').AsString;
            edCodigoEstagio.Text        := SQL.FieldByName('IDESTAGIO').AsString;
            edDescEstagio.Text          := SQL.FieldByName('DESCRICAOESTAGIO').AsString;
            edCodigoOPMC.Text           := SQL.FieldByName('IDOPMC').AsString;
            edDescOPMC.Text             := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
            edIntervaloCrescimento.Text := SQL.FieldByName('INTERVALOCRESCIMENTO').AsString;
            edObservacao.Text           := SQL.FieldByName('OBSERVACAO').AsString;
            edt_CodigoEspecie.Text      := SQL.FieldByName('ID_PRODUTO').AsString;
            edt_NomeEspecie.Text        := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
            edQuantidadeEstimada.Text   := SQL.FieldByName('QUANTIDADEESTIMADA').AsString;
            edDataPrevistaInicio.Date   := SQL.FieldByName('PREVISAOINICIO').AsDateTime;
            edDataPrevistaTermino.Date  := SQL.FieldByName('PREVISAOTERMINO').AsDateTime;
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

procedure TfrmControleEstagioOPF.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    if ((cds_PesquisaDATAFINAL.IsNull) or (cds_PesquisaDATAINICIO.AsDateTime < cds_PesquisaDATAFINAL.AsDateTime)) then begin
      AtualizarEdits(False);
      InvertePaineis;
    end else begin
      DisplayMsg(MSG_WAR, 'Estágio Encerrado, Portanto não pode ser Alterado!');
      Exit;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmControleEstagioOPF.btRelatorioClick(Sender: TObject);
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  if not cds_Pesquisa.IsEmpty then begin
    if btRelatorio.Tag = 0 then begin
      btRelatorio.Tag := 1;
      try

        DisplayMsg(MSG_WAIT, 'Buscando dados para visualizar!');

        FWC       := TFWConnection.Create;
        Consulta  := TFDQuery.Create(nil);

        try
          try

            Consulta.Close;
            Consulta.SQL.Clear;
            Consulta.SQL.Add('SELECT');
            Consulta.SQL.Add('	OPFE.ID AS IDOPF,');
            Consulta.SQL.Add('	OPF.QUANTIDADE,');
            Consulta.SQL.Add('	PF.ID AS CODIGOPRODUTO,');
            Consulta.SQL.Add('	PF.DESCRICAO AS NOMEPRODUTO,');
            Consulta.SQL.Add('	CAST(OPFE.DATAHORA AS DATE) AS DATAGERACAOOPF,');
            Consulta.SQL.Add('	OPMC.ID AS IDOPMC,');
            Consulta.SQL.Add('	CAST(OPFE.DATAHORA AS DATE) AS DATAGERACAOOPMC,');
            Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC,');
            Consulta.SQL.Add('	OPFE.OBSERVACAO');
            Consulta.SQL.Add('FROM OPFINAL OPF');
            Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
            Consulta.SQL.Add('INNER JOIN PRODUTO PF ON (PF.ID = OPF.PRODUTO_ID)');
            Consulta.SQL.Add('INNER JOIN ORDEMPRODUCAOMC OPMC ON (OPMC.ID = OPFE.OPMC_ID)');
            Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPMC.ID_PRODUTO)');
            Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
            Consulta.SQL.Add('WHERE 1 = 1');
            Consulta.SQL.Add('AND OPFE.ID = :IDOPFE');
            Consulta.Connection                     := FWC.FDConnection;
            Consulta.ParamByName('IDOPFE').DataType := ftInteger;
            Consulta.ParamByName('IDOPFE').AsInteger:= cds_PesquisaID.Value;
            Consulta.Prepare;
            Consulta.Open;
            Consulta.FetchAll;

            DMUtil.frxDBDataset1.DataSet := Consulta;
            DMUtil.ImprimirRelatorio('frOPFinal.fr3');
            DisplayMsgFinaliza;
          Except
            on E : Exception do begin
              DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta!', '', E.Message);
            end;
          end;
        finally
          FreeAndNil(Consulta);
          FreeAndNil(FWC);
        end;
      finally
        btRelatorio.Tag := 0;
      end;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.btExportarClick(Sender: TObject);
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

procedure TfrmControleEstagioOPF.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmControleEstagioOPF.btGravarClick(Sender: TObject);
Var
  FWC   : TFWConnection;
  OPFE  : TOPFINAL_ESTAGIO;
  ID    : Integer;
begin

  FWC   := TFWConnection.Create;
  OPFE  := TOPFINAL_ESTAGIO.Create(FWC);

  try
    try

      if Length(Trim(edDescOPF.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Ordem de Produção não informada, Verifique!');
        if edCodigoOPF.CanFocus then
          edCodigoOPF.SetFocus;
        Exit;
      end;

      if Length(Trim(edDescEstagio.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Estágio da OP não informada, Verifique!');
        if edCodigoEstagio.CanFocus then
          edCodigoEstagio.SetFocus;
        Exit;
      end;

      if Length(Trim(edDescOPMC.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Meio de Cultura não informado, Verifique!');
        if edCodigoOPMC.CanFocus then
          edCodigoOPMC.SetFocus;
        Exit;
      end;

      if Length(Trim(edObservacao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Observação não informada, Verifique!');
        if edObservacao.CanFocus then
          edObservacao.SetFocus;
        Exit;
      end;

      ID := (Sender as TSpeedButton).Tag;

      if ID = 0 then begin //Só Verificar o limite Caso o for Cadastro.
        if LimiteMultiplicacao(StrToIntDef(edCodigoOPF.Text, 0)) then begin
          DisplayMsg(MSG_CONF, 'Limite de Multiplicações atingido, Deseja Continuar?');
          if ResultMsgModal <> mrYes then
            Exit;
        end;
      end;

      OPFE.OPFINAL_ID.Value           := StrToIntDef(edCodigoOPF.Text, 0);
      OPFE.OPMC_ID.Value              := StrToIntDef(edCodigoOPMC.Text, 0);
      OPFE.ESTAGIO_ID.Value           := StrToIntDef(edCodigoEstagio.Text, 0);
      OPFE.OBSERVACAO.Value           := edObservacao.Text;
      OPFE.INTERVALOCRESCIMENTO.Value := StrToIntDef(edIntervaloCrescimento.Text,0);
      OPFE.QUANTIDADEESTIMADA.Value   := StrToIntDef(edQuantidadeEstimada.Text,0);
      OPFE.PREVISAOINICIO.Value       := edDataPrevistaInicio.Date;
      OPFE.PREVISAOTERMINO.Value      := edDataPrevistaTermino.Date;

      if ID > 0 then begin
        OPFE.ID.Value          := ID;
        OPFE.Update;
      end else begin
        OPFE.ID.isNull            := True;
        OPFE.DATAHORA.Value       := Now;
        OPFE.DATAHORAINICIO.Value := Now;
        OPFE.USUARIO_ID.Value     := USUARIO.CODIGO;

        //Verifica a sequencia do estágio
        OPFE.SelectList('OPFINAL_ID = ' + edCodigoOPF.Text, 'SEQUENCIA DESC');
        if OPFE.Count > 0 then
          OPFE.SEQUENCIA.Value    := TOPFINAL_ESTAGIO(OPFE.Itens[0]).SEQUENCIA.Value + 1
        else
          OPFE.SEQUENCIA.Value    := 1;

        OPFE.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar o Estágio da OP!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(OPFE);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmControleEstagioOPF.btObservacaoClick(Sender: TObject);
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

procedure TfrmControleEstagioOPF.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmControleEstagioOPF.CarregaDados;
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
      SQL.SQL.Add('	OPFE.ID,');
      SQL.SQL.Add('	OPF.ID AS CODIGOOP,');
      SQL.SQL.Add('	OPFE.SEQUENCIA,');
      SQL.SQL.Add('	C.NOME AS CLIENTE,');
      SQL.SQL.Add('	P.DESCRICAO AS PRODUTO,');
      SQL.SQL.Add('	E.DESCRICAO AS ESTAGIO,');
      SQL.SQL.Add('	OPFE.DATAHORAINICIO AS DATAINICIO,');
      SQL.SQL.Add('	OPFE.DATAHORAFIM AS DATAFINAL');
      SQL.SQL.Add('FROM OPFINAL OPF');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      SQL.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPF.CANCELADO = False');
      SQL.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
      SQL.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      SQL.SQL.Add('ORDER BY OPF.ID, OPFE.SEQUENCIA');
      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value          := SQL.FieldByName('ID').AsInteger;
          cds_PesquisaCODIGOOP.Value    := SQL.FieldByName('CODIGOOP').AsInteger;
          cds_PesquisaSEQUENCIA.Value   := SQL.FieldByName('SEQUENCIA').AsInteger;
          cds_PesquisaNOMECLIENTE.Value := SQL.FieldByName('CLIENTE').AsString;
          cds_PesquisaNOMEPRODUTO.Value := SQL.FieldByName('PRODUTO').AsString;
          cds_PesquisaESTAGIO.Value     := SQL.FieldByName('ESTAGIO').AsString;
          if not SQL.FieldByName('DATAINICIO').IsNull then
            cds_PesquisaDATAINICIO.Value  := SQL.FieldByName('DATAINICIO').AsDateTime;
          if not SQL.FieldByName('DATAFINAL').IsNull then
            cds_PesquisaDATAFINAL.Value   := SQL.FieldByName('DATAFINAL').AsDateTime;
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

procedure TfrmControleEstagioOPF.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmControleEstagioOPF.edCodigoEstagioChange(Sender: TObject);
begin
  edDescEstagio.Clear;
end;

procedure TfrmControleEstagioOPF.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoEstagioRightButtonClick(nil)
end;

procedure TfrmControleEstagioOPF.edCodigoEstagioRightButtonClick(
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

procedure TfrmControleEstagioOPF.edCodigoOPFChange(Sender: TObject);
begin
  edDescOPF.Clear;
  edt_CodigoEspecie.Clear;
  edt_NomeEspecie.Clear;
end;

procedure TfrmControleEstagioOPF.edCodigoOPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoOPFRightButtonClick(nil)
end;

procedure TfrmControleEstagioOPF.edCodigoOPFRightButtonClick(Sender: TObject);
var
  FWC     : TFWConnection;
  OPF     : TOPFINAL;
  SQL     : TFDQuery;
  Filtro  : string;
begin

  FWC := TFWConnection.Create;
  OPF := TOPFINAL.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try

    Filtro := 'DATAENCERRAMENTO IS NULL AND CANCELADO = False';
    edCodigoOPF.Text := IntToStr(DMUtil.Selecionar(OPF, edCodigoOPF.Text, Filtro));

    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
    SQL.SQL.Add('	P.ID,');
    SQL.SQL.Add(' P.DESCRICAO');
    SQL.SQL.Add('FROM OPFINAL OPF');
    SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND OPF.ID = :IDOPF');
    SQL.Connection  := FWC.FDConnection;
    SQL.ParamByName('IDOPF').DataType   := ftInteger;
    SQL.ParamByName('IDOPF').AsInteger  := StrToIntDef(edCodigoOPF.Text, -1);
    SQL.Prepare;
    SQL.Open;

    if not SQL.IsEmpty then begin
      edDescOPF.Text         := SQL.Fields[0].AsString;
      edt_CodigoEspecie.Text := SQL.Fields[1].AsString;
      edt_NomeEspecie.Text   := SQL.Fields[2].AsString;
    end;

  finally
    FreeAndNil(SQL);
    FreeAndNil(OPF);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.edCodigoOPMCChange(Sender: TObject);
begin
  edDescOPMC.Text := EmptyStr;
end;

procedure TfrmControleEstagioOPF.edCodigoOPMCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoOPMCRightButtonClick(nil)
end;

procedure TfrmControleEstagioOPF.edCodigoOPMCRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  OPMC: TORDEMPRODUCAOMC;
  SQL : TFDQuery;
begin

  FWC := TFWConnection.Create;
  OPMC:= TORDEMPRODUCAOMC.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try

    edCodigoOPMC.Text := IntToStr(DMUtil.SelecionarOrdemProducaoMeioCultura(StrToIntDef(edCodigoEstagio.Text , 0) , StrToIntDef(edt_CodigoEspecie.Text, 0), edCodigoOPMC.Text));

    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	OPMC.ID AS IDOPMC,');
    SQL.SQL.Add('	P.DESCRICAO AS NOMEPRODUTO');
    SQL.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPMC.ID_PRODUTO)');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND OPMC.ID = :IDOPMC');
    SQL.Connection  := FWC.FDConnection;
    SQL.ParamByName('IDOPMC').DataType   := ftInteger;
    SQL.ParamByName('IDOPMC').AsInteger  := StrToIntDef(edCodigoOPMC.Text, -1);
    SQL.Prepare;
    SQL.Open;

    if not SQL.IsEmpty then
      edDescOPMC.Text := SQL.FieldByName('NOMEPRODUTO').AsString;

  finally
    FreeAndNil(SQL);
    FreeAndNil(OPMC);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.edIntervaloCrescimentoChange(Sender: TObject);
Var
  DataInicio : TDate;
begin
  try
    DataInicio                  := StrToDate(edDataPrevistaInicio.Text);
    edDataPrevistaTermino.Date  := edDataPrevistaInicio.Date + StrToIntDef(edIntervaloCrescimento.Text, 0);
  except
  end;
end;

procedure TfrmControleEstagioOPF.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmControleEstagioOPF.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmControleEstagioOPF.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmControleEstagioOPF.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmControleEstagioOPF.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmControleEstagioOPF.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edCodigoOPF.CanFocus then
      edCodigoOPF.SetFocus;
  end;
end;

procedure TfrmControleEstagioOPF.SelecionarObservacao;
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
