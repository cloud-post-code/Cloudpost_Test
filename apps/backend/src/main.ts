import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  // Enable CORS
  const allowedOrigins = [
      'http://localhost:3000', // Storefront (main homepage)
      'http://localhost:3002', // Seller portal
      'http://localhost:3003', // Admin portal
      'http://localhost:3004', // Buyer portal
    ];
  
  // Add Railway domains if provided
  if (process.env.RAILWAY_PUBLIC_DOMAIN) {
    allowedOrigins.push(`https://${process.env.RAILWAY_PUBLIC_DOMAIN}`);
  }
  if (process.env.STOREFRONT_URL) {
    allowedOrigins.push(process.env.STOREFRONT_URL);
  }
  if (process.env.SELLER_PORTAL_URL) {
    allowedOrigins.push(process.env.SELLER_PORTAL_URL);
  }
  if (process.env.BUYER_PORTAL_URL) {
    allowedOrigins.push(process.env.BUYER_PORTAL_URL);
  }
  if (process.env.ADMIN_PORTAL_URL) {
    allowedOrigins.push(process.env.ADMIN_PORTAL_URL);
  }

  app.enableCors({
    origin: allowedOrigins,
    credentials: true,
  });

  // Global validation pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  // API prefix
  app.setGlobalPrefix('api');

  // Enable graceful shutdown
  app.enableShutdownHooks();

  const port = process.env.BACKEND_PORT || 3001;
  await app.listen(port);
  console.log(`Backend API running on http://localhost:${port}/api`);
}

bootstrap();

