# Car-Dealership
The MySQL schema for this project defines the structure and relationships of the database. The schema is stored in a cardealership script.sql file located in the sql/ directory. The schema file contains SQL commands to create the necessary tables and relationships for managing cars, customers, and sales in the dealership system
Following are the some of the queries to extract the data from the tables

The given SQL script creates a database called DealershipSystem and defines several tables with relationships between them. Below is a brief description of each table:

Cars: This table stores information about the cars available in the dealership, such as make, model, year, price, status (whether the car is available or sold), and a unique Vehicle Identification Number (VIN).

Columns: car_id, make, model, year, price, status, VIN_number.
Customers: This table stores customer information including their first and last names, email, phone number, and address.

Columns: customer_id, first_name, last_name, email, phone_number, address.
Employees: This table stores information about the employees working at the dealership, such as their names, contact details, hire date, position, and the dealership location they work at.

Columns: employee_id, first_name, last_name, email, phone_number, hire_date, position, location_id.
Dealerships: This table stores details about each dealership's location, including the name, address, and phone number.

Columns: location_id, location_name, address, phone_number.
Sales: This table records the sales transactions, linking cars with customers and employees, including the sale date and final price.

Columns: sale_id, car_id, customer_id, employee_id, sale_date, final_price.
Example Queries to Extract Data:


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

-- 4 View the list of employees with their positions and the total sales made
SELECT 
    Employees.first_name, 
    Employees.last_name, 
    Employees.position, 
    SUM(Sales.final_price) AS total_sales
FROM Employees
LEFT JOIN Sales ON Employees.employee_id = Sales.employee_id
GROUP BY Employees.employee_id;

-- 5 View the number of cars sold per customer: 
SELECT 
    Customers.first_name, 
    Customers.last_name, 
    COUNT(Sales.sale_id) AS number_of_cars_sold
FROM Sales
JOIN Customers ON Sales.customer_id = Customers.customer_id
GROUP BY Customers.customer_id;
