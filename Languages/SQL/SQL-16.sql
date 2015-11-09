create database Example
on primary (
	NAME = Example_Primary,
	FILENAME = 'D:\DB\Example\Example_Primary.mdf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 5MB
),
filegroup Example DEFAULT (
	NAME = Example_01,
	FILENAME = 'E:\DB\Example\Example_01.ndf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
), (
	NAME = Example_02,
	FILENAME = 'F:\DB\Example\Example_02.ndf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
),
filegroup Example_FullText (
	NAME = Example_FullText_01,
	FILENAME = 'E:\DB\Example\Example_FullText_01.ndf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
), (
	NAME = Example_FullText_02,
	FILENAME = 'F:\DB\Example\Example_FullText_02.ndf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
)
log on (
	NAME = Example_Log,
	FILENAME = 'G:\DB\Example\Example_Log.ldf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 5MB
)
