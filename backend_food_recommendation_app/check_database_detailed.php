<?php

require_once 'vendor/autoload.php';

use App\Models\Recipe;
use App\Models\Ingredient;

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== DETAILED DATABASE CHECK ===\n\n";

// 1. Check total counts
echo "1. TOTAL COUNTS:\n";
echo "Total recipes: " . Recipe::count() . "\n";
echo "Total ingredients: " . Ingredient::count() . "\n\n";

// 2. Check all recipes with 'breakfast' in name or description
echo "2. RECIPES WITH 'BREAKFAST' IN NAME OR DESCRIPTION:\n";
$breakfastRecipes = Recipe::where('name', 'LIKE', '%breakfast%')
    ->orWhere('description', 'LIKE', '%breakfast%')
    ->get(['name', 'description', 'category']);

foreach ($breakfastRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 3. Check all 'silog' recipes
echo "3. ALL 'SILOG' RECIPES:\n";
$silogRecipes = Recipe::where('name', 'LIKE', '%silog%')->get(['name', 'description', 'category']);
foreach ($silogRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 4. Check all Pandesal recipes
echo "4. ALL PANDESAL RECIPES:\n";
$pandesalRecipes = Recipe::where('name', 'LIKE', '%Pandesal%')->get(['name', 'description', 'category']);
foreach ($pandesalRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 5. Check all Puto recipes
echo "5. ALL PUTO RECIPES:\n";
$putoRecipes = Recipe::where('name', 'LIKE', '%Puto%')->get(['name', 'description', 'category']);
foreach ($putoRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 6. Check all Ginataang recipes
echo "6. ALL GINATAANG RECIPES:\n";
$ginataangRecipes = Recipe::where('name', 'LIKE', '%Ginataang%')->get(['name', 'description', 'category']);
foreach ($ginataangRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 7. Check all Tortang recipes
echo "7. ALL TORTANG RECIPES:\n";
$tortangRecipes = Recipe::where('name', 'LIKE', '%Tortang%')->get(['name', 'description', 'category']);
foreach ($tortangRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 8. Check all Pancake recipes
echo "8. ALL PANCAKE RECIPES:\n";
$pancakeRecipes = Recipe::where('name', 'LIKE', '%Pancake%')->get(['name', 'description', 'category']);
foreach ($pancakeRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 9. Check all recipes with 'Filipino Breakfast' in name
echo "9. ALL 'FILIPINO BREAKFAST' RECIPES:\n";
$filipinoBreakfastRecipes = Recipe::where('name', 'LIKE', '%Filipino Breakfast%')->get(['name', 'description', 'category']);
foreach ($filipinoBreakfastRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    echo "  " . $recipe->description . "\n\n";
}

// 10. Check recent recipes (last 20)
echo "10. LAST 20 RECIPES ADDED:\n";
$recentRecipes = Recipe::orderBy('created_at', 'desc')->limit(20)->get(['name', 'description', 'category', 'created_at']);
foreach ($recentRecipes as $recipe) {
    echo "- " . $recipe->name . " (" . $recipe->category . ") - " . $recipe->created_at . "\n";
    echo "  " . $recipe->description . "\n\n";
}

// 11. Check specific new ingredients
echo "11. CHECKING NEW INGREDIENTS:\n";
$newIngredients = ['tocino', 'corned beef', 'spam', 'hotdog', 'bacon', 'ham', 'chorizo', 'vienna sausage', 'sardines in tomato sauce', 'tuna flakes'];
foreach ($newIngredients as $ingredientName) {
    $ingredient = Ingredient::where('name', $ingredientName)->first();
    if ($ingredient) {
        echo "✓ " . $ingredient->name . " - " . $ingredient->category . "\n";
    } else {
        echo "✗ " . $ingredientName . " - NOT FOUND\n";
    }
}

echo "\n=== CHECK COMPLETED ===\n";
