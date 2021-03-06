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
    rgOpcoes: TRadioGroup;
    procedure edCodigoOPFRightButtonClick(Sender: TObject);
    procedure edCodigoOPFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoOPFChange(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btRelatorioClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure RelProducaoOPDetalhado;
    procedure RelProducaoOPResumido;
    { Private declarations }
  public
    { Public declarations }
    procedure SelecionaOP;
  end;

var
  frmRelProducaoOP: TfrmRelProducaoOP;

implementation

uses
  uDMUtil, uFWConnection, uBeanOPFinal, uMensagem, uConstantes, uFuncoes;

{$R *.dfm}

procedure TfrmRelProducaoOP.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelProducaoOP.btRelatorioClick(Sender: TObject);
begin

  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;

    try
      if StrToIntDef(edCodigoOPF.Text, -1) <= 0 then begin
        DisplayMsg(MSG_WAR, 'Selecione uma Ordem de Produ��o!');
        if edCodigoOPF.CanFocus then edCodigoOPF.SetFocus;
        Exit;
      end;

      case rgOpcoes.ItemIndex of
        0 : RelProducaoOPDetalhado;
        1 : RelProducaoOPResumido;
      end;

    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
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
  SelecionaOP;
end;

procedure TfrmRelProducaoOP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRelProducaoOP.RelProducaoOPDetalhado;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  ConsultaI : TFDQuery;
  FR        : TfrxDBDataset;
  FRI       : TfrxDBDataset;
begin

  FWC := TFWConnection.Create;
  Consulta := TFDQuery.Create(nil);
  ConsultaI := TFDQuery.Create(nil);
  FR := TfrxDBDataset.Create(nil);
  FRI := TfrxDBDataset.Create(nil);
  try
    try
      Consulta.Close;
      Consulta.SQL.Clear;

      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('OP.ID,');
      Consulta.SQL.Add('CL.NOME AS NOMECLIENTE,');
      Consulta.SQL.Add('PR.DESCRICAO AS PRODUTO,');
      Consulta.SQL.Add('V.NOME AS CULTIVAR,');
      Consulta.SQL.Add('OPE.SEQUENCIAESTAGIO || '' - '' || E.DESCRICAO AS ESTAGIO,');
      Consulta.SQL.Add('CAST(OPEL.DATAHORAINICIO AS DATE) AS DATAI,');
      Consulta.SQL.Add('CAST(OPE.PREVISAOTERMINO AS DATE) AS DATAF,');
      Consulta.SQL.Add('OPEL.NUMEROLOTE,');
      Consulta.SQL.Add('(SELECT COUNT(*) FROM OPFINAL_ESTAGIO_LOTE_S OPELS WHERE OPELS.OPFINAL_ESTAGIO_LOTE_ID = OPEL.ID) AS UNIDADESPRODUZIDAS,');
      Consulta.SQL.Add('(SELECT COUNT(*) FROM OPFINAL_ESTAGIO_LOTE_S OPELS WHERE OPELS.OPFINAL_ESTAGIO_LOTE_ID = OPEL.ID AND NOT OPELS.BAIXADO) AS SALDOUNIDADES,');
      Consulta.SQL.Add('(SELECT COUNT(*) FROM OPFINAL_ESTAGIO_LOTE_S OPELS INNER JOIN OPFINAL_ESTAGIO_LOTE_S_QUALIDADE OPELSQ ON OPELS.ID = OPELSQ.ID_OPFINAL_ESTAGIO_LOTE_S WHERE OPELS.OPFINAL_ESTAGIO_LOTE_ID = OPEL.ID) AS UNIDADESDESCARTADAS');
      Consulta.SQL.Add('FROM OPFINAL OP');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (OP.ID_VARIEDADE = V.ID)');
      Consulta.SQL.Add('INNER JOIN CLIENTE CL ON OP.CLIENTE_ID = CL.ID');
      Consulta.SQL.Add('INNER JOIN PRODUTO PR ON OP.PRODUTO_ID = PR.ID');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPE ON OP.ID = OPE.OPFINAL_ID');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON OPE.ESTAGIO_ID = E.ID');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPEL ON OPEL.OPFINAL_ESTAGIO_ID = OPE.ID');
      Consulta.SQL.Add('WHERE OP.ID = :ID');
      Consulta.SQL.Add('ORDER BY OPE.DATAHORAINICIO, E.ID, OPE.SEQUENCIAESTAGIO, OPEL.NUMEROLOTE');

      Consulta.Connection := FWC.FDConnection;
      Consulta.Transaction := FWC.FDTransaction;

      Consulta.ParamByName('ID').AsInteger := StrToInt(edCodigoOPF.Text);
      Consulta.Open();

      ConsultaI.Close;
      ConsultaI.SQL.Clear;
      ConsultaI.SQL.Add('SELECT');
      ConsultaI.SQL.Add('OP.SEQUENCIA,');
      ConsultaI.SQL.Add('E.DESCRICAO AS ESTAGIO,');
      ConsultaI.SQL.Add('OPEL.NUMEROLOTE,');
      ConsultaI.SQL.Add(':DIRIMAGEM || I.NOMEIMAGEM AS IMAGEM');
      ConsultaI.SQL.Add('FROM OPFINAL_ESTAGIO OP');
      ConsultaI.SQL.Add('INNER JOIN ESTAGIO E ON OP.ESTAGIO_ID = E.ID');
      ConsultaI.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPEL ON OP.ID = OPEL.OPFINAL_ESTAGIO_ID');
      ConsultaI.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPELS ON OPEL.ID = OPELS.OPFINAL_ESTAGIO_LOTE_ID');
      ConsultaI.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S_POSITIVO OPELSP ON OPELS.ID = OPELSP.ID_OPFINAL_ESTAGIO_LOTE_S');
      ConsultaI.SQL.Add('INNER JOIN IMAGEM I ON OPELSP.ID_IMAGEM = I.ID');
      ConsultaI.SQL.Add('WHERE OP.OPFINAL_ID = :ID');
      ConsultaI.SQL.Add('ORDER BY OP.SEQUENCIA');

      ConsultaI.Connection := FWC.FDConnection;
      ConsultaI.Transaction := FWC.FDTransaction;

      ConsultaI.ParamByName('ID').AsInteger := StrToInt(edCodigoOPF.Text);
      ConsultaI.ParamByName('DIRIMAGEM').AsString := CONFIG_LOCAL.DirImagens;
      ConsultaI.Open();


      FR.DataSet := Consulta;
      FR.UserName := 'ORDEMPRODUCAO';

      FRI.DataSet := ConsultaI;
      FRI.UserName := 'IMAGENS';

      RelParams.Clear;
      DMUtil.ImprimirRelatorio('frProducaoporOPDetalhado.fr3');
    except
      on E : exception do
        DisplayMsg(MSG_WAR, 'Erro ao gerar relat�rio Detalhado', '', E.Message);
    end;
  finally
    FreeAndNil(Consulta);
    FreeAndNil(ConsultaI);
    FreeAndNil(FR);
    FreeAndNil(FRI);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelProducaoOP.RelProducaoOPResumido;
var
  FWC     : TFWConnection;
  SQL     : TFDQuery;
  SQLI    : TFDQuery;
  SQLOP   : TFDQuery;
  FR      : TfrxDBDataset;
  FRI     : TfrxDBDataset;
begin

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  SQLI:= TFDQuery.Create(nil);
  SQLOP:= TFDQuery.Create(nil);
  FR  := TfrxDBDataset.Create(nil);
  FRI := TfrxDBDataset.Create(nil);

  try
    try

      FWC.StartTransaction;

      SQL.Connection := FWC.FDConnection;
      SQL.Transaction := FWC.FDTransaction;

      SQLI.Connection := FWC.FDConnection;
      SQLI.Transaction := FWC.FDTransaction;

      SQLOP.Connection := FWC.FDConnection;
      SQLOP.Transaction := FWC.FDTransaction;

      SQLOP.Close;
      SQLOP.SQL.Clear;
      SQLOP.SQL.Add('SELECT');
      SQLOP.SQL.Add('	OP.ID,');
      SQLOP.SQL.Add('	CL.NOME AS NOMECLIENTE,');
      SQLOP.SQL.Add('	PR.DESCRICAO AS PRODUTO,');
      SQLOP.SQL.Add('	V.NOME AS CULTIVAR');
      SQLOP.SQL.Add('FROM OPFINAL OP');
      SQLOP.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OP.ID_VARIEDADE)');
      SQLOP.SQL.Add('INNER JOIN CLIENTE CL ON (CL.ID = OP.CLIENTE_ID)');
      SQLOP.SQL.Add('INNER JOIN PRODUTO PR ON (PR.ID = OP.PRODUTO_ID)');
      SQLOP.SQL.Add('WHERE OP.ID = :IDOPFINAL');

      SQLOP.ParamByName('IDOPFINAL').AsInteger :=  StrToInt(edCodigoOPF.Text);

      SQLOP.Open;

      CarregaSQLRealizado(SQL);

      SQL.ParamByName('IDOPFINAL').AsInteger :=  StrToInt(edCodigoOPF.Text);

      SQL.Open;

      SQLI.Close;
      SQLI.SQL.Clear;
      SQLI.SQL.Add('SELECT');
      SQLI.SQL.Add('  :DIRIMAGEM || I.NOMEIMAGEM AS IMAGEM');
      SQLI.SQL.Add('FROM OPFINAL_ESTAGIO OP');
      SQLI.SQL.Add('INNER JOIN ESTAGIO E ON OP.ESTAGIO_ID = E.ID');
      SQLI.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPEL ON OP.ID = OPEL.OPFINAL_ESTAGIO_ID');
      SQLI.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPELS ON OPEL.ID = OPELS.OPFINAL_ESTAGIO_LOTE_ID');
      SQLI.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S_POSITIVO OPELSP ON OPELS.ID = OPELSP.ID_OPFINAL_ESTAGIO_LOTE_S');
      SQLI.SQL.Add('INNER JOIN IMAGEM I ON OPELSP.ID_IMAGEM = I.ID');
      SQLI.SQL.Add('WHERE OP.OPFINAL_ID = :IDOPFINAL');
      SQLI.SQL.Add('ORDER BY I.ID');

      SQLI.ParamByName('DIRIMAGEM').AsString := CONFIG_LOCAL.DirImagens;
      SQLI.ParamByName('IDOPFINAL').AsInteger :=  StrToInt(edCodigoOPF.Text);

      SQLI.Open;

      DMUtil.frxDBDataset1.DataSet := SQL;
      DMUtil.frxDBDataset1.UserName := 'OP';

      FR.DataSet := SQLOP;
      FR.UserName:= 'ORDEMPRODUCAO';

      FRI.DataSet := SQLI;
      FRI.UserName:= 'OPI';

      RelParams.Clear;

      DMUtil.ImprimirRelatorio('frProducaoporOPResumido.fr3');

    except
      on E : exception do
        DisplayMsg(MSG_WAR, 'Erro ao gerar relat�rio Resumido', '', E.Message);
    end;
  finally
    FreeAndNil(FR);
    FreeAndNil(FRI);
    FreeAndNil(SQL);
    FreeAndNil(SQLI);
    FreeAndNil(SQLOP);
    FreeAndNil(FWC);
  end;
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
