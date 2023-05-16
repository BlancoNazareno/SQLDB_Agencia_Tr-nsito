USE [master]
GO
/****** Object:  Database [AgenciaTransito]    Script Date: 15/05/2023 22:26:26 ******/
CREATE DATABASE [AgenciaTransito]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AgenciaTransito', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AgenciaTransito.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AgenciaTransito_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AgenciaTransito_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [AgenciaTransito] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AgenciaTransito].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AgenciaTransito] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AgenciaTransito] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AgenciaTransito] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AgenciaTransito] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AgenciaTransito] SET ARITHABORT OFF 
GO
ALTER DATABASE [AgenciaTransito] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AgenciaTransito] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AgenciaTransito] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AgenciaTransito] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AgenciaTransito] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AgenciaTransito] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AgenciaTransito] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AgenciaTransito] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AgenciaTransito] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AgenciaTransito] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AgenciaTransito] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AgenciaTransito] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AgenciaTransito] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AgenciaTransito] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AgenciaTransito] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AgenciaTransito] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AgenciaTransito] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AgenciaTransito] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AgenciaTransito] SET  MULTI_USER 
GO
ALTER DATABASE [AgenciaTransito] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AgenciaTransito] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AgenciaTransito] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AgenciaTransito] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AgenciaTransito] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AgenciaTransito] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [AgenciaTransito] SET QUERY_STORE = ON
GO
ALTER DATABASE [AgenciaTransito] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [AgenciaTransito]
GO
/****** Object:  Table [dbo].[Agentes]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agentes](
	[IdAgente] [int] IDENTITY(1,1) NOT NULL,
	[Legajo] [varchar](10) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[FechaIngreso] [date] NOT NULL,
	[Email] [varchar](100) NULL,
	[Telefono] [varchar](20) NULL,
	[Celular] [varchar](20) NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAgente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Localidades]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localidades](
	[IDLocalidad] [int] IDENTITY(1,1) NOT NULL,
	[Localidad] [varchar](150) NOT NULL,
	[IDProvincia] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLocalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediosPago]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediosPago](
	[IDMedioPago] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[MedioPagoElectronico] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMedioPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Multas]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Multas](
	[IdMulta] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoInfraccion] [int] NOT NULL,
	[IDLocalidad] [int] NOT NULL,
	[IdAgente] [int] NULL,
	[Patente] [varchar](10) NOT NULL,
	[FechaHora] [datetime] NOT NULL,
	[Monto] [money] NOT NULL,
	[Pagada] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[IDPago] [bigint] IDENTITY(1,1) NOT NULL,
	[IDMulta] [int] NOT NULL,
	[Importe] [money] NOT NULL,
	[Fecha] [date] NOT NULL,
	[IDMedioPago] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[IDProvincia] [smallint] IDENTITY(1,1) NOT NULL,
	[Provincia] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoInfracciones]    Script Date: 15/05/2023 22:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoInfracciones](
	[IdTipoInfraccion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[ImporteReferencia] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoInfraccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Agentes] ON 
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (1, N'A001', N'Carlos', N'Gomez', CAST(N'1988-04-15' AS Date), CAST(N'2012-07-01' AS Date), N'carlos.gomez@transito.gov.ar', N'11-4567-8901', N'15845858625', 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (2, N'A002', N'Maria', N'Fernandez', CAST(N'1985-12-10' AS Date), CAST(N'2013-01-15' AS Date), N'maria.fernandez@transito.gov.ar', N'11-2345-6789', N'154748584', 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (3, N'A003', N'Juan', N'Lopez', CAST(N'1990-02-25' AS Date), CAST(N'2014-06-30' AS Date), NULL, N'11-3456-7890', NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (4, N'A004', N'Ana', N'Perez', CAST(N'1992-05-08' AS Date), CAST(N'2015-02-01' AS Date), N'ana.perez@transito.gov.ar', NULL, NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (5, N'A005', N'Diego', N'Rodriguez', CAST(N'1986-11-30' AS Date), CAST(N'2016-03-15' AS Date), N'diego.rodriguez@transito.gov.ar', N'11-5678-9012', N'152623625', 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (6, N'A006', N'Carla', N'Lopez', CAST(N'1989-09-12' AS Date), CAST(N'2017-01-01' AS Date), NULL, N'11-7890-1234', N'154758485', 0)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (7, N'A007', N'Pablo', N'Diaz', CAST(N'1993-07-05' AS Date), CAST(N'2012-04-01' AS Date), N'pablo.diaz@transito.gov.ar', N'11-2345-6789', NULL, 0)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (8, N'A008', N'Romina', N'Martinez', CAST(N'1991-04-20' AS Date), CAST(N'2013-05-15' AS Date), NULL, N'11-3456-7890', NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (9, N'A009', N'Lucas', N'Gutierrez', CAST(N'1988-02-13' AS Date), CAST(N'2014-07-30' AS Date), N'lucas.gutierrez@transito.gov.ar', NULL, NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (10, N'A010', N'Marcela', N'Sanchez', CAST(N'1995-01-27' AS Date), CAST(N'2015-02-01' AS Date), NULL, NULL, NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (11, N'A011', N'Santiago', N'Lopez', CAST(N'1990-12-18' AS Date), CAST(N'2016-04-15' AS Date), N'santiago.torres@transito.gov.ar', N'11-5678-9012', N'154785485', 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (12, N'A012', N'Valentina', N'Suarez', CAST(N'1992-08-31' AS Date), CAST(N'2017-02-01' AS Date), NULL, N'11-7890-1234', NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (13, N'A013', N'Gustavo', N'Hernandez', CAST(N'1987-06-24' AS Date), CAST(N'2012-05-01' AS Date), N'gustavo.hernandez@transito.gov.ar', NULL, NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (14, N'A014', N'Julieta', N'Gongora', CAST(N'1984-03-09' AS Date), CAST(N'2013-06-15' AS Date), NULL, N'11-3456-7890', NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (15, N'A015', N'Mariano', N'Paz', CAST(N'1991-01-22' AS Date), CAST(N'2014-08-30' AS Date), N'mariano.paz@transito.gov.ar', N'11-4567-8901', NULL, 1)
GO
INSERT [dbo].[Agentes] ([IdAgente], [Legajo], [Nombres], [Apellidos], [FechaNacimiento], [FechaIngreso], [Email], [Telefono], [Celular], [Activo]) VALUES (16, N'A016', N'Legna', N'Nomis', CAST(N'1986-02-10' AS Date), CAST(N'2014-08-30' AS Date), N'lnomis@utn.edu.ar', N'11-2231-8901', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Agentes] OFF
GO
SET IDENTITY_INSERT [dbo].[Localidades] ON 
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (1, N'La Plata', 1)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (2, N'Mar del Plata', 1)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (3, N'Bahia Blanca', 1)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (4, N'Lomas de Zamora', 1)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (5, N'San Nicolas de los Arroyos', 1)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (6, N'Junin', 1)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (7, N'Cordoba', 2)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (8, N'Villa Maria', 2)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (9, N'Rio Cuarto', 2)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (10, N'Jesus Maria', 2)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (11, N'Bell Ville', 2)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (12, N'San Francisco', 2)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (13, N'Rosario', 3)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (14, N'Santa Fe', 3)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (15, N'Venado Tuerto', 3)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (16, N'Rafaela', 3)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (17, N'Reconquista', 3)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (18, N'Esperanza', 3)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (19, N'Mendoza', 4)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (20, N'San Rafael', 4)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (21, N'Lujan de Cuyo', 4)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (22, N'Maipu', 4)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (23, N'Godoy Cruz', 4)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (24, N'Malargüe', 4)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (25, N'San Miguel de Tucuman', 5)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (26, N'Concepcion', 5)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (27, N'Banda del Rio Sali', 5)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (28, N'Yerba Buena', 5)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (29, N'Aguilares', 5)
GO
INSERT [dbo].[Localidades] ([IDLocalidad], [Localidad], [IDProvincia]) VALUES (30, N'Simoca', 5)
GO
SET IDENTITY_INSERT [dbo].[Localidades] OFF
GO
SET IDENTITY_INSERT [dbo].[MediosPago] ON 
GO
INSERT [dbo].[MediosPago] ([IDMedioPago], [Nombre], [MedioPagoElectronico]) VALUES (1, N'Tarjeta de credito', 1)
GO
INSERT [dbo].[MediosPago] ([IDMedioPago], [Nombre], [MedioPagoElectronico]) VALUES (2, N'Tarjeta de debito', 1)
GO
INSERT [dbo].[MediosPago] ([IDMedioPago], [Nombre], [MedioPagoElectronico]) VALUES (3, N'PayPal', 1)
GO
INSERT [dbo].[MediosPago] ([IDMedioPago], [Nombre], [MedioPagoElectronico]) VALUES (4, N'Transferencia bancaria', 1)
GO
INSERT [dbo].[MediosPago] ([IDMedioPago], [Nombre], [MedioPagoElectronico]) VALUES (5, N'Efectivo', 0)
GO
SET IDENTITY_INSERT [dbo].[MediosPago] OFF
GO
SET IDENTITY_INSERT [dbo].[Multas] ON 
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (1, 2, 10, 9, N'AB123CD', CAST(N'2023-02-22T09:10:00.000' AS DateTime), 15500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (2, 4, 6, 4, N'CD456EF', CAST(N'2023-02-08T18:20:00.000' AS DateTime), 25500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (3, 8, 18, 12, N'EF789GH', CAST(N'2023-02-15T13:45:00.000' AS DateTime), 19500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (4, 5, 25, 15, N'GH012IJ', CAST(N'2023-03-06T16:30:00.000' AS DateTime), 25500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (5, 1, 22, 5, N'IJ345KL', CAST(N'2023-02-11T11:55:00.000' AS DateTime), 32000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (6, 9, 1, 11, N'KL678MN', CAST(N'2023-02-20T14:45:00.000' AS DateTime), 13000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (7, 6, 9, 13, N'MN901OP', CAST(N'2023-02-01T15:35:00.000' AS DateTime), 32000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (8, 7, 12, 3, N'OP234PQ', CAST(N'2023-03-02T10:00:00.000' AS DateTime), 37500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (9, 3, 17, 10, N'PQ567RS', CAST(N'2023-03-13T19:10:00.000' AS DateTime), 26000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (10, 10, 26, 8, N'RS890TU', CAST(N'2023-03-11T11:25:00.000' AS DateTime), 8000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (11, 2, 24, 12, N'TU123UV', CAST(N'2023-02-10T17:30:00.000' AS DateTime), 14500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (12, 4, 7, 6, N'UV456WX', CAST(N'2023-03-09T12:45:00.000' AS DateTime), 33500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (13, 8, 19, 15, N'WX789YZ', CAST(N'2023-02-27T08:15:00.000' AS DateTime), 22500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (14, 5, 23, 2, N'IJ567KL', CAST(N'2023-03-08T14:20:00.000' AS DateTime), 35500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (15, 1, 2, 1, N'AB123CD', CAST(N'2023-03-05T10:50:00.000' AS DateTime), 39000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (16, 9, 5, 10, N'CD678EF', CAST(N'2023-03-03T16:10:00.000' AS DateTime), 5000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (17, 6, 16, 7, N'EF901GH', CAST(N'2023-02-13T18:55:00.000' AS DateTime), 12000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (18, 7, 28, 9, N'AB123CD', CAST(N'2023-03-12T09:30:00.000' AS DateTime), 26500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (19, 3, 27, 11, N'IJ567KL', CAST(N'2023-02-23T14:40:00.000' AS DateTime), 17000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (20, 10, 13, 14, N'AB123CD', CAST(N'2023-03-21T11:50:00.000' AS DateTime), 24000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (21, 2, 29, 4, N'IJ567KL', CAST(N'2023-02-18T12:25:00.000' AS DateTime), 13000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (22, 1, 20, 3, N'ABC123', CAST(N'2023-01-02T08:15:00.000' AS DateTime), 8000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (23, 5, 17, 7, N'DEF456', CAST(N'2023-01-04T13:25:00.000' AS DateTime), 20000.0000, 1)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (24, 3, 12, 2, N'GHI789', CAST(N'2023-01-06T18:35:00.000' AS DateTime), 15000.0000, 1)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (25, 7, 24, 10, N'JKL012', CAST(N'2023-01-08T22:45:00.000' AS DateTime), 12000.0000, 1)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (26, 2, 6, 11, N'MNO345', CAST(N'2023-01-11T04:55:00.000' AS DateTime), 25000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (27, 4, 28, 4, N'PQR678', CAST(N'2023-01-13T09:05:00.000' AS DateTime), 12000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (28, 6, 9, 8, N'STU901', CAST(N'2023-01-16T14:15:00.000' AS DateTime), 8000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (29, 9, 5, 15, N'VWX234', CAST(N'2023-01-18T19:25:00.000' AS DateTime), 30000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (30, 8, 26, 13, N'YZA567', CAST(N'2023-01-21T00:35:00.000' AS DateTime), 35000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (31, 1, 14, 1, N'BCD890', CAST(N'2023-01-23T05:45:00.000' AS DateTime), 10000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (32, 5, 23, 7, N'EFG123', CAST(N'2023-01-26T10:55:00.000' AS DateTime), 18000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (33, 3, 8, 2, N'HIJ456', CAST(N'2023-02-01T16:05:00.000' AS DateTime), 13000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (34, 7, 25, 10, N'KLM789', CAST(N'2023-02-05T21:15:00.000' AS DateTime), 8000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (35, 2, 1, 11, N'NOP012', CAST(N'2023-02-10T02:25:00.000' AS DateTime), 22000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (36, 4, 27, 4, N'QRS345', CAST(N'2023-02-14T07:35:00.000' AS DateTime), 12000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (37, 6, 10, 8, N'TUV678', CAST(N'2023-02-19T12:45:00.000' AS DateTime), 10000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (38, 9, 2, 15, N'WXY901', CAST(N'2023-02-23T17:55:00.000' AS DateTime), 37000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (39, 8, 29, 13, N'ZAB234', CAST(N'2023-02-27T23:05:00.000' AS DateTime), 26000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (40, 1, 15, 1, N'CDE567', CAST(N'2023-03-03T04:15:00.000' AS DateTime), 15000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (41, 5, 22, 7, N'FGH890', CAST(N'2023-03-07T09:25:00.000' AS DateTime), 18000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (42, 1, 4, 6, N'AB123CD', CAST(N'2023-03-22T19:10:00.000' AS DateTime), 54000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (43, 1, 3, 6, N'CDE567', CAST(N'2023-03-26T19:10:00.000' AS DateTime), 25000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (44, 3, 3, 6, N'IJ567KL', CAST(N'2023-03-16T12:10:00.000' AS DateTime), 15000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (45, 1, 10, 1, N'SQL001', CAST(N'2023-04-22T09:10:00.000' AS DateTime), 15500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (46, 2, 6, 1, N'SQL001', CAST(N'2023-04-08T18:20:00.000' AS DateTime), 5500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (47, 3, 18, 1, N'SQL001', CAST(N'2023-03-15T13:45:00.000' AS DateTime), 12500.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (48, 4, 25, 1, N'SQL001', CAST(N'2023-04-06T16:30:00.000' AS DateTime), 25400.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (49, 5, 22, 1, N'SQL001', CAST(N'2023-04-11T11:55:00.000' AS DateTime), 31000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (50, 6, 1, 1, N'SQL002', CAST(N'2023-04-20T14:45:00.000' AS DateTime), 10000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (51, 7, 9, 1, N'SQL002', CAST(N'2023-04-01T15:35:00.000' AS DateTime), 30000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (52, 8, 12, 1, N'SQL002', CAST(N'2023-01-02T10:00:00.000' AS DateTime), 30000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (53, 9, 17, 1, N'SQL002', CAST(N'2023-04-13T19:10:00.000' AS DateTime), 21000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (54, 10, 26, 1, N'SQL002', CAST(N'2023-02-11T11:25:00.000' AS DateTime), 8000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (55, 6, 1, NULL, N'SQL002', CAST(N'2023-04-20T14:45:00.000' AS DateTime), 10000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (56, 7, 9, NULL, N'SQL002', CAST(N'2023-04-01T15:35:00.000' AS DateTime), 30000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (57, 3, 12, NULL, N'SQL002', CAST(N'2023-01-02T10:00:00.000' AS DateTime), 30000.0000, 0)
GO
INSERT [dbo].[Multas] ([IdMulta], [IdTipoInfraccion], [IDLocalidad], [IdAgente], [Patente], [FechaHora], [Monto], [Pagada]) VALUES (60, 3, 10, 9, N'ZZZ123', CAST(N'2023-04-25T00:00:00.000' AS DateTime), 99999.0000, 0)
GO
SET IDENTITY_INSERT [dbo].[Multas] OFF
GO
SET IDENTITY_INSERT [dbo].[Pagos] ON 
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (1, 1, 15500.0000, CAST(N'2023-02-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (2, 1, 7000.0000, CAST(N'2023-03-15' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (3, 1, 8500.0000, CAST(N'2023-03-20' AS Date), 3)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (4, 3, 19500.0000, CAST(N'2023-02-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (5, 3, 1500.0000, CAST(N'2023-03-01' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (6, 5, 32000.0000, CAST(N'2023-02-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (7, 5, 10000.0000, CAST(N'2023-03-10' AS Date), 4)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (8, 5, 10000.0000, CAST(N'2023-03-15' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (9, 5, 2000.0000, CAST(N'2023-03-20' AS Date), 3)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (10, 6, 13000.0000, CAST(N'2023-02-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (11, 20, 24000.0000, CAST(N'2023-03-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (12, 20, 8000.0000, CAST(N'2023-04-05' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (13, 22, 8000.0000, CAST(N'2023-01-05' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (14, 29, 30000.0000, CAST(N'2023-01-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (15, 30, 35000.0000, CAST(N'2023-02-05' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (16, 31, 10000.0000, CAST(N'2023-02-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (17, 32, 8000.0000, CAST(N'2023-02-28' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (18, 32, 10000.0000, CAST(N'2023-03-02' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (19, 33, 8000.0000, CAST(N'2023-03-05' AS Date), 3)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (20, 33, 5000.0000, CAST(N'2023-03-07' AS Date), 3)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (21, 34, 8000.0000, CAST(N'2023-03-09' AS Date), 4)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (22, 35, 10000.0000, CAST(N'2023-03-12' AS Date), 5)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (23, 35, 12000.0000, CAST(N'2023-03-15' AS Date), 5)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (24, 36, 12000.0000, CAST(N'2023-03-18' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (25, 37, 4000.0000, CAST(N'2023-03-21' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (26, 37, 6000.0000, CAST(N'2023-03-24' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (27, 37, 1000.0000, CAST(N'2023-03-27' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (28, 47, 25400.0000, CAST(N'2023-04-25' AS Date), 5)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (29, 46, 25400.0000, CAST(N'2023-04-25' AS Date), 3)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (30, 52, 15000.0000, CAST(N'2023-04-25' AS Date), 5)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (31, 52, 15000.0000, CAST(N'2023-04-25' AS Date), 5)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (32, 53, 20000.0000, CAST(N'2023-04-25' AS Date), 1)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (33, 53, 1000.0000, CAST(N'2023-04-25' AS Date), 2)
GO
INSERT [dbo].[Pagos] ([IDPago], [IDMulta], [Importe], [Fecha], [IDMedioPago]) VALUES (34, 60, 1000.0000, CAST(N'2023-04-25' AS Date), 1)
GO
SET IDENTITY_INSERT [dbo].[Pagos] OFF
GO
SET IDENTITY_INSERT [dbo].[Provincias] ON 
GO
INSERT [dbo].[Provincias] ([IDProvincia], [Provincia]) VALUES (1, N'Buenos Aires')
GO
INSERT [dbo].[Provincias] ([IDProvincia], [Provincia]) VALUES (2, N'Cordoba')
GO
INSERT [dbo].[Provincias] ([IDProvincia], [Provincia]) VALUES (3, N'Santa Fe')
GO
INSERT [dbo].[Provincias] ([IDProvincia], [Provincia]) VALUES (4, N'Mendoza')
GO
INSERT [dbo].[Provincias] ([IDProvincia], [Provincia]) VALUES (5, N'Tucuman')
GO
SET IDENTITY_INSERT [dbo].[Provincias] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoInfracciones] ON 
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (1, N'Exceso de velocidad', 10000.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (2, N'Estacionamiento en lugar prohibido', 7500.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (3, N'No respetar semaforo en rojo', 25000.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (4, N'No respetar señal de stop', 12500.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (5, N'No usar cinturon de seguridad', 5000.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (6, N'Hablar por telefono mientras se conduce', 7500.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (7, N'Circular en sentido contrario', 20000.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (8, N'No llevar luces encendidas en horario nocturno', 10000.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (9, N'Conducir bajo los efectos del alcohol', 50000.0000)
GO
INSERT [dbo].[TipoInfracciones] ([IdTipoInfraccion], [Descripcion], [ImporteReferencia]) VALUES (10, N'No respetar carril exclusivo para transporte publico', 1500.0000)
GO
SET IDENTITY_INSERT [dbo].[TipoInfracciones] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Agentes__0E01039AFC83AA23]    Script Date: 15/05/2023 22:26:26 ******/
ALTER TABLE [dbo].[Agentes] ADD UNIQUE NONCLUSTERED 
(
	[Legajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MediosPago] ADD  DEFAULT ((1)) FOR [MedioPagoElectronico]
GO
ALTER TABLE [dbo].[Multas] ADD  DEFAULT ((0)) FOR [Pagada]
GO
ALTER TABLE [dbo].[Localidades]  WITH CHECK ADD FOREIGN KEY([IDProvincia])
REFERENCES [dbo].[Provincias] ([IDProvincia])
GO
ALTER TABLE [dbo].[Multas]  WITH CHECK ADD FOREIGN KEY([IdAgente])
REFERENCES [dbo].[Agentes] ([IdAgente])
GO
ALTER TABLE [dbo].[Multas]  WITH CHECK ADD FOREIGN KEY([IDLocalidad])
REFERENCES [dbo].[Localidades] ([IDLocalidad])
GO
ALTER TABLE [dbo].[Multas]  WITH CHECK ADD FOREIGN KEY([IdTipoInfraccion])
REFERENCES [dbo].[TipoInfracciones] ([IdTipoInfraccion])
GO
ALTER TABLE [dbo].[Pagos]  WITH CHECK ADD FOREIGN KEY([IDMedioPago])
REFERENCES [dbo].[MediosPago] ([IDMedioPago])
GO
ALTER TABLE [dbo].[Pagos]  WITH CHECK ADD FOREIGN KEY([IDMulta])
REFERENCES [dbo].[Multas] ([IdMulta])
GO
ALTER TABLE [dbo].[Pagos]  WITH CHECK ADD CHECK  (([Importe]>(0)))
GO
USE [master]
GO
ALTER DATABASE [AgenciaTransito] SET  READ_WRITE 
GO
