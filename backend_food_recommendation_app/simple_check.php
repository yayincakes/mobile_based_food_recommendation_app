<?php

// Simple database check without Laravel
$host = 'localhost';
$dbname = 'food_recommendation_app';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "=== DATABASE CONNECTION SUCCESSFUL ===\n\n";
    
    // Check total recipes
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM recipes");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "Total recipes: " . $result['count'] . "\n";
    
    // Check total ingredients
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM ingredients");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "Total ingredients: " . $result['count'] . "\n\n";
    
    // Check for silog recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%silog%'");
    $silogRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Silog recipes (" . count($silogRecipes) . "):\n";
    foreach ($silogRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for Pandesal recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%Pandesal%'");
    $pandesalRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Pandesal recipes (" . count($pandesalRecipes) . "):\n";
    foreach ($pandesalRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for Puto recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%Puto%'");
    $putoRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Puto recipes (" . count($putoRecipes) . "):\n";
    foreach ($putoRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for Ginataang recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%Ginataang%'");
    $ginataangRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Ginataang recipes (" . count($ginataangRecipes) . "):\n";
    foreach ($ginataangRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for Tortang recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%Tortang%'");
    $tortangRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Tortang recipes (" . count($tortangRecipes) . "):\n";
    foreach ($tortangRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for Pancake recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%Pancake%'");
    $pancakeRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Pancake recipes (" . count($pancakeRecipes) . "):\n";
    foreach ($pancakeRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for Filipino Breakfast recipes
    $stmt = $pdo->query("SELECT name, category FROM recipes WHERE name LIKE '%Filipino Breakfast%'");
    $filipinoBreakfastRecipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo "Filipino Breakfast recipes (" . count($filipinoBreakfastRecipes) . "):\n";
    foreach ($filipinoBreakfastRecipes as $recipe) {
        echo "- " . $recipe['name'] . " (" . $recipe['category'] . ")\n";
    }
    echo "\n";
    
    // Check for specific new ingredients
    echo "Checking new ingredients:\n";
    $newIngredients = ['tocino', 'corned beef', 'spam', 'hotdog', 'bacon', 'ham', 'chorizo', 'vienna sausage', 'sardines in tomato sauce', 'tuna flakes'];
    foreach ($newIngredients as $ingredientName) {
        $stmt = $pdo->prepare("SELECT name, category FROM ingredients WHERE name = ?");
        $stmt->execute([$ingredientName]);
        $ingredient = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($ingredient) {
            echo "✓ " . $ingredient['name'] . " - " . $ingredient['category'] . "\n";
        } else {
            echo "✗ " . $ingredientName . " - NOT FOUND\n";
        }
    }
    
    echo "\n=== CHECK COMPLETED ===\n";
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
