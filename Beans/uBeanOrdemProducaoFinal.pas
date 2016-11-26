unit uBeanOrdemProducaoFinal;

interface

uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOFINAL = class(TFWPersistence)
  private
    FPRODUTO_ID: TFieldInteger;
    FOBSERVACAO: TFieldString;
    FDATAHORA: TFieldDateTime;
    FCLIENTE_ID: TFieldInteger;
    FID: TFieldInteger;
    FRESPONSAVEL_ID: TFieldInteger;
    FQUANTIDADE: TFieldInteger;
    FDATAHORAFIM: TFieldDateTime;
    FDATAHORAINICIO: TFieldDateTime;
    FINTERVALOCRESCIMENTO: TFieldInteger;
    FUSUARIO_ID: TFieldInteger;
    FMEIODECULTURA_ID: TFieldInteger;
    procedure SetCLIENTE_ID(const Value: TFieldInteger);
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetDATAHORAFIM(const Value: TFieldDateTime);
    procedure SetDATAHORAINICIO(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetINTERVALOCRESCIMENTO(const Value: TFieldInteger);
    procedure SetMEIODECULTURA_ID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetPRODUTO_ID(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldInteger);
    procedure SetRESPONSAVEL_ID(const Value: TFieldInteger);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                   : TFieldInteger read FID write SetID;
    property DATAHORA             : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property DATAHORAINICIO       : TFieldDateTime read FDATAHORAINICIO write SetDATAHORAINICIO;
    property DATAHORAFIM          : TFieldDateTime read FDATAHORAFIM write SetDATAHORAFIM;
    property QUANTIDADE           : TFieldInteger read FQUANTIDADE write SetQUANTIDADE;
    property OBSERVACAO           : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property INTERVALOCRESCIMENTO : TFieldInteger read FINTERVALOCRESCIMENTO write SetINTERVALOCRESCIMENTO;
    property MEIODECULTURA_ID     : TFieldInteger read FMEIODECULTURA_ID write SetMEIODECULTURA_ID;
    property PRODUTO_ID           : TFieldInteger read FPRODUTO_ID write SetPRODUTO_ID;
    property CLIENTE_ID           : TFieldInteger read FCLIENTE_ID write SetCLIENTE_ID;
    property RESPONSAVEL_ID       : TFieldInteger read FRESPONSAVEL_ID write SetRESPONSAVEL_ID;
    property USUARIO_ID           : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
  end;


implementation

{ TORDEMPRODUCAOFINAL }

procedure TORDEMPRODUCAOFINAL.InitInstance;
begin
  inherited;
  ID.isPK                         := True;

  DATAHORA.isNotNull      			  := True;
  QUANTIDADE.isNotNull      		  := True;
  INTERVALOCRESCIMENTO.isNotNull  := True;
  MEIODECULTURA_ID.isNotNull      := True;
  PRODUTO_ID.isNotNull      		  := True;
  CLIENTE_ID.isNotNull      		  := True;
  RESPONSAVEL_ID.isNotNull      	:= True;
  USUARIO_ID.isNotNull      		  := True;

  OBSERVACAO.Size                 := 512;
end;

procedure TORDEMPRODUCAOFINAL.SetCLIENTE_ID(const Value: TFieldInteger);
begin
  FCLIENTE_ID := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetDATAHORAFIM(const Value: TFieldDateTime);
begin
  FDATAHORAFIM := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetDATAHORAINICIO(const Value: TFieldDateTime);
begin
  FDATAHORAINICIO := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetINTERVALOCRESCIMENTO(
  const Value: TFieldInteger);
begin
  FINTERVALOCRESCIMENTO := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetMEIODECULTURA_ID(const Value: TFieldInteger);
begin
  FMEIODECULTURA_ID := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetPRODUTO_ID(const Value: TFieldInteger);
begin
  FPRODUTO_ID := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetQUANTIDADE(const Value: TFieldInteger);
begin
  FQUANTIDADE := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetRESPONSAVEL_ID(const Value: TFieldInteger);
begin
  FRESPONSAVEL_ID := Value;
end;

procedure TORDEMPRODUCAOFINAL.SetUSUARIO_ID(const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
