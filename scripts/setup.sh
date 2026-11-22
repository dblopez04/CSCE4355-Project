#!/usr/bin/env bash
# Creates retail_db and runs all setup files.
# Usage:
#   .scripts/setup.sh
set -e

cd "$(dirname "$0")/.."

# Connection settings
export PGHOST=localhost
export PGUSER=postgres
DB=retail_db

# If the database already exists, prompt the user for a reset.
if [ "$(psql -d postgres -Atc "SELECT 1 FROM pg_database WHERE datname = '$DB'")" = "1" ]; then
  read -rp "Database $DB already exists. Reset it? [y/N] " answer
  if [[ $answer != [yY] ]]; then
    echo "Exiting without changes."
    exit 0
  fi

  echo "Resetting: dropping database, users and roles..."
  psql -d postgres -v ON_ERROR_STOP=1 -f sql/99_teardown.sql
  echo "Reset complete."
  echo
fi

echo "Creating database $DB..."
psql -d postgres -c "CREATE DATABASE $DB;"

echo "Creating tables..."
psql -d "$DB" -v ON_ERROR_STOP=1 -f sql/schema/01_create_tables.sql

echo "Inserting sample data..."
psql -d "$DB" -v ON_ERROR_STOP=1 -f sql/schema/02_insert_data.sql

echo "Creating roles and granting permissions..."
psql -d "$DB" -v ON_ERROR_STOP=1 -f sql/roles/03_create_roles.sql

echo "Creating users..."
psql -d "$DB" -v ON_ERROR_STOP=1 -f sql/roles/04_create_users.sql

echo
echo "Setup complete."
echo

psql -U postgres -h localhost -d retail_db -P footer=off -f sql/summary.sql