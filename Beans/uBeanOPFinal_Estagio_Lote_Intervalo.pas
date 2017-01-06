unit uBeanOPFinal_Estagio_Lote_Intervalo;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_LOTE_INTERVALO = class(TFWPersistence)
  private
    FDATAHORAENTRADA: TFieldDateTime;
    FID: TFieldInteger;
    FOPFINAL_ESTAGIO_LOTE_ID: TFieldInteger;
    FDATAHORASAIDA: TFieldDateTime;
    procedure SetDATAHORAENTRADA(const Value: TFieldDateTime);
    procedure SetDATAHORASAIDA(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOPFINAL_ESTAGIO_LOTE_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                       : TFieldInteger read FID write SetID;
    property OPFINAL_ESTAGIO_LOTE_ID  : TFieldInteger read FOPFINAL_ESTAGIO_LOTE_ID write SetOPFINAL_ESTAGIO_LOTE_ID;
    property DATAHORAENTRADA          : TFieldDateTime read FDATAHORAENTRADA write SetDATAHORAENTRADA;
    property DATAHORASAIDA            : TFieldDateTime read FDATAHORASAIDA write SetDATAHORASAIDA;
  end;

implementation

{ TOPFINAL_ESTAGIO_LOTE_INTERVALO }

procedure TOPFINAL_ESTAGIO_LOTE_INTERVALO.InitInstance;
begin
  inherited;
  FID.isPK                            := True;

  FOPFINAL_ESTAGIO_LOTE_ID.isNotNull  := True;
  FDATAHORAENTRADA.isNotNull          := True;

end;

procedure TOPFINAL_ESTAGIO_LOTE_INTERVALO.SetDATAHORAENTRADA(
  const Value: TFieldDateTime);
begin
  FDATAHORAENTRADA := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_INTERVALO.SetDATAHORASAIDA(
  const Value: TFieldDateTime);
begin
  FDATAHORASAIDA := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_INTERVALO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_INTERVALO.SetOPFINAL_ESTAGIO_LOTE_ID(
  const Value: TFieldInteger);
begin
  FOPFINAL_ESTAGIO_LOTE_ID := Value;
end;

end.
