-- Aula 13

-- Exemplo 01

CREATE OR REPLACE FUNCTION retornaInfoProd(v_cod in produto.codprod%type) 
RETURNS varchar AS $$
Declare
       V_nome produto.descricao%type;
       V_preco produto.valor%type;
       Msg varchar(30);
Begin
     Select descricao, valor into strict v_nome, v_preco From produto 
     Where codprod = v_cod;
     select v_nome || '--'|| v_preco into msg;
     return msg;
     Exception
          When No_data_found then
                msg = 'Nenhum produto encontrado';
                Return msg;
         When others then
		   Return 'Erro desconhecido ';
End;
$$ LANGUAGE plpgsql; 

Select * from produto order by codprod; 
Select retornaInfoProd(2);
Select retornaInfoprod(30);


