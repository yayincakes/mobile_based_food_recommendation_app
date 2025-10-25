<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\Recipe;
use App\Models\Ingredient;

echo "=== RECIPE DATABASE DEBUG ===\n\n";

// Check total recipes
$totalRecipes = Recipe::count();
echo "📊 DATABASE TOTAL: {$totalRecipes} recipes\n\n";

// Check what seeders have been run
echo "🔍 CHECKING SEEDER STATUS:\n";

// Check if all seeders have been run
$seederFiles = [
    'DashboardRecipesSeeder' => 'dashboard_recipes_seeder.php',
    'HealthyFilipinoFoodsSeeder' => 'healthy_filipino_foods_seeder.php', 
    'FilipinoDessertRecipesSeeder' => 'filipino_dessert_recipes_seeder.php'
];

foreach ($seederFiles as $seederName => $filename) {
    $filePath = "database/seeders/{$filename}";
    if (file_exists($filePath)) {
        echo "✅ {$seederName}: File exists\n";
    } else {
        echo "❌ {$seederName}: File missing\n";
    }
}

echo "\n";

// Check recipes by seeder source (if we can identify them)
echo "📋 RECIPES BY CATEGORY:\n";
$categories = Recipe::selectRaw('category, COUNT(*) as count')
    ->groupBy('category')
    ->orderBy('count', 'desc')
    ->get();

foreach ($categories as $category) {
    echo "  - {$category->category}: {$category->count} recipes\n";
}

echo "\n";

// Check for specific recipes that should be there
echo "🔍 CHECKING FOR SPECIFIC RECIPES:\n";
$testRecipes = [
    'Adobong Manok', 'Sinigang', 'Kare-Kare', 'Lechon', 'Bibingka', 
    'Halo-Halo', 'Leche Flan', 'Ube Halaya', 'Biko', 'Puto',
    'Adobong Kangkong', 'Ginataang Kalabasa', 'Pinakbet', 'Laing'
];

foreach ($testRecipes as $recipeName) {
    $exists = Recipe::where('name', $recipeName)->exists();
    echo ($exists ? "✅" : "❌") . " {$recipeName}\n";
}

echo "\n";

// Check if we need to run more seeders
echo "📊 ANALYSIS:\n";
echo "Expected: 222 recipes (from Flutter app)\n";
echo "Actual: {$totalRecipes} recipes (in database)\n";
echo "Missing: " . (222 - $totalRecipes) . " recipes\n\n";

if ($totalRecipes < 222) {
    echo "⚠️  ISSUE IDENTIFIED: Database is missing recipes!\n";
    echo "The Flutter app has 222 recipes but database only has {$totalRecipes}.\n";
    echo "We need to run additional seeders or add missing recipes.\n";
} else {
    echo "✅ Database is up to date with Flutter app.\n";
}
