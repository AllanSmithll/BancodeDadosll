-- QUESTÃO 1: Execute ou elabore consultas conforme se pede a seguir:

-- Questão 1.1
Select * from empregado order by matricula;

-- Questão 1.2:
select *
from empregado
where cargo in ('Analista de Sistemas Pleno');

-- Questão 1.3
Select e.primeironome || ' ' || e.sobrenome 
    as "Empregado ", d.nome 
    as "Departamento" 
From empregado e 
    join departamento d 
    on e.coddepto = d.coddepto;
    
-- Questão 1.4
Select d.nome, count(*)
from Empregado e 
    join Departamento d 
    on e.coddepto = d.coddepto
group by d.nome;

-- Questão 1.5
select d.nome
from Empregado e 
    join Departamento d 
    on e.coddepto = d.coddepto
group by d.nome
having count(e.matricula) > 3;

-- Questão 1.6
select * from empregado;
select d.nome, sum(e.salario)
from Empregado e 
    join Departamento d 
    on e.coddepto = d.coddepto
group by d.nome;

-- Questão 1.7
Select  g.primeironome || ' ' || g.sobrenome 
    as "Gerente", e.primeironome || ' ' || e.sobrenome 
    as "Empregado"  
From (empregado e 
      join empregado g   
      on e.gerente = g.matricula)   
order by g.gerente;

-- Questão 1.7.1
Select  g.primeironome || ' ' || g.sobrenome 
    as "Gerente", count(*) as "Quantidade de Empregados"  
From (empregado e 
      join empregado g   
      on e.gerente = g.matricula)
group by g.matricula
order by "Quantidade de Empregados" DESC;

-- QUESTÃO 2: resolver com subconsultas

-- Questão 2.1
Select e.primeironome
from Empregado e
where e.coddepto in(
				select d.coddepto
				from departamento d
				where d.nome like 'P%'
				);

-- Questão 2.2
select e.sobrenome as "Sobrenome do subordinado"
from empregado e
where e.gerente in (select g.matricula
              		from empregado g
              		where g.sobrenome like 'Guedes');
              
-- Questão 2.3
select e.primeironome
from Empregado e
where not exists (select *
                  from departamento d
                  where e.coddepto = d.coddepto);
				  
--insert into Empregado values (default,'Anderson','Oliveira', current_date,'Designer de Interface Sênior', 4800.00,null,null);

-- QUESTÃO 3: criar VIEW
create or replace view NomeEmpsDepts
(primeironome, nome)
as select e.primeironome, d.nome
	from empregado e
		left join departamento d
		on e.coddepto = d.coddepto;
		
select * from NomeEmpsDepts;
-- drop view NomeEmpsDepts;

-- Questão 3.1
insert into NomeEmpsDepts values ('Diogo');

-- Questão 3.2
insert into empregado values (default, 'Diogo', 'Souza', current_date,'Engenheiro de Software Pleno', 5000.00,7,1);
select * from NomeEmpsDepts;
select * from empregado order by matricula;

-- QUESTÃO 4
select * from departamento;

create or replace view Depts 
(coddepto, nome, local)
as select *
	from departamento;
select * from Depts;

insert into Depts values (default, 'Marketing', 'Sede');
insert into Depts values (default, 'Almoxarifado', 'Sede');
-- drop view Depts;

-- QUESTÃO 5
create or replace view EmprgsWithM
(primeironome, matricula, dataadmissao)
as select primeironome, matricula, dataadmissao as "Data de Admissão"
	from empregado
	where primeironome like 'M%'
	with check option;

select * from EmprgsWithM;

insert into EmprgsWithM values ('Mário', default, current_date);
insert into EmprgsWithM values ('Kléber', default, current_date); -- Esta linha dá erro, pois primeironome não começa com "M"
-- drop view EmprgsWithM;

-- QUESTÃO 6
select e.matricula
from empregado e
  EXCEPT -- Todas as linhas da primeira consulta que não estão na segunda
select e.gerente
from empregado e;

select e.matricula
from empregado e
  INTERSECT -- Todas as linhas que estão em ambas as consultas
select e.gerente
from empregado e;

-- QUESTÃO 7
select e.coddepto
from empregado e
where e.dataadmissao>'20-01-2021'
   INTERSECT
select d.coddepto
from departamento d;

-- Com subquere
select e.coddepto
from empregado e
where exists (
  select *
  from empregado 
  where dataadmissao > '2021-01-20'
)
   INTERSECT
select d.coddepto
from departamento d;

-- Com JOIN e DISTINCT
select distinct e.coddepto
from empregado e
	join departamento d
	on e.coddepto = d.coddepto
where e.dataadmissao > '2021-01-20';

-- QUESTÃO 8
WITH
Custo_depto as (
  Select d.nome, sum(e.salario) as total_depto
  From empregado e JOIN departamento d 
       on e.coddepto = d.coddepto
  Group by d.nome),
  Custo_medio as (
	Select sum(total_depto)/Count(*) as media_dep
	From Custo_depto)
Select *
From Custo_depto
Where total_depto > (
        	Select media_dep
        	From Custo_medio)
Order by nome; 