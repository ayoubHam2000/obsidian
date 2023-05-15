
https://www.youtube.com/watch?v=85pG_pDkITY&t=1s

## TABLE OF CONTENTS
00:00 Intro
00:30 Why Use Postgres?
01:13 What is a Database
03:12 Change Database Theme
03:53 Create a Database
04:46 Design a Database
05:50 Turn Invoice into a Database
07:04 Make a Table
12:13 Data Types
16:36 Adding Data to Table
18:15 To See Data
18:25 SELECT
19:19 Create Custom Type
20:48 Change Column Data Type
22:58 Thinking About Tables
25:37 Breaking Up Tables
27:03  Primary & Foreign Keys
32:40 Foreign & Primary Keys
33:28 Altering Tables Many Examples
53:00   Getting Data from One Table
53:40 Where
54:30 Conditional Operators
55:48 Logical Operators
58:12 Order By
59:32 Limit
1:01:45 GROUP BY
1:03:11 Distinct
1:05:00 Getting Data from Multiple Tables
1:05:21 Inner Join
1:08:50 Join 3 Tables
1:13:15  Arithmetic Operators
1:13:45 Join with Where
1:14:55 Outer Joins
1:17:03 Cross Joins
1:18:16 Unions
1:19:27 Extract
1:21:05 IS NULL
1:22:03 SIMILAR LIKE & ~ 
1:29:25 GROUP BY
1:31:14  HAVING
1:32:18  AGGREGATE FUNCTIONS
1:34:22 WORKING WITH VIEWS
1:45:01 SQL Functions
1:49:00 Dollar Quotes
1:50:06 Functions that Return Void
1:52:38 Get Maximum Product Price
1:53:39 Get Total Value of Inventory
1:54:26 Get Number of Customers
1:56:15 Named Parameters
2:01:30 Return a Row / Composite
2:03:38 Get Multiple Rows
2:07:08 PL/pgSQL
2:11:35 Variables in Functions
2:15:55 Store Rows in Variables
2:19:17 IN INOUT and OUT
2:21:01 Using Multiple Outs
2:25:56 Return Query Results
2:33:42 IF ELSEIF and ELSE
2:38:48  CASE Statement
2:42:01 Loop Statement
2:45:20 FOR LOOP
2:48:34 Result Sets, Blocks & Raise Notice
2:51:11 For Each and Arrays
2:53:20 While Loop
2:54:54 Continue
3:01:34 Stored Procedures
3:09:35 Triggers
3:29:25 Cursors
3:39:45 Installation






[[postgreDataBase]]

## PostgreSQL

PostgreSQL is a powerful open-source object-relational database management system (ORDBMS) that uses and extends the SQL language. It was first released in 1989 and has since become one of the most popular databases in the world, particularly among developers who value its flexibility, reliability, and robustness.

PostgreSQL was founded by a group of computer science professors and graduate students at the University of California, Berkeley. The project started in the 1980s as a research project called POSTGRES

The team was led by Dr. Michael Stonebraker, a renowned computer scientist who has also been involved in the development of other prominent database management systems such as Ingres, Vertica, and VoltDB. Stonebraker was awarded the Turing Award in 2014 for his contributions to database management systems.

PostgreSQL is known for its ability to handle large amounts of data and for its advanced features, including support for transactions, multi-version concurrency control (MVCC), table partitioning, and replication. It also has a strong reputation for its compliance with standards, including SQL, ACID (Atomicity, Consistency, Isolation, Durability), and JSON.

Some of the key features of PostgreSQL include:

-   Support for complex queries and advanced data types, such as arrays, hstore, and JSON.
-   A wide range of indexing options, including B-tree, hash, GiST, SP-GiST, GIN, and BRIN.
-   Full-text search capabilities, including support for stemming, ranking, and phrase matching.
-   Extensibility through the use of user-defined functions (UDFs), stored procedures, and triggers.
-   Support for high availability and scalability through built-in replication and clustering features.
-   Advanced security features, including SSL encryption, user roles and permissions, and row-level security.

PostgreSQL is used by many large organizations, including Apple, Fujitsu, Cisco, and the U.S. Federal Aviation Administration. It is also a popular choice for web applications and is used by companies such as Reddit, Instagram, and Lyft.

## Why PostgreSQL

There are several reasons why one might choose PostgreSQL as their database management system. Some of these reasons include:

1.  Reliability and stability: PostgreSQL is known for its stability and robustness. It has a reputation for being able to handle large amounts of data and for being able to handle a high number of concurrent users.
    
2.  Extensibility: PostgreSQL is highly extensible and can be customized to meet the specific needs of an organization. It has a rich set of features, including support for user-defined functions (UDFs), stored procedures, and triggers.
    
3.  Compliance with standards: PostgreSQL is known for its compliance with industry standards, including SQL, ACID, and JSON. This makes it a good choice for organizations that require compliance with these standards.
    
4.  Performance: PostgreSQL is optimized for high-performance and is able to handle complex queries and large datasets quickly and efficiently.
    
5.  Open-source and free: PostgreSQL is an open-source database management system, which means that it is free to use and can be modified and distributed by anyone. This makes it an attractive option for organizations that want to avoid licensing fees.
    
6.  Community support: PostgreSQL has a large and active community of developers and users who provide support, share best practices, and contribute to the ongoing development of the software.
    

Overall, PostgreSQL is a powerful, flexible, and reliable database management system that is well-suited for a wide range of applications and use cases.

## ACID

ACID is an acronym that stands for Atomicity, Consistency, Isolation, and Durability. These are the four properties that ensure that transactions are processed reliably in a database management system.

1.  Atomicity: This property ensures that a transaction is treated as a single, indivisible unit of work. If any part of a transaction fails, the entire transaction is rolled back, and the database returns to its original state before the transaction started.
    
2.  Consistency: This property ensures that the database remains in a consistent state before and after a transaction. In other words, if a transaction is executed successfully, the data in the database should be consistent and adhere to any defined constraints or rules.
    
3.  Isolation: This property ensures that multiple transactions can run concurrently without interfering with each other. Each transaction should be executed in isolation, as if it were the only transaction running, and changes made by one transaction should not be visible to other transactions until the transaction is committed.
    
4.  Durability: This property ensures that once a transaction is committed, the changes made to the database will persist even in the face of system failures such as power outages, crashes, or other disasters. The system should be able to recover the database to its previous state and resume normal operations after such failures.
    

These properties are critical for ensuring that a database management system is reliable and consistent, and that transactions are processed in a way that preserves the integrity of the data. ACID compliance is important for applications where data consistency and reliability are crucial, such as financial transactions, inventory management, and other business-critical systems.

## How to design a DataBase

Designing a database involves several steps, and the process can vary depending on the specific requirements and goals of the project. However, there are some general principles and best practices that can help guide the process. Here is a general overview of how to design a database:

1.  Determine the requirements: The first step is to identify the specific requirements for the database. This involves understanding what data needs to be stored, how it will be used, and who will use it. This information can be gathered through interviews with stakeholders and by analyzing existing data sources.
    
2.  Identify the entities: Once the requirements are clear, the next step is to identify the entities that will be stored in the database. Entities are objects or concepts that are important to the organization, such as customers, orders, products, or employees.
    
3.  Create a conceptual data model: Using the identified entities, create a conceptual data model that shows how the entities are related to each other. This can be done using diagrams such as entity-relationship diagrams (ERDs). The conceptual data model should be reviewed and refined to ensure it accurately reflects the requirements.
    
4.  Normalize the data: Normalization is the process of organizing data in a way that reduces redundancy and improves data integrity. This involves breaking down the data into smaller, more atomic pieces and creating separate tables for related data.
    
5.  Define the data types and constraints: Once the data is normalized, define the data types and constraints for each table column. This includes specifying the maximum length, precision, and scale of numeric data, and defining any constraints such as primary keys, foreign keys, and unique constraints.
    
6.  Create the physical data model: Using the conceptual data model and the defined data types and constraints, create the physical data model. This involves defining the specific database objects such as tables, views, indexes, and stored procedures.
    
7.  Test and refine: Once the physical data model is created, it should be tested and refined to ensure it meets the requirements and performs well.
    
8.  Document the design: Finally, document the database design, including the data model, data types and constraints, and any other relevant information.

## Data Types

[[https://www.postgresql.org/docs/current/datatype.html]]
PostgreSQL supports a wide range of data types, including:

1.  Numeric Types: PostgreSQL provides several numeric types such as integer, serial, float, double precision, and numeric.
    
2.  Character Types: PostgreSQL supports several character types such as character, varchar, and text.
    
3.  Date/Time Types: PostgreSQL provides several date/time types such as date, time, timestamp, and interval.
    
4.  Boolean Type: PostgreSQL has a boolean type that can hold either true or false.
    
5.  Enumerated Types: Enumerated types allow you to create a list of predefined values, which can be used as a column type.
    
6.  Array Types: PostgreSQL allows you to create arrays of any built-in or user-defined base type.
    
7.  Composite Types: Composite types are user-defined types that can combine multiple fields of different data types into a single data type.
    
8.  Network Address Types: PostgreSQL provides several network address types such as inet and cidr for storing IP addresses and network masks.
    
9.  Geometric Types: PostgreSQL provides several geometric types such as point, line, and polygon.
    
10.  Range Types: Range types allow you to store a range of values of a particular data type.
    
11.  JSON Types: PostgreSQL provides several JSON types such as JSON and JSONB for storing JSON data.
    
12.  XML Type: PostgreSQL provides an XML type for storing XML data.

### examples of data types in PostgreSQL

1.  Numeric Types: integer, serial, bigint, decimal, numeric, float, real, double precision
    - NUMERIC(a, b)
2.  Character Types: character, char, varchar, text
    
3.  Date/Time Types: date, time, timestamp, interval, timestamptz, timetz
    
4.  Boolean Type: boolean
    
5.  Enumerated Types: enum
    
6.  Array Types: integer[], text[], customtype[]
    
7.  Composite Types: customtype
    
8.  Network Address Types: inet, cidr
    
9.  Geometric Types: point, line, lseg, box, path, polygon, circle
    
10.  Range Types: int4range, int8range, numrange, tsrange, tstzrange, daterange
    
11.  JSON Types: json, jsonb
    
12.  XML Type: xml

### varchar vs char

`CHAR` is a fixed-length data type, which means that it always allocates the same amount of storage space for each value, regardless of the actual length of the value. For example, if you define a column as `CHAR(10)`, PostgreSQL will allocate 10 bytes of storage for each value, even if the value only requires 5 bytes. If the value is shorter than the allocated space, PostgreSQL will pad it with spaces.

On the other hand, `VARCHAR` is a variable-length data type, which means that it allocates only the necessary amount of storage space for each value, up to a maximum length that you specify. For example, if you define a column as VARCHAR(10), PostgreSQL will allocate only the necessary amount of storage space for each value, up to a maximum of 10 characters.

### size

1.  SMALLINT: 2 bytes, range of -32768 to 32767
2.  INTEGER: 4 bytes, range of -2147483648 to 2147483647
3.  BIGINT: 8 bytes, range of -9223372036854775808 to 9223372036854775807
4.  NUMERIC: up to 131,072 digits before the decimal point and up to 16,383 digits after the decimal point
5.  FLOAT4 (single precision): 4 bytes, up to 6 decimal digits precision
6.  FLOAT8 (double precision): 8 bytes, up to 15 decimal digits precision
7.  VARCHAR(n): variable-length string, up to n characters
8.  TEXT: variable-length string, up to 1 GB
9.  DATE: 4 bytes, range of 4713 BC to 5874897 AD
10.  TIME: 8 bytes, range of 00:00:00 to 24:00:00
11.  TIMESTAMP: 8 bytes, range of 4713 BC to 294276 AD
12.  INTERVAL: 16 bytes, range of -178000000 years to +178000000 years
13. SERIAL: 2147483647
14. BIGSERIAL: 9223372036854775807
15. SMALLSERIAL: 32767

### Date

PostgreSQL provides several data types for storing date and time data:

1.  `DATE`: stores a date value in the format `YYYY-MM-DD`.
2.  `TIME`: stores a time value in the format `HH:MM:SS`.
3.  `TIMESTAMP`: stores a date and time value in the format `YYYY-MM-DD HH:MM:SS`.
4.  `TIMESTAMPTZ`: stores a date and time value with timezone information in the format `YYYY-MM-DD HH:MM:SS TZ`.

Date and time input is accepted in almost any reasonable format, including ISO 8601, SQL-compatible, traditional POSTGRES, and others. For some formats, ordering of day, month, and year in date input is ambiguous and there is support for specifying the expected ordering of these fields. Set the [DateStyle](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-DATESTYLE) parameter to `MDY` to select month-day-year interpretation, `DMY` to select day-month-year interpretation, or `YMD` to select year-month-day interpretation.

- `Interval`

In PostgreSQL, an interval is a time span, expressed in years, months, days, hours, minutes, and seconds. You can use intervals to perform date and time calculations, such as adding or subtracting a certain amount of time from a date or time value.

Here's an example of using intervals to add 1 day, 2 hours, and 30 minutes to a date value:

```SQL
SELECT '2022-05-08'::DATE + INTERVAL '1 day 2 hours 30 minutes';
SELECT NOW() - INTERVAL '1 week';
```

## Comment

```sql
--Comment
/* Multiline */
```

## Operation

### Conditional Operators

```
= : Equal
< : Less than
> : Greater than
<= : Less than or Equal
>= : Greater than or Equal
<> : Not Equal
!= : Not Equal
```

### Logical Operators

```
AND, OR and NOT are logical operators
BETWEEN
```
```sql
SELECT time_order_taken
FROM sales_order
WHERE time_order_taken > '2018-12-01' AND time_order_taken < '2018-12-31';

--Or

SELECT time_order_taken
FROM sales_order
WHERE time_order_taken BETWEEN '2018-12-01' AND '2018-12-31';

```

### Tables

```sql
CREATE TABLE table_name (
   column1 datatype1 [optional_parameters],
   column2 datatype2 [optional_parameters],
   column3 datatype3 [optional_parameters],
   .....
);
```

`optional_parameters`

Optional parameters are used to provide additional instructions or constraints for a column in a PostgreSQL table. Some commonly used optional parameters include:

-   `NOT NULL`: specifies that the column cannot contain null values
-   `DEFAULT value`: specifies a default value for the column if one is not provided during insertion
-   `UNIQUE`: specifies that the values in the column must be unique across all rows in the table
-   `PRIMARY KEY`: specifies that the column is the primary key for the table
-   `REFERENCES`: specifies a foreign key constraint that references another table and column
-   `CHECK`: specifies a constraint that checks if the value in the column satisfies a certain condition

```sql
CREATE TABLE products (
    id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    price numeric(10, 2) DEFAULT 0.00,
    category_id integer REFERENCES categories(id),
    CONSTRAINT positive_price CHECK (price >= 0.00)
);
```

---
```SQL
TRUNCATE TABLE table_name; --delete all data
DROP TABLE table_name; --delete table
```

### Insert

```SQL
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

### SELECT

```SQL
SELECT [ ALL | DISTINCT | DISTINCT ON (distinct_expressions) ]
expressions
FROM tables
[WHERE conditions]
[GROUP BY expressions]
[HAVING condition]
[ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS FIRST | NULLS LAST ]]
[LIMIT [ number_rows | ALL]
[OFFSET offset_value [ ROW | ROWS ]]
[FETCH { FIRST | NEXT } [ fetch_rows ] { ROW | ROWS } ONLY]
[FOR { UPDATE | SHARE } OF table [ NOWAIT ]];
```

-   **`ALL`** - An optional parameter that returns all matching rows.
-   **`DISTINCT`** - A parameter that removes duplicates from the result-set.
-   **`DISTINCT ON`** - An optional parameter that eliminates duplicate data based on the **`distinct_expressions`** keyword.
-   **`expressions`** - All the columns and fields you want included in the result. Specifying an asterisk (**`*`**) selects all columns.
-   **`tables`** - Specify the tables from which you want to retrieve records. The **`FROM`** clause must contain at least one table.
-   **`WHERE conditions`** - The clause is optional and contains the conditions that must be met in order to filter the records in the result-set.
-   **`GROUP BY expressions`** - An optional clause that collects data from multiple records, grouping the results by one or more columns.
-   **`HAVING condition`** - An optional clause used in combination with **`GROUP BY`**. It restricts the groups of the returned rows to only the ones that meet the condition **`TRUE`**, thus filtering them.
-   **`ORDER BY expression`** - An optional clause that identifies which column or columns to use to sort the data in the result-set.
-   **`LIMIT`** - An optional clause that sets the maximum number of records to retrieve from the table, specified by the **`number_rows`** syntax. The first row in the result-set is determined by **`offset_value`**.
-   **`FETCH`** - An optional clause that sets the maximum number of records in the result-set. Specify the number of records in place of the **`fetch_rows`** syntax. The **`offset_value`** determines the first row in the result-set.
-   **`FOR UPDATE`** - An optional clause that write-locks the records needed for running the query until the transaction completes.
-   **`FOR SHARE`** - An optional clause that allows the records to be used by other transactions but prevents their update or deletion.

```sql
SELECT
  customer_id,
  COUNT(*) AS order_count,
  AVG(total_amount) AS average_order_amount
FROM orders
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY customer_id
HAVING COUNT(*) >= 5
ORDER BY average_order_amount DESC;
```

### SQL functions

`CONCAT` `SUM` `COUNT`, `MAX`, `MIN`, `AVG`, `UPPER`, `LOWER`, `ROUND`, `TRIM`

### Create types

```SQL
enum
CREATE TYPE enum_name AS ENUM ('value1', 'value2', 'value3', ...);
```

## ALTER

`ALTER` is a SQL command used in PostgreSQL to modify an existing database object. It can be used to add, modify, or delete columns from a table, change the data type of a column, rename a table, and many other operations.

1. Add a column to an existing table:
```sql
ALTER TABLE table_name ADD COLUMN column_name data_type;
```

2. Modify the data type of a column: 
```SQL
ALTER TABLE table_name ALTER COLUMN column_name TYPE new_data_type;
```
3. Rename a table:
```SQL
ALTER TABLE old_table_name RENAME TO new_table_name;
```
4. Drop a column from a table:
```SQL
ALTER TABLE table_name DROP COLUMN column_name;
```
5. Add a foreign key constraint to a table: 
```SQL
ALTER TABLE child_table ADD CONSTRAINT foreign_key_name FOREIGN KEY (child_column_name) REFERENCES parent_table (parent_column_name);
```
6. Add default value to a column
```sql
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;
```

## INDEX

In PostgreSQL, an index is a database object that improves the performance of database queries by allowing them to retrieve data more quickly and efficiently.

An index consists of a set of keys and pointers to the physical location of the corresponding data in the table. When you query a table with an index, PostgreSQL can use the index to quickly locate the relevant rows, rather than scanning the entire table.

PostgreSQL supports several types of indexes, including B-tree, Hash, GiST, SP-GiST, GIN, and BRIN. B-tree indexes are the most commonly used, and are suitable for a wide range of applications.

You can create an index in PostgreSQL using the `CREATE INDEX` statement. Here's an example:
```sql
CREATE INDEX idx_customers_email ON customers (email);
```
- composite index.
```sql
CREATE INDEX idx_name ON mytable (column1, column2, column3);
```
This statement creates a B-tree index called `idx_customers_email` on the `email` column of the `customers` table. Once the index is created, queries that search the `email` column will be able to use the index to find matching rows more quickly.

```sql
CREATE INDEX idx_employees_name_dept ON employees(name, department);
SELECT * FROM employees WHERE name = 'John Doe' AND department = 'Sales';
```
The database engine will use the index to quickly find the rows that match the `WHERE` condition, rather than scanning the entire table. This can greatly improve the performance of your queries, especially on large tables.

----
- create a database
- create a table
- create a custom type
- types
- NOT NULL, SERIAL, DEFAULT, REFERENCES
- ADD COLUMN, ALTER TABLE, ALTER COLUMN ... SET ..., DROP COLUMN, RENAME TO,  CREATE INDEX, TRUNCATE TABLE, DROP TABLE


//nest js - typescipt - socket io - postgreSQL - react - canvas
//Accept Suggestion On Commit Character

