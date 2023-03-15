-- BD Pedidos
-- script da aula 05 - subqueries e outros comandos

select * from produto order by codprod; 

Select descricao
From produto
Where unidade IN ('KG', 'L', 'M');

Select round(avg(valor),0)
From produto; 

Select descricao
From produto
Where codprod in 
     (select codprod
	  From itenspedido
      Where quantidade = 10);

select * from vendedor order by codvend; 

select nome
	From vendedor
	Where salariofixo < 
	      (select round(AVG(salariofixo),1)
		   From vendedor);
								 

select * from produto; 

Select  pr.unidade, max(pr.valor) 
From  produto pr
group by pr.unidade; 
		 
Select p.descricao 
From produto p
Where  p.valor > 
    ANY (Select  max(pr.valor) 
         From  produto pr
         group by pr.unidade) ;
		 
-- Teste com ALL

Select p.descricao 
From produto p
Where  p.valor > 
    ALL (Select  max(pr.valor) 
         From  produto pr
         group by pr.unidade) ;

-- Faça a seguinte inserção
insert into produto values (default, 'XXX', 1.2, 'KG');

select * from produto order by codprod; 

select p.descricao
	From produto P
	Where not exists 
	(select *
     From itenspedido i
	 Where i.codprod = P.codprod);

Select p.descricao
From produto p 
Where p.codprod in  
     (select i.codprod
	  From itenspedido i
	  Where i.quantidade = 10);

Select p.descricao
From produto p 
Where p.codprod in  
     (select i.codprod
	  From itenspedido i);
	  
Select p.descricao
From produto p 
Where p.codprod not in  
     (select i.codprod
	  From itenspedido i);
	  
select p.descricao
	From produto P
	Where exists 
	(select *
     From itenspedido i
	 Where i.codprod = P.codprod);


-- Outras subqueries

Select distinct 
   (Select COUNT(*) from cliente where cidade like 'João Pessoa') AS "Quantidade de Pessoenses", 
   (Select COUNT(*) from cliente where cidade like 'Recife') AS "Quantidade de Recifenses"
  From cliente;
  
insert into cliente (codcli,nome) 
          (select codvend + 10, nome
          from vendedor
          where faixacomissao like 'A');
		  
select * from cliente order by codcli; 
select * from vendedor order by codvend; 

Update produto
Set valor = valor*1.025
Where valor < (select avg(valor) 
			   From produto
			   Where unidade = 'KG');
			   
select * from produto order by unidade; 

--Inserir antes do delete

insert into pedido values(100,10,'12/10/2020',4,null);

select * from pedido; 

delete from pedido P
where not exists (select nome
     		    from vendedor v
     		    where v.codvend = P.codvend);

Select p.data 
from pedido p
where p.numped in 
       (select i.numped 
        from itenspedido i
        where i.codprod in 
               (select pr.codprod 
                from produto pr
                where descricao like 'Chocolate'))

-- Create table as

CREATE TABLE pedidoVendedor AS 
select p.numped, v.nome
from pedido p join vendedor v on p.codvend = v.codvend
where data < '12/12/2020'; 

Select * from pedidoVendedor;

insert into pedidoVendedor values(201, 'Bruno Assis');

create table vendedor1 as 
     select * from vendedor where 1=2;
select * from vendedor1;

-- AntiJOINs

SELECT c.nome, c.codcli 
FROM cliente c
WHERE c.codcli NOT IN 
		(SELECT p.codcli 
		 FROM pedido p) 
ORDER BY c.nome;

Select c.nome, c.codcli
from cliente c left join pedido p on c.codcli = p.codcli
where p.codcli is null
Order by c.nome;

Select c.nome, c.codcli as cliente, p.codcli as ClienteemPedido, numped
from cliente c left join pedido p on c.codcli = p.codcli
Order by c.nome;
