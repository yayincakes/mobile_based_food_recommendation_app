<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recipe;
use App\Models\Ingredient;

class MissingRecipesSeeder extends Seeder
{
    public function run(): void
    {
        $this->createMissingIngredients();
        $this->createMissingRecipes();
    }

    private function createMissingIngredients(): void
    {
        $ingredients = [
            ['name' => 'chicken', 'category' => 'Protein', 'description' => 'Manok'],
            ['name' => 'pork', 'category' => 'Protein', 'description' => 'Baboy'],
            ['name' => 'beef', 'category' => 'Protein', 'description' => 'Baka'],
            ['name' => 'fish', 'category' => 'Protein', 'description' => 'Isda'],
            ['name' => 'shrimp', 'category' => 'Protein', 'description' => 'Hipon'],
            ['name' => 'crab', 'category' => 'Protein', 'description' => 'Alimango'],
            ['name' => 'squid', 'category' => 'Protein', 'description' => 'Pusit'],
            ['name' => 'clam', 'category' => 'Protein', 'description' => 'Tahong'],
            ['name' => 'mussel', 'category' => 'Protein', 'description' => 'Tahong'],
            ['name' => 'oyster', 'category' => 'Protein', 'description' => 'Talaba'],
            ['name' => 'morning glory', 'category' => 'Vegetable', 'description' => 'Kangkong'],
            ['name' => 'water spinach', 'category' => 'Vegetable', 'description' => 'Kangkong'],
            ['name' => 'whole pig', 'category' => 'Protein', 'description' => 'Buong baboy'],
        ];

        foreach ($ingredients as $ingredient) {
            Ingredient::firstOrCreate(
                ['name' => $ingredient['name']],
                $ingredient
            );
        }
    }

    private function createMissingRecipes(): void
    {
        $recipes = [
            // Additional Filipino Main Dishes
            [
                'name' => 'Crispy Pata',
                'description' => 'Deep-fried pork leg',
                'prep_time' => 30,
                'cook_time' => 120,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 580,
                'protein_per_serving' => 45,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 38,
                'instructions' => 'Boil pork leg until tender, then deep-fry until crispy',
                'is_filipino_dish' => true,
                'ingredients' => ['pork leg', 'garlic', 'bay leaves', 'salt', 'pepper', 'cooking oil'],
            ],
            [
                'name' => 'Sisig',
                'description' => 'Sizzling pork dish with onions and chili',
                'prep_time' => 20,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 420,
                'protein_per_serving' => 32,
                'carbs_per_serving' => 6,
                'fat_per_serving' => 28,
                'instructions' => 'Grill pork, chop finely, mix with onions and chili, serve sizzling',
                'is_filipino_dish' => true,
                'ingredients' => ['pork', 'onion', 'chili', 'garlic', 'soy sauce', 'vinegar'],
            ],
            [
                'name' => 'Bicol Express',
                'description' => 'Spicy pork dish with coconut milk',
                'prep_time' => 15,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 380,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 12,
                'fat_per_serving' => 24,
                'instructions' => 'Cook pork with coconut milk, chili, and vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['pork', 'coconut milk', 'chili', 'onion', 'garlic', 'ginger'],
            ],
            [
                'name' => 'Pancit Canton',
                'description' => 'Filipino stir-fried noodles',
                'prep_time' => 20,
                'cook_time' => 15,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 320,
                'protein_per_serving' => 18,
                'carbs_per_serving' => 45,
                'fat_per_serving' => 8,
                'instructions' => 'Stir-fry noodles with vegetables and meat',
                'is_filipino_dish' => true,
                'ingredients' => ['noodles', 'pork', 'shrimp', 'vegetables', 'soy sauce', 'garlic'],
            ],
            [
                'name' => 'Lumpiang Shanghai',
                'description' => 'Filipino spring rolls',
                'prep_time' => 30,
                'cook_time' => 20,
                'servings' => 6,
                'difficulty' => 'Medium',
                'category' => 'Filipino',
                'calories_per_serving' => 180,
                'protein_per_serving' => 12,
                'carbs_per_serving' => 15,
                'fat_per_serving' => 8,
                'instructions' => 'Wrap meat mixture in spring roll wrapper, deep-fry until golden',
                'is_filipino_dish' => true,
                'ingredients' => ['spring roll wrapper', 'pork', 'onion', 'carrot', 'garlic', 'cooking oil'],
            ],
            // Additional Healthy Filipino Dishes
            [
                'name' => 'Ginataang Gulay',
                'description' => 'Mixed vegetables in coconut milk',
                'prep_time' => 15,
                'cook_time' => 20,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 120,
                'protein_per_serving' => 4,
                'carbs_per_serving' => 18,
                'fat_per_serving' => 3,
                'instructions' => 'Cook mixed vegetables in coconut milk with spices',
                'is_filipino_dish' => true,
                'ingredients' => ['mixed vegetables', 'coconut milk', 'onion', 'garlic', 'ginger', 'chili'],
            ],
            [
                'name' => 'Tinolang Manok',
                'description' => 'Filipino chicken soup with vegetables',
                'prep_time' => 15,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 180,
                'protein_per_serving' => 22,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 6,
                'instructions' => 'Simmer chicken with vegetables in broth',
                'is_filipino_dish' => true,
                'ingredients' => ['chicken', 'potato', 'carrot', 'onion', 'garlic', 'ginger'],
            ],
            [
                'name' => 'Chicken Tinola',
                'description' => 'Traditional Filipino chicken soup',
                'prep_time' => 15,
                'cook_time' => 25,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 160,
                'protein_per_serving' => 20,
                'carbs_per_serving' => 6,
                'fat_per_serving' => 5,
                'instructions' => 'Boil chicken with ginger, onion, and vegetables',
                'is_filipino_dish' => true,
                'ingredients' => ['chicken', 'ginger', 'onion', 'garlic', 'chayote', 'morning glory'],
            ],
            // Additional Dessert Recipes
            [
                'name' => 'Mango Float',
                'description' => 'Filipino no-bake mango dessert',
                'prep_time' => 30,
                'cook_time' => 0,
                'servings' => 8,
                'difficulty' => 'Easy',
                'category' => 'Dessert',
                'calories_per_serving' => 280,
                'protein_per_serving' => 6,
                'carbs_per_serving' => 35,
                'fat_per_serving' => 12,
                'instructions' => 'Layer graham crackers with mango and cream mixture',
                'is_filipino_dish' => true,
                'ingredients' => ['mango', 'graham crackers', 'condensed milk', 'cream', 'sugar'],
            ],
            [
                'name' => 'Buko Pandan',
                'description' => 'Coconut and pandan dessert',
                'prep_time' => 20,
                'cook_time' => 15,
                'servings' => 6,
                'difficulty' => 'Easy',
                'category' => 'Dessert',
                'calories_per_serving' => 160,
                'protein_per_serving' => 3,
                'carbs_per_serving' => 25,
                'fat_per_serving' => 5,
                'instructions' => 'Mix coconut with pandan jelly and cream',
                'is_filipino_dish' => true,
                'ingredients' => ['coconut', 'pandan jelly', 'condensed milk', 'cream', 'sugar'],
            ],
        ];

        foreach ($recipes as $recipeData) {
            $ingredients = $recipeData['ingredients'];
            unset($recipeData['ingredients']);

            $recipe = Recipe::firstOrCreate(
                ['name' => $recipeData['name']],
                $recipeData
            );

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
}
