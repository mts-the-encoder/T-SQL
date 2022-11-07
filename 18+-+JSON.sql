SET DATEFORMAT ymd

IF EXISTS(SELECT * FROM sys.sequences WHERE name = 'SeqIdVendas')  
BEGIN 
	DROP SEQUENCE dbo.SeqIdVendas 
END 

IF EXISTS(SELECT * FROM sys.synonyms WHERE name = 'VendasSinonimo')  
BEGIN 
	DROP SYNONYM dbo.VendasSinonimo 
END 

IF OBJECT_ID('dbo.VendasProdutoQuantidadeValor', 'TF') IS NOT NULL 
BEGIN 
	DROP FUNCTION dbo.VendasProdutoQuantidadeValor 
END 

IF OBJECT_ID('dbo.VendasProduto', 'IF') IS NOT NULL 
BEGIN 
	DROP FUNCTION dbo.VendasProduto 
END 

IF OBJECT_ID('dbo.ValorTotal', 'FN') IS NOT NULL 
BEGIN 
	DROP FUNCTION dbo.ValorTotal 
END 

IF EXISTS(SELECT * FROM sys.views WHERE name = 'VendasProdutoB')  
BEGIN 
	DROP VIEW dbo.VendasProdutoB 
END 

IF EXISTS(SELECT * FROM sys.views WHERE name = 'VendasProdutoA')  
BEGIN 
	DROP VIEW dbo.VendasProdutoA 
END 

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'VendasProdutoATrigger')  
BEGIN 
	DROP TRIGGER dbo.VendasProdutoATrigger 
END 

IF EXISTS(SELECT * FROM sys.views WHERE name = 'VendasProdutoA')  
BEGIN 
	DROP VIEW dbo.VendasProdutoA 
END 

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'VendasAlteracao')  
BEGIN 
	DROP TRIGGER dbo.VendasAlteracao 
END 

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'VendasInclusao')  
BEGIN 
	DROP TRIGGER dbo.VendasInclusao 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'LogVendas')  
BEGIN 
	DROP TABLE dbo.LogVendas 
END 

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'IncluiVendas')  
BEGIN 
	DROP PROCEDURE dbo.IncluiVendas 
END 

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'VendasComTotal')  
BEGIN 
	DROP PROCEDURE dbo.VendasComTotal 
END 

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'VendasInclusaoDinamico')  
BEGIN 
	DROP PROCEDURE dbo.VendasInclusaoDinamico 
END 

IF EXISTS(SELECT * FROM sys.views WHERE name = 'VendasViewIndexed')  
BEGIN 
	DROP VIEW dbo.VendasViewIndexed 
END 

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'PopularVendas')  
BEGIN 
	DROP PROCEDURE dbo.PopularVendas 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'VendasHistorico')  
BEGIN 
	DROP TABLE dbo.VendasHistorico 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Vendas')  
BEGIN 
	DROP TABLE dbo.Vendas 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Produto')  
BEGIN 
	DROP TABLE dbo.Produto 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'CadastroCliente')  
BEGIN 
	DROP TABLE dbo.CadastroCliente 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Cidade')  
BEGIN 
	DROP TABLE dbo.Cidade 
END 

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Estado')  
BEGIN 
	DROP TABLE dbo.Estado 
END 

GO 

CREATE TABLE dbo.Estado 
(
	Id TINYINT IDENTITY(1, 1) NOT NULL, 
	Descricao VARCHAR(150) NOT NULL, 
	CONSTRAINT PK_Estado PRIMARY KEY (Id) 
)

INSERT INTO dbo.Estado (Descricao) 
VALUES ('São Paulo'), 
       ('Rio de Janeiro'), 
	   ('Minas Gerais') 

CREATE TABLE dbo.Cidade 
(
	Id SMALLINT IDENTITY(1, 1) NOT NULL, 
	Id_Estado TINYINT NOT NULL, 
	Descricao VARCHAR(250) NOT NULL, 
	CONSTRAINT PK_Cidade PRIMARY KEY (Id), 
	CONSTRAINT FK_Estado_Cidade FOREIGN KEY (Id_Estado) REFERENCES Estado (Id) 
) 

INSERT INTO dbo.Cidade (Id_Estado, Descricao) 
VALUES (1, 'Santo André'), 
       (1, 'São Bernardo do Campo'), 
	   (1, 'São Caetano do Sul'), 
	   (2, 'Duque de Caxias'), 
	   (2, 'Niterói'), 
	   (2, 'Petrópolis'), 
	   (3, 'Uberlândia'), 
	   (3, 'Contagem'), 
	   (3, 'Juiz de Fora') 

CREATE TABLE dbo.CadastroCliente 
(
	Id INTEGER IDENTITY(1, 1) NOT NULL, 
	Nome VARCHAR(150) NOT NULL, 
	Endereco VARCHAR(250) NOT NULL, 
	Id_Cidade SMALLINT NOT NULL, 
	Email VARCHAR(250) NOT NULL, 
	Telefone1 VARCHAR(20) NOT NULL, 
	Telefone2 VARCHAR(20) NULL, 
	Telefone3 VARCHAR(20) NULL, 
	CONSTRAINT PK_CadastroCliente PRIMARY KEY (Id), 
	CONSTRAINT FK_Cidade_CadastroCliente FOREIGN KEY (Id_Cidade) REFERENCES Cidade (Id) 
) 

INSERT INTO dbo.CadastroCliente (Nome, Endereco, Id_Cidade, Email, Telefone1, Telefone2, Telefone3) 
VALUES ('Cliente 1',  'Rua 1',  1, 'cliente_1@email.com',  '(11) 0000-0000', NULL, NULL), 
       ('Cliente 2',  'Rua 2',  1, 'cliente_2@email.com',  '(11) 0000-0000', '(11) 1111-1111', '(11) 2222-2222'), 
	   ('Cliente 3',  'Rua 3',  1, 'cliente_3@email.com',  '(11) 0000-0000', '(11) 1111-1111', '(11) 2222-2222'), 
	   ('Cliente 4',  'Rua 4',  2, 'cliente_4@email.com',  '(11) 0000-0000', '(11) 1111-1111', NULL), 
	   ('Cliente 5',  'Rua 5',  2, 'cliente_5@email.com',  '(11) 0000-0000', '(11) 1111-1111', '(11) 2222-2222'), 
	   ('Cliente 6',  'Rua 6',  2, 'cliente_6@email.com',  '(11) 0000-0000', '(11) 1111-1111', NULL), 
	   ('Cliente 7',  'Rua 7',  3, 'cliente_7@email.com',  '(11) 0000-0000', NULL,             NULL), 
	   ('Cliente 8',  'Rua 8',  3, 'cliente_8@email.com',  '(11) 0000-0000', '(11) 1111-1111', '(11) 2222-2222'), 
	   ('Cliente 9',  'Rua 9',  3, 'cliente_9@email.com',  '(11) 0000-0000', '(11) 1111-1111', '(11) 2222-2222'), 
	   ('Cliente 10', 'Rua 10', 4, 'cliente_10@email.com', '(21) 0000-0000', '(21) 1111-1111', '(21) 2222-2222'), 
	   ('Cliente 11', 'Rua 11', 4, 'cliente_11@email.com', '(21) 0000-0000', '(21) 1111-1111', '(21) 2222-2222'), 
	   ('Cliente 12', 'Rua 12', 4, 'cliente_12@email.com', '(21) 0000-0000', '(21) 1111-1111', '(21) 2222-2222'), 
	   ('Cliente 13', 'Rua 13', 5, 'cliente_13@email.com', '(21) 0000-0000', '(21) 1111-1111', '(21) 2222-2222'), 
	   ('Cliente 14', 'Rua 14', 5, 'cliente_14@email.com', '(21) 0000-0000', '(21) 1111-1111', NULL), 
	   ('Cliente 15', 'Rua 15', 5, 'cliente_15@email.com', '(21) 0000-0000', '(21) 1111-1111', NULL), 
	   ('Cliente 16', 'Rua 16', 6, 'cliente_16@email.com', '(21) 0000-0000', '(21) 1111-1111', '(21) 2222-2222'), 
	   ('Cliente 17', 'Rua 17', 6, 'cliente_17@email.com', '(21) 0000-0000', NULL,             NULL), 
	   ('Cliente 18', 'Rua 18', 6, 'cliente_18@email.com', '(21) 0000-0000', '(21) 1111-1111', '(21) 2222-2222'), 
	   ('Cliente 19', 'Rua 19', 7, 'cliente_19@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 20', 'Rua 20', 7, 'cliente_20@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 21', 'Rua 21', 7, 'cliente_21@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 22', 'Rua 22', 8, 'cliente_22@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 23', 'Rua 23', 8, 'cliente_23@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 24', 'Rua 24', 8, 'cliente_24@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 25', 'Rua 25', 9, 'cliente_25@email.com', '(31) 0000-0000', NULL,             NULL), 
	   ('Cliente 26', 'Rua 26', 9, 'cliente_26@email.com', '(31) 0000-0000', '(31) 1111-1111', '(31) 2222-2222'), 
	   ('Cliente 27', 'Rua 27', 9, 'cliente_27@email.com', '(31) 0000-0000', '(31) 1111-1111', NULL) 

CREATE TABLE dbo.Produto 
(
	Id SMALLINT IDENTITY(1, 1) NOT NULL, 
	Descricao VARCHAR(250) NOT NULL, 
	CONSTRAINT PK_Produto PRIMARY KEY (Id) 
) 

CREATE NONCLUSTERED INDEX IDX_Produto_Descricao ON dbo.Produto (Descricao) 

INSERT INTO dbo.Produto (Descricao) 
VALUES ('Produto A'), 
       ('Produto B'), 
       ('Produto C')

CREATE TABLE dbo.Vendas 
(
	Id BIGINT IDENTITY(1, 1) NOT NULL, 
	Pedido UNIQUEIDENTIFIER NOT NULL, 
	Id_Cliente INTEGER NOT NULL, 
	Id_Produto SMALLINT NOT NULL, 
	Quantidade SMALLINT NOT NULL, 
	"Valor Unitario" NUMERIC(9, 2) NOT NULL, 
	"Data Venda" SMALLDATETIME NOT NULL, 
	Observacao NVARCHAR(100) NULL, 
	CONSTRAINT PK_Vendas PRIMARY KEY (Id, Id_Cliente, Id_Produto), 
	CONSTRAINT UC_Vendas_Pedido_Cliente_Produto UNIQUE (Pedido, Id_Cliente, Id_Produto), 
	CONSTRAINT FK_CadastroCliente_Vendas FOREIGN KEY (Id_Cliente) REFERENCES CadastroCliente (Id), 
	CONSTRAINT FK_Produto_Vendas FOREIGN KEY (Id_Produto) REFERENCES Produto (Id) 
) 

CREATE NONCLUSTERED INDEX IDX_Vendas_Id_Cliente ON dbo.Vendas (Id_Cliente) 
CREATE NONCLUSTERED INDEX IDX_Vendas_Id_Produto ON dbo.Vendas (Id_Produto) 

CREATE NONCLUSTERED INDEX IDX_Vendas_DataVenda ON dbo.Vendas("Data Venda") INCLUDE (Quantidade, "Valor Unitario") 
GO 

CREATE PROCEDURE dbo.PopularVendas 
AS 
BEGIN 
	DECLARE @DataInicial SMALLDATETIME = CAST('2000-01-01' AS SMALLDATETIME) 
	DECLARE @DataFinal SMALLDATETIME = CAST('2020-12-15' AS SMALLDATETIME) 
	DECLARE @DataAtual SMALLDATETIME = @DataInicial
	DECLARE @Bloco SMALLINT = 5000 
	DECLARE @BlocoAtual SMALLINT = 0 
	DECLARE @Pedido UNIQUEIDENTIFIER 

	BEGIN TRANSACTION 

	WHILE (@DataFinal > @DataAtual) 
	BEGIN 
		IF (@BlocoAtual >= @Bloco) 
		BEGIN 
			COMMIT TRANSACTION 
			BEGIN TRANSACTION 
			SET @BlocoAtual = 0 
		END 

		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 1, 1, 10, 5.65, @DataAtual), 
			   (@Pedido, 1, 2, 10, 7.65, @DataAtual)
				
		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 2, 1, 20, 5.65, @DataAtual), 
			   (@Pedido, 2, 2, 20, 7.65, @DataAtual) 
		
		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 3, 1, 30, 5.65, @DataAtual) 

		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 4, 2, 40, 7.65, @DataAtual) 

		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 5, 1, 50, 5.65, @DataAtual), 
			   (@Pedido, 5, 2, 50, 7.65, @DataAtual) 
	
		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 6, 2, 60, 7.65, @DataAtual) 

		SET @Pedido = NEWID() 

		INSERT INTO dbo.Vendas (Pedido, Id_Cliente, Id_Produto, Quantidade, "Valor Unitario", "Data Venda") 
		VALUES (@Pedido, 7, 1, 70, 5.65, @DataAtual) 

		SET @DataAtual = DATEADD(d, 1, @DataAtual)
		SET @BlocoAtual = @BlocoAtual + 10 
	END 

	IF (@BlocoAtual > 0) 
	BEGIN 
		COMMIT TRANSACTION 
	END 
END 
GO 

EXEC dbo.PopularVendas 
GO 

SELECT Venda.Pedido, 
       Cliente.Nome AS Cliente, 
	   Produto.Descricao AS Produto, 
	   Venda.Quantidade, Venda."Valor Unitario" AS ValorUnitario, (Venda.Quantidade * Venda."Valor Unitario") AS ValorTotal, CAST(Venda."Data Venda" AS DATE) AS DataVenda
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON AUTO; 
 
SELECT Venda.Pedido, 
       Cliente.Nome AS Cliente, 
	   Produto.Descricao AS Produto, 
	   Venda.Quantidade, Venda."Valor Unitario" AS ValorUnitario, (Venda.Quantidade * Venda."Valor Unitario") AS ValorTotal, CAST(Venda."Data Venda" AS DATE) AS DataVenda
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH; 

SELECT Venda.Pedido, 
	   Venda.Id_Cliente								AS "Cliente.Código", 
       Cliente.Nome									AS "Cliente.Nome", 
	   Produto.Descricao							AS "Produto.Descrição", 
	   Venda.Quantidade, 
	   Venda."Valor Unitario"						AS ValorUnitario, 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS ValorTotal, 
	   CAST(Venda."Data Venda" AS DATE)				AS DataVenda
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH; 

SELECT Cliente.Nome									AS "Cliente", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valor Total", 
	   CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda" 
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH; 

SELECT Cliente.Nome									AS "Cliente", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH; 

SELECT Cliente.Nome									AS "Cliente", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH, ROOT('Data'); 

SELECT Produto.Id									AS "Id", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Produto		AS Produto 
  LEFT JOIN dbo.Vendas	AS Venda  ON (Produto.Id = Venda.Id_Produto) 
 WHERE Produto.Id = 3 
 ORDER BY Produto.Id DESC 
 FOR JSON PATH, INCLUDE_NULL_VALUES; 

SELECT Produto.Id									AS "Id", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Produto		AS Produto 
  LEFT JOIN dbo.Vendas	AS Venda  ON (Produto.Id = Venda.Id_Produto) 
 WHERE Produto.Id = 3 
 ORDER BY Produto.Id DESC 
 FOR JSON PATH, ROOT('Data'), INCLUDE_NULL_VALUES; 

SELECT Cliente.Nome									AS "Cliente", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH, WITHOUT_ARRAY_WRAPPER; 

SELECT Produto.Id									AS "Id", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Produto		AS Produto 
  LEFT JOIN dbo.Vendas	AS Venda  ON (Produto.Id = Venda.Id_Produto) 
 WHERE Produto.Id = 3 
 ORDER BY Produto.Id DESC 
 FOR JSON PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER; 

SELECT Cliente.Nome									AS "Cliente", 
	   Produto.Descricao							AS "Produto", 
	   Venda.Pedido									AS "Venda.Código do Pedido", 
       CAST(Venda."Data Venda" AS DATE)				AS "Venda.Data da Venda", 
	   Venda.Quantidade								AS "Venda.Quantidade", 
	   Venda."Valor Unitario"						AS "Venda.Valores.Valor Unitário", 
	   (Venda.Quantidade * Venda."Valor Unitario")	AS "Venda.Valores.Valor Total"
  FROM dbo.Vendas               AS Venda 
 INNER JOIN dbo.CadastroCliente AS Cliente ON (Venda.Id_Cliente = Cliente.Id) 
 INNER JOIN dbo.Produto         AS Produto ON (Venda.Id_Produto = Produto.Id) 
 WHERE Venda.[Data Venda] = CAST('2020-01-01' AS SMALLDATETIME) 
 FOR JSON PATH, ROOT('Data'), WITHOUT_ARRAY_WRAPPER; 

DECLARE @JSON1 AS NVARCHAR(MAX) = N'
{
	"Venda":{
		"Id": "5000000",
		"Id_Cliente": 1,
		"Id_Produto": 1, 
		"Quantidade": 10,
		"ValorUnitario": 5,
		"DataVenda": "2050-01-01"
	}
}';

SELECT * 
  FROM OPENJSON(@JSON1); 

DECLARE @JSON2 AS NVARCHAR(MAX) = N'
{
	"Venda":{
		"Id": "5000000",
		"Cliente":{
			"Id": 1,
			"Nome": "Nome Teste"
		},
		"Produto":{
			"Id": 1,
			"Descricao": "Produto D"
		},
		"Quantidade": 10,
		"ValorUnitario": 5,
		"DataVenda": "2050-01-01"
	}
}';

SELECT * 
  FROM OPENJSON(@JSON2); 

SELECT * 
  FROM OPENJSON(@JSON2, '$.Venda'); 

DECLARE @JSON3 AS NVARCHAR(MAX) = N'
{
	"Venda":{
		"Id": "5000000",
		"Cliente":{
			"Id": 1,
			"Nome": "Nome Teste"
		},
		"Produto":{
			"Id": 1,
			"Descricao": "Produto D"
		},
		"Quantidade": 10,
		"ValorUnitario": 5,
		"DataVenda": "2050-01-01"
	}
}';

SELECT * 
  FROM OPENJSON(@JSON3, 'lax $.Cliente'); 

SELECT * 
  FROM OPENJSON(@JSON3, 'strict $.Cliente'); 

DECLARE @JSON4 AS NVARCHAR(MAX) = N'
{
	"Venda":{
		"Id": "5000000",
		"Cliente":{
			"Id": 1,
			"Nome": "Nome Teste"
		},
		"Produto":{
			"Id": 1,
			"Descricao": "Produto D"
		},
		"Quantidade": 10,
		"ValorUnitario": 5.15,
		"DataVenda": "2050-01-01"
	}
}';

SELECT * 
  FROM OPENJSON(@JSON4) 
WITH 
(
	IdVenda			INT				'$.Venda.Id', 
	Cliente			NVARCHAR(MAX)	'$.Venda.Cliente'	AS JSON, 
	Produto			NVARCHAR(MAX)	'$.Venda.Produto'	AS JSON, 
	Quantidade		INT				'$.Venda.Quantidade', 
	ValorUnitario	NUMERIC(17, 2)	'$.Venda.ValorUnitario', 
	DataVenda		DATETIME		'$.Venda.DataVenda' 
); 

DECLARE @JSON5 AS NVARCHAR(MAX) = N'
{
	"Venda":{
		"Id": "5000000",
		"Cliente":{
			"Id": 1,
			"Nome": "Nome Teste"
		},
		"Produto":{
			"Id": 1,
			"Descricao": "Produto D"
		},
		"Quantidade": 10,
		"ValorUnitario": 5.15,
		"DataVenda": "2050-01-01"
	}
}';

SELECT JSON_VALUE(@JSON5, '$.Venda.Id') AS Id_Venda,
       JSON_VALUE(@JSON5, '$.Venda.DataVenda') AS Data_Venda,
	   JSON_VALUE(@JSON5, '$.Venda.Quantidade') AS Quantidade,
	   JSON_VALUE(@JSON5, '$.Venda.ValorUnitario') AS Valor_Unitario,
	   JSON_QUERY(@JSON5, '$.Venda.Cliente') AS Cliente,
	   JSON_QUERY(@JSON5, '$.Venda.Produto') AS Produto,
	   JSON_VALUE(@JSON5, '$.Venda.ValorTotal') AS ValorTotal,
	   JSON_QUERY(@JSON5, '$.Venda.Cliente.Cidade') AS Cidade; 

DECLARE @JSON6 AS NVARCHAR(MAX) = N'
{
	"Venda":{
		"Id": "5000000",
		"Cliente":{
			"Id": 1,
			"Nome": "Nome Teste"
		},
		"Produto":{
			"Id": 1,
			"Descricao": "Produto D"
		},
		"Quantidade": 10,
		"ValorUnitario": 5.15,
		"DataVenda": "2050-01-01"
	}
}';

SET @JSON6 = JSON_MODIFY(@JSON6, '$.Venda.Quantidade', 20); 

SET @JSON6 = JSON_MODIFY(@JSON6, '$.Venda.DataVenda', '2055-01-01'); 

SET @JSON6 = JSON_MODIFY(@JSON6, '$.Venda.ValorUnitario', NULL); 

SET @JSON6 = JSON_MODIFY(@JSON6, '$.Venda.Cliente.Cidade', 'Santo André'); 

PRINT @JSON6;

SELECT ISJSON ('str') AS s1, ISJSON ('') AS s2,
       ISJSON ('{}') AS s3, ISJSON ('{"a"}') AS s4,
       ISJSON ('{"a":1}') AS s5;

DECLARE @JSON7 AS NVARCHAR(MAX) = N'
{
	"Vendas": [
		{
			"Id": "5000000",
			"Cliente":{
				"Id": 1,
				"Nome": "Nome Teste"
			},
			"Produto":{
				"Id": 1,
				"Descricao": "Produto D"
			},
			"Quantidade": 10,
			"ValorUnitario": 5.15,
			"DataVenda": "2050-01-01"
		},
		{
			"Id": "5000001",
			"Cliente":{
				"Id": 2,
				"Nome": "Nome Teste 2"
			},
			"Produto":{
				"Id": 2,
				"Descricao": "Produto E"
			},
			"Quantidade": 70,
			"ValorUnitario": 7.15,
			"DataVenda": "2050-01-02"
		}
	]
}';

SELECT * 
  FROM OPENJSON(@JSON7, '$.Vendas')
WITH 
(
	IdVenda			INT				'$.Id', 
	Cliente			NVARCHAR(MAX)	'$.Cliente'	AS JSON, 
	Produto			NVARCHAR(MAX)	'$.Produto'	AS JSON, 
	Quantidade		INT				'$.Quantidade', 
	ValorUnitario	NUMERIC(17, 2)	'$.ValorUnitario', 
	DataVenda		DATETIME		'$.DataVenda' 
); 