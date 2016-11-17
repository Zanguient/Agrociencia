unit uComposicaoMeioCultura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  JvExStdCtrls, JvEdit, JvValidateEdit, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmComposicaoMeioCultura = class(TForm)
    Panel2: TPanel;
    gbMeioCultura: TGroupBox;
    edtMeioCultura: TButtonedEdit;
    edtNomeMeioCultura: TEdit;
    btBuscaComponentes: TSpeedButton;
    GroupBox1: TGroupBox;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btNovo: TSpeedButton;
    Label5: TLabel;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    cds_Componentes: TClientDataSet;
    cds_ComponentesIDPRODUTO: TIntegerField;
    cds_ComponentesNOMEPRODUTO: TStringField;
    cds_ComponentesQUANTIDADE: TFloatField;
    dg_Componentes: TDBGrid;
    ds_Componentes: TDataSource;
    btExcluir: TSpeedButton;
    procedure edtMeioCulturaRightButtonClick(Sender: TObject);
    procedure edtMeioCulturaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMeioCulturaChange(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btBuscaComponentesClick(Sender: TObject);
    procedure edtMateriaPrimaRightButtonClick(Sender: TObject);
    procedure edtMateriaPrimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMateriaPrimaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaMeioCultura;
    procedure SelecionaMateriaPrima;
    procedure SelecionaComponentes;
  end;

var
  frmComposicaoMeioCultura: TfrmComposicaoMeioCultura;

implementation
uses
  uFWConnection,
  uBeanProdutos,
  uDMUtil,
  uBeanProdutoComposicao,
  uSeleciona,
  uFuncoes;
{$R *.dfm}

{ TfrmComposicaoMeioCultura }

procedure TfrmComposicaoMeioCultura.btBuscaComponentesClick(Sender: TObject);
begin
  SelecionaComponentes;
end;

procedure TfrmComposicaoMeioCultura.btExcluirClick(Sender: TObject);
begin
  if not cds_Componentes.IsEmpty then
    cds_Componentes.Delete;
end;

procedure TfrmComposicaoMeioCultura.btNovoClick(Sender: TObject);
begin
  if not cds_Componentes.Locate(cds_ComponentesIDPRODUTO.FieldName, edtMateriaPrima.Text, []) then begin
    cds_Componentes.Append;
    cds_ComponentesIDPRODUTO.Value := StrToInt(edtMateriaPrima.Text);
    cds_ComponentesNOMEPRODUTO.Value:= edtNomeMateriaPrima.Text;
    cds_ComponentesQUANTIDADE.Value := edt_Quantidade.Value;
    cds_Componentes.Post;
  end;
end;

procedure TfrmComposicaoMeioCultura.edtMateriaPrimaChange(Sender: TObject);
begin
  edtMateriaPrima.Tag := 0;
  edtNomeMateriaPrima.Clear;
end;

procedure TfrmComposicaoMeioCultura.edtMateriaPrimaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN : SelecionaMateriaPrima;
  end;
end;

procedure TfrmComposicaoMeioCultura.edtMateriaPrimaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMateriaPrima;
end;

procedure TfrmComposicaoMeioCultura.edtMeioCulturaChange(Sender: TObject);
begin
  edtMeioCultura.Tag := 0;
  edtNomeMeioCultura.Clear;
end;

procedure TfrmComposicaoMeioCultura.edtMeioCulturaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN : SelecionaMeioCultura;
  end;
end;

procedure TfrmComposicaoMeioCultura.edtMeioCulturaRightButtonClick(
  Sender: TObject);
begin
  SelecionaMeioCultura;
end;

procedure TfrmComposicaoMeioCultura.SelecionaComponentes;
var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.Connection := FWC.FDConnection;
    SQL.SQL.Add('SELECT p.id, p.descricao, pc.quantidade FROM produto p INNER JOIN produtocomposicao pc ON p.id = pc.id_componente WHERE pc.id_produto = :PRODUTO');
    SQL.ParamByName('PRODUTO').AsInteger := StrToInt(edtMeioCultura.Text);
    SQL.Prepare;
    SQL.Open();

    SQL.First;
    while not SQL.Eof do begin
      cds_Componentes.Append;
      cds_ComponentesIDPRODUTO.Value    := SQL.Fields[0].Value;
      cds_ComponentesNOMEPRODUTO.Value  := SQL.Fields[1].Value;
      cds_ComponentesQUANTIDADE.Value   := SQL.Fields[2].Value;
      cds_Componentes.Post;

      SQL.Next;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoMeioCultura.SelecionaMateriaPrima;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  edtMateriaPrima.Clear;
  try
    Filtro := 'finalidade = 2';
    edtMateriaPrima.Tag := DMUtil.Selecionar(P, edtMateriaPrima.Text, Filtro);
    if edtMateriaPrima.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMateriaPrima.Tag));
      if P.Count > 0 then
        edtNomeMateriaPrima.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmComposicaoMeioCultura.SelecionaMeioCultura;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  edtMeioCultura.Clear;
  try
    Filtro := 'finalidade = 3';
    edtMeioCultura.Tag := DMUtil.Selecionar(P, edtMeioCultura.Text, Filtro);
    if edtMeioCultura.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMeioCultura.Tag));
      if P.Count > 0 then
        edtNomeMeioCultura.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;
end.
