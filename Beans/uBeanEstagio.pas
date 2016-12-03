unit uBeanEstagio;

interface
uses
  uFWPersistence,
  uDomains;

type
  TESTAGIO = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FDESCRICAO: TFieldString;
    FID: TFieldInteger;
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property DESCRICAO : TFieldString read FDESCRICAO write SetDESCRICAO;
    property OBSERVACAO : TFieldString read FOBSERVACAO write SetOBSERVACAO;
  end;
implementation

{ TESTAGIO }

procedure TESTAGIO.InitInstance;
begin
  inherited;
  ID.isPK  := True;

  DESCRICAO.isSearchField := True;

  DESCRICAO.Size := 100;
  OBSERVACAO.Size := 500;
end;

procedure TESTAGIO.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TESTAGIO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TESTAGIO.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

end.
