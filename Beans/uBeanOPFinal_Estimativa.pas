unit uBeanOPFinal_Estimativa;

interface
uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTIMATIVA = class(TFWPersistence)
  private
    FID_ESTAGIO: TFieldInteger;
    FSEQUENCIA: TFieldInteger;
    FID: TFieldInteger;
    FDIAS: TFieldInteger;
    FPERDA: TFieldInteger;
    FQUANTIDADE: TFieldInteger;
    FDTFIM: TFieldDate;
    FFATORX: TFieldInteger;
    FDTINICIO: TFieldDate;
    FID_OPFINAL: TFieldInteger;
    procedure SetDIAS(const Value: TFieldInteger);
    procedure SetDTFIM(const Value: TFieldDate);
    procedure SetDTINICIO(const Value: TFieldDate);
    procedure SetFATORX(const Value: TFieldInteger);
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ESTAGIO(const Value: TFieldInteger);
    procedure SetID_OPFINAL(const Value: TFieldInteger);
    procedure SetPERDA(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldInteger);
    procedure SetSEQUENCIA(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID: TFieldInteger read FID write SetID;
    property ID_OPFINAL: TFieldInteger read FID_OPFINAL write SetID_OPFINAL;
    property ID_ESTAGIO: TFieldInteger read FID_ESTAGIO write SetID_ESTAGIO;
    property SEQUENCIA: TFieldInteger read FSEQUENCIA write SetSEQUENCIA;
    property QUANTIDADE: TFieldInteger read FQUANTIDADE write SetQUANTIDADE;
    property FATORX: TFieldInteger read FFATORX write SetFATORX;
    property PERDA: TFieldInteger read FPERDA write SetPERDA;
    property DIAS: TFieldInteger read FDIAS write SetDIAS;
    property DTINICIO: TFieldDate read FDTINICIO write SetDTINICIO;
    property DTFIM: TFieldDate read FDTFIM write SetDTFIM;
end;
implementation

{ TOPFINAL_ESTIMATIVA }

procedure TOPFINAL_ESTIMATIVA.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TOPFINAL_ESTIMATIVA.SetDIAS(const Value: TFieldInteger);
begin
  FDIAS := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetDTFIM(const Value: TFieldDate);
begin
  FDTFIM := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetDTINICIO(const Value: TFieldDate);
begin
  FDTINICIO := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetFATORX(const Value: TFieldInteger);
begin
  FFATORX := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetID_ESTAGIO(const Value: TFieldInteger);
begin
  FID_ESTAGIO := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetID_OPFINAL(const Value: TFieldInteger);
begin
  FID_OPFINAL := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetPERDA(const Value: TFieldInteger);
begin
  FPERDA := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetQUANTIDADE(const Value: TFieldInteger);
begin
  FQUANTIDADE := Value;
end;

procedure TOPFINAL_ESTIMATIVA.SetSEQUENCIA(const Value: TFieldInteger);
begin
  FSEQUENCIA := Value;
end;

end.
