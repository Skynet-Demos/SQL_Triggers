-- Table DDLTriggerEvents script
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DDLTriggerEvents](
	[EventDate] [datetime] NOT NULL,
	[EventType] [nvarchar](64) NULL,
	[EventDDL] [nvarchar](max) NULL,
	[EventXML] [xml] NULL,
	[DatabaseName] [nvarchar](255) NULL,
	[SchemaName] [nvarchar](255) NULL,
	[ObjectName] [nvarchar](255) NULL,
	[HostName] [varchar](64) NULL,
	[IPAddress] [varchar](48) NULL,
	[ProgramName] [nvarchar](255) NULL,
	[LoginName] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[DDLTriggerEvents] ADD  DEFAULT (getdate()) FOR [EventDate]
GO


-- Table Invoice script
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Invoice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [varchar](20) NULL,
	[InvoiceDate] [date] NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-- Table InvoiceLog script
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InvoiceLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [int] NOT NULL,
	[InvoiceNumber] [varchar](20) NULL,
	[InvoiceDate] [date] NULL,
	[LogMessage] [varchar](2000) NULL,
	[LogDatetime] [datetime] NOT NULL,
 CONSTRAINT [PK_InvoiceLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


