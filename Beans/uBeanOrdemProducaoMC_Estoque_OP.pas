unit uBeanOrdemProducaoMC_Estoque_OP;

interface
uses
  uFWPersistence,
  uDomains;

  type
    TORDEMPRODUCAOMC_ESTOQUE_OP = class(TFWPersistence)
  private
    FID_ORDEMPRODUCAOMC_ESTOQUE: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TFieldFloat;
    FID_OPFINAL: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_OPFINAL(const Value: TFieldInteger);
    procedure SetID_ORDEMPRODUCAOMC_ESTOQUE(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_ORDEMPRODUCAOMC_ESTOQUE : TFieldInteger read FID_ORDEMPRODUCAOMC_ESTOQUE write SetID_ORDEMPRODUCAOMC_ESTOQUE;
    property ID_OPFINAL : TFieldInteger read FID_OPFINAL write SetID_OPFINAL;
    property QUANTIDADE : TFieldFloat read FQUANTIDADE write SetQUANTIDADE;
    end;
implementation

{ TORDEMPRODUCAOMC_ESTOQUE_OP }

procedure TORDEMPRODUCAOMC_ESTOQUE_OP.InitInstance;
begin
  inherited;
  ID.isPK     := True;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE_OP.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE_OP.SetID_OPFINAL(const Value: TFieldInteger);
begin
  FID_OPFINAL := Value;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE_OP.SetID_ORDEMPRODUCAOMC_ESTOQUE(
  const Value: TFieldInteger);
begin
  FID_ORDEMPRODUCAOMC_ESTOQUE := Value;
end;

procedure TORDEMPRODUCAOMC_ESTOQUE_OP.SetQUANTIDADE(const Value: TFieldFloat);
begin
  FQUANTIDADE := Value;
end;

end.
