<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            AdminUserSeeder::class,
            DashboardRecipesSeeder::class, // This includes recipes, ingredients, and meal plans
            HealthyFilipinoFoodsSeeder::class, // 50 additional healthy Filipino recipes
            FilipinoDessertRecipesSeeder::class, // 75 Filipino dessert recipes
        ]);
    }
}
