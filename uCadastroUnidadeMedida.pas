unit uCadastroUnidadeMedida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits;

type
  TfrmCadastroUnidadeMedida = class(TForm)
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel2: TPanel;
    pnEdicao: TPanel;
    pnBotoesEdicao: TPanel;
    ds_UnidadeMedida: TDataSource;
    cds_UnidadeMedida: TClientDataSet;
    cds_UnidadeMedidaID: TIntegerField;
    cds_UnidadeMedidaDESCRICAO: TStringField;
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
    Label1: TLabel;
    Label2: TLabel;
    edSimbolo: TEdit;
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
    cds_UnidadeMedidaSIMBOLO: TStringField;
    cds_UnidadeMedidaCODIGOEXTERNO: TStringField;
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
  frmCadastroUnidadeMedida: TfrmCadastroUnidadeMedida;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanUnidadeMedida,
  uMensagem,
  uFuncoes;

{$R *.dfm}

procedure TfrmCadastroUnidadeMedida.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edDescricao.Clear;
    edSimbolo.Clear;
    edCodigoExterno.Clear;
    btGravar.Tag  := 0;
  end else begin
    edDescricao.Text      := cds_UnidadeMedidaDESCRICAO.Value;
    edSimbolo.Text        := cds_UnidadeMedidaSIMBOLO.Value;
    edCodigoExterno.Text  := cds_UnidadeMedidaCODIGOEXTERNO.Value;
    btGravar.Tag          := cds_UnidadeMedidaID.Value;
  end;
end;

procedure TfrmCadastroUnidadeMedida.btAlterarClick(Sender: TObject);
begin
  if not cds_UnidadeMedida.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroUnidadeMedida.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroUnidadeMedida.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  UN  : TUNIDADEMEDIDA;
begin
  if not cds_UnidadeMedida.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir a Unidade de Medida Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        UN  := TUNIDADEMEDIDA.Create(FWC);
        try

          UN.ID.Value := cds_UnidadeMedidaID.Value;
          UN.Delete;

          FWC.Commit;

          cds_UnidadeMedida.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir a Unidade de Medida, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(UN);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadastroUnidadeMedida.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cds_UnidadeMedida, Caption + '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmCadastroUnidadeMedida.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroUnidadeMedida.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  UN  : TUNIDADEMEDIDA;
begin

  FWC := TFWConnection.Create;
  UN  := TUNIDADEMEDIDA.Create(FWC);

  try
    try

      if Length(Trim(edDescricao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Descrição não informada, Verifique!');
        if edDescricao.CanFocus then
          edDescricao.SetFocus;
        Exit;
      end;

      if Length(Trim(edSimbolo.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Símbolo não informado, Verifique!');
        if edSimbolo.CanFocus then
          edSimbolo.SetFocus;
        Exit;
      end;

      UN.DESCRICAO.Value      := edDescricao.Text;
      UN.SIMBOLO.Value        := edSimbolo.Text;
      UN.CODIGOEXTERNO.Value  := edCodigoExterno.Text;

      if (Sender as TSpeedButton).Tag > 0 then begin
        UN.ID.Value          := (Sender as TSpeedButton).Tag;
        UN.Update;
      end else begin
        UN.ID.isNull := True;
        UN.Insert;
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
    FreeAndNil(UN);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroUnidadeMedida.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroUnidadeMedida.Cancelar;
begin
  if cds_UnidadeMedida.State in [dsInsert, dsEdit] then
    cds_UnidadeMedida.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroUnidadeMedida.CarregaDados;
Var
  FWC : TFWConnection;
  UN  : TUNIDADEMEDIDA;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    UN  := TUNIDADEMEDIDA.Create(FWC);
    cds_UnidadeMedida.DisableControls;
    try

      Codigo := cds_UnidadeMedidaID.Value;

      cds_UnidadeMedida.EmptyDataSet;

      UN.SelectList('ID > 0', 'ID');
      if UN.Count > 0 then begin
        for I := 0 to UN.Count -1 do begin
          cds_UnidadeMedida.Append;
          cds_UnidadeMedidaID.Value             := TUNIDADEMEDIDA(UN.Itens[I]).ID.Value;
          cds_UnidadeMedidaDESCRICAO.Value      := TUNIDADEMEDIDA(UN.Itens[I]).DESCRICAO.Value;
          cds_UnidadeMedidaSIMBOLO.Value        := TUNIDADEMEDIDA(UN.Itens[I]).SIMBOLO.Value;
          cds_UnidadeMedidaCODIGOEXTERNO.Value  := TUNIDADEMEDIDA(UN.Itens[I]).CODIGOEXTERNO.Value;
          cds_UnidadeMedida.Post;
        end;
      end;

      if Codigo > 0 then
        cds_UnidadeMedida.Locate('ID', Codigo, []);

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados da Tela.', '', E.Message);
      end;
    end;

  finally
    cds_UnidadeMedida.EnableControls;
    FreeAndNil(UN);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroUnidadeMedida.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroUnidadeMedida.Filtrar;
begin
  cds_UnidadeMedida.Filtered := False;
  cds_UnidadeMedida.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroUnidadeMedida.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroUnidadeMedida.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not cds_UnidadeMedida.IsEmpty then begin
          if cds_UnidadeMedida.RecNo > 1 then
            cds_UnidadeMedida.Prior;
        end;
      end;
      VK_DOWN : begin
        if not cds_UnidadeMedida.IsEmpty then begin
          if cds_UnidadeMedida.RecNo < cds_UnidadeMedida.RecordCount then
            cds_UnidadeMedida.Next;
        end;
      end;
    end;
  end else begin
    case Key of
      VK_ESCAPE : Cancelar;
    end;
  end;
end;

procedure TfrmCadastroUnidadeMedida.FormShow(Sender: TObject);
begin
  cds_UnidadeMedida.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroUnidadeMedida.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroUnidadeMedida.InvertePaineis;
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
