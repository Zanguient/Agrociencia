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
    FFAZENDAAREATALHAO: TFieldString;
    FORIGEMMATERIAL: TFieldString;
    FLOCALIZADOR: TFieldString;
    FQUANTIDADEENVIADA: TFieldInteger;
    FDATAESTIMADAPROCESSAMENTO: TFieldDateTime;
    FTRANSPORTADORA: TFieldString;
    FSELECAOPOSITIVA: TFieldString;
    FCODIGOSELECAOCAMPO: TFieldString;
    FDATADERECEBIMENTO: TFieldDateTime;
    FDATADECOLETA: TFieldDateTime;
    FCOLETADOPOR: TFieldString;
    FDATAENCERRAMENTO: TFieldDateTime;
    FQUANTIDADEPRODUZIDA: TFieldInteger;
    FCANCELADO: TFieldBoolean;
    FLIMITEMULTIPLICACOES: TFieldInteger;
    FID_VARIEDADE: TFieldInteger;
    procedure SetCLIENTE_ID(const Value: TFieldInteger);
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetPRODUTO_ID(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldInteger);
    procedure SetUSUARIO_ID(const Value: TFieldInteger);
    procedure SetCODIGOSELECAOCAMPO(const Value: TFieldString);
    procedure SetDATADECOLETA(const Value: TFieldDateTime);
    procedure SetDATADERECEBIMENTO(const Value: TFieldDateTime);
    procedure SetDATAESTIMADAPROCESSAMENTO(const Value: TFieldDateTime);
    procedure SetFAZENDAAREATALHAO(const Value: TFieldString);
    procedure SetLOCALIZADOR(const Value: TFieldString);
    procedure SetORIGEMMATERIAL(const Value: TFieldString);
    procedure SetQUANTIDADEENVIADA(const Value: TFieldInteger);
    procedure SetSELECAOPOSITIVA(const Value: TFieldString);
    procedure SetTRANSPORTADORA(const Value: TFieldString);
    procedure SetCOLETADOPOR(const Value: TFieldString);
    procedure SetDATAENCERRAMENTO(const Value: TFieldDateTime);
    procedure SetQUANTIDADEPRODUZIDA(const Value: TFieldInteger);
    procedure SetCANCELADO(const Value: TFieldBoolean);
    procedure SetLIMITEMULTIPLICACOES(const Value: TFieldInteger);
    procedure SetID_VARIEDADE(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                         : TFieldInteger read FID write SetID;
    property DATAHORA                   : TFieldDateTime read FDATAHORA write SetDATAHORA;
    property DATAENCERRAMENTO           : TFieldDateTime read FDATAENCERRAMENTO write SetDATAENCERRAMENTO;
    property QUANTIDADE                 : TFieldInteger read FQUANTIDADE write SetQUANTIDADE;
    property QUANTIDADEPRODUZIDA        : TFieldInteger read FQUANTIDADEPRODUZIDA write SetQUANTIDADEPRODUZIDA;
    property PRODUTO_ID                 : TFieldInteger read FPRODUTO_ID write SetPRODUTO_ID;
    property CLIENTE_ID                 : TFieldInteger read FCLIENTE_ID write SetCLIENTE_ID;
    property USUARIO_ID                 : TFieldInteger read FUSUARIO_ID write SetUSUARIO_ID;
    property CANCELADO                  : TFieldBoolean read FCANCELADO write SetCANCELADO;
    property LIMITEMULTIPLICACOES       : TFieldInteger read FLIMITEMULTIPLICACOES write SetLIMITEMULTIPLICACOES;
    property SELECAOPOSITIVA            : TFieldString read FSELECAOPOSITIVA write SetSELECAOPOSITIVA;
    property ORIGEMMATERIAL             : TFieldString read FORIGEMMATERIAL write SetORIGEMMATERIAL;
    property CODIGOSELECAOCAMPO         : TFieldString read FCODIGOSELECAOCAMPO write SetCODIGOSELECAOCAMPO;
    property DATADECOLETA               : TFieldDateTime read FDATADECOLETA write SetDATADECOLETA;
    property COLETADOPOR                : TFieldString read FCOLETADOPOR write SetCOLETADOPOR;
    property FAZENDAAREATALHAO          : TFieldString read FFAZENDAAREATALHAO write SetFAZENDAAREATALHAO;
    property LOCALIZADOR                : TFieldString read FLOCALIZADOR write SetLOCALIZADOR;
    property QUANTIDADEENVIADA          : TFieldInteger read FQUANTIDADEENVIADA write SetQUANTIDADEENVIADA;
    property TRANSPORTADORA             : TFieldString read FTRANSPORTADORA write SetTRANSPORTADORA;
    property DATADERECEBIMENTO          : TFieldDateTime read FDATADERECEBIMENTO write SetDATADERECEBIMENTO;
    property DATAESTIMADAPROCESSAMENTO  : TFieldDateTime read FDATAESTIMADAPROCESSAMENTO write SetDATAESTIMADAPROCESSAMENTO;
    property OBSERVACAO                 : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property ID_VARIEDADE               : TFieldInteger read FID_VARIEDADE write SetID_VARIEDADE;
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
  FQUANTIDADEPRODUZIDA.isNotNull    := True;
  FCANCELADO.isNotNull              := True;
  FLIMITEMULTIPLICACOES.isNotNull   := True;

  SELECAOPOSITIVA.Size              := 3;
  ORIGEMMATERIAL.Size               := 100;
  CODIGOSELECAOCAMPO.Size           := 100;
  COLETADOPOR.Size                  := 100;
  FAZENDAAREATALHAO.Size            := 100;
  LOCALIZADOR.Size                  := 512;
  TRANSPORTADORA.Size               := 100;
  OBSERVACAO.Size                   := 512;
end;

procedure TOPFINAL.SetCANCELADO(const Value: TFieldBoolean);
begin
  FCANCELADO := Value;
end;

procedure TOPFINAL.SetCLIENTE_ID(const Value: TFieldInteger);
begin
  FCLIENTE_ID := Value;
end;

procedure TOPFINAL.SetCODIGOSELECAOCAMPO(const Value: TFieldString);
begin
  FCODIGOSELECAOCAMPO := Value;
end;

procedure TOPFINAL.SetCOLETADOPOR(const Value: TFieldString);
begin
  FCOLETADOPOR := Value;
end;

procedure TOPFINAL.SetDATADECOLETA(const Value: TFieldDateTime);
begin
  FDATADECOLETA := Value;
end;

procedure TOPFINAL.SetDATADERECEBIMENTO(const Value: TFieldDateTime);
begin
  FDATADERECEBIMENTO := Value;
end;

procedure TOPFINAL.SetDATAENCERRAMENTO(const Value: TFieldDateTime);
begin
  FDATAENCERRAMENTO := Value;
end;

procedure TOPFINAL.SetDATAESTIMADAPROCESSAMENTO(const Value: TFieldDateTime);
begin
  FDATAESTIMADAPROCESSAMENTO := Value;
end;

procedure TOPFINAL.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TOPFINAL.SetFAZENDAAREATALHAO(const Value: TFieldString);
begin
  FFAZENDAAREATALHAO := Value;
end;

procedure TOPFINAL.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL.SetID_VARIEDADE(const Value: TFieldInteger);
begin
  FID_VARIEDADE := Value;
end;

procedure TOPFINAL.SetLIMITEMULTIPLICACOES(const Value: TFieldInteger);
begin
  FLIMITEMULTIPLICACOES := Value;
end;

procedure TOPFINAL.SetLOCALIZADOR(const Value: TFieldString);
begin
  FLOCALIZADOR := Value;
end;

procedure TOPFINAL.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TOPFINAL.SetORIGEMMATERIAL(const Value: TFieldString);
begin
  FORIGEMMATERIAL := Value;
end;

procedure TOPFINAL.SetPRODUTO_ID(const Value: TFieldInteger);
begin
  FPRODUTO_ID := Value;
end;

procedure TOPFINAL.SetQUANTIDADE(const Value: TFieldInteger);
begin
  FQUANTIDADE := Value;
end;

procedure TOPFINAL.SetQUANTIDADEENVIADA(const Value: TFieldInteger);
begin
  FQUANTIDADEENVIADA := Value;
end;

procedure TOPFINAL.SetQUANTIDADEPRODUZIDA(const Value: TFieldInteger);
begin
  FQUANTIDADEPRODUZIDA := Value;
end;

procedure TOPFINAL.SetSELECAOPOSITIVA(const Value: TFieldString);
begin
  FSELECAOPOSITIVA := Value;
end;

procedure TOPFINAL.SetTRANSPORTADORA(const Value: TFieldString);
begin
  FTRANSPORTADORA := Value;
end;

procedure TOPFINAL.SetUSUARIO_ID(const Value: TFieldInteger);
begin
  FUSUARIO_ID := Value;
end;

end.
