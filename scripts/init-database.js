#!/usr/bin/env node
/**
 * Database Initialization Script for Railway
 * This script runs the schema.sql file to initialize the database
 * 
 * Usage: node scripts/init-database.js
 * 
 * Railway will automatically run this during deployment if configured
 */

const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const schemaPath = path.join(__dirname, '../database/schema.sql');

// Railway provides these environment variables for MySQL
const dbHost = process.env.MYSQL_HOST || process.env.DB_HOST || 'localhost';
const dbPort = process.env.MYSQL_PORT || process.env.DB_PORT || '3306';
const dbUser = process.env.MYSQLUSER || process.env.DB_USER || 'root';
const dbPassword = process.env.MYSQLPASSWORD || process.env.DB_PASSWORD || '';
const dbName = process.env.MYSQLDATABASE || process.env.DB_NAME || 'cloudpost_db';

console.log('Initializing Cloudpost database...');
console.log(`Connecting to: ${dbHost}:${dbPort}/${dbName}`);

// Check if schema file exists
if (!fs.existsSync(schemaPath)) {
  console.error(`Schema file not found at: ${schemaPath}`);
  process.exit(1);
}

// Run MySQL command to execute schema
const mysqlCommand = `mysql -h ${dbHost} -P ${dbPort} -u ${dbUser} ${dbPassword ? `-p${dbPassword}` : ''} ${dbName} < ${schemaPath}`;

exec(mysqlCommand, (error, stdout, stderr) => {
  if (error) {
    console.error(`Error executing schema: ${error.message}`);
    console.error(stderr);
    process.exit(1);
  }
  
  console.log('Database schema initialized successfully!');
  console.log(stdout);
});

