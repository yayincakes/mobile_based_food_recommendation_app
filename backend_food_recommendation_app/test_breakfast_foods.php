<?php

require_once 'vendor/autoload.php';

use App\Models\Recipe;
use App\Models\Ingredient;

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== BREAKFAST FOODS DATABASE TEST ===\n\n";

// Count total recipes
$totalRecipes = Recipe::count();
echo "Total recipes in database: " . $totalRecipes . "\n";

// Count breakfast-related recipes
$breakfastRecipes = Recipe::where('name', 'LIKE', '%silog')
    ->orWhere('name', 'LIKE', '%Pandesal%')
    ->orWhere('name', 'LIKE', '%Puto%')
    ->orWhere('name', 'LIKE', '%Ginataang%')
    ->orWhere('name', 'LIKE', '%Tortang%')
    ->orWhere('name', 'LIKE', '%Pancake%')
    ->orWhere('name', 'LIKE', '%Fresh Fruit%')
    ->orWhere('name', 'LIKE', '%Malunggay%')
    ->orWhere('name', 'LIKE', '%Kangkong%')
    ->orWhere('name', 'LIKE', '%Ampalaya%')
    ->orWhere('name', 'LIKE', '%Filipino Breakfast%')
    ->count();

echo "Breakfast-related recipes: " . $breakfastRecipes . "\n\n";

// List some breakfast recipes
echo "Sample breakfast recipes:\n";
$sampleRecipes = Recipe::where('name', 'LIKE', '%silog')
    ->orWhere('name', 'LIKE', '%Pandesal%')
    ->orWhere('name', 'LIKE', '%Puto%')
    ->orWhere('name', 'LIKE', '%Ginataang%')
    ->orWhere('name', 'LIKE', '%Tortang%')
    ->orWhere('name', 'LIKE', '%Pancake%')
    ->orWhere('name', 'LIKE', '%Fresh Fruit%')
    ->orWhere('name', 'LIKE', '%Malunggay%')
    ->orWhere('name', 'LIKE', '%Kangkong%')
    ->orWhere('name', 'LIKE', '%Ampalaya%')
    ->orWhere('name', 'LIKE', '%Filipino Breakfast%')
    ->limit(10)
    ->get(['name', 'description', 'category']);

foreach ($sampleRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// Count total ingredients
$totalIngredients = Ingredient::count();
echo "Total ingredients in database: " . $totalIngredients . "\n\n";

echo "=== TEST COMPLETED ===\n";
