unit uBeanLocalizacao;

interface
uses
  uFWPersistence,
  uDomains;

type
  TLOCALIZACAO = class(TFWPersistence)
  private
    FID: TFieldInteger;
    FSALA: TFieldString;
    FPRATELEIRAS: TFieldInteger;
    FTEMPERATURA: TFieldFloat;
    FREGIMEILUMINACAO: TFieldString;
    FAREA: TFieldFloat;
    FNOME: TFieldString;
    FESTANTE: TFieldInteger;
    procedure SetAREA(const Value: TFieldFloat);
    procedure SetESTANTE(const Value: TFieldInteger);
    procedure SetID(const Value: TFieldInteger);
    procedure SetNOME(const Value: TFieldString);
    procedure SetPRATELEIRAS(const Value: TFieldInteger);
    procedure SetREGIMEILUMINACAO(const Value: TFieldString);
    procedure SetSALA(const Value: TFieldString);
    procedure SetTEMPERATURA(const Value: TFieldFloat);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ESTANTE : TFieldInteger read FESTANTE write SetESTANTE;
    property SALA : TFieldString read FSALA write SetSALA;
    property NOME : TFieldString read FNOME write SetNOME;
    property REGIMEILUMINACAO : TFieldString read FREGIMEILUMINACAO write SetREGIMEILUMINACAO;
    property PRATELEIRAS : TFieldInteger read FPRATELEIRAS write SetPRATELEIRAS;
    property AREA : TFieldFloat read FAREA write SetAREA;
    property TEMPERATURA : TFieldFloat read FTEMPERATURA write SetTEMPERATURA;
  end;
implementation

{ TLOCALIZACAO }

procedure TLOCALIZACAO.InitInstance;
begin
  inherited;
  ID.isPK := True;

  SALA.Size := 100;
  NOME.Size := 100;
  REGIMEILUMINACAO.Size := 100;

  NOME.isSearchField := True;
  SALA.isSearchField := True;
  ESTANTE.isSearchField := True;

  ID.displayLabel := 'Cód. Barras';
  NOME.displayLabel := 'Nome';
  SALA.displayLabel := 'Sala';
  ESTANTE.displayLabel := 'Estante';
end;

procedure TLOCALIZACAO.SetAREA(const Value: TFieldFloat);
begin
  FAREA := Value;
end;

procedure TLOCALIZACAO.SetESTANTE(const Value: TFieldInteger);
begin
  FESTANTE := Value;
end;

procedure TLOCALIZACAO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TLOCALIZACAO.SetNOME(const Value: TFieldString);
begin
  FNOME := Value;
end;

procedure TLOCALIZACAO.SetPRATELEIRAS(const Value: TFieldInteger);
begin
  FPRATELEIRAS := Value;
end;

procedure TLOCALIZACAO.SetREGIMEILUMINACAO(const Value: TFieldString);
begin
  FREGIMEILUMINACAO := Value;
end;

procedure TLOCALIZACAO.SetSALA(const Value: TFieldString);
begin
  FSALA := Value;
end;

procedure TLOCALIZACAO.SetTEMPERATURA(const Value: TFieldFloat);
begin
  FTEMPERATURA := Value;
end;

end.
