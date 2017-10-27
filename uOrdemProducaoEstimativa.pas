unit uOrdemProducaoEstimativa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, System.DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TParametroEstimativa = record
    CodigoOp: Integer;
    DataInicio: TDate;
  end;
  TfrmOrdemProducaoEstimativa = class(TForm)
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    pnPrincipal: TPanel;
    dgEstimativa: TDBGrid;
    cdsEstimativa: TClientDataSet;
    dsEstimativa: TDataSource;
    edCodigoEstagio: TButtonedEdit;
    edDescEstagio: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edQuantidade: TEdit;
    Label3: TLabel;
    edFatorX: TEdit;
    Label4: TLabel;
    edPerda: TEdit;
    Label5: TLabel;
    edDias: TEdit;
    Label6: TLabel;
    btnAdicionar: TBitBtn;
    btRemover: TBitBtn;
    cdsEstimativaID: TIntegerField;
    cdsEstimativaID_ESTAGIO: TIntegerField;
    cdsEstimativaESTAGIO: TStringField;
    cdsEstimativaQUANTIDADE: TIntegerField;
    cdsEstimativaFATORX: TIntegerField;
    cdsEstimativaPERDA: TIntegerField;
    cdsEstimativaDIA: TIntegerField;
    cdsEstimativaDATAINICIO: TDateField;
    cdsEstimativaDATAFIM: TDateField;
    cdsEstimativaSEQUENCIA: TIntegerField;
    btAlterar: TSpeedButton;
    btReordenar: TSpeedButton;
    btExportar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure dgEstimativaCellClick(Column: TColumn);
    procedure btGravarClick(Sender: TObject);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btRemoverClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btReordenarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
  private
    { Private declarations }
  public
    Parametro: TParametroEstimativa;
    { Public declarations }
    procedure Adicionar;
    procedure Excluir;
    procedure Limpar;
    procedure Reordenar;
    procedure CarregarDados;
  end;

var
  frmOrdemProducaoEstimativa: TfrmOrdemProducaoEstimativa;

implementation
  uses
    uFWConnection,
    uBeanEstagio,
    uDMUtil,
    uFuncoes,
    uMensagem,
    uBeanOPFinal_Estimativa;

{$R *.dfm}

procedure TfrmOrdemProducaoEstimativa.Adicionar;
var
  dtInicio: TDate;
  Quantidade: Integer;
begin
  if cdsEstimativa.RecordCount > 0 then
  begin
    cdsEstimativa.Last;
    dtInicio := cdsEstimativaDATAFIM.AsDateTime;
    Quantidade := (cdsEstimativaQUANTIDADE.AsInteger * cdsEstimativaFATORX.AsInteger) - cdsEstimativaPERDA.AsInteger;
  end
  else
  begin
    dtInicio := Parametro.DataInicio;
    Quantidade := StrToIntDef(edQuantidade.Text,0);
  end;

  cdsEstimativa.Append;
  cdsEstimativaID_ESTAGIO.Value := StrToIntDef(edCodigoEstagio.Text,0);
  cdsEstimativaESTAGIO.Value := edDescEstagio.Text;

  cdsEstimativaFATORX.Value := StrToIntDef(edFatorX.Text,0);
  cdsEstimativaPERDA.Value := StrToIntDef(edPerda.Text,0);
  cdsEstimativaDIA.Value := StrToIntDef(edDias.Text,0);
  cdsEstimativaDATAINICIO.Value := dtInicio;
  cdsEstimativaQUANTIDADE.Value := Quantidade;

  cdsEstimativaDATAFIM.Value := IncDay(cdsEstimativaDATAINICIO.AsDateTime, cdsEstimativaDIA.AsInteger);
  cdsEstimativaSEQUENCIA.Value := cdsEstimativa.RecordCount + 1;
  cdsEstimativa.Post;
end;

procedure TfrmOrdemProducaoEstimativa.btAlterarClick(Sender: TObject);
begin
  CarregarDados;
end;

procedure TfrmOrdemProducaoEstimativa.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOrdemProducaoEstimativa.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cdsEstimativa, Caption + '_' +  IntToStr(Parametro.CodigoOp) +  '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmOrdemProducaoEstimativa.btGravarClick(Sender: TObject);
var
  FWC: TFWConnection;
  Estimativa: TOPFINAL_ESTIMATIVA;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  Estimativa := TOPFINAL_ESTIMATIVA.Create(FWC);
  try
    Estimativa.SelectList('id_opfinal = ' + IntToStr(Parametro.CodigoOp));
    if Estimativa.Count > 0 then
    begin
      for I := 0 to Estimativa.Count - 1 do
      begin
        if not cdsEstimativa.Locate(cdsEstimativaID.FieldName, TOPFINAL_ESTIMATIVA(Estimativa.Itens[I]).ID.Value, []) then
        begin
          Estimativa.ID.Value := TOPFINAL_ESTIMATIVA(Estimativa.Itens[I]).ID.Value;
          Estimativa.Delete;
        end;
      end;
    end;

    cdsEstimativa.Data := cdsEstimativa.Delta;

    Reordenar;

    cdsEstimativa.First;
    while not cdsEstimativa.Eof do
    begin
      Estimativa.ID_OPFINAL.Value := Parametro.CodigoOp;
      Estimativa.ID_ESTAGIO.Value := cdsEstimativaID_ESTAGIO.Value;
      Estimativa.SEQUENCIA.Value := cdsEstimativaSEQUENCIA.Value;
      Estimativa.QUANTIDADE.Value := cdsEstimativaQUANTIDADE.Value;
      Estimativa.FATORX.Value := cdsEstimativaFATORX.Value;
      Estimativa.PERDA.Value := cdsEstimativaPERDA.Value;
      Estimativa.DIAS.Value := cdsEstimativaDIA.Value;
      Estimativa.DTINICIO.Value := cdsEstimativaDATAINICIO.Value;
      Estimativa.DTFIM.Value := cdsEstimativaDATAFIM.Value;

      if cdsEstimativaID.IsNull then
      begin
        Estimativa.ID.isNull := True;
        Estimativa.Insert;
      end
      else
      begin
        Estimativa.ID.Value := cdsEstimativaID.Value;
        Estimativa.Update;
      end;

      cdsEstimativa.Next;
    end;
    Close;

  finally
    FreeAndNil(Estimativa);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoEstimativa.btnAdicionarClick(Sender: TObject);
begin
 if edDescEstagio.Text = EmptyStr then
 begin
   DisplayMsg(MSG_INF, 'Informe o Estágio!');
   if edCodigoEstagio.CanFocus then edCodigoEstagio.SetFocus;
   Exit;
 end;
 if edQuantidade.Enabled and (StrToIntDef(edQuantidade.Text, 0) = 0) then
 begin
   DisplayMsg(MSG_INF, 'Informe a quantidade de recipientes!');
   if edQuantidade.CanFocus then edQuantidade.SetFocus;
   Exit;
 end;
 if edFatorX.Enabled and (StrToIntDef(edFatorX.Text, 0) = 0) then
 begin
   DisplayMsg(MSG_INF, 'Informe o Fator X!');
   if edFatorX.CanFocus then edFatorX.SetFocus;
   Exit;
 end;
 if edPerda.Enabled and (StrToIntDef(edPerda.Text, 0) = 0) then
 begin
   DisplayMsg(MSG_INF, 'Informe a estimativa de potes perdidos!');
   if edPerda.CanFocus then edPerda.SetFocus;
   Exit;
 end;
 if edDias.Enabled and (StrToIntDef(edDias.Text, 0) = 0) then
 begin
   DisplayMsg(MSG_INF, 'Informe a estimativa de dias para o estágio selecionado!');
   if edDias.CanFocus then edDias.SetFocus;
   Exit;
 end;

  Adicionar;
  Limpar;
  edQuantidade.Enabled := cdsEstimativa.IsEmpty;
end;

procedure TfrmOrdemProducaoEstimativa.btRemoverClick(Sender: TObject);
var
 SeqAtual: Integer;
begin
  SeqAtual := cdsEstimativaSEQUENCIA.AsInteger;
  try
    Excluir;
    Reordenar;

    edQuantidade.Enabled := cdsEstimativa.IsEmpty;
  finally
    cdsEstimativa.Locate(cdsEstimativaSEQUENCIA.FieldName, SeqAtual, []);
  end;
end;

procedure TfrmOrdemProducaoEstimativa.btReordenarClick(Sender: TObject);
begin
  Reordenar;
end;

procedure TfrmOrdemProducaoEstimativa.CarregarDados;
var
  FWC: TFWConnection;
  SQL: TFDQuery;
  I: Integer;
begin
  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    SQL.Connection := FWC.FDConnection;
    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('EST.ID,');
    SQL.SQL.Add('EST.SEQUENCIA,');
    SQL.SQL.Add('EST.ID_ESTAGIO,');
    SQL.SQL.Add('E.DESCRICAO AS ESTAGIO,');
    SQL.SQL.Add('EST.QUANTIDADE,');
    SQL.SQL.Add('EST.FATORX,');
    SQL.SQL.Add('EST.PERDA,');
    SQL.SQL.Add('EST.DIAS AS DIA,');
    SQL.SQL.Add('EST.DTINICIO AS DATAINICIO,');
    SQL.SQL.Add('EST.DTFIM AS DATAFIM');
    SQL.SQL.Add('FROM OPFINAL_ESTIMATIVA EST');
    SQL.SQL.Add('INNER JOIN ESTAGIO E ON EST.ID_ESTAGIO = E.ID');
    SQL.SQL.Add('WHERE EST.ID_OPFINAL = :ID_OPFINAL');

    SQL.ParamByName('ID_OPFINAL').AsInteger := Parametro.CodigoOp;
    SQL.Prepare;

    SQL.Open();
    SQL.FetchAll;

    cdsEstimativa.EmptyDataSet;

    SQL.First;
    while not SQL.Eof do
    begin
      cdsEstimativa.Append;
      for I := 0 to cdsEstimativa.Fields.Count -1 do
      begin
        if Assigned(cdsEstimativa.FindField(SQL.Fields[I].FieldName)) then
          cdsEstimativa.FieldByName(SQL.Fields[I].FieldName).Value := SQL.Fields[I].Value;
      end;
      cdsEstimativa.Post;
      SQL.Next;
    end;

  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;

  edQuantidade.Enabled := cdsEstimativa.IsEmpty;
end;

procedure TfrmOrdemProducaoEstimativa.dgEstimativaCellClick(Column: TColumn);
begin
  if (Column.FieldName = cdsEstimativaSEQUENCIA.FieldName) or (Column.FieldName = cdsEstimativaQUANTIDADE.FieldName) then
    dgEstimativa.Options := dgEstimativa.Options + [dgEditing]
  else
    dgEstimativa.Options := dgEstimativa.Options - [dgEditing];
end;

procedure TfrmOrdemProducaoEstimativa.edCodigoEstagioChange(Sender: TObject);
begin
  edDescEstagio.Clear;
end;

procedure TfrmOrdemProducaoEstimativa.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoEstagioRightButtonClick(nil)
end;

procedure TfrmOrdemProducaoEstimativa.edCodigoEstagioRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin

  FWC := TFWConnection.Create;
  E   := TESTAGIO.Create(FWC);
  try
    edCodigoEstagio.Text := IntToStr(DMUtil.Selecionar(E, edCodigoEstagio.Text));
    E.SelectList('id = ' + edCodigoEstagio.Text);
    if E.Count = 1 then
      edDescEstagio.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmOrdemProducaoEstimativa.Excluir;
begin
  if not cdsEstimativa.IsEmpty then
  begin
    cdsEstimativa.Delete;
  end;
end;

procedure TfrmOrdemProducaoEstimativa.FormCreate(Sender: TObject);
begin
  cdsEstimativa.CreateDataSet;
  cdsEstimativa.Open;
  cdsEstimativa.IndexFieldNames := cdsEstimativaSEQUENCIA.FieldName;
  AjustaForm(Self);
end;

procedure TfrmOrdemProducaoEstimativa.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmOrdemProducaoEstimativa.FormShow(Sender: TObject);
begin
  AutoSizeDBGrid(dgEstimativa);
  CarregarDados;
end;

procedure TfrmOrdemProducaoEstimativa.Limpar;
begin
  edCodigoEstagio.Clear;
  edDescEstagio.Clear;
  edQuantidade.Clear;
  edFatorX.Clear;
  edPerda.Clear;
  edDias.Clear;
end;

procedure TfrmOrdemProducaoEstimativa.Reordenar;
var
  UltSequencia: Integer;
  dtInicio: TDate;
  Quantidade: Integer;
  Sequencia: Integer;
 begin
  UltSequencia := 1;
  cdsEstimativa.First;
  while not cdsEstimativa.Eof do
  begin
    if UltSequencia = 1 then
    begin
      dtInicio := Parametro.DataInicio;
      Quantidade := cdsEstimativaQUANTIDADE.AsInteger;
    end;

    if cdsEstimativaSEQUENCIA.Value <> UltSequencia then
    begin
      Sequencia := UltSequencia;
    end;

    cdsEstimativa.Edit;
    cdsEstimativaSEQUENCIA.Value := UltSequencia;
    cdsEstimativaQUANTIDADE.Value := Quantidade;
    cdsEstimativaDATAINICIO.Value := dtInicio;
    cdsEstimativa.Post;

    dtInicio := cdsEstimativaDATAFIM.AsDateTime;
    Quantidade := (cdsEstimativaQUANTIDADE.AsInteger * cdsEstimativaFATORX.AsInteger) - cdsEstimativaPERDA.AsInteger;

    UltSequencia := UltSequencia + 1;

    cdsEstimativa.Next;
  end;
    edQuantidade.Enabled := cdsEstimativa.IsEmpty;
end;

end.
