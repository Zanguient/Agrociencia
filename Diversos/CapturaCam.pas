unit CapturaCam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Camera, jpeg, Vcl.Buttons;

type
  TTabImage = Array[0..230399] of byte;

type
  TfCaptura = class(TForm)
    camCamera: TCamera;
    pnRodape: TPanel;
    GridPanel1: TGridPanel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCaptura: TfCaptura;

implementation

{$R *.dfm}

procedure TfCaptura.FormDestroy(Sender: TObject);
begin
  camCamera.Actif := False;
end;

procedure TfCaptura.FormShow(Sender: TObject);
//var
//  P : ^TTabImage;
begin
  try
    camCamera.Actif := True;
    //New(P);
    fCaptura.Caption := fCaptura.Caption + camCamera.FichierImage;
  except
    MessageDlg('Ocorreu um erro ao tentar ativar a Webcam.' + #13 +
      'Certifique-se de que a câmera esteja conctacda e corretamente configurada.', mtError, [mbOk], 0);
  end;
end;

end.
