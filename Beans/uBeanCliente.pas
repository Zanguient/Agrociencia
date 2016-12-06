unit uBeanCliente;

interface

uses
  uFWPersistence,
  uDomains;

type
  TCLIENTE = class(TFWPersistence)
  private
    FCPFCNPJ: TFieldString;
    FID: TFieldInteger;
    FCODIGOEXTERNO: TFieldString;
    FNOME: TFieldString;
    FEMAIL: TFieldString;
    FTELEFONE: TFieldString;
    FCELULAR: TFieldString;
    FOBSERVACAO: TFieldString;
    FCADPROIE: TFieldString;
    procedure SetCODIGOEXTERNO(const Value: TFieldString);
    procedure SetCPFCNPJ(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetNOME(const Value: TFieldString);
    procedure SetCELULAR(const Value: TFieldString);
    procedure SetEMAIL(const Value: TFieldString);
    procedure SetTELEFONE(const Value: TFieldString);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetCADPROIE(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID             : TFieldInteger read FID write SetID;
    property NOME           : TFieldString read FNOME write SetNOME;
    property CPFCNPJ        : TFieldString read FCPFCNPJ write SetCPFCNPJ;
    property TELEFONE       : TFieldString read FTELEFONE write SetTELEFONE;
    property CELULAR        : TFieldString read FCELULAR write SetCELULAR;
    property EMAIL          : TFieldString read FEMAIL write SetEMAIL;
    property OBSERVACAO     : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property CODIGOEXTERNO  : TFieldString read FCODIGOEXTERNO write SetCODIGOEXTERNO;
    property CADPROIE       : TFieldString read FCADPROIE write SetCADPROIE;
  end;

implementation

{ TCLIENTE }

procedure TCLIENTE.InitInstance;
begin
  inherited;
  ID.isPK             := True;

  NOME.isNotNull      := True;
  CPFCNPJ.isNotNull   := True;

  NOME.Size           := 100;
  CPFCNPJ.Size        := 18;
  TELEFONE.Size       := 15;
  CELULAR.Size        := 15;
  EMAIL.Size          := 100;
  OBSERVACAO.Size     := 512;
  CODIGOEXTERNO.Size  := 100;
  CADPROIE.Size       := 30;

  NOME.isSearchField  := True;

  ID.displayLabel     := 'Código';
  NOME.displayLabel   := 'Nome do Cliente';
end;

procedure TCLIENTE.SetCADPROIE(const Value: TFieldString);
begin
  FCADPROIE := Value;
end;

procedure TCLIENTE.SetCELULAR(const Value: TFieldString);
begin
  FCELULAR := Value;
end;

procedure TCLIENTE.SetCODIGOEXTERNO(const Value: TFieldString);
begin
  FCODIGOEXTERNO := Value;
end;

procedure TCLIENTE.SetCPFCNPJ(const Value: TFieldString);
begin
  FCPFCNPJ := Value;
end;

procedure TCLIENTE.SetEMAIL(const Value: TFieldString);
begin
  FEMAIL := Value;
end;

procedure TCLIENTE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TCLIENTE.SetNOME(const Value: TFieldString);
begin
  FNOME := Value;
end;

procedure TCLIENTE.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TCLIENTE.SetTELEFONE(const Value: TFieldString);
begin
  FTELEFONE := Value;
end;

end.
