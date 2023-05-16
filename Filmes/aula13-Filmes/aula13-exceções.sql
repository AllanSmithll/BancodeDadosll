-- Aula 13 - Funções e exceções

Create or replace function verificaArt(codigo integer)
Returns varchar
As $$ 
Declare nome varchar(25);
Begin
   select nomeart into nome from artista
       where codart = codigo;
    IF NOT FOUND THEN
        Return 'Nenhum artista com esse código foi encontrado.';
    END IF;
    return nome; 
End;
 $$ LANGUAGE 'plpgsql';
 
 Select verificaart(1);           
select verificaart(111); 

create or replace function verificaart2(integer) 
returns varchar 
 As $$ 
  Declare r record;
  begin
    select into r * from artista where codart = $1;
    if not found then RAISE EXCEPTION 'Artista não existente--> %', $1
         USING HINT = 'Por favor, verifique o código do artista';
    end if;
    return r.nomeart;
  End; $$ LANGUAGE 'plpgsql';
  
  select verificaart2(1); 
select verificaart2(111);

CREATE OR REPLACE FUNCTION testains(cod integer,nome varchar(25))
RETURNS integer AS $$
BEGIN
  Insert into estudio(codest,nomeest) values (cod,nome);
  Return 1;
  EXCEPTION 
    WHEN unique_violation THEN
      raise notice 'Já existe esse registro';
      return -1;
    WHEN OTHERS THEN
          -- fazer algo 
      RETURN -1;    
END;
$$ LANGUAGE plpgsql;

select * from estudio;
-- delete from estudio where codest > 3; 

select testains(4,'Teste'); 

select testains(5,'Teste'); 

-- Exemplo

-- drop table logcontagem; 
create table 
logcontagem 
(id serial, info varchar(40));

-- truncate table logcontagem; 

select * from logcontagem; 
select * from artista;

CREATE OR REPLACE FUNCTION testaContagem(limite integer, vpais artista.pais%type) 
RETURNS void AS $$
Declare 
  contagem integer;
  info2 varchar(40);
BEGIN
   SELECT count(*) into contagem from artista where pais = vpais;
   If contagem >= limite Then 
     RAISE exception 'Atingiu o limite';
  End If;
EXCEPTION
  WHEN raise_exception THEN
     info2 = 'Artistas de ' || vpais ||' possuem ' || contagem;
     INSERT INTO logcontagem (id, info) VALUES (default, info2);
END;
$$ LANGUAGE plpgsql; 

select testaContagem(9,'Brasil');
select * from logcontagem;  
--truncate table logcontagem; 

select * from artista where pais = 'USA'; 
update artista set pais = 'Brasil' where codart in (1,2,3,4); 

update artista set pais = 'USA' where pais is null; 
insert into artista values(default,'Rosamund Pike',null,'USA', '27/01/1979');

-- Exemplo

Create or replace function insereArttop(
   cod IN top.codart%type, 
   nome IN top.nomeart%type,
   cache1 IN top.cache%type) 
RETURNS void
 AS $$
begin
  insert into top values (cod, nome,cache1);
end;
$$ LANGUAGE plpgsql; 

create or replace function insere_artista_top (vcod  artista.codart%type, vnome artista.nomeart%type,
   nota numeric)
  Returns varchar as $$
    Declare max_top integer;
       varttop integer;
 Begin
    max_top = 6;
    select count(*) into varttop from top;
      if varttop >= max_top then 
       raise exception 'top esgotada';
    elsif nota > 7 then 
          perform insereArttop(vcod,vnome,null);
          return 'Inclusão em Top com êxito!';
        else 
          return 'Inclusão impossível';
    end if;
   Exception
     When raise_exception THEN
       return 'Top Esgotada'; 
     when others then
       return 'Erro desconhecido';
End;
$$ LANGUAGE plpgsql; 

select * from top;
delete from top where cache is null; 

select insere_artista_top (25,'Teste',9); 
Select insere_artista_top(21,'Teste',6); 