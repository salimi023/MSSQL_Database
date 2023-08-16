/* Stored procedures */
USE TBT
GO

-- Stored Procedure with SELECT (Get Business by Clearance)
CREATE OR ALTER PROCEDURE spBusinessByClearance
(
	@clearance AS VARCHAR(50)
)
AS
BEGIN
	SELECT b.bs_shortName_hu AS [Name], b.bs_registry_number AS [Registry], b.bs_foundation_date AS [Foundation] FROM [business].[profile] AS b 
	INNER JOIN [clearance].[clearance] AS c ON(b.bs_clearance = c.cl_id)
	WHERE c.cl_name = @clearance
END
GO

EXECUTE spBusinessByClearance 'Bizalmas'

DROP PROCEDURE spBusinessByClearance

-- Stored procedure with INSERT (Add Employee) 
CREATE OR ALTER PROCEDURE spAddEmployee
(
	@business AS VARCHAR(100),			-- Business Name
	@firstName AS VARCHAR(50),			-- Firstname
	@lastName AS VARCHAR(50),			-- Lastname
	@birthFirstName AS VARCHAR(50),		-- Birth Firstname
	@birthLastName AS VARCHAR(50),		-- Birth Lastname
	@position AS VARCHAR(50),			-- Position
	@pob AS VARCHAR(50),				-- Place of birth
	@dob AS DATE,						-- Date of birth
	@motherName AS VARCHAR(50),			-- Name of mother
	@nationality AS VARCHAR(20),		-- Nationality
	@zipCode AS INT,					-- Zip code
	@zipCity AS VARCHAR(50),			-- City
	@address AS VARCHAR(100),			-- Address line
	@phone AS VARCHAR(20),				-- Phone
	@email AS VARCHAR(50),				-- Email
	@clearanceDate AS DATE,				-- Date of Clearance
	@clearanceAuthority AS VARCHAR(50)	-- Authority issued the Clearance
)
AS
BEGIN	
	SET xact_abort ON
	BEGIN TRANSACTION	
		-- Business ID
		DECLARE @businessID AS INT = (SELECT bs_id FROM [business].[profile] WHERE bs_shortName_hu = @business)
		-- Position
		DECLARE @positionID AS INT = (SELECT pos_id FROM [staff].[positions] WHERE pos_name = @position)
		-- Nationality
		DECLARE @nationalityID AS INT = (SELECT nationality_id FROM [address].[nationality] WHERE nationality_name = @nationality)
		-- City and ZIP code
		DECLARE @zipCityID AS INT = (SELECT zip_id FROM [address].[zip_city] WHERE zip_code = @zipCode AND zip_city = @zipCity)
		-- Clearance Authority
		DECLARE @authorityID AS INT = (SELECT auth_id FROM [authorities].[authorities] WHERE auth_name = @clearanceAuthority)

		INSERT INTO [staff].[members] (
			bs_id,
			member_firstname,
			member_lastname,
			member_birth_firstname,
			member_birth_lastname,
			member_position,
			member_pob,
			member_dob, 
			member_mother_name,
			member_nationality,
			member_zip_city,
			member_address,
			member_phone,
			member_email,
			member_sec_clearance_date,
			member_sec_clearance_authority 			
		) VALUES (
			@businessID, 
			@firstName, 
			@lastName, 
			@birthFirstName, 
			@birthLastName, 
			@positionID, 
			@pob, 
			@dob, 
			@motherName, 
			@nationalityID, 			 
			@zipCityID, 
			@address, 
			@phone, 
			@email, 
			@clearanceDate, 
			@authorityID			
		)				
	COMMIT TRANSACTION
END
GO

EXECUTE spAddEmployee 
@business = 'Roaster Kft.', 
@firstName = 'Lajos', 
@lastName = 'Laza', 
@birthFirstName = NULL, 
@birthLastName = NULL, 
@position = 'biztonsági vezető', 
@pob = 'Debrecen', 
@dob = '1969-11-23', 
@motherName = 'Varga Lujza', 
@nationality = 'szlovák', 
@zipCode = 4026, 
@zipCity = 'Debrecen', 
@address = 'Piac utca 60.', 
@phone = '+36-53-666-7777', 
@email = 'laza@lajos.hu', 
@clearanceDate = '2022-12-22', 
@clearanceAuthority = 'Alkotmányvédelmi Hivatal'

DROP PROCEDURE spAddEmployee

-- Stored procedure with INSERT and Error handling (Add bank account)
CREATE OR ALTER PROCEDURE spAddBankAccount
(
	@business AS VARCHAR(50),
	@bank AS VARCHAR(50),
	@account AS VARCHAR(50)
)
AS
BEGIN
	-- Business ID
	DECLARE @businessID AS INT = (SELECT bs_id FROM [business].[profile] WHERE bs_shortName_hu = @business)
	-- Bank ID
	DECLARE @bankID AS INT = (SELECT bank_id FROM [financial].[bank] WHERE bank_name = @bank)

	IF NOT EXISTS(SELECT @account FROM [business].[bank_account] WHERE acc_number = @account)
	BEGIN	
		BEGIN TRY
			INSERT INTO [business].[bank_account] (acc_business, acc_bank, acc_number) VALUES(@businessID, @bankID, @account)
		END TRY
		BEGIN CATCH
			PRINT ERROR_MESSAGE()
		END CATCH
	END
END

-- Error: There is no saved business on this name
EXECUTE spAddBankAccount 'Kft Bt.', 'CIB Bank Zrt', '117562331-77895412-0000000'

DROP PROCEDURE spAddBankAccount