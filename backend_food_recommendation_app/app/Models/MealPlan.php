<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class MealPlan extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'start_date',
        'end_date',
        'user_id',
        'is_active',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'is_active' => 'boolean',
    ];

    /**
     * Get the user that owns the meal plan.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the meal plan items for the meal plan.
     */
    public function mealPlanItems(): HasMany
    {
        return $this->hasMany(MealPlanItem::class);
    }

    /**
     * Get the recipes for the meal plan.
     */
    public function recipes()
    {
        return $this->belongsToMany(Recipe::class, 'meal_plan_items')
                    ->withPivot('day', 'meal_type', 'servings')
                    ->withTimestamps();
    }

    /**
     * Scope to get only active meal plans.
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope to get meal plans for a specific user.
     */
    public function scopeForUser($query, $userId)
    {
        return $query->where('user_id', $userId);
    }
}
