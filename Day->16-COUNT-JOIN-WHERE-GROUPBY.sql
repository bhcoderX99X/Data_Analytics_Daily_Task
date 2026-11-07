DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    payment_method VARCHAR(30),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1,'Aman','Male','Delhi','2025-01-10'),
(2,'Priya','Female','Lucknow','2025-02-12'),
(3,'Rohit','Male','Noida','2025-03-15'),
(4,'Neha','Female','Delhi','2025-04-18'),
(5,'Arjun','Male','Bareilly','2025-05-20'),
(6,'Simran','Female','Lucknow','2025-06-05'),
(7,'Karan','Male','Noida','2025-06-15'),
(8,'Riya','Female','Delhi','2025-07-01');

INSERT INTO products VALUES
(101,'Laptop','Electronics',65000,52000),
(102,'Mouse','Electronics',1200,700),
(103,'Keyboard','Electronics',2200,1300),
(104,'Headphones','Electronics',3500,2200),
(105,'Office Chair','Furniture',9000,6000),
(106,'Desk','Furniture',12000,8000),
(107,'Backpack','Accessories',1800,1000),
(108,'Monitor','Electronics',18000,13000);

INSERT INTO orders VALUES
(1001,1,'2025-07-01','UPI','Completed'),
(1002,2,'2025-07-03','Card','Completed'),
(1003,3,'2025-07-05','UPI','Completed'),
(1004,1,'2025-07-10','Card','Completed'),
(1005,4,'2025-07-15','COD','Cancelled'),
(1006,5,'2025-08-01','UPI','Completed'),
(1007,6,'2025-08-05','Card','Completed'),
(1008,7,'2025-08-10','UPI','Completed'),
(1009,1,'2025-08-15','Card','Completed'),
(1010,8,'2025-08-20','COD','Completed');

INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1001,102,2),
(3,1002,104,1),
(4,1002,107,2),
(5,1003,105,1),
(6,1004,108,1),
(7,1004,103,1),
(8,1005,106,1),
(9,1006,101,1),
(10,1007,102,3),
(11,1008,105,1),
(12,1009,104,2),
(13,1010,107,1);


-- Basic KPIs
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi JOIN products p ON oi.product_id=p.product_id
JOIN orders o ON oi.order_id=o.order_id
WHERE o.status='Completed';

SELECT AVG(order_value) AS average_order_value
FROM (
    SELECT o.order_id, SUM(oi.quantity*p.price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id=oi.order_id
    JOIN products p ON oi.product_id=p.product_id
    WHERE o.status='Completed'
    GROUP BY o.order_id
);






SELECT AVG(order_value) AS average_order_value
FROM (
    SELECT o.order_id, SUM(oi.quantity*p.price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id=oi.order_id
    JOIN products p ON oi.product_id=p.product_id
    WHERE o.status='Completed'
    GROUP BY o.order_id
) x;

-- Top customers by spending
SELECT c.customer_id,c.customer_name,
       SUM(oi.quantity*p.price) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
WHERE o.status='Completed'
GROUP BY c.customer_id,c.customer_name
ORDER BY total_spending DESC;

-- Category revenue
SELECT p.category,
       SUM(oi.quantity*p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
JOIN orders o ON oi.order_id=o.order_id
WHERE o.status='Completed'
GROUP BY p.category
ORDER BY revenue DESC;

-- Product performance
SELECT p.product_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity*p.price) AS revenue,
       SUM(oi.quantity*(p.price-p.cost)) AS profit
FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
JOIN orders o ON oi.order_id=o.order_id
WHERE o.status='Completed'
GROUP BY p.product_id,p.product_name
ORDER BY revenue DESC;

-- Monthly revenue
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       SUM(oi.quantity*p.price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
WHERE o.status='Completed'
GROUP BY month
ORDER BY month;

-- Customers with no orders
SELECT c.customer_id,c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;

-- Products never sold
SELECT p.product_id,p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id=oi.product_id
WHERE oi.product_id IS NULL;

-- Orders greater than 5000
SELECT o.order_id,o.customer_id,
       SUM(oi.quantity*p.price) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
WHERE o.status='Completed'
GROUP BY o.order_id,o.customer_id
HAVING order_value > 5000;

-- Repeat customers
SELECT c.customer_id,c.customer_name,COUNT(o.order_id) AS orders_count
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
WHERE o.status='Completed'
GROUP BY c.customer_id,c.customer_name
HAVING COUNT(o.order_id)>1;
