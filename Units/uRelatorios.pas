unit uRelatorios;

interface

uses
  FireDAC.Comp.Client, Data.DB, System.SysUtils;

  procedure RelatorioListagemFornecedores;

implementation

uses
  uFWConnection,
  uDMUtil,
  uMensagem;

procedure RelatorioListagemFornecedores;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin

  DisplayMsg(MSG_WAIT, 'Buscando dados...');

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);

  try
    try

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	F.ID,');
      SQL.SQL.Add('	F.NOME AS NOMEFORNECEDOR,');
      SQL.SQL.Add('	F.CNPJ,');
      SQL.SQL.Add('	F.PRAZO_ENTREGA,');
      SQL.SQL.Add('	A.NOME AS NOMEALMOXARIFADO');
      SQL.SQL.Add('FROM FORNECEDOR F');
      SQL.SQL.Add('INNER JOIN ALMOXARIFADO A ON (F.ID_ALMOXARIFADO = A.ID)');
      SQL.SQL.Add('WHERE F.STATUS');
      SQL.SQL.Add('ORDER BY F.ID');
      SQL.Connection                    := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      DMUtil.frxDBDataset1.DataSet := SQL;
      RelParams.Clear;
      DMUtil.ImprimirRelatorio('frListagemSimplesFornecedor.fr3');
      DisplayMsgFinaliza;

    except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros ao buscar dados!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

procedure RelatorioListagemAlmoxarifados;
Var
  FWC : TFWConnection;
  SQL : TFDQuery;
begin

  DisplayMsg(MSG_WAIT, 'Buscando dados...');

  FWC := TFWConnection.Create;
  SQL := TFDQuery.Create(nil);

  try
    try

      SQL.Close;
      SQL.SQL.Clear;
      SQL.SQL.Add('SELECT');
      SQL.SQL.Add('	A.ID,');
      SQL.SQL.Add('	A.NOME AS NOMEALMOXARIFADO,');
      SQL.SQL.Add('	A.CODIGO_E10');
      SQL.SQL.Add('FROM ALMOXARIFADO A');
      SQL.SQL.Add('WHERE A.ID > 0');
      SQL.SQL.Add('ORDER BY A.ID');
      SQL.Connection                    := FWC.FDConnection;
      SQL.Prepare;
      SQL.Open;
      SQL.FetchAll;

      DMUtil.frxDBDataset1.DataSet := SQL;
      RelParams.Clear;
      DMUtil.ImprimirRelatorio('frListagemSimplesAlmoxarifado.fr3');
      DisplayMsgFinaliza;

    except
      on E : Exception do begin
        DisplayMsg(MSG_WAR, 'Ocorreram erros ao buscar dados!', '', E.Message);
      end;
    end;
  finally
    FreeAndNil(SQL);
    FreeAndNil(FWC);
  end;
end;

end.
