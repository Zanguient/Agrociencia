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
    gbOpcoes: TGroupBox;
    cbMeioCultura: TCheckBox;
    cbProdutoFinal: TCheckBox;
    rgStatus: TRadioGroup;
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
  uDMUtil;

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

      Consulta.SQL.Add('SELECT SEMANA, TIPO, ID, CAST(DATAINICIO AS DATE), DESCRICAO FROM');
      Consulta.SQL.Add('(');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('  DATE_PART(''WEEK'', OPMC.DATAINICIO) AS SEMANA,');
      Consulta.SQL.Add('  ''ORDEM DE PRODUÇÃO DO MEIO DE CULTURA'' AS TIPO,');
      Consulta.SQL.Add('	OPMC.ID,');
      Consulta.SQL.Add('	OPMC.DATAINICIO,');
      Consulta.SQL.Add('	''Código MC.: '' || MC.CODIGO || ''   Volume Final.: '' || OPMC.QUANTPRODUTO || '' LT'' AS DESCRICAO');
      Consulta.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPMC.ID_PRODUTO)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = P.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPMC.DATAINICIO BETWEEN :DATAI AND :DATAF');

      if not cbMeioCultura.Checked then
        Consulta.SQL.Add('AND 1 = 2');

      case rgStatus.ItemIndex of
        0 : Consulta.SQL.Add('AND OPMC.ENCERRADO = True');
        1 : Consulta.SQL.Add('AND OPMC.ENCERRADO = False');
      end;

      Consulta.SQL.Add('UNION ALL');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	DATE_PART(''WEEK'', OPFE.PREVISAOINICIO) AS SEMANA,');
      Consulta.SQL.Add('	''ORDEM DE PRODUÇÃO DA PLANTA'' AS TIPO,');
      Consulta.SQL.Add('	OPFE.ID,');
      Consulta.SQL.Add('	OPFE.PREVISAOINICIO AS DATAINICIO,');
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

      if not cbProdutoFinal.Checked then
        Consulta.SQL.Add('AND 1 = 2');

      case rgStatus.ItemIndex of
        0 : Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NOT NULL');
        1 : Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      end;

      Consulta.SQL.Add(') AGENDA');
      Consulta.SQL.Add('ORDER BY SEMANA, TIPO, DATAINICIO');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := Consulta;
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
