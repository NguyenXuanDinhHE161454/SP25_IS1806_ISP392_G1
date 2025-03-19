USE [RiceWarehouse2]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](10) NULL,
	[Age] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Debts]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Debts](
	[DebtID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[DebtType] [int] NOT NULL,
	[Amount] [decimal](15, 2) NOT NULL,
	[Note] [nvarchar](max) NULL,
	[DebtDate] [datetime] NULL,
	[Description] [text] NULL,
	[Evident] [text] NULL,
	[Payload] [text] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DebtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [int] NULL,
	[ProductId] [int] NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
	[Description] [text] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Payment] [decimal](18, 0) NULL,
	[CustomerId] [int] NULL,
	[UserId] [int] NULL,
	[Type] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
	[PaidAmount] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [text] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Image] [nvarchar](1000) NULL,
	[Quantity] [int] NULL,
	[ZoneId] [int] NULL,
	[Description] [text] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[Status] [smallint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
	[Amount] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[Username] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[IsBanned] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zone]    Script Date: 3/14/2025 1:39:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[Status] [smallint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[DeletedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (1, N'Nguyen Van A', N'Male', 30, N'101 Customer St', N'0918123456', 1, CAST(N'2025-03-01T10:25:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (2, N'Tran Thi B', N'Female', 25, N'202 Customer Rd', N'0918123457', 2, CAST(N'2025-03-01T10:30:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (3, N'John Doe', N'Male', 30, N'123 Main St', N'555-1234', NULL, CAST(N'2025-03-13T15:52:33.970' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (4, N'Customer 4', N'Female', 24, N'Customer Address 4', N'091000004', 5, CAST(N'2025-03-13T17:43:40.713' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (5, N'Customer 5', N'Other', 25, N'Customer Address 5', N'091000005', 6, CAST(N'2025-03-13T17:43:40.713' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (6, N'Customer 6', N'Male', 26, N'Customer Address 6', N'091000006', 7, CAST(N'2025-03-13T17:43:40.717' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (7, N'Customer 7', N'Female', 27, N'Customer Address 7', N'091000007', 8, CAST(N'2025-03-13T17:43:40.717' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (8, N'Customer 8', N'Other', 28, N'Customer Address 8', N'091000008', 9, CAST(N'2025-03-13T17:43:40.720' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (9, N'Customer 9', N'Male', 29, N'Customer Address 9', N'091000009', 10, CAST(N'2025-03-13T17:43:40.720' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (10, N'Customer 10', N'Female', 30, N'Customer Address 10', N'091000010', 11, CAST(N'2025-03-13T17:43:40.720' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (11, N'Customer 11', N'Other', 31, N'Customer Address 11', N'091000011', 12, CAST(N'2025-03-13T17:43:40.723' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (12, N'Customer 12', N'Male', 32, N'Customer Address 12', N'091000012', 13, CAST(N'2025-03-13T17:43:40.723' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (13, N'Customer 13', N'Female', 33, N'Customer Address 13', N'091000013', 14, CAST(N'2025-03-13T17:43:40.723' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (14, N'Customer 14', N'Other', 34, N'Customer Address 14', N'091000014', 15, CAST(N'2025-03-13T17:43:40.727' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (15, N'Customer 15', N'Male', 35, N'Customer Address 15', N'091000015', 16, CAST(N'2025-03-13T17:43:40.727' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (16, N'Customer 16', N'Female', 36, N'Customer Address 16', N'091000016', 17, CAST(N'2025-03-13T17:43:40.727' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (17, N'Customer 17', N'Other', 37, N'Customer Address 17', N'091000017', 18, CAST(N'2025-03-13T17:43:40.730' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (18, N'Customer 18', N'Male', 38, N'Customer Address 18', N'091000018', 19, CAST(N'2025-03-13T17:43:40.730' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (19, N'Customer 19', N'Female', 39, N'Customer Address 19', N'091000019', 20, CAST(N'2025-03-13T17:43:40.733' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (20, N'Customer 20', N'Other', 40, N'Customer Address 20', N'091000020', 21, CAST(N'2025-03-13T17:43:40.733' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (21, N'Customer 21', N'Male', 41, N'Customer Address 21', N'091000021', 22, CAST(N'2025-03-13T17:43:40.737' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (22, N'Customer 22', N'Female', 42, N'Customer Address 22', N'091000022', 23, CAST(N'2025-03-13T17:43:40.737' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (23, N'Customer 23', N'Other', 43, N'Customer Address 23', N'091000023', 24, CAST(N'2025-03-13T17:43:40.737' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (24, N'Customer 24', N'Male', 44, N'Customer Address 24', N'091000024', 25, CAST(N'2025-03-13T17:43:40.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (25, N'Customer 25', N'Female', 45, N'Customer Address 25', N'091000025', 26, CAST(N'2025-03-13T17:43:40.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (26, N'Customer 26', N'Other', 46, N'Customer Address 26', N'091000026', 27, CAST(N'2025-03-13T17:43:40.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (27, N'Customer 27', N'Male', 47, N'Customer Address 27', N'091000027', 28, CAST(N'2025-03-13T17:43:40.743' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (28, N'Customer 28', N'Female', 48, N'Customer Address 28', N'091000028', 29, CAST(N'2025-03-13T17:43:40.743' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (29, N'Customer 29', N'Other', 49, N'Customer Address 29', N'091000029', 30, CAST(N'2025-03-13T17:43:40.747' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (30, N'Customer 30', N'Male', 50, N'Customer Address 30', N'091000030', 31, CAST(N'2025-03-13T17:43:40.747' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (31, N'Customer 31', N'Female', 51, N'Customer Address 31', N'091000031', 32, CAST(N'2025-03-13T17:43:40.750' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (32, N'Customer 32', N'Other', 52, N'Customer Address 32', N'091000032', 33, CAST(N'2025-03-13T17:43:40.750' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (33, N'Customer 33', N'Male', 53, N'Customer Address 33', N'091000033', 34, CAST(N'2025-03-13T17:43:40.753' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (34, N'Customer 34', N'Female', 54, N'Customer Address 34', N'091000034', 35, CAST(N'2025-03-13T17:43:40.753' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (35, N'Customer 35', N'Other', 55, N'Customer Address 35', N'091000035', 36, CAST(N'2025-03-13T17:43:40.753' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (36, N'Customer 36', N'Male', 56, N'Customer Address 36', N'091000036', 37, CAST(N'2025-03-13T17:43:40.757' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (37, N'Customer 37', N'Female', 57, N'Customer Address 37', N'091000037', 38, CAST(N'2025-03-13T17:43:40.757' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (38, N'Customer 38', N'Other', 58, N'Customer Address 38', N'091000038', 39, CAST(N'2025-03-13T17:43:40.757' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (39, N'Customer 39', N'Male', 59, N'Customer Address 39', N'091000039', 40, CAST(N'2025-03-13T17:43:40.760' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (40, N'Customer 40', N'Female', 60, N'Customer Address 40', N'091000040', 41, CAST(N'2025-03-13T17:43:40.760' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (41, N'Customer 41', N'Other', 61, N'Customer Address 41', N'091000041', 42, CAST(N'2025-03-13T17:43:40.763' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (42, N'Customer 42', N'Male', 62, N'Customer Address 42', N'091000042', 43, CAST(N'2025-03-13T17:43:40.763' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (43, N'Customer 43', N'Female', 63, N'Customer Address 43', N'091000043', 44, CAST(N'2025-03-13T17:43:40.767' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (44, N'Customer 44', N'Other', 64, N'Customer Address 44', N'091000044', 45, CAST(N'2025-03-13T17:43:40.767' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (45, N'Customer 45', N'Male', 65, N'Customer Address 45', N'091000045', 46, CAST(N'2025-03-13T17:43:40.770' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (46, N'Customer 46', N'Female', 66, N'Customer Address 46', N'091000046', 47, CAST(N'2025-03-13T17:43:40.770' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (47, N'Customer 47', N'Other', 67, N'Customer Address 47', N'091000047', 48, CAST(N'2025-03-13T17:43:40.770' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (48, N'Customer 48', N'Male', 68, N'Customer Address 48', N'091000048', 49, CAST(N'2025-03-13T17:43:40.773' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (49, N'Customer 49', N'Female', 69, N'Customer Address 49', N'091000049', 50, CAST(N'2025-03-13T17:43:40.773' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (50, N'Customer 50', N'Other', 20, N'Customer Address 50', N'091000050', 1, CAST(N'2025-03-13T17:43:40.777' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Debts] ON 

INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (1, 1, 1, CAST(250000.00 AS Decimal(15, 2)), N'Debt from Invoice 1', CAST(N'2025-03-10T18:00:00.000' AS DateTime), N'Pending payment', NULL, NULL, 2, CAST(N'2025-03-10T18:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (2, 2, 0, CAST(300000.00 AS Decimal(15, 2)), N'Cleared debt', CAST(N'2025-03-11T09:05:00.000' AS DateTime), N'Payment received', NULL, NULL, 3, CAST(N'2025-03-11T09:05:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (3, 4, 1, CAST(30000.00 AS Decimal(15, 2)), N'Note for debt 3', CAST(N'2025-03-13T17:44:15.450' AS DateTime), N'Description for debt 3', N'Evident for debt 3', N'Payload for debt 3', 4, CAST(N'2025-03-13T17:44:15.450' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (4, 5, 0, CAST(40000.00 AS Decimal(15, 2)), N'Note for debt 4', CAST(N'2025-03-13T17:44:15.453' AS DateTime), N'Description for debt 4', N'Evident for debt 4', N'Payload for debt 4', 5, CAST(N'2025-03-13T17:44:15.453' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (5, 6, 1, CAST(50000.00 AS Decimal(15, 2)), N'Note for debt 5', CAST(N'2025-03-13T17:44:15.457' AS DateTime), N'Description for debt 5', N'Evident for debt 5', N'Payload for debt 5', 6, CAST(N'2025-03-13T17:44:15.457' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (6, 7, 0, CAST(60000.00 AS Decimal(15, 2)), N'Note for debt 6', CAST(N'2025-03-13T17:44:15.457' AS DateTime), N'Description for debt 6', N'Evident for debt 6', N'Payload for debt 6', 7, CAST(N'2025-03-13T17:44:15.457' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (7, 8, 1, CAST(70000.00 AS Decimal(15, 2)), N'Note for debt 7', CAST(N'2025-03-13T17:44:15.460' AS DateTime), N'Description for debt 7', N'Evident for debt 7', N'Payload for debt 7', 8, CAST(N'2025-03-13T17:44:15.460' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (8, 9, 0, CAST(80000.00 AS Decimal(15, 2)), N'Note for debt 8', CAST(N'2025-03-13T17:44:15.460' AS DateTime), N'Description for debt 8', N'Evident for debt 8', N'Payload for debt 8', 9, CAST(N'2025-03-13T17:44:15.460' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (9, 10, 1, CAST(90000.00 AS Decimal(15, 2)), N'Note for debt 9', CAST(N'2025-03-13T17:44:15.460' AS DateTime), N'Description for debt 9', N'Evident for debt 9', N'Payload for debt 9', 10, CAST(N'2025-03-13T17:44:15.460' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (10, 11, 0, CAST(100000.00 AS Decimal(15, 2)), N'Note for debt 10', CAST(N'2025-03-13T17:44:15.460' AS DateTime), N'Description for debt 10', N'Evident for debt 10', N'Payload for debt 10', 11, CAST(N'2025-03-13T17:44:15.460' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (11, 12, 1, CAST(110000.00 AS Decimal(15, 2)), N'Note for debt 11', CAST(N'2025-03-13T17:44:15.463' AS DateTime), N'Description for debt 11', N'Evident for debt 11', N'Payload for debt 11', 12, CAST(N'2025-03-13T17:44:15.463' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (12, 13, 0, CAST(120000.00 AS Decimal(15, 2)), N'Note for debt 12', CAST(N'2025-03-13T17:44:15.463' AS DateTime), N'Description for debt 12', N'Evident for debt 12', N'Payload for debt 12', 13, CAST(N'2025-03-13T17:44:15.463' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (13, 14, 1, CAST(130000.00 AS Decimal(15, 2)), N'Note for debt 13', CAST(N'2025-03-13T17:44:15.467' AS DateTime), N'Description for debt 13', N'Evident for debt 13', N'Payload for debt 13', 14, CAST(N'2025-03-13T17:44:15.467' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (14, 15, 0, CAST(140000.00 AS Decimal(15, 2)), N'Note for debt 14', CAST(N'2025-03-13T17:44:15.467' AS DateTime), N'Description for debt 14', N'Evident for debt 14', N'Payload for debt 14', 15, CAST(N'2025-03-13T17:44:15.467' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (15, 16, 1, CAST(150000.00 AS Decimal(15, 2)), N'Note for debt 15', CAST(N'2025-03-13T17:44:15.467' AS DateTime), N'Description for debt 15', N'Evident for debt 15', N'Payload for debt 15', 16, CAST(N'2025-03-13T17:44:15.467' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (16, 17, 0, CAST(160000.00 AS Decimal(15, 2)), N'Note for debt 16', CAST(N'2025-03-13T17:44:15.470' AS DateTime), N'Description for debt 16', N'Evident for debt 16', N'Payload for debt 16', 17, CAST(N'2025-03-13T17:44:15.470' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (17, 18, 1, CAST(170000.00 AS Decimal(15, 2)), N'Note for debt 17', CAST(N'2025-03-13T17:44:15.470' AS DateTime), N'Description for debt 17', N'Evident for debt 17', N'Payload for debt 17', 18, CAST(N'2025-03-13T17:44:15.470' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (18, 19, 0, CAST(180000.00 AS Decimal(15, 2)), N'Note for debt 18', CAST(N'2025-03-13T17:44:15.470' AS DateTime), N'Description for debt 18', N'Evident for debt 18', N'Payload for debt 18', 19, CAST(N'2025-03-13T17:44:15.470' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (19, 20, 1, CAST(190000.00 AS Decimal(15, 2)), N'Note for debt 19', CAST(N'2025-03-13T17:44:15.470' AS DateTime), N'Description for debt 19', N'Evident for debt 19', N'Payload for debt 19', 20, CAST(N'2025-03-13T17:44:15.470' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (20, 21, 0, CAST(200000.00 AS Decimal(15, 2)), N'Note for debt 20', CAST(N'2025-03-13T17:44:15.473' AS DateTime), N'Description for debt 20', N'Evident for debt 20', N'Payload for debt 20', 21, CAST(N'2025-03-13T17:44:15.473' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (21, 22, 1, CAST(210000.00 AS Decimal(15, 2)), N'Note for debt 21', CAST(N'2025-03-13T17:44:15.477' AS DateTime), N'Description for debt 21', N'Evident for debt 21', N'Payload for debt 21', 22, CAST(N'2025-03-13T17:44:15.477' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (22, 23, 0, CAST(220000.00 AS Decimal(15, 2)), N'Note for debt 22', CAST(N'2025-03-13T17:44:15.477' AS DateTime), N'Description for debt 22', N'Evident for debt 22', N'Payload for debt 22', 23, CAST(N'2025-03-13T17:44:15.477' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (23, 24, 1, CAST(230000.00 AS Decimal(15, 2)), N'Note for debt 23', CAST(N'2025-03-13T17:44:15.477' AS DateTime), N'Description for debt 23', N'Evident for debt 23', N'Payload for debt 23', 24, CAST(N'2025-03-13T17:44:15.477' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (24, 25, 0, CAST(240000.00 AS Decimal(15, 2)), N'Note for debt 24', CAST(N'2025-03-13T17:44:15.480' AS DateTime), N'Description for debt 24', N'Evident for debt 24', N'Payload for debt 24', 25, CAST(N'2025-03-13T17:44:15.480' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (25, 26, 1, CAST(250000.00 AS Decimal(15, 2)), N'Note for debt 25', CAST(N'2025-03-13T17:44:15.480' AS DateTime), N'Description for debt 25', N'Evident for debt 25', N'Payload for debt 25', 26, CAST(N'2025-03-13T17:44:15.480' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (26, 27, 0, CAST(260000.00 AS Decimal(15, 2)), N'Note for debt 26', CAST(N'2025-03-13T17:44:15.480' AS DateTime), N'Description for debt 26', N'Evident for debt 26', N'Payload for debt 26', 27, CAST(N'2025-03-13T17:44:15.480' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (27, 28, 1, CAST(270000.00 AS Decimal(15, 2)), N'Note for debt 27', CAST(N'2025-03-13T17:44:15.483' AS DateTime), N'Description for debt 27', N'Evident for debt 27', N'Payload for debt 27', 28, CAST(N'2025-03-13T17:44:15.483' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (28, 29, 0, CAST(280000.00 AS Decimal(15, 2)), N'Note for debt 28', CAST(N'2025-03-13T17:44:15.487' AS DateTime), N'Description for debt 28', N'Evident for debt 28', N'Payload for debt 28', 29, CAST(N'2025-03-13T17:44:15.487' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (29, 30, 1, CAST(290000.00 AS Decimal(15, 2)), N'Note for debt 29', CAST(N'2025-03-13T17:44:15.487' AS DateTime), N'Description for debt 29', N'Evident for debt 29', N'Payload for debt 29', 30, CAST(N'2025-03-13T17:44:15.487' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (30, 31, 0, CAST(300000.00 AS Decimal(15, 2)), N'Note for debt 30', CAST(N'2025-03-13T17:44:15.487' AS DateTime), N'Description for debt 30', N'Evident for debt 30', N'Payload for debt 30', 31, CAST(N'2025-03-13T17:44:15.487' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (31, 32, 1, CAST(310000.00 AS Decimal(15, 2)), N'Note for debt 31', CAST(N'2025-03-13T17:44:15.490' AS DateTime), N'Description for debt 31', N'Evident for debt 31', N'Payload for debt 31', 32, CAST(N'2025-03-13T17:44:15.490' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (32, 33, 0, CAST(320000.00 AS Decimal(15, 2)), N'Note for debt 32', CAST(N'2025-03-13T17:44:15.490' AS DateTime), N'Description for debt 32', N'Evident for debt 32', N'Payload for debt 32', 33, CAST(N'2025-03-13T17:44:15.490' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (33, 34, 1, CAST(330000.00 AS Decimal(15, 2)), N'Note for debt 33', CAST(N'2025-03-13T17:44:15.493' AS DateTime), N'Description for debt 33', N'Evident for debt 33', N'Payload for debt 33', 34, CAST(N'2025-03-13T17:44:15.493' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (34, 35, 0, CAST(340000.00 AS Decimal(15, 2)), N'Note for debt 34', CAST(N'2025-03-13T17:44:15.493' AS DateTime), N'Description for debt 34', N'Evident for debt 34', N'Payload for debt 34', 35, CAST(N'2025-03-13T17:44:15.493' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (35, 36, 1, CAST(350000.00 AS Decimal(15, 2)), N'Note for debt 35', CAST(N'2025-03-13T17:44:15.497' AS DateTime), N'Description for debt 35', N'Evident for debt 35', N'Payload for debt 35', 36, CAST(N'2025-03-13T17:44:15.497' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (36, 37, 0, CAST(360000.00 AS Decimal(15, 2)), N'Note for debt 36', CAST(N'2025-03-13T17:44:15.497' AS DateTime), N'Description for debt 36', N'Evident for debt 36', N'Payload for debt 36', 37, CAST(N'2025-03-13T17:44:15.497' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (37, 38, 1, CAST(370000.00 AS Decimal(15, 2)), N'Note for debt 37', CAST(N'2025-03-13T17:44:15.500' AS DateTime), N'Description for debt 37', N'Evident for debt 37', N'Payload for debt 37', 38, CAST(N'2025-03-13T17:44:15.500' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (38, 39, 0, CAST(380000.00 AS Decimal(15, 2)), N'Note for debt 38', CAST(N'2025-03-13T17:44:15.500' AS DateTime), N'Description for debt 38', N'Evident for debt 38', N'Payload for debt 38', 39, CAST(N'2025-03-13T17:44:15.500' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (39, 40, 1, CAST(390000.00 AS Decimal(15, 2)), N'Note for debt 39', CAST(N'2025-03-13T17:44:15.500' AS DateTime), N'Description for debt 39', N'Evident for debt 39', N'Payload for debt 39', 40, CAST(N'2025-03-13T17:44:15.500' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (40, 41, 0, CAST(400000.00 AS Decimal(15, 2)), N'Note for debt 40', CAST(N'2025-03-13T17:44:15.503' AS DateTime), N'Description for debt 40', N'Evident for debt 40', N'Payload for debt 40', 41, CAST(N'2025-03-13T17:44:15.503' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (41, 42, 1, CAST(410000.00 AS Decimal(15, 2)), N'Note for debt 41', CAST(N'2025-03-13T17:44:15.503' AS DateTime), N'Description for debt 41', N'Evident for debt 41', N'Payload for debt 41', 42, CAST(N'2025-03-13T17:44:15.503' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (42, 43, 0, CAST(420000.00 AS Decimal(15, 2)), N'Note for debt 42', CAST(N'2025-03-13T17:44:15.507' AS DateTime), N'Description for debt 42', N'Evident for debt 42', N'Payload for debt 42', 43, CAST(N'2025-03-13T17:44:15.507' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (43, 44, 1, CAST(430000.00 AS Decimal(15, 2)), N'Note for debt 43', CAST(N'2025-03-13T17:44:15.507' AS DateTime), N'Description for debt 43', N'Evident for debt 43', N'Payload for debt 43', 44, CAST(N'2025-03-13T17:44:15.507' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (44, 45, 0, CAST(440000.00 AS Decimal(15, 2)), N'Note for debt 44', CAST(N'2025-03-13T17:44:15.510' AS DateTime), N'Description for debt 44', N'Evident for debt 44', N'Payload for debt 44', 45, CAST(N'2025-03-13T17:44:15.510' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (45, 46, 1, CAST(450000.00 AS Decimal(15, 2)), N'Note for debt 45', CAST(N'2025-03-13T17:44:15.510' AS DateTime), N'Description for debt 45', N'Evident for debt 45', N'Payload for debt 45', 46, CAST(N'2025-03-13T17:44:15.510' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (46, 47, 0, CAST(460000.00 AS Decimal(15, 2)), N'Note for debt 46', CAST(N'2025-03-13T17:44:15.510' AS DateTime), N'Description for debt 46', N'Evident for debt 46', N'Payload for debt 46', 47, CAST(N'2025-03-13T17:44:15.510' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (47, 48, 1, CAST(470000.00 AS Decimal(15, 2)), N'Note for debt 47', CAST(N'2025-03-13T17:44:15.510' AS DateTime), N'Description for debt 47', N'Evident for debt 47', N'Payload for debt 47', 48, CAST(N'2025-03-13T17:44:15.510' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (48, 49, 0, CAST(480000.00 AS Decimal(15, 2)), N'Note for debt 48', CAST(N'2025-03-13T17:44:15.513' AS DateTime), N'Description for debt 48', N'Evident for debt 48', N'Payload for debt 48', 49, CAST(N'2025-03-13T17:44:15.513' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (49, 50, 1, CAST(490000.00 AS Decimal(15, 2)), N'Note for debt 49', CAST(N'2025-03-13T17:44:15.517' AS DateTime), N'Description for debt 49', N'Evident for debt 49', N'Payload for debt 49', 50, CAST(N'2025-03-13T17:44:15.517' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate], [Description], [Evident], [Payload], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (50, 1, 0, CAST(500000.00 AS Decimal(15, 2)), N'Note for debt 50', CAST(N'2025-03-13T17:44:15.517' AS DateTime), N'Description for debt 50', N'Evident for debt 50', N'Payload for debt 50', 1, CAST(N'2025-03-13T17:44:15.517' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Debts] OFF
GO
SET IDENTITY_INSERT [dbo].[InvoiceDetails] ON 

INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (1, 1, 1, CAST(50000 AS Decimal(18, 0)), 10, N'Jasmine Rice Purchase', 2, CAST(N'2025-03-10T17:59:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (2, 2, 2, CAST(60000 AS Decimal(18, 0)), 5, N'Sticky Rice Purchase', 3, CAST(N'2025-03-11T09:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (3, 4, 4, CAST(300 AS Decimal(18, 0)), 3, N'Description for invoice detail 3', 4, CAST(N'2025-03-13T17:44:10.820' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (4, 5, 5, CAST(400 AS Decimal(18, 0)), 4, N'Description for invoice detail 4', 5, CAST(N'2025-03-13T17:44:10.823' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (5, 6, 6, CAST(500 AS Decimal(18, 0)), 5, N'Description for invoice detail 5', 6, CAST(N'2025-03-13T17:44:10.823' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (6, 7, 7, CAST(600 AS Decimal(18, 0)), 6, N'Description for invoice detail 6', 7, CAST(N'2025-03-13T17:44:10.827' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (7, 8, 8, CAST(700 AS Decimal(18, 0)), 7, N'Description for invoice detail 7', 8, CAST(N'2025-03-13T17:44:10.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (8, 9, 9, CAST(800 AS Decimal(18, 0)), 8, N'Description for invoice detail 8', 9, CAST(N'2025-03-13T17:44:10.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (9, 10, 10, CAST(900 AS Decimal(18, 0)), 9, N'Description for invoice detail 9', 10, CAST(N'2025-03-13T17:44:10.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (10, 11, 11, CAST(1000 AS Decimal(18, 0)), 10, N'Description for invoice detail 10', 11, CAST(N'2025-03-13T17:44:10.833' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (11, 12, 12, CAST(1100 AS Decimal(18, 0)), 11, N'Description for invoice detail 11', 12, CAST(N'2025-03-13T17:44:10.833' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (12, 13, 13, CAST(1200 AS Decimal(18, 0)), 12, N'Description for invoice detail 12', 13, CAST(N'2025-03-13T17:44:10.833' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (13, 14, 14, CAST(1300 AS Decimal(18, 0)), 13, N'Description for invoice detail 13', 14, CAST(N'2025-03-13T17:44:10.837' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (14, 15, 15, CAST(1400 AS Decimal(18, 0)), 14, N'Description for invoice detail 14', 15, CAST(N'2025-03-13T17:44:10.837' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (15, 16, 16, CAST(1500 AS Decimal(18, 0)), 15, N'Description for invoice detail 15', 16, CAST(N'2025-03-13T17:44:10.837' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (16, 17, 17, CAST(1600 AS Decimal(18, 0)), 16, N'Description for invoice detail 16', 17, CAST(N'2025-03-13T17:44:10.840' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (17, 18, 18, CAST(1700 AS Decimal(18, 0)), 17, N'Description for invoice detail 17', 18, CAST(N'2025-03-13T17:44:10.840' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (18, 19, 19, CAST(1800 AS Decimal(18, 0)), 18, N'Description for invoice detail 18', 19, CAST(N'2025-03-13T17:44:10.843' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (19, 20, 20, CAST(1900 AS Decimal(18, 0)), 19, N'Description for invoice detail 19', 20, CAST(N'2025-03-13T17:44:10.843' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (20, 21, 21, CAST(2000 AS Decimal(18, 0)), 20, N'Description for invoice detail 20', 21, CAST(N'2025-03-13T17:44:10.843' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (21, 22, 22, CAST(2100 AS Decimal(18, 0)), 21, N'Description for invoice detail 21', 22, CAST(N'2025-03-13T17:44:10.847' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (22, 23, 23, CAST(2200 AS Decimal(18, 0)), 22, N'Description for invoice detail 22', 23, CAST(N'2025-03-13T17:44:10.847' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (23, 24, 24, CAST(2300 AS Decimal(18, 0)), 23, N'Description for invoice detail 23', 24, CAST(N'2025-03-13T17:44:10.847' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (24, 25, 25, CAST(2400 AS Decimal(18, 0)), 24, N'Description for invoice detail 24', 25, CAST(N'2025-03-13T17:44:10.850' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (25, 26, 26, CAST(2500 AS Decimal(18, 0)), 25, N'Description for invoice detail 25', 26, CAST(N'2025-03-13T17:44:10.850' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (26, 27, 27, CAST(2600 AS Decimal(18, 0)), 26, N'Description for invoice detail 26', 27, CAST(N'2025-03-13T17:44:10.850' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (27, 28, 28, CAST(2700 AS Decimal(18, 0)), 27, N'Description for invoice detail 27', 28, CAST(N'2025-03-13T17:44:10.853' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (28, 29, 29, CAST(2800 AS Decimal(18, 0)), 28, N'Description for invoice detail 28', 29, CAST(N'2025-03-13T17:44:10.853' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (29, 30, 30, CAST(2900 AS Decimal(18, 0)), 29, N'Description for invoice detail 29', 30, CAST(N'2025-03-13T17:44:10.853' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (30, 31, 31, CAST(3000 AS Decimal(18, 0)), 30, N'Description for invoice detail 30', 31, CAST(N'2025-03-13T17:44:10.857' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (31, 32, 32, CAST(3100 AS Decimal(18, 0)), 31, N'Description for invoice detail 31', 32, CAST(N'2025-03-13T17:44:10.860' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (32, 33, 33, CAST(3200 AS Decimal(18, 0)), 32, N'Description for invoice detail 32', 33, CAST(N'2025-03-13T17:44:10.860' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (33, 34, 34, CAST(3300 AS Decimal(18, 0)), 33, N'Description for invoice detail 33', 34, CAST(N'2025-03-13T17:44:10.863' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (34, 35, 35, CAST(3400 AS Decimal(18, 0)), 34, N'Description for invoice detail 34', 35, CAST(N'2025-03-13T17:44:10.863' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (35, 36, 36, CAST(3500 AS Decimal(18, 0)), 35, N'Description for invoice detail 35', 36, CAST(N'2025-03-13T17:44:10.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (36, 37, 37, CAST(3600 AS Decimal(18, 0)), 36, N'Description for invoice detail 36', 37, CAST(N'2025-03-13T17:44:10.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (37, 38, 38, CAST(3700 AS Decimal(18, 0)), 37, N'Description for invoice detail 37', 38, CAST(N'2025-03-13T17:44:10.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (38, 39, 39, CAST(3800 AS Decimal(18, 0)), 38, N'Description for invoice detail 38', 39, CAST(N'2025-03-13T17:44:10.870' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (39, 40, 40, CAST(3900 AS Decimal(18, 0)), 39, N'Description for invoice detail 39', 40, CAST(N'2025-03-13T17:44:10.870' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (40, 41, 41, CAST(4000 AS Decimal(18, 0)), 40, N'Description for invoice detail 40', 41, CAST(N'2025-03-13T17:44:10.870' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (41, 42, 42, CAST(4100 AS Decimal(18, 0)), 41, N'Description for invoice detail 41', 42, CAST(N'2025-03-13T17:44:10.873' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (42, 43, 43, CAST(4200 AS Decimal(18, 0)), 42, N'Description for invoice detail 42', 43, CAST(N'2025-03-13T17:44:10.873' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (43, 44, 44, CAST(4300 AS Decimal(18, 0)), 43, N'Description for invoice detail 43', 44, CAST(N'2025-03-13T17:44:10.873' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (44, 45, 45, CAST(4400 AS Decimal(18, 0)), 44, N'Description for invoice detail 44', 45, CAST(N'2025-03-13T17:44:10.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (45, 46, 46, CAST(4500 AS Decimal(18, 0)), 45, N'Description for invoice detail 45', 46, CAST(N'2025-03-13T17:44:10.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (46, 47, 47, CAST(4600 AS Decimal(18, 0)), 46, N'Description for invoice detail 46', 47, CAST(N'2025-03-13T17:44:10.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (47, 48, 48, CAST(4700 AS Decimal(18, 0)), 47, N'Description for invoice detail 47', 48, CAST(N'2025-03-13T17:44:10.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (48, 49, 49, CAST(4800 AS Decimal(18, 0)), 48, N'Description for invoice detail 48', 49, CAST(N'2025-03-13T17:44:10.880' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (49, 50, 50, CAST(4900 AS Decimal(18, 0)), 49, N'Description for invoice detail 49', 50, CAST(N'2025-03-13T17:44:10.880' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[InvoiceDetails] ([Id], [InvoiceId], [ProductId], [UnitPrice], [Quantity], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (50, 1, 1, CAST(5000 AS Decimal(18, 0)), 50, N'Description for invoice detail 50', 1, CAST(N'2025-03-13T17:44:10.880' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[InvoiceDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoices] ON 

INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (1, CAST(N'2025-03-10T17:59:00.000' AS DateTime), CAST(250000 AS Decimal(18, 0)), 1, 2, 0, 1, CAST(N'2025-03-10T17:59:00.000' AS DateTime), 0, NULL, NULL, NULL)
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (2, CAST(N'2025-03-11T09:00:00.000' AS DateTime), CAST(300000 AS Decimal(18, 0)), 2, 3, 1, 2, CAST(N'2025-03-11T09:00:00.000' AS DateTime), 0, NULL, NULL, NULL)
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (3, CAST(N'2025-03-13T17:44:06.393' AS DateTime), CAST(15000 AS Decimal(18, 0)), 4, 4, 0, 4, CAST(N'2025-03-13T17:44:06.393' AS DateTime), 0, NULL, NULL, CAST(9000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (4, CAST(N'2025-03-13T17:44:06.400' AS DateTime), CAST(20000 AS Decimal(18, 0)), 5, 5, 1, 5, CAST(N'2025-03-13T17:44:06.400' AS DateTime), 0, NULL, NULL, CAST(12000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (5, CAST(N'2025-03-13T17:44:06.400' AS DateTime), CAST(25000 AS Decimal(18, 0)), 6, 6, 2, 6, CAST(N'2025-03-13T17:44:06.400' AS DateTime), 0, NULL, NULL, CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (6, CAST(N'2025-03-13T17:44:06.400' AS DateTime), CAST(30000 AS Decimal(18, 0)), 7, 7, 0, 7, CAST(N'2025-03-13T17:44:06.400' AS DateTime), 0, NULL, NULL, CAST(18000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (7, CAST(N'2025-03-13T17:44:06.400' AS DateTime), CAST(35000 AS Decimal(18, 0)), 8, 8, 1, 8, CAST(N'2025-03-13T17:44:06.400' AS DateTime), 0, NULL, NULL, CAST(21000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (8, CAST(N'2025-03-13T17:44:06.403' AS DateTime), CAST(40000 AS Decimal(18, 0)), 9, 9, 2, 9, CAST(N'2025-03-13T17:44:06.403' AS DateTime), 0, NULL, NULL, CAST(24000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (9, CAST(N'2025-03-13T17:44:06.403' AS DateTime), CAST(45000 AS Decimal(18, 0)), 10, 10, 0, 10, CAST(N'2025-03-13T17:44:06.403' AS DateTime), 0, NULL, NULL, CAST(27000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (10, CAST(N'2025-03-13T17:44:06.403' AS DateTime), CAST(50000 AS Decimal(18, 0)), 11, 11, 1, 11, CAST(N'2025-03-13T17:44:06.403' AS DateTime), 0, NULL, NULL, CAST(30000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (11, CAST(N'2025-03-13T17:44:06.407' AS DateTime), CAST(55000 AS Decimal(18, 0)), 12, 12, 2, 12, CAST(N'2025-03-13T17:44:06.407' AS DateTime), 0, NULL, NULL, CAST(33000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (12, CAST(N'2025-03-13T17:44:06.407' AS DateTime), CAST(60000 AS Decimal(18, 0)), 13, 13, 0, 13, CAST(N'2025-03-13T17:44:06.407' AS DateTime), 0, NULL, NULL, CAST(36000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (13, CAST(N'2025-03-13T17:44:06.410' AS DateTime), CAST(65000 AS Decimal(18, 0)), 14, 14, 1, 14, CAST(N'2025-03-13T17:44:06.410' AS DateTime), 0, NULL, NULL, CAST(39000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (14, CAST(N'2025-03-13T17:44:06.410' AS DateTime), CAST(70000 AS Decimal(18, 0)), 15, 15, 2, 15, CAST(N'2025-03-13T17:44:06.410' AS DateTime), 0, NULL, NULL, CAST(42000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (15, CAST(N'2025-03-13T17:44:06.410' AS DateTime), CAST(75000 AS Decimal(18, 0)), 16, 16, 0, 16, CAST(N'2025-03-13T17:44:06.410' AS DateTime), 0, NULL, NULL, CAST(45000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (16, CAST(N'2025-03-13T17:44:06.410' AS DateTime), CAST(80000 AS Decimal(18, 0)), 17, 17, 1, 17, CAST(N'2025-03-13T17:44:06.410' AS DateTime), 0, NULL, NULL, CAST(48000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (17, CAST(N'2025-03-13T17:44:06.410' AS DateTime), CAST(85000 AS Decimal(18, 0)), 18, 18, 2, 18, CAST(N'2025-03-13T17:44:06.410' AS DateTime), 0, NULL, NULL, CAST(51000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (18, CAST(N'2025-03-13T17:44:06.413' AS DateTime), CAST(90000 AS Decimal(18, 0)), 19, 19, 0, 19, CAST(N'2025-03-13T17:44:06.413' AS DateTime), 0, NULL, NULL, CAST(54000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (19, CAST(N'2025-03-13T17:44:06.413' AS DateTime), CAST(95000 AS Decimal(18, 0)), 20, 20, 1, 20, CAST(N'2025-03-13T17:44:06.413' AS DateTime), 0, NULL, NULL, CAST(57000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (20, CAST(N'2025-03-13T17:44:06.413' AS DateTime), CAST(100000 AS Decimal(18, 0)), 21, 21, 2, 21, CAST(N'2025-03-13T17:44:06.413' AS DateTime), 0, NULL, NULL, CAST(60000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (21, CAST(N'2025-03-13T17:44:06.417' AS DateTime), CAST(105000 AS Decimal(18, 0)), 22, 22, 0, 22, CAST(N'2025-03-13T17:44:06.417' AS DateTime), 0, NULL, NULL, CAST(63000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (22, CAST(N'2025-03-13T17:44:06.417' AS DateTime), CAST(110000 AS Decimal(18, 0)), 23, 23, 1, 23, CAST(N'2025-03-13T17:44:06.417' AS DateTime), 0, NULL, NULL, CAST(66000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (23, CAST(N'2025-03-13T17:44:06.420' AS DateTime), CAST(115000 AS Decimal(18, 0)), 24, 24, 2, 24, CAST(N'2025-03-13T17:44:06.420' AS DateTime), 0, NULL, NULL, CAST(69000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (24, CAST(N'2025-03-13T17:44:06.420' AS DateTime), CAST(120000 AS Decimal(18, 0)), 25, 25, 0, 25, CAST(N'2025-03-13T17:44:06.420' AS DateTime), 0, NULL, NULL, CAST(72000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (25, CAST(N'2025-03-13T17:44:06.420' AS DateTime), CAST(125000 AS Decimal(18, 0)), 26, 26, 1, 26, CAST(N'2025-03-13T17:44:06.420' AS DateTime), 0, NULL, NULL, CAST(75000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (26, CAST(N'2025-03-13T17:44:06.420' AS DateTime), CAST(130000 AS Decimal(18, 0)), 27, 27, 2, 27, CAST(N'2025-03-13T17:44:06.420' AS DateTime), 0, NULL, NULL, CAST(78000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (27, CAST(N'2025-03-13T17:44:06.420' AS DateTime), CAST(135000 AS Decimal(18, 0)), 28, 28, 0, 28, CAST(N'2025-03-13T17:44:06.420' AS DateTime), 0, NULL, NULL, CAST(81000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (28, CAST(N'2025-03-13T17:44:06.423' AS DateTime), CAST(140000 AS Decimal(18, 0)), 29, 29, 1, 29, CAST(N'2025-03-13T17:44:06.423' AS DateTime), 0, NULL, NULL, CAST(84000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (29, CAST(N'2025-03-13T17:44:06.423' AS DateTime), CAST(145000 AS Decimal(18, 0)), 30, 30, 2, 30, CAST(N'2025-03-13T17:44:06.423' AS DateTime), 0, NULL, NULL, CAST(87000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (30, CAST(N'2025-03-13T17:44:06.423' AS DateTime), CAST(150000 AS Decimal(18, 0)), 31, 31, 0, 31, CAST(N'2025-03-13T17:44:06.423' AS DateTime), 0, NULL, NULL, CAST(90000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (31, CAST(N'2025-03-13T17:44:06.430' AS DateTime), CAST(155000 AS Decimal(18, 0)), 32, 32, 1, 32, CAST(N'2025-03-13T17:44:06.430' AS DateTime), 0, NULL, NULL, CAST(93000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (32, CAST(N'2025-03-13T17:44:06.430' AS DateTime), CAST(160000 AS Decimal(18, 0)), 33, 33, 2, 33, CAST(N'2025-03-13T17:44:06.430' AS DateTime), 0, NULL, NULL, CAST(96000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (33, CAST(N'2025-03-13T17:44:06.433' AS DateTime), CAST(165000 AS Decimal(18, 0)), 34, 34, 0, 34, CAST(N'2025-03-13T17:44:06.433' AS DateTime), 0, NULL, NULL, CAST(99000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (34, CAST(N'2025-03-13T17:44:06.447' AS DateTime), CAST(170000 AS Decimal(18, 0)), 35, 35, 1, 35, CAST(N'2025-03-13T17:44:06.447' AS DateTime), 0, NULL, NULL, CAST(102000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (35, CAST(N'2025-03-13T17:44:06.447' AS DateTime), CAST(175000 AS Decimal(18, 0)), 36, 36, 2, 36, CAST(N'2025-03-13T17:44:06.447' AS DateTime), 0, NULL, NULL, CAST(105000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (36, CAST(N'2025-03-13T17:44:06.450' AS DateTime), CAST(180000 AS Decimal(18, 0)), 37, 37, 0, 37, CAST(N'2025-03-13T17:44:06.450' AS DateTime), 0, NULL, NULL, CAST(108000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (37, CAST(N'2025-03-13T17:44:06.450' AS DateTime), CAST(185000 AS Decimal(18, 0)), 38, 38, 1, 38, CAST(N'2025-03-13T17:44:06.450' AS DateTime), 0, NULL, NULL, CAST(111000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (38, CAST(N'2025-03-13T17:44:06.450' AS DateTime), CAST(190000 AS Decimal(18, 0)), 39, 39, 2, 39, CAST(N'2025-03-13T17:44:06.450' AS DateTime), 0, NULL, NULL, CAST(114000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (39, CAST(N'2025-03-13T17:44:06.450' AS DateTime), CAST(195000 AS Decimal(18, 0)), 40, 40, 0, 40, CAST(N'2025-03-13T17:44:06.450' AS DateTime), 0, NULL, NULL, CAST(117000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (40, CAST(N'2025-03-13T17:44:06.453' AS DateTime), CAST(200000 AS Decimal(18, 0)), 41, 41, 1, 41, CAST(N'2025-03-13T17:44:06.453' AS DateTime), 0, NULL, NULL, CAST(120000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (41, CAST(N'2025-03-13T17:44:06.453' AS DateTime), CAST(205000 AS Decimal(18, 0)), 42, 42, 2, 42, CAST(N'2025-03-13T17:44:06.453' AS DateTime), 0, NULL, NULL, CAST(123000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (42, CAST(N'2025-03-13T17:44:06.453' AS DateTime), CAST(210000 AS Decimal(18, 0)), 43, 43, 0, 43, CAST(N'2025-03-13T17:44:06.453' AS DateTime), 0, NULL, NULL, CAST(126000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (43, CAST(N'2025-03-13T17:44:06.457' AS DateTime), CAST(215000 AS Decimal(18, 0)), 44, 44, 1, 44, CAST(N'2025-03-13T17:44:06.457' AS DateTime), 0, NULL, NULL, CAST(129000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (44, CAST(N'2025-03-13T17:44:06.457' AS DateTime), CAST(220000 AS Decimal(18, 0)), 45, 45, 2, 45, CAST(N'2025-03-13T17:44:06.457' AS DateTime), 0, NULL, NULL, CAST(132000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (45, CAST(N'2025-03-13T17:44:06.460' AS DateTime), CAST(225000 AS Decimal(18, 0)), 46, 46, 0, 46, CAST(N'2025-03-13T17:44:06.460' AS DateTime), 0, NULL, NULL, CAST(135000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (46, CAST(N'2025-03-13T17:44:06.460' AS DateTime), CAST(230000 AS Decimal(18, 0)), 47, 47, 1, 47, CAST(N'2025-03-13T17:44:06.460' AS DateTime), 0, NULL, NULL, CAST(138000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (47, CAST(N'2025-03-13T17:44:06.460' AS DateTime), CAST(235000 AS Decimal(18, 0)), 48, 48, 2, 48, CAST(N'2025-03-13T17:44:06.460' AS DateTime), 0, NULL, NULL, CAST(141000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (48, CAST(N'2025-03-13T17:44:06.460' AS DateTime), CAST(240000 AS Decimal(18, 0)), 49, 49, 0, 49, CAST(N'2025-03-13T17:44:06.460' AS DateTime), 0, NULL, NULL, CAST(144000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (49, CAST(N'2025-03-13T17:44:06.463' AS DateTime), CAST(245000 AS Decimal(18, 0)), 50, 50, 1, 50, CAST(N'2025-03-13T17:44:06.463' AS DateTime), 0, NULL, NULL, CAST(147000 AS Decimal(18, 0)))
INSERT [dbo].[Invoices] ([Id], [CreateDate], [Payment], [CustomerId], [UserId], [Type], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [PaidAmount]) VALUES (50, CAST(N'2025-03-13T17:44:06.463' AS DateTime), CAST(250000 AS Decimal(18, 0)), 1, 1, 2, 1, CAST(N'2025-03-13T17:44:06.463' AS DateTime), 0, NULL, NULL, CAST(150000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[Package] ON 

INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (1, N'10kg Pack', N'10kg Rice Package', 1, CAST(N'2025-03-01T10:45:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (2, N'5kg Pack', N'5kg Rice Package', 2, CAST(N'2025-03-01T10:50:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (3, N'Package 3', N'Description for package 3', 4, CAST(N'2025-03-13T17:44:01.687' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (4, N'Package 4', N'Description for package 4', 5, CAST(N'2025-03-13T17:44:01.693' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (5, N'Package 5', N'Description for package 5', 6, CAST(N'2025-03-13T17:44:01.697' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (6, N'Package 6', N'Description for package 6', 7, CAST(N'2025-03-13T17:44:01.697' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (7, N'Package 7', N'Description for package 7', 8, CAST(N'2025-03-13T17:44:01.700' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (8, N'Package 8', N'Description for package 8', 9, CAST(N'2025-03-13T17:44:01.700' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (9, N'Package 9', N'Description for package 9', 10, CAST(N'2025-03-13T17:44:01.700' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (10, N'Package 10', N'Description for package 10', 11, CAST(N'2025-03-13T17:44:01.703' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (11, N'Package 11', N'Description for package 11', 12, CAST(N'2025-03-13T17:44:01.703' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (12, N'Package 12', N'Description for package 12', 13, CAST(N'2025-03-13T17:44:01.707' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (13, N'Package 13', N'Description for package 13', 14, CAST(N'2025-03-13T17:44:01.707' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (14, N'Package 14', N'Description for package 14', 15, CAST(N'2025-03-13T17:44:01.707' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (15, N'Package 15', N'Description for package 15', 16, CAST(N'2025-03-13T17:44:01.707' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (16, N'Package 16', N'Description for package 16', 17, CAST(N'2025-03-13T17:44:01.710' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (17, N'Package 17', N'Description for package 17', 18, CAST(N'2025-03-13T17:44:01.710' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (18, N'Package 18', N'Description for package 18', 19, CAST(N'2025-03-13T17:44:01.710' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (19, N'Package 19', N'Description for package 19', 20, CAST(N'2025-03-13T17:44:01.710' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (20, N'Package 20', N'Description for package 20', 21, CAST(N'2025-03-13T17:44:01.713' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (21, N'Package 21', N'Description for package 21', 22, CAST(N'2025-03-13T17:44:01.717' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (22, N'Package 22', N'Description for package 22', 23, CAST(N'2025-03-13T17:44:01.717' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (23, N'Package 23', N'Description for package 23', 24, CAST(N'2025-03-13T17:44:01.720' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (24, N'Package 24', N'Description for package 24', 25, CAST(N'2025-03-13T17:44:01.720' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (25, N'Package 25', N'Description for package 25', 26, CAST(N'2025-03-13T17:44:01.720' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (26, N'Package 26', N'Description for package 26', 27, CAST(N'2025-03-13T17:44:01.723' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (27, N'Package 27', N'Description for package 27', 28, CAST(N'2025-03-13T17:44:01.723' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (28, N'Package 28', N'Description for package 28', 29, CAST(N'2025-03-13T17:44:01.727' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (29, N'Package 29', N'Description for package 29', 30, CAST(N'2025-03-13T17:44:01.727' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (30, N'Package 30', N'Description for package 30', 31, CAST(N'2025-03-13T17:44:01.730' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (31, N'Package 31', N'Description for package 31', 32, CAST(N'2025-03-13T17:44:01.733' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (32, N'Package 32', N'Description for package 32', 33, CAST(N'2025-03-13T17:44:01.733' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (33, N'Package 33', N'Description for package 33', 34, CAST(N'2025-03-13T17:44:01.737' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (34, N'Package 34', N'Description for package 34', 35, CAST(N'2025-03-13T17:44:01.737' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (35, N'Package 35', N'Description for package 35', 36, CAST(N'2025-03-13T17:44:01.737' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (36, N'Package 36', N'Description for package 36', 37, CAST(N'2025-03-13T17:44:01.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (37, N'Package 37', N'Description for package 37', 38, CAST(N'2025-03-13T17:44:01.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (38, N'Package 38', N'Description for package 38', 39, CAST(N'2025-03-13T17:44:01.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (39, N'Package 39', N'Description for package 39', 40, CAST(N'2025-03-13T17:44:01.740' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (40, N'Package 40', N'Description for package 40', 41, CAST(N'2025-03-13T17:44:01.743' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (41, N'Package 41', N'Description for package 41', 42, CAST(N'2025-03-13T17:44:01.743' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (42, N'Package 42', N'Description for package 42', 43, CAST(N'2025-03-13T17:44:01.743' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (43, N'Package 43', N'Description for package 43', 44, CAST(N'2025-03-13T17:44:01.747' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (44, N'Package 44', N'Description for package 44', 45, CAST(N'2025-03-13T17:44:01.747' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (45, N'Package 45', N'Description for package 45', 46, CAST(N'2025-03-13T17:44:01.747' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (46, N'Package 46', N'Description for package 46', 47, CAST(N'2025-03-13T17:44:01.750' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (47, N'Package 47', N'Description for package 47', 48, CAST(N'2025-03-13T17:44:01.750' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (48, N'Package 48', N'Description for package 48', 49, CAST(N'2025-03-13T17:44:01.750' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (49, N'Package 49', N'Description for package 49', 50, CAST(N'2025-03-13T17:44:01.750' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Package] ([Id], [Name], [Description], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (50, N'Package 50', N'Description for package 50', 1, CAST(N'2025-03-13T17:44:01.750' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Package] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (1, N'Jasmine Rice', N'jasmine.jpg', 100, 1, N'Premium Jasmine Rice', CAST(N'2025-03-01T10:35:00.000' AS DateTime), CAST(N'2025-03-01T10:35:00.000' AS DateTime), 1, 1, CAST(N'2025-03-01T10:35:00.000' AS DateTime), 0, NULL, 1, CAST(1000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (2, N'Sticky Rice', N'sticky.jpg', 50, 2, N'Sticky Rice for Special Dishes', CAST(N'2025-03-01T10:40:00.000' AS DateTime), CAST(N'2025-03-01T10:40:00.000' AS DateTime), 1, 2, CAST(N'2025-03-01T10:40:00.000' AS DateTime), 0, NULL, 1, CAST(1000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (3, N'Product 3', N'http://example.com/product3.jpg', 30, 4, N'Description for product 3', CAST(N'2025-03-13T17:43:55.210' AS DateTime), NULL, 0, 4, CAST(N'2025-03-13T17:43:55.210' AS DateTime), 0, NULL, NULL, CAST(3000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (4, N'Product 4', N'http://example.com/product4.jpg', 40, 5, N'Description for product 4', CAST(N'2025-03-13T17:43:55.213' AS DateTime), NULL, 1, 5, CAST(N'2025-03-13T17:43:55.213' AS DateTime), 0, NULL, NULL, CAST(4000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (5, N'Product 5', N'http://example.com/product5.jpg', 50, 6, N'Description for product 5', CAST(N'2025-03-13T17:43:55.213' AS DateTime), NULL, 2, 6, CAST(N'2025-03-13T17:43:55.213' AS DateTime), 0, NULL, NULL, CAST(5000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (6, N'Product 6', N'http://example.com/product6.jpg', 60, 7, N'Description for product 6', CAST(N'2025-03-13T17:43:55.213' AS DateTime), NULL, 0, 7, CAST(N'2025-03-13T17:43:55.213' AS DateTime), 0, NULL, NULL, CAST(6000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (7, N'Product 7', N'http://example.com/product7.jpg', 70, 8, N'Description for product 7', CAST(N'2025-03-13T17:43:55.217' AS DateTime), NULL, 1, 8, CAST(N'2025-03-13T17:43:55.217' AS DateTime), 0, NULL, NULL, CAST(7000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (8, N'Product 8', N'http://example.com/product8.jpg', 80, 9, N'Description for product 8', CAST(N'2025-03-13T17:43:55.217' AS DateTime), NULL, 2, 9, CAST(N'2025-03-13T17:43:55.217' AS DateTime), 0, NULL, NULL, CAST(8000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (9, N'Product 9', N'http://example.com/product9.jpg', 90, 10, N'Description for product 9', CAST(N'2025-03-13T17:43:55.217' AS DateTime), NULL, 0, 10, CAST(N'2025-03-13T17:43:55.217' AS DateTime), 0, NULL, NULL, CAST(9000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (10, N'Product 10', N'http://example.com/product10.jpg', 100, 11, N'Description for product 10', CAST(N'2025-03-13T17:43:55.220' AS DateTime), NULL, 1, 11, CAST(N'2025-03-13T17:43:55.220' AS DateTime), 0, NULL, NULL, CAST(10000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (11, N'Product 11', N'http://example.com/product11.jpg', 110, 12, N'Description for product 11', CAST(N'2025-03-13T17:43:55.220' AS DateTime), NULL, 2, 12, CAST(N'2025-03-13T17:43:55.220' AS DateTime), 0, NULL, NULL, CAST(11000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (12, N'Product 12', N'http://example.com/product12.jpg', 120, 13, N'Description for product 12', CAST(N'2025-03-13T17:43:55.220' AS DateTime), NULL, 0, 13, CAST(N'2025-03-13T17:43:55.220' AS DateTime), 0, NULL, NULL, CAST(12000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (13, N'Product 13', N'http://example.com/product13.jpg', 130, 14, N'Description for product 13', CAST(N'2025-03-13T17:43:55.223' AS DateTime), NULL, 1, 14, CAST(N'2025-03-13T17:43:55.223' AS DateTime), 0, NULL, NULL, CAST(13000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (14, N'Product 14', N'http://example.com/product14.jpg', 140, 15, N'Description for product 14', CAST(N'2025-03-13T17:43:55.223' AS DateTime), NULL, 2, 15, CAST(N'2025-03-13T17:43:55.223' AS DateTime), 0, NULL, NULL, CAST(14000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (15, N'Product 15', N'http://example.com/product15.jpg', 150, 16, N'Description for product 15', CAST(N'2025-03-13T17:43:55.227' AS DateTime), NULL, 0, 16, CAST(N'2025-03-13T17:43:55.227' AS DateTime), 0, NULL, NULL, CAST(15000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (16, N'Product 16', N'http://example.com/product16.jpg', 160, 17, N'Description for product 16', CAST(N'2025-03-13T17:43:55.227' AS DateTime), NULL, 1, 17, CAST(N'2025-03-13T17:43:55.227' AS DateTime), 0, NULL, NULL, CAST(16000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (17, N'Product 17', N'http://example.com/product17.jpg', 170, 18, N'Description for product 17', CAST(N'2025-03-13T17:43:55.227' AS DateTime), NULL, 2, 18, CAST(N'2025-03-13T17:43:55.227' AS DateTime), 0, NULL, NULL, CAST(17000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (18, N'Product 18', N'http://example.com/product18.jpg', 180, 19, N'Description for product 18', CAST(N'2025-03-13T17:43:55.227' AS DateTime), NULL, 0, 19, CAST(N'2025-03-13T17:43:55.227' AS DateTime), 0, NULL, NULL, CAST(18000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (19, N'Product 19', N'http://example.com/product19.jpg', 190, 20, N'Description for product 19', CAST(N'2025-03-13T17:43:55.230' AS DateTime), NULL, 1, 20, CAST(N'2025-03-13T17:43:55.230' AS DateTime), 0, NULL, NULL, CAST(19000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (20, N'Product 20', N'http://example.com/product20.jpg', 200, 21, N'Description for product 20', CAST(N'2025-03-13T17:43:55.230' AS DateTime), NULL, 2, 21, CAST(N'2025-03-13T17:43:55.230' AS DateTime), 0, NULL, NULL, CAST(20000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (21, N'Product 21', N'http://example.com/product21.jpg', 210, 22, N'Description for product 21', CAST(N'2025-03-13T17:43:55.230' AS DateTime), NULL, 0, 22, CAST(N'2025-03-13T17:43:55.230' AS DateTime), 0, NULL, NULL, CAST(21000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (22, N'Product 22', N'http://example.com/product22.jpg', 220, 23, N'Description for product 22', CAST(N'2025-03-13T17:43:55.233' AS DateTime), NULL, 1, 23, CAST(N'2025-03-13T17:43:55.233' AS DateTime), 0, NULL, NULL, CAST(22000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (23, N'Product 23', N'http://example.com/product23.jpg', 230, 24, N'Description for product 23', CAST(N'2025-03-13T17:43:55.237' AS DateTime), NULL, 2, 24, CAST(N'2025-03-13T17:43:55.237' AS DateTime), 0, NULL, NULL, CAST(23000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (24, N'Product 24', N'http://example.com/product24.jpg', 240, 25, N'Description for product 24', CAST(N'2025-03-13T17:43:55.237' AS DateTime), NULL, 0, 25, CAST(N'2025-03-13T17:43:55.237' AS DateTime), 0, NULL, NULL, CAST(24000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (25, N'Product 25', N'http://example.com/product25.jpg', 250, 26, N'Description for product 25', CAST(N'2025-03-13T17:43:55.240' AS DateTime), NULL, 1, 26, CAST(N'2025-03-13T17:43:55.240' AS DateTime), 0, NULL, NULL, CAST(25000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (26, N'Product 26', N'http://example.com/product26.jpg', 260, 27, N'Description for product 26', CAST(N'2025-03-13T17:43:55.240' AS DateTime), NULL, 2, 27, CAST(N'2025-03-13T17:43:55.240' AS DateTime), 0, NULL, NULL, CAST(26000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (27, N'Product 27', N'http://example.com/product27.jpg', 270, 28, N'Description for product 27', CAST(N'2025-03-13T17:43:55.240' AS DateTime), NULL, 0, 28, CAST(N'2025-03-13T17:43:55.240' AS DateTime), 0, NULL, NULL, CAST(27000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (28, N'Product 28', N'http://example.com/product28.jpg', 280, 29, N'Description for product 28', CAST(N'2025-03-13T17:43:55.243' AS DateTime), NULL, 1, 29, CAST(N'2025-03-13T17:43:55.243' AS DateTime), 0, NULL, NULL, CAST(28000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (29, N'Product 29', N'http://example.com/product29.jpg', 290, 30, N'Description for product 29', CAST(N'2025-03-13T17:43:55.243' AS DateTime), NULL, 2, 30, CAST(N'2025-03-13T17:43:55.243' AS DateTime), 0, NULL, NULL, CAST(29000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (30, N'Product 30', N'http://example.com/product30.jpg', 300, 31, N'Description for product 30', CAST(N'2025-03-13T17:43:55.243' AS DateTime), NULL, 0, 31, CAST(N'2025-03-13T17:43:55.243' AS DateTime), 0, NULL, NULL, CAST(30000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (31, N'Product 31', N'http://example.com/product31.jpg', 310, 32, N'Description for product 31', CAST(N'2025-03-13T17:43:55.247' AS DateTime), NULL, 1, 32, CAST(N'2025-03-13T17:43:55.247' AS DateTime), 0, NULL, NULL, CAST(31000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (32, N'Product 32', N'http://example.com/product32.jpg', 320, 33, N'Description for product 32', CAST(N'2025-03-13T17:43:55.247' AS DateTime), NULL, 2, 33, CAST(N'2025-03-13T17:43:55.247' AS DateTime), 0, NULL, NULL, CAST(32000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (33, N'Product 33', N'http://example.com/product33.jpg', 330, 34, N'Description for product 33', CAST(N'2025-03-13T17:43:55.250' AS DateTime), NULL, 0, 34, CAST(N'2025-03-13T17:43:55.250' AS DateTime), 0, NULL, NULL, CAST(33000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (34, N'Product 34', N'http://example.com/product34.jpg', 340, 35, N'Description for product 34', CAST(N'2025-03-13T17:43:55.250' AS DateTime), NULL, 1, 35, CAST(N'2025-03-13T17:43:55.250' AS DateTime), 0, NULL, NULL, CAST(34000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (35, N'Product 35', N'http://example.com/product35.jpg', 350, 36, N'Description for product 35', CAST(N'2025-03-13T17:43:55.250' AS DateTime), NULL, 2, 36, CAST(N'2025-03-13T17:43:55.250' AS DateTime), 0, NULL, NULL, CAST(35000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (36, N'Product 36', N'http://example.com/product36.jpg', 360, 37, N'Description for product 36', CAST(N'2025-03-13T17:43:55.253' AS DateTime), NULL, 0, 37, CAST(N'2025-03-13T17:43:55.253' AS DateTime), 0, NULL, NULL, CAST(36000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (37, N'Product 37', N'http://example.com/product37.jpg', 370, 38, N'Description for product 37', CAST(N'2025-03-13T17:43:55.253' AS DateTime), NULL, 1, 38, CAST(N'2025-03-13T17:43:55.253' AS DateTime), 0, NULL, NULL, CAST(37000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (38, N'Product 38', N'http://example.com/product38.jpg', 380, 39, N'Description for product 38', CAST(N'2025-03-13T17:43:55.253' AS DateTime), NULL, 2, 39, CAST(N'2025-03-13T17:43:55.253' AS DateTime), 0, NULL, NULL, CAST(38000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (39, N'Product 39', N'http://example.com/product39.jpg', 390, 40, N'Description for product 39', CAST(N'2025-03-13T17:43:55.257' AS DateTime), NULL, 0, 40, CAST(N'2025-03-13T17:43:55.257' AS DateTime), 0, NULL, NULL, CAST(39000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (40, N'Product 40', N'http://example.com/product40.jpg', 400, 41, N'Description for product 40', CAST(N'2025-03-13T17:43:55.257' AS DateTime), NULL, 1, 41, CAST(N'2025-03-13T17:43:55.257' AS DateTime), 0, NULL, NULL, CAST(40000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (41, N'Product 41', N'http://example.com/product41.jpg', 410, 42, N'Description for product 41', CAST(N'2025-03-13T17:43:55.257' AS DateTime), NULL, 2, 42, CAST(N'2025-03-13T17:43:55.257' AS DateTime), 0, NULL, NULL, CAST(41000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (42, N'Product 42', N'http://example.com/product42.jpg', 420, 43, N'Description for product 42', CAST(N'2025-03-13T17:43:55.260' AS DateTime), NULL, 0, 43, CAST(N'2025-03-13T17:43:55.260' AS DateTime), 0, NULL, NULL, CAST(42000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (43, N'Product 43', N'http://example.com/product43.jpg', 430, 44, N'Description for product 43', CAST(N'2025-03-13T17:43:55.260' AS DateTime), NULL, 1, 44, CAST(N'2025-03-13T17:43:55.260' AS DateTime), 0, NULL, NULL, CAST(43000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (44, N'Product 44', N'http://example.com/product44.jpg', 440, 45, N'Description for product 44', CAST(N'2025-03-13T17:43:55.260' AS DateTime), NULL, 2, 45, CAST(N'2025-03-13T17:43:55.260' AS DateTime), 0, NULL, NULL, CAST(44000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (45, N'Product 45', N'http://example.com/product45.jpg', 450, 46, N'Description for product 45', CAST(N'2025-03-13T17:43:55.263' AS DateTime), NULL, 0, 46, CAST(N'2025-03-13T17:43:55.263' AS DateTime), 0, NULL, NULL, CAST(45000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (46, N'Product 46', N'http://example.com/product46.jpg', 460, 47, N'Description for product 46', CAST(N'2025-03-13T17:43:55.263' AS DateTime), NULL, 1, 47, CAST(N'2025-03-13T17:43:55.263' AS DateTime), 0, NULL, NULL, CAST(46000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (47, N'Product 47', N'http://example.com/product47.jpg', 470, 48, N'Description for product 47', CAST(N'2025-03-13T17:43:55.263' AS DateTime), NULL, 2, 48, CAST(N'2025-03-13T17:43:55.263' AS DateTime), 0, NULL, NULL, CAST(47000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (48, N'Product 48', N'http://example.com/product48.jpg', 480, 49, N'Description for product 48', CAST(N'2025-03-13T17:43:55.267' AS DateTime), NULL, 0, 49, CAST(N'2025-03-13T17:43:55.267' AS DateTime), 0, NULL, NULL, CAST(48000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (49, N'Product 49', N'http://example.com/product49.jpg', 490, 50, N'Description for product 49', CAST(N'2025-03-13T17:43:55.267' AS DateTime), NULL, 1, 50, CAST(N'2025-03-13T17:43:55.267' AS DateTime), 0, NULL, NULL, CAST(49000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Image], [Quantity], [ZoneId], [Description], [CreatedDate], [UpdatedDate], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy], [Amount]) VALUES (50, N'Product 50', N'http://example.com/product50.jpg', 500, 1, N'Description for product 50', CAST(N'2025-03-13T17:43:55.267' AS DateTime), NULL, 2, 1, CAST(N'2025-03-13T17:43:55.267' AS DateTime), 0, NULL, NULL, CAST(50000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (1, N'Admin User', N'0909123456', N'123 Admin St', N'admin', N'hashedpass1', N'Admin', N'admin@example.com', 0, NULL, CAST(N'2025-03-01T10:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (2, N'Owner 1', N'0909123457', N'456 Owner Rd', N'owner1', N'hashedpass2', N'Owner', N'owner1@example.com', 0, 1, CAST(N'2025-03-01T10:05:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (3, N'Staff 1', N'0909123458', N'789 Staff Ln', N'staff1', N'hashedpass3', N'Staff', N'staff1@example.com', 0, 1, CAST(N'2025-03-01T10:10:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (4, N'User 4', N'090000004', N'Address 4', N'user4', N'hashed_password_4', N'Owner', N'user4@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.817' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (5, N'User 5', N'090000005', N'Address 5', N'user5', N'hashed_password_5', N'Staff', N'user5@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.820' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (6, N'User 6', N'090000006', N'Address 6', N'user6', N'hashed_password_6', N'Admin', N'user6@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.823' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (7, N'User 7', N'090000007', N'Address 7', N'user7', N'hashed_password_7', N'Owner', N'user7@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.827' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (8, N'User 8', N'090000008', N'Address 8', N'user8', N'hashed_password_8', N'Staff', N'user8@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.827' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (9, N'User 9', N'090000009', N'Address 9', N'user9', N'hashed_password_9', N'Admin', N'user9@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (10, N'User 10', N'090000010', N'Address 10', N'user10', N'hashed_password_10', N'Owner', N'user10@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (11, N'User 11', N'090000011', N'Address 11', N'user11', N'hashed_password_11', N'Staff', N'user11@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (12, N'User 12', N'090000012', N'Address 12', N'user12', N'hashed_password_12', N'Admin', N'user12@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (13, N'User 13', N'090000013', N'Address 13', N'user13', N'hashed_password_13', N'Owner', N'user13@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (14, N'User 14', N'090000014', N'Address 14', N'user14', N'hashed_password_14', N'Staff', N'user14@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (15, N'User 15', N'090000015', N'Address 15', N'user15', N'hashed_password_15', N'Admin', N'user15@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (16, N'User 16', N'090000016', N'Address 16', N'user16', N'hashed_password_16', N'Owner', N'user16@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.830' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (17, N'User 17', N'090000017', N'Address 17', N'user17', N'hashed_password_17', N'Staff', N'user17@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.833' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (18, N'User 18', N'090000018', N'Address 18', N'user18', N'hashed_password_18', N'Admin', N'user18@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.837' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (19, N'User 19', N'090000019', N'Address 19', N'user19', N'hashed_password_19', N'Owner', N'user19@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.837' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (20, N'User 20', N'090000020', N'Address 20', N'user20', N'hashed_password_20', N'Staff', N'user20@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.840' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (21, N'User 21', N'090000021', N'Address 21', N'user21', N'hashed_password_21', N'Admin', N'user21@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.840' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (22, N'User 22', N'090000022', N'Address 22', N'user22', N'hashed_password_22', N'Owner', N'user22@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.840' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (23, N'User 23', N'090000023', N'Address 23', N'user23', N'hashed_password_23', N'Staff', N'user23@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.840' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (24, N'User 24', N'090000024', N'Address 24', N'user24', N'hashed_password_24', N'Admin', N'user24@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.843' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (25, N'User 25', N'090000025', N'Address 25', N'user25', N'hashed_password_25', N'Owner', N'user25@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.847' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (26, N'User 26', N'090000026', N'Address 26', N'user26', N'hashed_password_26', N'Staff', N'user26@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.847' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (27, N'User 27', N'090000027', N'Address 27', N'user27', N'hashed_password_27', N'Admin', N'user27@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.847' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (28, N'User 28', N'090000028', N'Address 28', N'user28', N'hashed_password_28', N'Owner', N'user28@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.850' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (29, N'User 29', N'090000029', N'Address 29', N'user29', N'hashed_password_29', N'Staff', N'user29@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.850' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (30, N'User 30', N'090000030', N'Address 30', N'user30', N'hashed_password_30', N'Admin', N'user30@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.850' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (31, N'User 31', N'090000031', N'Address 31', N'user31', N'hashed_password_31', N'Owner', N'user31@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.853' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (32, N'User 32', N'090000032', N'Address 32', N'user32', N'hashed_password_32', N'Staff', N'user32@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.857' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (33, N'User 33', N'090000033', N'Address 33', N'user33', N'hashed_password_33', N'Admin', N'user33@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.857' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (34, N'User 34', N'090000034', N'Address 34', N'user34', N'hashed_password_34', N'Owner', N'user34@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.860' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (35, N'User 35', N'090000035', N'Address 35', N'user35', N'hashed_password_35', N'Staff', N'user35@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.860' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (36, N'User 36', N'090000036', N'Address 36', N'user36', N'hashed_password_36', N'Admin', N'user36@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.863' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (37, N'User 37', N'090000037', N'Address 37', N'user37', N'hashed_password_37', N'Owner', N'user37@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.863' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (38, N'User 38', N'090000038', N'Address 38', N'user38', N'hashed_password_38', N'Staff', N'user38@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (39, N'User 39', N'090000039', N'Address 39', N'user39', N'hashed_password_39', N'Admin', N'user39@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (40, N'User 40', N'090000040', N'Address 40', N'user40', N'hashed_password_40', N'Owner', N'user40@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (41, N'User 41', N'090000041', N'Address 41', N'user41', N'hashed_password_41', N'Staff', N'user41@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.867' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (42, N'User 42', N'090000042', N'Address 42', N'user42', N'hashed_password_42', N'Admin', N'user42@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.870' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (43, N'User 43', N'090000043', N'Address 43', N'user43', N'hashed_password_43', N'Owner', N'user43@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.870' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (44, N'User 44', N'090000044', N'Address 44', N'user44', N'hashed_password_44', N'Staff', N'user44@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.870' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (45, N'User 45', N'090000045', N'Address 45', N'user45', N'hashed_password_45', N'Admin', N'user45@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.873' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (46, N'User 46', N'090000046', N'Address 46', N'user46', N'hashed_password_46', N'Owner', N'user46@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.873' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (47, N'User 47', N'090000047', N'Address 47', N'user47', N'hashed_password_47', N'Staff', N'user47@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (48, N'User 48', N'090000048', N'Address 48', N'user48', N'hashed_password_48', N'Admin', N'user48@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (49, N'User 49', N'090000049', N'Address 49', N'user49', N'hashed_password_49', N'Owner', N'user49@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.877' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash], [Role], [Email], [IsBanned], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (50, N'User 50', N'090000050', N'Address 50', N'user50', N'hashed_password_50', N'Staff', N'user50@example.com', 0, NULL, CAST(N'2025-03-13T17:43:32.880' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Zone] ON 

INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (1, N'Zone A', CAST(N'2025-03-01T10:15:00.000' AS DateTime), NULL, NULL, 1, 1, CAST(N'2025-03-01T10:15:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (2, N'Zone B', CAST(N'2025-03-01T10:20:00.000' AS DateTime), NULL, NULL, 1, 1, CAST(N'2025-03-01T10:20:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (3, N'Zone 3', CAST(N'2025-03-13T17:43:47.570' AS DateTime), NULL, NULL, 0, 4, CAST(N'2025-03-13T17:43:47.570' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (4, N'Zone 4', CAST(N'2025-03-13T17:43:47.573' AS DateTime), NULL, NULL, 1, 5, CAST(N'2025-03-13T17:43:47.573' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (5, N'Zone 5', CAST(N'2025-03-13T17:43:47.573' AS DateTime), NULL, NULL, 2, 6, CAST(N'2025-03-13T17:43:47.573' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (6, N'Zone 6', CAST(N'2025-03-13T17:43:47.577' AS DateTime), NULL, NULL, 0, 7, CAST(N'2025-03-13T17:43:47.577' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (7, N'Zone 7', CAST(N'2025-03-13T17:43:47.577' AS DateTime), NULL, NULL, 1, 8, CAST(N'2025-03-13T17:43:47.577' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (8, N'Zone 8', CAST(N'2025-03-13T17:43:47.577' AS DateTime), NULL, NULL, 2, 9, CAST(N'2025-03-13T17:43:47.577' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (9, N'Zone 9', CAST(N'2025-03-13T17:43:47.580' AS DateTime), NULL, NULL, 0, 10, CAST(N'2025-03-13T17:43:47.580' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (10, N'Zone 10', CAST(N'2025-03-13T17:43:47.580' AS DateTime), NULL, NULL, 1, 11, CAST(N'2025-03-13T17:43:47.580' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (11, N'Zone 11', CAST(N'2025-03-13T17:43:47.580' AS DateTime), NULL, NULL, 2, 12, CAST(N'2025-03-13T17:43:47.580' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (12, N'Zone 12', CAST(N'2025-03-13T17:43:47.583' AS DateTime), NULL, NULL, 0, 13, CAST(N'2025-03-13T17:43:47.583' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (13, N'Zone 13', CAST(N'2025-03-13T17:43:47.583' AS DateTime), NULL, NULL, 1, 14, CAST(N'2025-03-13T17:43:47.583' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (14, N'Zone 14', CAST(N'2025-03-13T17:43:47.583' AS DateTime), NULL, NULL, 2, 15, CAST(N'2025-03-13T17:43:47.583' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (15, N'Zone 15', CAST(N'2025-03-13T17:43:47.587' AS DateTime), NULL, NULL, 0, 16, CAST(N'2025-03-13T17:43:47.587' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (16, N'Zone 16', CAST(N'2025-03-13T17:43:47.587' AS DateTime), NULL, NULL, 1, 17, CAST(N'2025-03-13T17:43:47.587' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (17, N'Zone 17', CAST(N'2025-03-13T17:43:47.590' AS DateTime), NULL, NULL, 2, 18, CAST(N'2025-03-13T17:43:47.590' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (18, N'Zone 18', CAST(N'2025-03-13T17:43:47.590' AS DateTime), NULL, NULL, 0, 19, CAST(N'2025-03-13T17:43:47.590' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (19, N'Zone 19', CAST(N'2025-03-13T17:43:47.590' AS DateTime), NULL, NULL, 1, 20, CAST(N'2025-03-13T17:43:47.590' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (20, N'Zone 20', CAST(N'2025-03-13T17:43:47.593' AS DateTime), NULL, NULL, 2, 21, CAST(N'2025-03-13T17:43:47.593' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (21, N'Zone 21', CAST(N'2025-03-13T17:43:47.593' AS DateTime), NULL, NULL, 0, 22, CAST(N'2025-03-13T17:43:47.593' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (22, N'Zone 22', CAST(N'2025-03-13T17:43:47.593' AS DateTime), NULL, NULL, 1, 23, CAST(N'2025-03-13T17:43:47.593' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (23, N'Zone 23', CAST(N'2025-03-13T17:43:47.597' AS DateTime), NULL, NULL, 2, 24, CAST(N'2025-03-13T17:43:47.597' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (24, N'Zone 24', CAST(N'2025-03-13T17:43:47.597' AS DateTime), NULL, NULL, 0, 25, CAST(N'2025-03-13T17:43:47.597' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (25, N'Zone 25', CAST(N'2025-03-13T17:43:47.597' AS DateTime), NULL, NULL, 1, 26, CAST(N'2025-03-13T17:43:47.597' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (26, N'Zone 26', CAST(N'2025-03-13T17:43:47.600' AS DateTime), NULL, NULL, 2, 27, CAST(N'2025-03-13T17:43:47.600' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (27, N'Zone 27', CAST(N'2025-03-13T17:43:47.600' AS DateTime), NULL, NULL, 0, 28, CAST(N'2025-03-13T17:43:47.600' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (28, N'Zone 28', CAST(N'2025-03-13T17:43:47.603' AS DateTime), NULL, NULL, 1, 29, CAST(N'2025-03-13T17:43:47.603' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (29, N'Zone 29', CAST(N'2025-03-13T17:43:47.603' AS DateTime), NULL, NULL, 2, 30, CAST(N'2025-03-13T17:43:47.603' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (30, N'Zone 30', CAST(N'2025-03-13T17:43:47.603' AS DateTime), NULL, NULL, 0, 31, CAST(N'2025-03-13T17:43:47.603' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (31, N'Zone 31', CAST(N'2025-03-13T17:43:47.607' AS DateTime), NULL, NULL, 1, 32, CAST(N'2025-03-13T17:43:47.607' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (32, N'Zone 32', CAST(N'2025-03-13T17:43:47.607' AS DateTime), NULL, NULL, 2, 33, CAST(N'2025-03-13T17:43:47.607' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (33, N'Zone 33', CAST(N'2025-03-13T17:43:47.610' AS DateTime), NULL, NULL, 0, 34, CAST(N'2025-03-13T17:43:47.610' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (34, N'Zone 34', CAST(N'2025-03-13T17:43:47.610' AS DateTime), NULL, NULL, 1, 35, CAST(N'2025-03-13T17:43:47.610' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (35, N'Zone 35', CAST(N'2025-03-13T17:43:47.610' AS DateTime), NULL, NULL, 2, 36, CAST(N'2025-03-13T17:43:47.610' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (36, N'Zone 36', CAST(N'2025-03-13T17:43:47.613' AS DateTime), NULL, NULL, 0, 37, CAST(N'2025-03-13T17:43:47.613' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (37, N'Zone 37', CAST(N'2025-03-13T17:43:47.613' AS DateTime), NULL, NULL, 1, 38, CAST(N'2025-03-13T17:43:47.613' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (38, N'Zone 38', CAST(N'2025-03-13T17:43:47.617' AS DateTime), NULL, NULL, 2, 39, CAST(N'2025-03-13T17:43:47.617' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (39, N'Zone 39', CAST(N'2025-03-13T17:43:47.617' AS DateTime), NULL, NULL, 0, 40, CAST(N'2025-03-13T17:43:47.617' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (40, N'Zone 40', CAST(N'2025-03-13T17:43:47.617' AS DateTime), NULL, NULL, 1, 41, CAST(N'2025-03-13T17:43:47.617' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (41, N'Zone 41', CAST(N'2025-03-13T17:43:47.620' AS DateTime), NULL, NULL, 2, 42, CAST(N'2025-03-13T17:43:47.620' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (42, N'Zone 42', CAST(N'2025-03-13T17:43:47.620' AS DateTime), NULL, NULL, 0, 43, CAST(N'2025-03-13T17:43:47.620' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (43, N'Zone 43', CAST(N'2025-03-13T17:43:47.620' AS DateTime), NULL, NULL, 1, 44, CAST(N'2025-03-13T17:43:47.620' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (44, N'Zone 44', CAST(N'2025-03-13T17:43:47.623' AS DateTime), NULL, NULL, 2, 45, CAST(N'2025-03-13T17:43:47.623' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (45, N'Zone 45', CAST(N'2025-03-13T17:43:47.623' AS DateTime), NULL, NULL, 0, 46, CAST(N'2025-03-13T17:43:47.623' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (46, N'Zone 46', CAST(N'2025-03-13T17:43:47.627' AS DateTime), NULL, NULL, 1, 47, CAST(N'2025-03-13T17:43:47.627' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (47, N'Zone 47', CAST(N'2025-03-13T17:43:47.627' AS DateTime), NULL, NULL, 2, 48, CAST(N'2025-03-13T17:43:47.627' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (48, N'Zone 48', CAST(N'2025-03-13T17:43:47.627' AS DateTime), NULL, NULL, 0, 49, CAST(N'2025-03-13T17:43:47.627' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (49, N'Zone 49', CAST(N'2025-03-13T17:43:47.630' AS DateTime), NULL, NULL, 1, 50, CAST(N'2025-03-13T17:43:47.630' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Zone] ([Id], [Name], [CreatedDate], [UpdatedDate], [UpdatedBy], [Status], [CreatedBy], [CreatedAt], [IsDeleted], [DeletedAt], [DeletedBy]) VALUES (50, N'Zone 50', CAST(N'2025-03-13T17:43:47.630' AS DateTime), NULL, NULL, 2, 1, CAST(N'2025-03-13T17:43:47.630' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Zone] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__85FB4E38A171055B]    Script Date: 3/14/2025 1:39:23 AM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4C6816A9C]    Script Date: 3/14/2025 1:39:23 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__85FB4E38CC626D0B]    Script Date: 3/14/2025 1:39:23 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Debts] ADD  DEFAULT (getdate()) FOR [DebtDate]
GO
ALTER TABLE [dbo].[Debts] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Debts] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[InvoiceDetails] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Package] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Package] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsBanned]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Zone] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Zone] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Debts]  WITH NOCHECK ADD  CONSTRAINT [FK_Debts_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Debts] CHECK CONSTRAINT [FK_Debts_CreatedBy]
GO
ALTER TABLE [dbo].[Debts]  WITH NOCHECK ADD  CONSTRAINT [FK_Debts_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Debts] CHECK CONSTRAINT [FK_Debts_Customers]
GO
ALTER TABLE [dbo].[Debts]  WITH NOCHECK ADD  CONSTRAINT [FK_Debts_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Debts] CHECK CONSTRAINT [FK_Debts_DeletedBy]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_InvoiceDetails_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_CreatedBy]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_InvoiceDetails_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_DeletedBy]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_InvoiceDetails_Invoices] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoices] ([Id])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_Invoices]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_InvoiceDetails_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_Product]
GO
ALTER TABLE [dbo].[Invoices]  WITH NOCHECK ADD  CONSTRAINT [FK_Invoices_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_CreatedBy]
GO
ALTER TABLE [dbo].[Invoices]  WITH NOCHECK ADD  CONSTRAINT [FK_Invoices_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_Customers]
GO
ALTER TABLE [dbo].[Invoices]  WITH NOCHECK ADD  CONSTRAINT [FK_Invoices_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_DeletedBy]
GO
ALTER TABLE [dbo].[Invoices]  WITH NOCHECK ADD  CONSTRAINT [FK_Invoices_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_Users]
GO
ALTER TABLE [dbo].[Package]  WITH NOCHECK ADD  CONSTRAINT [FK_Package_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Package] CHECK CONSTRAINT [FK_Package_CreatedBy]
GO
ALTER TABLE [dbo].[Package]  WITH NOCHECK ADD  CONSTRAINT [FK_Package_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Package] CHECK CONSTRAINT [FK_Package_DeletedBy]
GO
ALTER TABLE [dbo].[Product]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_CreatedBy]
GO
ALTER TABLE [dbo].[Product]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_DeletedBy]
GO
ALTER TABLE [dbo].[Product]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_Zone] FOREIGN KEY([ZoneId])
REFERENCES [dbo].[Zone] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Zone]
GO
ALTER TABLE [dbo].[Users]  WITH NOCHECK ADD  CONSTRAINT [FK_Users_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_CreatedBy]
GO
ALTER TABLE [dbo].[Users]  WITH NOCHECK ADD  CONSTRAINT [FK_Users_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_DeletedBy]
GO
ALTER TABLE [dbo].[Zone]  WITH NOCHECK ADD  CONSTRAINT [FK_Zone_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Zone] CHECK CONSTRAINT [FK_Zone_CreatedBy]
GO
ALTER TABLE [dbo].[Zone]  WITH NOCHECK ADD  CONSTRAINT [FK_Zone_DeletedBy] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Zone] CHECK CONSTRAINT [FK_Zone_DeletedBy]
GO
ALTER TABLE [dbo].[Zone]  WITH NOCHECK ADD  CONSTRAINT [FK_Zone_UpdatedBy] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Zone] CHECK CONSTRAINT [FK_Zone_UpdatedBy]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CK_Customers_Gender] CHECK  (([Gender]='Other' OR [Gender]='Female' OR [Gender]='Male'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CK_Customers_Gender]
GO
ALTER TABLE [dbo].[Debts]  WITH NOCHECK ADD  CONSTRAINT [CK_Debts_DebtType] CHECK  (([DebtType]=(1) OR [DebtType]=(0)))
GO
ALTER TABLE [dbo].[Debts] CHECK CONSTRAINT [CK_Debts_DebtType]
GO
ALTER TABLE [dbo].[Users]  WITH NOCHECK ADD  CONSTRAINT [CK_Users_Role] CHECK  (([Role]='Admin' OR [Role]='Owner' OR [Role]='Staff'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK_Users_Role]
GO
