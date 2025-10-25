import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceService {
  // Get user dietary restrictions
  static Future<List<String>> getDietaryRestrictions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final restrictionsJson = prefs.getString('restrictions');
      if (restrictionsJson != null) {
        return List<String>.from(json.decode(restrictionsJson));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get user health conditions
  static Future<List<String>> getHealthConditions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final conditionsJson = prefs.getString('healthConditions');
      if (conditionsJson != null) {
        return List<String>.from(json.decode(conditionsJson));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get user allergens (from restrictions)
  static Future<List<String>> getAllergens() async {
    try {
      final restrictions = await getDietaryRestrictions();
      final allergenKeywords = [
        'Nut allergy', 'Dairy-free', 'Gluten-free', 'Shellfish', 'Soy', 'Eggs'
      ];
      
      return restrictions.where((restriction) => 
        allergenKeywords.any((allergen) => 
          restriction.toLowerCase().contains(allergen.toLowerCase())
        )
      ).toList();
    } catch (e) {
      return [];
    }
  }

  // Get user dietary preferences (vegetarian, vegan, etc.)
  static Future<List<String>> getDietaryPreferences() async {
    try {
      final restrictions = await getDietaryRestrictions();
      final preferenceKeywords = [
        'Vegetarian', 'Vegan', 'Pork-free'
      ];
      
      return restrictions.where((restriction) => 
        preferenceKeywords.any((preference) => 
          restriction.toLowerCase().contains(preference.toLowerCase())
        )
      ).toList();
    } catch (e) {
      return [];
    }
  }

  // Check if recipe is suitable for user based on restrictions
  static Future<bool> isRecipeSuitable(Map<String, dynamic> recipe) async {
    try {
      final allergens = await getAllergens();
      final preferences = await getDietaryPreferences();
      final healthConditions = await getHealthConditions();
      
      // Check allergens
      final recipeAllergens = List<String>.from(recipe['allergens'] ?? []);
      for (String allergen in allergens) {
        if (recipeAllergens.any((recipeAllergen) => 
          recipeAllergen.toLowerCase().contains(allergen.toLowerCase())
        )) {
          return false;
        }
      }
      
      // Check dietary preferences
      if (preferences.contains('Vegetarian') || preferences.contains('Vegan')) {
        final ingredients = List<String>.from(recipe['ingredients'] ?? []);
        final meatKeywords = ['manok', 'chicken', 'baboy', 'pork', 'baka', 'beef', 'isda', 'fish'];
        
        if (ingredients.any((ingredient) => 
          meatKeywords.any((meat) => 
            ingredient.toLowerCase().contains(meat)
          )
        )) {
          return false;
        }
      }
      
      // Check health conditions
      if (healthConditions.contains('Diabetes')) {
        // Filter high-carb recipes for diabetes
        final calories = recipe['calories'] ?? 0;
        final carbs = recipe['carbs'] ?? 0;
        if (carbs > 50 || calories > 400) {
          return false;
        }
      }
      
      if (healthConditions.contains('Hypertension')) {
        // Filter high-sodium recipes for hypertension
        final ingredients = List<String>.from(recipe['ingredients'] ?? []);
        final sodiumKeywords = ['toyo', 'soy sauce', 'patis', 'fish sauce', 'bagoong', 'shrimp paste'];
        
        if (ingredients.any((ingredient) => 
          sodiumKeywords.any((sodium) => 
            ingredient.toLowerCase().contains(sodium)
          )
        )) {
          return false;
        }
      }
      
      return true;
    } catch (e) {
      return true; // If error, show all recipes
    }
  }

  // Get recommended recipes based on user profile
  static Future<List<Map<String, dynamic>>> getRecommendedRecipes(
    List<Map<String, dynamic>> allRecipes
  ) async {
    try {
      final suitableRecipes = <Map<String, dynamic>>[];
      
      for (Map<String, dynamic> recipe in allRecipes) {
        if (await isRecipeSuitable(recipe)) {
          suitableRecipes.add(recipe);
        }
      }
      
      return suitableRecipes;
    } catch (e) {
      return allRecipes; // If error, return all recipes
    }
  }
}