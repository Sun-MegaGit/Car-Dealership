CREATE DATABASE DealershipSystem;
USE DealershipSystem;


CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status ENUM('available', 'sold') NOT NULL DEFAULT 'available',
    VIN_number CHAR(17) UNIQUE NOT NULL
);


CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL
);


CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    position VARCHAR(50) NOT NULL,
    location_id INT NOT NULL
);


CREATE TABLE Dealerships (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL
);


ALTER TABLE Employees
ADD CONSTRAINT FK_Employee_Dealership
FOREIGN KEY (location_id) REFERENCES Dealerships(location_id);


CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    sale_date DATE NOT NULL,
    final_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (car_id) REFERENCES Cars(car_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);


INSERT INTO Dealerships (location_name, address, phone_number)
VALUES
('Downtown Dealership', '123 Main St, Springfield, IL', '555-111-2222'),
('Northside Dealership', '456 Elm St, Chicago, IL', '555-333-4444');


INSERT INTO Employees (first_name, last_name, email, phone_number, hire_date, position, location_id)
VALUES
('John', 'Smith', 'john.smith@example.com', '555-555-5555', '2020-03-15', 'Sales Manager', 1),
('Jane', 'Doe', 'jane.doe@example.com', '555-666-6666', '2021-06-01', 'Sales Associate', 1),
('Robert', 'Brown', 'robert.brown@example.com', '555-777-7777', '2019-09-23', 'Sales Associate', 2);

INSERT INTO Cars (make, model, year, price, status, VIN_number)
VALUES
('Toyota', 'Camry', 2020, 24000.00, 'available', '1HGCM82633A123456'),
('Honda', 'Civic', 2019, 20000.00, 'sold', '2HGCM82633A654321'),
('Ford', 'Mustang', 2021, 30000.00, 'available', '3HGCM82633A987654'),
('Tesla', 'Model 3', 2022, 45000.00, 'sold', '4HGCM82633A234567'),
('Chevrolet', 'Malibu', 2021, 25000.00, 'available', '5HGCM82633A345678');

INSERT INTO Customers (first_name, last_name, email, phone_number, address)
VALUES
('Michael', 'Johnson', 'michael.johnson@example.com', '555-888-8888', '789 Maple Dr, Springfield, IL'),
('Sarah', 'Connor', 'sarah.connor@example.com', '555-999-9999', '456 Pine St, Chicago, IL');


INSERT INTO Sales (car_id, customer_id, employee_id, sale_date, final_price)
VALUES
(2, 1, 1, '2023-11-01', 19000.00), 
(4, 2, 3, '2023-11-10', 44000.00); 

-- View all cars and their status
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