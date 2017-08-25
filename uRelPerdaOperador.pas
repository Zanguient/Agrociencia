unit uRelPerdaOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst,
  frxDBSet, Datasnap.DBClient;

type
  TfrmRelPerdaOperador = class(TForm)
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    btRelatorio: TSpeedButton;
    Panel2: TPanel;
    btFechar: TSpeedButton;
    cbExibirSQL: TCheckBox;
    gbEspecie: TGroupBox;
    edCodigoEspecie: TButtonedEdit;
    edDescricaoEspecie: TEdit;
    gbOperador: TGroupBox;
    edCodigoOperador: TButtonedEdit;
    edNomeOperador: TEdit;
    gbEstagio: TGroupBox;
    edCodigoEstagio: TButtonedEdit;
    edDescricaoEstagio: TEdit;
    CDS_DADOSRELATORIO: TClientDataSet;
    CDS_DADOSRELATORIOCODIGOOPERADOR: TIntegerField;
    CDS_DADOSRELATORIONOMEOPERADOR: TStringField;
    CDS_DADOSRELATORIOCODIGOESPECIE: TIntegerField;
    CDS_DADOSRELATORIODESCRICAOESPECIE: TStringField;
    CDS_DADOSRELATORIOCODIGOESTAGIO: TIntegerField;
    CDS_DADOSRELATORIODESCRICAOESTAGIO: TStringField;
    CDS_DADOSRELATORIOUNIDADES: TIntegerField;
    gbPeriodo: TGroupBox;
    Label1: TLabel;
    edDataInicial: TJvDateEdit;
    edDataFinal: TJvDateEdit;
    CDS_DADOSRELATORIOCODIGOMOTIVO: TIntegerField;
    CDS_DADOSRELATORIODESCRICAOMOTIVO: TStringField;
    CDS_DADOSRELATORIOUNIDADESDESCARTE: TIntegerField;
    gbMotivo: TGroupBox;
    edCodigoMotivo: TButtonedEdit;
    edDescricaoMotivo: TEdit;
    CDS_DADOSRELATORIOESTACAOTRABALHO: TStringField;
    gbVariedade: TGroupBox;
    edCodigoVariedade: TButtonedEdit;
    edNomeVariedade: TEdit;
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btRelatorioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoOperadorChange(Sender: TObject);
    procedure edCodigoOperadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoOperadorRightButtonClick(Sender: TObject);
    procedure edCodigoEspecieChange(Sender: TObject);
    procedure edCodigoEspecieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEspecieRightButtonClick(Sender: TObject);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCodigoMotivoChange(Sender: TObject);
    procedure edCodigoMotivoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoMotivoRightButtonClick(Sender: TObject);
    procedure edCodigoVariedadeRightButtonClick(Sender: TObject);
    procedure edCodigoVariedadeChange(Sender: TObject);
    procedure edCodigoVariedadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Procedure FecharTela;
    Procedure Visualizar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelPerdaOperador: TfrmRelPerdaOperador;

implementation

{$R *.dfm}

uses
  uMensagem,
  uFWConnection,
  uBeanUsuario,
  uDMUtil,
  uConstantes,
  uBeanProdutos,
  uBeanEstagio,
  uBeanOPFinal_Estagio_Lote_S,
  uBeanOPFinal_Estagio_Lote_Intervalo,
  uBeanOPFinal_Estagio_Lote_S_Qualidade,
  uBeanMotivoDescarte,
  uBeanVariedade;

procedure TfrmRelPerdaOperador.btRelatorioClick(Sender: TObject);
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

procedure TfrmRelPerdaOperador.edCodigoOperadorChange(Sender: TObject);
begin
  edNomeOperador.Clear;
end;

procedure TfrmRelPerdaOperador.edCodigoOperadorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoOperadorRightButtonClick(nil);
end;

procedure TfrmRelPerdaOperador.edCodigoOperadorRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  U   : TUSUARIO;
begin
  FWC := TFWConnection.Create;
  U   := TUSUARIO.Create(FWC);

  try
    edCodigoOperador.Text := IntToStr(DMUtil.Selecionar(U, edCodigoOperador.Text));
    U.SelectList('id = ' + edCodigoOperador.Text);
    if U.Count = 1 then
      edNomeOperador.Text := TUSUARIO(U.Itens[0]).NOME.asString;
  finally
    FreeAndNil(U);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelPerdaOperador.edCodigoVariedadeChange(Sender: TObject);
begin
  edNomeVariedade.Clear;
end;

procedure TfrmRelPerdaOperador.edCodigoVariedadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoVariedadeRightButtonClick(nil);
end;

procedure TfrmRelPerdaOperador.edCodigoVariedadeRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  V   : TVARIEDADE;
begin
  FWC := TFWConnection.Create;
  V   := TVARIEDADE.Create(FWC);

  try
    if edDescricaoEspecie.Text <> EmptyStr then
      edCodigoVariedade.Text := IntToStr(DMUtil.Selecionar(V, edCodigoVariedade.Text, 'id_produto = ' + QuotedStr(edCodigoEspecie.Text) ))
    else
      edCodigoVariedade.Text := IntToStr(DMUtil.Selecionar(V, edCodigoVariedade.Text, '' ));

    V.SelectList('id = ' + edCodigoVariedade.Text);
    if V.Count = 1 then
      edNomeVariedade.Text := TVARIEDADE(V.Itens[0]).NOME.asString;
  finally
    FreeAndNil(V);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelPerdaOperador.edCodigoEspecieChange(Sender: TObject);
begin
  edDescricaoEspecie.Clear;
end;

procedure TfrmRelPerdaOperador.edCodigoEspecieKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoEspecieRightButtonClick(nil);
end;

procedure TfrmRelPerdaOperador.edCodigoEspecieRightButtonClick(
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

procedure TfrmRelPerdaOperador.edCodigoEstagioChange(Sender: TObject);
begin
  edDescricaoEstagio.Clear;
end;

procedure TfrmRelPerdaOperador.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoEstagioRightButtonClick(nil);
end;

procedure TfrmRelPerdaOperador.edCodigoEstagioRightButtonClick(
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

procedure TfrmRelPerdaOperador.edCodigoMotivoChange(Sender: TObject);
begin
  edDescricaoMotivo.Clear;
end;

procedure TfrmRelPerdaOperador.edCodigoMotivoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoMotivoRightButtonClick(nil);
end;

procedure TfrmRelPerdaOperador.edCodigoMotivoRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  M   : TMOTIVODESCARTE;
begin
  FWC := TFWConnection.Create;
  M   := TMOTIVODESCARTE.Create(FWC);

  try
    edCodigoMotivo.Text := IntToStr(DMUtil.Selecionar(M, edCodigoMotivo.Text));
    M.SelectList('id = ' + edCodigoMotivo.Text);
    if M.Count = 1 then
      edDescricaoMotivo.Text := TMOTIVODESCARTE(M.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(M);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmRelPerdaOperador.btFecharClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmRelPerdaOperador.FecharTela;
begin
  if btRelatorio.Tag = 0 then
    Close;
end;

procedure TfrmRelPerdaOperador.FormCreate(Sender: TObject);
begin
  CDS_DADOSRELATORIO.CreateDataSet;
end;

procedure TfrmRelPerdaOperador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : FecharTela;
  end;
end;

procedure TfrmRelPerdaOperador.FormShow(Sender: TObject);
begin
  cbExibirSQL.Visible := DESIGNREL;

  edDataInicial.Date  := Date;
  edDataFinal.Date    := Date;
end;

procedure TfrmRelPerdaOperador.Visualizar;
var
  FWC         : TFWConnection;
  Consulta    : TFDQuery;
  ConsultaAux : TFDQuery;
begin

  FWC         := TFWConnection.Create;
  Consulta    := TFDQuery.Create(nil);
  ConsultaAux := TFDQuery.Create(nil);

  CDS_DADOSRELATORIO.DisableControls;
  CDS_DADOSRELATORIO.EmptyDataSet;

  try
    try

      ConsultaAux.Close;
      ConsultaAux.SQL.Clear;
      ConsultaAux.SQL.Add('SELECT');
      ConsultaAux.SQL.Add('	COUNT(OPFELS.ID) AS UNIDADES');
      ConsultaAux.SQL.Add('FROM OPFINAL OPF');
      ConsultaAux.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      ConsultaAux.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      ConsultaAux.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
      ConsultaAux.SQL.Add('WHERE 1 = 1');
      ConsultaAux.SQL.Add('AND OPFEL.USUARIO_ID = :IDOPERADOR');
      ConsultaAux.SQL.Add('AND OPFEL.ESTACAOTRABALHO = :ESTACAOTRABALHO');
      ConsultaAux.SQL.Add('AND OPF.PRODUTO_ID = :IDESPECIE');
      ConsultaAux.SQL.Add('AND OPFE.ESTAGIO_ID = :IDESTAGIO');
      ConsultaAux.Connection  := FWC.FDConnection;
      ConsultaAux.ParamByName('IDOPERADOR').DataType      := ftInteger;
      ConsultaAux.ParamByName('ESTACAOTRABALHO').DataType := ftString;
      ConsultaAux.ParamByName('IDESPECIE').DataType       := ftInteger;
      ConsultaAux.ParamByName('IDESTAGIO').DataType       := ftInteger;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	U.ID AS CODIGOOPERADOR,');
      Consulta.SQL.Add('	U.NOME AS NOMEOPERADOR,');
      Consulta.SQL.Add('	OPFEL.ESTACAOTRABALHO,');
      Consulta.SQL.Add('	MD.ID AS CODIGOMOTIVO,');
      Consulta.SQL.Add('	MD.DESCRICAO AS DESCRICAOMOTIVO,');
      Consulta.SQL.Add('	P.ID AS CODIGOESPECIE,');
      Consulta.SQL.Add('	P.DESCRICAO AS DESCRICAOESPECIE,');
      Consulta.SQL.Add('	E.ID AS CODIGOESTAGIO,');
      Consulta.SQL.Add('	E.DESCRICAO AS DESCRICAOESTAGIO,');
      Consulta.SQL.Add('	COUNT(OPFELSQ.ID) AS UNIDADESDESCARTE');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S_QUALIDADE OPFELSQ ON (OPFELSQ.ID_OPFINAL_ESTAGIO_LOTE_S = OPFELS.ID)');
      Consulta.SQL.Add('INNER JOIN MOTIVODESCARTE MD ON (MD.ID = OPFELSQ.ID_MOTIVODESCARTE)');
      Consulta.SQL.Add('INNER JOIN USUARIO U ON (U.ID = OPFEL.USUARIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND CAST(OPFEL.DATAHORAINICIO AS DATE) BETWEEN :DATAI AND :DATAF');

      if Length(Trim(edNomeOperador.Text)) > 0 then begin
        Consulta.SQL.Add('AND U.ID = :IDUSUARIO');
        Consulta.ParamByName('IDUSUARIO').DataType  := ftInteger;
        Consulta.ParamByName('IDUSUARIO').Value     := StrToIntDef(edCodigoOperador.Text, 0);
      end;

      if Length(Trim(edDescricaoMotivo.Text)) > 0 then begin
        Consulta.SQL.Add('AND MD.ID = :IDMOTIVO');
        Consulta.ParamByName('IDMOTIVO').DataType  := ftInteger;
        Consulta.ParamByName('IDMOTIVO').Value     := StrToIntDef(edCodigoMotivo.Text, 0);
      end;

      if Length(Trim(edDescricaoEspecie.Text)) > 0 then begin
        Consulta.SQL.Add('AND P.ID = :IDESPECIE');
        Consulta.ParamByName('IDESPECIE').DataType  := ftInteger;
        Consulta.ParamByName('IDESPECIE').Value     := StrToIntDef(edCodigoEspecie.Text, 0);
      end;

      if Length(Trim(edNomeVariedade.Text)) > 0 then begin
        Consulta.SQL.Add('AND V.ID = :IDVARIEDADE');
        Consulta.ParamByName('IDVARIEDADE').DataType  := ftInteger;
        Consulta.ParamByName('IDVARIEDADE').Value     := StrToIntDef(edCodigoVariedade.Text, 0);
      end;

      if Length(Trim(edDescricaoEstagio.Text)) > 0 then begin
        Consulta.SQL.Add('AND E.ID = :IDESTAGIO');
        Consulta.ParamByName('IDESTAGIO').DataType  := ftInteger;
        Consulta.ParamByName('IDESTAGIO').Value     := StrToIntDef(edCodigoEstagio.Text, 0);
      end;

      Consulta.SQL.Add('GROUP BY 1, 2, 3, 4, 5, 6, 7 , 8, 9');
      Consulta.SQL.Add('ORDER BY 1, 2, 3, 4, 5');

      Consulta.Connection := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      if cbExibirSQL.Checked then
        ShowMessage('Relatório de Perda por Operador!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin

          ConsultaAux.Close;
          ConsultaAux.ParamByName('IDOPERADOR').AsInteger     := Consulta.FieldByName('CODIGOOPERADOR').AsInteger;
          ConsultaAux.ParamByName('ESTACAOTRABALHO').AsString := Consulta.FieldByName('ESTACAOTRABALHO').AsString;
          ConsultaAux.ParamByName('IDESPECIE').AsInteger      := Consulta.FieldByName('CODIGOESPECIE').AsInteger;
          ConsultaAux.ParamByName('IDESTAGIO').AsInteger      := Consulta.FieldByName('CODIGOESTAGIO').AsInteger;
          ConsultaAux.Open;

          CDS_DADOSRELATORIO.Append;
          CDS_DADOSRELATORIOCODIGOOPERADOR.Value    := Consulta.FieldByName('CODIGOOPERADOR').AsInteger;
          CDS_DADOSRELATORIONOMEOPERADOR.Value      := Consulta.FieldByName('NOMEOPERADOR').AsString;
          CDS_DADOSRELATORIOESTACAOTRABALHO.Value   := Consulta.FieldByName('ESTACAOTRABALHO').AsString;
          CDS_DADOSRELATORIOCODIGOMOTIVO.Value      := Consulta.FieldByName('CODIGOMOTIVO').AsInteger;
          CDS_DADOSRELATORIODESCRICAOMOTIVO.Value   := Consulta.FieldByName('DESCRICAOMOTIVO').AsString;
          CDS_DADOSRELATORIOCODIGOESPECIE.Value     := Consulta.FieldByName('CODIGOESPECIE').AsInteger;
          CDS_DADOSRELATORIODESCRICAOESPECIE.Value  := Consulta.FieldByName('DESCRICAOESPECIE').AsString;
          CDS_DADOSRELATORIOCODIGOESTAGIO.Value     := Consulta.FieldByName('CODIGOESTAGIO').AsInteger;
          CDS_DADOSRELATORIODESCRICAOESTAGIO.Value  := Consulta.FieldByName('DESCRICAOESTAGIO').AsString;
          CDS_DADOSRELATORIOUNIDADESDESCARTE.Value  := Consulta.FieldByName('UNIDADESDESCARTE').AsInteger;
          CDS_DADOSRELATORIOUNIDADES.Value          := 0;

          if not ConsultaAux.IsEmpty then
            CDS_DADOSRELATORIOUNIDADES.Value        := ConsultaAux.FieldByName('UNIDADES').AsInteger;

          CDS_DADOSRELATORIO.Post;
          Consulta.Next;
        end;

        CDS_DADOSRELATORIO.IndexFieldNames := 'CODIGOOPERADOR;ESTACAOTRABALHO;CODIGOMOTIVO;CODIGOESPECIE;CODIGOESTAGIO';

        //Chama o Relatório para exibir os Dados
        DMUtil.frxDBDataset1.DataSet  := CDS_DADOSRELATORIO;
        RelParams.Clear;
        RelParams.Add('DATAI=' + edDataInicial.Text);
        RelParams.Add('DATAF=' + edDataFinal.Text);
        DMUtil.ImprimirRelatorio('frPerdaOperador.fr3');
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
    CDS_DADOSRELATORIO.EnableControls;
    FreeAndNil(Consulta);
    FreeAndNil(ConsultaAux);
    FreeAndNil(FWC);
  end;
end;

end.
