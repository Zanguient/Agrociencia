CREATE TABLE if not exists usuario
(
  id serial NOT NULL,
  nome character varying(100) NOT NULL,
  email character varying(100) NOT NULL,
  senha character varying(100),
  CONSTRAINT pk_usuario PRIMARY KEY (id)
);

CREATE TABLE usuario_permissao
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

CREATE TABLE if not exists recipientes
(
  id serial NOT NULL,
  descricao character varying(100) NOT NULL,
  codigoexterno character varying(100),
  CONSTRAINT pk_recipientes PRIMARY KEY (id)
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
  CONSTRAINT pk_cliente PRIMARY KEY (id)
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

CREATE TABLE produtocomposicao
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

CREATE TABLE if not exists ordemproducaomc
(
  id serial NOT NULL,
  CONSTRAINT pk_ordemproducaomc PRIMARY KEY (id)
);

CREATE TABLE if not exists ordemproducaofinal
(
  id serial NOT NULL,
  datahora timestamp NOT NULL,
  datahorainicio timestamp,
  datahorafim timestamp,  
  quantidade integer NOT NULL,
  observacao character varying(512),
  intervalocrescimento integer NOT NULL,
  meiodecultura_id integer NOT NULL,
  produto_id integer NOT NULL,
  cliente_id integer NOT NULL,  
  responsavel_id integer NOT NULL,
  usuario_id integer NOT NULL,
  CONSTRAINT pk_ordemproducaofinal PRIMARY KEY (id),
  CONSTRAINT fk_ordemproducaofinal_m FOREIGN KEY (meiodecultura_id)
      REFERENCES ordemproducaomc (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,  
  CONSTRAINT fk_ordemproducaofinal_p FOREIGN KEY (produto_id)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,  
    CONSTRAINT fk_ordemproducaofinal_c FOREIGN KEY (cliente_id)
      REFERENCES cliente (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,  
CONSTRAINT fk_ordemproducaofinal_r FOREIGN KEY (responsavel_id)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_ordemproducaofinal_u FOREIGN KEY (usuario_id)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT      
);

CREATE TABLE ordemproducaomc
(
  id integer NOT NULL DEFAULT nextval('ordemproducaomp_id_seq'::regclass),
  id_usuario bigint,
  id_recipiente bigint,
  id_usuarioexecutar bigint,
  datahora time without time zone,
  datainicio time without time zone,
  datafim time without time zone,
  quantrecipientes integer,
  esterilizacao boolean,
  id_produto bigint,
  phinicial numeric(18,2),
  phfinal numeric(18,2),
  phrecomendado numeric(18,2),
  mlrecipiente double precision,
  encerrado boolean,
  quantproduto double precision,
  CONSTRAINT pk_ordemproducaomp PRIMARY KEY (id),
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

CREATE TABLE ordemproducaomc_itens
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