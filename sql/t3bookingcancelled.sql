USE littlelemondb;
DELIMITER //

DROP PROCEDURE IF EXISTS CancelBooking//
CREATE PROCEDURE CancelBooking(
  IN p_booking_id BIGINT UNSIGNED
)
BEGIN
  DELETE FROM bookings
  WHERE booking_id = p_booking_id;

  IF ROW_COUNT() = 1 THEN
    SELECT CONCAT('Booking ', p_booking_id, ' cancelled') AS Confirmation;
  ELSE
    SELECT CONCAT('Booking ', p_booking_id, ' not found') AS Confirmation;
  END IF;
END//
DELIMITER ;

-- Example:
CALL CancelBooking(9);
