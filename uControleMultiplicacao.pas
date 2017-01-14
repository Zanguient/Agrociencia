unit uControleMultiplicacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, Data.DB,
  Datasnap.DBClient, uFWConnection, System.StrUtils;

type
  TControleProducao = (eIniciar, eContinuar, ePausar);

type
  TIntervalo = record
    DATAHORAINICIO : TDateTime;
    DATAHORAFIM : TDateTime;
  end;

type
  TSaidas = record
    CODIGOBARRAS : Integer;
  end;

type
  TMultiplicacao = record
    CODIGOOP : Integer;
    SEQUENCIA : Integer;
    NUMEROLOTE : Integer;
    IDESTAGIO : Integer;
    IDLOTE : Integer;
    DATAHORAI: TDateTime;
    EMANDAMENTO: Boolean;
    INTERVALO: ARRAY OF TIntervalo;
    SAIDAS : ARRAY OF TSaidas;
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
    cds_Entradas: TClientDataSet;
    ds_Entradas: TDataSource;
    cds_EntradasCODIGOBARRAS: TIntegerField;
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
    edCodigoSaida: TLabeledEdit;
    rgSaida: TRadioGroup;
    ds_Saidas: TDataSource;
    cds_Saidas: TClientDataSet;
    cds_SaidasCODIGOBARRAS: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPausePlayClick(Sender: TObject);
    procedure btFinalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_EntradasDataChange(Sender: TObject; Field: TField);
    procedure ds_SaidasDataChange(Sender: TObject; Field: TField);
  private
    MULTIPLICACAO : TMultiplicacao;
    procedure ExecutarEvento;
    procedure NovaMultiplicacao;
    procedure ControleProducao(Controle : TControleProducao);
    procedure GravarLote(FWC : TFWConnection);
    procedure GravarLoteEntradas(FWC : TFWConnection);
    procedure GravarLoteSaidas(FWC : TFWConnection);
    procedure GravarLoteIntervalos(FWC : TFWConnection);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleMultiplicacao: TfrmControleMultiplicacao;

implementation

uses
  uFuncoes,
  uMensagem,
  uBeanOPFinal_Estagio,
  uBeanOPFinal_Estagio_Lote,
  uBeanOPFinal_Estagio_Lote_S,
  uBeanOPFinal_Estagio_Lote_E,
  uBeanOPFinal_Estagio_Lote_Intervalo,
  uConstantes;

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
  FWC : TFWConnection;
  I   : Integer;
  S   : String;
begin

  if btFinalizar.Tag = 0 then begin
    btFinalizar.Tag := 1;
    try
      if not (cds_Entradas.IsEmpty and cds_Saidas.IsEmpty) then begin
        if MULTIPLICACAO.EMANDAMENTO then begin

          FWC := TFWConnection.Create;
          try
            try

              //Pra Qual estágio????

              GravarLote(FWC);

              GravarLoteIntervalos(FWC);

              GravarLoteEntradas(FWC);

              GravarLoteSaidas(FWC);

              FWC.Commit;

              DisplayMsg(MSG_OK, 'Multiplicação Realizada com Sucesso!');
              NovaMultiplicacao;

            except
              on E : Exception do begin
                FWC.Rollback;
              end;
            end;
          finally
            FreeAndNil(FWC);
          end;
        end else begin
          DisplayMsg(MSG_WAR, 'Multiplicação não está em Andamento, Clique em Iniciar!');
          Exit;
        end;
      end;
    finally
      btFinalizar.Tag := 0;
    end;
  end;
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

procedure TfrmControleMultiplicacao.ds_EntradasDataChange(Sender: TObject;
  Field: TField);
begin
  edQuantidadeEntrada.Text := IntToStr(cds_Entradas.RecordCount);
end;

procedure TfrmControleMultiplicacao.ds_SaidasDataChange(Sender: TObject;
  Field: TField);
begin
  edQuantidadeSaida.Text := IntToStr(cds_Saidas.RecordCount);
end;

procedure TfrmControleMultiplicacao.ExecutarEvento;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  Codigo,
  CodigoOPF,
  SeqEstagio: Integer;
begin
  if ((edCodigoOrdemProducao.Enabled) or (MULTIPLICACAO.EMANDAMENTO)) then begin

    if edCodigoOrdemProducao.Focused then begin

      if Pos('*', edCodigoOrdemProducao.Text) > 0 then begin

        CodigoOPF := StrToIntDef(LeftStr(edCodigoOrdemProducao.Text, Pos('*', edCodigoOrdemProducao.Text)-1),0);
        SeqEstagio:= StrToIntDef(RightStr(edCodigoOrdemProducao.Text, Pos('*', edCodigoOrdemProducao.Text)-1),0);

        if CodigoOPF > 0 then begin

          FWC       := TFWConnection.Create;
          Consulta  := TFDQuery.Create(nil);
          try
            try
              Consulta.Close;
              Consulta.SQL.Clear;
              Consulta.SQL.Add('SELECT');
              Consulta.SQL.Add('	OPF.ID,');
              Consulta.SQL.Add('	OPFE.ID AS IDESTAGIO,');
              Consulta.SQL.Add('	OPFE.SEQUENCIA,');
              Consulta.SQL.Add('	P.DESCRICAO');
              Consulta.SQL.Add('FROM OPFINAL OPF');
              Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
              Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
              Consulta.SQL.Add('WHERE 1 = 1');
              Consulta.SQL.Add('AND OPF.CANCELADO = FALSE');
              Consulta.SQL.Add('AND OPF.ID = :CODIGOOP');
              Consulta.SQL.Add('AND OPFE.SEQUENCIA = :SEQUENCIA');
              Consulta.Connection := FWC.FDConnection;
              Consulta.ParamByName('CODIGOOP').DataType   := ftInteger;
              Consulta.ParamByName('SEQUENCIA').DataType  := ftInteger;
              Consulta.ParamByName('CODIGOOP').Value      := CodigoOPF;
              Consulta.ParamByName('SEQUENCIA').Value     := SeqEstagio;
              Consulta.Open;

              if not Consulta.IsEmpty then begin
                Consulta.First;
                if Consulta.FieldByName('ID').AsInteger = CodigoOPF then begin
                  if Consulta.FieldByName('SEQUENCIA').AsInteger = SeqEstagio then begin

                    edNomeProduto.Text            := Consulta.FieldByName('DESCRICAO').AsString;
                    edCodigoOrdemProducao.Enabled := False;
                    MULTIPLICACAO.CODIGOOP        := Consulta.FieldByName('ID').AsInteger;
                    MULTIPLICACAO.SEQUENCIA       := Consulta.FieldByName('SEQUENCIA').AsInteger;
                    MULTIPLICACAO.IDESTAGIO       := Consulta.FieldByName('IDESTAGIO').AsInteger;
                    MULTIPLICACAO.DATAHORAI       := Now;
                    MULTIPLICACAO.EMANDAMENTO     := True;

                    ControleProducao(eIniciar);

                    edNumeroLoteEstagio.Enabled   := True;
                    if edNumeroLoteEstagio.CanFocus then
                      edNumeroLoteEstagio.SetFocus;

                  end;
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
            FreeAndNil(FWC);
          end;
        end;
      end;
    end else begin
      if edNumeroLoteEstagio.Focused then begin
        if StrToIntDef(edNumeroLoteEstagio.Text, 0) > 0 then begin
          edCodigoEntrada.Enabled := True;
          edCodigoSaida.Enabled   := True;
          MULTIPLICACAO.NUMEROLOTE:= StrToIntDef(edNumeroLoteEstagio.Text, 0);
          if edCodigoEntrada.CanFocus then
            edCodigoEntrada.SetFocus;
          edNumeroLoteEstagio.Enabled   := False;
        end;
      end else begin
        if edCodigoEntrada.Focused then begin
          Codigo := StrToIntDef(edCodigoEntrada.Text,0);
          case rgEntrada.ItemIndex of
            0 : begin
              if Codigo > 0 then begin
                cds_Entradas.Insert;
                cds_EntradasCODIGOBARRAS.Value  := Codigo;
                cds_Entradas.Post;
              end;
            end;
            1 : begin
              if not cds_Entradas.IsEmpty then begin
                if Codigo > 0 then begin
                  if cds_Entradas.Locate('CODIGOBARRAS', Codigo,[]) then
                    cds_Entradas.Delete;
                end;
              end;
            end;
          end;
          edCodigoEntrada.Clear;
        end else begin
          if edCodigoSaida.Focused then begin
            Codigo := StrToIntDef(edCodigoSaida.Text,0);
            case rgSaida.ItemIndex of
              0 : begin
                if Codigo = MULTIPLICACAO.IDESTAGIO then begin
                  cds_Saidas.Insert;
                  cds_SaidasCODIGOBARRAS.Value  := Codigo;
                  cds_Saidas.Post;
                end else begin
                  DisplayMsg(MSG_WAR, 'Código de Barras.: ' + IntToStr(Codigo) + ' não pertence a Ordem de Produção N.º ' + IntToStr(MULTIPLICACAO.CODIGOOP) + ', Verifique!');
                  Exit;
                end;
              end;
              1 : begin
                if not cds_Saidas.IsEmpty then begin
                  if Codigo > 0 then begin
                    if cds_Saidas.Locate('CODIGOBARRAS', Codigo,[]) then
                      cds_Saidas.Delete;
                  end;
                end;
              end;
            end;
            edCodigoSaida.Clear;
          end;
        end;
      end;
    end;
  end else begin
    DisplayMsg(MSG_WAR, 'Multiplicação Paralisada, Verifique!');
  end;
end;

procedure TfrmControleMultiplicacao.FormCreate(Sender: TObject);
begin
  cds_Entradas.CreateDataSet;
  cds_Saidas.CreateDataSet;
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
      if edCodigoEntrada.CanFocus then
        edCodigoEntrada.SetFocus;
    end;
    VK_F3 : begin
      rgEntrada.ItemIndex := 1;
      if edCodigoEntrada.CanFocus then
        edCodigoEntrada.SetFocus;
    end;
    VK_F4 : begin
      rgSaida.ItemIndex := 0;
      if edCodigoSaida.CanFocus then
        edCodigoSaida.SetFocus;
    end;
    VK_F5 : begin
      rgSaida.ItemIndex := 1;
      if edCodigoSaida.CanFocus then
        edCodigoSaida.SetFocus;
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

procedure TfrmControleMultiplicacao.GravarLoteIntervalos(FWC: TFWConnection);
Var
  OPFELI  : TOPFINAL_ESTAGIO_LOTE_INTERVALO;
  I       : Integer;
begin
  if Length(MULTIPLICACAO.INTERVALO) > 0 then begin

    OPFELI := TOPFINAL_ESTAGIO_LOTE_INTERVALO.Create(FWC);

    try
      try
        for I := Low(MULTIPLICACAO.INTERVALO) to High(MULTIPLICACAO.INTERVALO) do begin
          OPFELI.ID.isNull                      := True;
          OPFELI.OPFINAL_ESTAGIO_LOTE_ID.Value  := MULTIPLICACAO.IDLOTE;
          OPFELI.DATAHORAENTRADA.Value          := MULTIPLICACAO.INTERVALO[I].DATAHORAINICIO;
          OPFELI.DATAHORASAIDA.Value            := MULTIPLICACAO.INTERVALO[I].DATAHORAFIM;
          OPFELI.Insert;
        end;
      except
        on E : Exception do begin
          raise EAbort.Create('Erro ao Gravar os Intervalos do Lote.: ' + E.Message);
        end;
      end;
    finally
      FreeAndNil(OPFELI);
    end;
  end;
end;

procedure TfrmControleMultiplicacao.GravarLote(FWC: TFWConnection);
Var
  OPFEL : TOPFINAL_ESTAGIO_LOTE;
begin

  OPFEL := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
  try
    try

      OPFEL.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(MULTIPLICACAO.IDESTAGIO) + ' AND NUMEROLOTE = ' + IntToStr(MULTIPLICACAO.NUMEROLOTE));
      if OPFEL.Count = 0 then begin
        OPFEL.ID.isNull                 := True;
        OPFEL.OPFINAL_ESTAGIO_ID.Value  := MULTIPLICACAO.IDESTAGIO;
        OPFEL.NUMEROLOTE.Value          := MULTIPLICACAO.NUMEROLOTE;
        OPFEL.DATAHORAINICIO.Value      := MULTIPLICACAO.DATAHORAI;
        OPFEL.DATAHORAFIM.Value         := Now;
        OPFEL.USUARIO_ID.Value          := USUARIO.CODIGO;
        OPFEL.OBSERVACAO.Value          := '';
        OPFEL.Insert;
        MULTIPLICACAO.IDLOTE            := OPFEL.ID.Value;
      end else
        MULTIPLICACAO.IDLOTE            := TOPFINAL_ESTAGIO_LOTE(OPFEL.Itens[0]).ID.Value;
    except
      on E : Exception do begin
        raise EAbort.Create('Erro ao Gravar o Lote.: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(OPFEL);
  end;
end;

procedure TfrmControleMultiplicacao.GravarLoteEntradas(FWC : TFWConnection);
begin
  //Implementar Entradas.
end;

procedure TfrmControleMultiplicacao.GravarLoteSaidas(FWC : TFWConnection);
Var
  OPFELS  : TOPFINAL_ESTAGIO_LOTE_S;
begin

  if not cds_Saidas.IsEmpty then begin

    OPFELS := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);

    cds_Saidas.DisableControls;

    try
      try

        cds_Saidas.First;
        while not cds_Saidas.Eof do begin
          OPFELS.ID.isNull                      := True;
          OPFELS.OPFINAL_ESTAGIO_LOTE_ID.Value  := MULTIPLICACAO.IDLOTE;
          OPFELS.CODIGOBARRAS.Value             := cds_SaidasCODIGOBARRAS.AsString;
          OPFELS.DATAHORA.Value                 := Now;
          OPFELS.Insert;
          cds_Saidas.Next;
        end;

      except
        on E : Exception do begin
          raise EAbort.Create('Erro ao Gravar as Saídas.: ' + E.Message);
        end;
      end;
    finally
      FreeAndNil(OPFELS);
      cds_Saidas.EnableControls;
    end;
  end;
end;

procedure TfrmControleMultiplicacao.NovaMultiplicacao;
begin
  MULTIPLICACAO.CODIGOOP        := 0;
  MULTIPLICACAO.SEQUENCIA       := 0;
  MULTIPLICACAO.NUMEROLOTE      := 0;
  MULTIPLICACAO.IDESTAGIO       := 0;
  MULTIPLICACAO.IDLOTE          := 0;
  MULTIPLICACAO.DATAHORAI       := 0;
  MULTIPLICACAO.EMANDAMENTO     := False;
  SetLength(MULTIPLICACAO.INTERVALO, 0);
  SetLength(MULTIPLICACAO.SAIDAS, 0);
  edCodigoOrdemProducao.Clear;
  edCodigoOrdemProducao.Enabled := True;
  edNumeroLoteEstagio.Clear;
  edNumeroLoteEstagio.Enabled   := False;
  edCodigoEntrada.Clear;
  edCodigoEntrada.Enabled       := False;
  edCodigoSaida.Clear;
  edCodigoSaida.Enabled         := False;
  edNomeProduto.Clear;
  btPausePlay.Visible           := False;
  rgEntrada.ItemIndex           := 0;
  rgSaida.ItemIndex             := 0;
  cds_Entradas.EmptyDataSet;
  cds_Saidas.EmptyDataSet;
  if edCodigoOrdemProducao.CanFocus then
    edCodigoOrdemProducao.SetFocus;
end;

end.
