unit uBeanMeioCultura;

interface
uses
  uFWPersistence,
  uDomains;

type
  TMEIOCULTURA = class(TFWPersistence)
  private
    FID_ESTAGIO: TFieldInteger;
    FOBSERVACAO: TFieldString;
    FID_PRODUTO: TFieldInteger;
    FPHRECOMENDADO: TFieldFloat;
    FCODIGO: TFieldString;
    FID: TFieldInteger;
    procedure SetCODIGO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ESTAGIO(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetPHRECOMENDADO(const Value: TFieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property ID_ESTAGIO : TFieldInteger read FID_ESTAGIO write SetID_ESTAGIO;
    property CODIGO : TFieldString read FCODIGO write SetCODIGO;
    property PHRECOMENDADO : TFieldFloat read FPHRECOMENDADO write SetPHRECOMENDADO;
    property OBSERVACAO : TFieldString read FOBSERVACAO write SetOBSERVACAO;
  end;
implementation

{ TMEIOCULTURA }

procedure TMEIOCULTURA.InitInstance;
begin
  inherited;
  ID.isPK := True;

  CODIGO.Size := 5;
  OBSERVACAO.Size := 512;
end;

procedure TMEIOCULTURA.SetCODIGO(const Value: TFieldString);
begin
  FCODIGO := Value;
end;

procedure TMEIOCULTURA.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TMEIOCULTURA.SetID_ESTAGIO(const Value: TFieldInteger);
begin
  FID_ESTAGIO := Value;
end;

procedure TMEIOCULTURA.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TMEIOCULTURA.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TMEIOCULTURA.SetPHRECOMENDADO(const Value: TFieldFloat);
begin
  FPHRECOMENDADO := Value;
end;

end.
