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
     VALUES (000000001, 'Maria Almeida', '2000-03-05', 'F', 'Rua 1º de Maio n.º21', 'Lisboa', '1300471', 962736283, 'maria@gmail.com', 'abc123efg');

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000002, 'Luis Mendes', '1998-11-23', 'M', 'Rua General Morais Sarmento n.º11', 'Cascais', '2750044', 918373829, 'luismendes@gmail.com', 'luis1998');

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000003, 'André Soares', '1986-08-02', 'M', 'Rua Vasco da Gama n.º40', 'Porto', '4100365', 914836822, 'andresoares@hotmail.com', 'andrepikachu23');

INSERT INTO utilizador (id, nome, data_nascimento, genero, morada, localidade, codigo_postal, telefone, email, pwd)
     VALUES (000000004, 'Madalena Nunes', '2003-12-25', 'F', 'Rua 25 de Abril n.º10', 'Coimbra', '3040589', 967264537, 'madalenanunes34@gmail.com', 'madalenaobx34');
     
-- ----------------------------------------------------------------------------

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (1, 'Camisola azul da Pull&Bear', '1', '18', '2', 'Bom', '€10,00', 'Médio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (2, 'Camisola com animais da Vertbaudet', '107', '10', '21', 'Bom', '€8,00', 'Pequeno', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (3, 'Camisola às riscas da Pull&Bear', '1', '17', '2', 'Bom', '€12,00', 'Médio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (4, 'Sweater da Pull&Bear', '46', '19', '2', 'Bom', '€12,00', 'Médio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (5, 'Camisola de lã da Primark', '107', '5', '22', 'Bom', '€8,00', 'Pequeno', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (6, 'Camisola azul da Pull&Bear', '1', '17', '2', 'Bom', '€10,00', 'Médio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (7, 'Colete da Pull&Bear', '48', '19', '2', 'Bom', '€16,00', 'Grande', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (8, 'Sweater da Pull&Bear', '46', '19', '2', 'Bom', '€12,00', 'Médio', NULL);

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (9, 'Sweater da Primark', '107', '5', '22', 'Bom', '€8,00', 'Pequeno', NULL);

--

INSERT INTO artigo (id, titulo, categoria, tamanho, marca, estado, preco, tamanho_encomenda, descricao)
     VALUES (10, 'Calças castanhas da Pull&Bear', '9', '18', '2', 'Bom', '€12,00', 'Médio', NULL);



-- ----------------------------------------------------------------------------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000001, 'Mulher', 'Vestuário', 'Camisolas e sweaters');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000002, 'Mulher', 'Vestuário', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000003, 'Mulher', 'Vestuário', 'Casacos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000004, 'Mulher', 'Vestuário', 'Fatos e blazers');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000005, 'Mulher', 'Vestuário', 'Macacões');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000006, 'Mulher', 'Vestuário', 'Vestidos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000007, 'Mulher', 'Vestuário', 'Saias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000008, 'Mulher', 'Vestuário', 'Calças e leggings');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000009, 'Mulher', 'Vestuário', 'Calças de ganga');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000010, 'Mulher', 'Vestuário', 'Calções');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000011, 'Mulher', 'Vestuário', 'Vestuário de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000012, 'Mulher', 'Vestuário', 'Vestuário de maternidade');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000013, 'Mulher', 'Vestuário', 'Trajes e roupas especiais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000014, 'Mulher', 'Vestuário', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000015, 'Mulher', 'Calçado', 'Botas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000016, 'Mulher', 'Calçado', 'Calçado desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000017, 'Mulher', 'Calçado', 'Calçado tradicional');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000018, 'Mulher', 'Calçado', 'Chinelos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000019, 'Mulher', 'Calçado', 'Pantufas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000020, 'Mulher', 'Calçado', 'Sapatilhas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000021, 'Mulher', 'Calçado', 'Sapatos de salto');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000022, 'Mulher', 'Calçado', 'Sapatos rasos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000023, 'Mulher', 'Calçado', 'Sandálias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000024, 'Mulher', 'Calçado', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000025, 'Mulher', 'Acessórios', 'Acessórios para o cabelo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000026, 'Mulher', 'Acessórios', 'Bonés e chapéus');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000027, 'Mulher', 'Acessórios', 'Cachecóis e lenços');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000028, 'Mulher', 'Acessórios', 'Cintos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000029, 'Mulher', 'Acessórios', 'Guarda-chuva');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000030, 'Mulher', 'Acessórios', 'Joias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000031, 'Mulher', 'Acessórios', 'Luvas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000032, 'Mulher', 'Acessórios', 'Óculos de sol');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000033, 'Mulher', 'Acessórios', 'Porta chaves');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000034, 'Mulher', 'Acessórios', 'Relógios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000035, 'Mulher', 'Acessórios', 'Outros');

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
     VALUES (000000046, 'Homem', 'Vestuário', 'Camisolas e sweaters');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000047, 'Homem', 'Vestuário', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000048, 'Homem', 'Vestuário', 'Casacos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000049, 'Homem', 'Vestuário', 'Fatos e blazers');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000050, 'Homem', 'Vestuário', 'Calças');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000051, 'Homem', 'Vestuário', 'Calças de ganga');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000052, 'Homem', 'Vestuário', 'Calções');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000053, 'Homem', 'Vestuário', 'Meias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000054, 'Homem', 'Vestuário', 'Vestuário de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000055, 'Homem', 'Vestuário', 'Trajes e roupas especiais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000056, 'Homem', 'Vestuário', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000057, 'Homem', 'Calçado', 'Botas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000058, 'Homem', 'Calçado', 'Calçado desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000059, 'Homem', 'Calçado', 'Calçado tradicional');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000060, 'Homem', 'Calçado', 'Chinelos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000061, 'Homem', 'Calçado', 'Pantufas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000062, 'Homem', 'Calçado', 'Sapatilhas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000063, 'Homem', 'Calçado', 'Sapatos formais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000064, 'Homem', 'Calçado', 'Sapatos vela');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000065, 'Homem', 'Calçado', 'Sandálias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000066, 'Homem', 'Calçado', 'Outros');

----

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000067, 'Homem', 'Acessórios', 'Bonés e chapéus');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000068, 'Homem', 'Acessórios', 'Cachecóis e lenços');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000069, 'Homem', 'Acessórios', 'Cintos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000070, 'Homem', 'Acessórios', 'Gravatas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000071, 'Homem', 'Acessórios', 'Guarda-chuva');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000072, 'Homem', 'Acessórios', 'Joias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000073, 'Homem', 'Acessórios', 'Lenços de bolso');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000074, 'Homem', 'Acessórios', 'Luvas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000075, 'Homem', 'Acessórios', 'Óculos de sol');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000076, 'Homem', 'Acessórios', 'Porta chaves');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000077, 'Homem', 'Acessórios', 'Relógios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000078, 'Homem', 'Acessórios', 'Outros');

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
     VALUES (000000088, 'Criança', 'Vestuário para rapariga', 'Acessórios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000089, 'Criança', 'Vestuário para rapariga', 'Calças e calções');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000090, 'Criança', 'Vestuário para rapariga', 'Camisolas e hoodies');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000091, 'Criança', 'Vestuário para rapariga', 'Disfarces e vestuário de fantasia');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000092, 'Criança', 'Vestuário para rapariga', 'Malas e mochilas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000093, 'Criança', 'Vestuário para rapariga', 'Pijamas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000094, 'Criança', 'Vestuário para rapariga', 'Roupa interior e meias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000095, 'Criança', 'Vestuário para rapariga', 'Roupa para bebé');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000096, 'Criança', 'Vestuário para rapariga', 'Saias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000097, 'Criança', 'Vestuário para rapariga', 'Sapatos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000098, 'Criança', 'Vestuário para rapariga', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000099, 'Criança', 'Vestuário para rapariga', 'Vestidos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000100, 'Criança', 'Vestuário para rapariga', 'Vestuário de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000101, 'Criança', 'Vestuário para rapariga', 'Vestuário desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000102, 'Criança', 'Vestuário para rapariga', 'Vestuário formal');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000103, 'Criança', 'Vestuário para rapariga', 'Vestuário para gémeos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000104, 'Criança', 'Vestuário para rapariga', 'Outros');

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000105, 'Criança', 'Vestuário para rapaz', 'Acessórios');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000106, 'Criança', 'Vestuário para rapaz', 'Calças e calções');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000107, 'Criança', 'Vestuário para rapaz', 'Camisolas e hoodies');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000108, 'Criança', 'Vestuário para rapaz', 'Disfarces e vestuário de fantasia');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000109, 'Criança', 'Vestuário para rapaz', 'Malas e mochilas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000110, 'Criança', 'Vestuário para rapaz', 'Pijamas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000111, 'Criança', 'Vestuário para rapaz', 'Roupa interior e meias');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000112, 'Criança', 'Vestuário para rapaz', 'Roupa para bebé');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000113, 'Criança', 'Vestuário para rapaz', 'Sapatos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000114, 'Criança', 'Vestuário para rapaz', 'Tops e tshirts');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000115, 'Criança', 'Vestuário para rapaz', 'Vestuário de banho');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000116, 'Criança', 'Vestuário para rapaz', 'Vestuário desportivo');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000117, 'Criança', 'Vestuário para rapaz', 'Vestuário formal');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000118, 'Criança', 'Vestuário para rapaz', 'Vestuário para gémeos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000119, 'Criança', 'Vestuário para rapaz', 'Outros');

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000120, 'Criança', 'Brinquedos', 'Bonecas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000121, 'Criança', 'Brinquedos', 'Brinquedos educativos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000122, 'Criança', 'Brinquedos', 'Brinquedos de construção');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000123, 'Criança', 'Brinquedos', 'Brinquedos para dormir');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000124, 'Criança', 'Brinquedos', 'Brinquedos musicais');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000125, 'Criança', 'Brinquedos', 'Brinquedos de madeira');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000126, 'Criança', 'Brinquedos', 'Brinquedos para água');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000127, 'Criança', 'Brinquedos', 'Brinquedos de cozinha');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000128, 'Criança', 'Brinquedos', 'Figuras de ação');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000129, 'Criança', 'Brinquedos', 'Jogos eletrónicos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000130, 'Criança', 'Brinquedos', 'Outros');

-------

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000131, 'Criança', 'Veiculos de brincar', 'Brinquedos para empurrar');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000132, 'Criança', 'Veiculos de brincar', 'Trotinetes');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000133, 'Criança', 'Veiculos de brincar', 'Trenós, esquis e pranchas de neve');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000134, 'Criança', 'Veiculos de brincar', 'Bicicletas');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000135, 'Criança', 'Veiculos de brincar', 'Triciclos');

INSERT INTO categoria (id, grupo_alvo, tipo_artigo, nome)
     VALUES (000000136, 'Criança', 'Veiculos de brincar', 'Outros');

-- ----------------------------------------------------------------------------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000001, 'Bebé', 'Vestuário', '3 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000002, 'Bebé', 'Vestuário', '6 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000003, 'Bebé', 'Vestuário', '9 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000004, 'Bebé', 'Vestuário', '12 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000005, 'Bebé', 'Vestuário', '18 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000006, 'Bebé', 'Vestuário', '24 meses');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000007, 'Bebé', 'Vestuário', '36 meses');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000008, 'Criança', 'Vestuário', '3 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000009, 'Criança', 'Vestuário', '4 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000010, 'Criança', 'Vestuário', '5 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000011, 'Criança', 'Vestuário', '6 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000012, 'Criança', 'Vestuário', '8 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000013, 'Criança', 'Vestuário', '10 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000014, 'Criança', 'Vestuário', '12 anos');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000015, 'Criança', 'Vestuário', '14 anos');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000016, 'Adulto', 'Vestuário', 'XS');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000017, 'Adulto', 'Vestuário', 'S');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000018, 'Adulto', 'Vestuário', 'M');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000019, 'Adulto', 'Vestuário', 'L');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000020, 'Adulto', 'Vestuário', 'XL');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000021, 'Adulto', 'Vestuário', 'XXL');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000022, 'Bebé', 'Calçado', '17');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000023, 'Bebé', 'Calçado', '18');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000024, 'Bebé', 'Calçado', '19');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000025, 'Bebé', 'Calçado', '20');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000026, 'Bebé', 'Calçado', '21');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000027, 'Bebé', 'Calçado', '22');

-------

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000028, 'Criança', 'Calçado', '23');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000029, 'Criança', 'Calçado', '24');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000030, 'Criança', 'Calçado', '25');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000031, 'Criança', 'Calçado', '26');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000032, 'Criança', 'Calçado', '27');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000033, 'Criança', 'Calçado', '28');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000034, 'Criança', 'Calçado', '29');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000035, 'Criança', 'Calçado', '30');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000036, 'Criança', 'Calçado', '31');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000037, 'Criança', 'Calçado', '32');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000038, 'Criança', 'Calçado', '33');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000039, 'Criança', 'Calçado', '34');

-----

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000040, 'Adulto', 'Calçado', '35');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000041, 'Adulto', 'Calçado', '36');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000042, 'Adulto', 'Calçado', '37');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000043, 'Adulto', 'Calçado', '38');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000044, 'Adulto', 'Calçado', '39');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000045, 'Adulto', 'Calçado', '40');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000046, 'Adulto', 'Calçado', '41');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000047, 'Adulto', 'Calçado', '42');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000048, 'Adulto', 'Calçado', '43');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000049, 'Adulto', 'Calçado', '44');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000050, 'Adulto', 'Calçado', '45');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000051, 'Adulto', 'Calçado', '46');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000052, 'Adulto', 'Calçado', '47');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000053, 'Adulto', 'Calçado', '48');

INSERT INTO tamanho (id, faixa_etaria, tipo_artigo, valor)
     VALUES (000000054, 'Adulto', 'Calçado', '>48');

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
     VALUES (16, 'El Corte Inglés');

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