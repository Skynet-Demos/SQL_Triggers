-- AFTER INSERT TRIGGER
CREATE TRIGGER trgAfterInsert_Invoice ON dbo.Invoice
FOR INSERT		-- we can use AFTER INSERT also 
AS
	DECLARE @InvoiceId INT, @InvoiceNumber VARCHAR(20), @InvoiceDate DATE, @LogMessage VARCHAR(2000);
	
	SELECT @InvoiceId = i.Id FROM inserted i;
	SELECT @InvoiceNumber = i.InvoiceNumber FROM inserted i;
	SELECT @InvoiceDate = i.InvoiceDate FROM inserted i;
	SET @LogMessage = 'Invoice is inserted';

	INSERT INTO InvoiceLog (InvoiceId, InvoiceNumber, InvoiceDate, LogMessage, LogDatetime)
	VALUES (@InvoiceId, @InvoiceNumber, @InvoiceDate, @LogMessage, GETDATE());
GO

-- AFTER UPDATE TRIGGER
CREATE TRIGGER trgAfterUpdate_Invoice ON dbo.Invoice
AFTER UPDATE
AS
	DECLARE @InvoiceId INT, @InvoiceNumber VARCHAR(20), @InvoiceDate DATE, @LogMessage VARCHAR(2000);

	SELECT @InvoiceId = i.Id, @InvoiceNumber = i.InvoiceNumber, @InvoiceDate = i.InvoiceDate FROM inserted i;

	IF UPDATE(InvoiceNumber)
		SET @LogMessage = 'Invoice Number was updated. ';

	IF UPDATE(InvoiceDate)
		SET @LogMessage = CONCAT(@LogMessage, 'Invoice Date was updated');

	INSERT INTO InvoiceLog(InvoiceId, InvoiceNumber, InvoiceDate, LogMessage, LogDatetime)
	VALUES (@InvoiceId, @InvoiceNumber, @InvoiceDate, @LogMessage, GETDATE());
GO

-- AFTER DELETE TRIGGER
CREATE TRIGGER trgAfterDelete ON dbo.Invoice
FOR DELETE
AS
	DECLARE @InvoiceId INT, @InvoiceNumber VARCHAR(20), @InvoiceDate DATE, @LogMessage VARCHAR(2000);

	SELECT @InvoiceId = d.Id, @InvoiceNumber = d.InvoiceNumber, @InvoiceDate = d.InvoiceDate FROM deleted d;
	SET @LogMessage = 'Invoice is deleted';

	INSERT INTO InvoiceLog(InvoiceId, InvoiceNumber, InvoiceDate, LogMessage, LogDatetime)
	VALUES (@InvoiceId, @InvoiceNumber, @InvoiceDate, @LogMessage, GETDATE());
GO