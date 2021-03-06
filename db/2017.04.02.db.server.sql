USE [Smile_Logistics]
GO
/****** Object:  Table [dbo].[Agent_Prepaids]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agent_Prepaids](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NOT NULL,
	[AgentID] [int] NOT NULL,
	[RequestedDate] [datetime] NOT NULL,
	[ConfirmedDate] [datetime] NOT NULL,
	[Description] [ntext] NOT NULL,
	[Status] [int] NOT NULL,
	[TotalRequest] [float] NOT NULL,
	[TotalPaid] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdate] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[AttachedFiles] [ntext] NOT NULL,
	[ConfirmedBy] [int] NOT NULL,
	[JobWorkings] [ntext] NOT NULL,
 CONSTRAINT [PK_Prepaids] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer_Prepaids]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Prepaids](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Money] [float] NOT NULL,
	[Description] [ntext] NOT NULL,
	[PrepaidDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Customer_Prepaids] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerQuotation_Customs]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[UpdatedBy] [int] NOT NULL,
	[Total_In] [float] NOT NULL,
	[Total_Out] [float] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[Description] [ntext] NOT NULL,
	[DecreasePercentForSecondCont] [float] NOT NULL,
	[JobID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerQuotation_Customs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerQuotation_CustomsDetails]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerQuotation_CustomsDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuotationID] [int] NOT NULL,
	[FeeDetailID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[Description] [ntext] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Total] [float] NOT NULL,
	[Order] [int] NOT NULL,
 CONSTRAINT [PK_CustomerQuotation_CustomsDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerQuotation_Routes]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerQuotation_Routes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[QuotationID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Expire_Start] [datetime] NOT NULL,
	[Expire_End] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[IsUSD] [bit] NOT NULL,
	[PlaceStart] [int] NULL,
	[PlaceEnd] [int] NULL,
 CONSTRAINT [PK_CustomerQuotation_Routes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[Prepaids] [float] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomsProcess_FeeTypes]    Script Date: 4/2/2017 10:07:36 AM ******/
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
/****** Object:  Table [dbo].[CustomsProcess_QuotationDetails]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomsProcess_QuotationDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuotationID] [int] NOT NULL,
	[CustomsFeeID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_CustomsProcess_QuotationDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomsProcess_Quotations]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomsProcess_Quotations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExpireFrom] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[IsUSD] [bit] NOT NULL,
 CONSTRAINT [PK_CustomsProcess_Quotations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GoodsTypes]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_GoodsTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_InOutFees]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[IsUSD] [bit] NOT NULL,
 CONSTRAINT [PK_Job_InOutFees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_Prepaids]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_Prepaids](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NOT NULL,
	[Money] [float] NOT NULL,
	[Description] [ntext] NOT NULL,
	[PrepaidDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Job_Prepaids] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_QuotationRoutes]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[Loads] [float] NOT NULL,
	[PromotionByTransComp] [float] NOT NULL,
	[Total_Out] [float] NOT NULL,
	[Total_In] [float] NOT NULL,
	[PlaceStart] [int] NULL,
	[PlaceEnd] [int] NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Job_QuotationRoutes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_Workings]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_Workings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Job_Workings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[CustomerID] [int] NULL,
	[ProcessedDate] [datetime] NOT NULL,
	[ConsignedDate] [datetime] NOT NULL,
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
	[AgentPrepaids] [float] NOT NULL,
	[Total_Transport_In] [float] NOT NULL,
	[Total_Customs_In] [float] NOT NULL,
	[Total_In] [float] NOT NULL,
	[Total_Transport_Out] [float] NOT NULL,
	[Total_Customs_Out] [float] NOT NULL,
	[Total_Out] [float] NOT NULL,
	[USDRate] [float] NOT NULL,
 CONSTRAINT [PK_Jobs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quotation_Routes]    Script Date: 4/2/2017 10:07:36 AM ******/
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
/****** Object:  Table [dbo].[Sys_Modules]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[IsDeleted] [bit] NOT NULL,
	[ShowInMenu] [bit] NOT NULL,
 CONSTRAINT [PK_Sys_Modules] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sys_Permissions]    Script Date: 4/2/2017 10:07:36 AM ******/
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
/****** Object:  Table [dbo].[Sys_Roles]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sys_Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [ntext] NOT NULL,
	[CanAccessSystemMenu] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Sys_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sys_Users]    Script Date: 4/2/2017 10:07:36 AM ******/
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
/****** Object:  Table [dbo].[TransportCompanies]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_TransportCompanies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompany_Routes]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
 CONSTRAINT [PK_TransportCompany_Routes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompany_VehicleType_Loads]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportCompany_VehicleType_Loads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransComp_VehicleTypeID] [int] NOT NULL,
	[VehicleLoadID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_TransportCompany_VehicleType_Loads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportCompany_VehicleTypes]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportCompany_VehicleTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransCompID] [int] NOT NULL,
	[VehicleTypeID] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_TransportCompany_VehicleTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransportPlaces]    Script Date: 4/2/2017 10:07:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportPlaces](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_TransportPlaces] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleLoads]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_VehicleLoads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleTypes]    Script Date: 4/2/2017 10:07:36 AM ******/
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
	[IsDeleted] [bit] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[LastestUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_VehicleTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Agent_Prepaids] ON 

INSERT [dbo].[Agent_Prepaids] ([ID], [JobID], [AgentID], [RequestedDate], [ConfirmedDate], [Description], [Status], [TotalRequest], [TotalPaid], [IsDeleted], [LastestUpdate], [UpdatedBy], [AttachedFiles], [ConfirmedBy], [JobWorkings]) VALUES (1, 4, 4, CAST(N'2017-04-01T09:23:52.000' AS DateTime), CAST(N'2017-04-01T10:01:20.750' AS DateTime), N'inv', 1, 200000, 0, 0, CAST(N'2017-04-01T10:01:20.750' AS DateTime), 2, N'', 2, N'')
INSERT [dbo].[Agent_Prepaids] ([ID], [JobID], [AgentID], [RequestedDate], [ConfirmedDate], [Description], [Status], [TotalRequest], [TotalPaid], [IsDeleted], [LastestUpdate], [UpdatedBy], [AttachedFiles], [ConfirmedBy], [JobWorkings]) VALUES (2, 4, 5, CAST(N'2017-04-01T10:04:30.397' AS DateTime), CAST(N'2017-04-01T15:32:52.317' AS DateTime), N'inv', 1, 200000, 0, 0, CAST(N'2017-04-01T15:32:52.317' AS DateTime), 2, N'', 2, N'')
SET IDENTITY_INSERT [dbo].[Agent_Prepaids] OFF
SET IDENTITY_INSERT [dbo].[CustomerQuotation_Customs] ON 

INSERT [dbo].[CustomerQuotation_Customs] ([ID], [CustomerID], [Expire_Start], [Expire_End], [IsUSD], [USDRate], [IsDeleted], [UpdatedBy], [Total_In], [Total_Out], [LastestUpdated], [Description], [DecreasePercentForSecondCont], [JobID]) VALUES (1, 2, CAST(N'2017-03-01T00:00:00.000' AS DateTime), CAST(N'2017-03-31T00:00:00.000' AS DateTime), 0, 0, 0, 2, 0, 0, CAST(N'2017-03-27T00:20:37.690' AS DateTime), N'', 50, 4)
INSERT [dbo].[CustomerQuotation_Customs] ([ID], [CustomerID], [Expire_Start], [Expire_End], [IsUSD], [USDRate], [IsDeleted], [UpdatedBy], [Total_In], [Total_Out], [LastestUpdated], [Description], [DecreasePercentForSecondCont], [JobID]) VALUES (2, 2, CAST(N'2017-03-01T00:00:00.000' AS DateTime), CAST(N'2017-03-31T00:00:00.000' AS DateTime), 0, 0, 0, 2, 0, 0, CAST(N'2017-03-25T02:47:20.310' AS DateTime), N'', 50, 11)
SET IDENTITY_INSERT [dbo].[CustomerQuotation_Customs] OFF
SET IDENTITY_INSERT [dbo].[CustomerQuotation_CustomsDetails] ON 

INSERT [dbo].[CustomerQuotation_CustomsDetails] ([ID], [QuotationID], [FeeDetailID], [IsDeleted], [LastestUpdated], [UpdatedBy], [Description], [Quantity], [Total], [Order]) VALUES (1, 1, 6, 1, CAST(N'2017-03-21T02:46:29.393' AS DateTime), 2, N'', 2, 800000, 1)
INSERT [dbo].[CustomerQuotation_CustomsDetails] ([ID], [QuotationID], [FeeDetailID], [IsDeleted], [LastestUpdated], [UpdatedBy], [Description], [Quantity], [Total], [Order]) VALUES (2, 1, 7, 1, CAST(N'2017-03-21T02:46:29.377' AS DateTime), 2, N'', 2, 1350000, 1)
INSERT [dbo].[CustomerQuotation_CustomsDetails] ([ID], [QuotationID], [FeeDetailID], [IsDeleted], [LastestUpdated], [UpdatedBy], [Description], [Quantity], [Total], [Order]) VALUES (3, 2, 7, 0, CAST(N'2017-03-25T02:47:20.373' AS DateTime), 2, N'', 1, 0, 1)
INSERT [dbo].[CustomerQuotation_CustomsDetails] ([ID], [QuotationID], [FeeDetailID], [IsDeleted], [LastestUpdated], [UpdatedBy], [Description], [Quantity], [Total], [Order]) VALUES (4, 2, 6, 0, CAST(N'2017-03-25T02:47:20.387' AS DateTime), 2, N'', 1, 0, 1)
INSERT [dbo].[CustomerQuotation_CustomsDetails] ([ID], [QuotationID], [FeeDetailID], [IsDeleted], [LastestUpdated], [UpdatedBy], [Description], [Quantity], [Total], [Order]) VALUES (5, 2, 18, 0, CAST(N'2017-03-25T02:47:20.403' AS DateTime), 2, N'', 1, 0, 1)
INSERT [dbo].[CustomerQuotation_CustomsDetails] ([ID], [QuotationID], [FeeDetailID], [IsDeleted], [LastestUpdated], [UpdatedBy], [Description], [Quantity], [Total], [Order]) VALUES (6, 1, 18, 0, CAST(N'2017-03-27T00:20:37.753' AS DateTime), 2, N'', 1, 0, 1)
SET IDENTITY_INSERT [dbo].[CustomerQuotation_CustomsDetails] OFF
SET IDENTITY_INSERT [dbo].[CustomerQuotation_Routes] ON 

INSERT [dbo].[CustomerQuotation_Routes] ([ID], [CustomerID], [QuotationID], [Price], [Expire_Start], [Expire_End], [IsDeleted], [UpdatedBy], [LastestUpdated], [IsUSD], [PlaceStart], [PlaceEnd]) VALUES (1, 2, 1, 1700000, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-12-31T00:00:00.000' AS DateTime), 0, 2, CAST(N'2017-03-17T07:40:39.343' AS DateTime), 0, 1, 74)
SET IDENTITY_INSERT [dbo].[CustomerQuotation_Routes] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Prepaids]) VALUES (1, N'2. Cty TNHH Nagase Việt Nam', N'Phòng 1403, Tòa Nhà Vincom Center, 70-72 Lê Thánh Tôn, Q. 1,Tp. Hồ Chí Minh', N'', N'', 0, CAST(N'2017-03-03T15:43:26.907' AS DateTime), 2, 0)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Prepaids]) VALUES (2, N'1. Cty TNHH Sumitomo Warehouse Việt Nam ', N'26 Hàm Nghi, Bến Nghé, Quận 1, Hồ Chí Minh', N'', N'', 0, CAST(N'2017-03-17T05:30:47.813' AS DateTime), 2, 0)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Prepaids]) VALUES (3, N'Công ty TNHH MTV SX - TM thực phẩm  CÔNG DANH', N'25/11N Ấp Xuân Thới Đông 1, Xã Xuân Thới Đông, Hóc Môn, TP.HCM', N'nguyenthanhcong78@yahoo.com,', N'(084) 08 62545276 - Fax: (084) 62545273', 0, CAST(N'2017-03-03T15:50:41.157' AS DateTime), 2, 0)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Prepaids]) VALUES (4, N'Cty Checkpoint Vietnam', N'D4,Street 8B, Kizuna Serviced Factory, Lot K, Tan Kim IP,  Can Giuoc District, Long An Province', N'Chi.ngo@checkpt.com', N'+84 969 399 404', 0, CAST(N'2017-03-28T17:23:07.010' AS DateTime), 2, 0)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Prepaids]) VALUES (5, N'Cty Sotrans (Khách vãng lai)', N'', N'', N'', 0, CAST(N'2017-03-28T18:34:34.947' AS DateTime), 2, 0)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[CustomsProcess_FeeTypes] ON 

INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, N'1. Đăng ký', N'', 1, CAST(N'2017-03-04T03:04:24.610' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (2, N'2. Kiểm hóa', N'', 1, CAST(N'2017-03-04T03:04:28.443' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (3, N'Dỡ cont rỗng', N'', 1, CAST(N'2017-03-04T03:04:41.773' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (4, N'3. Thanh lý', N'', 1, CAST(N'2017-03-04T03:04:33.377' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (5, N'Phí cược container', N'', 1, CAST(N'2017-03-04T03:04:19.647' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (6, N'4. Bốc xếp', N'', 1, CAST(N'2017-03-04T03:04:37.613' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (7, N'Phí vận chuyển', N'', 1, CAST(N'2017-03-03T15:37:15.757' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (8, N'In ấn', N'', 1, CAST(N'2017-03-04T03:04:47.247' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (9, N'Cont 20 feet DC', N'', 0, CAST(N'2017-03-13T10:59:09.180' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (10, N'Cont 40 feet DC', N'', 0, CAST(N'2017-03-13T10:59:18.613' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (11, N'Hàng LCL', N'', 0, CAST(N'2017-03-13T11:00:54.573' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (12, N'Dưới 1 CBM', N'', 0, CAST(N'2017-03-13T11:00:39.080' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (13, N'LCL từ 1.1 đến 5 CBM', N'', 0, CAST(N'2017-03-13T10:59:41.917' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (14, N'LCL từ 5.1 đến 10 CBM', N'', 0, CAST(N'2017-03-13T11:00:16.740' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (15, N'LCL từ 10.1 đến 20 CBM', N'', 0, CAST(N'2017-03-13T10:59:58.730' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (16, N'Trên 20 CBM', N'', 0, CAST(N'2017-03-13T11:00:29.627' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (17, N'Chuyên ngành', N'', 0, CAST(N'2017-03-13T11:22:45.207' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_FeeTypes] ([ID], [Name], [Description], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (18, N'Hàng KNQ Nagase', N'Phí TTHQ  cho hàng từ KNQ (KH Nagase)', 0, CAST(N'2017-03-24T15:19:26.693' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[CustomsProcess_FeeTypes] OFF
SET IDENTITY_INSERT [dbo].[CustomsProcess_QuotationDetails] ON 

INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, 2, 1, 0, 0, CAST(N'2017-03-25T02:45:37.947' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (2, 2, 2, 0, 0, CAST(N'2017-03-25T02:45:37.977' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (3, 2, 4, 0, 0, CAST(N'2017-03-25T02:45:37.977' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (4, 2, 6, 0, 0, CAST(N'2017-03-25T02:45:37.993' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (5, 2, 17, 0, 0, CAST(N'2017-03-25T02:45:38.007' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (6, 2, 9, 800000, 0, CAST(N'2017-03-25T02:45:38.023' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (7, 2, 10, 900000, 0, CAST(N'2017-03-25T02:45:38.023' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (8, 2, 3, 0, 0, CAST(N'2017-03-25T02:45:38.040' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (9, 2, 12, 0, 0, CAST(N'2017-03-25T02:45:38.053' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (10, 2, 11, 800000, 0, CAST(N'2017-03-25T02:45:38.087' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (11, 2, 8, 0, 0, CAST(N'2017-03-25T02:45:38.087' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (12, 2, 13, 0, 0, CAST(N'2017-03-25T02:45:38.103' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (13, 2, 15, 0, 0, CAST(N'2017-03-25T02:45:38.117' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (14, 2, 14, 0, 0, CAST(N'2017-03-25T02:45:38.133' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (15, 2, 5, 0, 0, CAST(N'2017-03-25T02:45:38.150' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (16, 2, 7, 0, 0, CAST(N'2017-03-25T02:45:38.150' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (17, 2, 16, 0, 0, CAST(N'2017-03-25T02:45:38.163' AS DateTime), 2)
INSERT [dbo].[CustomsProcess_QuotationDetails] ([ID], [QuotationID], [CustomsFeeID], [Price], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (18, 2, 18, 700000, 0, CAST(N'2017-03-25T02:45:38.070' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[CustomsProcess_QuotationDetails] OFF
SET IDENTITY_INSERT [dbo].[CustomsProcess_Quotations] ON 

INSERT [dbo].[CustomsProcess_Quotations] ([ID], [ExpireFrom], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (2, CAST(N'2017-03-17T00:00:00.000' AS DateTime), 0, CAST(N'2017-03-25T02:45:37.900' AS DateTime), 2, 1)
SET IDENTITY_INSERT [dbo].[CustomsProcess_Quotations] OFF
SET IDENTITY_INSERT [dbo].[GoodsTypes] ON 

INSERT [dbo].[GoodsTypes] ([ID], [Name], [Code], [Description], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, N'Hàng lẻ', N'LCL', N'Hàng chở xe tải', 0, 1, CAST(N'2017-02-17T22:29:55.347' AS DateTime))
INSERT [dbo].[GoodsTypes] ([ID], [Name], [Code], [Description], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, N'Hàng cont', N'FCL', N'Hàng chở xe container', 0, 1, CAST(N'2017-02-17T22:35:03.433' AS DateTime))
SET IDENTITY_INSERT [dbo].[GoodsTypes] OFF
SET IDENTITY_INSERT [dbo].[Job_InOutFees] ON 

INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (1, 1, N'Test 1', N'Test 1', N'12345', CAST(N'2017-03-01T00:00:00.000' AS DateTime), 5555555, N'~/uploads/jobs/1/ThuChiHo/636256246096934800.png', 0, CAST(N'2017-03-20T16:36:49.710' AS DateTime), 1, 0)
INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (2, 4, N'Hoá đơn Cảng ', N'Sài Gòn Port', N'123456', CAST(N'2017-03-02T00:00:00.000' AS DateTime), 22000, N'~/uploads/jobs/4/ThuChiHo/636263226847013350.jpg', 0, CAST(N'2017-03-28T18:31:24.733' AS DateTime), 2, 1)
INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (3, 8, N'1', N'1', N'1', CAST(N'2017-03-16T00:00:00.000' AS DateTime), 0, N'~/uploads/jobs/8/ThuChiHo/636256937360444688.jpg', 0, CAST(N'2017-03-21T11:48:56.060' AS DateTime), 2, 1)
INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (4, 4, N'Hóa đơn KTCL', N'Trung tâm 3', N'123456', CAST(N'2017-03-23T00:00:00.000' AS DateTime), 1500000, N'~/uploads/jobs/4/ThuChiHo/636263226731766774.jpg', 0, CAST(N'2017-03-28T18:31:13.197' AS DateTime), 2, 0)
INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (5, 4, N'Nộp thuế hộ', N'Ngan hang ACB', N'123456', CAST(N'2017-03-24T00:00:00.000' AS DateTime), 15000000, N'~/uploads/jobs/4/ThuChiHo/636263226518272777.jpg', 0, CAST(N'2017-03-28T18:30:51.910' AS DateTime), 2, 0)
INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (6, 11, N'h', N'j', N'j', CAST(N'2017-03-31T00:00:00.000' AS DateTime), 0, N'~/uploads/jobs/11/ThuChiHo/636262006583950083.png', 0, CAST(N'2017-03-27T08:37:38.443' AS DateTime), 2, 1)
INSERT [dbo].[Job_InOutFees] ([ID], [JobID], [Name], [Company], [InvoiceNO], [InvoiceDate], [Money], [AttachedFiles], [IsDeleted], [LastestUpdated], [UpdatedBy], [IsUSD]) VALUES (7, 4, N'123', N'123', N'123', CAST(N'2017-04-27T00:00:00.000' AS DateTime), 300000, N'~/uploads/jobs/4/ThuChiHo/636266354733735292.jpg', 0, CAST(N'2017-04-01T09:24:33.393' AS DateTime), 2, 0)
SET IDENTITY_INSERT [dbo].[Job_InOutFees] OFF
SET IDENTITY_INSERT [dbo].[Job_QuotationRoutes] ON 

INSERT [dbo].[Job_QuotationRoutes] ([ID], [JobID], [RouteID], [Description], [ExtraFee], [DriverPhoneNumber], [VehicleNO], [Status], [IsDeleted], [LastestUpdate], [UpdatedBy], [USDRate], [Loads], [PromotionByTransComp], [Total_Out], [Total_In], [PlaceStart], [PlaceEnd], [Quantity]) VALUES (1, 4, 1, N'', 0, N'', N'', 0, 0, CAST(N'2017-03-17T07:40:39.403' AS DateTime), 2, 0, 0, 0, 1700000, 1700000, 1, 74, 1)
SET IDENTITY_INSERT [dbo].[Job_QuotationRoutes] OFF
SET IDENTITY_INSERT [dbo].[Job_Workings] ON 

INSERT [dbo].[Job_Workings] ([ID], [Name], [Description], [LastestUpdated], [UpdatedBy], [IsDeleted]) VALUES (1, N'D/O', N'D/O', CAST(N'2017-03-31T23:14:44.633' AS DateTime), 1, 0)
INSERT [dbo].[Job_Workings] ([ID], [Name], [Description], [LastestUpdated], [UpdatedBy], [IsDeleted]) VALUES (2, N'HQ', N'HQ', CAST(N'2017-03-31T23:14:52.153' AS DateTime), 1, 0)
INSERT [dbo].[Job_Workings] ([ID], [Name], [Description], [LastestUpdated], [UpdatedBy], [IsDeleted]) VALUES (3, N'Lấy mẫu KTCN', N'Lấy mẫu KTCN', CAST(N'2017-03-31T23:15:09.927' AS DateTime), 1, 0)
INSERT [dbo].[Job_Workings] ([ID], [Name], [Description], [LastestUpdated], [UpdatedBy], [IsDeleted]) VALUES (4, N'Nộp thuế hộ', N'Nộp thuế hộ', CAST(N'2017-03-31T23:15:16.620' AS DateTime), 1, 0)
INSERT [dbo].[Job_Workings] ([ID], [Name], [Description], [LastestUpdated], [UpdatedBy], [IsDeleted]) VALUES (5, N'Thương vụ', N'Thương vụ', CAST(N'2017-03-31T23:15:23.520' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Job_Workings] OFF
SET IDENTITY_INSERT [dbo].[Jobs] ON 

INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (1, 0, N'linh test', N'linh test', N'linh test', N'SM-IM-09032017-154407', 2, CAST(N'2017-03-09T15:44:24.153' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T15:56:26.143' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (2, 0, N'', N'', N'', N'SM-IM-11032017-105320', 2, CAST(N'2017-03-11T10:53:43.180' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-17T08:05:07.233' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (3, 0, N'', N'', N'', N'SM-IM-13032017-111506', 1, CAST(N'2017-03-13T11:15:22.783' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T15:56:20.363' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (4, 0, N'TY70060-11', N'OOLU4026663070', N'101290469120', N'SM-IM-17032017-052728', 2, CAST(N'2017-03-17T05:27:38.427' AS DateTime), CAST(N'2017-03-17T10:56:30.000' AS DateTime), 1, 1, 1, 0, 0, 0, CAST(N'2017-03-22T11:56:09.520' AS DateTime), 2, N'', 0, 0, 0, 1700000, 0, 0, 1700000, 0, 0, 22000)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (5, 0, N'', N'', N'', N'SM-IM-21032017-030517', 2, CAST(N'2017-03-21T03:05:25.360' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T05:58:40.683' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (6, 0, N'', N'', N'', N'SM-IM-21032017-031716', 2, CAST(N'2017-03-21T03:17:21.700' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T05:58:33.630' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (7, 0, N'', N'', N'', N'SM-IM-21032017-053936', 2, CAST(N'2017-03-21T05:39:44.833' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T05:58:25.930' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (8, 0, N'', N'', N'', N'SM-IM-21032017-114816', 2, CAST(N'2017-03-21T11:48:19.240' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T05:58:19.590' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (9, 0, N'', N'', N'', N'SM-IM-21032017-162211', 2, CAST(N'2017-03-21T16:22:15.767' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T05:57:02.603' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (10, 0, N'', N'', N'', N'SM-IM-22032017-022436', 2, CAST(N'2017-03-22T02:24:38.817' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-22T05:56:54.707' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Jobs] ([ID], [Type], [InvoiceNO], [BillLadingNO], [TKHQNO], [JobID], [CustomerID], [ProcessedDate], [ConsignedDate], [IsConsigned], [IsInformTransportComp], [IsPayedForTransportComp], [Status], [IsUrgent], [IsDeleted], [LastestUpdated], [UpdatedBy], [AttachedFiles], [IsPaidFromCustomer], [CustomerPrepaids], [AgentPrepaids], [Total_Transport_In], [Total_Customs_In], [Total_In], [Total_Transport_Out], [Total_Customs_Out], [Total_Out], [USDRate]) VALUES (11, 0, N'123456', N'ABC12345', N'1000234486', N'SM-IM-25032017-024234', 2, CAST(N'2017-03-25T02:43:28.250' AS DateTime), CAST(N'9999-12-31T23:59:59.997' AS DateTime), 0, 0, 0, 0, 0, 1, CAST(N'2017-03-27T20:16:12.040' AS DateTime), 2, N'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Jobs] OFF
SET IDENTITY_INSERT [dbo].[Quotation_Routes] ON 

INSERT [dbo].[Quotation_Routes] ([ID], [RouteID], [VehicleLoadID], [Price], [IsSamePrice], [Price_RoundedTrip], [Expire_Start], [Expire_End], [IsDeleted], [UpdatedBy], [LastestUpdated], [IsUSD]) VALUES (1, 1, 1, 1700000, 0, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-12-31T00:00:00.000' AS DateTime), 0, 2, CAST(N'2017-04-01T10:46:09.473' AS DateTime), 0)
INSERT [dbo].[Quotation_Routes] ([ID], [RouteID], [VehicleLoadID], [Price], [IsSamePrice], [Price_RoundedTrip], [Expire_Start], [Expire_End], [IsDeleted], [UpdatedBy], [LastestUpdated], [IsUSD]) VALUES (2, 1, 2, 1700000, 0, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-12-31T00:00:00.000' AS DateTime), 0, 2, CAST(N'2017-03-11T09:11:07.690' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Quotation_Routes] OFF
SET IDENTITY_INSERT [dbo].[Sys_Modules] ON 

INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (1, N'Danh mục', N'danh-muc', N'#', N'gi gi-show_thumbnails', -2147483648, 0, N'Danh mục', N'@0;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (2, N'Loại hàng hóa', N'loai-hang-hoa', N'~/modules/functions/GoodsTypes.ascx', N'gi gi-cargo', 1, 1, N'Loại hàng hóa', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (3, N'Loại xe', N'loai-xe', N'~/modules/functions/VehicleTypes.ascx', N'gi gi-truck', 1, 1, N'Loại xe', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (4, N'Tải trọng xe', N'tai-trong-xe', N'~/modules/functions/Vehicleloads.ascx', N'hi hi-download-alt', 1, 1, N'Tải trọng xe', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (5, N'Vận chuyển', N'van-chuyen', N'#', N'gi gi-transfer', -2147483648, 0, N'Vận chuyển', N'@0;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (6, N'Địa điểm vận chuyển', N'dia-diem-van-chuyen', N'~/modules/functions/TransportPlaces.ascx', N'fa fa-map-marker', 5, 1, N'Địa điểm vận chuyển', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (7, N'Hãng vận chuyển', N'hang-van-chuyen', N'~/modules/functions/TransportCompanies.ascx', N'gi gi-cars', 5, 1, N'Hãng vận chuyển', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (8, N'Tuyến đường', N'tuyen-duong', N'~/modules/functions/Routes.ascx', N'gi gi-git_compare', 5, 1, N'Tuyến đường theo từng Hãng vận chuyển', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (9, N'Báo giá vận chuyển', N'bao-gia-van-chuyen', N'~/modules/functions/QuotationRoutes.ascx', N'gi gi-money', 5, 1, N'Báo giá vận chuyển', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (10, N'Thủ tục hải quan', N'thu-tuc-hai-quan', N'#', N'gi gi-anchor', -2147483648, 0, N'Thủ tục hải quan', N'@0;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (11, N'Loại phí TTHQ', N'loai-phi-tthq', N'~/modules/functions/CustomsProcess_FeeTypes.ascx', N'hi hi-usd', 10, 1, N'Loại phí TTHQ', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (13, N'Hồ sơ khách hàng', N'ho-so-khach-hang', N'#', N'gi gi-parents', -2147483648, 0, N'Hồ sơ khách hàng', N'@0;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (14, N'Khách hàng', N'khach-hang', N'~/modules/functions/Customers.ascx', N'gi gi-vcard', 13, 1, N'Khách hàng', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (15, N'JOBs', N'jobs', N'#', N'gi gi-notes_2', -2147483648, 0, N'JOBs', N'@0;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (16, N'Danh sách Jobs', N'danh-sach-jobs', N'~/modules/functions/Jobs.ascx', N'gi gi-folder_open', 15, 1, N'Danh sách Jobs', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (17, N'Chi tiết JOB', N'job-detail', N'~/modules/functions/JobDetail.ascx', N'gi gi-notes_2', 15, 1, N'Chi tiết JOB', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (18, N'Bảng giá TTHQ', N'bang-gia-tthq', N'~/modules/functions/QuotationCustoms.ascx', N'gi gi-money', 10, 1, N'Bảng giá TTHQ', N'@0;@1;@2;@3;', 0, 1)
INSERT [dbo].[Sys_Modules] ([ID], [Name], [Alias], [Path], [IconClass], [ParentID], [Level], [Description], [Actions], [IsDeleted], [ShowInMenu]) VALUES (19, N'Mục chi làm hàng', N'muc-chi-lam-hang', N'~/modules/functions/JobWorkings.ascx', N'gi gi-inbox_in', 10, 1, N'Mục chi làm hàng', N'@0;@1;@2;@3;', 0, 1)
SET IDENTITY_INSERT [dbo].[Sys_Modules] OFF
SET IDENTITY_INSERT [dbo].[Sys_Permissions] ON 

INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (1, 4, 1, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (2, 4, 2, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (3, 4, 3, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (4, 4, 4, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (5, 4, 13, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (6, 4, 14, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (7, 4, 15, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (8, 4, 17, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (9, 4, 16, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (10, 4, 10, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (11, 4, 18, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (12, 4, 11, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (13, 4, 5, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (14, 4, 9, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (15, 4, 6, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (16, 4, 7, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (17, 4, 8, N'@0;@1;@2;@3;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (18, 3, 1, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (19, 3, 2, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (20, 3, 3, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (21, 3, 4, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (22, 3, 13, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (23, 3, 14, N'@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (24, 3, 15, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (25, 3, 17, N'@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (26, 3, 16, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (27, 3, 10, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (28, 3, 18, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (29, 3, 11, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (30, 3, 5, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (31, 3, 9, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (32, 3, 6, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (33, 3, 7, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (34, 3, 8, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (35, 2, 1, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (36, 2, 2, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (37, 2, 3, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (38, 2, 4, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (39, 2, 13, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (40, 2, 14, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (41, 2, 15, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (42, 2, 17, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (43, 2, 16, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (44, 2, 10, N'@0;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (45, 2, 18, N'@0;@1;@2;')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (46, 2, 11, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (47, 2, 5, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (48, 2, 9, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (49, 2, 6, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (50, 2, 7, N'')
INSERT [dbo].[Sys_Permissions] ([ID], [RoleID], [ModuleID], [Permissions]) VALUES (51, 2, 8, N'')
SET IDENTITY_INSERT [dbo].[Sys_Permissions] OFF
SET IDENTITY_INSERT [dbo].[Sys_Roles] ON 

INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (1, N'God Administrator', N'God Administrators', 1, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (2, N'Nhân viên hiện trường', N'Nhân viên hiện trường', 0, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (3, N'Kế toán', N'Kế toán', 0, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (4, N'Giám đốc', N'Giám đốc', 1, 0)
INSERT [dbo].[Sys_Roles] ([ID], [Name], [Description], [CanAccessSystemMenu], [IsDeleted]) VALUES (5, N'Administrator', N'Administrator', 1, 0)
SET IDENTITY_INSERT [dbo].[Sys_Roles] OFF
SET IDENTITY_INSERT [dbo].[Sys_Users] ON 

INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (1, N'God', N'Administrator', N'Administrator@sl.com', N'GodAdministrator', N'D20616B153DBEF09830CEE32DFE2AE96DD758F56781DD200985DEB9B628136F2', CAST(N'2017-03-09T15:16:30.457' AS DateTime), N'', N'', N'093.5757.345', 1, 1, 0)
INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (2, N'Hà', N'Ngô Mạnh', N'smilelogistics.vn@gmail.com', N'smile', N'451DD78611258359B9F732C845BCC42C', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'~/uploads/avatars/636242358366133457.jpg', N'', N'', 1, 4, 0)
INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (3, N'Đạt', N'Nguyễn Thành', N'dat.vanchuyenquocte@gmail.com', N'dat.vanchuyenquocte@gmail.com', N'451DD78611258359B9F732C845BCC42C', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'~/img/logo.jpg', N'60/2/1 Ung Văn Khiêm, P.25, Q.Bình Thạnh, TP.HCM', N'0946777657', 1, 4, 0)
INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (4, N'Giang', N'Lê Thị Trà', N'tragiang2504@yahoo.com.vn', N'tragiang2504', N'451DD78611258359B9F732C845BCC42C', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'~/uploads/avatars/636242366278565854.jpg', N'', N'0984878840', 1, 4, 0)
INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (5, N'Luân', N'Lương Ngọc Gia', N'smile.vanchuyenquocte@gmail.com', N'luan', N'451DD78611258359B9F732C845BCC42C', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'~/img/logo.jpg', N'', N'', 1, 2, 0)
INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (6, N'Toàn', N'Đặng Thành', N'docs1.smilelogistics@gmail.com', N'toan', N'451DD78611258359B9F732C845BCC42C', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'~/img/logo.jpg', N'', N'', 1, 2, 0)
INSERT [dbo].[Sys_Users] ([ID], [Firstname], [Lastname], [Email], [Username], [Password], [DateOfBirth], [Avatar], [Address], [PhoneNumber], [Status], [RoleID], [IsDeleted]) VALUES (7, N'Hảo', N'Ngô Thị Hoàng', N'ketoan.smilelogistics@gmail.com', N'ketoan.smilelogistics@gmail.com', N'451DD78611258359B9F732C845BCC42C', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'~/img/logo.jpg', N'', N'0969900485', 1, 3, 0)
SET IDENTITY_INSERT [dbo].[Sys_Users] OFF
SET IDENTITY_INSERT [dbo].[TransportCompanies] ON 

INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, N'Cty TNHH Hàn Việt Mỹ', N'HCM', N'', N'', 0, 0, CAST(N'2017-03-08T18:08:32.497' AS DateTime), 1)
INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (2, N'DNTN Vận tải Vân Huyền', N'81 Đường số 1, Khu B, Phường An Phú An Khánh Q2', N'0838960775', N'vtvanhuyen@yahoo.com.vn', 0, 0, CAST(N'2017-03-10T15:25:18.680' AS DateTime), 2)
INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (3, N'Cty TNHH MTV TM DV Vận tải Lâm Phát -  Anh Xá', N'264/35/21A NTMK, P. Phú Hòa, TP. TDM, Bình Dương; Kios 270 Thống Nhất, F10. GV', N'0961.623.338 / 0918.307.488', N'vantailamphat79@gmail.com', 0, 0, CAST(N'2017-03-30T22:20:22.827' AS DateTime), 2)
INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (4, N'Cty Mr Tra', N'0938823439', N'0938823439', N'ngandang7988@gmail.com', 0, 0, CAST(N'2017-03-11T09:25:35.003' AS DateTime), 2)
INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (5, N'Cty TNHH Giao nhận Vận tải Minh Hiển', N'89A Lý Phục Man, P Bình Thuận, Q7, HCM', N'', N'', 0, 0, CAST(N'2017-03-28T18:45:44.627' AS DateTime), 2)
INSERT [dbo].[TransportCompanies] ([ID], [Name], [Address], [PhoneNumber], [Email], [Status], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (6, N'Cty TNHH Logistics Hiệp Thành Long', N'52 Đường 61 Thảo Điền, Q2, TPHCM', N'', N'', 0, 0, CAST(N'2017-03-30T16:55:57.213' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[TransportCompanies] OFF
SET IDENTITY_INSERT [dbo].[TransportCompany_Routes] ON 

INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (1, 2, 1, 74, 0, CAST(N'2017-03-10T15:22:16.943' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (2, 2, 1, 75, 0, CAST(N'2017-03-10T15:22:34.883' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (3, 2, 1, 106, 0, CAST(N'2017-03-10T15:23:02.790' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (4, 4, 102, 16, 0, CAST(N'2017-03-11T09:26:36.053' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (5, 4, 102, 1, 0, CAST(N'2017-03-11T09:28:18.107' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (6, 4, 74, 16, 0, CAST(N'2017-03-11T09:29:10.307' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (7, 4, 74, 1, 0, CAST(N'2017-03-11T09:29:24.723' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (8, 4, 95, 1, 0, CAST(N'2017-03-11T09:30:29.593' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (9, 4, 95, 16, 0, CAST(N'2017-03-11T09:30:41.940' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (10, 4, 16, 106, 0, CAST(N'2017-03-11T09:31:46.940' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (11, 4, 1, 106, 0, CAST(N'2017-03-11T09:32:09.453' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (12, 4, 16, 110, 0, CAST(N'2017-03-11T09:32:51.617' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (13, 4, 1, 110, 0, CAST(N'2017-03-11T09:33:05.360' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (14, 4, 16, 94, 0, CAST(N'2017-03-11T09:33:38.640' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (15, 4, 1, 94, 0, CAST(N'2017-03-11T09:33:50.437' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (16, 4, 16, 114, 0, CAST(N'2017-03-11T09:35:56.207' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (17, 4, 16, 109, 0, CAST(N'2017-03-11T09:36:54.477' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (18, 4, 1, 114, 0, CAST(N'2017-03-11T09:38:17.233' AS DateTime), 2)
INSERT [dbo].[TransportCompany_Routes] ([ID], [TransCompID], [StartPoint], [EndPoint], [IsDeleted], [LastestUpdated], [UpdatedBy]) VALUES (19, 4, 1, 109, 0, CAST(N'2017-03-11T09:38:54.383' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[TransportCompany_Routes] OFF
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleType_Loads] ON 

INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, 1, 6, 0, 2, CAST(N'2017-03-10T15:25:18.760' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, 1, 7, 0, 2, CAST(N'2017-03-10T15:25:18.773' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (3, 1, 8, 0, 2, CAST(N'2017-03-10T15:25:18.790' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (4, 2, 1, 0, 2, CAST(N'2017-03-11T09:25:35.097' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (5, 2, 2, 0, 2, CAST(N'2017-03-11T09:25:35.110' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (6, 3, 6, 0, 2, CAST(N'2017-03-28T18:45:44.713' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (7, 3, 7, 0, 2, CAST(N'2017-03-28T18:45:44.730' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (8, 3, 8, 0, 2, CAST(N'2017-03-28T18:45:44.737' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (9, 3, 9, 0, 2, CAST(N'2017-03-28T18:45:44.743' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (10, 4, 6, 0, 2, CAST(N'2017-03-30T16:55:57.297' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (11, 4, 7, 0, 2, CAST(N'2017-03-30T16:55:57.310' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (12, 4, 8, 0, 2, CAST(N'2017-03-30T16:55:57.313' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleType_Loads] ([ID], [TransComp_VehicleTypeID], [VehicleLoadID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (13, 4, 9, 0, 2, CAST(N'2017-03-30T16:55:57.320' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleType_Loads] OFF
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleTypes] ON 

INSERT [dbo].[TransportCompany_VehicleTypes] ([ID], [TransCompID], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, 2, 2, 0, 2, CAST(N'2017-03-10T15:25:18.727' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleTypes] ([ID], [TransCompID], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, 4, 1, 0, 2, CAST(N'2017-03-11T09:25:35.063' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleTypes] ([ID], [TransCompID], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (3, 5, 2, 0, 2, CAST(N'2017-03-28T18:45:44.677' AS DateTime))
INSERT [dbo].[TransportCompany_VehicleTypes] ([ID], [TransCompID], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (4, 6, 2, 0, 2, CAST(N'2017-03-30T16:55:57.263' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransportCompany_VehicleTypes] OFF
SET IDENTITY_INSERT [dbo].[TransportPlaces] ON 

INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (1, N'1. Cảng Cát Lái', N'', N'', 0, CAST(N'2017-03-03T08:14:56.357' AS DateTime), 2, N'Đường Nguyễn Thị Định, P. Cát Lái, Q.2, TP.HCM')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (2, N'Kho Long Thành', N'', N'', 1, CAST(N'2017-03-03T08:42:56.320' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (3, N'Cảng Sóng Thần', N'', N'', 1, CAST(N'2017-03-03T06:47:10.797' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (4, N'Kho Tổng', N'', N'', 1, CAST(N'2017-03-05T15:27:40.767' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (9, N'2. Kho TCSC', N'', N'', 0, CAST(N'2017-03-28T17:27:58.807' AS DateTime), 2, N' 46-48, Hậu Giang, Phường 4, Tân Bình')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (10, N'3. Kho SCSC', N'', N'', 0, CAST(N'2017-03-28T17:27:49.947' AS DateTime), 2, N'30 Phan Thúc Duyện, Phường 4, Tân Bình')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (16, N'8. Tân Sơn Nhất Airport', N'', N'', 0, CAST(N'2017-03-28T17:30:30.000' AS DateTime), 2, N'Tân Bình')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (17, N'Cty TNHH Việt Nam Dai-Ichi Seiko', N'', N'', 0, CAST(N'2017-03-03T09:05:14.410' AS DateTime), 2, N'Số 41 Đại lộ Tự do, KCN VSIP, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (18, N'Cty Cổ Phần Chăn Nuôi CP Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:16:46.997' AS DateTime), 2, N'Lô A21-A35 KCN An Hiệp, Châu Thành, Bến Tre')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (20, N'Cty CP Bao Bì Nhựa Tân Tiến (Tapack)', N'', N'', 0, CAST(N'2017-03-03T08:17:03.997' AS DateTime), 2, N'Lô II 4-5-10-11, đường số 13, KCN Tân Bình, Tây Thạnh, Tân Phú')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (21, N'Cty TNHH Kyoshin Việt Nam', N'', N'', 0, CAST(N'2017-03-03T09:04:39.543' AS DateTime), 2, N'Đường 12, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (22, N'Cty TNHH ABCD', N'', N'', 0, CAST(N'2017-03-03T08:17:22.060' AS DateTime), 2, N'Lô B4, KCN Long Bình, Biên Hoà, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (23, N'Cty TNHH Alkana Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:17:36.330' AS DateTime), 2, N'Số 6, Dân chủ, KCN VSIP 2, Thủ Dầu Một, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (26, N'Cty TNHH AQUA', N'', N'', 0, CAST(N'2017-03-20T07:54:29.133' AS DateTime), 2, N'Số 8, Đường 17A, KCN Biên Hòa II, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (27, N'Cty TNHH Aqua/Tenma', N'', N'', 0, CAST(N'2017-03-20T07:54:35.130' AS DateTime), 2, N'Số 10, Đường 9A, KCN Biên Hòa II, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (28, N'Cty TNHH Asia Paint Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:18:12.030' AS DateTime), 2, N'Lô I5-I6, KCN Việt Hương, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (29, N'Cty TNHH Biên Hoà SCM', N'', N'', 0, CAST(N'2017-03-03T08:18:23.240' AS DateTime), 2, N'F6-T,16-G.6, Tam Hiệp, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (30, N'Cty TNHH Brenntag', N'', N'', 0, CAST(N'2017-03-03T08:18:33.647' AS DateTime), 2, N'ICD Tân Cảng, Phường Long Bình, Biên Hòa, Đồng Nai ')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (31, N'Cty TNHH D&Y Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:18:45.353' AS DateTime), 2, N'Đường 18, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (32, N'Cty TNHH Đại Đồng Tiến', N'', N'', 0, CAST(N'2017-03-03T08:24:26.147' AS DateTime), 2, N'948 Hương Lộ 2, P. Bình Trị Đông A, Bình Tân')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (34, N'Cty TNHH DDK', N'', N'', 0, CAST(N'2017-03-03T08:24:01.693' AS DateTime), 2, N'Số 20 đường Dân Chủ, KCN VSIP 2, Thu Dau Mot, Binh Duong')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (36, N'Cty TNHH Dệt Daewon Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:24:11.457' AS DateTime), 2, N'Khu Công Nghiệp Nhơn Trạch 1, H. Nhơn Trạch, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (37, N'Cty TNHH DIC', N'', N'', 0, CAST(N'2017-03-03T08:24:43.497' AS DateTime), 2, N'31 đường số 6, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (38, N'Cty TNHH DNP Việt Nam', N'', N'', 0, CAST(N'2017-03-20T07:55:06.580' AS DateTime), 2, N'Lô B_3A4_CN, KCN Mỹ Phước 3, Ben Cat, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (40, N'Cty TNHH East West Industries Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:25:10.973' AS DateTime), 2, N'Số 27, đường số 2, KCN VSIP 2, Thủ Dầu Một, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (43, N'Cty TNHH FC Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:25:37.320' AS DateTime), 2, N'Đường số 4, KCN Long Bình, Biên Hoà, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (48, N'Cty TNHH Gunze', N'', N'', 0, CAST(N'2017-03-03T08:25:57.090' AS DateTime), 2, N'Đường 10, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (49, N'Cty TNHH Hồng Nhân Plastic', N'', N'', 0, CAST(N'2017-03-03T08:38:38.710' AS DateTime), 2, N'110/10 Bà Hom, Phường 13, Quận 6')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (51, N'Cty TNHH Kiến Hưng', N'', N'', 0, CAST(N'2017-03-03T08:39:26.443' AS DateTime), 2, N'Số 33, Đường Trần Đại Nghĩa, KCN Tân Tạo, Bình Tân')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (52, N'Cty TNHH Koatsu Gas Kogyo Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:39:39.227' AS DateTime), 2, N'Đường D3-2, KCN Long Đức, Long Thành, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (54, N'Cty TNHH Kotobuki Sea', N'', N'', 0, CAST(N'2017-03-03T08:39:55.543' AS DateTime), 2, N'Lô 104/6, Đường Amata, KCN Amata, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (56, N'Cty TNHH Liên Thành Phát', N'', N'', 0, CAST(N'2017-03-03T07:35:41.497' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (57, N'Cty TNHH Mainetti', N'', N'', 0, CAST(N'2017-03-03T08:40:27.923' AS DateTime), 2, N'Đường số 7, KCN Long Thành, Long Thành, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (58, N'Cty TNHH Maruha Chemical Vietnam ', N'', N'(84)-650-3635-184 / 185', 0, CAST(N'2017-03-03T08:40:46.350' AS DateTime), 2, N'Street 1, VSIP 2, Thủ Dầu Một, Bình Dương, Vietnam ')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (59, N'Cty TNHH Minh Phát', N'', N'', 0, CAST(N'2017-03-03T07:36:56.033' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (61, N'Cty TNHH Minh Phú', N'', N'', 0, CAST(N'2017-03-03T07:37:15.373' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (63, N'Cty TNHH Muto', N'', N'', 0, CAST(N'2017-03-03T08:41:01.660' AS DateTime), 2, N'Lô C/7/1 Đường số 2, KCN Long Bình, Biên Hoà, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (64, N'Cty TNHH Mỹ Lan', N'', N'', 0, CAST(N'2017-03-03T08:09:50.553' AS DateTime), 2, N'')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (65, N'Cty TNHH Nagata', N'', N'', 0, CAST(N'2017-03-03T08:41:20.077' AS DateTime), 2, N'Đường 12, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (68, N'Cty TNHH Nidec Copal Precision VN', N'', N'', 0, CAST(N'2017-03-03T08:41:45.800' AS DateTime), 2, N'Lô I-1D-1, đường N1, Khu Công nghệ cao Sài gòn, Q.9, TP.HCM')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (69, N'Cty TNHH Nidec Sankyo', N'', N'', 0, CAST(N'2017-03-03T08:41:56.730' AS DateTime), 2, N'Lô I1-N1, Khu Công nghệ cao Sài gòn, Q.9, TP.HCM')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (70, N'Cty TNHH Nidec Servo', N'', N'', 0, CAST(N'2017-03-03T08:42:05.850' AS DateTime), 2, N'Lô I1.3-N1, Khu công nghệ cao Sài gòn, Q.9, TP.HCM')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (71, N'Cty TNHH Nidec Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:42:16.533' AS DateTime), 2, N'Lô I1-N2, Khu Công nghệ cao Sài gòn, Q.9, TP.HCM')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (72, N'Cty TNHH Nikkiso', N'', N'', 0, CAST(N'2017-03-03T08:42:26.137' AS DateTime), 2, N'Đường 19, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (73, N'Cty TNHH Nooro Nanpao', N'', N'', 0, CAST(N'2017-03-03T08:42:37.637' AS DateTime), 2, N'KCN Nhơn Trạch 2, Huyện Nhơn Trạch, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (74, N'4. KNQ Kerry (Sóng Thần)', N'', N'', 0, CAST(N'2017-03-28T17:27:37.660' AS DateTime), 2, N'20 THỐNG NHẤT, KHU CÔNG NGHIỆP SÓNG THẦN 2, HUYỆN DĨ AN, BÌNH DƯƠNG')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (75, N'5. KNQ Long Bình (ICD LB)', N'', N'', 0, CAST(N'2017-03-28T17:28:20.077' AS DateTime), 2, N'Khu Phố 7, Đường Bùi Văn Hòa, Phường Long Bình, Tp. Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (76, N'6. KNQ Nippon Bình Dương', N'', N'', 0, CAST(N'2017-03-28T17:30:01.897' AS DateTime), 2, N'Lô F, đường số 6, KCN Sóng thần 2, p. Dĩ An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (77, N'Cty TNHH Ebisuya Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:25:25.837' AS DateTime), 2, N'Lô 62A, KCN Long Giang, xã Tân Lập 1, Tân Phước, Tiền Giang')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (78, N'Cty TNHH Kewpie Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:39:05.340' AS DateTime), 2, N' Số 11, Vsip II-A, Đường số 14, KCN VN-SING, Tân Uyên, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (79, N'Cty TNHH Oval Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:43:54.047' AS DateTime), 2, N'26 Thống Nhất, KCN Sóng Thần 2, Dĩ An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (80, N'Cty TNHH Plus Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:44:08.503' AS DateTime), 2, N'Số 3, đướng 1A, KCN Biên Hòa II, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (81, N'Cty TNHH Pronics', N'', N'', 0, CAST(N'2017-03-03T08:44:28.750' AS DateTime), 2, N'Đường 12, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (82, N'Cty TNHH PV Paint', N'', N'', 0, CAST(N'2017-03-03T08:45:30.457' AS DateTime), 2, N'Số 11, đường số 2, KCN Sóng Thần 3, Thủ Dầu Một, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (83, N'Cty TNHH Rohto Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:45:47.010' AS DateTime), 2, N'Đường số 5, KCN VSIP, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (84, N'Cty TNHH Sakura Platics', N'', N'', 0, CAST(N'2017-03-03T08:46:04.113' AS DateTime), 2, N'23 Đường số 12, KP 1, Linh Tây, Thủ Đức')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (85, N'Cty TNHH Seiwa Electric Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:46:24.197' AS DateTime), 2, N'Lô R.28b-30-32-34-36a, Đường 18, KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (86, N'Cty TNHH Settsu Carton Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:46:49.883' AS DateTime), 2, N' KCN Long Đức, Huyện Long Thành, Tỉnh Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (87, N'Cty TNHH Sohwa Saigon', N'', N'', 0, CAST(N'2017-03-03T08:47:11.987' AS DateTime), 2, N'Số 2, Đường 2A, KCN VSIP, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (88, N'Cty TNHH Tenma (HCM) VIỆT NAM', N'', N'', 0, CAST(N'2017-03-03T08:47:29.110' AS DateTime), 2, N'Số 10, Đường 9A, KCN Biên Hòa II, Tp. Biên Hòa, Tỉnh Đồng Nai.')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (89, N'Cty TNHH Thức ăn Chăn nuôi Kyodo Sojitz', N'', N'', 0, CAST(N'2017-03-03T08:48:08.093' AS DateTime), 2, N'Lô F5-F6-F7-F8 KCN Thịnh Phát, xã Lương Bình, huyện Bến Lức, tỉnh Long An')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (90, N'Cty TNHH Tombow Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:48:37.717' AS DateTime), 2, N'Số 21 Đại Lộ Độc Lập, KCN VSIP, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (91, N'Cty TNHH Toyo Ink Compounds Việt Nam', N'', N'', 0, CAST(N'2017-03-03T08:48:50.467' AS DateTime), 2, N'Số 201, đường Amata, KCN Amata, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (92, N'Cty TNHH Việt Nam Yoshida', N'', N'', 0, CAST(N'2017-03-03T08:49:05.790' AS DateTime), 2, N'Lô 16-1, Đường 2B, KCN An Tây, Bến Cát, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (93, N'Cty TNHH Yuwa', N'', N'', 0, CAST(N'2017-03-03T08:51:23.607' AS DateTime), 2, N'Số 15 , Đường số 06, KCN VSIP 2, Thủ Dầu Một, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (94, N'KCN VSIP 2 ', N'', N'', 0, CAST(N'2017-03-11T10:19:15.090' AS DateTime), 2, N'KCN VSIP 2, Tân Uyên, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (95, N'KCN VSIP', N'', N'', 0, CAST(N'2017-03-17T05:31:28.753' AS DateTime), 2, N'KCN VSIP, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (96, N'KCN Sóng Thần', N'', N'', 0, CAST(N'2017-03-03T08:52:51.637' AS DateTime), 2, N'KCN Sóng Thần, Dĩ An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (97, N'KCN Sóng Thần 2', N'', N'', 0, CAST(N'2017-03-03T08:53:45.890' AS DateTime), 2, N'KCN Sóng Thần 2, Dĩ An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (98, N'KCN Sóng Thần 3', N'', N'', 0, CAST(N'2017-03-03T08:54:05.440' AS DateTime), 2, N'KCN Sóng Thần 3, Thủ Dầu Một, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (99, N'KCN Tân Bình', N'', N'', 0, CAST(N'2017-03-03T08:54:26.233' AS DateTime), 2, N' KCN Tân Bình, Tây Thạnh, Tân Phú')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (100, N'KCN Tân Tạo', N'', N'', 0, CAST(N'2017-03-03T08:54:40.433' AS DateTime), 2, N'KCN Tân Tạo, Bình Tân')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (101, N'KCN Việt Hương', N'', N'', 0, CAST(N'2017-03-03T08:54:56.300' AS DateTime), 2, N'KCN Việt Hương, Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (102, N'9. KCX Tân Thuận', N'', N'', 0, CAST(N'2017-03-10T15:44:25.627' AS DateTime), 2, N'KCX Tân Thuận, Quận 7')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (103, N'Khu Công nghệ cao Sài gòn, Q.9 (SG Hightech Park)', N'', N'', 0, CAST(N'2017-03-20T07:56:30.667' AS DateTime), 2, N'Khu Công nghệ cao Sài gòn, Q.9, TP.HCM')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (104, N'KCN Amata', N'', N'', 0, CAST(N'2017-03-03T08:55:44.640' AS DateTime), 2, N'KCN Amata, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (105, N'KCN Biên Hòa 1', N'', N'', 1, CAST(N'2017-03-07T14:07:47.337' AS DateTime), 2, N'KCN Biên Hòa 1, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (106, N'KCN Biên Hòa', N'', N'', 0, CAST(N'2017-03-11T10:19:25.560' AS DateTime), 2, N'KCN Biên Hòa, Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (107, N'KCN Hiệp Phước', N'', N'', 0, CAST(N'2017-03-03T08:56:56.127' AS DateTime), 2, N'KCN Hiệp Phước, Nhà Bè')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (108, N'KCN Long Đức', N'', N'', 0, CAST(N'2017-03-03T08:57:08.957' AS DateTime), 2, N'KCN Long Đức, Long Thành, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (109, N'KCN Long Thành', N'', N'', 0, CAST(N'2017-03-03T08:57:46.367' AS DateTime), 2, N'Long Thành, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (110, N'KCN Mỹ Phước 3', N'', N'', 0, CAST(N'2017-03-03T08:58:03.550' AS DateTime), 2, N'Khu công nghiệp Mỹ Phước 3 - Thị Xã Bến Cát - Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (111, N'KCN Nhơn Trạch 2', N'', N'', 0, CAST(N'2017-03-03T08:58:23.950' AS DateTime), 2, N'KCN Nhơn Trạch 2, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (112, N'KCN Nhơn Trạch 3', N'', N'', 0, CAST(N'2017-03-03T08:58:36.573' AS DateTime), 2, N'KCN Nhơn Trạch 3, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (113, N'TP. Biên Hòa', N'', N'', 0, CAST(N'2017-03-28T17:31:10.400' AS DateTime), 2, N'Biên Hòa, Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (114, N'KCN Tam Phước', N'', N'', 0, CAST(N'2017-03-11T09:35:16.890' AS DateTime), 2, N'Đường số 6, Tam Phước, Tp. Biên Hòa, Đồng Nai, Vietnam')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (115, N'KCN Mỹ Phước 1', N'', N'', 0, CAST(N'2017-03-11T09:41:31.290' AS DateTime), 2, N'Mỹ Phước 1, Bến Cát Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (116, N'Cty TNHH Ebisuya Vietnam', N'', N'', 0, CAST(N'2017-03-11T14:55:47.467' AS DateTime), 2, N' Lô 62A Khu công nghiệp Long Giang, Xã Tân Lập 1, Huyện Tân Phước, Tỉnh Tiền Giang')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (117, N'Cảng VICT', N'', N'', 0, CAST(N'2017-03-20T07:54:05.227' AS DateTime), 2, N'VICT')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (118, N'Cty TNHH YUWA VIETNAM ', N'', N'Tel: 0650 3628 073 Ex: 165', 0, CAST(N'2017-03-21T03:43:53.320' AS DateTime), 2, N'15 Street No 06, Vsip II, Hoa Phu, TP.TDM, Binh Duong')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (119, N'Cty TNHH Đầu Tư Ecowise', N'', N'', 0, CAST(N'2017-03-22T14:03:48.470' AS DateTime), 2, N'198 Nguyễn Văn Hưởng, phường Thảo Điền, Quận 2,  TP.Hồ Chí Minh')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (120, N'Cty TNHH Điện tử TT', N'', N'', 0, CAST(N'2017-03-28T18:17:55.637' AS DateTime), 2, N'Đường số 4, KCN Tân Đông Hiệp B, Dĩ An, Bình Dương, Việt Nam')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (121, N'7. KNQ Nippon Amata Đồng Nai', N'', N'', 0, CAST(N'2017-03-28T17:30:18.167' AS DateTime), 2, N'Lô 227/2, Đường số 15, KCN Long Bình( Amata), Phường Long Bình, Tp. Biên Hòa, Đồng Nai ')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (122, N'Cty TNHH Boramtek Việt Nam', N'', N'', 0, CAST(N'2017-03-28T18:17:38.227' AS DateTime), 2, N'Khu Công Nghiệp Biên Hòa 2, 4 Đường 17A, Tp. Biên Hòa,Đồng Nai')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (123, N'Cty TNHH SUN FIELD Việt Nam', N'', N'', 0, CAST(N'2017-03-29T18:18:55.777' AS DateTime), 2, N'số 42 VSIP đường số 3, khu công nghiệp Việt Nam - Singapore, TX Thuận An, Bình Dương')
INSERT [dbo].[TransportPlaces] ([ID], [Name], [Email], [PhoneNumber], [IsDeleted], [LastestUpdated], [UpdatedBy], [Address]) VALUES (124, N'Công Ty TNHH Chang Dae Vina', N'', N'', 0, CAST(N'2017-03-30T17:06:31.823' AS DateTime), 2, N'Lô 306, Đường số 7A, KCN Long Bình (Amata), Phường Long Bình')
SET IDENTITY_INSERT [dbo].[TransportPlaces] OFF
SET IDENTITY_INSERT [dbo].[VehicleLoads] ON 

INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, N'Tải 1 tấn', N'1T', N'Tải 1 tấn', 1, 1, 0, 2, CAST(N'2017-03-03T15:40:29.763' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, N'Tải 2 tấn', N'2T', N'Tải 2 tấn', 2, 1, 0, 2, CAST(N'2017-03-03T15:40:44.037' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (3, N'Tải 3 tấn', N'3T', N'Tải 3 tấn', 3, 1, 0, 2, CAST(N'2017-03-03T15:40:56.183' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (4, N'Tải 5 tấn', N'5T', N'Tải 5 tấn', 5, 1, 0, 2, CAST(N'2017-03-03T15:41:07.560' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (5, N'Tải 8 tấn', N'8T', N'Tải 8 tấn', 8, 1, 0, 2, CAST(N'2017-03-03T15:41:17.070' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (6, N'Cont 20 feet', N'20F', N'Cont 20 feet', 20, 2, 0, 1, CAST(N'2017-02-18T00:18:38.533' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (7, N'Cont 40 feet', N'40F', N'Cont 40 feet', 40, 2, 0, 1, CAST(N'2017-02-18T00:18:54.913' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (8, N'Cont 2x20 feet', N'2x20F', N'Cont 2x20 feet', 40, 2, 0, 1, CAST(N'2017-02-27T23:49:49.183' AS DateTime))
INSERT [dbo].[VehicleLoads] ([ID], [Name], [Code], [Description], [FullLoad], [VehicleTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (9, N'Xe moọc sàn', N'MS', N'Xe moọc sàn', 40, 2, 0, 2, CAST(N'2017-03-03T02:23:30.850' AS DateTime))
SET IDENTITY_INSERT [dbo].[VehicleLoads] OFF
SET IDENTITY_INSERT [dbo].[VehicleTypes] ON 

INSERT [dbo].[VehicleTypes] ([ID], [Name], [Code], [Description], [GoodsTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (1, N'Xe tải', N'Truck', N'Xe tải', 1, 0, 1, CAST(N'2017-02-17T22:57:09.000' AS DateTime))
INSERT [dbo].[VehicleTypes] ([ID], [Name], [Code], [Description], [GoodsTypeID], [IsDeleted], [UpdatedBy], [LastestUpdated]) VALUES (2, N'Xe container', N'Container', N'Xe container', 2, 0, 1, CAST(N'2017-02-17T22:58:29.890' AS DateTime))
SET IDENTITY_INSERT [dbo].[VehicleTypes] OFF
ALTER TABLE [dbo].[Agent_Prepaids] ADD  CONSTRAINT [DF_Agent_Prepaids_AttachedFiles]  DEFAULT ('') FOR [AttachedFiles]
GO
ALTER TABLE [dbo].[Agent_Prepaids] ADD  CONSTRAINT [DF_Agent_Prepaids_ConfirmedBy]  DEFAULT ((0)) FOR [ConfirmedBy]
GO
ALTER TABLE [dbo].[Agent_Prepaids] ADD  CONSTRAINT [DF_Agent_Prepaids_JobWorkings]  DEFAULT ('') FOR [JobWorkings]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] ADD  CONSTRAINT [DF_CustomerQuotation_Customs_Total]  DEFAULT ((0)) FOR [Total_In]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] ADD  CONSTRAINT [DF_CustomerQuotation_Customs_Total_Out]  DEFAULT ((0)) FOR [Total_Out]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] ADD  CONSTRAINT [DF_CustomerQuotation_Customs_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] ADD  CONSTRAINT [DF_CustomerQuotation_Customs_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] ADD  CONSTRAINT [DF_CustomerQuotation_Customs_DecreasePercentForSecondCont]  DEFAULT ((0)) FOR [DecreasePercentForSecondCont]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] ADD  CONSTRAINT [DF_CustomerQuotation_Customs_JobID]  DEFAULT ((1)) FOR [JobID]
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] ADD  CONSTRAINT [DF_CustomerQuotation_CustomsDetails_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] ADD  CONSTRAINT [DF_CustomerQuotation_CustomsDetails_Total]  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] ADD  CONSTRAINT [DF_CustomerQuotation_CustomsDetails_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] ADD  CONSTRAINT [DF_CustomerQuotation_Routes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] ADD  CONSTRAINT [DF_CustomerQuotation_Routes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[CustomerQuotation_Routes] ADD  CONSTRAINT [DF_CustomerQuotation_Routes_IsUSD]  DEFAULT ((0)) FOR [IsUSD]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_Prepaids]  DEFAULT ((0)) FOR [Prepaids]
GO
ALTER TABLE [dbo].[CustomsProcess_Quotations] ADD  CONSTRAINT [DF_CustomsProcess_Quotations_IsUSD]  DEFAULT ((0)) FOR [IsUSD]
GO
ALTER TABLE [dbo].[GoodsTypes] ADD  CONSTRAINT [DF_GoodsTypes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[GoodsTypes] ADD  CONSTRAINT [DF_GoodsTypes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[Job_InOutFees] ADD  CONSTRAINT [DF_Job_InOutFees_IsUSD]  DEFAULT ((0)) FOR [IsUSD]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] ADD  CONSTRAINT [DF_Job_QuotationRoutes_Loads]  DEFAULT ((0)) FOR [Loads]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] ADD  CONSTRAINT [DF_Job_QuotationRoutes_PromotionByTransComp]  DEFAULT ((0)) FOR [PromotionByTransComp]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] ADD  CONSTRAINT [DF_Job_QuotationRoutes_Total_Out]  DEFAULT ((0)) FOR [Total_Out]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] ADD  CONSTRAINT [DF_Job_QuotationRoutes_Total_In]  DEFAULT ((0)) FOR [Total_In]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] ADD  CONSTRAINT [DF_Job_QuotationRoutes_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Job_Workings] ADD  CONSTRAINT [DF_Job_Workings_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_AttachedFiles]  DEFAULT ('') FOR [AttachedFiles]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_IsPaidFromCustomer]  DEFAULT ((0)) FOR [IsPaidFromCustomer]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_CustomerPrepaids]  DEFAULT ((0)) FOR [CustomerPrepaids]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Agent_Prepaids]  DEFAULT ((0)) FOR [AgentPrepaids]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Total_Transport]  DEFAULT ((0)) FOR [Total_Transport_In]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Total_Customs]  DEFAULT ((0)) FOR [Total_Customs_In]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Total]  DEFAULT ((0)) FOR [Total_In]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Total_Transport_Out]  DEFAULT ((0)) FOR [Total_Transport_Out]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Total_Customs_Out]  DEFAULT ((0)) FOR [Total_Customs_Out]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Total_Out]  DEFAULT ((0)) FOR [Total_Out]
GO
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_USDRate]  DEFAULT ((0)) FOR [USDRate]
GO
ALTER TABLE [dbo].[Quotation_Routes] ADD  CONSTRAINT [DF_Quotation_Routes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[Quotation_Routes] ADD  CONSTRAINT [DF_Quotation_Routes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[Quotation_Routes] ADD  CONSTRAINT [DF_Quotation_Routes_IsUSD]  DEFAULT ((0)) FOR [IsUSD]
GO
ALTER TABLE [dbo].[Sys_Modules] ADD  CONSTRAINT [DF_Sys_Modules_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Sys_Modules] ADD  CONSTRAINT [DF_Sys_Modules_ShowInMenu]  DEFAULT ((1)) FOR [ShowInMenu]
GO
ALTER TABLE [dbo].[Sys_Roles] ADD  CONSTRAINT [DF_Sys_Roles_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TransportCompanies] ADD  CONSTRAINT [DF_TransportCompanies_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[TransportCompanies] ADD  CONSTRAINT [DF_TransportCompanies_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[TransportCompany_Routes] ADD  CONSTRAINT [DF_TransportCompany_Routes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[TransportCompany_Routes] ADD  CONSTRAINT [DF_TransportCompany_Routes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads] ADD  CONSTRAINT [DF_TransportCompany_VehicleType_Loads_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads] ADD  CONSTRAINT [DF_TransportCompany_VehicleType_Loads_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleType_Loads] ADD  CONSTRAINT [DF_TransportCompany_VehicleType_Loads_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes] ADD  CONSTRAINT [DF_TransportCompany_VehicleTypes_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes] ADD  CONSTRAINT [DF_TransportCompany_VehicleTypes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[TransportCompany_VehicleTypes] ADD  CONSTRAINT [DF_TransportCompany_VehicleTypes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[TransportPlaces] ADD  CONSTRAINT [DF_TransportPlaces_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[TransportPlaces] ADD  CONSTRAINT [DF_TransportPlaces_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[TransportPlaces] ADD  CONSTRAINT [DF_TransportPlaces_Address]  DEFAULT ('') FOR [Address]
GO
ALTER TABLE [dbo].[VehicleLoads] ADD  CONSTRAINT [DF_VehicleLoads_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[VehicleLoads] ADD  CONSTRAINT [DF_VehicleLoads_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[VehicleLoads] ADD  CONSTRAINT [DF_VehicleLoads_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[VehicleTypes] ADD  CONSTRAINT [DF_VehicleTypes_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[VehicleTypes] ADD  CONSTRAINT [DF_VehicleTypes_UpdatedBy]  DEFAULT ((0)) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[VehicleTypes] ADD  CONSTRAINT [DF_VehicleTypes_LastestUpdated]  DEFAULT (getdate()) FOR [LastestUpdated]
GO
ALTER TABLE [dbo].[Agent_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Agent_Prepaids_Confirmer] FOREIGN KEY([ConfirmedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Agent_Prepaids] CHECK CONSTRAINT [FK_Agent_Prepaids_Confirmer]
GO
ALTER TABLE [dbo].[Agent_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Agent_Prepaids_Sys_Users] FOREIGN KEY([AgentID])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Agent_Prepaids] CHECK CONSTRAINT [FK_Agent_Prepaids_Sys_Users]
GO
ALTER TABLE [dbo].[Agent_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Prepaids_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[Jobs] ([ID])
GO
ALTER TABLE [dbo].[Agent_Prepaids] CHECK CONSTRAINT [FK_Prepaids_Jobs]
GO
ALTER TABLE [dbo].[Agent_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Prepaids_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Agent_Prepaids] CHECK CONSTRAINT [FK_Prepaids_Sys_Users]
GO
ALTER TABLE [dbo].[Customer_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Prepaids_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([ID])
GO
ALTER TABLE [dbo].[Customer_Prepaids] CHECK CONSTRAINT [FK_Customer_Prepaids_Customers]
GO
ALTER TABLE [dbo].[Customer_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Prepaids_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Customer_Prepaids] CHECK CONSTRAINT [FK_Customer_Prepaids_Sys_Users]
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_Customs_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[Jobs] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_Customs] CHECK CONSTRAINT [FK_CustomerQuotation_Customs_Jobs]
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
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerQuotation_CustomsDetails_CustomsProcess_QuotationDetails] FOREIGN KEY([FeeDetailID])
REFERENCES [dbo].[CustomsProcess_QuotationDetails] ([ID])
GO
ALTER TABLE [dbo].[CustomerQuotation_CustomsDetails] CHECK CONSTRAINT [FK_CustomerQuotation_CustomsDetails_CustomsProcess_QuotationDetails]
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
ALTER TABLE [dbo].[CustomsProcess_FeeTypes]  WITH CHECK ADD  CONSTRAINT [FK_CustomsProcess_FeeTypes_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomsProcess_FeeTypes] CHECK CONSTRAINT [FK_CustomsProcess_FeeTypes_Sys_Users]
GO
ALTER TABLE [dbo].[CustomsProcess_QuotationDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomsProcess_QuotationDetails_CustomsProcess_Quotations] FOREIGN KEY([QuotationID])
REFERENCES [dbo].[CustomsProcess_Quotations] ([ID])
GO
ALTER TABLE [dbo].[CustomsProcess_QuotationDetails] CHECK CONSTRAINT [FK_CustomsProcess_QuotationDetails_CustomsProcess_Quotations]
GO
ALTER TABLE [dbo].[CustomsProcess_QuotationDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomsProcess_QuotationDetails_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomsProcess_QuotationDetails] CHECK CONSTRAINT [FK_CustomsProcess_QuotationDetails_Sys_Users]
GO
ALTER TABLE [dbo].[CustomsProcess_Quotations]  WITH CHECK ADD  CONSTRAINT [FK_CustomsProcess_Quotations_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[CustomsProcess_Quotations] CHECK CONSTRAINT [FK_CustomsProcess_Quotations_Sys_Users]
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
ALTER TABLE [dbo].[Job_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Job_Prepaids_Jobs] FOREIGN KEY([JobID])
REFERENCES [dbo].[Jobs] ([ID])
GO
ALTER TABLE [dbo].[Job_Prepaids] CHECK CONSTRAINT [FK_Job_Prepaids_Jobs]
GO
ALTER TABLE [dbo].[Job_Prepaids]  WITH CHECK ADD  CONSTRAINT [FK_Job_Prepaids_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Job_Prepaids] CHECK CONSTRAINT [FK_Job_Prepaids_Sys_Users]
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
ALTER TABLE [dbo].[Job_QuotationRoutes]  WITH CHECK ADD  CONSTRAINT [FK_Job_QuotationRoutes_TransportPlaces] FOREIGN KEY([PlaceStart])
REFERENCES [dbo].[TransportPlaces] ([ID])
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] CHECK CONSTRAINT [FK_Job_QuotationRoutes_TransportPlaces]
GO
ALTER TABLE [dbo].[Job_QuotationRoutes]  WITH CHECK ADD  CONSTRAINT [FK_Job_QuotationRoutes_TransportPlaces1] FOREIGN KEY([PlaceEnd])
REFERENCES [dbo].[TransportPlaces] ([ID])
GO
ALTER TABLE [dbo].[Job_QuotationRoutes] CHECK CONSTRAINT [FK_Job_QuotationRoutes_TransportPlaces1]
GO
ALTER TABLE [dbo].[Job_Workings]  WITH CHECK ADD  CONSTRAINT [FK_Job_Workings_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO
ALTER TABLE [dbo].[Job_Workings] CHECK CONSTRAINT [FK_Job_Workings_Sys_Users]
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
ALTER TABLE [dbo].[Quotation_Routes]  WITH CHECK ADD  CONSTRAINT [FK_Quotation_Routes_TransportCompany_VehicleType_Loads] FOREIGN KEY([VehicleLoadID])
REFERENCES [dbo].[TransportCompany_VehicleType_Loads] ([ID])
GO
ALTER TABLE [dbo].[Quotation_Routes] CHECK CONSTRAINT [FK_Quotation_Routes_TransportCompany_VehicleType_Loads]
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
