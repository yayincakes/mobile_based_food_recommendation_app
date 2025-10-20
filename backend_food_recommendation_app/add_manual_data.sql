-- Manual data insertion for testing
USE food_recommendation;

-- Insert sample users
INSERT INTO users (name, email, password, gender, height_cm, weight_kg, target_weight_kg, birth_date, activity_level, dietary_goal, created_at, updated_at) VALUES
('John Doe', 'john@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Male', 175, 75, 70, '1990-05-15', 'Active', 'Weight Loss', NOW(), NOW()),
('Maria Santos', 'maria@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Female', 160, 60, 55, '1992-08-20', 'Moderate', 'Weight Loss', NOW(), NOW()),
('Pedro Cruz', 'pedro@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Male', 180, 85, 90, '1988-12-10', 'Very Active', 'Muscle Building', NOW(), NOW());

-- Insert sample ingredients
INSERT INTO ingredients (name, category, description, created_at, updated_at) VALUES
('Chicken', 'Protein', 'Fresh chicken meat', NOW(), NOW()),
('Rice', 'Carbohydrate', 'White rice', NOW(), NOW()),
('Garlic', 'Vegetable', 'Fresh garlic cloves', NOW(), NOW()),
('Soy Sauce', 'Condiment', 'Traditional soy sauce', NOW(), NOW()),
('Vinegar', 'Condiment', 'Cane vinegar', NOW(), NOW());

-- Insert sample recipes
INSERT INTO recipes (name, description, prep_time, cook_time, servings, difficulty, category, calories_per_serving, protein_per_serving, carbs_per_serving, fat_per_serving, instructions, is_filipino_dish, created_at, updated_at) VALUES
('Chicken Adobo', 'Classic Filipino chicken adobo', 15, 45, 4, 'Easy', 'Main Course', 320, 28, 8, 18, 'Marinate chicken, sauté with garlic, add soy sauce and vinegar, simmer until tender', 1, NOW(), NOW()),
('Sinigang na Baboy', 'Traditional Filipino sour soup', 20, 60, 6, 'Medium', 'Soup', 280, 22, 18, 14, 'Boil pork, add tamarind, add vegetables, season with fish sauce', 1, NOW(), NOW()),
('Kare-Kare', 'Traditional Filipino oxtail stew', 30, 180, 8, 'Hard', 'Main Course', 420, 35, 22, 18, 'Boil oxtail, make peanut sauce, add vegetables, serve with bagoong', 1, NOW(), NOW());

-- Insert sample meal plans
INSERT INTO meal_plans (name, description, start_date, end_date, user_id, created_at, updated_at) VALUES
('Weekly Filipino Plan', 'A week of traditional Filipino meals', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 1, NOW(), NOW()),
('Healthy Weight Loss Plan', 'Balanced meals for weight loss', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 2, NOW(), NOW());

-- Insert sample meal plan items
INSERT INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings, created_at, updated_at) VALUES
(1, 1, 1, 'breakfast', 1, NOW(), NOW()),
(1, 2, 1, 'lunch', 1, NOW(), NOW()),
(1, 3, 1, 'dinner', 1, NOW(), NOW()),
(2, 1, 1, 'breakfast', 1, NOW(), NOW()),
(2, 2, 1, 'lunch', 1, NOW(), NOW());
