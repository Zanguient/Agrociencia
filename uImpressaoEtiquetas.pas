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
  end;

type
  TfrmImpressaoEtiquetas = class(TForm)
    Panel1: TPanel;
    pnSuperior: TPanel;
    edNumeroLoteEstagio: TLabeledEdit;
    edCodigoOrdemProducao: TLabeledEdit;
    edNomeProduto: TLabeledEdit;
    pnBotoesEdicao: TPanel;
    GridPanel2: TGridPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    btEtiquetas: TBitBtn;
    cds_Itens: TClientDataSet;
    ds_Itens: TDataSource;
    cds_ItensID: TIntegerField;
    btFechar: TSpeedButton;
    cds_ItensORDEMPRODUCAO: TIntegerField;
    cds_ItensNOMEPRODUTO: TStringField;
    edt_Quantidade: TLabeledEdit;
    procedure btFecharClick(Sender: TObject);
    procedure btEtiquetasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cds_ItensAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    LOTE : TLOTE;
    procedure ExecutarEvento;
    procedure ImprimirEtiquetas;
    procedure LimparEdits;
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
  uDMUtil;
{$R *.dfm}

procedure TfrmImpressaoEtiquetas.btEtiquetasClick(Sender: TObject);
begin
  ImprimirEtiquetas;
end;

procedure TfrmImpressaoEtiquetas.btFecharClick(Sender: TObject);
begin
  Close;
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
  L         : TOPFINAL_ESTAGIO_LOTE;
  LS        : TOPFINAL_ESTAGIO_LOTE_S;
  I: Integer;
begin
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
            Consulta.SQL.Add('	P.DESCRICAO,');
            Consulta.SQL.Add('	E.TIPO,');
            Consulta.SQL.Add('  (COALESCE((SELECT SUM(COALESCE(CEP.QUANTIDADE, 0.00))');
            Consulta.SQL.Add('	FROM CONTROLEESTOQUE CE INNER JOIN CONTROLEESTOQUEPRODUTO CEP ON (CEP.CONTROLEESTOQUE_ID = CE.ID)');
            Consulta.SQL.Add('	WHERE CE.CANCELADO = FALSE AND CEP.PRODUTO_ID = P.ID),0.00)) AS SALDO');
            Consulta.SQL.Add('FROM OPFINAL OPF');
            Consulta.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
            Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
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
                  LOTE.ORDEMPRODUCAO            := Consulta.FieldByName('ID').AsInteger;
                  LOTE.SEQUENCIA                := Consulta.FieldByName('SEQUENCIA').AsInteger;
                  LOTE.ESTAGIO                  := Consulta.FieldByName('IDESTAGIO').AsInteger;

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
      L   := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
      LS  := TOPFINAL_ESTAGIO_LOTE_S.Create(FWC);
      try
        L.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(LOTE.ESTAGIO) + ' AND NUMEROLOTE = ' + edNumeroLoteEstagio.Text);
        if L.Count > 0 then begin
          LOTE.LOTE := TOPFINAL_ESTAGIO_LOTE(L.Itens[0]).ID.Value;
          LS.SelectList('OPFINAL_ESTAGIO_LOTE_ID = ' + IntToStr(LOTE.LOTE));
          if LS.Count > 0 then begin
            cds_Itens.EmptyDataSet;
            for I := 0 to Pred(LS.Count) do begin
              cds_Itens.Append;
              cds_ItensID.Value := TOPFINAL_ESTAGIO_LOTE_S(LS.Itens[I]).ID.Value;
              cds_ItensORDEMPRODUCAO.Value := LOTE.ORDEMPRODUCAO;
              cds_ItensNOMEPRODUTO.Value := edNomeProduto.Text;
              cds_Itens.Post;
            end;
          end;
        end;
      finally
        FreeAndNil(L);
        FreeAndNil(LS);
        FreeAndNil(FWC);
      end;

      edNumeroLoteEstagio.Enabled   := False;
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
  edNomeProduto.Clear;
  cds_Itens.EmptyDataSet;
  edt_Quantidade.Text := IntToStr(cds_Itens.RecordCount);
end;

end.
