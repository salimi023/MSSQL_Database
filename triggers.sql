/* Triggers */
USE TBT
GO

/* Check Bank Account Number on Insert */
CREATE TRIGGER CheckAccountNumber ON [business].[bank_account]
FOR INSERT AS
    BEGIN
        DECLARE @bank_account VARCHAR(50)
        SELECT * FROM INSERTED
        DECLARE @data TABLE (
            acc_id INT NOT NULL,
            acc_business INT NOT NULL,
            acc_bank INT NOT NULL,
            acc_number VARCHAR(50) NOT NULL
        )

        INSERT INTO @data SELECT * FROM INSERTED
        SELECT * FROM @data                         
        
        SET @bank_account = (SELECT acc_number FROM @data)

        IF EXISTS (SELECT acc_number FROM [business].[bank_account] WHERE acc_number = @bank_account)
            BEGIN
                PRINT 'The Bank Account has already been saved!'
                ROLLBACK
            END          
    END

/* Preventing Dropping Tables */
CREATE TRIGGER PreventDropTable ON DATABASE
FOR DROP_TABLE AS
    BEGIN
        PRINT 'It is not allowed to drop table!'
        ROLLBACK
    END
