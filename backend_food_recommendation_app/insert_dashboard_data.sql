-- Insert Dashboard Foods, Meals, and Ingredients
-- This script contains all the Filipino recipes, ingredients, and meal plans from the dashboard

-- Insert Ingredients
INSERT IGNORE INTO ingredients (name, category, description, created_at, updated_at) VALUES
-- Proteins
('beef tapa', 'Protein', 'Marinated beef strips', NOW(), NOW()),
('chicken', 'Protein', 'Chicken meat', NOW(), NOW()),
('pork', 'Protein', 'Pork meat', NOW(), NOW()),
('beef', 'Protein', 'Beef meat', NOW(), NOW()),
('fish', 'Protein', 'Fish meat', NOW(), NOW()),
('bangus', 'Protein', 'Milkfish', NOW(), NOW()),
('tilapia', 'Protein', 'Tilapia fish', NOW(), NOW()),
('oxtail', 'Protein', 'Oxtail meat', NOW(), NOW()),
('pork belly', 'Protein', 'Pork belly', NOW(), NOW()),
('egg', 'Protein', 'Chicken eggs', NOW(), NOW()),
('tuyo', 'Protein', 'Dried fish', NOW(), NOW()),
('shrimp', 'Protein', 'Shrimp', NOW(), NOW()),
('salted egg', 'Protein', 'Salted duck egg', NOW(), NOW()),

-- Grains & Starches
('rice', 'Grain', 'White rice', NOW(), NOW()),
('brown rice', 'Grain', 'Brown rice', NOW(), NOW()),
('garlic rice', 'Grain', 'Fried rice with garlic', NOW(), NOW()),
('pandesal', 'Bread', 'Filipino bread rolls', NOW(), NOW()),
('saba banana', 'Fruit', 'Cooking banana', NOW(), NOW()),
('sweet potato', 'Vegetable', 'Sweet potato', NOW(), NOW()),
('kamote', 'Vegetable', 'Sweet potato', NOW(), NOW()),
('potatoes', 'Vegetable', 'Potatoes', NOW(), NOW()),
('carrots', 'Vegetable', 'Carrots', NOW(), NOW()),
('mung beans', 'Legume', 'Mung beans', NOW(), NOW()),
('mais', 'Grain', 'Corn', NOW(), NOW()),

-- Vegetables
('mixed vegetables', 'Vegetable', 'Assorted vegetables', NOW(), NOW()),
('onion', 'Vegetable', 'Onions', NOW(), NOW()),
('garlic', 'Vegetable', 'Garlic', NOW(), NOW()),
('ginger', 'Vegetable', 'Ginger root', NOW(), NOW()),
('tomato', 'Vegetable', 'Tomatoes', NOW(), NOW()),
('tomatoes', 'Vegetable', 'Tomatoes', NOW(), NOW()),
('eggplant', 'Vegetable', 'Eggplant', NOW(), NOW()),
('taro leaves', 'Vegetable', 'Taro leaves', NOW(), NOW()),
('cabbage', 'Vegetable', 'Cabbage', NOW(), NOW()),
('spring onion', 'Vegetable', 'Spring onions', NOW(), NOW()),
('green papaya', 'Fruit', 'Green papaya', NOW(), NOW()),

-- Condiments & Sauces
('soy sauce', 'Condiment', 'Soy sauce', NOW(), NOW()),
('vinegar', 'Condiment', 'Vinegar', NOW(), NOW()),
('fish sauce', 'Condiment', 'Fish sauce', NOW(), NOW()),
('bagoong', 'Condiment', 'Shrimp paste', NOW(), NOW()),
('bay leaves', 'Spice', 'Bay leaves', NOW(), NOW()),
('salt', 'Spice', 'Salt', NOW(), NOW()),
('sugar', 'Sweetener', 'Sugar', NOW(), NOW()),
('brown sugar', 'Sweetener', 'Brown sugar', NOW(), NOW()),
('cocoa powder', 'Ingredient', 'Cocoa powder', NOW(), NOW()),
('peanut butter', 'Condiment', 'Peanut butter', NOW(), NOW()),
('tomato sauce', 'Sauce', 'Tomato sauce', NOW(), NOW()),
('tamarind', 'Ingredient', 'Tamarind', NOW(), NOW()),
('chili', 'Spice', 'Chili pepper', NOW(), NOW()),

-- Dairy & Liquids
('milk', 'Dairy', 'Milk', NOW(), NOW()),
('coconut milk', 'Dairy', 'Coconut milk', NOW(), NOW()),
('butter', 'Dairy', 'Butter', NOW(), NOW()),
('chicken broth', 'Liquid', 'Chicken broth', NOW(), NOW()),
('oil', 'Fat', 'Cooking oil', NOW(), NOW()),
('olive oil', 'Fat', 'Olive oil', NOW(), NOW()),

-- Wrappers & Others
('spring roll wrapper', 'Wrapper', 'Spring roll wrapper', NOW(), NOW()),
('atchara', 'Condiment', 'Pickled papaya', NOW(), NOW()),
('gulaman', 'Dessert', 'Agar jelly', NOW(), NOW()),
('fresh mango', 'Fruit', 'Fresh mango', NOW(), NOW()),
('peanuts', 'Nut', 'Peanuts', NOW(), NOW()),
('lemon', 'Fruit', 'Lemon', NOW(), NOW()),
('longganisa', 'Protein', 'Filipino sausage', NOW(), NOW()),
('rice flour', 'Grain', 'Rice flour', NOW(), NOW());

-- Insert Recipes
INSERT IGNORE INTO recipes (name, description, prep_time, cook_time, servings, difficulty, category, calories_per_serving, protein_per_serving, carbs_per_serving, fat_per_serving, instructions, is_filipino_dish, created_at, updated_at) VALUES
-- Filipino Breakfast Dishes
('Tapsilog', 'Tapa, Sinangag, at Itlog - Classic Filipino breakfast', 15, 20, 2, 'Easy', 'Filipino', 520, 28, 58, 18, 'Marinate beef, cook garlic rice, fry egg', 1, NOW(), NOW()),
('Champorado with Tuyo', 'Sweet chocolate rice porridge with dried fish', 10, 25, 4, 'Easy', 'Filipino', 380, 15, 62, 9, 'Cook rice with cocoa powder, serve with tuyo', 1, NOW(), NOW()),
('Pandesal with Scrambled Egg', 'Soft Filipino bread with scrambled eggs', 5, 10, 2, 'Easy', 'Filipino', 340, 18, 44, 12, 'Toast pandesal, scramble eggs with milk', 1, NOW(), NOW()),
('Lugaw with Egg', 'Warm rice porridge with soft-boiled egg', 10, 20, 2, 'Easy', 'Filipino', 320, 12, 52, 8, 'Cook rice in chicken broth, add soft-boiled egg', 1, NOW(), NOW()),
('Arroz Caldo', 'Chicken rice porridge', 10, 25, 4, 'Easy', 'Filipino', 350, 15, 58, 8, 'Cook rice with chicken and ginger', 1, NOW(), NOW()),
('Longsilog', 'Longganisa, Sinangag, at Itlog', 10, 20, 2, 'Easy', 'Filipino', 540, 26, 62, 20, 'Cook longganisa, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Bibingka with Salted Egg', 'Traditional rice cake with salted egg', 15, 30, 6, 'Medium', 'Filipino', 420, 14, 58, 16, 'Make rice cake batter, bake with salted egg', 1, NOW(), NOW()),

-- Filipino Lunch Dishes
('Chicken Adobo', 'Classic Filipino chicken in soy sauce and vinegar', 15, 30, 4, 'Easy', 'Filipino', 350, 25, 15, 20, 'Marinate chicken, cook in soy sauce and vinegar', 1, NOW(), NOW()),
('Sinigang na Baboy', 'Sour soup with pork and vegetables', 20, 45, 6, 'Medium', 'Filipino', 380, 25, 35, 14, 'Boil pork with tamarind, add vegetables', 1, NOW(), NOW()),
('Beef Nilaga', 'Boiled beef with vegetables', 15, 60, 6, 'Medium', 'Filipino', 450, 32, 38, 18, 'Boil beef until tender, add vegetables', 1, NOW(), NOW()),
('Fish Sinigang', 'Sour soup with fish and vegetables', 15, 30, 4, 'Easy', 'Filipino', 360, 28, 36, 10, 'Boil fish with tamarind and vegetables', 1, NOW(), NOW()),
('Chicken Tinola', 'Chicken soup with ginger and vegetables', 15, 25, 4, 'Easy', 'Filipino', 420, 38, 32, 16, 'Boil chicken with ginger, add vegetables', 1, NOW(), NOW()),

-- Filipino Dinner Dishes
('Kare-Kare', 'Oxtail stew with peanut sauce', 30, 120, 8, 'Hard', 'Filipino', 480, 28, 45, 22, 'Cook oxtail, make peanut sauce, add vegetables', 1, NOW(), NOW()),
('Lechon Kawali', 'Crispy fried pork belly', 20, 45, 6, 'Medium', 'Filipino', 520, 32, 38, 28, 'Boil pork belly, deep fry until crispy', 1, NOW(), NOW()),
('Chicken Afritada', 'Chicken stew with potatoes and carrots', 20, 40, 6, 'Medium', 'Filipino', 460, 34, 48, 14, 'Sauté chicken, add vegetables and tomato sauce', 1, NOW(), NOW()),
('Laing', 'Taro leaves in coconut milk', 25, 30, 6, 'Medium', 'Filipino', 400, 26, 44, 14, 'Cook taro leaves in coconut milk with spices', 1, NOW(), NOW()),

-- Healthy Options
('Grilled Bangus', 'Grilled milkfish with vegetables', 15, 20, 2, 'Easy', 'Healthy', 250, 30, 8, 12, 'Season and grill bangus, serve with vegetables', 1, NOW(), NOW()),
('Pinakbet', 'Mixed vegetables with shrimp paste', 15, 20, 4, 'Easy', 'Healthy', 120, 8, 20, 3, 'Sauté vegetables with bagoong', 1, NOW(), NOW()),
('Ginisang Monggo', 'Sautéed mung beans with vegetables', 10, 25, 4, 'Easy', 'Healthy', 180, 12, 25, 5, 'Cook mung beans, sauté with vegetables', 1, NOW(), NOW()),
('Ensaladang Talong', 'Grilled eggplant salad', 10, 15, 2, 'Easy', 'Healthy', 80, 3, 12, 2, 'Grill eggplant, mix with tomatoes and onions', 1, NOW(), NOW()),
('Atchara', 'Pickled papaya and vegetables', 20, 0, 8, 'Easy', 'Healthy', 25, 1, 6, 0, 'Mix papaya with vinegar, sugar, and spices', 1, NOW(), NOW()),

-- Filipino Snacks
('Banana Cue', 'Caramelized banana on stick', 5, 10, 4, 'Easy', 'Filipino', 180, 2, 38, 4, 'Fry banana in brown sugar until caramelized', 1, NOW(), NOW()),
('Kamote Cue', 'Caramelized sweet potato', 5, 10, 4, 'Easy', 'Filipino', 150, 3, 32, 1, 'Fry sweet potato in brown sugar', 1, NOW(), NOW()),
('Turon', 'Fried banana spring roll', 10, 15, 6, 'Easy', 'Filipino', 200, 2, 35, 7, 'Wrap banana in spring roll wrapper, fry', 1, NOW(), NOW()),
('Mais', 'Boiled corn', 5, 15, 2, 'Easy', 'Filipino', 140, 4, 30, 2, 'Boil corn until tender', 1, NOW(), NOW()),
('Gulaman', 'Agar jelly dessert', 10, 15, 4, 'Easy', 'Filipino', 100, 0, 25, 0, 'Make agar jelly with sugar syrup', 1, NOW(), NOW());

-- Create a default user if none exists
INSERT IGNORE INTO users (name, email, password, role, is_active, created_at, updated_at) VALUES
('Default User', 'user@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', 1, NOW(), NOW());

-- Create a weekly meal plan
INSERT IGNORE INTO meal_plans (name, description, start_date, end_date, user_id, is_active, created_at, updated_at) VALUES
('Weekly Filipino Meal Plan', 'A comprehensive weekly meal plan featuring traditional Filipino dishes', 
 CURDATE() - INTERVAL WEEKDAY(CURDATE()) DAY, 
 CURDATE() - INTERVAL WEEKDAY(CURDATE()) DAY + INTERVAL 6 DAY, 
 (SELECT id FROM users WHERE email = 'user@example.com' LIMIT 1), 
 1, NOW(), NOW());

-- Create meal plan items for the weekly plan
INSERT IGNORE INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings, created_at, updated_at) VALUES
-- Monday (1)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Champorado with Tuyo' LIMIT 1), 1, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Chicken Tinola' LIMIT 1), 1, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Grilled Bangus' LIMIT 1), 1, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Banana Cue' LIMIT 1), 1, 'snack', 1, NOW(), NOW()),

-- Tuesday (2)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Tapsilog' LIMIT 1), 2, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Sinigang na Baboy' LIMIT 1), 2, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Pinakbet' LIMIT 1), 2, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Kamote Cue' LIMIT 1), 2, 'snack', 1, NOW(), NOW()),

-- Wednesday (3)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Pandesal with Scrambled Egg' LIMIT 1), 3, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Chicken Adobo' LIMIT 1), 3, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Ginisang Monggo' LIMIT 1), 3, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Fresh Mango' LIMIT 1), 3, 'snack', 1, NOW(), NOW()),

-- Thursday (4)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Lugaw with Egg' LIMIT 1), 4, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Beef Nilaga' LIMIT 1), 4, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Ensaladang Talong' LIMIT 1), 4, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Peanuts' LIMIT 1), 4, 'snack', 1, NOW(), NOW()),

-- Friday (5)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Arroz Caldo' LIMIT 1), 5, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Fish Sinigang' LIMIT 1), 5, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Chicken Afritada' LIMIT 1), 5, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Turon' LIMIT 1), 5, 'snack', 1, NOW(), NOW()),

-- Saturday (6)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Longsilog' LIMIT 1), 6, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Kare-Kare' LIMIT 1), 6, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Grilled Bangus' LIMIT 1), 6, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Mais' LIMIT 1), 6, 'snack', 1, NOW(), NOW()),

-- Sunday (7)
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Bibingka with Salted Egg' LIMIT 1), 7, 'breakfast', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Lechon Kawali' LIMIT 1), 7, 'lunch', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Laing' LIMIT 1), 7, 'dinner', 1, NOW(), NOW()),
((SELECT id FROM meal_plans WHERE name = 'Weekly Filipino Meal Plan' LIMIT 1), (SELECT id FROM recipes WHERE name = 'Gulaman' LIMIT 1), 7, 'snack', 1, NOW(), NOW());

-- Create recipe-ingredient relationships (sample relationships for key recipes)
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, created_at, updated_at) VALUES
-- Tapsilog ingredients
((SELECT id FROM recipes WHERE name = 'Tapsilog' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'beef tapa' LIMIT 1), '200', 'g', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Tapsilog' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'garlic rice' LIMIT 1), '1', 'cup', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Tapsilog' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'egg' LIMIT 1), '1', 'piece', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Tapsilog' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'garlic' LIMIT 1), '3', 'cloves', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Tapsilog' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'soy sauce' LIMIT 1), '2', 'tbsp', NOW(), NOW()),

-- Champorado ingredients
((SELECT id FROM recipes WHERE name = 'Champorado with Tuyo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'rice' LIMIT 1), '1', 'cup', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Champorado with Tuyo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'cocoa powder' LIMIT 1), '3', 'tbsp', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Champorado with Tuyo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'sugar' LIMIT 1), '2', 'tbsp', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Champorado with Tuyo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'tuyo' LIMIT 1), '2', 'pieces', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Champorado with Tuyo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'milk' LIMIT 1), '1', 'cup', NOW(), NOW()),

-- Chicken Adobo ingredients
((SELECT id FROM recipes WHERE name = 'Chicken Adobo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'chicken' LIMIT 1), '1', 'kg', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Chicken Adobo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'soy sauce' LIMIT 1), '1/2', 'cup', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Chicken Adobo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'vinegar' LIMIT 1), '1/2', 'cup', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Chicken Adobo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'garlic' LIMIT 1), '6', 'cloves', NOW(), NOW()),
((SELECT id FROM recipes WHERE name = 'Chicken Adobo' LIMIT 1), (SELECT id FROM ingredients WHERE name = 'bay leaves' LIMIT 1), '3', 'pieces', NOW(), NOW());

-- Display summary
SELECT 'Dashboard data insertion completed successfully!' as message;
SELECT COUNT(*) as total_ingredients FROM ingredients;
SELECT COUNT(*) as total_recipes FROM recipes;
SELECT COUNT(*) as total_meal_plans FROM meal_plans;
SELECT COUNT(*) as total_meal_plan_items FROM meal_plan_items;
SELECT COUNT(*) as total_recipe_ingredients FROM recipe_ingredients;
