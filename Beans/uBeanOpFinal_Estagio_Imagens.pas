unit uBeanOpFinal_Estagio_Imagens;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_IMAGENS = class(TFWPersistence)
  private
    FNOMEIMAGEM: TFieldString;
    FID: TFieldInteger;
    FID_OPFINAL_ESTAGIO: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_OPFINAL_ESTAGIO(const Value: TFieldInteger);
    procedure SetNOMEIMAGEM(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_OPFINAL_ESTAGIO : TFieldInteger read FID_OPFINAL_ESTAGIO write SetID_OPFINAL_ESTAGIO;
    property NOMEIMAGEM : TFieldString read FNOMEIMAGEM write SetNOMEIMAGEM;
  end;
implementation

{ TOPFINAL_ESTAGIO_IMAGENS }

procedure TOPFINAL_ESTAGIO_IMAGENS.InitInstance;
begin
  inherited;
  ID.isPK         := True;

  NOMEIMAGEM.Size := 500;
end;

procedure TOPFINAL_ESTAGIO_IMAGENS.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_IMAGENS.SetID_OPFINAL_ESTAGIO(
  const Value: TFieldInteger);
begin
  FID_OPFINAL_ESTAGIO := Value;
end;

procedure TOPFINAL_ESTAGIO_IMAGENS.SetNOMEIMAGEM(const Value: TFieldString);
begin
  FNOMEIMAGEM := Value;
end;

end.
