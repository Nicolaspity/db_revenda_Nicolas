create database db_revenda_nicolas;

create type status_pedido_enum as enum (
    'Solicitação', 
    'Compra', 
    'Produção', 
    'Encaminhamento', 
    'Entrega'
);

create type forma_pagamento_enum as enum (
    'Boleto', 
    'Cartão de Débito',
    'Cartão de Crédito', 
    'Pix'
);

create type genero_enum as enum (
    'Mulher Cis', 
    'Homen Cis', 
    'Mulher Trans', 
    'Homen Trans', 
    'Outros', 
    'Não quero informar'
);

create type raca_enum as enum (
    'Amarela', 
    'Branca', 
    'Indígena', 
    'Parda', 
    'Preta', 
    'Não'
);

create type metodo_entrega_enum as enum (
    'Entraga', 
    'Retirada'
);



create table endereco (
	endereco_id serial primary key,
	rua varchar(255) not null,
	bairro varchar(255) not null,
	cidade varchar(255) not null,
	estado varchar(255) not null,
	CEP char(8) not null unique, 
	numero int not null, 
	ponto_referencia text,
	last_update timestamp not null
);

create table produto (
	produto_id serial primary key,
	nome varchar(255) not null,
	descricao text not null,
	categoria varchar(255) not null,
	preco numeric(5, 2) not null,
	cor varchar(255) not null,
	altura_cm float not null,
	largura_cm float not null,
	profundidade_cm float not null,
	estoque int not null,
	last_update timestamp not null
);
create table funcionario (
    funcionario_id serial primary key,
    nome varchar(255) not null,
    sobrenome varchar(255) not null,
    email varchar(255) check (email like '%@%.com%') not null,
    senha varchar(255) not null,
    CPF char(14) check (CPF like '%.%.%-%') not null unique,
    celular char(14) not null unique,
    nascimento date not null,
    genero genero_enum not null,
    raca raca_enum not null,
    cargo varchar(255) not null,
    especializacoes varchar(255) not null,
    salario numeric(5, 2) not null,
    endereco_id int references endereco(endereco_id),
    last_update timestamp not null
);

create table usuario (
    usuario_id serial primary key,
    nome varchar(255) not null,
    sobrenome varchar(255) not null,
    email varchar(255) check (email like '%@%.com%') not null,
    senha varchar(255) not null,
    CPF char(14) check (CPF like '%.%.%-%') not null unique,
    celular char(14) not null unique,
    apelido varchar(255),
    nascimento date not null,
    genero genero_enum not null,
    raca raca_enum not null,
    endereco_id int references endereco(endereco_id),
    last_update timestamp not null
);


create table pedido (
	pedido_id serial primary key,
	descricao text not null,
	cupom numeric(5, 2) not null,
	frete numeric(5, 2) not null,
	data_pedido timestamp not null,
	status status_pedido_enum not null,
	metodo_entrega metodo_entrega_enum not null, 
	forma_pagamento forma_pagamento_enum not null,
	parcelamento int not null, 
	quantidade_produtos int not null,
    subtotal numeric(5, 2) not null,
    total numeric(5, 2) not null,
	usuario_id int references usuario(usuario_id),
	last_update timestamp not null
);

create table pedido_produto (
    pedido_id int references pedido(pedido_id),
    produto_id int references produto(produto_id),
    primary key (pedido_id, produto_id),
    last_update timestamp not null
);




insert into endereco (rua, bairro, cidade, estado, CEP, numero, ponto_referencia, last_update)
values
('Avenida Ipiranga', 'Centro', 'Petrópolis', 'RJ', '25638880', 613, 'Próximo à Catedral', NOW()),
('Rua do Imperador', 'Centro', 'Petrópolis', 'RJ', '25632221', 100, 'Em frente à Americanas', NOW()),
('Rua Teresa', 'Centro', 'Petrópolis', 'RJ', '25620020', 234, 'Próximo ao Museu', NOW()),
('Rua 16 de Março', 'Centro', 'Petrópolis', 'RJ', '25620000', 567, 'Calçadão', NOW()),
('Avenida Koeler', 'Centro', 'Petrópolis', 'RJ', '25620040', 321, 'Praça da Liberdade', NOW()),
('Rua da Imperatriz', 'Centro', 'Petrópolis', 'RJ', '25620030', 178, 'Palácio de Cristal', NOW()),
('Rua São Pedro de Alcântara', 'Centro', 'Petrópolis', 'RJ', '25620120', 455, 'Catedral São Pedro', NOW()),
('Rua do Rosário', 'Centro', 'Petrópolis', 'RJ', '25620050', 299, 'Igreja do Rosário', NOW()),
('Rua Montecaseros', 'Centro', 'Petrópolis', 'RJ', '25620010', 123, 'Casa Santos Dumont', NOW()),
('Rua Paulo Barbosa', 'Centro', 'Petrópolis', 'RJ', '25620100', 888, 'Quitandinha', NOW()),
('Rua do Catete', 'Catete', 'Rio de Janeiro', 'RJ', '22220000', 123, 'Próximo ao Museu da República', NOW()),
('Avenida Paulista', 'Bela Vista', 'São Paulo', 'SP', '01311000', 1000, 'Edifício Itália', NOW()),
('Rua da Praia', 'Centro', 'Porto Alegre', 'RS', '90010000', 567, 'Praça da Alfândega', NOW()),
('Avenida Afonso Pena', 'Boa Viagem', 'Belo Horizonte', 'MG', '30130000', 789, 'Parque Municipal', NOW()),
('Rua das Flores', 'Centro', 'Curitiba', 'PR', '80020120', 234, 'Praça Osório', NOW()),
('Avenida Beira-Mar', 'Meireles', 'Fortaleza', 'CE', '60165000', 456, 'Beira Mar', NOW()),
('Rua do Sol', 'Boa Vista', 'Recife', 'PE', '50050000', 321, 'Próximo ao Shopping', NOW()),
('Avenida Doutor João dos Santos', 'Vila Nova', 'Santos', 'SP', '11075300', 654, 'Próximo à Praia', NOW()),
('Rua das Palmeiras', 'Jardim Botânico', 'Brasília', 'DF', '71680000', 987, 'Parque da Cidade', NOW()),
('Avenida Atlântica', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021000', 1702, 'Posto 5', NOW());

insert into usuario (nome, sobrenome, email, senha, CPF, celular, apelido, nascimento, genero, raca, endereco_id, last_update)
values
('Julia', 'Lima', 'julia.lima@exemplo.com', 'hash_senha_1', '287.354.397-61', '(24)99999-9999', 'Juju', '1990-05-10', 'Mulher Cis', 'Branca', 11, NOW()),
('Marcos', 'Souza', 'marcos.souza@exemplo.com', 'hash_senha_2', '123.456.789-00', '(21)98888-8888', 'Marquinhos', '1985-08-15', 'Homen Cis', 'Parda', 12, NOW()),
('Carla', 'Ferreira', 'carla.ferreira@exemplo.com', 'hash_senha_3', '234.567.890-11', '(21)97777-7777', 'Carlinha', '1992-12-20', 'Mulher Cis', 'Preta', 13, NOW()),
('Rafael', 'Costa', 'rafael.costa@exemplo.com', 'hash_senha_4', '345.678.901-22', '(21)96666-6666', 'Rafa', '1988-03-25', 'Homen Cis', 'Branca', 14, NOW()),
('Larissa', 'Martins', 'larissa.martins@exemplo.com', 'hash_senha_5', '456.789.012-33', '(21)95555-5555', 'Lari', '1995-07-30', 'Mulher Cis', 'Amarela', 15, NOW()),
('Diego', 'Alves', 'diego.alves@exemplo.com', 'hash_senha_6', '567.890.123-44', '(21)94444-4444', 'Di', '1991-01-12', 'Homen Cis', 'Indígena', 16, NOW()),
('Paula', 'Ribeiro', 'paula.ribeiro@exemplo.com', 'hash_senha_7', '678.901.234-55', '(21)93333-3333', 'Paulinha', '1987-09-05', 'Mulher Cis', 'Parda', 17, NOW()),
('Bruno', 'Carvalho', 'bruno.carvalho@exemplo.com', 'hash_senha_8', '789.012.345-66', '(21)92222-2222', 'Bruninho', '1993-11-18', 'Homen Cis', 'Preta', 18, NOW()),
('Tatiane', 'Silveira', 'tatiane.silveira@exemplo.com', 'hash_senha_9', '890.123.456-77', '(21)91111-1111', 'Tati', '1989-04-22', 'Mulher Cis', 'Branca', 19, NOW()),
('Leonardo', 'Pires', 'leonardo.pires@exemplo.com', 'hash_senha_10', '901.234.567-88', '(21)90000-0000', 'Léo', '1994-06-08', 'Homen Cis', 'Parda', 20, NOW());


insert into funcionario (nome, sobrenome, email, senha, CPF, celular, nascimento, genero, raca, cargo, especializacoes, salario, endereco_id, last_update)
values
('João', 'Silva', 'joao.silva@empresa.com', 'hash123', '123.456.789-01', '(24)99999-9999', '1990-05-10', 'Homen Cis', 'Branca', 'Vendedor', 'Vendas', 250.00, 1, NOW()),
('Maria', 'Santos', 'maria.santos@empresa.com', 'hash456', '234.567.890-12', '(24)98888-8888', '1985-08-15', 'Mulher Cis', 'Parda', 'Gerente', 'Gestão', 350.00, 2, NOW()),
('Pedro', 'Costa', 'pedro.costa@empresa.com', 'hash789', '345.678.901-23', '(24)97777-7777', '1992-12-20', 'Homen Cis', 'Preta', 'Atendente', 'Atendimento', 180.00, 3, NOW()),
('Ana', 'Oliveira', 'ana.oliveira@empresa.com', 'hash101', '456.789.012-34', '(24)96666-6666', '1988-03-25', 'Mulher Cis', 'Branca', 'Caixa', 'Financeiro', 220.00, 4, NOW()),
('Carlos', 'Pereira', 'carlos.pereira@empresa.com', 'hash202', '567.890.123-45', '(24)95555-5555', '1995-07-30', 'Homen Cis', 'Parda', 'Estoquista', 'Logística', 190.00, 5, NOW()),
('Juliana', 'Almeida', 'juliana.almeida@empresa.com', 'hash303', '678.901.234-56', '(24)94444-4444', '1991-01-12', 'Mulher Cis', 'Branca', 'RH', 'Recrutamento', 280.00, 6, NOW()),
('Fernando', 'Lima', 'fernando.lima@empresa.com', 'hash404', '789.012.345-67', '(24)93333-3333', '1987-09-05', 'Homen Cis', 'Preta', 'Marketing', 'Publicidade', 300.00, 7, NOW()),
('Patrícia', 'Rocha', 'patricia.rocha@empresa.com', 'hash505', '890.123.456-78', '(24)92222-2222', '1993-11-18', 'Mulher Cis', 'Amarela', 'Designer', 'Design', 320.00, 8, NOW()),
('Ricardo', 'Melo', 'ricardo.melo@empresa.com', 'hash606', '901.234.567-89', '(24)91111-1111', '1989-04-22', 'Homen Cis', 'Indígena', 'TI', 'Sistemas', 400.00, 9, NOW()),
('Amanda', 'Nunes', 'amanda.nunes@empresa.com', 'hash707', '012.345.678-90', '(24)90000-0000', '1994-06-08', 'Mulher Cis', 'Parda', 'Diretora', 'Administração', 500.00, 10, NOW());


insert into produto (nome, descricao, categoria, preco, cor, altura_cm, largura_cm, profundidade_cm, estoque, last_update)
values
('Bolsa Baby Linho Natural', 'Bolsa em linho para uso diário. Bolso interno e alça ajustável.', 'Bolsa Baby', 95.00, 'Natural', 30.0, 40.0, 15.0, 10, NOW()),
('Bolsa Sua Amiga Azul', 'Bolsa com acabamento em nylon e forro interno resistente.', 'Sua Amiga', 145.00, 'Azul', 28.0, 36.0, 14.0, 6, NOW()),
('Bolsa Baú Listrada', 'Bolsa estilo baú com listras e zíper frontal.', 'Bolsa Baú', 120.00, 'Azul/Branco', 25.0, 34.0, 18.0, 5, NOW()),
('Bolsa Baú Nylon Caqui', 'Bolsa baú em nylon resistente, alça reforçada.', 'Bolsa Baú', 120.00, 'Caqui', 26.0, 35.0, 17.0, 8, NOW()),
('Bolsa Baby Mostarda', 'Bolsa pequena em tecido mostarda. Prática para saída rápida.', 'Bolsa Baby', 75.00, 'Mostarda', 22.0, 30.0, 12.0, 12, NOW()),
('Bolsa Baby Marrom', 'Bolsa em tom marrom, com acabamento em couro sintético.', 'Bolsa Baby', 120.00, 'Marrom', 27.0, 33.0, 13.0, 7, NOW()),
('Bolsa Carioca Preta', 'Bolsa estilo carioca, alças ajustáveis, visual clássico.', 'Bolsa Carioca', 145.00, 'Preta', 29.0, 38.0, 16.0, 0, NOW()),
('Bolsa Tote Minimalista', 'Bolsa tote em algodão cru com detalhes em couro.', 'Tote', 160.00, 'Cru', 35.0, 42.0, 20.0, 15, NOW()),
('Bolsa Clutch Festa', 'Clutch para eventos com detalhes de strass.', 'Clutch', 85.00, 'Dourado', 20.0, 25.0, 5.0, 20, NOW()),
('Bolsa Carioca Branca', 'Bolsa estilo carioca, alças ajustáveis, visual clássico.', 'Bolsa Carioca', 200.00, 'Branca', 29.0, 38.0, 16.0, 8, NOW());


insert into pedido (descricao, cupom, frete, data_pedido, status, metodo_entrega, forma_pagamento, parcelamento, quantidade_produtos, subtotal, total, usuario_id, last_update)
values
('Compra online - Julia', 0.00, 15.00, NOW(), 'Solicitação', 'Entraga', 'Cartão de Crédito', 2, 3, 340.00, 355.00, 1, NOW()),
('Compra retirada - Marcos', 10.00, 0.00, NOW(), 'Compra', 'Retirada', 'Pix', 1, 2, 265.00, 255.00, 2, NOW()),
('Compra online - Carla', 5.00, 20.00, NOW(), 'Produção', 'Entraga', 'Cartão de Débito', 1, 1, 145.00, 160.00, 3, NOW()),
('Compra online - Rafael', 0.00, 15.00, NOW(), 'Encaminhamento', 'Entraga', 'Boleto', 1, 2, 240.00, 255.00, 4, NOW()),
('Compra retirada - Larissa', 15.00, 0.00, NOW(), 'Entrega', 'Retirada', 'Pix', 1, 3, 360.00, 345.00, 5, NOW()),
('Compra online - Diego', 0.00, 20.00, NOW(), 'Solicitação', 'Entraga', 'Cartão de Crédito', 3, 1, 200.00, 220.00, 6, NOW()),
('Compra online - Paula', 20.00, 15.00, NOW(), 'Compra', 'Entraga', 'Cartão de Débito', 2, 2, 290.00, 285.00, 7, NOW()),
('Compra retirada - Bruno', 0.00, 0.00, NOW(), 'Produção', 'Retirada', 'Pix', 1, 1, 85.00, 85.00, 8, NOW()),
('Compra online - Tatiane', 10.00, 15.00, NOW(), 'Encaminhamento', 'Entraga', 'Boleto', 1, 4, 480.00, 485.00, 9, NOW()),
('Compra online - Leonardo', 0.00, 20.00, NOW(), 'Entrega', 'Entraga', 'Cartão de Crédito', 2, 2, 320.00, 340.00, 10, NOW());

insert into pedido_produto (pedido_id, produto_id, last_update)
values
(1, 2, NOW()),
(1, 3, NOW()),
(1, 5, NOW()),
(2, 7, NOW()),
(2, 6, NOW()),
(3, 1, NOW()),
(4, 4, NOW()),
(4, 8, NOW()),
(5, 9, NOW()),
(5, 10, NOW()),
(5, 2, NOW()),
(6, 10, NOW()),
(7, 3, NOW()),
(7, 7, NOW()),
(8, 9, NOW()),
(9, 5, NOW()),
(9, 6, NOW()),
(9, 8, NOW()),
(9, 10, NOW()),
(10, 1, NOW()),
(10, 4, NOW());


select * from usuario; 

select * from funcionario; 

select * from endereco; 

select * from pedido; 

select * from produto; 

select * from pedido_produto; 

select
	u.usuario_id,
	u.nome,
	u.email,
	p.pedido_id,
	p.descricao,
	p.status,
	p.total
from
	usuario u
inner join pedido p on
	u.usuario_id = p.usuario_id;

select
	pp.pedido_id,
	p.nome as produto_nome,
	ped.descricao as pedido_descricao,
	us.nome
from
	pedido_produto pp
inner join produto p on
	pp.produto_id = p.produto_id
inner join pedido ped on
	pp.pedido_id = ped.pedido_id
inner join usuario us on
	pp.pedido_id = us.usuario_id;
	


--27/08/2025
--OBS:
--como não entendi os slides e não tinha no W3 schols, aprendi com IA, tentando entender o processo das query's
	
-- Faça uma consulta filtrando um campo de texto utilizando like;
select
	*
from
	usuario u
where
	nome like '%i%';
--Essa consulta seleciona todas as colunas de tabela usuario que é apelidade como u onde o nome 
--apresenta a letra "i", já que %i% representa qualquer quantidade de caracteres antes e
--depois da letra "i" sendo definido pela clausa like, que especifica um padrão na minha condição. 


-- Execute um comando explain e tire um print (anexe nesta atividade);
explain analyze select
	*
from
	usuario u
where
	nome like '%i%';
--Essa consulta escanea a propria consulta, o tempo que ela levou(com o analyze) e outros dados
--(com explain), dando como resultado: seq scan(leitura de cada linha nesse caso like %i% da tabela usuario), 
--cost(estimativa de custo inicial e final de operação), rows(nº de linhas que o otimizador espera encontrar)
--, width(tamanho médio em bytes da linha, filter(verifica se nome contem a letra "i" em sua composição)
--, rows removed by filter(mostra quantas linhas descatdas pelo filtro) 
--,planning time(tempo gasto pelo PostgreSQL para planejar a consulta, decidir como executar),
-- execution time(tempo para executar a busca e retornar os significados)
--OBS: toda vez que eu executo o tempo de execução e o tempo de de plnejamento muda,
-- além de que, obviamente, a query não retorna os valores da tabela em si.




-- Crie um index para a coluna que utilizou no filtro acima;
--1 Ativa a biblioteca que permite índices de similaridade e buscas com %texto%.
create extension if not exists pg_trgm;
--2 Cria o indice da tabela usuario com o tipo gin(buscas por partes do texto) na coluna nome
create index idx_usuario_nome_trgm
on usuario
using gin (nome gin_trgm_ops);
--drop index idx_usuario_nome_trgm;
--OBS:
--Sem índice o banco faz Seq Scan, lê todas as linhas.
--Com índice o banco acessa direto só as linhas relevantes.



--Refaça a primeira consulta e execute o explain novamente.
--Tire um novo print (anexe neste atividade) e compare com o anterior. Aponte as diferenças.
select
	*
from
	usuario u
where
	nome like '%i%';
--Diferenças entre a consulta depois:
--Sem o indice criado demorou a mais 3 secundos, lendo todas as linhas. 
--Mas já com o indice criado, demorou apenas 1 secundo, lendo apenas as linhas que correspondem ao padrão do indice, nesse caso, %i%. 




-- Altere uma coluna de varchar para int, avalie o retorno, inclusive se for erro;
alter table produto
alter column cor type int
using cor::int;
-- Essa consulta iria alterar a coluna cor da tabela produto cujo tipo era varchar para um novo tipo, int 
-- Só que, como a coluna tem dados que não são numeros, deu erro de sintaxe




-- Altere uma coluna de int para varchar avalie o retorno, inclusive se for erro;
alter table pedido
alter column parcelamento type varchar
using parcelamento::varchar;
-- Essa consulta alterou a coluna cor da tabela produto cujo tipo era inteiro para um novo tipo, varchar




-- Crie um usuário com seu nome e dê todas as permissões de acesso para todas as tabelas;
create user Nicolas with password 'Nicolas123';
grant all privileges on database db_revenda_Nicolas to Nicolas;


--Crie um usuário para seu colega apenas com permissão de select em uma das tabelas;
create user julia with password 'julia123';
grant select on endereco to julia;



--Refaça todos os items no usuário que criou para seu colega, registre tudo que ocorreu (erros e acertos).
--Ao tentar criar as tabelas, inserir os valores, dá esse erro na conexão do banco de dados com o usuario
--da julia, já que ela não tem permissão para fazer nada além de consultar a tabela endereço, só que
-- não tem a tabela endereço na nova conexão do novo banco
--Erro SQL [42501]: ERRO: permissão negada para esquema public



--De volta no seu usuário, crie 12 consultas, sendo 3 consultas semelhantes (somente com alteração do tipo de join: inner, left e right). Ou seja, são 4 consultas diferentes, sendo que cada consulta terá 3 versões, uma com cada tipo de join;

--CONSULTA 1: relacionamento entre usuarios e pedidos
select
	u.usuario_id,
	u.nome,
	u.sobrenome,
	p.pedido_id,
	p.descricao,
	p.status,
	p.total
from
	usuario u
inner join pedido p on
	u.usuario_id = p.usuario_id;

select
	u.usuario_id,
	u.nome,
	u.sobrenome,
	p.pedido_id,
	p.descricao,
	p.status,
	p.total
from
	usuario u
left join pedido p on
	u.usuario_id = p.usuario_id;

select
	u.usuario_id,
	u.nome,
	u.sobrenome,
	p.pedido_id,
	p.descricao,
	p.status,
	p.total
from
	usuario u
right join pedido p on
	u.usuario_id = p.usuario_id;

--CONSULTA 2: relacionamento entre pedidos com produtos através da tabela pedido_produto
select
	p.pedido_id,
	p.descricao as pedido_descricao,
	p.status,
	p.parcelamento, 
	pr.produto_id,
	pr.nome as produto_nome,
	pr.preco
from
	pedido p
inner join pedido_produto pp on
	p.pedido_id = pp.pedido_id
inner join produto pr on
	pp.produto_id = pr.produto_id;

select
	p.pedido_id,
	p.descricao as pedido_descricao,
	p.status,
	p.parcelamento, 
	pr.produto_id,
	pr.nome as produto_nome,
	pr.preco
from
	pedido p
left join pedido_produto pp on
	p.pedido_id = pp.pedido_id
left join produto pr on
	pp.produto_id = pr.produto_id;

select
	p.pedido_id,
	p.descricao as pedido_descricao,
	p.status,
	p.parcelamento, 
	pr.produto_id,
	pr.nome as produto_nome,
	pr.preco
from
	pedido p
right join pedido_produto pp on
	p.pedido_id = pp.pedido_id
right join produto pr on
	pp.produto_id = pr.produto_id;

--CONSULTA 3: relacionamento entre funcionarios e endereços
select
	f.funcionario_id,
	f.nome,
	f.sobrenome,
	f.cargo,
	e.endereco_id,
	e.rua,
	e.cidade,
	e.estado
from
	funcionario f
inner join endereco e on
	f.endereco_id = e.endereco_id;

select
	f.funcionario_id,
	f.nome,
	f.sobrenome,
	f.cargo,
	e.endereco_id,
	e.rua,
	e.cidade,
	e.estado
from
	funcionario f
left join endereco e on
	f.endereco_id = e.endereco_id;

select
	f.funcionario_id,
	f.nome,
	f.sobrenome,
	f.cargo,
	e.endereco_id,
	e.rua,
	e.cidade
from
	funcionario f
right join endereco e on
	f.endereco_id = e.endereco_id;

--CONSULTA 4: relacionamento entre produtos e usuários (a mais complexa)
select
	pr.produto_id,
	pr.nome as produto_nome,
	pr.preco,
	p.pedido_id,
	p.descricao as pedido_descricao,
	u.usuario_id,
	u.apelido,
	u.nome as usuario_nome
from
	produto pr
inner join pedido_produto pp on
	pr.produto_id = pp.produto_id
inner join pedido p on
	pp.pedido_id = p.pedido_id
inner join usuario u on
	p.usuario_id = u.usuario_id;

select
	pr.produto_id,
	pr.nome as produto_nome,
	pr.preco,
	p.pedido_id,
	p.descricao as pedido_descricao,
	u.usuario_id,
	u.apelido,
	u.nome as usuario_nome
from
	produto pr
left join pedido_produto pp on
	pr.produto_id = pp.produto_id
left join pedido p on
	pp.pedido_id = p.pedido_id
left join usuario u on
	p.usuario_id = u.usuario_id;


select
	pr.produto_id,
	pr.nome as produto_nome,
	pr.preco,
	p.pedido_id,
	p.descricao as pedido_descricao,
	u.usuario_id,
	u.apelido,
	u.nome as usuario_nome
from
	produto pr
right join pedido_produto pp on
	pr.produto_id = pp.produto_id
right join pedido p on
	pp.pedido_id = p.pedido_id
right join usuario u on
	p.usuario_id = u.usuario_id;



--Atualize vários registros com colunas NULL;
update
	endereco
set
	ponto_referencia = null,
	last_update = NOW()
where
	endereco_id in (1, 3, 5, 7, 9);

update
	usuario
set
	apelido = null,
	last_update = NOW()
where
	usuario_id in (2, 4, 6);

--Essas consultas atualizam varios registros da coluna apelido da tabela usuario para
-- null e varios registros da  coluna ponto_referencia da tabela endereco para null.


--Execute as consultas com Join novamente, avalie os resultados.
--Resultados: algumas linhas da coluna apelido e ponto_referencia ficaram sem valor, com [null],
--mostrando que realmente funcinou