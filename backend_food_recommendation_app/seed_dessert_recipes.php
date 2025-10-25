<?php

require_once 'vendor/autoload.php';

use Illuminate\Database\Seeder;
use Database\Seeders\FilipinoDessertRecipesSeeder;

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

// Run the seeder
$seeder = new FilipinoDessertRecipesSeeder();
$seeder->run();

echo "Filipino dessert recipes have been added to the database!\n";
echo "Total recipes added: 75 Filipino dessert recipes\n";
echo "Categories: Traditional desserts, rice cakes, bread, pastries, spring rolls, and more\n";
