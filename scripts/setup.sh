#!/usr/bin/env bash
# Creates retail_db and runs all setup files.
# Usage:
#   scripts/setup.sh           first-time setup
#   scripts/setup.sh --reset   tears down the previous retail_db and rebuilds
set -e

cd "$(dirname "$0")/.."

if [ "$1" = "--reset" ]; then
  echo "Resetting: dropping database, users and roles..."
  psql -U postgres -h localhost -d postgres -v ON_ERROR_STOP=1 -f sql/99_teardown.sql
  echo "Reset complete."
  echo
fi

echo "Creating database retail_db..."
psql -U postgres -h localhost -d postgres -c "CREATE DATABASE retail_db;"

echo "Creating tables..."
psql -U postgres -h localhost -d retail_db -v ON_ERROR_STOP=1 -f sql/schema/01_create_tables.sql

echo "Inserting sample data..."
psql -U postgres -h localhost -d retail_db -v ON_ERROR_STOP=1 -f sql/schema/02_insert_data.sql

echo "Creating roles and granting permissions..."
psql -U postgres -h localhost -d retail_db -v ON_ERROR_STOP=1 -f sql/roles/03_create_roles.sql

echo "Creating users..."
psql -U postgres -h localhost -d retail_db -v ON_ERROR_STOP=1 -f sql/roles/04_create_users.sql

echo
echo "Setup complete."