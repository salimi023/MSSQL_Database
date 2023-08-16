/* DATABASE CREATION FILE */
USE master
GO

/* Create database */
DROP DATABASE IF EXISTS TBT
GO

CREATE DATABASE TBT
GO

USE TBT
GO

/* DROP TABLES */
DROP TABLE IF EXISTS [clearance].[clearance]
DROP TABLE IF EXISTS [address].[zip_city]
DROP TABLE IF EXISTS [address].[nationality]
DROP TABLE IF EXISTS [financial].[bank]
DROP TABLE IF EXISTS [business].[profile]
DROP TABLE IF EXISTS [business].[bank_account]
DROP TABLE IF EXISTS [business].[teaor]
DROP TABLE IF EXISTS [business].[activities]
DROP TABLE IF EXISTS [business].[site_types]
DROP TABLE IF EXISTS [business].[sites]
DROP TABLE IF EXISTS [business].[entity_type]
DROP TABLE IF EXISTS [business].[other_entities]
DROP TABLE IF EXISTS [business].[entity_nationality]
DROP TABLE IF EXISTS [business].[relation_types]
DROP TABLE IF EXISTS [business].[relations]
DROP TABLE IF EXISTS [staff].[positions]
DROP TABLE IF EXISTS [staff].[members]
DROP TABLE IF EXISTS [authorities].[type]
DROP TABLE IF EXISTS [authorities].[authorities]
DROP TABLE IF EXISTS [users].[users]

/* DROP SCHEMAS */
DROP SCHEMA IF EXISTS [clearance]
DROP SCHEMA IF EXISTS [address]
DROP SCHEMA IF EXISTS [financial]
DROP SCHEMA IF EXISTS [business]
DROP SCHEMA IF EXISTS [staff]
DROP SCHEMA IF EXISTS [authorities]
DROP SCHEMA IF EXISTS [users]
GO

/* Schema "clearance" (Level of Security Clearance) */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'clearance') EXEC('CREATE SCHEMA [clearance]')
GO

-- Levels of clearance
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'clearance.clearance')
CREATE TABLE [clearance].[clearance] (
	cl_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    cl_name VARCHAR(25) NOT NULL UNIQUE
)
GO

/* Schema "address" (Address data) */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'address') EXEC('CREATE SCHEMA [address]')
GO

-- Nationality data
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'address.nationality')
CREATE TABLE [address].[nationality](
    nationality_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    nationality_name VARCHAR(50) NOT NULL UNIQUE,
    nationality_code VARCHAR(3) NOT NULL UNIQUE
)
GO

-- Zip and City data
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'address.zip_city')
CREATE TABLE [address].[zip_city](
    zip_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    zip_code VARCHAR(20) NOT NULL UNIQUE,
    zip_city VARCHAR(50) NOT NULL,
    nationality_id INT NOT NULL FOREIGN KEY REFERENCES [address].[nationality](nationality_id)    
)
GO

/* Schema "financial" (Bank data) */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'financial') EXEC('CREATE SCHEMA [financial]')
GO

-- Bank data
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'financial.bank')
CREATE TABLE [financial].[bank](
    bank_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    bank_name VARCHAR(100) NOT NULL UNIQUE,
    bank_zip_city INT NOT NULL FOREIGN KEY REFERENCES [address].[zip_city](zip_id),
    bank_address VARCHAR(100) NOT NULL
)
GO

/* Schema "business" (Business profile data) */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'business') EXEC('CREATE SCHEMA [business]')
GO

-- Business profile
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.profile')
CREATE TABLE [business].[profile](
    bs_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    bs_clearance INT DEFAULT NULL FOREIGN KEY REFERENCES [clearance].[clearance](cl_id),
    bs_fullName_hu VARCHAR(100) NOT NULL,
    bs_shortName_hu VARCHAR(100) NOT NULL,
    bs_fullName_en VARCHAR(100) DEFAULT NULL,
    bs_shortName_en VARCHAR(100) DEFAULT NULL,
    bs_statistical_num VARCHAR(25) NOT NULL UNIQUE,
    bs_tax_number VARCHAR(25) NOT NULL UNIQUE,
    bs_registry_number VARCHAR(25) NOT NULL UNIQUE,
    bs_capital_amount FLOAT NOT NULL,
    bs_foundation_date DATE NOT NULL,
    bs_seat_city INT NOT NULL FOREIGN KEY REFERENCES [address].[zip_city](zip_id),
    bs_seat_address VARCHAR(100) NOT NULL,
    bs_PO_box VARCHAR(10) DEFAULT NULL,
    bs_phone VARCHAR(20) NOT NULL,
    bs_email VARCHAR(20) NOT NULL UNIQUE,
    bs_nonNATO_nonEU_rel BIT DEFAULT 1,
    bs_CEO_foreign_rel BIT DEFAULT 1,
    bs_foreign_inf_attempt BIT DEFAULT 1,
    bs_mil_project BIT DEFAULT 1,
    bs_classified_contr BIT DEFAULT 1,
    bs_other_info TEXT DEFAULT NULL
)
GO

-- Business bank account(s)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.bank_account')
CREATE TABLE [business].[bank_account](
    acc_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    acc_business INT NOT NULL FOREIGN KEY REFERENCES [business].[profile](bs_id),
    acc_bank INT NOT NULL FOREIGN KEY REFERENCES [financial].[bank](bank_id),
    acc_number VARCHAR(50) NOT NULL UNIQUE
)
GO

-- TEÁOR codes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.teaor')
CREATE TABLE [business].[teaor](
    teaor_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    teaor_code VARCHAR(20) NOT NULL UNIQUE,
    teaor_name VARCHAR(50) NOT NULL
)
GO

-- Business activities
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.activities')
CREATE TABLE [business].[activities](
    act_id INT IDENTITY(1, 1 ) NOT NULL PRIMARY KEY,
    bs_id INT FOREIGN KEY REFERENCES [business].[profile](bs_id),
    teaor_id INT FOREIGN KEY REFERENCES [business].[teaor](teaor_id),
    act_main BIT NOT NULL DEFAULT 1
)
GO

-- Business site types
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.site_types')
CREATE TABLE [business].[site_types](
    type_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
)
GO

-- Bussiness sites
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.sites')
CREATE TABLE [business].[sites](
    site_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    bs_id INT NOT NULL FOREIGN KEY REFERENCES [business].[profile](bs_id),
    zip_id INT NOT NULL FOREIGN KEY REFERENCES [address].[zip_city](zip_id),
    site_address VARCHAR(100) NOT NULL,
    site_name VARCHAR(100) NOT NULL,
    site_type INT FOREIGN KEY REFERENCES [business].[site_types](type_id)
)
GO

-- Types of other entities
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.entity_type')
CREATE TABLE [business].[entity_type](
    type_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
)
GO

-- Other entities (e.g shareholders, founders etc.)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.other_entities')
CREATE TABLE [business].[other_entities](
    ent_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    ent_legal_name VARCHAR(100) DEFAULT NULL,
    ent_first_name VARCHAR(50) DEFAULT NULL,
    ent_last_name VARCHAR(50) DEFAULT NULL,
    ent_type INT NOT NULL FOREIGN KEY REFERENCES [business].[entity_type](type_id),
    ent_pod VARCHAR(50) DEFAULT NULL,
    ent_dob DATE DEFAULT NULL CHECK (ent_dob > '1900-01-01'),
    ent_mother_name VARCHAR(50) DEFAULT NULL,    
    ent_zip_city INT DEFAULT NULL FOREIGN KEY REFERENCES [address].[zip_city](zip_id),
    ent_address VARCHAR(100) DEFAULT NULL,
    ent_reg_number VARCHAR(20) DEFAULT NULL,
    ent_tax_number VARCHAR(20) DEFAULT NULL,
    ent_share INT DEFAULT NULL CHECK (ent_share > 0)
)
GO

-- Nationality of the entities
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.entity_nationality')
CREATE TABLE [business].[entity_nationality](
    ent_nat_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    ent_id INT NOT NULL FOREIGN KEY REFERENCES [business].[other_entities](ent_id),
    nationality_id INT NOT NULL FOREIGN KEY REFERENCES [address].[nationality](nationality_id)
)
GO

-- Business relation types
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.entity_relation_types')
CREATE TABLE [business].[relation_types](
    type_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
) 
GO

-- Business relations
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'business.relations')
CREATE TABLE [business].[relations](
    rel_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    bs_id INT NOT NULL FOREIGN KEY REFERENCES [business].[profile](bs_id),
    ent_id INT NOT NULL FOREIGN KEY REFERENCES [business].[other_entities](ent_id),
    [type_id] INT NOT NULL FOREIGN KEY REFERENCES [business].[relation_types]([type_id])
)
GO

/* Schema "authorities" */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'authorities') EXEC('CREATE SCHEMA [authorities]')
GO

-- Types of authorities
CREATE TABLE [authorities].[type](
    type_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE    
)
GO

-- Authorities
CREATE TABLE [authorities].[authorities](
    auth_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    auth_name VARCHAR(50) NOT NULL UNIQUE,
    auth_type INT FOREIGN KEY REFERENCES [authorities].[type](type_id)    
)
GO

/* Schema "staff" */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'staff') EXEC('CREATE SCHEMA [staff]')
GO

-- Positions
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'staff.positions')
CREATE TABLE [staff].[positions](
    pos_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    pos_name VARCHAR(50) NOT NULL UNIQUE
)
GO

-- Staff members
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'staff.members')
CREATE TABLE [staff].[members](
    member_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    bs_id INT NOT NULL FOREIGN KEY REFERENCES [business].[profile](bs_id),
    member_firstname VARCHAR(20) NOT NULL,
    member_lastname VARCHAR(20) NOT NULL,
    member_birth_firstname VARCHAR(20) DEFAULT NULL,
    member_birth_lastname VARCHAR(20) DEFAULT NULL,
    member_position INT NOT NULL FOREIGN KEY REFERENCES [staff].[positions](pos_id),
    member_pob VARCHAR(50) NOT NULL,
    member_dob DATE NOT NULL CHECK (member_dob > '1900-01-01'),
    member_mother_name VARCHAR(50) NOT NULL,
    member_nationality INT NOT NULL FOREIGN KEY REFERENCES [address].[nationality](nationality_id),
    member_zip_city INT NOT NULL FOREIGN KEY REFERENCES [address].[zip_city](zip_id),
    member_address VARCHAR(100) NOT NULL,
    member_phone VARCHAR(20) DEFAULT NULL,
    member_email VARCHAR(20) DEFAULT NULL,
    member_sec_clearance_date DATE DEFAULT NULL,
    member_sec_clearance_authority INT DEFAULT NULL FOREIGN KEY REFERENCES [authorities].[authorities](auth_id)  
)
GO

/* Schema "users" */
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'users') EXEC('CREATE SCHEMA [users]')
GO

-- User's data
CREATE TABLE [users].[users](
    user_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    user_firstname VARCHAR(50) NOT NULL,
    user_lastname VARCHAR(50) NOT NULL,
    user_login VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL UNIQUE,
    user_password VARCHAR(256) NOT NULL
)
GO