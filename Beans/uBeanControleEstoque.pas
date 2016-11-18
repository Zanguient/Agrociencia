unit uBeanControleEstoque;

interface

uses
  uFWPersistence,
  uDomains;

type
  TCONTROLEESTOQUE = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FDATAHORA: TFieldDateTime;
    FID: TFieldInteger;
    FUSUARIO_ID: TFieldInteger;
    FCANCELADO: TFieldBoolean;
    FTIPOMOVIMENTACAO: TFieldInteger;
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
    procedure SetCANCELADO(const Value: TFieldBoolean);
    procedure SetTIPOMOVIMENTACAO(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID               : TFieldInteger read FID write SetID;
    property DATAHORA         : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property USUARIO_ID       : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
    property TIPOMOVIMENTACAO : TFieldInteger read FTIPOMOVIMENTACAO write SetTIPOMOVIMENTACAO;
    property CANCELADO        : TFieldBoolean read FCANCELADO write SetCANCELADO;
    property OBSERVACAO       : TFieldString read FOBSERVACAO write SetOBSERVACAO;
  end;

implementation

{ TCONTROLEESTOQUE }

procedure TCONTROLEESTOQUE.InitInstance;
begin
  inherited;
  ID.isPK                     := True;

  DATAHORA.isNotNull          := True;
  USUARIO_ID.isNotNull        := True;
  TIPOMOVIMENTACAO.isNotNull  := True;
  CANCELADO.isNotNull         := True;

  OBSERVACAO.Size             := 512;

end;

procedure TCONTROLEESTOQUE.SetCANCELADO(const Value: TFieldBoolean);
begin
  FCANCELADO := Value;
end;

procedure TCONTROLEESTOQUE.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TCONTROLEESTOQUE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TCONTROLEESTOQUE.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TCONTROLEESTOQUE.SetTIPOMOVIMENTACAO(const Value: TFieldInteger);
begin
  FTIPOMOVIMENTACAO := Value;
end;

procedure TCONTROLEESTOQUE.SetUSUARIO_ID(const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
