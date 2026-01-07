# Railway Database Migration Setup

This guide explains how to automatically run `database/schema.sql` on Railway MySQL.

## Quick Setup (Recommended)

### Step 1: Create MySQL Service
1. In Railway dashboard, click "New Project"
2. Click "New Service" → Select "MySQL"
3. Railway will automatically create the MySQL service with these environment variables:
   - `MYSQL_HOST`
   - `MYSQL_PORT`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`
   - `MYSQLDATABASE`

### Step 2: Create Migration Service
1. Click "New Service" → Select "GitHub Repo" (or "Empty Service")
2. Name it: **"Database Migration"**
3. Configure the service:
   - **Root Directory**: `migration` (important: use the migration directory)
   - **Build Command**: `npm install`
   - **Start Command**: `npm start` (or `node migrate.js`)
   - **Service Type**: One-off (or regular service that exits after completion)

   **Note**: The `migration/` directory contains a minimal `package.json` with only `mysql2` dependency, avoiding workspace protocol issues with the monorepo.

   **Alternative (using bash script - requires mysql client):**
   - **Build Command**: `echo "Migration service - no build needed"`
   - **Start Command**: `bash scripts/railway-migrate.sh`
   - **Note**: Railway's Nixpacks may install mysql client automatically, but Node.js approach is more reliable

### Step 3: Link MySQL to Migration Service
1. Go to Migration service → Settings → Variables
2. Click "Add Variable" → "Reference Variable"
3. Select your MySQL service and add these references:
   - `MYSQL_HOST` → Reference from MySQL service
   - `MYSQL_PORT` → Reference from MySQL service
   - `MYSQLUSER` → Reference from MySQL service
   - `MYSQLPASSWORD` → Reference from MySQL service
   - `MYSQLDATABASE` → Reference from MySQL service

   **OR** Railway may auto-link these if services are in the same project.

### Step 4: Deploy Migration Service
1. Click "Deploy" on the Migration service
2. Watch the logs - you should see:
   ```
   Cloudpost Database Migration
   MySQL is ready!
   Running database schema migration...
   ✓ Database migration completed successfully!
   ```
3. Once complete, the migration service will exit
4. You can now delete the migration service (or keep it for future migrations)

### Step 5: Verify Migration
1. Go to MySQL service → Data → MySQL Console
2. Run: `SHOW TABLES;`
3. You should see all tables from `schema.sql` (tbl_users, tbl_admin, etc.)

## Alternative: Manual Migration via MySQL Console

If you prefer to run manually:

1. Go to MySQL service → Data → MySQL Console
2. Copy entire contents of `database/schema.sql`
3. Paste into console and execute
4. Verify with `SHOW TABLES;`

## Troubleshooting

### Migration Service Fails to Connect
- Verify MySQL service is running
- Check that environment variables are linked correctly
- Ensure MySQL service is in the same project

### Schema File Not Found
- Verify `database/schema.sql` exists in your repository
- Check Root Directory setting (should be empty/root)

### Migration Takes Too Long
- Large schema files can take 5-10 minutes
- Check logs for progress
- Don't cancel the migration service while running

### Tables Already Exist
- The migration will fail if tables already exist
- Drop existing tables first, or modify schema.sql to use `CREATE TABLE IF NOT EXISTS`

## Next Steps

After migration completes:
1. Create Backend service (it will connect to MySQL)
2. Create Frontend services
3. Configure environment variables
4. Deploy!

See `RAILWAY_DEPLOYMENT.md` for full deployment instructions.

