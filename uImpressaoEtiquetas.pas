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
    LOTE : Integer;
    CODIGOMC : string;
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
    btnExcluir: TBitBtn;
    cds_ItensCODIGOMC: TStringField;
    edCodigoUsuario: TLabeledEdit;
    edNomeUsuario: TLabeledEdit;
    procedure btFecharClick(Sender: TObject);
    procedure btEtiquetasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cds_ItensAfterPost(DataSet: TDataSet);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
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
  uConstantes,
  uDMUtil, uBeanUsuario;
{$R *.dfm}

procedure TfrmImpressaoEtiquetas.btEtiquetasClick(Sender: TObject);
begin
  ImprimirEtiquetas;
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
      LS.OPFINAL_ESTAGIO_LOTE_ID.Value := LOTE.LOTE;
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

procedure TfrmImpressaoEtiquetas.btnExcluirClick(Sender: TObject);
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
    LS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + IntToStr(LOTE.LOTE));
    if LS.Count > 0 then begin
      FWC.StartTransaction;
      try
        LS.ID.Value := TOPFINAL_ESTAGIO_LOTE_S(LS.Itens[0]).ID.Value;
        LS.Delete;
        FWC.Commit;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_WAR, 'Erro ao Inserir Item!', '', E.Message);
          Exit;
        end;
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
    L.SelectList('ID = ' + IntToStr(LOTE.LOTE));
    if L.Count > 0 then begin
      LS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + IntToStr(LOTE.LOTE));
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
            Consulta.SQL.Add('	WHERE CE.CANCELADO = FALSE AND CEP.PRODUTO_ID = P.ID),0.00)) AS SALDO');
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
      FWC := TFWConnection.Create;
      U   := TUSUARIO.Create(FWC);
      L   := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
      LS  := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
      try
        L.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(LOTE.ESTAGIO) + ' AND NUMEROLOTE = ' + edNumeroLoteEstagio.Text);
        if L.Count > 0 then begin
          U.SelectList('ID = ' + TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).USUARIO_ID.asString);
          if U.Count > 0 then begin

            edCodigoUsuario.Text  := TUSUARIO(U.Itens[0]).ID.asString;
            edNomeUsuario.Text    := TUSUARIO(U.Itens[0]).NOME.asString;
            LOTE.LOTE             := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).ID.Value;

            LS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + IntToStr(LOTE.LOTE));
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
        end;
      finally
        FreeAndNil(U);
        FreeAndNil(L);
        FreeAndNil(LS);
        FreeAndNil(FWC);
      end;

      edNumeroLoteEstagio.Enabled   := cds_Itens.RecordCount = 0;
      btnAdicionar.Visible          := not edNumeroLoteEstagio.Enabled;
      btnExcluir.Visible            := btnAdicionar.Visible;
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
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmImpressaoEtiquetas.ImprimirEtiquetas;
begin
  if not cds_Itens.IsEmpty then begin
    DMUtil.frxDBDataset1.DataSet := cds_Itens;
    DMUtil.ImprimirRelatorio('frEtiquetaLote.fr3');
    LimparEdits;
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
  btnExcluir.Visible := False;
  edCodigoUsuario.Clear;
  edNomeUsuario.Clear;

  if edCodigoOrdemProducao.CanFocus then
    edCodigoOrdemProducao.SetFocus;

end;

end.
