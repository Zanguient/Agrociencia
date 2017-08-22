unit uCadastroVariedade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmCadastroVariedade = class(TForm)
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel2: TPanel;
    pnEdicao: TPanel;
    pnBotoesEdicao: TPanel;
    ds_Variedade: TDataSource;
    cds_Variedade: TClientDataSet;
    cds_VariedadeID: TIntegerField;
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
    Label2: TLabel;
    edDescricao: TEdit;
    pnUsuarioDireita: TPanel;
    btExportar: TSpeedButton;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    btCancelar: TSpeedButton;
    Panel5: TPanel;
    btGravar: TSpeedButton;
    cds_VariedadeNOME: TStringField;
    gbProduto: TGroupBox;
    edCodigoProduto: TButtonedEdit;
    edNomeProduto: TEdit;
    cds_VariedadeID_PRODUTO: TIntegerField;
    cds_VariedadeESPECIE: TStringField;
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
    procedure edCodigoProdutoRightButtonClick(Sender: TObject);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoProdutoChange(Sender: TObject);
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
  frmCadastroVariedade: TfrmCadastroVariedade;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanVariedade,
  uMensagem,
  uFuncoes,
  uDMUtil,
  uBeanProdutos;

{$R *.dfm}

procedure TfrmCadastroVariedade.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edDescricao.Clear;
    edCodigoProduto.Clear;
    edNomeProduto.Clear;
    btGravar.Tag  := 0;
  end else begin
    edDescricao.Text      := cds_VariedadeNOME.Value;
    edCodigoProduto.Text  := cds_VariedadeID_PRODUTO.AsString;
    edNomeProduto.Text    := cds_VariedadeESPECIE.AsString;
    btGravar.Tag          := cds_VariedadeID.Value;
  end;
end;

procedure TfrmCadastroVariedade.btAlterarClick(Sender: TObject);
begin
  if not cds_Variedade.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroVariedade.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroVariedade.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  VARIEDADE  : TVARIEDADE;
begin
  if not cds_Variedade.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir a Variedade Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        VARIEDADE  := TVARIEDADE.Create(FWC);
        try

          VARIEDADE.ID.Value := cds_VariedadeID.Value;
          VARIEDADE.Delete;

          FWC.Commit;

          cds_Variedade.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir a Variedade, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(VARIEDADE);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadastroVariedade.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cds_Variedade, Caption + '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmCadastroVariedade.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroVariedade.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  VARIEDADE  : TVARIEDADE;
begin

  FWC := TFWConnection.Create;
  VARIEDADE  := TVARIEDADE.Create(FWC);

  try
    try

      if Length(Trim(edDescricao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Descrição não informada, Verifique!');
        if edDescricao.CanFocus then
          edDescricao.SetFocus;
        Exit;
      end;

      VARIEDADE.NOME.Value          := edDescricao.Text;
      VARIEDADE.ID_PRODUTO.Value    := StrToInt(edCodigoProduto.Text);

      if (Sender as TSpeedButton).Tag > 0 then begin
        VARIEDADE.ID.Value          := (Sender as TSpeedButton).Tag;
        VARIEDADE.Update;
      end else begin
        VARIEDADE.ID.isNull := True;
        VARIEDADE.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar a Unidade de Medida!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(VARIEDADE);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroVariedade.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroVariedade.Cancelar;
begin
  if cds_Variedade.State in [dsInsert, dsEdit] then
    cds_Variedade.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroVariedade.CarregaDados;
Var
  FWC : TFWConnection;
  Query : TFDQuery;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    Query := TFDQuery.Create(nil);
    cds_Variedade.DisableControls;
    try
      Query.Connection := FWC.FDConnection;

      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT');
      Query.SQL.Add('V.ID,');
      Query.SQL.Add('V.NOME,');
      Query.SQL.Add('V.ID_PRODUTO,');
      Query.SQL.Add('P.DESCRICAO AS ESPECIE');
      Query.SQL.Add('FROM VARIEDADE V');
      Query.SQL.Add('INNER JOIN PRODUTO P ON V.ID_PRODUTO = P.ID');
      Query.Prepare;
      Query.Open();

      Codigo := cds_VariedadeID.Value;

      cds_Variedade.EmptyDataSet;

      Query.First;
      while not Query.Eof do begin
        cds_Variedade.Append;
        cds_VariedadeID.Value := Query.Fields[0].Value;
        cds_VariedadeNOME.Value := Query.Fields[1].Value;
        cds_VariedadeID_PRODUTO.Value := Query.Fields[2].Value;
        cds_VariedadeESPECIE.Value := Query.Fields[3].Value;
        cds_Variedade.Post;

        Query.Next;
      end;

      if Codigo > 0 then
        cds_Variedade.Locate('ID', Codigo, []);

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados da Tela.', '', E.Message);
      end;
    end;

  finally
    cds_Variedade.EnableControls;
    FreeAndNil(Query);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroVariedade.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroVariedade.edCodigoProdutoChange(Sender: TObject);
begin
  edNomeProduto.Clear;
end;

procedure TfrmCadastroVariedade.edCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoProdutoRightButtonClick(nil);
end;

procedure TfrmCadastroVariedade.edCodigoProdutoRightButtonClick(
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

procedure TfrmCadastroVariedade.Filtrar;
begin
  cds_Variedade.Filtered := False;
  cds_Variedade.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroVariedade.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroVariedade.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not cds_Variedade.IsEmpty then begin
          if cds_Variedade.RecNo > 1 then
            cds_Variedade.Prior;
        end;
      end;
      VK_DOWN : begin
        if not cds_Variedade.IsEmpty then begin
          if cds_Variedade.RecNo < cds_Variedade.RecordCount then
            cds_Variedade.Next;
        end;
      end;
    end;
  end else begin
    case Key of
      VK_ESCAPE : Cancelar;
    end;
  end;
end;

procedure TfrmCadastroVariedade.FormShow(Sender: TObject);
begin
  cds_Variedade.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroVariedade.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroVariedade.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edDescricao.CanFocus then
      edDescricao.SetFocus;
  end;
end;

end.
