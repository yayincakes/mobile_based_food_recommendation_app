<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recipe;
use App\Models\Ingredient;

class AdditionalFilipinoRecipesSeeder extends Seeder
{
    public function run(): void
    {
        // Create additional ingredients if they don't exist
        $additionalIngredients = [
            'Duck', 'Pork Belly', 'Mung Beans', 'Spinach', 'Taro Leaves', 'Coconut Cream',
            'Bagoong', 'Shrimp Paste', 'Longganisa', 'Tapa', 'Corn on the Cob', 'Banana',
            'Pandesal', 'Butter', 'Milk', 'Cheese', 'Salted Egg', 'Rice Flour',
            'Lumpia Wrapper', 'Peanuts', 'Gulaman Powder', 'Food Coloring'
        ];

        foreach ($additionalIngredients as $ingredientName) {
            Ingredient::firstOrCreate(['name' => $ingredientName]);
        }

        // Create additional Filipino recipes
        $additionalRecipes = [
            [
                'name' => 'Beef Duck',
                'description' => 'Filipino beef duck with rich sauce',
                'prep_time' => 25,
                'cook_time' => 90,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Main Course',
                'calories_per_serving' => 380,
                'protein_per_serving' => 30,
                'carbs_per_serving' => 18,
                'fat_per_serving' => 22,
                'instructions' => 'Sauté beef, add sauce ingredients, simmer until tender',
                'is_filipino_dish' => true,
                'ingredients' => ['Beef', 'Duck', 'Soy Sauce', 'Garlic', 'Onions', 'Tomatoes']
            ],
            [
                'name' => 'Bicol Express',
                'description' => 'Spicy Filipino pork dish with coconut milk and chili',
                'prep_time' => 20,
                'cook_time' => 45,
                'servings' => 4,
                'difficulty' => 'Medium',
                'category' => 'Main Course',
                'calories_per_serving' => 420,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 12,
                'fat_per_serving' => 32,
                'instructions' => 'Sauté pork, add coconut milk and chili, simmer until tender',
                'is_filipino_dish' => true,
                'ingredients' => ['Pork Belly', 'Coconut Cream', 'Chili', 'Garlic', 'Onions', 'Fish Sauce']
            ],
            [
                'name' => 'Champorado',
                'description' => 'Filipino chocolate rice porridge',
                'prep_time' => 10,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Breakfast',
                'calories_per_serving' => 280,
                'protein_per_serving' => 6,
                'carbs_per_serving' => 58,
                'fat_per_serving' => 4,
                'instructions' => 'Cook rice with cocoa powder and sugar, serve hot',
                'is_filipino_dish' => true,
                'ingredients' => ['Malagkit Rice', 'Cocoa Powder', 'Sugar', 'Salt']
            ],
            [
                'name' => 'Lumpia',
                'description' => 'Filipino spring rolls with vegetables and meat',
                'prep_time' => 45,
                'cook_time' => 20,
                'servings' => 8,
                'difficulty' => 'Medium',
                'category' => 'Appetizer',
                'calories_per_serving' => 180,
                'protein_per_serving' => 8,
                'carbs_per_serving' => 22,
                'fat_per_serving' => 6,
                'instructions' => 'Fill wrapper with vegetables and meat, roll, deep fry',
                'is_filipino_dish' => true,
                'ingredients' => ['Lumpia Wrapper', 'Pork', 'Cabbage', 'Carrots', 'String Beans', 'Cooking Oil']
            ],
            [
                'name' => 'Sisig',
                'description' => 'Filipino sizzling pork dish with onions and chili',
                'prep_time' => 30,
                'cook_time' => 60,
                'servings' => 4,
                'difficulty' => 'Medium',
                'category' => 'Main Course',
                'calories_per_serving' => 450,
                'protein_per_serving' => 35,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 32,
                'instructions' => 'Boil pork, grill, chop, sauté with onions and chili',
                'is_filipino_dish' => true,
                'ingredients' => ['Pork', 'Onions', 'Chili', 'Vinegar', 'Soy Sauce', 'Calamansi']
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

        foreach ($additionalRecipes as $recipeData) {
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
