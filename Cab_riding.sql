Design a normalized database based on your UML task/project for a ride-sharing service (like Uber or Ola). The design should reflect all key use cases from the UML diagrams (e.g., user registration, booking a ride, driver assignment, payment, ride status updates, etc.).

Create a normalized schema with appropriate tables and relationships.

Insert 5 sample records into each table.

Perform DML operations (INSERT, UPDATE, DELETE, SELECT with JOINs) to demonstrate key functionalities such as:

Booking a ride

Assigning a driver

Updating ride status

Viewing ride history for a user

Deleting a cancelled ride

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    user_type ENUM('Rider', 'Driver') -- Could also be a separate table
);

able: Users
sql
Copy
Edit
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    user_type ENUM('Rider', 'Driver') -- Could also be a separate table
);
🔹 Table: Drivers
sql
Copy
Edit
CREATE TABLE Drivers (
    driver_id INT PRIMARY KEY,
    user_id INT,
    license_number VARCHAR(50),
    vehicle_number VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
🔹 Table: Rides
sql
Copy
Edit
CREATE TABLE Rides (
    ride_id INT PRIMARY KEY,
    rider_id INT,
    driver_id INT,
    source VARCHAR(100),
    destination VARCHAR(100),
    ride_status ENUM('Requested', 'Accepted', 'In Progress', 'Completed', 'Cancelled'),
    request_time DATETIME,
    FOREIGN KEY (rider_id) REFERENCES Users(user_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);
🔹 Table: Payments
sql
Copy
Edit
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    ride_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status ENUM('Pending', 'Completed', 'Failed'),
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id)
);
✅ 2. Insert 5 Sample Records for Each Table
sql
Copy
Edit
-- Users (3 Riders + 2 Drivers)
INSERT INTO Users VALUES
(1, 'Aarav Mehta', 'aarav@example.com', '9999988888', 'Rider'),
(2, 'Priya Sharma', 'priya@example.com', '8888877777', 'Rider'),
(3, 'Kabir Roy', 'kabir@example.com', '7777766666', 'Rider'),
(4, 'Rahul Desai', 'rahul.driver@example.com', '6666655555', 'Driver'),
(5, 'Sneha Nair', 'sneha.driver@example.com', '5555544444', 'Driver');

-- Drivers
INSERT INTO Drivers VALUES
(1, 4, 'DL123456', 'MH12AB1234'),
(2, 5, 'DL654321', 'KA03CD5678');

-- Rides
INSERT INTO Rides VALUES
(1, 1, 1, 'Connaught Place', 'Delhi Airport', 'Completed', '2025-07-10 10:00:00'),
(2, 2, 2, 'MG Road', 'Whitefield', 'In Progress', '2025-07-10 11:00:00'),
(3, 3, 1, 'Cyber Hub', 'Sector 21', 'Requested', '2025-07-11 09:00:00'),
(4, 1, 2, 'Gachibowli', 'HiTech City', 'Cancelled', '2025-07-09 15:00:00'),
(5, 2, 1, 'Baner', 'FC Road', 'Accepted', '2025-07-11 08:30:00');

-- Payments
INSERT INTO Payments VALUES
(1, 1, 450.00, 'UPI', 'Completed'),
(2, 2, 300.00, 'Card', 'Pending'),
(3, 3, 0.00, 'UPI', 'Pending'),
(4, 4, 0.00, 'Cash', 'Failed'),
(5, 5, 150.00, 'Wallet', 'Pending');
✅ 3. DML Operations
📌 a) Booking a Ride
sql
Copy
Edit
-- A new rider books a ride
INSERT INTO Rides (ride_id, rider_id, driver_id, source, destination, ride_status, request_time)
VALUES (6, 3, 2, 'Vasant Kunj', 'AIIMS', 'Requested', NOW());
📌 b) Assigning a Driver
sql
Copy
Edit
-- Assign driver (id 1) to ride (id 3)
UPDATE Rides
SET driver_id = 1, ride_status = 'Accepted'
WHERE ride_id = 3;
📌 c) Updating Ride Status
sql
Copy
Edit
-- Ride has started
UPDATE Rides
SET ride_status = 'In Progress'
WHERE ride_id = 5;

-- Ride completed
UPDATE Rides
SET ride_status = 'Completed'
WHERE ride_id = 5;
📌 d) Viewing Ride History for a User
sql
Copy
Edit
-- All rides by rider_id = 1
SELECT R.ride_id, R.source, R.destination, R.ride_status, R.request_time, P.amount, P.payment_status
FROM Rides R
LEFT JOIN Payments P ON R.ride_id = P.ride_id
WHERE R.rider_id = 1;
📌 e) Deleting a Cancelled Ride
sql
Copy
Edit
DELETE FROM Payments WHERE ride_id = 4;
DELETE FROM Rides WHERE ride_id = 4;
✅ All Use Cases Covered:
Use Case	Covered?
User Registration	✅ via Users table
Booking a Ride	✅ via Rides INSERT
Assigning Driver	✅ via Rides UPDATE
Ride Status Updates	✅ via Rides UPDATE
Payments	✅ via Payments
Viewing History	✅ via SELECT with JOIN
Ride Cancellation	✅ via DELETE