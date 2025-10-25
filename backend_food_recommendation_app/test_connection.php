<?php
echo "Testing MySQL connection...\n";

try {
    $pdo = new PDO('mysql:host=127.0.0.1;dbname=food_recommendation_app', 'root', '');
    echo "✅ Connected to MySQL successfully!\n";
    
    $tables = $pdo->query('SHOW TABLES')->fetchAll(PDO::FETCH_COLUMN);
    echo "📊 Tables created: " . implode(', ', $tables) . "\n";
    
    // Check users table
    $userCount = $pdo->query('SELECT COUNT(*) FROM users')->fetchColumn();
    echo "👥 Users in database: $userCount\n";
    
    // Check if meal_plans table exists
    $mealPlanCount = $pdo->query('SELECT COUNT(*) FROM meal_plans')->fetchColumn();
    echo "🍽️ Meal plans in database: $mealPlanCount\n";
    
    echo "\n🎉 Database setup complete!\n";
    echo "Next: Run the SQL scripts in MySQL Workbench:\n";
    echo "1. setup_mysql.sql (if not already run)\n";
    echo "2. insert_meal_plans_data.sql\n";
    
} catch(Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}
?>
