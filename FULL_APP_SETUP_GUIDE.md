# 🍽️ Food Recommendation App - Complete Setup Guide

## 📋 Prerequisites

### Required Software:
- **PHP 8.1+** with extensions: BCMath, Ctype, JSON, Mbstring, OpenSSL, PDO, Tokenizer, XML
- **Composer** (PHP dependency manager)
- **MySQL 8.0+** or **MariaDB 10.3+**
- **Flutter SDK 3.0+**
- **Node.js 16+** (for Laravel Mix)
- **Git**

## 🚀 Backend Setup (Laravel)

### 1. Database Setup
```bash
# Create MySQL database
mysql -u root -p
CREATE DATABASE food_recommendation;
exit
```

### 2. Laravel Configuration
```bash
# Navigate to backend directory
cd backend_food_recommendation_app

# Install dependencies
composer install

# Create .env file
cp .env.example .env

# Edit .env file with your database credentials
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=food_recommendation
DB_USERNAME=root
DB_PASSWORD=Qwerty@123

# Generate application key
php artisan key:generate

# Run migrations
php artisan migrate

# Seed the database
php artisan db:seed
```

### 3. Start Backend Server
```bash
php artisan serve
```
The API will be available at `http://localhost:8000`

## 📱 Frontend Setup (Flutter)

### 1. Install Dependencies
```bash
# From project root directory
flutter pub get
```

### 2. Run the App
```bash
flutter run
```

## 🗄️ Database Structure

### Tables Created:
- `users` - User accounts and profiles
- `recipes` - Filipino recipe collection
- `ingredients` - Recipe ingredients
- `recipe_ingredients` - Recipe-ingredient relationships
- `meal_plans` - User meal plans
- `meal_plan_items` - Individual meal plan items
- `health_conditions` - Health condition types
- `dietary_restrictions` - Dietary restriction types

## 🔧 API Endpoints

### Authentication:
- `POST /api/register` - User registration
- `POST /api/login` - User login
- `POST /api/logout` - User logout

### Recipes:
- `GET /api/recipes` - Get all recipes
- `GET /api/recipes/filipino` - Get Filipino recipes
- `GET /api/recipes/popular` - Get popular recipes
- `GET /api/recipes/{id}` - Get specific recipe

### Meal Plans:
- `GET /api/meal-plans` - Get user meal plans
- `POST /api/meal-plans` - Create meal plan
- `PUT /api/meal-plans/{id}` - Update meal plan
- `DELETE /api/meal-plans/{id}` - Delete meal plan

## 🎯 Features

### User Features:
- ✅ User registration and authentication
- ✅ Profile management with health data
- ✅ Personalized meal recommendations
- ✅ Smart meal suggestions based on preferences
- ✅ Health condition filtering
- ✅ Dietary restriction support
- ✅ Meal plan creation and management
- ✅ Recipe browsing and search
- ✅ Favorite recipes management

### Smart Features:
- ✅ Time-based meal suggestions
- ✅ Health-based recommendations
- ✅ Goal-based meal filtering
- ✅ Macro and calorie tracking
- ✅ Personalized dashboard

## 🛠️ Troubleshooting

### Common Issues:

#### 1. Database Connection Error
```bash
# Check MySQL service
mysql -u root -p

# Verify database exists
SHOW DATABASES;

# Check .env configuration
cat .env | grep DB_
```

#### 2. Laravel Server Won't Start
```bash
# Clear cache
php artisan config:clear
php artisan cache:clear

# Check PHP version
php -v

# Reinstall dependencies
composer install --no-dev
```

#### 3. Flutter Build Errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### 4. API Connection Issues
- Verify backend server is running on port 8000
- Check API base URL in Flutter app
- Ensure CORS is properly configured

## 📊 Testing the App

### 1. Test Backend API
```bash
# Run the test script
php test_api.php
```

### 2. Test Database
```bash
# Check users
mysql -u root -pQwerty@123 -e "USE food_recommendation; SELECT COUNT(*) FROM users;"

# Check recipes
mysql -u root -pQwerty@123 -e "USE food_recommendation; SELECT COUNT(*) FROM recipes;"
```

### 3. Test Flutter App
1. Start backend server
2. Run Flutter app
3. Register a new user
4. Create a meal plan
5. Browse recipes
6. Check personalized recommendations

## 🔐 Security Notes

- Change default MySQL password
- Use environment variables for sensitive data
- Enable HTTPS in production
- Implement proper API rate limiting
- Validate all user inputs

## 📈 Performance Tips

- Use database indexing for large datasets
- Implement caching for frequently accessed data
- Optimize images and assets
- Use pagination for large lists
- Implement lazy loading

## 🚀 Deployment

### Production Checklist:
- [ ] Set `APP_ENV=production` in .env
- [ ] Configure production database
- [ ] Set up SSL certificates
- [ ] Configure web server (Apache/Nginx)
- [ ] Set up monitoring and logging
- [ ] Implement backup strategies

## 📞 Support

For issues or questions:
1. Check this guide first
2. Review error logs
3. Test individual components
4. Verify all prerequisites are met

---

**Happy Cooking! 🍳✨**
