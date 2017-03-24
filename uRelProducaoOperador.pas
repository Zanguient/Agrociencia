unit uRelProducaoOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst,
  frxDBSet;

type
  TfrmRelProducaoOperador = class(TForm)
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    cbExibirSQL: TCheckBox;
    gbEspecie: TGroupBox;
    edCodigoEspecie: TButtonedEdit;
    edDescricaoEspecie: TEdit;
    gbCliente: TGroupBox;
    edCodigoCliente: TButtonedEdit;
    edNomeCliente: TEdit;
    gbEstagio: TGroupBox;
    edCodigoEstagio: TButtonedEdit;
    edDescricaoEstagio: TEdit;
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btRelatorioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoClienteChange(Sender: TObject);
    procedure edCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoClienteRightButtonClick(Sender: TObject);
    procedure edCodigoEspecieChange(Sender: TObject);
    procedure edCodigoEspecieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEspecieRightButtonClick(Sender: TObject);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
  private
    Procedure FecharTela;
    Procedure Visualizar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProducaoOperador: TfrmRelProducaoOperador;

implementation

{$R *.dfm}

uses
  uMensagem,
  uFWConnection,
  uBeanUsuario,
  uDMUtil,
  uConstantes,
  uBeanCliente,
  uBeanProdutos, uBeanEstagio;

procedure TfrmRelProducaoOperador.btRelatorioClick(Sender: TObject);
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

procedure TfrmRelProducaoOperador.edCodigoClienteChange(Sender: TObject);
begin
  edNomeCliente.Clear;
end;

procedure TfrmRelProducaoOperador.edCodigoClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoClienteRightButtonClick(nil);
end;

procedure TfrmRelProducaoOperador.edCodigoClienteRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  C   : TCLIENTE;
begin
  FWC := TFWConnection.Create;
  C   := TCLIENTE.Create(FWC);

  try
    edCodigoCliente.Text := IntToStr(DMUtil.Selecionar(C, edCodigoCliente.Text));
    C.SelectList('id = ' + edCodigoCliente.Text);
    if C.Count = 1 then
      edNomeCliente.Text := TCLIENTE(C.Itens[0]).NOME.asString;
  finally
    FreeAndNil(C);
    FreeAndNil(FWC);
  end;

end;

procedure TfrmRelProducaoOperador.edCodigoEspecieChange(Sender: TObject);
begin
  edDescricaoEspecie.Clear;
end;

procedure TfrmRelProducaoOperador.edCodigoEspecieKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoEspecieRightButtonClick(nil);
end;

procedure TfrmRelProducaoOperador.edCodigoEspecieRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin
  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  try
    edCodigoEspecie.Text := IntToStr(DMUtil.Selecionar(P, edCodigoEspecie.Text, 'finalidade = ' + IntToStr(Integer(eProdutoFinal)) ));
    P.SelectList('id = ' + edCodigoEspecie.Text);
    if P.Count = 1 then
      edDescricaoEspecie.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelProducaoOperador.edCodigoEstagioChange(Sender: TObject);
begin
  edDescricaoEstagio.Clear;
end;

procedure TfrmRelProducaoOperador.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoEstagioRightButtonClick(nil);
end;

procedure TfrmRelProducaoOperador.edCodigoEstagioRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin
  FWC := TFWConnection.Create;
  E   := TESTAGIO.Create(FWC);

  try
    edCodigoEstagio.Text := IntToStr(DMUtil.Selecionar(E, edCodigoEstagio.Text, ''));
    E.SelectList('id = ' + edCodigoEstagio.Text);
    if E.Count = 1 then
      edDescricaoEstagio.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelProducaoOperador.btFecharClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmRelProducaoOperador.FecharTela;
begin
  if btRelatorio.Tag = 0 then
    Close;
end;

procedure TfrmRelProducaoOperador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : FecharTela;
  end;
end;

procedure TfrmRelProducaoOperador.FormShow(Sender: TObject);
begin
  cbExibirSQL.Visible := DESIGNREL;
end;

procedure TfrmRelProducaoOperador.Visualizar;
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
      Consulta.SQL.Add('	OPF.ID AS NUMEROCADASTRO,');
      Consulta.SQL.Add('	P.DESCRICAO || '' - '' || OPF.ID AS ESPECIE,');
      Consulta.SQL.Add('	CL.NOME AS NOMECLIENTE,');
      Consulta.SQL.Add('	E.DESCRICAO AS ESTAGIO,');
      Consulta.SQL.Add('	OPFEL.NUMEROLOTE AS NUMERLOTE,');
      Consulta.SQL.Add('	COUNT(OPFELS.ID) AS UNIDADES');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN CLIENTE CL ON (CL.ID = OPF.CLIENTE_ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID AND OPFELS.BAIXADO = FALSE)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');

      if Length(Trim(edDescricaoEspecie.Text)) > 0 then begin
        Consulta.SQL.Add('AND P.ID = :IDESPECIE');
        Consulta.ParamByName('IDESPECIE').DataType  := ftInteger;
        Consulta.ParamByName('IDESPECIE').Value     := StrToIntDef(edCodigoEspecie.Text, 0);
      end;

      if Length(Trim(edDescricaoEstagio.Text)) > 0 then begin
        Consulta.SQL.Add('AND OPFE.ESTAGIO_ID = :IDESTAGIO');
        Consulta.ParamByName('IDESTAGIO').DataType  := ftInteger;
        Consulta.ParamByName('IDESTAGIO').Value     := StrToIntDef(edCodigoEstagio.Text, 0);
      end;

      if Length(Trim(edNomeCliente.Text)) > 0 then begin
        Consulta.SQL.Add('AND CL.ID = :IDCLIENTE');
        Consulta.ParamByName('IDCLIENTE').DataType  := ftInteger;
        Consulta.ParamByName('IDCLIENTE').Value     := StrToIntDef(edCodigoCliente.Text, 0);
      end;

      Consulta.SQL.Add('GROUP BY 1, 2, 3, 4, 5');
      Consulta.SQL.Add('ORDER BY 1, 4, 5, 6');

      Consulta.Connection                     := FWC.FDConnection;

      if cbExibirSQL.Checked then
        ShowMessage('Relatório de Cadastro de Plantas!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet  := Consulta;
        DMUtil.ImprimirRelatorio('frProducaoOperador.fr3');
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
