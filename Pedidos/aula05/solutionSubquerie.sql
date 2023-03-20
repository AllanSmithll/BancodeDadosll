-- Solução para a subconsulta do slides 5 - Subqueries

Select p.data
from pedido p 
	join itenspedido i 
	on p.numped = i.numped
	join produto produ
	on produ.codprod = i.codprod
where descricao like 'Chocolate';

-- Original:

Select p.data


from pedido p


where p.numped in


             (select i.numped


              from itenspedido i


              where i.codprod in


                        (select pr.codprod


                         from produto pr


                         where descricao like 'Chocolate'))