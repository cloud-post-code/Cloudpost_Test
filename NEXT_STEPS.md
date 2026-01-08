# Next Steps - After MySQL Database Setup ✅

Great progress! You've already set up:
- ✅ Database connection
- ✅ User authentication (login/register)
- ✅ Admin authentication
- ✅ Basic Drizzle schemas (users, admin, auth tokens)

## 🎯 Immediate Next Steps

### 1. Complete Drizzle Schema Generation

Generate schemas for the remaining critical tables:

```bash
cd packages/database
npm run introspect
```

This will auto-generate TypeScript schemas for ALL tables in your database. After running, review `packages/database/src/schema/index.ts` to see all generated schemas.

**Priority tables you'll need:**
- `tbl_products` - Products catalog
- `tbl_seller_products` - Seller product listings
- `tbl_orders` - Orders
- `tbl_order_products` - Order items
- `tbl_product_categories` - Categories
- `tbl_addresses` - User addresses
- `tbl_cart` or `tbl_abandoned_cart` - Shopping cart

### 2. Build Product Endpoints

Create product listing and details endpoints:

**Update Products Service:**
```typescript
// apps/backend/src/products/products.service.ts
import { Injectable, Inject } from '@nestjs/common';
import { MySql2Database } from 'drizzle-orm/mysql2';
import { eq, desc, and } from 'drizzle-orm';
// Import after schema generation:
// import { products, sellerProducts, productCategories } from '@cloudpost/database/schema';

@Injectable()
export class ProductsService {
  constructor(@Inject('DRIZZLE_DB') private db: MySql2Database<any>) {}

  async findAll(limit = 20, offset = 0, categoryId?: number) {
    // TODO: Implement after schema generation
    // Example:
    // let query = this.db.select().from(products);
    // if (categoryId) {
    //   query = query.where(eq(products.categoryId, categoryId));
    // }
    // return query.limit(limit).offset(offset);
    return [];
  }

  async findOne(id: number) {
    // TODO: Implement after schema generation
    return null;
  }

  async findByCategory(categoryId: number) {
    // TODO: Implement after schema generation
    return [];
  }
}
```

### 3. Build Order Endpoints

Create order management endpoints:

**Update Orders Service:**
```typescript
// apps/backend/src/orders/orders.service.ts
import { Injectable, Inject } from '@nestjs/common';
import { MySql2Database } from 'drizzle-orm/mysql2';
import { eq, desc } from 'drizzle-orm';
// Import after schema generation:
// import { orders, orderProducts } from '@cloudpost/database/schema';

@Injectable()
export class OrdersService {
  constructor(@Inject('DRIZZLE_DB') private db: MySql2Database<any>) {}

  async findByUserId(userId: number) {
    // TODO: Implement after schema generation
    // return this.db
    //   .select()
    //   .from(orders)
    //   .where(eq(orders.userId, userId))
    //   .orderBy(desc(orders.orderDate));
    return [];
  }

  async findOne(orderId: number, userId?: number) {
    // TODO: Implement after schema generation
    return null;
  }

  async create(orderData: any) {
    // TODO: Implement order creation with transaction
    return null;
  }
}
```

### 4. Test Your Backend API

Test the endpoints you've built:

```bash
# Start backend
cd apps/backend
npm run dev

# In another terminal, test endpoints:
# Health check
curl http://localhost:3001/api/health

# Test database connection (add this endpoint if not exists)
curl http://localhost:3001/api/test-db

# Test login (replace with actual credentials from your DB)
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password"}'
```

### 5. Add Missing Endpoints

Update your controllers to expose all needed endpoints:

**Auth Controller** - Add register endpoint:
```typescript
// apps/backend/src/auth/auth.controller.ts
@Post('register')
async register(@Body() registerDto: RegisterDto) {
  return this.authService.register(registerDto);
}

@Post('admin/login')
async adminLogin(@Body() loginDto: AdminLoginDto) {
  // Use admin validation
}
```

**Products Controller** - Add search/filter:
```typescript
// apps/backend/src/products/products.controller.ts
@Get('search')
async search(@Query('q') query: string) {
  return this.productsService.search(query);
}

@Get('categories/:id/products')
async findByCategory(@Param('id') id: string) {
  return this.productsService.findByCategory(+id);
}
```

### 6. Connect Frontend to Backend

Set up API clients in your frontend apps:

**Create API Client:**
```typescript
// packages/shared/src/api/client.ts
import axios from 'axios';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001/api';

export const apiClient = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true,
});

// Add auth token to requests
apiClient.interceptors.request.use((config) => {
  if (typeof window !== 'undefined') {
    const token = localStorage.getItem('access_token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
  }
  return config;
});

// Handle auth errors
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Redirect to login
      if (typeof window !== 'undefined') {
        localStorage.removeItem('access_token');
        window.location.href = '/login';
      }
    }
    return Promise.reject(error);
  }
);
```

**Use in Storefront:**
```typescript
// apps/storefront/src/app/products/page.tsx
'use client';

import { useEffect, useState } from 'react';
import { apiClient } from '@cloudpost/shared/api/client';

export default function ProductsPage() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    apiClient.get('/products').then((res) => {
      setProducts(res.data);
    });
  }, []);

  return (
    <div>
      {products.map((product) => (
        <div key={product.id}>{product.name}</div>
      ))}
    </div>
  );
}
```

### 7. Add Validation DTOs

Create DTOs for request validation:

```typescript
// apps/backend/src/auth/dto/register.dto.ts
import { IsEmail, IsString, MinLength } from 'class-validator';

export class RegisterDto {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(3)
  username: string;

  @IsString()
  @MinLength(6)
  password: string;

  @IsString()
  name: string;
}
```

### 8. Testing Checklist

- [ ] Run `npm run introspect` to generate all schemas
- [ ] Test database connection endpoint
- [ ] Test user registration endpoint
- [ ] Test user login endpoint
- [ ] Test admin login endpoint
- [ ] Test product listing endpoint
- [ ] Test order creation endpoint
- [ ] Verify CORS is working for all portals
- [ ] Test frontend API calls from storefront

### 9. Quick Commands Reference

```bash
# Generate all Drizzle schemas from database
cd packages/database
npm run introspect

# Start all services
npm run dev

# Start individual services
cd apps/backend && npm run dev
cd apps/storefront && npm run dev
cd apps/buyer-portal && npm run dev

# Type check
npm run type-check

# Build for production
npm run build

# Test API endpoints
curl http://localhost:3001/api/health
```

## 🚀 Recommended Development Order

1. **Generate Schemas** → `cd packages/database && npm run introspect`
2. **Review Generated Schemas** → Check `packages/database/src/schema/index.ts`
3. **Build Product Endpoints** → Products service + controller
4. **Build Order Endpoints** → Orders service + controller  
5. **Test Backend APIs** → Use Postman or curl
6. **Connect Frontends** → Add API clients to frontend apps
7. **Add Error Handling** → Proper error responses
8. **Add Validation** → DTOs with class-validator
9. **Add Tests** → Unit and integration tests

## 📝 Notes

- Your authentication is already working! ✅
- Your database connection is set up! ✅
- Focus on generating schemas and building product/order endpoints next
- Use Drizzle Studio to explore your database: `cd packages/database && npm run studio`

Let me know when you've generated the schemas and I can help you build the product/order endpoints!
