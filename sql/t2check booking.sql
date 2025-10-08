DELIMITER //

DROP PROCEDURE IF EXISTS CheckBooking//
CREATE PROCEDURE CheckBooking(IN p_date DATE, IN p_table INT)
BEGIN
  DECLARE v_count INT;

  SELECT COUNT(*) INTO v_count
  FROM bookings
  WHERE DATE(booking_datetime) = p_date
    AND table_id = p_table;

  IF v_count > 0 THEN
    SELECT CONCAT('Table ', p_table, ' is already booked on ', p_date) AS `Booking status`;
  ELSE
    SELECT CONCAT('Table ', p_table, ' is available on ', p_date)      AS `Booking status`;
  END IF;
END//

DELIMITER ;

-- Try both cases (one booked, one free)
CALL CheckBooking('2022-11-12', 3);  -- booked
CALL CheckBooking('2022-12-17', 6);  -- likely free
