#!/bin/bash
# Railway MySQL Initialization Script
# Railway will automatically execute this when MySQL service is created
# Place this in the root directory or configure Railway to run it

set -e

echo "Initializing Cloudpost database..."

# Railway provides these environment variables automatically:
# MYSQL_HOST, MYSQL_PORT, MYSQLUSER, MYSQLPASSWORD, MYSQLDATABASE

# Wait for MySQL to be ready
until mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "SELECT 1" &> /dev/null; do
  echo "Waiting for MySQL connection..."
  sleep 2
done

echo "MySQL connected. Running schema..."

# Run the schema file
mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" "$MYSQLDATABASE" < database/schema.sql

echo "Database initialization complete!"

