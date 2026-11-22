-- Summary printed at the end of the setup script.

-- List all users and their role
SELECT u.rolname AS "User", g.rolname AS "Role"
FROM pg_auth_members m
JOIN pg_roles u ON u.oid = m.member
JOIN pg_roles g ON g.oid = m.roleid
WHERE g.rolname IN ('manager', 'employee', 'viewer')
ORDER BY g.rolname, u.rolname;

-- Display row count for each table
SELECT 'suppliers' AS "Table", count(*) AS "Rows" FROM suppliers
UNION ALL SELECT 'employees', count(*) FROM employees
UNION ALL SELECT 'products',  count(*) FROM products
UNION ALL SELECT 'sales',     count(*) FROM sales;