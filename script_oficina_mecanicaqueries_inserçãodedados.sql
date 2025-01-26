-- inserção de dados e querys no esquema Oficina Mecânica

use Oficina_Mecânica;


-- Inserir dados na tabela cliente
INSERT INTO cliente (Pnamo, Unome, CPF_ou_CNPJ, rua, bairro, número, complemento, cidade, CEP)
VALUES
('João', 'Silva', '12345678901', 'Rua A', 'Bairro Centro', 123, 'Apto 1', 'São Paulo', '12345-678'),
('Maria', 'Oliveira', '23456789012', 'Rua B', 'Bairro Sul', 456, 'Casa', 'Rio de Janeiro', '23456-789'),
('Carlos', 'Pereira', '34567890123', 'Rua C', 'Bairro Norte', 789, 'Sala 10', 'Belo Horizonte', '34567-890'),
('Ana', 'Costa', '45678901234', 'Rua D', 'Bairro Leste', 101, 'Cobertura', 'Curitiba', '45678-901'),
('Lucas', 'Ferreira', '56789012345', 'Rua E', 'Bairro Oeste', 202, 'Apto 5', 'Porto Alegre', '56789-012');

-- Inserir dados na tabela Veiculos
INSERT INTO Veiculos (idVCliente, caminhão, modelo, marca, ano_fabricação)
VALUES
(1, 'Sim', 'Caminhão X', 'Marca A', '2015-01-01'),
(2, default, 'Carro Y', 'Marca B', '2018-05-20'),
(3, 'Não', 'Moto Z', 'Marca C', '2020-10-10'),
(4, 'Sim', 'Caminhão W', 'Marca D', '2012-03-15'),
(5, default, 'SUV Q', 'Marca E', '2021-07-25');

-- Inserir dados na tabela Mecânicos
INSERT INTO Mecânicos (Pnamo, Unome, CPF, rua, bairro, número, complemento, cidade, especialidade)
VALUES
('Pedro', 'Almeida', '98765432100', 'Rua F', 'Bairro Centro', 111, 'Sala 1', 'São Paulo', 'Motor'),
('Juliana', 'Lima', '87654321099', 'Rua G', 'Bairro Norte', 222, 'Casa', 'Rio de Janeiro', 'Suspensão'),
('Renato', 'Santos', '76543210988', 'Rua H', 'Bairro Sul', 333, 'Apto 2', 'Belo Horizonte', 'Freios'),
('Carla', 'Souza', '65432109877', 'Rua I', 'Bairro Leste', 444, 'Cobertura', 'Curitiba', 'Elétrica'),
('Eduardo', 'Mendes', '54321098766', 'Rua J', 'Bairro Oeste', 555, 'Sala 3', 'Porto Alegre', 'Ar-condicionado');

-- Inserir dados na tabela Equipe_mecânica
INSERT INTO Equipe_mecânica (idMecânico)
VALUES
(1), (2), (3), (4), (5);

-- Inserir dados na tabela Peçasvalores
INSERT INTO Peçasvalores (valordapeça, modelodapeça, fabricante)
VALUES
(100.00, 'Peça A', 'Fabricante X'),
(200.00, 'Peça B', 'Fabricante Y'),
(300.00, 'Peça C', 'Fabricante Z'),
(400.00, 'Peça D', 'Fabricante W'),
(500.00, 'Peça E', 'Fabricante Q');

-- Inserir dados na tabela Mão_de_Obra
INSERT INTO Mão_de_Obra (tipodaMobra, valordaMObra, especialidade)
VALUES
('Troca de óleo', 50.00, 'Motor'),
('Troca de pneus', 100.00, 'Suspensão'),
('Troca de freios', 150.00, 'Freios'),
('Reparo elétrico', 200.00, 'Elétrica'),
('Manutenção do ar', 250.00, 'Ar-condicionado');

-- Inserir dados na tabela Ordem_Serviço
INSERT INTO Ordem_Serviço (idCliente, autorização_do_cliente, idEquipemecânica, statusdaordem, data_da_entrega, data_de_emissão, descrição_do_serviço, valor_final, valordaMobra, valordapeça, idPeça, idMobra)
VALUES
(1, default, 1, 'Em processamento', '2025-02-01', '2025-01-20', 'Troca de óleo e revisão geral', 150.00, 50.00, 100.00, 1, 1),
(2, 'Autorizado', 2, 'Em processamento', '2025-02-05', '2025-01-22', 'Troca de pneus', 300.00, 100.00, 200.00, 2, 2),
(3, 'Não autorizado', 3, 'Cancelada', NULL, '2025-01-25', 'Reparo de freios', 0.00, NULL, NULL, NULL, NULL),
(4, default, 4, 'Finalizado', '2025-01-30', '2025-01-15', 'Reparo elétrico', 600.00, 200.00, 400.00, 4, 4),
(5, 'Autorizado', 5, 'Em processamento', '2025-02-03', '2025-01-18', 'Manutenção do ar-condicionado', 750.00, 250.00, 500.00, 5, 5);

-- Inserir dados na tabela VerificaçãoServiço
INSERT INTO VerificaçãoServiço (idEquipemecânica, idVeiculo, tipo_de_serviço)
VALUES
(1, 1, 'Troca de óleo'),
(2, 2, 'Troca de pneus'),
(3, 3, 'Troca de freios'),
(4, 4, 'Reparo elétrico'),
(5, 5, 'Manutenção do ar-condicionado');


-- Perguntas respondidas com querys
show tables;

-- 1) Quantas peças diferentes estão cadastradas na tabela Peçasvalores e qual é o valor médio das peças?

select * from peçasvalores;

select count(*) idPeça , avg(valordapeça) as valor_médio_das_peças
from peçasvalores;
 
 
 -- 2) Quais equipes mecânicas realizaram serviços com valor final acima de R$500,00? Mostre o ID da equipe e o valor final.
 
 select * from ordem_serviço;
 
 select idEquipemecânica, valor_final
 from ordem_serviço
 where valor_final >500;
 
 -- 3) a parti da pergunta anterior, mostre o que se pediu anteriormente, porém com quais mecânicos participaram de cada serviço
 
 select * from equipe_mecânica;
 
 select o.idEquipemecânica, o.valor_final, e.idMecânico
 from ordem_serviço o join equipe_mecânica e
 on  o.idEquipemecânica = e.idEquipeM
 where o.valor_final >500;
 
 
 -- 4) me diga o status da ordem de seriço e a quantidade de ordem para cada status
 
 select * from ordem_serviço;
 
 select statusdaordem , count(*) as total_de_ordem_com_esse_status
 from ordem_serviço
 group by statusdaordem
 order by total_de_ordem_com_esse_status;
 
  -- 4) me mostre o id do cliente que autorizaram o serviço, o veiculo dele e a descrição do serviço
  
  select * from veiculos;
  select * from ordem_serviço;
  
 select o.idCliente, o. descrição_do_serviço, v. modelo
 from ordem_serviço o join veiculos v
 on  o.idCliente = v. idVcliente
 where o.autorização_do_cliente = 'Autorizado';
 
 
 -- 5)me mostre qual MODELO DE veículos foram atendidos, incluindo o tipo de serviço realizado e a descrição do serviço na ordem correspondente
select * from veiculos;
select * from ordem_serviço;
select * from verificaçãoserviço;


select  v. modelo, vs. tipo_de_serviço, o. descrição_do_serviço
from veiculos v join verificaçãoserviço vs
on v. idVeiculo = vs.idVeiculo 
join ordem_serviço o
on v.idVCliente = o.idCliente;


