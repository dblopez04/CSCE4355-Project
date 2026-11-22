
# Retail Store Inventory Management System
## Role-Based Access Control (RBAC) Permission Matrix

This matrix shows the permissions assigned to each application role in PostgreSQL, based on `sql/roles/03_create_roles.sql`.

| Table / Operation | Manager | Employee | Viewer |
|---|---|---|---|
| Products: SELECT | Yes | Yes | Yes |
| Products: INSERT | Yes | No | No |
| Products: UPDATE price | Yes | No | No |
| Products: UPDATE stock_quantity | Yes | Yes | No |
| Products: DELETE | Yes | No | No |
| Sales: SELECT | Yes | Yes | No |
| Sales: INSERT, UPDATE, DELETE | No | No | No |
| Suppliers: SELECT | Yes | No | No |
| Suppliers: INSERT, UPDATE, DELETE | Yes | No | No |
| Employees: SELECT, INSERT, UPDATE, DELETE | No | No | No |

## Role Descriptions

**Manager:** Can manage products and suppliers, including adding, updating, and deleting records. Can also view sales.

**Employee:** Can view products and sales and update product stock quantities. Cannot change prices or delete products.

**Viewer:** Can only view product information. Cannot modify records or access sales, suppliers, or employee information.

