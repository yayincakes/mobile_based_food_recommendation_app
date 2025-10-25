<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recipe;
use App\Models\Ingredient;
use App\Models\MealPlan;
use App\Models\MealPlanItem;
use App\Models\User;

class DashboardRecipesSeeder extends Seeder
{
    public function run(): void
    {
        // Create a default user for meal plans if none exists
        $user = User::first();
        if (!$user) {
            $user = User::create([
                'name' => 'Default User',
                'email' => 'user@example.com',
                'password' => bcrypt('password'),
                'role' => 'user',
                'is_active' => true,
            ]);
        }

        // Create ingredients first
        $this->createIngredients();
        
        // Create recipes
        $this->createRecipes();
        
        // Create meal plans
        $this->createMealPlans($user->id);
    }

    private function createIngredients(): void
    {
        $ingredients = [
            // Proteins
            ['name' => 'beef tapa', 'category' => 'Protein', 'description' => 'Marinated beef strips'],
            ['name' => 'chicken', 'category' => 'Protein', 'description' => 'Chicken meat'],
            ['name' => 'pork', 'category' => 'Protein', 'description' => 'Pork meat'],
            ['name' => 'beef', 'category' => 'Protein', 'description' => 'Beef meat'],
            ['name' => 'fish', 'category' => 'Protein', 'description' => 'Fish meat'],
            ['name' => 'bangus', 'category' => 'Protein', 'description' => 'Milkfish'],
            ['name' => 'tilapia', 'category' => 'Protein', 'description' => 'Tilapia fish'],
            ['name' => 'oxtail', 'category' => 'Protein', 'description' => 'Oxtail meat'],
            ['name' => 'pork belly', 'category' => 'Protein', 'description' => 'Pork belly'],
            ['name' => 'egg', 'category' => 'Protein', 'description' => 'Chicken eggs'],
            ['name' => 'tuyo', 'category' => 'Protein', 'description' => 'Dried fish'],
            ['name' => 'shrimp', 'category' => 'Protein', 'description' => 'Shrimp'],
            
            // Grains & Starches
            ['name' => 'rice', 'category' => 'Grain', 'description' => 'White rice'],
            ['name' => 'brown rice', 'category' => 'Grain', 'description' => 'Brown rice'],
            ['name' => 'garlic rice', 'category' => 'Grain', 'description' => 'Fried rice with garlic'],
            ['name' => 'pandesal', 'category' => 'Bread', 'description' => 'Filipino bread rolls'],
            ['name' => 'saba banana', 'category' => 'Fruit', 'description' => 'Cooking banana'],
            ['name' => 'sweet potato', 'category' => 'Vegetable', 'description' => 'Sweet potato'],
            ['name' => 'kamote', 'category' => 'Vegetable', 'description' => 'Sweet potato'],
            ['name' => 'potatoes', 'category' => 'Vegetable', 'description' => 'Potatoes'],
            ['name' => 'carrots', 'category' => 'Vegetable', 'description' => 'Carrots'],
            ['name' => 'mung beans', 'category' => 'Legume', 'description' => 'Mung beans'],
            ['name' => 'mais', 'category' => 'Grain', 'description' => 'Corn'],
            
            // Vegetables
            ['name' => 'mixed vegetables', 'category' => 'Vegetable', 'description' => 'Assorted vegetables'],
            ['name' => 'onion', 'category' => 'Vegetable', 'description' => 'Onions'],
            ['name' => 'garlic', 'category' => 'Vegetable', 'description' => 'Garlic'],
            ['name' => 'ginger', 'category' => 'Vegetable', 'description' => 'Ginger root'],
            ['name' => 'tomato', 'category' => 'Vegetable', 'description' => 'Tomatoes'],
            ['name' => 'tomatoes', 'category' => 'Vegetable', 'description' => 'Tomatoes'],
            ['name' => 'eggplant', 'category' => 'Vegetable', 'description' => 'Eggplant'],
            ['name' => 'taro leaves', 'category' => 'Vegetable', 'description' => 'Taro leaves'],
            ['name' => 'cabbage', 'category' => 'Vegetable', 'description' => 'Cabbage'],
            ['name' => 'spring onion', 'category' => 'Vegetable', 'description' => 'Spring onions'],
            ['name' => 'green papaya', 'category' => 'Fruit', 'description' => 'Green papaya'],
            
            // Condiments & Sauces
            ['name' => 'soy sauce', 'category' => 'Condiment', 'description' => 'Soy sauce'],
            ['name' => 'vinegar', 'category' => 'Condiment', 'description' => 'Vinegar'],
            ['name' => 'fish sauce', 'category' => 'Condiment', 'description' => 'Fish sauce'],
            ['name' => 'bagoong', 'category' => 'Condiment', 'description' => 'Shrimp paste'],
            ['name' => 'bay leaves', 'category' => 'Spice', 'description' => 'Bay leaves'],
            ['name' => 'salt', 'category' => 'Spice', 'description' => 'Salt'],
            ['name' => 'sugar', 'category' => 'Sweetener', 'description' => 'Sugar'],
            ['name' => 'brown sugar', 'category' => 'Sweetener', 'description' => 'Brown sugar'],
            ['name' => 'cocoa powder', 'category' => 'Ingredient', 'description' => 'Cocoa powder'],
            ['name' => 'peanut butter', 'category' => 'Condiment', 'description' => 'Peanut butter'],
            ['name' => 'tomato sauce', 'category' => 'Sauce', 'description' => 'Tomato sauce'],
            ['name' => 'tamarind', 'category' => 'Ingredient', 'description' => 'Tamarind'],
            ['name' => 'chili', 'category' => 'Spice', 'description' => 'Chili pepper'],
            
            // Dairy & Liquids
            ['name' => 'milk', 'category' => 'Dairy', 'description' => 'Milk'],
            ['name' => 'coconut milk', 'category' => 'Dairy', 'description' => 'Coconut milk'],
            ['name' => 'butter', 'category' => 'Dairy', 'description' => 'Butter'],
            ['name' => 'chicken broth', 'category' => 'Liquid', 'description' => 'Chicken broth'],
            ['name' => 'oil', 'category' => 'Fat', 'description' => 'Cooking oil'],
            ['name' => 'olive oil', 'category' => 'Fat', 'description' => 'Olive oil'],
            
            // Wrappers & Others
            ['name' => 'spring roll wrapper', 'category' => 'Wrapper', 'description' => 'Spring roll wrapper'],
            ['name' => 'salted egg', 'category' => 'Protein', 'description' => 'Salted duck egg'],
            ['name' => 'atchara', 'category' => 'Condiment', 'description' => 'Pickled papaya'],
            ['name' => 'gulaman', 'category' => 'Dessert', 'description' => 'Agar jelly'],
            ['name' => 'fresh mango', 'category' => 'Fruit', 'description' => 'Fresh mango'],
            ['name' => 'peanuts', 'category' => 'Nut', 'description' => 'Peanuts'],
        ];

        foreach ($ingredients as $ingredient) {
            Ingredient::firstOrCreate(
                ['name' => $ingredient['name']],
                $ingredient
            );
        }
    }

    private function createRecipes(): void
    {
        $recipes = [
            // Filipino Breakfast Dishes
            [
                'name' => 'Tapsilog',
                'description' => 'Tapa, Sinangag, at Itlog - Classic Filipino breakfast',
                'prep_time' => 15,
                'cook_time' => 20,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 520,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 58,
                'fat_per_serving' => 18,
                'instructions' => 'Marinate beef, cook garlic rice, fry egg',
                'is_filipino_dish' => true,
                'ingredients' => ['beef tapa', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
            ],
            [
                'name' => 'Champorado with Tuyo',
                'description' => 'Sweet chocolate rice porridge with dried fish',
                'prep_time' => 10,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 380,
                'protein_per_serving' => 15,
                'carbs_per_serving' => 62,
                'fat_per_serving' => 9,
                'instructions' => 'Cook rice with cocoa powder, serve with tuyo',
                'is_filipino_dish' => true,
                'ingredients' => ['rice', 'cocoa powder', 'sugar', 'tuyo', 'milk'],
            ],
            [
                'name' => 'Pandesal with Scrambled Egg',
                'description' => 'Soft Filipino bread with scrambled eggs',
                'prep_time' => 5,
                'cook_time' => 10,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 340,
                'protein_per_serving' => 18,
                'carbs_per_serving' => 44,
                'fat_per_serving' => 12,
                'instructions' => 'Toast pandesal, scramble eggs with milk',
                'is_filipino_dish' => true,
                'ingredients' => ['pandesal', 'eggs', 'milk', 'butter', 'salt'],
            ],
            [
                'name' => 'Lugaw with Egg',
                'description' => 'Warm rice porridge with soft-boiled egg',
                'prep_time' => 10,
                'cook_time' => 20,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 320,
                'protein_per_serving' => 12,
                'carbs_per_serving' => 52,
                'fat_per_serving' => 8,
                'instructions' => 'Cook rice in chicken broth, add soft-boiled egg',
                'is_filipino_dish' => true,
                'ingredients' => ['rice', 'chicken broth', 'egg', 'ginger', 'spring onion'],
            ],
            [
                'name' => 'Arroz Caldo',
                'description' => 'Chicken rice porridge',
                'prep_time' => 10,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 350,
                'protein_per_serving' => 15,
                'carbs_per_serving' => 58,
                'fat_per_serving' => 8,
                'instructions' => 'Cook rice with chicken and ginger',
                'is_filipino_dish' => true,
                'ingredients' => ['rice', 'chicken', 'ginger', 'garlic', 'chicken broth'],
            ],
            [
                'name' => 'Longsilog',
                'description' => 'Longganisa, Sinangag, at Itlog',
                'prep_time' => 10,
                'cook_time' => 20,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 540,
                'protein_per_serving' => 26,
                'carbs_per_serving' => 62,
                'fat_per_serving' => 20,
                'instructions' => 'Cook longganisa, prepare garlic rice, fry egg',
                'is_filipino_dish' => true,
                'ingredients' => ['longganisa', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
            ],
            [
                'name' => 'Bibingka with Salted Egg',
                'description' => 'Traditional rice cake with salted egg',
                'prep_time' => 15,
                'cook_time' => 30,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 420,
                'protein_per_serving' => 14,
                'carbs_per_serving' => 58,
                'fat_per_serving' => 16,
                'instructions' => 'Make rice cake batter, bake with salted egg',
                'is_filipino_dish' => true,
                'ingredients' => ['rice flour', 'coconut milk', 'salted egg', 'sugar', 'butter'],
            ],

            // Filipino Lunch Dishes
            [
                'name' => 'Chicken Adobo',
                'description' => 'Classic Filipino chicken in soy sauce and vinegar',
                'prep_time' => 15,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 350,
                'protein_per_serving' => 25,
                'carbs_per_serving' => 15,
                'fat_per_serving' => 20,
                'instructions' => 'Marinate chicken, cook in soy sauce and vinegar',
                'is_filipino_dish' => true,
                'ingredients' => ['chicken', 'soy sauce', 'vinegar', 'garlic', 'bay leaves'],
            ],
            [
                'name' => 'Sinigang na Baboy',
                'description' => 'Sour soup with pork and vegetables',
                'prep_time' => 20,
                'cook_time' => 45,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 380,
                'protein_per_serving' => 25,
                'carbs_per_serving' => 35,
                'fat_per_serving' => 14,
                'instructions' => 'Boil pork with tamarind, add vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['pork', 'tamarind', 'mixed vegetables', 'fish sauce', 'onion'],
            ],
            [
                'name' => 'Beef Nilaga',
                'description' => 'Boiled beef with vegetables',
                'prep_time' => 15,
                'cook_time' => 60,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 450,
                'protein_per_serving' => 32,
                'carbs_per_serving' => 38,
                'fat_per_serving' => 18,
                'instructions' => 'Boil beef until tender, add vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['beef', 'potatoes', 'carrots', 'cabbage', 'onion'],
            ],
            [
                'name' => 'Fish Sinigang',
                'description' => 'Sour soup with fish and vegetables',
                'prep_time' => 15,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 360,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 36,
                'fat_per_serving' => 10,
                'instructions' => 'Boil fish with tamarind and vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['fish', 'tamarind', 'mixed vegetables', 'fish sauce', 'onion'],
            ],
            [
                'name' => 'Chicken Tinola',
                'description' => 'Chicken soup with ginger and vegetables',
                'prep_time' => 15,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 420,
                'protein_per_serving' => 38,
                'carbs_per_serving' => 32,
                'fat_per_serving' => 16,
                'instructions' => 'Boil chicken with ginger, add vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['chicken', 'ginger', 'mixed vegetables', 'fish sauce', 'onion'],
            ],

            // Filipino Dinner Dishes
            [
                'name' => 'Kare-Kare',
                'description' => 'Oxtail stew with peanut sauce',
                'prep_time' => 30,
                'cook_time' => 120,
                'servings' => 8,
                'difficulty' => 'Hard',
                'category' => 'Filipino',
                'calories_per_serving' => 480,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 45,
                'fat_per_serving' => 22,
                'instructions' => 'Cook oxtail, make peanut sauce, add vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['oxtail', 'peanut butter', 'mixed vegetables', 'bagoong', 'onion'],
            ],
            [
                'name' => 'Lechon Kawali',
                'description' => 'Crispy fried pork belly',
                'prep_time' => 20,
                'cook_time' => 45,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 520,
                'protein_per_serving' => 32,
                'carbs_per_serving' => 38,
                'fat_per_serving' => 28,
                'instructions' => 'Boil pork belly, deep fry until crispy',
                'is_filipino_dish' => true,
                'ingredients' => ['pork belly', 'garlic', 'bay leaves', 'salt', 'oil'],
            ],
            [
                'name' => 'Chicken Afritada',
                'description' => 'Chicken stew with potatoes and carrots',
                'prep_time' => 20,
                'cook_time' => 40,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 460,
                'protein_per_serving' => 34,
                'carbs_per_serving' => 48,
                'fat_per_serving' => 14,
                'instructions' => 'Sauté chicken, add vegetables and tomato sauce',
                'is_filipino_dish' => true,
                'ingredients' => ['chicken', 'potatoes', 'carrots', 'tomato sauce', 'onion'],
            ],
            [
                'name' => 'Laing',
                'description' => 'Taro leaves in coconut milk',
                'prep_time' => 25,
                'cook_time' => 30,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 400,
                'protein_per_serving' => 26,
                'carbs_per_serving' => 44,
                'fat_per_serving' => 14,
                'instructions' => 'Cook taro leaves in coconut milk with spices',
                'is_filipino_dish' => true,
                'ingredients' => ['taro leaves', 'coconut milk', 'pork', 'ginger', 'chili'],
            ],
            [
                'name' => 'Grilled Bangus',
                'description' => 'Grilled milkfish with vegetables',
                'prep_time' => 15,
                'cook_time' => 20,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 250,
                'protein_per_serving' => 30,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 12,
                'instructions' => 'Season and grill bangus, serve with vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['bangus', 'lemon', 'garlic', 'mixed vegetables', 'olive oil'],
            ],
            [
                'name' => 'Pinakbet',
                'description' => 'Mixed vegetables with shrimp paste',
                'prep_time' => 15,
                'cook_time' => 20,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 120,
                'protein_per_serving' => 8,
                'carbs_per_serving' => 20,
                'fat_per_serving' => 3,
                'instructions' => 'Sauté vegetables with bagoong',
                'is_filipino_dish' => true,
                'ingredients' => ['mixed vegetables', 'bagoong', 'garlic', 'onion', 'tomato'],
            ],
            [
                'name' => 'Ginisang Monggo',
                'description' => 'Sautéed mung beans with vegetables',
                'prep_time' => 10,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 180,
                'protein_per_serving' => 12,
                'carbs_per_serving' => 25,
                'fat_per_serving' => 5,
                'instructions' => 'Cook mung beans, sauté with vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['mung beans', 'mixed vegetables', 'garlic', 'onion', 'fish sauce'],
            ],
            [
                'name' => 'Ensaladang Talong',
                'description' => 'Grilled eggplant salad',
                'prep_time' => 10,
                'cook_time' => 15,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 80,
                'protein_per_serving' => 3,
                'carbs_per_serving' => 12,
                'fat_per_serving' => 2,
                'instructions' => 'Grill eggplant, mix with tomatoes and onions',
                'is_filipino_dish' => true,
                'ingredients' => ['eggplant', 'tomatoes', 'onion', 'vinegar', 'salt'],
            ],
            [
                'name' => 'Atchara',
                'description' => 'Pickled papaya and vegetables',
                'prep_time' => 20,
                'cook_time' => 0,
                'servings' => 8,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 25,
                'protein_per_serving' => 1,
                'carbs_per_serving' => 6,
                'fat_per_serving' => 0,
                'instructions' => 'Mix papaya with vinegar, sugar, and spices',
                'is_filipino_dish' => true,
                'ingredients' => ['green papaya', 'vinegar', 'sugar', 'ginger', 'carrots'],
            ],

            // Filipino Snacks
            [
                'name' => 'Banana Cue',
                'description' => 'Caramelized banana on stick',
                'prep_time' => 5,
                'cook_time' => 10,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 180,
                'protein_per_serving' => 2,
                'carbs_per_serving' => 38,
                'fat_per_serving' => 4,
                'instructions' => 'Fry banana in brown sugar until caramelized',
                'is_filipino_dish' => true,
                'ingredients' => ['saba banana', 'brown sugar', 'oil'],
            ],
            [
                'name' => 'Kamote Cue',
                'description' => 'Caramelized sweet potato',
                'prep_time' => 5,
                'cook_time' => 10,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 150,
                'protein_per_serving' => 3,
                'carbs_per_serving' => 32,
                'fat_per_serving' => 1,
                'instructions' => 'Fry sweet potato in brown sugar',
                'is_filipino_dish' => true,
                'ingredients' => ['sweet potato', 'brown sugar', 'oil'],
            ],
            [
                'name' => 'Turon',
                'description' => 'Fried banana spring roll',
                'prep_time' => 10,
                'cook_time' => 15,
                'servings' => 6,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 200,
                'protein_per_serving' => 2,
                'carbs_per_serving' => 35,
                'fat_per_serving' => 7,
                'instructions' => 'Wrap banana in spring roll wrapper, fry',
                'is_filipino_dish' => true,
                'ingredients' => ['saba banana', 'spring roll wrapper', 'brown sugar', 'oil'],
            ],
            [
                'name' => 'Mais',
                'description' => 'Boiled corn',
                'prep_time' => 5,
                'cook_time' => 15,
                'servings' => 2,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 140,
                'protein_per_serving' => 4,
                'carbs_per_serving' => 30,
                'fat_per_serving' => 2,
                'instructions' => 'Boil corn until tender',
                'is_filipino_dish' => true,
                'ingredients' => ['mais', 'salt', 'butter'],
            ],
            [
                'name' => 'Gulaman',
                'description' => 'Agar jelly dessert',
                'prep_time' => 10,
                'cook_time' => 15,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 100,
                'protein_per_serving' => 0,
                'carbs_per_serving' => 25,
                'fat_per_serving' => 0,
                'instructions' => 'Make agar jelly with sugar syrup',
                'is_filipino_dish' => true,
                'ingredients' => ['gulaman', 'sugar', 'water'],
            ],
        ];

        foreach ($recipes as $recipeData) {
            $ingredients = $recipeData['ingredients'];
            unset($recipeData['ingredients']);
            
            $recipe = Recipe::firstOrCreate(
                ['name' => $recipeData['name']],
                $recipeData
            );

            // Attach ingredients to recipe
            foreach ($ingredients as $ingredientName) {
                $ingredient = Ingredient::where('name', $ingredientName)->first();
                if ($ingredient && !$recipe->ingredients()->where('ingredient_id', $ingredient->id)->exists()) {
                    $recipe->ingredients()->attach($ingredient->id, [
                        'quantity' => '1',
                        'unit' => 'piece'
                    ]);
                }
            }
        }
    }

    private function createMealPlans(int $userId): void
    {
        // Create a weekly meal plan
        $mealPlan = MealPlan::create([
            'name' => 'Weekly Filipino Meal Plan',
            'description' => 'A comprehensive weekly meal plan featuring traditional Filipino dishes',
            'start_date' => now()->startOfWeek(),
            'end_date' => now()->endOfWeek(),
            'user_id' => $userId,
            'is_active' => true,
        ]);

        // Get recipes for meal planning
        $recipes = Recipe::all()->keyBy('name');

        // Weekly meal plan data (0=Monday, 6=Sunday)
        $weeklyMeals = [
            // Monday (0)
            0 => [
                'breakfast' => 'Champorado with Tuyo',
                'lunch' => 'Chicken Tinola',
                'dinner' => 'Grilled Bangus with Brown Rice',
                'snack' => 'Banana Cue',
            ],
            // Tuesday (1)
            1 => [
                'breakfast' => 'Tapsilog',
                'lunch' => 'Sinigang na Baboy',
                'dinner' => 'Pinakbet with Grilled Fish',
                'snack' => 'Kamote',
            ],
            // Wednesday (2)
            2 => [
                'breakfast' => 'Pandesal with Scrambled Egg',
                'lunch' => 'Chicken Adobo with Rice',
                'dinner' => 'Ginisang Monggo with Fish',
                'snack' => 'Fresh Mango',
            ],
            // Thursday (3)
            3 => [
                'breakfast' => 'Lugaw with Egg',
                'lunch' => 'Beef Nilaga',
                'dinner' => 'Tortang Talong with Rice',
                'snack' => 'Peanuts',
            ],
            // Friday (4)
            4 => [
                'breakfast' => 'Arroz Caldo',
                'lunch' => 'Fish Sinigang',
                'dinner' => 'Chicken Afritada',
                'snack' => 'Turon',
            ],
            // Saturday (5)
            5 => [
                'breakfast' => 'Longsilog',
                'lunch' => 'Kare-Kare with Bagoong',
                'dinner' => 'Grilled Tilapia with Ensaladang Talong',
                'snack' => 'Mais',
            ],
            // Sunday (6)
            6 => [
                'breakfast' => 'Bibingka with Salted Egg',
                'lunch' => 'Lechon Kawali with Atchara',
                'dinner' => 'Laing with Grilled Fish',
                'snack' => 'Gulaman',
            ],
        ];

        // Create meal plan items
        foreach ($weeklyMeals as $day => $meals) {
            foreach ($meals as $mealType => $recipeName) {
                $recipe = $recipes->get($recipeName);
                if ($recipe) {
                    MealPlanItem::create([
                        'meal_plan_id' => $mealPlan->id,
                        'recipe_id' => $recipe->id,
                        'day' => $day + 1, // Convert to 1-7 (Monday-Sunday)
                        'meal_type' => $mealType,
                        'servings' => 1,
                    ]);
                }
            }
        }
    }
}
