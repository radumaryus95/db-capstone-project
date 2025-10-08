USE littlelemondb;

-- If needed, ensure parent rows exist (adjust table names if yours differ)
INSERT INTO customers (first_name,last_name,email,phone)
VALUES ('Anna','A','a@ex.com','1'),('Ben','B','b@ex.com','2'),('Cara','C','c@ex.com','3')
ON DUPLICATE KEY UPDATE email=VALUES(email);

INSERT INTO restaurant_tables (table_id,seats,location)
VALUES (2,4,'Dining'),(3,4,'Dining'),(5,4,'Patio')
ON DUPLICATE KEY UPDATE seats=VALUES(seats),location=VALUES(location);

-- ✅ Correct INSERT (includes guests and properly quoted dates)
INSERT INTO bookings (`booking_datetime`, `table_id`, `customer_id`, `guests`)
VALUES
('2022-10-10', 5, 1, 2),
('2022-11-12', 3, 3, 2),
('2022-10-11', 2, 2, 2),
('2022-10-13', 2, 1, 2);

-- Check
SELECT booking_id, booking_datetime, table_id, customer_id, guests
FROM bookings
ORDER BY booking_datetime, table_id;
