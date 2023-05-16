-- Tarefa 2 - 13/03/2023

-- Questão 1
select * from artista order by codart;
select * from estudio order by codest;
select * from categoria;
select * from filme order by codfilme;
select * from personagem;

-- Questão 2
insert into filme values(default,'Elvis',2022,120,null,3);
select * from filme;

-- Questão 3
select titulo, duracao 
from filme
where duracao > 120;

-- Questão 4
select nomeart
from artista
where cidade is null;

update artista 
set cidade = 'Cajazeiras' 
where codart in (2, 3, 5);

-- Questão 5
select C.desccateg
from categoria C join Filme F
on C.codcateg = F.codcateg
where titulo = 'Coringa';

-- Questão 6
select F.titulo, E.nomeest, C.desccateg
from Filme F 
JOIN Estudio E 
on F.codest = E.codest
JOIN Categoria C
on F.codcateg = F.codcateg;

-- Questão 7
select A.nomeart
from Artista A
    join Personagem P 
    on A.codart = P.codart
    join Filme F
    on P.codfilme = F.codfilme
where P.codfilme = 1;

-- Questão 8
select A.nomeart
from Artista A
    join Personagem P 
    on A.codart = P.codart
    join Filme F
    on P.codfilme = F.codfilme
    join Categoria C
    on C.codcateg = F.codcateg
where C.desccateg = 'Aventura' and A.nomeart like 'B%';

-- Questão 9
select C.desccateg, count(C.desccateg)
from Filme F 
    join Categoria C
    on F.codcateg = C.codcateg
group by C.desccateg;

-- Questão 10
select a.nomeart, p.nomepers
from artista a 
	left outer join personagem p 
	on a.codart = p.codart;

-- Questão 11
Select f.titulo as Filme, c.desccateg as Categoria
From filme f 
	right join categoria c 
	on f.codcateg = c.codcateg
Where f.codcateg is null;