unit uControleEstagioOPF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Comp.Client, System.Math, Vcl.Imaging.jpeg,
  Vcl.FileCtrl, Vcl.ExtDlgs, uConstantes;

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
    pnObservacao: TPanel;
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
    cds_FichadeProducao: TClientDataSet;
    cds_FichadeProducaoCODIGOPRODUTO: TIntegerField;
    cds_FichadeProducaoNOMEPRODUTO: TStringField;
    cds_FichadeProducaoDATAGERACAOOPFE: TDateField;
    cds_FichadeProducaoIDOPMC: TIntegerField;
    cds_FichadeProducaoDATAGERACAOOPMC: TDateField;
    cds_FichadeProducaoCODIGOMC: TStringField;
    cds_FichadeProducaoOBSERVACAO: TStringField;
    cds_FichadeProducaoIDOPF: TIntegerField;
    cds_FichadeProducaoCODIGOBARRAS: TStringField;
    pnFotos: TPanel;
    ScrollBox1: TScrollBox;
    cds_FichadeProducaoIDOPFE: TStringField;
    cds_FichadeProducaoNUMEROLOTE: TStringField;
    pnImagem: TPanel;
    Image1: TImage;
    btnImagemWebCam: TBitBtn;
    btnSalvarImagem: TBitBtn;
    btnImagemArquivo: TBitBtn;
    pnLocalizacao: TPanel;
    edCodigoLocalizacao: TButtonedEdit;
    Label4: TLabel;
    Label6: TLabel;
    edNomeLocalizacao: TEdit;
    btExcluir: TSpeedButton;
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
    procedure btnImagemWebCamClick(Sender: TObject);
    procedure btnSalvarImagemClick(Sender: TObject);
    procedure btnImagemArquivoClick(Sender: TObject);
    procedure edDataPrevistaInicioChange(Sender: TObject);
    procedure edCodigoLocalizacaoRightButtonClick(Sender: TObject);
    procedure edCodigoLocalizacaoChange(Sender: TObject);
    procedure edCodigoLocalizacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btExcluirClick(Sender: TObject);
  private
    procedure SelecionarObservacao;
    procedure Deletar(Sender: TObject);
    procedure CalculaDataPrevistaTermino;
    procedure BuscaOPF;
    { Private declarations }
  public
    Parametros : TPARAMETROS;
    function AtualizarEdits(Limpar : Boolean) : Boolean;
    function Alterar : Boolean;
    function Inserir : Boolean;
    procedure CarregaDados;
    procedure InvertePaineis;
    procedure Cancelar;
    procedure Filtrar;
    procedure BuscarFotos;
  end;

var
  frmControleEstagioOPF: TfrmControleEstagioOPF;

implementation

uses
  uDomains,
  uFWConnection,
  uMensagem,
  uFuncoes,
  uBeanEstagio,
  uBeanOPFinal,
  uDMUtil,
  uBeanOrdemProducaoMC,
  uBeanOPFinal_Estagio,
  uBeanObservacao,
  uBeanProdutos,
  uBeanImagem,
  uBeanOpFinal_Estagio_Imagens,
  uBeanLocalizacao,
  uWebCam;

{$R *.dfm}

function TfrmControleEstagioOPF.Alterar: Boolean;
Var
  FWC     : TFWConnection;
  OPFE    : TOPFINAL_ESTAGIO;
  Alterar : Boolean;
begin

  Result  := False;
  Alterar := False;

  if not cds_Pesquisa.IsEmpty then begin

    FWC   := TFWConnection.Create;
    OPFE  := TOPFINAL_ESTAGIO.Create(FWC);
    try
      try

        OPFE.SelectList('ID = ' + cds_PesquisaID.AsString);
        if OPFE.Count = 1 then begin

          if ((not TOPFINAL_ESTAGIO(OPFE.Itens[0]).DATAHORAFIM.isNull) and (TOPFINAL_ESTAGIO(OPFE.Itens[0]).DATAHORAINICIO.Value < TOPFINAL_ESTAGIO(OPFE.Itens[0]).DATAHORAFIM.Value)) then begin
            DisplayMsg(MSG_WAR, 'Estágio Encerrado, Portanto não pode ser Alterado!');
            Exit;
          end;

          Alterar := True;
        end;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_ERR, 'Erro ao Verificar Estágio da Ordem de Produção, Verifique!', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(OPFE);
      FreeAndNil(FWC);
    end;

    if Alterar then begin
      if AtualizarEdits(False) then begin//Se Conseguiu Carregar os Dados Inverte os Painéis
        InvertePaineis;
        Result := True;
      end;
    end;
  end;
end;

function TfrmControleEstagioOPF.AtualizarEdits(Limpar: Boolean) : Boolean;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin

  Result := False;

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
    edQuantidadeEstimada.Clear;
    edIntervaloCrescimento.Clear;
    btGravar.Tag  := 0;
    pnFotos.Visible := False;
    edCodigoLocalizacao.Clear;
    edNomeLocalizacao.Clear;
    LimpaImagens;

    if Parametros.Acao = eNovo then begin //Caso for Chamada de outra tela carregar com o Cadastro do Planta
      if Parametros.Codigo > 0 then begin
        edCodigoOPF.Text := IntToStr(Parametros.Codigo);
        BuscaOPF;
        edCodigoOPF.Enabled := Length(Trim(edDescOPF.Text)) = 0;
      end;
    end;

    Result := True;
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
        SQL.SQL.Add('	OPFE.MEIOCULTURA_ID,');
        SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOMEIOCULTURA,');
        SQL.SQL.Add('	E.ID AS IDESTAGIO,');
        SQL.SQL.Add('	E.DESCRICAO AS DESCRICAOESTAGIO,');
        SQL.SQL.Add('	PR.ID AS ID_PRODUTO,');
        SQL.SQL.Add('	PR.DESCRICAO AS DESCRICAOPRODUTO,');
        SQL.SQL.Add('	OPFE.INTERVALOCRESCIMENTO,');
        SQL.SQL.Add('	OPFE.OBSERVACAO,');
        SQL.SQL.Add('	OPFE.QUANTIDADEESTIMADA,');
        SQL.SQL.Add('	OPFE.PREVISAOINICIO,');
        SQL.SQL.Add('	OPFE.PREVISAOTERMINO,');
        SQL.SQL.Add('	OPFE.LOCALIZACAO_ID,');
        SQL.SQL.Add('	LC.NOME AS LOCALIZACAO');
        SQL.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
        SQL.SQL.Add('INNER JOIN OPFINAL OPF ON (OPF.ID = OPFE.OPFINAL_ID)');
        SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
        SQL.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
        SQL.SQL.Add('INNER JOIN PRODUTO PR ON (PR.ID = OPF.PRODUTO_ID)');
        SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPFE.MEIOCULTURA_ID)');
        SQL.SQL.Add('INNER JOIN LOCALIZACAO LC ON (OPFE.LOCALIZACAO_ID = LC.ID)');
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
            edCodigoOPMC.Text           := SQL.FieldByName('MEIOCULTURA_ID').AsString;
            edDescOPMC.Text             := SQL.FieldByName('DESCRICAOMEIOCULTURA').AsString;
            edIntervaloCrescimento.Text := SQL.FieldByName('INTERVALOCRESCIMENTO').AsString;
            edObservacao.Text           := SQL.FieldByName('OBSERVACAO').AsString;
            edt_CodigoEspecie.Text      := SQL.FieldByName('ID_PRODUTO').AsString;
            edt_NomeEspecie.Text        := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
            edQuantidadeEstimada.Text   := SQL.FieldByName('QUANTIDADEESTIMADA').AsString;
            edDataPrevistaInicio.Date   := SQL.FieldByName('PREVISAOINICIO').AsDateTime;
            edDataPrevistaTermino.Date  := SQL.FieldByName('PREVISAOTERMINO').AsDateTime;
            edCodigoLocalizacao.Text    := SQL.FieldByName('LOCALIZACAO_ID').AsString;
            edNomeLocalizacao.Text      := SQL.FieldByName('LOCALIZACAO').AsString;
            pnFotos.Visible             := True;
          end;
        end;

        BuscarFotos;

        Result := True;

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
  Alterar;
end;

procedure TfrmControleEstagioOPF.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmControleEstagioOPF.btRelatorioClick(Sender: TObject);
begin

  if not cds_Pesquisa.IsEmpty then begin
    if btRelatorio.Tag = 0 then begin
      btRelatorio.Tag := 1;
      try
        ImprimirOPFE(cds_PesquisaID.AsInteger);
      finally
        btRelatorio.Tag := 0;
      end;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.BuscaOPF;
var
  FWC     : TFWConnection;
  SQL     : TFDQuery;
  Filtro  : string;
begin

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);

  try

    Filtro := 'DATAENCERRAMENTO IS NULL AND CANCELADO = False';

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
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.BuscarFotos;
var
  Imagem: TImage;
  i: integer;
  espaco: integer;
  Diretorio : string;
  NomeArquivo : string;
  FWC : TFWConnection;
  SQL : TFDQuery;
  IMG : TIMAGENS;
  Achou: Boolean;
begin
  ScrollBox1.HorzScrollBar.Position:=0;
  Diretorio := CONFIG_LOCAL.DirImagens; //aqui é o caminho da pasta
  espaco := 10;
  FWC   := TFWConnection.Create;
  SQL   := TFDQuery.Create(nil);
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT I.ID, I.NOMEIMAGEM');
    SQL.SQL.Add('FROM OPFINAL_ESTAGIO_IMAGENS OI');
    SQL.SQL.Add('INNER JOIN IMAGEM I ON OI.ID_IMAGEM = I.ID');
    SQL.SQL.Add('WHERE OI.ID_OPFINAL_ESTAGIO = :IDESTAGIO');
    SQL.Connection := FWC.FDConnection;
    SQL.ParamByName('IDESTAGIO').AsInteger := btGravar.Tag;
    SQL.Open();

    LimpaImagens;

    SQL.First;
    while not SQL.Eof do begin
      NomeArquivo := Diretorio + SQL.FieldByName('NOMEIMAGEM').asString;
      if FileExists(NomeArquivo) then begin
        Achou := False;
        for IMG in IMAGENS do begin
          if IMG.ID = SQL.Fields[0].AsInteger then begin
            Achou := True;
            Break;
          end;
        end;
        if not Achou then begin
          SetLength(IMAGENS, Length(IMAGENS) + 1);

          IMAGENS[High(IMAGENS)].ID          := SQL.Fields[0].AsInteger;
          IMAGENS[High(IMAGENS)].NomeImagem  := SQL.Fields[1].AsString;
          IMAGENS[High(IMAGENS)].Imagem      := TImage.Create(Self);
          IMAGENS[High(IMAGENS)].Imagem.Parent := ScrollBox1;
          IMAGENS[High(IMAGENS)].Imagem.Width := 50;
          IMAGENS[High(IMAGENS)].Imagem.Height := 50;
          IMAGENS[High(IMAGENS)].Imagem.Top := 10;
          IMAGENS[High(IMAGENS)].Imagem.Stretch := true;
          IMAGENS[High(IMAGENS)].Imagem.Left := espaco;
          IMAGENS[High(IMAGENS)].Imagem.OnDblClick := Deletar;
          IMAGENS[High(IMAGENS)].Imagem.Tag := SQL.FieldByName('ID').AsInteger;
          IMAGENS[High(IMAGENS)].Imagem.Picture.LoadFromFile(NomeArquivo);
          espaco := espaco + IMAGENS[High(IMAGENS)].Imagem.Height + 10;
        end;
      end else
        DisplayMsg(MSG_INF, 'Imagem não encontrada!', '', NomeArquivo);
      SQL.Next;
    end;
    ScrollBox1.Refresh;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.btExcluirClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    if btExcluir.Tag = 0 then begin
      btExcluir.Tag := 1;
      try
        if ExcluirOPFE(cds_PesquisaID.Value) then
          cds_Pesquisa.Delete;
      finally
        btExcluir.Tag := 0;
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

      ID := (Sender as TSpeedButton).Tag;

      if ID = 0 then begin //Só Verificar o limite Caso o for Cadastro.
        if LimiteMultiplicacao(StrToIntDef(edCodigoOPF.Text, 0), StrToIntDef(edCodigoEstagio.Text, 0)) then begin
          DisplayMsg(MSG_CONF, 'Limite de Multiplicações atingido, Deseja Continuar?');
          if ResultMsgModal <> mrYes then
            Exit;
        end;
      end;

      OPFE.OPFINAL_ID.Value           := StrToIntDef(edCodigoOPF.Text, 0);
      OPFE.MEIOCULTURA_ID.Value       := StrToIntDef(edCodigoOPMC.Text, 0);
      OPFE.ESTAGIO_ID.Value           := StrToIntDef(edCodigoEstagio.Text, 0);
      OPFE.OBSERVACAO.Value           := edObservacao.Text;
      OPFE.INTERVALOCRESCIMENTO.Value := StrToIntDef(edIntervaloCrescimento.Text,0);
      OPFE.QUANTIDADEESTIMADA.Value   := StrToIntDef(edQuantidadeEstimada.Text,0);
      OPFE.PREVISAOINICIO.Value       := edDataPrevistaInicio.Date;
      OPFE.PREVISAOTERMINO.Value      := edDataPrevistaTermino.Date;
      OPFE.LOCALIZACAO_ID.Value       := StrToIntDef(edCodigoLocalizacao.Text,0);

      if ID > 0 then begin
        OPFE.ID.Value          := ID;
        OPFE.Update;
      end else begin
        OPFE.ID.isNull            := True;
        OPFE.DATAHORA.Value       := Now;
        OPFE.DATAHORAINICIO.isNull:= True; //Será Preenchido na Primeira Produção
        OPFE.USUARIO_ID.Value     := USUARIO.CODIGO;

        //Verifica a sequencia
        OPFE.SelectList('OPFINAL_ID = ' + IntToStr(OPFE.OPFINAL_ID.Value), 'SEQUENCIA DESC');
        if OPFE.Count > 0 then
          OPFE.SEQUENCIA.Value    := TOPFINAL_ESTAGIO(OPFE.Itens[0]).SEQUENCIA.Value + 1
        else
          OPFE.SEQUENCIA.Value    := 1;

        //Verifica a sequencia do estágio
        OPFE.SelectList('OPFINAL_ID = ' + IntToStr(OPFE.OPFINAL_ID.Value) + ' AND ESTAGIO_ID = ' + IntToStr(OPFE.ESTAGIO_ID.Value), 'SEQUENCIAESTAGIO DESC');
        if OPFE.Count > 0 then
          OPFE.SEQUENCIAESTAGIO.Value    := TOPFINAL_ESTAGIO(OPFE.Itens[0]).SEQUENCIAESTAGIO.Value + 1
        else
          OPFE.SEQUENCIAESTAGIO.Value    := 1;

        OPFE.Insert;
      end;

      FWC.Commit;

      if Parametros.Acao = eNada then begin
        InvertePaineis;
        CarregaDados;
      end;

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

  if Parametros.Acao in [eNovo, eAlterar] then
    Close;
end;

procedure TfrmControleEstagioOPF.btnImagemArquivoClick(Sender: TObject);
Var
  Arquivo : string;
begin
  if btnImagemArquivo.Tag = 0 then begin
    btnImagemArquivo.Tag := 1;
    try
      Arquivo := SelecionarImagemBMP;
      if Length(Trim(Arquivo)) > 0 then
        Image1.Picture.LoadFromFile(Arquivo);
    finally
      btnImagemArquivo.Tag := 0;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.btnImagemWebCamClick(Sender: TObject);
begin
  if btnImagemWebCam.Tag = 0 then begin
    btnImagemWebCam.Tag := 1;

    if not Assigned(frmWebCam) then
      frmWebCam := tfrmWebCam.Create(Self);
    try
      if frmWebCam.ShowModal = mrOk then
        Image1.Picture := frmWebCam.img1.Picture;
    finally
      FreeAndNil(frmWebCam);
      btnImagemWebCam.Tag := 0;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.btNovoClick(Sender: TObject);
begin
  Inserir;
end;

procedure TfrmControleEstagioOPF.btnSalvarImagemClick(Sender: TObject);
var
  FWC : TFWConnection;
  IMG : TIMAGEM;
  EIMG : TOPFINAL_ESTAGIO_IMAGENS;
  Arquivo : string;
begin
  if Assigned(Image1.Picture.Graphic) then begin
    FWC  := TFWConnection.Create;
    IMG  := TIMAGEM.Create(FWC);
    EIMG := TOPFINAL_ESTAGIO_IMAGENS.Create(FWC);
    try
      FWC.StartTransaction;
      try

        Arquivo := CONFIG_LOCAL.DirImagens + FormatDateTime('yyyymmdd_hhmmss', Now) + '.bmp';

        Image1.Picture.Graphic.SaveToFile(Arquivo);

        if FileExists(Arquivo) then begin

          IMG.ID.isNull                := True;
          IMG.ID_USUARIO.Value         := USUARIO.CODIGO;
          IMG.NOMEIMAGEM.Value         := ExtractFileName(Arquivo);
          IMG.Insert;

          EIMG.ID.isNull               := True;
          EIMG.ID_IMAGEM.Value         := IMG.ID.Value;
          EIMG.ID_OPFINAL_ESTAGIO.Value:= btGravar.Tag;
          EIMG.Insert;

          FWC.Commit;

          Image1.Picture := Nil;
          Image1.Parent.Repaint;

          BuscarFotos;

        end else begin
          DisplayMsg(MSG_WAR, 'Falha ao Salvar a Imagem.: ' + Arquivo);
          Exit;
        end;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_WAR, 'Erro ao gravar imagem!', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(IMG);
      FreeAndNil(EIMG);
      FreeAndNil(FWC);
    end;
  end;
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

procedure TfrmControleEstagioOPF.CalculaDataPrevistaTermino;
begin
  if Length(SoNumeros(edDataPrevistaInicio.Text)) = 8 then begin
    if StrToIntDef(edIntervaloCrescimento.Text,0) > 0 then
      edDataPrevistaTermino.Date := edDataPrevistaInicio.Date + StrToIntDef(edIntervaloCrescimento.Text,0)
    else
      edDataPrevistaTermino.Date := edDataPrevistaInicio.Date;
  end;
end;

procedure TfrmControleEstagioOPF.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;

  //Se Foi Chamada de outra Tela Fecha.
  if Parametros.Acao in [eNovo, eAlterar] then
    Close;

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

      case Parametros.Acao of
        eNada : begin
          SQL.SQL.Add('AND OPF.CANCELADO = False');
          SQL.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
          SQL.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
        end;
        eNovo : SQL.SQL.Add('AND 1 = 2'); //Não Precisa trazer nada na tela
        eAlterar : begin
          if Parametros.Codigo > 0 then //Parametro quando tela Chamada de outro Cadastro
            SQL.SQL.Add('AND OPFE.ID = ' + IntToStr(Parametros.Codigo));
        end;
      end;

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

procedure TfrmControleEstagioOPF.Deletar(Sender: TObject);
var
  FWC  : TFWConnection;
  IMG  : TIMAGEM;
  EIMG : TOPFINAL_ESTAGIO_IMAGENS;
  NomeImagem : string;
  I: Integer;
begin
  if TImage(Sender).Tag = 0 then Exit;
  
  DisplayMsg(MSG_CONF, 'Deseja Excluir a imagem selecionada?');
  if ResultMsgModal in [mrOk, mrYes] then begin
     FWC  := TFWConnection.Create;
     IMG  := TIMAGEM.Create(FWC);
     EIMG := TOPFINAL_ESTAGIO_IMAGENS.Create(FWC);
     try
       FWC.StartTransaction;
       try
         IMG.ID.Value := TImage(Sender).Tag;
         IMG.SelectList('ID = ' + IMG.ID.asString);
         if IMG.Count > 0 then begin
           NomeImagem := CONFIG_LOCAL.DirImagens + TIMAGEM(IMG.Itens[0]).NOMEIMAGEM.asString;
           if (FileExists(NomeImagem)) then
             DeleteFile(NomeImagem);

           EIMG.SelectList('ID_IMAGEM = ' + IMG.ID.asString);
           for I := 0 to EIMG.Count - 1 do begin
             EIMG.ID.Value := TOPFINAL_ESTAGIO_IMAGENS(EIMG.Itens[I]).ID.Value;
             EIMG.Delete;
           end;

         end;

         IMG.Delete;

         FWC.Commit;

         TImage(Sender).Tag := 0;
         TImage(Sender).Picture.Assign(nil);

         BuscarFotos;
       except
         on E : Exception do begin
           FWC.Rollback;
           DisplayMsg(MSG_WAR, 'Erro ao excluir imagem!', '', E.Message);
         end;
       end;
     finally
       FreeAndNil(IMG);
       FreeAndNil(EIMG);
       FreeAndNil(FWC);
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

procedure TfrmControleEstagioOPF.edCodigoLocalizacaoChange(Sender: TObject);
begin
  edNomeLocalizacao.Clear;
end;

procedure TfrmControleEstagioOPF.edCodigoLocalizacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoLocalizacaoRightButtonClick(nil);
end;

procedure TfrmControleEstagioOPF.edCodigoLocalizacaoRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  L  : TLOCALIZACAO;
begin
  FWC := TFWConnection.Create;
  L   := TLOCALIZACAO.Create(FWC);

  try
    edCodigoLocalizacao.Text := IntToStr(DMUtil.Selecionar(L, edCodigoLocalizacao.Text, ''));
    L.SelectList('id = ' + edCodigoLocalizacao.Text);
    if L.Count = 1 then
      edNomeLocalizacao.Text := TLOCALIZACAO(L.Itens[0]).NOME.asString;
  finally
    FreeAndNil(L);
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
begin
  edCodigoOPF.Text := IntToStr(DMUtil.SelecionarCadastroPlantas(edCodigoOPF.Text));
  BuscaOPF;
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

    edCodigoOPMC.Text := IntToStr(DMUtil.SelecionarMeioCultura(StrToIntDef(edCodigoEstagio.Text , 0) , StrToIntDef(edt_CodigoEspecie.Text, 0), edCodigoOPMC.Text));

    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	P.ID,');
    SQL.SQL.Add('	P.DESCRICAO AS NOMEPRODUTO');
    SQL.SQL.Add('FROM PRODUTO P');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND P.ID = :IDOPMC');
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

procedure TfrmControleEstagioOPF.edDataPrevistaInicioChange(Sender: TObject);
begin
  CalculaDataPrevistaTermino;
end;

procedure TfrmControleEstagioOPF.edIntervaloCrescimentoChange(Sender: TObject);
begin
  CalculaDataPrevistaTermino;
end;

procedure TfrmControleEstagioOPF.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmControleEstagioOPF.FormCreate(Sender: TObject);
begin
  Parametros.Codigo := 0;
  Parametros.Acao   := eNada;
  SetLength(IMAGENS, 0);
  AjustaForm(Self);
  cds_Pesquisa.CreateDataSet;
  cds_FichadeProducao.CreateDataSet;
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
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
  case Parametros.Acao of
    eNovo   : begin
      if not Inserir then
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      edCodigoOPF.Text := IntToStr(Parametros.Codigo);
    end;
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

procedure TfrmControleEstagioOPF.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

function TfrmControleEstagioOPF.Inserir: Boolean;
begin

  Result := False;

  try

    if AtualizarEdits(True) then begin
      InvertePaineis;
      Result := True;
    end;

  except
    on E : Exception do begin
      DisplayMsg(MSG_ERR, 'Erro ao Iniciar Inserção', '', E.Message);
    end;
  end;
end;

procedure TfrmControleEstagioOPF.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if not edCodigoOPF.Enabled then begin
      if edCodigoEstagio.CanFocus then
        edCodigoEstagio.SetFocus;
    end else begin
    if edCodigoOPF.CanFocus then
      edCodigoOPF.SetFocus;
    end;
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
