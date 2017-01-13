unit uControleMultiplicacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, Data.DB,
  Datasnap.DBClient;

type
  TControleProducao = (eIniciar, eContinuar, ePausar);

type
  TIntervalo = record
    DATAHORAINICIO : TDateTime;
    DATAHORAFIM : TDateTime;
  end;

type
  TMultiplicacao = record
    CODIGOOP : Integer;
    DATAHORAI: TDateTime;
    EMANDAMENTO: Boolean;
    INTERVALO: ARRAY OF TIntervalo;
  end;

type
  TfrmControleMultiplicacao = class(TForm)
    pnPrincipal: TPanel;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btFinalizar: TSpeedButton;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    btPausePlay: TSpeedButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    pnDados: TPanel;
    pnSuperior: TPanel;
    edNumeroLoteEstagio: TLabeledEdit;
    edCodigoOrdemProducao: TLabeledEdit;
    edNomeProduto: TLabeledEdit;
    cds_CodigoBarras: TClientDataSet;
    ds_CodigoBarras: TDataSource;
    cds_CodigoBarrasCODIGOBARRAS: TIntegerField;
    GridPanel1: TGridPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    gdCodigoBarras: TDBGrid;
    Panel4: TPanel;
    Label1: TLabel;
    edQuantidadeEntrada: TEdit;
    Panel5: TPanel;
    Label2: TLabel;
    edQuantidadeSaida: TEdit;
    Panel6: TPanel;
    rgEntrada: TRadioGroup;
    edCodigoEntrada: TLabeledEdit;
    Panel7: TPanel;
    rgSaida: TRadioGroup;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPausePlayClick(Sender: TObject);
    procedure btFinalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_CodigoBarrasDataChange(Sender: TObject; Field: TField);
  private
    MULTIPLICACAO : TMultiplicacao;
    procedure ExecutarEvento;
    procedure NovaMultiplicacao;
    procedure ControleProducao(Controle : TControleProducao);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleMultiplicacao: TfrmControleMultiplicacao;

implementation

uses
  uFuncoes,
  uFWConnection,
  uMensagem, uBeanOPFinal_Estagio;

{$R *.dfm}

{ TfrmControleMultiplicacao }

procedure TfrmControleMultiplicacao.btFecharClick(Sender: TObject);
begin
  if MULTIPLICACAO.CODIGOOP = 0 then
    Close
  else
    DisplayMsg(MSG_WAR, 'Tela não pode ser fechada com a Multiplicação em Andamento, Verifique!');
end;

procedure TfrmControleMultiplicacao.btFinalizarClick(Sender: TObject);
Var
  I : Integer;
  S : String;
begin
  S := EmptyStr;
  for I := Low(MULTIPLICACAO.INTERVALO) to High(MULTIPLICACAO.INTERVALO) do
    S := S + sLineBreak + DateTimeToStr(MULTIPLICACAO.INTERVALO[I].DATAHORAINICIO) + ' - ' + DateTimeToStr(MULTIPLICACAO.INTERVALO[I].DATAHORAFIM);

  if S <> EmptyStr then
    ShowMessage(S);

  NovaMultiplicacao;
end;

procedure TfrmControleMultiplicacao.btPausePlayClick(Sender: TObject);
begin
  if MULTIPLICACAO.EMANDAMENTO then
    ControleProducao(ePausar)
  else
    ControleProducao(eContinuar);
end;

procedure TfrmControleMultiplicacao.ControleProducao(
  Controle: TControleProducao);
begin
  case Controle of
    eIniciar: begin
                btPausePlay.Glyph             := nil;
                btPausePlay.Caption           := 'Parar';
                ImageList1.GetBitmap(2, btPausePlay.Glyph);
                btPausePlay.Visible           := True;
              end;
    eContinuar: begin
                  btPausePlay.Glyph   := nil;
                  btPausePlay.Caption := 'Parar';
                  ImageList1.GetBitmap(2, btPausePlay.Glyph);
                  MULTIPLICACAO.EMANDAMENTO := True;
                  if Length(MULTIPLICACAO.INTERVALO) > 0 then
                    MULTIPLICACAO.INTERVALO[High(MULTIPLICACAO.INTERVALO)].DATAHORAFIM := Now;
                end;
    ePausar: begin
                btPausePlay.Glyph         := nil;
                btPausePlay.Caption       := 'Iniciar';
                ImageList1.GetBitmap(1, btPausePlay.Glyph);
                MULTIPLICACAO.EMANDAMENTO := False;
                SetLength(MULTIPLICACAO.INTERVALO, Length(MULTIPLICACAO.INTERVALO) + 1);
                MULTIPLICACAO.INTERVALO[High(MULTIPLICACAO.INTERVALO)].DATAHORAINICIO := Now;
              end;
  end;
end;

procedure TfrmControleMultiplicacao.ds_CodigoBarrasDataChange(Sender: TObject;
  Field: TField);
begin
  edQuantidadeEntrada.Text := IntToStr(cds_CodigoBarras.RecordCount);
end;

procedure TfrmControleMultiplicacao.ExecutarEvento;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  CodigoOPF : Integer;
begin
  if ((edCodigoOrdemProducao.Enabled) or (MULTIPLICACAO.EMANDAMENTO)) then begin

    if edCodigoOrdemProducao.Focused then begin

      CodigoOPF := StrToIntDef(edCodigoOrdemProducao.Text, 0);

      if CodigoOPF > 0 then begin

        FWC       := TFWConnection.Create;
        Consulta  := TFDQuery.Create(nil);
        try
          try
            Consulta.Close;
            Consulta.SQL.Clear;
            Consulta.SQL.Add('SELECT');
            Consulta.SQL.Add('	OPF.ID,');
            Consulta.SQL.Add('	P.DESCRICAO');
            Consulta.SQL.Add('FROM OPFINAL OPF');
            Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
            Consulta.SQL.Add('WHERE 1 = 1');
            Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
            Consulta.SQL.Add('AND OPF.ID = :CODIGOOP');
            Consulta.Connection := FWC.FDConnection;
            Consulta.ParamByName('CODIGOOP').DataType := ftInteger;
            Consulta.ParamByName('CODIGOOP').Value := CodigoOPF;
            Consulta.Open;

            if not Consulta.IsEmpty then begin
              edNomeProduto.Text            := Consulta.FieldByName('DESCRICAO').AsString;
              edCodigoOrdemProducao.Enabled := False;
              MULTIPLICACAO.CODIGOOP        := Consulta.FieldByName('ID').AsInteger;
              MULTIPLICACAO.DATAHORAI       := Now;
              MULTIPLICACAO.EMANDAMENTO     := True;

              ControleProducao(eIniciar);

              edNumeroLoteEstagio.Enabled   := True;
              if edNumeroLoteEstagio.CanFocus then
                edNumeroLoteEstagio.SetFocus;

            end;
          except
            on E : Exception do begin
              DisplayMsg(MSG_ERR, 'Erro ao Buscar Ordem de Produção!', '', E.Message);
              Exit;
            end;
          end;
        finally
          FreeAndNil(Consulta);
          FreeAndNil(FWC);
        end;
      end;
    end else begin
      if edNumeroLoteEstagio.Focused then begin
        if StrToIntDef(edNumeroLoteEstagio.Text, 0) > 0 then begin
          edCodigoEntrada.Enabled := True;
          if edCodigoEntrada.CanFocus then
            edCodigoEntrada.SetFocus;
          edNumeroLoteEstagio.Enabled   := False;
        end;
      end else begin
        if edCodigoEntrada.Focused then begin
          case rgEntrada.ItemIndex of
            0 : begin
              if StrToIntDef(edCodigoEntrada.Text,0) > 0 then begin
                cds_CodigoBarras.Insert;
                cds_CodigoBarrasCODIGOBARRAS.Value  := StrToIntDef(edCodigoEntrada.Text,0);
                cds_CodigoBarras.Post;
              end;
            end;
            1 : begin
              if not cds_CodigoBarras.IsEmpty then begin
                if StrToIntDef(edCodigoEntrada.Text,0) > 0 then begin
                  if cds_CodigoBarras.Locate('CODIGOBARRAS', edCodigoEntrada.Text,[]) then
                    cds_CodigoBarras.Delete;
                end;
              end;
            end;
          end;
          edCodigoEntrada.Clear;
        end;
      end;
    end;
  end else begin
    DisplayMsg(MSG_WAR, 'Multiplicação Paralisada, Verifique!');
  end;
end;

procedure TfrmControleMultiplicacao.FormCreate(Sender: TObject);
begin
  cds_CodigoBarras.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmControleMultiplicacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : begin
      if MULTIPLICACAO.CODIGOOP = 0 then
        Close;
    end;
    VK_F2 : begin
      rgEntrada.ItemIndex := 0;
      if edQuantidadeEntrada.CanFocus then
        edQuantidadeEntrada.SetFocus;
    end;
    VK_F3 : begin
      rgEntrada.ItemIndex := 1;
      if edQuantidadeEntrada.CanFocus then
        edQuantidadeEntrada.SetFocus;
    end;
    VK_F4 : begin
      rgSaida.ItemIndex := 0;
      if edQuantidadeSaida.CanFocus then
        edQuantidadeSaida.SetFocus;
    end;
    VK_F5 : begin
      rgSaida.ItemIndex := 1;
      if edQuantidadeSaida.CanFocus then
        edQuantidadeSaida.SetFocus;
    end;
    VK_RETURN : begin
      ExecutarEvento;
    end;
  end;
end;

procedure TfrmControleMultiplicacao.FormShow(Sender: TObject);
begin
  NovaMultiplicacao;
end;

procedure TfrmControleMultiplicacao.NovaMultiplicacao;
begin
  MULTIPLICACAO.CODIGOOP        := 0;
  MULTIPLICACAO.EMANDAMENTO     := False;
  SetLength(MULTIPLICACAO.INTERVALO, 0);
  edCodigoOrdemProducao.Clear;
  edCodigoOrdemProducao.Enabled := True;
  edNumeroLoteEstagio.Clear;
  edNumeroLoteEstagio.Enabled   := False;
  edCodigoEntrada.Clear;
  edCodigoEntrada.Enabled := False;
  edNomeProduto.Clear;
  btPausePlay.Visible           := False;
  edQuantidadeEntrada.Text      := '0';
  edQuantidadeSaida.Text        := '0';
  cds_CodigoBarras.EmptyDataSet;
  if edCodigoOrdemProducao.CanFocus then
    edCodigoOrdemProducao.SetFocus;
end;

end.
