unit uSelecionaCadastroPlantas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TfrmSelecionaCadastroPlantas = class(TForm)
    cds_Pesquisa: TClientDataSet;
    ds_Pesquisa: TDataSource;
    pnPrincipal: TPanel;
    GroupBox1: TGroupBox;
    edPesquisa: TEdit;
    btSelecionar: TBitBtn;
    btBuscar: TBitBtn;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaDATAHORA: TDateTimeField;
    cds_PesquisaNOMECLIENTE: TStringField;
    cds_PesquisaDESCRICAOPRODUTO: TStringField;
    cds_PesquisaQUANTIDADE: TIntegerField;
    cds_PesquisaSELECAOPOSITIVA: TStringField;
    cds_PesquisaCODIGOSELECAOCAMPO: TStringField;
    gdSeleciona: TDBGrid;
    procedure cds_PesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure btSelecionarClick(Sender: TObject);
    procedure btn_BuscarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Retorno       : TEdit;
    procedure Filter;
    procedure Seleciona;
    procedure BuscaDados;
  end;

var
  frmSelecionaCadastroPlantas: TfrmSelecionaCadastroPlantas;

implementation
uses
  uFWConnection,
  uDomains,
  uDMUtil,
  uFuncoes;

{$R *.dfm}

procedure TfrmSelecionaCadastroPlantas.btBuscarClick(Sender: TObject);
begin
  Filter;
end;

procedure TfrmSelecionaCadastroPlantas.btn_BuscarClick(Sender: TObject);
begin
  BuscaDados;
end;

procedure TfrmSelecionaCadastroPlantas.btSelecionarClick(Sender: TObject);
begin
  Seleciona;
end;

procedure TfrmSelecionaCadastroPlantas.BuscaDados;
var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I   : Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  cds_Pesquisa.DisableControls;
  try

    cds_Pesquisa.EmptyDataSet;

    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	OPF.ID,');
    SQL.SQL.Add('	OPF.DATAHORA,');
    SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
    SQL.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
    SQL.SQL.Add('	OPF.QUANTIDADE,');
    SQL.SQL.Add('	OPF.SELECAOPOSITIVA,');
    SQL.SQL.Add('	OPF.CODIGOSELECAOCAMPO');
    SQL.SQL.Add('FROM OPFINAL OPF');
    SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL AND OPF.CANCELADO = False');
    SQL.SQL.Add('ORDER BY OPF.ID ASC');
    SQL.Connection  := FWC.FDConnection;
    SQL.Prepare;
    SQL.Open;
    SQL.FetchAll;

    if not SQL.IsEmpty then begin
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
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
    cds_Pesquisa.EnableControls;
  end;
end;

procedure TfrmSelecionaCadastroPlantas.cds_PesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmSelecionaCadastroPlantas.Filter;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmSelecionaCadastroPlantas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmSelecionaCadastroPlantas := nil;
  Action := caFree;
end;

procedure TfrmSelecionaCadastroPlantas.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
  cds_Pesquisa.CreateDataSet;
end;

procedure TfrmSelecionaCadastroPlantas.FormKeyDown(Sender: TObject; var Key: Word;
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
        if (cds_Pesquisa.RecNo > 1) and not (gdSeleciona.Focused) then
          cds_Pesquisa.Prior;
      end;
    end;
    VK_DOWN : begin
      if not cds_Pesquisa.IsEmpty then begin
        if (cds_Pesquisa.RecNo < cds_Pesquisa.RecordCount) and not (gdSeleciona.Focused) then
          cds_Pesquisa.Next;
      end;
    end;
    VK_F5 : begin
      btn_BuscarClick(nil);
    end;
  end;
end;

procedure TfrmSelecionaCadastroPlantas.FormShow(Sender: TObject);
begin

  BuscaDados;

  edPesquisa.Text := Retorno.Text;

  Filter;

  if cds_Pesquisa.RecordCount = 1 then begin
    btSelecionarClick(nil);
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  end else
    AutoSizeDBGrid(gdSeleciona);

end;

procedure TfrmSelecionaCadastroPlantas.Seleciona;
begin
  Retorno.Text    := cds_PesquisaID.AsString;
end;

end.
