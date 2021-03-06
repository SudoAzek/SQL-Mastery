/* MODIFYING DATA */

/* *********************** INSERT ***************************** */

/* Create a table named tasks for practicing the INSERT statement. */
CREATE TABLE IF NOT EXISTS tasks (
	task_id INT AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	start_date DATE,
	due_date DATE,
	priority TINYINT NOT NULL DEFAULT 3,
	decription TEXT,
	PRIMARY KEY (task_id)
);

/* Simple INSERT */
/* Following statement inserts a new row into the tasks table. */
INSERT INTO tasks(title, priority)
VALUES('Learing MySQL INSERT Statement', 1);

/* This query returns data from the tasks table. */
SELECT * FROM tasks;

/* Inserting rows using default value. */
/* If it's needed to insert a default value into a column, just ignore the column
 name while inserting or indicate it with DEFAULT keyword in the VALUES clause. */
INSERT INTO tasks(title, priority)
VALUES('Understanding DEFAULT keyword in INSERT statement', DEFAULT);

/* Inserting dates into the table. */
/* To insert a literal date value into a column, use the following format 'YYYY-MM-DD' */

/* Following statement inserts a new row to the tasks table with the start and due date values. */
INSERT INTO tasks(title, start_date, due_date)
VALUES('Inserting date into table', '2020-01-09', '2020-12-22');

/* It is possible to use expressions in the VALUES clause. The following statement adds a new task
using the current date for start date and due date columns. */
INSERT INTO tasks(title, start_date, due_date)
VALUES('Use current date for the task', CURRENT_DATE(), CURRENT_DATE());

/* Inserting multiple rows */
/* Following statement inserts three rows into the tasks table. */
INSERT INTO tasks(title, priority)
VALUES
	('My first task', 1),
	('It is the second task', 2),
	('This is the second task of the week', 3);

/* This statement shows the current value of the max_allowed_packet variable. */
SHOW VARIABLES LIKE 'max_allowed_packet';

/* To set a new value for the max_allowed_packet variable, use the following statement, where 
size is an integer that represents the number of maximum allowed packet size in bytes. */
SET GLOBAL max_allowed_packet = size;

/* Create a new table called projects to show more demonstrations of multiple rows insert. */
CREATE TABLE projects(
	project_id INT AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	start_date DATE,
	end_date DATE,
	PRIMARY KEY(project_id)	
);

/* Use the INSERT multiple rows statement to insert two rows int the projects table. */
INSERT INTO
	projects(name, start_date, end_date)
VALUES
	('AI for Education', '2019-08-01', '2019-12-31'),
	('ML for Marketing', '2020-03-21', '2020-12-22');

/* When multiple rows inserted, use the LAST_INSERT_ID() fuction to get the last inserted id of an 
AUTO_INCREMENT column, it can get the id of the first inserted row only, not the id of the last inserted row. */
SELECT LAST_INSERT_ID();

/* *********************** INSERT INTO SELECT ***************************** */

/* First, let's create a new table called suppliers. */
CREATE TABLE suppliers (
	supplierNumber INT AUTO_INCREMENT,
	supplierName VARCHAR(50) NOT NULL,
	phone VARCHAR(50),
	addressLine1 VARCHAR(50),
	addressLine2 VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	postalCode VARCHAR(50),
	country VARCHAR(50),
	customerNumber INT,
	PRIMARY KEY(supplierNumber)
);

/* Following query finds all customers who locate in California, USA. */
SELECT
	customerNumber,
	customerName,
	phone,
	addressLine1,
	addressLine2,
	city,
	state,
	postalCode,
	country
FROM
	customers
WHERE
	country = 'USA' AND
	state = 'CA';

/* Now, use the INSERT INTO... SELECT statement to insert customers who locate 
in California USA from the customers table into the suppliers table. */
INSERT INTO suppliers (
	supplierName,
	phone,
	addressLine1,
	addressLine2,
	city,
	state,
	postalCode,
	country,
	customerNumber
)
SELECT
	customerName,
	phone,
	addressLine1,
	addressLine2,
	city,
	state,
	postalCode,
	country,
	customerNumber
FROM
	customers
WHERE
	country = 'USA' AND
	state = 'CA';

/* Using SELECT statement in the VALUES list */
/*First, create a new table called stats. */
CREATE TABLE stats (
	totalProduct INT,
	totalCustomer INT,
	totalOrder INT
);

/* Second, use the INSERT statement to insert values that come from the SELECT statements. */
INSERT INTO stats(totalProduct, totalCustomer, totalOrder)
VALUES(
	(SELECT COUNT(*) FROM products),
	(SELECT COUNT(*) FROM customers),
	(SELECT COUNT(*) FROM orders)
);

/* *********************** INSERT IGNORE ***************************** */

/* When using the INSERT statement to add multiple rows to a table and if an error occurs during the processing, 
MySQL terminates the statement and returns an error. As a result, no rows are inserted into the table. However,
if using the INSERT IGNORE statement, the rows with invalid data that cause the error are ignored and the rows
with valid data are inserted in the table. */

/* Let's create a new table called subscribers for the practice */
CREATE TABLE subscribers (
	id INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(50) NOT NULL UNIQUE
);

/* The UNIQUE constraint ensures that no duplicate email exists in the email column. */

/* Following statement inserts a new row in the subscribers table. */
INSERT INTO subscribers(email)
VALUES('john.doe@gmail.com');

/* Let's execute another statement that insets two rows into the subscribers table. */
INSERT INTO subscribers(email)
VALUES('john.doe@gmail.com'),
	  ('jane.smith@gmail.com'); 
/* It returns an error. As we have marked our subscribers table with UNIQUE keyword,
the email john.doe@gmail.com violates the UNIQUE constraint. However, if using the
INSERT IGNORE statement the duplicate row will be ignored. */
INSERT IGNORE INTO subscribers(email)
VALUES('john.doe@gmail.com'),
	  ('jane.smith@gmail.com');

/* *********************** INSERT IGNORE and STRICT ***************************** */

/* When the strict mode is on, MySQL returns an error and aborts the INSERT statement if you try to insert invalid 
values int a table. However, if you use the INSTANT IGNORE statement, MySQL will issue a warning instead of an error.
In addition, it will try to adjust the values to make them valid before adding the value to the table. */

/* Create a new table named tokens to demo. */
CREATE TABLE tokens(
	s VARCHAR(6)
);
/* In this table, the column s accepts only string whose lengths are less than or equal to 6.

Second, insert a string whose length is seven into the tokens table. */
INSERT INTO tokens VALUES('abcdefg'); 
/* MySQL issues an error because the strict mode is on.

Now, use the INSERT IGNORE statement to insert the same string. */
INSERT IGNORE INTO tokens VALUES('abcdefg');
/* MySQL truncated data before inserting it into the tokens table. */

/* *********************** UPDATE ***************************** */

/* Using MySQL UPDATE to modify values in a single column. */

/* In this example, we will update the email of Mary Patterson to the new email mary.patterson@classicmodelcars.com.

First, find Mary's email from the employees table using the following SELECT statement. */
SELECT
	firstName,
	lastName,
	email
FROM
	employees
WHERE
	employeeNumber = 1056;

/* Second, update the email address of Mary to the new email mary.petterson@classicmodelcars.com */
UPDATE employees
SET
	email = 'mary.patterson@classicmodelcars.com'
WHERE
	employeeNumber = 1056;

/* Using MySQL UPDATE to modify values in multiple columns. */

/* To update values in the multiple columns, need to specify the assignments in the SET clause. 
For example, the following statement updates both last name and email columns of employee number 1056. */
UPDATE employees
SET
	lastName = 'Hill',
	email = 'mary.hill@classicmodelcars.com'
WHERE
	employeeNumber = 1056;

/* Using MySQL UPDATE to replace string */

/* Following example updates the domain parts of emails of all Sales Reps with office code 6. */
UPDATE employees
SET
	email = REPLACE(email, '@classicmodelcars.com', '@mysqltutorial.org')
WHERE
	jobTitle = 'Sales Rep' AND officeCode = 6;
/* In this example, the REPLACE() function replaces @classicmodelcars.com in the email column with @mysqltutorial.org */

/* Using MySQL UPDATE to update rows returned by a SELECT statement */

/* It's possible to supply the values for the SET clause from a SELECT statement that queries data from other tables. 
For example, in the customers table, some customers do not have any sale representative. The value of the column
saleRepEmployeeNumber is NULL as follows. */
SELECT
	customerName,
	salesRepEmployeeNumber
FROM
	customers
WHERE
	salesRepEmployeeNumber IS NULL;
/* We can take a sale representative and update for those customers. To do that, we can select a random employee whose job
title is Sales Rep from the employees table and update it for the employees table. */

-- This query selects a random employee from the table employees whose job title is the Sales Rep.
SELECT
	employeeNumber
FROM
	employees
WHERE
	jobTitle = 'Sales Rep'
ORDER BY RAND()
LIMIT 1;

/* To update the sales representative employee number column in the customers table, we place the query above in the SET 
clause of the UPDATE statement as follows. */
UPDATE customers
SET
	salesRepEmployeeNumber = (
		SELECT
			employeeNumber
		FROM
			employees
		WHERE
			jobTitle = 'Sales Rep'
		ORDER BY RAND()
		LIMIT 1
		)
WHERE
salesRepEmployeeNumber IS NULL;
		)


-- *********************** UPDATE JOIN *****************************

/* We are going to use a new sample database named emp_db for demonstration. This sample database consists of two tables:
	- The employees table stores employee data with employee id, name, performance, and salary.
	- The merits table stores employee performance and merit's percentage.
The following statements create and load data int the emp_db sample database: */
CREATE DATABASE IF NOT EXISTS emp_db;

USE emp_db;

-- create tables
CREATE TABLE merits (
	performance INT(11) NOT NULL,
	percentage FLOAT NOT NULL,
	PRIMARY KEY(performance)
);

CREATE TABLE employees (
	emp_id INT(11) NOT NULL AUTO_INCREMENT,
	emp_name VARCHAR(255) NOT NULL,
	performance INT(11) DEFAULT NULL,
	salary FLOAT DEFAULT NULL,
	PRIMARY KEY(emp_id),
	CONSTRAINT fk_performance FOREIGN KEY(performance)
		REFERENCES merits(performance)
);

-- insert data for merits table
INSERT INTO merits(performance, percentage)
VALUES(1, 0)
	 ,(2, 0.01)
	 ,(3, 0.03)
	 ,(4, 0.05)
	 ,(5, 0.08);

-- insert data for employees table
INSERT INTO employees(emp_name, performance, salary)
VALUES('Mary Doe', 1, 50000)
	 ,('Cindy Smith', 3, 65000)
	 ,('Sue Greenspan', 4, 75000)
	 ,('Grace Dell', 5, 125000)
	 ,('Nancy Johnson', 3, 85000)
	 ,('John Doe', 2, 45000)
	 ,('Lily Bush', 3, 55000);
		
-- *********************** UPDATE JOIN WITH INNER JOIN *****************************
