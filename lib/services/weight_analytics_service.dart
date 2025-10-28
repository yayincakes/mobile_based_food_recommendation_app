import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_data_service.dart';
import 'eating_habit_analysis_service.dart';

class WeightAnalyticsService {
  static const String _weightLogsKey = 'weight_logs';

  // Log weight entry
  static Future<void> logWeight(double weight, String notes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateTime.now();
      final dateKey = _getDateKey(today);
      
      final weightEntry = {
        'weight': weight,
        'notes': notes,
        'timestamp': today.toIso8601String(),
        'dateKey': dateKey,
      };
      
      final logs = await getWeightLogs();
      logs.add(weightEntry);
      
      // Keep only last 90 days of logs
      final cutoffDate = DateTime.now().subtract(const Duration(days: 90));
      logs.removeWhere((log) {
        final logDate = DateTime.parse(log['timestamp']);
        return logDate.isBefore(cutoffDate);
      });
      
      await prefs.setString(_weightLogsKey, json.encode(logs));
    } catch (e) {
      print('Error logging weight: $e');
    }
  }

  // Get weight logs
  static Future<List<Map<String, dynamic>>> getWeightLogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logsJson = prefs.getString(_weightLogsKey);
      if (logsJson != null) {
        return List<Map<String, dynamic>>.from(json.decode(logsJson));
      }
      return [];
    } catch (e) {
      print('Error getting weight logs: $e');
      return [];
    }
  }

  // Get weight analytics
  static Future<WeightAnalytics> getWeightAnalytics() async {
    try {
      final userProfile = await UserDataService.getUserProfile();
      if (userProfile == null) {
        print('WeightAnalytics: No user profile found');
        return WeightAnalytics.empty();
      }

      print('WeightAnalytics: User profile found - ${userProfile.name}');
      final logs = await getWeightLogs();
      print('WeightAnalytics: Found ${logs.length} weight logs');
      
      // Use user profile weight as starting point if no logs exist
      // If user profile weight is 0 or null, use a default value
      final profileWeight = userProfile.weight > 0 ? userProfile.weight : 70.0;
      print('WeightAnalytics: Profile weight: $profileWeight');
      
      // Calculate weight based on eating habits if no manual logs exist
      final calculatedWeight = await _calculateWeightFromEatingHabits(userProfile, profileWeight);
      print('WeightAnalytics: Calculated weight: $calculatedWeight');
      
      final currentWeight = logs.isNotEmpty 
          ? logs.last['weight'] as double 
          : calculatedWeight;
      final startWeight = logs.isNotEmpty 
          ? logs.first['weight'] as double 
          : profileWeight;
      final weightChange = currentWeight - startWeight;
      final daysTracked = logs.length;

      // Sort logs by date if we have them
      if (logs.isNotEmpty) {
        logs.sort((a, b) => DateTime.parse(a['timestamp']).compareTo(DateTime.parse(b['timestamp'])));
      }

      // Calculate daily weight data for 1 month (will generate sample data based on eating habits)
      final dailyWeightData = await _calculateDailyWeightDataForMonth(logs, userProfile);
      print('WeightAnalytics: Generated ${dailyWeightData.length} daily weight data points');
      
      // Calculate trend (last 7 days vs previous 7 days)
      final trend = logs.length >= 14 ? _calculateTrend(logs) : WeightTrend.stable;

      // Get goal-based analytics
      final goalAnalytics = _getGoalAnalytics(userProfile.goal, currentWeight, userProfile.targetWeight);

      print('Weight Analytics Debug:');
      print('  Profile Weight: ${userProfile.weight}');
      print('  Calculated Weight: $calculatedWeight');
      print('  Current Weight: $currentWeight');
      print('  Start Weight: $startWeight');
      print('  Days Tracked: $daysTracked');
      print('  Goal: ${userProfile.goal}');
      print('  Target Weight: ${userProfile.targetWeight}');

      return WeightAnalytics(
        currentWeight: currentWeight,
        startWeight: startWeight,
        weightChange: weightChange,
        daysTracked: daysTracked,
        dailyWeightData: dailyWeightData,
        trend: trend,
        goalAnalytics: goalAnalytics,
        lastUpdated: logs.isNotEmpty 
            ? DateTime.parse(logs.last['timestamp'])
            : DateTime.now(),
      );
    } catch (e) {
      print('Error getting weight analytics: $e');
      return WeightAnalytics.empty();
    }
  }

  // Calculate weight based on eating habits
  static Future<double> _calculateWeightFromEatingHabits(UserProfileData userProfile, double baseWeight) async {
    try {
      // Only calculate weight changes if we have actual eating habit data
      final today = DateTime.now();
      final dateKey = EatingHabitAnalysisService.getDateKey(today);
      final analysis = await EatingHabitAnalysisService.analyzeEatingHabits(dateKey);
      
      // If no eating data exists, return the base weight
      if (analysis.totalCalories == 0) {
        print('No eating habit data found - using base weight');
        return baseWeight;
      }
      
      // Calculate daily calorie surplus/deficit based on user's goal
      final dailyTarget = _calculateCalorieTarget(baseWeight, userProfile.goal);
      final surplus = analysis.totalCalories - dailyTarget;
      
      // Convert calorie surplus to weight change
      // 1 kg = approximately 7700 calories
      final weightChangeFromCalories = surplus / 7700;
      
      // Apply weight change to base weight
      final calculatedWeight = baseWeight + weightChangeFromCalories;
      
      print('Weight Calculation from eating habits:');
      print('  Base Weight: $baseWeight');
      print('  Daily Calories: ${analysis.totalCalories}');
      print('  Daily Target: $dailyTarget');
      print('  Calorie Surplus: $surplus');
      print('  Weight Change: $weightChangeFromCalories');
      print('  Calculated Weight: $calculatedWeight');
      
      return calculatedWeight;
    } catch (e) {
      print('Error calculating weight from eating habits: $e');
      return baseWeight;
    }
  }

  // Calculate daily weight data for 1 month based on eating habits
  static Future<List<DailyWeightData>> _calculateDailyWeightDataForMonth(
      List<Map<String, dynamic>> logs, UserProfileData userProfile) async {
    final dailyData = <DailyWeightData>[];
    
    // If we have actual weight logs, use them
    if (logs.isNotEmpty) {
      // Sort logs by date
      logs.sort((a, b) => DateTime.parse(a['timestamp']).compareTo(DateTime.parse(b['timestamp'])));
      
      // Create daily data from actual logs
      final startDate = DateTime.parse(logs.first['timestamp']);
      final endDate = DateTime.now();
      final daysDiff = endDate.difference(startDate).inDays;
      
      // Generate data for each day from first log to today
      for (int i = 0; i <= daysDiff && i < 30; i++) {
        final date = startDate.add(Duration(days: i));
        
        // Find the closest log for this date
        double weight = userProfile.weight;
        for (final log in logs) {
          final logDate = DateTime.parse(log['timestamp']);
          if (logDate.year == date.year && 
              logDate.month == date.month && 
              logDate.day == date.day) {
            weight = log['weight'] as double;
            break;
          }
        }
        
        dailyData.add(DailyWeightData(
          date: date,
          weight: weight,
          hasData: true,
        ));
      }
      
      print('Daily Weight Data from logs: ${dailyData.length} days');
      return dailyData;
    }
    
    // If no logs exist, return empty list - no sample data
    print('No weight logs found - returning empty daily data');
    return [];
  }


  // Calculate trend (last 7 days vs previous 7 days)
  static WeightTrend _calculateTrend(List<Map<String, dynamic>> logs) {
    if (logs.length < 14) {
      return WeightTrend.stable;
    }

    final recentLogs = logs.length >= 7 ? logs.sublist(logs.length - 7) : logs;
    final previousLogs = logs.length >= 14 ? logs.sublist(logs.length - 14, logs.length - 7) : [];

    final recentAvg = recentLogs.map((log) => log['weight'] as double).reduce((a, b) => a + b) / recentLogs.length;
    final previousAvg = previousLogs.map((log) => log['weight'] as double).reduce((a, b) => a + b) / previousLogs.length;

    final change = recentAvg - previousAvg;
    
    if (change > 0.5) return WeightTrend.increasing;
    if (change < -0.5) return WeightTrend.decreasing;
    return WeightTrend.stable;
  }

  // Get goal-based analytics
  static GoalAnalytics _getGoalAnalytics(String goal, double currentWeight, double? targetWeight) {
    switch (goal.toLowerCase()) {
      case 'weight gain':
        final target = targetWeight ?? currentWeight + 5;
        final progress = targetWeight != null 
            ? ((currentWeight - (target - 5)) / 5 * 100).clamp(0, 100)
            : 0;
        return GoalAnalytics(
          goal: 'Weight Gain',
          targetWeight: target,
          progress: progress.toDouble(),
          dailyCalorieTarget: _calculateCalorieTarget(currentWeight, goal),
          recommendations: _getWeightGainRecommendations(),
        );
      case 'weight loss':
        final target = targetWeight ?? currentWeight - 5;
        final progress = targetWeight != null 
            ? (((target + 5) - currentWeight) / 5 * 100).clamp(0, 100)
            : 0;
        return GoalAnalytics(
          goal: 'Weight Loss',
          targetWeight: target,
          progress: progress.toDouble(),
          dailyCalorieTarget: _calculateCalorieTarget(currentWeight, goal),
          recommendations: _getWeightLossRecommendations(),
        );
      case 'maintenance':
        return GoalAnalytics(
          goal: 'Weight Maintenance',
          targetWeight: currentWeight,
          progress: 100,
          dailyCalorieTarget: _calculateCalorieTarget(currentWeight, goal),
          recommendations: _getMaintenanceRecommendations(),
        );
      default:
        return GoalAnalytics(
          goal: goal,
          targetWeight: currentWeight,
          progress: 0,
          dailyCalorieTarget: _calculateCalorieTarget(currentWeight, goal),
          recommendations: ['Set a specific goal to track your progress'],
        );
    }
  }

  // Calculate calorie target based on goal
  static int _calculateCalorieTarget(double weight, String goal) {
    final baseCalories = weight * 20; // Base calories per kg
    
    switch (goal.toLowerCase()) {
      case 'weight gain':
        return (baseCalories + 500).round(); // Surplus for weight gain
      case 'weight loss':
        return (baseCalories - 500).round(); // Deficit for weight loss
      case 'maintenance':
        return baseCalories.round();
      default:
        return baseCalories.round();
    }
  }

  // Get recommendations based on goal
  static List<String> _getWeightGainRecommendations() {
    return [
      'Eat 4 small meals throughout the day',
      'Include healthy fats like nuts and avocados',
      'Add protein to every meal',
      'Drink calorie-dense smoothies',
      'Track your calorie intake daily'
    ];
  }

  static List<String> _getWeightLossRecommendations() {
    return [
      'Create a calorie deficit of 500 calories daily',
      'Focus on lean proteins and vegetables',
      'Limit processed foods and sugars',
      'Stay hydrated with water',
      'Track your meals and portions'
    ];
  }

  static List<String> _getMaintenanceRecommendations() {
    return [
      'Maintain consistent eating patterns',
      'Balance macronutrients properly',
      'Stay active with regular exercise',
      'Monitor your weight weekly',
      'Adjust portions based on activity level'
    ];
  }

  // Helper methods
  static String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// Weight Analytics Model
class WeightAnalytics {
  final double currentWeight;
  final double startWeight;
  final double weightChange;
  final int daysTracked;
  final List<DailyWeightData> dailyWeightData;
  final WeightTrend trend;
  final GoalAnalytics goalAnalytics;
  final DateTime lastUpdated;

  WeightAnalytics({
    required this.currentWeight,
    required this.startWeight,
    required this.weightChange,
    required this.daysTracked,
    required this.dailyWeightData,
    required this.trend,
    required this.goalAnalytics,
    required this.lastUpdated,
  });

  factory WeightAnalytics.empty() {
    return WeightAnalytics(
      currentWeight: 0,
      startWeight: 0,
      weightChange: 0,
      daysTracked: 0,
      dailyWeightData: [],
      trend: WeightTrend.stable,
      goalAnalytics: GoalAnalytics.empty(),
      lastUpdated: DateTime.now(),
    );
  }
}

// Daily Weight Data
class DailyWeightData {
  final DateTime date;
  final double weight;
  final bool hasData;

  DailyWeightData({
    required this.date,
    required this.weight,
    required this.hasData,
  });
}

// Weight Trend Enum
enum WeightTrend {
  increasing,
  decreasing,
  stable,
}

// Goal Analytics
class GoalAnalytics {
  final String goal;
  final double targetWeight;
  final double progress;
  final int dailyCalorieTarget;
  final List<String> recommendations;

  GoalAnalytics({
    required this.goal,
    required this.targetWeight,
    required this.progress,
    required this.dailyCalorieTarget,
    required this.recommendations,
  });

  factory GoalAnalytics.empty() {
    return GoalAnalytics(
      goal: 'No Goal Set',
      targetWeight: 0,
      progress: 0,
      dailyCalorieTarget: 2000,
      recommendations: ['Set a goal to get started'],
    );
  }
}
