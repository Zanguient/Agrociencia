unit uControleMultiplicacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, Data.DB;

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
    edEstagio: TLabeledEdit;
    edNumeroLoteEstagio: TLabeledEdit;
    edCodigoOrdemProducao: TLabeledEdit;
    DBGrid1: TDBGrid;
    edNomeProduto: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPausePlayClick(Sender: TObject);
    procedure btFinalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    MULTIPLICACAO : TMultiplicacao;
    procedure ExecutarEvento;
    procedure NovaMultiplicacao;
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
  if MULTIPLICACAO.EMANDAMENTO then begin
    btPausePlay.Glyph   := nil;
    btPausePlay.Caption := 'Iniciar';
    ImageList1.GetBitmap(1, btPausePlay.Glyph);
    MULTIPLICACAO.EMANDAMENTO := False;
    SetLength(MULTIPLICACAO.INTERVALO, Length(MULTIPLICACAO.INTERVALO) + 1);
    MULTIPLICACAO.INTERVALO[High(MULTIPLICACAO.INTERVALO)].DATAHORAINICIO := Now;
  end else begin
    btPausePlay.Glyph   := nil;
    btPausePlay.Caption := 'Parar';
    ImageList1.GetBitmap(2, btPausePlay.Glyph);
    MULTIPLICACAO.EMANDAMENTO := True;
    if Length(MULTIPLICACAO.INTERVALO) > 0 then
      MULTIPLICACAO.INTERVALO[High(MULTIPLICACAO.INTERVALO)].DATAHORAFIM := Now;
  end;
end;

procedure TfrmControleMultiplicacao.ExecutarEvento;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  OPFE      : TOPFINAL_ESTAGIO;
  CodigoOPF : Integer;
begin
  if edCodigoOrdemProducao.Focused then begin

    CodigoOPF := StrToIntDef(edCodigoOrdemProducao.Text, 0);

    if CodigoOPF > 0 then begin

      FWC       := TFWConnection.Create;
      Consulta  := TFDQuery.Create(nil);
      OPFE      := TOPFINAL_ESTAGIO.Create(FWC);
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

            btPausePlay.Glyph             := nil;
            btPausePlay.Caption           := 'Parar';
            ImageList1.GetBitmap(2, btPausePlay.Glyph);
            btPausePlay.Visible           := True;

            OPFE.SelectList('OPFINAL_ID = ' + Consulta.FieldByName('ID').AsString);
            if OPFE.Count = 0 then begin
              edNumeroLoteEstagio.Text    := '1';
              edNumeroLoteEstagio.Enabled := False;
            end else begin
              edNumeroLoteEstagio.Enabled := True;
              if edNumeroLoteEstagio.CanFocus then
                edNumeroLoteEstagio.SetFocus;
            end;

          end;
        except
          on E : Exception do begin
            DisplayMsg(MSG_ERR, 'Erro ao Buscar Ordem de Produção!', '', E.Message);
            Exit;
          end;
        end;
      finally
        FreeAndNil(Consulta);
        FreeAndNil(OPFE);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmControleMultiplicacao.FormCreate(Sender: TObject);
begin
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
  MULTIPLICACAO.CODIGOOP    := 0;
  MULTIPLICACAO.EMANDAMENTO := False;
  SetLength(MULTIPLICACAO.INTERVALO, 0);
  edCodigoOrdemProducao.Clear;
  edCodigoOrdemProducao.Enabled := True;
  edNomeProduto.Clear;
  btPausePlay.Visible     := False;
  if edCodigoOrdemProducao.CanFocus then
    edCodigoOrdemProducao.SetFocus;
end;

end.
