unit uConstantes;

interface

uses
  Vcl.ExtCtrls;

type
  TTipoPrecificacao = (eNenhum, eMargem, ePrecoEspecial);
  TFinalidadeProduto = (eTodos, eProdutoFinal, eMateriaPrima, eMeioCultura, eRecipiente);

type
  TDADOSLOGIN = record
    Usuario : String;
    LembrarUsuario : Boolean;
  end;

  TDADOSCONEXAO = record
    LibVendor : string;
    Database : string;
    Server : string;
    User_Name : string;
    Password : string;
    CharacterSet : string;
    DriverID : string;
    Port : string;
  end;

  TDADOSUSUARIO = record
    CODIGO : Integer;
    NOME : string;
    EMAIL : string;
    PERMITEINCLUIRETIQUETAS : Boolean;
  end;

  TMENU = record
    NOME    : string;
    CAPTION : string;
  end;

  TCONFIGURACOESLOCAIS = record
    DirRelatorios : string;
    DirImagens : string;
  end;

  TCLASSIFICACAO = record
    Codigo : Integer;
    Descricao : String;
  end;

  TIMAGENS = record
    ID : Integer;
    NomeImagem : string;
    Imagem : TImage;
  end;

  TPRECOS = record
    ID_PRODUTO : integer;
    SKU : String;
    CUSTOFINAL_ANT : Currency;
    CUSTOFINAL_NOVO : Currency;
    PRECO_CADASTRO : Currency;
    PRECO_ESPECIAL : Currency;
    MARGEM_SUGERIDA : Currency;
    TIPO : TTipoPrecificacao;
    PRECO_SUGESTAO : Currency;
    PRECODE : Currency;
    PRECOPOR : Currency;
    MARGEM_PRATICAR : Currency;
    MEDIA : Currency;
    PERCENTUAL_VPC : Currency;
    PERCENTUAL_FRETE : Currency;
    PERCENTUAL_OUTROS : Currency;
  end;

Const
  Alfabeto: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  MinimoCodigoBarras: Integer = 3; //Definir a quantidade mínima de Caracteres para Código de Barras

Var
  LOGIN           : TDADOSLOGIN;
  CONEXAO         : TDADOSCONEXAO;
  USUARIO         : TDADOSUSUARIO;
  CONFIG_LOCAL    : TCONFIGURACOESLOCAIS;
  MENUS           : array of TMENU;
  CLASSIFICACAO   : array of TCLASSIFICACAO;
  IMAGENS         : array of TIMAGENS;
  DESIGNREL       : Boolean;
  DirArqConf      : String;
  DirInstall      : String;
  DirArquivosExcel: String;

implementation

end.
