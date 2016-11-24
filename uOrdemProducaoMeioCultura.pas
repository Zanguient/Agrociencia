unit uOrdemProducaoMeioCultura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, JvExStdCtrls, JvEdit, JvValidateEdit, Vcl.Mask,
  JvExMask, JvToolEdit;

type
  TfrmOrdemProducaoMeioCultura = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    gbMeioCultura: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    btNovo: TBitBtn;
    btExcluir: TBitBtn;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    dg_Componentes: TDBGrid;
    ButtonedEdit1: TButtonedEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    JvValidateEdit1: TJvValidateEdit;
    Label6: TLabel;
    ButtonedEdit2: TButtonedEdit;
    Label7: TLabel;
    Edit2: TEdit;
    Label8: TLabel;
    JvValidateEdit2: TJvValidateEdit;
    Label9: TLabel;
    ButtonedEdit3: TButtonedEdit;
    Label10: TLabel;
    Edit3: TEdit;
    Label11: TLabel;
    JvValidateEdit3: TJvValidateEdit;
    Label12: TLabel;
    Label13: TLabel;
    JvValidateEdit4: TJvValidateEdit;
    Label14: TLabel;
    JvValidateEdit5: TJvValidateEdit;
    JvDateEdit1: TJvDateEdit;
    JvDateEdit2: TJvDateEdit;
    Label15: TLabel;
    Label16: TLabel;
    btGravar: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrdemProducaoMeioCultura: TfrmOrdemProducaoMeioCultura;

implementation
uses
  uFWConnection,
  uBeanProdutos,
  uDMUtil,
  uBeanProdutoComposicao,
  uSeleciona,
  uFuncoes,
  uMensagem,
  uBeanOrdemProducaoMP;
{$R *.dfm}

procedure TfrmOrdemProducaoMeioCultura.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmOrdemProducaoMeioCultura.FormShow(Sender: TObject);
begin
  AjustaForm(frmOrdemProducaoMeioCultura);
end;

end.
