# SQL Guidelines

These guidelines are for SQL and are intended to be used and usable in nearly any project and circumstance.
In cases where any one rule does not apply or cannot be implemented make best efforts to implements all others regardless.

 1.  Format sql using newlines and spaces (avoid tabs). Do not put all sql on a single line. 
     1.  Use of a sql formatter such as [Poor Sql](http://poorsql.com/) (online) or [ApexSQL Refactor](http://www.apexsql.com/sql_tools_refactor.aspx) (SSMS plug-in) is highly recommended.
     2.  Use newlines between all items in select lists.
     3.  Use newlines between all items in column lists (such as the list of columns to insert into in insert statements, the list of columns in an index, etc).
     4.  Use newlines between each join and before the on clause of each join.
 2.  Names
     1.  Use UpperCamelCase for all object names.
     2.  Do not use underscores unless mentioned below.
     3.  Do not use keywords or types as object or column names. Especially columns named only "Date", "DateTime", or "Timestamp".
     4.  Do not use any name prefixing scheme for any objects (views, procedures, indexes, etc.).
     5.  Ensure all names can be properly parsed by sql server without escaping inside square brackets (`[]`). No spaces or punctuation (including no hyphens or dashes).
     6.  Tables names
         1.  All table names should be singular. It is almost always shorter and it relieves confusion about what the proper pluralization is.
         2.  If you find yourself wanting to prefix your table names consider a schema. See rule G.15 below.
     7.  Column names
         1.  Column names should not include the table name except for the table's id column.
         2.  Identity columns should always be named TableNameId, ex: UserId.
         3.  Columns with any date and/or time information should have one of two suffixes ...Utc or ...Local. Ex: DateAddedUtc. See rule G.4 below.
         4.  Foreign key columns should always have the same name as the column they reference. In the case where there are multiple foreign key columns pointing to the same foreign column on a single table they should also include something after the foreign key column name to disambiguate the two columns. For example, a table with an ad that has an original and calculated binary might have columns called DigitalAdBinaryIdOriginal and DigitalAdBinaryIdCalculated.
     8.  Indexes, Constraints, Triggers, Foreign Keys, Primary Keys - Again, do not use any form of name prefixing scheme. This increases the identifier length and does not tell you anything that VS, SSMS, or the actual object definition doesn't tell you. Explicitly name all indexes, constraints, and foreign/primary keys.
         1.  Indexes/Constraints - Indexes and constraints should be named according to the table name followed by an underscore followed by the key column names separated by underscores. Ex: TableName\_Column1Name\_Column2Name
         2.  Triggers - Triggers should be named according to the table name followed by an underscore and an UpperCamelCase short description of the trigger. Ex: TableName\_UpdateComputedValueInSomeOtherTable
         3.  Foreign Keys - Foreign keys should be named with the table name, column name, and foreign table name in that order separated by underscores. Eg: TableName\_ColumnName\_ForeignTableName
         4.  Primary keys - Primary keys should be named with the table name and key column name separated by an underscore. Eg: TableName\_TableNameId. Nearly always tables should be clustered by primary key.
 3.  Tables should always have a single (not compound) id column that is the primary key. Generally this will be an integer identity column.
     1.  For lookup tables (statuses and other enums) this should NOT be an identity column - all id values should be determined and inserted manually by developers.
 4.  All dates in SQL should be stored in UTC. If local times are necessary they may be stored in addition to, not instead of, utc times.
     1.  When possible store dates and times in two separate columns, one for the date and one for the time. See [Date and Time Data Types and Functions](https://msdn.microsoft.com/en-us/library/ms186724.aspx). Storing dates and times in two columns, one of type `date` and one of type `time(2)` provides a wider range of possible date values than a single `datetime` column and still provides 2 digits of fractional second accuracy (more than enough for nearly all applications) but uses 6 bytes per row instead of 8. It also makes grouping by day (an extremely common operation) simpler and allows for indexing on date regardless of time - reducing index key size. As such, generally tables with date/time storage should always contain two columns: DateUtc (of type `date`) and TimeUtc (of type `time(2)`).
 5.  `Null` - Be careful about what columns can be null. When in doubt define them as not null and switch later if you have to. It is much easier to switch a not null column to a null column than it is to fix bad data and go the other way around.
 6.  Explicitly specify all column names. Do not use the asterisk * in select statements. Do not leave out the list of columns names for insert statements.
 7.  When referencing any object always use both the schema name and object name.
 8.  When using aliases always use the as keyword. Avoid using table aliases that are too short (fewer than three letters) as this can make it very difficult to determine what table a column is associated with.
 9.  Document all tables and columns using the `sp_addextendedproperty` procedure to set a 'MS_Description' property. SSDT will help manage this for you.
 10. Comments - Make liberal use of comments. Developers often have tendency to leave comments out of SQL mores so than other code.
     1.  Use block level comments (`/*...*/`) between sql statements in stored procedures, triggers, functions, etc. to describe the logic and each next statement.
     2.  Use Single line comments (`-- comment here...`) inside sql statements above lines that contain any logic worth specifically mentioning
 11. Do not use output parameters or return values in stored procedures. All information returned should be via result sets. This makes interoperability with numerous clients and frameworks (ORMs, etc.) simpler.
 12. Pay attention to query hints. Adding `with(nolock)` everywhere does not mean you have written efficient sql nor does it guarantee that your query won't lock. Do not pre-optimize by adding `with(nolock)` unless you are sure you need it.
 13. Prefer ANSI operators (`=`, `>`, `<`, `<>`, `in`, `exists`, `not`, `like`, `is null`, `and`, `or`) over other variants (`!=`, etc.)
 14. Prefer correlated sub-queries (`exists`, `not exists`) over sub-queries with `in` and `not in` operators.
 15. Schemas
     1.  Group related functionality (tables, views, stored procedures, etc.) into schemas. Think of schemas like a single-level namespacing system.
     2.  Do not be afraid to create new schemas when necessary.
     3.  Avoid schemas with only a single item in them.
     4.  Avoid large catch-all schemas (such as `dbo`).
     5.  Do not put any objects into any default or system schemas such as (`sys`, `guest`, `dbo`, `INFORMATION_SCHEMA`, or any of the `db_` schemas).
 16. Databases [Example Create Script](SQL-16.sql)
     1.  Database Names - Database names should follow the naming rule G.2: use UpperCamelCase and avoid punctuation such as camel case.
     2.  Avoid placing any database files, (default, primary, secondary, or log) on the system disk (usually "C:").
     3.  Primary File Group - Databases should have a primary file group that IS NOT THE DEFAULT FILE GROUP.
         1.  The primary file group should have a single file.
         2.  The file should have a logical name following the pattern DatabaseName\_Primary
         3.  The the physical file should be in a folder named after the database with the file name "Primary.mdf".
         4.  The file should be small (10MB or so) and have growth set at a small byte value (1MB or so) as it should never grow much or rapidly.
     4.  Default File Group - Databases should have a default file group that IS NOT THE PRIMARY FILE GROUP.
         1.  The default file group should have the same name as the database.
         2.  The default file group should have at least two files.
         3.  These files should be in a folder (or folders if they are spread across multiple drives) with the same name as database.
         4.  The files should have logical names according to the database name followed by a two-digit number starting with 01. Ex: DatabaseName\_01.
         5.  The files should have physical file names according to the logical name followed by the file extension ".ndf" Ex: DatabaseName\_01.ndf.
         6.  If possible, files can be spread across multiple physical disks to improve IO performance. Even if multiple physical disks are not available having at least two files in the primary group can improve the ease of maintenance tasks such as moving/renaming files or compacting files to recover disk space.
         7.  Initial sizes and growth rates for these files should be determined based on expected size and growth rate of the database. Whatever these size and growth rates are determined to be they should be the same across all files in the file group.
     5.  Log File - Databases must specify a log file
         1.  The log file logical name should follow the pattern DatabaseName\_Log
         2.  The physical log file should be in a folder with the same name as the database.
         3.  The log file physical name should be the logical name followed by the file extension ".ldf".
         4.  Log file size, growth and disk placement should be determined by disk availability and expected database usage.
     6.  Secondary (Non-Primary and Non-Default) File Groups
         1.  Databases may have 0 or more secondary file groups.
         2.  Secondary file groups should generally follow rules for default file groups except where differences are noted here.
         3.  Secondary file group names should be the database name and a short file group description (in UperCamelCase) separated by an underscore. Ex: DatabaseName\_FulltextSearchFileGroup
         4.  Secondary file group logical file names should be the file group name followed by a two digit number starting with 01. Ex: DatabaseName\_FulltextSearchFileGroup\_01
