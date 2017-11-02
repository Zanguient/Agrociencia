unit uDescarteMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  JvExStdCtrls, JvEdit, JvValidateEdit;

type
  TParametro = record
    ID_OPMC: Integer;
    QUANTIDADE: Currency;
  end;
  TfrmDescarteMC = class(TForm)
    Panel1: TPanel;
    pnSuperior: TPanel;
    Label8: TLabel;
    Label1: TLabel;
    edt_Motivo: TEdit;
    edt_CodigoMotivo: TButtonedEdit;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btDescartar: TSpeedButton;
    Panel9: TPanel;
    btCancelar: TSpeedButton;
    edQuantidade: TJvValidateEdit;
    Label2: TLabel;
    procedure btCancelarClick(Sender: TObject);
    procedure edt_CodigoMotivoChange(Sender: TObject);
    procedure edt_CodigoMotivoRightButtonClick(Sender: TObject);
    procedure edt_CodigoMotivoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btDescartarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure SelecionaMotivoDescarte;
    procedure Descartar;
  public
    { Public declarations }
    Parametro: TParametro;
  end;

var
  frmDescarteMC: TfrmDescarteMC;

implementation
uses
  uFWConnection,
  uBeanMotivoDescarte,
  uBeanOrdemProducaoMC,
  uDMUtil,
  uBeanOrdemProducaoMC_Descarte,
  uBeanControleEstoque,
  uBeanControleEstoqueProduto,
  uBeanProdutos,
  uMensagem,
  uConstantes,
  uFuncoes;
{$R *.dfm}

procedure TfrmDescarteMC.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDescarteMC.btDescartarClick(Sender: TObject);
begin
  if edQuantidade.Value > Parametro.QUANTIDADE then
  begin
    DisplayMsg(MSG_INF, 'Quantidade de descarte maior do que a disponível para baixa.');
    if edQuantidade.CanFocus then edQuantidade.SetFocus;
    Exit;
  end;
  if edt_Motivo.Text = '' then
  begin
    DisplayMsg(MSG_INF, 'Motivo inválido.');
    if edt_CodigoMotivo.CanFocus then edt_CodigoMotivo.SetFocus;
    Exit;
  end;

  Descartar;
  Close;
end;

procedure TfrmDescarteMC.Descartar;
var
  FWC: TFWConnection;
  OPMC: TORDEMPRODUCAOMC;
  DESCARTE: TORDEMPRODUCAOMC_DESCARTE;
  ESTOQUE: TCONTROLEESTOQUE;
  ESTOQUE_PROD: TCONTROLEESTOQUEPRODUTO;
  RECIPIENTE: TPRODUTO;
begin
  FWC := TFWConnection.Create;
  OPMC := TORDEMPRODUCAOMC.Create(FWC);
  DESCARTE := TORDEMPRODUCAOMC_DESCARTE.Create(FWC);
  ESTOQUE := TCONTROLEESTOQUE.Create(FWC);
  ESTOQUE_PROD := TCONTROLEESTOQUEPRODUTO.Create(FWC);
  RECIPIENTE := TPRODUTO.Create(FWC);
  try
    DisplayMsg(MSG_WAIT, 'Salvando dados.', 'Aguarde...');
    FWC.StartTransaction;
    try
      OPMC.SelectList('ID = ' + IntToStr(Parametro.ID_OPMC));
      if OPMC.Count = 0 then
      begin
        DisplayMsg(MSG_WAR, 'Ordem de Produção não encontrada.');
        Exit;
      end;

      RECIPIENTE.SelectList('ID = ' + TORDEMPRODUCAOMC(OPMC.Itens[0]).ID_RECIPIENTE.asSQL);

      if RECIPIENTE.Count = 0 then
      begin
        DisplayMsg(MSG_WAR, 'Recipiente não encontrado.');
        Exit;
      end;

      OPMC.ID.Value := TORDEMPRODUCAOMC(OPMC.Itens[0]).ID.Value;
      OPMC.SALDO.Value := TORDEMPRODUCAOMC(OPMC.Itens[0]).SALDO.Value - edQuantidade.Value;
      OPMC.Update;

      DESCARTE.ID.isNull := True;
      DESCARTE.ID_ORDEMPRODUCAOMC.Value := OPMC.ID.Value;
      DESCARTE.QUANTIDADE.Value := edQuantidade.Value;
      DESCARTE.ID_MOTIVO.Value := StrToInt(edt_CodigoMotivo.Text);
      DESCARTE.Insert;

      if TPRODUTO(RECIPIENTE.Itens[0]).RECIPIENTEREAPROVEITAVEL.Value then
      begin
        ESTOQUE.ID.isNull := True;
        ESTOQUE.USUARIO_ID.Value := USUARIO.CODIGO;
        ESTOQUE.TIPOMOVIMENTACAO.Value := 0;
        ESTOQUE.OBSERVACAO.Value := 'Retorno de recipientes.';
        ESTOQUE.CANCELADO.Value := False;
        ESTOQUE.DATAHORA.Value := Now;
        ESTOQUE.Insert;

        ESTOQUE_PROD.ID.isNull := True;
        ESTOQUE_PROD.CONTROLEESTOQUE_ID.Value := ESTOQUE.ID.Value;
        ESTOQUE_PROD.PRODUTO_ID.Value := TPRODUTO(RECIPIENTE.Itens[0]).ID.Value;
        ESTOQUE_PROD.QUANTIDADE.Value := edQuantidade.Value;
        ESTOQUE_PROD.Insert;
      end;

      ESTOQUE.ID.isNull := True;
      ESTOQUE.USUARIO_ID.Value := USUARIO.CODIGO;
      ESTOQUE.TIPOMOVIMENTACAO.Value := 0;
      ESTOQUE.OBSERVACAO.Value := 'Descarte de Meio de Cultura.';
      ESTOQUE.CANCELADO.Value := False;
      ESTOQUE.DATAHORA.Value := Now;
      ESTOQUE.Insert;

      ESTOQUE_PROD.ID.isNull := True;
      ESTOQUE_PROD.CONTROLEESTOQUE_ID.Value := ESTOQUE.ID.Value;
      ESTOQUE_PROD.PRODUTO_ID.Value :=  TORDEMPRODUCAOMC(OPMC.Itens[0]).ID_PRODUTO.Value;
      ESTOQUE_PROD.QUANTIDADE.Value := edQuantidade.Value;
      ESTOQUE_PROD.Insert;

      DisplayMsgFinaliza;
      FWC.Commit;
    except
      on E: Exception do
      begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Descartar', '', E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(DESCARTE);
    FreeAndNil(OPMC);
    FreeAndNil(ESTOQUE);
    FreeAndNil(ESTOQUE_PROD);
    FreeAndNil(RECIPIENTE);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmDescarteMC.edt_CodigoMotivoChange(Sender: TObject);
begin
  edt_Motivo.Clear;
end;

procedure TfrmDescarteMC.edt_CodigoMotivoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaMotivoDescarte;
end;

procedure TfrmDescarteMC.edt_CodigoMotivoRightButtonClick(Sender: TObject);
begin
  SelecionaMotivoDescarte;
end;

procedure TfrmDescarteMC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btCancelarClick(nil);
end;

procedure TfrmDescarteMC.FormShow(Sender: TObject);
begin
  edQuantidade.Value := Parametro.QUANTIDADE;
  AjustaForm(Self);
end;

procedure TfrmDescarteMC.SelecionaMotivoDescarte;
var
  FWC : TFWConnection;
  M   : TMOTIVODESCARTE;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  M      := TMOTIVODESCARTE.Create(FWC);
  edt_Motivo.Clear;
  try
    Filtro := '';
    edt_CodigoMotivo.Tag := DMUtil.Selecionar(M, edt_CodigoMotivo.Text, Filtro);
    if edt_CodigoMotivo.Tag > 0 then begin
      M.SelectList('id = ' + IntToStr(edt_CodigoMotivo.Tag));
      if M.Count > 0 then begin
        edt_CodigoMotivo.Text     := TMOTIVODESCARTE(M.Itens[0]).ID.asString;
        edt_Motivo.Text           := TMOTIVODESCARTE(M.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(M);
    FreeAndNil(FWC);
  end;
end;

end.
