<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Recipe;
use App\Models\MealPlan;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class AdminController extends Controller
{
    /**
     * Get admin dashboard statistics
     */
    public function dashboard(): JsonResponse
    {
        try {
            $stats = [
                'users' => [
                    'total' => User::count(),
                    'active' => User::where('is_active', true)->count(),
                    'new_this_month' => User::whereMonth('created_at', Carbon::now()->month)->count(),
                    'growth_rate' => $this->calculateGrowthRate('users'),
                ],
                'recipes' => [
                    'total' => Recipe::count(),
                    'filipino_dishes' => Recipe::where('is_filipino_dish', true)->count(),
                    'new_this_month' => Recipe::whereMonth('created_at', Carbon::now()->month)->count(),
                    'avg_calories' => Recipe::avg('calories_per_serving'),
                ],
                'meal_plans' => [
                    'total' => MealPlan::count(),
                    'active' => MealPlan::where('end_date', '>=', Carbon::now())->count(),
                    'new_this_month' => MealPlan::whereMonth('created_at', Carbon::now()->month)->count(),
                ],
                'system' => [
                    'total_ingredients' => DB::table('ingredients')->count(),
                    'avg_recipe_rating' => 4.2, // Placeholder - would need rating system
                    'popular_categories' => $this->getPopularCategories(),
                ]
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch dashboard data',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get users with pagination and filters
     */
    public function getUsers(Request $request): JsonResponse
    {
        try {
            $query = User::query();

            // Filter by role
            if ($request->has('role')) {
                $query->where('role', $request->role);
            }

            // Filter by active status
            if ($request->has('is_active')) {
                $query->where('is_active', $request->boolean('is_active'));
            }

            // Search by name or email
            if ($request->has('search')) {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%")
                      ->orWhere('email', 'like', "%{$search}%");
                });
            }

            // Sort
            $sortBy = $request->get('sort_by', 'created_at');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            $users = $query->paginate($request->get('per_page', 15));

            return response()->json([
                'success' => true,
                'data' => $users
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch users',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update user status
     */
    public function updateUserStatus(Request $request, $id): JsonResponse
    {
        try {
            $user = User::findOrFail($id);
            
            $request->validate([
                'is_active' => 'required|boolean'
            ]);

            $user->update([
                'is_active' => $request->is_active
            ]);

            return response()->json([
                'success' => true,
                'message' => 'User status updated successfully',
                'data' => $user
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update user status',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete user
     */
    public function deleteUser($id): JsonResponse
    {
        try {
            $user = User::findOrFail($id);
            
            // Prevent deleting admin users
            if ($user->isAdmin()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Cannot delete admin users'
                ], 400);
            }

            $user->delete();

            return response()->json([
                'success' => true,
                'message' => 'User deleted successfully'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete user',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get recipes with admin filters
     */
    public function getRecipes(Request $request): JsonResponse
    {
        try {
            $query = Recipe::with('ingredients');

            // Filter by category
            if ($request->has('category')) {
                $query->where('category', $request->category);
            }

            // Filter by Filipino dishes
            if ($request->has('is_filipino_dish')) {
                $query->where('is_filipino_dish', $request->boolean('is_filipino_dish'));
            }

            // Search by name
            if ($request->has('search')) {
                $query->where('name', 'like', "%{$request->search}%");
            }

            // Sort
            $sortBy = $request->get('sort_by', 'created_at');
            $sortOrder = $request->get('sort_order', 'desc');
            $query->orderBy($sortBy, $sortOrder);

            $recipes = $query->paginate($request->get('per_page', 15));

            return response()->json([
                'success' => true,
                'data' => $recipes
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch recipes',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Create new recipe
     */
    public function createRecipe(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'description' => 'nullable|string',
                'prep_time' => 'required|integer|min:0',
                'cook_time' => 'required|integer|min:0',
                'servings' => 'required|integer|min:1',
                'difficulty' => 'required|in:easy,medium,hard',
                'category' => 'required|string',
                'calories_per_serving' => 'required|numeric|min:0',
                'protein_per_serving' => 'required|numeric|min:0',
                'carbs_per_serving' => 'required|numeric|min:0',
                'fat_per_serving' => 'required|numeric|min:0',
                'instructions' => 'required|string',
                'is_filipino_dish' => 'boolean',
                'ingredients' => 'required|array',
                'ingredients.*.ingredient_id' => 'required|exists:ingredients,id',
                'ingredients.*.quantity' => 'required|string',
                'ingredients.*.unit' => 'required|string',
            ]);

            DB::beginTransaction();

            $recipe = Recipe::create($request->except('ingredients'));

            // Attach ingredients
            foreach ($request->ingredients as $ingredient) {
                $recipe->ingredients()->attach($ingredient['ingredient_id'], [
                    'quantity' => $ingredient['quantity'],
                    'unit' => $ingredient['unit']
                ]);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Recipe created successfully',
                'data' => $recipe->load('ingredients')
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Failed to create recipe',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update recipe
     */
    public function updateRecipe(Request $request, $id): JsonResponse
    {
        try {
            $recipe = Recipe::findOrFail($id);

            $request->validate([
                'name' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'prep_time' => 'sometimes|integer|min:0',
                'cook_time' => 'sometimes|integer|min:0',
                'servings' => 'sometimes|integer|min:1',
                'difficulty' => 'sometimes|in:easy,medium,hard',
                'category' => 'sometimes|string',
                'calories_per_serving' => 'sometimes|numeric|min:0',
                'protein_per_serving' => 'sometimes|numeric|min:0',
                'carbs_per_serving' => 'sometimes|numeric|min:0',
                'fat_per_serving' => 'sometimes|numeric|min:0',
                'instructions' => 'sometimes|string',
                'is_filipino_dish' => 'boolean',
            ]);

            $recipe->update($request->all());

            return response()->json([
                'success' => true,
                'message' => 'Recipe updated successfully',
                'data' => $recipe->load('ingredients')
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update recipe',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete recipe
     */
    public function deleteRecipe($id): JsonResponse
    {
        try {
            $recipe = Recipe::findOrFail($id);
            $recipe->delete();

            return response()->json([
                'success' => true,
                'message' => 'Recipe deleted successfully'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete recipe',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get analytics data
     */
    public function getAnalytics(Request $request): JsonResponse
    {
        try {
            $period = $request->get('period', '30'); // days
            $startDate = Carbon::now()->subDays($period);

            $analytics = [
                'user_registrations' => $this->getUserRegistrations($startDate),
                'recipe_views' => $this->getRecipeViews($startDate),
                'popular_recipes' => $this->getPopularRecipes($startDate),
                'category_distribution' => $this->getCategoryDistribution(),
                'user_activity' => $this->getUserActivity($startDate),
            ];

            return response()->json([
                'success' => true,
                'data' => $analytics
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch analytics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Helper methods
    private function calculateGrowthRate($table): float
    {
        $currentMonth = DB::table($table)->whereMonth('created_at', Carbon::now()->month)->count();
        $lastMonth = DB::table($table)->whereMonth('created_at', Carbon::now()->subMonth()->month)->count();
        
        if ($lastMonth == 0) return $currentMonth > 0 ? 100 : 0;
        
        return round((($currentMonth - $lastMonth) / $lastMonth) * 100, 2);
    }

    private function getPopularCategories(): array
    {
        return Recipe::select('category', DB::raw('count(*) as count'))
            ->groupBy('category')
            ->orderBy('count', 'desc')
            ->limit(5)
            ->get()
            ->toArray();
    }

    private function getUserRegistrations($startDate): array
    {
        return User::select(DB::raw('DATE(created_at) as date'), DB::raw('count(*) as count'))
            ->where('created_at', '>=', $startDate)
            ->groupBy('date')
            ->orderBy('date')
            ->get()
            ->toArray();
    }

    private function getRecipeViews($startDate): array
    {
        // Placeholder - would need a views table
        return [];
    }

    private function getPopularRecipes($startDate): array
    {
        return Recipe::select('name', 'category', 'calories_per_serving')
            ->orderBy('created_at', 'desc')
            ->limit(10)
            ->get()
            ->toArray();
    }

    private function getCategoryDistribution(): array
    {
        return Recipe::select('category', DB::raw('count(*) as count'))
            ->groupBy('category')
            ->get()
            ->toArray();
    }

    private function getUserActivity($startDate): array
    {
        // Placeholder - would need activity tracking
        return [];
    }
}
