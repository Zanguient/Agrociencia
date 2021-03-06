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
    ESTACAOTRABALHO : string;
    LOCALIZACAO_ID : Integer;
    IDESTAGIO : Integer;
    IDLOTE : Integer;
    DATAHORAI: TDateTime;
    EMANDAMENTO: Boolean;
    INICIAL : Boolean;
    FIM : Boolean;
    PREVISTO : Integer;
    SALDO : Integer;
    CADESTAGIO : Integer;
    CADESPECIE : Integer;
    ORDEMPRODUCAOMC : Integer;
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
    lbQuantidade: TLabel;
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
    lbEstagio: TLabel;
    edEstacaoTrabalho: TLabeledEdit;
    edOrdemProducaoMC: TEdit;
    lbOPMC: TLabel;
    btFotosEstagio: TSpeedButton;
    edDescOPMC: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPausePlayClick(Sender: TObject);
    procedure btFinalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_EntradasDataChange(Sender: TObject; Field: TField);
    procedure ds_SaidasDataChange(Sender: TObject; Field: TField);
    procedure edOrdemProducaoMCChange(Sender: TObject);
    procedure btFotosEstagioClick(Sender: TObject);
  private
    MULTIPLICACAO : TMultiplicacao;
    procedure ExecutarEvento;
    procedure NovaMultiplicacao;
    procedure ControleProducao(Controle : TControleProducao);
    procedure GravarLote(FWC : TFWConnection);
    procedure GravarLoteEntradas(FWC : TFWConnection);
    procedure GravarLoteSaidas(FWC : TFWConnection);
    procedure GravarLoteIntervalos(FWC : TFWConnection);
    procedure GravarEstoque(FWC : TFWConnection);
    procedure SelecionaOrdemProducaoMC;
    function LoteExiste : Boolean;
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
  uConstantes,
  uBeanControleEstoque,
  uBeanControleEstoqueProduto,
  uBeanOrdemProducaoMC_Estoque,
  uBeanOrdemProducaoMC_Estoque_OP,
  uBeanProdutos,
  uDMUtil,
  uBeanOPFinal,
  uBeanOrdemProducaoMC,
  uBeanMeioCultura,
  uFotosEstagio, uBeanMeioCulturaEspecie;

{$R *.dfm}

{ TfrmControleMultiplicacao }

procedure TfrmControleMultiplicacao.btFecharClick(Sender: TObject);
begin
  if MULTIPLICACAO.CODIGOOP = 0 then
    Close
  else
    DisplayMsg(MSG_WAR, 'Tela n�o pode ser fechada com a Multiplica��o em Andamento, Verifique!');
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
      //Kochen 17/07/2017 - Se for um est�gio final n�o � preciso ter uma OP MC selecionada
      if not (MULTIPLICACAO.FIM) and (edDescOPMC.Text = EmptyStr) then begin
        DisplayMsg(MSG_WAR, 'Selecione uma Ordem de Produ��o MC para continuar!');
        if edOrdemProducaoMC.CanFocus then begin
          edOrdemProducaoMC.SetFocus;
          edOrdemProducaoMC.SelectAll;
        end;
        Exit;
      end;
      if StrToIntDef(edQuantidadeEntrada.Text, 0) = 0 then begin
        DisplayMsg(MSG_WAR, 'Informe ao menos um recipiente de entrada para continuar!');
        if edCodigoEntrada.CanFocus then begin
          edCodigoEntrada.SetFocus;
          edCodigoEntrada.SelectAll;
        end;
        Exit;
      end;
      if StrToIntDef(edQuantidadeSaida.Text, 0) = 0 then begin
        DisplayMsg(MSG_WAR, 'Informe ao menos um recipiente de sa�da para continuar!');
        if MULTIPLICACAO.FIM then begin
          if edQuantidadeSaida.CanFocus then begin
            edQuantidadeSaida.SetFocus;
            edQuantidadeSaida.SelectAll;
          end;
        end
        else begin
          if edCodigoSaida.CanFocus then begin
            edCodigoSaida.SetFocus;
            edCodigoSaida.SelectAll;
          end;
        end;
        Exit;
      end;

      if not (cds_Entradas.IsEmpty and cds_Saidas.IsEmpty) then begin
        if MULTIPLICACAO.EMANDAMENTO then begin

          FWC := TFWConnection.Create;
          try
            try

              FWC.StartTransaction;

              GravarLote(FWC);

              GravarLoteIntervalos(FWC);

              GravarLoteEntradas(FWC);

              if not MULTIPLICACAO.FIM then
                GravarLoteSaidas(FWC);

              GravarEstoque(FWC);

              FWC.Commit;

              DisplayMsg(MSG_OK, 'Multiplica��o Realizada com Sucesso!');
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
          DisplayMsg(MSG_WAR, 'Multiplica��o n�o est� em Andamento, Clique em Iniciar!');
          Exit;
        end;
      end;
    finally
      btFinalizar.Tag := 0;
    end;
  end;
end;

procedure TfrmControleMultiplicacao.btFotosEstagioClick(Sender: TObject);
begin
  if MULTIPLICACAO.IDESTAGIO > 0 then begin
    if frmFotosEstagio = nil then
      frmFotosEstagio := TfrmFotosEstagio.Create(nil);
    try
      frmFotosEstagio.IdEstagio := MULTIPLICACAO.IDESTAGIO;
      frmFotosEstagio.ShowModal;
    finally
      FreeAndNil(frmFotosEstagio);
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

procedure TfrmControleMultiplicacao.edOrdemProducaoMCChange(Sender: TObject);
begin
  edDescOPMC.Clear;
end;

procedure TfrmControleMultiplicacao.ExecutarEvento;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  BuscaOP   : TFDQuery;
  Codigo,
  CodigoOPF,
  SeqEstagio: Integer;
begin
  if ((edCodigoOrdemProducao.Enabled) or (MULTIPLICACAO.EMANDAMENTO)) then begin

    if edCodigoOrdemProducao.Focused then begin

      if Pos('*', edCodigoOrdemProducao.Text) > 0 then begin

        CodigoOPF := StrToIntDef(LeftStr(edCodigoOrdemProducao.Text, Pos('*', edCodigoOrdemProducao.Text)-1),0);
        SeqEstagio:= StrToIntDef(RightStr(edCodigoOrdemProducao.Text, (Length(edCodigoOrdemProducao.Text) - Pos('*', edCodigoOrdemProducao.Text))), 0);

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
              Consulta.SQL.Add('	P.DESCRICAO,');
              Consulta.SQL.Add('	E.TIPO,');
              Consulta.SQL.Add('	E.DESCRICAO AS DESCRICAOESTAGIO,');
              Consulta.SQL.Add('	OPFE.ESTAGIO_ID AS ESTAGIO,');
              Consulta.SQL.Add('	P.ID AS ESPECIE,');
              Consulta.SQL.Add('	OPFE.QUANTIDADEESTIMADA,');
              Consulta.SQL.Add('	OPFE.LOCALIZACAO_ID,');
              Consulta.SQL.Add('	COALESCE((SELECT SUM(OPL.QUANTIDADE) FROM OPFINAL_ESTAGIO_LOTE OPL WHERE OPL.OPFINAL_ESTAGIO_ID = OPFE.ID),0) AS SALDOESTAGIO,');
              Consulta.SQL.Add('	COALESCE((SELECT COUNT(OPLS.ID) FROM OPFINAL_ESTAGIO_LOTE OPL INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPLS ON OPL.ID = OPLS.OPFINAL_ESTAGIO_LOTE_ID WHERE OPL.OPFINAL_ESTAGIO_ID = OPFE.ID),0) AS SALDOLOTE');
              Consulta.SQL.Add('FROM OPFINAL OPF');
              Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
              Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
              Consulta.SQL.Add('INNER JOIN PRODUTO PP ON OPFE.MEIOCULTURA_ID = PP.ID');
              Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (OPFE.ESTAGIO_ID = E.ID)');

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
                    MULTIPLICACAO.CADESTAGIO      := Consulta.FieldByName('ESTAGIO').AsInteger;
                    MULTIPLICACAO.CADESPECIE      := Consulta.FieldByName('ESPECIE').AsInteger;
                    MULTIPLICACAO.DATAHORAI       := Now;
                    MULTIPLICACAO.EMANDAMENTO     := True;
                    MULTIPLICACAO.INICIAL         := Consulta.FieldByName('TIPO').AsInteger = 0;
                    MULTIPLICACAO.PREVISTO        := Consulta.FieldByName('QUANTIDADEESTIMADA').AsInteger;
                    MULTIPLICACAO.FIM             := Consulta.FieldByName('TIPO').AsInteger = 3;
                    MULTIPLICACAO.LOCALIZACAO_ID  := Consulta.FieldByName('LOCALIZACAO_ID').AsInteger;
                    if MULTIPLICACAO.FIM then
                      MULTIPLICACAO.SALDO         := Consulta.FieldByName('SALDOESTAGIO').AsInteger
                    else
                      MULTIPLICACAO.SALDO         := Consulta.FieldByName('SALDOLOTE').AsInteger;

                    ControleProducao(eIniciar);

                    edNumeroLoteEstagio.Enabled   := True;
                    if MULTIPLICACAO.PREVISTO > 0 then
                      lbEstagio.Caption           := Consulta.FieldByName('DESCRICAOESTAGIO').AsString + '. Quantidade prevista: ' + IntToStr(MULTIPLICACAO.PREVISTO) + '. Quantidade j� produzida: ' + IntToStr(MULTIPLICACAO.SALDO)
                    else
                      lbEstagio.Caption           := Consulta.FieldByName('DESCRICAOESTAGIO').AsString;
                    edQuantidadeSaida.Enabled     := MULTIPLICACAO.FIM;
                    edCodigoSaida.Enabled         := not MULTIPLICACAO.FIM;
                    rgSaida.Enabled               := not MULTIPLICACAO.FIM;

                    if edNumeroLoteEstagio.CanFocus then begin
                      edNumeroLoteEstagio.SetFocus;
                      edNumeroLoteEstagio.SelectAll;
                    end;

                    if (MULTIPLICACAO.PREVISTO > 0) and (MULTIPLICACAO.PREVISTO <= MULTIPLICACAO.SALDO) then
                      DisplayMsg(MSG_INF, 'Quantidade de Potes ou Plantas(' + IntToStr(MULTIPLICACAO.PREVISTO) + ') previsto j� foi alcan�ado!');
                  end;
                end;
              end;
            except
              on E : Exception do begin
                DisplayMsg(MSG_ERR, 'Erro ao Buscar Ordem de Produ��o!', '', E.Message);
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
          MULTIPLICACAO.NUMEROLOTE      := StrToIntDef(edNumeroLoteEstagio.Text, 0);
          if LoteExiste then begin
            DisplayMsg(MSG_WAR, 'Lote j� cadastrado para o est�gio selecionado!');
            if edNumeroLoteEstagio.CanFocus then begin
              edNumeroLoteEstagio.SetFocus;
              edNumeroLoteEstagio.SelectAll;
            end;
            Exit;
          end;
          edNumeroLoteEstagio.Enabled   := False;
          edEstacaoTrabalho.Enabled     := True;
          if edEstacaoTrabalho.CanFocus then begin
            edEstacaoTrabalho.SetFocus;
            edEstacaoTrabalho.SelectAll;
          end;
        end;
      end else begin
        if edEstacaoTrabalho.Focused then begin
          if Length(Trim(edEstacaoTrabalho.Text)) > 0 then begin
            MULTIPLICACAO.ESTACAOTRABALHO := edEstacaoTrabalho.Text;
            // 17/07/2017 - Kochen - N�o obrigar OPMC na produ��o
            if not MULTIPLICACAO.FIM then
            begin
              edOrdemProducaoMC.Enabled     := True;
              lbOPMC.Enabled                := True;
              if edOrdemProducaoMC.CanFocus then begin
                edOrdemProducaoMC.SetFocus;
                edOrdemProducaoMC.SelectAll;
              end;
            end
            else
            begin
              edCodigoEntrada.Enabled       := True;
              edCodigoSaida.Enabled         := False;
              rgSaida.Enabled               := False;
              edOrdemProducaoMC.Enabled     := False;
              if edCodigoEntrada.CanFocus then begin
                edCodigoEntrada.SetFocus;
                edCodigoEntrada.SelectAll;
              end;
            end;
            edEstacaoTrabalho.Enabled     := False;
          end;
        end else begin
          if edOrdemProducaoMC.Focused then begin
            SelecionaOrdemProducaoMC;
            if MULTIPLICACAO.ORDEMPRODUCAOMC > 0 then begin
              edCodigoEntrada.Enabled       := True;
              edCodigoSaida.Enabled         := not MULTIPLICACAO.FIM;
              rgSaida.Enabled               := not MULTIPLICACAO.FIM;
              edOrdemProducaoMC.Enabled     := False;
              if edCodigoEntrada.CanFocus then begin
                edCodigoEntrada.SetFocus;
                edCodigoEntrada.SelectAll;
              end;
            end;
          end else begin
            if edCodigoEntrada.Focused then begin
              Codigo := StrToIntDef(edCodigoEntrada.Text,0);
              case rgEntrada.ItemIndex of
                0 : begin
                  if Codigo > 0 then begin
                    if MULTIPLICACAO.INICIAL then begin
                      if Codigo <> MULTIPLICACAO.CODIGOOP then begin
                        DisplayMsg(MSG_WAR, 'Pote selecionado n�o pertence a ordem de produ��o atual!');
                        if edCodigoEntrada.CanFocus then begin
                          edCodigoEntrada.SetFocus;
                          edCodigoEntrada.SelectAll;
                        end;
                        Exit;
                      end;
                    end else begin
                      if cds_Entradas.Locate(cds_EntradasCODIGOBARRAS.FieldName, Codigo, []) then begin
                        DisplayMsg(MSG_WAR, 'Pote j� foi adicionado ao lote atual!');
                        if edCodigoEntrada.CanFocus then begin
                          edCodigoEntrada.SetFocus;
                          edCodigoEntrada.SelectAll;
                        end;
                        Exit;
                      end;
                      FWC     := TFWConnection.Create;
                      BuscaOP := TFDQuery.Create(nil);
                      try
                        BuscaOP.Connection := FWC.FDConnection;
                        BuscaOP.Close;
                        BuscaOP.SQL.Clear;
                        BuscaOP.SQL.Add('SELECT OE.OPFINAL_ID AS OP, OE.ID AS ESTAGIO, OELS.BAIXADO FROM OPFINAL_ESTAGIO OE');
                        BuscaOP.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OEL ON OEL.OPFINAL_ESTAGIO_ID = OE.ID');
                        BuscaOP.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OELS ON OELS.OPFINAL_ESTAGIO_LOTE_ID = OEL.ID');
                        BuscaOP.SQL.Add('WHERE OELS.ID = :CODIGOBARRAS');
                        BuscaOP.ParamByName('CODIGOBARRAS').AsInteger := Codigo;
                        BuscaOP.Open();

                        if BuscaOP.IsEmpty then begin
                          DisplayMsg(MSG_WAR, 'C�digo de barras n�o encontrado!');
                          if edCodigoEntrada.CanFocus then begin
                            edCodigoEntrada.SetFocus;
                            edCodigoEntrada.SelectAll;
                          end;
                          Exit;
                        end;

                        if BuscaOP.FieldByName('OP').AsInteger <> MULTIPLICACAO.CODIGOOP then begin
                          DisplayMsg(MSG_WAR, 'C�digo de barras informado n�o pertence a Ordem de Produ��o selecionada!');
                          if edCodigoEntrada.CanFocus then begin
                            edCodigoEntrada.SetFocus;
                            edCodigoEntrada.SelectAll;
                          end;
                          Exit;
                        end;

                        if BuscaOP.FieldByName('BAIXADO').AsBoolean then begin
                          DisplayMsg(MSG_WAR, 'C�digo de barras informado j� foi baixado anteriormente!');
                          if edCodigoEntrada.CanFocus then begin
                            edCodigoEntrada.SetFocus;
                            edCodigoEntrada.SelectAll;
                          end;
                          Exit;
                        end;

                        if BuscaOP.FieldByName('ESTAGIO').AsInteger = MULTIPLICACAO.IDESTAGIO then begin
                          DisplayMsg(MSG_WAR, 'N�o � poss�vel selecionar um pote do mesmo ciclo!');
                          if edCodigoEntrada.CanFocus then begin
                            edCodigoEntrada.SetFocus;
                            edCodigoEntrada.SelectAll;
                          end;
                          Exit;
                        end;
                      finally
                        FreeAndNil(BuscaOP);
                        FreeAndNil(FWC);
                      end;
                    end;
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
                      if not TemSaldoOPMC(MULTIPLICACAO.ORDEMPRODUCAOMC, (cds_Saidas.RecordCount + 1)) then begin
                        DisplayMsg(MSG_WAR, 'Acabaram os potes do Meio de Cultura! Verifique com o Administrador!');
                        if edCodigoSaida.CanFocus then begin
                          edCodigoSaida.SetFocus;
                          edCodigoSaida.SelectAll;
                        end;
                        Exit;
                      end;
                      cds_Saidas.Insert;
                      cds_SaidasCODIGOBARRAS.Value  := Codigo;
                      cds_Saidas.Post;
                    end else begin
                      DisplayMsg(MSG_WAR, 'C�digo de Barras.: ' + IntToStr(Codigo) + ' n�o pertence a Ordem de Produ��o N.� ' + IntToStr(MULTIPLICACAO.CODIGOOP) + ', Verifique!');
                      if edCodigoSaida.CanFocus then begin
                        edCodigoSaida.SetFocus;
                        edCodigoSaida.SelectAll;
                      end;
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
      end;
    end;
  end else begin
    DisplayMsg(MSG_WAR, 'Multiplica��o Paralisada, Verifique!');
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
      if edCodigoEntrada.CanFocus then begin
        edCodigoEntrada.SetFocus;
        edCodigoEntrada.SelectAll;
      end;
    end;
    VK_F3 : begin
      rgEntrada.ItemIndex := 1;
      if edCodigoEntrada.CanFocus then begin
        edCodigoEntrada.SetFocus;
        edCodigoEntrada.SelectAll;
      end;
    end;
    VK_F4 : begin
      rgSaida.ItemIndex := 0;
      if edCodigoSaida.CanFocus then begin
        edCodigoSaida.SetFocus;
        edCodigoSaida.SelectAll;
      end;
    end;
    VK_F5 : begin
      rgSaida.ItemIndex := 1;
      if edCodigoSaida.CanFocus then begin
        edCodigoSaida.SetFocus;
        edCodigoSaida.SelectAll;
      end;
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

procedure TfrmControleMultiplicacao.GravarEstoque(FWC: TFWConnection);
var
  E      : TOPFINAL_ESTAGIO;
  OPMCEO : TORDEMPRODUCAOMC_ESTOQUE_OP;
  OPMCE  : TORDEMPRODUCAOMC_ESTOQUE;
  CE     : TCONTROLEESTOQUE;
  CEP    : TCONTROLEESTOQUEPRODUTO;
  P      : TPRODUTO;
  OP     : TOPFINAL;
  SQL    : TFDQuery;
begin
  SQL    := TFDQuery.Create(nil);
  CE     := TCONTROLEESTOQUE.Create(FWC);
  CEP    := TCONTROLEESTOQUEPRODUTO.Create(FWC);
  E      := TOPFINAL_ESTAGIO.Create(FWC);
  P      := TPRODUTO.Create(FWC);
  OP     := TOPFINAL.Create(FWC);
  try
    try
      SQL.Connection := FWC.FDConnection;

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('OPMC.ID_RECIPIENTE AS RECIPIENTE,');
      SQL.SQL.Add('PR.RECIPIENTEREAPROVEITAVEL');
      SQL.SQL.Add('FROM OPFINAL_ESTAGIO_LOTE OPL');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPS ON OPL.ID = OPS.OPFINAL_ESTAGIO_LOTE_ID');
      SQL.SQL.Add('INNER JOIN ORDEMPRODUCAOMC OPMC ON OPL.ORDEMPRODUCAOMC_ID = OPMC.ID');
      SQL.SQL.Add('INNER JOIN PRODUTO PR ON OPMC.ID_RECIPIENTE = PR.ID');
      SQL.SQL.Add('WHERE OPS.ID = :ID');
      SQL.Connection                 := FWC.FDConnection;
      SQL.ParamByName('ID').DataType := ftInteger;
      SQL.Prepare;

      CE.ID.isNull              := True;
      CE.DATAHORA.Value         := Now;
      CE.USUARIO_ID.Value       := USUARIO.CODIGO;
      CE.TIPOMOVIMENTACAO.Value := 0;
      CE.CANCELADO.Value        := False;
      CE.OBSERVACAO.Value       := 'Retorno de Recipiente Reutiliz�vel';
      CE.Insert;

      E.SelectList('ID = ' + IntToStr(MULTIPLICACAO.IDESTAGIO));
      if E.Count > 0 then begin
        P.SelectList('ID = ' + TOPFINAL_ESTAGIO(E.Itens[0]).MEIOCULTURA_ID.asSQL);
        if P.Count > 0 then begin

          CEP.ID.isNull                 := True;
          CEP.CONTROLEESTOQUE_ID.Value  := CE.ID.Value;
          CEP.PRODUTO_ID.Value          := TPRODUTO(P.Itens[0]).ID.Value;
          CEP.QUANTIDADE.Value          := cds_Saidas.RecordCount * -1;
          CEP.Insert;
        end;
      end;
      if MULTIPLICACAO.FIM then begin
        OP.SelectList('ID = ' + IntToStr(MULTIPLICACAO.CODIGOOP));
        if OP.Count > 0 then begin
          CEP.ID.isNull                := True;
          CEP.CONTROLEESTOQUE_ID.Value := CE.ID.Value;
          CEP.PRODUTO_ID.Value         := TOPFINAL(OP.Itens[0]).PRODUTO_ID.Value;
          CEP.QUANTIDADE.Value         := StrToCurr(edQuantidadeSaida.Text);
          CEP.Insert;
        end;
      end;
      if not MULTIPLICACAO.INICIAL then begin
        cds_Entradas.First;
        while not cds_Entradas.Eof do begin
          SQL.Close;
          SQL.Params[0].AsInteger := cds_EntradasCODIGOBARRAS.Value;
          SQL.Open();

          if not SQL.IsEmpty then begin
            if SQL.Fields[1].AsBoolean then begin

              CEP.ID.isNull                 := True;
              CEP.CONTROLEESTOQUE_ID.Value  := CE.ID.Value;
              CEP.PRODUTO_ID.Value          := SQL.Fields[0].Value;
              CEP.QUANTIDADE.Value          := 1;
              CEP.Insert;
            end;
          end;

          cds_Entradas.Next;
        end;
      end;
    except
      on E : Exception do begin
        raise EAbort.Create('Erro ao retornar o estoque dos recipientes: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(CEP);
    FreeAndNil(CE);
    FreeAndNil(OP);
    FreeAndNil(E);
    FreeAndNil(P);
    FreeAndNil(SQL);
  end;
end;

procedure TfrmControleMultiplicacao.GravarLote(FWC: TFWConnection);
Var
  OPFE  : TOPFINAL_ESTAGIO;
  OPFEL : TOPFINAL_ESTAGIO_LOTE;
  OPMC  : TORDEMPRODUCAOMC;
  SQL   : TFDQuery;
begin

  OPFE  := TOPFINAL_ESTAGIO.Create(FWC);
  OPFEL := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
  OPMC  := TORDEMPRODUCAOMC.Create(FWC);
  try
    try

      OPFE.SelectList('ID = ' + IntToStr(MULTIPLICACAO.IDESTAGIO));
      if OPFE.Count > 0 then begin

        OPFEL.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(MULTIPLICACAO.IDESTAGIO) + ' AND NUMEROLOTE = ' + IntToStr(MULTIPLICACAO.NUMEROLOTE));
        if OPFEL.Count = 0 then begin
          OPFEL.ID.isNull                 := True;
          OPFEL.OPFINAL_ESTAGIO_ID.Value  := MULTIPLICACAO.IDESTAGIO;
          OPFEL.NUMEROLOTE.Value          := MULTIPLICACAO.NUMEROLOTE;
          OPFEL.DATAHORAINICIO.Value      := MULTIPLICACAO.DATAHORAI;
          OPFEL.DATAHORAFIM.Value         := Now;
          OPFEL.USUARIO_ID.Value          := USUARIO.CODIGO;
          OPFEL.OBSERVACAO.Value          := '';
          OPFEL.QUANTIDADE.Value          := 0;
          OPFEL.ESTACAOTRABALHO.Value     := MULTIPLICACAO.ESTACAOTRABALHO;
          OPFEL.LOCALIZACAO_ID.Value      := MULTIPLICACAO.LOCALIZACAO_ID;
          if MULTIPLICACAO.FIM then
            OPFEL.QUANTIDADE.Value        := StrToInt(edQuantidadeSaida.Text)
          else
            OPFEL.ORDEMPRODUCAOMC_ID.Value:= StrToInt(edOrdemProducaoMC.Text);
          OPFEL.Insert;

          //Atualizar saldo da OPMC
          if MULTIPLICACAO.ORDEMPRODUCAOMC > 0 then begin
            if StrToIntDef(edQuantidadeSaida.Text,0) > 0 then begin
              SQL := TFDQuery.Create(nil);
              try
                SQL.Connection := FWC.FDConnection;
                SQL.Transaction := FWC.FDTransaction;
                SQL.ExecSQL('UPDATE ORDEMPRODUCAOMC SET SALDO = (SALDO - :QUANTIDADE) WHERE ID = :ID', [StrToIntDef(edQuantidadeSaida.Text,0), MULTIPLICACAO.ORDEMPRODUCAOMC], [ftInteger, ftInteger]);
              finally
                FreeAndNil(SQL);
              end;
            end;
          end;

          OPFE.ID.Value := TOPFINAL_ESTAGIO(OPFE.Itens[0]).ID.Value;

          //Caso ainda n�o tenha a data in�cio na teoria ser� o primeiro lote e grava a Data e Hora de In�cio de Produ��o
          if TOPFINAL_ESTAGIO(OPFE.Itens[0]).DATAHORAINICIO.isNull then
            OPFE.DATAHORAINICIO.Value := OPFEL.DATAHORAINICIO.Value;

          OPFE.DATAHORAFIM.Value := OPFEL.DATAHORAFIM.Value;
          OPFE.Update;

          MULTIPLICACAO.IDLOTE            := OPFEL.ID.Value;
        end else
          MULTIPLICACAO.IDLOTE            := TOPFINAL_ESTAGIO_LOTE(OPFEL.Itens[0]).ID.Value;
      end else
        raise EAbort.Create('Est�gio ' + IntToStr(MULTIPLICACAO.IDESTAGIO) + ' n�o Encontrado, Verifique!');

    except
      on E : Exception do begin
        raise EAbort.Create('Erro ao Gravar o Lote.: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(OPFE);
    FreeAndNil(OPFEL);
    FreeAndNil(OPMC);
  end;
end;

procedure TfrmControleMultiplicacao.GravarLoteEntradas(FWC : TFWConnection);
var
  OPFELE : TOPFINAL_ESTAGIO_LOTE_E;
  OPFELS : TOPFINAL_ESTAGIO_LOTE_S;
begin
  if not cds_Entradas.IsEmpty then begin
    OPFELE := TOPFINAL_ESTAGIO_LOTE_E.Create(FWC);
    OPFELS := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
    cds_Entradas.DisableControls;
    try

      try
        cds_Entradas.First;
        while not cds_Entradas.Eof do begin
          OPFELE.ID.isNull := True;
          OPFELE.OPFINAL_ESTAGIO_LOTE_ID.Value := MULTIPLICACAO.IDLOTE;
          OPFELE.CODIGOBARRAS.Value            := cds_EntradasCODIGOBARRAS.AsString;
          OPFELE.DATAHORA.Value                := Now;
          OPFELE.Insert;

          if not MULTIPLICACAO.INICIAL then begin
            OPFELS.SelectList('ID = ' + cds_EntradasCODIGOBARRAS.AsString);
            if OPFELS.Count > 0 then begin
              OPFELS.ID.Value                    := cds_EntradasCODIGOBARRAS.Value;
              OPFELS.BAIXADO.Value               := True;
              OPFELS.Update;
            end;
          end;

          cds_Entradas.Next;
        end;
      except
        on E : Exception do begin
          raise EAbort.Create('Erro ao Gravar as Entradas.: ' + E.Message);
        end;
      end;

    finally
      FreeAndNil(OPFELE);
      FreeAndNil(OPFELS);
      cds_Entradas.EnableControls;
    end;
  end;
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
          OPFELS.DATAHORA.Value                 := Now;
          OPFELS.BAIXADO.Value                  := False;
          OPFELS.Insert;
          cds_Saidas.Next;
        end;

      except
        on E : Exception do begin
          raise EAbort.Create('Erro ao Gravar as Sa�das.: ' + E.Message);
        end;
      end;
    finally
      FreeAndNil(OPFELS);
      cds_Saidas.EnableControls;
    end;
  end;
end;

function TfrmControleMultiplicacao.LoteExiste: Boolean;
var
  FWC     : TFWConnection;
  OPF_E_L : TOPFINAL_ESTAGIO_LOTE;
begin
  Result := False;

  FWC := TFWConnection.Create;
  OPF_E_L := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
  try
    OPF_E_L.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(MULTIPLICACAO.IDESTAGIO) + ' AND NUMEROLOTE = ' + IntToStr(MULTIPLICACAO.NUMEROLOTE));
    Result := OPF_E_L.Count > 0;
  finally
    FreeAndNil(OPF_E_L);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmControleMultiplicacao.NovaMultiplicacao;
begin
  MULTIPLICACAO.CODIGOOP        := 0;
  MULTIPLICACAO.SEQUENCIA       := 0;
  MULTIPLICACAO.NUMEROLOTE      := 0;
  MULTIPLICACAO.ESTACAOTRABALHO := '';
  MULTIPLICACAO.LOCALIZACAO_ID  := 0;
  MULTIPLICACAO.IDESTAGIO       := 0;
  MULTIPLICACAO.IDLOTE          := 0;
  MULTIPLICACAO.DATAHORAI       := 0;
  MULTIPLICACAO.EMANDAMENTO     := False;
  MULTIPLICACAO.INICIAL         := False;
  MULTIPLICACAO.FIM             := False;
  MULTIPLICACAO.PREVISTO        := 0;
  MULTIPLICACAO.SALDO           := 0;
  MULTIPLICACAO.CADESTAGIO      := 0;
  MULTIPLICACAO.CADESPECIE      := 0;
  MULTIPLICACAO.ORDEMPRODUCAOMC := 0;
  SetLength(MULTIPLICACAO.INTERVALO, 0);
  SetLength(MULTIPLICACAO.SAIDAS, 0);
  edCodigoOrdemProducao.Clear;
  edCodigoOrdemProducao.Enabled := True;
  edNumeroLoteEstagio.Clear;
  edEstacaoTrabalho.Clear;
  edNumeroLoteEstagio.Enabled   := False;
  edEstacaoTrabalho.Enabled     := False;
  edCodigoEntrada.Clear;
  edCodigoEntrada.Enabled       := False;
  edCodigoSaida.Clear;
  edCodigoSaida.Enabled         := False;
  edNomeProduto.Clear;
  btPausePlay.Visible           := False;
  rgEntrada.ItemIndex           := 0;
  rgSaida.ItemIndex             := 0;
  lbEstagio.Caption             := '';
  edOrdemProducaoMC.Enabled     := False;
  lbOPMC.Enabled                := False;
  edOrdemProducaoMC.Clear;
  cds_Entradas.EmptyDataSet;
  cds_Saidas.EmptyDataSet;
  if edCodigoOrdemProducao.CanFocus then begin
    edCodigoOrdemProducao.SetFocus;
    edCodigoOrdemProducao.SelectAll;
  end;
end;

procedure TfrmControleMultiplicacao.SelecionaOrdemProducaoMC;
var
  FWC : TFWConnection;
  OPMC : TORDEMPRODUCAOMC;
  MC   : TMEIOCULTURA;
  MCE  : TMEIOCULTURAESPECIE;
  IdOPMC : Integer;
begin
  FWC := TFWConnection.Create;
  OPMC:= TORDEMPRODUCAOMC.Create(FWC);
  MC  := TMEIOCULTURA.Create(FWC);
  MCE := TMEIOCULTURAESPECIE.Create(FWC);
  try
    IdOPMC := StrToIntDef(edOrdemProducaoMC.Text, 0);
    if IdOPMC > 0 then begin
      OPMC.SelectList('ID = '  + IntToStr(IdOPMC));
      if OPMC.Count > 0 then begin
        if TORDEMPRODUCAOMC(OPMC.Itens[0]).SALDO.Value <= 0 then begin
          DisplayMsg(MSG_WAR, 'Ordem de produ��o selecionada esta sem saldo no sistema!');
          Exit;
        end;
        MC.SelectList('ID_PRODUTO = ' + TORDEMPRODUCAOMC(OPMC.Itens[0]).ID_PRODUTO.asString);
        if MC.Count > 0 then begin

          if not TMEIOCULTURA(MC.Itens[0]).TODASASESPECIES.Value then begin
            MCE.SelectList('ID_MEIOCULTURA = ' + TMEIOCULTURA(MC.Itens[0]).ID.asString + ' AND ID_ESPECIE = ' + IntToStr(MULTIPLICACAO.CADESPECIE));
            if MCE.Count = 0 then begin
              DisplayMsg(MSG_WAR, 'Meio de cultura selecionado n�o pode ser usado para esta esp�cie!');
              Exit;
            end;
          end;

          if TMEIOCULTURA(MC.Itens[0]).ID_ESTAGIO.Value <> MULTIPLICACAO.CADESTAGIO then begin
            DisplayMsg(MSG_WAR, 'Meio de cultura selecionado pertence a outro est�gio!' + #13 + 'Verifique!');
            Exit;
          end;
//          edOrdemProducaoMC.Text        := TORDEMPRODUCAOMC(OPMC.Itens[0]).ID.asString;
          MULTIPLICACAO.ORDEMPRODUCAOMC := TORDEMPRODUCAOMC(OPMC.Itens[0]).ID.Value;
          edDescOPMC.Text := 'OPMC: ' + TORDEMPRODUCAOMC(OPMC.Itens[0]).ID.asString + ', ' +
                             'Meio de Cultura: ' + TMEIOCULTURA(MC.Itens[0]).CODIGO.asString + ', ' +
                             'Saldo: ' + FloatToStr(TORDEMPRODUCAOMC(OPMC.Itens[0]).SALDO.Value);

        end;
      end;
    end;
  finally
    FreeAndNil(OPMC);
    FreeAndNil(MC);
    FreeAndNil(MCE);
    FreeAndNil(FWC);
  end;
end;

end.
