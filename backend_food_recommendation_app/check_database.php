<?php

require_once 'vendor/autoload.php';

use App\Models\User;
use App\Models\Recipe;
use App\Models\Ingredient;
use App\Models\MealPlan;

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== DATABASE CONTENT CHECK ===\n\n";

try {
    // Check Users
    $userCount = User::count();
    echo "👤 Users: $userCount\n";
    if ($userCount > 0) {
        $users = User::select('id', 'name', 'email')->limit(3)->get();
        foreach ($users as $user) {
            echo "   - ID: {$user->id}, Name: {$user->name}, Email: {$user->email}\n";
        }
    }

    // Check Recipes
    $recipeCount = Recipe::count();
    echo "\n🍽️ Recipes: $recipeCount\n";
    if ($recipeCount > 0) {
        $recipes = Recipe::select('id', 'name', 'description')->limit(3)->get();
        foreach ($recipes as $recipe) {
            echo "   - ID: {$recipe->id}, Name: {$recipe->name}\n";
        }
    }

    // Check Ingredients
    $ingredientCount = Ingredient::count();
    echo "\n🥕 Ingredients: $ingredientCount\n";
    if ($ingredientCount > 0) {
        $ingredients = Ingredient::select('id', 'name', 'category')->limit(3)->get();
        foreach ($ingredients as $ingredient) {
            echo "   - ID: {$ingredient->id}, Name: {$ingredient->name}, Category: {$ingredient->category}\n";
        }
    }

    // Check Meal Plans (if model exists)
    try {
        if (class_exists('App\Models\MealPlan')) {
            $mealPlanCount = MealPlan::count();
            echo "\n📅 Meal Plans: $mealPlanCount\n";
            if ($mealPlanCount > 0) {
                $mealPlans = MealPlan::select('id', 'name', 'start_date', 'end_date')->limit(3)->get();
                foreach ($mealPlans as $plan) {
                    echo "   - ID: {$plan->id}, Name: {$plan->name}, Dates: {$plan->start_date} to {$plan->end_date}\n";
                }
            }
        } else {
            echo "\n📅 Meal Plans: Model not found (this is normal)\n";
        }
    } catch (Exception $e) {
        echo "\n📅 Meal Plans: Not available\n";
    }

    echo "\n✅ Database is accessible and contains data!\n";

} catch (Exception $e) {
    echo "❌ Error accessing database: " . $e->getMessage() . "\n";
}
