﻿-- Customers

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Customers_Id]') AND type = 'D') ALTER TABLE [Customers] DROP CONSTRAINT [DF_Customers_Id]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Customers]') AND type in (N'U')) DROP TABLE [Customers]

CREATE TABLE [Customers](
	[Id] UNIQUEIDENTIFIER NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Hostname] NVARCHAR(128) NOT NULL,
	[AdminEmail] NVARCHAR(50) NOT NULL,
	[Enabled] BIT NOT NULL,
	[EncryptionKey] NVARCHAR(255) NOT NULL,
 CONSTRAINT [PK_dbo.CustomerDescriptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- ApiTokens

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK_ApiTokens_Customers]') AND parent_object_id = OBJECT_ID('ApiTokens')) ALTER TABLE Users DROP CONSTRAINT FK_ApiTokens_Customers
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'ApiTokens') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE ApiTokens

CREATE TABLE ApiTokens (
	Id UNIQUEIDENTIFIER NOT NULL, 
	Name NVARCHAR(255) NOT NULL, 
	Token NVARCHAR(255) NOT NULL, 
	CustomerId UNIQUEIDENTIFIER NOT NULL,
	PRIMARY KEY (Id)
)

-- AuditLog

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK_AuditLog_Customers]') AND parent_object_id = OBJECT_ID('AuditLog')) ALTER TABLE Users DROP CONSTRAINT FK_AuditLog_Customers
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'AuditLog') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE AuditLog

CREATE TABLE AuditLog (
    Id UNIQUEIDENTIFIER NOT NULL,
    TimeStamp DATETIME NOT NULL,
    Username NVARCHAR(255) NULL,
    EntityType NVARCHAR(255) NOT NULL,
    EntityId UNIQUEIDENTIFIER NOT NULL,
    Action NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL,
	CustomerId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id)
)

-- IPS

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FKA0CDFB32869EBE96]') AND parent_object_id = OBJECT_ID('IPS')) ALTER TABLE IPS DROP CONSTRAINT FKA0CDFB32869EBE96
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FKA0CDFB32804A62A3]') AND parent_object_id = OBJECT_ID('IPS')) ALTER TABLE IPS DROP CONSTRAINT FKA0CDFB32804A62A3
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK_IPS_Customers]') AND parent_object_id = OBJECT_ID('IPS')) ALTER TABLE IPS DROP CONSTRAINT FK_IPS_Customers
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'IPS') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE IPS

CREATE TABLE IPS (
    Id UNIQUEIDENTIFIER NOT NULL,
    CreatedOn DATETIME NULL,
    UpdatedOn DATETIME NULL,
    Name NVARCHAR(255) NULL,
    StartBytes VARBINARY(MAX) NOT NULL,
    EndBytes VARBINARY(MAX) NOT NULL,
    CreatedBy UNIQUEIDENTIFIER NULL,
    UpdatedBy UNIQUEIDENTIFIER NULL,
	CustomerId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id)
)

-- ReferenceListItems

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK_ReferenceListItems_Customers]') AND parent_object_id = OBJECT_ID('ReferenceListItems')) ALTER TABLE Users DROP CONSTRAINT FK_ReferenceListItems_Customers
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FKB7F41DBDE42A69B6]') AND parent_object_id = OBJECT_ID('ReferenceListItems')) ALTER TABLE ReferenceListItems DROP CONSTRAINT FKB7F41DBDE42A69B6
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'ReferenceListItems') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE ReferenceListItems

CREATE TABLE ReferenceListItems (
    Id UNIQUEIDENTIFIER NOT NULL,
    Value NVARCHAR(255) NOT NULL,
    ReferenceListId UNIQUEIDENTIFIER NULL,
	CustomerId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id)
)

-- ReferenceLists

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'ReferenceLists') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE ReferenceLists	

CREATE TABLE ReferenceLists (
    Id UNIQUEIDENTIFIER NOT NULL,
    SystemName NVARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (Id)
)

-- NotificationMessages

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'NotIFicationMessages') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE NotificationMessages

CREATE TABLE NotificationMessages (
    Id UNIQUEIDENTIFIER NOT NULL,
    NotIFicationType NVARCHAR(255) NULL,
    Subject NVARCHAR(255) NULL,
    Body NVARCHAR(255) NULL,
    CreatedOn DATETIME NULL,
    ReferenceId UNIQUEIDENTIFIER NULL,
    SenderId UNIQUEIDENTIFIER NULL,
    PRIMARY KEY (Id)
)

-- Roles

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK_Roles_Customers]') AND parent_object_id = OBJECT_ID('Roles')) ALTER TABLE Users DROP CONSTRAINT FK_Roles_Customers
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'Roles') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE Roles

CREATE TABLE Roles (
    Id UNIQUEIDENTIFIER NOT NULL,
    Name NVARCHAR(255) NULL,
    UserType NVARCHAR(255) NULL,
    SystemRole BIT NULL,
	CustomerId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id)
)

-- RoleUsers

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK1D67E2ACCE5FEF8C]') AND parent_object_id = OBJECT_ID('RoleUsers')) ALTER TABLE RoleUsers  DROP CONSTRAINT FK1D67E2ACCE5FEF8C
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK1D67E2AC9900A6BA]') AND parent_object_id = OBJECT_ID('RoleUsers')) ALTER TABLE RoleUsers  DROP CONSTRAINT FK1D67E2AC9900A6BA
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'RoleUsers') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE RoleUsers

CREATE TABLE RoleUsers (
    RoleId UNIQUEIDENTIFIER NOT NULL,
    UserId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (UserId, RoleId)
)

-- UserSecurityQuestions

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FKF2DE24B6CE5FEF8C]') AND parent_object_id = OBJECT_ID('UserSecurityQuestions')) ALTER TABLE UserSecurityQuestions DROP CONSTRAINT FKF2DE24B6CE5FEF8C
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'UserSecurityQuestions') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE UserSecurityQuestions

CREATE TABLE UserSecurityQuestions (
    Id UNIQUEIDENTIFIER NOT NULL,
    Question NVARCHAR(255) NULL,
    Answer NVARCHAR(255) NULL,
    UserId UNIQUEIDENTIFIER NULL,
    PRIMARY KEY (Id)
)

-- Users

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK2C1C7FE5869EBE96]') AND parent_object_id = OBJECT_ID('Users')) ALTER TABLE Users DROP CONSTRAINT FK2C1C7FE5869EBE96
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK2C1C7FE5804A62A3]') AND parent_object_id = OBJECT_ID('Users')) ALTER TABLE Users DROP CONSTRAINT FK2C1C7FE5804A62A3
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FK_Users_Customers]') AND parent_object_id = OBJECT_ID('Users')) ALTER TABLE Users DROP CONSTRAINT FK_Users_Customers
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'Users') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE Users

CREATE TABLE Users (
    Id UNIQUEIDENTIFIER NOT NULL,
    CreatedOn DATETIME NULL,
    UpdatedOn DATETIME NULL,
    UserType NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    PasswordExpiryDate DATETIME NOT NULL,
    RegisteredDate DATETIME NOT NULL,
    Enabled BIT NOT NULL,
    LastLoginIP NVARCHAR(255) NULL,
    LastLoginDate DATETIME NULL,
    PasswordResetToken NVARCHAR(255) NULL,
    PasswordResetTokenExpiry DATETIME NULL,
    CreatedBy UNIQUEIDENTIFIER NULL,
    UpdatedBy UNIQUEIDENTIFIER NULL,	
	CustomerId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id)
)

-- UserNotifications

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FKD944DD8ECE5FEF8C]') AND parent_object_id = OBJECT_ID('UserNotifications')) ALTER TABLE UserNotifications  DROP CONSTRAINT FKD944DD8ECE5FEF8C
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[FKD944DD8E5266C05C]') AND parent_object_id = OBJECT_ID('UserNotifications')) ALTER TABLE UserNotifications  DROP CONSTRAINT FKD944DD8E5266C05C
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'UserNotifications') and OBJECTPROPERTY(id, N'IsUserTable') = 1) DROP TABLE UserNotifications

CREATE TABLE UserNotifications (
    UserId UNIQUEIDENTIFIER NOT NULL,
    MessageId UNIQUEIDENTIFIER NOT NULL,
    HasRead BIT NULL,
    PRIMARY KEY (UserId, MessageId)
)

ALTER TABLE ApiTokens WITH CHECK ADD CONSTRAINT FK_ApiTokens_Customers FOREIGN KEY(CustomerId) REFERENCES Customers (Id) ON UPDATE CASCADE ON DELETE CASCADE
ALTER TABLE AuditLog WITH CHECK ADD CONSTRAINT FK_AuditLog_Customers FOREIGN KEY(CustomerId) REFERENCES Customers (Id) ON UPDATE CASCADE ON DELETE CASCADE
ALTER TABLE IPS ADD CONSTRAINT FKA0CDFB32869EBE96 FOREIGN KEY (CreatedBy) REFERENCES Users
ALTER TABLE IPS ADD CONSTRAINT FKA0CDFB32804A62A3 FOREIGN KEY (UpdatedBy) REFERENCES Users
ALTER TABLE IPS WITH CHECK ADD CONSTRAINT FK_IPS_Customers FOREIGN KEY(CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
ALTER TABLE ReferenceListItems ADD CONSTRAINT FKB7F41DBDE42A69B6 FOREIGN KEY (ReferenceListId) REFERENCES ReferenceLists
ALTER TABLE ReferenceListItems WITH CHECK ADD CONSTRAINT FK_ReferenceListItems_Customers FOREIGN KEY(CustomerId) REFERENCES Customers (Id) ON UPDATE CASCADE ON DELETE CASCADE
ALTER TABLE NotificationMessages ADD CONSTRAINT FK31FA2BF489C67B9A FOREIGN KEY (SenderId) REFERENCES Users
ALTER TABLE Roles  WITH CHECK ADD  CONSTRAINT FK_Roles_Customers FOREIGN KEY(CustomerId) REFERENCES Customers (Id) ON UPDATE CASCADE ON DELETE CASCADE
ALTER TABLE RoleUsers ADD CONSTRAINT FK1D67E2ACCE5FEF8C FOREIGN KEY (UserId) REFERENCES Users
ALTER TABLE RoleUsers ADD CONSTRAINT FK1D67E2AC9900A6BA FOREIGN KEY (RoleId) REFERENCES Roles
ALTER TABLE UserSecurityQuestions ADD CONSTRAINT FKF2DE24B6CE5FEF8C FOREIGN KEY (UserId) REFERENCES Users
ALTER TABLE Users ADD CONSTRAINT FK2C1C7FE5869EBE96 FOREIGN KEY (CreatedBy) REFERENCES Users
ALTER TABLE Users ADD CONSTRAINT FK2C1C7FE5804A62A3 FOREIGN KEY (UpdatedBy) REFERENCES Users
ALTER TABLE Users WITH CHECK ADD CONSTRAINT FK_Users_Customers FOREIGN KEY(CustomerId) REFERENCES [Customers] (Id) ON UPDATE CASCADE
ALTER TABLE UserNotifications WITH CHECK ADD CONSTRAINT FKD944DD8ECE5FEF8C FOREIGN KEY(UserId) REFERENCES Users (Id) ON DELETE CASCADE
ALTER TABLE UserNotifications WITH CHECK ADD CONSTRAINT FKD944DD8E5266C05C FOREIGN KEY(MessageId) REFERENCES NotificationMessages (Id) ON DELETE CASCADE

-- ADDING REFERENCE LISTS

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].[ReferenceLists] where [SystemName] = N'Security Questions')
BEGIN 
	INSERT [dbo].[ReferenceLists] ([Id], [SystemName]) VALUES (newid(), N'Security Questions')
END