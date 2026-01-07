# Cloudpost E-Commerce Platform

A third-party e-commerce platform built with TypeScript, Next.js, NestJS, MySQL, and Drizzle ORM.

## Tech Stack

- **Language**: TypeScript
- **Frontend**: Next.js 14 (App Router)
- **Backend**: NestJS
- **Database**: MySQL
- **ORM**: Drizzle
- **Deployment**: Railway
- **Monorepo**: Turborepo

## Project Structure

```
cloudpost-ecommerce/
├── apps/
│   ├── storefront/        # Public storefront/homepage (Port 3000)
│   ├── buyer-portal/      # Buyer account portal (Port 3004)
│   ├── seller-portal/     # Seller portal (Port 3002)
│   ├── admin-portal/      # Admin portal (Port 3003)
│   └── backend/           # NestJS API server (Port 3001)
├── packages/
│   ├── shared/            # Shared types and utilities
│   └── database/          # Drizzle schema and migrations
└── database/              # SQL schema files
```

## Quick Start

See [SETUP.md](./SETUP.md) for detailed setup instructions.

### Prerequisites

- Node.js >= 18.0.0
- npm >= 9.0.0
- MySQL >= 8.0

### Installation

1. Install dependencies:
```bash
npm install
```

2. Set up database:
```bash
mysql -u root -p < database/schema.sql
```

3. Create `.env` file with your database credentials (see SETUP.md)

4. Generate Drizzle schemas:
```bash
cd packages/database
npm run introspect
```

5. Start development servers:
```bash
npm run dev
```

## Development URLs

- **Storefront** (Homepage): http://localhost:3000
- **Buyer Portal**: http://localhost:3004
- **Seller Portal**: http://localhost:3002
- **Admin Portal**: http://localhost:3003
- **Backend API**: http://localhost:3001/api

## Available Scripts

- `npm run dev` - Start all services in development mode
- `npm run build` - Build all services for production
- `npm run start` - Start all services in production mode
- `npm run lint` - Lint all services
- `npm run type-check` - Type check all TypeScript files

## Documentation

- [SETUP.md](./SETUP.md) - Detailed setup instructions
- [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) - Project structure overview

## Deployment

This project is configured for Railway deployment. See `railway.json` for configuration details.

1. Connect your repository to Railway
2. Set environment variables in Railway dashboard
3. Deploy!

