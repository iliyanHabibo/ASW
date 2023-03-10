--DUVIDAS:
--COMO METER OS OUTROS OUTROS NAS CATEGORIAS
--METEMOS ID NAS CATEGORIAS, TAMANHOS E MARCAS OU SO OS VALORES


SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS historico_compras;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS tamanho;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS utilizador;
DROP TABLE IF EXISTS comprador;
DROP TABLE IF EXISTS vendedor;
DROP TABLE IF EXISTS artigo;
DROP TABLE IF EXISTS compra;
DROP TABLE IF EXISTS vende;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------

CREATE TABLE categoria(
  id               NUMERIC(9), 
  grupo_alvo       VARCHAR(40) NOT NULL,   
  tipo_artigo      VARCHAR(40) NOT NULL,
  nome             VARCHAR(40) NOT NULL,
 
--
  CONSTRAINT pk_categoria  
    PRIMARY KEY (id)            

);


-- ----------------------------------------------------------------------------

CREATE TABLE tamanho(
  id               NUMERIC(9), 
  faixa_etaria     VARCHAR(40) NOT NULL,
  tipo_artigo      VARCHAR(40) NOT NULL,   
  valor            VARCHAR(40) NOT NULL,
 
--
  CONSTRAINT pk_tamanho  
    PRIMARY KEY (id)            

);

-- ----------------------------------------------------------------------------

CREATE TABLE marca(
  id               NUMERIC(9), 
  nome             VARCHAR(40) NOT NULL,
 
--
  CONSTRAINT pk_marca  
    PRIMARY KEY (id)               

);

-- ----------------------------------------------------------------------------

CREATE TABLE utilizador (
  id                    NUMERIC(9),
  nome                  VARCHAR(40) NOT NULL,
  data_nascimento       DATE NOT NULL,
  genero                VARCHAR(40) NOT NULL,
  morada                VARCHAR(40) NOT NULL,
  localidade            VARCHAR(40) NOT NULL,
  codigo_postal         NUMERIC(7) NOT NULL,
  telefone              NUMERIC(9) NOT NULL,
  email                 VARCHAR(40) NOT NULL,
  pwd                   VARCHAR(40) NOT NULL,

--
  CONSTRAINT pk_utilizador
    PRIMARY KEY (id)

);

-- ----------------------------------------------------------------------------

CREATE TABLE preferencias (
  utilizador          NUMERIC(9),
  categoria           NUMERIC(9),
  tamanho             NUMERIC(9),
  marca               NUMERIC(9),
--
  CONSTRAINT fk_preferencias_categoria
    FOREIGN KEY (categoria) REFERENCES categoria(id),
--
  CONSTRAINT fk_preferencias_tamanho
    FOREIGN KEY (tamanho) REFERENCES tamanho(id),
--
  CONSTRAINT fk_preferencias_marca
    FOREIGN KEY (marca) REFERENCES marca(id)

);

-- ----------------------------------------------------------------------------

CREATE TABLE artigo (
  id                    NUMERIC(9),
  titulo                VARCHAR(40) NOT NULL,
  categoria             NUMERIC(9) NOT NULL,
  tamanho               NUMERIC(9) NOT NULL,
  marca                 NUMERIC(9) NOT NULL,
  estado                VARCHAR(40) NOT NULL,
  preco                 NUMERIC(9) NOT NULL,
  tamanho_encomenda     VARCHAR(40) NOT NULL,
  descricao             VARCHAR(100),
  
--
  CONSTRAINT pk_artigo  
    PRIMARY KEY (id),               
--
  CONSTRAINT fk_artigo_categoria
    FOREIGN KEY (categoria) REFERENCES categoria(id),
--
  CONSTRAINT fk_artigo_tamanho
    FOREIGN KEY (tamanho) REFERENCES tamanho(id),
--
  CONSTRAINT fk_artigo_marca
    FOREIGN KEY (marca) REFERENCES marca(id)

);

-- ----------------------------------------------------------------------------

CREATE TABLE compra (
  id                             NUMERIC(9),
  utilizador_comprador           NUMERIC(9),
  utilizador_vendedor            NUMERIC(9),
  artigo                         NUMERIC(9),   
  data_compra                    DATE NOT NULL,

--
  CONSTRAINT pk_compra
    PRIMARY KEY (id),
--
  CONSTRAINT fk_compra_comprador
    FOREIGN KEY (utilizador_comprador) REFERENCES utilizador(id),
--
CONSTRAINT fk_compra_vendedor
    FOREIGN KEY (utilizador_vendedor) REFERENCES utilizador(id),
--
  CONSTRAINT fk_compra_artigo
    FOREIGN KEY (artigo) REFERENCES artigo(id)

);

-- ----------------------------------------------------------------------------

CREATE TABLE historico_compras (
  id                             NUMERIC(9),
  utilizador_comprador           NUMERIC(9),
  utilizador_vendedor            NUMERIC(9),
  artigo                         NUMERIC(9),   
  data_compra                    DATE NOT NULL,

--
  CONSTRAINT pk_compra
    PRIMARY KEY (id),
--
  CONSTRAINT fk_historico_compras_id
    FOREIGN KEY (id) REFERENCES compra(id) ON DELETE CASCADE,
--
  CONSTRAINT fk_historico_compras_comprador
    FOREIGN KEY (utilizador_comprador) REFERENCES compra(utilizador_comprador) ON DELETE CASCADE,
--
  CONSTRAINT fk_historico_compras_vendedor
    FOREIGN KEY (utilizador_vendedor) REFERENCES compra(utilizador_vendedor) ON DELETE CASCADE,
--
  CONSTRAINT fk_historico_compras_artigo
    FOREIGN KEY (artigo) REFERENCES compra(artigo) ON DELETE CASCADE,
--
  CONSTRAINT fk_historico_compras_data
    FOREIGN KEY (data_compra) REFERENCES compra(data_compra) ON DELETE CASCADE

);

-- ----------------------------------------------------------------------------

CREATE TABLE vende (
  id             NUMERIC(9),
  utilizador     NUMERIC(9),
  artigo         NUMERIC(9),
  
--
  CONSTRAINT pk_vende
    PRIMARY KEY (id,utilizador,artigo),
--
  CONSTRAINT fk_vende_utilizador
    FOREIGN KEY (utilizador) REFERENCES utilizador(id),
--
  CONSTRAINT fk_vende_artigo
    FOREIGN KEY (artigo) REFERENCES artigo(id)

);

-- ----------------------------------------------------------------------------

-- RIAs:

-- RIA1: O vendedor pode ser comprador e vice-versa.
-- RIA2: O administrador nao precisa de se registar.

-- ----------------------------------------------------------------------------

-- INSERTS:

-- ----------------------------------------------------------------------------

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000001, 'Maria Almeida', '2000-03-05', 'F', 'Rua 1?? de Maio n.??21', 'Lisboa', '1300471', 962736283, 'maria@gmail.com', 'abc123efg');

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000002, 'Luis Mendes', '1998-11-23', 'M', 'Rua General Morais Sarmento n.??11', 'Cascais', '2750044', 918373829, 'luismendes@gmail.com', 'luis1998');

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000003, 'Andr?? Soares', '1986-08-02', 'M', 'Rua Vasco da Gama n.??40', 'Porto', '4100365', 914836822, 'andresoares@hotmail.com', 'andrepikachu23');

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000004, 'Madalena Nunes', '2003-12-25', 'F', 'Rua 25 de Abril n.??10', 'Coimbra', '3040589', 967264537, 'madalenanunes34@gmail.com', 'madalenaobx34');
     
-- ----------------------------------------------------------------------------

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (1, 'Camisola azul da Pull&Bear', '1', '18', '2', 'Bom', '???10,00', 'M??dio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (2, 'Camisola com animais da Vertbaudet', '107', '10', '21', 'Bom', '???8,00', 'Pequeno', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (3, 'Camisola ??s riscas da Pull&Bear', '1', '17', '2', 'Bom', '???12,00', 'M??dio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (4, 'Sweater da Pull&Bear', '46', '19', '2', 'Bom', '???12,00', 'M??dio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (5, 'Camisola de l?? da Primark', '107', '5', '22', 'Bom', '???8,00', 'Pequeno', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (6, 'Camisola azul da Pull&Bear', '1', '17', '2', 'Bom', '???10,00', 'M??dio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (7, 'Colete da Pull&Bear', '48', '19', '2', 'Bom', '???16,00', 'Grande', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (8, 'Sweater da Pull&Bear', '46', '19', '2', 'Bom', '???12,00', 'M??dio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (9, 'Sweater da Primark', '107', '5', '22', 'Bom', '???8,00', 'Pequeno', NULL);

--

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (10, 'Cal??as castanhas da Pull&Bear', '9', '18', '2', 'Bom', '???12,00', 'M??dio', NULL);



-- ----------------------------------------------------------------------------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000001, 'Mulher', 'Vestu??rio', 'Camisolas e sweaters');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000002, 'Mulher', 'Vestu??rio', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000003, 'Mulher', 'Vestu??rio', 'Casacos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000004, 'Mulher', 'Vestu??rio', 'Fatos e blazers');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000005, 'Mulher', 'Vestu??rio', 'Macac??es');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000006, 'Mulher', 'Vestu??rio', 'Vestidos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000007, 'Mulher', 'Vestu??rio', 'Saias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000008, 'Mulher', 'Vestu??rio', 'Cal??as e leggings');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000009, 'Mulher', 'Vestu??rio', 'Cal??as de ganga');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000010, 'Mulher', 'Vestu??rio', 'Cal????es');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000011, 'Mulher', 'Vestu??rio', 'Vestu??rio de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000012, 'Mulher', 'Vestu??rio', 'Vestu??rio de maternidade');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000013, 'Mulher', 'Vestu??rio', 'Trajes e roupas especiais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000014, 'Mulher', 'Vestu??rio', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000015, 'Mulher', 'Cal??ado', 'Botas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000016, 'Mulher', 'Cal??ado', 'Cal??ado desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000017, 'Mulher', 'Cal??ado', 'Cal??ado tradicional');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000018, 'Mulher', 'Cal??ado', 'Chinelos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000019, 'Mulher', 'Cal??ado', 'Pantufas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000020, 'Mulher', 'Cal??ado', 'Sapatilhas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000021, 'Mulher', 'Cal??ado', 'Sapatos de salto');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000022, 'Mulher', 'Cal??ado', 'Sapatos rasos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000023, 'Mulher', 'Cal??ado', 'Sand??lias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000024, 'Mulher', 'Cal??ado', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000025, 'Mulher', 'Acess??rios', 'Acess??rios para o cabelo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000026, 'Mulher', 'Acess??rios', 'Bon??s e chap??us');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000027, 'Mulher', 'Acess??rios', 'Cachec??is e len??os');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000028, 'Mulher', 'Acess??rios', 'Cintos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000029, 'Mulher', 'Acess??rios', 'Guarda-chuva');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000030, 'Mulher', 'Acess??rios', 'Joias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000031, 'Mulher', 'Acess??rios', 'Luvas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000032, 'Mulher', 'Acess??rios', '??culos de sol');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000033, 'Mulher', 'Acess??rios', 'Porta chaves');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000034, 'Mulher', 'Acess??rios', 'Rel??gios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000035, 'Mulher', 'Acess??rios', 'Outros');

------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000036, 'Mulher', 'Malas', 'Bolsas');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000037, 'Mulher', 'Malas', 'Bolsas de cintura');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000038, 'Mulher', 'Malas', 'Bolsas de viagem');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000039, 'Mulher', 'Malas', 'Carteiras');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000040, 'Mulher', 'Malas', 'Malas a tiracolo');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000041, 'Mulher', 'Malas', 'Malas de maquilhagem');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000042, 'Mulher', 'Malas', 'Malas de viagem'); 

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000043, 'Mulher', 'Malas', 'Mochilas');  

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000044, 'Mulher', 'Malas', 'Sacos'); 

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000045, 'Mulher', 'Malas', 'Outros');   
    
-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000046, 'Homem', 'Vestu??rio', 'Camisolas e sweaters');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000047, 'Homem', 'Vestu??rio', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000048, 'Homem', 'Vestu??rio', 'Casacos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000049, 'Homem', 'Vestu??rio', 'Fatos e blazers');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000050, 'Homem', 'Vestu??rio', 'Cal??as');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000051, 'Homem', 'Vestu??rio', 'Cal??as de ganga');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000052, 'Homem', 'Vestu??rio', 'Cal????es');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000053, 'Homem', 'Vestu??rio', 'Meias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000054, 'Homem', 'Vestu??rio', 'Vestu??rio de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000055, 'Homem', 'Vestu??rio', 'Trajes e roupas especiais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000056, 'Homem', 'Vestu??rio', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000057, 'Homem', 'Cal??ado', 'Botas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000058, 'Homem', 'Cal??ado', 'Cal??ado desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000059, 'Homem', 'Cal??ado', 'Cal??ado tradicional');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000060, 'Homem', 'Cal??ado', 'Chinelos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000061, 'Homem', 'Cal??ado', 'Pantufas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000062, 'Homem', 'Cal??ado', 'Sapatilhas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000063, 'Homem', 'Cal??ado', 'Sapatos formais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000064, 'Homem', 'Cal??ado', 'Sapatos vela');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000065, 'Homem', 'Cal??ado', 'Sand??lias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000066, 'Homem', 'Cal??ado', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000067, 'Homem', 'Acess??rios', 'Bon??s e chap??us');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000068, 'Homem', 'Acess??rios', 'Cachec??is e len??os');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000069, 'Homem', 'Acess??rios', 'Cintos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000070, 'Homem', 'Acess??rios', 'Gravatas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000071, 'Homem', 'Acess??rios', 'Guarda-chuva');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000072, 'Homem', 'Acess??rios', 'Joias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000073, 'Homem', 'Acess??rios', 'Len??os de bolso');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000074, 'Homem', 'Acess??rios', 'Luvas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000075, 'Homem', 'Acess??rios', '??culos de sol');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000076, 'Homem', 'Acess??rios', 'Porta chaves');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000077, 'Homem', 'Acess??rios', 'Rel??gios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000078, 'Homem', 'Acess??rios', 'Outros');

------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000079, 'Homem', 'Malas', 'Bolsas');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000080, 'Homem', 'Malas', 'Bolsas de cintura');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000081, 'Homem', 'Malas', 'Bolsas de viagem');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000082, 'Homem', 'Malas', 'Carteiras');   

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000083, 'Homem', 'Malas', 'Malas a tiracolo');     

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000084, 'Homem', 'Malas', 'Malas de viagem'); 

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000085, 'Homem', 'Malas', 'Mochilas');  

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000086, 'Homem', 'Malas', 'Sacos'); 

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000087, 'Homem', 'Malas', 'Outros'); 

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000088, 'Crian??a', 'Vestu??rio para rapariga', 'Acess??rios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000089, 'Crian??a', 'Vestu??rio para rapariga', 'Cal??as e cal????es');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000090, 'Crian??a', 'Vestu??rio para rapariga', 'Camisolas e hoodies');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000091, 'Crian??a', 'Vestu??rio para rapariga', 'Disfarces e vestu??rio de fantasia');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000092, 'Crian??a', 'Vestu??rio para rapariga', 'Malas e mochilas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000093, 'Crian??a', 'Vestu??rio para rapariga', 'Pijamas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000094, 'Crian??a', 'Vestu??rio para rapariga', 'Roupa interior e meias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000095, 'Crian??a', 'Vestu??rio para rapariga', 'Roupa para beb??');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000096, 'Crian??a', 'Vestu??rio para rapariga', 'Saias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000097, 'Crian??a', 'Vestu??rio para rapariga', 'Sapatos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000098, 'Crian??a', 'Vestu??rio para rapariga', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000099, 'Crian??a', 'Vestu??rio para rapariga', 'Vestidos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000100, 'Crian??a', 'Vestu??rio para rapariga', 'Vestu??rio de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000101, 'Crian??a', 'Vestu??rio para rapariga', 'Vestu??rio desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000102, 'Crian??a', 'Vestu??rio para rapariga', 'Vestu??rio formal');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000103, 'Crian??a', 'Vestu??rio para rapariga', 'Vestu??rio para g??meos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000104, 'Crian??a', 'Vestu??rio para rapariga', 'Outros');

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000105, 'Crian??a', 'Vestu??rio para rapaz', 'Acess??rios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000106, 'Crian??a', 'Vestu??rio para rapaz', 'Cal??as e cal????es');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000107, 'Crian??a', 'Vestu??rio para rapaz', 'Camisolas e hoodies');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000108, 'Crian??a', 'Vestu??rio para rapaz', 'Disfarces e vestu??rio de fantasia');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000109, 'Crian??a', 'Vestu??rio para rapaz', 'Malas e mochilas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000110, 'Crian??a', 'Vestu??rio para rapaz', 'Pijamas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000111, 'Crian??a', 'Vestu??rio para rapaz', 'Roupa interior e meias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000112, 'Crian??a', 'Vestu??rio para rapaz', 'Roupa para beb??');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000113, 'Crian??a', 'Vestu??rio para rapaz', 'Sapatos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000114, 'Crian??a', 'Vestu??rio para rapaz', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000115, 'Crian??a', 'Vestu??rio para rapaz', 'Vestu??rio de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000116, 'Crian??a', 'Vestu??rio para rapaz', 'Vestu??rio desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000117, 'Crian??a', 'Vestu??rio para rapaz', 'Vestu??rio formal');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000118, 'Crian??a', 'Vestu??rio para rapaz', 'Vestu??rio para g??meos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000119, 'Crian??a', 'Vestu??rio para rapaz', 'Outros');

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000120, 'Crian??a', 'Brinquedos', 'Bonecas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000121, 'Crian??a', 'Brinquedos', 'Brinquedos educativos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000122, 'Crian??a', 'Brinquedos', 'Brinquedos de constru????o');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000123, 'Crian??a', 'Brinquedos', 'Brinquedos para dormir');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000124, 'Crian??a', 'Brinquedos', 'Brinquedos musicais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000125, 'Crian??a', 'Brinquedos', 'Brinquedos de madeira');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000126, 'Crian??a', 'Brinquedos', 'Brinquedos para ??gua');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000127, 'Crian??a', 'Brinquedos', 'Brinquedos de cozinha');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000128, 'Crian??a', 'Brinquedos', 'Figuras de a????o');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000129, 'Crian??a', 'Brinquedos', 'Jogos eletr??nicos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000130, 'Crian??a', 'Brinquedos', 'Outros');

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000131, 'Crian??a', 'Veiculos de brincar', 'Brinquedos para empurrar');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000132, 'Crian??a', 'Veiculos de brincar', 'Trotinetes');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000133, 'Crian??a', 'Veiculos de brincar', 'Tren??s, esquis e pranchas de neve');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000134, 'Crian??a', 'Veiculos de brincar', 'Bicicletas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000135, 'Crian??a', 'Veiculos de brincar', 'Triciclos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000136, 'Crian??a', 'Veiculos de brincar', 'Outros');

-- ----------------------------------------------------------------------------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000001, 'Beb??', 'Vestu??rio', '3 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000002, 'Beb??', 'Vestu??rio', '6 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000003, 'Beb??', 'Vestu??rio', '9 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000004, 'Beb??', 'Vestu??rio', '12 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000005, 'Beb??', 'Vestu??rio', '18 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000006, 'Beb??', 'Vestu??rio', '24 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000007, 'Beb??', 'Vestu??rio', '36 meses');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000008, 'Crian??a', 'Vestu??rio', '3 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000009, 'Crian??a', 'Vestu??rio', '4 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000010, 'Crian??a', 'Vestu??rio', '5 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000011, 'Crian??a', 'Vestu??rio', '6 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000012, 'Crian??a', 'Vestu??rio', '8 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000013, 'Crian??a', 'Vestu??rio', '10 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000014, 'Crian??a', 'Vestu??rio', '12 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000015, 'Crian??a', 'Vestu??rio', '14 anos');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000016, 'Adulto', 'Vestu??rio', 'XS');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000017, 'Adulto', 'Vestu??rio', 'S');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000018, 'Adulto', 'Vestu??rio', 'M');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000019, 'Adulto', 'Vestu??rio', 'L');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000020, 'Adulto', 'Vestu??rio', 'XL');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000021, 'Adulto', 'Vestu??rio', 'XXL');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000022, 'Beb??', 'Cal??ado', '17');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000023, 'Beb??', 'Cal??ado', '18');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000024, 'Beb??', 'Cal??ado', '19');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000025, 'Beb??', 'Cal??ado', '20');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000026, 'Beb??', 'Cal??ado', '21');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000027, 'Beb??', 'Cal??ado', '22');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000028, 'Crian??a', 'Cal??ado', '23');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000029, 'Crian??a', 'Cal??ado', '24');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000030, 'Crian??a', 'Cal??ado', '25');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000031, 'Crian??a', 'Cal??ado', '26');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000032, 'Crian??a', 'Cal??ado', '27');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000033, 'Crian??a', 'Cal??ado', '28');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000034, 'Crian??a', 'Cal??ado', '29');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000035, 'Crian??a', 'Cal??ado', '30');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000036, 'Crian??a', 'Cal??ado', '31');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000037, 'Crian??a', 'Cal??ado', '32');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000038, 'Crian??a', 'Cal??ado', '33');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000039, 'Crian??a', 'Cal??ado', '34');

-----

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000040, 'Adulto', 'Cal??ado', '35');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000041, 'Adulto', 'Cal??ado', '36');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000042, 'Adulto', 'Cal??ado', '37');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000043, 'Adulto', 'Cal??ado', '38');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000044, 'Adulto', 'Cal??ado', '39');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000045, 'Adulto', 'Cal??ado', '40');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000046, 'Adulto', 'Cal??ado', '41');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000047, 'Adulto', 'Cal??ado', '42');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000048, 'Adulto', 'Cal??ado', '43');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000049, 'Adulto', 'Cal??ado', '44');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000050, 'Adulto', 'Cal??ado', '45');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000051, 'Adulto', 'Cal??ado', '46');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000052, 'Adulto', 'Cal??ado', '47');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000053, 'Adulto', 'Cal??ado', '48');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000054, 'Adulto', 'Cal??ado', '>48');

-- ----------------------------------------------------------------------------

INSERT INTO marca (id, nome)
     VALUES (1, 'Bershka');

INSERT INTO marca (id, nome)
     VALUES (2, 'Pull&Bear');

INSERT INTO marca (id, nome)
     VALUES (3, 'Springfield');

INSERT INTO marca (id, nome)
     VALUES (4, 'Sacoor');

INSERT INTO marca (id, nome)
     VALUES (5, 'Salsa');

INSERT INTO marca (id, nome)
     VALUES (6, 'Lacoste');

INSERT INTO marca (id, nome)
     VALUES (7, 'Rayban');

INSERT INTO marca (id, nome)
     VALUES (8, 'Adidas');

INSERT INTO marca (id, nome)
     VALUES (9, 'H&M');

INSERT INTO marca (id, nome)
     VALUES (10, 'Lanidor');

INSERT INTO marca (id, nome)
     VALUES (11, 'Benetton');

INSERT INTO marca (id, nome)
     VALUES (12, 'Massimo Dutti');

INSERT INTO marca (id, nome)
     VALUES (13, 'Desigual');

INSERT INTO marca (id, nome)
     VALUES (14, 'Cortefiel');

INSERT INTO marca (id, nome)
     VALUES (15, 'SHEIN');

INSERT INTO marca (id, nome)
     VALUES (16, 'El Corte Ingl??s');

INSERT INTO marca (id, nome)
     VALUES (17, 'Puma');

INSERT INTO marca (id, nome)
     VALUES (18, 'Levis');

INSERT INTO marca (id, nome)
     VALUES (19, 'Tommy Hilfiger');

INSERT INTO marca (id, nome)
     VALUES (20, 'Billa Bong');

INSERT INTO marca (id, nome)
     VALUES (21, 'Vertbaudet');

INSERT INTO marca (id, nome)
     VALUES (22, 'Primark'); 

INSERT INTO marca (id, nome)
     VALUES (23, 'Nike');   

-- ----------------------------------------------------------------------------

COMMIT;

-- ----------------------------------------------------------------------------