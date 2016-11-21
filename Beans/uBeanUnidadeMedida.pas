unit uBeanUnidadeMedida;

interface

uses
  uFWPersistence,
  uDomains;

type
  TUNIDADEMEDIDA = class(TFWPersistence)
  private
    FID: TFieldInteger;
    FCODIGOEXTERNO: TFieldString;
    FSIMBOLO: TFieldString;
    FDESCRICAO: TFieldString;
    procedure SetCODIGOEXTERNO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetSIMBOLO(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID             : TFieldInteger read FID write SetID;
    property DESCRICAO      : TFieldString  read FDESCRICAO write SetDESCRICAO;
    property SIMBOLO        : TFieldString  read FSIMBOLO write SetSIMBOLO;
    property CODIGOEXTERNO  : TFieldString  read FCODIGOEXTERNO write SetCODIGOEXTERNO;
  end;

implementation

{ TUNIDADEMEDIDA }

procedure TUNIDADEMEDIDA.InitInstance;
begin
  inherited;

  ID.isPK             := True;

  DESCRICAO.isNotNull := True;
  SIMBOLO.isNotNull   := True;

  DESCRICAO.Size      := 100;
  SIMBOLO.Size        := 5;
  CODIGOEXTERNO.Size  := 100;

  DESCRICAO.isSearchField := True;
  SIMBOLO.isSearchField   := True;

  ID.displayLabel         := 'Código';
  DESCRICAO.displayLabel  := 'Descrição';
  SIMBOLO.displayLabel    := 'Símbolo';
end;

procedure TUNIDADEMEDIDA.SetCODIGOEXTERNO(const Value: TFieldString);
begin
  FCODIGOEXTERNO := Value;
end;

procedure TUNIDADEMEDIDA.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TUNIDADEMEDIDA.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TUNIDADEMEDIDA.SetSIMBOLO(const Value: TFieldString);
begin
  FSIMBOLO := Value;
end;

end.
