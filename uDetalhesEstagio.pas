unit uDetalhesEstagio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.ImgList;

type
  TParametros = record
    IDOPFE : Integer;
    UNIDADES : Integer;
  end;

type
  TfrmDetalhesEstagio = class(TForm)
    gpBotoes: TGridPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    btFechar: TSpeedButton;
    CDS_DETALHES: TClientDataSet;
    DS_DETALHES: TDataSource;
    CDS_DETALHESNUMEROLOTE: TIntegerField;
    CDS_DETALHESDATALOTE: TDateField;
    CDS_DETALHESLOCALIZACAO: TStringField;
    CDS_DETALHESUNIDADES: TIntegerField;
    CDS_DETALHESUSUARIO: TStringField;
    CDS_DETALHESESTACAO: TStringField;
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    lbOP: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    lbEspecie: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    lbEstagio: TLabel;
    Label4: TLabel;
    Panel4: TPanel;
    lbUnidades: TLabel;
    Label5: TLabel;
    Panel5: TPanel;
    lbCultivar: TLabel;
    Label6: TLabel;
    GridPanelGrid: TGridPanel;
    Panel6: TPanel;
    gdDetalhes: TDBGrid;
    Panel7: TPanel;
    gdSaidas: TDBGrid;
    lbSaidas: TLabel;
    CDS_ENTRADAS: TClientDataSet;
    DS_ENTRADAS: TDataSource;
    CDS_SAIDAS: TClientDataSet;
    DS_SAIDAS: TDataSource;
    CDS_ENTRADASCODIGOBARRAS: TStringField;
    CDS_SAIDASCODIGO: TIntegerField;
    Panel10: TPanel;
    lbEntradas: TLabel;
    gdEntradas: TDBGrid;
    CDS_SAIDASDESCARTAR: TIntegerField;
    ImageList1: TImageList;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DS_DETALHESDataChange(Sender: TObject; Field: TField);
    procedure FormResize(Sender: TObject);
    procedure gdSaidasCellClick(Column: TColumn);
    procedure gdSaidasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure CarregaInformacaoLote;
    procedure CarregaEntradaSaidas;
    { Private declarations }
  public
    Param : TParametros;
    { Public declarations }
  end;

var
  frmDetalhesEstagio: TfrmDetalhesEstagio;

implementation

{$R *.dfm}

uses
  uFuncoes,
  uMensagem,
  uFWConnection;

procedure TfrmDetalhesEstagio.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDetalhesEstagio.CarregaEntradaSaidas;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin

  CDS_ENTRADAS.DisableControls;
  CDS_SAIDAS.DisableControls;

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);

  try
    try

      CDS_ENTRADAS.EmptyDataSet;
      CDS_SAIDAS.EmptyDataSet;

       lbEntradas.Caption := 'Entradas: 0';
       lbSaidas.Caption := 'Saídas: 0';

      //Carrega Entradas
      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	OPFELE.CODIGOBARRAS');
      SQL.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_E OPFELE ON (OPFELE.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPFE.ID = :IDOPFE');
      SQL.SQL.Add('AND OPFEL.NUMEROLOTE = :NUMEROLOTE');

      SQL.ParamByName('IDOPFE').DataType  := ftInteger;
      SQL.ParamByName('IDOPFE').Value     := Param.IDOPFE;
      SQL.ParamByName('NUMEROLOTE').DataType := ftInteger;
      SQL.ParamByName('NUMEROLOTE').Value    := CDS_DETALHESNUMEROLOTE.Value;

      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          CDS_ENTRADAS.Append;
          CDS_ENTRADASCODIGOBARRAS.Value  := SQL.FieldByName('CODIGOBARRAS').AsString;
          CDS_ENTRADAS.Post;
          SQL.Next;
        end;
      end;

      //Carrega Saídas
      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	OPFELS.ID AS CODIGOBARRAS');
      SQL.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPFELS.BAIXADO = FALSE');
      SQL.SQL.Add('AND OPFE.ID = :IDOPFE');
      SQL.SQL.Add('AND OPFEL.NUMEROLOTE = :NUMEROLOTE');

      SQL.ParamByName('IDOPFE').DataType  := ftInteger;
      SQL.ParamByName('IDOPFE').Value     := Param.IDOPFE;
      SQL.ParamByName('NUMEROLOTE').DataType := ftInteger;
      SQL.ParamByName('NUMEROLOTE').Value    := CDS_DETALHESNUMEROLOTE.Value;

      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          CDS_SAIDAS.Append;
          CDS_SAIDASCODIGO.Value := SQL.FieldByName('CODIGOBARRAS').AsInteger;
          CDS_SAIDAS.Post;
          SQL.Next;
        end;
      end;

      lbEntradas.Caption := 'Entradas: ' + IntToStr(CDS_ENTRADAS.RecordCount);
      lbSaidas.Caption := 'Saídas: ' + IntToStr(CDS_SAIDAS.RecordCount);

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar Entradas e Saídas!', '', E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
    CDS_ENTRADAS.EnableControls;
    CDS_SAIDAS.EnableControls;
  end;
end;

procedure TfrmDetalhesEstagio.CarregaInformacaoLote;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin

  try
    FWC := TFWConnection.Create;
    SQL := TFDQuery.Create(nil);
    CDS_DETALHES.DisableControls;
    try

      CDS_DETALHES.EmptyDataSet;

      //Carrega Cabeçalho
      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	E.DESCRICAO AS ESTAGIO,');
      SQL.SQL.Add('	P.DESCRICAO || '' - '' || OPF.ID AS ESPECIE,');
      SQL.SQL.Add('	OPF.CULTIVAR');
      SQL.SQL.Add('FROM OPFINAL OPF');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      SQL.SQL.Add('INNER JOIN ESTAGIO E ON (E.ID = OPFE.ESTAGIO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPFE.ID = :IDOPFE');
      SQL.ParamByName('IDOPFE').DataType  := ftInteger;
      SQL.ParamByName('IDOPFE').Value     := Param.IDOPFE;

      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        lbOP.Caption := IntToStr(Param.IDOPFE);
        lbEstagio.Caption := SQL.FieldByName('ESTAGIO').AsString;
        lbEspecie.Caption := SQL.FieldByName('ESPECIE').AsString;
        lbUnidades.Caption:= IntToStr(Param.UNIDADES);
        lbCultivar.Caption:= SQL.FieldByName('CULTIVAR').AsString;
      end;

      //Carrega Grid
      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	OPFEL.NUMEROLOTE,');
      SQL.SQL.Add('	CAST(OPFEL.DATAHORAINICIO AS DATE) AS DATA,');
      SQL.SQL.Add('	OPFEL.LOCALIZACAO,');
      SQL.SQL.Add('	U.NOME AS USUARIO,');
      SQL.SQL.Add('	OPFEL.ESTACAOTRABALHO,');
      SQL.SQL.Add('	COUNT(OPFELS.ID) AS UNIDADES');
      SQL.SQL.Add('FROM OPFINAL_ESTAGIO OPFE');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
      SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
      SQL.SQL.Add('INNER JOIN USUARIO U ON (U.ID = OPFEL.USUARIO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPFE.ID = :IDOPFE');
      SQL.SQL.Add('AND OPFELS.BAIXADO = FALSE');
      SQL.SQL.Add('GROUP BY 1, 2, 3, 4, 5');
      SQL.SQL.Add('ORDER BY OPFEL.NUMEROLOTE ASC');

      SQL.ParamByName('IDOPFE').DataType  := ftInteger;
      SQL.ParamByName('IDOPFE').Value     := Param.IDOPFE;

      SQL.Connection  := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      if not SQL.IsEmpty then begin
        SQL.First;
        while not SQL.Eof do begin
          CDS_DETALHES.Append;
          CDS_DETALHESNUMEROLOTE.Value  := SQL.FieldByName('NUMEROLOTE').AsInteger;
          CDS_DETALHESDATALOTE.Value    := SQL.FieldByName('DATA').AsDateTime;
          CDS_DETALHESLOCALIZACAO.Value := SQL.FieldByName('LOCALIZACAO').AsString;
          CDS_DETALHESUSUARIO.Value     := SQL.FieldByName('USUARIO').AsString;
          CDS_DETALHESESTACAO.Value     := SQL.FieldByName('ESTACAOTRABALHO').AsString;
          CDS_DETALHESUNIDADES.Value    := SQL.FieldByName('UNIDADES').AsInteger;
          CDS_DETALHES.Post;
          SQL.Next;
        end;
      end;
    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Carregar os dados da Tela.', '', E.Message);
      end;
    end;

  finally
    CDS_DETALHES.EnableControls;
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure TfrmDetalhesEstagio.DS_DETALHESDataChange(Sender: TObject;
  Field: TField);
begin
  if not CDS_DETALHES.IsEmpty then
    CarregaEntradaSaidas;
end;

procedure TfrmDetalhesEstagio.FormCreate(Sender: TObject);
begin
  CDS_DETALHES.CreateDataSet;
  CDS_ENTRADAS.CreateDataSet;
  CDS_SAIDAS.CreateDataSet;
end;

procedure TfrmDetalhesEstagio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmDetalhesEstagio.FormResize(Sender: TObject);
begin
  AutoSizeDBGrid(gdDetalhes);
  AutoSizeDBGrid(gdEntradas);
  AutoSizeDBGrid(gdSaidas);
end;

procedure TfrmDetalhesEstagio.FormShow(Sender: TObject);
begin
  if Param.IDOPFE > 0 then begin
    CarregaInformacaoLote;
    AutoSizeDBGrid(gdDetalhes);
    AutoSizeDBGrid(gdEntradas);
    AutoSizeDBGrid(gdSaidas);
  end else
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmDetalhesEstagio.gdSaidasCellClick(Column: TColumn);
begin
  if gdSaidas.SelectedField.FieldName = 'DESCARTAR' then begin
    if Assigned(Self.gdSaidas.DataSource.DataSet.FindField('ID')) then begin
      ShowMessage('Teste');
      //ImprimirOPFE(Self.gdOPGerada.DataSource.DataSet.FieldByName('ID').AsInteger);
    end;
  end;
end;

procedure TfrmDetalhesEstagio.gdSaidasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  PositionLeft : Integer;
begin
  if Column.Field.FieldName = 'DESCARTAR' then begin
    gdSaidas.DefaultDrawDataCell(Rect, gdSaidas.Columns[DataCol].Field, State);
    PositionLeft := (Rect.Left + Rect.Right) div 2;
    gdSaidas.Canvas.FillRect(Rect);
    ImageList1.Draw(gdSaidas.Canvas, PositionLeft - 7, Rect.Top + 2, 1);
  end;
end;

end.
