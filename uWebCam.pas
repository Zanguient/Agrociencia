unit uWebCam;

(******************************************************************************

 Exemplo de Aplicativo com Webcam
 Autor: Fotógrafo Fernando VR
 Site: www.FernandoVR.com.br

 Sobre mim:
  Sou fotógrafo profissional, programador web PHP, e aprendiz no Delphi.
  Ainda estou iniciando meus estudos em Delphi por isso não adianta me adicionar
  para fazer perguntas difíceis que não saberei responder.

 Sobre o Aplicativo:
  Criei esse programa fuçando centenas de códigos fontes com webcam até encontrar
  um modo que não fosse necessário a instalação de nenhum componente e nem
  utilização de DLL´s.
  Este programa funciona com classes de Microsoft DirectX 9.0.
  Desenvolvi no DelphiXE 2, mas analisando o código fonte pode ser facilmente
  adaptado em versões anteriores.

******************************************************************************)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IniFiles, JPEG,
  VFrames, VSample, Direct3D9, DirectDraw, DirectShow9, DirectSound, DXTypes,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmWebCam = class(TForm)
    img1: TImage;
    Panel1: TPanel;
    btLigarDesligar: TButton;
    cbCameras: TComboBox;
    GridPanel1: TGridPanel;
    btCapturar: TBitBtn;
    btCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btLigarDesligarClick(Sender: TObject);
    procedure btCapturarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
    CameraAtivada  : boolean;
    fVideoImage : TVideoImage;
    fVideoBitmap:  TBitmap;
    procedure LigaDesligaCamera;
    procedure OnNewVideoCanvas(Sender : TObject; Width, Height: integer; DataPtr: pointer);
  public
    { Public declarations }
  end;

var
  frmWebCam: TfrmWebCam;

implementation

{$R *.dfm}

uses
  uConstantes, uMensagem;

procedure TfrmWebCam.OnNewVideoCanvas(Sender : TObject; Width, Height: integer; DataPtr: pointer);
begin
  fVideoImage.GetBitmap(fVideoBitmap);  // Pega o frame atual, Não sei pq mas precisa desta linha para funcionar.
  img1.picture.bitmap := fVideoBitmap;
end;

procedure TfrmWebCam.FormCreate(Sender: TObject);
var
  DeviceList : TStringList;
  I : Integer;
begin

  fVideoBitmap  := TBitmap.Create; // Cria um bitmap para os frames de vídeo.
  fVideoImage   := TVideoImage.Create;  // Cria uma imagem de vídeo.
  CameraAtivada := False; // Inicia avisando que a webcam está desligada;

  DeviceList := TStringList.Create;
  try
    fVideoImage.GetListOfDevices(DeviceList);
    cbCameras.Items := DeviceList;
    if cbCameras.Items.Count > 0 then begin
      cbCameras.ItemIndex := 0;
      if Length(Trim(CONFIG_LOCAL.WebCam)) > 0 then begin
        for I := 0 to cbCameras.Items.Count - 1 do begin
          if cbCameras.Items[I] = CONFIG_LOCAL.WebCam then begin
            cbCameras.ItemIndex := I;
            Break;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(DeviceList);
  end;
end;

procedure TfrmWebCam.FormDestroy(Sender: TObject);
begin
  fVideoImage.VideoStop;
  FreeAndNil(fVideoBitmap);
  FreeAndNil(fVideoImage);
end;

procedure TfrmWebCam.FormShow(Sender: TObject);
begin
  LigaDesligaCamera;
end;

procedure TfrmWebCam.LigaDesligaCamera;
var
  CamDevice : string;
begin
  if CameraAtivada then begin
    // Desliga a Webcam
    fVideoImage.VideoStop;
    btLigarDesligar.Caption := 'Ligar';
    CameraAtivada := False;
  end else begin

    CamDevice := Trim(cbCameras.Items.Strings[cbCameras.ItemIndex]);

    try

      fVideoImage.VideoStart(CamDevice);

      btLigarDesligar.Caption := 'Desligar';
      CameraAtivada := True;

      fVideoImage.OnNewVideoFrame := OnNewVideoCanvas;

    except
    end;
  end;

  cbCameras.Enabled := Not CameraAtivada;

end;

procedure TfrmWebCam.btCancelarClick(Sender: TObject);
begin
  if CameraAtivada then
    fVideoImage.VideoStop;
end;

procedure TfrmWebCam.btCapturarClick(Sender: TObject);
Var
  ArqIni : TIniFile;
begin

  if btCapturar.Tag = 0 then begin
    btCapturar.Tag := 1;
    try
      if CameraAtivada then begin
        ArqINI := TIniFile.Create(DirArqConf);
        try

          fVideoImage.VideoStop;

          if CONFIG_LOCAL.WebCam <> cbCameras.Items[cbCameras.ItemIndex] then begin
            CONFIG_LOCAL.WebCam := cbCameras.Items[cbCameras.ItemIndex];
            ArqINI.WriteString('CONFIGURACOES', 'WEBCAM', CONFIG_LOCAL.WebCam);
          end;

          ModalResult := mrOk;

        finally
          FreeAndNil(ArqIni);
        end;
      end else begin
        DisplayMsg(MSG_WAR, 'Câmera não Ativada, Verifique!');
        Exit;
      end;
    finally
      btCapturar.Tag := 0;
    end;
  end;
end;

procedure TfrmWebCam.btLigarDesligarClick(Sender: TObject);
begin
  if btLigarDesligar.Tag = 0 then begin
    btLigarDesligar.Tag := 1;
    try
      LigaDesligaCamera;
    finally
      btLigarDesligar.Tag := 0;
    end;
  end;
end;

end.
