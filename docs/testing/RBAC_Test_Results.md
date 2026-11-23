
# RBAC Testing Results

## Testing Methodology

The Retail Store Inventory Management System was tested using PostgreSQL 18.3. The tests were executed against the local `retail_inventory` database, which contains four tables: products, suppliers, employees, and sales.

A total of 48 permission tests were performed using PostgreSQL's `SET ROLE` command to simulate Manager, Employee, and Viewer permissions. Each test checked whether a role could perform an allowed or restricted database operation. Successful queries and permission-denied errors were compared against the expected results.

Three reusable SQL testing scripts were created under `sql/tests/`. Transactions were rolled back after successful data modifications to preserve the original sample data.

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
| T13 | Viewer | INSERT products | Denied | Denied | Pass |
| T14 | Viewer | UPDATE product price | Denied | Denied | Pass |
| T15 | Viewer | SELECT suppliers | Denied | Denied | Pass |
| T16 | Employee | INSERT products | Denied | Denied | Pass |
| T17 | Employee | SELECT suppliers | Denied | Denied | Pass |
| T18 | Employee | SELECT employees | Denied | Denied | Pass |
| T19 | Manager | SELECT products | Allowed | Allowed | Pass |
| T20 | Manager | UPDATE product stock | Allowed | Allowed | Pass |
| T21 | Manager | DELETE products | Allowed | Allowed | Pass |
| T22 | Manager | SELECT sales | Allowed | Allowed | Pass |
| T23 | Manager | INSERT suppliers | Allowed | Allowed | Pass |
| T24 | Manager | UPDATE suppliers | Allowed | Allowed | Pass |
| T25 | Manager | DELETE suppliers | Allowed | Allowed | Pass |
| T26 | Viewer | SELECT employees | Denied | Denied | Pass |
| T27 | Employee | INSERT suppliers | Denied | Denied | Pass |
| T28 | Employee | UPDATE suppliers | Denied | Denied | Pass |
| T29 | Employee | DELETE suppliers | Denied | Denied | Pass |
| T30 | Viewer | UPDATE product stock | Denied | Denied | Pass |
| T31 | Viewer | INSERT sales | Denied | Denied | Pass |
| T32 | Viewer | UPDATE sales | Denied | Denied | Pass |
| T33 | Viewer | DELETE sales | Denied | Denied | Pass |
| T34 | Viewer | INSERT employees | Denied | Denied | Pass |
| T35 | Viewer | UPDATE employees | Denied | Denied | Pass |
| T36 | Viewer | DELETE employees | Denied | Denied | Pass |
| T37 | Employee | INSERT sales | Denied | Denied | Pass |
| T38 | Employee | UPDATE sales | Denied | Denied | Pass |
| T39 | Employee | DELETE sales | Denied | Denied | Pass |
| T40 | Employee | INSERT employees | Denied | Denied | Pass |
| T41 | Employee | UPDATE employees | Denied | Denied | Pass |
| T42 | Employee | DELETE employees | Denied | Denied | Pass |
| T43 | Manager | INSERT sales | Denied | Denied | Pass |
| T44 | Manager | UPDATE sales | Denied | Denied | Pass |
| T45 | Manager | DELETE sales | Denied | Denied | Pass |
| T46 | Manager | INSERT employees | Denied | Denied | Pass |
| T47 | Manager | UPDATE employees | Denied | Denied | Pass |
| T48 | Manager | DELETE employees | Denied | Denied | Pass |

## Testing Summary

All 48 tests produced the expected results, with 14 Viewer tests, 17 Employee tests, and 17 Manager tests passing.

The Viewer role could only view product information. The Employee role could view products and sales and update product stock quantities but could not modify product prices or access restricted tables. The Manager role could manage products and suppliers and view sales but could not modify sales or access employee records.

The results confirmed that the tested RBAC permissions were enforced according to the permission matrix. The tests used `SET ROLE` to verify database permissions and did not test direct user login authentication.



