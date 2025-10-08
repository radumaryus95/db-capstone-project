USE littlelemondb;
DELIMITER //

DROP PROCEDURE IF EXISTS UpdateBooking//
CREATE PROCEDURE UpdateBooking(
  IN p_booking_id   BIGINT UNSIGNED,
  IN p_booking_date DATE
)
BEGIN
  UPDATE bookings
  SET booking_datetime = p_booking_date
  WHERE booking_id = p_booking_id;

  IF ROW_COUNT() = 1 THEN
    SELECT 'Booking updated' AS Confirmation;
  ELSE
    SELECT 'No booking updated (check booking_id)' AS Confirmation;
  END IF;
END//
DELIMITER ;

-- Example:
CALL UpdateBooking(9, '2022-12-17');
