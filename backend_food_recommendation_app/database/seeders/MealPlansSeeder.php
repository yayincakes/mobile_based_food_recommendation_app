<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\MealPlan;
use App\Models\MealPlanItem;
use App\Models\Recipe;

class MealPlansSeeder extends Seeder
{
    public function run(): void
    {
        // Create a test user if none exists
        $user = User::first();
        if (!$user) {
            $user = User::create([
                'name' => 'Test User',
                'email' => 'test@example.com',
                'password' => bcrypt('password'),
                'gender' => 'Male',
                'height_cm' => 175,
                'weight_kg' => 70,
                'target_weight_kg' => 65,
                'birth_date' => '1990-01-01',
                'activity_level' => 'Moderate',
                'dietary_goal' => 'Weight Loss'
            ]);
        }

        // Get some recipes for the meal plan
        $recipes = Recipe::limit(20)->get();
        
        if ($recipes->count() > 0) {
            // Create a sample meal plan
            $mealPlan = MealPlan::create([
                'name' => 'Weekly Filipino Meal Plan',
                'description' => 'A balanced weekly meal plan featuring traditional Filipino dishes',
                'start_date' => now(),
                'end_date' => now()->addDays(7),
                'user_id' => $user->id
            ]);

            // Create meal plan items for each day
            $days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
            $mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];
            
            foreach ($days as $dayIndex => $day) {
                foreach ($mealTypes as $mealType) {
                    $recipe = $recipes->random();
                    
                    MealPlanItem::create([
                        'meal_plan_id' => $mealPlan->id,
                        'recipe_id' => $recipe->id,
                        'day' => $dayIndex + 1,
                        'meal_type' => $mealType,
                        'servings' => 1
                    ]);
                }
            }
        }
    }
}
