--create database [DWHAmazonStage]
--go


--CREATE SCHEMA jps

--GO


USE [DWHAmazonStage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[stgCategory](
	[CategoryID] [int]  NULL,
	[CategoryName] [varchar](100) NULL,
	[CRAETEDDATE] [datetime] DEFAULT GETDATE() NOT NULL,
	[ModifiedDATE] [datetime] NULL,
	[CRAETEDBy] [varchar](100) DEFAULT SYSTEM_USER NOT NULL,
	[Modifiedby] [varchar](100) NULL,
	[FilePath] [varchar](1000) NULL,
	[FileName] [varchar](500) NULL
) ON [PRIMARY]
GO




USE [DWHAmazonStage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[stgProduct](
	[PID] [int] NULL,
	[ProductName] [varchar](100) NULL,
	[Price] [float] NULL,
	[CategoryID] [int] NULL,
	[CRAETEDDATE] [datetime] DEFAULT GETDATE() NOT NULL,
	[ModifiedDATE] [datetime] NULL,
	[CRAETEDBy] [varchar](100) DEFAULT SYSTEM_USER NULL,
	[Modifiedby] [varchar](100)  NULL,
	[FilePath] [varchar](1000) NULL,
	[FileName] [varchar](500) NULL
) ON [PRIMARY]
GO


USE [DWHAmazonStage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[stgCustomer](
	[CID] [int] NULL,
	[Name] [varchar](100) NULL,
	[city] [varchar](100) NULL,
	[CRAETEDDATE] [datetime] DEFAULT GETDATE() NOT NULL,
	[ModifiedDATE] [datetime] NULL,
	[CRAETEDBy] [varchar](100) DEFAULT SYSTEM_USER NOT NULL,
	[Modifiedby] [varchar](100) NULL,
	[FilePath] [varchar](1000) NULL,
	[FileName] [varchar](500) NULL
) ON [PRIMARY]
GO



USE [DWHAmazonStage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[stgSales](
	[PID] [int]  NULL,
	[CID] [int]  NULL,
	[SaleDate] [datetime] NULL,
	[QtySold] [int] NULL,
	[SalesAmount] [float] NULL,
	[DeliveryDate] [datetime] NULL,
	[CRAETEDDATE] [datetime] DEFAULT GETDATE() NOT NULL,
	[ModifiedDATE] [datetime] NULL,
	[CRAETEDBy] [varchar](100) DEFAULT SYSTEM_USER NOT NULL,
	[Modifiedby] [varchar](100) NULL,
	[FilePath] [varchar](1000) NULL,
	[FileName] [varchar](500) NULL
) ON [PRIMARY]
GO


------------------------------------------------------------CREATING FACT TABLES------------------------------------------------------------------

--CREATE DATABASE [DWHAmazon]
--GO

--USE [DWHAmazon]
--GO

--CREATE SCHEMA [jps]
--GO


USE [DWHAmazon]
GO

/****** Object:  Table [jps].[DimProduct]    Script Date: 11/22/2023 9:03:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[DimProduct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductKey] [int] NOT NULL,
	[ProductName] [varchar](100) NULL,
	[Price] [float] NULL,
	[CategoryName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [DWHAmazon]
GO

/****** Object:  Table [jps].[DimCustomer]    Script Date: 11/22/2023 9:04:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[DimCustomer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[city] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [DWHAmazon]
GO

/****** Object:  Table [jps].[DimLocation]    Script Date: 11/22/2023 9:06:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[DimLocation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocationKey] [int] NOT NULL,
	[LocationName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



USE DWHAmazon
GO
INSERT [DWHAmazon].[jps].[DimLocation] ([LocationKey],[LocationName])
SELECT 1, 'Baltimore'
UNION
SELECT 2, 'Banglore'
UNION
SELECT 3, 'Chatam'
UNION
SELECT 4, 'Chennai'
UNION
SELECT 5, 'Dallas'
UNION
SELECT 6, 'Dayton'
UNION
SELECT 7, 'Guntur'
UNION
SELECT 8, 'Mumbai'
UNION
SELECT 9, 'Mysore'
UNION
SELECT 10,'Newark'
UNION
SELECT 11,'OOty'
UNION
SELECT 12,'Towson'


USE [DWHAmazon] --
GO

/****** Object:  Table [jps].[FactSales]    Script Date: 11/22/2023 9:05:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [jps].[FactSales](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[LocationKey] [int] NULL,
	[SaleDate] [datetime] NULL,
	[QtySold] [int] NULL,
	[SalesAmount] [float] NULL,
	[DeliveryDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [jps].[FactSales]  WITH CHECK ADD FOREIGN KEY([CustomerKey])
REFERENCES [jps].[DimCustomer] ([CustomerKey])
GO

ALTER TABLE [jps].[FactSales]  WITH CHECK ADD FOREIGN KEY([LocationKey])
REFERENCES [jps].[DimLocation] ([LocationKey])
GO

ALTER TABLE [jps].[FactSales]  WITH CHECK ADD FOREIGN KEY([ProductKey])
REFERENCES [jps].[DimProduct] ([ProductKey])
GO

SELECT * FROM [jps].[DimLocation]
SELECT * FROM [jps].[FactSales]
SELECT * FROM [jps].[DimCustomer]
SELECT * FROM [jps].[DimProduct]

-----------------------------------------------------------------------------------------------------

-------------------------------------STEP 2- IMPORTING THE DATA -------------------------------

SELECT * FROM [jps].[CategoryMaster]
SELECT * FROM [jps].[CustomerMaster]
SELECT * FROM [jps].[ProductMaster]
SELECT * FROM [jps].[Sales]
