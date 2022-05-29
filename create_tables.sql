CREATE SCHEMA IF NOT EXISTS CustomerOrders;
SET search_path TO CustomerOrders;


CREATE TABLE IF NOT EXISTS departments (
  department_id INT NOT NULL,
  department_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (department_id)
);


CREATE TABLE IF NOT EXISTS categories (
  category_id INT NOT NULL,
  category_department_id INT NOT NULL,
  category_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (category_id),
  FOREIGN KEY (category_department_id) REFERENCES departments(department_id)
); 



CREATE TABLE IF NOT EXISTS products (
  product_id INT NOT NULL,
  product_category_id INT NOT NULL,
  product_name VARCHAR(45) NOT NULL,
  product_description VARCHAR(255) NOT NULL,
  product_price FLOAT NOT NULL,
  product_image VARCHAR(255) NOT NULL,
  PRIMARY KEY (product_id),
  FOREIGN KEY (product_category_id) REFERENCES categories(category_id)
);


CREATE TABLE IF NOT EXISTS customers (
  customer_id INT NOT NULL,
  customer_fname VARCHAR(45) NOT NULL,
  customer_lname VARCHAR(45) NOT NULL,
  customer_email VARCHAR(45) NOT NULL,
  customer_password VARCHAR(45) NOT NULL,
  customer_street VARCHAR(255) NOT NULL,
  customer_city VARCHAR(45) NOT NULL,
  customer_state VARCHAR(45) NOT NULL,
  customer_zipcode VARCHAR(45) NOT NULL,
  PRIMARY KEY (customer_id)
); 


CREATE INDEX IF NOT EXISTS idx_customers
ON customers (customer_city,customer_state);


CREATE TABLE IF NOT EXISTS orders (
  order_id INT NOT NULL,
  order_date TIMESTAMP NOT NULL,
  order_customer_id INT NOT NULL,
  order_status VARCHAR(45) NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_customer_id) REFERENCES customers(customer_id)
);

CREATE INDEX IF NOT EXISTS idx_orders
ON orders (order_customer_id);

CREATE TABLE IF NOT EXISTS order_items (
  order_item_id INT NOT NULL,
  order_item_order_id INT NOT NULL,
  order_item_product_id INT NOT NULL,
  order_item_quantity INT NOT NULL,
  order_item_subtotal FLOAT NOT NULL,
  order_item_product_price FLOAT NOT NULL,
  PRIMARY KEY (order_item_product_id,order_item_id),
  FOREIGN KEY (order_item_order_id) REFERENCES orders(order_id),
  FOREIGN KEY (order_item_product_id) REFERENCES products(product_id)	
);
