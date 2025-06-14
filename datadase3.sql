CREATE DATABASE Global_Logistics_SCM;
USE Global_Logistics_SCM;

CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    name VARCHAR(255),
    address TEXT
);


CREATE TABLE Carriers (
    carrier_id INT PRIMARY KEY,
    name VARCHAR(255),
    type ENUM('Air', 'Land', 'Sea'),
    contact_info TEXT
);


CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY,
    location VARCHAR(255),
    capacity INT
);


CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(100),
    assigned_warehouse_id INT,
    assigned_carrier_id INT,
    CONSTRAINT chk_assigned CHECK (
        (assigned_warehouse_id IS NOT NULL AND assigned_carrier_id IS NULL)
        OR
        (assigned_warehouse_id IS NULL AND assigned_carrier_id IS NOT NULL)
    ),
    FOREIGN KEY (assigned_warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (assigned_carrier_id) REFERENCES Carriers(carrier_id)
);


CREATE TABLE Shipments (
    shipment_id INT PRIMARY KEY,
    origin VARCHAR(255),
    destination VARCHAR(255),
    weight DECIMAL(10,2),
    content_description TEXT,
    shipment_date DATE
);


CREATE TABLE Shipment_Carriers (
    shipment_id INT,
    carrier_id INT,
    leg_number INT,
    PRIMARY KEY (shipment_id, leg_number),
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id),
    FOREIGN KEY (carrier_id) REFERENCES Carriers(carrier_id)
);


CREATE TABLE Shipment_Clients (
    shipment_id INT,
    client_id INT,
    role ENUM('Sender', 'Receiver'),
    PRIMARY KEY (shipment_id, client_id, role),
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);


CREATE TABLE Shipment_Warehouses (
    shipment_id INT,
    warehouse_id INT,
    storage_start DATETIME,
    storage_end DATETIME,
    PRIMARY KEY (shipment_id, warehouse_id, storage_start),
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);


CREATE TABLE Customs_Clearance (
    clearance_id INT PRIMARY KEY,
    shipment_id INT,
    country VARCHAR(255),
    clearance_date DATE,
    status ENUM('Pending', 'Cleared', 'Held'),
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id)
);


CREATE TABLE Cross_Docking (
    operation_id INT PRIMARY KEY,
    shipment_id INT,
    from_warehouse_id INT,
    to_warehouse_id INT,
    transfer_time DATETIME,
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id),
    FOREIGN KEY (from_warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (to_warehouse_id) REFERENCES Warehouses(warehouse_id)
);

INSERT INTO Clients VALUES
(1, 'Tata Motors', 'Mumbai, Maharashtra'),
(2, 'Reliance Industries', 'Jamnagar, Gujarat'),
(3, 'Infosys Ltd', 'Bengaluru, Karnataka'),
(4, 'ITC Limited', 'Kolkata, West Bengal'),
(5, 'Bharti Airtel', 'Gurgaon, Haryana'),
(6, 'Flipkart Pvt Ltd', 'Bangalore, Karnataka'),
(7, 'Amul India', 'Anand, Gujarat');

INSERT INTO Carriers VALUES
(1, 'Indigo Cargo', 'Air', 'cargo@goindigo.in'),
(2, 'VRL Logistics', 'Land', 'contact@vrlgroup.in'),
(3, 'Blue Dart Express', 'Air', 'support@bluedart.com'),
(4, 'Gati Ltd', 'Land', 'helpdesk@gati.com'),
(5, 'Shipping Corp of India', 'Sea', 'info@shipindia.com'),
(6, 'DTDC Express', 'Land', 'customer@dtdc.com'),
(7, 'SpiceXpress', 'Air', 'info@spicexpress.com');

INSERT INTO Warehouses VALUES
(1, 'Mumbai', 1000),
(2, 'Delhi', 1500),
(3, 'Chennai', 1200),
(4, 'Hyderabad', 1100),
(5, 'Ahmedabad', 900),
(6, 'Bangalore', 1400),
(7, 'Kolkata', 1300);

INSERT INTO Employees VALUES
(1, 'Ravi Kumar', 'Loader', 1, NULL),
(2, 'Meena Shah', 'Manager', 2, NULL),
(3, 'Arjun Patel', 'Driver', NULL, 2),
(4, 'Sara Nair', 'Pilot', NULL, 1),
(5, 'Sanjay Gupta', 'Coordinator', 3, NULL),
(6, 'Nisha Verma', 'Navigator', NULL, 3),
(7, 'Karan Joshi', 'Supervisor', 6, NULL);

INSERT INTO Shipments VALUES
(1, 'Mumbai', 'Delhi', 150.75, 'Electronics items', '2025-06-01'),
(2, 'Ahmedabad', 'Kolkata', 200.50, 'Dairy products', '2025-06-03'),
(3, 'Bangalore', 'Chennai', 100.00, 'Clothing', '2025-06-05'),
(4, 'Hyderabad', 'Mumbai', 250.25, 'Machinery parts', '2025-06-06'),
(5, 'Delhi', 'Bangalore', 175.00, 'Books', '2025-06-07'),
(6, 'Kolkata', 'Hyderabad', 300.00, 'Processed food', '2025-06-08'),
(7, 'Chennai', 'Ahmedabad', 220.00, 'Plastic goods', '2025-06-09');

INSERT INTO Shipment_Carriers VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1);

INSERT INTO Shipment_Clients VALUES
(1, 1, 'Sender'), (1, 2, 'Receiver'),
(2, 5, 'Sender'), (2, 4, 'Receiver'),
(3, 6, 'Sender'), (3, 3, 'Receiver'),
(4, 2, 'Sender'), (4, 1, 'Receiver'),
(5, 3, 'Sender'), (5, 6, 'Receiver'),
(6, 4, 'Sender'), (6, 7, 'Receiver'),
(7, 5, 'Sender'), (7, 2, 'Receiver');

INSERT INTO Shipment_Warehouses VALUES
(1, 1, '2025-06-01 08:00:00', '2025-06-01 14:00:00'),
(2, 5, '2025-06-03 07:30:00', '2025-06-03 15:45:00'),
(3, 6, '2025-06-05 10:00:00', '2025-06-05 16:30:00'),
(4, 4, '2025-06-06 09:45:00', '2025-06-06 14:15:00'),
(5, 2, '2025-06-07 08:20:00', '2025-06-07 13:10:00'),
(6, 7, '2025-06-08 09:00:00', '2025-06-08 17:00:00'),
(7, 3, '2025-06-09 07:45:00', '2025-06-09 12:45:00');

INSERT INTO Customs_Clearance VALUES
(1, 1, 'India', '2025-06-01', 'Cleared'),
(2, 2, 'India', '2025-06-03', 'Cleared'),
(3, 3, 'India', '2025-06-05', 'Pending'),
(4, 4, 'India', '2025-06-06', 'Held'),
(5, 5, 'India', '2025-06-07', 'Cleared'),
(6, 6, 'India', '2025-06-08', 'Pending'),
(7, 7, 'India', '2025-06-09', 'Cleared');

INSERT INTO Cross_Docking VALUES
(1, 1, 1, 2, '2025-06-01 15:00:00'),
(2, 2, 5, 7, '2025-06-03 16:00:00'),
(3, 3, 6, 3, '2025-06-05 17:00:00'),
(4, 4, 4, 1, '2025-06-06 16:00:00'),
(5, 5, 2, 6, '2025-06-07 15:00:00'),
(6, 6, 7, 4, '2025-06-08 18:00:00'),
(7, 7, 3, 5, '2025-06-09 14:30:00');
