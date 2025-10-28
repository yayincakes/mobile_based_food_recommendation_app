import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NutritionTrackingService {
  // Daily nutrition log model
  static Future<DailyNutritionLog?> getTodayLog() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = _getTodayKey();
      final logJson = prefs.getString('nutrition_log_$today');
      
      if (logJson != null) {
        final logData = json.decode(logJson);
        return DailyNutritionLog.fromJson(logData);
      }
      
      return null;
    } catch (e) {
      print('Error getting today\'s nutrition log: $e');
      return null;
    }
  }
  
  // Save daily nutrition log
  static Future<bool> saveTodayLog(DailyNutritionLog log) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = _getTodayKey();
      final logJson = json.encode(log.toJson());
      
      await prefs.setString('nutrition_log_$today', logJson);
      return true;
    } catch (e) {
      print('Error saving nutrition log: $e');
      return false;
    }
  }
  
  // Add nutrition entry to today's log
  static Future<bool> addNutritionEntry(NutritionEntry entry) async {
    try {
      final todayLog = await getTodayLog() ?? DailyNutritionLog.empty();
      todayLog.addEntry(entry);
      return await saveTodayLog(todayLog);
    } catch (e) {
      print('Error adding nutrition entry: $e');
      return false;
    }
  }
  
  // Update specific nutrition values
  static Future<bool> updateNutritionValues({
    int? calories,
    int? protein,
    int? carbs,
    int? fat,
    int? water,
    int? steps,
    int? sleep,
    int? workoutMinutes,
  }) async {
    try {
      final todayLog = await getTodayLog() ?? DailyNutritionLog.empty();
      
      if (calories != null) todayLog.calories = calories;
      if (protein != null) todayLog.protein = protein;
      if (carbs != null) todayLog.carbs = carbs;
      if (fat != null) todayLog.fat = fat;
      if (water != null) todayLog.water = water;
      if (steps != null) todayLog.steps = steps;
      if (sleep != null) todayLog.sleep = sleep;
      if (workoutMinutes != null) todayLog.workoutMinutes = workoutMinutes;
      
      return await saveTodayLog(todayLog);
    } catch (e) {
      print('Error updating nutrition values: $e');
      return false;
    }
  }
  
  // Get nutrition logs for a specific date range
  static Future<List<DailyNutritionLog>> getLogsForDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<DailyNutritionLog> logs = [];
      
      DateTime currentDate = startDate;
      while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
        final dateKey = _getDateKey(currentDate);
        final logJson = prefs.getString('nutrition_log_$dateKey');
        
        if (logJson != null) {
          final logData = json.decode(logJson);
          logs.add(DailyNutritionLog.fromJson(logData));
        }
        
        currentDate = currentDate.add(const Duration(days: 1));
      }
      
      return logs;
    } catch (e) {
      print('Error getting logs for date range: $e');
      return [];
    }
  }
  
  // Get weekly nutrition summary
  static Future<WeeklyNutritionSummary> getWeeklySummary() async {
    try {
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 6));
      
      final logs = await getLogsForDateRange(weekStart, weekEnd);
      
      return WeeklyNutritionSummary.fromLogs(logs);
    } catch (e) {
      print('Error getting weekly summary: $e');
      return WeeklyNutritionSummary.empty();
    }
  }
  
  // Helper methods
  static String _getTodayKey() {
    return _getDateKey(DateTime.now());
  }
  
  static String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  
  // Get today's log with diet history integration
  static Future<DailyNutritionLog?> getTodayLogWithDietHistory() async {
    try {
      // This will be used by the integration service
      return await getTodayLog();
    } catch (e) {
      print('Error getting today\'s log with diet history: $e');
      return null;
    }
  }
  
  
  // Clear old logs (keep last 30 days)
  static Future<void> cleanupOldLogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final cutoffDate = DateTime.now().subtract(const Duration(days: 30));
      
      for (String key in keys) {
        if (key.startsWith('nutrition_log_')) {
          final dateStr = key.replaceFirst('nutrition_log_', '');
          try {
            final date = DateTime.parse(dateStr);
            if (date.isBefore(cutoffDate)) {
              await prefs.remove(key);
            }
          } catch (e) {
            // Invalid date format, remove the key
            await prefs.remove(key);
          }
        }
      }
    } catch (e) {
      print('Error cleaning up old logs: $e');
    }
  }
}

// Daily nutrition log model
class DailyNutritionLog {
  DateTime date;
  int calories;
  int protein;
  int carbs;
  int fat;
  int water; // glasses
  int steps;
  int sleep; // hours
  int workoutMinutes;
  List<NutritionEntry> entries;
  
  DailyNutritionLog({
    required this.date,
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.water = 0,
    this.steps = 0,
    this.sleep = 0,
    this.workoutMinutes = 0,
    this.entries = const [],
  });
  
  factory DailyNutritionLog.empty() {
    return DailyNutritionLog(date: DateTime.now());
  }
  
  factory DailyNutritionLog.fromJson(Map<String, dynamic> json) {
    return DailyNutritionLog(
      date: DateTime.parse(json['date']),
      calories: json['calories'] ?? 0,
      protein: json['protein'] ?? 0,
      carbs: json['carbs'] ?? 0,
      fat: json['fat'] ?? 0,
      water: json['water'] ?? 0,
      steps: json['steps'] ?? 0,
      sleep: json['sleep'] ?? 0,
      workoutMinutes: json['workoutMinutes'] ?? 0,
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) => NutritionEntry.fromJson(e))
          .toList() ?? [],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'water': water,
      'steps': steps,
      'sleep': sleep,
      'workoutMinutes': workoutMinutes,
      'entries': entries.map((e) => e.toJson()).toList(),
    };
  }
  
  void addEntry(NutritionEntry entry) {
    entries.add(entry);
    calories += entry.calories;
    protein += entry.protein;
    carbs += entry.carbs;
    fat += entry.fat;
  }
  
  void removeEntry(NutritionEntry entry) {
    entries.remove(entry);
    calories -= entry.calories;
    protein -= entry.protein;
    carbs -= entry.carbs;
    fat -= entry.fat;
  }
}

// Individual nutrition entry model
class NutritionEntry {
  String id;
  String name;
  String mealType; // breakfast, lunch, dinner, snack
  int calories;
  int protein;
  int carbs;
  int fat;
  DateTime timestamp;
  String? description;
  
  NutritionEntry({
    required this.id,
    required this.name,
    required this.mealType,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.timestamp,
    this.description,
  });
  
  factory NutritionEntry.fromJson(Map<String, dynamic> json) {
    return NutritionEntry(
      id: json['id'],
      name: json['name'],
      mealType: json['mealType'],
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      timestamp: DateTime.parse(json['timestamp']),
      description: json['description'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mealType': mealType,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
    };
  }
}

// Weekly nutrition summary model
class WeeklyNutritionSummary {
  DateTime weekStart;
  DateTime weekEnd;
  int totalCalories;
  int totalProtein;
  int totalCarbs;
  int totalFat;
  int totalWater;
  int totalSteps;
  double averageSleep;
  int totalWorkoutMinutes;
  int daysLogged;
  
  WeeklyNutritionSummary({
    required this.weekStart,
    required this.weekEnd,
    this.totalCalories = 0,
    this.totalProtein = 0,
    this.totalCarbs = 0,
    this.totalFat = 0,
    this.totalWater = 0,
    this.totalSteps = 0,
    this.averageSleep = 0.0,
    this.totalWorkoutMinutes = 0,
    this.daysLogged = 0,
  });
  
  factory WeeklyNutritionSummary.empty() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return WeeklyNutritionSummary(
      weekStart: weekStart,
      weekEnd: weekStart.add(const Duration(days: 6)),
    );
  }
  
  factory WeeklyNutritionSummary.fromLogs(List<DailyNutritionLog> logs) {
    if (logs.isEmpty) {
      return WeeklyNutritionSummary.empty();
    }
    
    final weekStart = logs.first.date;
    final weekEnd = logs.last.date;
    
    int totalCalories = 0;
    int totalProtein = 0;
    int totalCarbs = 0;
    int totalFat = 0;
    int totalWater = 0;
    int totalSteps = 0;
    double totalSleep = 0.0;
    int totalWorkoutMinutes = 0;
    
    for (final log in logs) {
      totalCalories += log.calories;
      totalProtein += log.protein;
      totalCarbs += log.carbs;
      totalFat += log.fat;
      totalWater += log.water;
      totalSteps += log.steps;
      totalSleep += log.sleep;
      totalWorkoutMinutes += log.workoutMinutes;
    }
    
    return WeeklyNutritionSummary(
      weekStart: weekStart,
      weekEnd: weekEnd,
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbs: totalCarbs,
      totalFat: totalFat,
      totalWater: totalWater,
      totalSteps: totalSteps,
      averageSleep: logs.isNotEmpty ? totalSleep / logs.length : 0.0,
      totalWorkoutMinutes: totalWorkoutMinutes,
      daysLogged: logs.length,
    );
  }
}
