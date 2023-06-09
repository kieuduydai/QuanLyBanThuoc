USE [master]
GO
/****** Object:  Database [QuanLyBanThuoc]    Script Date: 8/14/2021 9:14:10 PM ******/
CREATE DATABASE [QuanLyBanThuoc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyBanThuoc', FILENAME = N'E:\New folder.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyBanThuoc_log', FILENAME = N'E:\New folder.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyBanThuoc] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyBanThuoc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyBanThuoc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyBanThuoc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyBanThuoc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyBanThuoc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyBanThuoc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyBanThuoc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyBanThuoc] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyBanThuoc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyBanThuoc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyBanThuoc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyBanThuoc] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyBanThuoc] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyBanThuoc] SET QUERY_STORE = OFF
GO
USE [QuanLyBanThuoc]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[IdTable] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Discount] [int] NULL,
	[TotalPrice] [float] NULL,
	[UserName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdBill] [int] NOT NULL,
	[IdMedicine] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IdCategory] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Dosage] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicineCategory]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicineCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sick]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sick](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameSick] [nvarchar](100) NULL,
	[Signal] [nvarchar](1000) NULL,
	[Cure] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableMedicine]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableMedicine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'DuyDai', N'Kiều Duy Đại', N'0', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'giakhanh', N'Nguyễn Gia Khánh', N'0', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'honghai', N'Nguyễn Hồng Hải', N'0', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'tienhung', N'Nguyễn Tiến Hưng', N'1', 1)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (66, CAST(N'2021-05-20' AS Date), CAST(N'2021-05-20' AS Date), 1, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (70, CAST(N'2021-05-21' AS Date), CAST(N'2021-05-21' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (71, CAST(N'2021-05-21' AS Date), CAST(N'2021-05-22' AS Date), 1, 1, 10, 117000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (72, CAST(N'2021-05-21' AS Date), CAST(N'2021-05-21' AS Date), 2, 1, 0, 15000000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (75, CAST(N'2021-05-21' AS Date), CAST(N'2021-05-21' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (76, CAST(N'2021-05-22' AS Date), CAST(N'2021-05-22' AS Date), 2, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (77, CAST(N'2021-05-23' AS Date), CAST(N'2021-05-23' AS Date), 2, 1, 10, 603000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (78, CAST(N'2021-05-26' AS Date), CAST(N'2021-05-27' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (79, CAST(N'2021-05-26' AS Date), CAST(N'2021-05-26' AS Date), 3, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (80, CAST(N'2021-05-27' AS Date), CAST(N'2021-05-27' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (81, CAST(N'2021-05-27' AS Date), CAST(N'2021-05-27' AS Date), 1, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (82, CAST(N'2021-05-27' AS Date), CAST(N'2021-05-27' AS Date), 4, 1, 0, 320000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (83, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 20000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (84, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (85, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (86, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 48000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (87, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 48000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (88, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 1040000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (89, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (90, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 640000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (91, CAST(N'2021-06-02' AS Date), CAST(N'2021-06-02' AS Date), 2, 1, 0, 140000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (93, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 450000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (94, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 4, 1, 0, 540000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (96, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (97, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (98, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 180000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (99, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 60000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (100, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (101, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 160000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (102, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (103, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 560000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (104, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 1, 1, 0, 640000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (105, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (106, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 1, 1, 0, 1370000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (107, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 4, 1, 0, 480000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (108, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (109, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (110, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (111, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (112, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (113, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 450000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (114, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 480000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (115, CAST(N'2021-06-03' AS Date), CAST(N'2021-06-03' AS Date), 2, 1, 0, 800000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (116, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (117, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (118, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 4, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (119, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (120, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 1, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (121, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 2, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (122, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 1, 1, 0, 90000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (123, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 2, 1, 0, 90000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (124, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 4, 1, 0, 70000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (125, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 1, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (127, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 2, 1, 0, 500000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (128, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 4, 1, 10, 180000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (129, CAST(N'2021-06-04' AS Date), CAST(N'2021-06-04' AS Date), 4, 1, 0, 1650000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (130, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 570000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (131, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 60000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (132, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 70000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (133, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 600000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (134, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 600000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (135, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 560000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (136, CAST(N'2021-06-05' AS Date), CAST(N'2021-06-05' AS Date), 2, 1, 0, 500000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (137, CAST(N'2021-04-04' AS Date), CAST(N'2021-04-04' AS Date), 2, 1, 0, 10000000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (138, CAST(N'2021-06-06' AS Date), CAST(N'2021-06-06' AS Date), 2, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (139, CAST(N'2021-06-06' AS Date), CAST(N'2021-06-06' AS Date), 2, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (140, CAST(N'2021-06-06' AS Date), CAST(N'2021-06-06' AS Date), 2, 1, 0, 480000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (141, CAST(N'2021-06-06' AS Date), CAST(N'2021-06-06' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (142, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (143, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 60000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (144, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 4, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (145, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 60000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (146, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (147, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (148, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (149, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 70000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (150, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 120000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (151, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 60000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (152, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (153, CAST(N'2021-06-07' AS Date), CAST(N'2021-06-07' AS Date), 1, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (154, CAST(N'2021-03-07' AS Date), CAST(N'2021-03-07' AS Date), 2, 1, 0, 12000000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (155, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 180000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (156, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 320000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (157, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (158, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 320000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (159, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (160, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 400000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (161, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 320000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (162, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 320000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (163, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 90000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (164, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (165, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (166, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (167, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (168, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 10, 36000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (169, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 4, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (170, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 160000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (171, CAST(N'2021-06-08' AS Date), CAST(N'2021-06-08' AS Date), 2, 1, 0, 960000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (172, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 240000, N'tienhung')
GO
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (173, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (174, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 10, 45000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (175, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 10, 90000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (176, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 10, 2970000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (177, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (178, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (179, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 10, 360000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (180, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (181, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (182, CAST(N'2021-06-09' AS Date), CAST(N'2021-06-09' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (183, CAST(N'2021-06-10' AS Date), CAST(N'2021-06-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (184, CAST(N'2021-06-10' AS Date), CAST(N'2021-06-10' AS Date), 2, 1, 0, 300000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (185, CAST(N'2021-06-10' AS Date), CAST(N'2021-06-10' AS Date), 2, 1, 0, 300000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (186, CAST(N'2021-06-12' AS Date), CAST(N'2021-06-12' AS Date), 2, 1, 0, 300000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (187, CAST(N'2021-06-12' AS Date), CAST(N'2021-06-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (188, CAST(N'2021-06-12' AS Date), CAST(N'2021-06-12' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (189, CAST(N'2021-06-12' AS Date), CAST(N'2021-06-12' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (190, CAST(N'2021-06-13' AS Date), CAST(N'2021-06-13' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (191, CAST(N'2021-06-14' AS Date), CAST(N'2021-06-14' AS Date), 2, 1, 10, 216000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (192, CAST(N'2021-06-19' AS Date), CAST(N'2021-06-19' AS Date), 2, 1, 10, 288000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (193, CAST(N'2021-06-19' AS Date), CAST(N'2021-06-19' AS Date), 2, 1, 10, 360000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (194, CAST(N'2021-06-19' AS Date), CAST(N'2021-06-19' AS Date), 2, 1, 10, 720000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (195, CAST(N'2021-06-21' AS Date), CAST(N'2021-06-21' AS Date), 2, 1, 0, 800000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (196, CAST(N'2021-06-21' AS Date), CAST(N'2021-06-21' AS Date), 2, 1, 10, 1656000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (197, CAST(N'2021-06-21' AS Date), CAST(N'2021-06-21' AS Date), 2, 1, 10, 630000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (198, CAST(N'2021-06-21' AS Date), CAST(N'2021-06-21' AS Date), 2, 1, 10, 378000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (199, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 2, 1, 10, 171000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (200, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 4, 1, 10, 45000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (201, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 2, 1, 0, 330000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (202, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 2, 1, 0, 140000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (203, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 2, 1, 0, 650000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (204, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 2, 1, 0, 490000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (205, CAST(N'2021-06-23' AS Date), CAST(N'2021-06-23' AS Date), 2, 1, 0, 120000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (206, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (207, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 0, 140000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (208, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 0, 230000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (209, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (210, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 0, 10000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (211, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 0, 110000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (212, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 4, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (213, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 2, 1, 10, 99000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (214, CAST(N'2021-06-24' AS Date), CAST(N'2021-06-24' AS Date), 1, 1, 10, 558000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (215, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 2, 1, 10, 216000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (216, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 1, 1, 5, 133000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (219, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 2, 1, 0, 820000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (226, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 1, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (228, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (229, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 1, 1, 0, 660000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (231, CAST(N'2021-06-25' AS Date), CAST(N'2021-06-25' AS Date), 1, 1, 10, 891000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (232, CAST(N'2021-06-26' AS Date), CAST(N'2021-06-26' AS Date), 2, 1, 0, 170000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (233, CAST(N'2021-06-26' AS Date), CAST(N'2021-06-26' AS Date), 4, 1, 10, 153000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (235, CAST(N'2021-06-27' AS Date), CAST(N'2021-06-27' AS Date), 2, 1, 10, 198000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (237, CAST(N'2021-06-27' AS Date), CAST(N'2021-06-27' AS Date), 4, 1, 10, 180000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (238, CAST(N'2021-06-27' AS Date), CAST(N'2021-06-27' AS Date), 2, 1, 10, 387000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (240, CAST(N'2021-06-28' AS Date), CAST(N'2021-06-28' AS Date), 2, 1, 10, 315000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (242, CAST(N'2021-06-29' AS Date), CAST(N'2021-06-29' AS Date), 2, 1, 10, 360000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (244, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (245, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 2, 1, 10, 279000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (246, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 1, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (248, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 2, 1, 10, 225000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (249, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 1, 1, 10, 414000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (251, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 4, 1, 10, 81000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (252, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 2, 1, 10, 486000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (253, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 2, 1, 10, 243000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (254, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-25' AS Date), 3, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (259, CAST(N'2021-07-23' AS Date), CAST(N'2021-07-23' AS Date), 2, 1, 10, 108000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (260, CAST(N'2021-07-24' AS Date), CAST(N'2021-07-24' AS Date), 2, 1, 10, 729000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (261, CAST(N'2021-07-24' AS Date), CAST(N'2021-07-24' AS Date), 4, 1, 10, 270000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (263, CAST(N'2021-07-24' AS Date), CAST(N'2021-07-24' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (264, CAST(N'2021-07-24' AS Date), CAST(N'2021-07-24' AS Date), 2, 1, 10, 567000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (266, CAST(N'2021-07-24' AS Date), CAST(N'2021-07-24' AS Date), 2, 1, 10, 414000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (267, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 300000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (268, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (269, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (270, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (271, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 160000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (272, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 3, 1, 0, 160000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (273, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 3, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (274, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (275, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 240000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (276, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 22000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (279, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 1, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (280, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (281, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 480000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (282, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 10000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (283, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 0, 220000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (284, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 10, 117000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (287, CAST(N'2021-07-25' AS Date), CAST(N'2021-07-25' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (288, CAST(N'2021-07-26' AS Date), CAST(N'2021-07-26' AS Date), 2, 1, 0, 180000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (289, CAST(N'2021-07-26' AS Date), CAST(N'2021-07-26' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (291, CAST(N'2021-07-26' AS Date), CAST(N'2021-07-27' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (292, CAST(N'2021-07-26' AS Date), CAST(N'2021-07-26' AS Date), 4, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (294, CAST(N'2021-07-27' AS Date), CAST(N'2021-07-27' AS Date), 2, 1, 10, 351000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (298, CAST(N'2021-07-27' AS Date), CAST(N'2021-07-27' AS Date), 1, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (299, CAST(N'2021-07-27' AS Date), CAST(N'2021-07-27' AS Date), 2, 1, 0, 10000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (300, CAST(N'2021-07-27' AS Date), CAST(N'2021-07-27' AS Date), 2, 1, 0, 10000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (301, CAST(N'2021-07-27' AS Date), CAST(N'2021-07-27' AS Date), 3, 1, 0, 10000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (302, CAST(N'2021-07-27' AS Date), CAST(N'2021-07-27' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (303, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 124000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (304, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 532000, N'tienhung')
GO
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (305, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (306, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (307, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 1020000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (308, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 532000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (309, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 979000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (310, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 632000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (311, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 614000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (314, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 104000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (317, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 104000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (324, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 4, 1, 0, 590000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (331, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (339, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 210000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (341, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 10, 297000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (343, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (345, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 1, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (347, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 250000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (349, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (350, CAST(N'2021-07-28' AS Date), CAST(N'2021-07-28' AS Date), 2, 1, 10, 19800, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (353, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (364, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 1, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (365, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (369, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 1, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (400, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (401, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 0, 22000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (404, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 10, 252000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (406, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 10, 153000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (407, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 2, 1, 10, 478800, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (417, CAST(N'2021-07-29' AS Date), CAST(N'2021-07-29' AS Date), 1, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (437, CAST(N'2021-07-30' AS Date), CAST(N'2021-07-30' AS Date), 4, 1, 10, 225000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (438, CAST(N'2021-07-30' AS Date), CAST(N'2021-07-30' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (443, CAST(N'2021-07-31' AS Date), CAST(N'2021-07-31' AS Date), 2, 1, 0, 210000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (444, CAST(N'2021-07-31' AS Date), CAST(N'2021-07-31' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (446, CAST(N'2021-07-31' AS Date), CAST(N'2021-07-31' AS Date), 2, 1, 0, 234000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (448, CAST(N'2021-07-31' AS Date), CAST(N'2021-07-31' AS Date), 4, 1, 10, 225000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (449, CAST(N'2021-07-31' AS Date), CAST(N'2021-07-31' AS Date), 2, 1, 10, 478800, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (450, CAST(N'2021-08-01' AS Date), CAST(N'2021-08-01' AS Date), 2, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (452, CAST(N'2021-08-01' AS Date), CAST(N'2021-08-01' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (454, CAST(N'2021-08-01' AS Date), CAST(N'2021-08-01' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (455, CAST(N'2021-08-01' AS Date), CAST(N'2021-08-01' AS Date), 2, 1, 10, 93600, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (457, CAST(N'2021-08-04' AS Date), CAST(N'2021-08-04' AS Date), 4, 1, 0, 520, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (458, CAST(N'2021-08-04' AS Date), CAST(N'2021-08-04' AS Date), 4, 1, 0, 160, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (459, CAST(N'2021-08-04' AS Date), CAST(N'2021-08-04' AS Date), 1, 1, 0, 80, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (473, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-05' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (475, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-05' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (477, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-05' AS Date), 2, 1, 0, 614000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (480, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-05' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (483, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-05' AS Date), 1, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (486, CAST(N'2021-08-05' AS Date), CAST(N'2021-08-05' AS Date), 2, 1, 0, 590000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (488, CAST(N'2021-08-06' AS Date), CAST(N'2021-08-06' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (489, CAST(N'2021-08-06' AS Date), CAST(N'2021-08-06' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (490, CAST(N'2021-08-06' AS Date), CAST(N'2021-08-06' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (491, CAST(N'2021-08-06' AS Date), CAST(N'2021-08-06' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (492, CAST(N'2021-08-06' AS Date), CAST(N'2021-08-06' AS Date), 2, 1, 0, 60000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (495, CAST(N'2021-08-06' AS Date), CAST(N'2021-08-06' AS Date), 2, 1, 0, 690000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (509, CAST(N'2021-08-08' AS Date), CAST(N'2021-08-08' AS Date), 2, 1, 0, 4000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (510, CAST(N'2021-08-08' AS Date), CAST(N'2021-08-08' AS Date), 2, 1, 0, 800000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (511, CAST(N'2021-08-08' AS Date), CAST(N'2021-08-08' AS Date), 2, 1, 0, 600000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (512, CAST(N'2021-08-08' AS Date), CAST(N'2021-08-08' AS Date), 2, 1, 0, 198000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (513, CAST(N'2021-08-08' AS Date), CAST(N'2021-08-08' AS Date), 2, 1, 0, 220000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (514, CAST(N'2021-08-08' AS Date), CAST(N'2021-08-08' AS Date), 2, 1, 0, 308000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (520, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 450000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (526, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 0, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (531, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 215000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (534, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (535, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 4, 1, 0, 20000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (545, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 590000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (547, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (548, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 290000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (563, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 1000000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (568, CAST(N'2021-08-09' AS Date), CAST(N'2021-08-09' AS Date), 2, 1, 0, 104000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (571, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 0, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (573, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (575, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (576, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 160000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (577, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 160000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (578, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (579, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (580, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 410000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (581, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (582, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (583, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 347000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (584, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 312300, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (585, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (586, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (587, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (588, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (589, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (590, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (591, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (592, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (593, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (594, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 531000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (595, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (596, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (597, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (598, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 1367000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (599, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (600, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (601, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (602, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
GO
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (603, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 4, 76800, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (604, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (605, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (606, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (607, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 10, 72000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (608, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (609, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (611, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (612, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (613, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (614, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (615, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (616, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (617, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 510000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (618, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (619, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 1041000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (620, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 1020000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (621, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (622, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 1, 1, 0, 4000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (623, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (624, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 771300, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (626, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 4000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (627, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 32000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (628, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (629, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 100000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (630, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 200000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (631, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 0, 857000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (632, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 2, 1, 10, 459000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (633, CAST(N'2021-08-10' AS Date), CAST(N'2021-08-10' AS Date), 4, 1, 10, 126000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (635, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 10000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (636, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (637, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (638, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (639, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (640, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (641, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 2550000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (642, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (643, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (644, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (645, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (646, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 10, 3600, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (647, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (648, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (650, CAST(N'2021-08-11' AS Date), CAST(N'2021-08-11' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (652, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 4, 1, 0, 1392000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (653, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 857000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (655, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (656, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (659, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (667, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 2220000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (668, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 88000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (669, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 110000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (670, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 220000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (671, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (672, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (673, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (674, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (675, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 270000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (676, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (677, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (678, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 857000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (679, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 40000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (680, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 22000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (686, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 109000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (688, CAST(N'2021-08-12' AS Date), CAST(N'2021-08-12' AS Date), 2, 1, 0, 367000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (689, CAST(N'2021-08-13' AS Date), CAST(N'2021-08-13' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (690, CAST(N'2021-08-13' AS Date), CAST(N'2021-08-13' AS Date), 2, 1, 0, 877000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (691, CAST(N'2021-08-13' AS Date), CAST(N'2021-08-13' AS Date), 2, 1, 10, 368100, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (692, CAST(N'2021-08-13' AS Date), CAST(N'2021-08-13' AS Date), 4, 1, 10, 3600, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (693, CAST(N'2021-08-13' AS Date), CAST(N'2021-08-13' AS Date), 2, 1, 0, 877000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (695, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (696, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 0, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (698, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 80000, N'giakhanh')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (700, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 130000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (701, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 3, 1, 0, 130000, NULL)
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (702, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 260000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (703, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 986000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (704, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 4, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (705, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 80000, N'tienhung')
INSERT [dbo].[Bill] ([Id], [DateCheckIn], [DateCheckOut], [IdTable], [Status], [Discount], [TotalPrice], [UserName]) VALUES (706, CAST(N'2021-08-14' AS Date), CAST(N'2021-08-14' AS Date), 2, 1, 0, 4000, N'DuyDai')
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (111, 66, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (117, 72, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (120, 75, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (121, 76, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (122, 71, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (123, 71, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (124, 77, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (125, 77, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (126, 77, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (127, 79, 6, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (128, 78, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (129, 80, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (130, 81, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (131, 82, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (132, 82, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (133, 82, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (134, 83, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (135, 84, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (136, 85, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (137, 86, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (139, 87, 2, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (140, 88, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (141, 89, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (142, 90, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (143, 91, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (144, 91, 4, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (146, 93, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (147, 94, 4, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (150, 96, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (151, 97, 4, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (152, 98, 4, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (153, 99, 4, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (154, 100, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (155, 101, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (156, 102, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (157, 103, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (158, 104, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (159, 105, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (160, 106, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (161, 106, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (162, 106, 8, 7)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (163, 107, 2, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (164, 108, 2, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (165, 109, 1, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (167, 110, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (168, 111, 1, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (170, 112, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (172, 113, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (173, 114, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (174, 114, 1, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (175, 115, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (176, 116, 6, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (177, 117, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (178, 118, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (179, 119, 6, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (180, 120, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (181, 121, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (182, 122, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (183, 123, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (184, 124, 8, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (185, 125, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (186, 128, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (187, 129, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (188, 129, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (189, 129, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (190, 127, 6, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (191, 130, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (192, 130, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (193, 130, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (194, 131, 2, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (195, 132, 8, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (196, 133, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (197, 133, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (198, 134, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (199, 134, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (200, 135, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (201, 135, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (202, 136, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (203, 136, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (204, 138, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (205, 139, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (206, 139, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (207, 140, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (208, 140, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (209, 141, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (210, 141, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (211, 142, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (212, 143, 2, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (213, 144, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (214, 145, 2, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (215, 146, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (216, 147, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (217, 148, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (218, 149, 8, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (219, 150, 11, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (220, 151, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (221, 152, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (222, 153, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (223, 155, 5, 3)
GO
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (224, 156, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (225, 157, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (226, 158, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (227, 159, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (228, 160, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (229, 161, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (230, 162, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (231, 163, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (232, 164, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (233, 165, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (234, 166, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (235, 167, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (236, 168, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (237, 169, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (238, 170, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (239, 171, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (240, 172, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (241, 173, 11, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (242, 174, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (243, 175, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (244, 176, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (245, 177, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (246, 178, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (247, 179, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (248, 180, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (249, 181, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (250, 182, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (251, 183, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (252, 184, 6, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (253, 185, 6, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (254, 186, 6, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (255, 187, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (256, 188, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (257, 189, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (258, 190, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (259, 191, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (260, 192, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (261, 193, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (262, 194, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (263, 195, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (264, 196, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (265, 196, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (266, 197, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (267, 197, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (268, 198, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (269, 198, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (270, 199, 4, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (271, 199, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (272, 200, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (273, 201, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (274, 201, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (275, 202, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (276, 202, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (277, 203, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (278, 204, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (279, 204, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (280, 204, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (281, 205, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (282, 205, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (283, 206, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (284, 207, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (285, 207, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (286, 208, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (287, 208, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (288, 209, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (289, 210, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (290, 211, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (291, 211, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (292, 212, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (293, 213, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (294, 213, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (295, 214, 6, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (296, 214, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (297, 214, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (298, 214, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (299, 215, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (300, 215, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (301, 215, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (302, 216, 12, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (303, 216, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (304, 216, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (307, 219, 10, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (308, 219, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (309, 219, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (319, 226, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (321, 228, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (322, 228, 12, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (323, 229, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (324, 229, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (328, 231, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (329, 232, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (330, 232, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (331, 233, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (332, 233, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (335, 235, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (336, 235, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (337, 235, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (339, 237, 6, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (342, 238, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (343, 238, 10, 2)
GO
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (344, 238, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (348, 240, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (349, 240, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (350, 240, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (354, 242, 8, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (355, 242, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (356, 242, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (359, 244, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (360, 245, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (361, 245, 10, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (362, 245, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (363, 246, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (364, 246, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (365, 246, 4, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (366, 246, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (368, 248, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (369, 248, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (370, 248, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (371, 251, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (372, 251, 8, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (374, 252, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (375, 252, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (376, 252, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (377, 249, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (378, 249, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (381, 253, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (382, 253, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (383, 253, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (388, 259, 9, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (389, 259, 10, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (390, 260, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (391, 260, 11, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (392, 260, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (394, 261, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (395, 261, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (396, 263, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (397, 264, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (398, 264, 11, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (399, 264, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (400, 266, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (403, 266, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (404, 267, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (405, 267, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (406, 268, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (407, 269, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (408, 270, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (409, 271, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (410, 254, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (411, 272, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (412, 272, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (413, 273, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (414, 274, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (415, 274, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (416, 274, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (417, 274, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (418, 275, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (419, 275, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (420, 275, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (421, 276, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (424, 279, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (425, 280, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (426, 281, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (427, 281, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (428, 281, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (429, 282, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (430, 283, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (431, 283, 4, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (432, 284, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (435, 287, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (436, 287, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (437, 287, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (438, 287, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (439, 288, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (440, 288, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (441, 289, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (443, 292, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (444, 292, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (445, 292, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (446, 292, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (447, 291, 28, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (449, 294, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (450, 294, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (451, 294, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (454, 298, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (455, 298, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (456, 298, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (457, 298, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (458, 299, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (459, 301, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (461, 300, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (462, 302, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (463, 303, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (464, 303, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (465, 304, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (466, 304, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (467, 304, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (468, 304, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (469, 305, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (470, 305, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (471, 305, 24, 5)
GO
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (472, 305, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (473, 306, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (474, 306, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (475, 306, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (476, 306, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (477, 307, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (478, 307, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (479, 307, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (480, 307, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (481, 308, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (482, 308, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (483, 308, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (484, 308, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (485, 309, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (486, 309, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (487, 309, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (488, 309, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (489, 309, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (490, 310, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (491, 310, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (492, 310, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (493, 310, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (494, 310, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (495, 311, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (496, 311, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (497, 311, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (498, 311, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (499, 311, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (500, 311, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (511, 314, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (512, 314, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (521, 317, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (522, 317, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (548, 324, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (549, 324, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (550, 324, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (551, 324, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (552, 324, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (577, 331, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (578, 331, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (579, 331, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (580, 331, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (606, 339, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (607, 339, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (610, 341, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (612, 343, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (613, 343, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (614, 343, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (615, 343, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (621, 347, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (622, 347, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (623, 347, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (626, 349, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (627, 349, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (628, 349, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (629, 349, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (630, 350, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (632, 353, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (633, 353, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (634, 353, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (635, 353, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (681, 364, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (682, 364, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (683, 364, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (684, 364, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (685, 365, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (686, 365, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (687, 365, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (688, 365, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (701, 369, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (702, 369, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (703, 369, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (704, 369, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (803, 400, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (804, 400, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (805, 400, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (806, 400, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (807, 401, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (816, 404, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (817, 404, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (819, 406, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (820, 406, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (822, 407, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (823, 407, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (824, 407, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (825, 407, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (847, 417, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (848, 417, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (849, 417, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (850, 417, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (905, 437, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (906, 437, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (907, 437, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (910, 438, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (911, 438, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (912, 438, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (913, 438, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (929, 443, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (930, 443, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (932, 444, 22, 2)
GO
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (933, 444, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (934, 444, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (935, 444, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (936, 446, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (937, 446, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (938, 446, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (939, 448, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (940, 448, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (941, 448, 12, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (944, 449, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (945, 449, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (946, 449, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (947, 449, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (948, 450, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (952, 452, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (953, 452, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (954, 452, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (955, 452, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (956, 454, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (957, 454, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (958, 454, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (959, 454, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (960, 455, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (961, 455, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (964, 457, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (965, 457, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (968, 458, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (969, 458, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (970, 459, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1008, 473, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1010, 475, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1011, 475, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1012, 475, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1013, 475, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1018, 477, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1019, 477, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1020, 477, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1021, 477, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1022, 477, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1023, 477, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1027, 480, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1028, 480, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1029, 480, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1030, 480, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1035, 483, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1041, 486, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1042, 486, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1043, 486, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1044, 486, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1045, 486, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1050, 488, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1051, 489, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1052, 490, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1053, 491, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1054, 492, 4, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1057, 495, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1058, 495, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1059, 495, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1060, 495, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1061, 495, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1062, 495, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1095, 509, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1096, 510, 7, 4)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1097, 511, 7, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1098, 512, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1099, 513, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1100, 514, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1107, 520, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1108, 520, 6, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1109, 520, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1112, 520, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1125, 531, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1126, 531, 11, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1127, 531, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1131, 534, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1132, 535, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1147, 545, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1148, 545, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1149, 545, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1150, 545, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1151, 545, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1156, 547, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1157, 548, 7, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1158, 548, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1159, 548, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1171, 563, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1172, 563, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1173, 563, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1174, 563, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1175, 563, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1176, 563, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1179, 568, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1180, 568, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1189, 575, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1190, 576, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1191, 577, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1192, 578, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1193, 579, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1194, 580, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1195, 580, 21, 6)
GO
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1196, 581, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1197, 581, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1198, 581, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1199, 581, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1200, 582, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1201, 583, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1202, 583, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1203, 584, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1204, 584, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1205, 585, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1206, 586, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1207, 587, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1208, 588, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1209, 589, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1210, 590, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1211, 590, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1212, 590, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1213, 590, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1214, 591, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1215, 592, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1216, 593, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1217, 594, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1218, 594, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1219, 594, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1220, 594, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1221, 594, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1222, 595, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1223, 596, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1224, 597, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1225, 598, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1226, 598, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1227, 598, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1228, 598, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1229, 599, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1230, 600, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1231, 601, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1232, 602, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1233, 573, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1234, 604, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1235, 605, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1236, 606, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1237, 607, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1238, 608, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1239, 603, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1240, 609, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1242, 611, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1243, 612, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1244, 613, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1245, 614, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1246, 615, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1247, 616, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1248, 616, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1249, 616, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1250, 616, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1251, 617, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1252, 617, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1253, 617, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1254, 617, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1255, 618, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1256, 619, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1257, 619, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1258, 620, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1259, 620, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1260, 620, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1261, 620, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1262, 621, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1263, 622, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1264, 623, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1265, 623, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1266, 623, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1267, 623, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1268, 624, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1269, 624, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1270, 624, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1271, 624, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1276, 626, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1277, 627, 26, 8)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1278, 628, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1279, 629, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1280, 630, 27, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1281, 631, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1282, 631, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1283, 631, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1284, 631, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1285, 633, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1286, 633, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1288, 632, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1289, 632, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1290, 632, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1291, 632, 25, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1292, 635, 9, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1293, 636, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1294, 637, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1295, 638, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1296, 639, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1297, 640, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1298, 641, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1299, 641, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1300, 641, 24, 5)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1301, 641, 25, 5)
GO
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1302, 642, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1303, 643, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1304, 644, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1305, 645, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1306, 646, 26, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1307, 647, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1308, 648, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1310, 650, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1311, 652, 26, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1312, 652, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1313, 652, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1315, 653, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1316, 653, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1317, 653, 24, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1318, 653, 25, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1320, 655, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1321, 656, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1327, 659, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1341, 667, 19, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1342, 667, 21, 6)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1343, 668, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1344, 669, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1345, 670, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1346, 670, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1347, 670, 27, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1348, 671, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1349, 672, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1350, 673, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1351, 674, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1352, 675, 5, 3)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1353, 676, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1354, 677, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1355, 678, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1356, 678, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1357, 678, 24, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1358, 678, 25, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1359, 679, 3, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1360, 680, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1368, 686, 26, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1369, 686, 29, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1370, 686, 27, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1373, 688, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1374, 688, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1375, 688, 31, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1376, 689, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1377, 690, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1378, 690, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1379, 690, 31, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1380, 690, 24, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1381, 690, 25, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1382, 692, 26, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1383, 691, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1384, 691, 31, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1385, 691, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1386, 693, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1387, 693, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1388, 693, 31, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1389, 693, 24, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1390, 693, 25, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1392, 695, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1394, 698, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1396, 701, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1397, 700, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1398, 702, 20, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1399, 704, 19, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1400, 703, 22, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1401, 703, 23, 2)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1402, 703, 24, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1403, 703, 25, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1404, 703, 31, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1405, 703, 26, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1406, 703, 29, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1407, 703, 27, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1408, 705, 1, 1)
INSERT [dbo].[BillInfo] ([Id], [IdBill], [IdMedicine], [count]) VALUES (1409, 706, 26, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Medicine] ON 

INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (1, N'Phosphalugel', 1, 80000, 0, N'Dùng 1 - 2 gói trên lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (2, N'Yumangel', 1, 60000, 0, N'Dùng 3 - 2 gói trên lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (3, N'Metrogylgel', 2, 40000, 4, N'Bôi 1-3 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (4, N'Hồ tetraped', 2, 60000, 0, N'Bôi 1-2 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (5, N'Liver Detox', 3, 90000, 999, N'Uống 1-3 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (6, N' Milk Thistle', 3, 100000, 0, N'Uống 1 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (7, N'Enalapril', 4, 200000, 39, N'Uống 1 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (8, N'Perindopril', 4, 70000, 0, N'Uống 2 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (9, N'Tiffy Dey', 5, 10000, 2000, N'Uống 2 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (10, N'Pacemin', 5, 100000, 51, N'Uống 3 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (11, N'Melatonic', 6, 60000, 61, N'Uống 1 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (12, N'ALOHA for Brain', 6, 40000, 1000, N'Uống 2 lần trên ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (19, N'Becberin', 1, 80000, 13, N'Dùng 1 - 2 gói trên lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (20, N'Otiv', 6, 130000, 993, N'Dùng 2 viên trên lần/ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (21, N'Wit 30VQ', 6, 330000, 74, N'Ngày uống 2 lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (22, N'Paracetamol', 5, 325000, 69, N'Dùng 1 viên trên lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (23, N'Oresol', 5, 22000, 131, N'Pha với 500ml nước uống thay nước lọc')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (24, N'Ibuprofen', 5, 88000, 157, N'1/2 - 1viên /lần, ngày 3 - 4 lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (25, N'Rotunda', 5, 75000, 157, N'1-2 viên/1 lần, 2-3 lần/1 ngày')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (26, N'Xanh Methylen', 2, 4000, 171, N' Bôi dung dịch Xanh methylen 1% ngày 2 – 3 lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (27, N'Dizigone', 2, 100000, 185, N'Ngày bôi từ 2-3 lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (28, N'Acyclovir Stada', 5, 40000, 199, N'Mỗi lần dùng 200 mg Acyclovir, các liều cách nhau tối thiểu 4 giờ')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (29, N'Purple potion Kmno4', 2, 5000, 998, N' Bôi dung dịch  ngày 2 – 3 lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (30, N'Sulfasalazine', 1, 200000, 1000, N'Ngày uống 2 lần')
INSERT [dbo].[Medicine] ([Id], [Name], [IdCategory], [Price], [Quantity], [Dosage]) VALUES (31, N'My vita', 5, 20000, 995, N'Ngày uống  1 - 2 viên trên lần')
SET IDENTITY_INSERT [dbo].[Medicine] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicineCategory] ON 

INSERT [dbo].[MedicineCategory] ([Id], [Name]) VALUES (1, N'Thuốc trị dạ dày')
INSERT [dbo].[MedicineCategory] ([Id], [Name]) VALUES (2, N'Thuốc trị da liễu')
INSERT [dbo].[MedicineCategory] ([Id], [Name]) VALUES (3, N'Thuốc trị gan')
INSERT [dbo].[MedicineCategory] ([Id], [Name]) VALUES (4, N'Thuốc trị tim mạch')
INSERT [dbo].[MedicineCategory] ([Id], [Name]) VALUES (5, N'Thuốc trị cảm cúm')
INSERT [dbo].[MedicineCategory] ([Id], [Name]) VALUES (6, N'Thuốc bổ')
SET IDENTITY_INSERT [dbo].[MedicineCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Sick] ON 

INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (1, N'Sốt virus', N'Bệnh nhân sốt virus có đặc điểm là sốt rất cao, sốt tăng dần theo diễn biến bệnh, nhiệt độ cơ thể có thể đạt từ 39 - 41 độ C. Đây cũng là triệu chứng phân biệt sốt virus với cảm sốt thông thường.
Sốt virus thường khiến phần đầu và các cơ có cảm giác mệt mỏi, uể oải khó chịu, cơ thể rơi vào trạng thái mất cân bằng.
Nhức đầu thường đến sau triệu chứng sốt và mệt mỏi. Người bị sốt virus cũng cảm thấy đau mắt, nóng rát trong nhãn cầu, cảm giác khó chịu, không muốn mở mắt. Khi vi khuẩn xâm nhập vào đường hô hấp gây sốt virus, bệnh nhân sẽ bị sưng các hạch nhỏ ở đầu, cổ, có thể nhận thấy khi sờ bằng tay', N'Oresol, Paracetamol, My vita')
INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (2, N'Bệnh quai bị', N'Sốt cao đột ngột,chán ăn.Đau đầu.
Sau khi sốt 1-3 ngày; tuyến nước bọt đau nhức, sưng to, có thể sưng ở một hoặc cả hai bên, khiến khuôn mặt bệnh nhân bị biến dạng, khó nhai, khó nuốt. Đây là dấu hiệu đặc trưng của
bệnh quai bị.Buồn nôn, nôn.
Đau cơ, nhức mỏi toàn thân.
Mệt mỏi.', N'Paracetamol, Oresol, Ibuprofen, Rotunda')
INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (3, N'Bệnh thủy đậu', N'Người bị Thủy đậu sẽ có những triệu chứng ban đầu là: sốt nhẹ, đau đầu, mệt mỏi. Trong khoảng 24 - 48 giờ sau đó trên da sẽ xuất hiện ban đỏ có đường kính khoảng vài milimet. Nhiều trường hợp còn nổi hạch sau tai và viêm họng.', N'Acyclovir, Xanh methylen, Purple potion Kmno4, Dizigone')
INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (4, N'Bệnh sởi', N'Sốt, Ho khan, Sổ mũi, Ăn không ngon,
Chảy máu cam, Đau họng,Viêm kết mạc. Xuất hiện những đốm Koplik trắng nhỏ với tâm màu trắng hơi xanh trên nền đỏ bên trong miệng hay trên niêm mạc bên trong của má.', N'Oresol, Phenobarbital, Diazepam')
INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (5, N'Sốt xuất huyết', N'Đau phía sau mắt, đau nhức đầu nghiêm trọng. Đau khớp và cơ
Sốt cao, có thể lên đến 40,5 độ C
Phát ban buồn nôn và ói mửa', N'Paracetamol, Aspirin, Acetaminophen')
INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (6, N'Viêm não Nhật Bản', N'Thường khá nguy hiểm do khả năng gây tổn thương ở não, để lại di chứng thần kinh nghiêm trọng và tỷ lệ tử vong cao. Bệnh thường khởi phát đột ngột với các triệu chứng đầu tiên nhận thấy là sốt cao đến 39 - 40 độ C, kèm theo các cơn đau đầu, cảm giác buồn nôn và nôn. Sau đó, viêm não Nhật Bản dẫn đến dấu hiệu co giật, co cứng cơ và lú lẫn.

Triệu chứng điển hình trong giai đoạn toàn phát là các dấu hiệu rối loạn ở não, màng não và hệ thần kinh thực vật. Bên cạnh đó, bệnh nhân có biểu hiện rối loạn vận động, thể hiện chủ yếu trên khuôn mặt, bao gồm co cứng cơ mặt, cơn quay mắt quay đầu, co giật bất thường, liệt nửa người, mất khả năng ngôn ngữ.', N'Tiêm vắc xin Jevax ')
INSERT [dbo].[Sick] ([Id], [NameSick], [Signal], [Cure]) VALUES (9, N'Viêm đại tràng', N'Viêm đại tràng cấp tính do lỵ amip: đau bụng quặn từng cơn, buồn đại tiện liên tục, nhưng mỗi lần đi tiêu chỉ có một ít phân, có máu và chất nhầy kèm theo phân.
Viêm đại tràng cấp do lỵ trực khuẩn: sốt, đau bụng, đi ngoài phân lỏng có máu, trong một ngày đêm đi nhiều lần phân lẫn máu, phân có màu như máu cá. Đặc biệt, nếu do Shigella shiga, số lần đi tiêu không thể đếm được (phân chảy ra theo đường hậu môn, không thành khuôn), mất nước và chất điện giải nhiều rất dễ gây trụy tim mạch.
Viêm đại tràng cấp do các nguyên nhân khác: triệu chứng đau bụng là chủ yếu, đau thắt bụng dưới, đau từng đoạn hoặc đau dọc theo khung đại tràng, đau do co thắt đại tràng, có khi gây cứng bụng, tiêu chảy xảy ra đột ngột, phân toàn nước (có thể có máu, nhầy), người mệt mỏi, gầy sút nhanh.', N'Sulfasalazine')
SET IDENTITY_INSERT [dbo].[Sick] OFF
GO
SET IDENTITY_INSERT [dbo].[TableMedicine] ON 

INSERT [dbo].[TableMedicine] ([Id], [Name], [Status]) VALUES (1, N'0', N'Trống')
INSERT [dbo].[TableMedicine] ([Id], [Name], [Status]) VALUES (2, N'1', N'Trống')
INSERT [dbo].[TableMedicine] ([Id], [Name], [Status]) VALUES (3, N'2', N'Trống')
INSERT [dbo].[TableMedicine] ([Id], [Name], [Status]) VALUES (4, N'3', N'Trống')
SET IDENTITY_INSERT [dbo].[TableMedicine] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'User') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Medicine] ADD  DEFAULT (N'Chưa đặt tên') FOR [Name]
GO
ALTER TABLE [dbo].[Medicine] ADD  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Medicine] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[MedicineCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [Name]
GO
ALTER TABLE [dbo].[TableMedicine] ADD  DEFAULT (N'Bàn chưa có tên') FOR [Name]
GO
ALTER TABLE [dbo].[TableMedicine] ADD  DEFAULT (N'Trống') FOR [Status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [fk_bill_id_TableMedicine] FOREIGN KEY([IdTable])
REFERENCES [dbo].[TableMedicine] ([Id])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [fk_bill_id_TableMedicine]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [fk_Bill_userName_Account] FOREIGN KEY([UserName])
REFERENCES [dbo].[Account] ([UserName])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [fk_Bill_userName_Account]
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD  CONSTRAINT [fk_billInfo_id_Bill] FOREIGN KEY([IdBill])
REFERENCES [dbo].[Bill] ([Id])
GO
ALTER TABLE [dbo].[BillInfo] CHECK CONSTRAINT [fk_billInfo_id_Bill]
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD  CONSTRAINT [fk_billInfo_id_Medicine] FOREIGN KEY([IdMedicine])
REFERENCES [dbo].[Medicine] ([Id])
GO
ALTER TABLE [dbo].[BillInfo] CHECK CONSTRAINT [fk_billInfo_id_Medicine]
GO
ALTER TABLE [dbo].[Medicine]  WITH CHECK ADD  CONSTRAINT [fk_medicine_id_MedicineCategory] FOREIGN KEY([IdCategory])
REFERENCES [dbo].[MedicineCategory] ([Id])
GO
ALTER TABLE [dbo].[Medicine] CHECK CONSTRAINT [fk_medicine_id_MedicineCategory]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
       @userName nvarchar(100)
        AS BEGIN
        SELECT *FROM dbo.Account Where UserName =@userName
       END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.Name AS [Tên bàn], b.TotalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá], UserName AS[Tài Khoản]
	FROM dbo.Bill AS b,dbo.TableMedicine AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   --End
   --Tạo PROC lấy dữ liệu từ TableMedicine
   Create PROC [dbo].[USP_GetTableList]
   AS SELECT * FROM dbo.TableMedicine
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBill]
@idTable INT,@UserName Nvarchar(100)
AS 
BEGIN Insert dbo.Bill(DateCheckIn,DateCheckOut,IdTable,Status,Discount,UserName)
VALUES(GETDATE(),NULL,@idTable,0,0,@UserName)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idMedicine INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @medicineCount INT = 1
	
	SELECT @isExitsBillInfo = id, @medicineCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE IdBill = @idBill AND IdMedicine = @idMedicine

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @medicineCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @medicineCount + @count WHERE IdMedicine = @idMedicine
		ELSE
			DELETE dbo.BillInfo WHERE IdBill = @idBill AND IdMedicine = @idMedicine
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
        ( IdBill, IdMedicine, count )
		VALUES  ( @idBill, -- idBill - int
          @idMedicine, -- idFood - int
          @count  -- count - int
          )
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--End
--Tạo PROC lấy dữ liệu từ Account cho đăng nhập
   CREATE PROC [dbo].[USP_Login]
   @userName Nvarchar(100),
   @passWord Nvarchar(100)
   AS 
   BEGIN
   SELECT *FROM dbo.Account Where UserName=@userName AND PassWord=@passWord
   END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTabel]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTabel]
@idTable1 INT, @idTable2 int,@UserName nvarchar(100)
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSeconrdBill INT
	
	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
	
	
	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status,
				  UserName
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  ,-- status - int
				  @UserName
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idSeconrdBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status,
				  UserName
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0 , -- status - int
				  @UserName
		        )
		SELECT @idSeconrdBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	UPDATE dbo.BillInfo SET idBill = @idSeconrdBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmty = 0)
		UPDATE dbo.TableMedicine SET status = N'Trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmty= 0)
		UPDATE dbo.TableMedicine SET status = N'Trống' WHERE id = @idTable1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 8/14/2021 9:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyBanThuoc] SET  READ_WRITE 
GO
