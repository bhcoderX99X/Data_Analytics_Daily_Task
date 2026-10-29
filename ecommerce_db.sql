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


Select*from customers;

Select*from products;

Select*from orders;

Select*from order_items;