unit uRelProducaoOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Comp.Client, Data.DB, frxDBSet;

type
  TfrmRelProducaoOP = class(TForm)
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    gbOPF: TGroupBox;
    edCodigoOPF: TButtonedEdit;
    edDescOPF: TEdit;
    procedure edCodigoOPFRightButtonClick(Sender: TObject);
    procedure edCodigoOPFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoOPFChange(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaOP;
  end;

var
  frmRelProducaoOP: TfrmRelProducaoOP;

implementation

uses
  uDMUtil, uFWConnection, uBeanOPFinal;

{$R *.dfm}

procedure TfrmRelProducaoOP.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelProducaoOP.btRelatorioClick(Sender: TObject);
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  ConsultaI : TFDQuery;
  FR        : TfrxDBDataset;
  FRI       : TfrxDBDataset;
begin
  FWC := TFWConnection.Create;
  Consulta := TFDQuery.Create(nil);
  try
    Consulta.Close;
    Consulta.SQL.Clear;
    Consulta.SQL.Add('SELECT');
    Consulta.SQL.Add('CL.NOME AS NOMECLIENTE,');
    Consulta.SQL.Add('PR.DESCRICAO AS PRODUTO,');
    Consulta.SQL.Add('E.DESCRICAO AS ESTAGIO,');
    Consulta.SQL.Add('CAST(E.PREVISAOINICIO AS DATE) AS DATAI,');
    Consulta.SQL.Add('CAST(E.PREVISAOTERMINO AS DATE) AS DATAF,');
    Consulta.SQL.Add('OPEL.NUMEROLOTE,');
    Consulta.SQL.Add('(SELECT COUNT(*) FROM OPFINAL_ESTAGIO_LOTE_S OPELS WHERE OPELS.OPFINAL_ESTAGIO_LOTE_ID = OPEL.ID) AS UNIDADEPRODUZIDA,');
    Consulta.SQL.Add('(SELECT COUNT(*) FROM OPFINAL_ESTAGIO_LOTE_S OPELS INNER JOIN OPFINAL_ESTAGIO_LOTE_S_QUALIDADE OPELSQ ON OPELS.ID = OPELSQ.ID_OPFINAL_ESTAGIO_LOTE_S WHERE OPELS.OPFINAL_ESTAGIO_LOTE_ID = OPEL.ID) AS UNIDADEPRODUZIDA');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('FROM OPFINAL OP');
    Consulta.SQL.Add('INNER JOIN CLIENTE CL ON OP.CLIENTE_ID = CL.ID');
    Consulta.SQL.Add('INNER JOIN PRODUTO PR ON OP.PRODUTO_ID = PR.ID');
    Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPE ON OP.ID = OPE.OPFINAL_ID');
    Consulta.SQL.Add('INNER JOIN ESTAGIO E ON OPE.ESTAGIO_ID = E.ID');
    Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPEL ON OPEL.OPFINAL_ESTAGIO_ID = OPE.ID');
    Consulta.SQL.Add('WHERE OP.ID = :ID');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');
    Consulta.SQL.Add('');

  finally
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;

end;

procedure TfrmRelProducaoOP.edCodigoOPFChange(Sender: TObject);
begin
  edDescOPF.Clear;
end;

procedure TfrmRelProducaoOP.edCodigoOPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoOPFRightButtonClick(nil);
end;

procedure TfrmRelProducaoOP.edCodigoOPFRightButtonClick(Sender: TObject);
begin
  edCodigoOPF.Text := IntToStr(DMUtil.SelecionarCadastroPlantas(edCodigoOPF.Text));
end;

procedure TfrmRelProducaoOP.SelecionaOP;
var
  FWC     : TFWConnection;
  OPF     : TOPFINAL;
  SQL     : TFDQuery;
begin
  FWC := TFWConnection.Create;
  OPF := TOPFINAL.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	C.NOME AS NOMECLIENTE,');
    SQL.SQL.Add('	P.ID,');
    SQL.SQL.Add(' P.DESCRICAO');
    SQL.SQL.Add('FROM OPFINAL OPF');
    SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
    SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND OPF.ID = :IDOPF');
    SQL.Connection  := FWC.FDConnection;
    SQL.ParamByName('IDOPF').DataType   := ftInteger;
    SQL.ParamByName('IDOPF').AsInteger  := StrToIntDef(edCodigoOPF.Text, -1);
    SQL.Prepare;
    SQL.Open;

    if not SQL.IsEmpty then
      edDescOPF.Text         := SQL.Fields[0].AsString + ' - ' + SQL.Fields[2].AsString;

  finally
    FreeAndNil(SQL);
    FreeAndNil(OPF);
    FreeAndNil(FWC);
  end;
end;

end.
