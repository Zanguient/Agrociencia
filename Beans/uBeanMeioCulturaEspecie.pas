unit uBeanMeioCulturaEspecie;

interface
uses
  uFWPersistence,
  uDomains;

type
  TMEIOCULTURAESPECIE = class(TFWPersistence)
  private
    FID_MEIOCULTURA: TFieldInteger;
    FID_ESPECIE: TFieldInteger;
    FID: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_ESPECIE(const Value: TFieldInteger);
    procedure SetID_MEIOCULTURA(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_MEIOCULTURA : TFieldInteger read FID_MEIOCULTURA write SetID_MEIOCULTURA;
    property ID_ESPECIE : TFieldInteger read FID_ESPECIE write SetID_ESPECIE;
  end;
implementation

{ TMEIOCULTURAESPECIE }

procedure TMEIOCULTURAESPECIE.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TMEIOCULTURAESPECIE.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TMEIOCULTURAESPECIE.SetID_ESPECIE(const Value: TFieldInteger);
begin
  FID_ESPECIE := Value;
end;

procedure TMEIOCULTURAESPECIE.SetID_MEIOCULTURA(const Value: TFieldInteger);
begin
  FID_MEIOCULTURA := Value;
end;

end.
