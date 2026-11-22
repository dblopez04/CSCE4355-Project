-- CSCE 4355: Manager Role Permission Tests
-- Tests T09 through T12

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

RESET ROLE;
