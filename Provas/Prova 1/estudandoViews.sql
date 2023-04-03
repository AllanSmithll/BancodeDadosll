-- ESTUDANDO VIEW
-- Prquilo
CREATE or replace VIEW Prquilo
(codigo, descricao,unidade)
AS Select codprod,descricao,unidade

From produto
Where unidade = 'KG';
select * from Prquilo;

-- VendSal
CREATE OR REPLACE VIEW
VendSalarios(codigo,nome,salario)
AS Select codvend,nome,salariofixo
From vendedor;
Select * from VendSal;

-- Data Manipulaion com Prquilo - SELECT também pode ser DQL
insert into Prquilo values (110, 'Arroz', 'KG');
update Prquilo set descricao = 'Arroz Integral'
where codigo = 110;
select * from Prquilo;
select * from produto;
delete from Prquilo where descricao = 'Arroz Integral';

-- ATENÇÃO
-- Se a view for do tipo join ou for
-- criada com group by,
-- operadores distinct ou funções
-- de grupo, não poderá ser
-- diretamente utilizada para
-- inclusão, exclusão ou alteração.
CREATE or replace VIEW Listapedidos AS
Select nome, descricao
From vendedor v join pedido p on v.codvend = p.codvend
Join itenspedido i on p.numped = i.numped
join produto pr on i.codprod = pr.codprod
order by nome;
-- A TABELA acima é estática, não podendo ser
-- atualizada, nem excluída, nem alterada

-- Tem vezes que realmente não faz sentido manipular
-- Views
Create or replace view totalsalarios as
select sum(salariofixo) as TotaldeSalarios
from vendedor;
update totalsalarios 
set totaldesalarios = totaldesalarios + 130;
-- Esse update não faz sentido

-- WITH CHECK OPTION
create or replace view produtodescA as
select codprod, descricao
from produto
where descricao like 'A%'
with check option;

select * from produtodesca;

-- Insert into ProdutodescA values (40,'Manteiga'); -- dá errado, pois não começa com A

Insert into ProdutodescA values (41, 'Azeite');

-- Mais DDL
alter view vendsalarios rename to vendsalarios2;
select * from vendsalarios2;
drop view vendsalarios2;

-- WITH
select * from cliente;
WITH ClientesComEndereco as
(SELECT nome FROM Cliente WHERE endereco is not null),
ClientesSemEndereco as
(SELECT nome FROM Cliente WHERE endereco is null)
SELECT * FROM ClientesComEndereco
UNION
SELECT * FROM ClientesSemEndereco;