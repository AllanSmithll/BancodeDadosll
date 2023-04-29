-- Aula 9 - Índices

select * from artista order by codart; 
select * from artista order by nomeart; 
create index testenome on artista(nomeart);

-- testando índices e constraints
-- drop table c; 
-- drop table d; 
Create table c (c1 INT, c2 INT);
Create unique INDEX ci ON c (c1, c2);
Alter table c ADD CONSTRAINT cpk PRIMARY KEY USING INDEX ci;

-- segundo teste

CREATE TABLE d (d1 INT, d2 INT);
ALTER TABLE d ADD CONSTRAINT dpk PRIMARY KEY (d1,d2);

-- visão com índices no postgres
select * from pg_indexes;

-- visão de índices
SELECT * FROM pg_indexes WHERE tablename = 'c';
SELECT * FROM pg_indexes WHERE tablename = 'd';
SELECT * FROM pg_indexes WHERE tablename = 'categoria';

-- índice composto
CREATE TABLE testeIn (id integer, maior integer, menor integer, nome  varchar(10));
Insert into testeIn values (1,200,30,'X');
Insert into testeIn values(2, 300,23,'Y');
Insert into testeIn values(3, 200,30,'Z'); 

SELECT nome 
FROM testeIn
WHERE maior = 200 AND menor = 30;

CREATE INDEX idx_testeIn_maior_menor 
ON testeIn (maior, menor);

-- usando a tabela Filme

select * from filme; 
explain select * from filme; 

explain analyze select * from filme where codcateg = 2;
 
explain select codfilme
from filme 
where codfilme = 5; 

explain analyze select codfilme
from filme 
where codfilme = 5; 

explain analyze select titulo
from filme 
where codfilme = 5; 

-- consultando filmes
select *
from filme
where ano = 2021; 

explain analyze Select * 
From filme
Where ano = 2021; 

-- drop index anoin; 

CREATE INDEX anoIn ON filme(ano);

explain analyze Select * 
From filme
Where ano = 2021;

select * from artista; 

explain analyze 
select nomeart from artista where cidade = 'Los Angeles' and pais = 'USA';

CREATE INDEX artistaIn ON artista(cidade,pais);
-- drop index artistaIn; 

explain analyze 
select a.nomeart
from artista a join personagem p on a.codart = p.codart
     join filme f on p.codfilme = f.codfilme
where f.ano = 2021; 

select indexname
from pg_indexes
where tablename = 'personagem'; 