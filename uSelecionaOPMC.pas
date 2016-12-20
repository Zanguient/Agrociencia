unit uSelecionaOPMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TfrmSelecionaOPMC = class(TForm)
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaID_PRODUTO: TIntegerField;
    cds_PesquisaCODIGO: TStringField;
    cds_PesquisaDESCRICAO: TStringField;
    cds_PesquisaPHRECOMENDADO: TFloatField;
    ds_Pesquisa: TDataSource;
    pnPrincipal: TPanel;
    GroupBox1: TGroupBox;
    edPesquisa: TEdit;
    btSelecionar: TBitBtn;
    btBuscar: TBitBtn;
    dgSeleciona: TDBGrid;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edt_Especie: TButtonedEdit;
    edt_NomeEspecie: TEdit;
    edt_CodigoEstagio: TButtonedEdit;
    edt_NomeEstagio: TEdit;
    btn_Buscar: TBitBtn;
    cds_PesquisaORDEMPRODUCAO: TIntegerField;
    procedure cds_PesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure btSelecionarClick(Sender: TObject);
    procedure btn_BuscarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_EspecieChange(Sender: TObject);
    procedure edt_CodigoEstagioChange(Sender: TObject);
    procedure edt_CodigoEstagioRightButtonClick(Sender: TObject);
    procedure edt_EspecieRightButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Retorno       : TEdit;
    prm_Estagio,
    prm_Especie   : Integer;
    procedure SelecionaEstagio;
    procedure SelecionaEspecie;
    procedure Filter;
    procedure Seleciona;

    procedure BuscaDados;
  end;

var
  frmSelecionaOPMC: TfrmSelecionaOPMC;

implementation
uses
  uFWConnection,
  uDomains,
  uDMUtil,
  uFuncoes,
  uBeanProdutos,
  uBeanEstagio;

{$R *.dfm}

procedure TfrmSelecionaOPMC.btBuscarClick(Sender: TObject);
begin
  Filter;
end;

procedure TfrmSelecionaOPMC.btn_BuscarClick(Sender: TObject);
begin
  BuscaDados;
end;

procedure TfrmSelecionaOPMC.btSelecionarClick(Sender: TObject);
begin
  Seleciona;
end;

procedure TfrmSelecionaOPMC.BuscaDados;
var
  FW   : TFWConnection;
  SQL  : TFDQuery;
  I: Integer;
begin
  FW   := TFWConnection.Create;
  SQL  := TFDQuery.Create(nil);
  cds_Pesquisa.DisableControls;
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('M.ID,');
    SQL.SQL.Add('M.ID_PRODUTO,');
    SQL.SQL.Add('M.CODIGO,');
    SQL.SQL.Add('P.DESCRICAO,');
    SQL.SQL.Add('M.PHRECOMENDADO,');
    SQL.SQL.Add('OP.ID AS ORDEMPRODUCAO');
    SQL.SQL.Add('FROM ORDEMPRODUCAOMC OP');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON OP.ID_PRODUTO = P.ID');
    SQL.SQL.Add('INNER JOIN MEIOCULTURA M ON P.ID = M.ID_PRODUTO');
    SQL.SQL.Add('WHERE NOT MC.ENCERRADO');
    if edt_NomeEspecie.Text <> EmptyStr then
      SQL.SQL.Add('AND EXISTS (SELECT 1 FROM MEIOCULTURAESPECIE ME WHERE ME.ID_MEIOCULTURA = M.ID AND ME.ID_ESPECIE = ' + QuotedStr(edt_Especie.Text) + ')');
    if edt_NomeEstagio.Text <> EmptyStr then
      SQL.SQL.Add('AND M.ID_ESTAGIO = ' + QuotedStr(edt_CodigoEstagio.Text));
    SQL.Connection := FW.FDConnection;
    SQL.Open();

    cds_Pesquisa.EmptyDataSet;
    SQL.First;
    while not SQL.Eof do begin
      cds_Pesquisa.Append;
      for I := 0 to Pred(cds_Pesquisa.Fields.Count) do begin
        if Assigned(SQL.FindField(cds_Pesquisa.Fields[I].FieldName)) then
          cds_Pesquisa.Fields[I].Value := SQL.FieldByName(cds_Pesquisa.Fields[I].FieldName).Value;
      end;
      cds_Pesquisa.Post;

      SQL.Next;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FW);
    cds_Pesquisa.EnableControls;
  end;
end;

procedure TfrmSelecionaOPMC.cds_PesquisaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
Var
  I : Integer;
begin
  Accept := False;
  for I := 0 to DataSet.Fields.Count - 1 do begin
    if Pos(AnsiLowerCase(edPesquisa.Text),AnsiLowerCase(DataSet.Fields[I].AsVariant)) > 0 then begin
      Accept := True;
      Break;
    end;
  end;
end;

procedure TfrmSelecionaOPMC.edt_CodigoEstagioChange(Sender: TObject);
begin
  edt_NomeEstagio.Clear;
end;

procedure TfrmSelecionaOPMC.edt_CodigoEstagioRightButtonClick(Sender: TObject);
begin
  SelecionaEstagio;
end;

procedure TfrmSelecionaOPMC.edt_EspecieChange(Sender: TObject);
begin
  edt_NomeEspecie.Clear;
end;

procedure TfrmSelecionaOPMC.edt_EspecieRightButtonClick(Sender: TObject);
begin
  SelecionaEspecie;
end;

procedure TfrmSelecionaOPMC.Filter;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmSelecionaOPMC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmSelecionaOPMC := nil;
  Action := caFree;
end;

procedure TfrmSelecionaOPMC.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
  cds_Pesquisa.CreateDataSet;
  cds_Pesquisa.Open;
end;

procedure TfrmSelecionaOPMC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
    VK_RETURN : begin
      if not cds_Pesquisa.IsEmpty then begin
        Seleciona;
        Close;
      end;
    end;
    VK_UP : begin
      if not cds_Pesquisa.IsEmpty then begin
        if (cds_Pesquisa.RecNo > 1) and not (dgSeleciona.Focused) then
          cds_Pesquisa.Prior;
      end;
    end;
    VK_DOWN : begin
      if not cds_Pesquisa.IsEmpty then begin
        if (cds_Pesquisa.RecNo < cds_Pesquisa.RecordCount) and not (dgSeleciona.Focused) then
          cds_Pesquisa.Next;
      end;
    end;
    VK_F5 : begin
      btn_BuscarClick(nil);
    end;
  end;
end;

procedure TfrmSelecionaOPMC.FormShow(Sender: TObject);
var
  FW : TFWConnection;
  E : TESTAGIO;
  P : TPRODUTO;
begin
  FW := TFWConnection.Create;
  E  := TESTAGIO.Create(FW);
  P  := TPRODUTO.Create(FW);
  try
    if prm_Estagio <> 0 then begin
      E.SelectList('ID = ' + QuotedStr(IntToStr(prm_Estagio)));
      if E.Count > 0 then begin
        edt_CodigoEstagio.Text  := TESTAGIO(E.Itens[0]).ID.asString;
        edt_NomeEstagio.Text    := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
      end;
    end;
    if prm_Especie <> 0 then begin
      P.SelectList('ID = ' + QuotedStr(IntToStr(prm_Especie)));
      if P.Count > 0 then begin
        edt_Especie.Text        := TPRODUTO(P.Itens[0]).ID.asString;
        edt_NomeEspecie.Text    := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;

    BuscaDados;
    edPesquisa.Text := Retorno.Text;
    Filter;

    if cds_Pesquisa.RecordCount = 1 then begin
      btSelecionarClick(nil);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(E);
    FreeAndNil(FW);
  end;
end;

procedure TfrmSelecionaOPMC.Seleciona;
begin
  Retorno.Text    := cds_PesquisaORDEMPRODUCAO.AsString;
end;

procedure TfrmSelecionaOPMC.SelecionaEspecie;
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  edt_NomeEspecie.Clear;
  try
    Filtro := 'finalidade = 1';
    edt_Especie.Tag := DMUtil.Selecionar(P, edt_Especie.Text, Filtro);
    if edt_Especie.Tag > 0 then begin
      P.SelectList('id = ' + IntToStr(edt_Especie.Tag));
      if P.Count > 0 then begin
        edt_Especie.Text           := TPRODUTO(P.Itens[0]).ID.asString;
        edt_NomeEspecie.Text       := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmSelecionaOPMC.SelecionaEstagio;
var
  FW : TFWConnection;
  E : TESTAGIO;
begin
  FW := TFWConnection.Create;
  E  := TESTAGIO.Create(FW);
  edt_NomeEstagio.Clear;
  try
    edt_CodigoEstagio.Tag := DMUtil.Selecionar(E, edt_CodigoEstagio.Text);
    if edt_CodigoEstagio.Tag > 0 then begin
      E.SelectList('id = ' + IntToStr(edt_CodigoEstagio.Tag));
      if E.Count > 0 then begin
        edt_CodigoEstagio.Text     := TESTAGIO(E.Itens[0]).ID.asString;
        edt_NomeEstagio.Text       := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(E);
    FreeAndNil(FW);
  end;
end;


end.
