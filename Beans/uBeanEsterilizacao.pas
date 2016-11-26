unit uBeanEsterilizacao;

interface

uses
  uFWPersistence,
  uDomains;

type
  TESTERILIZACAO = class(TFWPersistence)
  private
    FDESCRICAO: TFieldString;
    FMETODO: TFieldString;
    FID: TFieldInteger;
    procedure SetID(const Value: TFieldInteger);
    procedure SetMETODO(const Value: TFieldString);
    procedure SetDESCRICAO(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID             : TFieldInteger read FID write SetID;
    property METODO         : TFieldString read FMETODO write SetMETODO;
    property DESCRICAO     : TFieldString read FDESCRICAO write SetDESCRICAO;
  end;

implementation

{ TESTERILIZACAO }

procedure TESTERILIZACAO.InitInstance;
begin
  inherited;
  ID.isPK                 := True;

  METODO.isNotNull        := True;
  DESCRICAO.isNotNull     := True;

  METODO.Size             := 100;
  DESCRICAO.Size          := 512;

  METODO.isSearchField    := True;
  DESCRICAO.isSearchField := True;

  ID.displayLabel         := 'Código';
  METODO.displayLabel     := 'Método';
  DESCRICAO.displayLabel  := 'Descrição';
end;

procedure TESTERILIZACAO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TESTERILIZACAO.SetMETODO(const Value: TFieldString);
begin
  FMETODO := Value;
end;

procedure TESTERILIZACAO.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

end.
