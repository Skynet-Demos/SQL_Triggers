-- enable DML trigger
ENABLE TRIGGER trgAfterDelete ON dbo.Invoice;

-- disable DML trigger
DISABLE TRIGGER trgAfterDelete ON dbo.Invoice;

-- drop DML trigger
DROP TRIGGER trgAfterDelete;