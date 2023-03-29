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
select d.nome, count(e.matricula)
from Empregado e 
    join Departamento d 
    on e.coddepto = d.coddepto
where cargo like '%Engenheiro%'
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
				  
--insert into Empregado values (default,'Anderson','Oliveira',
							  current_date,'Designer de Interface Sênior',
							  4800.00,null,null);

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
