-- Aula 04 - Empregados e departamentos

Select * from empregado order by matricula; 
Select * from departamento; 

Select e.sobrenome as "Empregado", d.nome as "Departamento", 
e.dataadmissao as "Data de Admissão"
From empregado e join departamento d on e.coddepto = d.coddepto;

select * from empregado; 

Select e.primeironome as "Empregado", 	g.primeironome as "Gerente"
   From (empregado e join 
             empregado g 
  on e.gerente = g.matricula);

Select d.nome as Departamento, 	e.primeironome as
Empregado
From departamento d left outer join empregado e
on d.coddepto = e.coddepto;

select d.nome as Departamento, e.primeironome 
as Empregado
	from departamento d right outer join empregado e
		on d.coddepto = e.coddepto
   order by d.nome; 
   
Select d.nome as Departamento, 	e.primeironome as Empregado
From departamento d full join empregado e on d.coddepto = e.coddepto;

Select d.nome as Departamento, 	e.primeironome as Funcionario
	From departamento d left join empregado e
		on d.coddepto = e.coddepto
   Where e.coddepto is null
   Order by d.nome; 
