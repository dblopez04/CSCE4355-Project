#!/usr/bin/env bash
# Runs the RBAC tests in sql/tests/.
# Usage: ./scripts/test.sh
set -e

cd "$(dirname "$0")/.."

for f in sql/tests/*.sql; do
  echo "=================================================="
  echo "Running $f"
  echo "=================================================="
  psql -U postgres -h localhost -d retail_db -a -f "$f" 2>&1
  echo
done

echo "All tests finished."