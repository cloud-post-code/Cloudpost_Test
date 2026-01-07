#!/bin/bash
# Railway Database Migration Script
# This script runs automatically when deployed as a Railway service
# It will execute database/schema.sql to initialize the database

set -e

echo "=========================================="
echo "Cloudpost Database Migration"
echo "=========================================="

# Railway automatically provides these environment variables for MySQL:
# MYSQL_HOST, MYSQL_PORT, MYSQLUSER, MYSQLPASSWORD, MYSQLDATABASE

if [ -z "$MYSQL_HOST" ]; then
  echo "Error: MYSQL_HOST not set. Make sure MySQL service is linked."
  exit 1
fi

echo "MySQL Host: $MYSQL_HOST"
echo "MySQL Port: $MYSQL_PORT"
echo "Database: $MYSQLDATABASE"
echo "User: $MYSQLUSER"

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
MAX_RETRIES=30
RETRY_COUNT=0

until mysql -h "$MYSQL_HOST" -P "${MYSQL_PORT:-3306}" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "SELECT 1" &> /dev/null; do
  RETRY_COUNT=$((RETRY_COUNT + 1))
  if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
    echo "Error: MySQL not ready after $MAX_RETRIES attempts"
    exit 1
  fi
  echo "Attempt $RETRY_COUNT/$MAX_RETRIES: MySQL not ready, retrying in 2 seconds..."
  sleep 2
done

echo "MySQL is ready!"

# Check if schema file exists
SCHEMA_FILE="database/schema.sql"
if [ ! -f "$SCHEMA_FILE" ]; then
  echo "Error: Schema file not found at $SCHEMA_FILE"
  exit 1
fi

echo "Running database schema migration..."
echo "This may take a few minutes..."

# Run the schema file
mysql -h "$MYSQL_HOST" -P "${MYSQL_PORT:-3306}" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" "$MYSQLDATABASE" < "$SCHEMA_FILE"

if [ $? -eq 0 ]; then
  echo "=========================================="
  echo "✓ Database migration completed successfully!"
  echo "=========================================="
  
  # Verify tables were created
  TABLE_COUNT=$(mysql -h "$MYSQL_HOST" -P "${MYSQL_PORT:-3306}" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" "$MYSQLDATABASE" -e "SHOW TABLES;" 2>/dev/null | wc -l)
  echo "Tables created: $TABLE_COUNT"
  
  echo "Migration service can now be stopped/deleted."
  echo "Your database is ready to use!"
else
  echo "=========================================="
  echo "✗ Database migration failed!"
  echo "=========================================="
  exit 1
fi

