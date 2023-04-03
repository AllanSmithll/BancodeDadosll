-- Cliente
insert into cliente values(default,'Claudia Dias',null,null, '564325','786534','Recife','PE');
insert into cliente values(default,'Joaquim Moraes','Epitacio Pessoa, 123','32425643', '500925','789004','Joao Pessoa','PB');
insert into cliente values(default,'Janaina Rodrigues','Rui Carneiro, 342',null, '764325','386534','Joao Pessoa','PB');
insert into cliente values(default,'Maria Portela','Boa Viagem, 345','76435678', null,null,'Recife','PE');
insert into cliente values(default,'Ana Moura','Nego, 321','32465432', '87325','780978','Joao Pessoa','PB');
insert into cliente values(default,'Cassandra Doura',null,null, '786525','79876','Recife','PE');
insert into cliente values(default,'Cicero Novaes',null,null, '123525','432534','Natal','RN');
insert into cliente values(default,'Marcos Araruna','Sergipe,267','43265432', '900325','800534','Joao Pessoa','PB');

-- Vendedor
insert into vendedor values(default,'Juan Gomes', '28/07/1978', 2300.80,'C');
insert into vendedor values(default,'Joao Peregrino', '20/05/1970', 3300.80,'B');
insert into vendedor values(default,'Carla Gomes', '12/02/1984', 5300.80,'A');
insert into vendedor values(default,'Josefa Cirino', '23/08/1990', 2300.80,'C');
insert into vendedor values(default,'Ariane Dutra', '28/09/1993', 3300.80,'B');

-- Produto
insert into produto values(default,'Queijo', 22.00, 'KG');
insert into produto values(default,'Chocolate', 6.12, 'G');
insert into produto values(default,'Leite', 10.00, 'L');
insert into produto values(default,'Linho', 24.00, 'M');
insert into produto values(default,'Feijao', 12.00, 'KG');
insert into produto values(default,'Açucar', 9.00, 'KG');

-- Pedido
insert into pedido values(default,23, '12/09/2019', 1,1);
insert into pedido values(default,10, '21/09/2020', 2,1);
insert into pedido values(default,5, '25/08/2020', 3,4);
insert into pedido values(default,2, '28/07/2020', 4,2);
insert into pedido values(default,3, '28/09/2020', 5,3);
insert into pedido values(default,3, '26/10/2020', 5,2);

-- ItensPedido
insert into itenspedido values(2,2, 35);
insert into itenspedido values(2,3, 30);
insert into itenspedido values(1,1, 10);
insert into itenspedido values(4,5, 35);
insert into itenspedido values(5,4, 10);
insert into itenspedido values(3,4, 35);
insert into itenspedido values(1,5, 10);