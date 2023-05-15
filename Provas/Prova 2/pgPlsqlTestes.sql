-- Testes com o conteúdo introdutório de pgplsql
select * from cliente;

do $$
declare nomeVar varchar;
Begin
	select nome into strict nomeVar
	from cliente
	where codcli = 2;
raise notice 'Nome = %', nomeVar;
Exception
	when no_data_found then
		raise notice 'Nenhum cliente com essa matrícula encontrado';
end$$;

-- Criar testabloco
create table testa_bloco (coluna1 integer, coluna2 date);
select * from testa_bloco;

-- While test
do $$
declare
	I int := 0;
begin
	while I <= 10 loop
		insert into testa_bloco(coluna1, coluna2)
		values (I, current_date);
	I := I + 1;
	END LOOP;
END$$;
select * from testa_bloco;

-- atualiza_status_estoque
/*
alter table produto add status varchar(40);
alter table produto add quantest integer;
update produto set quantest = 45 where codprod = 1;
*/
select * from produto order by codprod;
do $$
declare
	qtd_atual produto.quantest%type;
begin
	select quantest into qtd_atual from produto;
	if qtd_atual > 30 then
		update produto
		set status = 'Estoque dentro do esperado'
		where codprod = 1;
	else
		update produto
		set status = 'Estoque fora do limite
		minimo'
		where codprod = 1;
	end if;
End$$;

-- Com Rowtype
SELECT * FROM Vendedor;
do $$
declare
	v_vendedor vendedor%ROWTYPE;
begin
	select codvend, nome into v_vendedor
	from vendedor
	where codvend = 10;
	raise notice 'Vendedor selecionado: %', v_vendedor.nome;
	if not found then
		raise exception 'Código de vendedor não possui registro';
	end if;
END$$;

-- Da Tarefa 7
select * from testa_bloco;
truncate testa_bloco;
Do $$
 DECLARE
   I INT := 1;
 BEGIN
     WHILE I <= 10 LOOP
	 	IF mod(i, 3)=0 THEN
			 INSERT INTO TESTA_BLOCO(coluna1,coluna2)
          VALUES (I,current_date);
		End if;
		I:= I+1;
	End loop;
End$$;
select * from testa_bloco;

-- Exemplo 5 da tarefa 7 para estudar
select * from vendedor;
do $$
declare
	v_codvend vendedor.codvend%type;
	v_nomevend vendedor.nome%type;
	v_salariofixo vendedor.salariofixo%type;
	c_vend cursor for 
		select codvend, nome, salariofixo from vendedor;
begin
	for v_vend in c_vend loop
		v_codvend := v_vend.codvend;
		v_nomevend := v_vend.nome;
		v_salariofixo := v_vend.salariofixo;
		raise notice 'Vendedor: %, %, %', v_codvend, v_nomevend, v_salariofixo;
	end loop;
end$$;