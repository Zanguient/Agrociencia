unit uRelPosicaoEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst,
  frxDBSet, System.TypInfo;

type
  TfrmRelPosicaoEstoque = class(TForm)
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    cbExibirSQL: TCheckBox;
    gbPeriodo: TGroupBox;
    edData: TJvDateEdit;
    gbTipoProduto: TGroupBox;
    cbFinalidadeProduto: TComboBox;
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
  frmRelPosicaoEstoque: TfrmRelPosicaoEstoque;

implementation

{$R *.dfm}

uses
  uMensagem,
  uFWConnection,
  uBeanUsuario,
  uDMUtil,
  uConstantes;

procedure TfrmRelPosicaoEstoque.btRelatorioClick(Sender: TObject);
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

procedure TfrmRelPosicaoEstoque.btFecharClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmRelPosicaoEstoque.FecharTela;
begin
  if btRelatorio.Tag = 0 then
    Close;
end;

procedure TfrmRelPosicaoEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : FecharTela;
  end;
end;

procedure TfrmRelPosicaoEstoque.FormShow(Sender: TObject);
var
  X : TFinalidadeProduto;
begin
  cbFinalidadeProduto.Items.Clear;
  for X := Low(TFinalidadeProduto) to High(TFinalidadeProduto) do
    cbFinalidadeProduto.Items.Add(GetEnumName(TypeInfo(TFinalidadeProduto), Integer(X)));

  if cbFinalidadeProduto.Items.Count > 0 then
    cbFinalidadeProduto.ItemIndex  := 0;

  cbExibirSQL.Visible := DESIGNREL;

  edData.Date  := Date;
end;

procedure TfrmRelPosicaoEstoque.Visualizar;
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
      Consulta.SQL.Add('	P.ID AS CODIGOPRODUTO,');
      Consulta.SQL.Add('	P.DESCRICAO AS DESCRICAOPRODUTO,');
      Consulta.SQL.Add('	UM.SIMBOLO AS UNIDADEMEDIDA,');
      Consulta.SQL.Add('	COALESCE((SELECT');
      Consulta.SQL.Add('		SUM(CEP.QUANTIDADE)');
      Consulta.SQL.Add('	FROM CONTROLEESTOQUE CE INNER JOIN CONTROLEESTOQUEPRODUTO CEP ON (CEP.CONTROLEESTOQUE_ID = CE.ID AND CEP.PRODUTO_ID = P.ID)');
      Consulta.SQL.Add('	WHERE CE.CANCELADO = FALSE AND CAST(CE.DATAHORA AS DATE) <= :DATA), 0.00) AS QUANTIDADE');
      Consulta.SQL.Add('FROM PRODUTO P');
      Consulta.SQL.Add('INNER JOIN UNIDADEMEDIDA UM ON (UM.ID = P.UNIDADEMEDIDA_ID)');
      Consulta.SQL.Add('LEFT JOIN CONTROLEESTOQUEPRODUTO CEP ON (CEP.PRODUTO_ID = P.ID)');
      Consulta.SQL.Add('LEFT JOIN CONTROLEESTOQUE CE ON (CE.ID = CEP.CONTROLEESTOQUE_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATA').DataType  := ftDate;
      Consulta.ParamByName('DATA').Value     := edData.Date;

      if cbFinalidadeProduto.ItemIndex > 0 then
        Consulta.SQL.Add('AND P.FINALIDADE = ' + IntToStr(cbFinalidadeProduto.ItemIndex));

      Consulta.SQL.Add('GROUP BY 1, 2, 3');
      Consulta.SQL.Add('ORDER BY 1');

      if cbExibirSQL.Checked then
        ShowMessage('Relat�rio de Posi��o do Estoque!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet  := Consulta;
        RelParams.Clear;
        DMUtil.ImprimirRelatorio('frPosicaoEstoque.fr3');
      end else begin
        DisplayMsg(MSG_WAR, 'N�o h� dados para Exibir, Verifique os Filtros!');
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
