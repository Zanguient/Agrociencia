unit uDescarteSE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  JvExStdCtrls, JvEdit, JvValidateEdit, FireDAC.Comp.Client;

type
  TParametro = record
    ID_PRODUTO: Integer;
    NOME_PRODUTO: string;
    QUANTIDADE: Currency;
  end;

  TfrmDescarteSE = class(TForm)
    Panel1: TPanel;
    pnSuperior: TPanel;
    Label8: TLabel;
    Label1: TLabel;
    edMotivo: TEdit;
    edCodigoMotivo: TButtonedEdit;
    pnBotoesVisualizacao: TPanel;
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    btDescartar: TSpeedButton;
    Panel9: TPanel;
    btCancelar: TSpeedButton;
    edQuantidade: TJvValidateEdit;
    Label2: TLabel;
    edCodigoProduto: TButtonedEdit;
    edNomeProduto: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure btCancelarClick(Sender: TObject);
    procedure edCodigoMotivoChange(Sender: TObject);
    procedure edCodigoMotivoRightButtonClick(Sender: TObject);
    procedure edCodigoMotivoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btDescartarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edCodigoProdutoChange(Sender: TObject);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoProdutoRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelecionaMotivoDescarte;
    function Descartar : Boolean;
  public
    { Public declarations }
    Parametro: TParametro;
  end;

var
  frmDescarteSE: TfrmDescarteSE;

implementation

uses
  uFWConnection,
  uBeanMotivoDescarte,
  uDMUtil,
  uBeanControleEstoque,
  uBeanControleEstoqueProduto,
  uBeanProdutos,
  uMensagem,
  uConstantes,
  uFuncoes;

{$R *.dfm}

procedure TfrmDescarteSE.btCancelarClick(Sender: TObject);
begin
  if Parametro.ID_PRODUTO > 0 then
    Close;
end;

procedure TfrmDescarteSE.btDescartarClick(Sender: TObject);
Var
  Sucesso : Boolean;
begin
  Sucesso := False;
  if btDescartar.Tag = 0 then begin
    btDescartar.Tag := 1;
    try

      Sucesso := Descartar;

    finally
      btDescartar.Tag := 0;
    end;
  end;

  if Sucesso then begin
    if Parametro.ID_PRODUTO > 0 then
      Close;
  end;
end;

function TfrmDescarteSE.Descartar : Boolean;
var
  FWC : TFWConnection;
  CE : TCONTROLEESTOQUE;
  CEP : TCONTROLEESTOQUEPRODUTO;
  P : TPRODUTO;
  SQL : TFDQuery;
  Quantidade : Currency;
begin

  Result := False;

  if Length(Trim(edNomeProduto.Text)) = 0 then begin
    DisplayMsg(MSG_WAR, 'Produto Selecionado não encontrado, Verifique!');
    if edCodigoProduto.CanFocus then
      edCodigoProduto.SetFocus;
    Exit;
  end;

  if Length(Trim(edMotivo.Text)) = 0 then begin
    DisplayMsg(MSG_WAR, 'Motivo do Descarte não selecionado, Verifique!');
    if edCodigoMotivo.CanFocus then
      edCodigoMotivo.SetFocus;
    Exit;
  end;

  Quantidade := StrToCurrDef(edQuantidade.Value, 0.00);

  if Quantidade <= 0 then begin
    DisplayMsg(MSG_WAR, 'Quantidade para descarte inválida, Verifique!');
    if edQuantidade.CanFocus then
      edQuantidade.SetFocus;
    Exit;
  end;

  FWC := TFWConnection.Create;
  CE := TCONTROLEESTOQUE.Create(FWC);
  CEP := TCONTROLEESTOQUEPRODUTO.Create(FWC);
  P := TPRODUTO.Create(FWC);
  SQL := TFDQuery.Create(nil);

  try

    FWC.StartTransaction;
    try

      P.SelectList('ID = ' + edCodigoProduto.Text);

      if P.Count = 1 then begin

        SQL.Close;
        SQL.SQL.Clear;
        SQL.SQL.Add('SELECT');
        SQL.SQL.Add('	SUM(CEP.QUANTIDADE) AS ESTOQUE');
        SQL.SQL.Add('FROM CONTROLEESTOQUE CE INNER JOIN CONTROLEESTOQUEPRODUTO CEP ON (CEP.CONTROLEESTOQUE_ID = CE.ID)');
        SQL.SQL.Add('WHERE CE.CANCELADO = FALSE AND CEP.PRODUTO_ID = :IDPRODUTO');

        SQL.Connection := FWC.FDConnection;
        SQL.Transaction := FWC.FDTransaction;

        SQL.ParamByName('IDPRODUTO').AsInteger := TPRODUTO(P.Itens[0]).ID.Value;

        SQL.Open;

        if (SQL.IsEmpty OR (SQL.FieldByName('ESTOQUE').AsCurrency < Quantidade)) then begin
          DisplayMsg(MSG_WAR, 'Saldo não disponível para o descarte, Verifique!');
          if edQuantidade.CanFocus then
            edQuantidade.SetFocus;
          Exit;
        end;

        CE.ID.isNull := True;
        CE.USUARIO_ID.Value := USUARIO.CODIGO;
        CE.TIPOMOVIMENTACAO.Value := 0;
        CE.OBSERVACAO.Value := 'Descarte de Solução estoque, Motivo.: ' + edMotivo.Text;
        CE.CANCELADO.Value := False;
        CE.DATAHORA.Value := Now;
        CE.Insert;

        CEP.ID.isNull := True;
        CEP.CONTROLEESTOQUE_ID.Value := CE.ID.Value;
        CEP.PRODUTO_ID.Value := TPRODUTO(P.Itens[0]).ID.Value;
        CEP.QUANTIDADE.Value := (Quantidade * -1);
        CEP.Insert;

        FWC.Commit;

        Result := True;

      end else begin
        DisplayMsg(MSG_WAR, 'Produto Selecionado Inválido, Verifique!');
        if edCodigoProduto.CanFocus then
          edCodigoProduto.SetFocus;
        Exit
      end;

    except
      on E: Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Descartar', '', E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(CE);
    FreeAndNil(CEP);
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmDescarteSE.edCodigoProdutoChange(Sender: TObject);
begin
  edNomeProduto.Clear;
end;

procedure TfrmDescarteSE.edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    edCodigoProdutoRightButtonClick(nil);
end;

procedure TfrmDescarteSE.edCodigoProdutoRightButtonClick(Sender: TObject);
var
  FWC : TFWConnection;
  P   : TPRODUTO;
begin
  FWC := TFWConnection.Create;
  P   := TPRODUTO.Create(FWC);

  try
    edCodigoProduto.Text := IntToStr(DMUtil.Selecionar(P, edCodigoProduto.Text, 'finalidade = ' + IntToStr(Integer(eSolEstoque)) ));
    P.SelectList('id = ' + edCodigoProduto.Text);
    if P.Count = 1 then
      edNomeProduto.Text := TPRODUTO(P.Itens[0]).DESCRICAO.asString;
  finally
    FreeAndNil(P);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmDescarteSE.edCodigoMotivoChange(Sender: TObject);
begin
  edMotivo.Clear;
end;

procedure TfrmDescarteSE.edCodigoMotivoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelecionaMotivoDescarte;
end;

procedure TfrmDescarteSE.edCodigoMotivoRightButtonClick(Sender: TObject);
begin
  SelecionaMotivoDescarte;
end;

procedure TfrmDescarteSE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btCancelarClick(nil);
end;

procedure TfrmDescarteSE.FormShow(Sender: TObject);
begin

  if Parametro.ID_PRODUTO > 0 then begin
    edCodigoProduto.Text := IntToStr(Parametro.ID_PRODUTO);
    edNomeProduto.Text := Parametro.NOME_PRODUTO;
    edQuantidade.Value := Parametro.QUANTIDADE;
    edCodigoProduto.Enabled := False;
  end;

  AjustaForm(Self);
end;

procedure TfrmDescarteSE.SelecionaMotivoDescarte;
var
  FWC : TFWConnection;
  M   : TMOTIVODESCARTE;
  Filtro : string;
begin
  FWC    := TFWConnection.Create;
  M      := TMOTIVODESCARTE.Create(FWC);
  edMotivo.Clear;
  try
    Filtro := '';
    edCodigoMotivo.Tag := DMUtil.Selecionar(M, edCodigoMotivo.Text, Filtro);
    if edCodigoMotivo.Tag > 0 then begin
      M.SelectList('id = ' + IntToStr(edCodigoMotivo.Tag));
      if M.Count > 0 then begin
        edCodigoMotivo.Text     := TMOTIVODESCARTE(M.Itens[0]).ID.asString;
        edMotivo.Text           := TMOTIVODESCARTE(M.Itens[0]).DESCRICAO.asString;
      end;
    end;
  finally
    FreeAndNil(M);
    FreeAndNil(FWC);
  end;
end;

end.
