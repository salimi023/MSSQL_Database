USE TBT
GO

DELETE FROM [business].[relations]
DBCC CHECKIDENT ('TBT.business.relations', RESEED, 0)
GO

DELETE FROM [business].[profile]
DBCC CHECKIDENT ('TBT.business.profile', RESEED, 0)
GO

DELETE FROM [clearance].[clearance]
DBCC CHECKIDENT ('TBT.clearance.clearance', RESEED, 0)
GO

DELETE FROM [business].[other_entities]
DBCC CHECKIDENT ('TBT.business.other_entities', RESEED, 0)
GO

DELETE FROM [address].[zip_city]
DBCC CHECKIDENT ('TBT.address.zip_city', RESEED, 0)
GO

DELETE FROM [address].[nationality]
DBCC CHECKIDENT ('TBT.address.nationality', RESEED, 0)
GO

DELETE FROM [business].[bank_account]
DBCC CHECKIDENT ('TBT.business.bank_account', RESEED, 0)
GO

DELETE FROM [financial].[bank]
DBCC CHECKIDENT ('TBT.financial.bank', RESEED, 0)
GO

DELETE FROM [business].[activities]
DBCC CHECKIDENT ('TBT.business.activities', RESEED, 0)
GO

DELETE FROM [business].[entity_nationality]
DBCC CHECKIDENT ('TBT.business.entity_nationality', RESEED, 0)
GO

DELETE FROM [business].[entity_type]
DBCC CHECKIDENT ('TBT.business.entity_type', RESEED, 0)
GO

DELETE FROM [business].[relation_types]
DBCC CHECKIDENT ('TBT.business.relation_types', RESEED, 0)
GO

DELETE FROM [business].[site_types]
DBCC CHECKIDENT ('TBT.business.site_types', RESEED, 0)
GO

DELETE FROM [business].[sites]
DBCC CHECKIDENT ('TBT.business.sites', RESEED, 0)
GO

DELETE FROM [business].[teaor]
DBCC CHECKIDENT ('TBT.business.teaor', RESEED, 0)
GO

DELETE FROM [staff].[positions]
DBCC CHECKIDENT ('TBT.staff.positions', RESEED, 0)
GO

DELETE FROM [staff].[members]
DBCC CHECKIDENT ('TBT.staff.members', RESEED, 0)
GO

DELETE FROM [authorities].[authorities]
DBCC CHECKIDENT ('TBT.authorities.authorities', RESEED, 0)
GO

DELETE FROM [authorities].[type]
DBCC CHECKIDENT ('TBT.authorities.type', RESEED, 0)
GO

DELETE FROM [users].[users]
DBCC CHECKIDENT ('TBT.users.users', RESEED, 0)
GO