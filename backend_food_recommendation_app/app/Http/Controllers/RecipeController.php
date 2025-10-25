<?php

namespace App\Http\Controllers;

use App\Models\Recipe;
use App\Models\Ingredient;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class RecipeController extends Controller
{
    // Get all recipes
    public function index(): JsonResponse
    {
        try {
            $recipes = Recipe::with(['ingredients'])->get();
            return response()->json($recipes);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch recipes'], 500);
        }
    }

    // Get popular recipes
    public function popular(): JsonResponse
    {
        try {
            $recipes = Recipe::with(['ingredients'])
                ->where('is_filipino_dish', true)
                ->orderBy('created_at', 'desc')
                ->limit(10)
                ->get();
            return response()->json($recipes);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch popular recipes'], 500);
        }
    }

    // Get recipe statistics
    public function stats(): JsonResponse
    {
        try {
            $totalRecipes = Recipe::count();
            $filipinoRecipes = Recipe::where('is_filipino_dish', true)->count();
            $totalIngredients = Ingredient::count();
            
            return response()->json([
                'total_recipes' => $totalRecipes,
                'filipino_recipes' => $filipinoRecipes,
                'total_ingredients' => $totalIngredients,
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch stats'], 500);
        }
    }

    // Get single recipe
    public function show($id): JsonResponse
    {
        try {
            $recipe = Recipe::with(['ingredients'])->find($id);
            if (!$recipe) {
                return response()->json(['error' => 'Recipe not found'], 404);
            }
            return response()->json($recipe);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch recipe'], 500);
        }
    }

    // Search recipes
    public function search(Request $request): JsonResponse
    {
        try {
            $query = $request->get('q', '');
            $recipes = Recipe::with(['ingredients'])
                ->where('name', 'like', "%{$query}%")
                ->orWhere('description', 'like', "%{$query}%")
                ->get();
            return response()->json($recipes);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Search failed'], 500);
        }
    }
}
