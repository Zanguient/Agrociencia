unit uBeanOrdemProducaoMC_Descarte;

interface
uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOMC_DESCARTE = class(TFWPersistence)
  private
    FID_ORDEMPRODUCAOMC: TFieldInteger;
    FID_MOTIVO: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ORDEMPRODUCAOMC(const Value: TFieldInteger);
    procedure SetID_MOTIVO(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID: TFieldInteger read FID write SetID;
    property ID_ORDEMPRODUCAOMC: TFieldInteger read FID_ORDEMPRODUCAOMC write SetID_ORDEMPRODUCAOMC;
    property QUANTIDADE: TFieldInteger read FQUANTIDADE write SetQUANTIDADE;
    property ID_MOTIVO: TFieldInteger read FID_MOTIVO write SetID_MOTIVO;
  end;
implementation

{ TORDEMPRODUCAOMC_DESCARTE }

procedure TORDEMPRODUCAOMC_DESCARTE.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TORDEMPRODUCAOMC_DESCARTE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOMC_DESCARTE.SetID_ORDEMPRODUCAOMC(
  const Value: TFieldInteger);
begin
  FID_ORDEMPRODUCAOMC := Value;
end;

procedure TORDEMPRODUCAOMC_DESCARTE.SetID_MOTIVO(const Value: TFieldInteger);
begin
  FID_MOTIVO := Value;
end;

procedure TORDEMPRODUCAOMC_DESCARTE.SetQUANTIDADE(const Value: TFieldInteger);
begin
  FQUANTIDADE := Value;
end;

end.
