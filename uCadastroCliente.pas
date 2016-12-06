unit uCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.TypInfo, System.Win.ComObj, Vcl.Samples.Gauges, JvExMask,
  JvToolEdit, JvBaseEdits;

type
  TfrmCadastroCliente = class(TForm)
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
    cds_PesquisaNOME: TStringField;
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
    edNome: TEdit;
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
    edCPFCNPJ: TEdit;
    Label1: TLabel;
    cds_PesquisaCPFCNPJ: TStringField;
    edTelefone: TEdit;
    Label4: TLabel;
    edCelular: TEdit;
    Label5: TLabel;
    edEmail: TEdit;
    Label6: TLabel;
    cds_PesquisaTELEFONE: TStringField;
    cds_PesquisaCELULAR: TStringField;
    cds_PesquisaEMAIL: TStringField;
    edObservacao: TEdit;
    Label7: TLabel;
    cds_PesquisaOBSERVACAO: TStringField;
    edCadProIE: TEdit;
    Label8: TLabel;
    cds_PesquisaCADPROIE: TStringField;
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
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  uDomains,
  uConstantes,
  uFWConnection,
  uBeanCliente,
  uMensagem,
  uFuncoes;

{$R *.dfm}

procedure TfrmCadastroCliente.AtualizarEdits(Limpar: Boolean);
begin
  if Limpar then begin
    edNome.Clear;
    edCPFCNPJ.Clear;
    edObservacao.Clear;
    edCodigoExterno.Clear;
    edCadProIE.Clear;
    btGravar.Tag  := 0;
  end else begin
    edNome.Text           := cds_PesquisaNOME.Value;
    edCPFCNPJ.Text        := cds_PesquisaCPFCNPJ.Value;
    edCodigoExterno.Text  := cds_PesquisaCODIGOEXTERNO.Value;
    edObservacao.Text     := cds_PesquisaOBSERVACAO.Value;
    edCadProIE.Text       := cds_PesquisaCADPROIE.Value;
    btGravar.Tag          := cds_PesquisaID.Value;
  end;
end;

procedure TfrmCadastroCliente.btAlterarClick(Sender: TObject);
begin
  if not cds_Pesquisa.IsEmpty then begin
    AtualizarEdits(False);
    InvertePaineis;
  end;
end;

procedure TfrmCadastroCliente.btCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroCliente.btExcluirClick(Sender: TObject);
Var
  FWC : TFWConnection;
  C   : TCLIENTE;
begin
  if not cds_Pesquisa.IsEmpty then begin

    DisplayMsg(MSG_CONF, 'Excluir o Cliente Selecionado?');

    if ResultMsgModal = mrYes then begin

      try

        FWC := TFWConnection.Create;
        C   := TCLIENTE.Create(FWC);
        try

          C.ID.Value := cds_PesquisaID.Value;
          C.Delete;

          FWC.Commit;

          cds_Pesquisa.Delete;

        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir o Cliente, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(C);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmCadastroCliente.btExportarClick(Sender: TObject);
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

procedure TfrmCadastroCliente.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroCliente.btGravarClick(Sender: TObject);
Var
  FWC : TFWConnection;
  C   : TCLIENTE;
begin

  FWC := TFWConnection.Create;
  C   := TCLIENTE.Create(FWC);

  try
    try

      if Length(Trim(edNome.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'Nome não informado, Verifique!');
        if edNome.CanFocus then
          edNome.SetFocus;
        Exit;
      end;

      if Length(Trim(edCPFCNPJ.Text)) = 0 then begin
        DisplayMsg(MSG_WAR, 'CPF/CNPJ não informado, Verifique!');
        if edCPFCNPJ.CanFocus then
          edCPFCNPJ.SetFocus;
        Exit;
      end else begin
        if not ValidaCPFCNPJ(edCPFCNPJ.Text) then begin
          DisplayMsg(MSG_WAR, 'CPF/CNPJ Inválido, Verifique!');
          if edCPFCNPJ.CanFocus then
            edCPFCNPJ.SetFocus;
          Exit;
        end;
      end;

      C.NOME.Value            := edNome.Text;
      C.CPFCNPJ.Value         := SoNumeros(edCPFCNPJ.Text);
      C.TELEFONE.Value        := edTelefone.Text;
      C.CELULAR.Value         := edCelular.Text;
      C.EMAIL.Value           := edCelular.Text;
      C.OBSERVACAO.Value      := edObservacao.Text;
      C.CODIGOEXTERNO.Value   := edCodigoExterno.Text;
      C.CADPROIE.Value        := edCadProIE.Text;

      if (Sender as TSpeedButton).Tag > 0 then begin
        C.ID.Value          := (Sender as TSpeedButton).Tag;
        C.Update;
      end else begin
        C.ID.isNull := True;
        C.Insert;
      end;

      FWC.Commit;

      InvertePaineis;

      CarregaDados;

    Except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Gravar o Cliente!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(C);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroCliente.btNovoClick(Sender: TObject);
begin
  AtualizarEdits(True);
  InvertePaineis;
end;

procedure TfrmCadastroCliente.Cancelar;
begin
  if cds_Pesquisa.State in [dsInsert, dsEdit] then
    cds_Pesquisa.Cancel;
  InvertePaineis;
end;

procedure TfrmCadastroCliente.CarregaDados;
Var
  FWC : TFWConnection;
  C   : TCLIENTE;
  I,
  Codigo  : Integer;
begin

  try
    FWC := TFWConnection.Create;
    C   := TCLIENTE.Create(FWC);
    cds_Pesquisa.DisableControls;
    try

      Codigo := cds_PesquisaID.Value;

      cds_Pesquisa.EmptyDataSet;

      C.SelectList('ID > 0', 'ID');
      if C.Count > 0 then begin
        for I := 0 to C.Count -1 do begin
          cds_Pesquisa.Append;
          cds_PesquisaID.Value            := TCLIENTE(C.Itens[I]).ID.Value;
          cds_PesquisaNOME.Value          := TCLIENTE(C.Itens[I]).NOME.Value;
          cds_PesquisaCPFCNPJ.Value       := TCLIENTE(C.Itens[I]).CPFCNPJ.Value;
          cds_PesquisaTELEFONE.Value      := TCLIENTE(C.Itens[I]).TELEFONE.Value;
          cds_PesquisaCELULAR.Value       := TCLIENTE(C.Itens[I]).CELULAR.Value;
          cds_PesquisaEMAIL.Value         := TCLIENTE(C.Itens[I]).EMAIL.Value;
          cds_PesquisaOBSERVACAO.Value    := TCLIENTE(C.Itens[I]).OBSERVACAO.Value;
          cds_PesquisaCODIGOEXTERNO.Value := TCLIENTE(C.Itens[I]).CODIGOEXTERNO.Value;
          cds_PesquisaCADPROIE.Value      := TCLIENTE(C.Itens[I]).CADPROIE.Value;
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
    FreeAndNil(C);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmCadastroCliente.csPesquisaFilterRecord(DataSet: TDataSet;
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

procedure TfrmCadastroCliente.Filtrar;
begin
  cds_Pesquisa.Filtered := False;
  cds_Pesquisa.Filtered := Length(edPesquisa.Text) > 0;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmCadastroCliente.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  cds_Pesquisa.CreateDataSet;
  CarregaDados;
  AutoSizeDBGrid(gdPesquisa);
end;

procedure TfrmCadastroCliente.gdPesquisaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmCadastroCliente.InvertePaineis;
begin
  pnVisualizacao.Visible        := not pnVisualizacao.Visible;
  pnBotoesVisualizacao.Visible  := pnVisualizacao.Visible;
  pnEdicao.Visible              := not pnEdicao.Visible;
  pnBotoesEdicao.Visible        := pnEdicao.Visible;
  if pnEdicao.Visible then begin
    if edNome.CanFocus then
      edNome.SetFocus;
  end;
end;

end.
