-- ========================================
-- FULL SQL FILE FOR MOVIE TICKET BOOKING SYSTEM WITH INSERTS + DML
-- ========================================

-- USERS TABLE
CREATE TABLE Users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(15),
  password VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- THEATERS TABLE
CREATE TABLE Theaters (
  theater_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  location VARCHAR(100)
);

-- SCREENS TABLE
CREATE TABLE Screens (
  screen_id INT AUTO_INCREMENT PRIMARY KEY,
  theater_id INT,
  screen_name VARCHAR(50),
  total_seats INT,
  FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id)
);

-- MOVIES TABLE
CREATE TABLE Movies (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  genre VARCHAR(50),
  duration_minutes INT,
  rating DECIMAL(2,1),
  release_date DATE
);

-- SHOWS TABLE
CREATE TABLE Shows (
  show_id INT AUTO_INCREMENT PRIMARY KEY,
  screen_id INT,
  movie_id INT,
  show_time DATETIME,
  price DECIMAL(8,2),
  FOREIGN KEY (screen_id) REFERENCES Screens(screen_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- BOOKINGS TABLE
CREATE TABLE Bookings (
  booking_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  show_id INT,
  booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(10,2),
  status VARCHAR(20),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

-- SEATS TABLE
CREATE TABLE Seats (
  seat_id INT AUTO_INCREMENT PRIMARY KEY,
  screen_id INT,
  seat_number VARCHAR(10),
  seat_type VARCHAR(50),
  FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);

-- BOOKED_SEATS TABLE
CREATE TABLE Booked_Seats (
  booked_seat_id INT AUTO_INCREMENT PRIMARY KEY,
  booking_id INT,
  seat_id INT,
  FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
  FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);

-- PAYMENTS TABLE
CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  booking_id INT,
  payment_mode VARCHAR(50),
  payment_date DATETIME,
  amount DECIMAL(10,2),
  status VARCHAR(20),
  FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- ========================================
-- SAMPLE INSERTS AND DML OPERATIONS
-- ========================================

-- USERS
INSERT INTO Users (name, email, phone, password) VALUES
('John Doe', 'john@example.com', '9876543210', 'pass123'),
('Jane Smith', 'jane@example.com', '8765432109', 'pass456'),
('Sam Wilson', 'sam@example.com', '7654321098', 'pass789'),
('Emma Watson', 'emma@example.com', '6543210987', 'pass321'),
('Chris Evans', 'chris@example.com', '5432109876', 'pass654');

-- THEATERS
INSERT INTO Theaters (name, location) VALUES
('PVR Cinemas', 'Delhi'),
('INOX', 'Mumbai'),
('Cinepolis', 'Bangalore'),
('Carnival', 'Chennai'),
('Miraj', 'Hyderabad');

-- SCREENS
INSERT INTO Screens (theater_id, screen_name, total_seats) VALUES
(1, 'Screen 1', 100),
(2, 'Screen A', 120),
(3, 'Screen X', 90),
(4, 'Screen 4', 150),
(5, 'Screen M', 80);

-- MOVIES
INSERT INTO Movies (title, genre, duration_minutes, rating, release_date) VALUES
('Avengers', 'Action', 180, 8.5, '2022-07-01'),
('Inception', 'Sci-Fi', 150, 9.0, '2022-06-15'),
('Frozen 2', 'Animation', 120, 7.8, '2022-05-20'),
('Dune', 'Adventure', 155, 8.2, '2022-08-10'),
('Joker', 'Drama', 122, 8.7, '2022-04-01');

-- SHOWS
INSERT INTO Shows (screen_id, movie_id, show_time, price) VALUES
(1, 1, '2025-07-08 10:00:00', 250),
(2, 2, '2025-07-08 13:00:00', 300),
(3, 3, '2025-07-08 15:00:00', 200),
(4, 4, '2025-07-08 18:00:00', 350),
(5, 5, '2025-07-08 21:00:00', 280);

-- SEATS
INSERT INTO Seats (screen_id, seat_number, seat_type) VALUES
(1, 'A1', 'Regular'),
(1, 'A2', 'Regular'),
(1, 'B1', 'Premium'),
(2, 'C1', 'Regular'),
(2, 'C2', 'Premium');

-- BOOKINGS
INSERT INTO Bookings (user_id, show_id, total_amount, status) VALUES
(1, 1, 500, 'Confirmed'),
(2, 2, 600, 'Confirmed'),
(3, 3, 400, 'Cancelled'),
(4, 4, 700, 'Confirmed'),
(5, 5, 560, 'Confirmed');

-- BOOKED_SEATS
INSERT INTO Booked_Seats (booking_id, seat_id) VALUES
(1, 1),
(1, 2),
(2, 4),
(3, 3),
(4, 5);

-- PAYMENTS
INSERT INTO Payments (booking_id, payment_mode, payment_date, amount, status) VALUES
(1, 'UPI', '2025-07-07', 500, 'Success'),
(2, 'Credit Card', '2025-07-07', 600, 'Success'),
(3, 'Wallet', '2025-07-07', 400, 'Refunded'),
(4, 'Net Banking', '2025-07-07', 700, 'Success'),
(5, 'UPI', '2025-07-07', 560, 'Success');

-- ========================================
-- SAMPLE DML OPERATIONS
-- ========================================

-- UPDATE
UPDATE Bookings SET status = 'Cancelled' WHERE booking_id = 5;

-- DELETE
DELETE FROM Booked_Seats WHERE booking_id = 3;

-- SELECT
SELECT * FROM Shows WHERE show_time > NOW();
SELECT u.name, m.title, b.status FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id;

-- INSERT
INSERT INTO Theaters (name, location) VALUES ('Wave Cinemas', 'Noida');

-- END OF FILE
