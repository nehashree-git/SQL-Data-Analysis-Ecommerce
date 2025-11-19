create database ecommerce;
use ecommerce;
--------------- Customers -------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);
--------------- Products -------------
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

--------------- Orders --------------
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
------------- Customer data ------------
INSERT INTO customers VALUES
(1,'Aarav','Mumbai','Maharashtra'),
(2,'Sneha','Pune','Maharashtra'),
(3,'Rahul','Bangalore','Karnataka'),
(4,'Priya','Chennai','Tamil Nadu'),
(5,'Kiran','Hyderabad','Telangana');
SELECT * FROM customers;
------------ Products data -------------
INSERT INTO products VALUES
(101,'Laptop','Electronics',55000),
(102,'Headphones','Electronics',2000),
(103,'Shoes','Fashion',3000),
(104,'T-Shirt','Fashion',800),
(105,'Washing Machine','Home Appliances',23000);
SELECT * FROM products;
----------- Orders data -----------------
INSERT INTO orders VALUES
(1001,1,101,'2025-01-12',1),
(1002,2,103,'2025-01-15',2),
(1003,3,104,'2025-01-18',3),
(1004,1,102,'2025-01-20',1),
(1005,4,105,'2025-01-25',1);
SELECT * FROM orders;
--------- Get all orders from January 2025 ---------
SELECT *
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31'
ORDER BY order_date;
----- List all orders with customer & product details(INNER JOIN) ------
SELECT o.order_id, c.customer_name, p.product_name, o.quantity, p.price
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id;
----- Aggregate Functions (SUM, AVG) Total revenue ------
SELECT SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;
-------- Average order quantity --------
SELECT AVG(quantity) AS avg_quantity
FROM orders;
-------- (GROUP BY )Revenue by category --------
SELECT p.category, SUM(p.price * o.quantity) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;
------ Subquery ,Customers who spent more than ₹50,000 ----------
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY customer_id
    HAVING SUM(p.price * o.quantity) > 50000
);
-------- Create a View ---------
CREATE VIEW sales_summary AS
SELECT o.order_id, c.customer_name, p.product_name, 
       p.category, o.quantity, p.price,
       (p.price * o.quantity) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;
----- Check data: ------
SELECT * FROM sales_summary;
---------- Create Index to Improve Performance ----------
CREATE INDEX idx_customer ON orders(customer_id);
CREATE INDEX idx_product ON orders(product_id);

SELECT * FROM sales_summary;











