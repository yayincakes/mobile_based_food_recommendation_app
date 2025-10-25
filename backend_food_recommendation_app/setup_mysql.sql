-- MySQL Workbench Setup Script for Food Recommendation App
-- Run this script in MySQL Workbench to set up the database

-- Create database
CREATE DATABASE IF NOT EXISTS food_recommendation_app;
USE food_recommendation_app;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    email_verified_at TIMESTAMP NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    gender VARCHAR(10),
    height_cm DECIMAL(5,2),
    weight_kg DECIMAL(5,2),
    target_weight_kg DECIMAL(5,2),
    birth_date DATE,
    activity_level VARCHAR(50),
    dietary_goal VARCHAR(100),
    remember_token VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create recipes table
CREATE TABLE IF NOT EXISTS recipes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    instructions TEXT,
    prep_time INT DEFAULT 0,
    cook_time INT DEFAULT 0,
    servings INT DEFAULT 1,
    calories INT DEFAULT 0,
    protein DECIMAL(8,2) DEFAULT 0,
    carbs DECIMAL(8,2) DEFAULT 0,
    fat DECIMAL(8,2) DEFAULT 0,
    fiber DECIMAL(8,2) DEFAULT 0,
    sugar DECIMAL(8,2) DEFAULT 0,
    sodium DECIMAL(8,2) DEFAULT 0,
    difficulty VARCHAR(20) DEFAULT 'Easy',
    cuisine VARCHAR(50),
    meal_type VARCHAR(50),
    tags JSON,
    allergens JSON,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create ingredients table
CREATE TABLE IF NOT EXISTS ingredients (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    unit VARCHAR(50),
    calories_per_unit DECIMAL(8,2) DEFAULT 0,
    protein_per_unit DECIMAL(8,2) DEFAULT 0,
    carbs_per_unit DECIMAL(8,2) DEFAULT 0,
    fat_per_unit DECIMAL(8,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create recipe_ingredients table
CREATE TABLE IF NOT EXISTS recipe_ingredients (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recipe_id BIGINT UNSIGNED NOT NULL,
    ingredient_id BIGINT UNSIGNED NOT NULL,
    quantity DECIMAL(8,2) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE
);

-- Create meal_plans table
CREATE TABLE IF NOT EXISTS meal_plans (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create meal_plan_items table
CREATE TABLE IF NOT EXISTS meal_plan_items (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    meal_plan_id BIGINT UNSIGNED NOT NULL,
    recipe_id BIGINT UNSIGNED NOT NULL,
    day INT NOT NULL,
    meal_type VARCHAR(50) NOT NULL,
    servings INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (meal_plan_id) REFERENCES meal_plans(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- Create personal_access_tokens table (for API authentication)
CREATE TABLE IF NOT EXISTS personal_access_tokens (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tokenable_type VARCHAR(255) NOT NULL,
    tokenable_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    token VARCHAR(64) UNIQUE NOT NULL,
    abilities TEXT,
    last_used_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX personal_access_tokens_tokenable_type_tokenable_id_index (tokenable_type, tokenable_id)
);

-- Create cache table
CREATE TABLE IF NOT EXISTS cache (
    `key` VARCHAR(255) PRIMARY KEY,
    value MEDIUMTEXT NOT NULL,
    expiration INT NOT NULL
);

-- Create cache_locks table
CREATE TABLE IF NOT EXISTS cache_locks (
    `key` VARCHAR(255) PRIMARY KEY,
    owner VARCHAR(255) NOT NULL,
    expiration INT NOT NULL
);

-- Create jobs table
CREATE TABLE IF NOT EXISTS jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    queue VARCHAR(255) NOT NULL,
    payload LONGTEXT NOT NULL,
    attempts TINYINT UNSIGNED NOT NULL,
    reserved_at INT UNSIGNED NULL,
    available_at INT UNSIGNED NOT NULL,
    created_at INT UNSIGNED NOT NULL,
    INDEX jobs_queue_index (queue)
);

-- Create job_batches table
CREATE TABLE IF NOT EXISTS job_batches (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    total_jobs INT NOT NULL,
    pending_jobs INT NOT NULL,
    failed_jobs INT NOT NULL,
    failed_job_ids LONGTEXT NOT NULL,
    options MEDIUMTEXT,
    cancelled_at INT NULL,
    created_at INT NOT NULL,
    finished_at INT NULL
);

-- Create failed_jobs table
CREATE TABLE IF NOT EXISTS failed_jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE NOT NULL,
    connection TEXT NOT NULL,
    queue TEXT NOT NULL,
    payload LONGTEXT NOT NULL,
    exception LONGTEXT NOT NULL,
    failed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create migrations table
CREATE TABLE IF NOT EXISTS migrations (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    migration VARCHAR(255) NOT NULL,
    batch INT NOT NULL
);

-- Create sessions table
CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INT NOT NULL,
    INDEX sessions_user_id_index (user_id),
    INDEX sessions_last_activity_index (last_activity)
);

-- Insert sample admin user
INSERT INTO users (name, email, password, role, is_active, gender, height_cm, weight_kg, target_weight_kg, birth_date, activity_level, dietary_goal) 
VALUES ('Admin User', 'admin@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', TRUE, 'Male', 175.00, 70.00, 65.00, '1990-01-01', 'Moderate', 'Weight Loss')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert sample regular user
INSERT INTO users (name, email, password, role, is_active, gender, height_cm, weight_kg, target_weight_kg, birth_date, activity_level, dietary_goal) 
VALUES ('Test User', 'test@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', TRUE, 'Female', 160.00, 55.00, 50.00, '1995-05-15', 'Light', 'Weight Loss')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert sample recipes
INSERT INTO recipes (name, description, instructions, prep_time, cook_time, servings, calories, protein, carbs, fat, fiber, sugar, sodium, difficulty, cuisine, meal_type, tags, allergens) VALUES
('Adobo', 'Classic Filipino chicken adobo', 'Marinate chicken in soy sauce and vinegar. Cook until tender.', 15, 30, 4, 250, 25.0, 8.0, 12.0, 2.0, 4.0, 800.0, 'Easy', 'Filipino', 'Main Course', '["Comfort Food", "Traditional"]', '["Soy"]'),
('Sinigang', 'Sour soup with vegetables and meat', 'Boil meat with tamarind. Add vegetables and season.', 10, 25, 6, 180, 20.0, 15.0, 5.0, 4.0, 8.0, 600.0, 'Easy', 'Filipino', 'Soup', '["Healthy", "Comfort Food"]', '[]'),
('Kare-Kare', 'Oxtail stew with peanut sauce', 'Simmer oxtail until tender. Add vegetables and peanut sauce.', 20, 60, 6, 320, 28.0, 12.0, 18.0, 6.0, 5.0, 700.0, 'Medium', 'Filipino', 'Main Course', '["Traditional", "Special Occasion"]', '["Peanuts"]'),
('Lechon Kawali', 'Crispy fried pork belly', 'Boil pork belly, then deep fry until crispy.', 30, 45, 4, 450, 35.0, 2.0, 32.0, 0.0, 1.0, 900.0, 'Medium', 'Filipino', 'Main Course', '["Special Occasion", "Crispy"]', '[]'),
('Pancit Canton', 'Stir-fried noodles with vegetables', 'Stir-fry noodles with vegetables and soy sauce.', 15, 20, 4, 280, 12.0, 45.0, 8.0, 3.0, 6.0, 750.0, 'Easy', 'Filipino', 'Main Course', '["Quick", "Vegetarian Option"]', '["Wheat", "Soy"]')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert sample ingredients
INSERT INTO ingredients (name, category, unit, calories_per_unit, protein_per_unit, carbs_per_unit, fat_per_unit) VALUES
('Chicken Breast', 'Meat', 'g', 1.65, 0.31, 0, 0.036),
('Pork Belly', 'Meat', 'g', 5.18, 0.09, 0, 0.56),
('Rice', 'Grain', 'cup', 205, 4.3, 45, 0.4),
('Soy Sauce', 'Condiment', 'tbsp', 8, 1.3, 0.8, 0),
('Vinegar', 'Condiment', 'tbsp', 3, 0, 0.1, 0),
('Garlic', 'Vegetable', 'clove', 4, 0.2, 1, 0),
('Onion', 'Vegetable', 'medium', 44, 1.2, 10.3, 0.1),
('Tomato', 'Vegetable', 'medium', 22, 1.1, 4.8, 0.2),
('Eggplant', 'Vegetable', 'medium', 25, 1, 6, 0.2),
('String Beans', 'Vegetable', 'cup', 31, 1.8, 7, 0.1)
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert sample meal plans
INSERT INTO meal_plans (name, description, start_date, end_date, user_id, is_active) VALUES
('Weekly Filipino Meal Plan', 'A balanced weekly meal plan featuring traditional Filipino dishes', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 2, TRUE),
('Weight Loss Plan', 'Low-calorie meal plan for weight loss', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), 2, FALSE),
('Muscle Building Plan', 'High-protein meal plan for muscle building', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 1, TRUE)
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert sample meal plan items
INSERT INTO meal_plan_items (meal_plan_id, recipe_id, day, meal_type, servings) VALUES
-- Week 1 for user 2's active plan
(1, 1, 1, 'breakfast', 1),
(1, 2, 1, 'lunch', 1),
(1, 3, 1, 'dinner', 1),
(1, 4, 2, 'breakfast', 1),
(1, 5, 2, 'lunch', 1),
(1, 1, 2, 'dinner', 1),
(1, 2, 3, 'breakfast', 1),
(1, 3, 3, 'lunch', 1),
(1, 4, 3, 'dinner', 1),
(1, 5, 4, 'breakfast', 1),
(1, 1, 4, 'lunch', 1),
(1, 2, 4, 'dinner', 1),
(1, 3, 5, 'breakfast', 1),
(1, 4, 5, 'lunch', 1),
(1, 5, 5, 'dinner', 1),
(1, 1, 6, 'breakfast', 1),
(1, 2, 6, 'lunch', 1),
(1, 3, 6, 'dinner', 1),
(1, 4, 7, 'breakfast', 1),
(1, 5, 7, 'lunch', 1),
(1, 1, 7, 'dinner', 1)
ON DUPLICATE KEY UPDATE servings = VALUES(servings);

-- Show created tables
SHOW TABLES;

-- Show sample data
SELECT 'Users:' as Table_Name;
SELECT id, name, email, role FROM users;

SELECT 'Recipes:' as Table_Name;
SELECT id, name, calories, protein FROM recipes LIMIT 5;

SELECT 'Meal Plans:' as Table_Name;
SELECT id, name, user_id, is_active FROM meal_plans;

SELECT 'Meal Plan Items:' as Table_Name;
SELECT mpi.id, mp.name as meal_plan, r.name as recipe, mpi.day, mpi.meal_type 
FROM meal_plan_items mpi 
JOIN meal_plans mp ON mpi.meal_plan_id = mp.id 
JOIN recipes r ON mpi.recipe_id = r.id 
LIMIT 10;
