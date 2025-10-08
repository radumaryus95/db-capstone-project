DELIMITER //

DROP PROCEDURE IF EXISTS AddBookingAuto//
CREATE PROCEDURE AddBookingAuto(
  IN p_customer_id  BIGINT UNSIGNED,
  IN p_table_id     INT,
  IN p_booking_date DATE
)
BEGIN
  INSERT INTO bookings (customer_id, table_id, booking_datetime, guests)
  VALUES (p_customer_id, p_table_id, p_booking_date, 2);

  IF ROW_COUNT() = 1 THEN
    SELECT 'New booking added' AS Confirmation;
  ELSE
    SELECT 'No booking added'  AS Confirmation;
  END IF;
END//
DELIMITER ;

-- call it
CALL AddBookingAuto(3, 4, '2022-12-30');
