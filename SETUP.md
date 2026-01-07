# Setup Guide

This guide will help you set up the Cloudpost E-Commerce platform for development.

## Prerequisites

- **Node.js** >= 18.0.0
- **npm** >= 9.0.0
- **MySQL** >= 8.0
- **Git**

## Step 1: Install Dependencies

Install all dependencies for the monorepo:

```bash
npm install
```

This will install dependencies for all workspaces (apps and packages).

## Step 2: Database Setup

### 2.1 Create MySQL Database

```bash
mysql -u root -p
```

Then in MySQL:

```sql
CREATE DATABASE IF NOT EXISTS cloudpost_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
EXIT;
```

### 2.2 Import Schema

```bash
mysql -u root -p cloudpost_db < database/schema.sql
```

### 2.3 Import Data (Optional)

```bash
mysql -u root -p cloudpost_db < database/data.sql
```

## Step 3: Environment Variables

Create a `.env` file in the root directory:

```bash
# Database
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=cloudpost_db

# Backend
BACKEND_PORT=3001
NODE_ENV=development

# Frontend
NEXT_PUBLIC_API_URL=http://localhost:3001/api

# JWT
JWT_SECRET=your-secret-key-change-in-production
JWT_EXPIRES_IN=7d
```

## Step 4: Generate Drizzle Schemas

Generate TypeScript schemas from your MySQL database:

```bash
cd packages/database
npm run generate
```

This will introspect your database and generate Drizzle schema files.

## Step 5: Start Development Servers

From the root directory:

```bash
npm run dev
```

This will start all services:
- Storefront (Homepage): http://localhost:3000
- Buyer Portal: http://localhost:3004
- Seller Portal: http://localhost:3002
- Admin Portal: http://localhost:3003
- Backend API: http://localhost:3001/api

## Individual Service Commands

You can also run services individually:

```bash
# Backend only
cd apps/backend
npm run dev

# Storefront (Homepage) only
cd apps/storefront
npm run dev

# Buyer Portal only
cd apps/buyer-portal
npm run dev

# Seller Portal only
cd apps/seller-portal
npm run dev

# Admin Portal only
cd apps/admin-portal
npm run dev
```

## Building for Production

```bash
npm run build
```

## Type Checking

```bash
npm run type-check
```

## Linting

```bash
npm run lint
```

## Railway Deployment

1. Connect your repository to Railway
2. Railway will automatically detect the `railway.json` configuration
3. Set environment variables in Railway dashboard
4. Deploy!

## Troubleshooting

### Database Connection Issues

- Verify MySQL is running: `mysql -u root -p`
- Check database credentials in `.env`
- Ensure database exists: `SHOW DATABASES;`

### Port Already in Use

- Change ports in respective `package.json` files
- Update CORS settings in `apps/backend/src/main.ts`

### Module Resolution Errors

- Run `npm install` from root directory
- Clear node_modules and reinstall: `rm -rf node_modules && npm install`

