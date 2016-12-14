unit uBeanOPFinal;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FPRODUTO_ID: TFieldInteger;
    FDATAHORA: TFieldDateTime;
    FCLIENTE_ID: TFieldInteger;
    FID: TFieldInteger;
    FQUANTIDADE: TFieldInteger;
    FUSUARIO_ID: TFieldInteger;
    procedure SetCLIENTE_ID(const Value: TFieldInteger);
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetPRODUTO_ID(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldInteger);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                   : TFieldInteger read FID write SetID;
    property DATAHORA             : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property QUANTIDADE           : TFieldInteger read FQUANTIDADE write SetQUANTIDADE;
    property PRODUTO_ID           : TFieldInteger read FPRODUTO_ID write SetPRODUTO_ID;
    property CLIENTE_ID           : TFieldInteger read FCLIENTE_ID write SetCLIENTE_ID;
    property USUARIO_ID           : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
    property OBSERVACAO           : TFieldString read FOBSERVACAO write SetOBSERVACAO;
  end;

implementation

{ TOPFINAL }

procedure TOPFINAL.InitInstance;
begin
  inherited;
  ID.isPK                           := True;

  FDATAHORA.isNotNull               := True;
  FQUANTIDADE.isNotNull             := True;
  FPRODUTO_ID.isNotNull             := True;
  FCLIENTE_ID.isNotNull             := True;
  FUSUARIO_ID.isNotNull             := True;

  OBSERVACAO.Size                   := 512;
end;

procedure TOPFINAL.SetCLIENTE_ID(const Value: TFieldInteger);
begin
  FCLIENTE_ID := Value;
end;

procedure TOPFINAL.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TOPFINAL.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TOPFINAL.SetPRODUTO_ID(const Value: TFieldInteger);
begin
  FPRODUTO_ID := Value;
end;

procedure TOPFINAL.SetQUANTIDADE(const Value: TFieldInteger);
begin
  FQUANTIDADE := Value;
end;

procedure TOPFINAL.SetUSUARIO_ID(const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
