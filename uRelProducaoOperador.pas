unit uRelProducaoOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst,
  frxDBSet, Datasnap.DBClient, System.DateUtils;

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
    CDS_DADOSRELATORIONUMERODELOTES: TIntegerField;
    CDS_DADOSRELATORIOUNIDADESSAIDA: TIntegerField;
    gbPeriodo: TGroupBox;
    Label1: TLabel;
    edDataInicial: TJvDateEdit;
    edDataFinal: TJvDateEdit;
    CDS_DADOSRELATORIOUNIDADESPORHORA: TIntegerField;
    CDS_DADOSRELATORIOQUANTIDADEDESCARTE: TIntegerField;
    CDS_DADOSRELATORIOUNIDADESENTRADA: TIntegerField;
    CDS_DADOSRELATORIOSEGUNDOSPRODUCAO: TIntegerField;
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
    procedure edCodigoVariedadeChange(Sender: TObject);
    procedure edCodigoVariedadeRightButtonClick(Sender: TObject);
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
  frmRelProducaoOperador: TfrmRelProducaoOperador;

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
  uBeanOPFinal_Estagio_Lote_E,
  uBeanVariedade;

procedure TfrmRelProducaoOperador.btRelatorioClick(Sender: TObject);
begin
  if btRelatorio.Tag = 0 then begin
    btRelatorio.Tag := 1;

    if edDataFinal.Date < edDataInicial.Date then begin
      DisplayMsg(MSG_WAR, 'Data Final n�o pode ser Menor que a Inicial, Verifique!');
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

procedure TfrmRelProducaoOperador.edCodigoOperadorChange(Sender: TObject);
begin
  edNomeOperador.Clear;
end;

procedure TfrmRelProducaoOperador.edCodigoOperadorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoOperadorRightButtonClick(nil);
end;

procedure TfrmRelProducaoOperador.edCodigoOperadorRightButtonClick(
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

procedure TfrmRelProducaoOperador.edCodigoVariedadeChange(Sender: TObject);
begin
  edNomeVariedade.Clear;
end;

procedure TfrmRelProducaoOperador.edCodigoVariedadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoVariedadeRightButtonClick(nil);
end;

procedure TfrmRelProducaoOperador.edCodigoVariedadeRightButtonClick(
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

procedure TfrmRelProducaoOperador.FormCreate(Sender: TObject);
begin
  CDS_DADOSRELATORIO.CreateDataSet;
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

  edDataInicial.Date  := Date;
  edDataFinal.Date    := Date;
end;

procedure TfrmRelProducaoOperador.Visualizar;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  ConsultaDesc : TFDQuery;
  OPFELS    : TOPFINAL_ESTAGIO_LOTE_S;
  OPFELE    : TOPFINAL_ESTAGIO_LOTE_E;
  OPFELI    : TOPFINAL_ESTAGIO_LOTE_INTERVALO;
  CQ        : TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE;
  SegundosUtilLote,
  I         : Integer;
  Hora,
  Minuto,
  Segundo,
  MiliSegundo : Word;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);
  ConsultaDesc := TFDQuery.Create(nil);
  OPFELS    := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
  OPFELE    := TOPFINAL_ESTAGIO_LOTE_E.Create(FWC);
  OPFELI    := TOPFINAL_ESTAGIO_LOTE_INTERVALO.Create(FWC);
  CQ        := TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE.Create(FWC);

  CDS_DADOSRELATORIO.DisableControls;
  CDS_DADOSRELATORIO.EmptyDataSet;

  try
    try

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('  OPFEL.ID AS IDLOTE,');
      Consulta.SQL.Add('  OPFEL.DATAHORAINICIO,');
      Consulta.SQL.Add('  OPFEL.DATAHORAFIM,');
      //Consulta.SQL.Add('  ((DATE_PART(''DAY'', OPFEL.DATAHORAFIM - OPFEL.DATAHORAINICIO) * 86400) +');
      //Consulta.SQL.Add('  (DATE_PART(''HOUR'', OPFEL.DATAHORAFIM - OPFEL.DATAHORAINICIO) * 3600) +');
      //Consulta.SQL.Add('  (DATE_PART(''MINUTE'', OPFEL.DATAHORAFIM - OPFEL.DATAHORAINICIO) * 60) +');
      //Consulta.SQL.Add('  (TRUNC(DATE_PART(''SECOND'', OPFEL.DATAHORAFIM - OPFEL.DATAHORAINICIO)))) AS SEGUNDOSPRODUCAO,');
      Consulta.SQL.Add('	U.ID AS CODIGOOPERADOR,');
      Consulta.SQL.Add('	U.NOME AS NOMEOPERADOR,');
      Consulta.SQL.Add('	P.ID AS CODIGOESPECIE,');
      Consulta.SQL.Add('	P.DESCRICAO AS DESCRICAOESPECIE,');
      Consulta.SQL.Add('	E.ID AS CODIGOESTAGIO,');
      Consulta.SQL.Add('	E.DESCRICAO AS DESCRICAOESTAGIO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      Consulta.SQL.Add('INNER JOIN USUARIO U ON (U.ID = OPFEL.USUARIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND CAST(OPFEL.DATAHORAINICIO AS DATE) BETWEEN :DATAI AND :DATAF');

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

      if Length(Trim(edNomeOperador.Text)) > 0 then begin
        Consulta.SQL.Add('AND U.ID = :IDUSUARIO');
        Consulta.ParamByName('IDUSUARIO').DataType  := ftInteger;
        Consulta.ParamByName('IDUSUARIO').Value     := StrToIntDef(edCodigoOperador.Text, 0);
      end;

      Consulta.SQL.Add('ORDER BY 1');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      if cbExibirSQL.Checked then
        ShowMessage('Relat�rio de Cadastro de Plantas!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin

        Consulta.First;
        while not Consulta.Eof do begin

          ConsultaDesc.Close;
          ConsultaDesc.SQL.Clear;
          ConsultaDesc.SQL.Add('SELECT');
          ConsultaDesc.SQL.Add('	COUNT(OPFELSQ.ID) AS QUANTIDADEDESCARTES');
          ConsultaDesc.SQL.Add('FROM OPFINAL_ESTAGIO_LOTE OPFEL');
          ConsultaDesc.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
          ConsultaDesc.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S_QUALIDADE OPFELSQ ON (OPFELSQ.ID_OPFINAL_ESTAGIO_LOTE_S = OPFELS.ID)');
          ConsultaDesc.SQL.Add('WHERE 1 = 1');
          ConsultaDesc.SQL.Add('AND OPFEL.ID = :IDLOTE');

          ConsultaDesc.Connection  := FWC.FDConnection;

          ConsultaDesc.ParamByName('IDLOTE').DataType := ftInteger;
          ConsultaDesc.ParamByName('IDLOTE').Value    := Consulta.FieldByName('IDLOTE').AsInteger;
          ConsultaDesc.Prepare;
          ConsultaDesc.Open;
          ConsultaDesc.FetchAll;

          //Tempo de Produ��o Total do lote em Segundos
          SegundosUtilLote := SecondsBetween(Consulta.FieldByName('DATAHORAINICIO').AsDateTime, Consulta.FieldByName('DATAHORAFIM').AsDateTime);

          //Descontar o Tempo parado do lote
          OPFELI.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + Consulta.FieldByName('IDLOTE').AsString);
          if OPFELI.Count > 0 then begin
            for I := 0 to OPFELI.Count - 1 do begin
              SegundosUtilLote := SegundosUtilLote - SecondsBetween(TOPFINAL_ESTAGIO_LOTE_INTERVALO(OPFELI.Itens[I]).DATAHORAENTRADA.Value, TOPFINAL_ESTAGIO_LOTE_INTERVALO(OPFELI.Itens[I]).DATAHORASAIDA.Value);
            end;
          end;

          OPFELS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + Consulta.FieldByName('IDLOTE').AsString);
          OPFELE.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + Consulta.FieldByName('IDLOTE').AsString);

          if CDS_DADOSRELATORIO.Locate('CODIGOOPERADOR;CODIGOESPECIE;CODIGOESTAGIO', VarArrayOf([Consulta.FieldByName('CODIGOOPERADOR').AsString, Consulta.FieldByName('CODIGOESPECIE').AsString, Consulta.FieldByName('CODIGOESTAGIO').AsString]), []) then begin
            CDS_DADOSRELATORIO.Edit;
            CDS_DADOSRELATORIONUMERODELOTES.Value             := CDS_DADOSRELATORIONUMERODELOTES.Value + 1;
            CDS_DADOSRELATORIOUNIDADESSAIDA.Value             := CDS_DADOSRELATORIOUNIDADESSAIDA.Value + OPFELS.Count;
            CDS_DADOSRELATORIOUNIDADESENTRADA.Value           := CDS_DADOSRELATORIOUNIDADESENTRADA.Value + OPFELE.Count;
            if not ConsultaDesc.IsEmpty then
              CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger  := CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger + ConsultaDesc.FieldByName('QUANTIDADEDESCARTES').AsInteger;
          end else begin

            CDS_DADOSRELATORIO.Append;
            CDS_DADOSRELATORIOCODIGOOPERADOR.Value    := Consulta.FieldByName('CODIGOOPERADOR').AsInteger;
            CDS_DADOSRELATORIONOMEOPERADOR.Value      := Consulta.FieldByName('NOMEOPERADOR').AsString;
            CDS_DADOSRELATORIOCODIGOESPECIE.Value     := Consulta.FieldByName('CODIGOESPECIE').AsInteger;
            CDS_DADOSRELATORIODESCRICAOESPECIE.Value  := Consulta.FieldByName('DESCRICAOESPECIE').AsString;
            CDS_DADOSRELATORIOCODIGOESTAGIO.Value     := Consulta.FieldByName('CODIGOESTAGIO').AsInteger;
            CDS_DADOSRELATORIODESCRICAOESTAGIO.Value  := Consulta.FieldByName('DESCRICAOESTAGIO').AsString;
            CDS_DADOSRELATORIONUMERODELOTES.Value     := 1;
            CDS_DADOSRELATORIOUNIDADESSAIDA.Value     := OPFELS.Count;
            CDS_DADOSRELATORIOUNIDADESENTRADA.Value   := OPFELE.Count;
            CDS_DADOSRELATORIOUNIDADESPORHORA.Value   := 0;
            CDS_DADOSRELATORIOQUANTIDADEDESCARTE.Value:= 0;

            if not ConsultaDesc.IsEmpty then
              CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger  := ConsultaDesc.FieldByName('QUANTIDADEDESCARTES').AsInteger;

            CDS_DADOSRELATORIOSEGUNDOSPRODUCAO.Value  := 0;

          end;

          //Soma os Minutos do Lote aos Minutos de Produ��o
          CDS_DADOSRELATORIOSEGUNDOSPRODUCAO.Value    := CDS_DADOSRELATORIOSEGUNDOSPRODUCAO.Value + SegundosUtilLote;

          //Calcula as unidades Produzidas por Hora
          if CDS_DADOSRELATORIOUNIDADESSAIDA.Value > 0 then
            if ((CDS_DADOSRELATORIOSEGUNDOSPRODUCAO.Value / 3600) > 0) then
              CDS_DADOSRELATORIOUNIDADESPORHORA.Value   := Trunc((CDS_DADOSRELATORIOUNIDADESSAIDA.Value / (CDS_DADOSRELATORIOSEGUNDOSPRODUCAO.Value / 3600)));

          CDS_DADOSRELATORIO.Post;

          Consulta.Next;
        end;

        CDS_DADOSRELATORIO.IndexFieldNames := 'CODIGOOPERADOR;CODIGOESPECIE;CODIGOESTAGIO';

        //Chama o Relat�rio para exibir os Dados
        DMUtil.frxDBDataset1.DataSet  := CDS_DADOSRELATORIO;
        RelParams.Clear;
        RelParams.Add('DATAI=' + edDataInicial.Text);
        RelParams.Add('DATAF=' + edDataFinal.Text);
        DMUtil.ImprimirRelatorio('frProducaoOperador.fr3');
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
    CDS_DADOSRELATORIO.EnableControls;
    FreeAndNil(CQ);
    FreeAndNil(OPFELI);
    FreeAndNil(OPFELS);
    FreeAndNil(OPFELE);
    FreeAndNil(Consulta);
    FreeAndNil(ConsultaDesc);
    FreeAndNil(FWC);
  end;
end;

end.
