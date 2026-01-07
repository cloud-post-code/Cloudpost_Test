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

### Environment Variables

Set these in Railway for the backend service:

```
DB_HOST=<railway-mysql-host>
DB_PORT=3306
DB_USER=<railway-mysql-user>
DB_PASSWORD=<railway-mysql-password>
DB_NAME=<railway-mysql-database>
JWT_SECRET=<generate-a-secure-random-string>
JWT_EXPIRES_IN=7d
NODE_ENV=production
BACKEND_PORT=3001
```

### CORS URLs (Optional)

If you want to restrict CORS, add:

```
STOREFRONT_URL=https://your-storefront.railway.app
SELLER_PORTAL_URL=https://your-seller-portal.railway.app
BUYER_PORTAL_URL=https://your-buyer-portal.railway.app
ADMIN_PORTAL_URL=https://your-admin-portal.railway.app
```

### Build Settings

- **Root Directory**: `apps/backend`
- **Build Command**: `npm install && npm run build`
- **Start Command**: `npm start`

## Step 4: Frontend Services Configuration

For each frontend service (seller-portal, buyer-portal, admin-portal, storefront):

### Environment Variables

```
NEXT_PUBLIC_API_URL=https://your-backend.railway.app/api
NODE_ENV=production
```

### Build Settings

- **Root Directory**: `apps/<service-name>`
- **Build Command**: `npm install && npm run build`
- **Start Command**: `npm start`

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
- Check environment variables are set correctly
- Ensure database name matches in connection string

### CORS Errors

- Add frontend URLs to backend CORS configuration
- Check that `NEXT_PUBLIC_API_URL` is set correctly in frontend services

### Build Failures

- Check that all dependencies are installed
- Verify Node.js version (>= 18.0.0)
- Check build logs for specific errors

### Authentication Issues

- Verify JWT_SECRET is set in backend
- Check that cookies are being set correctly
- Ensure API routes are proxying correctly

## Notes

- The `railway.json` file in the root provides default build/deploy settings
- Each service can override these settings in Railway dashboard
- Use Railway's environment variable linking to share database credentials between services
- Monitor logs in Railway dashboard for debugging

