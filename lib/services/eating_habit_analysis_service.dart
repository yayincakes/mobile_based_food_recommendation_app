import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EatingHabitAnalysisService {
  static const String _dailyLogsKey = 'daily_eating_logs';
  static const String _weeklyProgressKey = 'weekly_progress';
  static const String _habitStreaksKey = 'habit_streaks';

  // Daily eating log entry
  static Future<void> logMeal({
    required String mealType,
    required String mealName,
    required int calories,
    required int protein,
    required int carbs,
    required int fat,
    DateTime? timestamp,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = timestamp ?? DateTime.now();
      final dateKey = getDateKey(today);
      
      final logs = await getDailyLogs(dateKey);
      logs.add({
        'mealType': mealType,
        'mealName': mealName,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'timestamp': today.toIso8601String(),
      });
      
      await prefs.setString('${_dailyLogsKey}_$dateKey', json.encode(logs));
      await _updateWeeklyProgress(dateKey);
      await _updateHabitStreaks(mealType, mealName);
    } catch (e) {
      print('Error logging meal: $e');
    }
  }

  // Get daily eating logs for a specific date
  static Future<List<Map<String, dynamic>>> getDailyLogs(String dateKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logsJson = prefs.getString('${_dailyLogsKey}_$dateKey');
      if (logsJson != null) {
        return List<Map<String, dynamic>>.from(json.decode(logsJson));
      }
      return [];
    } catch (e) {
      print('Error getting daily logs: $e');
      return [];
    }
  }

  // Get today's logs
  static Future<List<Map<String, dynamic>>> getTodaysLogs() async {
    final today = DateTime.now();
      final dateKey = getDateKey(today);
    return getDailyLogs(dateKey);
  }

  // Calculate daily nutrition totals
  static Future<Map<String, int>> getDailyTotals(String dateKey) async {
    final logs = await getDailyLogs(dateKey);
    int totalCalories = 0;
    int totalProtein = 0;
    int totalCarbs = 0;
    int totalFat = 0;
    
    for (final log in logs) {
      totalCalories += log['calories'] as int? ?? 0;
      totalProtein += log['protein'] as int? ?? 0;
      totalCarbs += log['carbs'] as int? ?? 0;
      totalFat += log['fat'] as int? ?? 0;
    }
    
    return {
      'calories': totalCalories,
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
    };
  }

  // Get personalized goals based on user profile
  static Future<Map<String, int>> getPersonalizedGoals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString('user_profile');
      
      if (profileJson != null) {
        final profileData = json.decode(profileJson);
        final weight = profileData['weight']?.toDouble() ?? 70.0;
        final goal = profileData['goal'] ?? 'Maintenance';
        final activityLevel = profileData['activity_level'] ?? 'Sedentary';
        
        return _calculateGoals(weight, goal, activityLevel);
      }
      
      // Default goals if no profile
      return {
        'calories': 1800,
        'protein': 80,
        'carbs': 200,
        'fat': 60,
      };
    } catch (e) {
      print('Error getting personalized goals: $e');
      return {
        'calories': 1800,
        'protein': 80,
        'carbs': 200,
        'fat': 60,
      };
    }
  }

  // Calculate goals based on user characteristics
  static Map<String, int> _calculateGoals(double weight, String goal, String activityLevel) {
    // Base calories per kg based on goal and activity
    double caloriesPerKg;
    switch (goal.toLowerCase()) {
      case 'weight loss':
        caloriesPerKg = _getActivityMultiplier(activityLevel) * 25.0;
        break;
      case 'weight gain':
        caloriesPerKg = _getActivityMultiplier(activityLevel) * 35.0;
        break;
      case 'muscle gain':
        caloriesPerKg = _getActivityMultiplier(activityLevel) * 32.0;
        break;
      default: // Maintenance
        caloriesPerKg = _getActivityMultiplier(activityLevel) * 30.0;
        break;
    }
    
    final dailyCalories = (weight * caloriesPerKg).round();
    
    // Protein per kg based on goal
    double proteinPerKg;
    switch (goal.toLowerCase()) {
      case 'weight loss':
        proteinPerKg = 1.6; // Higher protein for weight loss
        break;
      case 'muscle gain':
        proteinPerKg = 2.0; // Higher protein for muscle gain
        break;
      default:
        proteinPerKg = 1.2;
        break;
    }
    
    final dailyProtein = (weight * proteinPerKg).round();
    
    // Fat per kg
    final dailyFat = (weight * 1.0).round();
    
    // Carbs calculated from remaining calories
    final proteinCalories = dailyProtein * 4;
    final fatCalories = dailyFat * 9;
    final remainingCalories = dailyCalories - proteinCalories - fatCalories;
    final dailyCarbs = (remainingCalories / 4).round();
    
    return {
      'calories': dailyCalories,
      'protein': dailyProtein,
      'carbs': dailyCarbs,
      'fat': dailyFat,
    };
  }

  // Get activity level multiplier
  static double _getActivityMultiplier(String activityLevel) {
    switch (activityLevel.toLowerCase()) {
      case 'sedentary':
        return 1.0;
      case 'lightly active':
        return 1.2;
      case 'moderately active':
        return 1.4;
      case 'very active':
        return 1.6;
      case 'extremely active':
        return 1.8;
      default:
        return 1.2;
    }
  }

  // Calculate progress percentage for each goal
  static Future<Map<String, double>> getProgressPercentages(String dateKey) async {
    final totals = await getDailyTotals(dateKey);
    final goals = await getPersonalizedGoals();
    
    return {
      'calories': (totals['calories']! / goals['calories']!).clamp(0.0, 1.0),
      'protein': (totals['protein']! / goals['protein']!).clamp(0.0, 1.0),
      'carbs': (totals['carbs']! / goals['carbs']!).clamp(0.0, 1.0),
      'fat': (totals['fat']! / goals['fat']!).clamp(0.0, 1.0),
    };
  }

  // Get overall completion percentage
  static Future<int> getOverallCompletion(String dateKey) async {
    final progress = await getProgressPercentages(dateKey);
    final totalProgress = progress.values.reduce((a, b) => a + b);
    return ((totalProgress / progress.length) * 100).round();
  }

  // Analyze eating habits
  static Future<EatingHabitAnalysis> analyzeEatingHabits(String dateKey) async {
    try {
      print('EatingHabitAnalysis: Analyzing habits for $dateKey');
      
      final logs = await getDailyLogs(dateKey);
      final goals = await getPersonalizedGoals();
      final totals = await getDailyTotals(dateKey);
      
      print('EatingHabitAnalysis: Found ${logs.length} meal logs');
      print('EatingHabitAnalysis: Daily totals - Calories: ${totals['calories']}, Protein: ${totals['protein']}');
      
      // Analyze meal timing
      final mealTimes = <String, List<DateTime>>{};
      for (final log in logs) {
        final timestamp = DateTime.parse(log['timestamp']);
        final mealType = log['mealType'] as String;
        mealTimes.putIfAbsent(mealType, () => []).add(timestamp);
      }
      
      // Analyze meal frequency
      final mealFrequency = mealTimes.length;
      final isRegularEating = mealFrequency >= 3; // At least 3 meals
      
      // Analyze meal timing consistency
      bool isConsistentTiming = true;
      for (final times in mealTimes.values) {
        if (times.length > 1) {
          times.sort();
          for (int i = 1; i < times.length; i++) {
            final diff = times[i].difference(times[i-1]).inHours;
            if (diff < 2 || diff > 6) { // Meals should be 2-6 hours apart
              isConsistentTiming = false;
              break;
            }
          }
        }
      }
      
      // Analyze nutrition balance
      final caloriesProgress = totals['calories']! / goals['calories']!;
      final proteinProgress = totals['protein']! / goals['protein']!;
      final carbsProgress = totals['carbs']! / goals['carbs']!;
      final fatProgress = totals['fat']! / goals['fat']!;
      
      final isBalancedNutrition = (caloriesProgress >= 0.8 && caloriesProgress <= 1.2) &&
                                 (proteinProgress >= 0.7 && proteinProgress <= 1.3) &&
                                 (carbsProgress >= 0.7 && carbsProgress <= 1.3) &&
                                 (fatProgress >= 0.7 && fatProgress <= 1.3);
      
      // Analyze meal variety
      final uniqueMeals = logs.map((log) => log['mealName']).toSet().length;
      final isVariedMeals = uniqueMeals >= 3; // At least 3 different meals
      
      // Calculate habit score
      int habitScore = 0;
      if (isRegularEating) habitScore += 25;
      if (isConsistentTiming) habitScore += 25;
      if (isBalancedNutrition) habitScore += 25;
      if (isVariedMeals) habitScore += 25;
      
      print('EatingHabitAnalysis: Habit score: $habitScore');
      
      return EatingHabitAnalysis(
        dateKey: dateKey,
        totalMeals: logs.length,
        totalCalories: totals['calories']!,
        totalProtein: totals['protein']!,
        totalCarbs: totals['carbs']!,
        totalFat: totals['fat']!,
        calorieGoal: goals['calories']!,
        proteinGoal: goals['protein']!,
        carbsGoal: goals['carbs']!,
        fatGoal: goals['fat']!,
        isRegularEating: isRegularEating,
        isConsistentTiming: isConsistentTiming,
        isBalancedNutrition: isBalancedNutrition,
        isVariedMeals: isVariedMeals,
        habitScore: habitScore,
        mealTimes: mealTimes,
        recommendations: _generateRecommendations(
          isRegularEating, isConsistentTiming, isBalancedNutrition, isVariedMeals,
          caloriesProgress, proteinProgress, carbsProgress, fatProgress
        ),
      );
    } catch (e) {
      print('Error analyzing eating habits: $e');
      // Return empty analysis on error
      return EatingHabitAnalysis(
        dateKey: dateKey,
        totalMeals: 0,
        totalCalories: 0,
        totalProtein: 0,
        totalCarbs: 0,
        totalFat: 0,
        calorieGoal: 2000,
        proteinGoal: 80,
        carbsGoal: 200,
        fatGoal: 60,
        isRegularEating: false,
        isConsistentTiming: false,
        isBalancedNutrition: false,
        isVariedMeals: false,
        habitScore: 0,
        mealTimes: {},
        recommendations: ['Start logging your meals to see eating habit analysis'],
      );
    }
  }

  // Generate personalized recommendations
  static List<String> _generateRecommendations(
    bool isRegularEating, bool isConsistentTiming, bool isBalancedNutrition, bool isVariedMeals,
    double caloriesProgress, double proteinProgress, double carbsProgress, double fatProgress
  ) {
    final recommendations = <String>[];
    
    if (!isRegularEating) {
      recommendations.add('Try to eat at least 3 meals per day for better metabolism');
    }
    
    if (!isConsistentTiming) {
      recommendations.add('Maintain consistent meal timing (2-6 hours apart)');
    }
    
    if (caloriesProgress < 0.8) {
      recommendations.add('You need more calories. Add healthy snacks between meals');
    } else if (caloriesProgress > 1.2) {
      recommendations.add('Consider reducing portion sizes or choosing lighter options');
    }
    
    if (proteinProgress < 0.7) {
      recommendations.add('Increase protein intake with lean meats, fish, or legumes');
    } else if (proteinProgress > 1.3) {
      recommendations.add('Balance protein with more vegetables and whole grains');
    }
    
    if (carbsProgress < 0.7) {
      recommendations.add('Add more complex carbohydrates like brown rice or quinoa');
    } else if (carbsProgress > 1.3) {
      recommendations.add('Choose whole grain options and reduce refined carbs');
    }
    
    if (fatProgress < 0.7) {
      recommendations.add('Include healthy fats like avocado, nuts, or olive oil');
    } else if (fatProgress > 1.3) {
      recommendations.add('Choose lean protein sources and reduce fried foods');
    }
    
    if (!isVariedMeals) {
      recommendations.add('Try different recipes to increase meal variety');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Great job! Your eating habits are on track');
    }
    
    return recommendations;
  }

  // Update weekly progress
  static Future<void> _updateWeeklyProgress(String dateKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final analysis = await analyzeEatingHabits(dateKey);
      
      final weeklyData = await getWeeklyProgress();
      weeklyData[dateKey] = analysis;
      
      await prefs.setString(_weeklyProgressKey, json.encode(
        weeklyData.map((key, value) => MapEntry(key, value.toJson()))
      ));
    } catch (e) {
      print('Error updating weekly progress: $e');
    }
  }

  // Get weekly progress data
  static Future<Map<String, EatingHabitAnalysis>> getWeeklyProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final weeklyJson = prefs.getString(_weeklyProgressKey);
      
      if (weeklyJson != null) {
        final data = json.decode(weeklyJson) as Map<String, dynamic>;
        return data.map((key, value) => MapEntry(
          key, 
          EatingHabitAnalysis.fromJson(value as Map<String, dynamic>)
        ));
      }
      
      return {};
    } catch (e) {
      print('Error getting weekly progress: $e');
      return {};
    }
  }

  // Update habit streaks
  static Future<void> _updateHabitStreaks(String mealType, String mealName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final streaks = await getHabitStreaks();
      
      // Update meal frequency streak
      streaks['meal_frequency'] = (streaks['meal_frequency'] ?? 0) + 1;
      
      // Update specific meal type streaks
      final mealTypeKey = 'meal_type_$mealType';
      streaks[mealTypeKey] = (streaks[mealTypeKey] ?? 0) + 1;
      
      await prefs.setString(_habitStreaksKey, json.encode(streaks));
    } catch (e) {
      print('Error updating habit streaks: $e');
    }
  }

  // Get habit streaks
  static Future<Map<String, int>> getHabitStreaks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final streaksJson = prefs.getString(_habitStreaksKey);
      
      if (streaksJson != null) {
        return Map<String, int>.from(json.decode(streaksJson));
      }
      
      return {};
    } catch (e) {
      print('Error getting habit streaks: $e');
      return {};
    }
  }

  // Helper method to get date key
  static String getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }


  // Get current week's date keys
  static List<String> getCurrentWeekKeys() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    return List.generate(7, (index) {
      final date = startOfWeek.add(Duration(days: index));
      return getDateKey(date);
    });
  }
}

// Eating habit analysis model
class EatingHabitAnalysis {
  final String dateKey;
  final int totalMeals;
  final int totalCalories;
  final int totalProtein;
  final int totalCarbs;
  final int totalFat;
  final int calorieGoal;
  final int proteinGoal;
  final int carbsGoal;
  final int fatGoal;
  final bool isRegularEating;
  final bool isConsistentTiming;
  final bool isBalancedNutrition;
  final bool isVariedMeals;
  final int habitScore;
  final Map<String, List<DateTime>> mealTimes;
  final List<String> recommendations;

  EatingHabitAnalysis({
    required this.dateKey,
    required this.totalMeals,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.calorieGoal,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatGoal,
    required this.isRegularEating,
    required this.isConsistentTiming,
    required this.isBalancedNutrition,
    required this.isVariedMeals,
    required this.habitScore,
    required this.mealTimes,
    required this.recommendations,
  });

  factory EatingHabitAnalysis.fromJson(Map<String, dynamic> json) {
    return EatingHabitAnalysis(
      dateKey: json['dateKey'] ?? '',
      totalMeals: json['totalMeals'] ?? 0,
      totalCalories: json['totalCalories'] ?? 0,
      totalProtein: json['totalProtein'] ?? 0,
      totalCarbs: json['totalCarbs'] ?? 0,
      totalFat: json['totalFat'] ?? 0,
      calorieGoal: json['calorieGoal'] ?? 1800,
      proteinGoal: json['proteinGoal'] ?? 80,
      carbsGoal: json['carbsGoal'] ?? 200,
      fatGoal: json['fatGoal'] ?? 60,
      isRegularEating: json['isRegularEating'] ?? false,
      isConsistentTiming: json['isConsistentTiming'] ?? false,
      isBalancedNutrition: json['isBalancedNutrition'] ?? false,
      isVariedMeals: json['isVariedMeals'] ?? false,
      habitScore: json['habitScore'] ?? 0,
      mealTimes: Map<String, List<DateTime>>.from(
        (json['mealTimes'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            (value as List<dynamic>).map((e) => DateTime.parse(e)).toList()
          )
        )
      ),
      recommendations: List<String>.from(json['recommendations'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateKey': dateKey,
      'totalMeals': totalMeals,
      'totalCalories': totalCalories,
      'totalProtein': totalProtein,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'calorieGoal': calorieGoal,
      'proteinGoal': proteinGoal,
      'carbsGoal': carbsGoal,
      'fatGoal': fatGoal,
      'isRegularEating': isRegularEating,
      'isConsistentTiming': isConsistentTiming,
      'isBalancedNutrition': isBalancedNutrition,
      'isVariedMeals': isVariedMeals,
      'habitScore': habitScore,
      'mealTimes': mealTimes.map(
        (key, value) => MapEntry(key, value.map((e) => e.toIso8601String()).toList())
      ),
      'recommendations': recommendations,
    };
  }

  // Get progress percentages
  Map<String, double> get progressPercentages => {
    'calories': (totalCalories / calorieGoal).clamp(0.0, 1.0),
    'protein': (totalProtein / proteinGoal).clamp(0.0, 1.0),
    'carbs': (totalCarbs / carbsGoal).clamp(0.0, 1.0),
    'fat': (totalFat / fatGoal).clamp(0.0, 1.0),
  };

  // Get overall completion percentage
  int get overallCompletion {
    final progress = progressPercentages.values.reduce((a, b) => a + b);
    return ((progress / progressPercentages.length) * 100).round();
  }
}
