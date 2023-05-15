-- TAREFA 7 - Blocos Anônimos
-- Questão 1
DO $$
Declare
  nomeCli varchar(40);
  qtdelinhas integer;
BEGIN
        	select nome into nomeCli from cliente where codcli = 2;
        	GET DIAGNOSTICS qtdelinhas := ROW_COUNT;
        	raise notice 'Nome cliente = %', nomeCli;
        	raise notice 'Quantidade de registros retornados = %',qtdelinhas;
END$$;

-- Questão 2
DO $$
DECLARE
  clireg cliente%ROWTYPE;
  info varchar(50);
BEGIN
        	clireg.codcli := 13;
        	clireg.nome := 'Ariane Botelho';
        	clireg.cidade  := 'Campina Grande';
        	Select clireg.nome || ' trabalha em '||clireg.cidade into info;
        	raise notice 'Informação = %', info;
END$$;

-- Questão 3
-- drop table testa_bloco; 
create table testa_bloco (coluna1 integer, coluna2 date);
select * from testa_bloco; 
/* Código original
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
*/
-- Resposta
Código original
Do $$
 DECLARE
   I INT := 0;
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

-- Questão 4
/* Código original
Do $$ Declare 
    qtd_atual produto.quantest%type;
    v_cod produto.codprod%type;
    p_cursor_prod cursor for
              select codprod,quantest from produto;
 Begin
   open p_cursor_prod;
   loop
      fetch p_cursor_prod into v_cod,qtd_atual;
      if qtd_atual > 30 then
         update produto
         set status = 'Estoque dentro do esperado'
         where codprod = v_cod;
      else update produto
             set status = 'Estoque fora do limite mínimo'
             where codprod = v_cod;
      end if;
    exit when not found;
   end loop;
 close p_cursor_prod;
 End$$;
 */
-- Resposta
Do $$ 
Declare 
    qtd_atual produto.quantest%type;
    v_cod produto.codprod%type;
    p_cursor_prod cursor for
              select codprod,quantest from produto;
 Begin
   for prod in p_cursor_prod loop
      if qtd_atual > 30 then
         update produto
         set status = 'Estoque dentro do esperado'
         where codprod = v_cod;
      else update produto
             set status = 'Estoque fora do limite mínimo'
             where codprod = v_cod;
      end if;
   end loop;
 End$$;
select * from produto;

-- Questão 5
Do $$
Declare
	cods_v vendedor.codvend%type;
	nome_v vendedor.nome%type;
	salar_v vendedor.salariofixo%type;
	v_cursor cursor for
		select codvend, nome, salariofixo
		from vendedor order by codvend;
begin
	for vend in v_cursor loop -- Os registros de vendedor passa a se chamar "vend"
		cods_v:=vend.codvend;
		nome_v:=vend.nome;
		salar_v:=vend.salariofixo;
		raise notice 'Código=%; Nome=%; Salário=%', cods_v, nome_v, salar_v;
	end loop;
end$$;

-- Versão que fiz estudando para a prova
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