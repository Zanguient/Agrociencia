unit uBeanOPFinal_Estagio;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO = class(TFWPersistence)
  private
    FESTAGIO_ID: TFieldInteger;
    FOBSERVACAO: TFieldString;
    FDATAHORA: TFieldDateTime;
    FOPMC_ID: TFieldInteger;
    FID: TFieldInteger;
    FDATAHORAFIM: TFieldDateTime;
    FDATAHORAINICIO: TFieldDateTime;
    FUSUARIO_ID: TFieldInteger;
    FOPFINAL_ID: TFieldInteger;
    FSEQUENCIA: TFieldInteger;
    FINTERVALOCRESCIMENTO: TFieldInteger;
    FQUANTIDADEESTIMADA: TFieldInteger;
    FPREVISAOTERMINO: TFieldDateTime;
    FPREVISAOINICIO: TFieldDateTime;
    FMEIOCULTURA_ID: TFieldInteger;
    FULTIMOLOTE: TFieldInteger;
    FLOCALIZACAO: TFieldString;
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetDATAHORAFIM(const Value: TFieldDateTime);
    procedure SetDATAHORAINICIO(const Value: TFieldDateTime);
    procedure SetESTAGIO_ID(const Value: TFieldInteger);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetOPFINAL_ID(const Value: TFieldInteger);
    procedure SetOPMC_ID(const Value: TFieldInteger);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
    procedure SetSEQUENCIA(const Value: TFieldInteger);
    procedure SetINTERVALOCRESCIMENTO(const Value: TFieldInteger);
    procedure SetQUANTIDADEESTIMADA(const Value: TFieldInteger);
    procedure SetPREVISAOINICIO(const Value: TFieldDateTime);
    procedure SetPREVISAOTERMINO(const Value: TFieldDateTime);
    procedure SetMEIOCULTURA_ID(const Value: TFieldInteger);
    procedure SetULTIMOLOTE(const Value: TFieldInteger);
    procedure SetLOCALIZACAO(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID                   : TFieldInteger read FID write SetID;
    property OPFINAL_ID           : TFieldInteger read FOPFINAL_ID write SetOPFINAL_ID;
    property DATAHORA             : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property DATAHORAINICIO       : TFieldDateTime read FDATAHORAINICIO write SetDATAHORAINICIO;
    property DATAHORAFIM          : TFieldDateTime read FDATAHORAFIM write SetDATAHORAFIM;
    property USUARIO_ID           : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
    property MEIOCULTURA_ID       : TFieldInteger read FMEIOCULTURA_ID write SetMEIOCULTURA_ID;
    property ESTAGIO_ID           : TFieldInteger read FESTAGIO_ID write SetESTAGIO_ID;
    property SEQUENCIA            : TFieldInteger read FSEQUENCIA write SetSEQUENCIA;
    property INTERVALOCRESCIMENTO : TFieldInteger read FINTERVALOCRESCIMENTO write SetINTERVALOCRESCIMENTO;
    property QUANTIDADEESTIMADA   : TFieldInteger read FQUANTIDADEESTIMADA write SetQUANTIDADEESTIMADA;
    property PREVISAOINICIO       : TFieldDateTime read FPREVISAOINICIO write SetPREVISAOINICIO;
    property PREVISAOTERMINO      : TFieldDateTime read FPREVISAOTERMINO write SetPREVISAOTERMINO;
    property OBSERVACAO           : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property ULTIMOLOTE           : TFieldInteger read FULTIMOLOTE write SetULTIMOLOTE;
    property LOCALIZACAO          : TFieldString read FLOCALIZACAO write SetLOCALIZACAO;
  end;

implementation

{ TOPFINAL_ESTAGIO }

procedure TOPFINAL_ESTAGIO.InitInstance;
begin
  inherited;
  ID.isPK                       := True;

  OPFINAL_ID.isNotNull          := True;
  DATAHORA.isNotNull            := True;
  USUARIO_ID.isNotNull          := True;
  ESTAGIO_ID.isNotNull          := True;
  SEQUENCIA.isNotNull           := True;
  INTERVALOCRESCIMENTO.isNotNull:= True;
  QUANTIDADEESTIMADA.isNotNull  := True;

  OBSERVACAO.Size               := 512;
  LOCALIZACAO.Size              := 100;
end;

procedure TOPFINAL_ESTAGIO.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TOPFINAL_ESTAGIO.SetDATAHORAFIM(const Value: TFieldDateTime);
begin
  FDATAHORAFIM := Value;
end;

procedure TOPFINAL_ESTAGIO.SetDATAHORAINICIO(const Value: TFieldDateTime);
begin
  FDATAHORAINICIO := Value;
end;

procedure TOPFINAL_ESTAGIO.SetESTAGIO_ID(const Value: TFieldInteger);
begin
  FESTAGIO_ID := Value;
end;

procedure TOPFINAL_ESTAGIO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO.SetINTERVALOCRESCIMENTO(const Value: TFieldInteger);
begin
  FINTERVALOCRESCIMENTO := Value;
end;

procedure TOPFINAL_ESTAGIO.SetLOCALIZACAO(const Value: TFieldString);
begin
  FLOCALIZACAO := Value;
end;

procedure TOPFINAL_ESTAGIO.SetMEIOCULTURA_ID(const Value: TFieldInteger);
begin
  FMEIOCULTURA_ID := Value;
end;

procedure TOPFINAL_ESTAGIO.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TOPFINAL_ESTAGIO.SetOPFINAL_ID(const Value: TFieldInteger);
begin
  FOPFINAL_ID := Value;
end;

procedure TOPFINAL_ESTAGIO.SetOPMC_ID(const Value: TFieldInteger);
begin
  FOPMC_ID := Value;
end;

procedure TOPFINAL_ESTAGIO.SetPREVISAOINICIO(const Value: TFieldDateTime);
begin
  FPREVISAOINICIO := Value;
end;

procedure TOPFINAL_ESTAGIO.SetPREVISAOTERMINO(const Value: TFieldDateTime);
begin
  FPREVISAOTERMINO := Value;
end;

procedure TOPFINAL_ESTAGIO.SetQUANTIDADEESTIMADA(const Value: TFieldInteger);
begin
  FQUANTIDADEESTIMADA := Value;
end;

procedure TOPFINAL_ESTAGIO.SetSEQUENCIA(const Value: TFieldInteger);
begin
  FSEQUENCIA := Value;
end;

procedure TOPFINAL_ESTAGIO.SetULTIMOLOTE(const Value: TFieldInteger);
begin
  FULTIMOLOTE := Value;
end;

procedure TOPFINAL_ESTAGIO.SetUSUARIO_ID(const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
