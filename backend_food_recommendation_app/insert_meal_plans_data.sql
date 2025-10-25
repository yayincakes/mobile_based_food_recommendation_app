-- Comprehensive Meal Plans Data Insertion Script
-- Run this script in MySQL Workbench after setting up the database

USE food_recommendation_app;

-- Clear existing data (optional - uncomment if you want to start fresh)
-- DELETE FROM meal_plan_items;
-- DELETE FROM meal_plans;
-- DELETE FROM recipe_ingredients;
-- DELETE FROM recipes;
-- DELETE FROM ingredients;
-- DELETE FROM users WHERE role != 'admin';

-- Insert additional sample users
INSERT INTO users (name, email, password, role, is_active, gender, height_cm, weight_kg, target_weight_kg, birth_date, activity_level, dietary_goal) VALUES
('Maria Santos', 'maria@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', TRUE, 'Female', 155.00, 50.00, 48.00, '1992-03-20', 'Light', 'Weight Loss'),
('Juan Dela Cruz', 'juan@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', TRUE, 'Male', 170.00, 75.00, 70.00, '1988-07-10', 'Moderate', 'Weight Loss'),
('Ana Rodriguez', 'ana@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', TRUE, 'Female', 165.00, 60.00, 55.00, '1995-11-15', 'Active', 'Muscle Building')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert more Filipino recipes
INSERT INTO recipes (name, description, instructions, prep_time, cook_time, servings, calories, protein, carbs, fat, fiber, sugar, sodium, difficulty, cuisine, meal_type, tags, allergens) VALUES
('Tinolang Manok', 'Chicken soup with ginger and vegetables', 'Boil chicken with ginger. Add vegetables and season with fish sauce.', 15, 25, 4, 200, 22.0, 12.0, 6.0, 3.0, 5.0, 650.0, 'Easy', 'Filipino', 'Soup', '["Healthy", "Comfort Food"]', '[]'),
('Bistek Tagalog', 'Beef steak with onions and soy sauce', 'Marinate beef in soy sauce and calamansi. Cook with onions.', 20, 15, 4, 280, 30.0, 8.0, 12.0, 2.0, 6.0, 850.0, 'Easy', 'Filipino', 'Main Course', '["Traditional", "Quick"]', '["Soy"]'),
('Pork Sisig', 'Sizzling pork with onions and chili', 'Cook pork until crispy. Mix with onions, chili, and calamansi.', 25, 20, 4, 320, 28.0, 5.0, 20.0, 1.0, 3.0, 700.0, 'Medium', 'Filipino', 'Main Course', '["Spicy", "Popular"]', '[]'),
('Lumpia', 'Spring rolls with vegetables and meat', 'Wrap vegetables and meat in spring roll wrapper. Deep fry until golden.', 30, 15, 6, 180, 12.0, 20.0, 8.0, 2.0, 3.0, 400.0, 'Medium', 'Filipino', 'Appetizer', '["Crispy", "Party Food"]', '["Wheat"]'),
('Halo-Halo', 'Mixed dessert with shaved ice and toppings', 'Layer shaved ice with various sweet toppings and evaporated milk.', 10, 0, 1, 250, 6.0, 45.0, 8.0, 3.0, 35.0, 50.0, 'Easy', 'Filipino', 'Dessert', '["Sweet", "Refreshing"]', '["Dairy"]'),
('Chicken Inasal', 'Grilled chicken marinated in vinegar and spices', 'Marinate chicken in vinegar mixture. Grill until cooked through.', 30, 20, 4, 220, 35.0, 2.0, 8.0, 0.0, 1.0, 600.0, 'Easy', 'Filipino', 'Main Course', '["Grilled", "Healthy"]', '[]'),
('Ginataang Kalabasa', 'Squash in coconut milk', 'Cook squash in coconut milk with vegetables and spices.', 10, 20, 4, 180, 4.0, 15.0, 12.0, 4.0, 8.0, 300.0, 'Easy', 'Filipino', 'Main Course', '["Vegetarian", "Healthy"]', '[]'),
('Pancit Bihon', 'Rice noodles with vegetables and meat', 'Stir-fry rice noodles with vegetables and soy sauce.', 15, 15, 4, 260, 10.0, 40.0, 6.0, 2.0, 4.0, 700.0, 'Easy', 'Filipino', 'Main Course', '["Quick", "Vegetarian Option"]', '["Soy"]'),
('Turon', 'Banana spring rolls', 'Wrap banana in spring roll wrapper. Deep fry until golden.', 15, 10, 4, 150, 2.0, 25.0, 6.0, 2.0, 15.0, 50.0, 'Easy', 'Filipino', 'Dessert', '["Sweet", "Crispy"]', '["Wheat"]'),
('Champorado', 'Chocolate rice porridge', 'Cook rice with cocoa powder and sugar. Serve with milk.', 5, 20, 2, 200, 6.0, 35.0, 4.0, 2.0, 20.0, 100.0, 'Easy', 'Filipino', 'Breakfast', '["Comfort Food", "Sweet"]', '["Dairy"]')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert more ingredients
INSERT INTO ingredients (name, category, unit, calories_per_unit, protein_per_unit, carbs_per_unit, fat_per_unit) VALUES
('Beef Sirloin', 'Meat', 'g', 2.5, 0.26, 0, 0.15),
('Pork Shoulder', 'Meat', 'g', 2.4, 0.19, 0, 0.18),
('Fish Sauce', 'Condiment', 'tbsp', 5, 1.0, 0.5, 0),
('Calamansi', 'Fruit', 'piece', 2, 0.1, 0.5, 0),
('Ginger', 'Spice', 'g', 0.8, 0.02, 0.18, 0.01),
('Coconut Milk', 'Dairy', 'cup', 445, 4.6, 6.4, 48.2),
('Banana', 'Fruit', 'medium', 105, 1.3, 27, 0.4),
('Squash', 'Vegetable', 'cup', 82, 1.8, 21.5, 0.2),
('Rice Noodles', 'Grain', 'cup', 192, 1.4, 44, 0.4),
('Cocoa Powder', 'Spice', 'tbsp', 12, 1.1, 3, 0.7),
('Evaporated Milk', 'Dairy', 'cup', 338, 16.8, 25.2, 19.2),
('Spring Roll Wrapper', 'Grain', 'piece', 20, 0.6, 3.8, 0.1)
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert comprehensive meal plans for different users
INSERT INTO meal_plans (name, description, start_date, end_date, user_id, is_active) VALUES
-- User 2 (Test User) - Active plan
('My Personalized Plan', 'AI-generated meal plan based on your preferences', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), 2, TRUE),

-- User 3 (Maria Santos) - Active plan
('Weight Loss Journey', 'Low-calorie meal plan for sustainable weight loss', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 3, TRUE),

-- User 4 (Juan Dela Cruz) - Active plan
('Muscle Building Plan', 'High-protein meal plan for muscle development', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 21 DAY), 4, TRUE),

-- User 5 (Ana Rodriguez) - Active plan
('Balanced Nutrition Plan', 'Well-rounded meal plan for overall health', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 5, TRUE),

-- Inactive plans (completed)
('Previous Weight Loss Plan', 'Completed weight loss plan', DATE_SUB(CURDATE(), INTERVAL 30 DAY), DATE_SUB(CURDATE(), INTERVAL 1 DAY), 2, FALSE),
('Summer Diet Plan', 'Completed summer diet plan', DATE_SUB(CURDATE(), INTERVAL 14 DAY), DATE_SUB(CURDATE(), INTERVAL 1 DAY), 3, FALSE)
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert detailed meal plan items for User 2's active plan (7 days)
INSERT INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings) VALUES
-- Day 1
(1, 1, 1, 'breakfast', 1),  -- Adobo
(1, 2, 1, 'lunch', 1),       -- Sinigang
(1, 3, 1, 'dinner', 1),       -- Kare-Kare
(1, 4, 1, 'snack', 1),        -- Lechon Kawali

-- Day 2
(1, 5, 2, 'breakfast', 1),    -- Pancit Canton
(1, 6, 2, 'lunch', 1),        -- Tinolang Manok
(1, 7, 2, 'dinner', 1),       -- Bistek Tagalog
(1, 8, 2, 'snack', 1),        -- Pork Sisig

-- Day 3
(1, 9, 3, 'breakfast', 1),    -- Lumpia
(1, 10, 3, 'lunch', 1),       -- Halo-Halo
(1, 11, 3, 'dinner', 1),     -- Chicken Inasal
(1, 12, 3, 'snack', 1),       -- Ginataang Kalabasa

-- Day 4
(1, 13, 4, 'breakfast', 1),   -- Pancit Bihon
(1, 1, 4, 'lunch', 1),        -- Adobo
(1, 2, 4, 'dinner', 1),       -- Sinigang
(1, 3, 4, 'snack', 1),        -- Kare-Kare

-- Day 5
(1, 4, 5, 'breakfast', 1),    -- Lechon Kawali
(1, 5, 5, 'lunch', 1),        -- Pancit Canton
(1, 6, 5, 'dinner', 1),       -- Tinolang Manok
(1, 7, 5, 'snack', 1),        -- Bistek Tagalog

-- Day 6
(1, 8, 6, 'breakfast', 1),    -- Pork Sisig
(1, 9, 6, 'lunch', 1),        -- Lumpia
(1, 10, 6, 'dinner', 1),      -- Halo-Halo
(1, 11, 6, 'snack', 1),       -- Chicken Inasal

-- Day 7
(1, 12, 7, 'breakfast', 1),    -- Ginataang Kalabasa
(1, 13, 7, 'lunch', 1),       -- Pancit Bihon
(1, 1, 7, 'dinner', 1),       -- Adobo
(1, 2, 7, 'snack', 1)         -- Sinigang
ON DUPLICATE KEY UPDATE servings = VALUES(servings);

-- Insert meal plan items for User 3's weight loss plan (3 days sample)
INSERT INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings) VALUES
-- Day 1
(2, 6, 1, 'breakfast', 1),    -- Tinolang Manok
(2, 12, 1, 'lunch', 1),       -- Ginataang Kalabasa
(2, 11, 1, 'dinner', 1),      -- Chicken Inasal
(2, 9, 1, 'snack', 1),        -- Lumpia

-- Day 2
(2, 2, 2, 'breakfast', 1),    -- Sinigang
(2, 6, 2, 'lunch', 1),        -- Tinolang Manok
(2, 12, 2, 'dinner', 1),      -- Ginataang Kalabasa
(2, 11, 2, 'snack', 1),       -- Chicken Inasal

-- Day 3
(2, 12, 3, 'breakfast', 1),   -- Ginataang Kalabasa
(2, 11, 3, 'lunch', 1),       -- Chicken Inasal
(2, 6, 3, 'dinner', 1),       -- Tinolang Manok
(2, 2, 3, 'snack', 1)         -- Sinigang
ON DUPLICATE KEY UPDATE servings = VALUES(servings);

-- Insert meal plan items for User 4's muscle building plan (3 days sample)
INSERT INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings) VALUES
-- Day 1
(3, 1, 1, 'breakfast', 2),    -- Adobo (2 servings)
(3, 7, 1, 'lunch', 2),        -- Bistek Tagalog (2 servings)
(3, 4, 1, 'dinner', 2),       -- Lechon Kawali (2 servings)
(3, 8, 1, 'snack', 1),        -- Pork Sisig

-- Day 2
(3, 7, 2, 'breakfast', 2),    -- Bistek Tagalog (2 servings)
(3, 1, 2, 'lunch', 2),        -- Adobo (2 servings)
(3, 8, 2, 'dinner', 2),       -- Pork Sisig (2 servings)
(3, 4, 2, 'snack', 1),        -- Lechon Kawali

-- Day 3
(3, 4, 3, 'breakfast', 2),    -- Lechon Kawali (2 servings)
(3, 8, 3, 'lunch', 2),        -- Pork Sisig (2 servings)
(3, 1, 3, 'dinner', 2),       -- Adobo (2 servings)
(3, 7, 3, 'snack', 1)         -- Bistek Tagalog
ON DUPLICATE KEY UPDATE servings = VALUES(servings);

-- Insert meal plan items for User 5's balanced plan (2 days sample)
INSERT INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings) VALUES
-- Day 1
(4, 2, 1, 'breakfast', 1),    -- Sinigang
(4, 3, 1, 'lunch', 1),        -- Kare-Kare
(4, 5, 1, 'dinner', 1),       -- Pancit Canton
(4, 6, 1, 'snack', 1),        -- Tinolang Manok

-- Day 2
(4, 3, 2, 'breakfast', 1),    -- Kare-Kare
(4, 5, 2, 'lunch', 1),        -- Pancit Canton
(4, 2, 2, 'dinner', 1),       -- Sinigang
(4, 3, 2, 'snack', 1)         -- Kare-Kare
ON DUPLICATE KEY UPDATE servings = VALUES(servings);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_meal_plans_user_active ON meal_plans(user_id, is_active);
CREATE INDEX IF NOT EXISTS idx_meal_plan_items_plan_day ON meal_plan_items(meal_plan_id, day);
CREATE INDEX IF NOT EXISTS idx_recipes_calories ON recipes(calories);
CREATE INDEX IF NOT EXISTS idx_recipes_meal_type ON recipes(meal_type);

-- Show summary of inserted data
SELECT '=== MEAL PLANS SUMMARY ===' as Summary;
SELECT 
    mp.id,
    mp.name as meal_plan_name,
    u.name as user_name,
    mp.is_active,
    COUNT(mpi.id) as total_meals,
    mp.start_date,
    mp.end_date
FROM meal_plans mp
JOIN users u ON mp.user_id = u.id
LEFT JOIN meal_plan_items mpi ON mp.id = mpi.meal_plan_id
GROUP BY mp.id, mp.name, u.name, mp.is_active, mp.start_date, mp.end_date
ORDER BY mp.is_active DESC, mp.created_at DESC;

SELECT '=== ACTIVE MEAL PLANS ===' as Summary;
SELECT 
    mp.id,
    mp.name,
    u.name as user_name,
    COUNT(mpi.id) as total_meals
FROM meal_plans mp
JOIN users u ON mp.user_id = u.id
LEFT JOIN meal_plan_items mpi ON mp.id = mpi.meal_plan_id
WHERE mp.is_active = TRUE
GROUP BY mp.id, mp.name, u.name
ORDER BY mp.created_at DESC;

SELECT '=== MEAL PLAN ITEMS SAMPLE ===' as Summary;
SELECT 
    mpi.id,
    mp.name as meal_plan,
    r.name as recipe,
    mpi.day,
    mpi.meal_type,
    mpi.servings,
    r.calories * mpi.servings as total_calories
FROM meal_plan_items mpi
JOIN meal_plans mp ON mpi.meal_plan_id = mp.id
JOIN recipes r ON mpi.recipe_id = r.id
WHERE mp.is_active = TRUE
ORDER BY mp.id, mpi.day, mpi.meal_type
LIMIT 20;

SELECT '=== NUTRITION SUMMARY BY USER ===' as Summary;
SELECT 
    u.name as user_name,
    mp.name as meal_plan_name,
    COUNT(mpi.id) as total_meals,
    SUM(r.calories * mpi.servings) as total_calories,
    SUM(r.protein * mpi.servings) as total_protein,
    SUM(r.carbs * mpi.servings) as total_carbs,
    SUM(r.fat * mpi.servings) as total_fat
FROM users u
JOIN meal_plans mp ON u.id = mp.user_id
JOIN meal_plan_items mpi ON mp.id = mpi.meal_plan_id
JOIN recipes r ON mpi.recipe_id = r.id
WHERE mp.is_active = TRUE
GROUP BY u.name, mp.name
ORDER BY u.name;
