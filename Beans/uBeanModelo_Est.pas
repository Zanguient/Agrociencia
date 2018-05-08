unit uBeanModelo_Est;

interface

uses
  uFWPersistence,
  uDomains;

type
  TMODELO_EST = class(TFWPersistence)
  private
    FID_PRODUTO: TFieldInteger;
    FID: TFieldInteger;
    FNOME: TFieldString;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetNOME(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID: TFieldInteger read FID write SetID;
    property ID_PRODUTO: TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property NOME: TFieldString read FNOME write SetNOME;
  end;

implementation

{ TMODELO_EST }

procedure TMODELO_EST.InitInstance;
begin
  inherited;
  FID.isPK := True;

  FNOME.displayLabel := 'Descrição';
  FNOME.isSearchField := True;

  FNOME.Size := 100;
end;

procedure TMODELO_EST.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TMODELO_EST.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TMODELO_EST.SetNOME(const Value: TFieldString);
begin
  FNOME := Value;
end;

end.
