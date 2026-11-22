-- CSCE 4355: Employee Role Permission Tests
-- Tests T04 through T08

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

RESET ROLE;
