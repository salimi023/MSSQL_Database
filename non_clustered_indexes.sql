/* Non Clustered Indexes */ 
USE TBT
GO

-- Staff members based on businesses
CREATE NONCLUSTERED INDEX IX_StaffMembersByBusiness
ON [staff].[members](bs_id ASC)

-- Bank accounts by businesses
CREATE NONCLUSTERED INDEX IX_BankAccountByBusiness
ON [business].[bank_account](acc_business ASC)

-- Bank accounts by banks
CREATE NONCLUSTERED INDEX IX_BankAccountByBanks
ON [business].[bank_account](acc_bank ASC)
