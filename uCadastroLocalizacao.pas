unit uCadastroLocalizacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, JvExStdCtrls, JvEdit, JvValidateEdit;

type
  TfrmCadastroLocalizacao = class(TForm)
    pnVisualizacao: TPanel;
    gdPesquisa: TDBGrid;
    pnBotoesVisualizacao: TPanel;
    pnPequisa: TPanel;
    btPesquisar: TSpeedButton;
    edPesquisa: TEdit;
    Panel2: TPanel;
    pnEdicao: TPanel;
    pnBotoesEdicao: TPanel;
    ds_Localizacao: TDataSource;
    cds_Localizacao: TClientDataSet;
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
    cds_LocalizacaoID: TIntegerField;
    cds_LocalizacaoNOME: TStringField;
    cds_LocalizacaoSALA: TStringField;
    cds_LocalizacaoESTANTE: TIntegerField;
    cds_LocalizacaoPRATELEIRAS: TIntegerField;
    edCodigo: TEdit;
    Label1: TLabel;
    edSala: TEdit;
    Label3: TLabel;
    edRegimeIluminacao: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edArea: TJvValidateEdit;
    Label7: TLabel;
    edTemperatura: TJvValidateEdit;
    Label8: TLabel;
    cds_LocalizacaoREGIME: TStringField;
    cds_LocalizacaoAREA: TFloatField;
    cds_LocalizacaoTEMPERATURA: TFloatField;
    edEstante: TJvValidateEdit;
    edPrateleiras: TJvValidateEdit;
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
  frmCadastroLocalizacao: TfrmCadastroLocalizacao;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanLocalizacao,
  uMensagem,
  uFuncoes,
  uDMUtil;

{$R *.dfm}

procedure TfrmCadastroLocalizacao.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edDescricao.Clear;
    edCodigo.Clear;
    edSala.Clear;
    edRegimeIluminacao.Clear;
    edEstante.Clear;
    edPrateleiras.Clear;
    edArea.Clear;
    edTemperatura.Clear;
    btGravar.Tag  := 0;
  end else begin
    edDescricao.Text := cds_LocalizacaoNOME.AsString;
    edCodigo.Text := cds_LocalizacaoID.AsString;
    edSala.Text := cds_LocalizacaoSALA.AsString;
    edRegimeIluminacao.Text := cds_LocalizacaoREGIME.AsString;
    edEstante.Text := cds_LocalizacaoESTANTE.AsString;
    edPrateleiras.Text := cds_LocalizacaoPRATELEIRAS.AsString;
    edArea.Text := FloatToStr(cds_LocalizacaoAREA.Value);
    edTemperatura.Text := FloatToStr(cds_LocalizacaoTEMPERATURA.Value);
    btGravar.Tag          := cds_LocalizacaoID.Value;
  end;
end;

procedure TfrmCadastroLocalizacao.btAlterarClick(Sender: TObject);
begin
  if not cds_Localizacao.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroLocalizacao.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroLocalizacao.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  LOCALIZACAO  : TLOCALIZACAO;
begin
  if not cds_Localizacao.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir a Unidade de Medida Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        LOCALIZACAO  := TLOCALIZACAO.Create(FWC);
        try

          LOCALIZACAO.ID.Value := cds_LocalizacaoID.Value;
          LOCALIZACAO.Delete;

          FWC.Commit;

          cds_Localizacao.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir a Unidade de Medida, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(LOCALIZACAO);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadastroLocalizacao.btExportarClick(Sender: TObject);
begin
  if btExportar.Tag = 0 then begin
    btExportar.Tag := 1;
    try
      ExpXLS(cds_Localizacao, Caption + '.xlsx');
    finally
      btExportar.Tag := 0;
    end;
  end;
end;

procedure TfrmCadastroLocalizacao.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroLocalizacao.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  LOCALIZACAO  : TLOCALIZACAO;
begin

  FWC := TFWConnection.Create;
  LOCALIZACAO  := TLOCALIZACAO.Create(FWC);

  try
    try

      if Length(Trim(edDescricao.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Descrição não informada, Verifique!');
        if edDescricao.CanFocus then
          edDescricao.SetFocus;
        Exit;
      end;

      LOCALIZACAO.NOME.Value              := edDescricao.Text;
      LOCALIZACAO.ESTANTE.Value           := StrToIntDef(edEstante.Text, 0);
      LOCALIZACAO.SALA.Value              := edSala.Text;
      LOCALIZACAO.REGIMEILUMINACAO.Value  := edRegimeIluminacao.Text;
      LOCALIZACAO.PRATELEIRAS.Value       := StrToIntDef(edPrateleiras.Text,0);
      LOCALIZACAO.AREA.Value              := edArea.Value;
      LOCALIZACAO.TEMPERATURA.Value       := edTemperatura.Value;

      if (Sender as TSpeedButton).Tag > 0 then begin
        LOCALIZACAO.ID.Value          := (Sender as TSpeedButton).Tag;
        LOCALIZACAO.Update;
      end else begin
        LOCALIZACAO.ID.isNull := True;
        LOCALIZACAO.Insert;
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
    FreeAndNil(LOCALIZACAO);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroLocalizacao.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroLocalizacao.Cancelar;
begin
  if cds_Localizacao.State in [dsInsert, dsEdit] then
    cds_Localizacao.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroLocalizacao.CarregaDados;
Var
  FWC : TFWConnection;
  Query : TFDQuery;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    Query := TFDQuery.Create(nil);
    cds_Localizacao.DisableControls;
    try
      Query.Connection := FWC.FDConnection;

      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT');
      Query.SQL.Add('L.ID,');
      Query.SQL.Add('L.NOME,');
      Query.SQL.Add('L.SALA,');
      Query.SQL.Add('L.ESTANTE,');
      Query.SQL.Add('L.PRATELEIRAS,');
      Query.SQL.Add('L.REGIMEILUMINACAO,');
      Query.SQL.Add('L.AREA,');
      Query.SQL.Add('L.TEMPERATURA');
      Query.SQL.Add('FROM LOCALIZACAO L');
      Query.Prepare;
      Query.Open();

      Codigo := cds_LocalizacaoID.Value;

      cds_Localizacao.EmptyDataSet;

      Query.First;
      while not Query.Eof do begin
        cds_Localizacao.Append;
        cds_LocalizacaoID.Value := Query.Fields[0].Value;
        cds_LocalizacaoNOME.Value := Query.Fields[1].Value;
        cds_LocalizacaoSALA.Value := Query.Fields[2].Value;
        cds_LocalizacaoESTANTE.Value := Query.Fields[3].Value;
        cds_LocalizacaoPRATELEIRAS.Value := Query.Fields[4].Value;
        cds_LocalizacaoREGIME.Value := Query.Fields[5].Value;
        cds_LocalizacaoAREA.Value := Query.Fields[6].Value;
        cds_LocalizacaoTEMPERATURA.Value := Query.Fields[7].Value;
        cds_Localizacao.Post;

        Query.Next;
      end;

      if Codigo > 0 then
        cds_Localizacao.Locate('ID', Codigo, []);

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados da Tela.', '', E.Message);
      end;
    end;

  finally
    cds_Localizacao.EnableControls;
    FreeAndNil(Query);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroLocalizacao.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroLocalizacao.Filtrar;
begin
  cds_Localizacao.Filtered := False;
  cds_Localizacao.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroLocalizacao.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroLocalizacao.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not cds_Localizacao.IsEmpty then begin
          if cds_Localizacao.RecNo > 1 then
            cds_Localizacao.Prior;
        end;
      end;
      VK_DOWN : begin
        if not cds_Localizacao.IsEmpty then begin
          if cds_Localizacao.RecNo < cds_Localizacao.RecordCount then
            cds_Localizacao.Next;
        end;
      end;
    end;
  end else begin
    case Key of
      VK_ESCAPE : Cancelar;
    end;
  end;
end;

procedure TfrmCadastroLocalizacao.FormShow(Sender: TObject);
begin
  cds_Localizacao.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroLocalizacao.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroLocalizacao.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edSala.CanFocus then
      edSala.SetFocus;
  end;
end;

end.
