CREATE TABLE EMP(ID INT,NAME VARCHAR(10),DEPT Varchar(10),SALARY INT,CITY VARCHAR(10))
INSERT INTO EMP VALUES(109,'DURGA','NULL',680000,'NULL'),(101,'RIYA','PYTHON',100000,'SATARA'),(102,'PRATIK','CHEM',9000000,'PUNE'),(103,'RITESH','DATASCI',7100000,'KOREGAON'),(104,'RAM','DATA ENG',8400000,'MUMBAI'),
(105,'NITA','AZURE',200000,'KOLHAPUR'),(106,'SAKSHI','ETL',43550,'HYDRABAD'),(107,'VRINDA','HISTORY',99999,'BANGLORE')
SELECT * FROM EMP
DELETE FROM EMP WHERE ID = 101

SELECT * FROM EMP
WHERE CITY = 'MUMBAI'

SELECT * FROM EMP
WHERE CITY LIKE 'MUMBAI'

SELECT * FROM EMP
WHERE CITY = 'PUNE' OR NAME = 'RIYA'

SELECT * FROM EMP
WHERE DEPT LIKE '%N'  AND NAME LIKE '%A';

SELECT * FROM EMP
WHERE SALARY BETWEEN 43000 AND 9000000;

SELECT * FROM EMP
WHERE NAME LIKE '____%E'

-- Product Dimension Table
CREATE TABLE DimProduct (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50)
);
-- Customer Dimension Table
CREATE TABLE DimCustomer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);
-- Date Dimension Table
CREATE TABLE DimDate (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);
DROP TABLE IF EXISTS DimDate;

-- Insert into Product Dimension
INSERT INTO DimProduct (product_name, category)
VALUES 
('Laptop', 'Electronics'),
('Shoes', 'Fashion');

-- Insert into Customer Dimension
INSERT INTO DimCustomer (customer_name, city)
VALUES 
('Riya Dhumal', 'Pune'),
('Ritesh Dhumal', 'Mumbai');

-- Insert into Date Dimension
INSERT INTO DimDate (full_date, year, month, day)
VALUES 
('2025-09-08', 2025, 9, 8),
('2025-09-09', 2025, 9, 9);


SELECT name 
FROM sys.tables;

SELECT * from DimCustomer

INSERT INTO DimProduct (product_name, category)
VALUES
('Laptop', 'Electronics'),
('Shoes', 'Fashion'),
('Mobile Phone', 'Electronics'),
('T-Shirt', 'Fashion');

INSERT INTO DimCustomer (customer_name, city)
VALUES
('Riya Dhumal', 'Pune'),
('Ritesh dhumaal', 'Mumbai'),
('Shra Patil', 'Nagpur'),
('saki Sharma', 'Delhi');

INSERT INTO DimDate (full_date, year, month, day)
VALUES
('2025-09-08', 2025, 9, 8),
('2025-09-09', 2025, 9, 9),
('2025-09-10', 2025, 9, 10),
('2025-09-11', 2025, 9, 11);

INSERT INTO FactSales (date_id, product_id, customer_id, quantity_sold, sales_amount)
VALUES
(1, 1, 1, 2, 120000.00),  
(2, 2, 2, 3, 4500.00),   
(3, 3, 3, 1, 30000.00),  
(4, 4, 4, 5, 2500.00); 

CREATE TABLE FactSales (
    fact_id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-increment primary key
    date_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    quantity_sold INT NOT NULL,
    sales_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (product_id) REFERENCES DimProduct(product_id),
    FOREIGN KEY (customer_id) REFERENCES DimCustomer(customer_id)
);

SELECT 
    d.full_date,
    p.product_name,
    c.customer_name,
    f.quantity_sold,
    f.sales_amount
FROM FactSales f
JOIN DimDate d ON f.date_id = d.date_id
JOIN DimProduct p ON f.product_id = p.product_id
JOIN DimCustomer c ON f.customer_id = c.customer_id;
-- Step 1: Create table
CREATE TABLE employeee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    salary INT
);

-- Step 2: Insert 20 records
INSERT INTO employeee (id, name, city, salary) VALUES
(1, 'Riya', 'Pune', 35000),
(2, 'Sagar', 'Mumbai', 42000),
(3, 'Ajit', 'Nagpur', 40000),
(4, 'Priya', 'Nashik', 37000),
(5, 'Rahul', 'Kolhapur', 39000),
(6, 'Sneha', 'Solapur', 41000),
(7, 'Amit', 'Pune', 45000),
(8, 'Neha', 'Thane', 36000),
(9, 'Vikas', 'Aurangabad', 47000),
(10, 'Anjali', 'Satara', 34000),
(11, 'Rohit', 'Pune', 38000),
(12, 'Komal', 'Mumbai', 43000),
(13, 'Vishal', 'Nashik', 41000),
(14, 'Manisha', 'Pune', 39000),
(15, 'Kiran', 'Latur', 35000),
(16, 'Deepa', 'Kolhapur', 37000),
(17, 'Nilesh', 'Solapur', 46000),
(18, 'Pooja', 'Nagpur', 38000),
(19, 'Sandeep', 'Pune', 44000),
(20, 'Tanvi', 'Thane', 42000);

with cte as (
select name, salary, dense_rank() over (order by salary desc) as rw from employeee
)
select * from cte where rw = 2

SELECT name, salary
FROM employeee
WHERE salary =  (
    SELECT MAX(salary)
    FROM employeee
    WHERE salary < (
        SELECT MAX(salary)
        FROM employeee
    )
);



ALTER LOGIN [sa] WITH PASSWORD = 'root1234';
-- or create/add another login and give sysadmin:
CREATE LOGIN [MyAdmin] WITH PASSWORD = 'AnotherStrong1!';
ALTER SERVER ROLE sysadmin ADD MEMBER [MyAdmin];