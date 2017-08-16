unit uBeanOPFinal_Estagio_Lote_S_Positivo;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOPFINAL_ESTAGIO_LOTE_S_POSITIVO = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FID_OPFINAL_ESTAGIO_LOTE_S: TFieldInteger;
    FID: TFieldInteger;
    FID_IMAGEM: TFieldInteger;
    FLOCALIZACAO_ID: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_IMAGEM(const Value: TFieldInteger);
    procedure SetID_OPFINAL_ESTAGIO_LOTE_S(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetLOCALIZACAO_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property ID_OPFINAL_ESTAGIO_LOTE_S : TFieldInteger read FID_OPFINAL_ESTAGIO_LOTE_S write SetID_OPFINAL_ESTAGIO_LOTE_S;
    property ID_IMAGEM : TFieldInteger read FID_IMAGEM write SetID_IMAGEM;
    property LOCALIZACAO_ID : TFieldInteger read FLOCALIZACAO_ID write SetLOCALIZACAO_ID;
    property OBSERVACAO : TFieldString read FOBSERVACAO write SetOBSERVACAO;
  end;
implementation

{ TOPFINAL_ESTAGIO_LOTE_S_POSITIVO }

procedure TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.InitInstance;
begin
  inherited;
  ID.isPK := True;

  OBSERVACAO.Size  := 500;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.SetID_IMAGEM(
  const Value: TFieldInteger);
begin
  FID_IMAGEM := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.SetID_OPFINAL_ESTAGIO_LOTE_S(
  const Value: TFieldInteger);
begin
  FID_OPFINAL_ESTAGIO_LOTE_S := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.SetLOCALIZACAO_ID(
  const Value: TFieldInteger);
begin
  FLOCALIZACAO_ID := Value;
end;

procedure TOPFINAL_ESTAGIO_LOTE_S_POSITIVO.SetOBSERVACAO(
  const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

end.
