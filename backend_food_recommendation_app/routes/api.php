<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\RecipeController;
use App\Http\Controllers\MealPlanController;
use App\Http\Controllers\AdminController;
use App\Models\User;

// Public routes
Route::get('/users', function () {
    return User::all();
});

// Recipe routes
Route::get('/recipes', [RecipeController::class, 'index']);
Route::get('/recipes/popular', [RecipeController::class, 'popular']);
Route::get('/recipes/stats', [RecipeController::class, 'stats']);
Route::get('/recipes/{id}', [RecipeController::class, 'show']);
Route::get('/recipes/search', [RecipeController::class, 'search']);

// Authentication routes
Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/auth/register', [AuthController::class, 'register']);

// Protected routes (require authentication)
Route::middleware('auth:sanctum')->group(function () {
    // Auth routes
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::get('/auth/me', [AuthController::class, 'me']);
    
    // Meal plan routes
    Route::get('/meal-plans', [MealPlanController::class, 'index']);
    Route::post('/meal-plans', [MealPlanController::class, 'store']);
    Route::get('/meal-plans/{id}', [MealPlanController::class, 'show']);
    Route::put('/meal-plans/{id}', [MealPlanController::class, 'update']);
    Route::delete('/meal-plans/{id}', [MealPlanController::class, 'destroy']);
    Route::get('/meal-plans/suggestions', [MealPlanController::class, 'suggestions']);
});

// Admin routes (require admin authentication)
Route::middleware(['auth:sanctum', 'admin'])->prefix('admin')->group(function () {
    // Dashboard
    Route::get('/dashboard', [AdminController::class, 'dashboard']);
    Route::get('/analytics', [AdminController::class, 'getAnalytics']);
    
    // User management
    Route::get('/users', [AdminController::class, 'getUsers']);
    Route::put('/users/{id}/status', [AdminController::class, 'updateUserStatus']);
    Route::delete('/users/{id}', [AdminController::class, 'deleteUser']);
    
    // Recipe management
    Route::get('/recipes', [AdminController::class, 'getRecipes']);
    Route::post('/recipes', [AdminController::class, 'createRecipe']);
    Route::put('/recipes/{id}', [AdminController::class, 'updateRecipe']);
    Route::delete('/recipes/{id}', [AdminController::class, 'deleteRecipe']);
});