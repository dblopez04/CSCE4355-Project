
# RBAC Testing Results

## Testing Methodology

The Retail Store Inventory Management System was tested using PostgreSQL 18.3. The database was created locally, and the SQL scripts were executed to create the tables, insert sample data, and configure user roles.

Twelve permission tests were performed using PostgreSQL's `SET ROLE` command to simulate Manager, Employee, and Viewer permissions. Each test checked whether a role could perform an allowed or restricted database operation. Successful queries and permission-denied errors were compared against the expected results.

Three reusable SQL testing scripts were also created under `sql/tests/`. Transactions were rolled back after successful data modifications to preserve the original sample data.

## Test Results

| Test ID | Role | Operation | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| T01 | Viewer | SELECT products | Allowed | Allowed | Pass |
| T02 | Viewer | DELETE products | Denied | Denied | Pass |
| T03 | Viewer | SELECT sales | Denied | Denied | Pass |
| T04 | Employee | SELECT products | Allowed | Allowed | Pass |
| T05 | Employee | UPDATE product stock | Allowed | Allowed | Pass |
| T06 | Employee | UPDATE product price | Denied | Denied | Pass |
| T07 | Employee | DELETE products | Denied | Denied | Pass |
| T08 | Employee | SELECT sales | Allowed | Allowed | Pass |
| T09 | Manager | INSERT products | Allowed | Allowed | Pass |
| T10 | Manager | UPDATE product price | Allowed | Allowed | Pass |
| T11 | Manager | SELECT suppliers | Allowed | Allowed | Pass |
| T12 | Manager | SELECT employees | Denied | Denied | Pass |

## Testing Summary

All 12 tests produced the expected results. The Viewer role was restricted to viewing products, the Employee role could view products and sales and update stock quantities, and the Manager role could perform additional product management operations and view suppliers.

The tests confirmed that the selected role permissions were enforced as defined in the SQL scripts. These tests used `SET ROLE` to verify database permissions and did not test direct user login authentication or every possible database operation.

