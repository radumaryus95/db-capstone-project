-- 1) Make sure you’re on the right database
USE littlelemondb;
SELECT DATABASE();

-- 2) Stored procedures present?
SHOW PROCEDURE STATUS WHERE Db = 'littlelemondb';
-- Inspect definitions:
SHOW CREATE PROCEDURE GetMaxQuantity\G
SHOW CREATE PROCEDURE CancelOrder\G

-- 3) Prepared statements are NOT persisted (session-only). 
-- If you converted to a procedure, it will appear above.
-- If you created a VIEW earlier:
SHOW FULL TABLES WHERE Table_type = 'VIEW';
SHOW CREATE VIEW OrdersView\G

-- 4) Tables & data sanity
SHOW TABLES;
DESCRIBE order_items;
SELECT COUNT(*) AS rows_order_items FROM order_items;
SELECT order_id, total_amount FROM orders ORDER BY order_id LIMIT 10;

-- 5) If you added triggers for totals:
SHOW TRIGGERS FROM littlelemondb;
