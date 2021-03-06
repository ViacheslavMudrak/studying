USE [master]
GO
/****** Object:  Database [forum]    Script Date: 21.12.2021 13:50:15 ******/
CREATE DATABASE [forum]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'forum', FILENAME = N'C:\Users\MudrakVV\forum.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'forum_log', FILENAME = N'C:\Users\MudrakVV\forum_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [forum] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [forum].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [forum] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [forum] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [forum] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [forum] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [forum] SET ARITHABORT OFF 
GO
ALTER DATABASE [forum] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [forum] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [forum] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [forum] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [forum] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [forum] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [forum] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [forum] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [forum] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [forum] SET  DISABLE_BROKER 
GO
ALTER DATABASE [forum] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [forum] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [forum] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [forum] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [forum] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [forum] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [forum] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [forum] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [forum] SET  MULTI_USER 
GO
ALTER DATABASE [forum] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [forum] SET DB_CHAINING OFF 
GO
ALTER DATABASE [forum] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [forum] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [forum] SET DELAYED_DURABILITY = DISABLED 
GO
USE [forum]
GO
/****** Object:  User [user]    Script Date: 21.12.2021 13:50:15 ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[credentials]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[credentials](
	[user_id] [int] NOT NULL,
	[login] [nvarchar](25) NOT NULL,
	[pasword] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_credentials] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[likes]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[likes](
	[post_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[like_it] [bit] NOT NULL,
 CONSTRAINT [PK_likes] PRIMARY KEY CLUSTERED 
(
	[post_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[logs]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NULL,
	[level] [nvarchar](100) NULL,
	[logger] [nvarchar](200) NULL,
	[message] [nvarchar](max) NULL,
	[properties] [nvarchar](max) NULL,
	[machinename] [nvarchar](200) NULL,
	[callsite] [nvarchar](200) NULL,
	[exception] [nvarchar](max) NULL,
 CONSTRAINT [PK_logs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[posts]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[posts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_time] [datetime] NOT NULL,
	[topic_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[contents] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_posts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[replies]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[replies](
	[post_id] [int] NOT NULL,
	[answ_post_id] [int] NOT NULL,
 CONSTRAINT [PK_replies] PRIMARY KEY CLUSTERED 
(
	[post_id] ASC,
	[answ_post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[topics]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[topics](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_time] [datetime] NOT NULL,
	[user_id] [int] NOT NULL,
	[topic_name] [nvarchar](200) NOT NULL,
	[description] [ntext] NULL,
 CONSTRAINT [PK_topics] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 21.12.2021 13:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[registration_date] [date] NOT NULL,
	[role_id] [int] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (1, N'BorysAdmin', N'a65sfd5')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (2, N'SvitlanaModer', N's4s6dsf')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (3, N'YuliyaModer', N'gfnb88e')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (4, N'SergiyFrolov', N'ewhg84')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (5, N'DmytroPiskyn', N'ef89h8e')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (6, N'MykolaPavlov', N'kyuk999')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (7, N'NataliyaOrlovska', N'wqqe13')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (8, N'OlenaSviridova', N'qewu56')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (9, N'TetyanaTrusova', N'eiubg89')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (10, N'VasylMykytenko', N'kjcxh25')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (11, N'MyhayloBuryak', N'lkgfs956')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (12, N'StepanPetrenko', N'sgw8es')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (13, N'OlegSavilov', N'ij564ew')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (14, N'IgorBilozir', N'sciuq15')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (15, N'OleksandrPolyakov', N'dc5ecw')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (16, N'GannaFisenko', N'ds54rvf')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (17, N'GalynaYakovenko', N'yj8ew9')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (18, N'OksanaLyashko', N'w154ew')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (19, N'VolodymyrPereverzev', N'vd854w')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (20, N'PavloZviroboy', N'nh54h5')
INSERT [dbo].[credentials] ([user_id], [login], [pasword]) VALUES (21, N'TretyakLidiya', N'sa8e8w')
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (1, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (1, 9, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (1, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (1, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (1, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (1, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (2, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (2, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (2, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (2, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (3, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (3, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (3, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (3, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (3, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (3, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (4, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (4, 6, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (4, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (4, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (4, 15, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (5, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (5, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (5, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (5, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (5, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (5, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 5, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 6, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 9, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (6, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (7, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (7, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (7, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (7, 21, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (8, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (8, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (8, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (9, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (10, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (10, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (10, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (11, 5, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (11, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (11, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (11, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (12, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (13, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (13, 9, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (13, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (13, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (14, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (14, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 5, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 6, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 9, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (15, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 6, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (16, 21, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 2, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 9, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 18, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (17, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (18, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (18, 8, 1)
GO
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (18, 18, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (19, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (19, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (19, 21, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (20, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (20, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (20, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (20, 14, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (20, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (20, 21, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (21, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (21, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (21, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (21, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (21, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (21, 20, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (22, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (22, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (22, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (22, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (22, 14, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (22, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 2, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 6, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 9, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (23, 21, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 9, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (24, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (25, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (25, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (25, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (25, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (25, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (26, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (26, 18, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (26, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (27, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (27, 9, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (27, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (27, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (27, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (27, 21, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (28, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (28, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (28, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (28, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (28, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (28, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (29, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (29, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (29, 9, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (29, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (29, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (29, 14, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 7, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (30, 21, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 2, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 5, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 17, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 18, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (31, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 2, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 6, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 7, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (32, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 2, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 7, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 15, 1)
GO
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (33, 21, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (34, 7, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (34, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 14, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (35, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (36, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (36, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (37, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (37, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (37, 6, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (37, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (37, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (38, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (38, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (38, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (38, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (39, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (39, 14, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (39, 20, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (40, 9, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (40, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (40, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (41, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (41, 15, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (41, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (42, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (42, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (42, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (43, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (43, 13, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (43, 15, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (43, 20, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (44, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (44, 6, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (44, 7, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (44, 10, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (45, 9, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (45, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (45, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (46, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (47, 6, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (47, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (47, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (47, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (47, 19, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 13, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (48, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (49, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (50, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (50, 4, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (50, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (50, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (50, 14, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (50, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 3, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 4, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 5, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 11, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 12, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 15, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 18, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (51, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 7, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 19, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (52, 21, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (53, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (53, 17, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (53, 20, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (54, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (54, 12, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (54, 16, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 2, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 8, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 10, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 11, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 14, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 18, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 20, 1)
GO
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (55, 21, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 3, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 5, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 7, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 8, 0)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 16, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 18, 1)
INSERT [dbo].[likes] ([post_id], [user_id], [like_it]) VALUES (56, 19, 1)
SET IDENTITY_INSERT [dbo].[posts] ON 

INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (1, CAST(N'2020-01-15T12:54:00.000' AS DateTime), 1, 20, N'Hyundai KONA Electric установил рекорд дальности полета на одном заряде аккумулятора в 1026 км на гоночной трассе EuroSpeedway Lausitz. Все электромобили были заводскими и немодифицированными. Кроме движков от батарейки работали только фары. ')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (2, CAST(N'2020-01-15T14:21:00.000' AS DateTime), 1, 5, N'а если включить кондер и ютуб ')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (3, CAST(N'2020-01-18T20:41:00.000' AS DateTime), 1, 6, N'На днях ехал с таксистом на Лифе (машина не его, плановая). Он всю дорогу плакал, что в Караване дорогая экспресс-зарядка (а с розетки слишком долго заряжать аж 12часов) и Лиф пипец какая невыгодная машина для такси и запас хода 130км. Пару раз по просьбе включал печку. Ехали 50км/ч через весь город. Благо светофоры были отключены.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (4, CAST(N'2020-01-18T21:06:00.000' AS DateTime), 1, 5, N'так в некоторых странах электрички нифига не дешевле в плане заправки')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (5, CAST(N'2020-01-18T21:15:00.000' AS DateTime), 1, 9, N'во всех абсолютно странах дешевле естественно домашняя зарядка )')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (6, CAST(N'2020-01-18T21:33:00.000' AS DateTime), 1, 13, N'Ну не совсем так, не придумывайте или (коректнее) не упрощайте. Сейчас зарядка дома от резетки в германии (если влепить отдельный "льготный" счетчик) 0.22EUR\КВт. Раньше при (условно) бесплатных суперчаржах как бы не сравнимо. При 20кВт на 100 км (с потерями на низковольтной зарядке) - это в районе 4.5EUR\100км. Это цена за банальный дизель такого же размера. Другой вопрос налог за год -, зато стразовка +. Пока то на то и выходит. А если не морочится отдельным счетчиком - то будет даже дороже. Дальше, зарядка ДОМА предпологает как минимум наличе этого дома, а это другой финансовый уровень, чтобы закрыть глаза на разницу в цене с паблик станциями. Зарядка на работе и в других местах "на халяву" может улучшать ситуацию, но это не всем доступно . И в который раз, полная арифметика с учетом начальной стоимости + топливо + обслуга пока и близко не на стороне электричек. Топливо то вообще ерунда в жизненном цикле для домашнего таза. Но повторю, электричка то не про экономию. Как и все элекетрическое оно победит своими пользовательскими качествами. Как и элетроплиты\духовки вытеснили газовые. Тупо практичнее.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (7, CAST(N'2020-01-19T10:45:00.000' AS DateTime), 1, 14, N'Средний расход большинства авто 15квт на 100 км. это 0,22*15=3,3 евро. Цена дизеля в Германии 1,15 евролитр. На 3 литрах дизеля 100 км не проедешь. Даже если взять Ваши 4,5 евро на 100 км., то на 4 литрах дизеля тоже 100 км не проедешь, в любом случае экономия по электричкам налицо. Что касается потребления, лифы (говорю о них пушо они самы распростаненные) едят в среднем 13квт/ч. Какая обслуга? раз в 3 года фильтр салона поменять?)')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (8, CAST(N'2020-01-19T16:14:00.000' AS DateTime), 1, 16, N'Вот отсюда и следует, что электромобиль, чисто городская штучка. Ну как вариант - пригородная.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (9, CAST(N'2020-01-19T18:32:00.000' AS DateTime), 1, 21, N'в масштабах нашей страны ( когда, к примеру с Днепра до Ужгорода 1300 км) и с нашей инфраструктурой электрозаряок, то да.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (10, CAST(N'2020-01-20T19:15:00.000' AS DateTime), 1, 7, N'Читала потом про эти испытания, они ехали 30-40 км в час) Выехала как-то на своей на полном заряде, показывал максимальную 520 км, вынужденно ехала 3 км со скоростью до 20 км/ч, пересчитал до максимального в 590 км)')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (11, CAST(N'2020-01-21T15:02:00.000' AS DateTime), 1, 11, N'Адаптивные круизы и на двс-машинах уже умеють медленно ездить, в том числе по пробкам ползать.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (12, CAST(N'2020-01-21T15:54:00.000' AS DateTime), 1, 10, N'Адаптивный круиз мне на ДВС не грозит в здравом уме и при памяти . А электричка неизбежна . Хотя может и до автопилота дотянем  тогда пусть у него голова болит')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (13, CAST(N'2020-01-21T16:18:00.000' AS DateTime), 1, 19, N'Адаптивный круиз уже даже на бюджетных шкодах ставят, и не задорого. Лет пять назад премиум-экзотикой был, теперь уже все. У меня круиз с 30км/ч активируется на пустой дороге. Ну и считай с 0км/ч, если есть "ведущий" на радаре. До 30км/ч только на автомате, конечно.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (14, CAST(N'2020-01-22T12:23:00.000' AS DateTime), 1, 10, N'А расскажите как круиз (или как оно там правилно зовется) на маленьких скоростях работает в электричке. Можно любую скорость поставить? ну там 30 или даже 10?')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (15, CAST(N'2020-01-22T13:11:00.000' AS DateTime), 1, 10, N'Да пусть ставят куда хотят . Мне то что с этого. С 30км и у меня активируется , но надо до 30 ещё разогнаться ..а вот с 20 , и чтобы сам догнал на 30 нельзя . Вот это неудобно (мне ).')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (16, CAST(N'2020-01-22T16:40:00.000' AS DateTime), 1, 7, N'Я таким извращением, к сожалению, не занималась, даже в испытательных целях )')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (17, CAST(N'2020-01-22T21:03:00.000' AS DateTime), 1, 10, N'А в чем извращение то? Ехать под знаком 30 именно 30 ?')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (18, CAST(N'2020-01-23T11:00:00.000' AS DateTime), 1, 19, N'Ну и вопрос, который я много раз подымал, при украинском вторичном рынке, ориентированном на импорт б/у из США, где цена уже отыграла налоговую субсидию, брать машины с других рынков или новые из салона - это автоматически переплачивать на размер этой субсидии, так как при продаже говорить "я брал в салоне, поэтому так дорого" не получится, субсидированные конкуренты из США будут давить цену вниз.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (19, CAST(N'2020-01-23T15:56:00.000' AS DateTime), 1, 15, N'Кстати , а как думаешь , почему при столь привлекательных ценах на энергию , это все требовалось субсидировать ? Да и сейчас это есть в других странах .')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (20, CAST(N'2020-01-23T16:21:00.000' AS DateTime), 1, 19, N'По той же причине, что и субсидирование зелёной энергетики - люди сами не купят, бо дорого, инфраструктуры изначально нет - она должна развиваться параллельно рынку. Дорого было в том числе из-за дорогого киловатт-часа в батареях. Аккумуляторы за последние 10 лет сильно шагнули вперёд, в том числе имхо из-за повышенного внимания и расходов в R&D, стимулированных перспективами рынка, для раскрутки которого и понадобились субсидии. Сейчас имхо уже можно субсидии начинать сворачивать, что в штатах и делается согласно предусмотренной ими программе.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (21, CAST(N'2020-01-23T16:29:00.000' AS DateTime), 2, 10, N'Есть тема про грипп, шо ты ото панику тут разводишь? На, читай, уже оперделились, грипп змеиный, китаёзы нажрались больных гадюк и начали всех травить вирусом.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (22, CAST(N'2020-01-23T17:37:00.000' AS DateTime), 2, 16, N'мы фсе умрем хнык-хных (печальный смайлик)')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (23, CAST(N'2020-01-23T17:47:00.000' AS DateTime), 2, 6, N'Смех смехом,но если бы я увидел таких космонавтов разгуливающих по улицам то я бы поднапрягся.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (24, CAST(N'2020-01-23T18:08:00.000' AS DateTime), 2, 18, N'Проблема в тому, що той вірус вже передається від людини до людини. А оперативній дії китайської громадянської оборони я захоплююся.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (25, CAST(N'2020-01-23T18:12:00.000' AS DateTime), 2, 4, N'Как пишут наши эпидемиологи, ссылаясь на китайский специалистов, лекарств нет, лечатся только симптомы, если поздно обратился - склеил ласты.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (26, CAST(N'2020-01-23T18:19:00.000' AS DateTime), 2, 5, N'всех, кто торгует с али-экспресса - на карантин ...')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (27, CAST(N'2020-01-23T18:20:00.000' AS DateTime), 2, 18, N'Проти нових штамів вірусів ліків ніколи не буває. Надія виключно на імунітет та здоровий організм. Ну і карантин від усіх можливих джерел.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (28, CAST(N'2020-01-23T18:21:00.000' AS DateTime), 2, 12, N'Нынче каждый пятый уже наверное, а кто не торгует, соприкасается с этим товаром и сам того не подозревая...под угрозой весь мир, если не найдут лекарство.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (29, CAST(N'2020-01-23T18:25:00.000' AS DateTime), 1, 12, N'Так сейчас же они не субсидии на электрички , а давление на ДВС устраивают . Что собсно правильно и я даже это поддерживаю . Но с точки зрения арифметики - не взлетает каменный цветок . Хоть с какими батареями')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (30, CAST(N'2020-01-23T19:08:00.000' AS DateTime), 2, 19, N'Вирус сам без носителя живёт не более 4 суток...посылки идут гораздо дольше, опасаться надо живых людей и не есть змей.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (31, CAST(N'2020-01-23T19:18:00.000' AS DateTime), 2, 20, N'При чем тут змеи и прочие зверушки? Они ж не в сыром виде это потребляют. Термообработка в виде кипячения хотя бы и хоть бычий хрен. Тут шото прикольнее. Какая то испанка китайская.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (32, CAST(N'2020-01-24T09:52:00.000' AS DateTime), 2, 18, N'Остання інфа, що це вірус летючих мишей, яких їли змії (кобри), а вже їх, як раз у сирому вигляді, як суши, їли люди.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (33, CAST(N'2020-01-24T15:07:00.000' AS DateTime), 2, 7, N'Понаснимают фильмов, а идиоты в лабораториях потом пробуют как оно на самом деле будет  ... про военных подтверждено уже везде, так что там реально не шуточные действия происходят...только вот через границы уже народ просочился...')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (34, CAST(N'2020-01-24T16:44:00.000' AS DateTime), 1, 5, N'Ехал вчера в вечерней пробке Киевской, рядом ехал лиф похоже не такси, без света, на окнах изморозь или так запотели, что не видно ничего, водила тёр тряпочкой лобовое...зачем так жить?')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (35, CAST(N'2020-01-24T17:40:00.000' AS DateTime), 2, 9, N'В Китае удалось вылечить первого пациента с коронавирусом')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (36, CAST(N'2020-01-24T18:28:00.000' AS DateTime), 2, 7, N'Не написано чем личили...возможно ниправда.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (37, CAST(N'2020-01-24T19:09:00.000' AS DateTime), 2, 8, N'А интересно, есть ли цифры сколько человек в том же Китае умирает от гриппа каждый год....? А то что то не вяжется....30 человек умерло и все перекрыто сразу военными....и перекрыто скорей всего раньше...')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (38, CAST(N'2020-01-24T22:45:00.000' AS DateTime), 2, 18, N'Від епідемії, яка розпочалася ледь місяць тому і тому від неї вакцин не існує. І так, не дивіться на кількість загиблих за цей час, дивіться на кількість, що вилікувалися.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (39, CAST(N'2020-01-25T11:20:00.000' AS DateTime), 2, 15, N'Есть шанс выжить и без вакцины, но небольшой. Суть подобных вирусов - в атипичности пневмонии. Обычно пневмония имеет бактериальную природу и лечится антибиотиками. Респираторные вирусы живут в носоглотке. И пневмония (бактериальная) может возникать как осложнение. Но бывают вирусы, проникающие непосредственно в легкие. И тогда в течение 1-3 суток вероятен летальный исход. Именно такую, вирусную пневмонию и лечат Тамифлю (подходит для любых типов гриппа). От этого коронавируса пока подобной вакцины нет.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (40, CAST(N'2020-01-25T14:14:00.000' AS DateTime), 1, 8, N'Здесь показана вся боль')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (41, CAST(N'2020-01-25T15:08:00.000' AS DateTime), 1, 20, N'Та боль даже не в этом. А кто в курсе цен на зарядки? Вот те две зарядки, что он делал это сколько в деньгах ? +минимум 50гр (чай погрется на заправке).')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (42, CAST(N'2020-01-25T22:22:00.000' AS DateTime), 2, 17, N'Поисковик по запросу "Вирус в Китае: Люди падают без сознания прямо на улицах" выдает ужасные видео. Это просто шок!')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (43, CAST(N'2020-01-26T10:55:00.000' AS DateTime), 1, 19, N'Я не в курсе цен, даже не в курсе сколько стоит бытовое электричество (просто заплатил по счетам и всё). Но то шо электромобиль выгодная штука для поездок на работу учебу, с возможностью заряжать дома - это точно!')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (44, CAST(N'2020-01-26T12:39:00.000' AS DateTime), 2, 9, N'WashingtonTimes: По словам израильского эксперта по биологической войне, эпидемия смертоносного вируса, распространяющаяся по всему миру, могла возникнуть в лаборатории в Ухане, связанной с секретной программой биологического оружия в Китае')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (45, CAST(N'2020-01-26T13:04:00.000' AS DateTime), 2, 5, N'пишут, что в Пекине временно приостановили движение междугородних автобусов (и немного ранее- о запрете торговли дикими животными)')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (46, CAST(N'2020-01-26T16:31:00.000' AS DateTime), 2, 21, N'Всемирная организация здравоохранения не стала объявлять международную чрезвычайную ситуацию в связи с вирусом, отчасти из-за того, что за пределами Китая подтвержденных случаев заражения пока немного')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (47, CAST(N'2020-01-26T22:12:00.000' AS DateTime), 1, 20, N'Цена кВт*ч на зарядках или стоимость своей зарядной станции? На публичных в Днепре, в основном что-то около 6-7 грн за кВт*ч на скоростных и 4-4.50 на медленных (часто не пользуюсь, может поправят - я поклацал приложение, посмотрел первые попавшиеся станции). Цена при зарядке дома - 1.68 грн/кВт*ч, 0.84, 0.90, 0.45, 0.67, 0.36 в зависимости от комбинации тарифов (по одной оси электроотопление, по другой 2зонный/3зонный). Своя зарядка обходится около 200-400 баксов, в зависимости от функционала. В комплекте идёт простое зарядное от розетки.')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (48, CAST(N'2020-01-27T15:25:00.000' AS DateTime), 1, 15, N'В кино чувак проехал с Харькова в Запорожье. Два раза дозаряжал. Вопрос ,сколько денег он заплатил . Не теоритически , а конкретно за те две зарядки .')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (49, CAST(N'2020-01-27T15:49:00.000' AS DateTime), 1, 8, N'там же в описании видео написано: "на зарядки потратил 350 грн"')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (50, CAST(N'2020-01-27T18:37:00.000' AS DateTime), 2, 5, N'Миха, ты свой смартфон, не так давно полученный из Китая, уже сдал в поликлинику на опыты?')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (51, CAST(N'2020-01-27T18:47:00.000' AS DateTime), 2, 11, N'Так мне его отправили ещё за месяц до того как вспыхнула инфекция')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (52, CAST(N'2020-01-27T18:49:00.000' AS DateTime), 2, 5, N'Лучше не рисковать и проверить всё-таки')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (53, CAST(N'2020-01-28T17:35:00.000' AS DateTime), 1, 11, N'Выгодно... Надо брать.... И замерзнуть нафиг в пути.... У меня на газу и то дешевле съездить из Харькова до ЗП... Так в тепле и с комфортом (без курток и тряпочек) + никаких зарядок и ненужных чаев, хотя когда замерз в электричке то необходимо')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (54, CAST(N'2020-01-29T16:57:00.000' AS DateTime), 1, 14, N'Ну так а как относиться к людям на старых аварийных корчах? Не в ТТХ же дело, а в человеке. То, что он без света- очень странно. Печька- да. Но свет ерунду потре6ляет')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (55, CAST(N'2020-01-30T20:21:00.000' AS DateTime), 1, 13, N'В тех же жигулях печка работает всегда. А свет, помню спрашивали на форуме лампы светодиодные и ЭКОшины на лиф. В Днепре то и пробок нет, минут 15-20 то ерунда, в Киеве частенько встряваю по незнанию на часок другой. А сколько печь то потребляет на лифе?')
INSERT [dbo].[posts] ([id], [date_time], [topic_id], [user_id], [contents]) VALUES (56, CAST(N'2020-01-31T13:30:00.000' AS DateTime), 1, 5, N'3 кВт в час фен. Если не ошибаюсь. Но это в морозец. Там в нормальной комплектации/годе стоит тепловой насос. Но. Оставим лиф таксистам. Он всегда будет пионером. Но.. проехали уже его. И как раз в пробках в нем и смысл')
SET IDENTITY_INSERT [dbo].[posts] OFF
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (1, 2)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (2, 10)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (3, 4)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (4, 5)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (5, 6)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (6, 7)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (8, 9)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (11, 12)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (12, 13)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (13, 15)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (14, 11)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (15, 16)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (16, 17)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (18, 19)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (19, 20)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (20, 29)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (21, 31)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (22, 23)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (25, 27)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (26, 28)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (26, 30)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (31, 32)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (34, 40)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (35, 36)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (36, 39)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (37, 38)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (40, 41)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (41, 43)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (43, 47)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (48, 49)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (49, 53)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (50, 51)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (51, 52)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (54, 55)
INSERT [dbo].[replies] ([post_id], [answ_post_id]) VALUES (55, 56)
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [role_name]) VALUES (1, N'admin')
INSERT [dbo].[roles] ([id], [role_name]) VALUES (2, N'moder')
INSERT [dbo].[roles] ([id], [role_name]) VALUES (3, N'member')
INSERT [dbo].[roles] ([id], [role_name]) VALUES (4, N'reader')
SET IDENTITY_INSERT [dbo].[roles] OFF
SET IDENTITY_INSERT [dbo].[topics] ON 

INSERT [dbo].[topics] ([id], [date_time], [user_id], [topic_name], [description]) VALUES (1, CAST(N'2020-01-15T11:12:00.000' AS DateTime), 10, N'Электромобили', N'Давно просилась тема. На самом деле вопрос решится год, два когда по трассам будут несколько чадэмок 100 амперных и за 15 минут кофеевания можно задуть 60% и рулить дальше. Ну и делимся, обсуждаем. Вопросы по покупке и эксплуатации приветствуются.')
INSERT [dbo].[topics] ([id], [date_time], [user_id], [topic_name], [description]) VALUES (2, CAST(N'2020-01-23T16:27:00.000' AS DateTime), 5, N'Новый китайский вирус', N'Что там вообще происходит? Пишут карантин,никого не впускать, никого не выпускать. Врачи в химзащитах,пациенты в герметичных ящиках. Зомби что ли?')
SET IDENTITY_INSERT [dbo].[topics] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (1, CAST(N'2019-12-10' AS Date), 1, N'FirstPerson')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (2, CAST(N'2019-12-11' AS Date), 2, N'CulturalModer')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (3, CAST(N'2019-12-12' AS Date), 2, N'LawModer')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (4, CAST(N'2019-12-13' AS Date), 2, N'GeneralModer')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (5, CAST(N'2019-12-14' AS Date), 3, N'Dmytro')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (6, CAST(N'2019-12-15' AS Date), 3, N'Mykola')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (7, CAST(N'2019-12-16' AS Date), 3, N'Nataliya')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (8, CAST(N'2019-12-17' AS Date), 3, N'Olena')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (9, CAST(N'2019-12-18' AS Date), 3, N'Tetyana')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (10, CAST(N'2019-12-19' AS Date), 3, N'Vasyl')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (11, CAST(N'2019-12-20' AS Date), 3, N'Myhaylo')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (12, CAST(N'2019-12-21' AS Date), 3, N'Stepan')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (13, CAST(N'2019-12-22' AS Date), 3, N'Oleg')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (14, CAST(N'2019-12-23' AS Date), 3, N'Igor')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (15, CAST(N'2019-12-24' AS Date), 3, N'Oleksandr')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (16, CAST(N'2019-12-25' AS Date), 3, N'Ganna')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (17, CAST(N'2019-12-26' AS Date), 3, N'Galyna')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (18, CAST(N'2019-12-27' AS Date), 3, N'Oksana')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (19, CAST(N'2019-12-28' AS Date), 3, N'Volodymyr')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (20, CAST(N'2019-12-29' AS Date), 3, N'Pavlo')
INSERT [dbo].[users] ([id], [registration_date], [role_id], [name]) VALUES (21, CAST(N'2019-12-30' AS Date), 3, N'Lidiya')
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[credentials]  WITH CHECK ADD  CONSTRAINT [FK_credentials_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[credentials] CHECK CONSTRAINT [FK_credentials_users]
GO
ALTER TABLE [dbo].[likes]  WITH CHECK ADD  CONSTRAINT [FK_likes_posts] FOREIGN KEY([post_id])
REFERENCES [dbo].[posts] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[likes] CHECK CONSTRAINT [FK_likes_posts]
GO
ALTER TABLE [dbo].[likes]  WITH CHECK ADD  CONSTRAINT [FK_likes_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[likes] CHECK CONSTRAINT [FK_likes_users]
GO
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [FK_posts_topics] FOREIGN KEY([topic_id])
REFERENCES [dbo].[topics] ([id])
GO
ALTER TABLE [dbo].[posts] CHECK CONSTRAINT [FK_posts_topics]
GO
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [FK_posts_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[posts] CHECK CONSTRAINT [FK_posts_users]
GO
ALTER TABLE [dbo].[replies]  WITH CHECK ADD  CONSTRAINT [FK_replies_posts] FOREIGN KEY([post_id])
REFERENCES [dbo].[posts] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[replies] CHECK CONSTRAINT [FK_replies_posts]
GO
ALTER TABLE [dbo].[replies]  WITH CHECK ADD  CONSTRAINT [FK_replies_replies_answ] FOREIGN KEY([answ_post_id])
REFERENCES [dbo].[posts] ([id])
GO
ALTER TABLE [dbo].[replies] CHECK CONSTRAINT [FK_replies_replies_answ]
GO
ALTER TABLE [dbo].[topics]  WITH CHECK ADD  CONSTRAINT [FK_topics_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[topics] CHECK CONSTRAINT [FK_topics_users]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_roles]
GO
USE [master]
GO
ALTER DATABASE [forum] SET  READ_WRITE 
GO
