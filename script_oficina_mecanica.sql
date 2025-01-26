
-- criação do esquema do modelo conceitual ofinica-mecanica
-- drop database Oficina_Mecânica;
create database Oficina_Mecânica;
use Oficina_Mecânica;

-- criar tabela cliente

create table cliente(
idCliente int auto_increment primary key,
Pnamo varchar(10),
Unome varchar(20),
CPF_ou_CNPJ char (15) not null, 
constraint unique_cpf_client unique(CPF_ou_CNPJ),
rua varchar(20) not null,
bairro varchar (20) not null,
número int not null,
complemento varchar(20) not null,
cidade varchar(20),
CEP char(10) not null
);

-- criar tabela veiculos
create table Veiculos ( 
idVeiculo int auto_increment primary key,
idVCliente int,
caminhão enum ('Sim', 'Não') default 'Não',
modelo varchar (20) not null,
marca varchar (20) not null, 
ano_fabricação date not null,
constraint fk_veiculo_do_cliente foreign key (idVCliente) references cliente (idCliente)
);

--  criar tabela mecânicos
create table Mecânicos(
idMecânico int auto_increment primary key,
Pnamo varchar(10),
Unome varchar(20),
CPF char (11) not null,
constraint unique_cpf_mecânico unique(CPF),
rua varchar(20) not null,
bairro varchar (20) not null,
número int not null,
complemento varchar(20) not null,
cidade varchar(20),
especialidade varchar(30) not null
);


--  criar equipe mêcanicos
create table Equipe_mecânica(
idEquipeM int auto_increment primary key,
idMecânico int,
constraint fk_mêcanico_equipe foreign key (idMecânico) references Mecânicos (idMecânico)
);


-- criar tabela valores de peças

create table Peçasvalores( 
idPeça int auto_increment,
valordapeça float not null,
modelodapeça varchar(20) not null,
fabricante varchar (20) not null,
primary key (idPeça ,valordapeça)
);


-- criar tabela mão de obra

create table Mão_de_Obra(
idMãodeObra int auto_increment,
tipodaMobra varchar (20) not null,
valordaMObra float not null,
especialidade varchar (20) not null,
primary key (idMãodeObra ,valordaMObra)
);

-- criar tabela orderm de serviço

create table Ordem_Serviço ( 
idOrdem_Serviço int auto_increment primary key,
idCliente int,
autorização_do_cliente enum('Autorizado' , 'Não autorizado') default 'Autorizado',
idEquipemecânica int,
statusdaordem enum ('Em processamento' , 'finalizado', 'cancelada') default 'Em processamento',
data_da_entrega date,
data_de_emissão date not null,
descrição_do_serviço varchar(255) not null,
valor_final float not null,
valordaMobra float,
valordapeça float,
idPeça int, 
idMobra int,
constraint fk_ordem_cliente foreign key(idCliente) references cliente (idCliente),
constraint fk_ordem_equipeM foreign key (idEquipemecânica) references Equipe_mecânica(idEquipeM),
constraint fk_ordem_peça foreign key (idPeça, valordapeça) references Peçasvalores ( idPeça, valordapeça),
constraint fk_ordem_Mobra foreign key (idMobra, valordaMobra) references Mão_de_Obra ( idMãodeObra ,valordaMObra)
);

-- criar tabela verificação do serviço

create table VerificaçãoServiço(
idEquipemecânica int,
idVeiculo int,
tipo_de_serviço varchar (100),
constraint fk_veriica_equipe foreign key (idEquipemecânica) references Equipe_mecânica(idEquipeM),
constraint fk_verifica_veiculo foreign key (idVeiculo) references Veiculos (idVeiculo)
);



show tables;