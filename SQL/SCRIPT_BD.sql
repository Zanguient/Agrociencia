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
  codigoexterno character varying(100),
  CONSTRAINT pk_cliente PRIMARY KEY (id)
);