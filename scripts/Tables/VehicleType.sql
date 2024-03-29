USE [FleetManagement]
GO

/****** Object:  Table [dbo].[VehicleType]    Script Date: 27-03-2016 03:00:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[VehicleType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
 CONSTRAINT [PK_VehicleType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


