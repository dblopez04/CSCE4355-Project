-- CSCE 4355: Viewer Role Permission Tests
-- Tests T01, T02, and T03

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

RESET ROLE;
