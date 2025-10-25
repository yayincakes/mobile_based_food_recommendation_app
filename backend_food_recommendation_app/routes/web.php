<?php

use Illuminate\Support\Facades\Route;
use App\Models\Recipe;
use App\Models\Ingredient;

Route::get('/', function () {
    return view('welcome');
});

// Database browser routes
Route::get('/recipes', function () {
    $recipes = Recipe::with('ingredients')->orderBy('name')->get();
    return response()->json([
        'total' => $recipes->count(),
        'recipes' => $recipes
    ]);
});

Route::get('/recipes/category/{category}', function ($category) {
    $recipes = Recipe::where('category', $category)->with('ingredients')->get();
    return response()->json([
        'category' => $category,
        'total' => $recipes->count(),
        'recipes' => $recipes
    ]);
});

Route::get('/recipes/search/{name}', function ($name) {
    $recipes = Recipe::where('name', 'like', "%{$name}%")->with('ingredients')->get();
    return response()->json([
        'search_term' => $name,
        'total' => $recipes->count(),
        'recipes' => $recipes
    ]);
});

Route::get('/desserts', function () {
    $desserts = Recipe::where('category', 'Dessert')->with('ingredients')->get();
    return response()->json([
        'total' => $desserts->count(),
        'desserts' => $desserts
    ]);
});

Route::get('/ingredients', function () {
    $ingredients = Ingredient::orderBy('name')->get();
    return response()->json([
        'total' => $ingredients->count(),
        'ingredients' => $ingredients
    ]);
});

Route::get('/stats', function () {
    return response()->json([
        'total_recipes' => Recipe::count(),
        'total_ingredients' => Ingredient::count(),
        'filipino_dishes' => Recipe::where('is_filipino_dish', true)->count(),
        'dessert_recipes' => Recipe::where('category', 'Dessert')->count(),
        'healthy_recipes' => Recipe::where('category', 'Healthy')->count(),
        'categories' => Recipe::selectRaw('category, COUNT(*) as count')
            ->groupBy('category')
            ->orderBy('count', 'desc')
            ->get()
    ]);
});

Route::get('/browser', function () {
    $stats = [
        'total_recipes' => Recipe::count(),
        'total_ingredients' => Ingredient::count(),
        'categories' => Recipe::selectRaw('category, COUNT(*) as count')
            ->groupBy('category')
            ->orderBy('count', 'desc')
            ->get()
    ];
    
    return view('browser', compact('stats'));
});