unit uBeanControleEstoqueProduto;

interface

uses
  uFWPersistence,
  uDomains;

type
  TCONTROLEESTOQUEPRODUTO = class(TFWPersistence)
  private
    FPRODUTO_ID: TFieldInteger;
    FCONTROLEESTOQUE_ID: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TFieldCurrency;
    procedure SetCONTROLEESTOQUE_ID(const Value: TFieldInteger);
    procedure SetID(const Value: TFieldInteger);
    procedure SetPRODUTO_ID(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldCurrency);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property CONTROLEESTOQUE_ID : TFieldInteger read FCONTROLEESTOQUE_ID write SetCONTROLEESTOQUE_ID;
    property PRODUTO_ID : TFieldInteger read FPRODUTO_ID write SetPRODUTO_ID;
    property QUANTIDADE : TFieldCurrency read FQUANTIDADE write SetQUANTIDADE;
  end;

implementation

{ TCONTROLEESTOQUEPRODUTO }

procedure TCONTROLEESTOQUEPRODUTO.InitInstance;
begin
  inherited;
  ID.isPK                       := True;

  CONTROLEESTOQUE_ID.isNotNull  := True;
  PRODUTO_ID.isNotNull          := True;
  QUANTIDADE.isNotNull          := True;

end;

procedure TCONTROLEESTOQUEPRODUTO.SetCONTROLEESTOQUE_ID(
  const Value: TFieldInteger);
begin
  FCONTROLEESTOQUE_ID := Value;
end;

procedure TCONTROLEESTOQUEPRODUTO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TCONTROLEESTOQUEPRODUTO.SetPRODUTO_ID(const Value: TFieldInteger);
begin
  FPRODUTO_ID := Value;
end;

procedure TCONTROLEESTOQUEPRODUTO.SetQUANTIDADE(const Value: TFieldCurrency);
begin
  FQUANTIDADE := Value;
end;

end.
