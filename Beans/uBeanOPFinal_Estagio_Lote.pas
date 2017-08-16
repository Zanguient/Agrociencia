unit uBeanOPFinal_Estagio_Lote;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_LOTE = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FNUMEROLOTE: TFieldInteger;
    FID: TFieldInteger;
    FOPFINAL_ESTAGIO_ID: TFieldInteger;
    FDATAHORAFIM: TFieldDateTime;
    FDATAHORAINICIO: TFieldDateTime;
    FUSUARIO_ID: TFieldInteger;
    FQUANTIDADE: TFieldInteger;
    FESTACAOTRABALHO: TFieldString;
    FORDEMPRODUCAOMC_ID: TFieldInteger;
    FLOCALIZACAO: TFieldString;
    FLOCALIZACAO_ID: TFieldInteger;
    procedure SetDATAHORAFIM(const Value: TFieldDateTime);
    procedure SetDATAHORAINICIO(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetNUMEROLOTE(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetOPFINAL_ESTAGIO_ID(const Value: TFieldInteger);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldInteger);
    procedure SetESTACAOTRABALHO(const Value: TFieldString);
    procedure SetORDEMPRODUCAOMC_ID(const Value: TFieldInteger);
    procedure SetLOCALIZACAO(const Value: TFieldString);
    procedure SetLOCALIZACAO_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                 : TFieldInteger read FID write SetID;
    property OPFINAL_ESTAGIO_ID : TFieldInteger read FOPFINAL_ESTAGIO_ID write SetOPFINAL_ESTAGIO_ID;
    property NUMEROLOTE         : TFieldInteger read FNUMEROLOTE write SetNUMEROLOTE;
    property DATAHORAINICIO     : TFieldDateTime read FDATAHORAINICIO write SetDATAHORAINICIO;
    property DATAHORAFIM        : TFieldDateTime read FDATAHORAFIM write SetDATAHORAFIM;
    property USUARIO_ID         : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
    property OBSERVACAO         : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property QUANTIDADE         : TFieldInteger read FQUANTIDADE write SetQUANTIDADE;
    property ESTACAOTRABALHO    : TFieldString read FESTACAOTRABALHO write SetESTACAOTRABALHO;
    property ORDEMPRODUCAOMC_ID : TFieldInteger read FORDEMPRODUCAOMC_ID write SetORDEMPRODUCAOMC_ID;
    property LOCALIZACAO        : TFieldString read FLOCALIZACAO write SetLOCALIZACAO;
    property LOCALIZACAO_ID     : TFieldInteger read FLOCALIZACAO_ID write SetLOCALIZACAO_ID;
  end;

implementation

{ TOPFINAL }

procedure TOPFINAL_ESTAGIO_LOTE.InitInstance;
begin
  inherited;
  ID.isPK                       := True;

  FNUMEROLOTE.isNotNull         := True;
  FOPFINAL_ESTAGIO_ID.isNotNull := True;
  FUSUARIO_ID.isNotNull         := True;

  FOBSERVACAO.Size              := 512;
  FESTACAOTRABALHO.Size         := 20;
  FLOCALIZACAO.Size             := 100;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetDATAHORAFIM(const Value: TFieldDateTime);
begin
  FDATAHORAFIM := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetDATAHORAINICIO(const Value: TFieldDateTime);
begin
  FDATAHORAINICIO := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetESTACAOTRABALHO(const Value: TFieldString);
begin
  FESTACAOTRABALHO := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetLOCALIZACAO(const Value: TFieldString);
begin
  FLOCALIZACAO := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetLOCALIZACAO_ID(const Value: TFieldInteger);
begin
  FLOCALIZACAO_ID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetNUMEROLOTE(const Value: TFieldInteger);
begin
  FNUMEROLOTE := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetOPFINAL_ESTAGIO_ID(const Value: TFieldInteger);
begin
  FOPFINAL_ESTAGIO_ID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetORDEMPRODUCAOMC_ID(
  const Value: TFieldInteger);
begin
  FORDEMPRODUCAOMC_ID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetQUANTIDADE(const Value: TFieldInteger);
begin
  FQUANTIDADE := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE.SetUSUARIO_ID(const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
