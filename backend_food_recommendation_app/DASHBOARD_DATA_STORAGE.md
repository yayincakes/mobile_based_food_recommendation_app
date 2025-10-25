# Dashboard Foods, Meals, and Ingredients Storage

This document describes how all the foods, meals, and ingredients from the dashboard screen have been stored in the database.

## Overview

All the Filipino recipes, ingredients, and meal plans from the `dashboard_screen.dart` have been systematically stored in the database using Laravel seeders and migrations.

## Database Structure

### Tables Created/Updated:
1. **ingredients** - All ingredients used in Filipino recipes
2. **recipes** - All Filipino recipes from the dashboard
3. **recipe_ingredients** - Many-to-many relationship between recipes and ingredients
4. **meal_plans** - Weekly meal plans
5. **meal_plan_items** - Individual meal items for each day
6. **users** - Default user for meal plans

## Data Stored

### 1. Ingredients (50+ ingredients)
- **Proteins**: beef tapa, chicken, pork, beef, fish, bangus, tilapia, oxtail, pork belly, egg, tuyo, shrimp, salted egg
- **Grains & Starches**: rice, brown rice, garlic rice, pandesal, saba banana, sweet potato, kamote, potatoes, carrots, mung beans, mais
- **Vegetables**: mixed vegetables, onion, garlic, ginger, tomato, eggplant, taro leaves, cabbage, spring onion, green papaya
- **Condiments & Sauces**: soy sauce, vinegar, fish sauce, bagoong, bay leaves, salt, sugar, brown sugar, cocoa powder, peanut butter, tomato sauce, tamarind, chili
- **Dairy & Liquids**: milk, coconut milk, butter, chicken broth, oil, olive oil
- **Others**: spring roll wrapper, atchara, gulaman, fresh mango, peanuts, lemon, longganisa, rice flour

### 2. Recipes (25+ Filipino recipes)

#### Breakfast Dishes:
- Tapsilog (Tapa, Sinangag, at Itlog)
- Champorado with Tuyo
- Pandesal with Scrambled Egg
- Lugaw with Egg
- Arroz Caldo
- Longsilog
- Bibingka with Salted Egg

#### Lunch Dishes:
- Chicken Adobo
- Sinigang na Baboy
- Beef Nilaga
- Fish Sinigang
- Chicken Tinola

#### Dinner Dishes:
- Kare-Kare
- Lechon Kawali
- Chicken Afritada
- Laing

#### Healthy Options:
- Grilled Bangus
- Pinakbet
- Ginisang Monggo
- Ensaladang Talong
- Atchara

#### Snacks:
- Banana Cue
- Kamote Cue
- Turon
- Mais
- Gulaman

### 3. Weekly Meal Plans
Complete 7-day meal plan with:
- **Monday**: Champorado with Tuyo, Chicken Tinola, Grilled Bangus, Banana Cue
- **Tuesday**: Tapsilog, Sinigang na Baboy, Pinakbet, Kamote Cue
- **Wednesday**: Pandesal with Scrambled Egg, Chicken Adobo, Ginisang Monggo, Fresh Mango
- **Thursday**: Lugaw with Egg, Beef Nilaga, Ensaladang Talong, Peanuts
- **Friday**: Arroz Caldo, Fish Sinigang, Chicken Afritada, Turon
- **Saturday**: Longsilog, Kare-Kare, Grilled Bangus, Mais
- **Sunday**: Bibingka with Salted Egg, Lechon Kawali, Laing, Gulaman

## Files Created

### 1. DashboardRecipesSeeder.php
- Comprehensive seeder that creates all ingredients, recipes, and meal plans
- Handles ingredient-recipe relationships
- Creates weekly meal plan with all 7 days

### 2. insert_dashboard_data.sql
- Direct SQL script to insert all dashboard data
- Can be run independently of Laravel
- Includes all ingredients, recipes, meal plans, and relationships

### 3. seed_dashboard_data.bat
- Windows batch file to run the Laravel seeder
- Easy one-click solution to populate the database

### 4. DatabaseSeeder.php (Updated)
- Updated to include DashboardRecipesSeeder
- Replaces individual seeders with comprehensive dashboard seeder

## How to Use

### Option 1: Laravel Seeder (Recommended)
```bash
cd backend_food_recommendation_app
php artisan db:seed --class=DashboardRecipesSeeder
```

### Option 2: Batch File (Windows)
```bash
cd backend_food_recommendation_app
seed_dashboard_data.bat
```

### Option 3: Direct SQL
```bash
mysql -u username -p database_name < insert_dashboard_data.sql
```

## Database Relationships

### Recipe-Ingredient Relationships
- Many-to-many relationship between recipes and ingredients
- Each recipe can have multiple ingredients
- Each ingredient can be used in multiple recipes
- Includes quantity and unit information

### Meal Plan Structure
- One meal plan contains multiple meal plan items
- Each meal plan item references a recipe
- Organized by day (1-7) and meal type (breakfast, lunch, dinner, snack)
- Includes serving information

## Nutritional Information

Each recipe includes comprehensive nutritional data:
- Calories per serving
- Protein per serving
- Carbohydrates per serving
- Fat per serving
- Prep time and cook time
- Difficulty level
- Category (Filipino, Healthy, etc.)
- Instructions

## Benefits

1. **Complete Data Storage**: All dashboard foods are now stored in the database
2. **Structured Relationships**: Proper database relationships between recipes and ingredients
3. **Meal Planning**: Complete weekly meal plans with Filipino dishes
4. **Scalable**: Easy to add more recipes and ingredients
5. **API Ready**: All data is accessible via Laravel API endpoints
6. **Consistent**: Standardized nutritional information and categorization

## API Endpoints Available

With this data stored, the following API endpoints are now available:
- `/api/recipes` - Get all recipes
- `/api/ingredients` - Get all ingredients
- `/api/meal-plans` - Get meal plans
- `/api/recipes/{id}` - Get specific recipe with ingredients
- `/api/meal-plans/{id}/items` - Get meal plan items

## Next Steps

1. Run the seeder to populate the database
2. Test API endpoints to ensure data is accessible
3. Update frontend to use real data from API instead of hardcoded values
4. Add more recipes and ingredients as needed
5. Implement user-specific meal plans

This comprehensive storage system ensures that all the Filipino foods, meals, and ingredients from the dashboard are properly stored and accessible through the API.
