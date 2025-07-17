### Add line in .zshrc file to use mysql in terminal => export PATH=${PATH}:/usr/local/mysql/bin/

### MySQL contains Row and columns structure

#### 1. DDL – Data Definition Language 
- CREATE, ALTER: Update database structure, 
- DROP, TRUNCATE: Used to remove all rows (complete data) from a table, Schema remians in DB , 
- RENAME, COMMENT

#### 2. DQL – Data Query Language 
- SELECT 

#### 3. DML – Data Manipulation Language
- INSERT, 
- UPDATE, 
- DELETE, 
- LOCK 

#### 4. DCL – Data Control Language
- GRANT: Assigns new privileges to a user account, 
- REVOKE: Removes previously granted privileges from a user account 

#### 5. TCL – Transaction Control Language: group a set of tasks into a single execution unit.
- BEGIN TRANSACTION, 
- COMMIT: Saves all changes made during the transaction, 
- ROLLBACK, 
- SAVEPOINT 

## Queries:
1. **DATABASE** 
	1. Create DATABASE:
	```mysql
	CREATE DATABASE <DB_NAME>
	```
	2. Drop/Delete DATABASE:
	```mysql
	DROP DATABASE <DB_NAME>
	```
	3. Make read only DATABASE ( if we use READ ONLY = 0 Then it will reset readonly DB )
	```mysql
	ALTER DATABASE <DB_NAME> READ ONLY = 1
	
	-- We can manipulate database if it is in READ ONLY MODE  --
	```
	4. Show all databases
	```mysql
	SHOW DATABASES
	```
	5. Select database to use
	```mysql
	USE <DB_NAME>
	```
	6. Show current database
	```mysql
	SELECT DATABASE()
	```
	 
2. **TABLES**
	1. Show all tables in database
	```mysql
	SHOW TABLES
	```
	2. Create new table in DB
	```mysql
	CREATE TABLE <TABLE_NAME> (
		employee_id INT,
		first_name VARCHAR( 50 ), // 50 is max character length
		hourly_pay DECIMAL( 5, 2 ), // 5 is max digits and 2 is how many digits after decimal 
		hire_date DATE 
	)
	```
	2. Show all columns in table
	```mysql
	SHOW COLUMNS FROM <TABLE_NAME>
	```
	3. Select table data
	```mysql
	SELECT * FROM <TABLE_NAME>
	```
	4. Rename table
	```mysql
	RENAME TABLE <OLD_TABLE_NAME> TO <NEW_TABLE_NAME>
	```
	5. Drop table
	```mysql
	DROP TABLE <TABLE_NAME>
	```
	6. Alter table
	```mysql	
	ALTER TABLE <TABLE_NAME> 
	```
	Methods:
	1) Update structure of table ( add new column in table )
	```mysql
	ALTER TABLE <TABLE_NAME> ADD <COLUMN_NAME> VARCHAR( 15 )
	```
	2) Rename column name 
	```mysql
	ALTER TABLE <TABLE_NAME> RENAME COLUMN <OLD_COL_NAME> TO <NEW_COL_NAME>
	```
	3) Updates column data type eg. varchar(10) to varchar(50)
	```mysql
	ALTER TABLE <TABLE_NAME> MODIFY COLUMN <COL_NAME> VARCHAR( 50 )
	```
	4) Will change position of your column. You can use FIRST to move at first position
	```mysql
	ALTER TABLE <TABLE_NAME> MODIFY <COL_NAME + DATA_TYPE> AFTER <COL_NAME_WHICH_AFTER_YOU_WANT_TO_MOVE_YOUR_COLUMN>
	```
	5) Delete column from table
	```mysql
	ALTER TABLE <TABLE_NAME> DROP COLUMN <COL_NAME> 
	```

3. **INSERT QUERIES**
	1. Insert single row
	```mysql
	INSERT INTO <TABLE_NAME> (field_1, field_2, field_3) VALUES (value_1, value_2, value_3)
	```
	Note: length of field and values should be equal while using this approach.
	
	2. Insert multiple rows
	```mysql
	INSERT INTO <TABLE_NAME> (field_1, field_2, field_3) 
	VALUES  ("Pratik", 3, false),
			("Rahul", 4, false),
			("Rutik", 5, false);
	```
	3. Insert multiple rows from .sql file
	running SQL script into terminal from .sql file
	1) mysql -u root -p 
	2) source <path_to_your_script>.sql


4. **SELECT QUERIES**
	1. Select all rows:
	```mysql
	SELECT * FROM <TABLE_NAME>
	```
	2. Select particular fields only:
	```mysql
	SELECT field_1, field_2, field_3 FROM <TABLE_NAME>
	```
	3. Select with condition:
	```mysql
	SELECT * FROM <TABLE_NAME> WHERE <CONDITION> 
	```
	- Different conditions operator: >=, <=, !=, =, >, <, IS NULL ect. 
	- You can use NOT EQUAL to in different conditions: "NOT=", "<>", "!=", etc
	- WHEN clause:- The CASE statement is followed by at least one pair of WHEN and THEN statements—SQL's equivalent of IF/THEN

	Eg. 
	```mysql
	select user_name , 
	case when rating between 1800 and 1999 then "4 Star"
	when rating between 2000 and 2199 then "5 Star"
	when rating between 2200 and 2499 then "6 Star"
	else "None" end as category
	from Users group by user_name; 
	```
5. **UPDATE QUERIES**
	1. Update single column:
		If yiu update column value without WHERE condition then all columns will affect with that value.

6. **DELETE QUERIES**
	1. DELETE FROM <TABLE_NAME> WHERE <CONDITION>;
		note: don't DELETE use without WHERE condition. It will delect ALL table rows.
				  DROP TABLE and DELETE are different. DROP TABLE will delete table from database and DELETE will delete rows from table.

## 7. **auto commit, commit & rollback ( check in details )** 

## 8. **DATE, TIME, DATETIME data-types**
1. DATE : store date type value
2. TIME : stores time type value
3. DATETIME : stores date and time value

	in-build functions to get date 
	1. CURRENT_DATE(): returns current date
	2. CURRENT_TIME(): returns current time
	3. NOW(): returns current date and time 

## 9. UNIQUE values
1. CREATE TABLE <TABLE_NAME> (
	field_1 datatype UNIQUE
	)
	
2. ALTER TABLE <TABLE_NAME> 
	ADD CONSTRAINTS 
	UNIQUE(field_name)

## 10. NOT NULL values
1. ALTER TABLE <TABLE_NAME>
	MODIFY <COL_NAME> data_type NOT NULL

## 11. Check :- 
adding check on column with condition. If condition not satisfies then it will not inster in table
1. while CREATING TABLE :- 
```mysql
CREATE TABLE <TABLE_NAME> (
field_name INT,
CONSTRAINT <CHECK_CONDITION_NAME> CHECK ( field_name CONDITION  value ) 
)
Eg. CREATE TABLE users (
		username VARCHAR(20) NOT NULL,
		age INT,
		CONSTRAINT age_over_18 CHECK(age > 18)
	);
```

2. UPDATING COL
```mysql
ALTER TAbLE <TABLE_NAME>
ADD CONSTRAINT <CHECK_CONSTRAINT_NAME> CHECK( field_name CONDITION value )
```

3. REMOVE CHECK 
```mysql
ALTER TABLE <TABLE_NAME>
DROP <CHECK_CONSTRAINT_NAME>
```

- Multiple columns
```mysql
CREATE TABLE companies (
	name VARCHAR(255) NOT NULL,
	address VARCHAR(255) NOT NULL,
	CONSTRAINT name_address UNIQUE (name , address)
);
```

## 12. DEFAULT value in column
Methods 
1) While CREATING A TABLE
	CREATE TABLE <TABLE_NAME>(
		hourly_pay INT DEFAULT 10
	)

2) On existing TABLE COLUMN
	ALTER TABLE <TABLE_NAME>
	ALTER <COL_NAME>  SET DEFAULT 0

## 13. PRIMARY KEY: 
Used as unique identifier for each row in table ( can't be null, can't be duplicate, can't be empty )
Methods:
1) While CREATING NEW TABLE	
```mysql
CREATE TABLE <TABLE_NAME>(
	field_name data_type PRIMARY KEY
)	
OR
CREATE TABLE <TABLE_NAME>(
	field_name data_type NOT NULL,
	PRIMARY KEY(field_name)
)	
```	

2) On existing table
```mysql
ALTER TABLE <TABLE_NAME>
ADD CONSTRAINT
PRIMARY KEY (field_name)
```

3) Delete PRIMARY KEY
```mysql
ALTER TABLE <TABLE_NAME>
DROP PRIMARY KEY
```

## 14. FOREIGN KEY: 
Used to link two tables together. It is used to maintain data integrity between two tables
Methods:
1) While CREATING NEW TABLE
```mysql
CREATE TABLE <TABLE_NAME>(
	field_name data_type,
	CONSTRAINT <FK_NAME> FOREIGN KEY (field_name) REFERENCES <TABLE_NAME_2>(table_2_field)
)
```
				
2) On existing table
```mysql
ALTER TABLE <TABLE_NAME>
ADD CONSTRAINT <FK_NAME> FOREIGN KEY (field_name) REFERENCES <TABLE_NAME_2>(table_2_field)
```

3) Delete FOREIGN KEY
```mysql
ALTER TABLE <TABLE_NAME>
DROP FOREIGN KEY <FK_NAME>
```
 
## 15. JOINS
1) INNER JOIN: it returns Only condition common in both tables (INNER keyword is optional)
```mysql
SELECT * 
FROM <LEFT_TABLE_NAME>
INNER JOIN <RIGHT_TABLE_NAME>
ON <LEFT_TABLE.FIELD_NAME> CONDITION <RIGHT_TABLE.FIELD_NAME>
```

2) LEFT JOIN: It pull LEFT TABLE ALL data and RIGHT TABLE  matching only rows
```mysql
SELECT * 
FROM <LEFT_TABLE_NAME>
LEFT JOIN <RIGHT_TABLE_NAME>
ON <LEFT_TABLE.FIELD_NAME> CONDITION <RIGHT_TABLE.FIELD_NAME> 
```

2) RIGHT JOIN:
It pull RIGHT TABLE ALL data and LEFT TABLE matching only rows
```mysql
SELECT *
FROM <LEFT_TABLE_NAME>
RIGHT JOIN <RIGHT_TABLE_NAME>
ON <LEFT_TABLE.FIELD_NAME> CONDITION <RIGHT_TABLE.FIELD_NAME>	
```

4) SELF JOIN:
JOIN other COPY of table to itself
Used to compare rows of the same table
Helps to display hierarchy of data

Query:
```mysql
SELECT * FROM <TABLE_NAME> as <ALICE_1>
INNER JOIN <TABLE_NAME> as <ALICE_2>
ON <ALICE_1.COL_NAME> = <ALICE_2.COL_NAME>
```

NOTE:- You can use any type of join  

5) CROSS JOIN:
whether the other table matches or not, the CROSS JOIN keyword returns all similar records from both tables with all possible combinations.

Query:
```mysql
SELECT *
FROM CUSTOMER
CROSS JOIN ORDERS;	 	

SELECT *
FROM CUSTOMER,
ORDERS;
```

**JOIN ON with AND keyword works as WHERE condition in JOINS**
Eg.
```mysql
join activity e
on s.machine_id = e.machine_id // JOIN ON machine_id
and s.process_id= e.process_id // AND process_id
and s.activity_type="start" and e.activity_type="end"
```			

## 16. FUNCTIONS 
1) COUNT(): Returns count of rows in table 
It ignores only NULL values — not 0
Wrong => COUNT(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count

Query:
```mysql
SELECT COUNT(<COL_NAME>) as <NICKNAME>
FROM <TABLE_NAME>
WHERE <CONDITION>
```

**Different functions**
- MAX(), 
- MIN(), 
- AVG(), 
- SUM(),
- CONCAT(field_1, field_2 ), 
- LENGTH(COL_NAME), 
- SUBSTR(COL_NAMe, START_INDEX, CHAR_LENGTH)
- ROUND( NUMBER, decimals_after_dot_number)

Note: `MIN treats the varchar values as strings and finds the minimum value by comparing their characters from left to right ( lexicographical order ).

The query SELECT COUNT(*) FROM Given_table; counts all rows in the table, including those with NULL values. Since the table has 2 rows, the result is 2.

## 17. AND, OR, NOT, BETWEEN, IN
Used while you want to pull data with multiple CONDITIONS 

Query:
```mysql
SELECT * FROM <TABLE_NAME>
WHERE <COL_NAME> LIKE "ADD PATTERN USING WILD CARD CHARS"
```

**WILD CARD CHARACTERS**
- " %": used while word start with or end with condition
- eg. "%S" --> End  with
- "S%" --> Start with

'_' : used to find pattern with radom letters
eg. "_oo" --> will search word which contains "oo" at last and at "_" position with random letter 

Syntax:
```mysql
SELECT * FROM <TABLE_NAME>
WHERE <COL_NAME> LIKE "_oo"
```
		
Syntax:
```mysql
SELECT * FROM <TABLE_NAME>
WHERE <COL_NAME> LIKE "ADD PATTERN USING WILD CARD CHARS"
```

## 18. ORDER BY:
sorts by ASC or DESC order  

Query:
```mysql
SELECT * FROM <TABLE_NAME>
ORDER BY <COL_NAME_1>, <COL_NAME_2> ASC/DESC ( by default ASC )
OREDR BY <COLUMN_NUMBER> ASC/DESC ( by default ASC ) // if you want to sort by column number
```

- You can use multiple columns for fallback 
- It comes after select statement

## 19. LIMIT: 
- LIMIT clause s used to limit number of records
- LIMIT always comes after ORDER BY
- Useful if you are working with a lot of data
- Can be used o display large data on page ( Pagination )

Query:
```mysql
SELECT * FROM <TABLE_NAME>
LIMIT <OFFSET_NUMBER>, <YOUR_LIMIT_IN_NUMBER>
OFFSET allows you to skip rows
```
example:
```mysql
SELECT * FROM <TABLE_NAME>
LIMIT 10 OFFSET 20
```

## 20. UNION:- 
- UNION combines result of two or More SELECT statements 
- It only works with same length of SELECT columns from both tables
- UNION doesn't allow duplicate, to solve this use UNION ALL

Query:
```mysql
SELECT field_1, field_2, field_3 FROM <TABLE_1>
UNION
SELECT field_1, field_2, field_3 FROM <TABLE_2>
```

## 21. VIEW 
- Virtual table based on the result set of an SQL statement
- The fields in views are fields from one or more real tables in the database
- They are not real tables, but can be interacted with  if they were
- You can perform all operations on view as TABLE

Query:
1. CREATE VIEW
	```mysql
	CREATE VIEW <VIEW_NAME> AS
	SELECT <COL_1>, <COL_2>
	FROM <TABLE_NAME>
	```

2. SELECT
	```mysql
	SELECT * FROM <VIEW_NAME>  
	```

3. DROP VIEW
	```mysql
	DROP VIEW <VIEW_NAME>  
	```

## 22. INDEX
- INDEX id BTree data structure
- indexes are used to find values within specific column more quickly 
- MySQL search normally sequentially through a column 
- The longer the column, the more expensive the operation
- UPDATE takes more time, SELECT take less

Query:
1. CREATE INDEX
	```mysql
	CREATE INDEX <INDEX_NAME>
	ON <TABLE_NAME>(field_1, field_2)
	```

2. ALTER TABLE
	```mysql
	ALTER <TABLE_NAME>
	DROP INDEX <INDEX_NAME>
	```

3. SHOW INDEXES
	```mysql
	SHOW INDEXES FROM <TABLE_NAME>
	```

## 23. SUBQUERIES
- Query within query

Query:
```mysql
SELECT * FROM <TABLE_NAME>
WHERE (
	<SELECT <COL_NAME> FROM <TABLE_NAME> 
	WHERE <SUB_QUERY_CONDITION>
	) <CONDITION_2>
```

EG.
```mysql
SELECT first_name, last_name
FROM employees
WHERE (SELECT AVG(hourly_pay) FROM employee) < hourly_pay
```

### Types of sub-Queries
1. **Scalar query:-** It always return one row and one column
2. **Multiple rows subquery:-** 
	- It returns multiple rows and multiple columns.
	- It return multiple rows and 1 column.

	when you are using where clause with multiple rows that time you need to iterate through all records for comparison. You can use IN OR NOT IN.

3. **Correlated sun-query**
	- The subquery is depends on outer subquery;
	```mysql
	SELECT * FROM employee e1 
	where salary > 
	(
		SELECT avg(salary)
		FROM employee e2
		WHERE e1.dept_name = e2.dept_name
	)
	```
	
	When you are using sub-query within join it treated as separate table it self.
	
	Sub-Queries allowed in 
		1. SELECT : sub-query should return only one column and one row
		2. FROM 
		3. WHERE
			4. HAVING

## 25. GROUP BY
- aggregate all rows by  specific column 
- often usage with aggregate function SUM(), MAX(), MIN(), AVG(), COUNT()

Query:
```mysql
SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date
```

**When you use GROUP BY WITH multiple columns it groups by both columns combination value**

## 26. ROLLUP
- ROLLUP , extension of the GROUP BY clause
- produces another row d show GRAND TOTAL ( super aggregate value )

Query:
```mysql
SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date WITH ROLLUP
```

## 27. ON DELETE
- ON DELETE SET NULL = When a FK deleted, replace EK with null which containing FK in other table
- ON DELETE CASCADE = When a FK deleted, delete row which containing FK in other table

Query:
```mysql
ALTER <TABLE_NAME>
ADD CONSTRAINT <FK_NAME>
FOREIGN KEY(COL_NAME_OF_CURRENT_TABLE) REFERENCES <TABLE_NAME_2>(PRIMARY_KEY_COL_NAME)
ON DELETE SET NULL/ ON DELETE CASCADE
```

## 28. STORED PROCEDURES
- is Prepared SQL code that you can save 
- Great if there's query you write often
- reduces traffic
- Increase performance
- Secure, admin can grant permission to use
- increase memory usage of every connection
		
Query:
1. DELIMITER: \$$  This line replace delimiter symbol( ; ) to $$

```mysql
CREATE PROCEDURE <PROCEDURE_NAME>(IN <PARAMETER_NAME> DATA_TYPE)
BEGIN 
	/* Procedure body */
END $$
DELIMITER ;
```
2. DROP PROCEDURE <PROCEDURE_NAME>
```mysql
DROP PROCEDURE <PROCEDURE_NAME>
```
3. CALL <PROCEDURE_NAME>(<ARG>)
```mysql
CALL <PROCEDURE_NAME>(<ARG>)
```

## 29. TRIGGERS
- When an event happens, do something
- ( INSERT< UPDATE, DELETE )
- benefits ==> checks data, handle errors, auditing tables

Query:
1. CREATE TRIGGER
```mysql
CREATE TRIGGER <TRIGGER_NAME>
BEFORE/AFTER <EVENT> ON <TABLE_NAME> // <EVENT> = INSERT / UPDATE / DELETE
FOR EACH ROW // on every row perform action 
SET NEW.<COL_NAME> = <ACTION>  // NEW used to refer new OR old value
```
2. SHOW TRIGGERS  
```mysql
SHOW TRIGGERS  
```

EG.
```mysql
CREATE TRIGGER after_salary_delete
AFTER DELETE ON employees
FOR EACH ROW
UPDATE expenses
SET expense_total = ( expenses_total - OLD.salary )
WHERE expense_name = 'salaries';

SET NEW.salary = (NEW.hourly_pay * 20280)
ON expenses 
```

NOTES:
	1) When you want to use distinct in functions use inside function 
	eg. SELECT COUNT( DISTINCT COL_NAME ) 

## 30. CASE WHEN
```mysql
SELECT 
CASE WHEN A = B AND B = C THEN 'Equilateral'
WHEN A + B <= C OR B + C <= A OR A + C <= B THEN 'Not A Triangle'
WHEN A != B AND B != C AND A != C THEN 'Scalene'
WHEN (A = B AND A != C) OR (B = C AND B != A) OR (A = C AND A != B)  THEN 'Isosceles'
END AS ""
FROM TRIANGLES
```

## 31. condition in COUNT()
```mysql
SELECT
COUNT(CASE WHEN condition1 THEN expression1 ELSE NULL END) AS Alias1,
COUNT(CASE WHEN condition2 THEN expression2 ELSE NULL END) AS Alias2
FROM table_name
WHERE condition;
```

## 32. Window Functions: 
( They are same as GROUP BY but can be used in SELECT, ORDER BY, HAVING )

- Window functions perform agggregate operations on groups of rows, But they produce a result FOR EACH ROW.
- functions that perform calculations across a set of rows related to the current row.

Syntax:
```mysql
SELECT * 
<aggregate_fn> over(partition by <column_name>) as alice			
FROM <table_name>;
```

- Here over() function treats all records as one window, and 
if you use partition clause then it will create separate partition with column condition

	EG. 
	```mysql
	SELECT * 
	row_number() over(partition by salary) as row_number
	FROM employees;
	```

**Window functions are**
- row_number(), 
- rank(): skips duplicate rows numbers, 
- dens_rank(): does not skip duplicate numbers, 
- lag(): return prev record, 
- ntile(): a window function that allows you to break a table into a specified number of approximately equal groups, or <bucket count>,
- first_value(): returns the first value in a window, types : first_value(val), first_value(val, 2)
- lead(), etc

	**Eg.**
	```table 
	INITIAL TABLE - employees
	------------------------------------
	emp_no 	| department 		| salary
	1       | sales      		| 50000
	2       | sales      		| 60000
	20   	| customer_service 	| 40000
	21   	| customer_service 	| 45000
	```
	```mysql
	SELECT emp_no, department, salary,
	AVG(salary), ROW_NUMBER() OVER (PARTITION BY department) AS dept_avg_salary
	FROM employees;
	```

	**TABLES AFTER WINDOW FUNCTION**
	```table 
	emp_no 	| department 		| salary 	| row_number
	-------- GROUP/WINDOW 1 -----------
	1       | sales      		| 50000 	| 1
	2       | sales      		| 60000 	| 2
	-------- GROUP/WINDOW 2 -----------
	20		| customer_service 	| 40000 	| 1
	21		| customer_service 	| 45000 	| 2
	```

	**RESULT TABLE AFTER AVG(salary)**
	```table 
	emp_no 	| department 		| dept_avg_salary 	| row_number 	
	1       | sales      		| 55000 			| 1
	2       | sales      		| 55000 			| 2
	20		| customer_service 	| 42500 			| 1
	21		| customer_service 	| 42500 			| 2
	```


## 33. WITH Clause:
- It is used to define temporary tables or result sets within a query

	**Eg 1.**
	```mysql
	WITH temp_sales_table as 
		( SELECT store_name, sum(price) as total_sales
			FROM sales
			GROUP BY store_name
		) 
	SELECT s.* 
	FROM sales s
	JOIN ( SELECT avg(total_sales) as sales
			FROM temp_sales_table 
		) avg_sales
	ON temp_sales_table.total_sales > avg_sales.sales;
	```

	**Eg 2.**
	```mysql
	WITH temp_sales_table AS 
	(
		SELECT store_name, SUM(price) AS total_sales
		FROM sales
		GROUP BY store_name
	)
	SELECT s.*
	FROM sales s
	JOIN temp_sales_table t ON s.store_name = t.store_name
	WHERE t.total_sales > (SELECT AVG(total_sales) FROM temp_sales_table);
	```

## 34. String Functions:-
1. **CONCAT():** Concats two or more strings
	- CONCAT( STRING1, STRING2, ...); // CONCAT( "Pratik", " ", "Kamble" ); => Pratik Kamble

2. **CONCAT_WS():** Concatenates two or more strings with a separator
	- CONCAT_WS( SEPARATOR, STRING1, STRING2, ...); // CONCAT_WS( "-", "Pratik", "Kamble" ); => Pratik-Kamble

3. **SUBSTRING()/SUBSTR():** Returns a substring from a string
	- SUBSTR( STRING, START, LENGTH ); // SUBSTR( "Pratik", 1, 4 ); => Prat
	- SUBSTRING( STRING, START ); // SUBSTR( "Pratik", 1 ); => Pratik
	- SUBSTR( STRING, START, LENGTH ); // SUBSTR( "Pratik", -4, 2 ); => at

4. **REPLACE():** Replaces a substring with another substring
	- REPLACE( STRING, OLD_SUBSTRING, NEW_SUBSTRING ); // REPLACE( "Pratik", "P", "A" ); => Aratik

5. **REVERSE():** Returns the reversed string
	- REVERSE( STRING ); // REVERSE( "Pratik" ); => kitarP

6. **CHAR_LENGTH():** Returns the length of a string
	- CHAR_LENGTH( STRING ); // CHAR_LENGTH( "Pratik" ); => 6
	- LENGTH(STRING); // LENGTH( "Pratik" ); => 6 ## Returns value in bytes

7. **UPPER()/UCASE() AND LOWER()/LCASE():** Returns the string in upper case or lower case
	- UPPER( STRING ); // UPPER( "Pratik" ); => PRATIK
	- LOWER( STRING ); // LOWER( "PRATIK" ); => pratik

8. **INSERT()/INSTR():** Inserts a substring into another string
	- INSERT( STRING, POSITION, REPLACABLE_LENGTH, NEW_SUBSTRING ); // INSERT( "Pratik", 1, 0, "A" ); => Apratik

9. **LEFT() AND RIGHT():** Returns the leftmost or rightmost characters of a string
	- LEFT( STRING, LENGTH ); // LEFT( "Pratik", 4 ); => Prat
	- RIGHT( STRING, LENGTH ); // RIGHT( "Pratik", 2 ); => Pr

10. **REPEAT():** Returns a string repeated a specified number of times
	- REPEAT( STRING, COUNT ); // REPEAT( "Pratik", 3 ); => PratikPratikPratik

11. **TRIM():** Returns the string with all non-alphanumeric characters removed
	- TRIM( STRING ); // TRIM( " Pratik " ); => Pratik
	- TRIM( LEADING 'a' FROM STRING ); // TREAM( LEADING 'a' FROM "aPratik " ); => Pratik
	- TRIM( TRAILING 'a' FROM STRING ); // TRIM( TRAILING 'a' FROM "Pratik a" ); => Pratik
	- TRIM( BOTH 'a' FROM STRING ); // TRIM( BOTH 'a' FROM "aPratik a" ); => Pratik

## 35. SELECT REFINING
1. DISTINCT: Returns all distinct values
	SELECT DISTINCT column_name FROM table_name; 

2. WindCards escaping characters:		
	You can use "\" backeword slash before windcard chars whilw searching
	Eg. SELECT name FROM books WHERE name LIKE "%\_%";

## 36. Aggregate functions
1. COUNT(): 
	It returns count of the rows in table.
	Syntax: SELECT COUNT(*) FROM <table_name>;
	
	```mysql
	SELECT COUNT(*) FROM books WHERE title LIKE '%the%';
	```

2. GROUP BY:
	Used to segregate data into smaller groups.											 
	```mysql
	SELECT COUNT(*) FROM <table_name> GROUP BY <column_name>; // this will return count of rows in each formed group;
	```

	```mysql
	SELECT author_lname, COUNT(*) 
	FROM books
	GROUP BY author_lname;
	```

	### GROUP BY with multiple COLUMNS
	```mysql
	SELECT author_fname, author_lname, COUNT(*) 
	FROM books 
	GROUP BY author_lname, author_fname;
	```				
				
	```mysql
	SELECT CONCAT(author_fname, ' ', author_lname) AS author,  COUNT(*)
	FROM books
	GROUP BY author;
	```
	
	### IMP NOTE:- 
	```markdown
	|   Clause   |   Order of Execution   |   When It’s Used                 |   What It Filters                    |   Can Use Aggregates (`SUM()`, `COUNT()`)?   |
	| ---------- | ---------------------- | -------------------------------- | ------------------------------------ | -------------------------------------------- |
	| `WHERE`    | 🟡 Before `GROUP BY`   | Filters rows   before grouping   |   Individual rows   (raw data)       | ❌ No                                         |
	| `HAVING`   | 🔵 After `GROUP BY`    | Filters rows   after grouping    |   Grouped rows   (aggregate results) | ✅ Yes                                        |
	```

### NOTE :- 
- WHERE filters rows before grouping (raw data).
- GROUP BY produces a new result set where rows are grouped by one or more columns.
	HAVING filters groups after aggregation (summary data).

## 37. DATA TYPES
### 1. CHAR vs VARCHAR:
	- CHAR - has a fixed size value. If the value is less than the defined length, then it adds spaces in that position.
	- VARCHAR - It stores values of provided characters. It does not add spaces in empty space.

### 2. Unsigned vs Signed INT:
	- Unsigned : In this type we can't store negative numbers
	- Signed :  In this type we can store positive as well as Negative numbers;	
	
### 3. DATE & TIME
- DATE: 'YYYY:MM:DD' -> CURDATE()
- TIME: 'HH:MM:SS' -> CURTIME()
- DATETIME: 'YYYY:MM:DD HH:MM:SS' -> NOW()

- DAY(birthdate),
- DAYOFWEEK(birthdate),
- DAYOFYEAR(birthdate)
- MONTHNAME(birthdate),
- YEAR(birthdate)
- MONTH(birthdt),
- DAY(birthdt),
- HOUR(birthdt),
- MINUTE(birthdt)

### Date formates:
```mysql
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
```

```mysql
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
```

```mysql
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people; // returns 12hr format
```

### 4. TIMESTAMPS
```mysql
CREATE TABLE captions2 (
	text VARCHAR(150),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```	

## 38. OPERATORS
### 1. BETWEEN:
```mysql
SELECT title, released_year FROM books
WHERE released_year BETWEEN 2004 AND 2014;
```

```mysql
SELECT title, released_year FROM books
WHERE released_year NOT BETWEEN 2004 AND 2014;
```
	
### 2. TIME CASTING:
```mysql
SELECT * FROM people WHERE birthtime 
BETWEEN CAST('12:00:00' AS TIME) 
AND CAST('16:00:00' AS TIME);
```

### 3. MODULO:
```mysql
released_year % 2 = 1; // return 0 OR 1 = 0 (false), 1 (true)
```

### 4. CASE:
- It is used to return custom text/string based on condition passing

```mysql
SELECT 
	author_fname, 
	author_lname,
	CASE WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*)," Books") 
	ELSE CONCAT(COUNT(*), " Book") 
			END AS COUNT
			FROM books
			WHERE author_lname IS NOT NULL
			GROUP BY author_fname, author_lname;
```
	
### 5. IFNULL: It is used to replace value if null found while selecting from table;
	Eg. 
	```mysql
	SELECT 
		first_name, 
		last_name, 
		IFNULL(SUM(amount), 0) AS money_spent
	FROM
		customers
		GROUP BY first_name, last_name;
	```

### 6. Create a temporary variable in a function
```mysql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
	DECLARE offset_val INT;
	SET offset_val = N - 1; ## temp variable
	RETURN (
		# Write your MySQL query statement below.
		SELECT (SELECT DISTINCT salary FROM Employee
			ORDER BY salary
			LIMIT 1 OFFSET offset_val) # You can't directly do N-1
		);
	END	
```
