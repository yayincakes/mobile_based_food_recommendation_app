<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MealPlanItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'meal_plan_id',
        'recipe_id',
        'day',
        'meal_type',
        'servings',
    ];

    protected $casts = [
        'day' => 'integer',
        'servings' => 'integer',
    ];

    /**
     * Get the meal plan that owns the meal plan item.
     */
    public function mealPlan(): BelongsTo
    {
        return $this->belongsTo(MealPlan::class);
    }

    /**
     * Get the recipe for the meal plan item.
     */
    public function recipe(): BelongsTo
    {
        return $this->belongsTo(Recipe::class);
    }

    /**
     * Get the meal type options.
     */
    public static function getMealTypes(): array
    {
        return [
            'breakfast',
            'lunch', 
            'dinner',
            'snack'
        ];
    }

    /**
     * Get the day names.
     */
    public static function getDayNames(): array
    {
        return [
            1 => 'Monday',
            2 => 'Tuesday', 
            3 => 'Wednesday',
            4 => 'Thursday',
            5 => 'Friday',
            6 => 'Saturday',
            7 => 'Sunday'
        ];
    }
}
