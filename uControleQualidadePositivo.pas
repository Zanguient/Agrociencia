unit uControleQualidadePositivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.Imaging.jpeg, CapturaCam;

type
  TfrmControleQualidadePositivo = class(TForm)
    Panel1: TPanel;
    pnSuperior: TPanel;
    lbPote: TLabel;
    edt_CodigoPote: TLabeledEdit;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    btCancelar: TSpeedButton;
    pnImagem: TPanel;
    Image1: TImage;
    btnImagemWebCam: TBitBtn;
    btnImagemArquivo: TBitBtn;
    btGravar: TSpeedButton;
    edt_Localizacao: TLabeledEdit;
    Label1: TLabel;
    mnObservacao: TMemo;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImagemArquivoClick(Sender: TObject);
    procedure btnImagemWebCamClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NomeImagemAtual : string;
    procedure SelecionaPote;
    procedure LimpaDados;
  end;

var
  frmControleQualidadePositivo: TfrmControleQualidadePositivo;

implementation

uses
  uFuncoes, uFWConnection, uMensagem, uConstantes,
  uBeanOPFinal_Estagio_Lote_S_Positivo, uBeanImagem;

{$R *.dfm}

procedure TfrmControleQualidadePositivo.btCancelarClick(Sender: TObject);
begin
  if edt_CodigoPote.Tag > 0 then
    LimpaDados
  else
    Close;
end;

procedure TfrmControleQualidadePositivo.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmControleQualidadePositivo.btGravarClick(Sender: TObject);
var
  FWC       : TFWConnection;
  POSITIVO  : TOPFINAL_ESTAGIO_LOTE_S_POSITIVO;
  IMAGEM    : TIMAGEM;
begin
  if NomeImagemAtual = '' then begin
    DisplayMsg(MSG_WAR, 'Selecione uma imagem para continuar!');
    Exit;
  end;

  if edt_CodigoPote.Tag > 0 then begin
    FWC       := TFWConnection.Create;
    IMAGEM    := TIMAGEM.Create(FWC);
    POSITIVO  := TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.Create(FWC);
    try

      FWC.StartTransaction;
      try
        IMAGEM.ID.isNull        := True;
        IMAGEM.ID_USUARIO.Value := USUARIO.CODIGO;
        IMAGEM.NOMEIMAGEM.Value := ExtractFileName(NomeImagemAtual);
        IMAGEM.Insert;

        POSITIVO.ID.isNull                       := True;
        POSITIVO.ID_OPFINAL_ESTAGIO_LOTE_S.Value := edt_CodigoPote.Tag;
        POSITIVO.ID_IMAGEM.Value                 := IMAGEM.ID.Value;
        POSITIVO.LOCALIZACAO.Value               := edt_Localizacao.Text;
        POSITIVO.OBSERVACAO.Value                := mnObservacao.Text;
        POSITIVO.Insert;

        FWC.Commit;

        LimpaDados;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_WAR, 'Erro ao Salvar Dados', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(POSITIVO);
      FreeAndNil(IMAGEM);
      FreeAndNil(FWC);
    end;
  end;
end;

procedure TfrmControleQualidadePositivo.btnImagemArquivoClick(Sender: TObject);
var
  DirNomeFoto : string;
begin
  if OpenPictureDialog1.Execute() then begin
    if OpenPictureDialog1.FileName <> '' then begin
      DirNomeFoto := CONFIG_LOCAL.DirImagens +
                     FormatDateTime('yyyymmdd_hhmmss', Now) + '_' + IntToStr(edt_CodigoPote.Tag) +'.jpg';

      Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      Image1.Picture.SaveToFile(DirNomeFoto);
      NomeImagemAtual := DirNomeFoto;
    end;
  end;
end;

procedure TfrmControleQualidadePositivo.btnImagemWebCamClick(Sender: TObject);
var
  DirNomeFoto: string;
  NomeFoto: string;
  procedure ConverteParaJpeg(ACaminhoFoto: string);
  var
    cjBmp: TBitmap;
    cjJpg: TJpegImage;
    strNomeSemExtensao: string;
    AFoto: TImage;
    Nome : string;
  begin
    AFoto:= TImage.Create(Self);
    AFoto.Parent := Self;
    AFoto.Visible := False;
    AFoto.Picture.Bitmap.LoadFromFile(ACaminhoFoto + '.bmp');

    cjJpg := TJPegImage.Create;
    cjBmp := TBitmap.Create;

    cjBmp.Assign(AFoto.Picture.Bitmap);
    cjJpg.Assign(cjBMP);

    Nome := ExtractFileName(ACaminhoFoto + '.jpg');

    cjJpg.SaveToFile(CONFIG_LOCAL.DirImagens + Nome);
    DeleteFile(ACaminhoFoto + '.bmp');
    cjJpg.Free;
    cjBmp.Free;
    AFoto.Free;
  end;
begin
  fCaptura := TfCaptura.Create(Self);
  try
    DirNomeFoto := ExtractFilePath(Application.ExeName) +
      FormatDateTime('yyyymmdd_hhmmss', Now) + '_' + IntToStr(edt_CodigoPote.Tag) +'.bmp';

    NomeFoto := ExtractFilePath(DirNomeFoto) +
      Copy(ExtractFileName(DirNomeFoto),1, Length(ExtractFileName(DirNomeFoto))-4);

    fCaptura.camCamera.FichierImage := ExtractFileName(DirNomeFoto);
    if fCaptura.ShowModal = mrOk then begin
      fCaptura.camCamera.CaptureImageDisque;
      ConverteParaJpeg(NomeFoto);
      NomeFoto := CONFIG_LOCAL.DirImagens + ExtractFileName(NomeFoto + '.jpg');
      Image1.Picture.LoadFromFile(NomeFoto);
      NomeImagemAtual := NomeFoto;
    end;
  finally
    FreeAndNil(fCaptura);
  end;
end;

procedure TfrmControleQualidadePositivo.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmControleQualidadePositivo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN : begin
      if edt_CodigoPote.Focused then
        SelecionaPote;
    end;
    VK_ESCAPE : begin
      if edt_CodigoPote.Tag > 0 then
        LimpaDados
      else
        Close;
    end;
  end;
end;

procedure TfrmControleQualidadePositivo.LimpaDados;
begin
  edt_CodigoPote.Clear;
  edt_Localizacao.Clear;
  mnObservacao.Clear;
  btGravar.Enabled := False;
  btCancelar.Enabled := False;
  lbPote.Caption     := '';
  edt_CodigoPote.Tag := 0;
  NomeImagemAtual   := '';
  pnImagem.Visible := False;
  Image1.Picture.Assign(nil);
end;

procedure TfrmControleQualidadePositivo.SelecionaPote;
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
    SQL.SQL.Add('INNER JOIN OPFINAL OP ON OPE.OPFINAL_ID = OP.ID');
    SQL.SQL.Add('INNER JOIN ORDEMPRODUCAOMC OPMC ON OPL.ORDEMPRODUCAOMC_ID = OPMC.ID');
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

    btGravar.Enabled    := True;
    btCancelar.Enabled  := True;

    lbPote.Caption := 'Código OP: ' + SQL.FieldByName('OPFINAL').AsString +
                      ', Espécie: ' + SQL.FieldByName('ESPECIE').AsString +
                      ', Meio de Cultura: ' + SQL.FieldByName('MEIOCULTURA').AsString +
                      ', Recipiente: ' + SQL.FieldByName('RECIPIENTE').AsString;
    edt_CodigoPote.Tag := SQL.FieldByName('CODRECIPIENTE').AsInteger;
    if edt_Localizacao.CanFocus then edt_Localizacao.SetFocus;
    pnImagem.Visible := True;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

end.
