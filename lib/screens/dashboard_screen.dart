import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/recommendation_service.dart';
import '../services/profile_management_service.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';
import '../models/user_profile.dart';
import 'recipe_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTab = 0; // 0=weekly, 1=daily
  DateTime selectedDate = DateTime.now();
  final Color darkGreen = const Color(0xFF006400);
  
  // Personalized recommendations
  UserProfile? _userProfile;
  List<Recipe> _recommendedRecipes = [];
  
  // Cached meal plan to prevent regeneration
  Map<int, Map<String, dynamic>>? _cachedMealPlan;
  
  // Cache key to ensure consistency
  String? _lastCacheKey;
  
  @override
  void initState() {
    super.initState();
    _loadPersonalizedRecommendations();
    _testProfileCreation();
  }
  
  // Test function to create a sample profile for debugging
  Future<void> _testProfileCreation() async {
    try {
      // Check if profile exists
      final existingProfile = await ProfileManagementService.getProfile();
      if (existingProfile == null) {
        print('No existing profile found, creating test profile...');
        
        // Create a test profile
        final testProfile = UserProfile(
          name: 'Test User',
          email: 'test@example.com',
          height: 170.0,
          weight: 70.0,
          gender: 'Male',
          birthDate: DateTime.now().subtract(const Duration(days: 25 * 365)),
          activityLevel: 'Moderately active',
          dietaryGoals: [],
          healthConditions: [],
          allergies: [],
          mealPlans: [
            MealPlan(
              id: 'test-plan-1',
              name: 'Auto Plan',
              description: 'AI-recommended personalized plan',
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 30)),
              isActive: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ],
          preferences: ['Traditional Filipino', 'High protein', 'Quick & easy recipes'],
          goal: 'Weight Loss',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await ProfileManagementService.saveProfile(testProfile);
        print('Test profile created successfully');
        
        // Reload recommendations with the new profile
        await _loadPersonalizedRecommendations();
        setState(() {});
      } else {
        print('Existing profile found: ${existingProfile.name}');
      }
    } catch (e) {
      print('Error in test profile creation: $e');
    }
  }

  // Get day of week (0=Mon, 6=Sun)
  int get currentDayOfWeek => (selectedDate.weekday - 1) % 7;
  
  // Get personalized weekly meal plan
  Map<int, Map<String, dynamic>> get weeklyMealPlan {
    // Create cache key based on current state
    final currentCacheKey = _generateCacheKey();
    
    // Return cached plan if available and cache key matches
    if (_cachedMealPlan != null && _lastCacheKey == currentCacheKey) {
      print('Using cached meal plan');
      return _cachedMealPlan!;
    }
    
    // Generate new plan if no cache exists or cache key changed
    Map<int, Map<String, dynamic>> newPlan;
    if (_recommendedRecipes.isNotEmpty) {
      print('Using personalized recommendations for weekly plan');
      newPlan = _generatePersonalizedMealPlan();
    } else if (_userProfile != null) {
      print('No recommendations yet, but user profile exists - generating personalized plan');
      newPlan = _generatePersonalizedMealPlan();
    } else {
      print('No user profile or recommendations, using default plan');
      newPlan = _getDefaultMealPlan();
    }
    
    // Cache the generated plan with current key
    _cachedMealPlan = newPlan;
    _lastCacheKey = currentCacheKey;
    return newPlan;
  }

  // Generate cache key based on current state
  String _generateCacheKey() {
    final recipeCount = _recommendedRecipes.length;
    final userGoal = _userProfile?.goal ?? 'default';
    final userPreferences = _userProfile?.preferences.join(',') ?? '';
    return '${recipeCount}_${userGoal}_${userPreferences}';
  }

  // Generate personalized meal plan based on recommendations
  Map<int, Map<String, dynamic>> _generatePersonalizedMealPlan() {
    final Map<int, Map<String, dynamic>> personalizedPlan = {};
    
    // Get meal types based on user's plan preferences
    final mealTypes = _getUserMealTypes();
    print('Generating personalized meal plan with meal types: $mealTypes');
    
    // Get recipes to use (either from recommendations or all recipes)
    List<Recipe> recipesToUse = _recommendedRecipes;
    if (recipesToUse.isEmpty) {
      print('No recommendations available, using all recipes');
      recipesToUse = RecipeService().getAllRecipes();
    }
    
    print('Using ${recipesToUse.length} recipes for meal plan generation');
    
    // Create a map to track recipe indices for each meal type to ensure cycling
    final Map<String, int> recipeIndexPerMealType = {};
    
    // Initialize tracking for each meal type
    for (String mealType in mealTypes) {
      recipeIndexPerMealType[mealType] = 0;
    }
    
    // Pre-shuffle recipes once for consistent results
    final shuffledRecipes = List<Recipe>.from(recipesToUse);
    shuffledRecipes.shuffle();
    
    for (int day = 0; day < 7; day++) {
      final dayMeals = <String, dynamic>{};
      // Track recipes used in this specific day to prevent duplication
      final Set<int> usedRecipeIdsToday = {};
      
      for (String mealType in mealTypes) {
        // Get recommendations for this meal type
        final mealRecipes = _getMealTypeRecommendations(mealType, shuffledRecipes);
        
        if (mealRecipes.isNotEmpty) {
          // Find recipes not used today
          final availableRecipes = mealRecipes.where((recipe) => 
            !usedRecipeIdsToday.contains(recipe.id)).toList();
          
          Recipe selectedRecipe;
          if (availableRecipes.isNotEmpty) {
            // Use cycling index to select different recipes each day
            // Add day offset to ensure different recipes each day
            final dayOffset = day * 2; // Different offset for each day
            final currentIndex = (recipeIndexPerMealType[mealType]! + dayOffset) % availableRecipes.length;
            selectedRecipe = availableRecipes[currentIndex];
            recipeIndexPerMealType[mealType] = currentIndex + 1;
            usedRecipeIdsToday.add(selectedRecipe.id);
            print('Day $day, $mealType: Selected "${selectedRecipe.name}" (Index: $currentIndex, Available: ${availableRecipes.length})');
          } else {
            // If all recipes are used today, use the first one
            selectedRecipe = mealRecipes.first;
            usedRecipeIdsToday.add(selectedRecipe.id);
            print('Day $day, $mealType: Using first recipe "${selectedRecipe.name}" (all used today)');
          }
          
          dayMeals[mealType] = {
            'name': selectedRecipe.name,
            'calories': selectedRecipe.caloriesPerServing,
            'protein': selectedRecipe.proteinPerServing,
            'carbs': selectedRecipe.carbsPerServing,
            'fat': selectedRecipe.fatPerServing,
            'description': selectedRecipe.description,
            'isRecommended': true,
            'isPersonalized': true,
            'prepTime': selectedRecipe.prepTime,
            'cookTime': selectedRecipe.cookTime,
            'difficulty': selectedRecipe.difficulty,
            'category': selectedRecipe.category,
            'isFilipinoDish': selectedRecipe.isFilipinoDish,
          };
          print('Day $day, $mealType: ${selectedRecipe.name} (Index: ${recipeIndexPerMealType[mealType]! - 1})');
        } else {
          // Fallback to default meal
          dayMeals[mealType] = _getDefaultMeal(mealType);
          print('Day $day, $mealType: Using default meal');
        }
      }
      
      personalizedPlan[day] = dayMeals;
    }
    
    return personalizedPlan;
  }

  // Get user's meal types based on their plan preferences
  List<String> _getUserMealTypes() {
    if (_userProfile == null) {
      print('No user profile, using default meal types');
      return ['breakfast', 'lunch', 'dinner', 'snack'];
    }
    
    // Check if user has meal preferences that indicate frequency
    final preferences = _userProfile!.preferences;
    print('User preferences for meal types: $preferences');
    
    // Check for specific meal frequency preferences
    if (preferences.contains('Small frequent meals')) {
      print('Using frequent meals plan');
      return ['breakfast', 'mid-morning snack', 'lunch', 'afternoon snack', 'dinner', 'evening snack'];
    } else if (preferences.contains('Intermittent fasting')) {
      print('Using intermittent fasting plan');
      return ['lunch', 'dinner'];
    } else if (preferences.contains('Traditional 3 meals')) {
      print('Using traditional 3 meals plan');
      return ['breakfast', 'lunch', 'dinner'];
    } else if (preferences.contains('2 meals per day')) {
      print('Using 2 meals plan');
      return ['lunch', 'dinner'];
    } else if (preferences.contains('5 meals per day')) {
      print('Using 5 meals plan');
      return ['breakfast', 'mid-morning snack', 'lunch', 'afternoon snack', 'dinner'];
    } else if (preferences.contains('6 meals per day')) {
      print('Using 6 meals plan');
      return ['breakfast', 'mid-morning snack', 'lunch', 'afternoon snack', 'dinner', 'evening snack'];
    } else {
      // Try to infer from other preferences
      if (preferences.contains('Weight loss') && !preferences.contains('Muscle gain')) {
        print('Inferring 3 meals for weight loss');
        return ['breakfast', 'lunch', 'dinner'];
      } else if (preferences.contains('Muscle gain') || preferences.contains('High protein')) {
        print('Inferring 5 meals for muscle gain');
        return ['breakfast', 'mid-morning snack', 'lunch', 'afternoon snack', 'dinner'];
      } else {
        print('Using default 4 meals plan');
        // Default to 4 meals (3 meals + 1 snack)
        return ['breakfast', 'lunch', 'dinner', 'snack'];
      }
    }
  }

  // Get user plan type for display
  String _getUserPlanType() {
    if (_userProfile == null) return 'Default Plan';
    
    final preferences = _userProfile!.preferences;
    
    if (preferences.contains('Small frequent meals')) {
      return 'Frequent Meals';
    } else if (preferences.contains('Intermittent fasting')) {
      return 'IF Plan';
    } else if (preferences.contains('Traditional 3 meals')) {
      return '3-Meal Plan';
    } else if (preferences.contains('High protein')) {
      return 'High Protein';
    } else if (preferences.contains('Traditional Filipino')) {
      return 'Filipino Focus';
    } else if (preferences.contains('Quick & easy recipes')) {
      return 'Quick & Easy';
    } else {
      return 'Personalized';
    }
  }

  // Get recommendations for specific meal type based on user preferences
  List<Recipe> _getMealTypeRecommendations(String mealType, [List<Recipe>? recipes]) {
    final recipesToUse = recipes ?? _recommendedRecipes;
    
    final filteredRecipes = recipesToUse.where((recipe) {
      final recipeText = '${recipe.name} ${recipe.description} ${recipe.category}'.toLowerCase();
      
      // Apply user preference filtering first
      if (!_matchesUserPreferences(recipe)) {
        return false;
      }
      
      // Apply meal-specific filtering
      switch (mealType) {
        case 'breakfast':
          return _isBreakfastAppropriate(recipe, recipeText);
        case 'lunch':
          return _isLunchAppropriate(recipe, recipeText);
        case 'dinner':
          return _isDinnerAppropriate(recipe, recipeText);
        case 'snack':
        case 'mid-morning snack':
        case 'afternoon snack':
        case 'evening snack':
          return _isSnackAppropriate(recipe, recipeText);
        default:
          return true;
      }
    }).toList();
    
    // Debug logging to see recipe availability
    print('Meal type "$mealType" has ${filteredRecipes.length} available recipes');
    if (filteredRecipes.isNotEmpty) {
      print('Sample recipes for $mealType: ${filteredRecipes.take(3).map((r) => r.name).join(", ")}');
    }
    
    // Return filtered recipes without shuffling to maintain consistency
    return filteredRecipes;
  }

  // Check if recipe matches user preferences
  bool _matchesUserPreferences(Recipe recipe) {
    if (_userProfile == null) return true;
    
    final preferences = _userProfile!.preferences;
    final healthConditions = _userProfile!.healthConditions;
    final allergies = _userProfile!.allergies;
    
    // Check for allergies
    if (allergies.isNotEmpty) {
      for (Allergy allergy in allergies) {
        if (recipe.allergens.any((allergen) => 
            allergen.toLowerCase().contains(allergy.name.toLowerCase()))) {
          return false;
        }
      }
    }
    
    // Check health conditions
    if (healthConditions.any((condition) => condition.name == 'Diabetes') && 
        recipe.caloriesPerServing > 500) {
      return false; // Lower calorie options for diabetes
    }
    
    if (healthConditions.any((condition) => condition.name == 'Hypertension') && 
        (recipe.name.toLowerCase().contains('salty') ||
         recipe.description.toLowerCase().contains('high sodium'))) {
      return false; // Avoid high sodium for hypertension
    }
    
    // Check dietary preferences
    if (preferences.contains('High protein') && 
        recipe.proteinPerServing < 20) {
      return false; // Prefer high protein recipes
    }
    
    if (preferences.contains('Quick & easy recipes') && 
        recipe.prepTime > 30) {
      return false; // Prefer quick recipes
    }
    
    if (preferences.contains('Traditional Filipino') && 
        !recipe.isFilipinoDish) {
      return false; // Prefer Filipino dishes
    }
    
    return true;
  }

  // Check if recipe is appropriate for breakfast
  bool _isBreakfastAppropriate(Recipe recipe, String recipeText) {
    // Filipino breakfast dishes - ONLY these specific dishes
    final filipinoBreakfastKeywords = [
      'tapsilog', 'champorado', 'pandesal', 'lugaw', 'arroz caldo',
      'longsilog', 'bibingka', 'puto', 'kakanin', 'silog',
      'tocilog', 'bangsilog', 'cornsilog', 'spamsilog', 'hotsilog',
      'ginataang mais'
    ];
    
    // General breakfast keywords - ONLY these specific foods
    final breakfastKeywords = [
      'breakfast', 'morning', 'cereal', 'pancake', 'waffle', 'toast',
      'egg', 'scrambled', 'fried', 'boiled', 'oats', 'porridge'
    ];
    
    // STRICT: Must have breakfast keywords AND appropriate calories
    final hasBreakfastKeywords = breakfastKeywords.any((keyword) => 
        recipeText.contains(keyword)) ||
        filipinoBreakfastKeywords.any((keyword) => 
        recipeText.contains(keyword));
    
    // Check calorie range for breakfast (200-500 calories)
    final hasAppropriateCalories = recipe.caloriesPerServing >= 200 && 
                                  recipe.caloriesPerServing <= 500;
    
    // Exclude lunch/dinner keywords
    final excludesOtherMeals = !recipeText.contains('lunch') && 
                              !recipeText.contains('dinner') &&
                              !recipeText.contains('main course') &&
                              !recipeText.contains('adobo') &&
                              !recipeText.contains('sinigang') &&
                              !recipeText.contains('nilaga') &&
                              !recipeText.contains('tinola') &&
                              !recipeText.contains('lechon') &&
                              !recipeText.contains('kare-kare') &&
                              !recipeText.contains('sisig') &&
                              !recipeText.contains('bulalo');
    
    // STRICT: Must have breakfast keywords AND appropriate calories AND exclude other meals
    return hasBreakfastKeywords && hasAppropriateCalories && excludesOtherMeals;
  }

  // Check if recipe is appropriate for lunch
  bool _isLunchAppropriate(Recipe recipe, String recipeText) {
    // Filipino lunch dishes - ONLY these specific dishes
    final filipinoLunchKeywords = [
      'adobo', 'sinigang', 'nilaga', 'tinola', 'afritada', 'kare-kare',
      'lechon', 'pansit', 'munggo', 'laing', 'sisig', 'pinakbet',
      'caldereta', 'curry', 'paksiw', 'ginataang', 'tortang', 'inasal',
      'bulalo', 'dinuguan'
    ];
    
    // General lunch keywords - ONLY these specific foods
    final lunchKeywords = [
      'lunch', 'midday', 'salad', 'sandwich', 'soup', 'stew'
    ];
    
    // Check for lunch keywords
    final hasLunchKeywords = lunchKeywords.any((keyword) => 
        recipeText.contains(keyword)) ||
        filipinoLunchKeywords.any((keyword) => 
        recipeText.contains(keyword));
    
    // Check calorie range for lunch (300-700 calories)
    final hasAppropriateCalories = recipe.caloriesPerServing >= 300 && 
                                  recipe.caloriesPerServing <= 700;
    
    // Exclude breakfast/dinner keywords
    final excludesOtherMeals = !recipeText.contains('breakfast') && 
                              !recipeText.contains('dinner') &&
                              !recipeText.contains('evening') &&
                              !recipeText.contains('tapsilog') &&
                              !recipeText.contains('champorado') &&
                              !recipeText.contains('pandesal') &&
                              !recipeText.contains('lugaw');
    
    // STRICT: Must have lunch keywords AND appropriate calories AND exclude other meals
    return hasLunchKeywords && hasAppropriateCalories && excludesOtherMeals;
  }

  // Check if recipe is appropriate for dinner
  bool _isDinnerAppropriate(Recipe recipe, String recipeText) {
    // Filipino dinner dishes - ONLY these specific dishes
    final filipinoDinnerKeywords = [
      'lechon', 'bangus', 'tilapia', 'fish', 'chicken', 'pork', 'beef',
      'grilled', 'roasted', 'fried', 'crispy', 'caldereta', 'afritada',
      'kare-kare', 'sisig', 'bulalo', 'dinuguan', 'paksiw', 'ginataang'
    ];
    
    // General dinner keywords - ONLY these specific foods
    final dinnerKeywords = [
      'dinner', 'evening', 'main course', 'entree', 'grilled', 'roasted'
    ];
    
    // Check for dinner keywords
    final hasDinnerKeywords = dinnerKeywords.any((keyword) => 
        recipeText.contains(keyword)) ||
        filipinoDinnerKeywords.any((keyword) => 
        recipeText.contains(keyword));
    
    // Check calorie range for dinner (400+ calories)
    final hasAppropriateCalories = recipe.caloriesPerServing >= 400;
    
    // Exclude breakfast/lunch keywords
    final excludesOtherMeals = !recipeText.contains('breakfast') && 
                              !recipeText.contains('lunch') &&
                              !recipeText.contains('morning') &&
                              !recipeText.contains('tapsilog') &&
                              !recipeText.contains('champorado') &&
                              !recipeText.contains('pandesal') &&
                              !recipeText.contains('lugaw') &&
                              !recipeText.contains('adobo') &&
                              !recipeText.contains('sinigang') &&
                              !recipeText.contains('nilaga') &&
                              !recipeText.contains('tinola');
    
    // STRICT: Must have dinner keywords AND appropriate calories AND exclude other meals
    return hasDinnerKeywords && hasAppropriateCalories && excludesOtherMeals;
  }

  // Check if recipe is appropriate for snacks
  bool _isSnackAppropriate(Recipe recipe, String recipeText) {
    // Filipino snack dishes - ONLY these specific dishes
    final filipinoSnackKeywords = [
      'banana', 'turon', 'kamote', 'gulaman', 'mais', 'peanuts',
      'kakanin', 'puto', 'bibingka', 'suman', 'biko', 'sapin-sapin'
    ];
    
    // General snack keywords - ONLY these specific foods
    final snackKeywords = [
      'snack', 'light', 'small', 'finger food', 'appetizer'
    ];
    
    // Check for snack keywords
    final hasSnackKeywords = snackKeywords.any((keyword) => 
        recipeText.contains(keyword)) ||
        filipinoSnackKeywords.any((keyword) => 
        recipeText.contains(keyword));
    
    // Check calorie range for snacks (≤300 calories)
    final hasAppropriateCalories = recipe.caloriesPerServing <= 300;
    
    // Exclude main meal keywords
    final excludesMainMeals = !recipeText.contains('breakfast') && 
                            !recipeText.contains('lunch') &&
                            !recipeText.contains('dinner') &&
                            !recipeText.contains('main course') &&
                            !recipeText.contains('tapsilog') &&
                            !recipeText.contains('champorado') &&
                            !recipeText.contains('pandesal') &&
                            !recipeText.contains('lugaw') &&
                            !recipeText.contains('adobo') &&
                            !recipeText.contains('sinigang') &&
                            !recipeText.contains('nilaga') &&
                            !recipeText.contains('tinola') &&
                            !recipeText.contains('lechon') &&
                            !recipeText.contains('kare-kare') &&
                            !recipeText.contains('sisig') &&
                            !recipeText.contains('bulalo');
    
    // STRICT: Must have snack keywords AND appropriate calories AND exclude main meals
    return hasSnackKeywords && hasAppropriateCalories && excludesMainMeals;
  }

  // Get default meal plan (fallback)
  Map<int, Map<String, dynamic>> _getDefaultMealPlan() {
    return {
      // Monday (0)
      0: {
        'breakfast': {'name': 'Champorado with Tuyo', 'calories': 380, 'protein': 15, 'carbs': 62, 'fat': 9},
        'lunch': {'name': 'Chicken Tinola', 'calories': 420, 'protein': 38, 'carbs': 32, 'fat': 16},
        'dinner': {'name': 'Grilled Bangus with Brown Rice', 'calories': 450, 'protein': 32, 'carbs': 48, 'fat': 12},
        'snack': {'name': 'Banana Cue (1 piece)', 'calories': 180, 'protein': 2, 'carbs': 38, 'fat': 4},
      },
      // Tuesday (1)
      1: {
        'breakfast': {'name': 'Tapsilog', 'calories': 520, 'protein': 28, 'carbs': 58, 'fat': 18},
        'lunch': {'name': 'Sinigang na Baboy', 'calories': 380, 'protein': 25, 'carbs': 35, 'fat': 14},
        'dinner': {'name': 'Pinakbet with Grilled Fish', 'calories': 400, 'protein': 30, 'carbs': 42, 'fat': 10},
        'snack': {'name': 'Kamote (Steamed)', 'calories': 150, 'protein': 3, 'carbs': 32, 'fat': 1},
      },
      // Wednesday (2)
      2: {
        'breakfast': {'name': 'Pandesal with Scrambled Egg', 'calories': 340, 'protein': 18, 'carbs': 44, 'fat': 12},
        'lunch': {'name': 'Chicken Adobo with Rice', 'calories': 480, 'protein': 35, 'carbs': 52, 'fat': 15},
        'dinner': {'name': 'Ginisang Monggo with Fish', 'calories': 420, 'protein': 28, 'carbs': 55, 'fat': 9},
        'snack': {'name': 'Fresh Mango', 'calories': 120, 'protein': 1, 'carbs': 28, 'fat': 1},
      },
      // Thursday (3)
      3: {
        'breakfast': {'name': 'Lugaw with Egg', 'calories': 320, 'protein': 12, 'carbs': 52, 'fat': 8},
        'lunch': {'name': 'Beef Nilaga', 'calories': 450, 'protein': 32, 'carbs': 38, 'fat': 18},
        'dinner': {'name': 'Tortang Talong with Rice', 'calories': 380, 'protein': 16, 'carbs': 54, 'fat': 12},
        'snack': {'name': 'Peanuts (handful)', 'calories': 160, 'protein': 7, 'carbs': 6, 'fat': 14},
      },
      // Friday (4)
      4: {
        'breakfast': {'name': 'Arroz Caldo', 'calories': 350, 'protein': 15, 'carbs': 58, 'fat': 8},
        'lunch': {'name': 'Fish Sinigang', 'calories': 360, 'protein': 28, 'carbs': 36, 'fat': 10},
        'dinner': {'name': 'Chicken Afritada', 'calories': 460, 'protein': 34, 'carbs': 48, 'fat': 14},
        'snack': {'name': 'Turon (1 piece)', 'calories': 200, 'protein': 2, 'carbs': 35, 'fat': 7},
      },
      // Saturday (5)
      5: {
        'breakfast': {'name': 'Longsilog', 'calories': 540, 'protein': 26, 'carbs': 62, 'fat': 20},
        'lunch': {'name': 'Kare-Kare with Bagoong', 'calories': 480, 'protein': 28, 'carbs': 45, 'fat': 22},
        'dinner': {'name': 'Grilled Tilapia with Ensaladang Talong', 'calories': 380, 'protein': 35, 'carbs': 32, 'fat': 12},
        'snack': {'name': 'Mais (Boiled Corn)', 'calories': 140, 'protein': 4, 'carbs': 30, 'fat': 2},
      },
      // Sunday (6)
      6: {
        'breakfast': {'name': 'Bibingka with Salted Egg', 'calories': 420, 'protein': 14, 'carbs': 58, 'fat': 16},
        'lunch': {'name': 'Lechon Kawali with Atchara', 'calories': 520, 'protein': 32, 'carbs': 38, 'fat': 28},
        'dinner': {'name': 'Laing with Grilled Fish', 'calories': 400, 'protein': 26, 'carbs': 44, 'fat': 14},
        'snack': {'name': 'Gulaman', 'calories': 100, 'protein': 0, 'carbs': 25, 'fat': 0},
      },
    };
  }

  // Get default meal for specific meal type
  Map<String, dynamic> _getDefaultMeal(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return {'name': 'Oatmeal with Fruits', 'calories': 300, 'protein': 10, 'carbs': 50, 'fat': 8};
      case 'lunch':
        return {'name': 'Grilled Chicken Salad', 'calories': 400, 'protein': 30, 'carbs': 25, 'fat': 15};
      case 'dinner':
        return {'name': 'Baked Salmon with Vegetables', 'calories': 450, 'protein': 35, 'carbs': 30, 'fat': 20};
      case 'snack':
        return {'name': 'Greek Yogurt with Berries', 'calories': 150, 'protein': 12, 'carbs': 20, 'fat': 3};
      default:
        return {'name': 'Healthy Meal', 'calories': 350, 'protein': 20, 'carbs': 35, 'fat': 12};
    }
  }

  // Daily goals - will be personalized based on user profile
  int get dailyCalorieGoal => _getPersonalizedCalorieGoal();
  int get dailyProteinGoal => _getPersonalizedProteinGoal();
  int get dailyCarbsGoal => _getPersonalizedCarbsGoal();
  int get dailyFatGoal => _getPersonalizedFatGoal();

  // Get current day's meals
  Map<String, dynamic> get todaysMeals {
    final meals = weeklyMealPlan[currentDayOfWeek] ?? {};
    print('Today\'s meals (day $currentDayOfWeek): ${meals.keys.toList()}');
    return meals;
  }

  // Personalized goal calculations based on user profile
  int _getPersonalizedCalorieGoal() {
    if (_userProfile == null) return 1800; // Default goal
    
    final userWeight = _userProfile!.weight ?? 70.0;
    final goal = _userProfile!.goal;
    
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
    
    return (userWeight * caloriesPerKg).round();
  }

  int _getPersonalizedProteinGoal() {
    if (_userProfile == null) return 80; // Default goal
    
    final userWeight = _userProfile!.weight ?? 70.0;
    final goal = _userProfile!.goal;
    
    // Protein per kg based on goal
    double proteinPerKg;
    switch (goal) {
      case 'Weight loss':
        proteinPerKg = 1.6; // Higher protein for weight loss
        break;
      case 'Weight gain':
        proteinPerKg = 1.4;
        break;
      case 'Muscle gain':
        proteinPerKg = 2.0; // Higher protein for muscle gain
        break;
      default:
        proteinPerKg = 1.2;
    }
    
    return (userWeight * proteinPerKg).round();
  }

  int _getPersonalizedCarbsGoal() {
    if (_userProfile == null) return 200; // Default goal
    
    final calorieGoal = dailyCalorieGoal;
    final proteinGoal = dailyProteinGoal;
    final fatGoal = dailyFatGoal;
    
    // Calculate carbs based on remaining calories
    final proteinCalories = proteinGoal * 4;
    final fatCalories = fatGoal * 9;
    final remainingCalories = calorieGoal - proteinCalories - fatCalories;
    
    return (remainingCalories / 4).round(); // 4 calories per gram of carbs
  }

  int _getPersonalizedFatGoal() {
    if (_userProfile == null) return 60; // Default goal
    
    final userWeight = _userProfile!.weight ?? 70.0;
    final goal = _userProfile!.goal;
    
    // Fat per kg based on goal
    double fatPerKg;
    switch (goal) {
      case 'Weight loss':
        fatPerKg = 0.8; // Lower fat for weight loss
        break;
      case 'Weight gain':
        fatPerKg = 1.2; // Higher fat for weight gain
        break;
      case 'Muscle gain':
        fatPerKg = 1.0;
        break;
      default:
        fatPerKg = 1.0;
    }
    
    return (userWeight * fatPerKg).round();
  }

  // Load personalized recommendations
  Future<void> _loadPersonalizedRecommendations() async {
    try {
      // Load user profile
      _userProfile = await ProfileManagementService.getProfile();
      
      // Debug: Print user profile data
      print('User Profile: $_userProfile');
      if (_userProfile != null) {
        print('User Preferences: ${_userProfile!.preferences}');
        print('User Goal: ${_userProfile!.goal}');
        print('User Health Conditions: ${_userProfile!.healthConditions.map((c) => c.name).toList()}');
        print('User Allergies: ${_userProfile!.allergies.map((a) => a.name).toList()}');
      }
      
      // Get sample recipes for recommendations
      final sampleRecipes = RecipeService().getAllRecipes();
      
      if (_userProfile != null && sampleRecipes.isNotEmpty) {
        // Get personalized recommendations based on user profile and plan
        final recommendations = await RecommendationService.getPersonalizedRecommendations(
          allRecipes: sampleRecipes,
          limit: 20,
        );
        
        print('Recommended recipes count: ${recommendations.length}');
        for (var recipe in recommendations.take(5)) {
          print('Recommended: ${recipe.name}');
        }
        
        setState(() {
          _recommendedRecipes = recommendations;
          // Clear cached plan to force regeneration
          _cachedMealPlan = null;
        });
      } else {
        print('No user profile or recipes found, using default');
        setState(() {
          _recommendedRecipes = sampleRecipes.take(10).toList();
          // Clear cached plan to force regeneration
          _cachedMealPlan = null;
        });
      }
    } catch (e) {
      print('Error loading personalized recommendations: $e');
      setState(() {
        _recommendedRecipes = RecipeService().getAllRecipes().take(10).toList();
        // Clear cached plan to force regeneration
        _cachedMealPlan = null;
      });
    }
  }

  
  // Calculate daily totals
  int get totalCalories {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['calories'] as int? ?? 0);
    });
    return total;
  }

  int get totalProtein {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['protein'] as int? ?? 0);
    });
    return total;
  }

  int get totalCarbs {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['carbs'] as int? ?? 0);
    });
    return total;
  }

  int get totalFat {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['fat'] as int? ?? 0);
    });
    return total;
  }

  String get _dailyTip {
    final calLeft = (dailyCalorieGoal - totalCalories);
    final proLeft = (dailyProteinGoal - totalProtein);
    final carbLeft = (dailyCarbsGoal - totalCarbs);
    final fatLeft = (dailyFatGoal - totalFat);

    if (calLeft < -150) return 'You\'re ${calLeft.abs()} kcal over. Choose a lighter meal and add a short walk.';
    if (fatLeft < -10)  return 'Fat is a bit high today. Go for lean protein and veggies next.';
    if (carbLeft < -25) return 'Carbs trending high. Prefer leafy greens and proteins tonight.';

    if (proLeft > 20)   return 'You\'re ${proLeft}g short on protein. Add chicken, fish, or eggs next.';
    if (calLeft > 250)  return 'About ${calLeft} kcal left—try a balanced snack.';
    if (carbLeft > 40)  return 'You still have ${carbLeft}g carbs—whole grains could help.';
    if (fatLeft > 15)   return 'Room for ${fatLeft}g fat—add a little olive oil or nuts.';

    if (calLeft.abs() <= 100 && proLeft <= 10 && carbLeft <= 20 && fatLeft <= 10) {
      return 'Great pace! You\'re on track to hit today\'s goals.';
    }
    return 'Keep it steady—aim for balanced portions in your next meal.';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    
    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    final day = date.day;
    
    return '$weekday, $month $day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            children: [
              const SizedBox(height: 16),
              Center(child: Text('FitMeal', style: GoogleFonts.pacifico(fontSize: 32, color: darkGreen))),
              const SizedBox(height: 20),

              // Daily progress card
              _dailyProgressCard(),

              const SizedBox(height: 14),

              // Smart reminder
              _reminderCard(_dailyTip),

              const SizedBox(height: 18),

              // Plan selector tabs
              Container(
                height: 46,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.grey.shade200),
                child: Row(children: [
                  _planTabButton('Weekly Plan', 0),
                  _planTabButton('Daily Plan', 1),
                ]),
              ),
              const SizedBox(height: 16),

              // Content based on selected tab
              if (selectedTab == 0) _buildWeeklyPlan() else _buildDailyPlan(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyPlan() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Weekly Overview', 
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.refresh, color: darkGreen, size: 20),
              onPressed: _refreshMealPlan,
              tooltip: 'Refresh meal plan',
            ),
            if (_userProfile != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: darkGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getUserPlanType(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        
        // Weekly summary cards
        ...List.generate(7, (index) {
          final dayMeals = weeklyMealPlan[index]!;
          int dayTotal = 0;
          dayMeals.forEach((key, meal) {
            if (meal is Map) dayTotal += (meal['calories'] as int? ?? 0);
          });
          
          final isToday = index == currentDayOfWeek;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isToday ? darkGreen.withOpacity(0.08) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isToday ? darkGreen : Colors.grey.shade300,
                width: isToday ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isToday ? darkGreen : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        days[index],
                        style: GoogleFonts.poppins(
                          color: isToday ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Today',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      '$dayTotal kcal',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMealRow('Breakfast', dayMeals['breakfast']),
                _buildMealRow('Lunch', dayMeals['lunch']),
                _buildMealRow('Dinner', dayMeals['dinner']),
                _buildMealRow('Snack', dayMeals['snack']),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMealRow(String mealType, Map<String, dynamic>? meal) {
    if (meal == null) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getMealColor(mealType),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${mealType}: ${meal['name']}',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${meal['calories']} kcal',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(selectedDate),
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDate.subtract(const Duration(days: 1));
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDate.add(const Duration(days: 1));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Daily goals summary
        _dailyGoalsSummary(),
        
        const SizedBox(height: 16),
        Text('Today\'s Meals', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 12),

        // Breakfast
        _mealCard('Breakfast', todaysMeals['breakfast'], Icons.breakfast_dining, Colors.orange),
        const SizedBox(height: 10),

        // Lunch
        _mealCard('Lunch', todaysMeals['lunch'], Icons.lunch_dining, Colors.green),
        const SizedBox(height: 10),

        // Dinner
        _mealCard('Dinner', todaysMeals['dinner'], Icons.dinner_dining, Colors.blue),
        const SizedBox(height: 10),

        // Snack
        _mealCard('Snack', todaysMeals['snack'], Icons.cookie, Colors.purple),
      ],
    );
  }

  Widget _dailyGoalsSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.orange.shade700, size: 22),
              const SizedBox(width: 8),
              Text(
                'Daily Goals',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _goalStat('Calories', '$totalCalories / $dailyCalorieGoal', Colors.orange),
              _goalStat('Protein', '${totalProtein}g / ${dailyProteinGoal}g', Colors.green),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _goalStat('Carbs', '${totalCarbs}g / ${dailyCarbsGoal}g', Colors.blue),
              _goalStat('Fat', '${totalFat}g / ${dailyFatGoal}g', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _goalStat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealCard(String mealType, Map<String, dynamic>? meal, IconData icon, Color color) {
    if (meal == null) return const SizedBox.shrink();

    final bool isPersonalized = meal['isPersonalized'] ?? false;
    final String description = meal['description'] ?? '';
    final String? difficulty = meal['difficulty'];
    final String? category = meal['category'];
    final bool? isFilipinoDish = meal['isFilipinoDish'];

    return GestureDetector(
      onTap: () => _showRecipeDetail(mealType, meal),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isPersonalized ? darkGreen.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPersonalized ? darkGreen.withOpacity(0.3) : Colors.grey.shade300,
            width: isPersonalized ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isPersonalized ? darkGreen.withOpacity(0.1) : Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isPersonalized ? darkGreen.withOpacity(0.15) : color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isPersonalized ? Icons.recommend : icon, 
                  color: isPersonalized ? darkGreen : color, 
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          mealType,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isPersonalized) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: darkGreen.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Personalized',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                color: darkGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            meal['name'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.touch_app,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (isFilipinoDish == true) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.flag, size: 12, color: Colors.red.shade600),
                          const SizedBox(width: 4),
                          Text(
                            'Filipino',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nutritionBadge('${meal['calories']} kcal', Icons.local_fire_department, Colors.orange),
              _nutritionBadge('${meal['protein']}g P', Icons.fitness_center, Colors.green),
              _nutritionBadge('${meal['carbs']}g C', Icons.rice_bowl, Colors.blue),
              _nutritionBadge('${meal['fat']}g F', Icons.water_drop, Colors.red),
            ],
          ),
          if (difficulty != null || category != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                if (difficulty != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(difficulty).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      difficulty,
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        color: _getDifficultyColor(difficulty),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                if (category != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _nutritionBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.green;
      case 'dinner':
        return Colors.blue;
      case 'snack':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // Clear cached plan and reload personalized recommendations
    _cachedMealPlan = null;
    _lastCacheKey = null;
    await _loadPersonalizedRecommendations();
    if (mounted) {
      setState(() {});
    }
  }

  // Method to manually refresh meal plan
  void _refreshMealPlan() {
    setState(() {
      _cachedMealPlan = null;
      _lastCacheKey = null;
    });
  }

  // Find recipe by name from available recipes
  Recipe? _findRecipeByName(String recipeName) {
    final allRecipes = RecipeService().getAllRecipes();
    try {
      return allRecipes.firstWhere((recipe) => recipe.name == recipeName);
    } catch (e) {
      print('Recipe not found: $recipeName');
      return null;
    }
  }

  // Show recipe detail page
  void _showRecipeDetail(String mealType, Map<String, dynamic> meal) {
    final recipeName = meal['name'] as String;
    final recipe = _findRecipeByName(recipeName);
    
    if (recipe != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(
            recipe: recipe,
            mealType: mealType,
          ),
        ),
      ).then((_) {
        // Refresh the dashboard when returning from recipe detail
        _refreshData();
      });
    } else {
      // Show a simple dialog for default meals
      _showDefaultMealDialog(mealType, meal);
    }
  }

  // Show dialog for default meals (no recipe details available)
  void _showDefaultMealDialog(String mealType, Map<String, dynamic> meal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          meal['name'],
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meal Type: ${mealType.toUpperCase()}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Nutrition Information:',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text('• Calories: ${meal['calories']} kcal'),
            Text('• Protein: ${meal['protein']}g'),
            Text('• Carbs: ${meal['carbs']}g'),
            Text('• Fat: ${meal['fat']}g'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  Widget _dailyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkGreen.withOpacity(0.08), Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: darkGreen.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: darkGreen),
              const SizedBox(width: 8),
              Text(
                'Today\'s Progress',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _progressRow(
            label: 'Calories',
            value: totalCalories,
            goal: dailyCalorieGoal,
            color: Colors.orange,
            icon: Icons.local_fire_department,
            unit: 'kcal',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _macroTile('Protein', totalProtein, dailyProteinGoal, Colors.green)),
              const SizedBox(width: 8),
              Expanded(child: _macroTile('Carbs', totalCarbs, dailyCarbsGoal, Colors.blue)),
              const SizedBox(width: 8),
              Expanded(child: _macroTile('Fat', totalFat, dailyFatGoal, Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressRow({
    required String label,
    required int value,
    required int goal,
    required Color color,
    required IconData icon,
    String unit = '',
  }) {
    final pct = (value / goal).clamp(0, 1);
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                  const Spacer(),
                  Text(
                    '$value / $goal $unit',
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: pct.toDouble(),
                  minHeight: 10,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _macroTile(String label, int value, int goal, Color color) {
    final pct = (value / goal).clamp(0, 1);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.bubble_chart, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            '$value/$goal',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct.toDouble(),
              minHeight: 6,
              color: color,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reminderCard(String tip) {
    final bool warn = tip.contains('over') || tip.contains('high');
    final Color bg = warn ? Colors.redAccent.withOpacity(0.12) : darkGreen.withOpacity(0.10);
    final Color iconColor = warn ? Colors.redAccent : darkGreen;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(warn ? Icons.warning_amber : Icons.lightbulb, color: iconColor, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _planTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: selectedTab == index ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: selectedTab == index
                ? [const BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1))]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: selectedTab == index ? darkGreen : Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

}