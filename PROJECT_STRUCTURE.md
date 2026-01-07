# Project Structure

```
cloudpost-ecommerce/
├── apps/
│   ├── storefront/            # Public storefront/homepage Next.js application
│   │   ├── src/
│   │   │   └── app/           # Next.js App Router
│   │   │       ├── layout.tsx
│   │   │       ├── page.tsx
│   │   │       └── globals.css
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── next.config.js
│   │
│   ├── buyer-portal/          # Buyer account portal Next.js application
│   │   ├── src/
│   │   │   └── app/           # Next.js App Router
│   │   │       ├── layout.tsx
│   │   │       ├── page.tsx
│   │   │       └── globals.css
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── next.config.js
│   │
│   ├── seller-portal/         # Seller-facing Next.js application
│   │   ├── src/
│   │   │   └── app/           # Next.js App Router
│   │   │       ├── layout.tsx
│   │   │       ├── page.tsx
│   │   │       └── globals.css
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── next.config.js
│   │
│   ├── admin-portal/          # Admin-facing Next.js application
│   │   ├── src/
│   │   │   └── app/           # Next.js App Router
│   │   │       ├── layout.tsx
│   │   │       ├── page.tsx
│   │   │       └── globals.css
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── next.config.js
│   │
│   └── backend/               # NestJS API server
│       ├── src/
│       │   ├── auth/          # Authentication module
│       │   │   ├── auth.module.ts
│       │   │   ├── auth.service.ts
│       │   │   ├── auth.controller.ts
│       │   │   └── strategies/
│       │   │       ├── jwt.strategy.ts
│       │   │       └── local.strategy.ts
│       │   ├── users/         # Users module
│       │   ├── products/      # Products module
│       │   ├── orders/        # Orders module
│       │   ├── database/      # Database module
│       │   ├── app.module.ts
│       │   ├── app.controller.ts
│       │   ├── app.service.ts
│       │   └── main.ts
│       ├── package.json
│       ├── tsconfig.json
│       └── nest-cli.json
│
├── packages/
│   ├── shared/                # Shared types and utilities
│   │   ├── src/
│   │   │   ├── types/         # TypeScript types
│   │   │   ├── utils/         # Utility functions
│   │   │   └── index.ts
│   │   ├── package.json
│   │   └── tsconfig.json
│   │
│   └── database/              # Drizzle ORM schema and config
│       ├── src/
│       │   ├── schema/        # Database schemas
│       │   ├── db.ts          # Database connection
│       │   └── index.ts
│       ├── drizzle.config.ts  # Drizzle configuration
│       ├── package.json
│       └── tsconfig.json
│
├── database/                  # SQL files
│   ├── schema.sql             # Database schema
│   └── README.md
│
├── package.json               # Root package.json (monorepo)
├── turbo.json                 # Turborepo configuration
├── railway.json               # Railway deployment config
├── .gitignore
├── .nvmrc                     # Node version
├── .eslintrc.json
├── .prettierrc
└── README.md
```

## Port Configuration

- **Storefront** (Homepage): http://localhost:3000
- **Buyer Portal**: http://localhost:3004
- **Seller Portal**: http://localhost:3002
- **Admin Portal**: http://localhost:3003
- **Backend API**: http://localhost:3001/api

## Next Steps

1. **Generate Drizzle Schemas**: Run `drizzle-kit introspect` to generate TypeScript schemas from your MySQL database
2. **Set up Environment Variables**: Copy `.env.example` to `.env` and configure
3. **Install Dependencies**: Run `npm install` in the root directory
4. **Start Development**: Run `npm run dev` to start all services

