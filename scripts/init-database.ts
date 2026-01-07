/**
 * Database Initialization Script for Railway
 * This script runs the schema.sql file to initialize the database
 * 
 * Usage: npx tsx scripts/init-database.ts
 * 
 * Railway will automatically run this during deployment if configured
 */

import { exec } from 'child_process';
import { promisify } from 'util';
import * as fs from 'fs';
import * as path from 'path';

const execAsync = promisify(exec);

// Railway provides these environment variables for MySQL
const dbHost = process.env.MYSQL_HOST || process.env.DB_HOST || 'localhost';
const dbPort = process.env.MYSQL_PORT || process.env.DB_PORT || '3306';
const dbUser = process.env.MYSQLUSER || process.env.DB_USER || 'root';
const dbPassword = process.env.MYSQLPASSWORD || process.env.DB_PASSWORD || '';
const dbName = process.env.MYSQLDATABASE || process.env.DB_NAME || 'cloudpost_db';

const schemaPath = path.join(__dirname, '../database/schema.sql');

async function initDatabase() {
  console.log('Initializing Cloudpost database...');
  console.log(`Connecting to: ${dbHost}:${dbPort}/${dbName}`);

  // Check if schema file exists
  if (!fs.existsSync(schemaPath)) {
    console.error(`Schema file not found at: ${schemaPath}`);
    process.exit(1);
  }

  try {
    // Run MySQL command to execute schema
    const passwordArg = dbPassword ? `-p${dbPassword}` : '';
    const mysqlCommand = `mysql -h ${dbHost} -P ${dbPort} -u ${dbUser} ${passwordArg} ${dbName} < ${schemaPath}`;
    
    const { stdout, stderr } = await execAsync(mysqlCommand);
    
    if (stderr && !stderr.includes('Warning')) {
      console.error('Database initialization warnings:', stderr);
    }
    
    console.log('Database schema initialized successfully!');
    if (stdout) {
      console.log(stdout);
    }
  } catch (error: any) {
    console.error('Error executing schema:', error.message);
    if (error.stderr) {
      console.error(error.stderr);
    }
    process.exit(1);
  }
}

initDatabase();

