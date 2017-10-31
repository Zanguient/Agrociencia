unit uRelEstimativaVsRealidade;

interface
uses
  FireDAC.Comp.Client, uConstantes, frxClass, frxDBSet, System.DateUtils,
  uFWConnection, Data.DB, Datasnap.DBClient, System.SysUtils;
type
  TRelatorioEstimativaVsRealidade = class
  private
    FCDS_PREVISAO: TClientDataSet;
    FSQL_ESTIMATIVA: TFDQuery;
    FSQL_REALIZADO: TFDQuery;
    FSQL_CABECALHO: TFDQuery;
    FFWC: TFWConnection;
    FIDOPFINAL: Integer;
    procedure SetCDS_PREVISAO(const Value: TClientDataSet);
    procedure SetFWC(const Value: TFWConnection);
    procedure SetSQL_CABECALHO(const Value: TFDQuery);
    procedure SetSQL_ESTIMATIVA(const Value: TFDQuery);
    procedure SetSQL_REALIZADO(const Value: TFDQuery);
    procedure SetIDOPFINAL(const Value: Integer);
  protected
    procedure MontarSQLCabecalho;
    procedure MontarSQLEstimativa;
    procedure MontarSQLRealizado;
    procedure MontarDataSetPrevisao;
  public
    constructor Create(IdOpfinal: Integer);
    destructor Destroy; override;
    procedure ImprimirRelatorio;
  published
    property IDOPFINAL: Integer read FIDOPFINAL write SetIDOPFINAL;
    property FWC: TFWConnection read FFWC write SetFWC;
    property SQL_CABECALHO: TFDQuery read FSQL_CABECALHO write SetSQL_CABECALHO;
    property SQL_ESTIMATIVA: TFDQuery read FSQL_ESTIMATIVA write SetSQL_ESTIMATIVA;
    property SQL_REALIZADO: TFDQuery read FSQL_REALIZADO write SetSQL_REALIZADO;
    property CDS_PREVISAO: TClientDataSet read FCDS_PREVISAO write SetCDS_PREVISAO;
  end;

implementation
  uses uDMUtil;

{ TRelatorioEstimativaVsRealidade }

constructor TRelatorioEstimativaVsRealidade.Create(IdOpfinal: Integer);
begin
  FWC := TFWConnection.Create;
  SQL_CABECALHO := TFDQuery.Create(nil);
  SQL_ESTIMATIVA := TFDQuery.Create(nil);
  SQL_REALIZADO := TFDQuery.Create(nil);
  CDS_PREVISAO := TClientDataSet.Create(nil);
  FIDOPFINAL := IdOpfinal;
end;

destructor TRelatorioEstimativaVsRealidade.Destroy;
begin
  FreeAndNil(FSQL_CABECALHO);
  FreeAndNil(FSQL_ESTIMATIVA);
  FreeAndNil(FSQL_REALIZADO);
  FreeAndNil(FCDS_PREVISAO);
  FreeAndNil(FFWC);
  inherited;
end;

procedure TRelatorioEstimativaVsRealidade.ImprimirRelatorio;
var
  FR_CABECALHO: TfrxDBDataset;
  FR_ESTIMATIVA: TfrxDBDataset;
  FR_REALIZADO: TfrxDBDataset;
  FR_PREVISAO: TfrxDBDataset;
begin
  FR_CABECALHO := TfrxDBDataset.Create(nil);
  FR_ESTIMATIVA := TfrxDBDataset.Create(nil);
  FR_REALIZADO := TfrxDBDataset.Create(nil);
  FR_PREVISAO := TfrxDBDataset.Create(nil);
  try
    MontarSQLCabecalho;
    MontarSQLEstimativa;
    MontarSQLRealizado;
    MontarDataSetPrevisao;

    RelParams.Clear;

    FR_CABECALHO.DataSet := FSQL_CABECALHO;
    FR_CABECALHO.UserName := 'CABECALHO';

    FR_ESTIMATIVA.DataSet := FSQL_ESTIMATIVA;
    FR_ESTIMATIVA.UserName:= 'ESTIMATIVA';

    FR_REALIZADO.DataSet := FSQL_REALIZADO;
    FR_REALIZADO.UserName:= 'REALIZADO';

    FR_PREVISAO.DataSet := FCDS_PREVISAO;
    FR_PREVISAO.UserName := 'PREVISAO';

    DMUtil.ImprimirRelatorio('frEstimativaRealidade.fr3');
  finally
    FreeAndNil(FR_CABECALHO);
    FreeAndNil(FR_ESTIMATIVA);
    FreeAndNil(FR_REALIZADO);
    FreeAndNil(FR_PREVISAO);
  end;
end;

procedure TRelatorioEstimativaVsRealidade.MontarDataSetPrevisao;
var
  nSaida,
  I : Integer;
  dtSaida: TDate;
begin
  // Criando dataset para mostrar no relatório
  CDS_PREVISAO.Close;
  for I := 0 to SQL_REALIZADO.Fields.Count - 1 do
    CDS_PREVISAO.FieldDefs.Add(SQL_REALIZADO.Fields[I].FieldName, SQL_REALIZADO.Fields[I].DataType, SQL_REALIZADO.Fields[I].Size, SQL_REALIZADO.Fields[I].Required);

  CDS_PREVISAO.CreateDataSet;
  CDS_PREVISAO.Open;

  if SQL_ESTIMATIVA.RecordCount <= SQL_REALIZADO.RecordCount then
    Exit;

  //Parte da op que já foi realizada
  SQL_REALIZADO.First;
  while not SQL_REALIZADO.Eof do
  begin
    CDS_PREVISAO.Append;
    for I := 0 to SQL_REALIZADO.Fields.Count - 1 do
    begin
      if not SQL_REALIZADO.Fields[I].IsNull then
        CDS_PREVISAO.Fields[I].Value := SQL_REALIZADO.Fields[I].Value;
    end;
    CDS_PREVISAO.Post;

    SQL_REALIZADO.Next;
  end;

  CDS_PREVISAO.Last;
  if SQL_ESTIMATIVA.Locate(SQL_ESTIMATIVA.FieldByName('sequencia').FieldName, CDS_PREVISAO.FieldByName('sequencia').Value, []) then
  begin
    SQL_ESTIMATIVA.Next;
    while not SQL_ESTIMATIVA.Eof do
    begin
      nSaida := CDS_PREVISAO.FieldByName('saida').AsInteger;
      dtSaida := CDS_PREVISAO.FieldByName('previsaotermino').Value;

      CDS_PREVISAO.Append;
      for I := 0 to SQL_ESTIMATIVA.Fields.Count - 1 do
      begin
        if not SQL_ESTIMATIVA.Fields[I].IsNull and Assigned(CDS_PREVISAO.FindField(SQL_ESTIMATIVA.Fields[I].FieldName)) then
          CDS_PREVISAO.FieldByName(SQL_ESTIMATIVA.Fields[I].FieldName).Value := SQL_ESTIMATIVA.Fields[I].Value;
      end;

      CDS_PREVISAO.FieldByName('quantidade').Value := nSaida;
      CDS_PREVISAO.FieldByName('PERDA').Value := Trunc((CDS_PREVISAO.FieldByName('quantidade').AsInteger * CDS_PREVISAO.FieldByName('fatorx').AsInteger) * (SQL_ESTIMATIVA.FieldByName('percperda').AsFloat/100));
      CDS_PREVISAO.FieldByName('saida').AsInteger := Trunc(CDS_PREVISAO.FieldByName('quantidade').AsInteger * CDS_PREVISAO.FieldByName('fatorx').AsInteger) - CDS_PREVISAO.FieldByName('perda').AsInteger;
      CDS_PREVISAO.FieldByName('previsaoinicio').Value := dtSaida;
      CDS_PREVISAO.FieldByName('previsaotermino').AsDateTime := IncDay(CDS_PREVISAO.FieldByName('previsaoinicio').AsDateTime, CDS_PREVISAO.FieldByName('dias').AsInteger);
      CDS_PREVISAO.Post;

      SQL_ESTIMATIVA.Next;
    end;
  end;
end;

procedure TRelatorioEstimativaVsRealidade.MontarSQLCabecalho;
begin
  SQL_CABECALHO.Close;
  SQL_CABECALHO.SQL.Clear;
  SQL_CABECALHO.Connection := FWC.FDConnection;
  SQL_CABECALHO.SQL.Add('select');
  SQL_CABECALHO.SQL.Add('  op.id,');
  SQL_CABECALHO.SQL.Add('  cast(op.dataderecebimento as date) as datarecebimento,');
  SQL_CABECALHO.SQL.Add('  cl.nome as cliente,');
  SQL_CABECALHO.SQL.Add('  pr.descricao as especie,');
  SQL_CABECALHO.SQL.Add('  v.nome as variedade');
  SQL_CABECALHO.SQL.Add('from opfinal op');
  SQL_CABECALHO.SQL.Add('inner join cliente cl on op.cliente_id = cl.id');
  SQL_CABECALHO.SQL.Add('inner join produto pr on op.produto_id = pr.id');
  SQL_CABECALHO.SQL.Add('inner join variedade v on op.id_variedade = v.id');
  SQL_CABECALHO.SQL.Add('where op.id = :idopfinal');
  SQL_CABECALHO.ParamByName('idopfinal').AsInteger := IDOPFINAL;
  SQL_CABECALHO.Open();
end;

procedure TRelatorioEstimativaVsRealidade.MontarSQLEstimativa;
begin
  SQL_ESTIMATIVA.Close;
  SQL_ESTIMATIVA.SQL.Clear;
  SQL_ESTIMATIVA.Connection := FWC.FDConnection;
  SQL_ESTIMATIVA.SQL.Add('select');
  SQL_ESTIMATIVA.SQL.Add('op.id,');
  SQL_ESTIMATIVA.SQL.Add('ope.sequencia,');
  SQL_ESTIMATIVA.SQL.Add('e.descricao as estagio,');
  SQL_ESTIMATIVA.SQL.Add('e.tipo,');
  SQL_ESTIMATIVA.SQL.Add('ope.fatorx,');
  SQL_ESTIMATIVA.SQL.Add('ope.dias,');
  SQL_ESTIMATIVA.SQL.Add('ope.quantidade,');
  SQL_ESTIMATIVA.SQL.Add('(ope.quantidade * ope.fatorx) - ((ope.quantidade * ope.fatorx) * (ope.perda/100)) as saida,');
  SQL_ESTIMATIVA.SQL.Add('((ope.quantidade * ope.fatorx) * (ope.perda/100)) as perda,');
  SQL_ESTIMATIVA.SQL.Add('ope.perda as percperda,');
  SQL_ESTIMATIVA.SQL.Add('ope.dtinicio as previsaoinicio,');
  SQL_ESTIMATIVA.SQL.Add('ope.dtfim as previsaotermino');
  SQL_ESTIMATIVA.SQL.Add('from opfinal op');
  SQL_ESTIMATIVA.SQL.Add('inner join opfinal_estimativa ope on op.id = ope.id_opfinal');
  SQL_ESTIMATIVA.SQL.Add('inner join estagio e on ope.id_estagio = e.id');
  SQL_ESTIMATIVA.SQL.Add('where op.id = :idopfinal');
  SQL_ESTIMATIVA.SQL.Add('order by ope.sequencia');
  SQL_ESTIMATIVA.ParamByName('idopfinal').AsInteger := IDOPFINAL;
  SQL_ESTIMATIVA.Open();
end;

procedure TRelatorioEstimativaVsRealidade.MontarSQLRealizado;
begin
  SQL_REALIZADO.Close;
  SQL_REALIZADO.SQL.Clear;
  SQL_REALIZADO.Connection := FWC.FDConnection;
  SQL_REALIZADO.SQL.Add('select');
  SQL_REALIZADO.SQL.Add('id,');
  SQL_REALIZADO.SQL.Add('sequencia,');
  SQL_REALIZADO.SQL.Add('estagio,');
  SQL_REALIZADO.SQL.Add('tipo,');
  SQL_REALIZADO.SQL.Add('dias,');
  SQL_REALIZADO.SQL.Add('quantidade,');
  SQL_REALIZADO.SQL.Add('cast((case when saida > 0 then saida else 1 end / case when quantidade > 0 then cast(quantidade as numeric(18,2)) else 1 end) as numeric(18,2)) as fatorx,');
  SQL_REALIZADO.SQL.Add('saida - perda as saida,');
  SQL_REALIZADO.SQL.Add('perda,');
  SQL_REALIZADO.SQL.Add('previsaoinicio,');
  SQL_REALIZADO.SQL.Add('previsaotermino');
  SQL_REALIZADO.SQL.Add('from (');
  SQL_REALIZADO.SQL.Add('select');
  SQL_REALIZADO.SQL.Add('op.id,');
  SQL_REALIZADO.SQL.Add('ope.sequenciaestagio as sequencia,');
  SQL_REALIZADO.SQL.Add('e.descricao as estagio,');
  SQL_REALIZADO.SQL.Add('e.tipo,');
  SQL_REALIZADO.SQL.Add('ope.previsaotermino::date - ope.previsaoinicio::date as dias,');
  SQL_REALIZADO.SQL.Add('(select count(*) from opfinal_estagio_lote opel');
  SQL_REALIZADO.SQL.Add('  inner join opfinal_estagio_lote_e opele on opel.id = opele.opfinal_estagio_lote_id');
  SQL_REALIZADO.SQL.Add('  where opel.opfinal_estagio_id = ope.id) as quantidade,');
  SQL_REALIZADO.SQL.Add('(select count(*) from opfinal_estagio_lote opel');
  SQL_REALIZADO.SQL.Add('  inner join opfinal_estagio_lote_s opels on opel.id = opels.opfinal_estagio_lote_id');
  SQL_REALIZADO.SQL.Add('  where opel.opfinal_estagio_id = ope.id) as saida,');
  SQL_REALIZADO.SQL.Add('(select count(*) from opfinal_estagio_lote opel');
  SQL_REALIZADO.SQL.Add('  inner join opfinal_estagio_lote_s opels on opel.id = opels.opfinal_estagio_lote_id');
  SQL_REALIZADO.SQL.Add('  inner join opfinal_estagio_lote_s_qualidade opelsq on opels.id = opelsq.id_opfinal_estagio_lote_s');
  SQL_REALIZADO.SQL.Add('  where opel.opfinal_estagio_id = ope.id) as perda,');
  SQL_REALIZADO.SQL.Add('ope.previsaoinicio,');
  SQL_REALIZADO.SQL.Add('ope.previsaotermino');
  SQL_REALIZADO.SQL.Add('from opfinal op');
  SQL_REALIZADO.SQL.Add('inner join opfinal_estagio ope on op.id = ope.opfinal_id');
  SQL_REALIZADO.SQL.Add('inner join estagio e on ope.estagio_id = e.id');
  SQL_REALIZADO.SQL.Add('where op.id = :idopfinal');
  SQL_REALIZADO.SQL.Add(') as Tabela');
  SQL_REALIZADO.SQL.Add('order by sequencia');
  SQL_REALIZADO.ParamByName('idopfinal').AsInteger := IDOPFINAL;
  SQL_REALIZADO.Prepare;
  SQL_REALIZADO.Open();
end;

procedure TRelatorioEstimativaVsRealidade.SetCDS_PREVISAO(
  const Value: TClientDataSet);
begin
  FCDS_PREVISAO := Value;
end;

procedure TRelatorioEstimativaVsRealidade.SetFWC(const Value: TFWConnection);
begin
  FFWC := Value;
end;

procedure TRelatorioEstimativaVsRealidade.SetIDOPFINAL(const Value: Integer);
begin
  FIDOPFINAL := Value;
end;

procedure TRelatorioEstimativaVsRealidade.SetSQL_CABECALHO(
  const Value: TFDQuery);
begin
  FSQL_CABECALHO := Value;
end;

procedure TRelatorioEstimativaVsRealidade.SetSQL_ESTIMATIVA(
  const Value: TFDQuery);
begin
  FSQL_ESTIMATIVA := Value;
end;

procedure TRelatorioEstimativaVsRealidade.SetSQL_REALIZADO(
  const Value: TFDQuery);
begin
  FSQL_REALIZADO := Value;
end;

end.
