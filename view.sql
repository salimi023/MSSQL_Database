/* Views */
USE TBT
GO

/* Financial Data of Companies filtered by the level of security clearance */
CREATE VIEW [FinancialData]
AS
SELECT p.bs_shortName_hu AS [Name], b.bank_name AS 'Bank Name', CONCAT(a.zip_code, ' ', a.zip_city,  ', ', b.bank_address) AS 'Bank Address', ba.acc_number AS 'Account Number' FROM [business].[profile] AS p
INNER JOIN [business].[bank_account] AS ba ON(p.bs_id = ba.acc_business)
INNER JOIN [financial].[bank] AS b ON(b.bank_id = ba.acc_bank)
INNER JOIN [address].[zip_city] AS a ON(b.bank_zip_city = a.zip_id)
WHERE p.bs_clearance = (SELECT cl_id FROM [clearance].[clearance] WHERE cl_name = 'Szigorúan Titkos!')
GO

SELECT * FROM [FinancialData]
GO

DROP VIEW [FinancialData]
GO

/* Business Activities filtered by the main activity */
CREATE VIEW [BusinessActivities]
AS
SELECT p.bs_shortName_hu AS [Name], t.teaor_code AS [Code], t.teaor_name AS [Activity] FROM [business].[profile] AS p
INNER JOIN [business].[activities] AS a ON(a.bs_id = p.bs_id)
INNER JOIN [business].[teaor] AS t ON(t.teaor_id = a.teaor_id)
WHERE a.act_main = 1
GO

SELECT * FROM [BusinessActivities]
GO

DROP VIEW [BusinessActivities]

/* Staffmembers */
CREATE VIEW StaffMembers 
AS
SELECT b.bs_shortName_hu AS Business, CONCAT(m.member_firstname, ' ', m.member_lastname) AS [Name], p.pos_name AS Position, a.nationality_name AS Nationality,	CONCAT(addr.zip_code, ' ', addr.zip_city, ', ', m.member_address) AS Address, m.member_phone AS Phone, m.member_email AS Email
FROM [business].[profile] AS b
INNER JOIN [staff].[members] AS m ON(b.bs_id = m.bs_id)
INNER JOIN [staff].[positions] AS p ON(p.pos_id = m.member_position)
LEFT JOIN [address].[nationality] AS a ON(a.nationality_id = m.member_nationality)
INNER JOIN [address].[zip_city] AS addr ON(addr.zip_id = m.member_zip_city)
GO

SELECT * FROM StaffMembers
GO

DROP VIEW StaffMembers
