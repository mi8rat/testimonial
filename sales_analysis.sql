-- Simple Data Analysis with PostgreSQL
-- Sales Data Analysis Example

-- Create a sales database
CREATE DATABASE IF NOT EXISTS sales_db;

-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create sales table
CREATE TABLE IF NOT EXISTS sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER,
    sale_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Insert sample customers
INSERT INTO customers (customer_name, email, city, signup_date) VALUES
('John Smith', 'john@email.com', 'New York', '2024-01-15'),
('Emma Johnson', 'emma@email.com', 'Los Angeles', '2024-02-20'),
('Michael Brown', 'michael@email.com', 'Chicago', '2024-01-10'),
('Sarah Davis', 'sarah@email.com', 'New York', '2024-03-05'),
('David Wilson', 'david@email.com', 'Houston', '2024-02-15'),
('Lisa Anderson', 'lisa@email.com', 'Chicago', '2024-01-25'),
('James Taylor', 'james@email.com', 'Phoenix', '2024-04-01'),
('Maria Garcia', 'maria@email.com', 'Los Angeles', '2024-03-10');

-- Insert sample products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 999.99),
('Smartphone', 'Electronics', 699.99),
('Headphones', 'Electronics', 149.99),
('Desk Chair', 'Furniture', 299.99),
('Standing Desk', 'Furniture', 499.99),
('Coffee Maker', 'Appliances', 89.99),
('Blender', 'Appliances', 59.99),
('Monitor', 'Electronics', 349.99);

-- Insert sample sales
INSERT INTO sales (customer_id, product_id, quantity, sale_date, total_amount) VALUES
(1, 1, 1, '2024-01-20', 999.99),
(1, 3, 2, '2024-01-20', 299.98),
(2, 2, 1, '2024-02-25', 699.99),
(3, 4, 1, '2024-02-15', 299.99),
(3, 5, 1, '2024-02-15', 499.99),
(4, 1, 1, '2024-03-10', 999.99),
(4, 8, 1, '2024-03-10', 349.99),
(5, 6, 2, '2024-03-01', 179.98),
(6, 7, 1, '2024-02-28', 59.99),
(6, 3, 1, '2024-02-28', 149.99),
(7, 2, 1, '2024-04-05', 699.99),
(8, 5, 1, '2024-03-15', 499.99),
(1, 6, 1, '2024-04-10', 89.99),
(2, 8, 2, '2024-04-12', 699.98);

-- ============================================
-- DATA ANALYSIS QUERIES
-- ============================================

-- 1. Total Revenue by Product Category
SELECT 
    p.category,
    COUNT(s.sale_id) AS total_sales,
    SUM(s.quantity) AS total_quantity,
    SUM(s.total_amount) AS total_revenue,
    ROUND(AVG(s.total_amount), 2) AS avg_sale_value
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 2. Top 5 Customers by Revenue
SELECT 
    c.customer_name,
    c.city,
    COUNT(s.sale_id) AS number_of_purchases,
    SUM(s.total_amount) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 5;

-- 3. Monthly Sales Trend
SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS month,
    COUNT(sale_id) AS number_of_sales,
    SUM(total_amount) AS monthly_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY month;

-- 4. Best Selling Products
SELECT 
    p.product_name,
    p.category,
    p.price,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.total_amount) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price
ORDER BY total_units_sold DESC;

-- 5. Sales by City
SELECT 
    c.city,
    COUNT(DISTINCT c.customer_id) AS number_of_customers,
    COUNT(s.sale_id) AS number_of_sales,
    SUM(s.total_amount) AS total_revenue
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- 6. Customer Purchase Frequency
SELECT 
    c.customer_name,
    c.city,
    COUNT(s.sale_id) AS purchase_count,
    MIN(s.sale_date) AS first_purchase,
    MAX(s.sale_date) AS last_purchase,
    SUM(s.total_amount) AS lifetime_value
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY purchase_count DESC;

-- 7. Product Category Performance Summary
SELECT 
    category,
    COUNT(DISTINCT product_id) AS number_of_products,
    ROUND(AVG(price), 2) AS avg_product_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products
GROUP BY category
ORDER BY avg_product_price DESC;

-- 8. Revenue Per Customer Segment (by city)
WITH city_stats AS (
    SELECT 
        c.city,
        SUM(s.total_amount) AS total_revenue,
        COUNT(DISTINCT c.customer_id) AS customer_count
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.city
)
SELECT 
    city,
    total_revenue,
    customer_count,
    ROUND(total_revenue / customer_count, 2) AS revenue_per_customer
FROM city_stats
ORDER BY revenue_per_customer DESC;
