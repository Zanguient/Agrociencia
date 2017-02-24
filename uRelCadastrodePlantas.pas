unit uRelCadastrodePlantas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst;

type
  TfrmRelCadastrodePlantas = class(TForm)
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    cbExibirSQL: TCheckBox;
    gbPeriodo: TGroupBox;
    Label1: TLabel;
    edDataInicial: TJvDateEdit;
    edDataFinal: TJvDateEdit;
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
  frmRelCadastrodePlantas: TfrmRelCadastrodePlantas;

implementation

{$R *.dfm}

uses
  uMensagem,
  uFWConnection,
  uBeanUsuario,
  uDMUtil,
  uConstantes;

procedure TfrmRelCadastrodePlantas.btRelatorioClick(Sender: TObject);
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

procedure TfrmRelCadastrodePlantas.btFecharClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmRelCadastrodePlantas.FecharTela;
begin
  if btRelatorio.Tag = 0 then
    Close;
end;

procedure TfrmRelCadastrodePlantas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : FecharTela;
  end;
end;

procedure TfrmRelCadastrodePlantas.FormShow(Sender: TObject);
begin
  cbExibirSQL.Visible := DESIGNREL;
end;

procedure TfrmRelCadastrodePlantas.Visualizar;
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
      Consulta.SQL.Add('	OPF.ID,');
      Consulta.SQL.Add('	CL.NOME AS NOMECLIENTE,');
      Consulta.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
      Consulta.SQL.Add('	OPF.QUANTIDADE,');
      Consulta.SQL.Add('	OPF.SELECAOPOSITIVA,');
      Consulta.SQL.Add('	OPF.CODIGOSELECAOCAMPO,');
      Consulta.SQL.Add('	OPF.ORIGEMMATERIAL,');
      Consulta.SQL.Add('	OPF.DATADECOLETA,');
      Consulta.SQL.Add('	OPF.COLETADOPOR,');
      Consulta.SQL.Add('	OPF.FAZENDAAREATALHAO,');
      Consulta.SQL.Add('	OPF.LOCALIZADOR,');
      Consulta.SQL.Add('	OPF.QUANTIDADEENVIADA,');
      Consulta.SQL.Add('	OPF.TRANSPORTADORA,');
      Consulta.SQL.Add('	OPF.DATADERECEBIMENTO,');
      Consulta.SQL.Add('	OPF.DATAESTIMADAPROCESSAMENTO,');
      Consulta.SQL.Add('	OPF.OBSERVACAO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN CLIENTE CL ON (CL.ID = OPF.CLIENTE_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND CAST(OPF.DATAHORA AS DATE) BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('ORDER BY OPF.ID');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      if cbExibirSQL.Checked then
        ShowMessage('Relatório de Cadastro de Plantas!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := Consulta;
        DMUtil.ImprimirRelatorio('frCadastrodePlantas.fr3');
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
