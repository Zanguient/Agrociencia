unit uControleEstagioOPF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Comp.Client;

type
  TfrmControleEstagioOPF = class(TForm)
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel2: TPanel;
    pnEdicao: TPanel;
    pnBotoesEdicao: TPanel;
    ds_Pesquisa: TDataSource;
    cds_Pesquisa: TClientDataSet;
    cds_PesquisaID: TIntegerField;
    cds_PesquisaNOMECLIENTE: TStringField;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btExcluir: TSpeedButton;
    btFechar: TSpeedButton;
    btAlterar: TSpeedButton;
    btNovo: TSpeedButton;
    Panel1: TPanel;
    Panel3: TPanel;
    GridPanel1: TGridPanel;
    pnUsuarioEsquerda: TPanel;
    pnUsuarioDireita: TPanel;
    btExportar: TSpeedButton;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    cds_PesquisaNOMEPRODUTO: TStringField;
    cds_PesquisaSEQUENCIA: TIntegerField;
    cds_PesquisaESTAGIO: TStringField;
    cds_PesquisaCODIGOOP: TIntegerField;
    edObservacao: TEdit;
    Label1: TLabel;
    gbOPF: TGroupBox;
    edOPF: TButtonedEdit;
    edDescOPF: TEdit;
    gbOPMC: TGroupBox;
    edOPMC: TButtonedEdit;
    edDescOPMC: TEdit;
    gbEstagio: TGroupBox;
    edCodigoEstagio: TButtonedEdit;
    edDescEstagio: TEdit;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure csPesquisaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure gdPesquisaTitleClick(Column: TColumn);
    procedure btExportarClick(Sender: TObject);
    procedure edOPFChange(Sender: TObject);
    procedure edOPMCChange(Sender: TObject);
    procedure edOPFRightButtonClick(Sender: TObject);
    procedure edOPMCRightButtonClick(Sender: TObject);
    procedure edOPMCKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edOPFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure CarregaDados;
    procedure InvertePaineis;
    procedure Cancelar;
    procedure Filtrar;
    procedure AtualizarEdits(Limpar : Boolean);
  end;

var
  frmControleEstagioOPF: TfrmControleEstagioOPF;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uMensagem,
  uFuncoes,
  uBeanEstagio, uBeanOPFinal, uDMUtil, uBeanOrdemProducaoMC;

{$R *.dfm}

procedure TfrmControleEstagioOPF.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edObservacao.Clear;
    btGravar.Tag  := 0;
  end else begin
    //edDescricao.Text      := cds_PesquisaDESCRICAO.Value;
    //edObservacao.Text     := cds_PesquisaOBSERVACAO.Value;
    btGravar.Tag          := cds_PesquisaID.Value;
  end;
end;

procedure TfrmControleEstagioOPF.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmControleEstagioOPF.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmControleEstagioOPF.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir o Estágio Selecionado?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        E   := TESTAGIO.Create(FWC);
        try

          E.ID.Value := cds_PesquisaID.Value;
          E.Delete;

          FWC.Commit;

          cds_Pesquisa.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir o Estágio, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(E);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cds_Pesquisa, Caption + '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmControleEstagioOPF.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin

  FWC := TFWConnection.Create;
  E   := TESTAGIO.Create(FWC);

  try
    try

      {if Length(Trim(edDescricao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Descrição não informada, Verifique!');
        if edDescricao.CanFocus then
          edDescricao.SetFocus;
        Exit;
      end;}

      if Length(Trim(edObservacao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Observação não informada, Verifique!');
        if edObservacao.CanFocus then
          edObservacao.SetFocus;
        Exit;
      end;

      //E.DESCRICAO.Value       := edDescricao.Text;
      E.OBSERVACAO.Value      := edObservacao.Text;

      if (Sender as TSpeedButton).Tag > 0 then begin
        E.ID.Value          := (Sender as TSpeedButton).Tag;
        E.Update;
      end else begin
        E.ID.isNull := True;
        E.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar o Estágio!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmControleEstagioOPF.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmControleEstagioOPF.CarregaDados;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    SQL := TFDQuery.Create(nil);
    cds_Pesquisa.DisableControls;
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	OPF.ID,');
      SQL.SQL.Add('	OP.ID AS CODIGOOP,');
      SQL.SQL.Add('	OPF.SEQUENCIA,');
      SQL.SQL.Add('	C.NOME AS CLIENTE,');
      SQL.SQL.Add('	P.DESCRICAO AS PRODUTO,');
      SQL.SQL.Add('	E.DESCRICAO AS ESTAGIO');
      SQL.SQL.Add('FROM OPFINAL OP');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPF ON (OPF.OPFINAL_ID = OP.ID)');
      SQL.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPF.ESTAGIO_ID)');
      SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OP.CLIENTE_ID)');
      SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OP.PRODUTO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('ORDER BY 1,2');
      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value          := SQL.FieldByName('ID').AsInteger;
          cds_PesquisaCODIGOOP.Value    := SQL.FieldByName('CODIGOOP').AsInteger;
          cds_PesquisaSEQUENCIA.Value   := SQL.FieldByName('SEQUENCIA').AsInteger;
          cds_PesquisaNOMECLIENTE.Value := SQL.FieldByName('CLIENTE').AsString;
          cds_PesquisaNOMEPRODUTO.Value := SQL.FieldByName('PRODUTO').AsString;
          cds_PesquisaESTAGIO.Value     := SQL.FieldByName('ESTAGIO').AsString;
          cds_Pesquisa.Post;
          SQL.Next;
        end;
      end;

      if Codigo > 0 then
        cds_Pesquisa.Locate('ID', Codigo, []);

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados da Tela.', '', E.Message);
      end;
    end;

  finally
    cds_Pesquisa.EnableControls;
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.csPesquisaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
Var
  I : Integer;
begin
  Accept := False;
  for I := 0 to DataSet.Fields.Count - 1 do begin
    if not DataSet.Fields[I].IsNull then begin
      if Pos(AnsiLowerCase(edPesquisa.Text),AnsiLowerCase(DataSet.Fields[I].AsVariant)) > 0 then begin
        Accept := True;
        Break;
      end;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.edCodigoEstagioChange(Sender: TObject);
begin
  edDescEstagio.Clear;
end;

procedure TfrmControleEstagioOPF.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoEstagioRightButtonClick(nil)
end;

procedure TfrmControleEstagioOPF.edCodigoEstagioRightButtonClick(
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

procedure TfrmControleEstagioOPF.edOPFChange(Sender: TObject);
begin
  edDescOPF.Text := EmptyStr;
end;

procedure TfrmControleEstagioOPF.edOPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edOPFRightButtonClick(nil)
end;

procedure TfrmControleEstagioOPF.edOPFRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  OPF : TOPFINAL;
  SQL : TFDQuery;
begin

  FWC := TFWConnection.Create;
  OPF := TOPFINAL.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try

    edOPF.Text := IntToStr(DMUtil.Selecionar(OPF, edOPF.Text));

    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	C.NOME AS NOMECLIENTE');
    SQL.SQL.Add('FROM OPFINAL OPF');
    SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND OPF.ID = :IDOPF');
    SQL.Connection  := FWC.FDConnection;
    SQL.ParamByName('IDOPF').DataType   := ftInteger;
    SQL.ParamByName('IDOPF').AsInteger  := StrToIntDef(edOPF.Text, -1);
    SQL.Prepare;
    SQL.Open;

    if not SQL.IsEmpty then
      edDescOPF.Text := SQL.FieldByName('NOMECLIENTE').AsString;

  finally
    FreeAndNil(SQL);
    FreeAndNil(OPF);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.edOPMCChange(Sender: TObject);
begin
  edDescOPMC.Text := EmptyStr;
end;

procedure TfrmControleEstagioOPF.edOPMCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edOPMCRightButtonClick(nil)
end;

procedure TfrmControleEstagioOPF.edOPMCRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  OPMC: TORDEMPRODUCAOMC;
  SQL : TFDQuery;
begin

  FWC := TFWConnection.Create;
  OPMC:= TORDEMPRODUCAOMC.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try

    edOPMC.Text := IntToStr(DMUtil.Selecionar(OPMC, edOPMC.Text));

    SQL.Close;
    SQL.SQL.Clear;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('	C.NOME AS NOMECLIENTE');
    SQL.SQL.Add('FROM OPFINAL OPF');
    SQL.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
    SQL.SQL.Add('WHERE 1 = 1');
    SQL.SQL.Add('AND OPF.ID = :IDOPF');
    SQL.Connection  := FWC.FDConnection;
    SQL.ParamByName('IDOPF').DataType   := ftInteger;
    SQL.ParamByName('IDOPF').AsInteger  := StrToIntDef(edOPMC.Text, -1);
    SQL.Prepare;
    SQL.Open;

    if not SQL.IsEmpty then
      edDescOPMC.Text := SQL.FieldByName('NOMECLIENTE').AsString;

  finally
    FreeAndNil(SQL);
    FreeAndNil(OPMC);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleEstagioOPF.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmControleEstagioOPF.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmControleEstagioOPF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pnVisualizacao.Visible then begin
    case Key of
      VK_ESCAPE : Close;
      VK_RETURN : begin
        if edPesquisa.Focused then begin
          Filtrar;
        end else begin
          if edPesquisa.CanFocus then begin
            edPesquisa.SetFocus;
            edPesquisa.SelectAll;
          end;
        end;
      end;
      VK_F5 : CarregaDados;
      VK_UP : begin
        if not cds_Pesquisa.IsEmpty then begin
          if cds_Pesquisa.RecNo > 1 then
            cds_Pesquisa.Prior;
        end;
      end;
      VK_DOWN : begin
        if not cds_Pesquisa.IsEmpty then begin
          if cds_Pesquisa.RecNo < cds_Pesquisa.RecordCount then
            cds_Pesquisa.Next;
        end;
      end;
    end;
  end else begin
    case Key of
      VK_ESCAPE : Cancelar;
    end;
  end;
end;

procedure TfrmControleEstagioOPF.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmControleEstagioOPF.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmControleEstagioOPF.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edOPF.CanFocus then
      edOPF.SetFocus;
  end;
end;

end.
