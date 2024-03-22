create database RepairsAndMaintainance;
use RepairsAndMaintainance;

CREATE TABLE Customers (
  customer_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20),
  email VARCHAR(100)
);
select *from Customers;
-- drop table Customers
-- Inserting into Customers
INSERT INTO Customers (first_name, last_name, phone_number, email)
VALUES ('Eric', 'Affum', '024-165-1155', 'eaffum05@umat.edu.gh'),
       ('Felix', 'Aryeh', '055-014-8545', 'fkaryeh@umat.edu.gh'),
	   ('Dominic','Fabin','026-151-2513','fabindominic99@gmail.com'),
	   ('samuel','Ainoo','024-250-5621','stitiches32@gmail.com');

CREATE TABLE Vehicles (
  vehicle_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
  make VARCHAR(50) NOT NULL,
  model VARCHAR(50) NOT NULL,
  year INT,
  license_plate VARCHAR(20),
  VIN VARCHAR(17) UNIQUE
);

-- Insert Vehicles
INSERT INTO Vehicles (customer_id, make, model, year, license_plate, VIN)
VALUES (1, 'Honda', 'Civic', 2020, 'ABC123', 'HONJXKA30'),
       (1, 'Ford', 'F-150', 2022, 'DEF456', '2FHFK4A6NKBA01'),
	   (2, 'Benz', 'X50', 2019, 'WK1156', '2FHFK4A6NKBA02'),
	   (5, 'Tesla', 'X50', 2019, 'WK1156', '3HGDF50AKBA301'),
	   (8, 'Corolla', 'X50', 2019, 'WK1156', '2FHDHS45BA05'),
	   (6, 'Ford', 'X50', 2019, 'WK1156', '2FHJ5K51KKBA06'),
	   (1, 'Toyota', 'Camry', 2022, 'ABC123', '1HGCM823A1206'),
	   (2, 'Honda', 'Civic', 2021, 'XYZ789', '2HGFG1JH98504'),
	   (3, 'Ford', 'F-150', 2020, 'LMN456', '1FTFW1EF9BFA95');

select *from Vehicles;

CREATE TABLE Services (
  service_id INT IDENTITY(1,1) PRIMARY KEY,
  service_name VARCHAR(50) NOT NULL,
  service_description VARCHAR(255),
  labor_cost DECIMAL(10,2) NOT NULL
);

-- Insert Services
INSERT INTO Services (service_name, service_description, labor_cost)
VALUES ('Oil Change', 'Standard oil change with filter replacement', 50.00),
       ('Tire Rotation and Alignment', 'Rotation of all four tires', 25.00),
	   ('Emission Check', 'Emission of all type', 25.00),
	   ('Brake Inspection','Brake pads, rotors, and calipers are inspected',100.00),
	   ('Battery Replacement','Old battery is removed, and a new one is installed. Connections are checked',150.00);
select *from Services;

CREATE TABLE Technicians (
  technician_id INT PRIMARY KEY IDENTITY(1,1),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  hire_date DATE NOT NULL,
  hourly_rate DECIMAL(10,2) NOT NULL
);

INSERT INTO Technicians (first_name, last_name, hire_date, hourly_rate)
VALUES ('Nana Yaw', 'Smith', '2020-01-01', 35.00),
       ('Jane', 'Daks', '2022-05-15', 40.00),
	   ('Moses', 'Turkson', '2022-05-15', 40.00),
	   ('Phavour', 'Eben', '2022-05-15', 60.00),
	   ('Araba', 'Turk', '2024-01-15', 50.00),
	   ('Kennedy', 'Akogo', '2023-05-15', 40.00);
select * from Technicians;

CREATE TABLE Repairs (
  repair_id INT IDENTITY(1,1) PRIMARY KEY,
  vehicle_id INT FOREIGN KEY REFERENCES Vehicles(vehicle_id),
  service_id INT FOREIGN KEY REFERENCES Services(service_id),
  repair_date DATE NOT NULL,
  technician_id INT FOREIGN KEY REFERENCES Technicians(technician_id), 
  notes VARCHAR(255)
);
-- Insert Repairs 
INSERT INTO Repairs (vehicle_id, service_id, repair_date,technician_id, notes)
VALUES (7, 1, '2022-03-15',4, 'Used synthetic oil'),
       (12, 2, '2022-12-20',1, 'Customer requested front-wheel alignment'),
	   (5, 2, '2023-01-29',2, 'Customer requested front-wheel alignment'),
	   (10, 4, '2023-02-20',6, 'Customer requested a Brake Inspection'),
	   (8, 1, '2024-01-10',5, 'Customer requested a Used synthetic oil'),
	   (9, 5, '2024-01-20',4, 'Customer requested a Battery Replacement'),
	   (11, 5, '2024-02-18',3, 'Customer requested a Battery Replacement'),
	   (6, 3, '2024-03-10',4, 'Customer requested an Emission Check');

select * from Repairs

CREATE TABLE Payments (
  payment_id INT PRIMARY KEY IDENTITY(1,1),  /* Auto-incrementing primary key */
  repair_id INT FOREIGN KEY REFERENCES Repairs(repair_id),
  payment_date DATE NOT NULL,
  payment_method VARCHAR(50) NOT NULL,  /* Cash, Credit Card, etc. */
  payment_amount DECIMAL(10,2) NOT NULL
);
INSERT INTO Payments (repair_id, payment_date, payment_method, payment_amount)
VALUES (1, '2022-03-15', 'Cash', 75.00),  /* Increased amount for synthetic oil */
       (2, '2022-12-20', 'Credit Card', 35.00),
	   (3, '2023-01-29', 'Momo', 35.00),
	   (4, '2023-02-20', 'Credit Card', 35.00),
	   (5, '2024-01-10', 'Credit Card', 35.00),
	   (6, '2024-02-18', 'Cheque', 35.00),
	   (7, '2024-03-10', 'Credit Card', 35.00);

CREATE TABLE Inventory (
  part_id INT PRIMARY KEY IDENTITY(1,1),
  part_name VARCHAR(100) NOT NULL,
  part_description VARCHAR(255),
  cost_per_unit DECIMAL(10,2) NOT NULL,
  quantity_in_stock INT NOT NULL,
  reorder_point INT NOT NULL
);
INSERT INTO Inventory (part_name, cost_per_unit, quantity_in_stock, reorder_point)
VALUES ('Engine Oil Filter', 12.50, 20, 10),
       ('Brake Pads (Front)', 75.00, 15, 5),
       ('Alternator', 55.00, 30, 15),
	   ('Radiator', 85.00, 20, 5),
	   ('Front Steering', 55.00, 40, 25),
	   ('Battery', 150.00, 35, 35),
	   ('Exhaust System', 45.00, 15, 25),
	   ('Fuel Supply System', 5.00, 30, 15),
	   ('Cooling Fans',25.00,20,15);

Select * from Inventory

UPDATE Inventory
SET part_description = 
    CASE 
        WHEN part_name = 'Engine Oil Filter' THEN 'High-quality oil filter for engine maintenance'
        WHEN part_name = 'Brake Pads (Front)' THEN 'Front brake pads for standard vehicle models'
        WHEN part_name = 'Alternator' THEN 'Component responsible for charging the battery and powering electrical systems'
        WHEN part_name = 'Radiator' THEN 'Component for cooling engine coolant'
        WHEN part_name = 'Front Steering' THEN 'Steering system for controlling vehicle direction'
        WHEN part_name = 'Battery' THEN 'Device for storing electrical energy to start the engine and power accessories'
        WHEN part_name = 'Exhaust System' THEN 'System for expelling exhaust gases from the engine'
        WHEN part_name = 'Fuel Supply System' THEN 'System for delivering fuel to the engine'
        WHEN part_name = 'Cooling Fans' THEN 'Fans for assisting in cooling the engine'
    END;

EXEC CalculateTotalRepairCost @repair_id=6
