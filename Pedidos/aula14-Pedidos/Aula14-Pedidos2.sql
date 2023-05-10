-- Aula 14 Triggers com BD Pedidos

-- Exemplo 4

Create or replace view vPessoas as 
   select nome as nome, 'c' as tipo 
   from cliente
	 Union
    Select nome, 'v' from vendedor;
Select * from vPessoas;
select * from vPessoas order by tipo; 

CREATE or replace FUNCTION insere_view_vPessoas()
  RETURNS trigger AS $$
  Declare v_cod_vend integer;
               v_cod_cli integer;
 Begin
     Select max(codvend)+1 into v_cod_vend from vendedor;
     Select max(codcli)+1 into v_cod_cli from cliente;
     If new.tipo = 'c' then 
         Insert into cliente(codcli, nome) values (v_cod_cli, new.nome);
     Else 
          Insert into vendedor (codvend,nome) values (v_cod_vend,new.nome);
     End if;
     Return null;
  END;
  $$ language plpgsql;
  
  -- drop trigger insViewVPessoas on vPessoas; 
  
  Create trigger insViewVPessoas 
     Instead of insert on vPessoas
     for each row
     execute procedure insere_view_vPessoas();

select * from vendedor; 
-- delete from vendedor where codvend > 10; 

select * from cliente; 
select * from vPessoas order by tipo;

insert into vPessoas values('Mercia2','v');
insert into vPessoas values('Catarina2','c');

-- delete from cliente where nome like 'Catarina%'; 

-- Exemplo 5

-- drop table tabclienteaudit; 

create table tabClienteaudit
(atualizacao integer, ultimadata date, quem varchar);
select * from tabClienteaudit;

CREATE OR REPLACE FUNCTION registra_upd_cliente() RETURNS TRIGGER AS $$
  declare qtd_linhas integer; 
Begin
    select count(*) into qtd_linhas from tabClienteaudit;
    if qtd_linhas = 0 then insert into tabclienteAudit values(1,current_date, current_user);
    else Update tabClienteAudit
           Set atualizacao = atualizacao + 1, ultimadata = current_date, quem = current_user;
    end if;
    return null; 
End;
$$ language plpgsql; 

-- drop trigger cliente_audit on cliente; 

CREATE TRIGGER cliente_audit
  AFTER UPDATE ON cliente
    FOR EACH ROW EXECUTE PROCEDURE registra_upd_cliente();

select * from cliente;
update cliente set cidade = 'João Pessoa' Where codcli = 5;
Select * from tabclienteAudit;

SELECT * FROM INFORMATION_SCHEMA.TRIGGERS;

