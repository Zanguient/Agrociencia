unit uBeanOPFinal_E_L_S_Q_Imagem;

interface
uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_E_L_S_Q_IMAGEM = class(TFWPersistence)
  private
    FID: TFieldInteger;
    FID_IMAGEM: TFieldInteger;
    FID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_IMAGEM(const Value: TFieldInteger);
    procedure SetID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE : TFieldInteger read FID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE write SetID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE;
    property ID_IMAGEM : TFieldInteger read FID_IMAGEM write SetID_IMAGEM;
  end;
implementation

{ TOPFINAL_E_L_S_Q_IMAGEM }

procedure TOPFINAL_E_L_S_Q_IMAGEM.InitInstance;
begin
  inherited;
  ID.isPK := True;
end;

procedure TOPFINAL_E_L_S_Q_IMAGEM.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_E_L_S_Q_IMAGEM.SetID_IMAGEM(const Value: TFieldInteger);
begin
  FID_IMAGEM := Value;
end;

procedure TOPFINAL_E_L_S_Q_IMAGEM.SetID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE(
  const Value: TFieldInteger);
begin
  FID_OPFINAL_ESTAGIO_LOTE_S_QUALIDADE := Value;
end;

end.
