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
  nomecontato character varying(100),
  datanascimento date,
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
  recipientereaproveitavel boolean NOT NULL,
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
  tipo smallint,
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
  limitemultiplicacoes integer NOT NULL,
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

CREATE TABLE opfinal_estagio
(
  id serial NOT NULL,
  opfinal_id integer NOT NULL,
  datahora timestamp without time zone NOT NULL,
  datahorainicio timestamp without time zone,
  datahorafim timestamp without time zone,
  usuario_id integer NOT NULL,
  estagio_id integer NOT NULL,
  sequencia integer NOT NULL,
  intervalocrescimento integer NOT NULL,
  quantidadeestimada integer NOT NULL,
  previsaoinicio timestamp without time zone,
  previsaotermino timestamp without time zone,
  observacao character varying(512),
  meiocultura_id bigint,
  recipiente_id bigint,
  ultimolote integer DEFAULT 0,
  CONSTRAINT pk_opfinal_estagio PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_estagio_e FOREIGN KEY (estagio_id)
      REFERENCES estagio (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_meiocultura FOREIGN KEY (meiocultura_id)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_op FOREIGN KEY (opfinal_id)
      REFERENCES opfinal (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_recipiente FOREIGN KEY (recipiente_id)
      REFERENCES produto (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_u FOREIGN KEY (usuario_id)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
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

CREATE TABLE if not exists opfinal_estagio_lote
(
  id serial NOT NULL,
  opfinal_estagio_id bigint NOT NULL,
  numerolote integer NOT NULL,
  datahorainicio timestamp,
  datahorafim timestamp,  
  usuario_id integer NOT NULL,
  observacao character varying(512),
  quantidade integer,
  estacaotrabalho character varying(20),
  CONSTRAINT pk_opfinal_estagio_lote PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_estagio_lote_op FOREIGN KEY (opfinal_estagio_id)
      REFERENCES opfinal_estagio (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfinal_estagio_lote_u FOREIGN KEY (usuario_id)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists opfinal_estagio_lote_e
(
  id serial NOT NULL,
  opfinal_estagio_lote_id bigint NOT NULL,
  codigobarras character varying(20),
  datahora timestamp NOT NULL,
  CONSTRAINT pk_opfinal_estagio_lote_e PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_estagio_lote_e_ope FOREIGN KEY (opfinal_estagio_lote_id)
      REFERENCES opfinal_estagio_lote (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists opfinal_estagio_lote_s
(
  id serial NOT NULL,
  opfinal_estagio_lote_id bigint NOT NULL,
  datahora timestamp NOT NULL,
  baixado boolean,
  CONSTRAINT pk_opfinal_estagio_lote_s PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_estagio_lote_s_ope FOREIGN KEY (opfinal_estagio_lote_id)
      REFERENCES opfinal_estagio_lote (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE if not exists opfinal_estagio_lote_intervalo
(
  id serial NOT NULL,
  opfinal_estagio_lote_id bigint NOT NULL,
  datahoraentrada timestamp NOT NULL,
  datahorasaida timestamp,
  CONSTRAINT pk_opfinal_estagio_lote_intervalo PRIMARY KEY (id),
  CONSTRAINT fk_opfinal_estagio_lote_e_ope FOREIGN KEY (opfinal_estagio_lote_id)
      REFERENCES opfinal_estagio_lote (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE motivodescarte
(
  id serial NOT NULL,
  descricao character varying(255) NOT NULL,
  CONSTRAINT pk_motivodescarte PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE opfinal_estagio_lote_s_qualidade
(
  id serial NOT NULL,
  id_opfinal_estagio_lote_s bigint,
  id_motivodescarte bigint,
  CONSTRAINT pk_opfinal_estagio_lote_s_qualidade PRIMARY KEY (id),
  CONSTRAINT fk_opfels_motivo FOREIGN KEY (id_motivodescarte)
      REFERENCES motivodescarte (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_opfelsq_pote FOREIGN KEY (id_opfinal_estagio_lote_s)
      REFERENCES opfinal_estagio_lote_s (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);

ALTER TABLE usuario ADD datanascimento date;

ALTER TABLE usuario ADD COLUMN permiteitensetiqueta boolean;

CREATE TABLE imagem
(
  id serial NOT NULL,
  id_usuario bigint,
  nomeimagem character varying(255),
  CONSTRAINT pk_imagem PRIMARY KEY (id),
  CONSTRAINT fk_imagem_usuario FOREIGN KEY (id_usuario)
      REFERENCES usuario (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

CREATE TABLE opfinal_e_l_s_q_imagem
(
  id serial NOT NULL,
  id_opfinal_estagio_lote_s_qualidade bigint,
  id_imagem bigint,
  CONSTRAINT pk_opf_e_l_s_q_imagem PRIMARY KEY (id),
  CONSTRAINT fk_opf_e_l_s_q_imagem FOREIGN KEY (id_opfinal_estagio_lote_s_qualidade)
      REFERENCES opfinal_estagio_lote_s_qualidade (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_opf_i_imagem FOREIGN KEY (id_imagem)
      REFERENCES imagem (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

CREATE TABLE opfinal_estagio_imagens
(
  id serial NOT NULL,
  id_opfinal_estagio bigint,
  id_imagem bigint,
  CONSTRAINT pk_opfinal_estagio_imagem PRIMARY KEY (id),
  CONSTRAINT fk_opf_e_f_imagem FOREIGN KEY (id_imagem)
      REFERENCES imagem (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_opf_i_e FOREIGN KEY (id_opfinal_estagio)
      REFERENCES opfinal_estagio (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

CREATE TABLE opfinal_imagem
(
  id serial NOT NULL,
  id_opfinal bigint,
  id_imagem bigint,
  CONSTRAINT pk_opfinal_imagem PRIMARY KEY (id),
  CONSTRAINT fk_opfi_imagem FOREIGN KEY (id_imagem)
      REFERENCES imagem (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_opfi_opfinal FOREIGN KEY (id_opfinal)
      REFERENCES opfinal (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

CREATE TABLE opfinal_estagio_lote_s_positivo
(
  id serial NOT NULL,
  id_opfinal_estagio_lote_s bigint,
  id_imagem bigint,
  localizacao character varying(100),
  observacao character varying(500),
  CONSTRAINT pk_opfinal_estagio_lote_s_positivo PRIMARY KEY (id),
  CONSTRAINT fk_positivo_imagem FOREIGN KEY (id_imagem)
      REFERENCES imagem (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_positivo_opf_e_l_s FOREIGN KEY (id_opfinal_estagio_lote_s)
      REFERENCES opfinal_estagio_lote_s (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

ALTER TABLE ordemproducaomc
   ADD COLUMN saldo double precision;

ALTER TABLE opfinal_estagio
  DROP COLUMN recipiente_id;

ALTER TABLE opfinal_estagio_lote
   ADD COLUMN ordemproducaomc_id bigint;

ALTER TABLE opfinal_estagio_lote
  ADD CONSTRAINT fk_opf_e_l_opmc FOREIGN KEY (ordemproducaomc_id) REFERENCES ordemproducaomc (id)
   ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX fki_opf_e_l_opmc
  ON opfinal_estagio_lote(ordemproducaomc_id);

CREATE TABLE public.ordemproducaosolucao
(
   id serial, 
   datainclusao timestamp without time zone, 
   id_usuarioinclusao bigint, 
   id_produto bigint, 
   quantidade double precision, 
   id_usuarioencerramento bigint, 
   dataencerramento timestamp without time zone, 
   CONSTRAINT pk_ordemproducaosolucao PRIMARY KEY (id), 
   CONSTRAINT fk_opsol_ui FOREIGN KEY (id_usuarioinclusao) REFERENCES usuario (id) ON UPDATE CASCADE ON DELETE RESTRICT, 
   CONSTRAINT fk_opsol_prod FOREIGN KEY (id_produto) REFERENCES produto (id) ON UPDATE CASCADE ON DELETE RESTRICT, 
   CONSTRAINT fk_opsol_ue FOREIGN KEY (id_usuarioencerramento) REFERENCES usuario (id) ON UPDATE CASCADE ON DELETE RESTRICT
) 
WITH (
  OIDS = FALSE
);

CREATE TABLE public.ordemproducaosolucao_itens
(
   id serial, 
   id_ordemproducaosolucao bigint, 
   id_produto bigint, 
   quantidade double precision, 
   CONSTRAINT pk_ordemproducaosolucao_itens PRIMARY KEY (id), 
   CONSTRAINT fk_opsoli_opsol FOREIGN KEY (id_ordemproducaosolucao) REFERENCES ordemproducaosolucao (id) ON UPDATE CASCADE ON DELETE CASCADE, 
   CONSTRAINT fk_opsoli_prod FOREIGN KEY (id_produto) REFERENCES produto (id) ON UPDATE CASCADE ON DELETE RESTRICT
) 
WITH (
  OIDS = FALSE
);

ALTER TABLE ordemproducaosolucao
   ADD COLUMN encerrado boolean;

ALTER TABLE ordemproducaosolucao
   ADD COLUMN dataprevisao date;

ALTER TABLE ordemproducaosolucao
   ADD COLUMN observacao text;

ALTER TABLE ordemproducaosolucao
   ADD COLUMN observacaoencerramento text;

////////////////////////////////////////////
   
ALTER TABLE opfinal
   ADD COLUMN cultivar character varying(100);

UPDATE opfinal SET cultivar = '';   

ALTER TABLE meiocultura
   ADD COLUMN todasasespecies boolean;

UPDATE meiocultura SET todasasespecies = False;

ALTER TABLE opfinal_estagio
   ADD COLUMN localizacao character varying(100);
UPDATE opfinal_estagio SET localizacao = '';
ALTER TABLE opfinal_estagio_lote
   ADD COLUMN localizacao character varying(100);
UPDATE opfinal_estagio_lote SET localizacao = '';

//////////////////////////////////////////////////
///// ALTERAÇÕES 1.7
//////////////////////////////////////////////////

CREATE TABLE if not exists variedade (
id serial NOT NULL,
id_produto bigint,
nome character varying(100),
CONSTRAINT pk_variedade PRIMARY KEY (id),
CONSTRAINT fk_variedade_produto FOREIGN KEY (id_produto)
    REFERENCES produto (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);

insert into variedade (id_produto, nome) select distinct opfinal.produto_id as id_produto, opfinal.cultivar as nome from opfinal;

ALTER TABLE opfinal
  ADD COLUMN id_variedade bigint;

UPDATE opfinal set id_variedade = (select variedade.id from variedade where variedade.id_produto = opfinal.produto_id and variedade.nome = opfinal.cultivar);

ALTER TABLE opfinal
  ADD CONSTRAINT fk_opf_variedade FOREIGN KEY (id_variedade) REFERENCES variedade (id)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE opfinal DROP COLUMN cultivar;

CREATE TABLE if not exists localizacao (
id serial NOT NULL,
estante integer,
sala character varying(100),
nome character varying(100),
regimeiluminacao character varying(100),
prateleiras integer,
area double precision,
temperatura double precision,
CONSTRAINT pk_localizacao PRIMARY KEY (id)
);

INSERT INTO localizacao (id, estante, sala, nome, regimeiluminacao, prateleiras, area, temperatura) VALUES (0,0, 'Não Definido', 'Não Definido', 'Não Definido', 0, 0, 0);

ALTER TABLE opfinal_estagio_lote
   ADD COLUMN localizacao_id bigint;

UPDATE opfinal_estagio_lote SET localizacao_id = 0;

ALTER TABLE opfinal_estagio_lote 
  ADD CONSTRAINT fk_opfel_localizacao FOREIGN KEY (localizacao_id) REFERENCES localizacao(id)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE opfinal_estagio
   ADD COLUMN localizacao_id bigint;

UPDATE opfinal_estagio SET localizacao_id = 0;

ALTER TABLE opfinal_estagio 
  ADD CONSTRAINT fk_opfe_localizacao FOREIGN KEY (localizacao_id) REFERENCES localizacao(id)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE opfinal_estagio_lote_s_positivo
   ADD COLUMN localizacao_id bigint;

UPDATE opfinal_estagio_lote_s_positivo SET localizacao_id = 0;

ALTER TABLE opfinal_estagio_lote_s_positivo 
  ADD CONSTRAINT fk_opfelsp_localizacao FOREIGN KEY (localizacao_id) REFERENCES localizacao(id)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE opfinal_estagio
   ADD COLUMN sequenciaestagio integer;

update opfinal_estagio set sequenciaestagio = sequencia;

CREATE TABLE if not exists opfinal_estimativa (
id serial NOT NULL,
id_opfinal bigint,
id_estagio bigint,
sequencia integer,
quantidade integer,
fatorx double precision,
perda double precision,
dias integer,
dtinicio date,
dtfim date,
CONSTRAINT pk_opfinal_estimativa PRIMARY KEY (id),
CONSTRAINT fk_estimativa_opfinal FOREIGN KEY (id_opfinal)
    REFERENCES opfinal (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_estimativa_estagio FOREIGN KEY (id_estagio)
    REFERENCES estagio (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ordemproducaomc_descarte (
id serial,
id_ordemproducaomc bigint,
quantidade integer,
id_motivo integer,
CONSTRAINT pk_ordemproducaomc_descarte PRIMARY KEY (id),
CONSTRAINT fk_ordemproducaomc_descarte_opmc FOREIGN KEY (id_ordemproducaomc)
    REFERENCES ordemproducaomc (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT,
CONSTRAINT fk_ordemproducaomc_descarte_motivo FOREIGN KEY (id_motivo)
      REFERENCES motivodescarte (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS modelo_est (
id serial,
id_produto bigint,
nome character varying(100),
CONSTRAINT pk_modelo_est PRIMARY KEY (id),
CONSTRAINT fk_modelo_est_prod FOREIGN KEY (id_produto) REFERENCES produto (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS modelo_est_estagio (
id serial,
id_modelo_est bigint,
id_estagio bigint,
sequencia integer,
fatorx double precision,
perda double precision,
dias integer,
CONSTRAINT pk_modelo_est_estagio PRIMARY KEY (id),
CONSTRAINT fk_mee_modelo_est FOREIGN KEY (id_modelo_est)
    REFERENCES modelo_est (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_mee_estagio FOREIGN KEY (id_estagio)
    REFERENCES estagio (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);