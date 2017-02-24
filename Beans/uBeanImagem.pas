unit uBeanImagem;

interface
uses
  uFWPersistence,
  uDomains;
type
  TIMAGEM = class(TFWPersistence)
  private
    FNOMEIMAGEM: TFieldString;
    FID: TFieldInteger;
    FID_USUARIO: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_USUARIO(const Value: TFieldInteger);
    procedure SetNOMEIMAGEM(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_USUARIO : TFieldInteger read FID_USUARIO write SetID_USUARIO;
    property NOMEIMAGEM : TFieldString read FNOMEIMAGEM write SetNOMEIMAGEM;

  end;


implementation

{ TIMAGEM }

procedure TIMAGEM.InitInstance;
begin
  inherited;
  ID.isPK := True;

  NOMEIMAGEM.Size := 255;
end;

procedure TIMAGEM.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TIMAGEM.SetID_USUARIO(const Value: TFieldInteger);
begin
  FID_USUARIO := Value;
end;

procedure TIMAGEM.SetNOMEIMAGEM(const Value: TFieldString);
begin
  FNOMEIMAGEM := Value;
end;

end.
