unit uImpressaoEtiquetas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, Data.DB,
  Datasnap.DBClient, uFWConnection, System.StrUtils;

type
  TLOTE = record
    ORDEMPRODUCAO : Integer;
    SEQUENCIA : Integer;
    ESTAGIO : Integer;
    IDLOTE : Integer;
    CODIGOMC : string;
    LOCALIZACAO_ID : Integer;
  end;

type
  TfrmImpressaoEtiquetas = class(TForm)
    Panel1: TPanel;
    pnSuperior: TPanel;
    edNumeroLoteEstagio: TLabeledEdit;
    edCodigoOrdemProducao: TLabeledEdit;
    edProduto: TLabeledEdit;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    btEtiquetas: TBitBtn;
    cds_Itens: TClientDataSet;
    ds_Itens: TDataSource;
    btFechar: TSpeedButton;
    cds_ItensORDEMPRODUCAO: TIntegerField;
    cds_ItensPRODUTO: TStringField;
    edt_Quantidade: TLabeledEdit;
    cds_ItensCODIGOBARRAS: TStringField;
    cds_ItensDATALOTE: TDateField;
    btnAdicionar: TBitBtn;
    cds_ItensCODIGOMC: TStringField;
    edCodigoUsuario: TLabeledEdit;
    edNomeUsuario: TLabeledEdit;
    cds_ItensNUMEROLOTE: TStringField;
    edNomeLocalizacao: TEdit;
    edCodigoLocalizacao: TButtonedEdit;
    Label2: TLabel;
    Label1: TLabel;
    procedure btFecharClick(Sender: TObject);
    procedure btEtiquetasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cds_ItensAfterPost(DataSet: TDataSet);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edCodigoLocalizacaoRightButtonClick(Sender: TObject);
    procedure edCodigoLocalizacaoChange(Sender: TObject);
    procedure edCodigoLocalizacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function AtualizaLocalizacao : Boolean;
    { Private declarations }
  public
    { Public declarations }
    LOTE : TLOTE;
    procedure ExecutarEvento;
    procedure ImprimirEtiquetas;
    procedure LimparEdits;
    procedure CarregaEtiquetas;
  end;

var
  frmImpressaoEtiquetas: TfrmImpressaoEtiquetas;

implementation
uses
  uFuncoes,
  uMensagem,
  uBeanOPFinal_Estagio,
  uBeanOPFinal_Estagio_Lote,
  uBeanOPFinal_Estagio_Lote_S,
  uBeanOPFinal_Estagio_Lote_S_Qualidade,
  uConstantes,
  uDMUtil, 
  uBeanUsuario,
  uBeanMotivoDescarte,
  uBeanLocalizacao;
{$R *.dfm}

function TfrmImpressaoEtiquetas.AtualizaLocalizacao : Boolean;
var
  FWC : TFWConnection;
  L   : TOPFINAL_ESTAGIO_LOTE;
begin

  Result := True;

  if edCodigoLocalizacao.Enabled then begin

    Result := False;

    if LOTE.IDLOTE > 0 then begin

      FWC := TFWConnection.Create;
      L   := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
      try
        try
          L.ID.Value          := LOTE.IDLOTE;
          L.LOCALIZACAO_ID.Value := StrToIntDef(edCodigoLocalizacao.Text,0);
          L.Update;

          Result := True;

        except
          on E : Exception do Begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Atualizar a Localização para o Lote, Verifique!');
            Exit;
          End;
        end;
      finally
        FreeAndNil(L);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

procedure TfrmImpressaoEtiquetas.btEtiquetasClick(Sender: TObject);
begin
  if btEtiquetas.Tag = 0 then begin
    btEtiquetas.Tag := 1;
    try

      if edCodigoLocalizacao.Enabled then begin
        if Length(Trim(edNomeLocalizacao.Text)) = 0 then begin
          DisplayMsg(MSG_WAR, 'Obrigatório informar a Localização do Lote, Verifique!');
          if edCodigoLocalizacao.CanFocus then
            edCodigoLocalizacao.SetFocus;
          Exit;
        end;
      end;

      ImprimirEtiquetas;

    finally
      btEtiquetas.Tag := 0;
    end;
  end;
end;

procedure TfrmImpressaoEtiquetas.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImpressaoEtiquetas.btnAdicionarClick(Sender: TObject);
var
  FWC : TFWConnection;
  LS  : TOPFINAL_ESTAGIO_LOTE_S;
  USU : TUSUARIO;
begin
  if not (USUARIO.PERMITEINCLUIRETIQUETAS) then begin
    DisplayMsg(MSG_PASSWORD, 'Digite o usuário e senha de alguem que tenha permissão por favor!');
    if not (ResultMsgModal in [mrOk, mrYes]) then Exit;
    FWC := TFWConnection.Create;
    USU := TUSUARIO.Create(FWC);
    try
      USU.SelectList('ID = ' + IntToStr(ResultMsgPassword));
      if USU.Count > 0 then begin
        if not (TUSUARIO(USU.Itens[0]).PERMITEITENSETIQUETA.Value) then begin
          DisplayMsg(MSG_WAR, 'Usuário informado não tem permissão para a operação atual!');
          Exit;
        end;
      end
      else begin
        DisplayMsg(MSG_WAR, 'Usuário não encontrado!');
        Exit;
      end;

    finally
      FreeAndNil(USU);
      FreeAndNil(FWC);
    end;

  end;
  FWC := TFWConnection.Create;
  LS  := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
  try
    FWC.StartTransaction;
    try
      LS.ID.isNull                     := True;
      LS.OPFINAL_ESTAGIO_LOTE_ID.Value := LOTE.IDLOTE;
      LS.DATAHORA.Value                := Now;
      LS.BAIXADO.Value                 := False;
      LS.Insert;

      FWC.Commit;
    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_WAR, 'Erro ao Inserir Item!', '', E.Message);
        Exit;
      end;
    end;
    CarregaEtiquetas;
  finally
    FreeAndNil(LS);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmImpressaoEtiquetas.CarregaEtiquetas;
var
  FWC : TFWConnection;
  LS  : TOPFINAL_ESTAGIO_LOTE_S;
  L   : TOPFINAL_ESTAGIO_LOTE;
  I : Integer;
begin
  FWC := TFWConnection.Create;
  L   := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
  LS  := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
  try
    L.SelectList('ID = ' + IntToStr(LOTE.IDLOTE));
    if L.Count > 0 then begin
      LS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + IntToStr(LOTE.IDLOTE) + 'AND (NOT BAIXADO)');
      if LS.Count > 0 then begin
        cds_Itens.EmptyDataSet;
        for I := 0 to Pred(LS.Count) do begin
          cds_Itens.Append;
          cds_ItensCODIGOBARRAS.Value   := StrZero(TOPFINAL_ESTAGIO_LOTE_S(LS.Itens[I]).ID.asString, MinimoCodigoBarras);
          cds_ItensORDEMPRODUCAO.Value  := LOTE.ORDEMPRODUCAO;
          cds_ItensPRODUTO.Value        := edProduto.Text;
          cds_ItensDATALOTE.Value       := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).DATAHORAINICIO.Value;
          cds_ItensCODIGOMC.Value       := LOTE.CODIGOMC;
          cds_Itens.Post;
        end;
      end;
    end;
  finally
    FreeAndNil(LS);
    FreeAndNil(L);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmImpressaoEtiquetas.cds_ItensAfterPost(DataSet: TDataSet);
begin
  edt_Quantidade.Text := IntToStr(cds_Itens.RecordCount);
end;

procedure TfrmImpressaoEtiquetas.edCodigoLocalizacaoChange(Sender: TObject);
begin
  edNomeLocalizacao.Clear;
end;

procedure TfrmImpressaoEtiquetas.edCodigoLocalizacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edCodigoLocalizacaoRightButtonClick(nil);
end;

procedure TfrmImpressaoEtiquetas.edCodigoLocalizacaoRightButtonClick(
  Sender: TObject);
var
  FWC : TFWConnection;
  L  : TLOCALIZACAO;
begin
  FWC := TFWConnection.Create;
  L   := TLOCALIZACAO.Create(FWC);

  try
    edCodigoLocalizacao.Text := IntToStr(DMUtil.Selecionar(L, edCodigoLocalizacao.Text, ''));
    L.SelectList('id = ' + edCodigoLocalizacao.Text);
    if L.Count = 1 then
      edNomeLocalizacao.Text := TLOCALIZACAO(L.Itens[0]).NOME.asString;
  finally
    FreeAndNil(L);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmImpressaoEtiquetas.ExecutarEvento;
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  BuscaOP   : TFDQuery;
  Codigo,
  CodigoOPF,
  SeqEstagio: Integer;
  U         : TUSUARIO;
  L         : TOPFINAL_ESTAGIO_LOTE;
  LS        : TOPFINAL_ESTAGIO_LOTE_S;
  LOCAL     : TLOCALIZACAO;
  I: Integer;
begin
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
            Consulta.SQL.Add('	(P.DESCRICAO || '' - '' || OPF.ID) AS PRODUTO,');
            Consulta.SQL.Add('	E.TIPO,');
            Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC,');
            Consulta.SQL.Add('  (COALESCE((SELECT SUM(COALESCE(CEP.QUANTIDADE, 0.00))');
            Consulta.SQL.Add('	FROM CONTROLEESTOQUE CE INNER JOIN CONTROLEESTOQUEPRODUTO CEP ON (CEP.CONTROLEESTOQUE_ID = CE.ID)');
            Consulta.SQL.Add('	WHERE (NOT CE.CANCELADO) AND CEP.PRODUTO_ID = P.ID),0.00)) AS SALDO');
            Consulta.SQL.Add('FROM OPFINAL OPF');
            Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
            Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
            Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (OPFE.ESTAGIO_ID = E.ID)');
            Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = OPFE.MEIOCULTURA_ID)');

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

                  edProduto.Text                := Consulta.FieldByName('PRODUTO').AsString;
                  edCodigoOrdemProducao.Enabled := False;
                  LOTE.ORDEMPRODUCAO            := Consulta.FieldByName('ID').AsInteger;
                  LOTE.SEQUENCIA                := Consulta.FieldByName('SEQUENCIA').AsInteger;
                  LOTE.ESTAGIO                  := Consulta.FieldByName('IDESTAGIO').AsInteger;
                  LOTE.CODIGOMC                 := Consulta.FieldByName('CODIGOMC').AsString;

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
  end else if edNumeroLoteEstagio.Focused then begin
    if StrToIntDef(edNumeroLoteEstagio.Text, 0) > 0 then begin
      FWC   := TFWConnection.Create;
      U     := TUSUARIO.Create(FWC);
      L     := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
      LOCAL := TLOCALIZACAO.Create(FWC);
      LS    := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
      try
        L.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(LOTE.ESTAGIO) + ' AND NUMEROLOTE = ' + edNumeroLoteEstagio.Text);
        if L.Count > 0 then begin
          U.SelectList('ID = ' + TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).USUARIO_ID.asString);
          if U.Count > 0 then begin

            edCodigoUsuario.Text        := TUSUARIO(U.Itens[0]).ID.asString;
            edNomeUsuario.Text          := TUSUARIO(U.Itens[0]).NOME.asString;
            edCodigoLocalizacao.Text    := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).LOCALIZACAO_ID.asString;
            LOCAL.SelectList('ID = ' + TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).LOCALIZACAO_ID.asString);
            if LOCAL.Count > 0 then
              edNomeLocalizacao.Text := TLOCALIZACAO(LOCAL.Itens[0]).NOME.asString;
            LOTE.IDLOTE                 := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).ID.Value;
            LOTE.LOCALIZACAO_ID         := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).LOCALIZACAO_ID.Value;

            edCodigoLocalizacao.Enabled := USUARIO.PERMITEINCLUIRETIQUETAS;

            LS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + IntToStr(LOTE.IDLOTE) + ' AND (NOT BAIXADO)');
            if LS.Count > 0 then begin
              cds_Itens.EmptyDataSet;
              for I := 0 to Pred(LS.Count) do begin
                cds_Itens.Append;
                cds_ItensCODIGOBARRAS.Value   := StrZero(TOPFINAL_ESTAGIO_LOTE_S(LS.Itens[I]).ID.asString, MinimoCodigoBarras);
                cds_ItensORDEMPRODUCAO.Value  := LOTE.ORDEMPRODUCAO;
                cds_ItensPRODUTO.Value        := edProduto.Text;
                cds_ItensDATALOTE.Value       := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).DATAHORAINICIO.Value;
                cds_ItensNUMEROLOTE.Value     := StrZero(TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).NUMEROLOTE.asString, MinimoCodigoBarras);
                cds_ItensCODIGOMC.Value       := LOTE.CODIGOMC;
                cds_Itens.Post;
              end;
            end;
          end;
        end;
      finally
        FreeAndNil(U);
        FreeAndNil(L);
        FreeAndNil(LOCAL);
        FreeAndNil(LS);
        FreeAndNil(FWC);
      end;

      edNumeroLoteEstagio.Enabled   := cds_Itens.RecordCount = 0;
      btnAdicionar.Visible          := not edNumeroLoteEstagio.Enabled;
    end;
  end;
end;

procedure TfrmImpressaoEtiquetas.FormCreate(Sender: TObject);
begin
  cds_Itens.CreateDataSet;
  AjustaForm(Self);
end;

procedure TfrmImpressaoEtiquetas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : ExecutarEvento;
    VK_ESCAPE : begin
      if LOTE.ORDEMPRODUCAO > 0 then
        LimparEdits
      else
        Close;
    end;
  end;
end;

procedure TfrmImpressaoEtiquetas.ImprimirEtiquetas;
begin
  if not cds_Itens.IsEmpty then begin
    if AtualizaLocalizacao then begin
      DMUtil.frxDBDataset1.DataSet := cds_Itens;
      RelParams.Clear;
      DMUtil.ImprimirRelatorio('frEtiquetaLote.fr3');
      LimparEdits;
    end;
  end;
end;

procedure TfrmImpressaoEtiquetas.LimparEdits;
begin
  edCodigoOrdemProducao.Clear;
  edCodigoOrdemProducao.Enabled := True;
  edNumeroLoteEstagio.Clear;
  edNumeroLoteEstagio.Enabled   := False;
  edProduto.Clear;
  cds_Itens.EmptyDataSet;
  edt_Quantidade.Clear;
  btnAdicionar.Visible := False;
  edCodigoLocalizacao.Enabled := False;
  edCodigoUsuario.Clear;
  edNomeUsuario.Clear;
  edCodigoLocalizacao.Clear;
  edNomeLocalizacao.Clear;

  LOTE.ORDEMPRODUCAO := 0;
  LOTE.SEQUENCIA := 0;
  LOTE.ESTAGIO := 0;
  LOTE.IDLOTE := 0;
  LOTE.CODIGOMC := EmptyStr;
  LOTE.LOCALIZACAO_ID := 0;

  if edCodigoOrdemProducao.CanFocus then
    edCodigoOrdemProducao.SetFocus;

end;

end.
