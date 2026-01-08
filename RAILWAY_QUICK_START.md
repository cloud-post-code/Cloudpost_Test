# Railway Quick Start Guide

## Automatic Database Migration on Railway

This guide shows you how to automatically run `database/schema.sql` when you deploy to Railway.

## Step-by-Step Instructions

### 1. Create MySQL Service
1. Go to Railway dashboard → New Project
2. Click "New Service" → Select **"MySQL"**
3. Railway will automatically create the MySQL database
4. Note: Railway provides these environment variables automatically:
   - `MYSQL_HOST`
   - `MYSQL_PORT` 
   - `MYSQLUSER` (note: no underscore)
   - `MYSQLPASSWORD` (note: no underscore)
   - `MYSQLDATABASE` (or `MYSQL_DATABASE` - Railway may provide both)
   - `MYSQL_URL` (connection string)
   - `MYSQL_ROOT_PASSWORD`

### 2. Create Database Migration Service
1. In the same project, click "New Service" → Select **"GitHub Repo"** (or "Empty Service")
2. Name it: **"Database Migration"**
3. Configure the service:
   - **Root Directory**: `migration` (important: use the migration directory)
   - **Build Command**: `npm install`
   - **Start Command**: `npm start` (or `node migrate.js`)
   - **Service Type**: One-off (exits after completion)

   **Note**: The `migration/` directory contains a minimal `package.json` with only `mysql2` dependency, avoiding workspace protocol issues.

### 3. Link MySQL Variables
1. Go to Migration service → Settings → Variables
2. Click "Add Variable" → "Reference Variable"
3. Select your MySQL service and add references for:
   - `MYSQL_HOST`
   - `MYSQL_PORT`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`
   - `MYSQLDATABASE`

   **OR** Railway may auto-link these if services are in the same project.

### 4. Deploy Migration Service
1. Click "Deploy" on the Migration service
2. Watch the logs - you should see:

**First Run (Empty Database):**
   ```
   ==========================================
   Cloudpost Database Migration
   ==========================================
   MySQL Host: [your-host]
   MySQL Port: 3306
   Database: [your-database]
   User: [your-user]
   
   Waiting for MySQL to be ready...
   ✓ MySQL is ready!
   Connecting to database...
   Database 'cloudpost_db' does not exist. Creating...
   ✓ Database 'cloudpost_db' created
   Reading schema file...
   Running database schema migration...
   This may take a few minutes...
   
   ==========================================
   ✓ Database migration completed successfully!
   ==========================================
   Tables created: [number]
   
   Migration service can now be stopped/deleted.
   Your database is ready to use!
   ```

**Subsequent Runs (Database Already Exists):**
If you run the migration again, it will detect existing tables and skip:
   ```
   ⚠️  Tables already exist in the database!
   Found [number] existing table(s).
   
   Skipping migration to prevent errors.
   
   ✓ Migration skipped - database already initialized
   ```

3. Once you see "✓ Database migration completed successfully!" or "✓ Migration skipped", you're done
4. You can now delete the migration service (or keep it for future migrations)

### 5. Verify Migration
1. Go to MySQL service → Data → MySQL Console
2. Run: `SHOW TABLES;`
3. You should see all tables (tbl_users, tbl_admin, tbl_user_credentials, etc.)

### 6. Create Backend Service
Now you can create your backend service - it will connect to the migrated database!

## Troubleshooting

### "mysql2 package not found"
- Make sure `npm install` runs successfully
- Check that `mysql2` is in `package.json` dependencies

### "MySQL environment variables not set"
- Verify MySQL service is linked
- Check that variables are referenced correctly
- Railway should auto-provide these if services are in same project

### Migration takes a long time
- Large schema files (5000+ lines) can take 5-10 minutes
- This is normal - don't cancel the migration
- Watch logs for progress

### "Schema file not found"
- Verify `database/schema.sql` exists in your repository
- Check Root Directory setting (should be empty/root)

### "Tables already exist" - Migration Skipped
- This is **normal and expected** if you run migration twice
- The script automatically detects existing tables and skips migration
- This prevents errors from trying to create tables that already exist
- If you need to re-run migration:
  - Drop tables manually, OR
  - Use a fresh database, OR  
  - Set `FORCE_MIGRATE=true` environment variable (will fail if tables exist)

## Next Steps

After migration completes:
1. ✅ Database is ready
2. Create Backend service (see `RAILWAY_DEPLOYMENT.md`)
3. Create Frontend services
4. Configure environment variables
5. Deploy!

## Alternative: Manual Migration

If you prefer to run manually:
1. Go to MySQL service → Data → MySQL Console  
2. Copy entire contents of `database/schema.sql`
3. Paste and execute
4. Verify with `SHOW TABLES;`

