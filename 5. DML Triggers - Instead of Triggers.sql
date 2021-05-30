-- INSTEAD OF INSERT TRIGGER
-- Usecase: Restrict the entries where Invoice date > 2021-04-01
CREATE TRIGGER trgInsteadOfInsert_Invoice ON dbo.Invoice
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @InvoiceId INT, @InvoiceNumber VARCHAR(20), @InvoiceDate DATE, @LogMessage VARCHAR(2000);
	
	SELECT @InvoiceId = i.Id, @InvoiceNumber = i.InvoiceNumber, @InvoiceDate = i.InvoiceDate FROM inserted i;

	IF @InvoiceDate <= '2021-04-01'
	BEGIN
		-- valid data, insert
		INSERT INTO Invoice (InvoiceNumber, InvoiceDate)
		VALUES (@InvoiceNumber, @InvoiceDate);
	END
	ELSE
		BEGIN
			-- invalid data, do not allow
			SET @LogMessage = CONCAT('Restricted invoice date, ', @InvoiceDate, '. Data was not inserted');
			INSERT INTO InvoiceLog (InvoiceId, InvoiceNumber, InvoiceDate, LogMessage, LogDatetime)
			VALUES (@InvoiceId, @InvoiceNumber, @InvoiceDate, @LogMessage, GETDATE());

			-- rais an error
			RAISERROR(@LogMessage, 16, 1);	
		END
END

-- INSTEAD OF UPDATE TRIGGER
-- Usecase: do not allow to update Invoice Number
CREATE TRIGGER trgInsteadOfUpdate_Invoice ON dbo.Invoice
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @InvoiceId INT, @InvoiceNumber VARCHAR(20), @InvoiceDate DATE, @LogMessage VARCHAR(2000);
	
	SELECT @InvoiceId = i.Id, @InvoiceNumber = i.InvoiceNumber, @InvoiceDate = i.InvoiceDate FROM inserted i;

	IF UPDATE(InvoiceNumber)
		BEGIN
			-- updating Invoice Number is not allowed
			SET @LogMessage = 'Invoice Number can not be updated';
			INSERT INTO InvoiceLog (InvoiceId, InvoiceNumber, InvoiceDate, LogMessage, LogDatetime)
			VALUES (@InvoiceId, @InvoiceNumber, @InvoiceDate, @LogMessage, GETDATE());
			RAISERROR(@LogMessage, 16, 1);				
		END
	ELSE
		BEGIN
			-- valid data
			UPDATE Invoice SET InvoiceDate = @InvoiceDate WHERE Id = @InvoiceId;
		END
END
GO

-- INSTEAD OF DELETE TRIGGER
-- Usecase: do not delete Invoice with number INV001
CREATE TRIGGER trgInsteadOfDelete_Invoice ON dbo.Invoice
INSTEAD OF DELETE
AS
	DECLARE @InvoiceId INT, @InvoiceNumber VARCHAR(20), @InvoiceDate DATE, @LogMessage VARCHAR(2000);
	
	SELECT @InvoiceId = i.Id, @InvoiceNumber = i.InvoiceNumber, @InvoiceDate = i.InvoiceDate FROM inserted i;

	IF @InvoiceNumber = 'INV001'
		BEGIN
			-- do not delete Invoice INV001
			SET @LogMessage = 'Invoice INV001 can not be deleted';
			INSERT INTO InvoiceLog (InvoiceId, InvoiceNumber, InvoiceDate, LogMessage, LogDatetime)
			VALUES (@InvoiceId, @InvoiceNumber, @InvoiceDate, @LogMessage, GETDATE());
			RAISERROR(@LogMessage, 16, 1);	
		END
	ELSE
		BEGIN
			-- other than INV001, we can delete
			DELETE FROM Invoice WHERE Id = @InvoiceId;
		END
GO