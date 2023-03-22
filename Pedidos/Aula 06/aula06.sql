-- Aula 06 - Views

select * from produto order by codprod; 

-- View Prquilo

CREATE  or replace VIEW Prquilo 
     (codigo, descricao,unidade) 
       AS Select codprod,descricao,unidade
	  From produto
	  Where unidade = 'KG';

Select * from Prquilo;
Select * from Prquilo order by codigo; 
Select descricao from prquilo order by descricao;

-- View VendSal

CREATE OR REPLACE VIEW VendSal(codigo,nome,salario)
           AS Select codvend,nome,salariofixo
	          From vendedor; 

Select * from VendSal;
Select nome from vendSal order by nome;

-- Prquilo e tabela produto

Select * from prquilo order by codigo;
Select * from produto order by codprod;

Insert into PRquilo 
values (110,'Arroz','KG');

Update Prquilo
Set descricao = 'Arroz Integral'
Where codigo = 110;

Select * from prquilo order by codigo;
Select * from produto order by codprod;

Delete from PRquilo 
where descricao = 'Arroz Integral';

-- View Listapedidos

CREATE or replace VIEW Listapedidos AS
   Select nome, descricao
   From vendedor v join pedido p on v.codvend = p.codvend 
   Join itenspedido i on p.numped = i.numped 
   join produto pr on i.codprod = pr.codprod
   order by nome;
   
Select * from listapedidos order by nome;

-- View totalSalarios

Create or replace view totalsalarios as
    select sum(salariofixo) as TotaldeSalarios
    from vendedor;

Select * from totalsalarios;

-- View ProdutodescA

CREATE OR REPLACE VIEW ProdutodescA AS
SELECT codprod, descricao
FROM produto
WHERE descricao like 'A%'
WITH CHECK OPTION; -- Só funciona para View, e se tiver Where antes

Select * from produtodesca;

Insert into ProdutodescA values (40, 'Manteiga'); -- Dá errado
Insert into ProdutodescA values (41, 'Azeite');

-- com JOIN

Select nome from vendsal v 
    join pedido p 
    on v.codigo = p.codvend;

Select nome from vendedor v 
    join pedido p 
    on v.codvend = p.codvend;

-- Comando WITH
select * from cliente;

With ClientesAtivos AS
    (SELECT codcli, nome from Cliente WHERE endereco is not null ), 
    ClientesInativos AS
    (SELECT codcli, nome from Cliente WHERE endereco is null )
    SELECT * FROM ClientesAtivos
    UNION 
    SELECT * FROM ClientesInativos;
