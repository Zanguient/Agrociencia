unit uBeanOrdemProducaoSolucao_Itens;

interface
uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOSOLUCAO_ITENS = class(TFWPersistence)
  private
    FID_PRODUTO: TFieldInteger;
    FID_ORDEMPRODUCAOSOLUCAO: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TfieldFloat;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ORDEMPRODUCAOSOLUCAO(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TfieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_ORDEMPRODUCAOSOLUCAO : TFieldInteger read FID_ORDEMPRODUCAOSOLUCAO write SetID_ORDEMPRODUCAOSOLUCAO;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property QUANTIDADE : TfieldFloat read FQUANTIDADE write SetQUANTIDADE;
  end;
implementation

{ TORDEMPRODUCAOSOLUCAO_ITENS }

procedure TORDEMPRODUCAOSOLUCAO_ITENS.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TORDEMPRODUCAOSOLUCAO_ITENS.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO_ITENS.SetID_ORDEMPRODUCAOSOLUCAO(
  const Value: TFieldInteger);
begin
  FID_ORDEMPRODUCAOSOLUCAO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO_ITENS.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO_ITENS.SetQUANTIDADE(
  const Value: TfieldFloat);
begin
  FQUANTIDADE := Value;
end;

end.
