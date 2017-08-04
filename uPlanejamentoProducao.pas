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
    gbPrincipal: TGroupBox;
    edData: TJvDateEdit;
    btConsulta: TBitBtn;
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
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
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
    procedure btExportarRPClick(Sender: TObject);
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
  private
    procedure ConsultaDados;
    procedure AjustaGrid;
    procedure CarregarRecebimentoPlantas;
    procedure CarregarMeiodeCultura;
    procedure CarregarGerarNovaOP;
    procedure CarregarOPGerada;
    procedure CarregarESolEstoque;
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
  uBeanOrdemProducaoMC, uBeanOrdemProducaoSolucao;

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
      if Assigned(Self.gdGerarOP.DataSource.DataSet.FindField('ID')) then begin
        if not Assigned(frmControleEstagioOPF) then
          frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
        try
          frmControleEstagioOPF.Parametros.Codigo := 0;
          frmControleEstagioOPF.Parametros.Acao   := eNovo;
          frmControleEstagioOPF.ShowModal;
        finally
          FreeAndNil(frmControleEstagioOPF);
        end;
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
            AutoSizeDBGrid(gdOPESolEstoque);

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
        end;
      end;
    finally
      (Sender as TSpeedButton).Tag := 0;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.btConsultaClick(Sender: TObject);
begin
  if btConsulta.Tag = 0 then begin
    btConsulta.Tag := 1;
    try
      ConsultaDados;
    finally
      btConsulta.Tag := 0;
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

procedure TfrmPlanejamentoProducao.btExportarRPClick(Sender: TObject);
begin
  {if btExportarRP.Tag = 0 then begin
    btExportarRP.Tag := 1;
    try
      ExpXLS(cds_Pesquisa, Caption + '.xlsx');
    finally
      btExportarRP.Tag := 0;
    end;
  end;}
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
      Consulta.SQL.Add('AND CAST(OPS.DATAPREVISAO AS DATE) <= :DATA');
      Consulta.SQL.Add('AND OPS.ENCERRADO = FALSE');
      Consulta.SQL.Add('ORDER BY OPS.DATAPREVISAO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATA').DataType   := ftDate;
      Consulta.ParamByName('DATA').Value      := edData.Date;

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
      Consulta.SQL.Add('	E.DESCRICAO AS ESTAGIOATUAL,');
      Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND CAST(OPFE.PREVISAOTERMINO AS DATE) <= :DATA');
      Consulta.SQL.Add('ORDER BY OPFE.PREVISAOTERMINO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATA').DataType   := ftDate;
      Consulta.ParamByName('DATA').Value      := edData.Date;

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
      Consulta.SQL.Add('AND CAST(OPMC.DATAINICIO AS DATE) <= :DATA');
      Consulta.SQL.Add('AND OPMC.ENCERRADO = False');
      Consulta.SQL.Add('ORDER BY OPMC.DATAINICIO ASC');

      Consulta.Connection                    := FWC.FDConnection;

      Consulta.ParamByName('DATA').DataType  := ftDate;
      Consulta.ParamByName('DATA').Value     := edData.Date;

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
      Consulta.SQL.Add('	E.DESCRICAO AS ESTAGIOPREVISTO,');
      Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
      Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND CAST(OPFE.PREVISAOINICIO AS DATE) <= :DATA');
      Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO_LOTE OPFEL WHERE OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      Consulta.SQL.Add('ORDER BY OPFE.PREVISAOINICIO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATA').DataType   := ftDate;
      Consulta.ParamByName('DATA').Value      := edData.Date;

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
      Consulta.SQL.Add('	OPF.SELECAOPOSITIVA AS SELECAOPOSITIVA,');
      Consulta.SQL.Add('	OPF.CODIGOSELECAOCAMPO AS CODIGOSELECAOCAMPO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
      Consulta.SQL.Add('AND OPF.DATAESTIMADAPROCESSAMENTO IS NOT NULL');
      Consulta.SQL.Add('AND CAST(OPF.DATAESTIMADAPROCESSAMENTO AS DATE) <= :DATA');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO OPFE WHERE OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('ORDER BY OPF.DATAESTIMADAPROCESSAMENTO ASC');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATA').DataType   := ftDate;
      Consulta.ParamByName('DATA').Value      := edData.Date;

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
end;

procedure TfrmPlanejamentoProducao.FormCreate(Sender: TObject);
begin
  CDS_PLANTAS.CreateDataSet;
  CDS_MEIOCULTURA.CreateDataSet;
  CDS_NOVAOP.CreateDataSet;
  CDS_OPGERADA.CreateDataSet;
  CDS_ESOLESTOQUE.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmPlanejamentoProducao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
    VK_RETURN : begin
      if edData.Focused then
        ConsultaDados;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.FormShow(Sender: TObject);
begin
  edData.Date    := Date + 7;
  ConsultaDados;
  AjustaGrid;
end;

procedure TfrmPlanejamentoProducao.gdGerarOPCellClick(Column: TColumn);
begin
  if gdGerarOP.SelectedField.FieldName = 'SALDOPOTES' then begin
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
