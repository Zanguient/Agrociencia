unit uBeanObservacao;

interface

uses
  uFWPersistence,
  uDomains;

type
  TOBSERVACAO = class(TFWPersistence)
  private
    FOBSERVACAO: TFieldString;
    FDESCRICAO: TFieldString;
    FID: TFieldInteger;
    FCODIGOEXTERNO: TFieldString;
    procedure SetCODIGOEXTERNO(const Value: TFieldString);
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetOBSERVACAO(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID             : TFieldInteger read FID write SetID;
    property DESCRICAO      : TFieldString read FDESCRICAO write SetDESCRICAO;
    property OBSERVACAO     : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property CODIGOEXTERNO  : TFieldString read FCODIGOEXTERNO write SetCODIGOEXTERNO;
  end;

implementation

{ TOBSERVACAO }

procedure TOBSERVACAO.InitInstance;
begin
  inherited;
  ID.isPK                 := True;

  DESCRICAO.isNotNull     := True;
  OBSERVACAO.isNotNull    := True;

  DESCRICAO.Size          := 100;
  OBSERVACAO.Size         := 512;
  CODIGOEXTERNO.Size      := 100;

  DESCRICAO.isSearchField := True;

  ID.displayLabel         := 'Código';
  DESCRICAO.displayLabel  := 'Descrição';

end;

procedure TOBSERVACAO.SetCODIGOEXTERNO(const Value: TFieldString);
begin
  FCODIGOEXTERNO := Value;
end;

procedure TOBSERVACAO.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TOBSERVACAO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TOBSERVACAO.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

end.
