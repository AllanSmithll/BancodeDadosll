-- Aula 7 - segurança de dados com SQL

-- Criação de usuário
-- Crie um usuário novo com suas iniciais

CREATE ROLE aaa LOGIN
  PASSWORD 'Allan123#' CREATEDB CREATEROLE;
  
--

select * from cliente;
select * from pedido; 

-- conceder privilégios para usuários/roles com Grant

GRANT Select ON Produto TO dysf2;
GRANT All privileges ON Cliente TO public;
GRANT all on pedido to dysf2 WITH GRANT OPTION;
GRANT update(valor) on produto to dysf2;

-- Revogar privilégios de usuários com Revoke

Revoke select on produto from dysf;
Revoke select on cliente from public;
Revoke insert, update on pedido from dysf;

-- Inserir 5 registros antes de criar a view

insert into pedido values (default,12,current_date,4,2);
insert into pedido values (default,12,current_date,4,5);
insert into pedido values (default,12,current_date,4,3);
insert into pedido values (default,12,current_date,4,4);
insert into pedido values (default,12,current_date,4,1);

create or replace view clientesVIP as 
   SELECT c.nome as "VIP"
   FROM cliente c join pedido p on c.codcli = p.codcli
   Group by c.nome
   Having count(*) > 2; 

select * from ClientesVIP;
--drop view clientesVIP;

Grant select on clientesVIP to aaa,bd2;

