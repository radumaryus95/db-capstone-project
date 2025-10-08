DELIMITER //

DROP PROCEDURE IF EXISTS AddValidBooking//
CREATE PROCEDURE AddValidBooking(IN p_date DATE, IN p_table INT)
BEGIN
  DECLARE v_count INT;

  START TRANSACTION;

  SELECT COUNT(*) INTO v_count
  FROM bookings
  WHERE DATE(booking_datetime) = p_date
    AND table_id = p_table
  FOR UPDATE;

  IF v_count > 0 THEN
    ROLLBACK;
    SELECT CONCAT('Table ', p_table, ' is already booked - booking cancelled') AS `Booking status`;
  ELSE
    INSERT INTO bookings (booking_datetime, table_id, customer_id, guests)
    VALUES (p_date, p_table, 1, 2);  -- swap 1/2 for real values if you want

    COMMIT;
    SELECT CONCAT('Table ', p_table, ' successfully booked on ', p_date) AS `Booking status`;
  END IF;
END//

DELIMITER ;

-- Test both paths
CALL AddValidBooking('2022-11-12', 3);  -- should ROLLBACK (already booked)
CALL AddValidBooking('2022-12-17', 6);  -- should COMMIT (new booking)

-- Verify
SELECT booking_id, booking_datetime, table_id, customer_id, guests
FROM bookings
ORDER BY booking_datetime, table_id;
