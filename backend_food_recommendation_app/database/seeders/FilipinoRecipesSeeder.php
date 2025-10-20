<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recipe;
use App\Models\Ingredient;

class FilipinoRecipesSeeder extends Seeder
{
    public function run(): void
    {
        // Create ingredients first
        $ingredients = [
            'Chicken', 'Pork', 'Beef', 'Fish', 'Shrimp', 'Rice', 'Garlic', 'Onions', 'Ginger',
            'Tomatoes', 'Soy Sauce', 'Vinegar', 'Coconut Milk', 'Tamarind', 'Malunggay',
            'Kangkong', 'String Beans', 'Eggplant', 'Potatoes', 'Carrots', 'Cabbage',
            'Bell Peppers', 'Chili', 'Bay Leaves', 'Black Pepper', 'Salt', 'Sugar',
            'Cooking Oil', 'Fish Sauce', 'Green Onions', 'Cilantro', 'Lemon',
            'Brown Sugar', 'Cocoa Powder', 'Malagkit Rice', 'Tuyo (Dried Fish)',
            'Oxtail', 'Peanut Butter', 'Annatto', 'Canton Noodles', 'Shaved Ice',
            'Sweet Beans', 'Fruits', 'Leche Flan', 'Evaporated Milk'
        ];

        foreach ($ingredients as $ingredientName) {
            Ingredient::firstOrCreate(['name' => $ingredientName]);
        }

        // Create Filipino recipes
        $recipes = [
            [
                'name' => 'Chicken Adobo',
                'description' => 'Classic Filipino chicken adobo with soy sauce and vinegar',
                'prep_time' => 15,
                'cook_time' => 45,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Main Course',
                'calories_per_serving' => 320,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 18,
                'instructions' => 'Marinate chicken, sauté with garlic, add soy sauce and vinegar, simmer until tender',
                'is_filipino_dish' => true,
                'ingredients' => ['Chicken', 'Soy Sauce', 'Vinegar', 'Garlic', 'Bay Leaves', 'Black Pepper']
            ],
            [
                'name' => 'Sinigang na Baboy',
                'description' => 'Traditional Filipino sour soup with pork and vegetables',
                'prep_time' => 20,
                'cook_time' => 60,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Soup',
                'calories_per_serving' => 280,
                'protein_per_serving' => 22,
                'carbs_per_serving' => 18,
                'fat_per_serving' => 14,
                'instructions' => 'Boil pork, add tamarind, add vegetables, season with fish sauce',
                'is_filipino_dish' => true,
                'ingredients' => ['Pork', 'Tamarind', 'Kangkong', 'String Beans', 'Radish', 'Tomatoes', 'Onions', 'Chili']
            ],
            [
                'name' => 'Kare-Kare',
                'description' => 'Traditional Filipino oxtail stew with peanut sauce',
                'prep_time' => 30,
                'cook_time' => 180,
                'servings' => 8,
                'difficulty' => 'Hard',
                'category' => 'Main Course',
                'calories_per_serving' => 420,
                'protein_per_serving' => 35,
                'carbs_per_serving' => 22,
                'fat_per_serving' => 18,
                'instructions' => 'Boil oxtail, make peanut sauce, add vegetables, serve with bagoong',
                'is_filipino_dish' => true,
                'ingredients' => ['Oxtail', 'Peanut Butter', 'Annatto', 'String Beans', 'Eggplant', 'Cabbage']
            ],
            [
                'name' => 'Pancit Canton',
                'description' => 'Filipino stir-fried noodles with vegetables and meat',
                'prep_time' => 25,
                'cook_time' => 15,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Main Course',
                'calories_per_serving' => 380,
                'protein_per_serving' => 18,
                'carbs_per_serving' => 52,
                'fat_per_serving' => 12,
                'instructions' => 'Sauté meat and vegetables, add noodles, season with soy sauce',
                'is_filipino_dish' => true,
                'ingredients' => ['Canton Noodles', 'Chicken', 'Shrimp', 'Cabbage', 'Carrots', 'Bell Peppers', 'Soy Sauce']
            ],
            [
                'name' => 'Bulalo',
                'description' => 'Filipino beef shank soup with bone marrow',
                'prep_time' => 20,
                'cook_time' => 240,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Soup',
                'calories_per_serving' => 350,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 15,
                'fat_per_serving' => 22,
                'instructions' => 'Boil beef shanks, add vegetables, simmer until tender',
                'is_filipino_dish' => true,
                'ingredients' => ['Beef', 'Potatoes', 'Carrots', 'Cabbage', 'Onions', 'Corn', 'Salt', 'Black Pepper']
            ],
            [
                'name' => 'Ginataang Kalabasa at Sitaw',
                'description' => 'Filipino squash and string beans in coconut milk',
                'prep_time' => 15,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Vegetable',
                'calories_per_serving' => 180,
                'protein_per_serving' => 6,
                'carbs_per_serving' => 22,
                'fat_per_serving' => 8,
                'instructions' => 'Sauté garlic, add vegetables, pour coconut milk, simmer',
                'is_filipino_dish' => true,
                'ingredients' => ['Squash', 'String Beans', 'Coconut Milk', 'Garlic', 'Onions', 'Fish Sauce']
            ],
            [
                'name' => 'Inasal',
                'description' => 'Filipino grilled chicken marinated in calamansi and annatto',
                'prep_time' => 30,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Medium',
                'category' => 'Main Course',
                'calories_per_serving' => 290,
                'protein_per_serving' => 32,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 14,
                'instructions' => 'Marinate chicken, grill until golden, serve with rice',
                'is_filipino_dish' => true,
                'ingredients' => ['Chicken', 'Calamansi', 'Annatto', 'Garlic', 'Ginger', 'Vinegar', 'Salt']
            ],
            [
                'name' => 'Tinola',
                'description' => 'Filipino ginger chicken soup with vegetables',
                'prep_time' => 15,
                'cook_time' => 40,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Soup',
                'calories_per_serving' => 220,
                'protein_per_serving' => 24,
                'carbs_per_serving' => 12,
                'fat_per_serving' => 8,
                'instructions' => 'Sauté ginger and garlic, add chicken, add vegetables, season',
                'is_filipino_dish' => true,
                'ingredients' => ['Chicken', 'Ginger', 'Garlic', 'Onions', 'Malunggay', 'Chayote', 'Fish Sauce']
            ]
        ];

        foreach ($recipes as $recipeData) {
            $ingredients = $recipeData['ingredients'];
            unset($recipeData['ingredients']);

            $recipe = Recipe::create($recipeData);

            // Attach ingredients with quantities
            foreach ($ingredients as $ingredientName) {
                $ingredient = Ingredient::where('name', $ingredientName)->first();
                if ($ingredient) {
                    $recipe->ingredients()->attach($ingredient->id, [
                        'quantity' => rand(1, 3) . ' pieces',
                        'unit' => 'piece'
                    ]);
                }
            }
        }
    }
}
