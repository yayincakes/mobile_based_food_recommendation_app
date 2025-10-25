<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\Recipe;
use App\Models\Ingredient;

echo "=== FOOD RECOMMENDATION APP DATABASE BROWSER ===\n\n";

while (true) {
    echo "Choose an option:\n";
    echo "1. View all recipes\n";
    echo "2. View recipes by category\n";
    echo "3. Search recipes by name\n";
    echo "4. View dessert recipes\n";
    echo "5. View ingredients\n";
    echo "6. Database statistics\n";
    echo "7. Exit\n";
    echo "Enter your choice (1-7): ";
    
    $choice = trim(fgets(STDIN));
    
    switch ($choice) {
        case '1':
            echo "\n=== ALL RECIPES ===\n";
            $recipes = Recipe::orderBy('name')->get(['name', 'category', 'calories_per_serving', 'difficulty']);
            foreach ($recipes as $recipe) {
                echo "- {$recipe->name} ({$recipe->category}) - {$recipe->calories_per_serving} cal - {$recipe->difficulty}\n";
            }
            echo "\nTotal: " . $recipes->count() . " recipes\n\n";
            break;
            
        case '2':
            echo "\n=== RECIPES BY CATEGORY ===\n";
            $categories = Recipe::selectRaw('category, COUNT(*) as count')
                ->groupBy('category')
                ->orderBy('count', 'desc')
                ->get();
            
            foreach ($categories as $category) {
                echo "\n{$category->category} ({$category->count} recipes):\n";
                $recipes = Recipe::where('category', $category->category)
                    ->orderBy('name')
                    ->get(['name', 'calories_per_serving']);
                foreach ($recipes as $recipe) {
                    echo "  - {$recipe->name} ({$recipe->calories_per_serving} cal)\n";
                }
            }
            break;
            
        case '3':
            echo "\nEnter recipe name to search: ";
            $search = trim(fgets(STDIN));
            $recipes = Recipe::where('name', 'like', "%{$search}%")->get();
            
            if ($recipes->count() > 0) {
                echo "\nFound {$recipes->count()} recipe(s):\n";
                foreach ($recipes as $recipe) {
                    echo "- {$recipe->name} ({$recipe->category}) - {$recipe->calories_per_serving} cal\n";
                    echo "  Ingredients: " . $recipe->ingredients->pluck('name')->join(', ') . "\n";
                    echo "  Instructions: " . substr($recipe->instructions, 0, 100) . "...\n\n";
                }
            } else {
                echo "No recipes found matching '{$search}'\n";
            }
            break;
            
        case '4':
            echo "\n=== DESSERT RECIPES ===\n";
            $desserts = Recipe::where('category', 'Dessert')->orderBy('name')->get();
            foreach ($desserts as $dessert) {
                echo "- {$dessert->name} ({$dessert->calories_per_serving} cal) - {$dessert->difficulty}\n";
            }
            echo "\nTotal desserts: " . $desserts->count() . "\n\n";
            break;
            
        case '5':
            echo "\n=== INGREDIENTS ===\n";
            $ingredients = Ingredient::orderBy('name')->get(['name', 'category']);
            foreach ($ingredients as $ingredient) {
                echo "- {$ingredient->name} ({$ingredient->category})\n";
            }
            echo "\nTotal ingredients: " . $ingredients->count() . "\n\n";
            break;
            
        case '6':
            echo "\n=== DATABASE STATISTICS ===\n";
            echo "Total Recipes: " . Recipe::count() . "\n";
            echo "Total Ingredients: " . Ingredient::count() . "\n";
            echo "Filipino Dishes: " . Recipe::where('is_filipino_dish', true)->count() . "\n";
            echo "Dessert Recipes: " . Recipe::where('category', 'Dessert')->count() . "\n";
            echo "Healthy Recipes: " . Recipe::where('category', 'Healthy')->count() . "\n";
            
            echo "\nRecipes by Category:\n";
            $categories = Recipe::selectRaw('category, COUNT(*) as count')
                ->groupBy('category')
                ->orderBy('count', 'desc')
                ->get();
            foreach ($categories as $category) {
                echo "  - {$category->category}: {$category->count}\n";
            }
            echo "\n";
            break;
            
        case '7':
            echo "Goodbye!\n";
            exit(0);
            
        default:
            echo "Invalid choice. Please enter 1-7.\n\n";
    }
}
