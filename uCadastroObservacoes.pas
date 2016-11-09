unit uCadastroObservacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits;

type
  TfrmCadastroObservacoes = class(TForm)
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
    cds_PesquisaDESCRICAO: TStringField;
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
    edCodigoExterno: TEdit;
    Label3: TLabel;
    cds_PesquisaCODIGOEXTERNO: TStringField;
    edObservacao: TEdit;
    Label1: TLabel;
    cds_PesquisaOBSERVACAO: TStringField;
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
  frmCadastroObservacoes: TfrmCadastroObservacoes;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanRecipientes,
  uMensagem,
  uFuncoes,
  uBeanObservacao;

{$R *.dfm}

procedure TfrmCadastroObservacoes.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edDescricao.Clear;
    edObservacao.Clear;
    edCodigoExterno.Clear;
    btGravar.Tag  := 0;
  end else begin
    edDescricao.Text      := cds_PesquisaDESCRICAO.Value;
    edObservacao.Text     := cds_PesquisaOBSERVACAO.Value;
    edCodigoExterno.Text  := cds_PesquisaCODIGOEXTERNO.Value;
    btGravar.Tag          := cds_PesquisaID.Value;
  end;
end;

procedure TfrmCadastroObservacoes.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroObservacoes.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroObservacoes.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  O   : TOBSERVACAO;
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir a Observação Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        O   := TOBSERVACAO.Create(FWC);
        try

          O.ID.Value := cds_PesquisaID.Value;
          O.Delete;

          FWC.Commit;

          cds_Pesquisa.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir a Observação, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(O);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadastroObservacoes.btExportarClick(Sender: TObject);
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

procedure TfrmCadastroObservacoes.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroObservacoes.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  O   : TOBSERVACAO;
begin

  FWC := TFWConnection.Create;
  O   := TOBSERVACAO.Create(FWC);

  try
    try

      if Length(Trim(edDescricao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Descrição não informada, Verifique!');
        if edDescricao.CanFocus then
          edDescricao.SetFocus;
        Exit;
      end;

      if Length(Trim(edObservacao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Observação não informada, Verifique!');
        if edObservacao.CanFocus then
          edObservacao.SetFocus;
        Exit;
      end;

      O.DESCRICAO.Value       := edDescricao.Text;
      O.OBSERVACAO.Value      := edObservacao.Text;
      O.CODIGOEXTERNO.Value   := edCodigoExterno.Text;

      if (Sender as TSpeedButton).Tag > 0 then begin
        O.ID.Value          := (Sender as TSpeedButton).Tag;
        O.Update;
      end else begin
        O.ID.isNull := True;
        O.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar a Observação!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(O);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroObservacoes.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroObservacoes.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroObservacoes.CarregaDados;
Var
  FWC : TFWConnection;
  O   : TOBSERVACAO;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    O   := TOBSERVACAO.Create(FWC);
    cds_Pesquisa.DisableControls;
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      O.SelectList('ID > 0', 'ID');
      if O.Count > 0 then begin
        for I := 0 to O.Count -1 do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value             := TOBSERVACAO(O.Itens[I]).ID.Value;
          cds_PesquisaDESCRICAO.Value      := TOBSERVACAO(O.Itens[I]).DESCRICAO.Value;
          cds_PesquisaOBSERVACAO.Value     := TOBSERVACAO(O.Itens[I]).OBSERVACAO.Value;
          cds_PesquisaCODIGOEXTERNO.Value  := TOBSERVACAO(O.Itens[I]).CODIGOEXTERNO.Value;
          cds_Pesquisa.Post;
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
    FreeAndNil(O);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroObservacoes.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroObservacoes.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroObservacoes.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroObservacoes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadastroObservacoes.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroObservacoes.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroObservacoes.InvertePaineis;
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
