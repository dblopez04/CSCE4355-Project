-- CSCE 4355: Viewer Role Permission Tests
-- Tests T01-T03, T13-T15, T26, and T30-T36

SET ROLE report_viewer;

-- T01: Viewer can read products
SELECT product_id, product_name, price
FROM products
LIMIT 5;

-- T02: Viewer cannot delete products
DELETE FROM products
WHERE product_id = 1;

-- T03: Viewer cannot view sales
SELECT *
FROM sales
LIMIT 5;

-- T13: Viewer cannot insert products
INSERT INTO products (product_name, price, stock_quantity)
VALUES ('RBAC Test Product', 10.00, 5);

-- T14: Viewer cannot update product prices
UPDATE products
SET price = 20.00
WHERE product_id = 1;

-- T15: Viewer cannot view suppliers
SELECT *
FROM suppliers
LIMIT 5;

-- T26: Viewer cannot view employee records
SELECT *
FROM employees
LIMIT 5;

-- T30: Viewer cannot update product stock quantities
UPDATE products
SET stock_quantity = 50
WHERE product_id = 1;

-- T31: Viewer cannot insert sales
INSERT INTO sales DEFAULT VALUES;

-- T32: Viewer cannot update sales
UPDATE sales
SET total_amount = 0
WHERE sale_id = 1;

-- T33: Viewer cannot delete sales
DELETE FROM sales
WHERE sale_id = 1;

-- T34: Viewer cannot insert employee records
INSERT INTO employees DEFAULT VALUES;

-- T35: Viewer cannot update employee records
UPDATE employees
SET employee_id = DEFAULT
WHERE employee_id = 1;

-- T36: Viewer cannot delete employee records
DELETE FROM employees
WHERE employee_id = 1;

RESET ROLE;
