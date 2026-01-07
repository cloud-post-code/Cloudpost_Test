#!/bin/bash
# Database Migration Script for Railway
# This script will be run automatically when MySQL service starts

set -e

echo "Starting database migration..."

# Wait for MySQL to be ready
until mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "SELECT 1" &> /dev/null; do
  echo "Waiting for MySQL to be ready..."
  sleep 2
done

echo "MySQL is ready. Running schema migration..."

# Run schema.sql
mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" "$MYSQLDATABASE" < /app/database/schema.sql

echo "Database migration completed successfully!"

