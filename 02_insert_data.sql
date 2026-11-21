
INSERT INTO suppliers (supplier_name, contact_name, email, phone)
VALUES
('TechSource Distributors', 'John Smith', 'john@techsource.example', '555-0101'),
('Office Supply Co', 'Sarah Johnson', 'sarah@officesupply.example', '555-0102'),
('Retail Goods Inc', 'Michael Brown', 'michael@retailgoods.example', '555-0103'),
('Global Electronics', 'Emily Davis', 'emily@globalelectronics.example', '555-0104'),
('Home Essentials Ltd', 'David Wilson', 'david@homeessentials.example', '555-0105');

INSERT INTO employees (first_name, last_name, email, job_title, hire_date)
VALUES
('James', 'Wilson', 'james.wilson@example.com', 'Manager', '2023-01-15'),
('Sarah', 'Davis', 'sarah.davis@example.com', 'Sales Associate', '2023-06-10'),
('Michael', 'Brown', 'michael.brown@example.com', 'Cashier', '2024-02-20'),
('Emily', 'Johnson', 'emily.johnson@example.com', 'Inventory Clerk', '2024-05-05'),
('David', 'Miller', 'david.miller@example.com', 'Sales Associate', '2025-03-12');

INSERT INTO products (product_name, supplier_id, price, stock_quantity, category)
VALUES
('Laptop', 1, 899.99, 15, 'Electronics'),
('Wireless Mouse', 1, 24.99, 50, 'Electronics'),
('Office Chair', 2, 149.99, 20, 'Furniture'),
('Notebook', 2, 4.99, 100, 'Office Supplies'),
('USB Cable', 4, 9.99, 75, 'Electronics'),
('Desk Lamp', 5, 29.99, 30, 'Home'),
('Bluetooth Speaker', 4, 59.99, 25, 'Electronics'),
('Backpack', 3, 39.99, 40, 'Accessories'),
('Water Bottle', 3, 14.99, 60, 'Accessories'),
('Desk Organizer', 5, 19.99, 35, 'Office Supplies');

INSERT INTO sales (product_id, employee_id, quantity, total_amount)
VALUES
(1, 2, 1, 899.99),
(2, 3, 2, 49.98),
(3, 2, 1, 149.99),
(4, 4, 5, 24.95),
(5, 3, 3, 29.97),
(6, 2, 2, 59.98),
(7, 5, 1, 59.99),
(8, 3, 2, 79.98),
(9, 4, 4, 59.96),
(10, 5, 1, 19.99);
