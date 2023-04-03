select * from cliente;
select * from pedido;
select * from produto;
select * from itenspedido;
select * from vendedor;

-- JOIN
select e.nome, UF
from cliente e
	join pedido p
	on e.codcli = p.codcli
where UF in ('PE', 'PB') and prazoentrega > 15;

-- UNION
(select nome
from cliente
where cidade like 'Recife')
union
(select nome
from vendedor);

-- INTERSECT
select codcli
from cliente
where uf = 'PB'
intersect
select codcli
from pedido;

-- EXCEPT
select codcli
from cliente
except
select codcli
from pedido;

-- Cross JOIN
select c.codcli, nome, numped, p.codcli
from cliente c cross join pedido p;

-- Agregação
select cidade, count(*) as "Quantida de pessoas"
from cliente c join pedido p
on c.codcli = p.codcli
join vendedor v on p.codvend = v.codvend
group by cidade
having count(*) > 2
order by count(*) desc;

-- Sem subquery
select descricao
from produto
where unidade in ('KG', 'L', 'M');

SELECT ROUND(AVG(VALOR), 0)
FROM PRODUTO;

-- Com subconsulta
-- Exemplo 1 - IN
select p.descricao
from produto p
where p.codprod in (
				select i.codprod
				from itenspedido i
				where i.quantidade = 10);

-- Exemplo 2 - Sinal de maior
select v.nome, v.salariofixo
from vendedor v
where v.salariofixo > (
					select round(avg(salariofixo), 2) as "Média de salário"
					from vendedor);

-- Exemplo 3 - ANY
select p.descricao
from produto p
where p.valor > any (select max(pr.valor)
					from produto pr
					group by pr.unidade);
-- Com ALL, esta consulta retorna nada, pois o ALL dá falso.
					
-- Exemplo 4 - NOT EXISTS -> Produto que NOT exists em itenspedido
select codprod, descricao
from produto pr
where not exists (select *
			 from itenspedido i
			 where pr.codprod = i.codprod);

-- Subconsulta pode estar em...
-- SELECT
Select distinct
(Select COUNT(*) from cliente where cidade like
'Joao Pessoa') AS "Quantidade de Pessoenses",
(Select COUNT(*) from cliente where cidade like
'Recife') AS "Quantidade de Recifenses"
From cliente;

-- INSERT
insert into cliente (codcli,nome)
(select codvend + 10, nome
from vendedor
where faixacomissao like 'A');

-- depois deletando
DELETE FROM cliente where codcli = (SELECT codcli
			from cliente
			where codcli=13);

-- UPDATE
Update produto 
set valor = valor * 1.025
where valor < (select avg(valor)
			  from produto
			   where unidade = 'KG');
			   
create table pedidoVendedor as
select p.numped, v.nome
from pedido p join vendedor v on p.codvend = v.codvend
where data < '12/12/2020';

select * from pedidoVendedor;
-- drop table pedidoVendedor;

create table vendedor1 as
select * from vendedor where 1=2;

select * from vendedor1;

-- Antijoin
SELECT c.nome, c.codcli
FROM cliente c
WHERE c.codcli 
	NOT IN(SELECT p.codcli
			FROM pedido p)
ORDER BY c.codcli;

Select c.nome, c.codcli
from cliente c left join pedido p on c.codcli =
p.codcli
where p.codcli is null -- O antijoin está aqui, 
-- pois o WHERE está filtrando os codcli dos clientes 
-- que não têm na tabela Pedido. Ou seja, clientes
-- que nunca fizeram pedido, por isso não estão
-- na tabela pedido
Order by c.nome;

-- PARA VER O LEFT JOIN EM AÇÃO:
Select c.nome, c.codcli as cliente, p.codcli as
ClienteemPedido, numped
from cliente c left join pedido p on c.codcli = p.codcli
Order by c.nome;