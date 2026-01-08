# Backend Environment Variables Setup

This guide explains how to configure environment variables for the backend service.

## Quick Start

1. Copy the example file:
   ```bash
   cp .env.example .env.local
   ```

2. Edit `.env.local` with your actual values (see below)

## Required Environment Variables

### Database Configuration

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `DB_HOST` | MySQL database host | `localhost` | `localhost` or `mysql.railway.app` |
| `DB_PORT` | MySQL database port | `3306` | `3306` |
| `DB_USER` | MySQL database username | - | `root` |
| `DB_PASSWORD` | MySQL database password | - | `your_password` |
| `DB_NAME` | MySQL database name | `cloudpost_db` | `cloudpost_db` |

### JWT Configuration

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `JWT_SECRET` | Secret key for signing JWT tokens | `your-secret-key` | Generate with: `openssl rand -base64 32` |
| `JWT_EXPIRES_IN` | JWT token expiration time | `7d` | `7d`, `24h`, `1h` |

### Server Configuration

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `BACKEND_PORT` | Port for the backend server | `3001` | `3001` |
| `NODE_ENV` | Node environment | `development` | `development`, `production` |

### CORS URLs (Optional - for production)

These are only needed when deploying to production and configuring CORS:

| Variable | Description | Example |
|----------|-------------|---------|
| `STOREFRONT_URL` | Storefront application URL | `https://your-storefront.railway.app` |
| `SELLER_PORTAL_URL` | Seller portal application URL | `https://your-seller-portal.railway.app` |
| `BUYER_PORTAL_URL` | Buyer portal application URL | `https://your-buyer-portal.railway.app` |
| `ADMIN_PORTAL_URL` | Admin portal application URL | `https://your-admin-portal.railway.app` |
| `RAILWAY_PUBLIC_DOMAIN` | Railway public domain for backend | `your-backend.railway.app` |

## Local Development Setup

1. **Create `.env.local` file:**
   ```bash
   cp .env.example .env.local
   ```

2. **Update database credentials:**
   - Set `DB_PASSWORD` to your local MySQL password
   - Ensure `DB_NAME` matches your database name

3. **Generate a secure JWT secret:**
   ```bash
   openssl rand -base64 32
   ```
   Copy the output and set it as `JWT_SECRET` in `.env.local`

4. **Start the backend:**
   ```bash
   npm run dev
   ```

## Production Setup (Railway)

When deploying to Railway, set these environment variables in the Railway dashboard:

### Database Variables (Use Variable References)

In Railway, use **Variable References** to link MySQL service variables:

| Backend Variable | Reference From MySQL Service |
|-----------------|------------------------------|
| `DB_HOST` | `MYSQL_HOST` |
| `DB_PORT` | `MYSQL_PORT` |
| `DB_USER` | `MYSQLUSER` |
| `DB_PASSWORD` | `MYSQLPASSWORD` |
| `DB_NAME` | `MYSQLDATABASE` |

### Direct Variables

Set these directly (not as references):

```
JWT_SECRET=<generate-a-secure-random-string>
JWT_EXPIRES_IN=7d
NODE_ENV=production
```

### CORS URLs

After deploying frontend services, add their URLs:

```
STOREFRONT_URL=https://your-storefront.railway.app
SELLER_PORTAL_URL=https://your-seller-portal.railway.app
BUYER_PORTAL_URL=https://your-buyer-portal.railway.app
ADMIN_PORTAL_URL=https://your-admin-portal.railway.app
```

## Security Notes

- **Never commit `.env.local`** - It's already in `.gitignore`
- **Use strong JWT secrets** - Generate with `openssl rand -base64 32`
- **Use different secrets** for development and production
- **Keep database credentials secure** - Never expose them in logs or version control

## File Priority

The backend uses `@nestjs/config` which loads environment variables in this order:
1. `.env.local` (highest priority)
2. `.env`

Variables set in the system environment will override file-based variables.

## Troubleshooting

### Database Connection Issues

- Verify MySQL is running: `mysql -u root -p`
- Check database exists: `SHOW DATABASES;`
- Verify credentials match your MySQL setup
- Check firewall/network settings if using remote database

### JWT Authentication Issues

- Ensure `JWT_SECRET` is set and matches across all services
- Verify `JWT_EXPIRES_IN` format is correct (e.g., `7d`, `24h`)
- Check token expiration hasn't passed

### CORS Issues

- Add frontend URLs to backend CORS configuration
- Ensure URLs include protocol (`https://` or `http://`)
- Check that credentials are enabled in frontend API calls

