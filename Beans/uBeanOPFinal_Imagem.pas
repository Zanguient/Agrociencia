unit uBeanOPFinal_Imagem;

interface
uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_IMAGEM = class(TFWPersistence)
  private
    FID: TFieldInteger;
    FID_IMAGEM: TFieldInteger;
    FID_OPFINAL: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_IMAGEM(const Value: TFieldInteger);
    procedure SetID_OPFINAL(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_OPFINAL : TFieldInteger read FID_OPFINAL write SetID_OPFINAL;
    property ID_IMAGEM : TFieldInteger read FID_IMAGEM write SetID_IMAGEM;
  end;
implementation

{ TOPFINAL_IMAGEM }

procedure TOPFINAL_IMAGEM.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TOPFINAL_IMAGEM.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_IMAGEM.SetID_IMAGEM(const Value: TFieldInteger);
begin
  FID_IMAGEM := Value;
end;

procedure TOPFINAL_IMAGEM.SetID_OPFINAL(const Value: TFieldInteger);
begin
  FID_OPFINAL := Value;
end;

end.
