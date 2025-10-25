<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Recipe extends Model
{
    protected $fillable = [
        'name',
        'description',
        'prep_time',
        'cook_time',
        'servings',
        'difficulty',
        'category',
        'calories_per_serving',
        'protein_per_serving',
        'carbs_per_serving',
        'fat_per_serving',
        'instructions',
        'is_filipino_dish',
    ];

    protected $casts = [
        'is_filipino_dish' => 'boolean',
    ];

    public function ingredients(): BelongsToMany
    {
        return $this->belongsToMany(Ingredient::class, 'recipe_ingredients')
            ->withPivot('quantity', 'unit')
            ->withTimestamps();
    }
}
