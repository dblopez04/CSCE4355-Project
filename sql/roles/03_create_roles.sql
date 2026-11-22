CREATE ROLE manager  NOLOGIN;
CREATE ROLE employee NOLOGIN;
CREATE ROLE viewer   NOLOGIN;

REVOKE ALL ON suppliers, employees, products, sales FROM PUBLIC;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO manager, employee, viewer;

------------------------------------------------------------------
-- View products: Manager, Employee, Viewer
------------------------------------------------------------------
GRANT SELECT ON products TO manager, employee, viewer;

------------------------------------------------------------------
-- Add products: Manager
------------------------------------------------------------------
GRANT INSERT ON products TO manager;

------------------------------------------------------------------
-- Change product prices: Manager
-- Update stock quantities: Manager and Employee
------------------------------------------------------------------
GRANT UPDATE ON products TO manager;                    -- all columns, incl. price
GRANT UPDATE (stock_quantity) ON products TO employee;  -- stock only

------------------------------------------------------------------
-- Delete products: Manager
------------------------------------------------------------------
GRANT DELETE ON products TO manager;

------------------------------------------------------------------
-- View sales: Manager and Employee
------------------------------------------------------------------
GRANT SELECT ON sales TO manager, employee;

------------------------------------------------------------------
-- Manage suppliers: Manager
------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON suppliers TO manager;