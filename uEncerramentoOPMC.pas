unit uEncerramentoOPMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons;

type
  TfrmEncerramentoOPMC = class(TForm)
    pnPrincipal: TPanel;
    gbPrincipal: TGroupBox;
    Label18: TLabel;
    edt_CodigoOrdem: TButtonedEdit;
    edt_PHInicial: TJvValidateEdit;
    Label14: TLabel;
    edt_PHFinal: TJvValidateEdit;
    Label1: TLabel;
    pnGridPanel: TPanel;
    GridPanel1: TGridPanel;
    gbMeioCultura: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edt_CodigoMeioCultura: TButtonedEdit;
    edt_DescricaoMeioCultura: TEdit;
    edt_QuantidadeMeioCultura: TJvValidateEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    edt_CodigoRecipientes: TButtonedEdit;
    edt_NomeRecipiente: TEdit;
    edt_QuantidadeRecipiente: TJvValidateEdit;
    edt_MLPorRecipiente: TJvValidateEdit;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btEncerrar: TSpeedButton;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    gbObservacao: TGroupBox;
    edt_Observacao: TEdit;
    procedure edt_CodigoOrdemRightButtonClick(Sender: TObject);
    procedure edt_CodigoOrdemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_CodigoOrdemChange(Sender: TObject);
    procedure btEncerrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaOrdemProducao;
    procedure LimparDadosOrdem;
    procedure EncerrarOrdem;
  end;

var
  frmEncerramentoOPMC: TfrmEncerramentoOPMC;

implementation
uses
  uSeleciona,
  uDMUtil,
  uConstantes,
  uFWConnection,
  uBeanMeioCultura,
  uBeanOrdemProducaoMC,
  uMensagem,
  uBeanProdutos,
  uFuncoes,
  uBeanControleEstoque,
  uBeanControleEstoqueProduto,
  uBeanOrdemProducaoMC_Itens,
  uBeanOrdemProducaoMC_Estoque;
{$R *.dfm}

{ TfrmEncerramentoOPMC }

procedure TfrmEncerramentoOPMC.btEncerrarClick(Sender: TObject);
begin
  if btEncerrar.Tag = 0 then begin
    btEncerrar.Tag := 1;
    try
      EncerrarOrdem;
    finally
      btEncerrar.Tag := 0;
    end;

  end;
end;

procedure TfrmEncerramentoOPMC.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEncerramentoOPMC.edt_CodigoOrdemChange(Sender: TObject);
begin
  if pnPrincipal.Tag = 0 then
    LimparDadosOrdem;
end;

procedure TfrmEncerramentoOPMC.edt_CodigoOrdemKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then SelecionaOrdemProducao;
end;

procedure TfrmEncerramentoOPMC.edt_CodigoOrdemRightButtonClick(Sender: TObject);
begin
  SelecionaOrdemProducao;
end;

procedure TfrmEncerramentoOPMC.EncerrarOrdem;
Var
  FWC   : TFWConnection;
  CE    : TCONTROLEESTOQUE;
  CEP   : TCONTROLEESTOQUEPRODUTO;
  OPMC  : TORDEMPRODUCAOMC;
  OPMCI : TORDEMPRODUCAOMC_ITENS;
  OPMCE : TORDEMPRODUCAOMC_ESTOQUE;
  I: Integer;
begin
  if (edt_CodigoOrdem.Text = EmptyStr) or (edt_CodigoOrdem.Tag = 0) then begin
    DisplayMsg(MSG_INF, 'Selecione uma Ordem de Produção de Meio de Cultura!');
    Exit;
  end;

  FWC     := TFWConnection.Create;
  CE      := TCONTROLEESTOQUE.Create(FWC);
  CEP     := TCONTROLEESTOQUEPRODUTO.Create(FWC);
  OPMC    := TORDEMPRODUCAOMC.Create(FWC);
  OPMCI   := TORDEMPRODUCAOMC_ITENS.Create(FWC);
  OPMCE   := TORDEMPRODUCAOMC_ESTOQUE.Create(FWC);
  try
    DisplayMsg(MSG_WAIT, 'Encerrando Ordem de Produção de Meio de Cultura...');

    FWC.StartTransaction;
    try
      OPMC.SelectList('ID = ' + QuotedStr(edt_CodigoOrdem.Text));
      if OPMC.Count > 0 then begin
        CE.ID.isNull                := True;
        CE.DATAHORA.Value           := Now;
        CE.USUARIO_ID.Value         := USUARIO.CODIGO;
        CE.TIPOMOVIMENTACAO.Value   := 1;
        CE.CANCELADO.Value          := False;
        CE.OBSERVACAO.Value         := 'Encerramento da Ordem de Produção de Meio de Cultura: ' + TORDEMPRODUCAOMC(OPMC.Itens[0]).ID.asString;
        CE.Insert;

        CEP.ID.isNull               := True;
        CEP.CONTROLEESTOQUE_ID.Value:= CE.ID.Value;
        CEP.PRODUTO_ID.Value        := StrToInt(edt_CodigoMeioCultura.Text);
        CEP.QUANTIDADE.Value        := edt_QuantidadeMeioCultura.Value;
        CEP.Insert;

        CEP.ID.isNull               := True;
        CEP.CONTROLEESTOQUE_ID.Value:= CE.ID.Value;
        CEP.PRODUTO_ID.Value        := StrToInt(edt_CodigoRecipientes.Text);
        CEP.QUANTIDADE.Value        := edt_QuantidadeRecipiente.Value;
        CEP.Insert;

        OPMCI.SelectList('ID_ORDEMPRODUCAOMC = ' + QuotedStr(edt_CodigoOrdem.Text));
        if OPMCI.Count > 0 then begin
          for I := 0 to Pred(OPMCI.Count) do begin
            CEP.ID.isNull               := True;
            CEP.CONTROLEESTOQUE_ID.Value:= CE.ID.Value;
            CEP.PRODUTO_ID.Value        := TORDEMPRODUCAOMC_ITENS(OPMCI.Itens[I]).ID_PRODUTO.Value;
            CEP.QUANTIDADE.Value        := TORDEMPRODUCAOMC_ITENS(OPMCI.Itens[I]).QUANTIDADE.Value * -1;
            CEP.Insert;
          end;
        end;
      end;

      OPMC.ID.Value                     := StrToInt(edt_CodigoOrdem.Text);
      OPMC.ENCERRADO.Value              := True;
      OPMC.DATAFIM.Value                := Now;
      OPMC.ID_USUARIOEXECUTAR.Value     := USUARIO.CODIGO;
      OPMC.PHINICIAL.Value              := edt_PHInicial.Value;
      OPMC.PHFINAL.Value                := edt_PHFinal.Value;
      OPMC.MLRECIPIENTE.Value           := edt_MLPorRecipiente.Value;
      OPMC.QUANTRECIPIENTES.Value       := edt_QuantidadeRecipiente.Value;
      OPMC.OBSERVACAOENCERRAMENTO.Value := edt_Observacao.Text;

      OPMC.Update;

      OPMCE.ID.isNull                   := True;
      OPMCE.ID_ORDEMPRODUCAOMC.Value    := OPMC.ID.Value;
      OPMCE.QUANTIDADE.Value            := OPMC.QUANTRECIPIENTES.Value;
      OPMCE.SALDO.Value                 := OPMC.QUANTRECIPIENTES.Value;
      OPMCE.Insert;

      FWC.Commit;
      DisplayMsgFinaliza;
      LimparDadosOrdem;
    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao Encerrar Ordem de Produção de Meios de Cultura!');
      end;
    end;
  finally
    FreeAndNil(CE);
    FreeAndNil(CEP);
    FreeAndNil(OPMC);
    FreeAndNil(OPMCI);
    FreeAndNil(OPMCE);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmEncerramentoOPMC.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmEncerramentoOPMC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;  
end;

procedure TfrmEncerramentoOPMC.LimparDadosOrdem;
begin
  pnPrincipal.Tag := 1;
  try
    edt_CodigoOrdem.Tag := 0;
    edt_CodigoOrdem.Clear;
    edt_PHInicial.Value := 0;
    edt_PHFinal.Value   := 0;
    edt_Observacao.Clear;
    edt_CodigoMeioCultura.Clear;
    edt_DescricaoMeioCultura.Clear;
    edt_CodigoRecipientes.Clear;
    edt_NomeRecipiente.Clear;
    edt_MLPorRecipiente.Value  := 0;
    edt_QuantidadeMeioCultura.Value := 0;
    edt_QuantidadeRecipiente.Value  := 0;
  finally
    pnPrincipal.Tag := 0;
  end;
end;

procedure TfrmEncerramentoOPMC.SelecionaOrdemProducao;
var
  FW : TFWConnection;
  MC : TMEIOCULTURA;
  OP : TORDEMPRODUCAOMC;
  PR : TPRODUTO;
  Filtro : string;
begin
  FW := TFWConnection.Create;
  MC := TMEIOCULTURA.Create(FW);
  OP := TORDEMPRODUCAOMC.Create(FW);
  PR := TPRODUTO.Create(FW);
  pnPrincipal.Tag := 0;
  try
    pnPrincipal.Tag := 1;
    Filtro := 'ORDEMPRODUCAOMC.ID_PRODUTO = MEIOCULTURA.ID_PRODUTO AND NOT ORDEMPRODUCAOMC.ENCERRADO';
    edt_CodigoOrdem.Tag := DMUtil.Selecionar(OP, edt_CodigoOrdem.Text, Filtro, MC);
    OP.SelectList('ID = ' + QuotedStr(IntToStr(edt_CodigoOrdem.Tag)));
    if OP.Count > 0 then begin
      edt_CodigoOrdem.Text             := TORDEMPRODUCAOMC(OP.Itens[0]).ID.asString;
      edt_PHInicial.Value              := TORDEMPRODUCAOMC(OP.Itens[0]).PHINICIAL.Value;
      edt_PHFinal.Value                := TORDEMPRODUCAOMC(OP.Itens[0]).PHFINAL.Value;
      edt_CodigoMeioCultura.Text       := TORDEMPRODUCAOMC(OP.Itens[0]).ID_PRODUTO.asString;
      MC.SelectList('ID = ' + TORDEMPRODUCAOMC(OP.Itens[0]).ID_PRODUTO.asSQL);
      if MC.Count > 0 then begin
        PR.SelectList('ID = ' + TMEIOCULTURA(MC.Itens[0]).ID_PRODUTO.asSQL);
        if PR.Count > 0 then
          edt_DescricaoMeioCultura.Text:= TPRODUTO(PR.Itens[0]).DESCRICAO.asString;
      end;
      edt_QuantidadeMeioCultura.Value  := TORDEMPRODUCAOMC(OP.Itens[0]).QUANTPRODUTO.Value;
      edt_CodigoRecipientes.Text       := TORDEMPRODUCAOMC(OP.Itens[0]).ID_RECIPIENTE.asString;
      edt_MLPorRecipiente.Value        := TORDEMPRODUCAOMC(OP.Itens[0]).MLRECIPIENTE.Value;
      PR.SelectList('ID = ' + TORDEMPRODUCAOMC(OP.Itens[0]).ID_RECIPIENTE.asSQL);
      if PR.Count > 0 then
        edt_NomeRecipiente.Text        := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;
      edt_QuantidadeRecipiente.Value   := TORDEMPRODUCAOMC(OP.Itens[0]).QUANTPRODUTO.Value;
    end;
  finally
    pnPrincipal.Tag := 0;
    FreeAndNil(PR);
    FreeAndNil(OP);
    FreeAndNil(MC);
    FreeAndNil(FW);
  end;
end;

end.
