unit uBeanOpFinal_Estagio_Imagens;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_IMAGENS = class(TFWPersistence)
  private
    FID: TFieldInteger;
    FID_OPFINAL_ESTAGIO: TFieldInteger;
    FID_IMAGEM: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_OPFINAL_ESTAGIO(const Value: TFieldInteger);
    procedure SetID_IMAGEM(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_OPFINAL_ESTAGIO : TFieldInteger read FID_OPFINAL_ESTAGIO write SetID_OPFINAL_ESTAGIO;
    property ID_IMAGEM : TFieldInteger read FID_IMAGEM write SetID_IMAGEM;
  end;
implementation

{ TOPFINAL_ESTAGIO_IMAGENS }

procedure TOPFINAL_ESTAGIO_IMAGENS.InitInstance;
begin
  inherited;
  ID.isPK         := True;
end;

procedure TOPFINAL_ESTAGIO_IMAGENS.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_IMAGENS.SetID_IMAGEM(const Value: TFieldInteger);
begin
  FID_IMAGEM := Value;
end;

procedure TOPFINAL_ESTAGIO_IMAGENS.SetID_OPFINAL_ESTAGIO(
  const Value: TFieldInteger);
begin
  FID_OPFINAL_ESTAGIO := Value;
end;

end.
