unit uBeanRecipientes;

interface

uses
  uFWPersistence,
  uDomains;

type
  TRECIPIENTES = class(TFWPersistence)
  private
    FDESCRICAO: TFieldString;
    FID: TFieldInteger;
    FCODIGOEXTERNO: TFieldString;
    procedure SetCODIGOEXTERNO(const Value: TFieldString);
    procedure SetDESCRICAO(const Value: TFieldString);
    procedure SetID(const Value: TFieldInteger);
  protected
    procedure InitInstance; override;
  published
    property ID             : TFieldInteger read FID write SetID;
    property DESCRICAO      : TFieldString read FDESCRICAO write SetDESCRICAO;
    property CODIGOEXTERNO  : TFieldString read FCODIGOEXTERNO write SetCODIGOEXTERNO;
  end;

implementation

{ TRECIPIENTES }

procedure TRECIPIENTES.InitInstance;
begin
  inherited;
  ID.isPK             := True;

  DESCRICAO.isNotNull := True;

  DESCRICAO.Size      := 100;
  CODIGOEXTERNO.Size  := 100;
end;

procedure TRECIPIENTES.SetCODIGOEXTERNO(const Value: TFieldString);
begin
  FCODIGOEXTERNO := Value;
end;

procedure TRECIPIENTES.SetDESCRICAO(const Value: TFieldString);
begin
  FDESCRICAO := Value;
end;

procedure TRECIPIENTES.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

end.
