unit uBeanMotivoDescarte;

interface

uses
  uFWPersistence,
  uDomains;

type
  TMOTIVODESCARTE = class(TFWPersistence)
  private
    FDESCRICAO: TFieldString;
    FID: TFieldInteger;
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property DESCRICAO : TFieldString read FDESCRICAO write SetDESCRICAO;
  end;
implementation

{ TMOTIVODESCARTE }

procedure TMOTIVODESCARTE.InitInstance;
begin
  inherited;
  ID.isPK := True;

  DESCRICAO.Size := 255;
  DESCRICAO.isSearchField := True;
  ID.displayLabel         := 'Código';
  DESCRICAO.displayLabel  := 'Motivo';
end;

procedure TMOTIVODESCARTE.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TMOTIVODESCARTE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

end.
