-- Aula 04

Select nome
	From cliente
	Where cidade = 'Joao Pessoa';
	
	select * from cliente; 
	select * from pedido; 
	select * from vendedor; 
	
Select nome, UF 
from cliente JOIN pedido 
        on cliente.codcli = pedido.codcli 
where UF in ('PB','PE') and prazoentrega > 15;

-- Operações de conjuntos 

(Select nome
    from cliente
    where cidade like 'Recife')
    UNION
(Select nome
 from vendedor);

select codcli
  from cliente
  where UF = 'PB'
  INTERSECT
select codcli
   from pedido;

select codcli
  from cliente
Except
select codcli
   from pedido;
   
select * from cliente order by codcli; 

select * from pedido order by numped; 

-- produto cartesiano

Select cliente.codcli, nome, numped, pedido.codcli
from cliente, pedido;

Select cliente.codcli, nome, numped, pedido.codcli
from cliente cross JOIN pedido;

-- Joins

Select cliente.codcli, pedido.codcli, nome, numped
from cliente, pedido
where cliente.codcli = pedido.codcli;

Select cliente.codcli, pedido.codcli, nome, numped
from cliente JOIN pedido on cliente.codcli = pedido.codcli;

Select v.nome 
From vendedor v join pedido p 
        on v.codvend =  p.codvend
     join itenspedido i on p.numped = i.numped 
     join produto pr on i.codprod = pr.codprod
Where i.quantidade > 5 and pr.descricao = 'Chocolate'; 

-- Group by 

Select cidade, count(*)
from cliente C join pedido P on C.codcli = P.codcli 
join vendedor V on P.codvend = V.codvend 
Group by cidade;

select cliente.uf, count(*) 
from cliente
group by uf
having count(*) > 2; 

select v.faixacomissao, avg(salariofixo)
from vendedor v
where v.faixacomissao <> 'B'
group by v.faixacomissao
having avg(salariofixo) > 3000; 

select v.faixacomissao, min(salariofixo), max(salariofixo)
from vendedor v
group by v.faixacomissao