-- Aula 12 - Funções e procedures armazenadas

select * from pg_language;

select * from artista;  
alter table artista add indicaoscar integer; 
update artista
set indicaoscar = 0; 

Do $$
BEGIN
  UPDATE artista
    SET indicaoscar = 10
    WHERE codart = 100;
  IF NOT FOUND THEN
    INSERT INTO artista (codart, nomeart, indicaoscar) 
    VALUES (100, 'XXX', 10);
  END IF;
END$$;

select * from artista;  

Create or replace function soma(integer, integer) returns integer as ' 
        Select $1+$2;
  ' language SQL; 

select soma(1,1);

-- Exemplo 1

CREATE OR REPLACE FUNCTION InsereCategoria (codigo INTEGER, nome VARCHAR(25)) 
  RETURNS void 
  AS $$ 
     BEGIN
         INSERT INTO categoria VALUES (codigo, nome); 
     END; 
     $$ LANGUAGE 'plpgsql';
	 
Select * from Categoria;
-- delete from categoria where codcateg > 7; 

Select InsereCategoria (10, 'Comédia sátira');
Select * from Categoria;

-- Exemplo 2

CREATE OR REPLACE function mostra_filmes (v_categoria IN categoria.desccateg%type)
 returns void
 as $$
    declare 
       vfilme cursor (v_categoria categoria.desccateg%type) for 
           select titulo, ano
           from filme f join categoria c on f.codcateg = c.codcateg
           where desccateg = v_categoria;
 BEGIN
    FOR v_f IN vfilme(v_categoria) LOOP
       raise notice 'Título = %',v_f.titulo;
        raise notice 'Ano = %',v_f.ano; 
   END LOOP;
 END;
 $$ LANGUAGE 'plpgsql';

select titulo from filme; 
select * from categoria; 

Select mostra_filmes('Ação'); 

-- Exemplo 3

Create or replace function contafilme (
   cat IN categoria.desccateg%type)
   RETURNS integer as $$
    declare totalfilme integer;
   Begin
     Select count(*) into totalfilme
     from filme f join categoria c on f.codcateg = c.codcateg
     Where desccateg = cat;
     Return totalfilme;    
   End;
$$ LANGUAGE 'plpgsql';

Select contafilme('Ação'); 

-- Exemplo 4

Create or replace function DolarToReal
(dolar in numeric, cotacao numeric)
Returns numeric
As $$ 
  Begin
       Return dolar *cotacao;
  End;
  $$ LANGUAGE 'plpgsql';
  
 Do $$ declare v numeric;
     begin
         v:= DolarToReal(100, 4.71);
         raise notice 'Valor em Real: %',v;
    End$$;

Do $$ declare v numeric;
     begin
         v:= DolarToReal(100, 5.18);
         raise notice 'Valor em Real: %',v;
    End$$;

select * from artista;
select * from personagem; 

-- Exemplo 5
CREATE OR REPLACE PROCEDURE mostraNumFilmes(nome varchar(25))
LANGUAGE plpgsql
AS $$
DECLARE
contador integer := 0;
BEGIN
  Select count(*) INTO contador 
  From artista a join personagem p on a.codart = p.codart
  Where a.nomeart = nome;
  RAISE NOTICE '% Fez % filmes', nome, contador;
END $$;

CALL mostraNumFilmes('Joaquin Phoenix');
Call mostraNumFilmes('Cameron Diaz');