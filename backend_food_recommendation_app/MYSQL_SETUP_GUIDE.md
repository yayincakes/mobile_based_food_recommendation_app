# MySQL Setup Guide for Food Recommendation App

This guide will help you migrate from SQLite to MySQL and set up the database with meal plan data.

## Prerequisites

1. **MySQL Server** installed and running
2. **MySQL Workbench** installed
3. **Laravel** backend project ready

## Step 1: Database Setup in MySQL Workbench

1. **Open MySQL Workbench**
2. **Connect to your MySQL server**
3. **Run the setup script:**
   - Open `setup_mysql.sql` in MySQL Workbench
   - Execute the script to create the database and tables
   - This will create the `food_recommendation_app` database with all necessary tables

## Step 2: Laravel Configuration

1. **Run the configuration script:**
   ```bash
   cd backend_food_recommendation_app
   php configure_mysql.php
   ```

2. **Or manually update your .env file:**
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=food_recommendation_app
   DB_USERNAME=root
   DB_PASSWORD=your_mysql_password
   ```

## Step 3: Laravel Setup Commands

Run these commands in your backend directory:

```bash
# Generate application key
php artisan key:generate

# Run migrations
php artisan migrate

# Run seeders
php artisan db:seed

# Clear cache
php artisan config:clear
php artisan cache:clear
```

## Step 3: Insert Sample Data

1. **In MySQL Workbench, run:**
   - Open `insert_meal_plans_data.sql`
   - Execute the script to insert comprehensive meal plan data

## Step 4: Verify Setup

### Check Database Tables
```sql
USE food_recommendation_app;
SHOW TABLES;
```

### Check Sample Data
```sql
-- Check users
SELECT id, name, email, role FROM users;

-- Check meal plans
SELECT id, name, user_id, is_active FROM meal_plans;

-- Check active meal plans
SELECT mp.id, mp.name, u.name as user_name, mp.is_active 
FROM meal_plans mp 
JOIN users u ON mp.user_id = u.id 
WHERE mp.is_active = TRUE;
```

## Database Structure

### Tables Created:
- **users** - User accounts and profiles
- **recipes** - Recipe information with nutrition data
- **ingredients** - Ingredient database
- **recipe_ingredients** - Many-to-many relationship
- **meal_plans** - User meal plans (one active per user)
- **meal_plan_items** - Daily meal assignments
- **personal_access_tokens** - API authentication
- **cache, sessions, jobs** - Laravel system tables

### Key Features:
- **One Plan Per User**: Only one active meal plan per user
- **Comprehensive Nutrition Data**: Calories, protein, carbs, fat tracking
- **Filipino Cuisine Focus**: Traditional Filipino recipes
- **Flexible Meal Planning**: Breakfast, lunch, dinner, snacks
- **User Profiles**: Height, weight, goals, activity levels

## Sample Data Included:

### Users (4 sample users):
- Admin User (admin@example.com)
- Test User (test@example.com) 
- Maria Santos (maria@example.com)
- Juan Dela Cruz (juan@example.com)
- Ana Rodriguez (ana@example.com)

### Recipes (15 Filipino dishes):
- Adobo, Sinigang, Kare-Kare, Lechon Kawali
- Pancit Canton, Tinolang Manok, Bistek Tagalog
- Pork Sisig, Lumpia, Halo-Halo, Chicken Inasal
- Ginataang Kalabasa, Pancit Bihon, Turon, Champorado

### Meal Plans:
- **Active Plans**: One per user with 7-30 day plans
- **Nutrition Focus**: Weight loss, muscle building, balanced
- **Complete Weekly Schedules**: Breakfast, lunch, dinner, snacks

## API Endpoints Available:

After setup, your Laravel API will have these endpoints:
- `GET /api/recipes` - List all recipes
- `GET /api/meal-plans` - Get user meal plans
- `POST /api/meal-plans` - Create new meal plan
- `GET /api/users/{id}/meal-plans` - Get user's meal plans
- `GET /api/meal-plans/{id}/items` - Get meal plan items

## Troubleshooting:

### Common Issues:

1. **Connection Refused:**
   - Check MySQL server is running
   - Verify credentials in .env file

2. **Database Not Found:**
   - Run the setup_mysql.sql script first
   - Check database name in .env

3. **Migration Errors:**
   - Clear cache: `php artisan config:clear`
   - Check database permissions

4. **Seeder Errors:**
   - Ensure all tables exist
   - Check foreign key constraints

### Quick Fixes:

```bash
# Reset everything
php artisan migrate:fresh --seed

# Clear all cache
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear
```

## Next Steps:

1. **Test the API endpoints** using Postman or curl
2. **Connect your Flutter app** to the new MySQL backend
3. **Customize meal plans** for your specific needs
4. **Add more recipes** through the admin interface

## Files Created:

- `setup_mysql.sql` - Database creation script
- `insert_meal_plans_data.sql` - Sample data insertion
- `configure_mysql.php` - Laravel configuration
- `setup_mysql.bat` - Windows setup script
- `MealPlan.php` - Laravel model
- `MealPlanItem.php` - Laravel model

Your Food Recommendation App is now ready with a robust MySQL backend! 🎉
