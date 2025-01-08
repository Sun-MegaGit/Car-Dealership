# Car-Dealership
The MySQL schema for this project defines the structure and relationships of the database. The schema is stored in a cardealership script.sql file located in the sql/ directory. The schema file contains SQL commands to create the necessary tables and relationships for managing cars, customers, and sales in the dealership system
Following are the some of the queries to extract the data from the tables

For the details of the databases and tables please check the file cardealership script.sql 


Queries - 

-- 1. View all cars and their status
SELECT * FROM Cars;

-- 2. View all sales with customer and employee details
SELECT 
    Sales.sale_id,
    Cars.make AS car_make,
    Cars.model AS car_model,
    Customers.first_name AS customer_first_name,
    Customers.last_name AS customer_last_name,
    Employees.first_name AS employee_first_name,
    Employees.last_name AS employee_last_name,
    Sales.sale_date,
    Sales.final_price
FROM Sales
JOIN Cars ON Sales.car_id = Cars.car_id
JOIN Customers ON Sales.customer_id = Customers.customer_id
JOIN Employees ON Sales.employee_id = Employees.employee_id;

-- 3. View all employees and their dealership
SELECT 
    Employees.first_name,
    Employees.last_name,
    Employees.position,
    Dealerships.location_name AS dealership_name,
    Dealerships.address AS dealership_address
FROM Employees
JOIN Dealerships ON Employees.location_id = Dealerships.location_id;
