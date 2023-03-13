-- Questão 6
select * from artista order by nomeart;
select * from estudio codest;
select * from categoria order by codcateg;
select * from filme order by codfilme;
select * from personagem order by codfilme;

-- Questão 9
select nomeart
from artista
where nomeart like 'B%';

-- Questão 10
select titulo, ano
from filme
where ano = '2019';

-- Questão 11
update personagem set cache = cache * 1.15;

-- Questão 12
update artista set pais = 'USA' where codart = 3;
update artista set pais = 'USA' where codart = 4;
update artista set pais = 'Canada' where codart = 5;

-- Questão 13
insert into artista values(default, 'Caio Castro', 'São Paulo', 'Brasil', '1989-01-22');
insert into artista values(default, 'Cauã Reymond', 'Rio de Janeiro', 'Brasil', '1980-05-20');

-- Questão 14
alter table Personagem drop constraint FKPersonagem2Artis;
alter table Personagem add constraint FKPersonagem2Artis foreign key (codart) references artista on delete cascade;
delete from artista where nomeart='Hamises Abdaba';