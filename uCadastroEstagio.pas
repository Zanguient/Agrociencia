unit uCadastroEstagio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits;

type
  TfrmCadastroEstagio = class(TForm)
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
    edObservacao: TEdit;
    Label1: TLabel;
    cds_PesquisaOBSERVACAO: TStringField;
    chkEstagioInicial: TCheckBox;
    cds_PesquisaINICIAL: TBooleanField;
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
  frmCadastroEstagio: TfrmCadastroEstagio;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uMensagem,
  uFuncoes,
  uBeanEstagio;

{$R *.dfm}

procedure TfrmCadastroEstagio.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edDescricao.Clear;
    edObservacao.Clear;
    btGravar.Tag  := 0;
  end else begin
    edDescricao.Text          := cds_PesquisaDESCRICAO.Value;
    edObservacao.Text         := cds_PesquisaOBSERVACAO.Value;
    chkEstagioInicial.Checked := cds_PesquisaINICIAL.Value;
    btGravar.Tag              := cds_PesquisaID.Value;
  end;
end;

procedure TfrmCadastroEstagio.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroEstagio.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroEstagio.btExcluirClick(Sender: TObject);
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

procedure TfrmCadastroEstagio.btExportarClick(Sender: TObject);
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

procedure TfrmCadastroEstagio.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroEstagio.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin

  FWC := TFWConnection.Create;
  E   := TESTAGIO.Create(FWC);

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

      E.DESCRICAO.Value       := edDescricao.Text;
      E.OBSERVACAO.Value      := edObservacao.Text;
      E.INICIAL.Value         := chkEstagioInicial.Checked;

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

procedure TfrmCadastroEstagio.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroEstagio.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroEstagio.CarregaDados;
Var
  FWC : TFWConnection;
  E   : TESTAGIO;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    E   := TESTAGIO.Create(FWC);
    cds_Pesquisa.DisableControls;
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      E.SelectList('ID > 0', 'ID');
      if E.Count > 0 then begin
        for I := 0 to E.Count -1 do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value             := TESTAGIO(E.Itens[I]).ID.Value;
          cds_PesquisaDESCRICAO.Value      := TESTAGIO(E.Itens[I]).DESCRICAO.Value;
          cds_PesquisaINICIAL.Value        := TESTAGIO(E.Itens[I]).INICIAL.Value;
          cds_PesquisaOBSERVACAO.Value     := TESTAGIO(E.Itens[I]).OBSERVACAO.Value;
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
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroEstagio.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroEstagio.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroEstagio.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroEstagio.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadastroEstagio.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroEstagio.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroEstagio.InvertePaineis;
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
