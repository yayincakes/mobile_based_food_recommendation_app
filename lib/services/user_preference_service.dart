import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceService {
  // Get user health conditions
  static Future<List<String>> getUserHealthConditions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final conditionsJson = prefs.getString('healthConditions');
      if (conditionsJson != null) {
        final conditions = List<String>.from(json.decode(conditionsJson));
        return conditions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  // Get user dietary restrictions
  static Future<List<String>> getUserDietaryRestrictions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final restrictionsJson = prefs.getString('restrictions');
      if (restrictionsJson != null) {
        final restrictions = List<String>.from(json.decode(restrictionsJson));
        return restrictions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  // Get user goal
  static Future<String> getUserGoal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('dietGoal') ?? 'Maintenance';
    } catch (e) {
      return 'Maintenance';
    }
  }
  
  // Get calorie goal
  static Future<int> getCalorieGoal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('calorieGoal') ?? 2000;
    } catch (e) {
      return 2000;
    }
  }
  
  // Get macro targets
  static Future<Map<String, double>> getMacroTargets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final protein = prefs.getDouble('proteinTarget') ?? 0.25;
      final carbs = prefs.getDouble('carbsTarget') ?? 0.50;
      final fat = prefs.getDouble('fatTarget') ?? 0.25;
      
      return {
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
      };
    } catch (e) {
      return {
        'protein': 0.25,
        'carbs': 0.50,
        'fat': 0.25,
      };
    }
  }
  
  // Filter recipes based on user preferences
  static List<Map<String, dynamic>> filterRecipesForUser(
    List<Map<String, dynamic>> recipes, {
    required List<String> healthConditions,
    required List<String> dietaryRestrictions,
    required String goal,
  }) {
    return recipes.where((recipe) {
      // Filter based on health conditions
      if (healthConditions.isNotEmpty && healthConditions.first != 'None') {
        // Add health-based filtering logic here
        // For now, return all recipes
      }
      
      // Filter based on dietary restrictions
      if (dietaryRestrictions.isNotEmpty && dietaryRestrictions.first != 'None') {
        for (final restriction in dietaryRestrictions) {
          if (restriction == 'Vegetarian' && _containsMeat(recipe)) {
            return false;
          }
          if (restriction == 'Vegan' && (_containsMeat(recipe) || _containsDairy(recipe))) {
            return false;
          }
          if (restriction == 'Dairy-free' && _containsDairy(recipe)) {
            return false;
          }
          if (restriction == 'Nut allergy' && _containsNuts(recipe)) {
            return false;
          }
          if (restriction == 'Gluten-free' && _containsGluten(recipe)) {
            return false;
          }
          if (restriction == 'Pork-free' && _containsPork(recipe)) {
            return false;
          }
        }
      }
      
      return true;
    }).toList();
  }
  
  // Helper methods for dietary restrictions
  
  static bool _containsMeat(Map<String, dynamic> recipe) {
    final ingredients = _getIngredientsList(recipe);
    final meatKeywords = ['manok', 'baboy', 'baka', 'karne', 'chicken', 'pork', 'beef', 'meat'];
    return ingredients.any((ingredient) => 
      meatKeywords.any((keyword) => ingredient.toLowerCase().contains(keyword)));
  }
  
  static bool _containsDairy(Map<String, dynamic> recipe) {
    final ingredients = _getIngredientsList(recipe);
    final dairyKeywords = ['gatas', 'milk', 'cheese', 'dairy', 'butter', 'cream'];
    return ingredients.any((ingredient) => 
      dairyKeywords.any((keyword) => ingredient.toLowerCase().contains(keyword)));
  }
  
  static bool _containsNuts(Map<String, dynamic> recipe) {
    final ingredients = _getIngredientsList(recipe);
    final nutKeywords = ['mani', 'nuts', 'peanut', 'almond', 'cashew', 'walnut'];
    return ingredients.any((ingredient) => 
      nutKeywords.any((keyword) => ingredient.toLowerCase().contains(keyword)));
  }
  
  static bool _containsGluten(Map<String, dynamic> recipe) {
    final ingredients = _getIngredientsList(recipe);
    final glutenKeywords = ['wheat', 'flour', 'bread', 'pasta', 'noodles', 'canton'];
    return ingredients.any((ingredient) => 
      glutenKeywords.any((keyword) => ingredient.toLowerCase().contains(keyword)));
  }
  
  static bool _containsPork(Map<String, dynamic> recipe) {
    final ingredients = _getIngredientsList(recipe);
    final porkKeywords = ['baboy', 'pork', 'bacon', 'ham'];
    return ingredients.any((ingredient) => 
      porkKeywords.any((keyword) => ingredient.toLowerCase().contains(keyword)));
  }
  
  static List<String> _getIngredientsList(Map<String, dynamic> recipe) {
    if (recipe['ingredients'] is List) {
      return (recipe['ingredients'] as List)
          .map((e) => e.toString().toLowerCase())
          .toList();
    }
    return [];
  }
}
