<?php

namespace App\Http\Controllers;

use App\Models\MealPlan;
use App\Models\MealPlanItem;
use App\Models\Recipe;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class MealPlanController extends Controller
{
    // Get all meal plans for a user
    public function index(Request $request): JsonResponse
    {
        try {
            $userId = $request->user()->id;
            $mealPlans = MealPlan::where('user_id', $userId)
                ->with(['items.recipe'])
                ->orderBy('created_at', 'desc')
                ->get();
            
            return response()->json($mealPlans);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch meal plans'], 500);
        }
    }

    // Create a new meal plan
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'description' => 'nullable|string',
                'start_date' => 'required|date',
                'end_date' => 'required|date|after:start_date',
                'meals' => 'required|array',
                'meals.*.recipe_id' => 'required|exists:recipes,id',
                'meals.*.day' => 'required|integer|min:1|max:7',
                'meals.*.meal_type' => 'required|string|in:breakfast,lunch,dinner,snack',
                'meals.*.servings' => 'required|integer|min:1',
            ]);

            $mealPlan = MealPlan::create([
                'name' => $validated['name'],
                'description' => $validated['description'],
                'start_date' => $validated['start_date'],
                'end_date' => $validated['end_date'],
                'user_id' => $request->user()->id,
            ]);

            // Create meal plan items
            foreach ($validated['meals'] as $meal) {
                MealPlanItem::create([
                    'meal_plan_id' => $mealPlan->id,
                    'recipe_id' => $meal['recipe_id'],
                    'day' => $meal['day'],
                    'meal_type' => $meal['meal_type'],
                    'servings' => $meal['servings'],
                ]);
            }

            $mealPlan->load(['items.recipe']);
            
            return response()->json([
                'success' => true,
                'meal_plan' => $mealPlan,
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'Failed to create meal plan',
            ], 500);
        }
    }

    // Get a specific meal plan
    public function show($id, Request $request): JsonResponse
    {
        try {
            $mealPlan = MealPlan::where('id', $id)
                ->where('user_id', $request->user()->id)
                ->with(['items.recipe'])
                ->first();

            if (!$mealPlan) {
                return response()->json(['error' => 'Meal plan not found'], 404);
            }

            return response()->json($mealPlan);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch meal plan'], 500);
        }
    }

    // Update a meal plan
    public function update(Request $request, $id): JsonResponse
    {
        try {
            $mealPlan = MealPlan::where('id', $id)
                ->where('user_id', $request->user()->id)
                ->first();

            if (!$mealPlan) {
                return response()->json(['error' => 'Meal plan not found'], 404);
            }

            $validated = $request->validate([
                'name' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'start_date' => 'sometimes|date',
                'end_date' => 'sometimes|date|after:start_date',
            ]);

            $mealPlan->update($validated);
            $mealPlan->load(['items.recipe']);

            return response()->json([
                'success' => true,
                'meal_plan' => $mealPlan,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'Failed to update meal plan',
            ], 500);
        }
    }

    // Delete a meal plan
    public function destroy($id, Request $request): JsonResponse
    {
        try {
            $mealPlan = MealPlan::where('id', $id)
                ->where('user_id', $request->user()->id)
                ->first();

            if (!$mealPlan) {
                return response()->json(['error' => 'Meal plan not found'], 404);
            }

            $mealPlan->delete();

            return response()->json([
                'success' => true,
                'message' => 'Meal plan deleted successfully',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'Failed to delete meal plan',
            ], 500);
        }
    }

    // Get meal plan suggestions
    public function suggestions(Request $request): JsonResponse
    {
        try {
            $user = $request->user();
            $suggestions = Recipe::where('is_filipino_dish', true)
                ->inRandomOrder()
                ->limit(5)
                ->get();

            return response()->json([
                'success' => true,
                'suggestions' => $suggestions,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'Failed to get suggestions',
            ], 500);
        }
    }
}
