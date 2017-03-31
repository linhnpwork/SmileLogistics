USE [Smile_Logistics]
GO

/****** Object:  Table [dbo].[Job_Workings]    Script Date: 31-03-17 8:53:14 PM ******/
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
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Job_Workings_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Job_Workings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Job_Workings]  WITH CHECK ADD  CONSTRAINT [FK_Job_Workings_Sys_Users] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[Sys_Users] ([ID])
GO

ALTER TABLE [dbo].[Job_Workings] CHECK CONSTRAINT [FK_Job_Workings_Sys_Users]
GO

