unit uOrdemProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Comp.Client, Vcl.ImgList, Vcl.Menus,
  Vcl.Imaging.jpeg, CapturaCam, uConstantes;

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
    cds_PesquisaQUANTIDADE: TIntegerField;
    cds_PesquisaESPECIE: TStringField;
    cds_PesquisaCLIENTE: TStringField;
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
    btMenu: TSpeedButton;
    cbStatus: TComboBox;
    PopupMenu: TPopupMenu;
    ENCERRAR1: TMenuItem;
    IMPRIMIRETIQUETAS1: TMenuItem;
    ImageList1: TImageList;
    Cancelar1: TMenuItem;
    edLimiteMultiplicacao: TEdit;
    Label14: TLabel;
    cds_Etiqueta1: TClientDataSet;
    cds_Etiqueta1CODIGOOP: TStringField;
    cds_PesquisaSELECAOPOSITIVA: TStringField;
    cds_PesquisaCODIGOSELECAOCAMPO: TStringField;
    Panel6: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    cbSelecaoPositiva: TComboBox;
    edCodSelecaoCampo: TEdit;
    Label7: TLabel;
    edOrigemMaterial: TEdit;
    Panel7: TPanel;
    edFazendaAreaTalhao: TEdit;
    Label4: TLabel;
    edDataColeta: TJvDateEdit;
    edColetadoPor: TEdit;
    Label5: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edLocalizador: TEdit;
    edQuantidadeMaterial: TEdit;
    edTransportadora: TEdit;
    edDataRecebimento: TJvDateEdit;
    edDataEstimada: TJvDateEdit;
    pnFotos: TPanel;
    ScrollBox1: TScrollBox;
    pnImagem: TPanel;
    Image1: TImage;
    btnImagemWebCam: TBitBtn;
    btnSalvarImagem: TBitBtn;
    btnImagemArquivo: TBitBtn;
    cds_Etiqueta1PRODUTO: TStringField;
    cds_PesquisaIDESPECIE: TIntegerField;
    cds_PesquisaDATA: TDateField;
    ScrollBox2: TScrollBox;
    gbVariedade: TGroupBox;
    edCodigoVariedade: TButtonedEdit;
    edDescricaoVariedade: TEdit;
    cds_PesquisaID_VARIEDADE: TIntegerField;
    cds_PesquisaVARIEDADE: TStringField;
    btExcluir: TSpeedButton;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure csPesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure gdPesquisaTitleClick(Column: TColumn);
    procedure btExportarClick(Sender: TObject);
    procedure btObservacaoClick(Sender: TObject);
    procedure edCodigoClienteChange(Sender: TObject);
    procedure edCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoClienteRightButtonClick(Sender: TObject);
    procedure edCodigoProdutoRightButtonClick(Sender: TObject);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoProdutoChange(Sender: TObject);
    procedure cbStatusChange(Sender: TObject);
    procedure ENCERRAR1Click(Sender: TObject);
    procedure btMenuClick(Sender: TObject);
    procedure Cancelar1Click(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure IMPRIMIRETIQUETAS1Click(Sender: TObject);
    procedure btnImagemWebCamClick(Sender: TObject);
    procedure btnImagemArquivoClick(Sender: TObject);
    procedure btnSalvarImagemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoVariedadeRightButtonClick(Sender: TObject);
    procedure edCodigoVariedadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoVariedadeChange(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    procedure SelecionarObservacao;
    procedure EncerrarOPF;
    procedure Deletar(Sender: TObject);
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
  frmOrdemProducao: TfrmOrdemProducao;

implementation

uses
  uDomains,
  uFWConnection,
  uBeanOPFinal,
  uMensagem,
  uFuncoes,
  uBeanObservacao,
  uDMUtil,
  uBeanCliente,
  uBeanProdutos,
  uBeanEstagio,
  uBeanOPFinal_Estagio,
  uBeanImagem,
  uBeanOPFinal_Imagem,
  uWebCam,
  uBeanVariedade;

{$R *.dfm}

function TfrmOrdemProducao.Alterar : Boolean;
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
begin

  Result := False;

  if not cds_Pesquisa.IsEmpty then begin

    FWC := TFWConnection.Create;
    OPF := TOPFINAL.Create(FWC);
    try
      try
        OPF.SelectList('ID = ' + cds_PesquisaID.AsString);
        if OPF.Count = 1 then begin
          if TOPFINAL(OPF.Itens[0]).DATAENCERRAMENTO.isNotNull then begin
            DisplayMsg(MSG_ERR, 'Ordem de Produção já Encerrada, Não pode ser Alterada!');
            Exit;
          end;
        end;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_ERR, 'Erro ao Verificar Ordem de Produção, Verifique!', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(OPF);
      FreeAndNil(FWC);
    end;

    if AtualizarEdits(False) then begin//Se Conseguiu Carregar os Dados Inverte os Painéis
      InvertePaineis;
      Result := True;
    end;
  end;
end;

function TfrmOrdemProducao.AtualizarEdits(Limpar : Boolean) : Boolean;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I   : Integer;
begin

  Result := False;

  if Limpar then begin
    edQuantidade.Clear;
    edCodigoCliente.Clear;
    edNomeCliente.Clear;
    edCodigoProduto.Clear;
    edNomeProduto.Clear;
    edCodigoVariedade.Clear;
    edObservacao.Clear;
    edLimiteMultiplicacao.Text := '0';
    cbSelecaoPositiva.ItemIndex := 0;
    edCodSelecaoCampo.Clear;
    edOrigemMaterial.Clear;
    edDataColeta.Clear;
    edColetadoPor.Clear;
    edFazendaAreaTalhao.Clear;
    edLocalizador.Clear;
    edQuantidadeMaterial.Text := '0';
    edTransportadora.Clear;
    edDataRecebimento.Clear;
    edDataEstimada.Clear;
    btGravar.Tag  := 0;
    pnFotos.Visible := False;
    Result := True;
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
        SQL.SQL.Add('	OPF.CLIENTE_ID,');
        SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
        SQL.SQL.Add('	OPF.PRODUTO_ID,');
        SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
        SQL.SQL.Add('	OPF.SELECAOPOSITIVA,');
        SQL.SQL.Add('	OPF.ORIGEMMATERIAL,');
        SQL.SQL.Add('	OPF.CODIGOSELECAOCAMPO,');
        SQL.SQL.Add('	OPF.DATADECOLETA,');
        SQL.SQL.Add('	OPF.COLETADOPOR,');
        SQL.SQL.Add('	OPF.FAZENDAAREATALHAO,');
        SQL.SQL.Add('	OPF.LOCALIZADOR,');
        SQL.SQL.Add('	OPF.QUANTIDADEENVIADA,');
        SQL.SQL.Add('	OPF.TRANSPORTADORA,');
        SQL.SQL.Add('	OPF.DATADERECEBIMENTO,');
        SQL.SQL.Add('	OPF.DATAESTIMADAPROCESSAMENTO,');
        SQL.SQL.Add('	OPF.OBSERVACAO,');
        SQL.SQL.Add('	OPF.LIMITEMULTIPLICACOES,');
        SQL.SQL.Add('	OPF.ID_VARIEDADE,');
        SQL.SQL.Add('	V.NOME AS VARIEDADE');
        SQL.SQL.Add('FROM OPFINAL OPF');
        SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
        SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
        SQL.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
        SQL.SQL.Add('WHERE 1 = 1');
        SQL.SQL.Add('AND OPF.ID = :OPID');
        SQL.Connection  := FWC.FDConnection;
        SQL.ParamByName('OPID').DataType  := ftInteger;
        SQL.Prepare;
        SQL.ParamByName('OPID').AsInteger := btGravar.Tag;
        SQL.Open;

        if not SQL.IsEmpty then begin
          if SQL.FieldByName('CODIGO').AsInteger = btGravar.Tag then begin
            edQuantidade.Text           := SQL.FieldByName('QUANTIDADE').AsString;
            edCodigoCliente.Text        := SQL.FieldByName('CLIENTE_ID').AsString;
            edNomeCliente.Text          := SQL.FieldByName('NOMECLIENTE').AsString;
            edCodigoProduto.Text        := SQL.FieldByName('PRODUTO_ID').AsString;
            edNomeProduto.Text          := SQL.FieldByName('DESCRICAOPRODUTO').AsString;
            edCodigoVariedade.Text      := SQL.FieldByName('ID_VARIEDADE').AsString;
            edDescricaoVariedade.Text   := SQL.FieldByName('VARIEDADE').AsString;
            edObservacao.Text           := SQL.FieldByName('OBSERVACAO').AsString;
            edLimiteMultiplicacao.Text  := SQL.FieldByName('LIMITEMULTIPLICACOES').AsString;

            for I := 0 to cbSelecaoPositiva.Items.Count - 1 do begin
              if cbSelecaoPositiva.Items[I] = SQL.FieldByName('SELECAOPOSITIVA').AsString then begin
                cbSelecaoPositiva.ItemIndex := I;
                Break;
              end;
            end;

            edCodSelecaoCampo.Text      := SQL.FieldByName('CODIGOSELECAOCAMPO').AsString;
            edOrigemMaterial.Text       := SQL.FieldByName('ORIGEMMATERIAL').AsString;
            edDataColeta.Date           := SQL.FieldByName('DATADECOLETA').AsDateTime;
            edColetadoPor.Text          := SQL.FieldByName('COLETADOPOR').AsString;
            edFazendaAreaTalhao.Text    := SQL.FieldByName('FAZENDAAREATALHAO').AsString;
            edLocalizador.Text          := SQL.FieldByName('LOCALIZADOR').AsString;
            edQuantidadeMaterial.Text   := SQL.FieldByName('QUANTIDADEENVIADA').AsString;
            edTransportadora.Text       := SQL.FieldByName('TRANSPORTADORA').AsString;
            edDataRecebimento.Date      := SQL.FieldByName('DATADERECEBIMENTO').AsDateTime;
            edDataEstimada.Date         := SQL.FieldByName('DATAESTIMADAPROCESSAMENTO').AsDateTime;
          end;
          pnFotos.Visible               := True;
          BuscarFotos;
        end;

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

procedure TfrmOrdemProducao.btAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TfrmOrdemProducao.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmOrdemProducao.btExcluirClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    if btExcluir.Tag = 0 then begin
      btExcluir.Tag := 1;
      try
        if ExcluirOPF(cds_PesquisaID.Value) then
          cds_Pesquisa.Delete;
      finally
        btExcluir.Tag := 0;
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
  E   : TESTAGIO;
  OPE : TOPFINAL_ESTAGIO;
begin

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

  if Length(Trim(edDescricaoVariedade.Text)) = 0  then begin
    DisplayMsg(MSG_WAR, 'Cultivar/Variedade não informado, Verifique!');
    if edCodigoVariedade.CanFocus then
      edCodigoVariedade.SetFocus;
    Exit;
  end;

  if Length(SoNumeros(edDataColeta.Text)) > 0 then begin
    try
      StrToDate(edDataColeta.Text);
    except
      DisplayMsg(MSG_WAR, 'Data de Coleta Inválida, Verifique!');
      if edDataColeta.CanFocus then
        edDataColeta.SetFocus;
      Exit;
    end;
  end;

  if Length(SoNumeros(edDataRecebimento.Text)) > 0 then begin
    try
      StrToDate(edDataRecebimento.Text);
    except
      DisplayMsg(MSG_WAR, 'Data de Recebimento Inválida, Verifique!');
      if edDataRecebimento.CanFocus then
        edDataRecebimento.SetFocus;
      Exit;
    end;
  end;

  if Length(SoNumeros(edDataEstimada.Text)) > 0 then begin
    try
      StrToDate(edDataEstimada.Text);
    except
      DisplayMsg(MSG_WAR, 'Data Estimada Inválida, Verifique!');
      if edDataEstimada.CanFocus then
        edDataEstimada.SetFocus;
      Exit;
    end;
  end;

  FWC := TFWConnection.Create;
  OPF := TOPFINAL.Create(FWC);
  E   := TESTAGIO.Create(FWC);
  OPE := TOPFINAL_ESTAGIO.Create(FWC);

  try
    try

      OPF.DATAHORA.Value                  := Now;
      OPF.QUANTIDADE.Value                := StrToIntDef(edQuantidade.Text,0);
      OPF.CLIENTE_ID.Value                := StrToIntDef(edCodigoCliente.Text,0);
      OPF.PRODUTO_ID.Value                := StrToIntDef(edCodigoProduto.Text,0);
      OPF.USUARIO_ID.Value                := USUARIO.CODIGO;
      OPF.OBSERVACAO.Value                := edObservacao.Text;
      OPF.LIMITEMULTIPLICACOES.Value      := StrToIntDef(edLimiteMultiplicacao.Text,0);
      OPF.SELECAOPOSITIVA.Value           := cbSelecaoPositiva.Items[cbSelecaoPositiva.ItemIndex];
      OPF.CODIGOSELECAOCAMPO.Value        := edCodSelecaoCampo.Text;
      OPF.ORIGEMMATERIAL.Value            := edOrigemMaterial.Text;
      OPF.DATADECOLETA.Value              := edDataColeta.Date;
      OPF.COLETADOPOR.Value               := edColetadoPor.Text;
      OPF.FAZENDAAREATALHAO.Value         := edFazendaAreaTalhao.Text;
      OPF.LOCALIZADOR.Value               := edLocalizador.Text;
      OPF.QUANTIDADEENVIADA.Value         := StrToIntDef(edQuantidadeMaterial.Text, 0);
      OPF.TRANSPORTADORA.Value            := edTransportadora.Text;
      OPF.DATADERECEBIMENTO.Value         := edDataRecebimento.Date;
      OPF.DATAESTIMADAPROCESSAMENTO.Value := edDataEstimada.Date;
      OPF.ID_VARIEDADE.Value              := StrToInt(edCodigoVariedade.Text);

      if (Sender as TSpeedButton).Tag > 0 then begin
        OPF.ID.Value          := (Sender as TSpeedButton).Tag;
        OPF.Update;
      end else begin
        OPF.ID.isNull                     := True;
        OPF.QUANTIDADEPRODUZIDA.Value     := 0;
        OPF.CANCELADO.Value               := False;
        OPF.Insert;
      end;

      FWC.Commit;

      if Parametros.Acao = eNada then begin
        InvertePaineis;
        CarregaDados;
      end;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar a Ordem de Produção!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(OPF);
    FreeAndNil(E);
    FreeAndNil(OPE);
    FreeAndNil(FWC);
  end;

  if Parametros.Acao in [eNovo, eAlterar] then
    Close;

end;

procedure TfrmOrdemProducao.btMenuClick(Sender: TObject);
begin
  PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmOrdemProducao.btnImagemArquivoClick(Sender: TObject);
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

procedure TfrmOrdemProducao.btnImagemWebCamClick(Sender: TObject);
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

procedure TfrmOrdemProducao.btNovoClick(Sender: TObject);
begin
  if AtualizarEdits(True) then //Se Conseguiu Carregar os Dados Inverte os Painéis
    InvertePaineis;
end;

procedure TfrmOrdemProducao.btnSalvarImagemClick(Sender: TObject);
var
  FWC : TFWConnection;
  IMG : TIMAGEM;
  EIMG : TOPFINAL_IMAGEM;
  Arquivo : string;
begin

  if Assigned(Image1.Picture.Graphic) then begin
    FWC  := TFWConnection.Create;
    IMG  := TIMAGEM.Create(FWC);
    EIMG := TOPFINAL_IMAGEM.Create(FWC);
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
          EIMG.ID_OPFINAL.Value        := btGravar.Tag;
          EIMG.Insert;

          FWC.Commit;

          Image1.Picture := nil;
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

procedure TfrmOrdemProducao.btPesquisarClick(Sender: TObject);
begin
  if btPesquisar.Tag = 0 then begin
    btPesquisar.Tag := 1;
    try
      Filtrar;
    finally
      btPesquisar.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducao.BuscarFotos;
var
  Imagem: TImage;
  i: integer;
  espaco: integer;
  Diretorio : string;
  NomeArquivo : string;
  FWC : TFWConnection;
  SQL : TFDQuery;
  Achou: Boolean;
  IMG : TIMAGENS;
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
    SQL.SQL.Add('FROM OPFINAL_IMAGEM OI');
    SQL.SQL.Add('INNER JOIN IMAGEM I ON OI.ID_IMAGEM = I.ID');
    SQL.SQL.Add('WHERE OI.ID_OPFINAL = :IDOPFINAL');
    SQL.Connection := FWC.FDConnection;
    SQL.ParamByName('IDOPFINAL').AsInteger := btGravar.Tag;
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
    ScrollBox1.Repaint;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducao.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;

  if Parametros.Acao in [eNovo, eAlterar] then //Se Foi Chamada de outra Tela Fecha.
    Close;

  InvertePaineis;
end;

procedure TfrmOrdemProducao.Cancelar1Click(Sender: TObject);
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
  SQL : TFDQuery;
begin

  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Cancelar a Ordem de Produção Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        OPF := TOPFINAL.Create(FWC);
        SQL := TFDQuery.Create(nil);
        try

          OPF.SelectList('ID = ' + cds_PesquisaID.AsString);
          if OPF.Count = 1 then begin

            if TOPFINAL(OPF.Itens[0]).CANCELADO.Value then begin
              DisplayMsg(MSG_WAR, 'Ordem de Produção já Cancelada, Verifique!');
              Exit;
            end;

            if not TOPFINAL(OPF.Itens[0]).DATAENCERRAMENTO.isNull then begin
              DisplayMsg(MSG_WAR, 'Ordem de Produção já Encerrada, Portanto não pode ser Cancelada!');
              Exit;
            end;

            SQL.Close;
            SQL.SQL.Clear;
            SQL.SQL.Add('SELECT');
            SQL.SQL.Add('  COUNT(OPFELS.ID) AS UNIDADES');
            SQL.SQL.Add('FROM OPFINAL OPF');
            SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
            SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
            SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
            SQL.SQL.Add('WHERE 1 = 1');
            SQL.SQL.Add('AND OPFELS.BAIXADO = FALSE');
            SQL.SQL.Add('AND OPF.ID = :IDOPF');
            SQL.ParamByName('IDOPF').DataType  := ftInteger;
            SQL.ParamByName('IDOPF').Value     := TOPFINAL(OPF.Itens[0]).ID.Value;

            SQL.Connection  := FWC.FDConnection;
            SQL.Prepare;
            SQL.Open;
            SQL.FetchAll;

            if not SQL.IsEmpty then begin
              DisplayMsg(MSG_WAR, 'Existem ' + SQL.FieldByName('UNIDADES').AsString + ' Unidades não Baixadas, Verifique!');
              Exit;
            end;

            OPF.ID.Value        := TOPFINAL(OPF.Itens[0]).ID.Value;
            OPF.CANCELADO.Value := True;
            OPF.Update;

            FWC.Commit;

            CarregaDados;
          end;
        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Cancelar a Ordem de Produção, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(SQL);
        FreeAndNil(OPF);
        FreeAndNil(FWC);
      end;
    end;
  end;
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
      SQL.SQL.Add('	OPF.ID,');
      SQL.SQL.Add('	CAST(OPF.DATAHORA AS DATE) AS DATA,');
      SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
      SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOESPECIE,');
      SQL.SQL.Add('	P.ID AS CODIGOESPECIE,');
      SQL.SQL.Add('	OPF.QUANTIDADE,');
      SQL.SQL.Add('	OPF.SELECAOPOSITIVA,');
      SQL.SQL.Add('	OPF.CODIGOSELECAOCAMPO,');
      SQL.SQL.Add('	OPF.ID_VARIEDADE,');
      SQL.SQL.Add('	V.NOME AS VARIEDADE');
      SQL.SQL.Add('FROM OPFINAL OPF');
      SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      SQL.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      SQL.SQL.Add('WHERE 1 = 1');

      if Parametros.Codigo > 0 then //Parametro quando tela Chamada de outro Cadastro
        SQL.SQL.Add('AND OPF.ID = ' + IntToStr(Parametros.Codigo))
      else begin
        case cbStatus.ItemIndex of
          0 : SQL.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL AND OPF.CANCELADO = False');
          1 : SQL.SQL.Add('AND OPF.DATAENCERRAMENTO IS NOT NULL AND OPF.CANCELADO = False');
          2 : SQL.SQL.Add('AND OPF.CANCELADO = True');
        end;
      end;

      SQL.SQL.Add('ORDER BY OPF.ID ASC');
      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value                  := SQL.FieldByName('ID').AsInteger;
          cds_PesquisaDATA.Value                := SQL.FieldByName('DATA').AsDateTime;
          cds_PesquisaCLIENTE.Value             := SQL.FieldByName('NOMECLIENTE').AsString;
          cds_PesquisaESPECIE.Value             := SQL.FieldByName('DESCRICAOESPECIE').AsString;
          cds_PesquisaID_VARIEDADE.Value        := SQL.FieldByName('ID_VARIEDADE').AsInteger;
          cds_PesquisaVARIEDADE.Value           := SQL.FieldByName('VARIEDADE').AsString;
          cds_PesquisaQUANTIDADE.Value          := SQL.FieldByName('QUANTIDADE').AsInteger;
          cds_PesquisaSELECAOPOSITIVA.Value     := SQL.FieldByName('SELECAOPOSITIVA').AsString;
          cds_PesquisaCODIGOSELECAOCAMPO.Value  := SQL.FieldByName('CODIGOSELECAOCAMPO').AsString;
          cds_PesquisaIDESPECIE.Value           := SQL.FieldByName('CODIGOESPECIE').AsInteger;
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

procedure TfrmOrdemProducao.cbStatusChange(Sender: TObject);
begin
  CarregaDados;
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

procedure TfrmOrdemProducao.Deletar(Sender: TObject);
var
  FWC  : TFWConnection;
  IMG  : TIMAGEM;
  EIMG : TOPFINAL_IMAGEM;
  NomeImagem : string;
  I: Integer;
begin
  if TImage(Sender).Tag = 0 then Exit;

  DisplayMsg(MSG_CONF, 'Deseja Excluir a imagem selecionada?');
  if ResultMsgModal in [mrOk, mrYes] then begin
     FWC  := TFWConnection.Create;
     IMG  := TIMAGEM.Create(FWC);
     EIMG := TOPFINAL_IMAGEM.Create(FWC);
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
             EIMG.ID.Value := TOPFINAL_IMAGEM(EIMG.Itens[I]).ID.Value;
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

procedure TfrmOrdemProducao.edCodigoClienteChange(Sender: TObject);
begin
  edNomeCliente.Clear;
end;

procedure TfrmOrdemProducao.edCodigoClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoClienteRightButtonClick(nil);
end;

procedure TfrmOrdemProducao.edCodigoClienteRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  C   : TCLIENTE;
begin
  FWC := TFWConnection.Create;
  C   := TCLIENTE.Create(FWC);

  try
    edCodigoCliente.Text := IntToStr(DMUtil.Selecionar(C, edCodigoCliente.Text));
    C.SelectList('id = ' + edCodigoCliente.Text);
    if C.Count = 1 then
      edNomeCliente.Text := TCLIENTE(C.Itens[0]).NOME.asString;
  finally
    FreeAndNil(C);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducao.edCodigoProdutoChange(Sender: TObject);
begin
  edNomeProduto.Clear;
end;

procedure TfrmOrdemProducao.edCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoProdutoRightButtonClick(nil);
end;

procedure TfrmOrdemProducao.edCodigoProdutoRightButtonClick(Sender: TObject);
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

procedure TfrmOrdemProducao.edCodigoVariedadeChange(Sender: TObject);
begin
  edDescricaoVariedade.Clear;
end;

procedure TfrmOrdemProducao.edCodigoVariedadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoVariedadeRightButtonClick(nil);
end;

procedure TfrmOrdemProducao.edCodigoVariedadeRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  V   : TVARIEDADE;
begin
  FWC := TFWConnection.Create;
  V   := TVARIEDADE.Create(FWC);

  if edNomeProduto.Text = EmptyStr then begin
    DisplayMsg(MSG_INF, 'Informe a espécie para selecionar a variedade!');
    Exit;
  end;

  try
    edCodigoVariedade.Text := IntToStr(DMUtil.Selecionar(V, edCodigoVariedade.Text, 'id_produto = ' + QuotedStr(edCodigoProduto.Text) ));
    V.SelectList('id = ' + edCodigoVariedade.Text);
    if V.Count = 1 then
      edDescricaoVariedade.Text := TVARIEDADE(V.Itens[0]).NOME.asString;
  finally
    FreeAndNil(V);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducao.ENCERRAR1Click(Sender: TObject);
begin
  if ENCERRAR1.Tag = 0 then begin
    ENCERRAR1.Tag := 1;
    try
      EncerrarOPF;
    finally
      ENCERRAR1.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducao.EncerrarOPF;
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
  OPFE: TOPFINAL_ESTAGIO;
  I   : Integer;
begin

  if not cds_Pesquisa.IsEmpty then begin

    FWC := TFWConnection.Create;
    OPF := TOPFINAL.Create(FWC);
    OPFE:= TOPFINAL_ESTAGIO.Create(FWC);

    try
      try
        OPF.SelectList('ID = ' + cds_PesquisaID.AsString);
        if OPF.Count = 1 then begin
          if not TOPFINAL(OPF.Itens[0]).DATAENCERRAMENTO.isNull then begin
            DisplayMsg(MSG_WAR, 'Ordem de Produção já Encerrada!');
            Exit;
          end;

          DisplayMsg(MSG_INPUT_INT, 'Informe a Quantidade de Plantas Produzidas!');

          if ResultMsgModal = mrOk then begin
            OPF.ID.Value                  := TOPFINAL(OPF.Itens[0]).ID.Value;
            OPF.DATAENCERRAMENTO.Value    := Now;
            OPF.QUANTIDADEPRODUZIDA.Value := ResultMsgInputInt;
            OPF.Update;

            OPFE.SelectList('OPFINAL_ID = ' + cds_PesquisaID.AsString);
            if OPFE.Count > 0 then begin
              for I := 0 to OPFE.Count - 1 do begin
                OPFE.ID.Value           := TOPFINAL_ESTAGIO(OPFE.Itens[I]).ID.Value;
                OPFE.DATAHORAFIM.Value  := OPF.DATAENCERRAMENTO.Value;
                OPFE.Update;
              end;
            end;

            FWC.Commit;

            DisplayMsg(MSG_OK, 'Ordem de Produção Nº ' + TOPFINAL(OPF.Itens[0]).ID.asString + ' Encerrada com Sucesso!');

            CarregaDados;
          end;
        end;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_ERR, 'Erro ao Encerrar a Ordem de Produção, Verifique!', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(OPFE);
      FreeAndNil(OPF);
      FreeAndNil(FWC);
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
  cds_Pesquisa.CreateDataSet;
  cds_Etiqueta1.CreateDataSet;
  Parametros.Codigo := 0;
  Parametros.Acao   := eNada;
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
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);

  case Parametros.Acao of
    eNovo   : begin
      if not Inserir then
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
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

procedure TfrmOrdemProducao.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmOrdemProducao.IMPRIMIRETIQUETAS1Click(Sender: TObject);
Var
  I : Integer;
begin

  if not cds_Pesquisa.IsEmpty then begin

    cds_Etiqueta1.EmptyDataSet;

    try

      DisplayMsg(MSG_INPUT_INT, 'Informe a Quantidade de Estiquetas!');

      if ResultMsgModal = mrOk then begin
        if ResultMsgInputInt > 0 then begin
          for I := 1 to ResultMsgInputInt do begin
            cds_Etiqueta1.Append;
            cds_Etiqueta1CODIGOOP.AsString  := StrZero(cds_PesquisaID.AsString, MinimoCodigoBarras);
            cds_Etiqueta1PRODUTO.AsString   := cds_PesquisaESPECIE.AsString + ' - ' + cds_PesquisaID.AsString;
            cds_Etiqueta1.Post;
          end;
        end;
      end;

      if not cds_Etiqueta1.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := cds_Etiqueta1;
        RelParams.Clear;
        DMUtil.ImprimirRelatorio('frEtiqueta1.fr3');
      end;
    finally
      cds_Etiqueta1.EmptyDataSet;
    end;
  end;

end;

function TfrmOrdemProducao.Inserir: Boolean;
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

procedure TfrmOrdemProducao.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edCodigoCliente.CanFocus then
      edCodigoCliente.SetFocus;
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
