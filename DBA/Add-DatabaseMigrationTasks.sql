USE MigrationDB;
GO

INSERT INTO [dbo].[DatabaseMigrationTasksWithCDC]
    (SourceServer, DestinationServer, DatabaseName, is_migration_ready, DBA, EnableCDC)
VALUES
    ('SourceServer', 'DestinationServer.domain.local', 'Application_DatabaseName', 'yes', SUSER_SNAME(), 'no'),
    ('SourceServer', 'DestinationServer.domain.local', 'Application_DatabaseName', 'yes', SUSER_SNAME(), 'no'),
    ('SourceServer', 'DestinationServer.domain.local', 'Application_DatabaseName', 'yes', SUSER_SNAME(), 'no'),
    ('SourceServer', 'DestinationServer.domain.local', 'Application_DatabaseName', 'yes', SUSER_SNAME(), 'no'),
    ('SourceServer', 'DestinationServer.domain.local', 'Application_DatabaseName', 'yes', SUSER_SNAME(), 'no');

GO
