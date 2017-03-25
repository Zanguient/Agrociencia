unit uRelProducaoOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, FireDAC.Comp.Client, Data.DB, Vcl.CheckLst,
  frxDBSet, Datasnap.DBClient;

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
    CDS_DADOSRELATORIOTEMPOUTILPRODUCAO: TTimeField;
    CDS_DADOSRELATORIOUNIDADES: TIntegerField;
    gbPeriodo: TGroupBox;
    Label1: TLabel;
    edDataInicial: TJvDateEdit;
    edDataFinal: TJvDateEdit;
    CDS_DADOSRELATORIOUNIDADESPORHORA: TIntegerField;
    CDS_DADOSRELATORIODESCARTE: TStringField;
    CDS_DADOSRELATORIOQUANTIDADEDESCARTE: TIntegerField;
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
  uBeanOPFinal_Estagio_Lote_S_Qualidade;

procedure TfrmRelProducaoOperador.btRelatorioClick(Sender: TObject);
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
  OPFELI    : TOPFINAL_ESTAGIO_LOTE_INTERVALO;
  CQ        : TOPFINAL_ESTAGIO_LOTE_S_QUALIDADE;
  TempoUtil : TTime;
  I,
  MinProd   : Integer;
  Hora,
  Minuto,
  Segundo,
  MiliSegundo : Word;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);
  ConsultaDesc := TFDQuery.Create(nil);
  OPFELS    := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
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
      Consulta.SQL.Add('CAST((OPFEL.DATAHORAFIM - OPFEL.DATAHORAINICIO) AS TIME) AS TEMPOPRODUCAO,');
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
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND CAST(OPFEL.DATAHORAINICIO AS DATE) BETWEEN :DATAI AND :DATAF');

      if Length(Trim(edDescricaoEspecie.Text)) > 0 then begin
        Consulta.SQL.Add('AND P.ID = :IDESPECIE');
        Consulta.ParamByName('IDESPECIE').DataType  := ftInteger;
        Consulta.ParamByName('IDESPECIE').Value     := StrToIntDef(edCodigoEspecie.Text, 0);
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
        ShowMessage('Relatório de Cadastro de Plantas!' + sLineBreak + sLineBreak + Consulta.SQL.Text);

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

          //Tempo de Produção Total do lote
          TempoUtil := Consulta.FieldByName('TEMPOPRODUCAO').AsDateTime;

          //Descontar o Tempo parado do lote
          OPFELI.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + Consulta.FieldByName('IDLOTE').AsString);
          if OPFELI.Count > 0 then begin
            for I := 0 to OPFELI.Count - 1 do begin
              TempoUtil := TOPFINAL_ESTAGIO_LOTE_INTERVALO(OPFELI.Itens[I]).DATAHORASAIDA.Value - TOPFINAL_ESTAGIO_LOTE_INTERVALO(OPFELI.Itens[I]).DATAHORAENTRADA.Value;
            end;
          end;

          if CDS_DADOSRELATORIO.Locate('CODIGOOPERADOR;CODIGOESPECIE;CODIGOESTAGIO', VarArrayOf([Consulta.FieldByName('CODIGOOPERADOR').AsString, Consulta.FieldByName('CODIGOESPECIE').AsString, Consulta.FieldByName('CODIGOESTAGIO').AsString]), []) then begin
            CDS_DADOSRELATORIO.Edit;
            CDS_DADOSRELATORIONUMERODELOTES.Value             := CDS_DADOSRELATORIONUMERODELOTES.Value + 1;
            CDS_DADOSRELATORIOTEMPOUTILPRODUCAO.Value         := CDS_DADOSRELATORIOTEMPOUTILPRODUCAO.AsDateTime + TempoUtil;
            if not ConsultaDesc.IsEmpty then
              CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger  := CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger + ConsultaDesc.FieldByName('QUANTIDADEDESCARTES').AsInteger;
          end else begin

            OPFELS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + Consulta.FieldByName('IDLOTE').AsString);

            CDS_DADOSRELATORIO.Append;
            CDS_DADOSRELATORIOCODIGOOPERADOR.Value    := Consulta.FieldByName('CODIGOOPERADOR').AsInteger;
            CDS_DADOSRELATORIONOMEOPERADOR.Value      := Consulta.FieldByName('NOMEOPERADOR').AsString;
            CDS_DADOSRELATORIOCODIGOESPECIE.Value     := Consulta.FieldByName('CODIGOESPECIE').AsInteger;
            CDS_DADOSRELATORIODESCRICAOESPECIE.Value  := Consulta.FieldByName('DESCRICAOESPECIE').AsString;
            CDS_DADOSRELATORIOCODIGOESTAGIO.Value     := Consulta.FieldByName('CODIGOESTAGIO').AsInteger;
            CDS_DADOSRELATORIODESCRICAOESTAGIO.Value  := Consulta.FieldByName('DESCRICAOESTAGIO').AsString;
            CDS_DADOSRELATORIONUMERODELOTES.Value     := 1;
            CDS_DADOSRELATORIOTEMPOUTILPRODUCAO.Value := TempoUtil;
            CDS_DADOSRELATORIOUNIDADES.Value          := OPFELS.Count;
            CDS_DADOSRELATORIOUNIDADESPORHORA.Value   := 0;
            CDS_DADOSRELATORIOQUANTIDADEDESCARTE.Value:= 0;

            if not ConsultaDesc.IsEmpty then
              CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger  := ConsultaDesc.FieldByName('QUANTIDADEDESCARTES').AsInteger;

            CDS_DADOSRELATORIODESCARTE.Value          := '0 (0%)';
          end;

          DecodeTime(CDS_DADOSRELATORIOTEMPOUTILPRODUCAO.AsDateTime, Hora, Minuto, Segundo, MiliSegundo);

          MinProd := 0;
          if Hora > 0 then
            MinProd := MinProd + (Hora * 60);
          MinProd := MinProd + Minuto;

          if MinProd > 0 then begin
            if CDS_DADOSRELATORIOUNIDADES.Value > 0 then
              CDS_DADOSRELATORIOUNIDADESPORHORA.Value   := Trunc((CDS_DADOSRELATORIOUNIDADES.Value / (MinProd / 60)));
          end;

          if CDS_DADOSRELATORIOUNIDADES.Value > 0 then begin
            if CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger > 0 then
              CDS_DADOSRELATORIODESCARTE.Value          := CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsString + ' (' + FormatCurr('#,##0.00', ((CDS_DADOSRELATORIOQUANTIDADEDESCARTE.AsInteger * 100) / CDS_DADOSRELATORIOUNIDADES.AsInteger))  + '%)';
          end;

          CDS_DADOSRELATORIO.Post;

          Consulta.Next;
        end;

        CDS_DADOSRELATORIO.First;
        while not CDS_DADOSRELATORIO.Eof do begin

          CDS_DADOSRELATORIO.Next;
        end;

        CDS_DADOSRELATORIO.IndexFieldNames := 'CODIGOOPERADOR;CODIGOESPECIE;CODIGOESTAGIO';

        //Chama o Relatório para exibir os Dados
        DMUtil.frxDBDataset1.DataSet  := CDS_DADOSRELATORIO;
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
    CDS_DADOSRELATORIO.EnableControls;
    FreeAndNil(CQ);
    FreeAndNil(OPFELI);
    FreeAndNil(OPFELS);
    FreeAndNil(Consulta);
    FreeAndNil(ConsultaDesc);
    FreeAndNil(FWC);
  end;
end;

end.
