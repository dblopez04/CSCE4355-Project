#!/usr/bin/env bash
# Runs the tests from sql/tests/ and prints a permission matrix
# Usage: ./scripts/test.sh

cd "$(dirname "$0")/.."

export PGHOST=localhost
export PGUSER=postgres
DB=retail_db

ROLES=(Manager Employee Viewer)

OPERATIONS=(
  "View products"   "Add products"   "Change product prices"   "Update stock quantities"   "Delete products"
  "View sales"      "Add sales"      "Update sales"            "Delete sales"
  "View suppliers"  "Add suppliers"  "Update suppliers"        "Delete suppliers"
  "View employees"  "Add employees"  "Update employees"        "Delete employees"
)

# Every statement in the test files
STATEMENTS=(
  # 01_test_viewer.sql
  "-"                                 # SET ROLE
  "Viewer|View products"              # T01
  "Viewer|Delete products"            # T02
  "Viewer|View sales"                 # T03
  "Viewer|Add products"               # T13
  "Viewer|Change product prices"      # T14
  "Viewer|View suppliers"             # T15
  "Viewer|View employees"             # T26
  "Viewer|Update stock quantities"    # T30
  "Viewer|Add sales"                  # T31
  "Viewer|Update sales"               # T32
  "Viewer|Delete sales"               # T33
  "Viewer|Add employees"              # T34
  "Viewer|Update employees"           # T35
  "Viewer|Delete employees"           # T36
  "-"                                 # RESET ROLE

  # 02_test_employee.sql
  "-"                                 # SET ROLE
  "Employee|View products"            # T04
  "-"                                 # T05 BEGIN
  "Employee|Update stock quantities"  # T05 UPDATE
  "-"                                 # T05 SELECT
  "-"                                 # T05 ROLLBACK
  "Employee|Change product prices"    # T06
  "Employee|Delete products"          # T07
  "Employee|View sales"               # T08
  "Employee|Add products"             # T16
  "Employee|View suppliers"           # T17
  "Employee|View employees"           # T18
  "Employee|Add suppliers"            # T27
  "Employee|Update suppliers"         # T28
  "Employee|Delete suppliers"         # T29
  "Employee|Add sales"                # T37
  "Employee|Update sales"             # T38
  "Employee|Delete sales"             # T39
  "Employee|Add employees"            # T40
  "Employee|Update employees"         # T41
  "Employee|Delete employees"         # T42
  "-"                                 # RESET ROLE

  # 03_test_manager.sql
  "-"                                 # SET ROLE
  "-"                                 # T09 BEGIN
  "Manager|Add products"              # T09 INSERT
  "-"                                 # T09 ROLLBACK
  "-"                                 # T10 BEGIN
  "Manager|Change product prices"     # T10 UPDATE
  "-"                                 # T10 SELECT
  "-"                                 # T10 ROLLBACK
  "Manager|View suppliers"            # T11
  "Manager|View employees"            # T12
  "Manager|View products"             # T19
  "-"                                 # T20 BEGIN
  "Manager|Update stock quantities"   # T20 UPDATE
  "-"                                 # T20 ROLLBACK
  "-"                                 # T21 BEGIN
  "-"                                 # T21 INSERT (setup)
  "Manager|Delete products"           # T21 DELETE
  "-"                                 # T21 ROLLBACK
  "Manager|View sales"                # T22
  "-"                                 # T23 BEGIN
  "Manager|Add suppliers"             # T23 INSERT
  "-"                                 # T23 ROLLBACK
  "-"                                 # T24 BEGIN
  "Manager|Update suppliers"          # T24 UPDATE
  "-"                                 # T24 ROLLBACK
  "-"                                 # T25 BEGIN
  "-"                                 # T25 INSERT (setup)
  "Manager|Delete suppliers"          # T25 DELETE
  "-"                                 # T25 ROLLBACK
  "Manager|Add sales"                 # T43
  "Manager|Update sales"              # T44
  "Manager|Delete sales"              # T45
  "Manager|Add employees"             # T46
  "Manager|Update employees"          # T47
  "Manager|Delete employees"          # T48
  "-"                                 # RESET ROLE
)

# Run each test file
results=()
for f in sql/tests/*.sql; do
  results+=($(sed 's/;[[:space:]]*$/;\n\\echo :ERROR/' "$f" | psql -d "$DB" -q -o /dev/null -f - 2>/dev/null))
done

if [ ${#results[@]} -ne ${#STATEMENTS[@]} ]; then
  echo "Warning: got ${#results[@]} results for ${#STATEMENTS[@]} statements."
fi

# Match each result to its test
declare -A matrix
for i in "${!STATEMENTS[@]}"; do
  [ "${STATEMENTS[$i]}" = "-" ] && continue
  case "${results[$i]}" in
    true)  matrix[${STATEMENTS[$i]}]="Denied" ;;
    false) matrix[${STATEMENTS[$i]}]="Allowed" ;;
    *)     matrix[${STATEMENTS[$i]}]="?" ;;
  esac
done

# Print the matrix 
printf "%-25s" "Operation"
for role in "${ROLES[@]}"; do printf "%-10s" "$role"; done
echo
echo "----------------------------------------------------"
for op in "${OPERATIONS[@]}"; do
  printf "%-25s" "$op"
  for role in "${ROLES[@]}"; do printf "%-10s" "${matrix[$role|$op]:--}"; done
  echo
done