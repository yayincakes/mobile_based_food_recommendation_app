-- Insert Additional Filipino Breakfast Foods
-- This script adds more variety of Filipino breakfast dishes to the database

-- Insert Additional Breakfast Ingredients
INSERT IGNORE INTO ingredients (name, category, description, created_at, updated_at) VALUES
-- Additional Breakfast Proteins
('tocino', 'Protein', 'Sweet cured pork', NOW(), NOW()),
('corned beef', 'Protein', 'Canned corned beef', NOW(), NOW()),
('spam', 'Protein', 'Canned luncheon meat', NOW(), NOW()),
('hotdog', 'Protein', 'Filipino hotdog', NOW(), NOW()),
('bacon', 'Protein', 'Bacon strips', NOW(), NOW()),
('ham', 'Protein', 'Sliced ham', NOW(), NOW()),
('chorizo', 'Protein', 'Spanish sausage', NOW(), NOW()),
('vienna sausage', 'Protein', 'Canned vienna sausage', NOW(), NOW()),
('sardines in tomato sauce', 'Protein', 'Canned sardines in tomato sauce', NOW(), NOW()),
('tuna flakes', 'Protein', 'Canned tuna flakes', NOW(), NOW()),

-- Additional Breakfast Grains & Starches
('pandesal', 'Bread', 'Filipino bread rolls', NOW(), NOW()),
('ensaymada', 'Bread', 'Sweet bread with cheese', NOW(), NOW()),
('pan de sal', 'Bread', 'Filipino bread', NOW(), NOW()),
('monay', 'Bread', 'Filipino bread roll', NOW(), NOW()),
('puto', 'Rice Cake', 'Steamed rice cake', NOW(), NOW()),
('kutsinta', 'Rice Cake', 'Brown rice cake', NOW(), NOW()),
('pichi-pichi', 'Rice Cake', 'Cassava rice cake', NOW(), NOW()),
('sapin-sapin', 'Rice Cake', 'Layered rice cake', NOW(), NOW()),
('biko', 'Rice Cake', 'Sweet sticky rice', NOW(), NOW()),
('suman', 'Rice Cake', 'Wrapped sticky rice', NOW(), NOW()),

-- Additional Breakfast Vegetables & Fruits
('green papaya', 'Fruit', 'Unripe papaya', NOW(), NOW()),
('ripe papaya', 'Fruit', 'Ripe papaya', NOW(), NOW()),
('ripe mango', 'Fruit', 'Sweet ripe mango', NOW(), NOW()),
('banana', 'Fruit', 'Banana', NOW(), NOW()),
('saba banana', 'Fruit', 'Cooking banana', NOW(), NOW()),
('lacatan banana', 'Fruit', 'Sweet banana variety', NOW(), NOW()),
('avocado', 'Fruit', 'Avocado fruit', NOW(), NOW()),
('guyabano', 'Fruit', 'Soursop', NOW(), NOW()),
('pineapple', 'Fruit', 'Fresh pineapple', NOW(), NOW()),
('watermelon', 'Fruit', 'Fresh watermelon', NOW(), NOW()),

-- Additional Breakfast Condiments & Sauces
('margarine', 'Dairy', 'Margarine spread', NOW(), NOW()),
('cheese', 'Dairy', 'Processed cheese', NOW(), NOW()),
('cheddar cheese', 'Dairy', 'Cheddar cheese', NOW(), NOW()),
('queso de bola', 'Dairy', 'Edam cheese', NOW(), NOW()),
('condensed milk', 'Dairy', 'Sweetened condensed milk', NOW(), NOW()),
('evaporated milk', 'Dairy', 'Evaporated milk', NOW(), NOW()),
('coconut milk', 'Dairy', 'Fresh coconut milk', NOW(), NOW()),
('coconut cream', 'Dairy', 'Coconut cream', NOW(), NOW()),
('butter', 'Dairy', 'Butter', NOW(), NOW()),
('mayonnaise', 'Condiment', 'Mayonnaise', NOW(), NOW()),

-- Additional Breakfast Spices & Seasonings
('vanilla extract', 'Flavoring', 'Vanilla extract', NOW(), NOW()),
('cinnamon', 'Spice', 'Cinnamon powder', NOW(), NOW()),
('nutmeg', 'Spice', 'Nutmeg powder', NOW(), NOW()),
('cardamom', 'Spice', 'Cardamom powder', NOW(), NOW()),
('star anise', 'Spice', 'Star anise', NOW(), NOW()),
('cloves', 'Spice', 'Cloves', NOW(), NOW()),
('allspice', 'Spice', 'Allspice powder', NOW(), NOW()),
('pandan leaves', 'Herb', 'Pandan leaves', NOW(), NOW()),
('lemongrass', 'Herb', 'Lemongrass', NOW(), NOW()),
('bay leaves', 'Herb', 'Bay leaves', NOW(), NOW());

-- Insert Additional Filipino Breakfast Recipes
INSERT IGNORE INTO recipes (name, description, prep_time, cook_time, servings, difficulty, category, calories_per_serving, protein_per_serving, carbs_per_serving, fat_per_serving, instructions, is_filipino_dish, created_at, updated_at) VALUES

-- Traditional Filipino Breakfast Dishes
('Tocilog', 'Tocino, Sinangag, at Itlog - Sweet cured pork with garlic rice and egg', 10, 20, 2, 'Easy', 'Filipino', 580, 32, 58, 22, 'Cook tocino until caramelized, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Cornsilog', 'Corned beef, Sinangag, at Itlog - Corned beef with garlic rice and egg', 5, 15, 2, 'Easy', 'Filipino', 520, 28, 58, 18, 'Sauté corned beef with onions, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Spamsilog', 'Spam, Sinangag, at Itlog - Spam with garlic rice and egg', 5, 15, 2, 'Easy', 'Filipino', 540, 26, 58, 20, 'Fry spam slices, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Hotdogsilog', 'Hotdog, Sinangag, at Itlog - Filipino hotdog with garlic rice and egg', 5, 15, 2, 'Easy', 'Filipino', 500, 24, 58, 16, 'Fry hotdog, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Baconsilog', 'Bacon, Sinangag, at Itlog - Bacon with garlic rice and egg', 5, 15, 2, 'Easy', 'Filipino', 560, 30, 58, 24, 'Fry bacon until crispy, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Hamsilog', 'Ham, Sinangag, at Itlog - Ham with garlic rice and egg', 5, 10, 2, 'Easy', 'Filipino', 480, 28, 58, 14, 'Heat ham slices, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Chorisilog', 'Chorizo, Sinangag, at Itlog - Spanish sausage with garlic rice and egg', 5, 15, 2, 'Easy', 'Filipino', 520, 26, 58, 18, 'Cook chorizo, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Viennasilog', 'Vienna Sausage, Sinangag, at Itlog - Vienna sausage with garlic rice and egg', 5, 10, 2, 'Easy', 'Filipino', 460, 22, 58, 14, 'Heat vienna sausage, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Sardinesilog', 'Sardines, Sinangag, at Itlog - Sardines with garlic rice and egg', 5, 10, 2, 'Easy', 'Filipino', 480, 26, 58, 16, 'Sauté sardines with onions, prepare garlic rice, fry egg', 1, NOW(), NOW()),
('Tunasilog', 'Tuna, Sinangag, at Itlog - Tuna flakes with garlic rice and egg', 5, 10, 2, 'Easy', 'Filipino', 460, 24, 58, 14, 'Sauté tuna flakes with onions, prepare garlic rice, fry egg', 1, NOW(), NOW()),

-- Filipino Bread Breakfasts
('Pandesal with Butter and Cheese', 'Soft Filipino bread with butter and cheese', 5, 5, 2, 'Easy', 'Filipino', 320, 12, 44, 8, 'Toast pandesal, spread butter, add cheese', 1, NOW(), NOW()),
('Pandesal with Jam', 'Soft Filipino bread with fruit jam', 5, 5, 2, 'Easy', 'Filipino', 280, 8, 52, 4, 'Toast pandesal, spread jam', 1, NOW(), NOW()),
('Pandesal with Peanut Butter', 'Soft Filipino bread with peanut butter', 5, 5, 2, 'Easy', 'Filipino', 340, 14, 44, 12, 'Toast pandesal, spread peanut butter', 1, NOW(), NOW()),
('Ensaymada', 'Sweet bread with cheese and sugar', 10, 20, 4, 'Medium', 'Filipino', 380, 12, 58, 14, 'Make sweet bread dough, add cheese, bake', 1, NOW(), NOW()),
('Pan de Sal with Scrambled Egg', 'Filipino bread with scrambled eggs', 5, 10, 2, 'Easy', 'Filipino', 360, 20, 44, 14, 'Toast pan de sal, scramble eggs with milk', 1, NOW(), NOW()),
('Monay with Butter', 'Filipino bread roll with butter', 5, 5, 2, 'Easy', 'Filipino', 300, 10, 44, 8, 'Warm monay, spread butter', 1, NOW(), NOW()),

-- Filipino Rice Cakes for Breakfast
('Puto with Cheese', 'Steamed rice cake with cheese', 15, 20, 6, 'Easy', 'Filipino', 180, 6, 32, 4, 'Make rice cake batter, steam, top with cheese', 1, NOW(), NOW()),
('Puto with Salted Egg', 'Steamed rice cake with salted egg', 15, 20, 6, 'Easy', 'Filipino', 200, 8, 32, 6, 'Make rice cake batter, steam, top with salted egg', 1, NOW(), NOW()),
('Kutsinta', 'Brown rice cake with coconut', 20, 25, 8, 'Easy', 'Filipino', 160, 4, 35, 2, 'Make brown rice cake batter, steam, serve with coconut', 1, NOW(), NOW()),
('Pichi-Pichi', 'Cassava rice cake with coconut', 20, 25, 8, 'Easy', 'Filipino', 180, 4, 38, 3, 'Make cassava batter, steam, serve with coconut', 1, NOW(), NOW()),
('Sapin-Sapin', 'Layered rice cake', 30, 30, 8, 'Medium', 'Filipino', 220, 6, 42, 4, 'Make layered rice cake with different colors, steam', 1, NOW(), NOW()),
('Biko', 'Sweet sticky rice with coconut', 20, 30, 6, 'Easy', 'Filipino', 280, 6, 58, 6, 'Cook sticky rice with coconut milk and sugar', 1, NOW(), NOW()),
('Suman with Mango', 'Wrapped sticky rice with mango', 25, 30, 6, 'Medium', 'Filipino', 240, 4, 52, 4, 'Wrap sticky rice in banana leaves, steam, serve with mango', 1, NOW(), NOW()),

-- Filipino Porridge Breakfasts
('Ginataang Mais', 'Sweet corn in coconut milk', 10, 20, 4, 'Easy', 'Filipino', 220, 6, 38, 8, 'Cook corn in coconut milk with sugar', 1, NOW(), NOW()),
('Ginataang Saba', 'Sweet banana in coconut milk', 10, 20, 4, 'Easy', 'Filipino', 200, 4, 42, 6, 'Cook saba banana in coconut milk with sugar', 1, NOW(), NOW()),
('Ginataang Kamote', 'Sweet potato in coconut milk', 10, 25, 4, 'Easy', 'Filipino', 240, 6, 45, 8, 'Cook sweet potato in coconut milk with sugar', 1, NOW(), NOW()),
('Ginataang Bilo-Bilo', 'Sweet rice balls in coconut milk', 20, 25, 6, 'Medium', 'Filipino', 280, 6, 52, 8, 'Make rice balls, cook in coconut milk with fruits', 1, NOW(), NOW()),
('Ginataang Halo-Halo', 'Mixed fruits in coconut milk', 15, 20, 6, 'Easy', 'Filipino', 200, 4, 38, 6, 'Cook mixed fruits in coconut milk with sugar', 1, NOW(), NOW()),

-- Filipino Omelet Breakfasts
('Tortang Talong', 'Eggplant omelet', 15, 15, 3, 'Easy', 'Filipino', 180, 12, 15, 10, 'Grill eggplant, wrap in beaten egg, cook', 1, NOW(), NOW()),
('Tortang Giniling', 'Ground meat omelet', 15, 20, 4, 'Easy', 'Filipino', 280, 20, 8, 18, 'Sauté ground meat, mix with beaten egg, cook', 1, NOW(), NOW()),
('Tortang Alimasag', 'Crab omelet', 20, 15, 3, 'Medium', 'Filipino', 220, 18, 8, 12, 'Mix crab meat with beaten egg, cook', 1, NOW(), NOW()),
('Tortang Hipon', 'Shrimp omelet', 15, 15, 3, 'Easy', 'Filipino', 200, 16, 8, 10, 'Mix shrimp with beaten egg, cook', 1, NOW(), NOW()),
('Tortang Isda', 'Fish omelet', 15, 15, 3, 'Easy', 'Filipino', 190, 18, 8, 10, 'Mix fish with beaten egg, cook', 1, NOW(), NOW()),

-- Filipino Pancake Breakfasts
('Pancake with Margarine', 'Filipino pancake with margarine', 10, 15, 4, 'Easy', 'Filipino', 220, 8, 32, 8, 'Make pancake batter, cook, serve with margarine', 1, NOW(), NOW()),
('Pancake with Cheese', 'Filipino pancake with cheese', 10, 15, 4, 'Easy', 'Filipino', 240, 12, 32, 10, 'Make pancake batter, cook, top with cheese', 1, NOW(), NOW()),
('Pancake with Jam', 'Filipino pancake with fruit jam', 10, 15, 4, 'Easy', 'Filipino', 200, 6, 38, 6, 'Make pancake batter, cook, serve with jam', 1, NOW(), NOW()),
('Pancake with Condensed Milk', 'Filipino pancake with condensed milk', 10, 15, 4, 'Easy', 'Filipino', 260, 8, 42, 8, 'Make pancake batter, cook, drizzle with condensed milk', 1, NOW(), NOW()),

-- Filipino Fruit Breakfasts
('Fresh Fruit Salad', 'Mixed Filipino fruits', 15, 0, 4, 'Easy', 'Filipino', 120, 2, 28, 1, 'Mix fresh fruits together', 1, NOW(), NOW()),
('Mango with Rice', 'Sweet mango with rice', 10, 15, 2, 'Easy', 'Filipino', 320, 6, 68, 2, 'Cook rice, serve with sliced mango', 1, NOW(), NOW()),
('Banana with Rice', 'Sweet banana with rice', 10, 15, 2, 'Easy', 'Filipino', 300, 6, 65, 2, 'Cook rice, serve with sliced banana', 1, NOW(), NOW()),
('Avocado with Condensed Milk', 'Avocado with sweetened condensed milk', 10, 0, 2, 'Easy', 'Filipino', 280, 6, 42, 12, 'Slice avocado, drizzle with condensed milk', 1, NOW(), NOW()),
('Guyabano Smoothie', 'Soursop smoothie', 10, 0, 2, 'Easy', 'Filipino', 180, 4, 38, 2, 'Blend guyabano with milk and sugar', 1, NOW(), NOW()),

-- Filipino Healthy Breakfast Options
('Malunggay Omelet', 'Moringa leaves omelet', 10, 15, 3, 'Easy', 'Healthy', 160, 12, 8, 10, 'Mix moringa leaves with beaten egg, cook', 1, NOW(), NOW()),
('Kangkong Omelet', 'Water spinach omelet', 10, 15, 3, 'Easy', 'Healthy', 140, 10, 8, 8, 'Mix water spinach with beaten egg, cook', 1, NOW(), NOW()),
('Ampalaya Omelet', 'Bitter gourd omelet', 15, 15, 3, 'Easy', 'Healthy', 120, 8, 8, 6, 'Mix bitter gourd with beaten egg, cook', 1, NOW(), NOW()),
('Ginataang Malunggay', 'Moringa leaves in coconut milk', 5, 15, 3, 'Easy', 'Healthy', 100, 6, 8, 6, 'Cook moringa leaves in coconut milk', 1, NOW(), NOW()),
('Ginataang Kangkong', 'Water spinach in coconut milk', 5, 15, 3, 'Easy', 'Healthy', 80, 4, 8, 4, 'Cook water spinach in coconut milk', 1, NOW(), NOW()),

-- Filipino Modern Breakfast Options
('Filipino Breakfast Burrito', 'Tortilla with Filipino fillings', 15, 10, 2, 'Easy', 'Filipino', 420, 20, 45, 18, 'Wrap Filipino ingredients in tortilla', 1, NOW(), NOW()),
('Filipino Breakfast Bowl', 'Rice bowl with Filipino toppings', 10, 15, 2, 'Easy', 'Filipino', 380, 18, 52, 12, 'Top rice with Filipino breakfast ingredients', 1, NOW(), NOW()),
('Filipino Breakfast Sandwich', 'Sandwich with Filipino fillings', 10, 10, 2, 'Easy', 'Filipino', 360, 16, 38, 14, 'Make sandwich with Filipino breakfast ingredients', 1, NOW(), NOW()),
('Filipino Breakfast Wrap', 'Wrap with Filipino fillings', 10, 10, 2, 'Easy', 'Filipino', 340, 14, 42, 12, 'Wrap Filipino ingredients in flatbread', 1, NOW(), NOW());

-- Display summary
SELECT 'Additional Filipino breakfast foods inserted successfully!' as message;
SELECT COUNT(*) as total_recipes FROM recipes;
SELECT COUNT(*) as total_ingredients FROM ingredients;
SELECT COUNT(*) as breakfast_recipes FROM recipes WHERE name LIKE '%silog' OR name LIKE '%Pandesal%' OR name LIKE '%Puto%' OR name LIKE '%Ginataang%' OR name LIKE '%Tortang%' OR name LIKE '%Pancake%' OR name LIKE '%Fresh Fruit%' OR name LIKE '%Malunggay%' OR name LIKE '%Kangkong%' OR name LIKE '%Ampalaya%' OR name LIKE '%Filipino Breakfast%';
