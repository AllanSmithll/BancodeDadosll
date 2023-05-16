-- Tarefa 9 sobre Triggers e Functions - 15/05/2023
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

-- Questão 6
create or replace function idadeArtista(
    codigoArtista artista.codart%type
) returns varchar(30) as $$
