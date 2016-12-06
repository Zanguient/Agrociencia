unit uEncerramentoOPMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons;

type
  TfrmEncerramentoOPMC = class(TForm)
    pnPrincipal: TPanel;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    edt_CodigoOrdem: TButtonedEdit;
    edt_PHInicial: TJvValidateEdit;
    Label14: TLabel;
    edt_PHFinal: TJvValidateEdit;
    Label1: TLabel;
    Panel2: TPanel;
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
    procedure edt_CodigoOrdemRightButtonClick(Sender: TObject);
    procedure edt_CodigoOrdemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaOrdemProducao;
  end;

var
  frmEncerramentoOPMC: TfrmEncerramentoOPMC;

implementation
uses
  uSeleciona,
  uDMUtil,
  uFWConnection,
  uBeanMeioCultura,
  uBeanOrdemProducaoMC,
  uMensagem,
  uBeanProdutos,
  uFuncoes;
{$R *.dfm}

{ TfrmEncerramentoOPMC }

procedure TfrmEncerramentoOPMC.edt_CodigoOrdemKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then SelecionaOrdemProducao;
end;

procedure TfrmEncerramentoOPMC.edt_CodigoOrdemRightButtonClick(Sender: TObject);
begin
  SelecionaOrdemProducao;
end;

procedure TfrmEncerramentoOPMC.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
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
  try
    Filtro := 'ORDEMPRODUCAOMC.ID_PRODUTO = MEIODULTURA.ID_PRODUTO AND NOT ORDEMPRODUCAOMC.ENCERRADO';
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
      PR.SelectList('ID = ' + TORDEMPRODUCAOMC(OP.Itens[0]).ID_RECIPIENTE.asSQL);
      if PR.Count > 0 then
        edt_NomeRecipiente.Text        := TPRODUTO(PR.Itens[0]).DESCRICAO.asString;
      edt_QuantidadeRecipiente.Value   := TORDEMPRODUCAOMC(OP.Itens[0]).QUANTPRODUTO.Value;
    end;
  finally
    FreeAndNil(PR);
    FreeAndNil(OP);
    FreeAndNil(MC);
    FreeAndNil(FW);
  end;
end;

end.
