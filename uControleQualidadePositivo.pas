unit uControleQualidadePositivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.Imaging.jpeg, CapturaCam, Data.DB;

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
  uFuncoes,
  uFWConnection,
  uMensagem,
  uConstantes,
  uBeanOPFinal_Estagio_Lote_S_Positivo,
  uBeanImagem,
  uBeanOPFinal_Estagio_Lote;

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
  OPFEL     : TOPFINAL_ESTAGIO_LOTE;
  Consulta  : TFDQuery;
begin
  if NomeImagemAtual = '' then begin
    DisplayMsg(MSG_WAR, 'Selecione uma imagem para continuar!');
    Exit;
  end;

  if edt_Localizacao.Enabled then begin
    if Length(Trim(edt_Localizacao.Text)) = 0 then begin
      DisplayMsg(MSG_WAR, 'Obrigatório informar a Localização do Lote, Verifique!');
      if edt_Localizacao.CanFocus then
        edt_Localizacao.SetFocus;
      Exit;
    end;
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

        //Atualizar a localização no Lote
        if edt_Localizacao.Enabled then begin

          OPFEL   := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
          Consulta:= TFDQuery.Create(nil);
          try
            try

              Consulta.Close;
              Consulta.SQL.Clear;
              Consulta.SQL.Add('SELECT');
              Consulta.SQL.Add('	OPFEL.ID AS IDLOTE');
              Consulta.SQL.Add('FROM OPFINAL_ESTAGIO_LOTE OPFEL');
              Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
              Consulta.SQL.Add('WHERE 1 = 1');
              Consulta.SQL.Add('AND OPFELS.ID = :IDPOTE');
              Consulta.SQL.Add('AND OPFEL.LOCALIZACAO <> :LOCALIZACAO');

              Consulta.Connection := FWC.FDConnection;

              Consulta.ParamByName('IDPOTE').DataType       := ftInteger;
              Consulta.ParamByName('LOCALIZACAO').DataType  := ftString;
              Consulta.ParamByName('IDPOTE').Value          := edt_CodigoPote.Tag;
              Consulta.ParamByName('LOCALIZACAO').Value     := edt_Localizacao.Text;

              Consulta.Prepare;
              Consulta.Open;
              Consulta.FetchAll;

              if not Consulta.IsEmpty then begin
                Consulta.First;
                while not Consulta.Eof do begin
                  OPFEL.ID.Value          := Consulta.FieldByName('IDLOTE').AsInteger;
                  OPFEL.LOCALIZACAO.Value := edt_Localizacao.Text;
                  OPFEL.Update;
                  Consulta.Next;
                end;
              end;
            except
              on E: Exception do
                raise Exception.Create('Erro ao Atualizar Localização no Lote.: ' + E.Message);
            end;

          finally
            FreeAndNil(OPFEL);
            FreeAndNil(Consulta);
          end;
        end;

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
  edt_CodigoPote.Enabled  := True;
  btGravar.Enabled        := False;
  btCancelar.Enabled      := False;
  lbPote.Caption          := '';
  edt_CodigoPote.Tag      := 0;
  NomeImagemAtual         := '';
  pnImagem.Visible        := False;
  Image1.Picture.Assign(nil);

  if edt_CodigoPote.CanFocus then
    edt_CodigoPote.SetFocus;

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
    SQL.SQL.Add('SELECT ');
    SQL.SQL.Add(' OPS.ID AS IDPOTE,');
    SQL.SQL.Add(' P.DESCRICAO AS ESPECIE,');
    SQL.SQL.Add(' MC.DESCRICAO AS MEIOCULTURA,');
    SQL.SQL.Add(' R.DESCRICAO AS RECIPIENTE,');
    SQL.SQL.Add(' OP.ID AS OPFINAL,');
    SQL.SQL.Add(' R.ID AS CODRECIPIENTE,');
    SQL.SQL.Add(' E.DESCRICAO AS ESTAGIO,');
    SQL.SQL.Add(' OPL.LOCALIZACAO AS LOCALIZACAO');
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

    SQL.Connection := FWC.FDConnection;

    SQL.ParamByName('POTE').AsInteger := StrToIntDef(edt_CodigoPote.Text, -1);
    SQL.Prepare;
    SQL.Open();

    if not SQL.IsEmpty then begin

      btGravar.Enabled        := True;
      btCancelar.Enabled      := True;
      edt_CodigoPote.Enabled  := False;

      lbPote.Caption := 'Código OP: ' + SQL.FieldByName('OPFINAL').AsString +
                        ', Espécie: ' + SQL.FieldByName('ESPECIE').AsString +
                        ', Meio de Cultura: ' + SQL.FieldByName('MEIOCULTURA').AsString +
                        ', Recipiente: ' + SQL.FieldByName('RECIPIENTE').AsString;

      edt_CodigoPote.Tag  := SQL.FieldByName('IDPOTE').AsInteger;
      edt_Localizacao.Text:= SQL.FieldByName('LOCALIZACAO').AsString;

      if edt_Localizacao.CanFocus then
        edt_Localizacao.SetFocus;

      pnImagem.Visible := True;
    end else begin
      DisplayMsg(MSG_WAR, 'Pote não encontrado! Verifique!');
      Exit;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

end.
