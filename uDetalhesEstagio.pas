unit uDetalhesEstagio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls;

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
    gdDetalhes: TDBGrid;
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
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure CarregaInformacaoLote;
    { Private declarations }
  public
    Param : TParametros;
    { Public declarations }
  end;

var
  frmDetalhesEstagio: TfrmDetalhesEstagio;

implementation

{$R *.dfm}

uses uFuncoes, uMensagem, uFWConnection, FireDAC.Comp.Client;

procedure TfrmDetalhesEstagio.btFecharClick(Sender: TObject);
begin
  Close;
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

procedure TfrmDetalhesEstagio.FormCreate(Sender: TObject);
begin
  CDS_DETALHES.CreateDataSet;
end;

procedure TfrmDetalhesEstagio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmDetalhesEstagio.FormShow(Sender: TObject);
begin
  if Param.IDOPFE > 0 then begin
    CarregaInformacaoLote;
    AutoSizeDBGrid(gdDetalhes);
  end else
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

end.
