unit uFotosEstagio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TfrmFotosEstagio = class(TForm)
    ImagePrincipal: TImage;
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Visualizar(Sender: TObject);
  public
    { Public declarations }
    IdEstagio : Integer;
    procedure BuscarFotos;
  end;

var
  frmFotosEstagio: TfrmFotosEstagio;

implementation

uses
  uFWConnection, FireDAC.Comp.Client, uConstantes, uFuncoes;

{$R *.dfm}

procedure TfrmFotosEstagio.BuscarFotos;
var
  FWC : TFWConnection;
  SQL : TFDQuery;
  espaco : Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    SQL.Close;
    SQL.Connection := FWC.FDConnection;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT I.ID, I.NOMEIMAGEM');
    SQL.SQL.Add('FROM OPFINAL_ESTAGIO_IMAGENS OPEI');
    SQL.SQL.Add('INNER JOIN IMAGEM I ON OPEI.ID_IMAGEM = I.ID');
    SQL.SQL.Add('WHERE ID_OPFINAL_ESTAGIO = :ESTAGIO');
    SQL.ParamByName('ESTAGIO').AsInteger := IdEstagio;
    SQL.Prepare;
    SQL.Open();

    SetLength(IMAGENS, 0);

    if not (SQL.IsEmpty) then begin
      espaco := 10;
      SQL.First;
      while not SQL.Eof do begin
        SetLength(IMAGENS, Length(IMAGENS) + 1);
        IMAGENS[High(IMAGENS)].ID              := SQL.Fields[0].AsInteger;
        IMAGENS[High(IMAGENS)].NomeImagem      := SQL.Fields[1].AsString;
        IMAGENS[High(IMAGENS)].Imagem          := TImage.Create(nil);
        IMAGENS[High(IMAGENS)].Imagem.OnClick  := Visualizar;
        IMAGENS[High(IMAGENS)].Imagem.Parent   := ScrollBox1;
        IMAGENS[High(IMAGENS)].Imagem.Width    := 50;
        IMAGENS[High(IMAGENS)].Imagem.Height   := 50;
        IMAGENS[High(IMAGENS)].Imagem.Top      := 10;
        IMAGENS[High(IMAGENS)].Imagem.Stretch  := true;
        IMAGENS[High(IMAGENS)].Imagem.Left     := espaco;
        IMAGENS[High(IMAGENS)].Imagem.Tag      := SQL.FieldByName('ID').AsInteger;
        IMAGENS[High(IMAGENS)].Imagem.Picture.LoadFromFile(CONFIG_LOCAL.DirImagens + SQL.Fields[1].AsString);
        espaco := espaco + IMAGENS[High(IMAGENS)].Imagem.Height + 10;

        SQL.Next;
      end;
    end;

    ScrollBox1.Repaint;
    ScrollBox1.Refresh;

  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmFotosEstagio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LimpaImagens;
end;

procedure TfrmFotosEstagio.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmFotosEstagio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmFotosEstagio.FormShow(Sender: TObject);
begin
  BuscarFotos;
end;

procedure TfrmFotosEstagio.Visualizar(Sender: TObject);
var
  I: Integer;
begin
  for I := Low(IMAGENS) to High(IMAGENS) do begin
    if IMAGENS[I].ID = TImage(Sender).Tag then begin
      ImagePrincipal.Picture.Assign(TImage(Sender).Picture);
      Break;
    end;
  end;

end;

end.
