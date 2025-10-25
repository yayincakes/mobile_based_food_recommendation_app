<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recipe;
use App\Models\Ingredient;

class CompleteRecipeSyncSeeder extends Seeder
{
    public function run(): void
    {
        $this->createAllIngredients();
        $this->createAllRecipes();
    }

    private function createAllIngredients(): void
    {
        $ingredients = [
            // Proteins
            ['name' => 'beef tapa', 'category' => 'Protein', 'description' => 'Marinated beef'],
            ['name' => 'garlic rice', 'category' => 'Grain', 'description' => 'Fried rice with garlic'],
            ['name' => 'egg', 'category' => 'Protein', 'description' => 'Chicken egg'],
            ['name' => 'garlic', 'category' => 'Vegetable', 'description' => 'Garlic cloves'],
            ['name' => 'soy sauce', 'category' => 'Condiment', 'description' => 'Soy sauce'],
            ['name' => 'rice', 'category' => 'Grain', 'description' => 'White rice'],
            ['name' => 'cocoa powder', 'category' => 'Sweetener', 'description' => 'Unsweetened cocoa'],
            ['name' => 'sugar', 'category' => 'Sweetener', 'description' => 'White sugar'],
            ['name' => 'tuyo', 'category' => 'Protein', 'description' => 'Dried fish'],
            ['name' => 'milk', 'category' => 'Dairy', 'description' => 'Fresh milk'],
            
            // Vegetables
            ['name' => 'onion', 'category' => 'Vegetable', 'description' => 'Yellow onion'],
            ['name' => 'tomato', 'category' => 'Vegetable', 'description' => 'Fresh tomato'],
            ['name' => 'cucumber', 'category' => 'Vegetable', 'description' => 'Fresh cucumber'],
            ['name' => 'lettuce', 'category' => 'Vegetable', 'description' => 'Fresh lettuce'],
            ['name' => 'carrot', 'category' => 'Vegetable', 'description' => 'Fresh carrot'],
            ['name' => 'potato', 'category' => 'Vegetable', 'description' => 'Fresh potato'],
            ['name' => 'cabbage', 'category' => 'Vegetable', 'description' => 'Fresh cabbage'],
            ['name' => 'eggplant', 'category' => 'Vegetable', 'description' => 'Fresh eggplant'],
            ['name' => 'okra', 'category' => 'Vegetable', 'description' => 'Fresh okra'],
            ['name' => 'bitter gourd', 'category' => 'Vegetable', 'description' => 'Ampalaya'],
            ['name' => 'string beans', 'category' => 'Vegetable', 'description' => 'Sitaw'],
            ['name' => 'squash', 'category' => 'Vegetable', 'description' => 'Kalabasa'],
            ['name' => 'sweet potato', 'category' => 'Vegetable', 'description' => 'Kamote'],
            ['name' => 'banana', 'category' => 'Fruit', 'description' => 'Saging'],
            ['name' => 'mango', 'category' => 'Fruit', 'description' => 'Mangga'],
            ['name' => 'pineapple', 'category' => 'Fruit', 'description' => 'Pinya'],
            ['name' => 'papaya', 'category' => 'Fruit', 'description' => 'Papaya'],
            ['name' => 'coconut', 'category' => 'Fruit', 'description' => 'Niyog'],
            ['name' => 'coconut milk', 'category' => 'Dairy', 'description' => 'Gata'],
            ['name' => 'coconut cream', 'category' => 'Dairy', 'description' => 'Kakang gata'],
            
            // Meats
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
            
            // Spices and Seasonings
            ['name' => 'salt', 'category' => 'Seasoning', 'description' => 'Asin'],
            ['name' => 'pepper', 'category' => 'Seasoning', 'description' => 'Paminta'],
            ['name' => 'vinegar', 'category' => 'Condiment', 'description' => 'Suka'],
            ['name' => 'fish sauce', 'category' => 'Condiment', 'description' => 'Patis'],
            ['name' => 'oyster sauce', 'category' => 'Condiment', 'description' => 'Oyster sauce'],
            ['name' => 'bay leaves', 'category' => 'Herb', 'description' => 'Dahon ng laurel'],
            ['name' => 'ginger', 'category' => 'Spice', 'description' => 'Luya'],
            ['name' => 'lemongrass', 'category' => 'Herb', 'description' => 'Tanglad'],
            ['name' => 'chili', 'category' => 'Spice', 'description' => 'Sili'],
            ['name' => 'turmeric', 'category' => 'Spice', 'description' => 'Luyang dilaw'],
            
            // Grains and Starches
            ['name' => 'malagkit na bigas', 'category' => 'Grain', 'description' => 'Glutinous rice'],
            ['name' => 'cornstarch', 'category' => 'Starch', 'description' => 'Cornstarch'],
            ['name' => 'flour', 'category' => 'Grain', 'description' => 'Harina'],
            ['name' => 'bread', 'category' => 'Grain', 'description' => 'Tinapay'],
            ['name' => 'noodles', 'category' => 'Grain', 'description' => 'Pansit'],
            ['name' => 'pasta', 'category' => 'Grain', 'description' => 'Pasta'],
            
            // Dessert Ingredients
            ['name' => 'baking powder', 'category' => 'Leavening Agent', 'description' => 'Baking powder'],
            ['name' => 'baking soda', 'category' => 'Leavening Agent', 'description' => 'Baking soda'],
            ['name' => 'vanilla extract', 'category' => 'Flavoring', 'description' => 'Vanilla extract'],
            ['name' => 'butter', 'category' => 'Dairy', 'description' => 'Mantikilya'],
            ['name' => 'cheese', 'category' => 'Dairy', 'description' => 'Keso'],
            ['name' => 'cream', 'category' => 'Dairy', 'description' => 'Krema'],
            ['name' => 'condensed milk', 'category' => 'Dairy', 'description' => 'Condensed milk'],
            ['name' => 'evaporated milk', 'category' => 'Dairy', 'description' => 'Evaporated milk'],
            ['name' => 'ube', 'category' => 'Vegetable', 'description' => 'Purple yam'],
            ['name' => 'tapioca', 'category' => 'Starch', 'description' => 'Sago'],
            ['name' => 'gelatin', 'category' => 'Thickener', 'description' => 'Gelatin'],
            ['name' => 'corn', 'category' => 'Vegetable', 'description' => 'Mais'],
            ['name' => 'peanut', 'category' => 'Nut', 'description' => 'Mani'],
            ['name' => 'sesame', 'category' => 'Seed', 'description' => 'Linga'],
            
            // Cooking Oils
            ['name' => 'cooking oil', 'category' => 'Fat', 'description' => 'Mantika'],
            ['name' => 'coconut oil', 'category' => 'Fat', 'description' => 'Langkis'],
            ['name' => 'olive oil', 'category' => 'Fat', 'description' => 'Olive oil'],
            
            // Additional Filipino Ingredients
            ['name' => 'spring roll wrapper', 'category' => 'Grain', 'description' => 'Lumpia wrapper'],
            ['name' => 'banana leaves', 'category' => 'Wrapper', 'description' => 'Dahon ng saging'],
            ['name' => 'bagoong', 'category' => 'Condiment', 'description' => 'Fermented shrimp paste'],
            ['name' => 'alamang', 'category' => 'Condiment', 'description' => 'Small shrimp paste'],
            ['name' => 'achuete', 'category' => 'Spice', 'description' => 'Annatto seeds'],
            ['name' => 'calamansi', 'category' => 'Fruit', 'description' => 'Philippine lime'],
            ['name' => 'tamarind', 'category' => 'Fruit', 'description' => 'Sampalok'],
            ['name' => 'jackfruit', 'category' => 'Fruit', 'description' => 'Langka'],
            ['name' => 'sweet potato leaves', 'category' => 'Vegetable', 'description' => 'Talbos ng kamote'],
            ['name' => 'morning glory', 'category' => 'Vegetable', 'description' => 'Kangkong'],
        ];

        foreach ($ingredients as $ingredient) {
            Ingredient::firstOrCreate(
                ['name' => $ingredient['name']],
                $ingredient
            );
        }
    }

    private function createAllRecipes(): void
    {
        // This will be a massive array of all 222 recipes from the Flutter app
        // For now, let me add the missing core Filipino recipes
        $recipes = [
            // Core Filipino Dishes (Missing from database)
            [
                'name' => 'Adobong Manok',
                'description' => 'Classic Filipino chicken adobo',
                'prep_time' => 15,
                'cook_time' => 30,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Filipino',
                'calories_per_serving' => 320,
                'protein_per_serving' => 28,
                'carbs_per_serving' => 8,
                'fat_per_serving' => 18,
                'instructions' => 'Marinate chicken in soy sauce and vinegar, then simmer until tender',
                'is_filipino_dish' => true,
                'ingredients' => ['chicken', 'soy sauce', 'vinegar', 'garlic', 'bay leaves', 'pepper'],
            ],
            [
                'name' => 'Lechon',
                'description' => 'Roasted whole pig, Filipino style',
                'prep_time' => 60,
                'cook_time' => 300,
                'servings' => 20,
                'difficulty' => 'Hard',
                'category' => 'Filipino',
                'calories_per_serving' => 450,
                'protein_per_serving' => 35,
                'carbs_per_serving' => 0,
                'fat_per_serving' => 32,
                'instructions' => 'Season whole pig and roast over charcoal for several hours',
                'is_filipino_dish' => true,
                'ingredients' => ['whole pig', 'salt', 'pepper', 'garlic', 'onion', 'bay leaves'],
            ],
            [
                'name' => 'Adobong Kangkong',
                'description' => 'Stir-fried water spinach in adobo sauce',
                'prep_time' => 10,
                'cook_time' => 15,
                'servings' => 4,
                'difficulty' => 'Easy',
                'category' => 'Healthy',
                'calories_per_serving' => 45,
                'protein_per_serving' => 3,
                'carbs_per_serving' => 6,
                'fat_per_serving' => 1,
                'instructions' => 'Stir-fry kangkong with garlic, soy sauce, and vinegar',
                'is_filipino_dish' => true,
                'ingredients' => ['morning glory', 'garlic', 'soy sauce', 'vinegar', 'onion'],
            ],
            // Add more missing recipes here...
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
