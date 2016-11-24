unit uBeanOrdemProducaoMP;

interface
uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOMP = class(TFWPersistence)
  private
    FESTERILIZACAO: TFieldBoolean;
    FQUANTRECIPIENTES: TFieldInteger;
    FID_PRODUTO: TFieldInteger;
    FDATAHORA: TFieldDateTime;
    FID_RECIPIENTE: TFieldInteger;
    FPHRECOMENDADO: TFieldFloat;
    FID_USUARIOEXECUTAR: TFieldInteger;
    FID: TFieldInteger;
    FDATAFIM: TFieldDateTime;
    FDATAINICIO: TFieldDateTime;
    FPHFINAL: TFieldFloat;
    FPHINICIAL: TFieldFloat;
    FID_USUARIO: TFieldInteger;
    procedure SetDATAFIM(const Value: TFieldDateTime);
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetDATAINICIO(const Value: TFieldDateTime);
    procedure SetESTERILIZACAO(const Value: TFieldBoolean);
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetID_RECIPIENTE(const Value: TFieldInteger);
    procedure SetID_USUARIO(const Value: TFieldInteger);
    procedure SetID_USUARIOEXECUTAR(const Value: TFieldInteger);
    procedure SetPHFINAL(const Value: TFieldFloat);
    procedure SetPHINICIAL(const Value: TFieldFloat);
    procedure SetPHRECOMENDADO(const Value: TFieldFloat);
    procedure SetQUANTRECIPIENTES(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_USUARIO : TFieldInteger read FID_USUARIO write SetID_USUARIO;
    property ID_RECIPIENTE : TFieldInteger read FID_RECIPIENTE write SetID_RECIPIENTE;
    property ID_USUARIOEXECUTAR : TFieldInteger read FID_USUARIOEXECUTAR write SetID_USUARIOEXECUTAR;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property DATAHORA : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property DATAINICIO : TFieldDateTime read FDATAINICIO write SetDATAINICIO;
    property DATAFIM : TFieldDateTime read FDATAFIM write SetDATAFIM;
    property QUANTRECIPIENTES : TFieldInteger read FQUANTRECIPIENTES write SetQUANTRECIPIENTES;
    property ESTERILIZACAO : TFieldBoolean read FESTERILIZACAO write SetESTERILIZACAO;
    property PHINICIAL : TFieldFloat read FPHINICIAL write SetPHINICIAL;
    property PHFINAL : TFieldFloat read FPHFINAL write SetPHFINAL;
    property PHRECOMENDADO : TFieldFloat read FPHRECOMENDADO write SetPHRECOMENDADO;
  end;
implementation

{ TORDEMPRODUCAOMP }

procedure TORDEMPRODUCAOMP.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TORDEMPRODUCAOMP.SetDATAFIM(const Value: TFieldDateTime);
begin
  FDATAFIM := Value;
end;

procedure TORDEMPRODUCAOMP.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TORDEMPRODUCAOMP.SetDATAINICIO(const Value: TFieldDateTime);
begin
  FDATAINICIO := Value;
end;

procedure TORDEMPRODUCAOMP.SetESTERILIZACAO(const Value: TFieldBoolean);
begin
  FESTERILIZACAO := Value;
end;

procedure TORDEMPRODUCAOMP.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOMP.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TORDEMPRODUCAOMP.SetID_RECIPIENTE(const Value: TFieldInteger);
begin
  FID_RECIPIENTE := Value;
end;

procedure TORDEMPRODUCAOMP.SetID_USUARIO(const Value: TFieldInteger);
begin
  FID_USUARIO := Value;
end;

procedure TORDEMPRODUCAOMP.SetID_USUARIOEXECUTAR(const Value: TFieldInteger);
begin
  FID_USUARIOEXECUTAR := Value;
end;

procedure TORDEMPRODUCAOMP.SetPHFINAL(const Value: TFieldFloat);
begin
  FPHFINAL := Value;
end;

procedure TORDEMPRODUCAOMP.SetPHINICIAL(const Value: TFieldFloat);
begin
  FPHINICIAL := Value;
end;

procedure TORDEMPRODUCAOMP.SetPHRECOMENDADO(const Value: TFieldFloat);
begin
  FPHRECOMENDADO := Value;
end;

procedure TORDEMPRODUCAOMP.SetQUANTRECIPIENTES(const Value: TFieldInteger);
begin
  FQUANTRECIPIENTES := Value;
end;

end.
