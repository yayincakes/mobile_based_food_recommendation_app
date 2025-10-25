<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recipe;
use App\Models\Ingredient;

class FinalRecipeSeeder extends Seeder
{
    public function run(): void
    {
        $this->createFinalRecipe();
    }

    private function createFinalRecipe(): void
    {
        // Final recipe to reach 222 total
        $recipe = [
            'name' => 'Egg Tinola',
            'description' => 'Filipino egg soup with ginger',
            'prep_time' => 15,
            'cook_time' => 20,
            'servings' => 4,
            'difficulty' => 'Easy',
            'category' => 'Healthy',
            'calories_per_serving' => 100,
            'protein_per_serving' => 8,
            'carbs_per_serving' => 6,
            'fat_per_serving' => 5,
            'instructions' => 'Boil eggs with ginger, onion, and vegetables',
            'is_filipino_dish' => true,
            'ingredients' => ['egg', 'ginger', 'onion', 'garlic', 'chayote', 'morning glory'],
        ];

        $ingredients = $recipe['ingredients'];
        unset($recipe['ingredients']);

        $newRecipe = Recipe::firstOrCreate(
            ['name' => $recipe['name']],
            $recipe
        );

        foreach ($ingredients as $ingredientName) {
            $ingredient = Ingredient::where('name', $ingredientName)->first();
            if ($ingredient && !$newRecipe->ingredients()->where('ingredient_id', $ingredient->id)->exists()) {
                $newRecipe->ingredients()->attach($ingredient->id, [
                    'quantity' => '1',
                    'unit' => 'piece'
                ]);
            }
        }
    }
}
