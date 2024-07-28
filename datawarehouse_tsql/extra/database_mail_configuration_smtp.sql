-- Disable Database Mail
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Database Mail XPs', 0;
RECONFIGURE;

-- Re-enable Database Mail
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;

------

---- Drop the existing Database Mail account
--IF EXISTS (SELECT * FROM msdb.dbo.sysmail_account WHERE name = 'DataSolveAccount')
--BEGIN
--    EXEC msdb.dbo.sysmail_delete_account_sp @account_name = 'DataSolveAccount';
--END;

---- Drop the existing Database Mail profile
--IF EXISTS (SELECT * FROM msdb.dbo.sysmail_profile WHERE name = 'DataSolveProfile')
--BEGIN
--    EXEC msdb.dbo.sysmail_delete_profile_sp @profile_name = 'DataSolveProfile';
--END;

---- Drop the existing principal profile
--IF EXISTS (SELECT * FROM msdb.dbo.sysmail_principalprofile WHERE profile_id = (SELECT profile_id FROM msdb.dbo.sysmail_profile WHERE name = 'DataSolveProfile'))
--BEGIN
--    DECLARE @profile_id INT;
--    SET @profile_id = (SELECT profile_id FROM msdb.dbo.sysmail_profile WHERE name = 'DataSolveProfile');
--    EXEC msdb.dbo.sysmail_delete_principalprofile_sp @profile_id = @profile_id, @principal_sid = 0x00;
--END;



-- Create a Database Mail profile
EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'DataSolveProfile',
    @description = 'Profile for DataSolve ETL Diagnostics';

-- Add a Database Mail account to the profile
EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = 'DataSolveAccount',
    @description = 'Account for DataSolve ETL Diagnostics',
    @email_address = 'YOUR_EMAIL', -- Replace with your email address
    @display_name = 'DataSolve Notifications',
    @replyto_address = 'YOUR_EMAIL', -- Replace with your email address
    @mailserver_name = 'smtp.zoho.com.au', -- Replace with your SMTP server
    @mailserver_type = 'SMTP', -- Specify the mail server type
    @port = 587, -- Specify the port, typically 587 for SMTP
    @username = 'YOUR_EMAIL', -- Replace with your SMTP username
    @password = 'YOUR_PASSWORD', -- Replace with your SMTP password
    @enable_ssl = 1; -- Enable SSL if required by your SMTP server

-- Add the account to the profile
EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'DataSolveProfile',
    @account_name = 'DataSolveAccount',
    @sequence_number = 1;

-- Set the profile as the default for public
EXEC msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = 'DataSolveProfile',
    @principal_name = 'public',
    @is_default = 1;


	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'DataSolveProfile',
    @recipients = 'YOUR_EMAIL', -- Replace with your email address
    @subject = 'Test Email',
    @body = 'This is a test email to confirm Database Mail configuration.';
