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
    GroupBox1: TGroupBox;
    edtMateriaPrima: TButtonedEdit;
    edtNomeMateriaPrima: TEdit;
    edt_Quantidade: TJvValidateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    cds_ComponentesID: TIntegerField;
    btBuscaComponentes: TBitBtn;
    btNovo: TBitBtn;
    btExcluir: TBitBtn;
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
    procedure btCancelarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaMeioCultura;
    procedure SelecionaMateriaPrima;
    procedure SelecionaComponentes;
    procedure GravarComponentes;
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
  uFuncoes,
  uMensagem;
{$R *.dfm}

{ TfrmComposicaoMeioCultura }

procedure TfrmComposicaoMeioCultura.btBuscaComponentesClick(Sender: TObject);
begin
  SelecionaComponentes;
  btNovo.Enabled    := True;
  btExcluir.Enabled := True;
  btGravar.Enabled  := True;
end;

procedure TfrmComposicaoMeioCultura.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmComposicaoMeioCultura.btExcluirClick(Sender: TObject);
begin
  if not cds_Componentes.IsEmpty then
    cds_Componentes.Delete;
end;

procedure TfrmComposicaoMeioCultura.btGravarClick(Sender: TObject);
begin
  if btGravar.Tag = 0 then begin
    btGravar.Tag := 1;
    try
      GravarComponentes;
    finally
      btGravar.Tag := 0;
    end;
  end;
end;

procedure TfrmComposicaoMeioCultura.btNovoClick(Sender: TObject);
begin
  if not cds_Componentes.Locate(cds_ComponentesIDPRODUTO.FieldName, edtMateriaPrima.Text, []) then begin
    cds_Componentes.Append;
    cds_ComponentesIDPRODUTO.Value := StrToInt(edtMateriaPrima.Text);
    cds_ComponentesNOMEPRODUTO.Value:= edtNomeMateriaPrima.Text;
    cds_ComponentesQUANTIDADE.Value := edt_Quantidade.Value;
    cds_Componentes.Post;

    edtMateriaPrima.Clear;
    edt_Quantidade.Clear;
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
  btNovo.Enabled    := False;
  btExcluir.Enabled := False;
  btGravar.Enabled  := False;
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

procedure TfrmComposicaoMeioCultura.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
  cds_Componentes.CreateDataSet;
  cds_Componentes.Open;
end;

procedure TfrmComposicaoMeioCultura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btCancelarClick(nil);
end;

procedure TfrmComposicaoMeioCultura.FormShow(Sender: TObject);
begin
  AutoSizeDBGrid(dg_Componentes);
end;

procedure TfrmComposicaoMeioCultura.GravarComponentes;
var
  FWC : TFWConnection;
  PC  : TPRODUTOCOMPOSICAO;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  PC  := TPRODUTOCOMPOSICAO.Create(FWC);
  try
    DisplayMsg(MSG_WAIT, 'Gravando dados no banco de dados...');
    FWC.StartTransaction;
    try
      PC.SelectList('id_produto = ' + QuotedStr(edtMeioCultura.Text));
      for I := 0 to Pred(PC.Count) do begin
        if not cds_Componentes.Locate(cds_ComponentesID.FieldName, TPRODUTOCOMPOSICAO(PC.Itens[I]).ID.Value, []) then begin
          PC.ID.Value := TPRODUTOCOMPOSICAO(PC.Itens[I]).ID.Value;
          PC.Delete;
        end;
      end;

      cds_Componentes.First;
      while not cds_Componentes.Eof do begin
        PC.ID_COMPONENTE.Value := cds_ComponentesIDPRODUTO.Value;
        PC.QUANTIDADE.Value    := cds_ComponentesQUANTIDADE.Value;
        if cds_ComponentesID.IsNull then begin
          PC.ID.isNull         := True;
          PC.ID_PRODUTO.Value  := StrToInt(edtMeioCultura.Text);
          PC.Insert;
        end else begin
          PC.ID.Value          := cds_ComponentesID.Value;
          PC.Update;
        end;
        cds_Componentes.Next;
      end;
      FWC.Commit;

      edtMeioCultura.Clear;
      cds_Componentes.EmptyDataSet;
      if edtMeioCultura.CanFocus then edtMeioCultura.SetFocus;
      DisplayMsgFinaliza;
    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Ocorreram erros ao gravar componentes!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(PC);
    FreeAndNil(FWC);
  end;
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
    cds_Componentes.EmptyDataSet;
    if edtMeioCultura.Text = EmptyStr then begin
      DisplayMsg(MSG_INF, 'Informe um meio de cultura para continuar!');
      Exit;
    end;
    DisplayMsg(MSG_WAIT, 'Consultando componentes no banco de dados!');
    try
      SQL.Close;
      SQL.SQL.Clear;
      SQL.Connection := FWC.FDConnection;
      SQL.SQL.Add('SELECT p.id, p.descricao, pc.quantidade, pc.id FROM produto p INNER JOIN produtocomposicao pc ON p.id = pc.id_componente WHERE pc.id_produto = :PRODUTO');
      SQL.ParamByName('PRODUTO').AsInteger := StrToInt(edtMeioCultura.Text);
      SQL.Prepare;
      SQL.Open();

      SQL.First;
      while not SQL.Eof do begin
        cds_Componentes.Append;
        cds_ComponentesID.Value           := SQL.Fields[3].Value;
        cds_ComponentesIDPRODUTO.Value    := SQL.Fields[0].Value;
        cds_ComponentesNOMEPRODUTO.Value  := SQL.Fields[1].Value;
        cds_ComponentesQUANTIDADE.Value   := SQL.Fields[2].Value;
        cds_Componentes.Post;

        SQL.Next;
      end;
      DisplayMsgFinaliza;
    except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Erro ao executar consulta!', '', E.Message);
      end;
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
  edtNomeMateriaPrima.Clear;
  try
    Filtro := 'finalidade = 2';
    edtMateriaPrima.Tag := DMUtil.Selecionar(P, edtMateriaPrima.Text, Filtro);
    if edtMateriaPrima.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMateriaPrima.Tag));
      if P.Count > 0 then begin
        edtMateriaPrima.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edtNomeMateriaPrima.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
        if edt_Quantidade.CanFocus then edt_Quantidade.SetFocus;        
      end;
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
  edtNomeMeioCultura.Clear;
  try
    Filtro := 'finalidade = 3';
    edtMeioCultura.Tag := DMUtil.Selecionar(P, edtMeioCultura.Text, Filtro);
    if edtMeioCultura.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edtMeioCultura.Tag));
      if P.Count > 0 then begin
        edtMeioCultura.Text     := TPRODUTO(P.Itens[0]).ID.asString;
        edtNomeMeioCultura.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;
end.
