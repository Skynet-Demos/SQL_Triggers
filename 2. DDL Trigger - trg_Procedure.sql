CREATE TRIGGER trg_Procedure ON DATABASE
    FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE
AS
	BEGIN    
		DECLARE @EventData XML = EVENTDATA();
  
		INSERT dbo.DDLTriggerEvents (EventType, EventDDL, EventXML, DatabaseName, SchemaName, ObjectName, HostName, ProgramName, LoginName)
		SELECT
			@EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'), 
			@EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
			@EventData,
			DB_NAME(),
			@EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'), 
			@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
			HOST_NAME(),
			PROGRAM_NAME(),
			SUSER_SNAME();
	END
GO