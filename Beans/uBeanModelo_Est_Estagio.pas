unit uBeanModelo_Est_Estagio;

interface

uses
  uFWPersistence,
  uDomains;

type
  TMODELO_EST_ESTAGIO = class(TFWPersistence)
  private
    FID_ESTAGIO: TFieldInteger;
    FSEQUENCIA: TFieldInteger;
    FID_MODELO_EST: TFieldInteger;
    FID: TFieldInteger;
    FDIAS: TFieldInteger;
    FPERDA: TFieldFloat;
    FFATORX: TFieldFloat;
    procedure SetDIAS(const Value: TFieldInteger);
    procedure SetFATORX(const Value: TFieldFloat);
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ESTAGIO(const Value: TFieldInteger);
    procedure SetID_MODELO_EST(const Value: TFieldInteger);
    procedure SetPERDA(const Value: TFieldFloat);
    procedure SetSEQUENCIA(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID: TFieldInteger read FID write SetID;
    property ID_MODELO_EST: TFieldInteger read FID_MODELO_EST write SetID_MODELO_EST;
    property ID_ESTAGIO: TFieldInteger read FID_ESTAGIO write SetID_ESTAGIO;
    property SEQUENCIA: TFieldInteger read FSEQUENCIA write SetSEQUENCIA;
    property FATORX: TFieldFloat read FFATORX write SetFATORX;
    property PERDA: TFieldFloat read FPERDA write SetPERDA;
    property DIAS: TFieldInteger read FDIAS write SetDIAS;
  end;

implementation

{ TMODELO_EST_ESTAGIO }

procedure TMODELO_EST_ESTAGIO.InitInstance;
begin
  inherited;
  FID.isPK := True;
end;

procedure TMODELO_EST_ESTAGIO.SetDIAS(const Value: TFieldInteger);
begin
  FDIAS := Value;
end;

procedure TMODELO_EST_ESTAGIO.SetFATORX(const Value: TFieldFloat);
begin
  FFATORX := Value;
end;

procedure TMODELO_EST_ESTAGIO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TMODELO_EST_ESTAGIO.SetID_ESTAGIO(const Value: TFieldInteger);
begin
  FID_ESTAGIO := Value;
end;

procedure TMODELO_EST_ESTAGIO.SetID_MODELO_EST(const Value: TFieldInteger);
begin
  FID_MODELO_EST := Value;
end;

procedure TMODELO_EST_ESTAGIO.SetPERDA(const Value: TFieldFloat);
begin
  FPERDA := Value;
end;

procedure TMODELO_EST_ESTAGIO.SetSEQUENCIA(const Value: TFieldInteger);
begin
  FSEQUENCIA := Value;
end;

end.
