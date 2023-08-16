/* Backup & Restore */
USE master;
GO

ALTER DATABASE [TBT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Full Backup
BACKUP DATABASE [TBT]
 TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TBT.bak'
    WITH FORMAT;
GO

-- Differential Backup
BACKUP DATABASE [PlanDB]
    TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TBT.bak'
        WITH DIFFERENTIAL;
GO

-- Transactional Backup
BACKUP LOG [PlanDB] 
   TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TBT_FullRM_log1';  
GO

ALTER DATABASE [TBT] SET MULTI_USER;
GO

-- Restore Database
USE master;
GO

ALTER DATABASE [TBT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

RESTORE DATABASE [TBT] FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TBT.bak'
WITH REPLACE,
STATS = 10,
RESTART,
MOVE 'TBT' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TBT.mdf',
MOVE 'TBT_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TBT.log_ldf'
GO

ALTER DATABASE [TBT] SET MULTI_USER;
GO