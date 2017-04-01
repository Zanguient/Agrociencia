unit uRelAgendaSemanal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB;

type
  TfrmRelAgendaSemanal = class(TForm)
    gbPeriodo: TGroupBox;
    edDataInicial: TJvDateEdit;
    edDataFinal: TJvDateEdit;
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    Label1: TLabel;
    rgStatus: TRadioGroup;
    cbExibirSQL: TCheckBox;
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
  frmRelAgendaSemanal: TfrmRelAgendaSemanal;

implementation

{$R *.dfm}

uses
  uMensagem,
  uFWConnection,
  uBeanUsuario,
  uDMUtil,
  uConstantes;

procedure TfrmRelAgendaSemanal.btRelatorioClick(Sender: TObject);
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

procedure TfrmRelAgendaSemanal.btFecharClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmRelAgendaSemanal.FecharTela;
begin
  if btRelatorio.Tag = 0 then
    Close;
end;

procedure TfrmRelAgendaSemanal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : FecharTela;
  end;
end;

procedure TfrmRelAgendaSemanal.FormShow(Sender: TObject);
begin
  cbExibirSQL.Visible := DESIGNREL;
  edDataInicial.Date  := Date;
  edDataFinal.Date    := Date;
end;

procedure TfrmRelAgendaSemanal.Visualizar;
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

      Consulta.SQL.Add('SELECT SEMANA, TIPO, ID, CAST(DATA AS DATE), DESCRICAO FROM');
      Consulta.SQL.Add('(');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('  DATE_PART(''WEEK'', OPMC.DATAINICIO) AS SEMANA,');
      Consulta.SQL.Add('  0 AS TIPO, --Meio de Cultura');
      Consulta.SQL.Add('	OPMC.ID,');
      Consulta.SQL.Add('	OPMC.DATAINICIO AS DATA,');
      Consulta.SQL.Add('	''Código MC.: '' || MC.CODIGO || ''   Volume Final.: '' || OPMC.QUANTPRODUTO || '' LT'' AS DESCRICAO');
      Consulta.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPMC.ID_PRODUTO)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = P.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPMC.DATAINICIO BETWEEN :DATAI AND :DATAF');

      case rgStatus.ItemIndex of
        0 : Consulta.SQL.Add('AND OPMC.ENCERRADO = True');
        1 : Consulta.SQL.Add('AND OPMC.ENCERRADO = False');
      end;

      Consulta.SQL.Add('UNION ALL');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	DATE_PART(''WEEK'', OPFE.PREVISAOINICIO) AS SEMANA,');
      Consulta.SQL.Add('	1 AS TIPO, --Iniciar OP');
      Consulta.SQL.Add('	OPFE.ID,');
      Consulta.SQL.Add('	OPFE.PREVISAOINICIO AS DATA,');
      Consulta.SQL.Add('	''Espécie.:   '' || P.DESCRICAO || ''   Estágio.: '' || E.DESCRICAO || ''   Codigo MCP.: '' || MC.CODIGO AS DESCRICAO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND OPFE.PREVISAOINICIO BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO_LOTE OPFEL WHERE OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');

      case rgStatus.ItemIndex of
        0 : Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NOT NULL');
        1 : Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      end;

      Consulta.SQL.Add('UNION ALL');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	DATE_PART(''WEEK'', OPFE.PREVISAOTERMINO) AS SEMANA,');
      Consulta.SQL.Add('	2 AS TIPO, --Gerar OP');
      Consulta.SQL.Add('	OPFE.ID,');
      Consulta.SQL.Add('	OPFE.PREVISAOTERMINO AS DATA,');
      Consulta.SQL.Add('	''Espécie.:   '' || P.DESCRICAO || ''   Estágio.: '' || E.DESCRICAO || ''   Codigo MCP.: '' || MC.CODIGO AS DESCRICAO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND OPFE.PREVISAOTERMINO BETWEEN :DATAI AND :DATAF');

      case rgStatus.ItemIndex of
        0 : Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NOT NULL');
        1 : Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      end;

      Consulta.SQL.Add('UNION ALL');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	DATE_PART(''WEEK'', OPF.DATAESTIMADAPROCESSAMENTO) AS SEMANA,');
      Consulta.SQL.Add('	3 AS TIPO, --Recebimento de Plantas');
      Consulta.SQL.Add('	OPF.ID,');
      Consulta.SQL.Add('	OPF.DATAESTIMADAPROCESSAMENTO AS DATA,');
      Consulta.SQL.Add('	''Espécie.:   '' || P.DESCRICAO || ''   Cliente.: '' || C.NOME AS DESCRICAO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
      Consulta.SQL.Add('AND OPF.DATAESTIMADAPROCESSAMENTO IS NOT NULL');
      Consulta.SQL.Add('AND OPF.DATAESTIMADAPROCESSAMENTO BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO OPFE WHERE OPFE.OPFINAL_ID = OPF.ID)');

      case rgStatus.ItemIndex of
        0 : Consulta.SQL.Add('AND OPF.DATAENCERRAMENTO IS NOT NULL');
        1 : Consulta.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
      end;

      Consulta.SQL.Add('UNION ALL');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	DATE_PART(''WEEK'', OPS.DATAPREVISAO) AS SEMANA,');
      Consulta.SQL.Add('	4 AS TIPO, --OP Solução Estoque');
      Consulta.SQL.Add('	OPS.ID,');
      Consulta.SQL.Add('	OPS.DATAPREVISAO AS DATA,');
      Consulta.SQL.Add('	''Solução.:   '' || P.DESCRICAO || ''   Quantidade.: '' || OPS.QUANTIDADE || '' '' || UN.SIMBOLO AS DESCRICAO');
      Consulta.SQL.Add('FROM ORDEMPRODUCAOSOLUCAO OPS');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPS.ID_PRODUTO)');
      Consulta.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON (UN.ID = P.UNIDADEMEDIDA_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND CAST(OPS.DATAPREVISAO AS DATE) BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('AND OPS.ENCERRADO = FALSE');

      Consulta.SQL.Add(') AGENDA');
      Consulta.SQL.Add('ORDER BY SEMANA, TIPO, DATA');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      if cbExibirSQL.Checked then
        ShowMessage('Relatório de Agenda Semanal!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := Consulta;
        RelParams.Clear;
        DMUtil.ImprimirRelatorio('frAgendaSemanal.fr3');
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
