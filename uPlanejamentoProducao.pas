unit uPlanejamentoProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons,
  Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  FireDAC.Comp.Client;

type
  TfrmPlanejamentoProducao = class(TForm)
    pnPrincipal: TPanel;
    PageControl1: TPageControl;
    TSRP: TTabSheet;
    TSMC: TTabSheet;
    TSNOP: TTabSheet;
    TSOPG: TTabSheet;
    Panel3: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    gdRecebimentoPlantas: TDBGrid;
    gdMeioCultura: TDBGrid;
    gdGerarOP: TDBGrid;
    gdOPGerada: TDBGrid;
    CDS_PLANTAS: TClientDataSet;
    CDS_MEIOCULTURA: TClientDataSet;
    CDS_NOVAOP: TClientDataSet;
    CDS_OPGERADA: TClientDataSet;
    DS_PLANTAS: TDataSource;
    DS_MEIOCULTURA: TDataSource;
    DS_NOVAOP: TDataSource;
    DS_OPGERADA: TDataSource;
    CDS_PLANTASID: TIntegerField;
    CDS_PLANTASDATA: TDateField;
    CDS_MEIOCULTURAID: TIntegerField;
    CDS_MEIOCULTURADATA: TDateField;
    CDS_NOVAOPID: TIntegerField;
    CDS_NOVAOPDATA: TDateField;
    CDS_PLANTASCLIENTE: TStringField;
    CDS_PLANTASESPECIE: TStringField;
    CDS_PLANTASABRIRCADASTRO: TIntegerField;
    CDS_MEIOCULTURACODIGOMC: TStringField;
    CDS_MEIOCULTURAVOLUMEFINAL: TStringField;
    CDS_MEIOCULTURAABRIROP: TIntegerField;
    CDS_MEIOCULTURAIMPRIMIROP: TIntegerField;
    CDS_NOVAOPESPECIE: TStringField;
    CDS_NOVAOPESTAGIOATUAL: TStringField;
    CDS_NOVAOPCODIGOMC: TStringField;
    CDS_OPGERADAID: TIntegerField;
    CDS_OPGERADADATA: TDateField;
    CDS_OPGERADAESPECIE: TStringField;
    CDS_OPGERADAESTAGIOATUAL: TStringField;
    CDS_OPGERADACODIGOMC: TStringField;
    CDS_NOVAOPIDOPF: TIntegerField;
    CDS_NOVAOPSALDOPOTES: TIntegerField;
    TSOPESOL: TTabSheet;
    gdOPESolEstoque: TDBGrid;
    Panel5: TPanel;
    CDS_ESOLESTOQUE: TClientDataSet;
    DS_ESOLESTOQUE: TDataSource;
    CDS_ESOLESTOQUEID: TIntegerField;
    CDS_ESOLESTOQUEDATA: TDateField;
    CDS_ESOLESTOQUESOLUCAO: TStringField;
    CDS_ESOLESTOQUEVOLUMEFINAL: TStringField;
    CDS_PLANTASSELECAOPOSITIVA: TStringField;
    CDS_PLANTASCODIGOSELECAOCAMPO: TStringField;
    Panel16: TPanel;
    SpeedButton5: TSpeedButton;
    Panel12: TPanel;
    SpeedButton3: TSpeedButton;
    Panel10: TPanel;
    SpeedButton2: TSpeedButton;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    Panel7: TPanel;
    SpeedButton4: TSpeedButton;
    btNovoRP: TSpeedButton;
    btAlterarRP: TSpeedButton;
    btExcluirRP: TSpeedButton;
    btExportarRP: TSpeedButton;
    btExportarOPMC: TSpeedButton;
    btExportarGNOP: TSpeedButton;
    btExportarOPG: TSpeedButton;
    btExportarOPSE: TSpeedButton;
    btNovoOPMC: TSpeedButton;
    btAlterarOPMC: TSpeedButton;
    btExcluirOPMC: TSpeedButton;
    btRelatorioOPMC: TSpeedButton;
    btRelatorioGNOP: TSpeedButton;
    btAlterarGNOP: TSpeedButton;
    btNovoGNOP: TSpeedButton;
    btRelatorioOPG: TSpeedButton;
    btAlterarOPG: TSpeedButton;
    btNovoOPG: TSpeedButton;
    btRelatorioOPSE: TSpeedButton;
    btExcluirOPSE: TSpeedButton;
    btAlterarOPSE: TSpeedButton;
    btNovoOPSE: TSpeedButton;
    gbFiltroRP: TGroupBox;
    edDataRP: TJvDateEdit;
    btConsultaRP: TBitBtn;
    edCodigoClienteRP: TButtonedEdit;
    edNomeClienteRP: TEdit;
    edDescricaoEspecieRP: TEdit;
    edCodigoEspecieRP: TButtonedEdit;
    gbFiltroOPMC: TGroupBox;
    edDataOPMC: TJvDateEdit;
    btConsultaOPMC: TBitBtn;
    edDescricaoMCOPMC: TEdit;
    edCodigoMCOPMC: TButtonedEdit;
    gbFiltroGNOP: TGroupBox;
    edDataGNOP: TJvDateEdit;
    btConsultaGNOP: TBitBtn;
    edCodigoEstagioGNOP: TButtonedEdit;
    edDescricaoEstagioGNOP: TEdit;
    edDescricaoEspecieGNOP: TEdit;
    edCodigoEspecieGNOP: TButtonedEdit;
    gbFiltroOPG: TGroupBox;
    edDataOPG: TJvDateEdit;
    btConsultaOPG: TBitBtn;
    edCodigoEstagioOPG: TButtonedEdit;
    edDescricaoEstagioOPG: TEdit;
    edDescricaoEspecieOPG: TEdit;
    edCodigoEspecieOPG: TButtonedEdit;
    gbFiltroOPSE: TGroupBox;
    edDataOPSE: TJvDateEdit;
    btConsultaOPSE: TBitBtn;
    edCodigoSolucaoOPSE: TButtonedEdit;
    edNomeSolucaoOPSE: TEdit;
    CDS_PLANTASVARIEDADE: TStringField;
    edCodigoVariedadeRP: TButtonedEdit;
    edNomeVariedadeRP: TEdit;
    edNomeVariedadeGNOP: TEdit;
    edCodigoVariedadeGNOP: TButtonedEdit;
    edNomeVariedadeOPG: TEdit;
    edCodigoVariedadeOPG: TButtonedEdit;
    CDS_NOVAOPVARIEDADE: TStringField;
    CDS_OPGERADAVARIEDADE: TStringField;
    TSIE: TTabSheet;
    Panel8: TPanel;
    GroupBox1: TGroupBox;
    edDataIE: TJvDateEdit;
    btConsultaIE: TBitBtn;
    edCodigoEstagioIE: TButtonedEdit;
    edDescricaoEstagioIE: TEdit;
    edDescricaoEspecieIE: TEdit;
    edCodigoEspecieIE: TButtonedEdit;
    edNomeVariedadeIE: TEdit;
    edCodigoVariedadeIE: TButtonedEdit;
    Panel9: TPanel;
    SpeedButton6: TSpeedButton;
    btExportarIE: TSpeedButton;
    btRelatorioIE: TSpeedButton;
    btAlterarIE: TSpeedButton;
    btNovoIE: TSpeedButton;
    gdIniciandoEstagio: TDBGrid;
    DS_INICIANDOESTAGIO: TDataSource;
    CDS_INICIANDOESTAGIO: TClientDataSet;
    CDS_INICIANDOESTAGIOID: TIntegerField;
    CDS_INICIANDOESTAGIOIDOPF: TIntegerField;
    CDS_INICIANDOESTAGIODATA: TDateField;
    CDS_INICIANDOESTAGIOESPECIE: TStringField;
    CDS_INICIANDOESTAGIOVARIEDADE: TStringField;
    CDS_INICIANDOESTAGIOESTAGIOATUAL: TStringField;
    CDS_INICIANDOESTAGIOCODIGOMC: TStringField;
    CDS_INICIANDOESTAGIOSALDOPOTES: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure gdGerarOPDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gdOPGeradaCellClick(Column: TColumn);
    procedure gdGerarOPCellClick(Column: TColumn);
    procedure gdRecebimentoPlantasTitleClick(Column: TColumn);
    procedure gdMeioCulturaTitleClick(Column: TColumn);
    procedure gdGerarOPTitleClick(Column: TColumn);
    procedure gdOPGeradaTitleClick(Column: TColumn);
    procedure gdOPESolEstoqueTitleClick(Column: TColumn);
    procedure btNovoRPClick(Sender: TObject);
    procedure btAlterarRPClick(Sender: TObject);
    procedure btExcluirRPClick(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
    procedure btNovoOPMCClick(Sender: TObject);
    procedure btAlterarOPMCClick(Sender: TObject);
    procedure btExcluirOPMCClick(Sender: TObject);
    procedure btRelatorioOPMCClick(Sender: TObject);
    procedure btAlterarGNOPClick(Sender: TObject);
    procedure btNovoGNOPClick(Sender: TObject);
    procedure btRelatorioGNOPClick(Sender: TObject);
    procedure btNovoOPGClick(Sender: TObject);
    procedure btAlterarOPGClick(Sender: TObject);
    procedure btRelatorioOPGClick(Sender: TObject);
    procedure btRelatorioOPSEClick(Sender: TObject);
    procedure btAlterarOPSEClick(Sender: TObject);
    procedure btExcluirOPSEClick(Sender: TObject);
    procedure btNovoOPSEClick(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure edCodigoClienteChange(Sender: TObject);
    procedure edCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoClienteRightButtonClick(Sender: TObject);
    procedure edCodigoEspecieChange(Sender: TObject);
    procedure edCodigoEspecieRightButtonClick(Sender: TObject);
    procedure edCodigoEspecieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioChange(Sender: TObject);
    procedure edCodigoEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoEstagioRightButtonClick(Sender: TObject);
    procedure edCodigoMCOPMCChange(Sender: TObject);
    procedure edCodigoMCOPMCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoMCOPMCRightButtonClick(Sender: TObject);
    procedure edCodigoSolucaoOPSEChange(Sender: TObject);
    procedure edCodigoSolucaoOPSEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoSolucaoOPSERightButtonClick(Sender: TObject);
    procedure edCodigoVariedadeChange(Sender: TObject);
    procedure edCodigoVariedadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoVariedadeRightButtonClick(Sender: TObject);
    procedure gdIniciandoEstagioCellClick(Column: TColumn);
    procedure gdIniciandoEstagioDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gdIniciandoEstagioTitleClick(Column: TColumn);
    procedure btRelatorioIEClick(Sender: TObject);
    procedure btAlterarIEClick(Sender: TObject);
    procedure btNovoIEClick(Sender: TObject);
  private
    procedure ConsultaDados;
    procedure AjustaGrid;
    procedure CarregarRecebimentoPlantas;
    procedure CarregarMeiodeCultura;
    procedure CarregarGerarNovaOP;
    procedure CarregarOPGerada;
    procedure CarregarESolEstoque;
    procedure CarregarIniciandoEstagio;
    procedure AtualizaABA;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlanejamentoProducao: TfrmPlanejamentoProducao;

implementation

uses
  uDMUtil,
  uConstantes,
  uFWConnection,
  uMensagem,
  uFuncoes,
  uOrdemProducao,
  uControleEstagioOPF,
  uOrdemProducaoMeioCultura,
  uOrdemProducaoSolucao,
  uDetalhesEstagio,
  uBeanOPFinal,
  uBeanOrdemProducaoMC, uBeanOrdemProducaoSolucao, uBeanCliente, uBeanProdutos,
  uBeanEstagio, uBeanVariedade;

{$R *.dfm}

{ TfrmAgendamento }

procedure TfrmPlanejamentoProducao.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlanejamentoProducao.btNovoGNOPClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('IDOPF')) then begin
        if not Assigned(frmControleEstagioOPF) then
          frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
        try
          frmControleEstagioOPF.Parametros.Codigo := Self.gdGerarOP.DataSource.DataSet.FindField('IDOPF').AsInteger;
          frmControleEstagioOPF.Parametros.Acao   := eNovo;
          frmControleEstagioOPF.ShowModal;
        finally
          FreeAndNil(frmControleEstagioOPF);
        end;
        AtualizaABA;
      end;

    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btNovoIEClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('IDOPF')) then begin
        if not Assigned(frmControleEstagioOPF) then
          frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
        try
          frmControleEstagioOPF.Parametros.Codigo := Self.gdIniciandoEstagio.DataSource.DataSet.FindField('IDOPF').AsInteger;
          frmControleEstagioOPF.Parametros.Acao   := eNovo;
          frmControleEstagioOPF.ShowModal;
        finally
          FreeAndNil(frmControleEstagioOPF);
        end;
        AtualizaABA;
      end;

    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btNovoOPGClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdOPGerada.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmControleEstagioOPF) then
          frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
        try
          frmControleEstagioOPF.Parametros.Codigo := 0;
          frmControleEstagioOPF.Parametros.Acao   := eNovo;
          frmControleEstagioOPF.ShowModal;
        finally
          FreeAndNil(frmControleEstagioOPF);
        end;
        AtualizaABA;
      end;

    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btNovoOPMCClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdMeioCultura.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmOrdemProducaoMeioCultura) then
          frmOrdemProducaoMeioCultura := TfrmOrdemProducaoMeioCultura.Create(nil);
        try
          frmOrdemProducaoMeioCultura.Parametros.Codigo  := 0;
          frmOrdemProducaoMeioCultura.Parametros.Acao    := eNovo;
          frmOrdemProducaoMeioCultura.ShowModal;
        finally
          FreeAndNil(frmOrdemProducaoMeioCultura);
        end;
        AtualizaABA;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btNovoOPSEClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdOPESolEstoque.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmOrdemProducaoSolucao) then
          frmOrdemProducaoSolucao := TfrmOrdemProducaoSolucao.Create(nil);
        try
          frmOrdemProducaoSolucao.Parametros.Codigo := 0;
          frmOrdemProducaoSolucao.Parametros.Acao   := eNovo;
          frmOrdemProducaoSolucao.ShowModal;
        finally
          FreeAndNil(frmOrdemProducaoSolucao);
        end;
        AtualizaABA;
      end;

    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btNovoRPClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdRecebimentoPlantas.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmOrdemProducao) then
          frmOrdemProducao := TfrmOrdemProducao.Create(nil);
        try
          frmOrdemProducao.Parametros.Codigo  := 0;
          frmOrdemProducao.Parametros.Acao    := eNovo;
          frmOrdemProducao.ShowModal;
        finally
          FreeAndNil(frmOrdemProducao);
        end;
        AtualizaABA;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btRelatorioGNOPClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdGerarOP.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('ID')) then
          ImprimirOPFE(Self.gdGerarOP.DataSource.DataSet.FindField('ID').AsInteger);
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btRelatorioIEClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdIniciandoEstagio.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('ID')) then
          ImprimirOPFE(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('ID').AsInteger);
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btRelatorioOPGClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdOPGerada.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdOPGerada.DataSource.DataSet.FindField('ID')) then
          ImprimirOPFE(Self.gdOPGerada.DataSource.DataSet.FindField('ID').AsInteger);
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btRelatorioOPMCClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdMeioCultura.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdMeioCultura.DataSource.DataSet.FindField('ID')) then
          ImprimirOPMC(Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger);
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btRelatorioOPSEClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdOPESolEstoque.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdOPESolEstoque.DataSource.DataSet.FindField('ID')) then
          ImprimirOPSOL(Self.gdOPESolEstoque.DataSource.DataSet.FindField('ID').AsInteger);
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.AjustaGrid;
begin
  if PageControl1.ActivePage = TSRP then
    AutoSizeDBGrid(gdRecebimentoPlantas)
  else
    if PageControl1.ActivePage = TSMC then
      AutoSizeDBGrid(gdMeioCultura)
    else
      if PageControl1.ActivePage = TSNOP then
        AutoSizeDBGrid(gdGerarOP)
      else
        if PageControl1.ActivePage = TSOPG then
          AutoSizeDBGrid(gdOPGerada)
        else
          if PageControl1.ActivePage = TSOPESOL then
            AutoSizeDBGrid(gdOPESolEstoque)
          else
            if PageControl1.ActivePage = TSIE then
              AutoSizeDBGrid(gdIniciandoEstagio);
end;

procedure TfrmPlanejamentoProducao.AtualizaABA;
begin
  if PageControl1.ActivePage = TSRP then
    CarregarRecebimentoPlantas
  else
    if PageControl1.ActivePage = TSMC then
      CarregarMeiodeCultura
    else
      if PageControl1.ActivePage = TSNOP then
        CarregarGerarNovaOP
      else
        if PageControl1.ActivePage = TSOPG then
          CarregarOPGerada
        else
          if PageControl1.ActivePage = TSOPESOL then
            CarregarESolEstoque
          else
            if PageControl1.ActivePage = TSIE then
              CarregarIniciandoEstagio;
end;

procedure TfrmPlanejamentoProducao.btAlterarGNOPClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try

      if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdGerarOP.DataSource.DataSet.IsEmpty then begin
          if not Assigned(frmControleEstagioOPF) then
            frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
          try
            frmControleEstagioOPF.Parametros.Codigo := Self.gdGerarOP.DataSource.DataSet.FindField('ID').AsInteger;
            frmControleEstagioOPF.Parametros.Acao   := eAlterar;
            frmControleEstagioOPF.ShowModal;
          finally
            FreeAndNil(frmControleEstagioOPF);
          end;
          AtualizaABA;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btAlterarIEClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try

      if Assigned(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdIniciandoEstagio.DataSource.DataSet.IsEmpty then begin
          if not Assigned(frmControleEstagioOPF) then
            frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
          try
            frmControleEstagioOPF.Parametros.Codigo := Self.gdIniciandoEstagio.DataSource.DataSet.FindField('ID').AsInteger;
            frmControleEstagioOPF.Parametros.Acao   := eAlterar;
            frmControleEstagioOPF.ShowModal;
          finally
            FreeAndNil(frmControleEstagioOPF);
          end;
          AtualizaABA;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btAlterarOPGClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdOPGerada.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdOPGerada.DataSource.DataSet.FindField('ID')) then begin
          if not Assigned(frmControleEstagioOPF) then
            frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
          try
            frmControleEstagioOPF.Parametros.Codigo := Self.gdOPGerada.DataSource.DataSet.FindField('ID').AsInteger;
            frmControleEstagioOPF.Parametros.Acao   := eAlterar;
            frmControleEstagioOPF.ShowModal;
          finally
            FreeAndNil(frmControleEstagioOPF);
          end;
          AtualizaABA;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btAlterarOPMCClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdMeioCultura.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdMeioCultura.DataSource.DataSet.IsEmpty then begin
          if not Assigned(frmOrdemProducaoMeioCultura) then
            frmOrdemProducaoMeioCultura := TfrmOrdemProducaoMeioCultura.Create(nil);
          try
            frmOrdemProducaoMeioCultura.Parametros.Codigo  := Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger;
            frmOrdemProducaoMeioCultura.Parametros.Acao    := eAlterar;
            frmOrdemProducaoMeioCultura.ShowModal;
          finally
            FreeAndNil(frmOrdemProducaoMeioCultura);
          end;
          AtualizaABA;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btAlterarOPSEClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if not Self.gdOPESolEstoque.DataSource.DataSet.IsEmpty then begin
        if Assigned(Self.gdOPESolEstoque.DataSource.DataSet.FindField('ID')) then begin
          if not Assigned(frmOrdemProducaoSolucao) then
            frmOrdemProducaoSolucao := TfrmOrdemProducaoSolucao.Create(nil);
          try
            frmOrdemProducaoSolucao.Parametros.Codigo := Self.gdOPESolEstoque.DataSource.DataSet.FindField('ID').AsInteger;
            frmOrdemProducaoSolucao.Parametros.Acao   := eAlterar;
            frmOrdemProducaoSolucao.ShowModal;
          finally
            FreeAndNil(frmOrdemProducaoSolucao);
          end;
          AtualizaABA;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btAlterarRPClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdRecebimentoPlantas.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdRecebimentoPlantas.DataSource.DataSet.IsEmpty then begin
          if not Assigned(frmOrdemProducao) then
            frmOrdemProducao := TfrmOrdemProducao.Create(nil);
          try
            frmOrdemProducao.Parametros.Codigo  := Self.gdRecebimentoPlantas.DataSource.DataSet.FieldByName('ID').AsInteger;
            frmOrdemProducao.Parametros.Acao    := eAlterar;
            frmOrdemProducao.ShowModal;
          finally
            FreeAndNil(frmOrdemProducao);
          end;
          AtualizaABA;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btConsultaClick(Sender: TObject);
begin
  if (Sender as TBitBtn).Tag = 0 then begin
    (Sender as TBitBtn).Tag := 1;
    try
      AtualizaABA;
    finally
      (Sender as TBitBtn).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btExcluirOPMCClick(Sender: TObject);
var
  FWC : TFWConnection;
  MC  : TORDEMPRODUCAOMC;
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdMeioCultura.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdMeioCultura.DataSource.DataSet.IsEmpty then begin
          if Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger > 0 then begin

            DisplayMsg(MSG_CONF, 'Excluir a Ordem de Produção Selecionada?');

            if ResultMsgModal = mrYes then begin

              try

                FWC := TFWConnection.Create;
                MC  := TORDEMPRODUCAOMC.Create(FWC);
                try

                  MC.SelectList('ID = ' + IntToStr(Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger));
                  if MC.Count > 0 then begin

                    if not TORDEMPRODUCAOMC(MC.Itens[0]).ENCERRADO.Value then begin

                      MC.ID.Value := TORDEMPRODUCAOMC(MC.Itens[0]).ID.Value;
                      MC.Delete;

                      FWC.Commit;

                      Self.gdMeioCultura.DataSource.DataSet.Delete;
                    end else begin
                      DisplayMsg(MSG_WAR, 'OP de Meio de Cultura Nº ' + IntToStr(Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger) + ' já Encerrada, Verifique!');
                      Exit;
                    end;
                  end else begin
                    DisplayMsg(MSG_WAR, 'OP de Meio de Cultura Nº ' + IntToStr(Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger) + ' não Encontrada, Verifique!');
                    Exit;
                  end;
                except
                  on E : Exception do begin
                    FWC.Rollback;
                    DisplayMsg(MSG_ERR, 'Erro ao Excluir a Ordem de Produção, Verifique!', '', E.Message);
                  end;
                end;
              finally
                FreeAndNil(MC);
                FreeAndNil(FWC);
              end;
            end;
          end;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btExcluirOPSEClick(Sender: TObject);
Var
  FWC : TFWConnection;
  SOL : TORDEMPRODUCAOSOLUCAO;
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdOPESolEstoque.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdOPESolEstoque.DataSource.DataSet.IsEmpty then begin
          if Self.gdOPESolEstoque.DataSource.DataSet.FieldByName('ID').AsInteger > 0 then begin

            DisplayMsg(MSG_CONF, 'Excluir a Solução Selecionada?');

            if ResultMsgModal = mrYes then begin

              try

                FWC := TFWConnection.Create;
                SOL := TORDEMPRODUCAOSOLUCAO.Create(FWC);
                try

                  SOL.ID.Value := Self.gdOPESolEstoque.DataSource.DataSet.FieldByName('ID').AsInteger;
                  SOL.Delete;

                  FWC.Commit;

                  Self.gdOPESolEstoque.DataSource.DataSet.Delete;

                except
                  on E : Exception do begin
                    FWC.Rollback;
                    DisplayMsg(MSG_ERR, 'Erro ao Excluir a Solução, Verifique!', '', E.Message);
                  end;
                end;
              finally
                FreeAndNil(SOL);
                FreeAndNil(FWC);
              end;
            end;
          end;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btExcluirRPClick(Sender: TObject);
Var
  FWC : TFWConnection;
  OP  : TOPFINAL;
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    try
      if Assigned(Self.gdRecebimentoPlantas.DataSource.DataSet.FindField('ID')) then begin
        if not Self.gdRecebimentoPlantas.DataSource.DataSet.IsEmpty then begin
          if Self.gdRecebimentoPlantas.DataSource.DataSet.FieldByName('ID').AsInteger > 0 then begin

            DisplayMsg(MSG_CONF, 'Excluir o Recebimento de Planta Selecionado?');

            if ResultMsgModal = mrYes then begin

              try

                FWC := TFWConnection.Create;
                OP  := TOPFINAL.Create(FWC);
                try

                  OP.ID.Value := Self.gdRecebimentoPlantas.DataSource.DataSet.FieldByName('ID').AsInteger;
                  OP.Delete;

                  FWC.Commit;

                  Self.gdRecebimentoPlantas.DataSource.DataSet.Delete;

                except
                  on E : Exception do begin
                    FWC.Rollback;
                    DisplayMsg(MSG_ERR, 'Erro ao Excluir o Recebimento de Planta.', '', E.Message);
                  end;
                end;
              finally
                FreeAndNil(OP);
                FreeAndNil(FWC);
              end;
            end;
          end;
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btExportarClick(Sender: TObject);
begin
  if (Sender as TSpeedButton).Tag = 0 then begin
    (Sender as TSpeedButton).Tag := 1;
    (Sender as TSpeedButton).Caption := 'Gerando...';
    Application.ProcessMessages;
    try

      if (Sender as TSpeedButton) = btExportarRP then begin
        if gdRecebimentoPlantas.DataSource.DataSet.IsEmpty then begin
          DisplayMsg(MSG_WAR, 'Não há Dados para Exportar, Verifique!');
          Exit;
        end;

        ExpDbGridXLS(gdRecebimentoPlantas, 'Recebimento de Plantas.xls');
      end else
        if (Sender as TSpeedButton) = btExportarOPMC then begin
          if gdMeioCultura.DataSource.DataSet.IsEmpty then begin
            DisplayMsg(MSG_WAR, 'Não há Dados para Exportar, Verifique!');
            Exit;
          end;

          ExpDbGridXLS(gdMeioCultura, 'Ordem de Produção MC.xls');
        end else
          if (Sender as TSpeedButton) = btExportarGNOP then begin
            if gdGerarOP.DataSource.DataSet.IsEmpty then begin
              DisplayMsg(MSG_WAR, 'Não há Dados para Exportar, Verifique!');
              Exit;
            end;

            ExpDbGridXLS(gdGerarOP, 'Gerar Nova OP.xls');
          end else
            if (Sender as TSpeedButton) = btExportarOPG then begin
              if gdOPGerada.DataSource.DataSet.IsEmpty then begin
                DisplayMsg(MSG_WAR, 'Não há Dados para Exportar, Verifique!');
                Exit;
              end;

              ExpDbGridXLS(gdOPGerada, 'OP Gerada.xls');
            end else
              if (Sender as TSpeedButton) = btExportarOPSE then begin
                if gdOPESolEstoque.DataSource.DataSet.IsEmpty then begin
                  DisplayMsg(MSG_WAR, 'Não há Dados para Exportar, Verifique!');
                  Exit;
                end;

                ExpDbGridXLS(gdOPESolEstoque, 'Ordem de Produção Solução Estoque.xls');
              end else
                if (Sender as TSpeedButton) = btExportarIE then begin
                  if gdIniciandoEstagio.DataSource.DataSet.IsEmpty then begin
                    DisplayMsg(MSG_WAR, 'Não há Dados para Exportar, Verifique!');
                    Exit;
                  end;

                  ExpDbGridXLS(gdIniciandoEstagio, 'Iniciando Estágio.xls');
                end;
    finally
      (Sender as TSpeedButton).Tag := 0;
      (Sender as TSpeedButton).Caption := 'E&xportar';
      Application.ProcessMessages;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.CarregarESolEstoque;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      CDS_ESOLESTOQUE.DisableControls;

      CDS_ESOLESTOQUE.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPS.ID,');
      Consulta.SQL.Add('	OPS.DATAPREVISAO AS DATA,');
      Consulta.SQL.Add('	P.DESCRICAO AS SOLUCAO,');
      Consulta.SQL.Add('	OPS.QUANTIDADE,');
      Consulta.SQL.Add('	UN.SIMBOLO');
      Consulta.SQL.Add('FROM ORDEMPRODUCAOSOLUCAO OPS');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPS.ID_PRODUTO)');
      Consulta.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON (UN.ID = P.UNIDADEMEDIDA_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND ((:CODIGOSOLUCAO = -1) OR (P.ID = :CODIGOSOLUCAO))');
      Consulta.SQL.Add('AND (CAST(OPS.DATAPREVISAO AS DATE) <= :DATA)');
      Consulta.SQL.Add('AND (OPS.ENCERRADO = FALSE)');
      Consulta.SQL.Add('ORDER BY OPS.DATAPREVISAO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('CODIGOSOLUCAO').DataType  := ftInteger;
      Consulta.ParamByName('DATA').DataType           := ftDate;
      Consulta.ParamByName('CODIGOSOLUCAO').Value     := StrToIntDef(edCodigoSolucaoOPSE.Text, -1);;
      Consulta.ParamByName('DATA').Value              := edDataOPSE.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin
          CDS_ESOLESTOQUE.Append;
          CDS_ESOLESTOQUEID.Value           := Consulta.FieldByName('ID').AsInteger;
          CDS_ESOLESTOQUEDATA.Value         := Consulta.FieldByName('DATA').AsDateTime;
          CDS_ESOLESTOQUESOLUCAO.Value      := Consulta.FieldByName('SOLUCAO').AsString;
          CDS_ESOLESTOQUEVOLUMEFINAL.Value  := Consulta.FieldByName('QUANTIDADE').AsString + ' ' + Consulta.FieldByName('SIMBOLO').AsString;
          CDS_ESOLESTOQUE.Post;
          Consulta.Next;
        end;
      end;

      TSOPESOL.Caption    := 'Ordem de Produção de Solução Estoque (' + IntToStr(Consulta.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta das Produções da Solução Estoque!', '', E.Message);
      end;
    end;
  finally
    CDS_ESOLESTOQUE.EnableControls;
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.CarregarGerarNovaOP;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  ConsultaPotes : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);
  ConsultaPotes := TFDQuery.Create(nil);

  try
    try

      CDS_NOVAOP.DisableControls;

      CDS_NOVAOP.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPFE.ID AS IDOPFE,');
      Consulta.SQL.Add('	OPF.ID AS IDOPF,');
      Consulta.SQL.Add('	OPFE.PREVISAOTERMINO AS DATA,');
      Consulta.SQL.Add('	P.DESCRICAO || '' - '' || OPF.ID AS ESPECIE,');
      Consulta.SQL.Add('	V.NOME AS VARIEDADE,');
      Consulta.SQL.Add('	E.DESCRICAO AS ESTAGIOATUAL,');
      Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND (OPF.CANCELADO = FALSE)');
      Consulta.SQL.Add('AND ((:CODIGOESPECIE = -1) OR (P.ID = :CODIGOESPECIE))');
      Consulta.SQL.Add('AND ((:CODIGOESTAGIO = -1) OR (E.ID = :CODIGOESTAGIO))');
      Consulta.SQL.Add('AND ((:CODIGOVARIEDADE = -1) OR (V.ID = :CODIGOVARIEDADE))');
      Consulta.SQL.Add('AND CAST(OPFE.PREVISAOTERMINO AS DATE) <= :DATA');
      Consulta.SQL.Add('ORDER BY OPFE.PREVISAOTERMINO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('CODIGOESPECIE').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOESTAGIO').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOVARIEDADE').DataType:= ftInteger;
      Consulta.ParamByName('DATA').DataType           := ftDate;
      Consulta.ParamByName('CODIGOESPECIE').Value     := StrToIntDef(edCodigoEspecieGNOP.Text, -1);
      Consulta.ParamByName('CODIGOESTAGIO').Value     := StrToIntDef(edCodigoEstagioGNOP.Text, -1);
      Consulta.ParamByName('CODIGOVARIEDADE').Value   := StrToIntDef(edCodigoVariedadeGNOP.Text, -1);
      Consulta.ParamByName('DATA').Value              := edDataGNOP.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin

        Consulta.First;

        ConsultaPotes.Close;
        ConsultaPotes.SQL.Clear;
        ConsultaPotes.SQL.Add('SELECT');
        ConsultaPotes.SQL.Add('	COUNT(OPFELS.ID) AS SALDOPOTES');
        ConsultaPotes.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
        ConsultaPotes.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
        ConsultaPotes.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
        ConsultaPotes.SQL.Add('WHERE 1 = 1');
        ConsultaPotes.SQL.Add('AND OPFELS.BAIXADO = FALSE');
        ConsultaPotes.SQL.Add('AND OPFE.ID = :IDOPFE');
        ConsultaPotes.Connection  := FWC.FDConnection;

        while not Consulta.Eof do begin

          ConsultaPotes.Close;
          ConsultaPotes.ParamByName('IDOPFE').DataType  := ftInteger;
          ConsultaPotes.ParamByName('IDOPFE').Value     := Consulta.FieldByName('IDOPFE').AsInteger;
          ConsultaPotes.Prepare;
          ConsultaPotes.Open;
          ConsultaPotes.FetchAll;
          if not ConsultaPotes.IsEmpty then begin
            if ConsultaPotes.FieldByName('SALDOPOTES').AsInteger > 0 then begin
              CDS_NOVAOP.Append;
              CDS_NOVAOPID.Value            := Consulta.FieldByName('IDOPFE').AsInteger;
              CDS_NOVAOPIDOPF.Value         := Consulta.FieldByName('IDOPF').AsInteger;
              CDS_NOVAOPDATA.Value          := Consulta.FieldByName('DATA').AsDateTime;
              CDS_NOVAOPESPECIE.Value       := Consulta.FieldByName('ESPECIE').AsString;
              CDS_NOVAOPVARIEDADE.Value     := Consulta.FieldByName('VARIEDADE').AsString;
              CDS_NOVAOPESTAGIOATUAL.Value  := Consulta.FieldByName('ESTAGIOATUAL').AsString;
              CDS_NOVAOPCODIGOMC.Value      := Consulta.FieldByName('CODIGOMC').AsString;
              CDS_NOVAOPSALDOPOTES.Value    := ConsultaPotes.FieldByName('SALDOPOTES').AsInteger;
              CDS_NOVAOP.Post;
            end;
          end;
          Consulta.Next;
        end;
      end;

      TSNOP.Caption    := 'Finalizando Estágio (Gerar Nova OP) (' + IntToStr(CDS_NOVAOP.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta Finalizando Estágio!', '', E.Message);
      end;
    end;
  finally
    CDS_NOVAOP.EnableControls;
    FreeAndNil(ConsultaPotes);
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.CarregarIniciandoEstagio;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  ConsultaPotes : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);
  ConsultaPotes := TFDQuery.Create(nil);

  try
    try

      CDS_INICIANDOESTAGIO.DisableControls;

      CDS_INICIANDOESTAGIO.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPFE.ID AS IDOPFE,');
      Consulta.SQL.Add('	OPF.ID AS IDOPF,');
      Consulta.SQL.Add('	OPFE.DATAHORAINICIO AS DATA,');
      Consulta.SQL.Add('	P.DESCRICAO || '' - '' || OPF.ID AS ESPECIE,');
      Consulta.SQL.Add('	V.NOME AS VARIEDADE,');
      Consulta.SQL.Add('	E.DESCRICAO AS ESTAGIOATUAL,');
      Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND (OPF.CANCELADO = FALSE)');
      Consulta.SQL.Add('AND OPFE.DATAHORAINICIO IS NOT NULL');
      Consulta.SQL.Add('AND ((:CODIGOESPECIE = -1) OR (P.ID = :CODIGOESPECIE))');
      Consulta.SQL.Add('AND ((:CODIGOESTAGIO = -1) OR (E.ID = :CODIGOESTAGIO))');
      Consulta.SQL.Add('AND ((:CODIGOVARIEDADE = -1) OR (V.ID = :CODIGOVARIEDADE))');
      Consulta.SQL.Add('AND CAST(OPFE.DATAHORAINICIO AS DATE) >= :DATA');
      Consulta.SQL.Add('ORDER BY OPFE.DATAHORAINICIO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('CODIGOESPECIE').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOESTAGIO').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOVARIEDADE').DataType:= ftInteger;
      Consulta.ParamByName('DATA').DataType           := ftDate;
      Consulta.ParamByName('CODIGOESPECIE').Value     := StrToIntDef(edCodigoEspecieIE.Text, -1);
      Consulta.ParamByName('CODIGOESTAGIO').Value     := StrToIntDef(edCodigoEstagioIE.Text, -1);
      Consulta.ParamByName('CODIGOVARIEDADE').Value   := StrToIntDef(edCodigoVariedadeIE.Text, -1);
      Consulta.ParamByName('DATA').Value              := edDataIE.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin

        Consulta.First;

        ConsultaPotes.Close;
        ConsultaPotes.SQL.Clear;
        ConsultaPotes.SQL.Add('SELECT');
        ConsultaPotes.SQL.Add('	COUNT(OPFELS.ID) AS SALDOPOTES');
        ConsultaPotes.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
        ConsultaPotes.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
        ConsultaPotes.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
        ConsultaPotes.SQL.Add('WHERE 1 = 1');
        ConsultaPotes.SQL.Add('AND OPFELS.BAIXADO = FALSE');
        ConsultaPotes.SQL.Add('AND OPFE.ID = :IDOPFE');
        ConsultaPotes.Connection  := FWC.FDConnection;

        while not Consulta.Eof do begin

          ConsultaPotes.Close;
          ConsultaPotes.ParamByName('IDOPFE').DataType  := ftInteger;
          ConsultaPotes.ParamByName('IDOPFE').Value     := Consulta.FieldByName('IDOPFE').AsInteger;
          ConsultaPotes.Prepare;
          ConsultaPotes.Open;
          ConsultaPotes.FetchAll;
          if not ConsultaPotes.IsEmpty then begin
            if ConsultaPotes.FieldByName('SALDOPOTES').AsInteger > 0 then begin
              CDS_INICIANDOESTAGIO.Append;
              CDS_INICIANDOESTAGIOID.Value            := Consulta.FieldByName('IDOPFE').AsInteger;
              CDS_INICIANDOESTAGIOIDOPF.Value         := Consulta.FieldByName('IDOPF').AsInteger;
              CDS_INICIANDOESTAGIODATA.Value          := Consulta.FieldByName('DATA').AsDateTime;
              CDS_INICIANDOESTAGIOESPECIE.Value       := Consulta.FieldByName('ESPECIE').AsString;
              CDS_INICIANDOESTAGIOVARIEDADE.Value     := Consulta.FieldByName('VARIEDADE').AsString;
              CDS_INICIANDOESTAGIOESTAGIOATUAL.Value  := Consulta.FieldByName('ESTAGIOATUAL').AsString;
              CDS_INICIANDOESTAGIOCODIGOMC.Value      := Consulta.FieldByName('CODIGOMC').AsString;
              CDS_INICIANDOESTAGIOSALDOPOTES.Value    := ConsultaPotes.FieldByName('SALDOPOTES').AsInteger;
              CDS_INICIANDOESTAGIO.Post;
            end;
          end;
          Consulta.Next;
        end;
      end;

      TSIE.Caption    := 'Iniciando Estágio (' + IntToStr(CDS_INICIANDOESTAGIO.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta Iniciando Estágio!', '', E.Message);
      end;
    end;
  finally
    CDS_INICIANDOESTAGIO.EnableControls;
    FreeAndNil(ConsultaPotes);
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.CarregarMeiodeCultura;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      CDS_MEIOCULTURA.DisableControls;

      CDS_MEIOCULTURA.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPMC.ID,');
      Consulta.SQL.Add('	OPMC.DATAINICIO AS DATA,');
      Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC,');
      Consulta.SQL.Add('	OPMC.QUANTPRODUTO,');
      Consulta.SQL.Add('	UN.SIMBOLO');
      Consulta.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPMC.ID_PRODUTO)');
      Consulta.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON (UN.ID = P.UNIDADEMEDIDA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = P.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND ((:CODIGOMC = -1) OR (MC.ID_PRODUTO = :CODIGOMC))');
      Consulta.SQL.Add('AND CAST(OPMC.DATAINICIO AS DATE) <= :DATA');
      Consulta.SQL.Add('AND OPMC.ENCERRADO = False');
      Consulta.SQL.Add('ORDER BY OPMC.DATAINICIO ASC');

      Consulta.Connection                    := FWC.FDConnection;

      Consulta.ParamByName('CODIGOMC').DataType := ftInteger;
      Consulta.ParamByName('DATA').DataType     := ftDate;
      Consulta.ParamByName('CODIGOMC').Value    := StrToIntDef(edCodigoMCOPMC.Text, -1);
      Consulta.ParamByName('DATA').Value        := edDataOPMC.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin
          CDS_MEIOCULTURA.Append;
          CDS_MEIOCULTURAID.Value           := Consulta.FieldByName('ID').AsInteger;
          CDS_MEIOCULTURADATA.Value         := Consulta.FieldByName('DATA').AsDateTime;
          CDS_MEIOCULTURACODIGOMC.Value     := Consulta.FieldByName('CODIGOMC').AsString;
          CDS_MEIOCULTURAVOLUMEFINAL.Value  := Consulta.FieldByName('QUANTPRODUTO').AsString + ' ' + Consulta.FieldByName('SIMBOLO').AsString;
          CDS_MEIOCULTURAABRIROP.Value      := 0;
          CDS_MEIOCULTURAIMPRIMIROP.Value   := 0;
          CDS_MEIOCULTURA.Post;
          Consulta.Next;
        end;
      end;

      TSMC.Caption    := 'Ordem de Produção do Meio de Cultura (' + IntToStr(Consulta.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta das Produções do Meio de Cultura!', '', E.Message);
      end;
    end;
  finally
    CDS_MEIOCULTURA.EnableControls;
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.CarregarOPGerada;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      CDS_OPGERADA.DisableControls;

      CDS_OPGERADA.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPFE.ID,');
      Consulta.SQL.Add('	OPFE.PREVISAOINICIO AS DATA,');
      Consulta.SQL.Add('	P.DESCRICAO || '' - '' || OPF.ID AS ESPECIE,');
      Consulta.SQL.Add('	V.NOME AS VARIEDADE,');
      Consulta.SQL.Add('	E.DESCRICAO AS ESTAGIOPREVISTO,');
      Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND (OPF.CANCELADO = FALSE)');
      Consulta.SQL.Add('AND ((:CODIGOESPECIE = -1) OR (P.ID = :CODIGOESPECIE))');
      Consulta.SQL.Add('AND ((:CODIGOESTAGIO = -1) OR (E.ID = :CODIGOESTAGIO))');
      Consulta.SQL.Add('AND ((:CODIGOVARIEDADE = -1) OR (V.ID = :CODIGOVARIEDADE))');
      Consulta.SQL.Add('AND (CAST(OPFE.PREVISAOINICIO AS DATE) <= :DATA)');
      Consulta.SQL.Add('AND (OPFE.DATAHORAFIM IS NULL)');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO_LOTE OPFEL WHERE OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      Consulta.SQL.Add('ORDER BY OPFE.PREVISAOINICIO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('CODIGOESPECIE').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOESTAGIO').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOVARIEDADE').DataType:= ftInteger;
      Consulta.ParamByName('DATA').DataType           := ftDate;
      Consulta.ParamByName('CODIGOESPECIE').Value     := StrToIntDef(edCodigoEspecieOPG.Text, -1);
      Consulta.ParamByName('CODIGOESTAGIO').Value     := StrToIntDef(edCodigoEstagioOPG.Text, -1);
      Consulta.ParamByName('CODIGOVARIEDADE').Value   := StrToIntDef(edCodigoVariedadeOPG.Text, -1);
      Consulta.ParamByName('DATA').Value              := edDataOPG.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin
          CDS_OPGERADA.Append;
          CDS_OPGERADAID.Value            := Consulta.FieldByName('ID').AsInteger;
          CDS_OPGERADADATA.Value          := Consulta.FieldByName('DATA').AsDateTime;
          CDS_OPGERADAESPECIE.Value       := Consulta.FieldByName('ESPECIE').AsString;
          CDS_OPGERADAVARIEDADE.Value     := Consulta.FieldByName('VARIEDADE').AsString;
          CDS_OPGERADAESTAGIOATUAL.Value  := Consulta.FieldByName('ESTAGIOPREVISTO').AsString;
          CDS_OPGERADACODIGOMC.Value      := Consulta.FieldByName('CODIGOMC').AsString;
          CDS_OPGERADA.Post;
          Consulta.Next;
        end;
      end;

      TSOPG.Caption    := 'Novo Estágio (OP Gerada) (' + IntToStr(Consulta.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta do Novo Estágio!', '', E.Message);
      end;
    end;
  finally
    CDS_OPGERADA.EnableControls;
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.CarregarRecebimentoPlantas;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      CDS_PLANTAS.DisableControls;

      CDS_PLANTAS.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPF.ID,');
      Consulta.SQL.Add('	OPF.DATAESTIMADAPROCESSAMENTO AS DATA,');
      Consulta.SQL.Add('	C.NOME AS CLIENTE,');
      Consulta.SQL.Add('	P.DESCRICAO || '' - '' || OPF.ID AS ESPECIE,');
      Consulta.SQL.Add('	V.NOME AS VARIEDADE,');
      Consulta.SQL.Add('	OPF.SELECAOPOSITIVA AS SELECAOPOSITIVA,');
      Consulta.SQL.Add('	OPF.CODIGOSELECAOCAMPO AS CODIGOSELECAOCAMPO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN VARIEDADE V ON (V.ID = OPF.ID_VARIEDADE)');
      Consulta.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
      Consulta.SQL.Add('AND OPF.DATAESTIMADAPROCESSAMENTO IS NOT NULL');
      Consulta.SQL.Add('AND ((:CODIGOCLIENTE = -1) OR (C.ID = :CODIGOCLIENTE))');
      Consulta.SQL.Add('AND ((:CODIGOESPECIE = -1) OR (P.ID = :CODIGOESPECIE))');
      Consulta.SQL.Add('AND ((:CODIGOVARIEDADE = -1) OR (V.ID = :CODIGOVARIEDADE))');
      Consulta.SQL.Add('AND CAST(OPF.DATAESTIMADAPROCESSAMENTO AS DATE) <= :DATA');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO OPFE WHERE OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('ORDER BY OPF.DATAESTIMADAPROCESSAMENTO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('CODIGOCLIENTE').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOESPECIE').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOVARIEDADE').DataType:= ftInteger;
      Consulta.ParamByName('DATA').DataType           := ftDate;
      Consulta.ParamByName('CODIGOCLIENTE').Value     := StrToIntDef(edCodigoClienteRP.Text, -1);
      Consulta.ParamByName('CODIGOESPECIE').Value     := StrToIntDef(edCodigoEspecieRP.Text, -1);
      Consulta.ParamByName('CODIGOVARIEDADE').Value   := StrToIntDef(edCodigoVariedadeRP.Text, -1);
      Consulta.ParamByName('DATA').Value              := edDataRP.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin
          CDS_PLANTAS.Append;
          CDS_PLANTASID.Value                 := Consulta.FieldByName('ID').AsInteger;
          CDS_PLANTASCLIENTE.Value            := Consulta.FieldByName('CLIENTE').AsString;
          CDS_PLANTASESPECIE.Value            := Consulta.FieldByName('ESPECIE').AsString;
          CDS_PLANTASVARIEDADE.Value          := Consulta.FieldByName('VARIEDADE').AsString;
          CDS_PLANTASSELECAOPOSITIVA.Value    := Consulta.FieldByName('SELECAOPOSITIVA').AsString;
          CDS_PLANTASCODIGOSELECAOCAMPO.Value := Consulta.FieldByName('CODIGOSELECAOCAMPO').AsString;
          CDS_PLANTASDATA.Value               := Consulta.FieldByName('DATA').AsDateTime;
          CDS_PLANTASABRIRCADASTRO.Value      := 0;
          CDS_PLANTAS.Post;
          Consulta.Next;
        end;
      end;

      TSRP.Caption    := 'Cadastro e Recebimento de Plantas (' + IntToStr(Consulta.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta de Recebimento de Plantas!', '', E.Message);
      end;
    end;
  finally
    CDS_PLANTAS.EnableControls;
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.ConsultaDados;
begin
  CarregarRecebimentoPlantas;
  CarregarMeiodeCultura;
  CarregarGerarNovaOP;
  CarregarOPGerada;
  CarregarESolEstoque;
  CarregarIniciandoEstagio;
end;

procedure TfrmPlanejamentoProducao.edCodigoClienteChange(Sender: TObject);
begin
  if (Sender as TButtonedEdit) = edCodigoClienteRP then
    edNomeClienteRP.Clear;
end;

procedure TfrmPlanejamentoProducao.edCodigoClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoClienteRightButtonClick(Sender);
end;

procedure TfrmPlanejamentoProducao.edCodigoClienteRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  C   : TCLIENTE;
begin
  FWC := TFWConnection.Create;
  C   := TCLIENTE.Create(FWC);

  try
    (Sender as TButtonedEdit).Text := IntToStr(DMUtil.Selecionar(C, (Sender as TButtonedEdit).Text));
    C.SelectList('id = ' + (Sender as TButtonedEdit).Text);
    if C.Count = 1 then begin
      if (Sender as TButtonedEdit) = edCodigoClienteRP then
        edNomeClienteRP.Text := TCLIENTE(C.Itens[0]).NOME.asString;
    end;
  finally
    FreeAndNil(C);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.edCodigoVariedadeChange(Sender: TObject);
begin
  if (Sender as TButtonedEdit) = edCodigoVariedadeRP then
    edNomeVariedadeRP.Clear
  else
    if (Sender as TButtonedEdit) = edCodigoVariedadeGNOP then
      edNomeVariedadeGNOP.Clear
    else
      if (Sender as TButtonedEdit) = edCodigoVariedadeOPG then
        edNomeVariedadeOPG.Clear
      else
        if (Sender as TButtonedEdit) = edCodigoVariedadeIE then
          edNomeVariedadeIE.Clear;
end;

procedure TfrmPlanejamentoProducao.edCodigoVariedadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoVariedadeRightButtonClick(Sender);
end;

procedure TfrmPlanejamentoProducao.edCodigoVariedadeRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  V   : TVARIEDADE;
begin

  FWC := TFWConnection.Create;
  V   := TVARIEDADE.Create(FWC);

  try

    (Sender as TButtonedEdit).Tag := DMUtil.Selecionar(V, (Sender as TButtonedEdit).Text, '');
    if (Sender as TButtonedEdit).Tag > 0 then begin
      V.SelectList('id = ' + IntToStr((Sender as TButtonedEdit).Tag));
      if V.Count > 0 then begin
        if (Sender as TButtonedEdit) = edCodigoVariedadeRP then begin
          edCodigoVariedadeRP.Text := TVARIEDADE(V.Itens[0]).ID.asString;
          edNomeVariedadeRP.Text   := TVARIEDADE(V.Itens[0]).NOME.asString;
        end else
          if (Sender as TButtonedEdit) = edCodigoVariedadeGNOP then begin
            edCodigoVariedadeGNOP.Text  := TVARIEDADE(V.Itens[0]).ID.asString;
            edNomeVariedadeGNOP.Text    := TVARIEDADE(V.Itens[0]).NOME.asString;
          end else
            if (Sender as TButtonedEdit) = edCodigoVariedadeOPG then begin
              edCodigoVariedadeOPG.Text := TVARIEDADE(V.Itens[0]).ID.asString;
              edNomeVariedadeOPG.Text   := TVARIEDADE(V.Itens[0]).NOME.asString;
            end else
              if (Sender as TButtonedEdit) = edCodigoVariedadeIE then begin
                edCodigoVariedadeIE.Text := TVARIEDADE(V.Itens[0]).ID.asString;
                edNomeVariedadeIE.Text   := TVARIEDADE(V.Itens[0]).NOME.asString;
              end;
      end;
    end else
      edCodigoVariedadeChange(Sender);
  finally
    FreeAndNil(V);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.edCodigoEspecieChange(Sender: TObject);
begin
  if (Sender as TButtonedEdit) = edCodigoEspecieRP then
    edDescricaoEspecieRP.Clear
  else
    if (Sender as TButtonedEdit) = edCodigoEspecieGNOP then
      edDescricaoEspecieGNOP.Clear
    else
      if (Sender as TButtonedEdit) = edCodigoEspecieOPG then
        edDescricaoEspecieOPG.Clear
      else
        if (Sender as TButtonedEdit) = edCodigoEspecieIE then
          edDescricaoEspecieIE.Clear;
end;

procedure TfrmPlanejamentoProducao.edCodigoEspecieRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  try

    Filtro := 'finalidade = 1';
    (Sender as TButtonedEdit).Tag := DMUtil.Selecionar(P, (Sender as TButtonedEdit).Text, Filtro);
    if (Sender as TButtonedEdit).Tag > 0 then begin
      P.SelectList('id = ' + IntToStr((Sender as TButtonedEdit).Tag));
      if P.Count = 1 then begin
        if (Sender as TButtonedEdit) = edCodigoEspecieRP then begin
          edCodigoEspecieRP.Text    := TPRODUTO(P.Itens[0]).ID.asString;
          edDescricaoEspecieRP.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
        end else
          if (Sender as TButtonedEdit) = edCodigoEspecieGNOP then begin
            edCodigoEspecieGNOP.Text    := TPRODUTO(P.Itens[0]).ID.asString;
            edDescricaoEspecieGNOP.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
          end else
            if (Sender as TButtonedEdit) = edCodigoEspecieOPG then begin
              edCodigoEspecieOPG.Text    := TPRODUTO(P.Itens[0]).ID.asString;
              edDescricaoEspecieOPG.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
            end else
              if (Sender as TButtonedEdit) = edCodigoEspecieIE then begin
                edCodigoEspecieIE.Text    := TPRODUTO(P.Itens[0]).ID.asString;
                edDescricaoEspecieIE.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
              end;
      end;
    end else
      edCodigoEspecieChange(Sender);
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.edCodigoEstagioChange(Sender: TObject);
begin
  if (Sender as TButtonedEdit) = edCodigoEstagioGNOP then
    edDescricaoEstagioGNOP.Clear
  else
    if (Sender as TButtonedEdit) = edCodigoEstagioOPG then
      edDescricaoEstagioOPG.Clear
    else
      if (Sender as TButtonedEdit) = edCodigoEstagioIE then
        edDescricaoEstagioIE.Clear;
end;

procedure TfrmPlanejamentoProducao.edCodigoEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoEstagioRightButtonClick(Sender);
end;

procedure TfrmPlanejamentoProducao.edCodigoEstagioRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  E   : TESTAGIO;
begin
  FWC := TFWConnection.Create;
  E   := TESTAGIO.Create(FWC);

  try

    (Sender as TButtonedEdit).Tag := DMUtil.Selecionar(E, (Sender as TButtonedEdit).Text);
    if (Sender as TButtonedEdit).Tag > 0 then begin
      E.SelectList('id = ' + IntToStr((Sender as TButtonedEdit).Tag));
      if E.Count = 1 then begin
        if (Sender as TButtonedEdit) = edCodigoEstagioGNOP then begin
          edCodigoEstagioGNOP.Text    := TESTAGIO(E.Itens[0]).ID.asString;
          edDescricaoEstagioGNOP.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
        end else
          if (Sender as TButtonedEdit) = edCodigoEstagioOPG then begin
            edCodigoEstagioOPG.Text    := TESTAGIO(E.Itens[0]).ID.asString;
            edDescricaoEstagioOPG.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
          end else
            if (Sender as TButtonedEdit) = edCodigoEstagioIE then begin
              edCodigoEstagioIE.Text    := TESTAGIO(E.Itens[0]).ID.asString;
              edDescricaoEstagioIE.Text := TESTAGIO(E.Itens[0]).DESCRICAO.asString;
            end;
      end;
    end else
      edCodigoEstagioChange(Sender);
  finally
    FreeAndNil(E);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.edCodigoMCOPMCChange(Sender: TObject);
begin
  edDescricaoMCOPMC.Clear;
end;

procedure TfrmPlanejamentoProducao.edCodigoMCOPMCKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoMCOPMCRightButtonClick(Sender);
end;

procedure TfrmPlanejamentoProducao.edCodigoMCOPMCRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  OPMC: TORDEMPRODUCAOMC;
  SQL : TFDQuery;
begin
  FWC := TFWConnection.Create;
  OPMC:= TORDEMPRODUCAOMC.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try

    (Sender as TButtonedEdit).Text := IntToStr(DMUtil.SelecionarMeioCultura(0 , 0, (Sender as TButtonedEdit).Text));

    if StrToIntDef((Sender as TButtonedEdit).Text, 0) > 0 then begin

      OPMC.SelectList('id = ' + IntToStr(StrToIntDef((Sender as TButtonedEdit).Text, 0)));

      if OPMC.Count > 0 then begin

        SQL.Close;
        SQL.SQL.Clear;
        SQL.SQL.Add('SELECT');
        SQL.SQL.Add('	P.ID,');
        SQL.SQL.Add('	P.DESCRICAO AS NOMEPRODUTO');
        SQL.SQL.Add('FROM PRODUTO P');
        SQL.SQL.Add('WHERE 1 = 1');
        SQL.SQL.Add('AND P.ID = :IDOPMC');
        SQL.Connection  := FWC.FDConnection;
        SQL.ParamByName('IDOPMC').DataType   := ftInteger;
        SQL.ParamByName('IDOPMC').AsInteger  := TORDEMPRODUCAOMC(OPMC.Itens[0]).ID_PRODUTO.Value;
        SQL.Prepare;
        SQL.Open;

        if not SQL.IsEmpty then
          edDescricaoMCOPMC.Text := SQL.FieldByName('NOMEPRODUTO').AsString;

      end;
    end;
  finally
    FreeAndNil(OPMC);
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.edCodigoSolucaoOPSEChange(Sender: TObject);
begin
  if (Sender as TButtonedEdit) = edCodigoSolucaoOPSE then
    edNomeSolucaoOPSE.Clear;
end;

procedure TfrmPlanejamentoProducao.edCodigoSolucaoOPSEKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoSolucaoOPSERightButtonClick(Sender);
end;

procedure TfrmPlanejamentoProducao.edCodigoSolucaoOPSERightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  P   : TPRODUTO;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  P      := TPRODUTO.Create(FWC);
  try
    Filtro := 'finalidade = 5';
    (Sender as TButtonedEdit).Tag := DMUtil.Selecionar(P, (Sender as TButtonedEdit).Text, Filtro);
    if (Sender as TButtonedEdit).Tag > 0 then begin
      P.SelectList('id = ' + IntToStr((Sender as TButtonedEdit).Tag));
      if P.Count > 0 then begin
        (Sender as TButtonedEdit).Text  := TPRODUTO(P.Itens[0]).ID.asString;
        edNomeSolucaoOPSE.Text          := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmPlanejamentoProducao.edCodigoEspecieKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoEspecieRightButtonClick(Sender);
end;

procedure TfrmPlanejamentoProducao.FormCreate(Sender: TObject);
begin
  CDS_PLANTAS.CreateDataSet;
  CDS_MEIOCULTURA.CreateDataSet;
  CDS_NOVAOP.CreateDataSet;
  CDS_OPGERADA.CreateDataSet;
  CDS_ESOLESTOQUE.CreateDataSet;
  CDS_INICIANDOESTAGIO.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmPlanejamentoProducao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
    VK_F5 : AtualizaABA;
  end;
end;

procedure TfrmPlanejamentoProducao.FormShow(Sender: TObject);
begin
  edDataRP.Date     := Date + 7;
  edDataOPMC.Date   := Date + 7;
  edDataGNOP.Date   := Date + 7;
  edDataOPG.Date    := Date + 7;
  edDataOPSE.Date   := Date + 7;
  edDataIE.Date     := Date - 7;
  ConsultaDados;
  AjustaGrid;
end;

procedure TfrmPlanejamentoProducao.gdGerarOPCellClick(Column: TColumn);
begin
  if gdGerarOP.SelectedField.FieldName = 'SALDOPOTES' then begin
    if not Self.gdGerarOP.DataSource.DataSet.IsEmpty then begin
      if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmDetalhesEstagio) then
          frmDetalhesEstagio := TfrmDetalhesEstagio.Create(nil);
        try
          frmDetalhesEstagio.Param.IDOPFE := Self.gdGerarOP.DataSource.DataSet.FindField('ID').AsInteger;

          frmDetalhesEstagio.Param.UNIDADES := 0;
          if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('SALDOPOTES')) then
            frmDetalhesEstagio.Param.UNIDADES := Self.gdGerarOP.DataSource.DataSet.FindField('SALDOPOTES').AsInteger;

          frmDetalhesEstagio.ShowModal;
        finally
          FreeAndNil(frmDetalhesEstagio);
        end;
        AtualizaABA;
      end;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdGerarOPDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if Pos(Column.FieldName, '|SALDOPOTES|') > 0 then begin
    gdGerarOP.Canvas.FillRect(Rect);
    BUTTON  := 0;
    R       := Rect;
    SCapt   := Column.Title.Caption;

    if Column.FieldName = 'SALDOPOTES' then begin
      if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('SALDOPOTES')) then
        SCapt := Self.gdGerarOP.DataSource.DataSet.FieldByName('SALDOPOTES').AsString;
    end;

    InflateRect(R,-2,-2); //Diminue o tamanho do Botão
    DrawFrameControl(gdGerarOP.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gdGerarOP.Canvas do begin
      Brush.Style := bsClear;
      Font.Color  := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdGerarOPTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmPlanejamentoProducao.gdIniciandoEstagioCellClick(Column: TColumn);
begin
  if gdIniciandoEstagio.SelectedField.FieldName = 'SALDOPOTES' then begin
    if not Self.gdIniciandoEstagio.DataSource.DataSet.IsEmpty then begin
      if Assigned(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmDetalhesEstagio) then
          frmDetalhesEstagio := TfrmDetalhesEstagio.Create(nil);
        try
          frmDetalhesEstagio.Param.IDOPFE := Self.gdIniciandoEstagio.DataSource.DataSet.FindField('ID').AsInteger;

          frmDetalhesEstagio.Param.UNIDADES := 0;
          if Assigned(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('SALDOPOTES')) then
            frmDetalhesEstagio.Param.UNIDADES := Self.gdIniciandoEstagio.DataSource.DataSet.FindField('SALDOPOTES').AsInteger;

          frmDetalhesEstagio.ShowModal;
        finally
          FreeAndNil(frmDetalhesEstagio);
        end;
        AtualizaABA;
      end;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdIniciandoEstagioDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if Pos(Column.FieldName, '|SALDOPOTES|') > 0 then begin
    gdIniciandoEstagio.Canvas.FillRect(Rect);
    BUTTON  := 0;
    R       := Rect;
    SCapt   := Column.Title.Caption;

    if Column.FieldName = 'SALDOPOTES' then begin
      if Assigned(Self.gdIniciandoEstagio.DataSource.DataSet.FindField('SALDOPOTES')) then
        SCapt := Self.gdIniciandoEstagio.DataSource.DataSet.FieldByName('SALDOPOTES').AsString;
    end;

    InflateRect(R,-2,-2); //Diminue o tamanho do Botão
    DrawFrameControl(gdIniciandoEstagio.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gdIniciandoEstagio.Canvas do begin
      Brush.Style := bsClear;
      Font.Color  := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdIniciandoEstagioTitleClick(
  Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmPlanejamentoProducao.gdMeioCulturaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmPlanejamentoProducao.gdOPESolEstoqueTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmPlanejamentoProducao.gdOPGeradaCellClick(Column: TColumn);
begin

  if gdOPGerada.SelectedField.FieldName = 'ABRIROP' then begin
    if Assigned(Self.gdOPGerada.DataSource.DataSet.FindField('ID')) then begin
      if not Assigned(frmControleEstagioOPF) then
        frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
      try
        frmControleEstagioOPF.Parametros.Codigo := Self.gdOPGerada.DataSource.DataSet.FindField('ID').AsInteger;
        frmControleEstagioOPF.Parametros.Acao   := eAlterar;
        frmControleEstagioOPF.ShowModal;
      finally
        FreeAndNil(frmControleEstagioOPF);
      end;
    end;
  end else begin
    if gdOPGerada.SelectedField.FieldName = 'IMPRIMIROP' then
      if Assigned(Self.gdOPGerada.DataSource.DataSet.FindField('ID')) then
        ImprimirOPFE(Self.gdOPGerada.DataSource.DataSet.FieldByName('ID').AsInteger);
  end;
end;

procedure TfrmPlanejamentoProducao.gdOPGeradaTitleClick(Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmPlanejamentoProducao.gdRecebimentoPlantasTitleClick(
  Column: TColumn);
begin
  OrdenarGrid(Column);
end;

procedure TfrmPlanejamentoProducao.PageControl1Change(Sender: TObject);
begin
  AjustaGrid;
end;

end.
