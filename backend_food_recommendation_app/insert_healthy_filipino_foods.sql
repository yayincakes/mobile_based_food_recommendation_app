-- Insert 50 Additional Healthy Filipino Foods
-- This script adds 50 more healthy Filipino recipes to give users more variety

-- Insert Additional Healthy Ingredients
INSERT IGNORE INTO ingredients (name, category, description, created_at, updated_at) VALUES
-- Healthy Proteins
('salmon', 'Protein', 'Fresh salmon', NOW(), NOW()),
('tuna', 'Protein', 'Fresh tuna', NOW(), NOW()),
('mackerel', 'Protein', 'Fresh mackerel', NOW(), NOW()),
('sardines', 'Protein', 'Fresh sardines', NOW(), NOW()),
('chicken breast', 'Protein', 'Skinless chicken breast', NOW(), NOW()),
('lean pork', 'Protein', 'Lean pork cuts', NOW(), NOW()),
('tofu', 'Protein', 'Firm tofu', NOW(), NOW()),
('tempeh', 'Protein', 'Tempeh', NOW(), NOW()),
('quail eggs', 'Protein', 'Quail eggs', NOW(), NOW()),
('duck eggs', 'Protein', 'Duck eggs', NOW(), NOW()),

-- Healthy Grains & Starches
('quinoa', 'Grain', 'Quinoa', NOW(), NOW()),
('oats', 'Grain', 'Rolled oats', NOW(), NOW()),
('barley', 'Grain', 'Pearl barley', NOW(), NOW()),
('buckwheat', 'Grain', 'Buckwheat', NOW(), NOW()),
('wild rice', 'Grain', 'Wild rice', NOW(), NOW()),
('red rice', 'Grain', 'Red rice', NOW(), NOW()),
('black rice', 'Grain', 'Black rice', NOW(), NOW()),
('sweet potato leaves', 'Vegetable', 'Sweet potato leaves (talbos)', NOW(), NOW()),
('malunggay', 'Vegetable', 'Moringa leaves', NOW(), NOW()),
('kangkong', 'Vegetable', 'Water spinach', NOW(), NOW()),

-- Healthy Vegetables
('okra', 'Vegetable', 'Okra', NOW(), NOW()),
('ampalaya', 'Vegetable', 'Bitter gourd', NOW(), NOW()),
('sitaw', 'Vegetable', 'String beans', NOW(), NOW()),
('patola', 'Vegetable', 'Sponge gourd', NOW(), NOW()),
('upo', 'Vegetable', 'Bottle gourd', NOW(), NOW()),
('kalabasa', 'Vegetable', 'Squash', NOW(), NOW()),
('gabi', 'Vegetable', 'Taro root', NOW(), NOW()),
('camote tops', 'Vegetable', 'Sweet potato tops', NOW(), NOW()),
('alugbati', 'Vegetable', 'Basella', NOW(), NOW()),
('pechay', 'Vegetable', 'Chinese cabbage', NOW(), NOW()),

-- Healthy Fruits
('guyabano', 'Fruit', 'Soursop', NOW(), NOW()),
('lansones', 'Fruit', 'Lansones', NOW(), NOW()),
('rambutan', 'Fruit', 'Rambutan', NOW(), NOW()),
('duhat', 'Fruit', 'Java plum', NOW(), NOW()),
('santol', 'Fruit', 'Santol', NOW(), NOW()),
('atis', 'Fruit', 'Sugar apple', NOW(), NOW()),
('chico', 'Fruit', 'Sapodilla', NOW(), NOW()),
('papaya', 'Fruit', 'Papaya', NOW(), NOW()),
('pineapple', 'Fruit', 'Pineapple', NOW(), NOW()),
('coconut', 'Fruit', 'Fresh coconut', NOW(), NOW()),

-- Healthy Nuts & Seeds
('cashew nuts', 'Nut', 'Cashew nuts', NOW(), NOW()),
('almonds', 'Nut', 'Almonds', NOW(), NOW()),
('walnuts', 'Nut', 'Walnuts', NOW(), NOW()),
('chia seeds', 'Seed', 'Chia seeds', NOW(), NOW()),
('flax seeds', 'Seed', 'Flax seeds', NOW(), NOW()),
('sesame seeds', 'Seed', 'Sesame seeds', NOW(), NOW()),
('sunflower seeds', 'Seed', 'Sunflower seeds', NOW(), NOW()),

-- Healthy Condiments
('coconut oil', 'Fat', 'Virgin coconut oil', NOW(), NOW()),
('avocado oil', 'Fat', 'Avocado oil', NOW(), NOW()),
('sesame oil', 'Fat', 'Sesame oil', NOW(), NOW()),
('coconut vinegar', 'Condiment', 'Coconut vinegar', NOW(), NOW()),
('cane vinegar', 'Condiment', 'Cane vinegar', NOW(), NOW()),
('calamansi', 'Fruit', 'Calamansi lime', NOW(), NOW()),
('lemongrass', 'Herb', 'Lemongrass', NOW(), NOW()),
('pandan', 'Herb', 'Pandan leaves', NOW(), NOW()),
('turmeric', 'Spice', 'Turmeric root', NOW(), NOW()),
('spinach', 'Vegetable', 'Fresh spinach', NOW(), NOW()),
('cauliflower', 'Vegetable', 'Cauliflower', NOW(), NOW()),
('bell peppers', 'Vegetable', 'Bell peppers', NOW(), NOW()),
('mushrooms', 'Vegetable', 'Fresh mushrooms', NOW(), NOW()),
('jackfruit', 'Fruit', 'Jackfruit', NOW(), NOW()),
('glutinous rice', 'Grain', 'Glutinous rice', NOW(), NOW()),
('condensed milk', 'Dairy', 'Condensed milk', NOW(), NOW()),
('cream', 'Dairy', 'Fresh cream', NOW(), NOW()),
('greek yogurt', 'Dairy', 'Greek yogurt', NOW(), NOW()),
('honey', 'Sweetener', 'Natural honey', NOW(), NOW()),
('cinnamon', 'Spice', 'Cinnamon powder', NOW(), NOW()),
('paprika', 'Spice', 'Paprika powder', NOW(), NOW()),
('mint leaves', 'Herb', 'Fresh mint leaves', NOW(), NOW()),
('lettuce', 'Vegetable', 'Fresh lettuce', NOW(), NOW()),
('cucumber', 'Vegetable', 'Fresh cucumber', NOW(), NOW()),
('rice paper', 'Wrapper', 'Rice paper wrappers', NOW(), NOW());

-- Insert 50 Additional Healthy Filipino Recipes
INSERT IGNORE INTO recipes (name, description, prep_time, cook_time, servings, difficulty, category, calories_per_serving, protein_per_serving, carbs_per_serving, fat_per_serving, instructions, is_filipino_dish, created_at, updated_at) VALUES
-- Healthy Breakfast Options
('Oatmeal with Malunggay and Banana', 'Nutritious oatmeal with moringa leaves and banana', 5, 10, 2, 'Easy', 'Healthy', 280, 12, 45, 6, 'Cook oats with water, add malunggay leaves and sliced banana', 1, NOW(), NOW()),
('Quinoa Champorado', 'Healthy chocolate quinoa porridge', 5, 15, 2, 'Easy', 'Healthy', 320, 8, 55, 7, 'Cook quinoa with cocoa powder and coconut milk', 1, NOW(), NOW()),
('Tofu Scramble with Vegetables', 'Scrambled tofu with mixed vegetables', 10, 15, 2, 'Easy', 'Healthy', 180, 15, 12, 8, 'Scramble tofu with vegetables and spices', 1, NOW(), NOW()),
('Sweet Potato Hash', 'Roasted sweet potato with vegetables', 10, 25, 3, 'Easy', 'Healthy', 220, 6, 42, 4, 'Roast diced sweet potato with vegetables and herbs', 1, NOW(), NOW()),
('Green Smoothie Bowl', 'Nutritious smoothie bowl with Filipino fruits', 10, 0, 1, 'Easy', 'Healthy', 250, 8, 45, 6, 'Blend spinach, mango, banana, and coconut milk', 1, NOW(), NOW()),

-- Healthy Soups & Stews
('Ginataang Kalabasa', 'Squash in coconut milk with vegetables', 15, 20, 4, 'Easy', 'Healthy', 180, 6, 25, 8, 'Cook squash in coconut milk with vegetables', 1, NOW(), NOW()),
('Tinolang Isda', 'Healthy fish soup with ginger and vegetables', 15, 20, 4, 'Easy', 'Healthy', 200, 25, 15, 5, 'Boil fish with ginger, add vegetables and season', 1, NOW(), NOW()),
('Ginisang Monggo with Malunggay', 'Mung beans with moringa leaves', 10, 30, 4, 'Easy', 'Healthy', 160, 12, 22, 3, 'Cook mung beans, sauté with vegetables and malunggay', 1, NOW(), NOW()),
('Sinigang na Hipon', 'Sour soup with shrimp and vegetables', 15, 25, 4, 'Easy', 'Healthy', 150, 18, 12, 4, 'Boil shrimp with tamarind and vegetables', 1, NOW(), NOW()),
('Nilagang Baka with Vegetables', 'Boiled beef with mixed vegetables', 20, 60, 6, 'Medium', 'Healthy', 280, 30, 20, 8, 'Boil beef until tender, add vegetables', 1, NOW(), NOW()),

-- Healthy Main Dishes
('Grilled Salmon with Atchara', 'Grilled salmon with pickled vegetables', 15, 15, 2, 'Easy', 'Healthy', 320, 35, 8, 16, 'Grill salmon, serve with atchara', 1, NOW(), NOW()),
('Chicken Breast Adobo', 'Healthy chicken breast adobo', 15, 25, 4, 'Easy', 'Healthy', 220, 35, 8, 6, 'Marinate chicken breast, cook in soy sauce and vinegar', 1, NOW(), NOW()),
('Tofu Sisig', 'Healthy tofu sisig', 20, 15, 4, 'Medium', 'Healthy', 180, 15, 8, 10, 'Sauté tofu with vegetables and spices', 1, NOW(), NOW()),
('Baked Bangus with Herbs', 'Baked milkfish with fresh herbs', 15, 25, 2, 'Easy', 'Healthy', 250, 30, 5, 12, 'Bake bangus with herbs and lemon', 1, NOW(), NOW()),
('Vegetable Kare-Kare', 'Vegetarian kare-kare with peanut sauce', 20, 30, 6, 'Medium', 'Healthy', 200, 8, 25, 10, 'Cook vegetables in peanut sauce', 1, NOW(), NOW()),

-- Healthy Vegetable Dishes
('Ampalaya with Egg', 'Bitter gourd with scrambled egg', 15, 15, 3, 'Easy', 'Healthy', 120, 8, 8, 6, 'Sauté ampalaya with scrambled egg', 1, NOW(), NOW()),
('Ginataang Sitaw at Kalabasa', 'String beans and squash in coconut milk', 10, 20, 4, 'Easy', 'Healthy', 150, 4, 20, 8, 'Cook vegetables in coconut milk', 1, NOW(), NOW()),
('Kangkong with Garlic', 'Water spinach with garlic', 5, 10, 3, 'Easy', 'Healthy', 60, 4, 8, 2, 'Sauté kangkong with garlic', 1, NOW(), NOW()),
('Ginisang Pechay', 'Sautéed Chinese cabbage', 5, 10, 3, 'Easy', 'Healthy', 50, 3, 6, 2, 'Sauté pechay with garlic and onion', 1, NOW(), NOW()),
('Malunggay with Gata', 'Moringa leaves in coconut milk', 5, 15, 3, 'Easy', 'Healthy', 80, 4, 6, 5, 'Cook malunggay in coconut milk', 1, NOW(), NOW()),

-- Healthy Snacks & Desserts
('Buko Pandan Salad', 'Young coconut with pandan jelly', 20, 15, 6, 'Easy', 'Healthy', 120, 2, 25, 2, 'Mix young coconut with pandan jelly and condensed milk', 1, NOW(), NOW()),
('Turon with Banana and Jackfruit', 'Healthy banana and jackfruit spring roll', 15, 20, 6, 'Easy', 'Healthy', 180, 3, 35, 5, 'Wrap banana and jackfruit in spring roll wrapper, bake', 1, NOW(), NOW()),
('Ginataang Bilo-Bilo', 'Sweet rice balls in coconut milk', 20, 25, 6, 'Medium', 'Healthy', 200, 4, 35, 6, 'Make rice balls, cook in coconut milk with fruits', 1, NOW(), NOW()),
('Fresh Fruit Salad', 'Mixed Filipino fruits with yogurt', 15, 0, 4, 'Easy', 'Healthy', 150, 6, 30, 2, 'Mix fresh fruits with Greek yogurt', 1, NOW(), NOW()),
('Chia Pudding with Mango', 'Chia seed pudding with fresh mango', 10, 0, 2, 'Easy', 'Healthy', 200, 8, 25, 8, 'Soak chia seeds in coconut milk, top with mango', 1, NOW(), NOW()),

-- Healthy Rice Alternatives
('Cauliflower Rice', 'Grated cauliflower as rice substitute', 10, 10, 3, 'Easy', 'Healthy', 50, 3, 8, 2, 'Grate cauliflower, sauté with garlic and oil', 1, NOW(), NOW()),
('Quinoa Fried Rice', 'Fried quinoa with vegetables', 10, 15, 3, 'Easy', 'Healthy', 220, 8, 35, 6, 'Cook quinoa, stir-fry with vegetables and soy sauce', 1, NOW(), NOW()),
('Brown Rice Congee', 'Healthy brown rice porridge', 5, 30, 4, 'Easy', 'Healthy', 180, 6, 35, 3, 'Cook brown rice in chicken broth until soft', 1, NOW(), NOW()),

-- Healthy Drinks
('Malunggay Smoothie', 'Nutritious moringa smoothie', 10, 0, 2, 'Easy', 'Healthy', 120, 6, 20, 3, 'Blend malunggay leaves with fruits and coconut water', 1, NOW(), NOW()),
('Ginger Turmeric Tea', 'Anti-inflammatory ginger turmeric tea', 5, 10, 2, 'Easy', 'Healthy', 20, 1, 4, 0, 'Boil ginger and turmeric, add honey and lemon', 1, NOW(), NOW()),
('Calamansi Detox Drink', 'Refreshing calamansi detox drink', 5, 0, 2, 'Easy', 'Healthy', 30, 1, 8, 0, 'Mix calamansi juice with water and honey', 1, NOW(), NOW()),

-- Additional Healthy Dishes
('Grilled Tuna Steak', 'Grilled tuna with herbs and lemon', 15, 12, 2, 'Easy', 'Healthy', 280, 40, 5, 10, 'Grill tuna steak with herbs and lemon', 1, NOW(), NOW()),
('Vegetable Lumpia', 'Fresh vegetable spring rolls', 30, 0, 8, 'Medium', 'Healthy', 80, 4, 12, 2, 'Wrap fresh vegetables in rice paper', 1, NOW(), NOW()),
('Steamed Fish with Ginger', 'Steamed fish with ginger and soy sauce', 10, 15, 2, 'Easy', 'Healthy', 200, 35, 5, 4, 'Steam fish with ginger and soy sauce', 1, NOW(), NOW()),
('Mushroom Adobo', 'Vegetarian mushroom adobo', 10, 20, 4, 'Easy', 'Healthy', 120, 8, 15, 4, 'Cook mushrooms in soy sauce and vinegar', 1, NOW(), NOW()),
('Baked Sweet Potato Fries', 'Healthy baked sweet potato fries', 10, 25, 4, 'Easy', 'Healthy', 150, 3, 30, 4, 'Cut sweet potato into fries, bake until crispy', 1, NOW(), NOW()),

-- More Healthy Filipino Dishes
('Ginataang Langka', 'Jackfruit in coconut milk', 15, 20, 4, 'Easy', 'Healthy', 180, 4, 35, 6, 'Cook jackfruit in coconut milk with spices', 1, NOW(), NOW()),
('Paksiw na Isda', 'Fish cooked in vinegar and ginger', 10, 20, 4, 'Easy', 'Healthy', 160, 25, 8, 4, 'Cook fish in vinegar with ginger and vegetables', 1, NOW(), NOW()),
('Ginisang Togue', 'Sautéed bean sprouts', 5, 10, 3, 'Easy', 'Healthy', 40, 3, 6, 1, 'Sauté bean sprouts with garlic and onion', 1, NOW(), NOW()),
('Tortang Talong', 'Eggplant omelet', 15, 15, 3, 'Easy', 'Healthy', 140, 8, 12, 8, 'Grill eggplant, wrap in beaten egg and cook', 1, NOW(), NOW()),
('Ensaladang Mangga', 'Green mango salad', 10, 0, 4, 'Easy', 'Healthy', 60, 1, 15, 0, 'Mix green mango with tomatoes and onions', 1, NOW(), NOW()),

-- More Healthy Options
('Ginataang Gulay', 'Mixed vegetables in coconut milk', 15, 20, 4, 'Easy', 'Healthy', 120, 4, 18, 6, 'Cook mixed vegetables in coconut milk', 1, NOW(), NOW()),
('Paksiw na Bangus', 'Milkfish cooked in vinegar', 10, 20, 4, 'Easy', 'Healthy', 180, 25, 8, 6, 'Cook bangus in vinegar with ginger', 1, NOW(), NOW()),
('Ginisang Sayote', 'Sautéed chayote', 10, 15, 3, 'Easy', 'Healthy', 50, 2, 8, 2, 'Sauté chayote with garlic and onion', 1, NOW(), NOW()),
('Tinolang Manok', 'Chicken soup with ginger', 15, 25, 4, 'Easy', 'Healthy', 200, 22, 12, 6, 'Boil chicken with ginger, add vegetables', 1, NOW(), NOW()),
('Ginataang Hipon', 'Shrimp in coconut milk', 15, 20, 4, 'Easy', 'Healthy', 160, 18, 8, 8, 'Cook shrimp in coconut milk with vegetables', 1, NOW(), NOW()),

-- Final Healthy Dishes
('Ginisang Repolyo', 'Sautéed cabbage', 5, 10, 3, 'Easy', 'Healthy', 40, 2, 6, 2, 'Sauté cabbage with garlic and onion', 1, NOW(), NOW()),
('Paksiw na Bangus sa Gata', 'Milkfish in coconut milk', 15, 20, 4, 'Easy', 'Healthy', 220, 25, 8, 10, 'Cook bangus in coconut milk with vegetables', 1, NOW(), NOW()),
('Ginataang Kalabasa at Sitaw', 'Squash and string beans in coconut milk', 10, 20, 4, 'Easy', 'Healthy', 140, 4, 20, 6, 'Cook vegetables in coconut milk', 1, NOW(), NOW()),
('Tinolang Hipon', 'Shrimp soup with ginger', 15, 20, 4, 'Easy', 'Healthy', 140, 18, 8, 4, 'Boil shrimp with ginger and vegetables', 1, NOW(), NOW()),
('Ginisang Ampalaya', 'Sautéed bitter gourd', 10, 15, 3, 'Easy', 'Healthy', 60, 3, 8, 2, 'Sauté ampalaya with garlic and onion', 1, NOW(), NOW());

-- Display summary
SELECT '50 additional healthy Filipino foods inserted successfully!' as message;
SELECT COUNT(*) as total_recipes FROM recipes;
SELECT COUNT(*) as total_ingredients FROM ingredients;
SELECT COUNT(*) as healthy_recipes FROM recipes WHERE category = 'Healthy';
SELECT COUNT(*) as filipino_recipes FROM recipes WHERE is_filipino_dish = 1;
