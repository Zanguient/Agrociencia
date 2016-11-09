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
    procedure SetCODIGOEXTERNO(const Value: TFieldString);
    procedure SetCPFCNPJ(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetNOME(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID             : TFieldInteger read FID write SetID;
    property NOME           : TFieldString read FNOME write SetNOME;
    property CPFCNPJ        : TFieldString read FCPFCNPJ write SetCPFCNPJ;
    property CODIGOEXTERNO  : TFieldString read FCODIGOEXTERNO write SetCODIGOEXTERNO;
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
  CODIGOEXTERNO.Size  := 100;

end;

procedure TCLIENTE.SetCODIGOEXTERNO(const Value: TFieldString);
begin
  FCODIGOEXTERNO := Value;
end;

procedure TCLIENTE.SetCPFCNPJ(const Value: TFieldString);
begin
  FCPFCNPJ := Value;
end;

procedure TCLIENTE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TCLIENTE.SetNOME(const Value: TFieldString);
begin
  FNOME := Value;
end;

end.
