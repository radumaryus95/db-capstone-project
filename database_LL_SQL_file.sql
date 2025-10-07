CREATE DATABASE IF NOT EXISTS LittleLemonDB;
USE LittleLemonDB;

CREATE TABLE customers (
  customer_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name  VARCHAR(100) NOT NULL,
  email      VARCHAR(255) UNIQUE,
  phone      VARCHAR(25),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE staff (
  staff_id   BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name  VARCHAR(100) NOT NULL,
  role       VARCHAR(80)  NOT NULL,
  salary     DECIMAL(10,2) NOT NULL,
  hire_date  DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE restaurant_tables (
  table_id INT UNSIGNED PRIMARY KEY,
  seats    TINYINT UNSIGNED NOT NULL,
  location VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE bookings (
  booking_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  customer_id BIGINT UNSIGNED NOT NULL,
  table_id INT UNSIGNED NOT NULL,
  booking_datetime DATETIME NOT NULL,
  guests TINYINT UNSIGNED NOT NULL,
  notes VARCHAR(255),
  CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_table FOREIGN KEY (table_id)
    REFERENCES restaurant_tables(table_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE cuisines (
  cuisine_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE menu_categories (
  category_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE menu_items (
  menu_item_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  description TEXT,
  price DECIMAL(8,2) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  cuisine_id INT UNSIGNED,
  category_id INT UNSIGNED,
  CONSTRAINT fk_menu_cuisine FOREIGN KEY (cuisine_id)
    REFERENCES cuisines(cuisine_id) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_menu_category FOREIGN KEY (category_id)
    REFERENCES menu_categories(category_id) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  order_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  customer_id BIGINT UNSIGNED NOT NULL,
  staff_id BIGINT UNSIGNED,
  booking_id BIGINT UNSIGNED NULL,
  order_type ENUM('DINE_IN','TAKEAWAY','DELIVERY') NOT NULL,
  status ENUM('NEW','IN_PROGRESS','COMPLETED','CANCELLED') NOT NULL DEFAULT 'NEW',
  total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  CONSTRAINT fk_order_customer FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_order_staff FOREIGN KEY (staff_id)
    REFERENCES staff(staff_id) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_order_booking FOREIGN KEY (booking_id)
    REFERENCES bookings(booking_id) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_item_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT UNSIGNED NOT NULL,
  menu_item_id BIGINT UNSIGNED NOT NULL,
  quantity INT UNSIGNED NOT NULL DEFAULT 1,
  unit_price DECIMAL(8,2) NOT NULL,
  CONSTRAINT fk_oi_order FOREIGN KEY (order_id)
    REFERENCES orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_oi_menu FOREIGN KEY (menu_item_id)
    REFERENCES menu_items(menu_item_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE deliveries (
  delivery_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT UNSIGNED NOT NULL UNIQUE,
  delivery_address VARCHAR(255),
  delivery_datetime DATETIME NULL,
  status ENUM('PENDING','DISPATCHED','DELIVERED','FAILED') NOT NULL DEFAULT 'PENDING',
  CONSTRAINT fk_delivery_order FOREIGN KEY (order_id)
    REFERENCES orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- helpful indexes
CREATE INDEX idx_bookings_customer ON bookings(customer_id, booking_datetime);
CREATE INDEX idx_orders_customer ON orders(customer_id, order_datetime);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_menu_name ON menu_items(name);
