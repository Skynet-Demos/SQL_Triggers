-- creating a test login user
USE master;  
GO  
CREATE LOGIN login_test WITH PASSWORD = '123' MUST_CHANGE,  
    CHECK_EXPIRATION = ON;  
GO  

GRANT VIEW SERVER STATE TO login_test;  
GO  

/*
VIEW SERVER STATE permission
enables a login to view the results of Dynamic Management Objects.

MUST_CHANGE
it forces to change the password for the first time
*/

-- Logon Trigger
-- Usecase: restrict concurrent sessions for a login
CREATE TRIGGER trgRestrictConcurrentUserSessions ON ALL SERVER
FOR LOGON
AS
	BEGIN
	IF (SELECT COUNT(*) FROM sys.dm_exec_sessions 
		WHERE is_user_process = 1 AND original_login_name = 'login_test') > 10
		BEGIN
			PRINT 'More than 10 sessions are not allowed for login_test';
			ROLLBACK;
		END
	END
GO