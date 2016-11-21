unit uBeanProdutos;

interface

uses
  uFWPersistence,
  uDomains;

type
  TPRODUTO = class(TFWPersistence)
  private
    FDESCRICAO: TFieldString;
    FID: TFieldInteger;
    FCODIGOEXTERNO: TFieldString;
    FFINALIDADE: TFieldInteger;
    FUNIDADEMEDIDA_ID: TFieldInteger;
    procedure SetCODIGOEXTERNO(const Value: TFieldString);
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetFINALIDADE(const Value: TFieldInteger);
    procedure SetUNIDADEMEDIDA_ID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID               : TFieldInteger read FID write SetID;
    property DESCRICAO        : TFieldString read FDESCRICAO write SetDESCRICAO;
    property FINALIDADE       : TFieldInteger read FFINALIDADE write SetFINALIDADE;
    property UNIDADEMEDIDA_ID : TFieldInteger read FUNIDADEMEDIDA_ID write SetUNIDADEMEDIDA_ID;
    property CODIGOEXTERNO    : TFieldString read FCODIGOEXTERNO write SetCODIGOEXTERNO;
  end;

implementation

{ TPRODUTOS }

procedure TPRODUTO.InitInstance;
begin
  inherited;
  ID.isPK                 := True;

  DESCRICAO.isNotNull     := True;
  FINALIDADE.isNotNull    := True;
  UNIDADEMEDIDA_ID.isNotNull:= True;

  DESCRICAO.Size          := 100;
  CODIGOEXTERNO.Size      := 100;

  DESCRICAO.isSearchField := True;

  ID.displayLabel         := 'Código';
  DESCRICAO.displayLabel  := 'Descrição';

end;

procedure TPRODUTO.SetCODIGOEXTERNO(const Value: TFieldString);
begin
  FCODIGOEXTERNO := Value;
end;

procedure TPRODUTO.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TPRODUTO.SetFINALIDADE(const Value: TFieldInteger);
begin
  FFINALIDADE := Value;
end;

procedure TPRODUTO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TPRODUTO.SetUNIDADEMEDIDA_ID(const Value: TFieldInteger);
begin
  FUNIDADEMEDIDA_ID := Value;
end;

end.
