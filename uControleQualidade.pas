unit uControleQualidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs;

type
  TfrmControleQualidade = class(TForm)
    Panel1: TPanel;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btDescartar: TSpeedButton;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    btCancelar: TSpeedButton;
    pnSuperior: TPanel;
    edt_CodigoPote: TLabeledEdit;
    edt_Motivo: TEdit;
    edt_CodigoMotivo: TButtonedEdit;
    Label8: TLabel;
    Label1: TLabel;
    lbPote: TLabel;
    pnImagem: TPanel;
    Image1: TImage;
    btnImagemWebCam: TBitBtn;
    btnImagemArquivo: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btFecharClick(Sender: TObject);
    procedure edt_CodigoMotivoRightButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btDescartarClick(Sender: TObject);
    procedure edt_CodigoMotivoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImagemClick(Sender: TObject);
    procedure btnImagemArquivoClick(Sender: TObject);
  private
    { Private declarations }
    NomeImagemAtual : string;
    procedure SelecionaMotivoDescarte;
    procedure SelecionaPote;
    procedure LimparDados;
  public
    { Public declarations }
  end;

var
  frmControleQualidade: TfrmControleQualidade;

implementation
uses
  uFuncoes,
  uMensagem,
  uBeanOPFinal_Estagio,
  uBeanOPFinal_Estagio_Lote,
  uBeanOPFinal_Estagio_Lote_S,
  uConstantes,
  uBeanMotivoDescarte,
  uBeanProdutos,
  uBeanOPFinal,
  uDMUtil,
  uFWConnection, uBeanOPFinal_Estagio_Lote_S_Qualidade, uBeanControleEstoque,
  uBeanControleEstoqueProduto, Vcl.Imaging.jpeg, CapturaCam, uBeanImagem,
  uBeanOPFinal_E_L_S_Q_Imagem;

{$R *.dfm}

procedure TfrmControleQualidade.btCancelarClick(Sender: TObject);
begin
  LimparDados;
end;

procedure TfrmControleQualidade.btDescartarClick(Sender: TObject);
var
  FWC : TFWConnection;
  CQ  : TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE;
  OPS : TOPFINAL_ESTAGIO_LOTE_S;
  R   : TPRODUTO;
  CE  : TCONTROLEESTOQUE;
  CEP : TCONTROLEESTOQUEPRODUTO;
  IMG : TIMAGEM;
  IMGV: TOPFINAL_E_L_S_Q_IMAGEM;
begin
  FWC := TFWConnection.Create;
  CQ  := TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.Create(FWC);
  OPS := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
  R   := TPRODUTO.Create(FWC);
  CE  := TCONTROLEESTOQUE.Create(FWC);
  CEP := TCONTROLEESTOQUEPRODUTO.Create(FWC);
  IMG := TIMAGEM.Create(FWC);
  IMGV:= TOPFINAL_E_L_S_Q_IMAGEM.Create(FWC);
  try

    DisplayMsg(MSG_WAIT, 'Gravando dados! Aguarde...');
    FWC.StartTransaction;
    try

      CQ.ID.isNull := True;
      CQ.ID_OPFINAL_ESTAGIO_LOTE_S.Value               := StrToInt(edt_CodigoPote.Text);
      CQ.ID_MOTIVODESCARTE.Value                       := StrToInt(edt_CodigoMotivo.Text);
//      CQ.NOMEIMAGEM.Value                              := NomeImagemAtual;
      CQ.Insert;

      IMG.ID.isNull                                    := True;
      IMG.ID_USUARIO.Value                             := USUARIO.CODIGO;
      IMG.NOMEIMAGEM.Value                             := ExtractFileName(NomeImagemAtual);
      IMG.Insert;

      IMGV.ID.isNull                                   := True;
      IMGV.ID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE.Value   := CQ.ID.Value;
      IMGV.ID_IMAGEM.Value                             := IMG.ID.Value;
      IMGV.Insert;

      OPS.ID.Value                                     := CQ.ID_OPFINAL_ESTAGIO_LOTE_S.Value;
      OPS.BAIXADO.Value                                := True;
      OPS.Update;

      R.SelectList('ID = ' + IntToStr(lbPote.Tag));
      if R.Count > 0 then begin
        if TPRODUTO(R.Itens[0]).RECIPIENTEREAPROVEITAVEL.Value then begin
          CE.ID.isNull              := True;
          CE.DATAHORA.Value         := Now;
          CE.USUARIO_ID.Value       := USUARIO.CODIGO;
          CE.TIPOMOVIMENTACAO.Value := 0;
          CE.CANCELADO.Value        := False;
          CE.OBSERVACAO.Value       := 'Baixa do pote ' + edt_CodigoPote.Text;
          CE.Insert;

          CEP.ID.isNull := True;
          CEP.CONTROLEESTOQUE_ID.Value := CE.ID.Value;
          CEP.PRODUTO_ID.Value         := lbPote.Tag;
          CEP.QUANTIDADE.Value         := 1;
          CEP.Insert;
        end;
      end;
      FWC.Commit;
      DisplayMsgFinaliza;
      LimparDados;
      if edt_CodigoPote.CanFocus then edt_CodigoPote.SetFocus;

    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Ocorreu um erro ao descartar o pote selecionado!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(CQ);
    FreeAndNil(OPS);
    FreeAndNil(R);
    FreeAndNil(CE);
    FreeAndNil(CEP);
    FreeAndNil(IMG);
    FreeAndNil(IMGV);
    FreeAndNil(FWC);
  end;

end;

procedure TfrmControleQualidade.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmControleQualidade.btnImagemArquivoClick(Sender: TObject);
var
  DirNomeFoto : string;
begin
  if OpenPictureDialog1.Execute() then begin
    if OpenPictureDialog1.FileName <> '' then begin
      DirNomeFoto := CONFIG_LOCAL.DirImagens +
                     FormatDateTime('yyyymmdd_hhmmss', Now) + '_' + IntToStr(lbPote.Tag) +'.jpg';

      Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      Image1.Picture.SaveToFile(DirNomeFoto);
      NomeImagemAtual := DirNomeFoto;
    end;
  end;
end;

procedure TfrmControleQualidade.btnImagemClick(Sender: TObject);
var
  DirNomeFoto: string;
  NomeFoto: string;
begin
  fCaptura := TfCaptura.Create(Self);
  try
    DirNomeFoto := ExtractFilePath(Application.ExeName) +
      FormatDateTime('yyyymmdd_hhmmss', Now) + '_' + edt_CodigoPote.Text +'.bmp';

    NomeFoto := ExtractFilePath(DirNomeFoto) +
      Copy(ExtractFileName(DirNomeFoto),1, Length(ExtractFileName(DirNomeFoto))-4);

    fCaptura.camCamera.FichierImage := ExtractFileName(DirNomeFoto);
    if fCaptura.ShowModal = mrOk then begin
      fCaptura.camCamera.CaptureImageDisque;
      ConverterBMPtoJPEG(NomeFoto);
      NomeFoto := CONFIG_LOCAL.DirImagens + ExtractFileName(NomeFoto + '.jpg');
      Image1.Picture.LoadFromFile(NomeFoto);
      NomeImagemAtual := NomeFoto;
    end;
  finally
    FreeAndNil(fCaptura);
  end;
end;

procedure TfrmControleQualidade.edt_CodigoMotivoChange(Sender: TObject);
begin
  edt_Motivo.Clear;
end;

procedure TfrmControleQualidade.edt_CodigoMotivoRightButtonClick(
  Sender: TObject);
begin
  SelecionaMotivoDescarte;
end;

procedure TfrmControleQualidade.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmControleQualidade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : begin
      if edt_CodigoPote.Focused then
        SelecionaPote
      else if edt_CodigoMotivo.Focused then
        SelecionaMotivoDescarte;
    end;
    VK_ESCAPE : begin
      if lbPote.Tag > 0 then
        LimparDados
      else
        Close;
    end;
  end;
  if Key = VK_RETURN then begin


  end;
end;

procedure TfrmControleQualidade.LimparDados;
begin
  edt_CodigoPote.Clear;
  edt_CodigoMotivo.Clear;
  edt_Motivo.Clear;
  btDescartar.Enabled := False;
  btCancelar.Enabled := False;
  lbPote.Caption     := '';
  lbPote.Tag := 0;
  NomeImagemAtual   := '';
  pnImagem.Visible := False;
  Image1.Picture := nil;
end;

procedure TfrmControleQualidade.SelecionaMotivoDescarte;
var
  FWC : TFWConnection;
  M   : TMOTIVODESCARTE;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  M      := TMOTIVODESCARTE.Create(FWC);
  edt_Motivo.Clear;
  try
    Filtro := '';
    edt_CodigoMotivo.Tag := DMUtil.Selecionar(M, edt_CodigoMotivo.Text, Filtro);
    if edt_CodigoMotivo.Tag > 0 then begin
      M.SelectList('id = ' + IntToStr(edt_CodigoMotivo.Tag));
      if M.Count > 0 then begin
        edt_CodigoMotivo.Text     := TMOTIVODESCARTE(M.Itens[0]).ID.asString;
        edt_Motivo.Text           := TMOTIVODESCARTE(M.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(M);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleQualidade.SelecionaPote;
var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin
  pnImagem.Visible := False;
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.Connection := FWC.FDConnection;
    SQL.SQL.Add('SELECT ');
    SQL.SQL.Add('P.DESCRICAO AS ESPECIE,');
    SQL.SQL.Add('MC.DESCRICAO AS MEIOCULTURA,');
    SQL.SQL.Add('R.DESCRICAO AS RECIPIENTE,');
    SQL.SQL.Add('OP.ID AS OPFINAL,');
    SQL.SQL.Add('R.ID AS CODRECIPIENTE,');
    SQL.SQL.Add('E.DESCRICAO AS ESTAGIO');
    SQL.SQL.Add('FROM OPFINAL_ESTAGIO_LOTE_S OPS');
    SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPL ON OPS.OPFINAL_ESTAGIO_LOTE_ID = OPL.ID');
    SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPE ON OPL.OPFINAL_ESTAGIO_ID = OPE.ID');
    SQL.SQL.Add('INNER JOIN ORDEMPRODUCAOMC OPMC ON OPL.ORDEMPRODUCAOMC_ID = OPMC.ID');
    SQL.SQL.Add('INNER JOIN OPFINAL OP ON OPE.OPFINAL_ID = OP.ID');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON OP.PRODUTO_ID = P.ID');
    SQL.SQL.Add('INNER JOIN PRODUTO MC ON OPE.MEIOCULTURA_ID = MC.ID');
    SQL.SQL.Add('INNER JOIN PRODUTO R ON OPMC.ID_RECIPIENTE = R.ID');
    SQL.SQL.Add('INNER JOIN ESTAGIO E ON OPE.ESTAGIO_ID = E.ID');
    SQL.SQL.Add('WHERE OPS.ID = :POTE');
    SQL.SQL.Add('AND NOT OPS.BAIXADO');
    SQL.ParamByName('POTE').AsInteger := StrToInt(edt_CodigoPote.Text);
    SQL.Prepare;
    SQL.Open();

    if SQL.IsEmpty then begin
      DisplayMsg(MSG_WAR, 'Pote não encontrado! Verifique!');
      Exit;
    end;

    btDescartar.Enabled := True;
    btCancelar.Enabled  := True;

    lbPote.Caption := 'Código OP: ' + SQL.FieldByName('OPFINAL').AsString +
                      ', Espécie: ' + SQL.FieldByName('ESPECIE').AsString +
                      ', Meio de Cultura: ' + SQL.FieldByName('MEIOCULTURA').AsString +
                      ', Recipiente: ' + SQL.FieldByName('RECIPIENTE').AsString;
    lbPote.Tag := SQL.FieldByName('CODRECIPIENTE').AsInteger;
    if edt_CodigoMotivo.CanFocus then edt_CodigoMotivo.SetFocus;
    pnImagem.Visible := True;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

end.
