unit uBeanOrdemProducaoMC_Itens;

interface
uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOMC_ITENS = class(TFWPersistence)
  private
    FID_PRODUTO: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TFieldFloat;
    FID_ORDEMPRODUCAOMC: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ORDEMPRODUCAOMC(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_ORDEMPRODUCAOMC : TFieldInteger read FID_ORDEMPRODUCAOMC write SetID_ORDEMPRODUCAOMC;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property QUANTIDADE : TFieldFloat read FQUANTIDADE write SetQUANTIDADE;
  end;
implementation

{ TORDEMPRODUCAOMC_ITENS }

procedure TORDEMPRODUCAOMC_ITENS.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TORDEMPRODUCAOMC_ITENS.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOMC_ITENS.SetID_ORDEMPRODUCAOMC(
  const Value: TFieldInteger);
begin
  FID_ORDEMPRODUCAOMC := Value;
end;

procedure TORDEMPRODUCAOMC_ITENS.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TORDEMPRODUCAOMC_ITENS.SetQUANTIDADE(const Value: TFieldFloat);
begin
  FQUANTIDADE := Value;
end;

end.
