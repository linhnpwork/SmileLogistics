USE [Smile_Logistics]
GO
/****** Object:  Table [dbo].[CustomerQuotation_Customs]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerQuotation_Customs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Expire_Start] [datetime] NOT NULL,
	[Expire_End] [datetime] NOT NULL,
	[IsUSD] [bit] NOT NULL,
	[USDRate] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_CustomerQuotation_Customs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerQuotation_CustomsDetails]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerQuotation_CustomsDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuotationID] [int] NOT NULL,
	[FeeDetailID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_CustomerQuotation_CustomsDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerQuotation_Routes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerQuotation_Routes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[QuotationID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[IsSamePrice] [bit] NOT NULL,
	[Price_RoundedTrip] [float] NOT NULL,
	[Expire_Start] [datetime] NOT NULL,
	[Expire_End] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[IsUSD] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerQuotation_Routes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomProcess_FeeDetails]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomProcess_FeeDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FeeTypeID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[IsUSD] [bit] NOT NULL,
	[ExpireFrom] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_CustomProcess_FeeDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomsProcess_FeeTypes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomsProcess_FeeTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_CustomsProcess_FeeTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GoodsTypes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoodsTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_GoodsTypes_UpdatedBy]  DEFAULT ((0)),
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_GoodsTypes_LastestUpdated]  DEFAULT (getdate()),
 CONSTRAINT [PK_GoodsTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_InOutFees]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_InOutFees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Company] [nvarchar](50) NOT NULL,
	[InvoiceNO] [nvarchar](50) NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[Money] [float] NOT NULL,
	[AttachedFiles] [ntext] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Job_InOutFees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_QuotationRoutes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_QuotationRoutes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NOT NULL,
	[RouteID] [int] NOT NULL,
	[Description] [ntext] NOT NULL,
	[ExtraFee] [float] NOT NULL,
	[DriverPhoneNumber] [nvarchar](50) NOT NULL,
	[VehicleNO] [nvarchar](50) NOT NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdate] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[USDRate] [float] NOT NULL,
 CONSTRAINT [PK_Job_QuotationRoutes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jobs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[InvoiceNO] [nvarchar](500) NOT NULL,
	[BillLadingNO] [nvarchar](500) NOT NULL,
	[TKHQNO] [nvarchar](500) NOT NULL,
	[JobID] [nvarchar](50) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Quotation_TransportID] [int] NOT NULL,
	[Quotation_CustomProcID] [int] NOT NULL,
	[ProcessedDate] [datetime] NOT NULL,
	[ConsignedDate] [datetime] NOT NULL,
	[DriverPhoneNumber] [nvarchar](50) NOT NULL,
	[VehicleNO] [nvarchar](50) NOT NULL,
	[IsConsigned] [bit] NOT NULL,
	[IsInformTransportComp] [bit] NOT NULL,
	[IsPayedForTransportComp] [bit] NOT NULL,
	[Status] [int] NOT NULL,
	[IsUrgent] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[AttachedFiles] [ntext] NOT NULL,
	[IsPaidFromCustomer] [bit] NOT NULL,
	[CustomerPrepaids] [float] NOT NULL,
 CONSTRAINT [PK_Jobs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Prepaids]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prepaids](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NOT NULL,
	[AgentID] [int] NOT NULL,
	[PaidDate] [datetime] NOT NULL,
	[RequestedDate] [datetime] NOT NULL,
	[Description] [ntext] NOT NULL,
	[Status] [int] NOT NULL,
	[TotalRequest] [float] NOT NULL,
	[TotalPaid] [float] NOT NULL,
	[AttachedFiles] [ntext] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdate] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Prepaids] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quotation_Routes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quotation_Routes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RouteID] [int] NOT NULL,
	[VehicleLoadID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[IsSamePrice] [bit] NOT NULL,
	[Price_RoundedTrip] [float] NOT NULL,
	[Expire_Start] [datetime] NOT NULL,
	[Expire_End] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[IsUSD] [bit] NOT NULL,
 CONSTRAINT [PK_Quotation_Routes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sys_Modules]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sys_Modules](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Alias] [nvarchar](50) NOT NULL,
	[Path] [nvarchar](500) NOT NULL,
	[IconClass] [nvarchar](50) NOT NULL,
	[ParentID] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[Description] [ntext] NOT NULL,
	[Actions] [ntext] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Sys_Modules_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Sys_Modules] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sys_Permissions]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sys_Permissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[ModuleID] [int] NOT NULL,
	[Permissions] [ntext] NOT NULL,
 CONSTRAINT [PK_Sys_Permissions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sys_Roles]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sys_Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[CanAccessSystemMenu] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Sys_Roles_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Sys_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sys_Users]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sys_Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Lastname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Avatar] [nvarchar](500) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Status] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Sys_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompanies]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportCompanies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_TransportCompanies_LastestUpdated]  DEFAULT (getdate()),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_TransportCompanies_UpdatedBy]  DEFAULT ((0)),
 CONSTRAINT [PK_TransportCompanies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompany_Routes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportCompany_Routes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransCompID] [int] NOT NULL,
	[StartPoint] [int] NOT NULL,
	[EndPoint] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_TransportCompany_Routes_LastestUpdated]  DEFAULT (getdate()),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_TransportCompany_Routes_UpdatedBy]  DEFAULT ((0)),
 CONSTRAINT [PK_TransportCompany_Routes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompany_VehicleType_Loads]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportCompany_VehicleType_Loads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransComp_VehicleTypeID] [int] NOT NULL,
	[VehicleLoadID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_TransportCompany_VehicleType_Loads_IsDeleted]  DEFAULT ((0)),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_TransportCompany_VehicleType_Loads_UpdatedBy]  DEFAULT ((0)),
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_TransportCompany_VehicleType_Loads_LastestUpdated]  DEFAULT (getdate()),
 CONSTRAINT [PK_TransportCompany_VehicleType_Loads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompany_VehicleTypes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportCompany_VehicleTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransCompID] [int] NOT NULL,
	[VehicleTypeID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_TransportCompany_VehicleTypes_IsDeleted]  DEFAULT ((0)),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_TransportCompany_VehicleTypes_UpdatedBy]  DEFAULT ((0)),
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_TransportCompany_VehicleTypes_LastestUpdated]  DEFAULT (getdate()),
 CONSTRAINT [PK_TransportCompany_VehicleTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportPlaces]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportPlaces](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_TransportPlaces_LastestUpdated]  DEFAULT (getdate()),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_TransportPlaces_UpdatedBy]  DEFAULT ((0)),
 CONSTRAINT [PK_TransportPlaces] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleLoads]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleLoads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[FullLoad] [float] NOT NULL,
	[VehicleTypeID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_VehicleLoads_IsDeleted]  DEFAULT ((0)),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_VehicleLoads_UpdatedBy]  DEFAULT ((0)),
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_VehicleLoads_LastestUpdated]  DEFAULT (getdate()),
 CONSTRAINT [PK_VehicleLoads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleTypes]    Script Date: 21-Feb-17 23:25:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[GoodsTypeID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_VehicleTypes_IsDeleted]  DEFAULT ((0)),
	[UpdatedBy] [int] NOT NULL CONSTRAINT [DF_VehicleTypes_UpdatedBy]  DEFAULT ((0)),
	[LastestUpdated] [datetime] NOT NULL CONSTRAINT [DF_VehicleTypes_LastestUpdated]  DEFAULT (getdate()),
 CONSTRAINT [PK_VehicleTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[GoodsTypes] ON 

INSERT [dbo].[GoodsTypes] ([ID], [Name], [Code], [Description], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, N'Hàng lẻ', N'LCL', N'Hàng chở xe tải', 0, 1, CAST(N'2017-02-17 22:29:55.347' AS DateTime))
INSERT [dbo].[GoodsTypes] ([ID], [Name], [Code], [Description], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, N'Hàng cont', N'FCL', N'Hàng chở xe container', 0, 1, CAST(N'2017-02-17 22:35:03.433' AS DateTime))
SET IDENTITY_INSERT [dbo].[GoodsTypes] OFF
SET IDENTITY_INSERT [dbo].[Sys_Modules] ON 

INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (1, N'Danh mục', N'danh-muc', N'#', N'gi gi-show_thumbnails', -2147483648, 0, N'Danh mục', N'@0;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (2, N'Loại hàng hóa', N'loai-hang-hoa', N'~/modules/functions/GoodsTypes.ascx', N'gi gi-cargo', 1, 1, N'Loại hàng hóa', N'@0;@1;@2;@3;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (3, N'Loại xe', N'loai-xe', N'~/modules/functions/VehicleTypes.ascx', N'gi gi-truck', 1, 1, N'Loại xe', N'@0;@1;@2;@3;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (4, N'Tải trọng xe', N'tai-trong-xe', N'~/modules/functions/Vehicleloads.ascx', N'hi hi-download-alt', 1, 1, N'Tải trọng xe', N'@0;@1;@2;@3;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (5, N'Vận chuyển', N'van-chuyen', N'#', N'gi gi-transfer', -2147483648, 0, N'Vận chuyển', N'@0;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (6, N'Địa điểm vận chuyển', N'dia-diem-van-chuyen', N'~/modules/functions/TransportPlaces.ascx', N'fa fa-map-marker', 5, 1, N'Địa điểm vận chuyển', N'@0;@1;@2;@3;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (7, N'Hãng vận chuyển', N'hang-van-chuyen', N'~/modules/functions/TransportCompanies.ascx', N'gi gi-cars', 5, 1, N'Hãng vận chuyển', N'@0;@1;@2;@3;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (8, N'Tuyến đường', N'tuyen-duong', N'~/modules/functions/Routes.ascx', N'gi gi-git_compare', 5, 1, N'Tuyến đường theo từng Hãng vận chuyển', N'@0;@1;@2;@3;', 0)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted]) VALUES (9, N'Báo giá vận chuyển', N'bao-gia-van-chuyen', N'~/modules/functions/QuotationRoutes.ascx', N'gi gi-money', 5, 1, N'Báo giá vận chuyển', N'@0;@1;@2;@3;', 0)
SET IDENTITY_INSERT [dbo].[Sys_Modules] OFF
SET IDENTITY_INSERT [dbo].[Sys_Roles] ON 

INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (1, N'God Administrator', N'God Administrators', 1, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (2, N'Nhân viên hiện trường', N'Nhân viên hiện trường', 0, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (3, N'Kế toán', N'Kế toán', 0, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (4, N'Giám đốc', N'Giám đốc', 1, 0)
SET IDENTITY_INSERT [dbo].[Sys_Roles] OFF
SET IDENTITY_INSERT [dbo].[Sys_Users] ON 

INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (1, N'God', N'Administrator', N'Administrator@sl.com', N'GodAdministrator', N'D20616B153DBEF09830CEE32DFE2AE96DD758F56781DD200985DEB9B628136F2', CAST(N'2017-02-17 22:23:15.000' AS DateTime), N'', N'', N'093.5757.345', 1, 1, 0)
SET IDENTITY_INSERT [dbo].[Sys_Users] OFF
SET IDENTITY_INSERT [dbo].[TransportCompanies] ON 

INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, N'Hãng A', N'HCM', N'', N'', 0, 0, CAST(N'2017-02-20 01:19:11.030' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TransportCompanies] OFF
SET IDENTITY_INSERT [dbo].[TransportCompany_Routes] ON 

INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, 1, 1, 2, 0, CAST(N'2017-02-21 16:26:58.600' AS DateTime), 1)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (2, 1, 4, 1, 0, CAST(N'2017-02-21 16:28:09.620' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TransportCompany_Routes] OFF
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleType_Loads] ON 

INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, 1, 6, 0, 1, CAST(N'2017-02-20 01:19:11.060' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, 1, 7, 0, 1, CAST(N'2017-02-20 01:19:11.080' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (3, 2, 3, 0, 1, CAST(N'2017-02-20 01:19:11.150' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (4, 2, 4, 0, 1, CAST(N'2017-02-20 01:19:11.157' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (5, 2, 5, 0, 1, CAST(N'2017-02-20 01:19:11.163' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleType_Loads] OFF
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleTypes] ON 

INSERT [dbo].[TransportCompany_VehicleTypes] ([ID], [TransCompID], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, 1, 2, 0, 1, CAST(N'2017-02-20 01:10:42.730' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleTypes] ([ID], [TransCompID], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, 1, 1, 0, 1, CAST(N'2017-02-20 01:19:11.110' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleTypes] OFF
SET IDENTITY_INSERT [dbo].[TransportPlaces] ON 

INSERT [dbo].[TransportPlaces] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, N'Cảng Cát Lái', N'', N'', N'', 0, CAST(N'2017-02-19 14:49:17.537' AS DateTime), 1)
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (2, N'Kho Long Thành', N'', N'', N'', 0, CAST(N'2017-02-19 14:49:26.480' AS DateTime), 1)
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (3, N'Cảng Sóng Thần', N'', N'', N'', 0, CAST(N'2017-02-20 01:26:51.363' AS DateTime), 1)
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (4, N'Kho Tổng', N'', N'', N'', 0, CAST(N'2017-02-20 01:27:01.783' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TransportPlaces] OFF
SET IDENTITY_INSERT [dbo].[VehicleLoads] ON 

INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, N'Tải 1 tấn', N'1T', N'Tải 1 tấn', 1, 1, 0, 1, CAST(N'2017-02-18 00:17:06.143' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, N'Tải 2 tấn', N'2T', N'Tải 2 tấn', 2, 1, 0, 1, CAST(N'2017-02-18 00:17:20.283' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (3, N'Tải 3 tấn', N'3T', N'Tải 3 tấn', 3, 1, 0, 1, CAST(N'2017-02-18 00:17:35.770' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (4, N'Tải 5 tấn', N'5T', N'Tải 5 tấn', 5, 1, 0, 1, CAST(N'2017-02-18 00:17:48.940' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (5, N'Tải 8 tấn', N'8T', N'Tải 8 tấn', 8, 1, 0, 1, CAST(N'2017-02-18 00:18:03.643' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (6, N'Cont 20 feet', N'20F', N'Cont 20 feet', 20, 2, 0, 1, CAST(N'2017-02-18 00:18:38.533' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (7, N'Cont 40 feet', N'40F', N'Cont 40 feet', 40, 2, 0, 1, CAST(N'2017-02-18 00:18:54.913' AS DateTime))
SET IDENTITY_INSERT [dbo].[VehicleLoads] OFF
SET IDENTITY_INSERT [dbo].[VehicleTypes] ON 

INSERT [dbo].[VehicleTypes] ([ID], [Name], [Code], [Description], [GoodsTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, N'Xe tải', N'Truck', N'Xe tải', 1, 0, 1, CAST(N'2017-02-17 22:57:09.000' AS DateTime))
INSERT [dbo].[VehicleTypes] ([ID], [Name], [Code], [Description], [GoodsTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, N'Xe container', N'Container', N'Xe container', 2, 0, 1, CAST(N'2017-02-17 22:58:29.890' AS DateTime))
SET IDENTITY_INSERT [dbo].[VehicleTypes] OFF
ALTER TABLE [dbo].[CustomerQuotation_Routes] ADD  CONSTRAINT [DF_CustomerQuotation_Routes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] ADD  CONSTRAINT [DF_CustomerQuotation_Routes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] ADD  CONSTRAINT [DF_CustomerQuotation_Routes_IsUSD]  DEFAULT ((0)) FOR [IsUSD]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_AttachedFiles]  DEFAULT ('') FOR [AttachedFiles]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_IsPaidFromCustomer]  DEFAULT ((0)) FOR [IsPaidFromCustomer]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_CustomerPrepaids]  DEFAULT ((0)) FOR [CustomerPrepaids]
GO
ALTER TABLE [dbo].[Quotation_Routes] ADD  CONSTRAINT [DF_Quotation_Routes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[Quotation_Routes] ADD  CONSTRAINT [DF_Quotation_Routes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[Quotation_Routes] ADD  CONSTRAINT [DF_Quotation_Routes_IsUSD]  DEFAULT ((0)) FOR [IsUSD]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_Customs_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] CHECK CONSTRAINT [FK_CustomerQuotation_Customs_Sys_Users]
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_CustomsDetails_CustomerQuotation_Customs] FOREIGN KEY([QuotationID])
REFERENCES [dbo].[CustomerQuotation_Customs] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] CHECK CONSTRAINT [FK_CustomerQuotation_CustomsDetails_CustomerQuotation_Customs]
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_CustomsDetails_CustomProcess_FeeDetails] FOREIGN KEY([FeeDetailID])
REFERENCES [dbo].[CustomProcess_FeeDetails] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] CHECK CONSTRAINT [FK_CustomerQuotation_CustomsDetails_CustomProcess_FeeDetails]
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_CustomsDetails_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] CHECK CONSTRAINT [FK_CustomerQuotation_CustomsDetails_Sys_Users]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_Routes_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] CHECK CONSTRAINT [FK_CustomerQuotation_Routes_Customers]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_Routes_Quotation_Routes] FOREIGN KEY([QuotationID])
REFERENCES [dbo].[Quotation_Routes] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] CHECK CONSTRAINT [FK_CustomerQuotation_Routes_Quotation_Routes]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_Routes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] CHECK CONSTRAINT [FK_CustomerQuotation_Routes_Sys_Users]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Sys_Users]
GO
ALTER TABLE [dbo].[CustomProcess_FeeDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomProcess_FeeDetails_CustomsProcess_FeeTypes] FOREIGN KEY([FeeTypeID])
REFERENCES [dbo].[CustomsProcess_FeeTypes] ([ID])
GO
ALTER TABLE [dbo].[CustomProcess_FeeDetails] CHECK CONSTRAINT [FK_CustomProcess_FeeDetails_CustomsProcess_FeeTypes]
GO
ALTER TABLE [dbo].[CustomProcess_FeeDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomProcess_FeeDetails_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomProcess_FeeDetails] CHECK CONSTRAINT [FK_CustomProcess_FeeDetails_Sys_Users]
GO
ALTER TABLE [dbo].[CustomsProcess_FeeTypes]  WITH CHECK ADD  CONSTRAINT [FK_CustomsProcess_FeeTypes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomsProcess_FeeTypes] CHECK CONSTRAINT [FK_CustomsProcess_FeeTypes_Sys_Users]
GO
ALTER TABLE [dbo].[GoodsTypes]  WITH CHECK ADD  CONSTRAINT [FK_GoodsTypes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[GoodsTypes] CHECK CONSTRAINT [FK_GoodsTypes_Sys_Users]
GO
ALTER TABLE [dbo].[Job_InOutFees]  WITH CHECK ADD  CONSTRAINT [FK_Job_InOutFees_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[Jobs] ([ID])
GO
ALTER TABLE [dbo].[Job_InOutFees] CHECK CONSTRAINT [FK_Job_InOutFees_Jobs]
GO
ALTER TABLE [dbo].[Job_InOutFees]  WITH CHECK ADD  CONSTRAINT [FK_Job_InOutFees_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Job_InOutFees] CHECK CONSTRAINT [FK_Job_InOutFees_Sys_Users]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes]  WITH CHECK ADD  CONSTRAINT [FK_Job_QuotationRoutes_CustomerQuotation_Routes] FOREIGN KEY([RouteID])
REFERENCES [dbo].[CustomerQuotation_Routes] ([ID])
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] CHECK CONSTRAINT [FK_Job_QuotationRoutes_CustomerQuotation_Routes]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes]  WITH CHECK ADD  CONSTRAINT [FK_Job_QuotationRoutes_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[Jobs] ([ID])
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] CHECK CONSTRAINT [FK_Job_QuotationRoutes_Jobs]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes]  WITH CHECK ADD  CONSTRAINT [FK_Job_QuotationRoutes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] CHECK CONSTRAINT [FK_Job_QuotationRoutes_Sys_Users]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK_Jobs_CustomerQuotation_Customs] FOREIGN KEY([Quotation_CustomProcID])
REFERENCES [dbo].[CustomerQuotation_Customs] ([ID])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK_Jobs_CustomerQuotation_Customs]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK_Jobs_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([ID])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK_Jobs_Customers]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK_Jobs_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK_Jobs_Sys_Users]
GO
ALTER TABLE [dbo].[Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Prepaids_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[Jobs] ([ID])
GO
ALTER TABLE [dbo].[Prepaids] CHECK CONSTRAINT [FK_Prepaids_Jobs]
GO
ALTER TABLE [dbo].[Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Prepaids_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Prepaids] CHECK CONSTRAINT [FK_Prepaids_Sys_Users]
GO
ALTER TABLE [dbo].[Quotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_Quotation_Routes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Quotation_Routes] CHECK CONSTRAINT [FK_Quotation_Routes_Sys_Users]
GO
ALTER TABLE [dbo].[Quotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_Quotation_Routes_TransportCompany_Routes] FOREIGN KEY([RouteID])
REFERENCES [dbo].[TransportCompany_Routes] ([ID])
GO
ALTER TABLE [dbo].[Quotation_Routes] CHECK CONSTRAINT [FK_Quotation_Routes_TransportCompany_Routes]
GO
ALTER TABLE [dbo].[Quotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_Quotation_Routes_VehicleLoads] FOREIGN KEY([VehicleLoadID])
REFERENCES [dbo].[VehicleLoads] ([ID])
GO
ALTER TABLE [dbo].[Quotation_Routes] CHECK CONSTRAINT [FK_Quotation_Routes_VehicleLoads]
GO
ALTER TABLE [dbo].[Sys_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Sys_Permissions_Sys_Modules] FOREIGN KEY([ModuleID])
REFERENCES [dbo].[Sys_Modules] ([ID])
GO
ALTER TABLE [dbo].[Sys_Permissions] CHECK CONSTRAINT [FK_Sys_Permissions_Sys_Modules]
GO
ALTER TABLE [dbo].[Sys_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Sys_Permissions_Sys_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Sys_Roles] ([ID])
GO
ALTER TABLE [dbo].[Sys_Permissions] CHECK CONSTRAINT [FK_Sys_Permissions_Sys_Roles]
GO
ALTER TABLE [dbo].[Sys_Users]  WITH CHECK ADD  CONSTRAINT [FK_Sys_Users_Sys_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Sys_Roles] ([ID])
GO
ALTER TABLE [dbo].[Sys_Users] CHECK CONSTRAINT [FK_Sys_Users_Sys_Roles]
GO
ALTER TABLE [dbo].[TransportCompanies]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompanies_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[TransportCompanies] CHECK CONSTRAINT [FK_TransportCompanies_Sys_Users]
GO
ALTER TABLE [dbo].[TransportCompany_Routes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_Routes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_Routes] CHECK CONSTRAINT [FK_TransportCompany_Routes_Sys_Users]
GO
ALTER TABLE [dbo].[TransportCompany_Routes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_Routes_TransportCompanies] FOREIGN KEY([TransCompID])
REFERENCES [dbo].[TransportCompanies] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_Routes] CHECK CONSTRAINT [FK_TransportCompany_Routes_TransportCompanies]
GO
ALTER TABLE [dbo].[TransportCompany_Routes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_Routes_TransportPlaces] FOREIGN KEY([StartPoint])
REFERENCES [dbo].[TransportPlaces] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_Routes] CHECK CONSTRAINT [FK_TransportCompany_Routes_TransportPlaces]
GO
ALTER TABLE [dbo].[TransportCompany_Routes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_Routes_TransportPlaces1] FOREIGN KEY([EndPoint])
REFERENCES [dbo].[TransportPlaces] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_Routes] CHECK CONSTRAINT [FK_TransportCompany_Routes_TransportPlaces1]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_VehicleType_Loads_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads] CHECK CONSTRAINT [FK_TransportCompany_VehicleType_Loads_Sys_Users]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_VehicleType_Loads_TransportCompany_VehicleTypes] FOREIGN KEY([TransComp_VehicleTypeID])
REFERENCES [dbo].[TransportCompany_VehicleTypes] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads] CHECK CONSTRAINT [FK_TransportCompany_VehicleType_Loads_TransportCompany_VehicleTypes]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_VehicleType_Loads_VehicleLoads] FOREIGN KEY([VehicleLoadID])
REFERENCES [dbo].[VehicleLoads] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads] CHECK CONSTRAINT [FK_TransportCompany_VehicleType_Loads_VehicleLoads]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_VehicleTypes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes] CHECK CONSTRAINT [FK_TransportCompany_VehicleTypes_Sys_Users]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_VehicleTypes_TransportCompanies] FOREIGN KEY([TransCompID])
REFERENCES [dbo].[TransportCompanies] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes] CHECK CONSTRAINT [FK_TransportCompany_VehicleTypes_TransportCompanies]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes]  WITH CHECK ADD  CONSTRAINT [FK_TransportCompany_VehicleTypes_VehicleTypes] FOREIGN KEY([VehicleTypeID])
REFERENCES [dbo].[VehicleTypes] ([ID])
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes] CHECK CONSTRAINT [FK_TransportCompany_VehicleTypes_VehicleTypes]
GO
ALTER TABLE [dbo].[TransportPlaces]  WITH CHECK ADD  CONSTRAINT [FK_TransportPlaces_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[TransportPlaces] CHECK CONSTRAINT [FK_TransportPlaces_Sys_Users]
GO
ALTER TABLE [dbo].[VehicleLoads]  WITH CHECK ADD  CONSTRAINT [FK_VehicleLoads_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[VehicleLoads] CHECK CONSTRAINT [FK_VehicleLoads_Sys_Users]
GO
ALTER TABLE [dbo].[VehicleLoads]  WITH CHECK ADD  CONSTRAINT [FK_VehicleLoads_VehicleTypes] FOREIGN KEY([VehicleTypeID])
REFERENCES [dbo].[VehicleTypes] ([ID])
GO
ALTER TABLE [dbo].[VehicleLoads] CHECK CONSTRAINT [FK_VehicleLoads_VehicleTypes]
GO
ALTER TABLE [dbo].[VehicleTypes]  WITH CHECK ADD  CONSTRAINT [FK_VehicleTypes_GoodsTypes] FOREIGN KEY([GoodsTypeID])
REFERENCES [dbo].[GoodsTypes] ([ID])
GO
ALTER TABLE [dbo].[VehicleTypes] CHECK CONSTRAINT [FK_VehicleTypes_GoodsTypes]
GO
ALTER TABLE [dbo].[VehicleTypes]  WITH CHECK ADD  CONSTRAINT [FK_VehicleTypes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[VehicleTypes] CHECK CONSTRAINT [FK_VehicleTypes_Sys_Users]
GO
