unit uDMUtil;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, forms, Vcl.Controls,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, Vcl.ImgList, uFWPersistence, Vcl.StdCtrls,
  frxClass, frxDesgn, frxDBSet, frxExportPDF, frxExportXLS, fs_ichartrtti,
  Data.DB, VCLTee.TeeData, frxBarcode;

type
  TDMUtil = class(TDataModule)
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    ImageList1: TImageList;
    frxBarCodeObject1: TfrxBarCodeObject;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Selecionar(Tabela : TFWPersistence; ValorControl : String = ''; Filtro : String = ''; Tabela2 : TFWPersistence = nil) : Integer;
    function SelecionarMeioCultura(Estagio : Integer = 0; Especie : Integer = 0; Valor : String = '') : Integer;
    function SelecionarOrdemProducaoMeioCultura(Estagio : Integer = 0; Especie : Integer = 0; Valor : String = '') : Integer;
    function SelecionarCadastroPlantas(Valor : String = '') : Integer;
    procedure ImprimirRelatorio(Relatorio : String);
  end;

var
  DMUtil: TDMUtil;
  RelParams : TStringList;

implementation

Uses
  uConstantes,
  uFuncoes,
  uSeleciona,
  uSelecionaOPMC,
  uSelecionaMeioCultura,
  uMensagem, uSelecionaCadastroPlantas;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMUtil.DataModuleCreate(Sender: TObject);
begin
  DirInstall        := GetCurrentDir;
  if DirInstall[Length(DirInstall)] <> '\' then
    DirInstall := DirInstall + '\';

  DirArqConf        := DirInstall + 'Agrociencia.ini';
  DirArquivosExcel  := DirInstall + 'Arquivos\';

  if not DirectoryExists(DirInstall) then
    CreateDir(DirInstall);

  CarregarConfigLocal;

  CarregarConexaoBD;

  if Length(Trim(CONFIG_LOCAL.DirImagens)) > 0 then begin
    if not DirectoryExists(CONFIG_LOCAL.DirImagens) then
      CreateDir(CONFIG_LOCAL.DirImagens);
  end;

  RelParams    := TStringList.Create;
  carregaArrayClassificacao;
end;

procedure TDMUtil.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(RelParams);
end;

procedure TDMUtil.ImprimirRelatorio(Relatorio: String);
var
  Arquivo : String;
  ArqText : TextFile;
  I       : Integer;
begin
  frxReport1.Clear;

  Arquivo                  := CONFIG_LOCAL.DirRelatorios + Relatorio;

  if not FileExists(Arquivo) then begin
    DisplayMsg(MSG_WAR, 'Arquivo ' + Arquivo + ' não encontrado, Verifique!');
    Exit;
  end;

  frxReport1.LoadFromFile(Arquivo);

  frxReport1.Variables['Usuario'] := QuotedStr(USUARIO.NOME);

  for I := 0 to Pred(RelParams.Count) do begin
    FrxReport1.Variables[Copy(RelParams.Strings[I], 0, Pos('=',RelParams.Strings[I]) -1)] := QuotedStr(Copy(RelParams.Strings[I], Pos('=',RelParams.Strings[I]) + 1, Length(RelParams.Strings[I]) - Pos('=',RelParams.Strings[I]) + 1));
  end;

  try
    if DESIGNREL then begin
      AssignFile(ArqText, Arquivo);
      frxReport1.DesignReport();
      Reset(ArqText);
      CloseFile(ArqText);
    end else
      frxReport1.ShowReport();
  finally
    frxReport1.Clear;
  end;
end;

function TDMUtil.Selecionar(Tabela : TFWPersistence; ValorControl : String; Filtro : String; Tabela2 : TFWPersistence): Integer;
var
  Control : TEdit;
begin
  Result                      := 0;
  Control                     := TEdit.Create(nil);
  try
    if not Assigned(frmSeleciona) then
      frmSeleciona            := TfrmSeleciona.Create(nil);
    if ValorControl <> '' then
      Control.Text            := ValorControl;
    frmSeleciona.Retorno      := Control;
    frmSeleciona.FTabelaPai   := Tabela;
    if Assigned(Tabela2) then
      frmSeleciona.FTabelaAux := Tabela2;
    if Filtro <> EmptyStr then
      frmSeleciona.Filtro     := Filtro;
    if (frmSeleciona.ShowModal = mrOk) or (Control.Text <> '') then
      Result                  := StrToIntDef(Control.Text,0);
  finally
    FreeAndNil(Control);
  end;
end;

function TDMUtil.SelecionarCadastroPlantas(Valor: String): Integer;
var
  Control : TEdit;
begin
  Result                      := 0;
  Control                     := TEdit.Create(nil);
  try
    if not Assigned(frmSelecionaCadastroPlantas) then
      frmSelecionaCadastroPlantas       := TfrmSelecionaCadastroPlantas.Create(nil);
    if Valor <> EmptyStr then
      Control.Text                      := Valor;
    frmSelecionaCadastroPlantas.Retorno := Control;
    if (frmSelecionaCadastroPlantas.ShowModal = mrOk) or (Control.Text <> '') then
      Result                            := StrToIntDef(Control.Text,0);
  finally
    FreeAndNil(Control);
  end;
end;

function TDMUtil.SelecionarMeioCultura(Estagio, Especie: Integer; Valor : String): Integer;
var
  Control : TEdit;
begin
  Result                      := 0;
  Control                     := TEdit.Create(nil);
  try
    if not Assigned(frmSelecionaMeioCultura) then
      frmSelecionaMeioCultura            := TfrmSelecionaMeioCultura.Create(nil);
    if Valor <> EmptyStr then
      Control.Text                       := Valor;
    frmSelecionaMeioCultura.Retorno      := Control;
    frmSelecionaMeioCultura.prm_Estagio  := Estagio;
    frmSelecionaMeioCultura.prm_Especie  := Especie;
    if (frmSelecionaMeioCultura.ShowModal = mrOk) or (Control.Text <> '') then
      Result                             := StrToIntDef(Control.Text,0);
  finally
    FreeAndNil(Control);
  end;
end;

function TDMUtil.SelecionarOrdemProducaoMeioCultura(Estagio, Especie: Integer;
  Valor: String): Integer;
var
  Control : TEdit;
begin
  Result                      := 0;
  Control                     := TEdit.Create(nil);
  try
    if not Assigned(frmSelecionaOPMC) then
      frmSelecionaOPMC                   := TfrmSelecionaOPMC.Create(nil);
    if Valor <> EmptyStr then
      Control.Text                       := Valor;
    frmSelecionaOPMC.prm_Estagio         := Estagio;
    frmSelecionaOPMC.prm_Especie         := Especie;
    frmSelecionaOPMC.Retorno             := Control;
    if (frmSelecionaOPMC.ShowModal = mrOk) or (Control.Text <> '') then
      Result                             := StrToIntDef(Control.Text,0);
  finally
    FreeAndNil(Control);
  end;
end;

end.
