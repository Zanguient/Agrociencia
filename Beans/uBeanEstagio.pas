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
    FINICIAL: TFieldBoolean;
    FTIPO: TFieldInteger;
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetINICIAL(const Value: TFieldBoolean);
    procedure SetTIPO(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property DESCRICAO : TFieldString read FDESCRICAO write SetDESCRICAO;
    property OBSERVACAO : TFieldString read FOBSERVACAO write SetOBSERVACAO;
//    property INICIAL : TFieldBoolean read FINICIAL write SetINICIAL;
    property TIPO : TFieldInteger read FTIPO write SetTIPO;
  end;
implementation

{ TESTAGIO }

procedure TESTAGIO.InitInstance;
begin
  inherited;
  ID.isPK  := True;

  DESCRICAO.Size  := 100;
  OBSERVACAO.Size := 512;

  DESCRICAO.isSearchField   := True;
  OBSERVACAO.isSearchField  := True;

  ID.displayWidth           := 10;
  DESCRICAO.displayWidth    := 40;

  ID.displayLabel           := 'Código';
  DESCRICAO.displayLabel    := 'Descrição';
  OBSERVACAO.displayLabel   := 'Observação';

end;

procedure TESTAGIO.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TESTAGIO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TESTAGIO.SetINICIAL(const Value: TFieldBoolean);
begin
  FINICIAL := Value;
end;

procedure TESTAGIO.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TESTAGIO.SetTIPO(const Value: TFieldInteger);
begin
  FTIPO := Value;
end;

end.
