import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class MealPlanService {
  static const String _currentPlanKey = 'current_meal_plan';
  static const String _savedPlansKey = 'saved_meal_plans';
  
  // Get current meal plan
  static Future<Map<String, dynamic>?> getCurrentPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final planJson = prefs.getString(_currentPlanKey);
      if (planJson != null) {
        return Map<String, dynamic>.from(json.decode(planJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // Save meal plan
  static Future<bool> saveMealPlan(Map<String, dynamic> mealPlan) async {
    try {
      // Try to save to API first
      final apiResult = await ApiService.createMealPlan(mealPlanData: mealPlan);
      if (apiResult['success']) {
        // Also save locally as backup
        await _saveMealPlanLocally(mealPlan);
        return true;
      }
      
      // Fallback to local storage
      return await _saveMealPlanLocally(mealPlan);
    } catch (e) {
      // Fallback to local storage on error
      return await _saveMealPlanLocally(mealPlan);
    }
  }
  
  // Save meal plan locally
  static Future<bool> _saveMealPlanLocally(Map<String, dynamic> mealPlan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentPlanKey, json.encode(mealPlan));
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Set current plan
  static Future<void> setCurrentPlan(Map<String, dynamic> plan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentPlanKey, json.encode(plan));
    } catch (e) {
      // Handle error silently
    }
  }
  
  // Generate meal plan based on user preferences
  static Future<Map<String, dynamic>> generateMealPlan({
    required String goal,
    required List<String> healthConditions,
    required List<String> dietaryRestrictions,
    required int mealsPerDay,
    required String activityLevel,
  }) async {
    try {
      // Get available recipes from API
      final recipesResult = await ApiService.getFilipinoRecipes();
      List<dynamic> availableRecipes = [];
      
      if (recipesResult['success'] && recipesResult['data'] != null) {
        availableRecipes = recipesResult['data']['data'] ?? [];
      }
      
      // Filter recipes based on health conditions and restrictions
      List<dynamic> filteredRecipes = _filterRecipesForUser(
        availableRecipes,
        healthConditions: healthConditions,
        dietaryRestrictions: dietaryRestrictions,
      );
      
      // Generate meal plan
      final mealPlan = _createMealPlan(
        filteredRecipes,
        goal: goal,
        mealsPerDay: mealsPerDay,
        activityLevel: activityLevel,
      );
      
      return mealPlan;
    } catch (e) {
      // Return empty meal plan on error
      return {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'createdAt': DateTime.now().toIso8601String(),
        'goal': goal,
        'mealsPerDay': mealsPerDay,
        'activityLevel': activityLevel,
        'meals': [],
        'totalCalories': 0,
        'totalProtein': 0,
        'totalCarbs': 0,
        'totalFat': 0,
      };
    }
  }
  
  // Filter recipes for user
  static List<dynamic> _filterRecipesForUser(
    List<dynamic> recipes, {
    required List<String> healthConditions,
    required List<String> dietaryRestrictions,
  }) {
    return recipes.where((recipe) {
      // Filter based on dietary restrictions
      if (dietaryRestrictions.isNotEmpty && dietaryRestrictions.first != 'None') {
        final ingredients = _getIngredientsList(recipe);
        for (final restriction in dietaryRestrictions) {
          if (restriction == 'Vegetarian' && _containsMeat(ingredients)) {
            return false;
          }
          if (restriction == 'Vegan' && (_containsMeat(ingredients) || _containsDairy(ingredients))) {
            return false;
          }
          if (restriction == 'Dairy-free' && _containsDairy(ingredients)) {
            return false;
          }
          if (restriction == 'Nut allergy' && _containsNuts(ingredients)) {
            return false;
          }
          if (restriction == 'Gluten-free' && _containsGluten(ingredients)) {
            return false;
          }
          if (restriction == 'Pork-free' && _containsPork(ingredients)) {
            return false;
          }
        }
      }
      
      return true;
    }).toList();
  }
  
  // Create meal plan
  static Map<String, dynamic> _createMealPlan(
    List<dynamic> recipes, {
    required String goal,
    required int mealsPerDay,
    required String activityLevel,
  }) {
    if (recipes.isEmpty) {
      return {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'createdAt': DateTime.now().toIso8601String(),
        'goal': goal,
        'mealsPerDay': mealsPerDay,
        'activityLevel': activityLevel,
        'meals': [],
        'totalCalories': 0,
        'totalProtein': 0,
        'totalCarbs': 0,
        'totalFat': 0,
      };
    }
    
    // Shuffle recipes for variety
    final shuffledRecipes = List.from(recipes)..shuffle();
    
    // Create meals
    final meals = <Map<String, dynamic>>[];
    final mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
    
    for (int i = 0; i < mealsPerDay && i < mealTypes.length; i++) {
      if (i < shuffledRecipes.length) {
        final recipe = shuffledRecipes[i];
        meals.add({
          'mealType': mealTypes[i],
          'recipe': recipe,
          'servings': 1,
        });
      }
    }
    
    // Calculate totals
    int totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    
    for (final meal in meals) {
      final recipe = meal['recipe'];
      totalCalories += recipe['calories'] ?? 0;
      totalProtein += (recipe['protein'] ?? 0).toDouble();
      totalCarbs += (recipe['carbs'] ?? 0).toDouble();
      totalFat += (recipe['fat'] ?? 0).toDouble();
    }
    
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'createdAt': DateTime.now().toIso8601String(),
      'goal': goal,
      'mealsPerDay': mealsPerDay,
      'activityLevel': activityLevel,
      'meals': meals,
      'totalCalories': totalCalories,
      'totalProtein': totalProtein,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
    };
  }
  
  // Helper methods for dietary restrictions
  static List<String> _getIngredientsList(dynamic recipe) {
    if (recipe['ingredients'] is List) {
      return (recipe['ingredients'] as List)
          .map((e) => e.toString().toLowerCase())
          .toList();
    }
    return [];
  }
  
  static bool _containsMeat(List<String> ingredients) {
    final meatKeywords = ['manok', 'baboy', 'baka', 'karne', 'chicken', 'pork', 'beef', 'meat'];
    return ingredients.any((ingredient) => 
      meatKeywords.any((keyword) => ingredient.contains(keyword)));
  }
  
  static bool _containsDairy(List<String> ingredients) {
    final dairyKeywords = ['gatas', 'milk', 'cheese', 'dairy', 'butter', 'cream'];
    return ingredients.any((ingredient) => 
      dairyKeywords.any((keyword) => ingredient.contains(keyword)));
  }
  
  static bool _containsNuts(List<String> ingredients) {
    final nutKeywords = ['mani', 'nuts', 'peanut', 'almond', 'cashew', 'walnut'];
    return ingredients.any((ingredient) => 
      nutKeywords.any((keyword) => ingredient.contains(keyword)));
  }
  
  static bool _containsGluten(List<String> ingredients) {
    final glutenKeywords = ['wheat', 'flour', 'bread', 'pasta', 'noodles', 'canton'];
    return ingredients.any((ingredient) => 
      glutenKeywords.any((keyword) => ingredient.contains(keyword)));
  }
  
  static bool _containsPork(List<String> ingredients) {
    final porkKeywords = ['baboy', 'pork', 'bacon', 'ham'];
    return ingredients.any((ingredient) => 
      porkKeywords.any((keyword) => ingredient.contains(keyword)));
  }
}
