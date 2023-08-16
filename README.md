# MSSQL DEMO DATABASE

The main goal of the database to demonstrate SQL coding and database administration skills by a basic demo MSSQL database.

The content of the repository is as follows:

## DATABASE DESIGN

1. Database design with table relations and foreign key constraints normalized till 3NF level (db_schema.pdf)
2. Creation of database schema and tables (schema.sql)
3. Uploading sample data into database (data.sql)
4. Deleting sample data from database tables (delete_dbdata.sql)

## DATABASE MANAGEMENT

1. Adding User and Application roles to database (roles.sql)
2. Adding Backup (full, transactional, differential) and Restore procedures to database (backup.sql; backup_scheduled.sql)

## DATABASE ACTIONS

1. Function (function.sql)
2. Indexing with non-clustered indexes for better performance (non_clustered_indexes.sql)
3. Stored procedures (stored_procedures.sql)

    - Stored procedure using SELECT
    - Stored procedure using INSERT and transaction with automatic rollback on failure
    - Stored procedure using INSERT and error handling on the level of the database

4. Triggers (triggers.sql)

    - Trigger for data validation before INSERT
    - Trigger to prevent DROP command on tables

5. Views (view.sql)

The database can be tested in MSSQL Studio database management tool.
