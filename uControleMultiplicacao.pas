unit uControleMultiplicacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids;

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
    edLoteEstagio: TLabeledEdit;
    edOrdemProducao: TLabeledEdit;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPausePlayClick(Sender: TObject);
  private
    Procedure CarregaDadosOPF;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleMultiplicacao: TfrmControleMultiplicacao;

implementation

uses
  uFuncoes;

{$R *.dfm}

{ TfrmControleMultiplicacao }

procedure TfrmControleMultiplicacao.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmControleMultiplicacao.btPausePlayClick(Sender: TObject);
begin
  if btPausePlay.Tag = 0 then begin
    btPausePlay.Glyph := nil;
    ImageList1.GetBitmap(1, btPausePlay.Glyph);
    btPausePlay.Tag := 1;
  end else begin
    btPausePlay.Glyph := nil;
    ImageList1.GetBitmap(2, btPausePlay.Glyph);
    btPausePlay.Tag := 0;
  end;
end;

procedure TfrmControleMultiplicacao.CarregaDadosOPF;
begin
  //
end;

procedure TfrmControleMultiplicacao.FormCreate(Sender: TObject);
begin
  AjustaForm(Self);
end;

procedure TfrmControleMultiplicacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.
