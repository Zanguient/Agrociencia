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
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    Label1: TLabel;
    edDataFinal: TJvDateEdit;
    edDataInicial: TJvDateEdit;
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
    CDS_PLANTASPRODUTO: TStringField;
    CDS_PLANTASABRIRCADASTRO: TIntegerField;
    CDS_MEIOCULTURACODIGOMC: TStringField;
    CDS_MEIOCULTURAVOLUMEFINAL: TStringField;
    CDS_MEIOCULTURAABRIROP: TIntegerField;
    CDS_MEIOCULTURAIMPRIMIROP: TIntegerField;
    CDS_NOVAOPESPECIE: TStringField;
    CDS_NOVAOPESTAGIOATUAL: TStringField;
    CDS_NOVAOPCODIGOMC: TStringField;
    CDS_NOVAOPABRIROP: TIntegerField;
    CDS_NOVAOPGERAROP: TIntegerField;
    CDS_OPGERADAID: TIntegerField;
    CDS_OPGERADADATA: TDateField;
    CDS_OPGERADAESPECIE: TStringField;
    CDS_OPGERADAESTAGIOATUAL: TStringField;
    CDS_OPGERADACODIGOMC: TStringField;
    CDS_OPGERADAABRIROP: TIntegerField;
    CDS_OPGERADAIMPRIMIROP: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure gdRecebimentoPlantasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gdRecebimentoPlantasCellClick(Column: TColumn);
    procedure PageControl1Change(Sender: TObject);
    procedure gdMeioCulturaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gdMeioCulturaCellClick(Column: TColumn);
    procedure gdGerarOPDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gdOPGeradaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gdOPGeradaCellClick(Column: TColumn);
  private
    procedure ConsultaDados;
    procedure AjustaGrid;
    procedure CarregarRecebimentoPlantas;
    procedure CarregarMeiodeCultura;
    procedure CarregarGerarNovaOP;
    procedure CarregarOPGerada;
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
  uControleEstagioOPF;
{$R *.dfm}

{ TfrmAgendamento }

procedure TfrmPlanejamentoProducao.btFecharClick(Sender: TObject);
begin
  Close;
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
        AutoSizeDBGrid(gdOPGerada);
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

procedure TfrmPlanejamentoProducao.CarregarGerarNovaOP;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      CDS_NOVAOP.DisableControls;

      CDS_NOVAOP.EmptyDataSet;

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPFE.ID,');
      Consulta.SQL.Add('	OPFE.PREVISAOTERMINO AS DATA,');
      Consulta.SQL.Add('	P.DESCRICAO AS ESPECIE,');
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
      Consulta.SQL.Add('AND OPFE.PREVISAOTERMINO BETWEEN :DATAI AND :DATAF');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin
          CDS_NOVAOP.Append;
          CDS_NOVAOPID.Value            := Consulta.FieldByName('ID').AsInteger;
          CDS_NOVAOPDATA.Value          := Consulta.FieldByName('DATA').AsDateTime;
          CDS_NOVAOPESPECIE.Value       := Consulta.FieldByName('ESPECIE').AsString;
          CDS_NOVAOPESTAGIOATUAL.Value  := Consulta.FieldByName('ESTAGIOATUAL').AsString;
          CDS_NOVAOPCODIGOMC.Value      := Consulta.FieldByName('CODIGOMC').AsString;
          CDS_NOVAOPABRIROP.Value       := 0;
          CDS_NOVAOPGERAROP.Value       := 0;
          CDS_NOVAOP.Post;
          Consulta.Next;
        end;
      end;

      TSNOP.TabVisible := not Consulta.IsEmpty;
      TSNOP.Caption    := 'Finalizando Estágio (Gerar Nova OP) (' + IntToStr(Consulta.RecordCount) + ')';

    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta Finalizando Estágio!', '', E.Message);
      end;
    end;
  finally
    CDS_NOVAOP.EnableControls;
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
      Consulta.SQL.Add('AND OPMC.DATAINICIO BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('AND OPMC.ENCERRADO = False');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

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

      TSMC.TabVisible := not Consulta.IsEmpty;
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
      Consulta.SQL.Add('	P.DESCRICAO AS ESPECIE,');
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
      Consulta.SQL.Add('AND OPFE.PREVISAOINICIO BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('AND OPFE.DATAHORAFIM IS NULL');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO_LOTE OPFEL WHERE OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

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
          CDS_OPGERADAABRIROP.Value       := 0;
          CDS_OPGERADAIMPRIMIROP.Value    := 0;
          CDS_OPGERADA.Post;
          Consulta.Next;
        end;
      end;

      TSOPG.TabVisible := not Consulta.IsEmpty;
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
      Consulta.SQL.Add('');
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('	OPF.ID,');
      Consulta.SQL.Add('	OPF.DATAESTIMADAPROCESSAMENTO AS DATA,');
      Consulta.SQL.Add('	C.NOME AS CLIENTE,');
      Consulta.SQL.Add('	P.DESCRICAO AS PRODUTO');
      Consulta.SQL.Add('FROM OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      Consulta.SQL.Add('INNER JOIN CLIENTE C ON (C.ID = OPF.CLIENTE_ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
      Consulta.SQL.Add('AND OPF.DATAENCERRAMENTO IS NULL');
      Consulta.SQL.Add('AND OPF.DATAESTIMADAPROCESSAMENTO IS NOT NULL');
      Consulta.SQL.Add('AND OPF.DATAESTIMADAPROCESSAMENTO BETWEEN :DATAI AND :DATAF');
      Consulta.SQL.Add('AND NOT EXISTS (SELECT 1 FROM OPFINAL_ESTAGIO OPFE WHERE OPFE.OPFINAL_ID = OPF.ID)');

      Consulta.Connection                     := FWC.FDConnection;

      Consulta.ParamByName('DATAI').DataType  := ftDate;
      Consulta.ParamByName('DATAF').DataType  := ftDate;
      Consulta.ParamByName('DATAI').Value     := edDataInicial.Date;
      Consulta.ParamByName('DATAF').Value     := edDataFinal.Date;

      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        while not Consulta.Eof do begin
          CDS_PLANTAS.Append;
          CDS_PLANTASID.Value           := Consulta.FieldByName('ID').AsInteger;
          CDS_PLANTASCLIENTE.Value      := Consulta.FieldByName('CLIENTE').AsString;
          CDS_PLANTASPRODUTO.Value      := Consulta.FieldByName('PRODUTO').AsString;
          CDS_PLANTASDATA.Value         := Consulta.FieldByName('DATA').AsDateTime;
          CDS_PLANTASABRIRCADASTRO.Value:= 0;
          CDS_PLANTAS.Post;
          Consulta.Next;
        end;
      end;

      TSRP.TabVisible := not Consulta.IsEmpty;
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
end;

procedure TfrmPlanejamentoProducao.FormCreate(Sender: TObject);
begin
  CDS_PLANTAS.CreateDataSet;
  CDS_MEIOCULTURA.CreateDataSet;
  CDS_NOVAOP.CreateDataSet;
  CDS_OPGERADA.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmPlanejamentoProducao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmPlanejamentoProducao.FormShow(Sender: TObject);
begin
  edDataInicial.Date  := Date;
  edDataFinal.Date    := Date + 7;
  ConsultaDados;
  AjustaGrid;
end;

procedure TfrmPlanejamentoProducao.gdGerarOPDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if Pos(Column.FieldName, '|ABRIROP|GERAROP') > 0 then begin
    gdGerarOP.Canvas.FillRect(Rect);
    BUTTON  := 0;
    R       := Rect;
    SCapt   := Column.Title.Caption;
    InflateRect(R,-2,-2); //Diminue o tamanho do Botão
    DrawFrameControl(gdGerarOP.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gdGerarOP.Canvas do begin
      Brush.Style := bsClear;
      Font.Color  := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdMeioCulturaCellClick(Column: TColumn);
begin
  if gdMeioCultura.SelectedField.FieldName = 'IMPRIMIROP' then begin
    ImprimirOPMC(Self.gdMeioCultura.DataSource.DataSet.FieldByName('ID').AsInteger);
  end else begin
    if gdMeioCultura.SelectedField.FieldName = 'ABRIROP' then begin
      if not Assigned(frmControleEstagioOPF) then
        frmControleEstagioOPF := TfrmControleEstagioOPF.Create(nil);
      try
        frmControleEstagioOPF.ShowModal;
      finally
        FreeAndNil(frmControleEstagioOPF);
      end;
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdMeioCulturaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if Pos(Column.FieldName, '|ABRIROP|IMPRIMIROP') > 0 then begin
    gdMeioCultura.Canvas.FillRect(Rect);
    BUTTON  := 0;
    R       := Rect;
    SCapt   := Column.Title.Caption;
    InflateRect(R,-2,-2); //Diminue o tamanho do Botão
    DrawFrameControl(gdMeioCultura.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gdMeioCultura.Canvas do begin
      Brush.Style := bsClear;
      Font.Color  := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdOPGeradaCellClick(Column: TColumn);
begin
  if gdOPGerada.SelectedField.FieldName = 'IMPRIMIROP' then
    if Assigned(Self.gdOPGerada.DataSource.DataSet.FindField('ID')) then
      ImprimirOPFE(Self.gdOPGerada.DataSource.DataSet.FieldByName('ID').AsInteger);
end;

procedure TfrmPlanejamentoProducao.gdOPGeradaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if Pos(Column.FieldName, '|ABRIROP|IMPRIMIROP') > 0 then begin
    gdOPGerada.Canvas.FillRect(Rect);
    BUTTON  := 0;
    R       := Rect;
    SCapt   := Column.Title.Caption;
    InflateRect(R,-2,-2); //Diminue o tamanho do Botão
    DrawFrameControl(gdOPGerada.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gdOPGerada.Canvas do begin
      Brush.Style := bsClear;
      Font.Color  := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdRecebimentoPlantasCellClick(
  Column: TColumn);
begin
  if gdRecebimentoPlantas.SelectedField.FieldName = 'ABRIRCADASTRO' then begin
    if not Assigned(frmOrdemProducao) then
      frmOrdemProducao := TfrmOrdemProducao.Create(nil);
    try
      frmOrdemProducao.CodigoOPF := Self.gdRecebimentoPlantas.DataSource.DataSet.FieldByName('ID').AsInteger;
      frmOrdemProducao.ShowModal;
    finally
      FreeAndNil(frmOrdemProducao);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.gdRecebimentoPlantasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if Column.FieldName = 'ABRIRCADASTRO' then
  begin
    gdRecebimentoPlantas.Canvas.FillRect(Rect);
    BUTTON := 0;
    R := Rect;
    SCapt := 'Abrir Cadastro';
    InflateRect(R,-2,-2); //Diminue o tamanho do Botão
    DrawFrameControl(gdRecebimentoPlantas.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gdRecebimentoPlantas.Canvas do begin
      Brush.Style := bsClear;
      Font.Color := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);
    end;
  end;
end;

procedure TfrmPlanejamentoProducao.PageControl1Change(Sender: TObject);
begin
  AjustaGrid;
end;

end.
