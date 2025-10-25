import '../models/recipe.dart';
import '../models/user_profile.dart';
import 'profile_management_service.dart';

class RecommendationService {
  
  // Goal-based nutrition targets
  static const Map<String, Map<String, double>> _goalNutritionTargets = {
    'Weight loss': {
      'calories_per_kg': 25, // Lower calories per kg body weight
      'protein_ratio': 0.25, // Higher protein ratio
      'carbs_ratio': 0.35, // Lower carbs
      'fat_ratio': 0.25, // Moderate fat
    },
    'Weight gain': {
      'calories_per_kg': 35, // Higher calories per kg body weight
      'protein_ratio': 0.20, // High protein for muscle building
      'carbs_ratio': 0.50, // Higher carbs for energy
      'fat_ratio': 0.20, // Moderate fat
    },
    'Muscle gain': {
      'calories_per_kg': 32, // High calories for muscle building
      'protein_ratio': 0.30, // Very high protein
      'carbs_ratio': 0.45, // High carbs for energy
      'fat_ratio': 0.20, // Lower fat
    },
    'Maintenance': {
      'calories_per_kg': 30, // Balanced calories
      'protein_ratio': 0.20, // Moderate protein
      'carbs_ratio': 0.45, // Balanced carbs
      'fat_ratio': 0.25, // Moderate fat
    },
  };

  // Foods to avoid for specific allergies
  static const Map<String, List<String>> _allergyFoods = {
    'Nuts': ['almond', 'walnut', 'cashew', 'pistachio', 'pecan', 'hazelnut', 'peanut'],
    'Dairy': ['milk', 'cheese', 'butter', 'cream', 'yogurt', 'whey', 'lactose'],
    'Gluten': ['wheat', 'barley', 'rye', 'flour', 'bread', 'pasta', 'noodles'],
    'Seafood': ['fish', 'shrimp', 'crab', 'lobster', 'salmon', 'tuna', 'shellfish'],
    'Eggs': ['egg', 'eggs', 'mayonnaise', 'custard', 'meringue'],
    'Soy': ['soy', 'soybean', 'tofu', 'tempeh', 'miso', 'soy sauce'],
    'Sesame': ['sesame', 'tahini', 'sesame oil'],
  };

  // Health condition dietary recommendations
  static const Map<String, Map<String, dynamic>> _healthConditionDiet = {
    'Diabetes': {
      'avoid': ['sugar', 'sweet', 'candy', 'soda', 'juice', 'white rice', 'white bread'],
      'prefer': ['whole grains', 'fiber', 'vegetables', 'lean protein', 'low glycemic'],
      'max_calories_per_meal': 500,
    },
    'Hypertension': {
      'avoid': ['salt', 'sodium', 'processed', 'canned', 'pickled', 'salted'],
      'prefer': ['potassium', 'magnesium', 'fruits', 'vegetables', 'whole grains'],
      'max_sodium_per_meal': 600,
    },
    'CKD': {
      'avoid': ['high protein', 'phosphorus', 'potassium', 'sodium'],
      'prefer': ['low protein', 'vegetables', 'fruits', 'controlled portions'],
      'max_protein_per_meal': 15,
    },
    'Hyperlipidemia': {
      'avoid': ['saturated fat', 'trans fat', 'fried', 'processed meat', 'full fat dairy'],
      'prefer': ['omega 3', 'fiber', 'vegetables', 'lean protein', 'healthy fats'],
      'max_fat_per_meal': 20,
    },
  };

  // Foods that support specific goals
  static const Map<String, List<String>> _goalSupportingFoods = {
    'Weight loss': [
      'vegetables', 'leafy greens', 'lean protein', 'whole grains',
      'fruits', 'legumes', 'fish', 'chicken breast', 'turkey'
    ],
    'Weight gain': [
      'healthy fats', 'nuts', 'avocado', 'olive oil', 'whole grains',
      'lean meats', 'dairy', 'complex carbohydrates'
    ],
    'Muscle gain': [
      'lean protein', 'chicken', 'fish', 'eggs', 'lean beef',
      'dairy', 'legumes', 'quinoa', 'brown rice'
    ],
    'Maintenance': [
      'balanced diet', 'variety', 'whole foods', 'fruits', 'vegetables',
      'lean proteins', 'healthy fats', 'complex carbs'
    ],
  };

  // Get personalized recommendations based on user profile
  static Future<List<Recipe>> getPersonalizedRecommendations({
    required List<Recipe> allRecipes,
    int limit = 10,
  }) async {
    try {
      final userProfile = await _getUserProfile();
      print('RecommendationService - User Profile: $userProfile');
      
      if (userProfile == null) {
        print('No user profile found, using default recommendations');
        return _getDefaultRecommendations(allRecipes, limit);
      }

      print('User preferences: ${userProfile.preferences}');
      print('User goal: ${userProfile.goal}');
      print('User health conditions: ${userProfile.healthConditions.map((c) => c.name).toList()}');
      print('User allergies: ${userProfile.allergies.map((a) => a.name).toList()}');

      // Filter recipes based on allergies and dietary restrictions
      final allergyNames = userProfile.allergies.map((allergy) => allergy.name).toList();
      final allergyFilteredRecipes = _filterByAllergies(allRecipes, allergyNames);
      print('After allergy filtering: ${allergyFilteredRecipes.length} recipes');
      
      // Filter by health conditions
      final healthFilteredRecipes = _filterByHealthConditions(allergyFilteredRecipes, userProfile);
      print('After health filtering: ${healthFilteredRecipes.length} recipes');
      
      // Filter by user plan preferences
      final planFilteredRecipes = _filterByUserPlan(healthFilteredRecipes, userProfile);
      print('After plan filtering: ${planFilteredRecipes.length} recipes');
      
      // Filter by plan mode (auto vs manual)
      final modeFilteredRecipes = _filterByPlanMode(planFilteredRecipes, userProfile);
      print('After mode filtering: ${modeFilteredRecipes.length} recipes');
      
      // Score recipes based on goals and preferences
      final scoredRecipes = _scoreRecipesForGoals(modeFilteredRecipes, userProfile);
      print('Scored recipes: ${scoredRecipes.length}');
      
      // Sort by score and return top recommendations
      scoredRecipes.sort((a, b) => b.score.compareTo(a.score));
      
      final finalRecommendations = scoredRecipes.take(limit).map((r) => r.recipe).toList();
      print('Final recommendations: ${finalRecommendations.length}');
      for (var recipe in finalRecommendations.take(3)) {
        print('Final recommendation: ${recipe.name}');
      }
      
      return finalRecommendations;
    } catch (e) {
      print('Error getting personalized recommendations: $e');
      return _getDefaultRecommendations(allRecipes, limit);
    }
  }

  // Filter recipes based on user allergies
  static List<Recipe> _filterByAllergies(List<Recipe> recipes, List<String> allergies) {
    if (allergies.isEmpty) return recipes;
    
    return recipes.where((recipe) {
      final recipeText = '${recipe.name} ${recipe.description} ${recipe.instructions}'.toLowerCase();
      
      for (final allergy in allergies) {
        final allergyFoods = _allergyFoods[allergy] ?? [];
        for (final food in allergyFoods) {
          if (recipeText.contains(food.toLowerCase())) {
            return false; // Recipe contains allergen
          }
        }
      }
      return true; // Recipe is safe
    }).toList();
  }

  // Filter recipes based on health conditions
  static List<Recipe> _filterByHealthConditions(List<Recipe> recipes, UserProfile userProfile) {
    final healthConditions = userProfile.healthConditions.map((condition) => condition.name).toList();
    if (healthConditions.isEmpty) return recipes;
    
    return recipes.where((recipe) {
      final recipeText = '${recipe.name} ${recipe.description} ${recipe.instructions}'.toLowerCase();
      
      for (final condition in healthConditions) {
        final dietInfo = _healthConditionDiet[condition];
        if (dietInfo == null) continue;
        
        // Check if recipe contains foods to avoid
        final avoidFoods = dietInfo['avoid'] as List<String>? ?? [];
        for (final food in avoidFoods) {
          if (recipeText.contains(food.toLowerCase())) {
            return false; // Recipe contains food to avoid for this condition
          }
        }
        
        // Check calorie limits for specific conditions
        if (condition == 'Diabetes') {
          final maxCalories = dietInfo['max_calories_per_meal'] as int? ?? 500;
          if (recipe.caloriesPerServing > maxCalories) {
            return false; // Too many calories for diabetes
          }
        }
        
        // Check protein limits for CKD
        if (condition == 'CKD') {
          final maxProtein = dietInfo['max_protein_per_meal'] as int? ?? 15;
          if (recipe.proteinPerServing > maxProtein) {
            return false; // Too much protein for CKD
          }
        }
      }
      return true; // Recipe is safe for all conditions
    }).toList();
  }

  // Filter recipes based on user plan preferences
  static List<Recipe> _filterByUserPlan(List<Recipe> recipes, UserProfile userProfile) {
    final preferences = userProfile.preferences;
    print('Filtering by user plan preferences: $preferences');
    
    if (preferences.isEmpty) {
      print('No preferences found, returning all recipes');
      return recipes;
    }
    
    final filteredRecipes = recipes.where((recipe) {
      final recipeText = '${recipe.name} ${recipe.description} ${recipe.instructions}'.toLowerCase();
      
      // Filter based on meal preferences
      for (final preference in preferences) {
        switch (preference) {
          case 'Home-cooked meals':
            if (recipeText.contains('homemade') || recipeText.contains('home-cooked')) {
              print('Recipe ${recipe.name} matches Home-cooked meals');
            }
            break;
          case 'Quick & easy recipes':
            if (recipe.prepTime <= 15 && recipe.difficulty == 'Easy') {
              print('Recipe ${recipe.name} matches Quick & easy recipes');
            }
            break;
          case 'Meal prep friendly':
            if (recipeText.contains('meal prep') || recipeText.contains('batch') || 
                recipeText.contains('freezer') || recipeText.contains('storage')) {
              print('Recipe ${recipe.name} matches Meal prep friendly');
            }
            break;
          case 'Budget-friendly':
            if (recipeText.contains('budget') || recipeText.contains('cheap') || 
                recipeText.contains('affordable') || recipeText.contains('simple ingredients')) {
              print('Recipe ${recipe.name} matches Budget-friendly');
            }
            break;
          case 'High protein':
            if (recipe.proteinPerServing >= 20) {
              print('Recipe ${recipe.name} matches High protein (${recipe.proteinPerServing}g)');
            }
            break;
          case 'Traditional Filipino':
            if (recipe.isFilipinoDish) {
              print('Recipe ${recipe.name} matches Traditional Filipino');
            }
            break;
          case 'International cuisine':
            if (!recipe.isFilipinoDish) {
              print('Recipe ${recipe.name} matches International cuisine');
            }
            break;
          case 'Vegetarian':
            if (recipeText.contains('vegetarian') || recipeText.contains('vegan') ||
                recipeText.contains('plant-based')) {
              print('Recipe ${recipe.name} matches Vegetarian');
            }
            break;
          case 'Low-carb':
            if (recipe.carbsPerServing <= 20) {
              print('Recipe ${recipe.name} matches Low-carb (${recipe.carbsPerServing}g)');
            }
            break;
          case 'Gluten-free':
            if (recipeText.contains('gluten-free') || !recipeText.contains('wheat') ||
                !recipeText.contains('flour') || !recipeText.contains('bread')) {
              print('Recipe ${recipe.name} matches Gluten-free');
            }
            break;
          case 'Restaurant-style':
            if (recipeText.contains('restaurant') || recipeText.contains('chef') ||
                recipe.difficulty == 'Hard') {
              print('Recipe ${recipe.name} matches Restaurant-style');
            }
            break;
        }
      }
      
      // If no specific preferences match, include the recipe
      return true; // Changed from matchesPreference to true to be more inclusive
    }).toList();
    
    print('Plan filtering result: ${filteredRecipes.length} recipes');
    return filteredRecipes;
  }

  // Filter recipes based on plan mode (auto vs manual)
  static List<Recipe> _filterByPlanMode(List<Recipe> recipes, UserProfile userProfile) {
    // Check if user has meal plans that indicate their plan mode
    final mealPlans = userProfile.mealPlans;
    print('User meal plans: ${mealPlans.length}');
    
    if (mealPlans.isEmpty) {
      print('No meal plans found, returning all recipes');
      return recipes;
    }
    
    // Get the active meal plan
    final activePlan = mealPlans.firstWhere(
      (plan) => plan.isActive,
      orElse: () => mealPlans.first,
    );
    
    print('Active plan: ${activePlan.name} - ${activePlan.description}');
    
    // Filter based on plan description or name
    final planDescription = '${activePlan.name} ${activePlan.description}'.toLowerCase();
    
    if (planDescription.contains('custom') || planDescription.contains('manual')) {
      print('Filtering for manual plan mode');
      // For manual plans, prefer recipes that are more customizable
      final filteredRecipes = recipes.where((recipe) {
        final recipeText = '${recipe.name} ${recipe.description}'.toLowerCase();
        return recipeText.contains('customizable') || 
               recipeText.contains('adjustable') ||
               recipe.difficulty == 'Easy' || // Easy to modify
               recipeText.contains('simple ingredients');
      }).toList();
      print('Manual mode filtering result: ${filteredRecipes.length} recipes');
      return filteredRecipes;
    } else {
      print('Filtering for auto plan mode');
      // For auto plans, prefer AI-recommended recipes
      final filteredRecipes = recipes.where((recipe) {
        final recipeText = '${recipe.name} ${recipe.description}'.toLowerCase();
        return recipeText.contains('recommended') ||
               recipeText.contains('personalized') ||
               recipe.isFilipinoDish || // Default to Filipino for auto plans
               recipe.rating >= 4.0; // High-rated recipes
      }).toList();
      print('Auto mode filtering result: ${filteredRecipes.length} recipes');
      return filteredRecipes;
    }
  }

  // Score recipes based on user goals and preferences
  static List<_ScoredRecipe> _scoreRecipesForGoals(List<Recipe> recipes, UserProfile userProfile) {
    final goal = userProfile.goal;
    final nutritionTargets = _goalNutritionTargets[goal] ?? _goalNutritionTargets['Maintenance']!;
    final supportingFoods = _goalSupportingFoods[goal] ?? [];
    
    return recipes.map((recipe) {
      double score = 0.0;
      
      // Base score
      score += 50.0;
      
      // Nutrition alignment score
      score += _calculateNutritionScore(recipe, nutritionTargets, userProfile);
      
      // Goal-supporting ingredients score
      score += _calculateIngredientScore(recipe, supportingFoods);
      
      // Calorie appropriateness score
      score += _calculateCalorieScore(recipe, userProfile);
      
      // User preference matching
      score += _calculatePreferenceScore(recipe, userProfile);
      
      // Health condition supporting score
      score += _calculateHealthConditionScore(recipe, userProfile);
      
      // Filipino dish preference (if user prefers Filipino food)
      if (recipe.isFilipinoDish && userProfile.preferences.contains('Traditional Filipino')) {
        score += 20.0;
      }
      
      // Difficulty appropriateness
      score += _calculateDifficultyScore(recipe, userProfile);
      
      return _ScoredRecipe(recipe: recipe, score: score);
    }).toList();
  }

  // Calculate nutrition alignment score
  static double _calculateNutritionScore(Recipe recipe, Map<String, double> targets, UserProfile userProfile) {
    final userWeight = userProfile.weight ?? 70.0; // Default weight if null
    final targetCalories = userWeight * targets['calories_per_kg']!;
    final recipeCalories = recipe.caloriesPerServing;
    
    // Score based on calorie appropriateness
    final calorieDiff = (recipeCalories - targetCalories).abs();
    final calorieScore = 30.0 - (calorieDiff / targetCalories * 30.0);
    
    // Protein ratio score
    final proteinRatio = recipe.proteinPerServing / recipeCalories * 4; // 4 cal per gram protein
    final targetProteinRatio = targets['protein_ratio']!;
    final proteinDiff = (proteinRatio - targetProteinRatio).abs();
    final proteinScore = 20.0 - (proteinDiff * 100);
    
    return (calorieScore + proteinScore).clamp(0.0, 50.0);
  }

  // Calculate ingredient support score
  static double _calculateIngredientScore(Recipe recipe, List<String> supportingFoods) {
    final recipeText = '${recipe.name} ${recipe.description} ${recipe.instructions}'.toLowerCase();
    
    double score = 0.0;
    for (final food in supportingFoods) {
      if (recipeText.contains(food.toLowerCase())) {
        score += 5.0;
      }
    }
    
    return score.clamp(0.0, 30.0);
  }

  // Calculate calorie appropriateness score
  static double _calculateCalorieScore(Recipe recipe, UserProfile userProfile) {
    final goal = userProfile.goal;
    final calories = recipe.caloriesPerServing;
    
    switch (goal) {
      case 'Weight loss':
        return calories <= 400 ? 20.0 : (calories <= 600 ? 10.0 : 0.0);
      case 'Weight gain':
        return calories >= 500 ? 20.0 : (calories >= 300 ? 10.0 : 0.0);
      case 'Muscle gain':
        return calories >= 400 ? 20.0 : (calories >= 300 ? 10.0 : 0.0);
      case 'Maintenance':
        return calories >= 300 && calories <= 500 ? 20.0 : 10.0;
      default:
        return 10.0;
    }
  }

  // Calculate difficulty appropriateness score
  static double _calculateDifficultyScore(Recipe recipe, UserProfile userProfile) {
    final userExperience = userProfile.preferences.contains('Beginner') ? 'Easy' : 'Medium';
    final recipeDifficulty = recipe.difficulty;
    
    if (userExperience == recipeDifficulty) return 10.0;
    if (userExperience == 'Easy' && recipeDifficulty == 'Medium') return 5.0;
    if (userExperience == 'Medium' && recipeDifficulty == 'Easy') return 5.0;
    return 0.0;
  }

  // Calculate user preference matching score
  static double _calculatePreferenceScore(Recipe recipe, UserProfile userProfile) {
    double score = 0.0;
    final recipeText = '${recipe.name} ${recipe.description} ${recipe.instructions}'.toLowerCase();
    
    for (final preference in userProfile.preferences) {
      switch (preference) {
        case 'Home-cooked meals':
          if (recipeText.contains('homemade') || recipeText.contains('home-cooked')) {
            score += 15.0;
          }
          break;
        case 'Quick & easy recipes':
          if (recipe.prepTime <= 15 && recipe.difficulty == 'Easy') {
            score += 20.0;
          } else if (recipe.prepTime <= 30 && recipe.difficulty == 'Easy') {
            score += 10.0;
          }
          break;
        case 'Meal prep friendly':
          if (recipeText.contains('meal prep') || recipeText.contains('batch') ||
              recipeText.contains('freezer') || recipeText.contains('storage')) {
            score += 15.0;
          }
          break;
        case 'Budget-friendly':
          if (recipeText.contains('budget') || recipeText.contains('cheap') || 
              recipeText.contains('affordable') || recipeText.contains('simple ingredients')) {
            score += 15.0;
          }
          break;
        case 'High protein':
          if (recipe.proteinPerServing >= 25) {
            score += 20.0;
          } else if (recipe.proteinPerServing >= 15) {
            score += 10.0;
          }
          break;
        case 'Traditional Filipino':
          if (recipe.isFilipinoDish) {
            score += 20.0;
          }
          break;
        case 'International cuisine':
          if (!recipe.isFilipinoDish) {
            score += 15.0;
          }
          break;
        case 'Vegetarian':
          if (recipeText.contains('vegetarian') || recipeText.contains('vegan') ||
              recipeText.contains('plant-based')) {
            score += 15.0;
          }
          break;
        case 'Low-carb':
          if (recipe.carbsPerServing <= 15) {
            score += 20.0;
          } else if (recipe.carbsPerServing <= 25) {
            score += 10.0;
          }
          break;
        case 'Gluten-free':
          if (recipeText.contains('gluten-free') || (!recipeText.contains('wheat') &&
              !recipeText.contains('flour') && !recipeText.contains('bread'))) {
            score += 15.0;
          }
          break;
        case 'Restaurant-style':
          if (recipeText.contains('restaurant') || recipeText.contains('chef') ||
              recipe.difficulty == 'Hard') {
            score += 10.0;
          }
          break;
      }
    }
    
    return score.clamp(0.0, 60.0);
  }

  // Calculate health condition supporting score
  static double _calculateHealthConditionScore(Recipe recipe, UserProfile userProfile) {
    double score = 0.0;
    final recipeText = '${recipe.name} ${recipe.description} ${recipe.instructions}'.toLowerCase();
    final healthConditions = userProfile.healthConditions.map((condition) => condition.name).toList();
    
    for (final condition in healthConditions) {
      final dietInfo = _healthConditionDiet[condition];
      if (dietInfo == null) continue;
      
      // Check for preferred foods
      final preferFoods = dietInfo['prefer'] as List<String>? ?? [];
      for (final food in preferFoods) {
        if (recipeText.contains(food.toLowerCase())) {
          score += 8.0;
        }
      }
    }
    
    return score.clamp(0.0, 40.0);
  }

  // Get default recommendations when no user profile
  static List<Recipe> _getDefaultRecommendations(List<Recipe> recipes, int limit) {
    return recipes.take(limit).toList();
  }

  // Get user profile from storage
  static Future<UserProfile?> _getUserProfile() async {
    try {
      return await ProfileManagementService.getProfile();
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }

  // Get meal plan recommendations for a specific day
  static Future<Map<String, List<Recipe>>> getMealPlanRecommendations({
    required List<Recipe> allRecipes,
    required String mealType, // 'breakfast', 'lunch', 'dinner', 'snack'
  }) async {
    try {
      final userProfile = await _getUserProfile();
      if (userProfile == null) {
        return {mealType: _getDefaultRecommendations(allRecipes, 5)};
      }

      // Filter by allergies first
      final allergyNames = userProfile.allergies.map((allergy) => allergy.name).toList();
      final allergyFilteredRecipes = _filterByAllergies(allRecipes, allergyNames);
      
      // Filter by meal type appropriateness
      final mealTypeRecipes = _filterByMealType(allergyFilteredRecipes, mealType);
      
      // Get personalized recommendations
      final recommendations = await getPersonalizedRecommendations(
        allRecipes: mealTypeRecipes,
        limit: 5,
      );
      
      return {mealType: recommendations};
    } catch (e) {
      print('Error getting meal plan recommendations: $e');
      return {mealType: _getDefaultRecommendations(allRecipes, 5)};
    }
  }

  // Filter recipes by meal type appropriateness
  static List<Recipe> _filterByMealType(List<Recipe> recipes, String mealType) {
    return recipes.where((recipe) {
      final recipeText = '${recipe.name} ${recipe.description}'.toLowerCase();
      
      switch (mealType) {
        case 'breakfast':
          return recipeText.contains('breakfast') || 
                 recipeText.contains('morning') ||
                 recipeText.contains('cereal') ||
                 recipe.caloriesPerServing <= 400;
        case 'lunch':
          return recipeText.contains('lunch') ||
                 (recipe.caloriesPerServing >= 300 && recipe.caloriesPerServing <= 600);
        case 'dinner':
          return recipeText.contains('dinner') ||
                 recipe.caloriesPerServing >= 400;
        case 'snack':
          return recipeText.contains('snack') ||
                 recipe.caloriesPerServing <= 200;
        default:
          return true;
      }
    }).toList();
  }

  // Get nutrition summary for recommended recipes
  static Map<String, dynamic> getNutritionSummary(List<Recipe> recipes) {
    if (recipes.isEmpty) {
      return {
        'total_calories': 0,
        'total_protein': 0.0,
        'total_carbs': 0.0,
        'total_fat': 0.0,
        'avg_calories': 0.0,
      };
    }

    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final recipe in recipes) {
      totalCalories += recipe.caloriesPerServing;
      totalProtein += recipe.proteinPerServing;
      totalCarbs += recipe.carbsPerServing;
      totalFat += recipe.fatPerServing;
    }

    return {
      'total_calories': totalCalories.round(),
      'total_protein': totalProtein,
      'total_carbs': totalCarbs,
      'total_fat': totalFat,
      'avg_calories': (totalCalories / recipes.length).round(),
    };
  }

  // Get personalized daily meal plan based on user profile
  static Future<Map<String, dynamic>> getPersonalizedDailyMealPlan({
    required List<Recipe> allRecipes,
    required String mealType,
  }) async {
    try {
      final userProfile = await _getUserProfile();
      if (userProfile == null) {
        return _getDefaultMealPlan(mealType);
      }

      // Get meal frequency from user preferences or default to 3 meals
      final mealFrequency = _getMealFrequency(userProfile);
      
      // Calculate target calories per meal based on user's goal and weight
      final targetCaloriesPerMeal = _calculateTargetCaloriesPerMeal(userProfile, mealFrequency);
      
      // Get personalized recommendations for this meal type
      final recommendations = await getPersonalizedRecommendations(
        allRecipes: allRecipes,
        limit: 5,
      );
      
      // Filter by meal type and calorie appropriateness
      final mealTypeRecipes = _filterByMealType(recommendations, mealType);
      final calorieAppropriateRecipes = _filterByCalorieRange(mealTypeRecipes, targetCaloriesPerMeal);
      
      // Select the best recipe for this meal
      final selectedRecipe = calorieAppropriateRecipes.isNotEmpty 
          ? calorieAppropriateRecipes.first 
          : mealTypeRecipes.isNotEmpty 
              ? mealTypeRecipes.first 
              : recommendations.isNotEmpty 
                  ? recommendations.first 
                  : null;
      
      if (selectedRecipe == null) {
        return _getDefaultMealPlan(mealType);
      }
      
      return {
        'name': selectedRecipe.name,
        'description': selectedRecipe.description,
        'calories': selectedRecipe.caloriesPerServing,
        'protein': selectedRecipe.proteinPerServing,
        'carbs': selectedRecipe.carbsPerServing,
        'fat': selectedRecipe.fatPerServing,
        'isRecommended': true,
        'isPersonalized': true,
        'prepTime': selectedRecipe.prepTime,
        'cookTime': selectedRecipe.cookTime,
        'difficulty': selectedRecipe.difficulty,
        'category': selectedRecipe.category,
        'isFilipinoDish': selectedRecipe.isFilipinoDish,
      };
    } catch (e) {
      print('Error getting personalized meal plan: $e');
      return _getDefaultMealPlan(mealType);
    }
  }

  // Get meal frequency from user profile
  static int _getMealFrequency(UserProfile userProfile) {
    // Check if user has meal preferences that indicate frequency
    if (userProfile.preferences.contains('Small frequent meals')) {
      return 6; // 5-6 meals
    } else if (userProfile.preferences.contains('Intermittent fasting')) {
      return 2; // 2 meals
    } else {
      return 3; // Default 3 meals
    }
  }

  // Calculate target calories per meal
  static int _calculateTargetCaloriesPerMeal(UserProfile userProfile, int mealFrequency) {
    final userWeight = userProfile.weight ?? 70.0;
    final goal = userProfile.goal;
    
    // Base calories per kg based on goal
    double caloriesPerKg;
    switch (goal) {
      case 'Weight loss':
        caloriesPerKg = 25.0;
        break;
      case 'Weight gain':
        caloriesPerKg = 35.0;
        break;
      case 'Muscle gain':
        caloriesPerKg = 32.0;
        break;
      default:
        caloriesPerKg = 30.0;
    }
    
    final totalDailyCalories = userWeight * caloriesPerKg;
    return (totalDailyCalories / mealFrequency).round();
  }

  // Filter recipes by calorie range
  static List<Recipe> _filterByCalorieRange(List<Recipe> recipes, int targetCalories) {
    final minCalories = (targetCalories * 0.7).round(); // 70% of target
    final maxCalories = (targetCalories * 1.3).round(); // 130% of target
    
    return recipes.where((recipe) {
      return recipe.caloriesPerServing >= minCalories && recipe.caloriesPerServing <= maxCalories;
    }).toList();
  }

  // Get default meal plan when no personalization is available
  static Map<String, dynamic> _getDefaultMealPlan(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return {
          'name': 'Oatmeal with Fruits',
          'description': 'Healthy breakfast with whole grains and fresh fruits',
          'calories': 300,
          'protein': 10,
          'carbs': 50,
          'fat': 8,
          'isRecommended': false,
          'isPersonalized': false,
        };
      case 'lunch':
        return {
          'name': 'Grilled Chicken Salad',
          'description': 'Light and nutritious lunch option',
          'calories': 400,
          'protein': 30,
          'carbs': 25,
          'fat': 15,
          'isRecommended': false,
          'isPersonalized': false,
        };
      case 'dinner':
        return {
          'name': 'Baked Salmon with Vegetables',
          'description': 'Balanced dinner with lean protein and vegetables',
          'calories': 450,
          'protein': 35,
          'carbs': 30,
          'fat': 20,
          'isRecommended': false,
          'isPersonalized': false,
        };
      case 'snack':
        return {
          'name': 'Greek Yogurt with Berries',
          'description': 'Healthy snack with protein and antioxidants',
          'calories': 150,
          'protein': 12,
          'carbs': 20,
          'fat': 3,
          'isRecommended': false,
          'isPersonalized': false,
        };
      default:
        return {
          'name': 'Healthy Meal',
          'description': 'Balanced meal option',
          'calories': 350,
          'protein': 20,
          'carbs': 35,
          'fat': 12,
          'isRecommended': false,
          'isPersonalized': false,
        };
    }
  }
}

// Helper class for scoring recipes
class _ScoredRecipe {
  final Recipe recipe;
  final double score;
  
  _ScoredRecipe({required this.recipe, required this.score});
}
