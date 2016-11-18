unit uBeanControleEstoqueCancelamento;

interface

uses
  uFWPersistence,
  uDomains;

type
  TCONTROLEESTOQUECANCELAMENTO = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FDATAHORA: TFieldDateTime;
    FCONTROLEESTOQUE_ID: TFieldInteger;
    FID: TFieldInteger;
    FUSUARIO_ID: TFieldInteger;
    procedure SetCONTROLEESTOQUE_ID(const Value: TFieldInteger);
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                 : TFieldInteger read FID write SetID;
    property CONTROLEESTOQUE_ID : TFieldInteger read FCONTROLEESTOQUE_ID write SetCONTROLEESTOQUE_ID;
    property DATAHORA           : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property USUARIO_ID         : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
    property OBSERVACAO         : TFieldString read FOBSERVACAO write SetOBSERVACAO;
  end;

implementation

{ TCONTROLEESTOQUECANCELAMENTO }

procedure TCONTROLEESTOQUECANCELAMENTO.InitInstance;
begin
  inherited;
  ID.isPK                       := True;

  CONTROLEESTOQUE_ID.isNotNull  := True;
  DATAHORA.isNotNull            := True;
  USUARIO_ID.isNotNull          := True;

  OBSERVACAO.Size               := 512;
end;

procedure TCONTROLEESTOQUECANCELAMENTO.SetCONTROLEESTOQUE_ID(
  const Value: TFieldInteger);
begin
  FCONTROLEESTOQUE_ID := Value;
end;

procedure TCONTROLEESTOQUECANCELAMENTO.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TCONTROLEESTOQUECANCELAMENTO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TCONTROLEESTOQUECANCELAMENTO.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TCONTROLEESTOQUECANCELAMENTO.SetUSUARIO_ID(
  const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
