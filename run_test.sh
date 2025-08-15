#!/bin/bash

echo `pwd`
cd integration_tests

echo "Installing deps..."
dbt --warn-error deps --target $1 || exit 1
echo "Creating source table..."
dbt --warn-error run-operation create_source_table --target $1 || exit 1
echo "Seeding..."
dbt --warn-error seed --target $1 --full-refresh || exit 1
echo "Running..."
dbt --warn-error run --target $1 || exit 1
echo "Testing..."
dbt --warn-error test --target $1 || exit 1
