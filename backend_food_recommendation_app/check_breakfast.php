<?php

require_once 'vendor/autoload.php';

use App\Models\Recipe;
use App\Models\Ingredient;

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== BREAKFAST FOODS DATABASE CHECK ===\n\n";

try {
    // Check total counts
    echo "1. TOTAL COUNTS:\n";
    echo "Total recipes: " . Recipe::count() . "\n";
    echo "Total ingredients: " . Ingredient::count() . "\n\n";
    
    // Check for silog recipes
    echo "2. SILOG RECIPES:\n";
    $silogRecipes = Recipe::where('name', 'LIKE', '%silog%')->get();
    echo "Found " . $silogRecipes->count() . " silog recipes:\n";
    foreach ($silogRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for Pandesal recipes
    echo "3. PANDESAL RECIPES:\n";
    $pandesalRecipes = Recipe::where('name', 'LIKE', '%Pandesal%')->get();
    echo "Found " . $pandesalRecipes->count() . " pandesal recipes:\n";
    foreach ($pandesalRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for Puto recipes
    echo "4. PUTO RECIPES:\n";
    $putoRecipes = Recipe::where('name', 'LIKE', '%Puto%')->get();
    echo "Found " . $putoRecipes->count() . " puto recipes:\n";
    foreach ($putoRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for Ginataang recipes
    echo "5. GINATAANG RECIPES:\n";
    $ginataangRecipes = Recipe::where('name', 'LIKE', '%Ginataang%')->get();
    echo "Found " . $ginataangRecipes->count() . " ginataang recipes:\n";
    foreach ($ginataangRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for Tortang recipes
    echo "6. TORTANG RECIPES:\n";
    $tortangRecipes = Recipe::where('name', 'LIKE', '%Tortang%')->get();
    echo "Found " . $tortangRecipes->count() . " tortang recipes:\n";
    foreach ($tortangRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for Pancake recipes
    echo "7. PANCAKE RECIPES:\n";
    $pancakeRecipes = Recipe::where('name', 'LIKE', '%Pancake%')->get();
    echo "Found " . $pancakeRecipes->count() . " pancake recipes:\n";
    foreach ($pancakeRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for Filipino Breakfast recipes
    echo "8. FILIPINO BREAKFAST RECIPES:\n";
    $filipinoBreakfastRecipes = Recipe::where('name', 'LIKE', '%Filipino Breakfast%')->get();
    echo "Found " . $filipinoBreakfastRecipes->count() . " Filipino Breakfast recipes:\n";
    foreach ($filipinoBreakfastRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ")\n";
    }
    echo "\n";
    
    // Check for specific new ingredients
    echo "9. CHECKING NEW INGREDIENTS:\n";
    $newIngredients = ['tocino', 'corned beef', 'spam', 'hotdog', 'bacon', 'ham', 'chorizo', 'vienna sausage', 'sardines in tomato sauce', 'tuna flakes'];
    foreach ($newIngredients as $ingredientName) {
        $ingredient = Ingredient::where('name', $ingredientName)->first();
        if ($ingredient) {
            echo "✓ " . $ingredient->name . " - " . $ingredient->category . "\n";
        } else {
            echo "✗ " . $ingredientName . " - NOT FOUND\n";
        }
    }
    echo "\n";
    
    // Check recent recipes
    echo "10. RECENT RECIPES (last 10):\n";
    $recentRecipes = Recipe::orderBy('created_at', 'desc')->limit(10)->get(['name', 'category', 'created_at']);
    foreach ($recentRecipes as $recipe) {
        echo "- " . $recipe->name . " (" . $recipe->category . ") - " . $recipe->created_at . "\n";
    }
    
    echo "\n=== CHECK COMPLETED ===\n";
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
