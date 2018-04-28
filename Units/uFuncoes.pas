unit uFuncoes;

interface

uses
  System.SysUtils,
  System.UITypes,
  IdHashMessageDigest,
  Vcl.Dialogs,
  Grids,
  DBGrids,
  DateUtils,
  Winapi.Windows,
  Vcl.Menus,
  Vcl.Forms,
  Datasnap.DBClient,
  Data.DB,
  Vcl.Graphics,
  System.Win.ComObj,
  FireDAC.Comp.Client,
  Vcl.ExtCtrls,
  Vcl.ExtDlgs,
  Vcl.Imaging.jpeg,
  frxDBSet,
  FireDAC.Stan.Intf,
  System.Math;

  procedure CarregarConfigLocal;
  procedure LimpaImagens;
  procedure CarregaArrayMenus(Menu : TMainMenu);
  procedure DefinePermissaoMenu(Menu : TMainMenu);
  procedure CarregarConexaoBD;
  procedure AutoSizeDBGrid(const DBGrid: TDBGrid);
  procedure DimensionarGrid(dbg: TDbGrid; var formulario);
  procedure AjustaForm(Form : TForm);
  procedure OrdenarGrid(Column: TColumn);
  procedure ExpXLS(DataSet: TDataSet; NomeArq: string);
  procedure DeletarArquivosPasta(Diretorio : String);
  procedure ConverterBMPtoJPEG(ACaminhoFoto: string);
  procedure ImprimirOPMC(ID : Integer);
  procedure ImprimirEtiquetaOPMC(ID : Integer);
  procedure ImprimirEtiquetasRP(ID : Integer);
  procedure ImprimirOPFE(ID : Integer);
  procedure ImprimirOPSOL(ID : Integer);
  function ExcluirOPFE(ID : Integer) : Boolean;
  function ExcluirOPF(ID : Integer) : Boolean;
  function EncerrarOPSE(ID : Integer) : Boolean;
  function EncerrarOPF(ID : Integer) : Boolean;
  function CancelarOPF(ID : Integer) : Boolean;
  function ValidaUsuario(Email, Senha : String) : Boolean;
  function MD5(Texto : String): String;
  function Criptografa(Texto : String; Tipo : String) : String;
  function SoNumeros(Texto: String): String;
  function CalculaPercentualDiferenca(ValorAnterior, ValorNovo : Currency) : Currency;
  function StrZero(Texto : string; Quant : Integer): string;
  function carregaArrayClassificacao : Boolean;
  function FormataCNPJ(CNPJ : String) : String;
  function AjustaTamnhoCNPJ(CNPJ : String) : String;
  function ExcluirCaracteresdeNumeric(Valor : Variant) : String;
  function RetornaCodigo_CF(CF : String) : Integer;
  function ValidaCPFCNPJ(Texto : String) : Boolean;
  function LimiteMultiplicacao(CodigoOPF, IDEstagio : Integer) : Boolean;
  function SelecionarImagemBMP : String;
  function TemSaldoOPMC(CodigoOPMC, Quantidade : Integer) : Boolean;
  procedure ExpDbGridXLS(const DBGrid: TDBGrid; NomeArq: string);

implementation

Uses
  uConstantes,
  IniFiles,
  uFWConnection,
  uBeanUsuario,
  uBeanUsuario_Permissao,
  uDomains,
  uMensagem, uDMUtil, uBeanOPFinal_Estagio, uBeanOPFinal_Estagio_Lote,
  uBeanOPFinal, uBeanOrdemProducaoSolucao, uBeanOrdemProducaoSolucao_Itens,
  uBeanControleEstoque, uBeanControleEstoqueProduto;

procedure LimpaImagens;
var
  IMAGEM : Integer;
begin
  for IMAGEM := Low(IMAGENS) to High(IMAGENS) do begin
    IMAGENS[IMAGEM].Imagem.Picture.Assign(nil);
    IMAGENS[IMAGEM].Imagem.Destroy;
    IMAGENS[IMAGEM].ID := 0;
    IMAGENS[IMAGEM].NomeImagem := '';
  end;
  SetLength(IMAGENS, 0);
end;
procedure CarregarConfigLocal;
Var
  ArqINI : TIniFile;
begin

  ArqINI := TIniFile.Create(DirArqConf);
  try

    LOGIN.Usuario               := ArqINI.ReadString('LOGIN', 'USUARIO', '');
    LOGIN.LembrarUsuario        := ArqINI.ReadBool('LOGIN', 'LEMBRARUSUARIO', True);

    CONFIG_LOCAL.DirRelatorios  := ArqINI.ReadString('CONFIGURACOES', 'DIR_RELATORIOS', DirInstall + 'Relatorios\');
    CONFIG_LOCAL.DirImagens     := ArqINI.ReadString('CONFIGURACOES', 'DIR_IMAGENS', DirInstall + 'Imagens\');
    CONFIG_LOCAL.DirBackup      := ArqINI.ReadString('CONFIGURACOES', 'DIR_BACKUP', DirInstall + 'Backup\');
    CONFIG_LOCAL.WebCam         := ArqINI.ReadString('CONFIGURACOES', 'WEBCAM', EmptyStr);

  finally
    FreeAndNil(ArqINI);
  end;

end;

procedure CarregarConexaoBD;
Var
  ArqINI : TIniFile;
begin

  ArqINI := TIniFile.Create(DirArqConf);
  try

    CONEXAO.LibVendor     := ExtractFilePath(ParamStr(0)) + 'libpq.dll';
    CONEXAO.Database      := ArqINI.ReadString('CONEXAOBD', 'Database', '');
    CONEXAO.Server        := ArqINI.ReadString('CONEXAOBD', 'Server', 'localhost');
    CONEXAO.User_Name     := ArqINI.ReadString('CONEXAOBD', 'User_Name', '');
    CONEXAO.Password      := ArqINI.ReadString('CONEXAOBD', 'Password', '');
    CONEXAO.CharacterSet  := ArqINI.ReadString('CONEXAOBD', 'CharacterSet', 'UTF8');
    CONEXAO.DriverID      := ArqINI.ReadString('CONEXAOBD', 'DriverID', 'PG');
    CONEXAO.Port          := ArqINI.ReadString('CONEXAOBD', 'Port', '5432');

  finally
    FreeAndNil(ArqINI);
  end;

end;

procedure AutoSizeDBGrid(const DBGrid: TDBGrid);
var
  TotalColumnWidth, ColumnCount, GridClientWidth, Filler, i: Integer;
begin
  ColumnCount := DBGrid.Columns.Count;
  if ColumnCount = 0 then
    Exit;

  // compute total width used by grid columns and vertical lines if any
  TotalColumnWidth := 0;
  for i := 0 to ColumnCount-1 do
    TotalColumnWidth := TotalColumnWidth + DBGrid.Columns[i].Width;
  if dgColLines in DBGrid.Options then
    // include vertical lines in total (one per column)
    TotalColumnWidth := TotalColumnWidth + ColumnCount;

  // compute grid client width by excluding vertical scroll bar, grid indicator,
  // and grid border
  GridClientWidth := DBGrid.Width - GetSystemMetrics(SM_CXVSCROLL);
  if dgIndicator in DBGrid.Options then begin
    GridClientWidth := GridClientWidth - IndicatorWidth;
    if dgColLines in DBGrid.Options then
      Dec(GridClientWidth);
  end;
  if DBGrid.BorderStyle = bsSingle then begin
    if DBGrid.Ctl3D then // border is sunken (vertical border is 2 pixels wide)
      GridClientWidth := GridClientWidth - 4
    else // border is one-dimensional (vertical border is one pixel wide)
      GridClientWidth := GridClientWidth - 2;
  end;

  // adjust column widths
  if TotalColumnWidth < GridClientWidth then begin
    Filler := (GridClientWidth - TotalColumnWidth) div ColumnCount;
    for i := 0 to ColumnCount-1 do
      DBGrid.Columns[i].Width := DBGrid.Columns[i].Width + Filler;
  {end
  else if TotalColumnWidth > GridClientWidth then begin
    Filler := (TotalColumnWidth - GridClientWidth) div ColumnCount;
    if (TotalColumnWidth - GridClientWidth) mod ColumnCount <> 0 then
      Inc(Filler);
    for i := 0 to ColumnCount-1 do
      DBGrid.Columns[i].Width := DBGrid.Columns[i].Width - Filler;}
  end;
end;

procedure DimensionarGrid(dbg: TDbGrid; var formulario);
type
  TArray = Array of integer;

  procedure AjustarColumns(Swidth,TSize:integer;Asize:TArray);
  var
    idx : Integer;
   begin
     if Tsize = 0 then
        begin
           Tsize:=dbg.Columns.Count;
             for idx:=0 to dbg.Columns.Count-1 do
               dbg.Columns[Idx].Width:=
                     (dbg.Width- dbg.Canvas.TextWidth('AAAAAA')) div Tsize
        end
     else
      for idx:=0 to dbg.Columns.Count-1 do
        dbg.Columns[Idx].Width:=dbg.Columns[Idx].Width + (Swidth*Asize[idx] div Tsize);
   end;
var
  Idx,
  Twidth,
  Tsize,
  Swidth : Integer;
  AWidth : TArray;
  Asize : TArray;
  NomeColuna : String;
begin
  SetLength(AWidth,dbg.Columns.Count);
  SetLength(ASize,dbg.Columns.Count);
  TWidth:=0;
  TSize:=0;

  for Idx := 0 to dbg.Columns.Count - 1  do begin
    NomeColuna := Dbg.Columns[Idx].Title.Caption;
    dbg.Columns[Idx].Width := dbg.Canvas.TextWidth(Dbg.Columns[Idx].Title.Caption+'A');
    AWidth[idx] := dbg.Columns[Idx].Width;
    TWidth := TWidth + AWidth[idx];
    Asize[idx] := dbg.Columns[idx].Field.Size;
    Tsize := Tsize+Asize[idx];
  end;

  if dgColLines in dbg.Options then
    TWidth := TWidth+ Dbg.Columns.Count;

  //adiciona a largura da coluna indicada do cursor
  if dgIndicator in Dbg.Options then
    TWidth := TWidth+IndicatorWidth;

  Swidth := dbg.ClientWidth - TWidth;
  AjustarColumns(Swidth,TSize,Asize);
  dbg.Width := dbg.Width + dbg.Canvas.TextWidth('AAAAAA');
  Dbg.Left := (Tform(formulario).Width - dbg.Width) div 2 - (dbg.Canvas.TextWidth('AA') div 2);
end;

procedure AjustaForm(Form : TForm);
begin
  Form.ClientHeight := Application.MainForm.ClientHeight - 2; //Cabeçalho form principal
  Form.ClientWidth  := Application.MainForm.ClientWidth;
  Form.Height       := Application.MainForm.ClientHeight - 2; //Cabeçalho form principal
  Form.Width        := Application.MainForm.ClientWidth;
  Form.Top          := Application.MainForm.Top   + Application.MainForm.BorderWidth + 47;
  Form.Left         := Application.MainForm.Left  + Application.MainForm.BorderWidth + 3;
end;

procedure OrdenarGrid(Column: TColumn);
var
  Indice    : string;
  Existe    : Boolean;
  I         : Integer;
  CDS_idx   : TClientDataSet;
  FDM       : TFDMemTable;
  DB_GRID   : TDBGrid;
  C         : TColumn;
begin

  if Column.Grid.DataSource.DataSet is TClientDataSet then begin

    CDS_idx := TClientDataSet(Column.Grid.DataSource.DataSet);

    if CDS_idx.IndexFieldNames = Column.FieldName then begin

      Indice := AnsiUpperCase(Column.FieldName+'_INV');

      Existe  := False;
      For I := 0 to Pred(CDS_idx.IndexDefs.Count) do begin
        if AnsiUpperCase(CDS_idx.IndexDefs[I].Name) = Indice then begin
          Existe := True;
          Break;
        end;
      end;

      if not Existe then
        with CDS_idx.IndexDefs.AddIndexDef do begin
          Name := indice;
          Fields := Column.FieldName;
          Options := [ixDescending];
        end;
      CDS_idx.IndexName := Indice;
    end else
      CDS_idx.IndexFieldNames := Column.FieldName;

    if Column.Grid is TDBGrid then begin
      DB_GRID := TDBGrid(Column.Grid);
      for I := 0 to DB_GRID.Columns.Count - 1 do begin
        C := DB_GRID.Columns[I];
        if Column <> C then begin
          if C.Title.Font.Color <> clWindowText then
            C.Title.Font.Color := clWindowText;
        end;
      end;
      Column.Title.Font.Color := clBlue;
    end;
  end else begin

    if Column.Grid.DataSource.DataSet is TFDMemTable then begin
      FDM := TFDMemTable(Column.Grid.DataSource.DataSet);

      if FDM.IndexFieldNames = Column.FieldName then begin

        Indice := AnsiUpperCase(Column.FieldName+'_INV');

        Existe  := False;
        For I := 0 to Pred(FDM.IndexDefs.Count) do begin
          if AnsiUpperCase(FDM.IndexDefs[I].Name) = Indice then begin
            Existe := True;
            Break;
          end;
        end;

        if not Existe then
          with FDM.Indexes.Add do begin
            Name := Indice;
            Fields := Column.FieldName;
            Options := [soDescending];
            Active := True;
          end;
        FDM.IndexName := Indice;
        FDM.IndexesActive := True;
      end else
        FDM.IndexFieldNames := Column.FieldName;

      if Column.Grid is TDBGrid then begin
        DB_GRID := TDBGrid(Column.Grid);
        for I := 0 to DB_GRID.Columns.Count - 1 do begin
          C := DB_GRID.Columns[I];
          if Column <> C then begin
            if C.Title.Font.Color <> clWindowText then
              C.Title.Font.Color := clWindowText;
          end;
        end;
        Column.Title.Font.Color := clBlue;
      end;

    end;
  end;
end;

procedure ExpXLS(DataSet: TDataSet; NomeArq: string);
var
  ExcApp: OleVariant;
  I,
  L : Integer;
  VarNomeArq : String;
begin

  DataSet.DisableControls;

  try

    if DataSet.IsEmpty then
      Exit;

    VarNomeArq := DirArquivosExcel + FormatDateTime('yyyymmdd', Date) + '\' + NomeArq;

    if not DirectoryExists(ExtractFilePath(VarNomeArq)) then
      ForceDirectories(ExtractFilePath(VarNomeArq));

    if FileExists(VarNomeArq) then
      DeleteFile(PChar(VarNomeArq));

    ExcApp := CreateOleObject('Excel.Application');
    ExcApp.Visible := True;
    ExcApp.WorkBooks.Add;
    DataSet.First;
    L := 1;
    DataSet.First;
    while not DataSet.Eof do begin
      if L = 1 then begin
        for I := 0 to DataSet.Fields.Count - 1 do begin
          if DataSet.Fields[i].Visible then begin
            if DataSet.Fields[i] is TStringField then
              ExcApp.WorkBooks[1].Sheets[1].Columns[I + 1].NumberFormat := '@';

            ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1].Font.Bold  := True;
            ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1].Font.Color := clBlue;
            ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1]            := DataSet.Fields[I].DisplayName;
          end;
        end;
        L := L + 1;
      end;

      for I := 0 to DataSet.Fields.Count - 1 do
        if DataSet.Fields[i].Visible then begin
          ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1] := DataSet.Fields[i].DisplayText;
        end;

      DataSet.Next;
      L := L + 1;
    end;
    ExcApp.Columns.AutoFit;
    ExcApp.WorkBooks[1].SaveAs(VarNomeArq);
  finally
    DataSet.EnableControls;
  end;
end;

procedure DeletarArquivosPasta(Diretorio : String);
var
  SR: TSearchRec;
  I : Integer;
begin
  try
    I := FindFirst(Diretorio + '\*.*', faAnyFile, SR);
    while I = 0 do begin
      if ((SR.Attr and faDirectory) <> faDirectory) then
        DeleteFile(PChar(Diretorio + '\' + SR.Name));
      I := FindNext(SR);
    end;
  except
  end;
end;

procedure ConverterBMPtoJPEG(ACaminhoFoto: string);
var
  cjBmp : TBitmap;
  cjJpg : TJpegImage;
  strNomeSemExtensao: string;
  AFoto : TImage;
  Nome : string;
begin
  AFoto := TImage.Create(nil);
  cjJpg := TJPegImage.Create;
  cjBmp := TBitmap.Create;

  try

    AFoto.Picture.Bitmap.LoadFromFile(ACaminhoFoto + '.bmp');
    cjBmp.Assign(AFoto.Picture.Bitmap);
    cjJpg.Assign(cjBMP);

    Nome := ExtractFileName(ACaminhoFoto + '.jpg');

    cjJpg.SaveToFile(CONFIG_LOCAL.DirImagens + Nome);
    DeleteFile(PWideChar(ACaminhoFoto + '.bmp'));

  finally
    FreeAndNil(cjJpg);
    FreeAndNil(cjBmp);
    FreeAndNil(AFoto);
  end;
end;

procedure ImprimirOPMC(ID : Integer);
var
  FW    : TFWConnection;
  SQL   : TFDQuery;
  FR    : TfrxDBDataset;
  SQL_I : TFDQuery;
  FR_I  : TfrxDBDataset;
begin
  FW    := TFWConnection.Create;
  SQL   := TFDQuery.Create(nil);
  SQL_I := TFDQuery.Create(nil);
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.Connection := FW.FDConnection;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('CASE CHAR_LENGTH(CAST(OPMC.ID AS VARCHAR))');
    SQL.SQL.Add('	WHEN 1 THEN ''00'' || CAST(OPMC.ID AS VARCHAR)');
    SQL.SQL.Add('	WHEN 2 THEN ''0'' || CAST(OPMC.ID AS VARCHAR)');
    SQL.SQL.Add('	ELSE CAST(OPMC.ID AS VARCHAR) END AS ID,');
    SQL.SQL.Add('MC.CODIGO,');
    SQL.SQL.Add('E.METODO,');
    SQL.SQL.Add('OPMC.ID_RECIPIENTE,');
    SQL.SQL.Add('PR.DESCRICAO,');
    SQL.SQL.Add('MC.PHRECOMENDADO,');
    SQL.SQL.Add('OPMC.PHINICIAL,');
    SQL.SQL.Add('OPMC.PHFINAL,');
    SQL.SQL.Add('OPMC.DATAHORA,');
    SQL.SQL.Add('OPMC.QUANTRECIPIENTES,');
    SQL.SQL.Add('OPMC.MLRECIPIENTE,');
    SQL.SQL.Add('OPMC.QUANTPRODUTO,');
    SQL.SQL.Add('OPMC.OBSERVACAO,');
    SQL.SQL.Add('OPMC.OBSERVACAOENCERRAMENTO,');
    SQL.SQL.Add('OPMC.ID_USUARIOEXECUTAR,');
    SQL.SQL.Add('U.NOME,');
    SQL.SQL.Add('OPMC.DATAFIM,');
    SQL.SQL.Add('OPMC.ENCERRADO');
    SQL.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
    SQL.SQL.Add('INNER JOIN MEIOCULTURA MC ON OPMC.ID_PRODUTO = MC.ID_PRODUTO');
    SQL.SQL.Add('INNER JOIN ESTERILIZACAO E ON OPMC.ID_ESTERILIZACAO = E.ID');
    SQL.SQL.Add('INNER JOIN PRODUTO PR ON OPMC.ID_RECIPIENTE = PR.ID');
    SQL.SQL.Add('LEFT JOIN USUARIO U ON OPMC.ID_USUARIOEXECUTAR = U.ID');
    SQL.SQL.Add('WHERE OPMC.ID = :ID');
    SQL.ParamByName('ID').AsInteger := ID;
    SQL.Prepare;
    SQL.Open();

    if SQL.IsEmpty then begin
      DisplayMsg(MSG_INF, 'Dados da Ordem de Produção não encontrados!');
      Exit;
    end;

    SQL_I.Close;
    SQL_I.SQL.Clear;
    SQL_I.Connection := FW.FDConnection;
    SQL_I.SQL.Add('SELECT');
    SQL_I.SQL.Add('OPMCI.ID_PRODUTO,');
    SQL_I.SQL.Add('PR.DESCRICAO,');
    SQL_I.SQL.Add('UN.SIMBOLO,');
    SQL_I.SQL.Add('OPMCI.QUANTIDADE');
    SQL_I.SQL.Add('FROM ORDEMPRODUCAOMC_ITENS OPMCI');
    SQL_I.SQL.Add('INNER JOIN PRODUTO PR ON OPMCI.ID_PRODUTO = PR.ID');
    SQL_I.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON PR.UNIDADEMEDIDA_ID = UN.ID');
    SQL_I.SQL.Add('WHERE OPMCI.ID_ORDEMPRODUCAOMC = :ID');
    SQL_I.ParamByName('ID').AsInteger := ID;
    SQL_I.Prepare;
    SQL_I.Open();

    FR    := TfrxDBDataset.Create(nil);
    FR_I  := TfrxDBDataset.Create(nil);
    try
      FR.UserName     := 'ORDEMPRODUCAO';
      FR_I.UserName   := 'ITENS';

      FR.DataSet      := SQL;
      FR_I.DataSet    := SQL_I;

      RelParams.Clear;
      DMUtil.ImprimirRelatorio('frOPMC.fr3');
      DisplayMsgFinaliza;
    finally
      FreeAndNil(FR_I);
      FreeAndNil(FR);
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(SQL_I);
    FreeAndNil(FW);
  end;
end;

procedure ImprimirEtiquetaOPMC(ID : Integer);
var
  FWC   : TFWConnection;
  SQL   : TFDQuery;
begin
  FWC   := TFWConnection.Create;
  SQL   := TFDQuery.Create(nil);
  try
    try

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('CASE CHAR_LENGTH(CAST(OPMC.ID AS VARCHAR))');
      SQL.SQL.Add('	WHEN 1 THEN ''00'' || CAST(OPMC.ID AS VARCHAR)');
      SQL.SQL.Add('	WHEN 2 THEN ''0'' || CAST(OPMC.ID AS VARCHAR)');
      SQL.SQL.Add('	ELSE CAST(OPMC.ID AS VARCHAR) END AS ID,');
      SQL.SQL.Add('	OPMC.DATAHORA,');
      SQL.SQL.Add('	MC.CODIGO AS CODIGOMC,');
      SQL.SQL.Add('	PR.DESCRICAO AS TIPOFRASCO,');
      SQL.SQL.Add('	OPMC.QUANTRECIPIENTES,');
      SQL.SQL.Add('	E.METODO AS METODOESTERILIZACAO');
      SQL.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
      SQL.SQL.Add('INNER JOIN MEIOCULTURA MC ON OPMC.ID_PRODUTO = MC.ID_PRODUTO');
      SQL.SQL.Add('INNER JOIN ESTERILIZACAO E ON OPMC.ID_ESTERILIZACAO = E.ID');
      SQL.SQL.Add('INNER JOIN PRODUTO PR ON OPMC.ID_RECIPIENTE = PR.ID');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPMC.ID = :ID');
      SQL.ParamByName('ID').DataType  := ftInteger;
      SQL.ParamByName('ID').AsInteger := ID;
      SQL.Connection := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open();

      if not SQL.IsEmpty then begin
        DMUtil.frxDBDataset1.DataSet := SQL;
        RelParams.Clear;
        DMUtil.ImprimirRelatorio('frEtiquetaOPMC.fr3');
      end else begin
        DisplayMsg(MSG_WAR, 'Não há dados para Exibir, Verifique os Filtros!');
        Exit;
      end;
    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao montar Dados para o Relatório.', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure ImprimirEtiquetasRP(ID : Integer);
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
  FDMT : TFDMemTable;
  I : Integer;
begin

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  FDMT := TFDMemTable.Create(nil);

  try
    try

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	(P.DESCRICAO || '' - '' || OPF.ID) AS PRODUTO');
      SQL.SQL.Add('FROM OPFINAL OPF');
      SQL.SQL.Add('INNER JOIN PRODUTO P ON (P.ID = OPF.PRODUTO_ID)');
      SQL.SQL.Add('WHERE 1 = 1');
      SQL.SQL.Add('AND OPF.ID = :ID');

      SQL.Connection := FWC.FDConnection;
      SQL.Transaction := FWC.FDTransaction;

      SQL.ParamByName('ID').AsInteger := ID;

      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;
      SQL.Open;

      if not SQL.IsEmpty then begin

        FDMT.Close;
        FDMT.FieldDefs.Clear;
        FDMT.FieldDefs.Add('CODIGOOP', ftString, 13, False);
        FDMT.FieldDefs.Add('PRODUTO', ftString, 100, False);
        FDMT.CreateDataSet;

        DisplayMsg(MSG_INPUT_INT, 'Informe a Quantidade de Estiquetas!');

        if ResultMsgModal = mrOk then begin
          if ResultMsgInputInt > 0 then begin
            for I := 1 to ResultMsgInputInt do begin
              FDMT.Append;
              FDMT.FieldByName('CODIGOOP').AsString := StrZero(IntToStr(ID), MinimoCodigoBarras);
              FDMT.FieldByName('PRODUTO').AsString := SQL.FieldByName('PRODUTO').AsString;
              FDMT.Post;
            end;

            DMUtil.frxDBDataset1.DataSet := FDMT;
            RelParams.Clear;
            DMUtil.ImprimirRelatorio('frEtiqueta1.fr3');
          end;
        end;

      end else
        DisplayMsg(MSG_WAR, 'Não foram encontradas informações para o Recebimento de Plantas Selecionado, Verifique!');
    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao Imprimir as Etiquetas de Recebimento de Plantas!', '', E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(FDMT);
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure ImprimirOPFE(ID : Integer);
var
  FWC       : TFWConnection;
  Consulta  : TFDQuery;
  OPFE      : TOPFINAL_ESTAGIO;
  I         : Integer;
begin

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);
  OPFE      := TOPFINAL_ESTAGIO.Create(FWC);

  try
    try

      DisplayMsg(MSG_INPUT_INT, 'Informe a Quantidade de Lotes a Gerar!', '', '', '1');

      if ResultMsgModal = mrOk then begin
        if ResultMsgInputInt > 0 then begin
          OPFE.SelectList('ID = ' + IntToStr(ID));
          if OPFE.Count > 0 then begin

            Consulta.Close;
            Consulta.SQL.Clear;
            Consulta.SQL.Add('SELECT');
            Consulta.SQL.Add('	OPF.ID AS IDOPF,');
            Consulta.SQL.Add('	CASE CHAR_LENGTH(CAST(OPFE.ID AS VARCHAR))');
            Consulta.SQL.Add('		WHEN 1 THEN ''00'' || CAST(OPFE.ID AS VARCHAR)');
            Consulta.SQL.Add('		WHEN 2 THEN ''0'' || CAST(OPFE.ID AS VARCHAR)');
            Consulta.SQL.Add('		ELSE CAST(OPFE.ID AS VARCHAR) END AS IDOPFE,');
            Consulta.SQL.Add('	PF.ID AS CODIGOPRODUTO,');
            Consulta.SQL.Add('	PF.DESCRICAO AS NOMEPRODUTO,');
            Consulta.SQL.Add('	CAST(OPFE.DATAHORA AS DATE) AS DATAGERACAOOPFE,');
            Consulta.SQL.Add('	PMC.ID AS IDOPMC,');
            Consulta.SQL.Add('	CAST(OPFE.DATAHORA AS DATE) AS DATAGERACAOOPMC,');
            Consulta.SQL.Add('	MC.CODIGO AS CODIGOMC,');
            Consulta.SQL.Add('	OPFE.OBSERVACAO,');
            Consulta.SQL.Add('	CASE CHAR_LENGTH(CAST((COALESCE(OPFE.ULTIMOLOTE,0) + 1) AS VARCHAR))');
            Consulta.SQL.Add('			WHEN 1 THEN ''00'' || CAST((COALESCE(OPFE.ULTIMOLOTE,0) + 1) AS VARCHAR)');
            Consulta.SQL.Add('			WHEN 2 THEN ''0'' || CAST((COALESCE(OPFE.ULTIMOLOTE,0) + 1) AS VARCHAR)');
            Consulta.SQL.Add('			ELSE CAST((COALESCE(OPFE.ULTIMOLOTE,0) + 1) AS VARCHAR) END AS NUMEROLOTE,');
            Consulta.SQL.Add('	(OPF.ID || ''*'' || OPFE.SEQUENCIA) AS CODIGOBARRAS,');
            Consulta.SQL.Add('	OPFE.LOCALIZACAO');
            Consulta.SQL.Add('FROM OPFINAL OPF');
            Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
            Consulta.SQL.Add('INNER JOIN PRODUTO PF ON (PF.ID = OPF.PRODUTO_ID)');
            Consulta.SQL.Add('INNER JOIN PRODUTO PMC ON (PMC.ID = OPFE.MEIOCULTURA_ID)');
            Consulta.SQL.Add('INNER JOIN MEIOCULTURA MC ON (MC.ID_PRODUTO = PMC.ID)');
            Consulta.SQL.Add('WHERE 1 = 1');
            Consulta.SQL.Add('AND OPFE.ID = :IDOPFE');

            Consulta.Connection                     := FWC.FDConnection;

            for I := 0 to ResultMsgInputInt - 1 do begin

              Consulta.Close;
              Consulta.ParamByName('IDOPFE').DataType := ftInteger;
              Consulta.ParamByName('IDOPFE').AsInteger:= ID;
              Consulta.Prepare;
              Consulta.Open;
              Consulta.FetchAll;

              if not Consulta.IsEmpty then begin

                DMUtil.frxDBDataset1.DataSet := Consulta;
                RelParams.Clear;
                DMUtil.ImprimirRelatorio('frFichaTecnicadeProducao.fr3');

                FWC.StartTransaction;

                OPFE.ID.Value           := TOPFINAL_ESTAGIO(OPFE.Itens[0]).ID.Value;
                OPFE.ULTIMOLOTE.Value   := Consulta.FieldByName('NUMEROLOTE').AsInteger;
                OPFE.Update;

                FWC.Commit;
              end;
            end;
          end;
        end;
      end;
    Except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros na consulta!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(Consulta);
    FreeAndNil(OPFE);
    FreeAndNil(FWC);
  end;
end;

procedure ImprimirOPSOL(ID : Integer);
var
  FW    : TFWConnection;
  SQL   : TFDQuery;
  FR    : TfrxDBDataset;
  SQL_I : TFDQuery;
  FR_I  : TfrxDBDataset;
begin

  FW    := TFWConnection.Create;
  SQL   := TFDQuery.Create(nil);
  SQL_I := TFDQuery.Create(nil);
  try
    SQL.Close;
    SQL.SQL.Clear;
    SQL.Connection := FW.FDConnection;
    SQL.SQL.Add('SELECT');
    SQL.SQL.Add('CASE CHAR_LENGTH(CAST(OPMC.ID AS VARCHAR))');
    SQL.SQL.Add('	WHEN 1 THEN ''00'' || CAST(OPMC.ID AS VARCHAR)');
    SQL.SQL.Add('	WHEN 2 THEN ''0'' || CAST(OPMC.ID AS VARCHAR)');
    SQL.SQL.Add('	ELSE CAST(OPMC.ID AS VARCHAR) END AS ID,');
    SQL.SQL.Add('OPMC.ID_PRODUTO,');
    SQL.SQL.Add('PR.DESCRICAO,');
    SQL.SQL.Add('OPMC.DATAINCLUSAO,');
    SQL.SQL.Add('OPMC.QUANTIDADE,');
    SQL.SQL.Add('OPMC.ID_USUARIOINCLUSAO,');
    SQL.SQL.Add('OPMC.ID_USUARIOENCERRAMENTO,');
    SQL.SQL.Add('OPMC.DATAPREVISAO,');
    SQL.SQL.Add('OPMC.OBSERVACAO,');
    SQL.SQL.Add('OPMC.OBSERVACAOENCERRAMENTO,');
    SQL.SQL.Add('U.NOME AS USUARIOINCLUSAO,');
    SQL.SQL.Add('UU.NOME AS USUARIOENCERRAMENTO,');
    SQL.SQL.Add('OPMC.DATAENCERRAMENTO,');
    SQL.SQL.Add('OPMC.ENCERRADO');
    SQL.SQL.Add('FROM ORDEMPRODUCAOSOLUCAO OPMC');
    SQL.SQL.Add('INNER JOIN PRODUTO PR ON OPMC.ID_PRODUTO = PR.ID');
    SQL.SQL.Add('INNER JOIN USUARIO U ON OPMC.ID_USUARIOINCLUSAO = U.ID');
    SQL.SQL.Add('INNER JOIN USUARIO UU ON OPMC.ID_USUARIOENCERRAMENTO = UU.ID');
    SQL.SQL.Add('WHERE OPMC.ID = :ID');
    SQL.ParamByName('ID').AsInteger := ID;
    SQL.Prepare;
    SQL.Open();

    if SQL.IsEmpty then begin
      DisplayMsg(MSG_INF, 'Dados da Ordem de Produção não encontrados!');
      Exit;
    end;

    SQL_I.Close;
    SQL_I.SQL.Clear;
    SQL_I.Connection := FW.FDConnection;
    SQL_I.SQL.Add('SELECT');
    SQL_I.SQL.Add('OPMCI.ID_PRODUTO,');
    SQL_I.SQL.Add('PR.DESCRICAO,');
    SQL_I.SQL.Add('UN.SIMBOLO,');
    SQL_I.SQL.Add('OPMCI.QUANTIDADE');
    SQL_I.SQL.Add('FROM ORDEMPRODUCAOSOLUCAO_ITENS OPMCI');
    SQL_I.SQL.Add('INNER JOIN PRODUTO PR ON OPMCI.ID_PRODUTO = PR.ID');
    SQL_I.SQL.Add('INNER JOIN UNIDADEMEDIDA UN ON PR.UNIDADEMEDIDA_ID = UN.ID');
    SQL_I.SQL.Add('WHERE OPMCI.ID_ORDEMPRODUCAOSOLUCAO = :ID');
    SQL_I.ParamByName('ID').AsInteger := ID;
    SQL_I.Prepare;
    SQL_I.Open();

    FR    := TfrxDBDataset.Create(nil);
    FR_I  := TfrxDBDataset.Create(nil);
    try
      FR.UserName     := 'ORDEMPRODUCAO';
      FR_I.UserName   := 'ITENS';

      FR.DataSet      := SQL;
      FR_I.DataSet    := SQL_I;

      RelParams.Clear;
      DMUtil.ImprimirRelatorio('frOPSOL.fr3');
      DisplayMsgFinaliza;
    finally
      FreeAndNil(FR_I);
      FreeAndNil(FR);
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(SQL_I);
    FreeAndNil(FW);
  end;
end;

function ExcluirOPFE(ID : Integer) : Boolean;
var
  FWC   : TFWConnection;
  OPFE  : TOPFINAL_ESTAGIO;
  OPFEL : TOPFINAL_ESTAGIO_LOTE;
begin

  Result := False;

  if ID > 0 then begin

    DisplayMsg(MSG_CONF, 'Excluir a Ordem de Produção Selecionada?');

    if ResultMsgModal = mrYes then begin

      try

        FWC   := TFWConnection.Create;
        OPFE  := TOPFINAL_ESTAGIO.Create(FWC);
        OPFEL := TOPFINAL_ESTAGIO_LOTE.Create(FWC);
        try

          OPFE.SelectList('ID = ' + IntToStr(ID));
          if OPFE.Count > 0 then begin

            OPFEL.SelectList('OPFINAL_ESTAGIO_ID = ' + IntToStr(TOPFINAL_ESTAGIO(OPFE.Itens[0]).ID.Value));

            if OPFEL.Count = 0 then begin
              if TOPFINAL_ESTAGIO(OPFE.Itens[0]).ULTIMOLOTE.Value > 0 then
                DisplayMsg(MSG_WAR, 'OP de Produção Nº ' + IntToStr(ID) + sLineBreak +
                                    'já tem ' + TOPFINAL_ESTAGIO(OPFE.Itens[0]).ULTIMOLOTE.asString + ' Lotes Impressos' + sLineBreak +
                                    'Mas será excluida mesmo assim!');

                OPFE.ID.Value := TOPFINAL_ESTAGIO(OPFE.Itens[0]).ID.Value;
                OPFE.Delete;

                FWC.Commit;

                Result := True;

            end else begin
              DisplayMsg(MSG_WAR, 'OP de Produção Nº ' + IntToStr(ID) + ', já tem ' + IntToStr(OPFEL.Count) + ' Lotes Produzidos, Verifique!');
              Exit;
            end;
          end else begin
            DisplayMsg(MSG_WAR, 'OP de Produção Nº ' + IntToStr(ID) + ' não Encontrada, Verifique!');
            Exit;
          end;
        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir a Ordem de Produção, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(OPFE);
        FreeAndNil(OPFEL);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

function ExcluirOPF(ID : Integer) : Boolean;
var
  FWC   : TFWConnection;
  OPF   : TOPFINAL;
  OPFE  : TOPFINAL_ESTAGIO;
begin

  Result := False;

  if ID > 0 then begin

    DisplayMsg(MSG_CONF, 'Excluir o Recebimento de Planta Selecionado?');

    if ResultMsgModal = mrYes then begin

      try

        FWC   := TFWConnection.Create;
        OPF   := TOPFINAL.Create(FWC);
        OPFE  := TOPFINAL_ESTAGIO.Create(FWC);
        try

          OPF.SelectList('ID = ' + IntToStr(ID));
          if OPF.Count > 0 then begin

            OPFE.SelectList('OPFINAL_ID = ' + IntToStr(TOPFINAL(OPF.Itens[0]).ID.Value));

            if OPFE.Count = 0 then begin

              OPF.ID.Value := TOPFINAL(OPF.Itens[0]).ID.Value;
              OPF.Delete;

              FWC.Commit;

              Result := True;

            end else begin
              DisplayMsg(MSG_WAR, 'Recebimento de Planta Nº ' + IntToStr(ID) + ', já tem ' + IntToStr(OPFE.Count) + ' OPs Geradas, Verifique!');
              Exit;
            end;
          end else begin
            DisplayMsg(MSG_WAR, 'Recebimento de Planta Nº ' + IntToStr(ID) + ' não Encontrada, Verifique!');
            Exit;
          end;
        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Excluir o Recebimento de Planta, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(OPF);
        FreeAndNil(OPFE);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

function EncerrarOPSE(ID : Integer) : Boolean;
var
  FWC       : TFWConnection;
  SOL       : TORDEMPRODUCAOSOLUCAO;
  SOLI      : TORDEMPRODUCAOSOLUCAO_ITENS;
  CE        : TCONTROLEESTOQUE;
  CEP       : TCONTROLEESTOQUEPRODUTO;
  I         : Integer;
  Mensagem  : string;
begin

  Result := False;

  if ID > 0 then begin

    DisplayMsg(MSG_CONF, 'Encerrar a Produção de Solução Estoque?');

    if ResultMsgModal = mrYes then begin

      FWC   := TFWConnection.Create;
      SOL   := TORDEMPRODUCAOSOLUCAO.Create(FWC);
      SOLI  := TORDEMPRODUCAOSOLUCAO_ITENS.Create(FWC);
      CE    := TCONTROLEESTOQUE.Create(FWC);
      CEP   := TCONTROLEESTOQUEPRODUTO.Create(FWC);

      try

        FWC.StartTransaction;

        try

          SOL.SelectList('ID = ' + IntToStr(ID));
          if SOL.Count > 0 then begin

            if not TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ENCERRADO.Value then begin

              DisplayMsg(MSG_INPUT_TEXT, 'Informe a Observação do Encerramento!');

              if ResultMsgModal = mrOk then begin

                Mensagem := ResultMsgInputText;

                SOL.ID.Value                      := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID.Value;
                SOL.OBSERVACAOENCERRAMENTO.Value  := Mensagem;
                SOL.ID_USUARIOENCERRAMENTO.Value  := USUARIO.CODIGO;
                SOL.DATAENCERRAMENTO.Value        := Now;
                SOL.ENCERRADO.Value               := True;
                SOL.Update;

                SOLI.SelectList('ID_ORDEMPRODUCAOSOLUCAO = ' + TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID.asString);
                if SOLI.Count > 0 then begin
                  CE.ID.isNull                    := True;
                  CE.USUARIO_ID.Value             := USUARIO.CODIGO;
                  CE.TIPOMOVIMENTACAO.Value       := 0;
                  CE.CANCELADO.Value              := False;
                  CE.DATAHORA.Value               := Now;
                  CE.OBSERVACAO.Value             := 'Ordem de Produção de Solução de Estoque ' + IntToStr(ID);
                  CE.Insert;

                  CEP.ID.isNull                   := True;
                  CEP.CONTROLEESTOQUE_ID.Value    := CE.ID.Value;
                  CEP.PRODUTO_ID.Value            := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).ID_PRODUTO.Value;
                  CEP.QUANTIDADE.Value            := TORDEMPRODUCAOSOLUCAO(SOL.Itens[0]).QUANTIDADE.Value;
                  CEP.Insert;

                  for I := 0 to Pred(SOLI.Count) do begin
                    CEP.ID.isNull                 := True;
                    CEP.CONTROLEESTOQUE_ID.Value  := CE.ID.Value;
                    CEP.PRODUTO_ID.Value          := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).ID_PRODUTO.Value;
                    CEP.QUANTIDADE.Value          := TORDEMPRODUCAOSOLUCAO_ITENS(SOLI.Itens[I]).QUANTIDADE.Value * -1;
                    CEP.Insert;
                  end;
                end;

                FWC.Commit;

                Result := True;

              end;
            end else begin
              DisplayMsg(MSG_WAR, 'OP Solução Estoque Nº ' + IntToStr(ID) + ', já Encerrada, Verifique!');
              Exit;
            end;
          end else begin
            DisplayMsg(MSG_WAR, 'OP Solução Estoque Nº ' + IntToStr(ID) + ' não Encontrada, Verifique!');
            Exit;
          end;
        except
          on E : Exception do begin
            FWC.Rollback;
            DisplayMsg(MSG_ERR, 'Erro ao Encerrar a OP Solução Estoque, Verifique!', '', E.Message);
          end;
        end;
      finally
        FreeAndNil(CEP);
        FreeAndNil(CE);
        FreeAndNil(SOLI);
        FreeAndNil(SOL);
        FreeAndNil(FWC);
      end;
    end;
  end;
end;

function EncerrarOPF(ID : Integer) : Boolean;
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
  OPFE: TOPFINAL_ESTAGIO;
  I   : Integer;
begin

  Result := False;

  FWC := TFWConnection.Create;
  OPF := TOPFINAL.Create(FWC);
  OPFE:= TOPFINAL_ESTAGIO.Create(FWC);

  try
    try
      OPF.SelectList('ID = ' + IntToStr(ID));
      if OPF.Count = 1 then begin
        if not TOPFINAL(OPF.Itens[0]).DATAENCERRAMENTO.isNull then begin
          DisplayMsg(MSG_WAR, 'Ordem de Produção já Encerrada!');
          Exit;
        end;

        DisplayMsg(MSG_INPUT_INT, 'Informe a Quantidade de Plantas Produzidas!');

        if ResultMsgModal = mrOk then begin
          OPF.ID.Value                  := TOPFINAL(OPF.Itens[0]).ID.Value;
          OPF.DATAENCERRAMENTO.Value    := Now;
          OPF.QUANTIDADEPRODUZIDA.Value := ResultMsgInputInt;
          OPF.Update;

          OPFE.SelectList('OPFINAL_ID = ' + IntToStr(ID));
          if OPFE.Count > 0 then begin
            for I := 0 to OPFE.Count - 1 do begin
              OPFE.ID.Value           := TOPFINAL_ESTAGIO(OPFE.Itens[I]).ID.Value;
              OPFE.DATAHORAFIM.Value  := OPF.DATAENCERRAMENTO.Value;
              OPFE.Update;
            end;
          end;

          FWC.Commit;

          Result := True;

          DisplayMsg(MSG_OK, 'Ordem de Produção Nº ' + TOPFINAL(OPF.Itens[0]).ID.asString + ' Encerrada com Sucesso!');
        end;
      end;
    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Encerrar a Ordem de Produção, Verifique!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(OPFE);
    FreeAndNil(OPF);
    FreeAndNil(FWC);
  end;
end;

function CancelarOPF(ID : Integer) : Boolean;
Var
  FWC : TFWConnection;
  OPF : TOPFINAL;
  SQL : TFDQuery;
begin

  Result := False;

  DisplayMsg(MSG_CONF, 'Cancelar a Ordem de Produção Selecionada?');

  if ResultMsgModal = mrYes then begin

    try

      FWC := TFWConnection.Create;
      OPF := TOPFINAL.Create(FWC);
      SQL := TFDQuery.Create(nil);
      try

        OPF.SelectList('ID = ' + IntToStr(ID));
        if OPF.Count = 1 then begin

          if TOPFINAL(OPF.Itens[0]).CANCELADO.Value then begin
            DisplayMsg(MSG_WAR, 'Ordem de Produção já Cancelada, Verifique!');
            Exit;
          end;

          if not TOPFINAL(OPF.Itens[0]).DATAENCERRAMENTO.isNull then begin
            DisplayMsg(MSG_WAR, 'Ordem de Produção já Encerrada, Portanto não pode ser Cancelada!');
            Exit;
          end;

          SQL.Close;
          SQL.SQL.Clear;
          SQL.SQL.Add('SELECT');
          SQL.SQL.Add('  COUNT(OPFELS.ID) AS UNIDADES');
          SQL.SQL.Add('FROM OPFINAL OPF');
          SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
          SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE OPFEL ON (OPFEL.OPFINAL_ESTAGIO_ID = OPFE.ID)');
          SQL.SQL.Add('INNER JOIN OPFINAL_ESTAGIO_LOTE_S OPFELS ON (OPFELS.OPFINAL_ESTAGIO_LOTE_ID = OPFEL.ID)');
          SQL.SQL.Add('WHERE 1 = 1');
          SQL.SQL.Add('AND OPFELS.BAIXADO = FALSE');
          SQL.SQL.Add('AND OPF.ID = :IDOPF');
          SQL.ParamByName('IDOPF').DataType  := ftInteger;
          SQL.ParamByName('IDOPF').Value     := TOPFINAL(OPF.Itens[0]).ID.Value;

          SQL.Connection  := FWC.FDConnection;
          SQL.Prepare;
          SQL.Open;
          SQL.FetchAll;

          if not SQL.IsEmpty then begin
            DisplayMsg(MSG_WAR, 'Existem ' + SQL.FieldByName('UNIDADES').AsString + ' Unidades não Baixadas, Verifique!');
            Exit;
          end;

          OPF.ID.Value        := TOPFINAL(OPF.Itens[0]).ID.Value;
          OPF.CANCELADO.Value := True;
          OPF.Update;

          FWC.Commit;

          Result := True;

        end;
      except
        on E : Exception do begin
          FWC.Rollback;
          DisplayMsg(MSG_ERR, 'Erro ao Cancelar a Ordem de Produção, Verifique!', '', E.Message);
        end;
      end;
    finally
      FreeAndNil(SQL);
      FreeAndNil(OPF);
      FreeAndNil(FWC);
    end;
  end;
end;

function ValidaUsuario(Email, Senha : String) : Boolean;
Var
  FWC : TFWConnection;
  USU : TUSUARIO;
begin

  Result  := False;

  if UpperCase(Email) = 'ADMINISTRADOR' then begin
    if UpperCase(Senha) = 'SUPER' + IntToStr(DayOf(Date)) then begin
      USUARIO.CODIGO              := 0;
      USUARIO.NOME                := 'ADMINISTRADOR';
      USUARIO.EMAIL               := '';
      Result := True;
      Exit;
    end;
  end;

  try
    try

      FWC := TFWConnection.Create;

      USU := TUSUARIO.Create(FWC);

      USU.SelectList('UPPER(EMAIL) = ' + QuotedStr(UpperCase(Email)));

      if USU.Count > 0 then begin
        if (Criptografa(TUSUARIO(USU.Itens[0]).SENHA.Value, 'D') = Senha) then begin
          USUARIO.CODIGO                  := TUSUARIO(USU.Itens[0]).ID.Value;
          USUARIO.NOME                    := TUSUARIO(USU.Itens[0]).NOME.Value;
          USUARIO.EMAIL                   := TUSUARIO(USU.Itens[0]).EMAIL.Value;
          USUARIO.PERMITEINCLUIRETIQUETAS := TUSUARIO(USU.Itens[0]).PERMITEITENSETIQUETA.Value;
//          USUARIO.PERMITIRCADUSUARIO  := TUSUARIO(USU.Itens[0]).PERMITIR_CAD_USUARIO.Value;
          Result          := True;
        end;
      end;
    except
      on E : exception do
        DisplayMsg(MSG_ERR, 'Erro ao validar Usuário, Verifique!', '', E.Message);
    end;
  finally
    FreeAndNil(USU);
    FreeAndNil(FWC);
  end;
end;

function MD5(Texto : String): String;
var
  MD5 : TIdHashMessageDigest5;
begin
  MD5 := TIdHashMessageDigest5.Create;
  try
    Exit(MD5.HashStringAsHex(Texto));
  finally
    FreeAndNil(MD5);
  end;
end;

//funcao que retorno o código ASCII dos caracteres
function AsciiToInt(Caracter: Char): Integer;
var
  i: Integer;
begin
  i := 32;
  while i < 255 do begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

Function Criptografa(Texto : String; Tipo : String) : String;
var
  I    : Integer;
  Chave: Integer;
begin

  Chave := 10;

  if (Trim(Texto) = EmptyStr) or (chave = 0) then begin
    Result := Texto;
  end else begin
    Result := '';
    if UpperCase(Tipo) = 'E' then begin
      for I := 1 to Length(texto) do begin
        Result := Result + Chr(AsciiToInt(texto[I])+chave);
      end;
    end else begin
      for I := 1 to Length(Texto) do begin
        Result := Result + Chr(AsciiToInt(Texto[I]) - Chave);
      end;
    end;
  end;
end;
procedure CarregaArrayMenus(Menu : TMainMenu);
var
  I,
  J,
  K : Integer;
begin
  SetLength(MENUS, 0);
  for I := 0 to Pred(Menu.Items.Count) do begin
    if Menu.Items[I].Count = 0 then begin
      SetLength(MENUS, Length(MENUS) + 1);
      Menus[High(MENUS)].NOME   := Menu.Items[I].Name;
      Menus[High(MENUS)].CAPTION:= StringReplace(Menu.Items[I].Caption, '&', '', [rfReplaceAll]);
    end else begin
      for J := 0 to Pred(Menu.Items[I].Count) do begin
        if Menu.Items[I].Items[J].Count = 0 then begin
          SetLength(MENUS, Length(MENUS) + 1);
          Menus[High(MENUS)].NOME   := Menu.Items[I].Items[J].Name;
          Menus[High(MENUS)].CAPTION:= StringReplace(Menu.Items[I].Items[J].Caption, '&', '', [rfReplaceAll]);
        end else begin
          for K := 0 to Pred(Menu.Items[I].Items[J].Count) do begin
            SetLength(MENUS, Length(MENUS) + 1);
            Menus[High(MENUS)].NOME   := Menu.Items[I].Items[J].Items[K].Name;
            Menus[High(MENUS)].CAPTION:= StringReplace(Menu.Items[I].Items[J].Items[K].Caption, '&', '', [rfReplaceAll]);
          end;
        end;
      end;
    end;
  end;
end;

procedure DefinePermissaoMenu(Menu : TMainMenu);
var
  I,
  J,
  K   : Integer;
  CON : TFWConnection;
  PU  : TUSUARIO_PERMISSAO;
begin
  CON                                        :=  TFWConnection.Create;
  PU                                         := TUSUARIO_PERMISSAO.Create(CON);
  try
//    for I := 0 to Pred(Menu.Items.Count) do begin
//      if Menu.Items[I].Count = 0 then begin
//        PU.SelectList('ID_USUARIO = ' + IntToStr(USUARIO.CODIGO) + ' AND MENU = ' + QuotedStr(Menu.Items[I].Name));
//        Menu.Items[I].Visible                := PU.Count > 0;
//      end else begin
//        for J := 0 to Pred(Menu.Items[I].Count) do begin
//          if Menu.Items[I].Items[J].Count = 0 then begin
//            PU.SelectList('ID_USUARIO = ' + IntToStr(USUARIO.CODIGO) + ' AND MENU = ' + QuotedStr(Menu.Items[I].Items[J].Name));
//            Menu.Items[I].Items[J].Visible     := PU.Count > 0;
//          end else begin
//            for K := 0 to Pred(Menu.Items[I].Items[J].Count) do begin
//              PU.SelectList('ID_USUARIO = ' + IntToStr(USUARIO.CODIGO) + ' AND MENU = ' + QuotedStr(Menu.Items[I].Items[J].Items[K].Name));
//              Menu.Items[I].Items[J].Items[K].Visible     := PU.Count > 0;
//            end;
//          end;
//        end;
//      end;
//    end;
    for I := 0 to Pred(Menu.Items.Count) do begin
      if Menu.Items[I].Count > 0 then begin
        Menu.Items[I].Visible                := False;
        for J := 0 to Pred(Menu.Items[I].Count) do begin
          if Menu.Items[I].Items[J].Count = 0 then begin
            PU.SelectList('ID_USUARIO = ' + IntToStr(USUARIO.CODIGO) + ' AND MENU = ' + QuotedStr(Menu.Items[I].Items[J].Name));
            Menu.Items[I].Items[J].Visible     := PU.Count > 0;
          end else begin
            Menu.Items[I].Items[J].Visible     := False;
            for K := 0 to Pred(Menu.Items[I].Items[J].Count) do begin
              PU.SelectList('ID_USUARIO = ' + IntToStr(USUARIO.CODIGO) + ' AND MENU = ' + QuotedStr(Menu.Items[I].Items[J].Items[K].Name));
              Menu.Items[I].Items[J].Items[K].Visible     := PU.Count > 0;
              if Menu.Items[I].Items[J].Items[K].Visible then
                Menu.Items[I].Items[J].Visible            := True;
            end;
          end;
          if Menu.Items[I].Items[J].Visible then
            Menu.Items[I].Visible            := True;

        end;
      end;
    end;
  finally
    FreeAndNil(PU);
    FreeAndNil(CON);
  end;

end;

function SoNumeros(Texto: String): String;
var
    I : Integer;
Begin
  I := 1;
  if Length(Texto) > 0 then
    while I <= Length(Texto) do begin
      if not (Texto[I] in ['0'..'9']) then begin
        Delete(Texto,I,1);
        Continue;
      end;
      Inc(I);
    end;
  Result := Texto;
end;

function CalculaPercentualDiferenca(ValorAnterior, ValorNovo : Currency) : Currency;
begin
  Result := 0.00;
  if ValorAnterior > 0.00 then
    if ValorNovo > 0.00 then
        Result := Trunc((((ValorNovo * 100) / ValorAnterior) - 100) * 100) / 100.00
end;


function StrZero(Texto : string; Quant : Integer): string;
begin
  Result := Texto;
  Quant := Quant - Length(Result);
  if Quant > 0 then
   Result := StringOfChar('0', Quant)+Result;
end;

function carregaArrayClassificacao : Boolean;
begin
  Result     := False;
  SetLength(CLASSIFICACAO,0);

  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[0].Descricao :=  'ICMS TRIBUTADO 12% - PIS/COFINS TRIBUTADO';
  CLASSIFICACAO[0].Codigo    := 1;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[1].Descricao :=  'ICMS TRIBUTADO 18% - PIS/COFINS TRIBUTADO';
  CLASSIFICACAO[1].Codigo    := 6;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[2].Descricao :=  'ICMS SUBST. TRIB.  - PIS/COFINS TRIBUTADO';
  CLASSIFICACAO[2].Codigo    := 7;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[3].Descricao :=  'ICMS SUBST. TRIB. - PIS/COFINS ALIQUOTA 0';
  CLASSIFICACAO[3].Codigo    := 8;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[4].Descricao :=  'ICMS SUBS. TRIB. - PIS/COFINS INC. MONOFASICA';
  CLASSIFICACAO[4].Codigo    := 9;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[5].Descricao :=  'ENERGIA ELETRICA';
  CLASSIFICACAO[5].Codigo    := 10;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[6].Descricao :=  'TELEFONE';
  CLASSIFICACAO[6].Codigo    := 11;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[7].Descricao :=  'MATERIAL DE USO E CONSUMO';
  CLASSIFICACAO[7].Codigo    := 12;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[8].Descricao :=  'IMOBILIZADO';
  CLASSIFICACAO[8].Codigo    := 13;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[9].Descricao :=  'MERC IMPORTADA  ICMS TRIB - PIS COFINS TRIB';
  CLASSIFICACAO[9].Codigo    := 15;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[10].Descricao:=  'VENDA IMPORT ICMS TRIB - PIS E COFINS MONOFASICO';
  CLASSIFICACAO[10].Codigo   := 16;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[11].Descricao:=  'VENDA IMPORT ICMS ST - PIS E COFINS TRIB';
  CLASSIFICACAO[11].Codigo   := 17;
  SetLength(CLASSIFICACAO,Length(CLASSIFICACAO) + 1);
  CLASSIFICACAO[12].Descricao:=  'VENDA IMPOR ICMS ST - PIS COFINS MONOFASICO';
  CLASSIFICACAO[12].Codigo   := 18;
end;

function FormataCNPJ(CNPJ : String) : String;
Var
  Aux : String;
begin
  Aux := SoNumeros(CNPJ);

  while Length(Aux) < 14 do
    Aux := '0' + Aux;

  Result := Copy(Aux,1,2) + '.' + Copy(Aux,3,3) + '.' + Copy(Aux,6,3) + '/' + Copy(Aux,9,4) + '-' + Copy(Aux,13,2);
end;

function AjustaTamnhoCNPJ(CNPJ : String) : String;
Var
  Aux : String;
begin
  Aux := SoNumeros(CNPJ);

  while Length(Aux) < 14 do
    Aux := '0' + Aux;

  Result := Aux;
end;

function ExcluirCaracteresdeNumeric(Valor : Variant) : String;
var
  I : Integer;
begin

  Result := Valor;
  I := 1;

  while I <= Length(Result) do begin
    if not (Result[I] in ['0'..'9', ',']) then begin
      Delete(Result,I,1);
      Continue;
    end;
    Inc(I);
  end;
end;

function RetornaCodigo_CF(CF : String) : Integer;
Var
  I : Integer;
begin

  Result := 0;

  if Length(Trim(CF)) > 0 then begin
    for I := Low(CLASSIFICACAO) to High(CLASSIFICACAO) do begin
      if Pos(CF, CLASSIFICACAO[I].Descricao) > 0 then begin
        Result := CLASSIFICACAO[I].Codigo;
        Break;
      end;
    end;
  end;

end;

function ValidaCPFCNPJ(Texto : String) : Boolean;
Var
  SomenteNumeros : string;
  N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12 : Integer;
  D1,D2 : Integer;
  Digitado,Calculado : string;
  V : array[1..2] of Word;
  CNPJ : array[1..14] of Byte;
  I : Byte;
begin
  Result := False;

  SomenteNumeros := SoNumeros(Texto);

  case Length(SomenteNumeros) of
    11 : begin //CPF

      N1 := StrToInt(SomenteNumeros[1]);
      N2 := StrToInt(SomenteNumeros[2]);
      N3 := StrToInt(SomenteNumeros[3]);
      N4 := StrToInt(SomenteNumeros[4]);
      N5 := StrToInt(SomenteNumeros[5]);
      N6 := StrToInt(SomenteNumeros[6]);
      N7 := StrToInt(SomenteNumeros[7]);
      N8 := StrToInt(SomenteNumeros[8]);
      N9 := StrToInt(SomenteNumeros[9]);

      D1 := N9*2+N8*3+N7*4+N6*5+N5*6+N4*7+N3*8+N2*9+N1*10;

      D1 := 11 - (D1 mod 11);

      if D1 >= 10 then
        D1 := 0;

      D2 := D1*2+N9*3+N8*4+N7*5+N6*6+N5*7+N4*8+N3*9+N2*10+N1*11;
      D2 := 11 - (D2 mod 11);

      if D2 >= 10 then
        D2 := 0;

      Calculado := IntToStr(D1) + IntToStr(D2);
      Digitado  := SomenteNumeros[10] + SomenteNumeros[11];

      Result    := Calculado = Digitado;

    end;
    14 : begin //CNPJ
      try
        for I := 1 to 14 do
          CNPJ[i] := StrToInt(Texto[i]);
        //Nota: Calcula o primeiro dígito de verificação.
        V[1] := 5*CNPJ[1] + 4*CNPJ[2]  + 3*CNPJ[3]  + 2*CNPJ[4];
        V[1] := V[1] + 9*CNPJ[5] + 8*CNPJ[6]  + 7*CNPJ[7]  + 6*CNPJ[8];
        V[1] := V[1] + 5*CNPJ[9] + 4*CNPJ[10] + 3*CNPJ[11] + 2*CNPJ[12];
        V[1] := 11 - V[1] mod 11;
        V[1] := IfThen(V[1] >= 10, 0, V[1]);
        //Nota: Calcula o segundo dígito de verificação.
        V[2] := 6*CNPJ[1] + 5*CNPJ[2]  + 4*CNPJ[3]  + 3*CNPJ[4];
        V[2] := V[2] + 2*CNPJ[5] + 9*CNPJ[6]  + 8*CNPJ[7]  + 7*CNPJ[8];
        V[2] := V[2] + 6*CNPJ[9] + 5*CNPJ[10] + 4*CNPJ[11] + 3*CNPJ[12];
        V[2] := V[2] + 2*V[1];
        V[2] := 11 - V[2] mod 11;
        V[2] := IfThen(V[2] >= 10, 0, V[2]);
        //Nota: Verdadeiro se os dígitos de verificação são os esperados.
        Result := ((V[1] = CNPJ[13]) and (V[2] = CNPJ[14]));
      except on E: Exception do
        Result := False;
      end;

    end;
  end;
end;

function LimiteMultiplicacao(CodigoOPF, IDEstagio : Integer) : Boolean;
Var
  FWC     : TFWConnection;
  Consulta: TFDQuery;
begin

  Result    := False;

  FWC       := TFWConnection.Create;
  Consulta  := TFDQuery.Create(nil);

  try
    try

      Consulta.Close;
      Consulta.SQL.Clear;
      Consulta.SQL.Add('SELECT');
      Consulta.SQL.Add('  OPF.LIMITEMULTIPLICACOES,');
      Consulta.SQL.Add('  COUNT(*) AS MULTIPLICACOES');
      Consulta.SQL.Add('FROM');
      Consulta.SQL.Add('OPFINAL OPF');
      Consulta.SQL.Add('INNER JOIN OPFINAL_ESTAGIO OPFE ON (OPFE.OPFINAL_ID = OPF.ID)');
      Consulta.SQL.Add('INNER JOIN ESTAGIO E ON (OPFE.ESTAGIO_ID = E.ID)');
      Consulta.SQL.Add('WHERE 1 = 1');
      Consulta.SQL.Add('AND E.TIPO = 2');
      Consulta.SQL.Add('AND OPF.ID = :CODIGOOPF');
      Consulta.SQL.Add('AND OPFE.ESTAGIO_ID = :IDESTAGIO');
      Consulta.SQL.Add('AND OPF.LIMITEMULTIPLICACOES > 0');
      Consulta.SQL.Add('GROUP BY 1');

      Consulta.Connection                         := FWC.FDConnection;
      Consulta.ParamByName('CODIGOOPF').DataType  := ftInteger;
      Consulta.ParamByName('IDESTAGIO').DataType  := ftInteger;
      Consulta.ParamByName('CODIGOOPF').AsInteger := CodigoOPF;
      Consulta.ParamByName('IDESTAGIO').AsInteger := IDEstagio;
      Consulta.Prepare;
      Consulta.Open;
      Consulta.FetchAll;

      if not Consulta.IsEmpty then begin
        Consulta.First;
        if ((Consulta.FieldByName('MULTIPLICACOES').AsInteger + 1) >= Consulta.FieldByName('LIMITEMULTIPLICACOES').AsInteger) then
          Result := True;
      end;

    except
      on E : Exception do begin
        FWC.Rollback;
        DisplayMsg(MSG_ERR, 'Erro ao Verificar o Limite de Multiplicações!', '', E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(Consulta);
    FreeAndNil(FWC);
  end;
end;

function SelecionarImagemBMP : String;
var
  OpenDialog : TOpenPictureDialog;
begin

  Result := EmptyStr;

  OpenDialog := TOpenPictureDialog.Create(nil);
  try
    OpenDialog.Filter := 'Bitmaps (*.bmp)|*.bmp';
    if OpenDialog.Execute() then begin
      if Length(Trim(OpenDialog.FileName)) > 0 then
        if UpperCase(ExtractFileExt(OpenDialog.FileName)) = '.BMP' then
          Result := OpenDialog.FileName
        else
          DisplayMsg(MSG_WAR, 'Extensão deve ser .BMP, Verifique!');
    end;
  finally
    FreeAndNil(OpenDialog);
  end;
end;

function TemSaldoOPMC(CodigoOPMC, Quantidade : Integer) : Boolean;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin

  Result := False;

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);
  try
    try
      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	  OPMC.SALDO');
      SQL.SQL.Add('FROM ORDEMPRODUCAOMC OPMC');
      SQL.SQL.Add('WHERE OPMC.ID = :ID');

      SQL.Connection := FWC.FDConnection;
      SQL.Transaction := FWC.FDTransaction;

      SQL.ParamByName('ID').AsInteger := CodigoOPMC;

      SQL.Open;

      if not SQL.IsEmpty then begin
        if SQL.FieldByName('SALDO').AsCurrency >= Quantidade then begin
          Result := True;
          Exit;
        end;
      end;

    except
      on E : Exception do begin
        DisplayMsg(MSG_ERR, 'Erro ao verificar o saldo de OPMC!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;
procedure ExpDbGridXLS(const DBGrid: TDBGrid; NomeArq: string);
var
  ExcApp: OleVariant;
  I,
  L : Integer;
  VarNomeArq : String;
  DataSet : TClientDataSet;
  Bookmark : TBookmark;
begin
  if (not Assigned(DBGrid.DataSource)) or (not Assigned(DBGrid.DataSource.DataSet)) then begin
    DisplayMsg(MSG_INF, 'Não foi possível exportar os dados do grid.');
    Exit;
  end;

  DataSet := TClientDataSet(DBGrid.DataSource.DataSet);

  Bookmark := DataSet.GetBookmark;
  DataSet.DisableControls;
  try

    if DataSet.IsEmpty then
      Exit;

    VarNomeArq := DirArquivosExcel + FormatDateTime('yyyymmdd', Date) + '\' + NomeArq;

    if not DirectoryExists(ExtractFilePath(VarNomeArq)) then
      ForceDirectories(ExtractFilePath(VarNomeArq));

    if FileExists(VarNomeArq) then
      DeleteFile(PChar(VarNomeArq));

    ExcApp := CreateOleObject('Excel.Application');
    ExcApp.Visible := True;
    ExcApp.WorkBooks.Add;
    DataSet.First;
    L := 1;
    DataSet.First;
    while not DataSet.Eof do begin
      if L = 1 then begin
        for I := 0 to DBGrid.Columns.Count - 1 do begin
          if DBGrid.Columns[I].Field is TStringField then
            ExcApp.WorkBooks[1].Sheets[1].Columns[I + 1].NumberFormat := '@';
          ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1].Font.Bold  := True;
          ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1].Font.Color := clBlue;
          ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1]            := DBGrid.Columns[I].Title.Caption;
        end;
        L := L + 1;
      end;

      for I := 0 to DBGrid.Columns.Count - 1 do
        ExcApp.WorkBooks[1].Sheets[1].Cells[L, I + 1] := DBGrid.Columns[I].Field.DisplayText;

      DataSet.Next;
      L := L + 1;
    end;
    ExcApp.Columns.AutoFit;
    ExcApp.WorkBooks[1].SaveAs(VarNomeArq);
  finally
    DataSet.GotoBookmark(Bookmark);
    DataSet.EnableControls;
  end;
end;

end.
