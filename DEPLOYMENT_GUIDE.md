# FitMeal App - Complete Deployment Guide

## 🚀 **System Overview**

Your FitMeal app now includes:
- ✅ **Intelligent Food Recommendations** based on user goals and allergies
- ✅ **Goal-based Filtering** (weight loss, muscle gain, maintenance)
- ✅ **Allergy Management** with automatic ingredient filtering
- ✅ **Personalized Dashboard** with smart recommendations
- ✅ **Admin Panel** for system management
- ✅ **Nutritional Analysis** and calorie tracking

## 📱 **Frontend (Flutter App)**

### Prerequisites
```bash
# Install Flutter SDK
# Install Android Studio / Xcode
# Install VS Code with Flutter extension
```

### Setup & Build
```bash
# Navigate to project directory
cd food_recommendation_app

# Install dependencies
flutter pub get

# Run the app
flutter run

# Build for production
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

### Key Features Implemented

#### 1. **Personalized Recommendation System**
- **File**: `lib/services/recommendation_service.dart`
- **Features**:
  - Goal-based nutrition targets
  - Allergy filtering
  - Meal-type recommendations
  - Nutritional scoring algorithm

#### 2. **Enhanced User Profile**
- **File**: `lib/models/user_profile.dart`
- **Features**:
  - Allergies management
  - Dietary preferences
  - Health conditions
  - Goal tracking

#### 3. **Personalized Dashboard**
- **File**: `lib/screens/personalized_dashboard_screen.dart`
- **Features**:
  - Goal-based recommendations
  - Meal-type filtering
  - Nutrition summaries
  - Allergy warnings

## 🗄️ **Backend (Laravel API)**

### Prerequisites
```bash
# Install PHP 8.1+
# Install Composer
# Install MySQL/PostgreSQL
# Install Laravel
```

### Setup Backend
```bash
cd backend_food_recommendation_app

# Install dependencies
composer install

# Copy environment file
cp .env.example .env

# Generate application key
php artisan key:generate

# Configure database in .env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=fitmeal_db
DB_USERNAME=your_username
DB_PASSWORD=your_password

# Run migrations
php artisan migrate

# Seed database
php artisan db:seed

# Start server
php artisan serve
```

### API Endpoints

#### Authentication
```
POST /api/auth/register
POST /api/auth/login
POST /api/auth/logout
```

#### Recipes
```
GET /api/recipes
GET /api/recipes/{id}
POST /api/recipes
PUT /api/recipes/{id}
DELETE /api/recipes/{id}
```

#### Admin (Protected)
```
GET /api/admin/dashboard
GET /api/admin/users
GET /api/admin/recipes
POST /api/admin/recipes
PUT /api/admin/users/{id}/status
DELETE /api/admin/users/{id}
```

## 🐳 **Docker Deployment (Recommended)**

### 1. **Backend Docker Setup**
```dockerfile
# backend/Dockerfile
FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www
```

### 2. **Docker Compose**
```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: ./backend_food_recommendation_app
    ports:
      - "8000:8000"
    environment:
      - APP_ENV=production
      - APP_DEBUG=false
    volumes:
      - ./backend_food_recommendation_app:/var/www
    depends_on:
      - db
      - redis

  db:
    image: mysql:8.0
    environment:
      MYSQL_DATABASE: fitmeal_db
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_USER: fitmeal_user
      MYSQL_PASSWORD: fitmeal_password
    volumes:
      - mysql_data:/var/lib/mysql
    ports:
      - "3306:3306"

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - app

volumes:
  mysql_data:
```

### 3. **Deploy with Docker**
```bash
# Build and start services
docker-compose up -d

# Run migrations
docker-compose exec app php artisan migrate

# Seed database
docker-compose exec app php artisan db:seed
```

## ☁️ **Cloud Deployment Options**

### 1. **Heroku Deployment**

#### Backend (Laravel)
```bash
# Install Heroku CLI
# Login to Heroku
heroku login

# Create app
heroku create fitmeal-api

# Set environment variables
heroku config:set APP_KEY=your_app_key
heroku config:set DB_CONNECTION=pgsql
heroku config:set DB_HOST=your_db_host
heroku config:set DB_DATABASE=your_db_name
heroku config:set DB_USERNAME=your_db_user
heroku config:set DB_PASSWORD=your_db_password

# Deploy
git push heroku main

# Run migrations
heroku run php artisan migrate
```

#### Frontend (Flutter Web)
```bash
# Build for web
flutter build web --release

# Deploy to Netlify/Vercel
# Upload build/web folder
```

### 2. **AWS Deployment**

#### Backend (EC2 + RDS)
```bash
# Launch EC2 instance
# Install Docker
# Deploy backend with docker-compose
# Create RDS MySQL instance
# Configure security groups
```

#### Frontend (S3 + CloudFront)
```bash
# Build Flutter web
flutter build web --release

# Upload to S3 bucket
# Configure CloudFront distribution
# Set up custom domain
```

### 3. **DigitalOcean Deployment**

#### Backend (Droplet)
```bash
# Create Droplet (Ubuntu 20.04)
# Install Docker
# Clone repository
# Deploy with docker-compose
```

#### Frontend (App Platform)
```bash
# Connect GitHub repository
# Configure build settings
# Deploy automatically
```

## 🔧 **Production Configuration**

### 1. **Environment Variables**
```env
# Backend .env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-api-domain.com

DB_CONNECTION=mysql
DB_HOST=your-db-host
DB_PORT=3306
DB_DATABASE=fitmeal_db
DB_USERNAME=your-username
DB_PASSWORD=your-password

CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis

# Frontend configuration
API_BASE_URL=https://your-api-domain.com/api
```

### 2. **Security Configuration**
```php
// backend/config/cors.php
'allowed_origins' => [
    'https://your-app-domain.com',
    'https://your-admin-domain.com',
],

// backend/config/sanctum.php
'stateful' => [
    'https://your-app-domain.com',
],
```

### 3. **Database Optimization**
```sql
-- Add indexes for better performance
CREATE INDEX idx_recipes_category ON recipes(category);
CREATE INDEX idx_recipes_calories ON recipes(calories_per_serving);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
```

## 📊 **Monitoring & Analytics**

### 1. **Application Monitoring**
```bash
# Install Laravel Telescope (development)
composer require laravel/telescope
php artisan telescope:install

# Install Laravel Horizon (queues)
composer require laravel/horizon
php artisan horizon:install
```

### 2. **Error Tracking**
```bash
# Install Sentry
composer require sentry/sentry-laravel
```

### 3. **Performance Monitoring**
```bash
# Install Laravel Debugbar (development)
composer require barryvdh/laravel-debugbar
```

## 🧪 **Testing & Quality Assurance**

### 1. **Backend Testing**
```bash
# Run tests
php artisan test

# Run specific test suite
php artisan test --testsuite=Feature
```

### 2. **Frontend Testing**
```bash
# Run Flutter tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### 3. **API Testing**
```bash
# Install Postman/Insomnia
# Test all endpoints
# Verify authentication
# Test admin routes
```

## 🚀 **Deployment Checklist**

### Pre-Deployment
- [ ] All tests passing
- [ ] Environment variables configured
- [ ] Database migrations ready
- [ ] SSL certificates obtained
- [ ] Domain names configured
- [ ] CDN setup (optional)

### Deployment Steps
- [ ] Deploy backend first
- [ ] Run database migrations
- [ ] Seed initial data
- [ ] Test API endpoints
- [ ] Deploy frontend
- [ ] Configure CORS
- [ ] Test full integration

### Post-Deployment
- [ ] Monitor application logs
- [ ] Set up error tracking
- [ ] Configure backups
- [ ] Set up monitoring alerts
- [ ] Test user registration
- [ ] Test admin functionality
- [ ] Verify recommendations work

## 📱 **Mobile App Distribution**

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (Google Play)
flutter build appbundle --release

# Upload to Google Play Console
```

### iOS
```bash
# Build for iOS
flutter build ios --release

# Archive in Xcode
# Upload to App Store Connect
```

## 🔄 **Continuous Deployment**

### GitHub Actions
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy Backend
        run: |
          # Deploy Laravel backend
      - name: Deploy Frontend
        run: |
          # Deploy Flutter web
```

## 📈 **Scaling Considerations**

### Backend Scaling
- Use Redis for caching
- Implement database read replicas
- Use CDN for static assets
- Implement API rate limiting
- Use queue workers for heavy tasks

### Frontend Scaling
- Implement code splitting
- Use lazy loading
- Optimize images
- Implement caching strategies
- Use service workers

## 🛡️ **Security Best Practices**

### Backend Security
- Use HTTPS everywhere
- Implement rate limiting
- Validate all inputs
- Use prepared statements
- Implement CSRF protection
- Regular security updates

### Frontend Security
- Validate user inputs
- Use secure storage
- Implement proper authentication
- Regular dependency updates
- Content Security Policy

## 📞 **Support & Maintenance**

### Monitoring
- Set up uptime monitoring
- Monitor API response times
- Track error rates
- Monitor database performance

### Maintenance
- Regular security updates
- Database optimization
- Performance monitoring
- User feedback collection
- Feature updates

## 🎯 **Success Metrics**

### Technical Metrics
- API response time < 200ms
- 99.9% uptime
- Zero critical security issues
- < 1% error rate

### Business Metrics
- User engagement
- Recommendation accuracy
- User satisfaction
- Feature adoption

Your FitMeal app is now ready for production deployment with intelligent food recommendations, comprehensive user management, and scalable architecture!
