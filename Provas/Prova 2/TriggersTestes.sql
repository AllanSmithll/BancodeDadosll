create table empaudit
(
	matemp integer not null,
	dataalter varchar not null
);

create or replace function geralogemp()
returns trigger as $$
begin
	insert into empaudit(matemp, dataalter)
	values (new.matricula, current_timestamp);
return new;
end;
$$ language plpgsql;

create or replace trigger logEmptrigger
after insert on empregado for each row
execute procedure geralogemp();

-- alter table empregado disable trigger all;

select * from empregado order by matricula;
select * from empaudit;
insert into empregado values
	(default,'Patrick','Estrela','03-01-2022',
	'Analista de Requisitos',6000,1,2);
	
-- banco Pedidos
select * from itenspedido;

create or replace function verificaItem()
returns trigger as $$
declare quantidade_itens integer;
begin
	select count(*) into STRICT quantidade_itens
	from itensPedido
	where numped = new.numped;
	if quantidade_itens is null then
		raise exception 'Não faz sentido esse pedido!';
	end if;
	return null;
end; $$ language 'plpgsql';

create or replace trigger trigger_controle_estoque
after insert on pedido for each row
execute procedure verificaItem();

select * from itenspedido;
select * from pedido;
insert into pedido values (default,10,current_date,1,1);
insert into pedido values (default,10,current_date,2,1);

-- Banco empregado
select * from empregado;

create or replace function verificaIdade()
returns trigger as $$
declare datanascimento date; idade int;
begin
	if age(new.datanasc) < interval '18 years' then
		raise exception 'Não pode trabalhar menores de 18 anos.';
	end if;
	return new;
end; $$ language 'plpgsql';

create or replace trigger t_verificaIdade
before insert on empregado for each row
execute procedure verificaIdade();

insert into Empregado values (default,'Mario','Oliveira',current_date,'Designer de Interface',4800.00,1,null, current_date);