import 'dart:math';
import 'user_preference_service.dart';
import 'api_service.dart';

class MealSuggestionService {
  // Get today's meal suggestions
  static Future<List<Map<String, dynamic>>> getTodayMealSuggestions() async {
    try {
      // Get user preferences
      final healthConditions = await UserPreferenceService.getUserHealthConditions();
      final dietaryRestrictions = await UserPreferenceService.getUserDietaryRestrictions();
      final goal = await UserPreferenceService.getUserGoal();
      
      // Get available recipes
      final recipesResult = await ApiService.getFilipinoRecipes();
      List<dynamic> availableRecipes = [];
      
      if (recipesResult['success'] && recipesResult['data'] != null) {
        availableRecipes = recipesResult['data']['data'] ?? [];
      }
      
      // Filter recipes based on user preferences
      final filteredRecipes = _filterRecipesForUser(
        availableRecipes,
        healthConditions: healthConditions,
        dietaryRestrictions: dietaryRestrictions,
        goal: goal,
      );
      
      // Get time-based suggestions
      final currentHour = DateTime.now().hour;
      final mealType = _getMealTypeForTime(currentHour);
      
      // Filter recipes by meal type and get suggestions
      final mealRecipes = _filterRecipesByMealType(filteredRecipes, mealType);
      final suggestions = _getSmartSuggestions(mealRecipes, goal, healthConditions);
      
      return suggestions;
    } catch (e) {
      return [];
    }
  }
  
  // Get health-based recommendations
  static Future<List<Map<String, dynamic>>> getHealthBasedRecommendations() async {
    try {
      final healthConditions = await UserPreferenceService.getUserHealthConditions();
      final dietaryRestrictions = await UserPreferenceService.getUserDietaryRestrictions();
      
      // Get available recipes
      final recipesResult = await ApiService.getFilipinoRecipes();
      List<dynamic> availableRecipes = [];
      
      if (recipesResult['success'] && recipesResult['data'] != null) {
        availableRecipes = recipesResult['data']['data'] ?? [];
      }
      
      // Filter based on health conditions
      final healthFilteredRecipes = _filterRecipesByHealthConditions(
        availableRecipes,
        healthConditions,
      );
      
      // Filter based on dietary restrictions
      final finalRecipes = _filterRecipesByDietaryRestrictions(
        healthFilteredRecipes,
        dietaryRestrictions,
      );
      
      return finalRecipes.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }
  
  // Get next meal suggestion
  static Future<Map<String, dynamic>?> getNextMealSuggestion() async {
    try {
      final suggestions = await getTodayMealSuggestions();
      if (suggestions.isNotEmpty) {
        final random = Random();
        return suggestions[random.nextInt(suggestions.length)];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // Helper methods
  static List<dynamic> _filterRecipesForUser(
    List<dynamic> recipes, {
    required List<String> healthConditions,
    required List<String> dietaryRestrictions,
    required String goal,
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
  
  static String _getMealTypeForTime(int hour) {
    if (hour >= 6 && hour < 11) {
      return 'Breakfast';
    } else if (hour >= 11 && hour < 15) {
      return 'Lunch';
    } else if (hour >= 15 && hour < 19) {
      return 'Snack';
    } else {
      return 'Dinner';
    }
  }
  
  static List<dynamic> _filterRecipesByMealType(List<dynamic> recipes, String mealType) {
    return recipes.where((recipe) {
      final tags = _getTagsList(recipe);
      return tags.any((tag) => _isMealTypeMatch(tag, mealType));
    }).toList();
  }
  
  static bool _isMealTypeMatch(String tag, String mealType) {
    switch (mealType) {
      case 'Breakfast':
        return tag.contains('breakfast') || tag.contains('umaga') || tag.contains('agahan');
      case 'Lunch':
        return tag.contains('lunch') || tag.contains('tanghalian') || tag.contains('ulam');
      case 'Dinner':
        return tag.contains('dinner') || tag.contains('hapunan') || tag.contains('gabi');
      case 'Snack':
        return tag.contains('snack') || tag.contains('meryenda') || tag.contains('quick');
      default:
        return true;
    }
  }
  
  static List<Map<String, dynamic>> _getSmartSuggestions(
    List<dynamic> recipes,
    String goal,
    List<String> healthConditions,
  ) {
    // Sort recipes by relevance to goal
    final sortedRecipes = List.from(recipes);
    sortedRecipes.sort((a, b) {
      final aScore = _calculateRelevanceScore(a, goal, healthConditions);
      final bScore = _calculateRelevanceScore(b, goal, healthConditions);
      return bScore.compareTo(aScore);
    });
    
    // Return top 5 suggestions
    return sortedRecipes
        .take(5)
        .cast<Map<String, dynamic>>()
        .toList();
  }
  
  static int _calculateRelevanceScore(
    dynamic recipe,
    String goal,
    List<String> healthConditions,
  ) {
    int score = 0;
    
    // Score based on goal
    switch (goal) {
      case 'Weight loss':
        if (_isLowCalorie(recipe)) score += 3;
        if (_isHighProtein(recipe)) score += 2;
        if (_isHealthy(recipe)) score += 2;
        break;
      case 'Weight gain':
        if (_isHighCalorie(recipe)) score += 3;
        if (_isHighProtein(recipe)) score += 2;
        break;
      case 'Maintenance':
        if (_isBalanced(recipe)) score += 3;
        if (_isHealthy(recipe)) score += 2;
        break;
    }
    
    // Score based on health conditions
    for (final condition in healthConditions) {
      if (condition == 'Diabetes' && _isLowSugar(recipe)) score += 2;
      if (condition == 'Hypertension' && _isLowSodium(recipe)) score += 2;
      if (condition == 'Chronic Kidney Disease' && _isLowProtein(recipe)) score += 2;
    }
    
    return score;
  }
  
  static List<dynamic> _filterRecipesByHealthConditions(
    List<dynamic> recipes,
    List<String> healthConditions,
  ) {
    if (healthConditions.isEmpty || healthConditions.first == 'None') {
      return recipes;
    }
    
    return recipes.where((recipe) {
      for (final condition in healthConditions) {
        switch (condition) {
          case 'Diabetes':
            if (!_isLowSugar(recipe)) return false;
            break;
          case 'Hypertension':
            if (!_isLowSodium(recipe)) return false;
            break;
          case 'Chronic Kidney Disease':
            if (!_isLowProtein(recipe)) return false;
            break;
        }
      }
      return true;
    }).toList();
  }
  
  static List<dynamic> _filterRecipesByDietaryRestrictions(
    List<dynamic> recipes,
    List<String> dietaryRestrictions,
  ) {
    if (dietaryRestrictions.isEmpty || dietaryRestrictions.first == 'None') {
      return recipes;
    }
    
    return recipes.where((recipe) {
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
      return true;
    }).toList();
  }
  
  // Helper methods for recipe analysis
  static List<String> _getIngredientsList(dynamic recipe) {
    if (recipe['ingredients'] is List) {
      return (recipe['ingredients'] as List)
          .map((e) => e.toString().toLowerCase())
          .toList();
    }
    return [];
  }
  
  static List<String> _getTagsList(dynamic recipe) {
    if (recipe['tags'] is List) {
      return (recipe['tags'] as List)
          .map((e) => e.toString().toLowerCase())
          .toList();
    }
    return [];
  }
  
  static bool _isLowCalorie(dynamic recipe) {
    final calories = recipe['calories'] ?? 0;
    return calories < 300;
  }
  
  static bool _isHighCalorie(dynamic recipe) {
    final calories = recipe['calories'] ?? 0;
    return calories > 400;
  }
  
  static bool _isHighProtein(dynamic recipe) {
    final protein = recipe['protein'] ?? 0;
    return protein > 20;
  }
  
  static bool _isLowProtein(dynamic recipe) {
    final protein = recipe['protein'] ?? 0;
    return protein < 15;
  }
  
  static bool _isHealthy(dynamic recipe) {
    final tags = _getTagsList(recipe);
    return tags.any((tag) => tag.contains('healthy') || tag.contains('low fat'));
  }
  
  static bool _isBalanced(dynamic recipe) {
    final calories = recipe['calories'] ?? 0;
    return calories >= 200 && calories <= 500;
  }
  
  static bool _isLowSugar(dynamic recipe) {
    final ingredients = _getIngredientsList(recipe);
    final sugarKeywords = ['sugar', 'asukal', 'honey', 'syrup'];
    return !ingredients.any((ingredient) => 
      sugarKeywords.any((keyword) => ingredient.contains(keyword)));
  }
  
  static bool _isLowSodium(dynamic recipe) {
    final ingredients = _getIngredientsList(recipe);
    final sodiumKeywords = ['salt', 'asin', 'patis', 'toyo', 'soy sauce'];
    return !ingredients.any((ingredient) => 
      sodiumKeywords.any((keyword) => ingredient.contains(keyword)));
  }
  
  // Dietary restriction helpers
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
