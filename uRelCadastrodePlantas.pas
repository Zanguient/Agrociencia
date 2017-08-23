unit uRelCadastrodePlantas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst,
  frxDBSet;

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
    gbProduto: TGroupBox;
    edCodigoProduto: TButtonedEdit;
    edNomeProduto: TEdit;
    gbCliente: TGroupBox;
    edCodigoCliente: TButtonedEdit;
    edNomeCliente: TEdit;
    gbRecebimentoPlanta: TGroupBox;
    edCodigoOPF: TButtonedEdit;
    edDescricaoOPF: TEdit;
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btRelatorioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoClienteChange(Sender: TObject);
    procedure edCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoClienteRightButtonClick(Sender: TObject);
    procedure edCodigoProdutoChange(Sender: TObject);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoProdutoRightButtonClick(Sender: TObject);
    procedure edCodigoOPFChange(Sender: TObject);
    procedure edCodigoOPFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoOPFRightButtonClick(Sender: TObject);
  private
    Procedure FecharTela;
    Procedure Visualizar;
    procedure BuscaOPF;
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
  uConstantes,
  uBeanCliente,
  uBeanProdutos;

procedure TfrmRelCadastrodePlantas.btRelatorioClick(Sender: TObject);
begin
  if btRelatorio.Tag = 0 then begin
    btRelatorio.Tag := 1;

    if edDataFinal.Date < edDataInicial.Date then begin
      DisplayMsg(MSG_WAR, 'Data Final não pode ser Menor que a Inicial, Verifique!');
      if edDataInicial.CanFocus then
        edDataInicial.SetFocus;
      Exit;
    end;

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

procedure TfrmRelCadastrodePlantas.BuscaOPF;
var
  FWC     : TFWConnection;
  SQL     : TFDQuery;
  Filtro  : string;
begin

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);

  try

    Filtro := 'DATAENCERRAMENTO IS NULL AND CANCELADO = False';

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
      edDescricaoOPF.Text := SQL.Fields[0].AsString;

  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelCadastrodePlantas.edCodigoClienteChange(Sender: TObject);
begin
  edNomeCliente.Clear;
end;

procedure TfrmRelCadastrodePlantas.edCodigoClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoClienteRightButtonClick(nil);
end;

procedure TfrmRelCadastrodePlantas.edCodigoClienteRightButtonClick(
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

procedure TfrmRelCadastrodePlantas.edCodigoProdutoChange(Sender: TObject);
begin
  edNomeProduto.Clear;
end;

procedure TfrmRelCadastrodePlantas.edCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoProdutoRightButtonClick(nil);
end;

procedure TfrmRelCadastrodePlantas.edCodigoProdutoRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin
  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  try
    edCodigoProduto.Text := IntToStr(DMUtil.Selecionar(P, edCodigoProduto.Text, 'finalidade = ' + IntToStr(Integer(eProdutoFinal)) ));
    P.SelectList('id = ' + edCodigoProduto.Text);
    if P.Count = 1 then
      edNomeProduto.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelCadastrodePlantas.edCodigoOPFChange(
  Sender: TObject);
begin
  edDescricaoOPF.Clear;
end;

procedure TfrmRelCadastrodePlantas.edCodigoOPFKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoOPFRightButtonClick(nil)
end;

procedure TfrmRelCadastrodePlantas.edCodigoOPFRightButtonClick(Sender: TObject);
begin
  edCodigoOPF.Text := IntToStr(DMUtil.SelecionarCadastroPlantas(edCodigoOPF.Text));
  BuscaOPF;
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

  edDataInicial.Date  := Date;
  edDataFinal.Date    := Date + 7;
end;

procedure TfrmRelCadastrodePlantas.Visualizar;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  ConsultaI : TFDQuery;
  FR        : TfrxDBDataset;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);
  ConsultaI := TFDQuery.Create(nil);
  FR        := TfrxDBDataset.Create(nil);

  try
    try

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPF.ID,');
      Consulta.SQL.Add('	CL.NOME AS NOMECLIENTE,');
      Consulta.SQL.Add('	P.DESCRICAO AS DESCRICAOESPECIE,');
      Consulta.SQL.Add('	V.NOME AS VARIEDADE,');
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
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('WHERE 1 = 1');

      Consulta.Connection := FWC.FDConnection;

      //Se for Recebimento de Planta não Aplicar Outro Filtro
      if Length(Trim(edDescricaoOPF.Text)) > 0 then begin
          Consulta.SQL.Add('AND OPF.ID = :IDOPF');
          Consulta.ParamByName('IDOPF').DataType  := ftInteger;
          Consulta.ParamByName('IDOPF').Value     := StrToIntDef(edCodigoOPF.Text, 0);
      end else begin
        Consulta.SQL.Add('AND CAST(OPF.DATAHORA AS DATE) BETWEEN :DATAI AND :DATAF');
        Consulta.ParamByName('DATAI').DataType  := ftDate;
        Consulta.ParamByName('DATAF').DataType  := ftDate;
        Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
        Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

        if Length(Trim(edNomeCliente.Text)) > 0 then begin
          Consulta.SQL.Add('AND CL.ID = :IDCLIENTE');
          Consulta.ParamByName('IDCLIENTE').DataType  := ftInteger;
          Consulta.ParamByName('IDCLIENTE').Value     := StrToIntDef(edCodigoCliente.Text, 0);
        end;

        if Length(Trim(edNomeProduto.Text)) > 0 then begin
          Consulta.SQL.Add('AND P.ID = :IDPRODUTO');
          Consulta.ParamByName('IDPRODUTO').DataType  := ftInteger;
          Consulta.ParamByName('IDPRODUTO').Value     := StrToIntDef(edCodigoProduto.Text, 0);
        end;
      end;

      Consulta.SQL.Add('ORDER BY OPF.ID');

      if cbExibirSQL.Checked then
        ShowMessage('Relatório de Cadastro de Plantas!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin

        ConsultaI.Close;
        ConsultaI.SQL.Clear;
        ConsultaI.SQL.Add('SELECT');
        ConsultaI.SQL.Add(' OPF.ID AS ID_OPFINAL,');
        ConsultaI.SQL.Add(' :DIRIMAGENS || I.NOMEIMAGEM AS IMAGEM ');
        ConsultaI.SQL.Add('FROM OPFINAL OPF');
        ConsultaI.SQL.Add('INNER JOIN OPFINAL_IMAGEM OPFI ON (OPFI.ID_OPFINAL = OPF.ID)');
        ConsultaI.SQL.Add('INNER JOIN IMAGEM I ON (I.ID = OPFI.ID_IMAGEM)');
        ConsultaI.SQL.Add('WHERE 1 = 1');
        ConsultaI.SQL.Add('AND CAST(OPF.DATAHORA AS DATE) BETWEEN :DATAI AND :DATAF');

        ConsultaI.Connection                     := FWC.FDConnection;

        ConsultaI.ParamByName('DIRIMAGENS').DataType  := ftString;
        ConsultaI.ParamByName('DATAI').DataType       := ftDate;
        ConsultaI.ParamByName('DATAF').DataType       := ftDate;
        ConsultaI.ParamByName('DIRIMAGENS').Value     := CONFIG_LOCAL.DirImagens;
        ConsultaI.ParamByName('DATAI').Value          := edDataInicial.Date;
        ConsultaI.ParamByName('DATAF').Value          := edDataFinal.Date;

        ConsultaI.Prepare;
        ConsultaI.Open;
        ConsultaI.FetchAll;

        DMUtil.frxDBDataset1.DataSet  := Consulta;
        FR.UserName                   := 'OPFINAL_IMAGENS';
        FR.DataSet                    := ConsultaI;
        RelParams.Clear;
        RelParams.Add('DATAI=' + edDataInicial.Text);
        RelParams.Add('DATAF=' + edDataFinal.Text);
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
    FreeAndNil(ConsultaI);
    FreeAndNil(Consulta);
    FreeAndNil(FR);
    FreeAndNil(FWC);
  end;
end;

end.
