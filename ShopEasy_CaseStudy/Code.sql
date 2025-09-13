-- ================================================
-- CASE STUDY: "ShopEasy" E-Commerce Database
-- ================================================
-- 
-- BUSINESS SCENARIO:
-- ShopEasy is a small online retail business that sells electronics and accessories.
-- They need a database to track customers, products, orders, and employee performance.
-- The company wants to analyze sales patterns, customer behavior, and inventory levels.


-- ================================================
-- STEP 1: CREATE DATABASE
-- ================================================

create database casestudy1;
use casestudy1;

-- ================================================
-- STEP 1: CREATE TABLES
-- ================================================

-- Table 1: Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    registration_date DATE,
    customer_type VARCHAR(20) -- 'Regular', 'Premium', 'VIP'
);

-- Table 2: Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    description VARCHAR(200)
);

-- Table 3: Products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    supplier VARCHAR(100),
    added_date DATE,
    is_active BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Table 4: Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(50), -- 'Sales', 'Support', 'Management'
    salary DECIMAL(10, 2)
);

-- Table 5: Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20), -- 'Pending', 'Shipped', 'Delivered', 'Cancelled'
    payment_method VARCHAR(20), -- 'Credit Card', 'Debit Card', 'PayPal', 'Cash'
    shipping_city VARCHAR(50),
    shipping_state VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Table 6: Order_Items (for order details)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    discount_percent DECIMAL(5, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Table 7: Reviews
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT, -- 1 to 5
    review_text VARCHAR(500),
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ================================================
-- STEP 2: INSERT SAMPLE DATA
-- ================================================

-- Insert Categories
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Laptops', 'Portable computers and notebooks'),
(2, 'Smartphones', 'Mobile phones and accessories'),
(3, 'Headphones', 'Audio devices and earphones'),
(4, 'Tablets', 'Tablet computers and e-readers'),
(5, 'Smartwatches', 'Wearable technology'),
(6, 'Cameras', 'Digital cameras and accessories');

-- Insert Customers (20 customers)
INSERT INTO customers (customer_id, first_name, last_name, email, phone, city, state, registration_date, customer_type) VALUES
(1, 'Rahul', 'Sharma', 'rahul.sharma@email.com', '9876543210', 'Mumbai', 'Maharashtra', '2023-01-15', 'Regular'),
(2, 'Priya', 'Patel', 'priya.patel@email.com', '9876543211', 'Ahmedabad', 'Gujarat', '2023-01-20', 'Premium'),
(3, 'Amit', 'Kumar', 'amit.kumar@email.com', '9876543212', 'Delhi', 'Delhi', '2023-02-10', 'Regular'),
(4, 'Sneha', 'Verma', 'sneha.verma@email.com', '9876543213', 'Bangalore', 'Karnataka', '2023-02-15', 'VIP'),
(5, 'Arun', 'Singh', 'arun.singh@email.com', '9876543214', 'Chennai', 'Tamil Nadu', '2023-03-01', 'Premium'),
(6, 'Pooja', 'Reddy', 'pooja.reddy@email.com', '9876543215', 'Hyderabad', 'Telangana', '2023-03-10', 'Regular'),
(7, 'Vijay', 'Nair', 'vijay.nair@email.com', '9876543216', 'Kochi', 'Kerala', '2023-03-15', 'Regular'),
(8, 'Anjali', 'Gupta', 'anjali.gupta@email.com', '9876543217', 'Pune', 'Maharashtra', '2023-04-01', 'Premium'),
(9, 'Rohit', 'Mehta', 'rohit.mehta@email.com', '9876543218', 'Jaipur', 'Rajasthan', '2023-04-10', 'VIP'),
(10, 'Neha', 'Shah', 'neha.shah@email.com', '9876543219', 'Surat', 'Gujarat', '2023-04-20', 'Regular'),
(11, 'Karan', 'Joshi', 'karan.joshi@email.com', '9876543220', 'Mumbai', 'Maharashtra', '2023-05-01', 'Premium'),
(12, 'Deepa', 'Rao', 'deepa.rao@email.com', '9876543221', 'Bangalore', 'Karnataka', '2023-05-15', 'Regular'),
(13, 'Suresh', 'Iyer', 'suresh.iyer@email.com', '9876543222', 'Chennai', 'Tamil Nadu', '2023-06-01', 'VIP'),
(14, 'Kavita', 'Pillai', 'kavita.pillai@email.com', '9876543223', 'Kochi', 'Kerala', '2023-06-10', 'Regular'),
(15, 'Manish', 'Agarwal', 'manish.agarwal@email.com', '9876543224', 'Kolkata', 'West Bengal', '2023-07-01', 'Premium'),
(16, 'Rashmi', 'Desai', 'rashmi.desai@email.com', '9876543225', 'Mumbai', 'Maharashtra', '2023-07-15', 'Regular'),
(17, 'Arjun', 'Kapoor', 'arjun.kapoor@email.com', '9876543226', 'Delhi', 'Delhi', '2023-08-01', 'VIP'),
(18, 'Meera', 'Saxena', 'meera.saxena@email.com', '9876543227', 'Lucknow', 'Uttar Pradesh', '2023-08-10', 'Regular'),
(19, 'Varun', 'Malhotra', 'varun.malhotra@email.com', '9876543228', 'Chandigarh', 'Punjab', '2023-09-01', 'Premium'),
(20, 'Simran', 'Kaur', 'simran.kaur@email.com', '9876543229', 'Amritsar', 'Punjab', '2023-09-15', 'Regular'),
(21, 'Ichha', 'Hims', 'himas.lich@email.com', '9821231232', 'Amritsar', 'Punjab', '2002-09-15', 'Regular');

-- Insert Products (25 products)
INSERT INTO products (product_id, product_name, category_id, price, stock_quantity, supplier, added_date, is_active) VALUES
(1, 'Dell Inspiron 15', 1, 45000.00, 15, 'Dell India', '2023-01-01', TRUE),
(2, 'HP Pavilion 14', 1, 52000.00, 10, 'HP Store', '2023-01-05', TRUE),
(3, 'MacBook Air M1', 1, 92000.00, 8, 'Apple India', '2023-01-10', TRUE),
(4, 'iPhone 13', 2, 65000.00, 25, 'Apple India', '2023-01-15', TRUE),
(5, 'Samsung Galaxy S22', 2, 55000.00, 20, 'Samsung Store', '2023-01-20', TRUE),
(6, 'OnePlus 11', 2, 45000.00, 18, 'OnePlus India', '2023-02-01', TRUE),
(7, 'Sony WH-1000XM4', 3, 25000.00, 30, 'Sony India', '2023-02-10', TRUE),
(8, 'AirPods Pro', 3, 22000.00, 25, 'Apple India', '2023-02-15', TRUE),
(9, 'JBL Tune 760NC', 3, 5500.00, 40, 'JBL Store', '2023-02-20', TRUE),
(10, 'iPad Air', 4, 55000.00, 12, 'Apple India', '2023-03-01', TRUE),
(11, 'Samsung Galaxy Tab S8', 4, 48000.00, 10, 'Samsung Store', '2023-03-10', TRUE),
(12, 'Apple Watch Series 8', 5, 42000.00, 15, 'Apple India', '2023-03-15', TRUE),
(13, 'Samsung Galaxy Watch 5', 5, 28000.00, 20, 'Samsung Store', '2023-03-20', TRUE),
(14, 'Canon EOS R50', 6, 65000.00, 5, 'Canon India', '2023-04-01', TRUE),
(15, 'Sony Alpha 7 III', 6, 135000.00, 3, 'Sony India', '2023-04-10', TRUE),
(16, 'Lenovo ThinkPad', 1, 75000.00, 7, 'Lenovo Store', '2023-04-15', TRUE),
(17, 'Xiaomi Redmi Note 12', 2, 18000.00, 35, 'Xiaomi India', '2023-05-01', TRUE),
(18, 'Realme 11 Pro', 2, 25000.00, 28, 'Realme Store', '2023-05-10', TRUE),
(19, 'Boat Rockerz 450', 3, 1500.00, 50, 'Boat Lifestyle', '2023-05-15', TRUE),
(20, 'Kindle Paperwhite', 4, 14000.00, 15, 'Amazon Devices', '2023-06-01', TRUE),
(21, 'Fitbit Charge 5', 5, 12000.00, 18, 'Fitbit Store', '2023-06-10', TRUE),
(22, 'GoPro Hero 11', 6, 45000.00, 8, 'GoPro India', '2023-06-15', TRUE),
(23, 'Asus ROG Gaming Laptop', 1, 125000.00, 4, 'Asus Store', '2023-07-01', TRUE),
(24, 'Nothing Phone 2', 2, 38000.00, 0, 'Nothing Store', '2023-07-10', FALSE),
(25, 'Mi Band 7', 5, 3500.00, 45, 'Xiaomi India', '2023-07-15', TRUE);

-- Insert Employees (8 employees)
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, department, salary) VALUES
(1, 'Rajesh', 'Kumar', 'rajesh.k@shopeasy.com', '2022-01-15', 'Sales', 45000.00),
(2, 'Sunita', 'Sharma', 'sunita.s@shopeasy.com', '2022-03-01', 'Sales', 42000.00),
(3, 'Vikram', 'Singh', 'vikram.s@shopeasy.com', '2022-05-10', 'Support', 38000.00),
(4, 'Anita', 'Desai', 'anita.d@shopeasy.com', '2022-07-01', 'Management', 65000.00),
(5, 'Pranav', 'Joshi', 'pranav.j@shopeasy.com', '2022-09-15', 'Sales', 40000.00),
(6, 'Divya', 'Nair', 'divya.n@shopeasy.com', '2023-01-10', 'Support', 35000.00),
(7, 'Aakash', 'Mehta', 'aakash.m@shopeasy.com', '2023-03-20', 'Sales', 43000.00),
(8, 'Rekha', 'Patel', 'rekha.p@shopeasy.com', '2023-06-01', 'Support', 36000.00);

-- Insert Orders (30 orders)
INSERT INTO orders (order_id, customer_id, employee_id, order_date, total_amount, status, payment_method, shipping_city, shipping_state) VALUES
(1, 1, 1, '2023-10-01', 45000.00, 'Delivered', 'Credit Card', 'Mumbai', 'Maharashtra'),
(2, 2, 2, '2023-10-02', 65000.00, 'Delivered', 'Debit Card', 'Ahmedabad', 'Gujarat'),
(3, 3, 1, '2023-10-03', 25000.00, 'Delivered', 'PayPal', 'Delhi', 'Delhi'),
(4, 4, 5, '2023-10-05', 92000.00, 'Delivered', 'Credit Card', 'Bangalore', 'Karnataka'),
(5, 5, 7, '2023-10-07', 55000.00, 'Shipped', 'Debit Card', 'Chennai', 'Tamil Nadu'),
(6, 6, 2, '2023-10-08', 22000.00, 'Delivered', 'Cash', 'Hyderabad', 'Telangana'),
(7, 7, 1, '2023-10-10', 5500.00, 'Delivered', 'PayPal', 'Kochi', 'Kerala'),
(8, 8, 5, '2023-10-12', 48000.00, 'Delivered', 'Credit Card', 'Pune', 'Maharashtra'),
(9, 9, 7, '2023-10-14', 135000.00, 'Shipped', 'Credit Card', 'Jaipur', 'Rajasthan'),
(10, 10, 2, '2023-10-15', 18000.00, 'Delivered', 'Debit Card', 'Surat', 'Gujarat'),
(11, 11, 1, '2023-10-17', 42000.00, 'Delivered', 'Credit Card', 'Mumbai', 'Maharashtra'),
(12, 12, 5, '2023-10-18', 28000.00, 'Pending', 'PayPal', 'Bangalore', 'Karnataka'),
(13, 13, 7, '2023-10-20', 75000.00, 'Delivered', 'Credit Card', 'Chennai', 'Tamil Nadu'),
(14, 14, 2, '2023-10-22', 1500.00, 'Delivered', 'Cash', 'Kochi', 'Kerala'),
(15, 15, 1, '2023-10-24', 14000.00, 'Shipped', 'Debit Card', 'Kolkata', 'West Bengal'),
(16, 1, 5, '2023-10-25', 52000.00, 'Delivered', 'Credit Card', 'Mumbai', 'Maharashtra'),
(17, 2, 7, '2023-10-26', 45000.00, 'Delivered', 'PayPal', 'Ahmedabad', 'Gujarat'),
(18, 3, 2, '2023-10-27', 25000.00, 'Cancelled', 'Credit Card', 'Delhi', 'Delhi'),
(19, 4, 1, '2023-10-28', 55000.00, 'Delivered', 'Debit Card', 'Bangalore', 'Karnataka'),
(20, 5, 5, '2023-10-29', 12000.00, 'Delivered', 'Cash', 'Chennai', 'Tamil Nadu'),
(21, 16, 7, '2023-10-30', 125000.00, 'Pending', 'Credit Card', 'Mumbai', 'Maharashtra'),
(22, 17, 2, '2023-11-01', 38000.00, 'Shipped', 'PayPal', 'Delhi', 'Delhi'),
(23, 18, 1, '2023-11-02', 3500.00, 'Delivered', 'Cash', 'Lucknow', 'Uttar Pradesh'),
(24, 19, 5, '2023-11-03', 65000.00, 'Delivered', 'Credit Card', 'Chandigarh', 'Punjab'),
(25, 20, 7, '2023-11-04', 45000.00, 'Delivered', 'Debit Card', 'Amritsar', 'Punjab'),
(26, 1, 2, '2023-11-05', 97000.00, 'Shipped', 'Credit Card', 'Mumbai', 'Maharashtra'),
(27, 4, 1, '2023-11-06', 30500.00, 'Delivered', 'PayPal', 'Bangalore', 'Karnataka'),
(28, 8, 5, '2023-11-07', 67000.00, 'Delivered', 'Credit Card', 'Pune', 'Maharashtra'),
(29, 11, 7, '2023-11-08', 140000.00, 'Pending', 'Credit Card', 'Mumbai', 'Maharashtra'),
(30, 15, 2, '2023-11-09', 8000.00, 'Delivered', 'Cash', 'Kolkata', 'West Bengal');

-- Insert Order Items (60 items for the 30 orders)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_percent) VALUES
(1, 1, 1, 1, 45000.00, 0.00),
(2, 2, 4, 1, 65000.00, 0.00),
(3, 3, 7, 1, 25000.00, 0.00),
(4, 4, 3, 1, 92000.00, 0.00),
(5, 6, 5, 1, 55000.00, 0.00),
(6, 6, 8, 1, 22000.00, 0.00),
(7, 8, 9, 1, 5500.00, 0.00),
(8, 8, 11, 1, 48000.00, 0.00),
(9, 9, 15, 1, 135000.00, 0.00),
(10, 10, 17, 1, 18000.00, 0.00),
(11, 11, 12, 1, 42000.00, 0.00),
(12, 12, 13, 1, 28000.00, 0.00),
(13, 13, 16, 1, 75000.00, 0.00),
(14, 14, 19, 1, 1500.00, 0.00),
(15, 15, 20, 1, 14000.00, 0.00),
(16, 16, 2, 1, 52000.00, 0.00),
(17, 17, 6, 1, 45000.00, 0.00),
(18, 18, 18, 1, 25000.00, 0.00),
(19, 19, 10, 1, 55000.00, 0.00),
(20, 20, 21, 1, 12000.00, 0.00),
(21, 21, 23, 1, 125000.00, 0.00),
(22, 22, 24, 1, 38000.00, 0.00),
(23, 23, 25, 1, 3500.00, 0.00),
(24, 24, 14, 1, 65000.00, 0.00),
(25, 25, 22, 1, 45000.00, 0.00),
(26, 26, 3, 1, 92000.00, 5.00),
(27, 26, 9, 1, 5500.00, 10.00),
(28, 27, 7, 1, 25000.00, 0.00),
(29, 27, 9, 1, 5500.00, 0.00),
(30, 28, 4, 1, 65000.00, 3.00),
(31, 28, 19, 2, 1500.00, 0.00),
(32, 29, 3, 1, 92000.00, 2.00),
(33, 29, 11, 1, 48000.00, 0.00),
(34, 30, 9, 1, 5500.00, 5.00),
(35, 30, 19, 2, 1500.00, 10.00),
(36, 1, 19, 2, 1500.00, 0.00),
(37, 2, 8, 1, 22000.00, 5.00),
(38, 4, 7, 1, 25000.00, 10.00),
(39, 5, 13, 1, 28000.00, 5.00),
(40, 6, 9, 2, 5500.00, 0.00),
(41, 8, 19, 3, 1500.00, 10.00),
(42, 10, 25, 1, 3500.00, 0.00),
(43, 11, 8, 1, 22000.00, 5.00),
(44, 13, 2, 1, 52000.00, 0.00),
(45, 14, 25, 2, 3500.00, 15.00),
(46, 16, 9, 1, 5500.00, 0.00),
(47, 17, 19, 3, 1500.00, 0.00),
(48, 19, 7, 1, 25000.00, 10.00),
(49, 20, 25, 1, 3500.00, 0.00),
(50, 21, 8, 2, 22000.00, 5.00),
(51, 22, 17, 1, 18000.00, 0.00),
(52, 23, 19, 1, 1500.00, 0.00),
(53, 24, 9, 2, 5500.00, 10.00),
(54, 25, 13, 1, 28000.00, 5.00),
(55, 26, 19, 2, 1500.00, 0.00),
(56, 27, 25, 1, 3500.00, 0.00),
(57, 28, 9, 1, 5500.00, 10.00),
(58, 29, 7, 1, 25000.00, 0.00),
(59, 30, 19, 1, 1500.00, 0.00),
(60, 30, 25, 1, 3500.00, 10.00);

-- Insert Reviews (15 reviews)
INSERT INTO reviews (review_id, product_id, customer_id, rating, review_text, review_date) VALUES
(1, 1, 1, 4, 'Good laptop for daily use. Battery life could be better.', '2023-10-10'),
(2, 4, 2, 5, 'Excellent phone! Camera quality is outstanding.', '2023-10-15'),
(3, 7, 3, 5, 'Best noise cancellation headphones in this price range.', '2023-10-12'),
(4, 3, 4, 5, 'MacBook Air is perfect for my work. Super fast and lightweight.', '2023-10-20'),
(5, 5, 5, 4, 'Great phone but slightly overpriced.', '2023-11-01'),
(6, 8, 6, 5, 'AirPods Pro are amazing! Worth every rupee.', '2023-10-25'),
(7, 9, 7, 3, 'Decent headphones for the price. Build quality could be better.', '2023-10-18'),
(8, 11, 8, 4, 'Good tablet, but iPad is still better for creative work.', '2023-10-28'),
(9, 17, 10, 4, 'Best budget phone! Great value for money.', '2023-10-22'),
(10, 19, 14, 5, 'Excellent budget headphones. Sound quality surprised me!', '2023-10-30'),
(11, 2, 16, 4, 'HP Pavilion is good for students. Runs all software smoothly.', '2023-11-02'),
(12, 6, 17, 5, 'OnePlus 11 is super fast. Gaming performance is excellent.', '2023-11-05'),
(13, 25, 18, 4, 'Mi Band 7 is perfect for fitness tracking. Battery lasts a week!', '2023-11-08'),
(14, 14, 19, 5, 'Canon EOS R50 takes professional quality photos. Love it!', '2023-11-10'),
(15, 22, 20, 4, 'GoPro Hero 11 is great for adventure videos. Stabilization is amazing.', '2023-11-12');

-- ================================================
-- PRACTICE QUERIES - BEGINNER LEVEL
-- ================================================

-- 1. SELECT all customers from Mumbai
select * from customers where city = 'Mumbai';

-- 2. Find all products priced below 30000
select * from products where price < 30000;

-- 3. List all employees in the Sales department
select * from employees where department = 'sales';

-- 4. Show all orders with status 'Delivered'
select * from orders where status = 'Delivered';

-- 5. Find all Premium customers
select * from customers where customer_type = 'Premium';

-- ================================================
-- PRACTICE QUERIES - INTERMEDIATE LEVEL
-- ================================================

-- 1. Find the total number of orders per customer
select 
	c.customer_id, CONCAT(c.first_name,' ',c.last_name) as "Client Name" , count(*) as "Order Count" 
from 
	orders as o
join customers as c on
	o.customer_id = c.customer_id
group by o.customer_id;

-- 2. Calculate the average product price by category
select 
	c.category_name, avg(p.price) as "Average Price" 
from
	products as p 
join categories as c on
    c.category_id = p.category_id
group by p.category_id;

-- 3. List top 5 most expensive products
select 
	*
from products
order by price desc
limit 5;

-- 4. Find customers who haven't made any orders
WITH buying_customers as (
select 
	distinct(customer_id) 
from orders 
) 
select * from customers 
where 
	customer_id 
not in (select customer_id from buying_customers);

-- 5. Show monthly sales totals for 2023
select 
    year(order_date) as year,
    month(order_date) as month,
    COUNT(*) as count
from 
	orders 
where 
	year(order_date) = '2023'
group by 
	year(order_date), month(order_date)
order by 
	year, month;

-- 6. Find products that are out of stock (stock_quantity = 0)
select
	*
from 
	products
where 
	is_active = 1 
    and stock_quantity = 0;

-- 7. List employees and their total sales amount
select 
	concat(e.first_name, ' ', e.last_name) as "Employee Name", sum(total_amount) as 'Total Sales'
from
	orders as o
join 
	employees as e on e.employee_id = o.employee_id
group by 
	o.employee_id;

-- 8. Find the most popular payment method
select 
	payment_method as "Payment Method", COUNT(*) as "Payment Amount"
from
	orders
group by
	payment_method;

-- 9. Calculate total revenue by state
select 
	shipping_state as "State", count(*)
from 
	orders
group by
	shipping_state;

-- ================================================
-- PRACTICE QUERIES - ADVANCED LEVEL
-- ================================================

-- 1. Find customers who have spent more than 50000 in total
select
	concat(c.first_name, ' ',c.last_name) as "Customer Name", sum(o.total_amount) as "Total Spends"
from 
	orders as o
join
	customers as c on c.customer_id = o.customer_id
group by
	o.customer_id
having 
	sum(o.total_amount) > 50000
order by 
	sum(o.total_amount) desc;

-- 2. Identify the best-selling product (by quantity sold)
select
	p.product_name as "Most Sold Product" , sum(oi.quantity) as "Number of items sold"
from
	order_items as oi
join products as p on p.product_id = oi.product_id
group by
	oi.product_id
order by
	sum(oi.quantity) desc
limit 1;
	
-- 3. Calculate the average order value by customer type
select 
	c.customer_type as "Customer Type", avg(o.total_amount) as "Average ORder Value"
from
	orders as o 
left join customers as c on c.customer_id = o.customer_id
group by
	c.customer_type
order by
	avg(o.total_amount) desc;
    
-- 4. Find products that have never been ordered
select * from order_items;
update order_items set product_id = 2, unit_price = 52000 where order_item_id = 1;
WITH ordered_product as ( 
select distinct(oi.product_id) as "products" from order_items  as oi inner join orders as o on o.order_id = oi.order_id
)
select * from products as p where p.product_id NOT IN (select products from ordered_product);

-- 5. Show the employee with highest sales in each month

WITH monthly_sales as (select
	year(order_date) as "year", month(order_date) as "month", e.employee_id as "empID", sum(o.total_amount) as "amount"
from orders as o 
join employees as e on e.employee_id = o.employee_id
group by
	year(order_date), month(order_date), o.employee_id
),
employee_sales as (
select *,RANK() OVER ( PARTITION BY year,month order by amount desc) as sales_rank from monthly_sales
)
select year, month, empId, amount, sales_rank from  employee_sales
where sales_rank = 1;

-- 6. Calculate customer retention (customers who ordered more than once)
select distinct(customer_id), count(*)
from 
	orders 
group by 
	customer_id
having count(*) > 1
order by count(*) desc;

-- 7. Find products with average rating above 4
select product_id, avg(rating) from reviews
group by 
	product_id
having avg(rating) > 4;
