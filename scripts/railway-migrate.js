#!/usr/bin/env node
/**
 * Railway Database Migration Script
 * Runs database/schema.sql automatically on Railway
 * Uses mysql2 package (no mysql client required)
 */

const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');

// Railway provides these environment variables for MySQL
const config = {
  host: process.env.MYSQL_HOST || process.env.DB_HOST,
  port: parseInt(process.env.MYSQL_PORT || process.env.DB_PORT || '3306'),
  user: process.env.MYSQLUSER || process.env.DB_USER,
  password: process.env.MYSQLPASSWORD || process.env.DB_PASSWORD,
  database: process.env.MYSQLDATABASE || process.env.DB_NAME || 'cloudpost_db',
  multipleStatements: true, // Allow multiple SQL statements
};

async function waitForMySQL(maxRetries = 30) {
  console.log('Waiting for MySQL to be ready...');
  
  for (let i = 0; i < maxRetries; i++) {
    try {
      const connection = await mysql.createConnection(config);
      await connection.ping();
      await connection.end();
      console.log('✓ MySQL is ready!');
      return true;
    } catch (error) {
      if (i < maxRetries - 1) {
        console.log(`Attempt ${i + 1}/${maxRetries}: MySQL not ready, retrying in 2 seconds...`);
        await new Promise(resolve => setTimeout(resolve, 2000));
      } else {
        console.error('✗ MySQL not ready after maximum retries');
        throw error;
      }
    }
  }
}

async function checkTablesExist(connection) {
  try {
    const [tables] = await connection.query('SHOW TABLES');
    return tables.length > 0;
  } catch (error) {
    // Database might not exist yet, or no tables, or connection issue
    if (error.code === 'ER_BAD_DB_ERROR') {
      // Database doesn't exist - that's fine, we'll create it
      return false;
    }
    // Other errors - assume no tables
    return false;
  }
}

async function ensureDatabaseExists(connection) {
  try {
    // Try to use the database - this will fail if it doesn't exist
    await connection.query(`USE ${config.database}`);
  } catch (error) {
    if (error.code === 'ER_BAD_DB_ERROR') {
      // Database doesn't exist, create it
      console.log(`Database '${config.database}' does not exist. Creating...`);
      await connection.query(`CREATE DATABASE IF NOT EXISTS \`${config.database}\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci`);
      await connection.query(`USE ${config.database}`);
      console.log(`✓ Database '${config.database}' created`);
    } else {
      throw error;
    }
  }
}

async function runMigration() {
  console.log('==========================================');
  console.log('Cloudpost Database Migration');
  console.log('==========================================');
  console.log(`MySQL Host: ${config.host}`);
  console.log(`MySQL Port: ${config.port}`);
  console.log(`Database: ${config.database}`);
  console.log(`User: ${config.user}`);
  console.log('');

  if (!config.host || !config.user || !config.password) {
    console.error('Error: MySQL environment variables not set.');
    console.error('Required: MYSQL_HOST, MYSQLUSER, MYSQLPASSWORD');
    console.error('Make sure MySQL service is linked in Railway.');
    process.exit(1);
  }

  try {
    // Wait for MySQL to be ready
    await waitForMySQL();

    // Read schema file
    const schemaPath = path.join(__dirname, '../database/schema.sql');
    if (!fs.existsSync(schemaPath)) {
      console.error(`Error: Schema file not found at ${schemaPath}`);
      process.exit(1);
    }

    console.log('Connecting to database...');
    // Connect without specifying database first (in case it doesn't exist)
    const connectionConfig = { ...config };
    delete connectionConfig.database;
    const connection = await mysql.createConnection(connectionConfig);

    // Ensure database exists
    await ensureDatabaseExists(connection);

    // Now reconnect with database specified
    await connection.end();
    const dbConnection = await mysql.createConnection(config);

    // Check if tables already exist (unless force migration is enabled)
    const forceMigrate = process.env.FORCE_MIGRATE === 'true';
    const tablesExist = await checkTablesExist(dbConnection);
    
    if (tablesExist && !forceMigrate) {
      const [tables] = await dbConnection.query('SHOW TABLES');
      console.log('');
      console.log('⚠️  Tables already exist in the database!');
      console.log(`Found ${tables.length} existing table(s).`);
      console.log('');
      console.log('Skipping migration to prevent errors.');
      console.log('');
      console.log('To force migration (will fail if tables exist):');
      console.log('  Set environment variable: FORCE_MIGRATE=true');
      console.log('');
      console.log('To re-run migration:');
      console.log('  1. Drop existing tables manually, OR');
      console.log('  2. Use a fresh database, OR');
      console.log('  3. Set FORCE_MIGRATE=true (will fail on existing tables)');
      await dbConnection.end();
      
      console.log('');
      console.log('==========================================');
      console.log('✓ Migration skipped - database already initialized');
      console.log('==========================================');
      process.exit(0);
    }

    if (tablesExist && forceMigrate) {
      console.log('');
      console.log('⚠️  FORCE_MIGRATE=true - attempting migration despite existing tables');
      console.log('This will likely fail if tables already exist.');
      console.log('');
    }

    console.log('Reading schema file...');
    const schema = fs.readFileSync(schemaPath, 'utf8');

    console.log('Running database schema migration...');
    console.log('This may take a few minutes...');
    
    // Execute schema
    await dbConnection.query(schema);
    await dbConnection.end();

    console.log('');
    console.log('==========================================');
    console.log('✓ Database migration completed successfully!');
    console.log('==========================================');

    // Verify tables were created
    const verifyConnection = await mysql.createConnection(config);
    const [tables] = await verifyConnection.query('SHOW TABLES');
    await verifyConnection.end();
    
    console.log(`Tables created: ${tables.length}`);
    console.log('');
    console.log('Migration service can now be stopped/deleted.');
    console.log('Your database is ready to use!');
    
    process.exit(0);
  } catch (error) {
    console.error('');
    console.error('==========================================');
    console.error('✗ Database migration failed!');
    console.error('==========================================');
    console.error('Error:', error.message);
    
    // Check if error is due to existing tables
    if (error.message && error.message.includes('already exists')) {
      console.error('');
      console.error('This error usually means tables already exist.');
      console.error('The migration script checks for existing tables and skips migration.');
      console.error('If you see this error, tables were created between the check and execution.');
      console.error('');
      console.error('To force migration, you can:');
      console.error('1. Drop existing tables manually');
      console.error('2. Use a fresh database');
    }
    
    if (error.sql) {
      console.error('SQL:', error.sql.substring(0, 200));
    }
    process.exit(1);
  }
}

runMigration();

