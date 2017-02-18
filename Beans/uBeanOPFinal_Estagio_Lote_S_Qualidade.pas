unit uBeanOPFinal_Estagio_Lote_S_Qualidade;

interface
uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE = class(TFWPersistence)
  private
    FID_OPFINAL_ESTAGIO_LOTE_S: TFieldInteger;
    FID: TFieldInteger;
    FID_MOTIVODESCARTE: TFieldInteger;
    FNOMEIMAGEM: TFieldString;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_MOTIVODESCARTE(const Value: TFieldInteger);
    procedure SetID_OPFINAL_ESTAGIO_LOTE_S(const Value: TFieldInteger);
    procedure SetNOMEIMAGEM(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_OPFINAL_ESTAGIO_LOTE_S : TFieldInteger read FID_OPFINAL_ESTAGIO_LOTE_S write SetID_OPFINAL_ESTAGIO_LOTE_S;
    property ID_MOTIVODESCARTE : TFieldInteger read FID_MOTIVODESCARTE write SetID_MOTIVODESCARTE;
    property NOMEIMAGEM : TFieldString read FNOMEIMAGEM write SetNOMEIMAGEM;
  end;
implementation

{ TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE }

procedure TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.InitInstance;
begin
  inherited;
  ID.isPK := True;

  NOMEIMAGEM.Size := 500;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.SetID_MOTIVODESCARTE(
  const Value: TFieldInteger);
begin
  FID_MOTIVODESCARTE := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.SetID_OPFINAL_ESTAGIO_LOTE_S(
  const Value: TFieldInteger);
begin
  FID_OPFINAL_ESTAGIO_LOTE_S := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.SetNOMEIMAGEM(
  const Value: TFieldString);
begin
  FNOMEIMAGEM := Value;
end;

end.
