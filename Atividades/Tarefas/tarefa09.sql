-- Tarefa 9 sobre Triggers e Functions - 16/05/2023
-- Questão 1
Create or Replace Function trocaNome()
Returns trigger as $$
declare msg varchar(40);
Begin
  msg = 'Nome '||old.nomeart|| ' mudou para '||new.nomeart;
  raise notice 'Foi feito: %',msg;
  return null;
End;
$$ LANGUAGE plpgsql; 
 
CREATE TRIGGER veNome AFTER UPDATE
  of nomeart ON Artista
  FOR EACH ROW
  EXECUTE PROCEDURE trocaNome();
 
select * from artista;
 
update artista
set nomeart = 'TROCA'
where nomeart = 'Brad Pitt';
update artista
set nomeart = 'Brad Pitt'
where nomeart = 'TROCA';

-- Questão 2
create table FILMELOG (
    usuario varchar(20),
    operacao char(1),
    dataHora timestamp
);

create or replace function filmeLog()
returns trigger as $$
begin
    insert into FILMELOG values (current_user, substr(tg_op,1,1), now());
    return new;
end;
$$ LANGUAGE plpgsql;

create or replace trigger logFilmeTrigger
after update or delete or insert on filme for each row
execute procedure filmeLog();

select * from filmelog;
select * from filme;
select * from categoria;
select * from estudio;
insert into filme values(default, 'Superman', 2021, 200, 1, 3);

-- Questão 3
create or replace view filmeCateg
as select f.titulo, c.desccateg
    from filme f 
    inner join categoria c 
    on f.codcateg = c.codcateg;

select * from filmeCateg;

-- Questão 4
select * from artista;
create or replace function insereFilmeDaView() 
returns trigger as $$
declare 
    vCodFilme integer; 
    vCodCateg integer;
begin
	begin
		select max(codfilme)+1 into vCodFilme from filme;
    	select codcateg into strict vCodCateg from categoria where desccateg = new.desccateg;
    	insert into filme (codfilme, titulo, codcateg) values (vCodFilme, new.titulo, vCodCateg);
		return new;
	end;
    EXCEPTION
        when no_data_found then
			select max(codcateg)+1 into vCodCateg from categoria;
        	insert into categoria(codcateg,desccateg) values (vCodCateg, new.desccateg);
    		insert into filme (codfilme, titulo, codcateg) values (vCodFilme, new.titulo, vCodCateg);
    		return new;
end;
$$ language plpgsql;

create or replace trigger insereFilmeTrigger
instead of insert on filmeCateg for each row
execute procedure insereFilmeDaView();

-- Teste com inserts
insert into filmeCateg values ('Pé de Feijão', 'Vida Escolar');
insert into filmeCateg values ('Justiceiro', 'Terror');
insert into filmeCateg values ('PJ Masks', 'Infantil');
select * from filme;
select * from categoria;
select * from filmeCateg;

-- Questão 5
select * from filme;
alter table filme drop constraint IF EXISTS fkfilme2estud;

-- Ação importante
-- UPDATE filme SET codest=null WHERE codest NOT IN (SELECT codest FROM estudio);

CREATE OR REPLACE FUNCTION atualizaConstraintFilmes()
RETURNS TRIGGER AS $$
BEGIN
    update Filme set codest=new.codest where codest=old.codest;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- DROP function atualizaConstraintFilmes() cascade;
/*
Estrutura importante que é a base dessa function
  ALTER TABLE filme
        ADD CONSTRAINT fkfilme2estud
        FOREIGN KEY (codestud) REFERENCES estudio ON UPDATE CASCADE;
*/

create or replace trigger TriggerAtualizaConstraintFilmes
after update on estudio for each row
execute function atualizaConstraintFilmes();
-- drop trigger TriggerAtualizaConstraintFilmes on estudio;

select * from estudio;
select * from filme;
update estudio set codest=8 where codest=6;
update estudio set codest=6 where codest=8;
alter table filme add constraint fkfilme2estud
	foreign key (codest) references estudio(codest) on delete cascade;

-- Questão 6
select * from artista;
create or replace function idadeArtista(
    codigoArtista artista.codart%type
) returns varchar(30) as $$
declare 
	vcodArt integer;
	vDataNasc date;
	vIdadeArtista int;
	c_cursor cursor for (select * from artista);
begin
	for artista in c_cursor loop
		if artista.codart = codigoArtista then
			vcodArt= artista.codart;
			vDataNasc = artista.datanasc;
			vIdadeArtista = extract(year from (age(vDataNasc)));
			raise notice 'O artista de código % tem % anos.', vcodArt, vIdadeArtista;
			return vIdadeArtista;
		elsif NOT FOUND then
			return 'Nenhum artista com esse código encontrado.';
		end if;
	end loop;
end; $$ language 'plpgsql';

select * from artista;
select idadeArtista(8);