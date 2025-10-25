import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/diet_history.dart';

class DietHistoryService {
  static const String _dietHistoryKey = 'diet_history_entries';

  // Save diet entry
  static Future<bool> saveDietEntry(DietHistoryEntry entry) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingEntries = await getDietHistory();
      
      existingEntries.add(entry);
      
      final entriesJson = existingEntries.map((e) => e.toJson()).toList();
      await prefs.setString(_dietHistoryKey, jsonEncode(entriesJson));
      
      return true;
    } catch (e) {
      print('Error saving diet entry: $e');
      return false;
    }
  }

  // Get all diet history entries
  static Future<List<DietHistoryEntry>> getDietHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final entriesJson = prefs.getString(_dietHistoryKey);
      
      if (entriesJson == null) return [];
      
      final List<dynamic> entriesList = jsonDecode(entriesJson);
      return entriesList.map((json) => DietHistoryEntry.fromJson(json)).toList();
    } catch (e) {
      print('Error getting diet history: $e');
      return [];
    }
  }

  // Get diet history for a specific date range
  static Future<List<DietHistoryEntry>> getDietHistoryForRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allEntries = await getDietHistory();
    return allEntries.where((entry) {
      return entry.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
             entry.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  // Get daily nutrition summary for a specific date
  static Future<DailyNutritionSummary?> getDailyNutritionSummary(DateTime date) async {
    final entries = await getDietHistoryForRange(date, date);
    
    if (entries.isEmpty) return null;

    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSugar = 0;
    double totalSodium = 0;

    for (final entry in entries) {
      totalCalories += entry.calories;
      totalProtein += entry.protein;
      totalCarbs += entry.carbs;
      totalFat += entry.fat;
      totalFiber += entry.fiber;
      totalSugar += entry.sugar;
      totalSodium += entry.sodium;
    }

    final mealTypes = entries.map((e) => e.mealType).toSet();
    
    return DailyNutritionSummary(
      date: date,
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbs: totalCarbs,
      totalFat: totalFat,
      totalFiber: totalFiber,
      totalSugar: totalSugar,
      totalSodium: totalSodium,
      entries: entries,
      mealCount: mealTypes.length,
    );
  }

  // Get nutrition trends for a date range
  static Future<List<NutritionTrend>> getNutritionTrends(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final trends = <NutritionTrend>[];
    final currentDate = DateTime(startDate.year, startDate.month, startDate.day);
    final endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);

    while (currentDate.isBefore(endDateOnly) || currentDate.isAtSameMomentAs(endDateOnly)) {
      final summary = await getDailyNutritionSummary(currentDate);
      
      trends.add(NutritionTrend(
        date: currentDate,
        calories: summary?.totalCalories ?? 0,
        protein: summary?.totalProtein ?? 0,
        carbs: summary?.totalCarbs ?? 0,
        fat: summary?.totalFat ?? 0,
      ));

      currentDate.add(const Duration(days: 1));
    }

    return trends;
  }

  // Analyze eating habits
  static Future<EatingHabitAnalysis> analyzeEatingHabits(int daysBack) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: daysBack));
    
    final entries = await getDietHistoryForRange(startDate, endDate);
    
    if (entries.isEmpty) {
      return EatingHabitAnalysis(
        averageDailyCalories: 0,
        averageMealFrequency: 0,
        mostEatenMeal: 'None',
        leastEatenMeal: 'None',
        topFoods: [],
        macroDistribution: {},
        insights: ['No eating data available'],
        overallTrend: 'stable',
      );
    }

    // Calculate daily averages
    final dailySummaries = <DailyNutritionSummary>[];
    for (int i = 0; i < daysBack; i++) {
      final date = endDate.subtract(Duration(days: i));
      final summary = await getDailyNutritionSummary(date);
      if (summary != null) dailySummaries.add(summary);
    }

    final averageDailyCalories = dailySummaries.isEmpty 
        ? 0 
        : dailySummaries.map((s) => s.totalCalories).reduce((a, b) => a + b) / dailySummaries.length;

    // Meal frequency analysis
    final mealTypeCounts = <String, int>{};
    for (final entry in entries) {
      mealTypeCounts[entry.mealType] = (mealTypeCounts[entry.mealType] ?? 0) + 1;
    }

    final averageMealFrequency = entries.length / daysBack;
    final mostEatenMeal = mealTypeCounts.entries.isNotEmpty 
        ? mealTypeCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : 'None';
    final leastEatenMeal = mealTypeCounts.entries.isNotEmpty 
        ? mealTypeCounts.entries.reduce((a, b) => a.value < b.value ? a : b).key
        : 'None';

    // Top foods analysis
    final foodCounts = <String, int>{};
    for (final entry in entries) {
      foodCounts[entry.foodName] = (foodCounts[entry.foodName] ?? 0) + 1;
    }

    final sortedFoods = foodCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topFoods = sortedFoods.take(5).map((e) => e.key).toList();

    // Macro distribution
    final totalProtein = entries.map((e) => e.protein).reduce((a, b) => a + b);
    final totalCarbs = entries.map((e) => e.carbs).reduce((a, b) => a + b);
    final totalFat = entries.map((e) => e.fat).reduce((a, b) => a + b);
    final totalMacros = totalProtein + totalCarbs + totalFat;

    final macroDistribution = <String, double>{
      'Protein': totalMacros > 0 ? (totalProtein / totalMacros * 100) : 0.0,
      'Carbs': totalMacros > 0 ? (totalCarbs / totalMacros * 100) : 0.0,
      'Fat': totalMacros > 0 ? (totalFat / totalMacros * 100) : 0.0,
    };

    // Generate insights
    final insights = <String>[];
    
    if (averageDailyCalories < 1200) {
      insights.add('Daily calorie intake is quite low. Consider adding healthy snacks.');
    } else if (averageDailyCalories > 2500) {
      insights.add('Daily calorie intake is high. Consider portion control.');
    }

    if (macroDistribution['Protein']! < 15) {
      insights.add('Protein intake is low. Add more protein-rich foods.');
    }

    if (macroDistribution['Fat']! < 20) {
      insights.add('Fat intake is low. Include healthy fats like nuts and avocado.');
    }

    // Overall trend analysis
    String overallTrend = 'stable';
    if (dailySummaries.length >= 7) {
      final recent = dailySummaries.take(3).map((s) => s.totalCalories).reduce((a, b) => a + b) / 3;
      final older = dailySummaries.skip(4).map((s) => s.totalCalories).reduce((a, b) => a + b) / 3;
      
      if (recent > older * 1.1) {
        overallTrend = 'improving';
      } else if (recent < older * 0.9) {
        overallTrend = 'declining';
      }
    }

    return EatingHabitAnalysis(
      averageDailyCalories: averageDailyCalories.toDouble(),
      averageMealFrequency: averageMealFrequency.toDouble(),
      mostEatenMeal: mostEatenMeal,
      leastEatenMeal: leastEatenMeal,
      topFoods: topFoods,
      macroDistribution: macroDistribution,
      insights: insights,
      overallTrend: overallTrend,
    );
  }

  // Calculate diet adherence score
  static Future<DietAdherenceScore> calculateAdherenceScore(DateTime date) async {
    final summary = await getDailyNutritionSummary(date);
    
    if (summary == null) {
      return DietAdherenceScore(
        date: date,
        adherencePercentage: 0,
        mealsLogged: 0,
        mealsPlanned: 3, // Assuming 3 meals per day
        calorieAdherence: 0,
        macroAdherence: 0,
        feedback: 'No meals logged for this day',
        improvements: ['Start logging your meals to track adherence'],
      );
    }

    // Calculate meal adherence (assuming 3 meals per day)
    final mealAdherence = (summary.mealCount / 3) * 100;
    
    // Calculate calorie adherence (assuming 2000 calorie target)
    final calorieTarget = 2000.0;
    var calorieAdherence = (summary.totalCalories / calorieTarget) * 100;
    if (calorieAdherence > 100) calorieAdherence = 100; // Cap at 100%
    
    // Calculate macro adherence (ideal ratios: 25% protein, 45% carbs, 30% fat)
    final totalMacros = summary.totalProtein + summary.totalCarbs + summary.totalFat;
    double macroAdherence = 0;
    
    if (totalMacros > 0) {
      final proteinRatio = (summary.totalProtein / totalMacros) * 100;
      final carbsRatio = (summary.totalCarbs / totalMacros) * 100;
      final fatRatio = (summary.totalFat / totalMacros) * 100;
      
      final proteinScore = 100 - (proteinRatio - 25).abs() * 2;
      final carbsScore = 100 - (carbsRatio - 45).abs() * 2;
      final fatScore = 100 - (fatRatio - 30).abs() * 2;
      
      macroAdherence = (proteinScore + carbsScore + fatScore) / 3;
    }

    // Overall adherence score
    final overallAdherence = (mealAdherence * 0.3 + calorieAdherence * 0.4 + macroAdherence * 0.3);

    // Generate feedback and improvements
    final feedback = _generateFeedback(overallAdherence, calorieAdherence, macroAdherence);
    final improvements = _generateImprovements(summary, overallAdherence);

    return DietAdherenceScore(
      date: date,
      adherencePercentage: overallAdherence,
      mealsLogged: summary.mealCount,
      mealsPlanned: 3,
      calorieAdherence: calorieAdherence,
      macroAdherence: macroAdherence,
      feedback: feedback,
      improvements: improvements,
    );
  }

  static String _generateFeedback(double overall, double calorie, double macro) {
    if (overall >= 80) {
      return 'Excellent adherence to your diet plan!';
    } else if (overall >= 60) {
      return 'Good adherence with room for improvement.';
    } else if (overall >= 40) {
      return 'Moderate adherence. Focus on consistency.';
    } else {
      return 'Low adherence. Consider reviewing your meal plan.';
    }
  }

  static List<String> _generateImprovements(DailyNutritionSummary summary, double adherence) {
    final improvements = <String>[];
    
    if (summary.totalCalories < 1500) {
      improvements.add('Increase calorie intake with healthy snacks');
    } else if (summary.totalCalories > 2500) {
      improvements.add('Reduce portion sizes to meet calorie goals');
    }
    
    if (summary.totalProtein < 40) {
      improvements.add('Add more protein-rich foods to your meals');
    }
    
    if (summary.totalFiber < 25) {
      improvements.add('Include more fiber-rich foods like vegetables and whole grains');
    }
    
    if (summary.totalSodium > 2300) {
      improvements.add('Reduce sodium intake by choosing low-sodium options');
    }
    
    if (summary.mealCount < 3) {
      improvements.add('Try to eat regular meals throughout the day');
    }
    
    return improvements;
  }

  // Delete diet entry
  static Future<bool> deleteDietEntry(String entryId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingEntries = await getDietHistory();
      
      existingEntries.removeWhere((entry) => entry.id == entryId);
      
      final entriesJson = existingEntries.map((e) => e.toJson()).toList();
      await prefs.setString(_dietHistoryKey, jsonEncode(entriesJson));
      
      return true;
    } catch (e) {
      print('Error deleting diet entry: $e');
      return false;
    }
  }

  // Clear all diet history
  static Future<bool> clearAllHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_dietHistoryKey);
      return true;
    } catch (e) {
      print('Error clearing diet history: $e');
      return false;
    }
  }
}
