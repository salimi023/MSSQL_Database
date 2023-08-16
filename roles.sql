USE TBT
GO

/* User Roles */ 
CREATE LOGIN TesztElek 
    WITH PASSWORD = 'p7Q5E8C4s9A4H4A8C4O5X5b5t'
GO

CREATE USER TesztElek FOR LOGIN TesztElek
GO  

ALTER ROLE db_owner ADD MEMBER TesztElek
GO

CREATE LOGIN JohnDoe 
    WITH PASSWORD = 'S0N3x483D1i651j7S2r4V1A24'
GO

CREATE USER JohnDoe FOR LOGIN JohnDoe
GO  

ALTER ROLE db_datawriter ADD MEMBER JohnDoe
GO

CREATE LOGIN JaneDoe 
    WITH PASSWORD = 'R4d2A5r5e8d2z5k8J990L6o5X'
GO

CREATE USER JaneDoe FOR LOGIN JaneDoe
GO  

ALTER ROLE db_datareader ADD MEMBER JaneDoe
GO

/* Application Role */
USE [TBT]
GO
CREATE APPLICATION ROLE [business_profile] WITH DEFAULT_SCHEMA = [business], PASSWORD = N'V8f862G5344067O'
GO
USE [TBT]
GO
ALTER AUTHORIZATION ON SCHEMA::[business] TO [business_profile]
GO

