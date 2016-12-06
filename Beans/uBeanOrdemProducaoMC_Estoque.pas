unit uBeanOrdemProducaoMC_Estoque;

interface
uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOMC_ESTOQUE = class(TFWPersistence)
  private
    FID_ORDEMPRODUCAOMC: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TFieldFloat;
    FSALDO: TFieldFloat;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ORDEMPRODUCAOMC(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldFloat);
    procedure SetSALDO(const Value: TFieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_ORDEMPRODUCAOMC : TFieldInteger read FID_ORDEMPRODUCAOMC write SetID_ORDEMPRODUCAOMC;
    property QUANTIDADE : TFieldFloat read FQUANTIDADE write SetQUANTIDADE;
    property SALDO : TFieldFloat read FSALDO write SetSALDO;
  end;
implementation

{ TORDEMPRODUCAOMC_ESTOQUE }

procedure TORDEMPRODUCAOMC_ESTOQUE.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE.SetID_ORDEMPRODUCAOMC(
  const Value: TFieldInteger);
begin
  FID_ORDEMPRODUCAOMC := Value;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE.SetQUANTIDADE(const Value: TFieldFloat);
begin
  FQUANTIDADE := Value;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE.SetSALDO(const Value: TFieldFloat);
begin
  FSALDO := Value;
end;

end.
