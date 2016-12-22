CREATE TABLE if not exists usuario
(
  id serial NOT NULL,
  nome character varying(100) NOT NULL,
  email character varying(100) NOT NULL,
  senha character varying(100),
  permiteprodutoalemcomposicao boolean,
  CONSTRAINT pk_usuario PRIMARY KEY (id)
);

CREATE TABLE if not exists usuario_permissao
(

  id serial NOT NULL,
  id_usuario bigint,
  menu character varying(100),
  CONSTRAINT pk_usuario_permissao PRIMARY KEY (id),
  CONSTRAINT fk_usuario_permissao_u FOREIGN KEY (id_usuario)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE if not exists unidademedida
(
  id serial NOT NULL,
  descricao character varying(100) NOT NULL,
  simbolo character varying(5) NOT NULL,
  codigoexterno character varying(100),
  CONSTRAINT pk_unidademedida PRIMARY KEY (id)
);

CREATE TABLE if not exists observacao
(
  id serial NOT NULL,
  descricao character varying(100) NOT NULL,
  observacao character varying(512) NOT NULL,
  codigoexterno character varying(100),
  CONSTRAINT pk_observacao PRIMARY KEY (id)
);

CREATE TABLE if not exists cliente
(
  id serial NOT NULL,
  nome character varying(100) NOT NULL,
  cpfcnpj character varying(18) NOT NULL,
  telefone character varying(15),
  celular character varying(15),
  email character varying(100),
  observacao character varying(512),
  codigoexterno character varying(100),
  cadproie character varying(30),
  CONSTRAINT pk_cliente PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE if not exists produto
(
  id serial NOT NULL,
  descricao character varying(100) NOT NULL,
  finalidade integer NOT NULL,
  unidademedida_id integer NOT NULL,
  codigoexterno character varying(100),
  CONSTRAINT pk_produto PRIMARY KEY (id),
  CONSTRAINT fk_produto_unidademedida foreign key (unidademedida_id) 
	REFERENCES unidademedida (id) on delete restrict on update cascade
);

CREATE TABLE if not exists controleestoque (
  id serial NOT NULL,
  datahora timestamp NOT NULL,
  usuario_id integer NOT NULL,
  tipomovimentacao integer NOT NULL,
  cancelado boolean NOT NULL,
  observacao character varying(512),
  CONSTRAINT pk_controleestoque PRIMARY KEY (id),
  CONSTRAINT fk_controleestoque_usuario1 foreign key (usuario_id) 
	REFERENCES usuario (id) on delete restrict on update cascade
);

COMMENT ON COLUMN controleestoque.tipomovimentacao IS '0 - Entrada 1 - Saída';

CREATE TABLE if not exists controleestoqueproduto (
  id serial NOT NULL,
  controleestoque_id integer NOT NULL,
  produto_id integer NOT NULL,
  quantidade numeric(18,2) NOT NULL,
  CONSTRAINT pk_controleestoqueproduto PRIMARY KEY (id),
  CONSTRAINT fk_controleestoqueproduto_ce1 FOREIGN KEY (controleestoque_id)
      REFERENCES controleestoque (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_controleestoqueproduto_produto1 FOREIGN KEY (produto_id)
      REFERENCES produto (id) MATCH SIMPLE
      on delete restrict on update cascade
);

CREATE TABLE if not exists controleestoquecancelamento (
  id serial NOT NULL,
  controleestoque_id integer NOT NULL,
  datahora timestamp NOT NULL,
  usuario_id integer NOT NULL,
  observacao character varying(512),
  CONSTRAINT pk_cep PRIMARY KEY (id),
  CONSTRAINT fk_cep_usuario1 foreign key (usuario_id) 
	REFERENCES usuario (id) on delete restrict on update cascade
);

CREATE TABLE if not exists produtocomposicao
(
   id serial, 
   id_produto bigint, 
   id_componente bigint, 
   quantidade numeric(18,3), 
   CONSTRAINT pk_produtocomposicao PRIMARY KEY (id), 
   CONSTRAINT fk_pc_produto FOREIGN KEY (id_produto) REFERENCES produto (id) ON UPDATE CASCADE ON DELETE CASCADE, 
   CONSTRAINT fk_pc_materiaprima FOREIGN KEY (id_componente) REFERENCES produto (id) ON UPDATE CASCADE ON DELETE CASCADE
) 
WITH (
  OIDS = FALSE
);

CREATE TABLE if not exists esterilizacao
(
  id serial NOT NULL,
  metodo character varying(100) NOT NULL,
  descricao character varying(512) NOT NULL,
  CONSTRAINT pk_esterilizacao PRIMARY KEY (id)
);

CREATE TABLE if not exists estagio
(
  id serial NOT NULL,
  descricao character varying(100) NOT NULL,
  observacao character varying(500),
  CONSTRAINT pk_estagio PRIMARY KEY (id)
);

CREATE TABLE if not exists meiocultura (
id serial NOT NULL,
id_produto bigint,
id_estagio bigint,
codigo character varying(5),
phrecomendado numeric(18,3),
observacao character varying(512),
CONSTRAINT pk_meiocultura PRIMARY KEY (id),
CONSTRAINT fk_meiocultura_estagio FOREIGN KEY (id_estagio)
    REFERENCES estagio (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE if not exists meioculturaespecie (
id serial NOT NULL,
id_meiocultura bigint,
id_especie bigint,
CONSTRAINT pk_meioculturaespecie PRIMARY KEY (id),
CONSTRAINT fk_meioculturaespecie_meiocultura FOREIGN KEY (id_meiocultura)
    REFERENCES meiocultura (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_meioculturaespecie_especie FOREIGN KEY (id_especie)
    REFERENCES produto (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists ordemproducaomc
(
  id serial NOT NULL,
  id_usuario bigint,
  id_recipiente bigint,
  id_usuarioexecutar bigint,
  datahora timestamp,
  quantrecipientes integer,
  esterilizacao boolean,
  id_produto bigint,
  phinicial numeric(18,3),
  phfinal numeric(18,3),
  mlrecipiente double precision,
  encerrado boolean,
  quantproduto double precision,
  id_esterilizacao bigint,
  datainicio date,
  datafim timestamp,
  observacao character varying(500),
  observacaoencerramento character varying(500),
  CONSTRAINT pk_ordemproducaomc PRIMARY KEY (id),
  CONSTRAINT fk_opmc_esterilizacao FOREIGN KEY (id_esterilizacao)
      REFERENCES esterilizacao (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opmc_produto FOREIGN KEY (id_produto)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opmc_recipiente FOREIGN KEY (id_recipiente)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opmc_usuario FOREIGN KEY (id_usuario)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opmc_usuarioexecutar FOREIGN KEY (id_usuarioexecutar)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists ordemproducaomc_itens
(
  id serial NOT NULL,
  id_ordemproducaomc bigint,
  id_produto bigint,
  quantidade double precision,
  CONSTRAINT pk_ordemproducaomc_itens PRIMARY KEY (id),
  CONSTRAINT fk_opmci_ordemproducaomc FOREIGN KEY (id_ordemproducaomc)
      REFERENCES ordemproducaomc (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_opmci_produto FOREIGN KEY (id_produto)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists ordemproducaomc_estoque (
id serial NOT NULL,
id_ordemproducaomc bigint,
quantidade double precision,
saldo double precision,
CONSTRAINT pk_ordemproducaomc_estoque PRIMARY KEY (id),
CONSTRAINT fk_ordemproducaomc_estoque_opmc FOREIGN KEY (id_ordemproducaomc)
    REFERENCES ordemproducaomc (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists opfinal
(
  id serial NOT NULL,
  datahora timestamp NOT NULL,
  dataencerramento timestamp,
  quantidade integer NOT NULL,
  quantidadeproduzida integer NOT NULL,
  produto_id integer NOT NULL,
  cliente_id integer NOT NULL,  
  usuario_id integer NOT NULL,
  cancelado boolean NOT NULL,
  selecaopositiva character varying(3),
  origemmaterial character varying(100),
  codigoselecaocampo character varying(100),
  datadecoleta timestamp,
  coletadopor character varying(100),
  fazendaareatalhao character varying(100),
  localizador character varying(512),
  quantidadeenviada integer,
  transportadora character varying(100),
  dataderecebimento timestamp,
  dataestimadaprocessamento timestamp,
  observacao character varying(512),
  CONSTRAINT pk_opfinal PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_p FOREIGN KEY (produto_id)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,  
  CONSTRAINT fk_opfinal_c FOREIGN KEY (cliente_id)
      REFERENCES cliente (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,  
  CONSTRAINT fk_op_u FOREIGN KEY (usuario_id)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT      
);

CREATE TABLE if not exists opfinal_estagio
(
  id serial NOT NULL,
  opfinal_id integer NOT NULL,
  datahora timestamp NOT NULL,
  datahorainicio timestamp,
  datahorafim timestamp,  
  usuario_id integer NOT NULL,
  opmc_id integer NOT NULL,
  estagio_id integer NOT NULL,
  sequencia integer NOT NULL,
  intervalocrescimento integer NOT NULL,
  quantidadeestimada integer NOT NULL,
  previsaoinicio timestamp,
  previsaotermino timestamp,
  observacao character varying(512),
  CONSTRAINT pk_opfinal_estagio PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_estagio_op FOREIGN KEY (opfinal_id)
      REFERENCES opfinal (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_u FOREIGN KEY (usuario_id)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_mc FOREIGN KEY (opmc_id)
      REFERENCES ordemproducaomc (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_e FOREIGN KEY (estagio_id)
      REFERENCES estagio (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists ordemproducaomc_estoque_op (
id serial NOT NULL,
id_ordemproducaomc_estoque bigint,
id_opfinal bigint,
quantidade double precision,
CONSTRAINT pk_ordemproducaomc_estoque_op PRIMARY KEY (id),
CONSTRAINT fk_ordemproducaomc_estoque_op_mce FOREIGN KEY (id_ordemproducaomc_estoque)
    REFERENCES ordemproducaomc_estoque (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT,
CONSTRAINT fk_ordemproducaomc_estoque_op_opfinal FOREIGN KEY (id_opfinal)
    REFERENCES opfinal (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);