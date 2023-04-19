-- Aula 10 - Introdução ao pgplsql

CREATE OR REPLACE FUNCTION incrementa(i integer) 
   RETURNS integer AS $$
   BEGIN
     RETURN i + 1;
   END;
$$ LANGUAGE plpgsql;

select incrementa(2);

-- Exemplo 1

select * from cliente order by codcli; 

DO $$ 
Declare nomeVar varchar(40);
Begin
   select nome into strict nomeVar
     from cliente
     where codcli = 2;
   raise notice 'Nome = %', nomeVar;
   Exception
        When no_data_found then
             raise notice 'Nenhum cliente com essa matrícula foi encontrado';
End$$;

-- Exemplo 2
-- drop table testa_bloco; 

create table testa_bloco (coluna1 integer, coluna2 date);
select * from testa_bloco; 

Do $$
 DECLARE
   I INT := 0;
 BEGIN
     WHILE I <= 10 LOOP
        INSERT INTO TESTA_BLOCO(coluna1,coluna2)
          VALUES (I,current_date);
        I := I + 1;
     END LOOP;
END$$;

select * from testa_bloco; 

-- Exemplo 3
select * from produto; 

Alter table produto add status varchar(40);
Alter table produto add quantest integer; 
Update produto
Set quantest = 45 
Where codprod = 1; 

Select * from produto order by codprod; 

Do $$ 
Declare qtd_atual produto.quantest%type;
Begin
  select quantest into qtd_atual from produto
  where codprod = 1;
  if qtd_atual > 30 then
     update produto
      set status = 'Estoque dentro do esperado'
      where codprod = 1;
  else
    update produto
      set status = 'Estoque fora do limite minimo'
      where codprod = 1;
  end if;
End$$;

 select codprod, descricao, status, quantest 
 from produto; 

-- Exemplo 4

select * from vendedor; 

DO $$ 
  DECLARE
    v_vendedor  vendedor%ROWTYPE;
Begin
    SELECT codvend, nome INTO v_vendedor
    FROM vendedor
    WHERE codvend = 2;
    raise notice 'Vendedor selecionado = %',v_vendedor.nome;
End$$;

