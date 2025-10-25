<?php

require 'vendor/autoload.php';

$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\Recipe;

echo "=== Recipe Database Status ===\n";
echo "Total recipes in database: " . Recipe::count() . "\n";
echo "Dessert recipes: " . Recipe::where('category', 'Dessert')->count() . "\n";
echo "Filipino dishes: " . Recipe::where('is_filipino_dish', true)->count() . "\n";

echo "\n=== Sample Dessert Recipes ===\n";
$dessertRecipes = Recipe::where('category', 'Dessert')->take(10)->get(['name', 'category', 'calories_per_serving']);
foreach ($dessertRecipes as $recipe) {
    echo "- {$recipe->name} ({$recipe->calories_per_serving} cal)\n";
}

echo "\n=== Recent Recipes Added ===\n";
$recentRecipes = Recipe::orderBy('created_at', 'desc')->take(5)->get(['name', 'category', 'created_at']);
foreach ($recentRecipes as $recipe) {
    echo "- {$recipe->name} ({$recipe->category}) - {$recipe->created_at}\n";
}
