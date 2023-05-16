-- Tafera 8 - Funções Armazenadas
-- Questão 1
-- Código original
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
End$$

-- Resposta
create or replace function atualizaStatus(codigo produto.codprod%type) 
    returns void
    as $$
        Declare qtd_atual produto.quantest%type; 
        Begin 
         select quantest into qtd_atual from produto 
         where codprod = codigo; 
         if qtd_atual > 30 then 
         update produto 
         set status = 'Estoque dentro do esperado' 
         where codprod = codigo; 
         else 
         update produto 
         set status = 'Estoque fora do limite minimo' 
         where codprod = codigo; 
         end if; 
        End
        $$ LANGUAGE 'plpgsql';
        
select * from produto; 
        update produto set status = null where codprod = 10;  
        select atualizastatus(2);

-- Questão 2
create or replace function getSumSalario()  
returns numeric 
as $$  
 Declare 
 salcomp numeric; 
 v record; 
 Begin 
 Salcomp = 0; 
 for v in (select salariofixo from vendedor where salariofixo is not null)   loop
 salcomp = salcomp + v.salariofixo; 
 end loop; 
 return salcomp; 
end; 
$$ LANGUAGE 'plpgsql'; 
select getSumsalario(); 

-- Questão 2.1
create or replace function getSumSalario2()  
returns numeric 
as $$  
 Declare 
 salcomp numeric; 
 v record; 
 Begin 
 select sum(salariofixo) from vendedor where salariofixo is not null into salcomp; 
 return salcomp; 
end; 
$$ LANGUAGE 'plpgsql'; 
select getSumsalario();

-- Questão 3
--drop table fornecedor;
create table fornecedor
(
 codigo serial not null primary key,
 nome varchar(30), 
 cnpj varchar(15),
 email varchar(15)
);
create or replace function inserirFornecedor(
	nome fornecedor.nome%type,
	cnpj fornecedor.cnpj%type,
	email fornecedor.email%type)
returns void
AS $$ Declare
	begin
		insert into fornecedor values(default, nome, cnpj, email);
	end;
	$$ LANGUAGE 'plpgsql';

select * from fornecedor;
select inserirFornecedor('Jonatas Peixe', '111111111', 'naowa@jsoso');
select inserirFornecedor('Jonatas da Carne', '111111112', 'naowa@jsdeso');
select inserirFornecedor('Jonatas do Leite', '111111113', 'aodswwa@jsoso');
--truncate fornecedor;

-- Questão 4
create or replace function showFornecedor()
returns void
as $$ declare
	f_cod fornecedor.codigo%type;
	f_nome fornecedor.nome%type;
	f_email fornecedor.email%type;
	f_cursor Cursor for
		select codigo, nome, email 
		from fornecedor;
begin
	for f_linha in f_cursor loop
		f_cod:=f_linha.codigo;
		f_nome:=f_linha.nome;
		f_email:=f_linha.email;
		raise notice 'Dados do Fornecedor: %, %, %', f_cod, f_nome, f_email;
	end loop;
	end;
	$$ LANGUAGE 'plpgsql';

select * from fornecedor;
select showFornecedor();