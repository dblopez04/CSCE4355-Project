-- CSCE 4355: Manager Role Permission Tests
-- Tests T09-T12, T19-T25, and T43-T48

SET ROLE james_wilson;

-- T09: Manager can insert products
BEGIN;

INSERT INTO products
(product_name, supplier_id, price, stock_quantity, category)
VALUES ('Test Product', 1, 19.99, 10, 'Testing');

ROLLBACK;

-- T10: Manager can update product prices
BEGIN;

UPDATE products
SET price = 799.99
WHERE product_id = 1;

SELECT product_id, product_name, price
FROM products
WHERE product_id = 1;

ROLLBACK;

-- T11: Manager can view suppliers
SELECT supplier_id, supplier_name, contact_name
FROM suppliers
LIMIT 5;

-- T12: Manager cannot view employees
SELECT *
FROM employees
LIMIT 5;

-- T19: Manager can view products
SELECT product_id, product_name, price, stock_quantity
FROM products
LIMIT 5;

-- T20: Manager can update stock quantities
BEGIN;
UPDATE products
SET stock_quantity = 25
WHERE product_id = 1;
ROLLBACK;

-- T21: Manager can delete products
BEGIN;

INSERT INTO products
(product_name, supplier_id, price, stock_quantity, category)
VALUES ('Delete Test Product', 1, 9.99, 5, 'Testing');

DELETE FROM products
WHERE product_name = 'Delete Test Product'
AND category = 'Testing';

ROLLBACK;

-- T22: Manager can view sales
SELECT sale_id, product_id, employee_id, total_amount
FROM sales
LIMIT 5;

-- T23: Manager can insert suppliers
BEGIN;
INSERT INTO suppliers (supplier_name, contact_name, email)
VALUES ('RBAC Test Supplier', 'Test Contact', 'rbac_test@example.com');
ROLLBACK;

-- T24: Manager can update suppliers
BEGIN;
UPDATE suppliers
SET contact_name = 'Updated Test Contact'
WHERE supplier_id = 1;
ROLLBACK;

-- T25: Manager can delete suppliers
BEGIN;

INSERT INTO suppliers (supplier_name, contact_name, email)
VALUES ('Delete Test Supplier', 'Test Contact', 'delete_test@example.com');

DELETE FROM suppliers
WHERE supplier_name = 'Delete Test Supplier'
AND email = 'delete_test@example.com';

ROLLBACK;

-- T43: Manager cannot insert sales
INSERT INTO sales DEFAULT VALUES;

-- T44: Manager cannot update sales
UPDATE sales
SET total_amount = 0
WHERE sale_id = 1;

-- T45: Manager cannot delete sales
DELETE FROM sales
WHERE sale_id = 1;

-- T46: Manager cannot insert employee records
INSERT INTO employees DEFAULT VALUES;

-- T47: Manager cannot update employee records
UPDATE employees
SET employee_id = DEFAULT
WHERE employee_id = 1;

-- T48: Manager cannot delete employee records
DELETE FROM employees
WHERE employee_id = 1;

RESET ROLE;
