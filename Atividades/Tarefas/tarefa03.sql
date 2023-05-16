-- Tarefa 03 - 21/03/2023

-- Questão 1
select f.titulo
from filme f
where f.codest in (select e.codest
               	from estudio e
               	where e.nomeest like 'P%')
order by f.titulo;

-- Questão 2
select f.titulo
from filme f
where exists
 	(select e.codest
 	 from estudio e
  	 where f.codest = e.codest and nomeest like 'P%')
order by f.titulo;

select * from categoria;
select * from filme;

-- Questão 3
select c.desccateg
from Categoria c
where exists
	(select f.codcateg
	 from Filme f
	 where f.codcateg = c.codcateg);

select * from artista;
select * from personagem;

-- Questão 4
select a.nomeart
from Artista a
where exists
	(select p.codart
	 from Personagem p
	 where p.codart = a.codart and nomepers = 'Natalie');

-- Questão 5
select a.nomeart
from Artista a
where exists
	(select p.codart
	 from Personagem p
	 where p.codart = a.codart);
	 
-- Questão 6
select a.nomeart
from Artista a 
	JOIN Personagem p
	ON a.codart = p.codart
where p.cache > 
			(select avg(cache)
			 from Personagem);