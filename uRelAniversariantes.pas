unit uRelAniversariantes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst;

type
  TfrmRelAniversariantes = class(TForm)
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    cbExibirSQL: TCheckBox;
    chklistMes: TCheckListBox;
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btRelatorioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Procedure FecharTela;
    Procedure Visualizar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelAniversariantes: TfrmRelAniversariantes;

implementation

{$R *.dfm}

uses
  uMensagem,
  uFWConnection,
  uBeanUsuario,
  uDMUtil,
  uConstantes;

procedure TfrmRelAniversariantes.btRelatorioClick(Sender: TObject);
begin
  if btRelatorio.Tag = 0 then begin
    btRelatorio.Tag := 1;
    btRelatorio.Caption := 'Gerando...';
    Application.ProcessMessages;
    try

      Visualizar;

    finally
      btRelatorio.Tag := 0;
      btRelatorio.Caption := '&Visualizar';
      Application.ProcessMessages;
    end;
  end;
end;

procedure TfrmRelAniversariantes.btFecharClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmRelAniversariantes.FecharTela;
begin
  if btRelatorio.Tag = 0 then
    Close;
end;

procedure TfrmRelAniversariantes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : FecharTela;
  end;
end;

procedure TfrmRelAniversariantes.FormShow(Sender: TObject);
begin
  cbExibirSQL.Visible := DESIGNREL;
end;

procedure TfrmRelAniversariantes.Visualizar;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	MES,');
      Consulta.SQL.Add('	CASE WHEN MESEXTENSO = 1 THEN ''Janeiro''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 2 THEN ''Fevereiro''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 3 THEN ''Março''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 4 THEN ''Abril''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 5 THEN ''Maio''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 6 THEN ''Junho''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 7 THEN ''Julho''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 8 THEN ''Agosto''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 9 THEN ''Setembro''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 10 THEN ''Outubro''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 11 THEN ''Novembro''');
      Consulta.SQL.Add('	     WHEN MESEXTENSO = 12 THEN ''Dezembro'' END AS MESEXTENSO,');
      Consulta.SQL.Add('	DIA,');
      Consulta.SQL.Add('	TIPOCLIENTE,');
      Consulta.SQL.Add('	NOME,');
      Consulta.SQL.Add('	DATANASCIMENTO,');
      Consulta.SQL.Add('	EMAIL');
      Consulta.SQL.Add('FROM (');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	EXTRACT(MONTH FROM U.DATANASCIMENTO) AS MES,');
      Consulta.SQL.Add('	EXTRACT(MONTH FROM U.DATANASCIMENTO) AS MESEXTENSO,');
      Consulta.SQL.Add('	EXTRACT(DAY FROM U.DATANASCIMENTO) AS DIA,');
      Consulta.SQL.Add('	''Cliente Interno'' AS TIPOCLIENTE,');
      Consulta.SQL.Add('	U.NOME AS NOME,');
      Consulta.SQL.Add('	U.DATANASCIMENTO AS DATANASCIMENTO,');
      Consulta.SQL.Add('	U.EMAIL');
      Consulta.SQL.Add('FROM USUARIO U');
      Consulta.SQL.Add('UNION ALL');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	EXTRACT(MONTH FROM C.DATANASCIMENTO) AS MES,');
      Consulta.SQL.Add('	EXTRACT(MONTH FROM C.DATANASCIMENTO) AS MESEXTENSO,');
      Consulta.SQL.Add('	EXTRACT(DAY FROM C.DATANASCIMENTO) AS DIA,');
      Consulta.SQL.Add('	''Cliente Externo'' AS TIPOCLIENTE,');
      Consulta.SQL.Add('	C.NOME AS NOME,');
      Consulta.SQL.Add('	C.DATANASCIMENTO AS DATANASCIMENTO,');
      Consulta.SQL.Add('	C.EMAIL');
      Consulta.SQL.Add('FROM CLIENTE C');
      Consulta.SQL.Add(') AS ANIVERSARIANTES');
      Consulta.SQL.Add('ORDER BY MES, DIA, TIPOCLIENTE, NOME');

      Consulta.Connection                     := FWC.FDConnection;

      //Consulta.ParamByName('DATAI').DataType  := ftDate;
      //Consulta.ParamByName('DATAF').DataType  := ftDate;

      if cbExibirSQL.Checked then
        ShowMessage('Relatório de Aniversariantes!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := Consulta;
        DMUtil.ImprimirRelatorio('frAniversariantes.fr3');
      end else begin
        DisplayMsg(MSG_WAR, 'Não há dados para Exibir, Verifique os Filtros!');
        Exit;
      end;

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

end.
