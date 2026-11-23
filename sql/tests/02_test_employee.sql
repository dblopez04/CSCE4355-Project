-- CSCE 4355: Employee Role Permission Tests
-- Tests T04-T08, T16-T18, T27-T29, and T37-T42

SET ROLE sarah_davis;

-- T04: Employee can view products
SELECT product_id, product_name, price, stock_quantity
FROM products
LIMIT 5;

-- T05: Employee can update stock quantities
BEGIN;
UPDATE products
SET stock_quantity = 20
WHERE product_id = 1;

SELECT product_id, product_name, stock_quantity
FROM products
WHERE product_id = 1;

ROLLBACK;

-- T06: Employee cannot change product prices
UPDATE products
SET price = 799.99
WHERE product_id = 1;

-- T07: Employee cannot delete products
DELETE FROM products
WHERE product_id = 1;

-- T08: Employee can view sales
SELECT sale_id, product_id, employee_id, quantity, total_amount
FROM sales
LIMIT 5;

-- T16: Employee cannot insert products
INSERT INTO products (product_name, price, stock_quantity)
VALUES ('Employee Test Product', 15.00, 5);

-- T17: Employee cannot view suppliers
SELECT *
FROM suppliers
LIMIT 5;

-- T18: Employee cannot view employee records
SELECT *
FROM employees
LIMIT 5;

-- T27: Employee cannot insert suppliers
INSERT INTO suppliers (supplier_name, contact_name, email)
VALUES ('Employee Test Supplier', 'Test Contact', 'employee_test@example.com');

-- T28: Employee cannot update suppliers
UPDATE suppliers
SET contact_name = 'Employee Update Test'
WHERE supplier_id = 1;

-- T29: Employee cannot delete suppliers
DELETE FROM suppliers
WHERE supplier_id = 1;

-- T37: Employee cannot insert sales
INSERT INTO sales DEFAULT VALUES;

-- T38: Employee cannot update sales
UPDATE sales
SET total_amount = 0
WHERE sale_id = 1;

-- T39: Employee cannot delete sales
DELETE FROM sales
WHERE sale_id = 1;

-- T40: Employee cannot insert employee records
INSERT INTO employees DEFAULT VALUES;

-- T41: Employee cannot update employee records
UPDATE employees
SET employee_id = DEFAULT
WHERE employee_id = 1;

-- T42: Employee cannot delete employee records
DELETE FROM employees
WHERE employee_id = 1;

RESET ROLE;
