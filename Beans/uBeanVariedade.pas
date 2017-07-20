unit uBeanVariedade;

interface

uses
  uFWPersistence,
  uDomains;

type
  TVARIEDADE = class(TFWPersistence)
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
    property ID : TFieldInteger read FID write SetID;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property NOME : TFieldString read FNOME write SetNOME;
  end;

implementation

{ TVARIEDADE }

procedure TVARIEDADE.InitInstance;
begin
  inherited;
  ID.isPK := True;

  NOME.Size := 100;
end;

procedure TVARIEDADE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TVARIEDADE.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TVARIEDADE.SetNOME(const Value: TFieldString);
begin
  FNOME := Value;
end;

end.
