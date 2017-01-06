unit uBeanOPFinal_Estagio_Lote_S;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_LOTE_S = class(TFWPersistence)
  private
    FDATAHORA: TFieldDateTime;
    FCODIGOBARRAS: TFieldString;
    FID: TFieldInteger;
    FOPFINAL_ESTAGIO_LOTE_ID: TFieldInteger;
    procedure SetCODIGOBARRAS(const Value: TFieldString);
    procedure SetDATAHORA(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOPFINAL_ESTAGIO_LOTE_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID                       : TFieldInteger read FID write SetID;
    property OPFINAL_ESTAGIO_LOTE_ID  : TFieldInteger read FOPFINAL_ESTAGIO_LOTE_ID write SetOPFINAL_ESTAGIO_LOTE_ID;
    property CODIGOBARRAS             : TFieldString read FCODIGOBARRAS write SetCODIGOBARRAS;
    property DATAHORA                 : TFieldDateTime read FDATAHORA write SetDATAHORA;
  end;

implementation

{ TOPFINAL_ESTAGIO_LOTE_S }

procedure TOPFINAL_ESTAGIO_LOTE_S.InitInstance;
begin
  inherited;
  FID.isPK                            := True;

  FOPFINAL_ESTAGIO_LOTE_ID.isNotNull  := True;
  FDATAHORA.isNotNull                 := True;

  FCODIGOBARRAS.Size                  := 20;

end;

procedure TOPFINAL_ESTAGIO_LOTE_S.SetCODIGOBARRAS(const Value: TFieldString);
begin
  FCODIGOBARRAS := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S.SetDATAHORA(const Value: TFieldDateTime);
begin
  FDATAHORA := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S.SetOPFINAL_ESTAGIO_LOTE_ID(
  const Value: TFieldInteger);
begin
  FOPFINAL_ESTAGIO_LOTE_ID := Value;
end;

end.
