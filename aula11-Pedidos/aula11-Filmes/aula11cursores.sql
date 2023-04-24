-- Aula 11 - Cursores 

select nomeart, cidade
from artista
where codart = 1;


select nomeart, cidade
from artista
where pais = 'USA';

-- Exemplo de uso de cursor

DO $$ 
   Declare
   	vdesc categoria.desccateg%type;
  	vcursor_categ CURSOR for 
          Select desccateg from categoria;
Begin
  Open vcursor_categ;
  LOOP
    fetch vcursor_categ into vdesc;
    EXIT when NOT FOUND;
    raise notice 'Nome Categoria = %', vdesc;          
  END LOOP;
  Close vcursor_categ;
End$$;

-- Exemplo com raise notice

DO $$ 
   Declare
   	vdesc categoria.desccateg%type;
	vcod categoria.codcateg%type;
  	vcursor_categ CURSOR for 
          Select * from categoria;
Begin
  Open vcursor_categ;
  LOOP
    fetch vcursor_categ into vcod,vdesc;
    EXIT when NOT FOUND;
    raise notice 'Nome Categoria é % e o código é %', vdesc, vcod;          
  END LOOP;
  Close vcursor_categ;
End$$;



--Exemplo de uso de cursor com FOR
DO $$ 
   Declare
   	vdesc categoria.desccateg%type;
  	        vcursor_categ CURSOR for 
                  Select desccateg from categoria;
Begin
For vcat IN vcursor_categ LOOP
        vdesc := vcat.desccateg;
             raise notice 'Nome Categoria = %', vdesc;          
     END LOOP;
End$$;

-- Exemplo de uso de cursor com parâmetro
DO $$ 
 Declare
   localpais artista.pais%TYPE; -- Tipo do campo que está sendo usado
   c_artista Cursor (v_pais artista.pais%TYPE) for
       Select  *  From artista where pais = v_pais;
Begin
     localpais := 'Brasil'; 
     raise notice 'País = %', localpais; 
     For vart IN c_artista(localpais) LOOP
           raise notice 'Nome do Artista = %', vart.nomeart; 
End Loop;
End$$;

select * from artista where pais = 'Brasil';
select * from artista;
select * from personagem;


-- Exemplo de uso de cursor com tabela TOP
-- drop table top; 

create table top as select a.codart, nomeart, cache
    from artista a join personagem p on a.codart = p.codart where 1 = 2;
	
-- truncate table top; 
select * from top; 

DO $$ 
declare
  regart public.top%ROWTYPE; -- Tipo linha, que é o registro completo
Begin
  For regart IN (Select distinct a.codart, nomeart, cache
                          FROM artista a join personagem p
                                      on a.codart = p.codart
                          WHERE cache > 7000) LOOP
       Insert into top values 
             (regart.codart,regart.nomeart, regart.cache);
   End loop; 
End$$;

Select * from top order by codart;
