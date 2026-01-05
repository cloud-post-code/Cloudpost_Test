# Cloudpost Platform

Modern e-commerce dashboard platform built with Next.js, NestJS, PostgreSQL, and Drizzle ORM.

## Architecture

```
platform/
├── packages/
│   ├── database/          # Shared Drizzle schema & migrations
│   ├── shared/            # Shared types, utilities
│   └── ui/                # Shared UI components
├── apps/
│   ├── dashboard/         # Next.js dashboard frontend
│   └── api/               # NestJS backend API
```

## Tech Stack

- **Frontend**: Next.js 14+ (App Router) with TypeScript
- **Backend**: NestJS with TypeScript
- **Database**: PostgreSQL with Drizzle ORM
- **UI**: Tailwind CSS with shadcn/ui components
- **Monorepo**: Turborepo

## Prerequisites

- Node.js 18+ and npm 9+
- PostgreSQL 14+

## Setup

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Set up environment variables**:
   Create `.env` files in:
   - `apps/api/.env` - API environment variables
   - `apps/dashboard/.env.local` - Dashboard environment variables
   - `packages/database/.env` - Database connection

   Required variables:
   ```
   DATABASE_URL=postgresql://user:password@localhost:5432/cloudpost
   PORT=3001
   FRONTEND_URL=http://localhost:3000
   ```

3. **Run database migrations**:
   ```bash
   cd packages/database
   npm run db:generate
   npm run db:migrate
   ```

4. **Seed database** (optional):
   ```bash
   cd packages/database
   npm run db:seed
   ```

5. **Start development servers**:
   ```bash
   # From root directory
   npm run dev
   ```

   This will start:
   - Dashboard: http://localhost:3000
   - API: http://localhost:3001
   - API Docs: http://localhost:3001/api/docs

## Project Structure

### Packages

- **@cloudpost/database**: Database schema, migrations, and seed scripts
- **@cloudpost/shared**: Shared TypeScript types and utilities
- **@cloudpost/ui**: Shared UI components

### Apps

- **@cloudpost/dashboard**: Next.js dashboard application
- **@cloudpost/api**: NestJS REST API

## Available Scripts

- `npm run dev` - Start all apps in development mode
- `npm run build` - Build all packages and apps
- `npm run lint` - Lint all packages
- `npm run type-check` - Type check all packages

## Database Schema

The database schema is defined in `packages/database/src/schema/` using Drizzle ORM. Key tables include:

- **Users**: User accounts and credentials
- **Products**: Product catalog
- **Orders**: Order management
- **Shops**: Seller shop information
- **Addresses**: User addresses
- **Transactions**: Wallet transactions

See `packages/database/src/schema/` for complete schema definitions.

## API Documentation

API documentation is available at `/api/docs` when the API server is running. It includes:

- Shop management endpoints
- Product CRUD operations
- Order management
- Inventory management
- Wallet operations
- Account management

## Deployment

### Railway

1. Connect your GitHub repository to Railway
2. Add PostgreSQL service
3. Set environment variables in Railway dashboard
4. Deploy both dashboard and API services

The `railway.json` file contains deployment configuration.

## Development Notes

- Authentication is currently a placeholder and will be implemented later
- All features mirror the old PHP site functionality
- Synthetic data seeder generates test users, products, and orders
- Focus is on Seller Dashboard features first

## License

Private - All rights reserved

