unit uBeanProdutoComposicao;

interface
uses
  uFWPersistence,
  uDomains;
type
  TPRODUTOCOMPOSICAO = class(TFWPersistence)
  private
    FID_PRODUTO: TFieldInteger;
    FID: TFieldInteger;
    FID_COMPONENTE: TFieldInteger;
    FQUANTIDADE: TFieldFloat;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_COMPONENTE(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property ID_COMPONENTE : TFieldInteger read FID_COMPONENTE write SetID_COMPONENTE;
    property QUANTIDADE : TFieldFloat read FQUANTIDADE write SetQUANTIDADE;
  end;
implementation

{ TPRODUTOCOMPOSICAO }

procedure TPRODUTOCOMPOSICAO.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TPRODUTOCOMPOSICAO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TPRODUTOCOMPOSICAO.SetID_COMPONENTE(const Value: TFieldInteger);
begin
  FID_COMPONENTE := Value;
end;

procedure TPRODUTOCOMPOSICAO.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TPRODUTOCOMPOSICAO.SetQUANTIDADE(const Value: TFieldFloat);
begin
  FQUANTIDADE := Value;
end;

end.
