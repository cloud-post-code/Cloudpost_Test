# Railway Deployment Guide

This guide will help you deploy the Cloudpost application to Railway.

## Prerequisites

- Railway account
- GitHub repository connected to Railway
- MySQL database (Railway provides MySQL service)

## Step 1: Create Railway Services

You'll need to create the following services in Railway:

1. **MySQL Database** - For the database
2. **Backend** - NestJS API server
3. **Seller Portal** - Next.js app (port 3002)
4. **Buyer Portal** - Next.js app (port 3004)
5. **Admin Portal** - Next.js app (port 3003)
6. **Storefront** - Next.js app (port 3000)

## Step 2: Database Setup

### Option A: Automatic Migration Service (Recommended)

1. Create a MySQL service in Railway
2. Create a new service called "Database Migration"
3. Configure the migration service:
   - **Root Directory**: Root (or leave empty)
   - **Build Command**: `cd scripts && npm install`
   - **Start Command**: `cd scripts && node railway-migrate.js`
   - **Environment Variables**: Link MySQL service variables (Railway will auto-provide: `MYSQL_HOST`, `MYSQL_PORT`, `MYSQLUSER`, `MYSQLPASSWORD`, `MYSQLDATABASE`)
4. Deploy the migration service - it will run once and initialize the database
5. After migration completes, you can delete this service (or keep it for future migrations)

**See `RAILWAY_MIGRATION_SETUP.md` for detailed step-by-step instructions.**

### Option B: Using Railway MySQL Console

1. Create a MySQL service in Railway
2. Go to the MySQL service → Data → MySQL Console
3. Copy and paste the entire contents of `database/schema.sql`
4. Execute the script

### Option C: Backend Auto-Migration (Alternative)

The backend can check and run migrations on startup. Add this to your backend service:

**Environment Variables:**
```
AUTO_MIGRATE=true
```

**Note**: This requires installing `mysql` client in the backend service, which may not be ideal.

### Recommended: Option A

Use the migration service approach - it's clean, runs once, and you can verify it completed successfully before starting other services.

## Step 3: Backend Service Configuration

### Build Settings

- **Root Directory**: (empty/root) - **Important**: Leave empty to use workspace commands
- **Build Command**: `npm install && npm run build --workspace=@cloudpost/backend`
- **Start Command**: `npm start --workspace=@cloudpost/backend`

### Environment Variables

**Important**: This is a monorepo using npm workspaces. You must use **Variable References** to link MySQL variables.

1. Go to Backend service → Settings → Variables
2. Click "+ New Variable" → "Reference Variable"
3. Select your MySQL service and create these references:

| Backend Variable Name | Reference From MySQL Service |
|----------------------|------------------------------|
| `DB_HOST` | `MYSQL_HOST` |
| `DB_PORT` | `MYSQL_PORT` |
| `DB_USER` | `MYSQLUSER` |
| `DB_PASSWORD` | `MYSQLPASSWORD` |
| `DB_NAME` | `MYSQLDATABASE` (or `MYSQL_DATABASE`) |

**Note**: Railway provides MySQL variables with names like `MYSQL_HOST`, `MYSQLUSER`, `MYSQLPASSWORD`, `MYSQLDATABASE`. Use Variable References to map them to the backend's expected names (`DB_HOST`, `DB_USER`, etc.).

4. Add these variables directly (not referenced):

```
JWT_SECRET=<generate-a-secure-random-string>
JWT_EXPIRES_IN=7d
NODE_ENV=production
```

**To generate JWT_SECRET**: Use `openssl rand -base64 32` or any secure random string generator.

### CORS URLs (Optional)

After deploying frontend services, add these to Backend environment variables:

```
STOREFRONT_URL=https://your-storefront.railway.app
SELLER_PORTAL_URL=https://your-seller-portal.railway.app
BUYER_PORTAL_URL=https://your-buyer-portal.railway.app
ADMIN_PORTAL_URL=https://your-admin-portal.railway.app
```

## Step 4: Frontend Services Configuration

For each frontend service (seller-portal, buyer-portal, admin-portal, storefront):

### Build Settings

- **Root Directory**: (empty/root) - **Important**: Leave empty to use workspace commands
- **Build Command**: `npm install && npm run build --workspace=@cloudpost/<service-name>`
- **Start Command**: `npm start --workspace=@cloudpost/<service-name>`

**Workspace names:**
- Storefront: `@cloudpost/storefront`
- Seller Portal: `@cloudpost/seller-portal`
- Buyer Portal: `@cloudpost/buyer-portal`
- Admin Portal: `@cloudpost/admin-portal`

### Environment Variables

Add these directly in each frontend service:

```
NEXT_PUBLIC_API_URL=https://your-backend.railway.app/api
NODE_ENV=production
```

**Note**: Replace `your-backend.railway.app` with your actual Backend service Railway domain (found in Backend service → Settings → Networking).

## Step 5: Service Dependencies

In Railway, configure service dependencies:
- All frontend services depend on the backend service
- Backend service depends on MySQL service

## Step 6: Custom Domains (Optional)

1. Go to each service settings
2. Add a custom domain
3. Update `NEXT_PUBLIC_API_URL` in frontend services to use the backend domain
4. Update CORS settings in backend to include the new domains

## Step 7: Verify Deployment

1. Check backend health: `https://your-backend.railway.app/api`
2. Test seller portal: `https://your-seller-portal.railway.app`
3. Test buyer portal: `https://your-buyer-portal.railway.app`
4. Test admin portal: `https://your-admin-portal.railway.app`
5. Test storefront: `https://your-storefront.railway.app`

## Troubleshooting

### Database Connection Issues

- Verify MySQL service is running
- **Check Variable References**: Ensure you used "Reference Variable" (not copied values) to link MySQL variables
- Verify variable names match exactly (`DB_HOST` references `MYSQL_HOST`, `DB_USER` references `MYSQLUSER`, etc.)
- Check that `DB_NAME` references `MYSQLDATABASE` (or `MYSQL_DATABASE` if that's what Railway shows)
- Ensure database name matches in connection string

### CORS Errors

- Add frontend URLs to backend CORS configuration
- Check that `NEXT_PUBLIC_API_URL` is set correctly in frontend services

### Build Failures

- **Monorepo Issues**: Ensure Root Directory is empty (root) for all services, not `apps/backend` or `apps/storefront`
- **Workspace Dependencies**: Verify you're using workspace build commands (`--workspace=@cloudpost/...`)
- Check that all dependencies are installed at root level
- Verify Node.js version (>= 18.0.0)
- Check build logs for specific errors
- If workspace dependencies fail, ensure `npm install` runs at root before building

### Authentication Issues

- Verify JWT_SECRET is set in backend
- Check that cookies are being set correctly
- Ensure API routes are proxying correctly

## Notes

- **Monorepo Setup**: This project uses npm workspaces. All services must use Root Directory = empty (root) and workspace build commands
- The `railway.json` file in the root provides default build/deploy settings
- Each service can override these settings in Railway dashboard
- **Variable References**: Always use Railway's "Reference Variable" feature to link MySQL variables - never copy/paste values
- Railway automatically provides `PORT` environment variable - your apps will use it automatically
- Monitor logs in Railway dashboard for debugging
- Workspace dependencies (`@cloudpost/database`, `@cloudpost/shared`) are resolved when building from root

