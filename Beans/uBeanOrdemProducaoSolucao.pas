unit uBeanOrdemProducaoSolucao;

interface
uses
  uFWPersistence,
  uDomains;

type
  TORDEMPRODUCAOSOLUCAO = class(TFWPersistence)
  private
    FID_PRODUTO: TFieldInteger;
    FID: TFieldInteger;
    FID_USUARIOINCLUSAO: TFieldInteger;
    FDATAINCLUSAO: TFieldDateTime;
    FDATAENCERRAMENTO: TFieldDateTime;
    FID_USUARIOENCERRAMENTO: TFieldInteger;
    FQUANTIDADE: TFieldFloat;
    FENCERRADO: TFieldBoolean;
    FDATAPREVISAO: TFieldDate;
    FOBSERVACAO: TFieldString;
    FOBSERVACAOENCERRAMENTO: TFieldString;
    procedure SetDATAENCERRAMENTO(const Value: TFieldDateTime);
    procedure SetDATAINCLUSAO(const Value: TFieldDateTime);
    procedure SetID(const Value: TFieldInteger);
    procedure SetID_PRODUTO(const Value: TFieldInteger);
    procedure SetID_USUARIOENCERRAMENTO(const Value: TFieldInteger);
    procedure SetID_USUARIOINCLUSAO(const Value: TFieldInteger);
    procedure SetQUANTIDADE(const Value: TFieldFloat);
    procedure SetENCERRADO(const Value: TFieldBoolean);
    procedure SetDATAPREVISAO(const Value: TFieldDate);
    procedure SetOBSERVACAO(const Value: TFieldString);
    procedure SetOBSERVACAOENCERRAMENTO(const Value: TFieldString);
  protected
    procedure InitInstance; override;
  published
    property ID : TFieldInteger read FID write SetID;
    property DATAINCLUSAO : TFieldDateTime read FDATAINCLUSAO write SetDATAINCLUSAO;
    property ID_USUARIOINCLUSAO : TFieldInteger read FID_USUARIOINCLUSAO write SetID_USUARIOINCLUSAO;
    property ID_PRODUTO : TFieldInteger read FID_PRODUTO write SetID_PRODUTO;
    property QUANTIDADE : TFieldFloat read FQUANTIDADE write SetQUANTIDADE;
    property ID_USUARIOENCERRAMENTO : TFieldInteger read FID_USUARIOENCERRAMENTO write SetID_USUARIOENCERRAMENTO;
    property DATAENCERRAMENTO : TFieldDateTime read FDATAENCERRAMENTO write SetDATAENCERRAMENTO;
    property ENCERRADO : TFieldBoolean read FENCERRADO write SetENCERRADO;
    property DATAPREVISAO : TFieldDate read FDATAPREVISAO write SetDATAPREVISAO;
    property OBSERVACAO : TFieldString read FOBSERVACAO write SetOBSERVACAO;
    property OBSERVACAOENCERRAMENTO : TFieldString read FOBSERVACAOENCERRAMENTO write SetOBSERVACAOENCERRAMENTO;
  end;
implementation

{ TORDEMPRODUCAOSOLUCAO }

procedure TORDEMPRODUCAOSOLUCAO.InitInstance;
begin
  inherited;
  ID.isPK                     := True;
  OBSERVACAO.Size             := 1000;
  OBSERVACAOENCERRAMENTO.Size := 1000;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetDATAENCERRAMENTO(
  const Value: TFieldDateTime);
begin
  FDATAENCERRAMENTO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetDATAINCLUSAO(const Value: TFieldDateTime);
begin
  FDATAINCLUSAO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetDATAPREVISAO(const Value: TFieldDate);
begin
  FDATAPREVISAO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetENCERRADO(const Value: TFieldBoolean);
begin
  FENCERRADO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetID(const Value: TFieldInteger);
begin
  FID := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetID_PRODUTO(const Value: TFieldInteger);
begin
  FID_PRODUTO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetID_USUARIOENCERRAMENTO(
  const Value: TFieldInteger);
begin
  FID_USUARIOENCERRAMENTO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetID_USUARIOINCLUSAO(
  const Value: TFieldInteger);
begin
  FID_USUARIOINCLUSAO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetOBSERVACAO(const Value: TFieldString);
begin
  FOBSERVACAO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetOBSERVACAOENCERRAMENTO(
  const Value: TFieldString);
begin
  FOBSERVACAOENCERRAMENTO := Value;
end;

procedure TORDEMPRODUCAOSOLUCAO.SetQUANTIDADE(const Value: TFieldFloat);
begin
  FQUANTIDADE := Value;
end;

end.
