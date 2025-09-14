-- ================================================
-- CASE STUDY: Simple Bank Account Management System
-- Focus: SQL VIEWS and TRIGGERS
-- ================================================

-- SCENARIO: A small bank needs to track customer accounts, transactions,
-- and maintain audit logs. They need views for reporting and triggers
-- for automatic data validation and audit trail.

-- ================================================
-- STEP 1: CREATE DATABASE
-- ================================================

create database casestudy2;
use casestudy2;

-- ================================================
-- STEP 1: CREATE BASE TABLES
-- ================================================

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS audit_log;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_status VARCHAR(20) DEFAULT 'Active' -- Active, Inactive, Suspended
);

-- Accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(20) NOT NULL, -- Savings, Current, Fixed Deposit
    balance DECIMAL(15, 2) DEFAULT 0.00,
    min_balance DECIMAL(10, 2) DEFAULT 500.00,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active', -- Active, Frozen, Closed
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_type VARCHAR(20) NOT NULL, -- Deposit, Withdrawal, Transfer
    amount DECIMAL(10, 2) NOT NULL,
    balance_after DECIMAL(15, 2),
    description VARCHAR(200),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Audit log table (for trigger demonstration)
CREATE TABLE audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50),
    operation VARCHAR(20), -- INSERT, UPDATE, DELETE
    user VARCHAR(100),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_values TEXT,
    new_values TEXT
);

-- ================================================
-- STEP 2: INSERT SAMPLE DATA
-- ================================================

-- Insert customers
INSERT INTO customers (first_name, last_name, email, phone) VALUES
('Rajesh', 'Kumar', 'rajesh.kumar@email.com', '9876543210'),
('Priya', 'Sharma', 'priya.sharma@email.com', '9876543211'),
('Amit', 'Patel', 'amit.patel@email.com', '9876543212'),
('Sneha', 'Verma', 'sneha.verma@email.com', '9876543213'),
('Vikram', 'Singh', 'vikram.singh@email.com', '9876543214');

-- Insert accounts
INSERT INTO accounts (customer_id, account_number, account_type, balance, min_balance) VALUES
(1, 'SAV10001', 'Savings', 50000.00, 5000.00),
(1, 'CUR10001', 'Current', 100000.00, 10000.00),
(2, 'SAV10002', 'Savings', 25000.00, 5000.00),
(3, 'SAV10003', 'Savings', 75000.00, 5000.00),
(4, 'CUR10002', 'Current', 150000.00, 10000.00),
(5, 'SAV10004', 'Savings', 10000.00, 5000.00),
(5, 'FD10001', 'Fixed Deposit', 200000.00, 0.00);

-- Insert initial transactions
INSERT INTO transactions (account_id, transaction_type, amount, balance_after, description) VALUES
(1, 'Deposit', 50000.00, 50000.00, 'Initial deposit'),
(2, 'Deposit', 100000.00, 100000.00, 'Initial deposit'),
(3, 'Deposit', 25000.00, 25000.00, 'Initial deposit'),
(4, 'Deposit', 75000.00, 75000.00, 'Initial deposit'),
(5, 'Deposit', 150000.00, 150000.00, 'Initial deposit'),
(6, 'Deposit', 10000.00, 10000.00, 'Initial deposit'),
(7, 'Deposit', 200000.00, 200000.00, 'Fixed deposit created');

-- ================================================
-- SECTION A: SQL VIEWS
-- ================================================

-- -- -- View Question 1: Customer Account Summary
-- Create a view called customer_account_summary that shows:

-- Customer ID and full name (concatenated)
-- Email and customer status
-- Total number of accounts per customer
-- Sum of all account balances per customer
-- The date of their oldest account (relationship_since)
-- Include customers even if they have no accounts

-- Expected columns: customer_id, customer_name, email, customer_status, total_accounts, total_balance, relationship_since

create view customer_account_summary AS
select 
    c.customer_id as "customer_id",
    CONCAT(c.first_name,' ', c.last_name) as "customer_name",
    c.email as "email",
    c.customer_status as "customer_status",
    COUNT(a.account_id) as "total_accounts",
    SUM(a.balance) as "total_balance",
    MIN(a.created_date) as "relationship_since"
from 
	customers c
left join 
accounts a ON c.customer_id = a.customer_id
group by 
	c.customer_id, c.first_name, c.last_name, c.email, c.customer_status;

select * from customer_account_summary;

-- View Question 2: VIP Customer Identification
-- Create a view called vip_customers that:

-- Shows only customers with total balance >= 100,000
-- Includes customer details (id, name, email, phone)
-- Calculates total balance across all active accounts
-- Assigns VIP tiers:

-- Platinum: balance >= 500,000
-- Gold: balance >= 200,000
-- Silver: balance >= 100,000

-- Only considers Active accounts

-- Expected columns: customer_id, customer_name, email, phone, total_balance, vip_tier

CREATE VIEW vip_customers AS
select 
    c.customer_id as "customer_id",
    CONCAT(c.first_name, ' ', c.last_name) as "customer_name",
    c.email as "email", 
    c.phone as "phone",
    SUM(a.balance) as "total_balance",
		case 
		WHEN SUM(a.balance) >= 500000 THEN 'Platinum'
		WHEN SUM(a.balance) >= 200000 THEN 'Gold'
		WHEN SUM(a.balance) >= 100000 THEN 'Silver'
		end as "vip_tier"
from customers as c
inner join accounts as a on c.customer_id = a.customer_id
where a.status = 'Active'
group by c.customer_id, c.first_name, c.last_name, c.email, c.phone
having SUM(a.balance) >= 100000;

select * from vip_customers;

-- View Question 3: Monthly Transaction Report
-- Create a view called monthly_transaction_summary that:

-- Groups transactions by month (YYYY-MM format)
-- Counts total number of transactions per month
-- Sums deposits, withdrawals, and transfers separately
-- Counts unique active accounts per month

-- Expected columns: month, total_transactions, total_deposits, total_withdrawals, total_transfers, active_accounts
-- Hint: Use DATE_FORMAT() function and CASE statements

CREATE VIEW monthly_transaction_summary AS
select 
    DATE_FORMAT(transaction_date, '%Y-%m') as "month",
    COUNT(*) as "total_transactions",
    SUM(CASE when transaction_type = 'Deposit' then amount else 0 end) as "total_deposits",
    SUM(CASE when transaction_type = 'Withdrawal' then amount else 0 end) as "total_withdrawals",
    SUM(CASE when transaction_type = 'Transfer' then amount else 0 end) as "total_transfers",
    COUNT(distinct account_id) as "active_accounts"
from transactions
group by DATE_FORMAT(transaction_date, '%Y-%m');

-- View Question 4: Fraud Detection - Recent Large Transactions
-- Create a view called recent_large_transactions that:

-- Shows transactions of 50,000 or more
-- Only includes transactions from the last 7 days
-- Joins with customer and account information
-- Orders by transaction date (most recent first)

-- Expected columns: transaction_id, customer_id, customer_name, account_number, transaction_type, amount, balance_after, description, transaction_date

CREATE VIEW recent_large_transactions AS
select 
    t.transaction_id as "transaction_id",
    c.customer_id as "Custoemr_id",
    CONCAT(c.first_name,' ',c.last_name) as "customer_name",
    a.account_number as "accont_number",
    t.transaction_type as "transaction_type",
    t.amount as "amount",
    t.balance_after as "balance_after",
    t.description as "description",
    t.transaction_date as "transaction_date"
from transactions t
inner join accounts a on t.account_id = a.account_id
inner join customers c on a.customer_id = c.customer_id
where t.amount >= 50000
    and t.transaction_date >= DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY t.transaction_date DESC;

select * from recent_large_transactions;

-- =====================================s===========
-- SECTION A: SQL TRIGGERS
-- ================================================

-- Trigger Question 1: Transaction Validation
-- Create a BEFORE INSERT trigger called validate_transaction_amount that:

-- Prevents withdrawals that exceed account balance
-- Ensures all transaction amounts are positive (> 0)
-- Throws appropriate error messages using SIGNAL SQLSTATE '45000'
-- Error messages:

-- "Insufficient balance for withdrawal"
-- "Transaction amount must be positive"

-- Test with:
-- INSERT INTO transactions (account_id, transaction_type, amount, description)
-- VALUES (6, 'Withdrawal', 15000.00, 'ATM withdrawal');

DELIMITER //
CREATE TRIGGER validate_transaction_amount
before insert on transactions
for each row
begin
    declare current_balance DECIMAL(15, 2);
    
    -- for CUrrent balance
    select balance into current_balance
    from accounts
    where account_id = new.account_id;
    
    -- Insufficient balance
    if new.transaction_type = 'Withdrawal' and new.amount > current_balance then
        signal sqlstate '45000'
        set MESSAGE_TEXT = 'Insufficient balance for withdrawal';
    end if;
    
    -- positive
    if new.amount <= 0 then
        signal sqlstate '45000'
        set MESSAGE_TEXT = 'Transaction amount must be positive';
    end if;
end//
DELIMITER ;

INSERT INTO transactions (account_id, transaction_type, amount, description)
VALUES (6, 'Withdrawal', 15000.00, 'ATM withdrawal');

-- Trigger Question 2: Automatic Balance Update
-- Create an AFTER INSERT trigger called update_account_balance that:

-- Automatically updates account balance after any transaction
-- Adds amount for deposits
-- Subtracts amount for withdrawals
-- Updates the balance_after field in the transactions table with the new balance

-- Test with:
-- sql-- Should increase account balance
-- INSERT INTO transactions (account_id, transaction_type, amount, description)
-- VALUES (1, 'Deposit', 5000.00, 'Salary credit');

DELIMITER //
CREATE TRIGGER update_account_balance
before insert on transactions
for each row
begin
    declare current_balance DECIMAL(15,2);
    
    --  current account balance
    select balance into current_balance 
    from accounts 
    where account_id = new.account_id;
    
    -- Update
    if new.transaction_type = 'Deposit' then
        update accounts 
        set balance = balance + new.amount
        where account_id = new.account_id;
        
        -- Set balance_after 
        SET new.balance_after = current_balance + new.amount;
        
    elseif new.transaction_type = 'Withdrawal' then
        update accounts 
        set balance = balance - new.amount
        where account_id = new.account_id;
        
        -- Set balance_after 
        set new.balance_after = current_balance - new.amount;
    end if;
end//
DELIMITER ;

select * from accounts where account_id = 1;
select * from transactions where account_id = 1;

INSERT INTO transactions (account_id, transaction_type, amount, description)
VALUES (1, 'Deposit', 5000.00, 'Salary credit');

select * from accounts where account_id = 1;
select * from transactions where account_id = 1;