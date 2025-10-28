import 'user_data_service.dart';

class GoalCalculationService {
  // Calculate personalized daily calorie goal based on user profile
  static int calculateCalorieGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 1800; // Default goal
    
    final userWeight = userProfile.weight;
    final goal = userProfile.goal.toLowerCase();
    
    // Base calories per kg based on goal
    double caloriesPerKg;
    switch (goal) {
      case 'weight loss':
        caloriesPerKg = 25.0;
        break;
      case 'weight gain':
        caloriesPerKg = 35.0;
        break;
      case 'muscle gain':
        caloriesPerKg = 32.0;
        break;
      case 'maintenance':
        caloriesPerKg = 30.0;
        break;
      default:
        caloriesPerKg = 30.0;
    }
    
    return (userWeight * caloriesPerKg).round();
  }
  
  // Calculate personalized daily protein goal
  static int calculateProteinGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 80; // Default goal
    
    final userWeight = userProfile.weight;
    final goal = userProfile.goal.toLowerCase();
    
    // Protein per kg based on goal
    double proteinPerKg;
    switch (goal) {
      case 'weight loss':
        proteinPerKg = 1.6; // Higher protein for weight loss
        break;
      case 'weight gain':
        proteinPerKg = 1.4;
        break;
      case 'muscle gain':
        proteinPerKg = 2.0; // Higher protein for muscle gain
        break;
      case 'maintenance':
        proteinPerKg = 1.2;
        break;
      default:
        proteinPerKg = 1.2;
    }
    
    return (userWeight * proteinPerKg).round();
  }
  
  // Calculate personalized daily carbs goal
  static int calculateCarbsGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 200; // Default goal
    
    final calorieGoal = calculateCalorieGoal(userProfile);
    final proteinGoal = calculateProteinGoal(userProfile);
    final fatGoal = calculateFatGoal(userProfile);
    
    // Calculate carbs based on remaining calories
    final proteinCalories = proteinGoal * 4;
    final fatCalories = fatGoal * 9;
    final remainingCalories = calorieGoal - proteinCalories - fatCalories;
    
    return (remainingCalories / 4).round(); // 4 calories per gram of carbs
  }
  
  // Calculate personalized daily fat goal
  static int calculateFatGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 60; // Default goal
    
    final userWeight = userProfile.weight;
    final goal = userProfile.goal.toLowerCase();
    
    // Fat per kg based on goal
    double fatPerKg;
    switch (goal) {
      case 'weight loss':
        fatPerKg = 0.8; // Lower fat for weight loss
        break;
      case 'weight gain':
        fatPerKg = 1.2; // Higher fat for weight gain
        break;
      case 'muscle gain':
        fatPerKg = 1.0;
        break;
      case 'maintenance':
        fatPerKg = 1.0;
        break;
      default:
        fatPerKg = 1.0;
    }
    
    return (userWeight * fatPerKg).round();
  }
  
  // Calculate personalized water goal (glasses per day)
  static int calculateWaterGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 8; // Default goal
    
    final userWeight = userProfile.weight;
    final activity = userProfile.activity.toLowerCase();
    
    // Base water intake: 35ml per kg body weight
    double baseWaterMl = userWeight * 35;
    
    // Adjust based on activity level
    double activityMultiplier;
    switch (activity) {
      case 'sedentary':
        activityMultiplier = 1.0;
        break;
      case 'lightly active':
        activityMultiplier = 1.1;
        break;
      case 'moderately active':
        activityMultiplier = 1.2;
        break;
      case 'very active':
        activityMultiplier = 1.3;
        break;
      case 'extremely active':
        activityMultiplier = 1.4;
        break;
      default:
        activityMultiplier = 1.0;
    }
    
    // Convert to glasses (assuming 250ml per glass)
    final totalWaterMl = baseWaterMl * activityMultiplier;
    return (totalWaterMl / 250).round();
  }
  
  // Calculate personalized steps goal
  static int calculateStepsGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 8000; // Default goal
    
    final activity = userProfile.activity.toLowerCase();
    
    switch (activity) {
      case 'sedentary':
        return 6000;
      case 'lightly active':
        return 8000;
      case 'moderately active':
        return 10000;
      case 'very active':
        return 12000;
      case 'extremely active':
        return 15000;
      default:
        return 8000;
    }
  }
  
  // Calculate personalized sleep goal
  static int calculateSleepGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 8; // Default goal
    
    final age = _calculateAge(userProfile);
    
    // Sleep recommendations by age
    if (age < 18) {
      return 9; // Teenagers need more sleep
    } else if (age < 65) {
      return 8; // Adults
    } else {
      return 7; // Older adults
    }
  }
  
  // Calculate personalized workout goal (minutes per day)
  static int calculateWorkoutGoal(UserProfileData? userProfile) {
    if (userProfile == null) return 30; // Default goal
    
    final goal = userProfile.goal.toLowerCase();
    final activity = userProfile.activity.toLowerCase();
    
    // Base workout time based on goal
    int baseMinutes;
    switch (goal) {
      case 'weight loss':
        baseMinutes = 45; // More cardio for weight loss
        break;
      case 'muscle gain':
        baseMinutes = 60; // More time for strength training
        break;
      case 'weight gain':
        baseMinutes = 30; // Moderate exercise
        break;
      case 'maintenance':
        baseMinutes = 30;
        break;
      default:
        baseMinutes = 30;
    }
    
    // Adjust based on current activity level
    double activityMultiplier;
    switch (activity) {
      case 'sedentary':
        activityMultiplier = 1.2; // Start with more exercise
        break;
      case 'lightly active':
        activityMultiplier = 1.0;
        break;
      case 'moderately active':
        activityMultiplier = 0.8;
        break;
      case 'very active':
        activityMultiplier = 0.6;
        break;
      case 'extremely active':
        activityMultiplier = 0.5;
        break;
      default:
        activityMultiplier = 1.0;
    }
    
    return (baseMinutes * activityMultiplier).round();
  }
  
  // Get all personalized goals
  static Map<String, int> getAllGoals(UserProfileData? userProfile) {
    return {
      'calories': calculateCalorieGoal(userProfile),
      'protein': calculateProteinGoal(userProfile),
      'carbs': calculateCarbsGoal(userProfile),
      'fat': calculateFatGoal(userProfile),
      'water': calculateWaterGoal(userProfile),
      'steps': calculateStepsGoal(userProfile),
      'sleep': calculateSleepGoal(userProfile),
      'workout': calculateWorkoutGoal(userProfile),
    };
  }
  
  // Helper method to calculate age from birth date
  static int _calculateAge(UserProfileData userProfile) {
    // Since we don't have birth date in UserProfileData, we'll use a default age
    // In a real app, you'd want to add birth date to the user profile
    return 30; // Default age
  }
  
  // Calculate BMI category and recommendations
  static Map<String, dynamic> getBMIRecommendations(UserProfileData userProfile) {
    final bmi = userProfile.bmi;
    final category = userProfile.bmiCategory;
    
    Map<String, dynamic> recommendations = {
      'bmi': bmi,
      'category': category,
      'isHealthy': bmi >= 18.5 && bmi < 25,
      'needsWeightLoss': bmi >= 25,
      'needsWeightGain': bmi < 18.5,
    };
    
    // Add specific recommendations based on BMI
    if (bmi < 18.5) {
      recommendations['message'] = 'Consider increasing calorie intake and strength training';
      recommendations['priority'] = 'weight_gain';
    } else if (bmi >= 25) {
      recommendations['message'] = 'Focus on calorie deficit and regular exercise';
      recommendations['priority'] = 'weight_loss';
    } else {
      recommendations['message'] = 'Maintain current healthy habits';
      recommendations['priority'] = 'maintenance';
    }
    
    return recommendations;
  }
  
  // Calculate progress percentage for a metric
  static double calculateProgressPercentage(int current, int goal) {
    if (goal == 0) return 0.0;
    return (current / goal).clamp(0.0, 1.0);
  }
  
  // Get completion status for all goals
  static Map<String, bool> getGoalCompletionStatus(
    Map<String, int> currentValues,
    Map<String, int> goals,
  ) {
    Map<String, bool> completion = {};
    
    for (String key in goals.keys) {
      final current = currentValues[key] ?? 0;
      final goal = goals[key] ?? 1;
      completion[key] = current >= goal;
    }
    
    return completion;
  }
  
  // Calculate overall daily completion percentage
  static double calculateOverallCompletion(
    Map<String, int> currentValues,
    Map<String, int> goals,
  ) {
    if (goals.isEmpty) return 0.0;
    
    double totalProgress = 0.0;
    for (String key in goals.keys) {
      final current = currentValues[key] ?? 0;
      final goal = goals[key] ?? 1;
      totalProgress += calculateProgressPercentage(current, goal);
    }
    
    return (totalProgress / goals.length).clamp(0.0, 1.0);
  }
}
