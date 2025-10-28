import 'package:shared_preferences/shared_preferences.dart';
import 'nutrition_tracking_service.dart';
import 'diet_history_service.dart';
import '../models/diet_history.dart';

class NutritionIntegrationService {
  // Sync diet history with nutrition tracking for today
  static Future<void> syncTodayWithDietHistory() async {
    try {
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      
      // Get today's diet history entries
      final dietEntries = await DietHistoryService.getDietHistoryForRange(todayDate, todayDate);
      
      if (dietEntries.isEmpty) {
        print('No diet history entries for today');
        return;
      }
      
      // Calculate totals from diet history
      double totalCalories = 0;
      double totalProtein = 0;
      double totalCarbs = 0;
      double totalFat = 0;
      
      for (final entry in dietEntries) {
        totalCalories += entry.calories;
        totalProtein += entry.protein;
        totalCarbs += entry.carbs;
        totalFat += entry.fat;
      }
      
      // Get or create today's nutrition log
      DailyNutritionLog? todayLog = await NutritionTrackingService.getTodayLog();
      if (todayLog == null) {
        todayLog = DailyNutritionLog.empty();
      }
      
      // Update nutrition log with diet history data
      todayLog.calories = totalCalories.round();
      todayLog.protein = totalProtein.round();
      todayLog.carbs = totalCarbs.round();
      todayLog.fat = totalFat.round();
      
      // Convert diet history entries to nutrition entries
      final nutritionEntries = dietEntries.map((dietEntry) => NutritionEntry(
        id: dietEntry.id,
        name: dietEntry.foodName,
        mealType: dietEntry.mealType,
        calories: dietEntry.calories.round(),
        protein: dietEntry.protein.round(),
        carbs: dietEntry.carbs.round(),
        fat: dietEntry.fat.round(),
        timestamp: dietEntry.loggedAt,
        description: dietEntry.notes ?? 'Logged from diet history',
      )).toList();
      
      // Update entries in nutrition log
      todayLog.entries = nutritionEntries;
      
      // Save updated nutrition log
      await NutritionTrackingService.saveTodayLog(todayLog);
      
      print('Synced ${dietEntries.length} diet history entries with nutrition tracking');
    } catch (e) {
      print('Error syncing diet history with nutrition tracking: $e');
    }
  }
  
  // Get combined nutrition data for today (diet history + manual entries)
  static Future<DailyNutritionLog> getCombinedTodayLog() async {
    try {
      // First sync diet history
      await syncTodayWithDietHistory();
      
      // Get the updated nutrition log
      final todayLog = await NutritionTrackingService.getTodayLog();
      return todayLog ?? DailyNutritionLog.empty();
    } catch (e) {
      print('Error getting combined today log: $e');
      return DailyNutritionLog.empty();
    }
  }
  
  // Get combined nutrition data for a specific date
  static Future<DailyNutritionLog> getCombinedLogForDate(DateTime date) async {
    try {
      final dateOnly = DateTime(date.year, date.month, date.day);
      
      // Get diet history entries for the date
      final dietEntries = await DietHistoryService.getDietHistoryForRange(dateOnly, dateOnly);
      
      // Calculate totals from diet history
      double totalCalories = 0;
      double totalProtein = 0;
      double totalCarbs = 0;
      double totalFat = 0;
      
      for (final entry in dietEntries) {
        totalCalories += entry.calories;
        totalProtein += entry.protein;
        totalCarbs += entry.carbs;
        totalFat += entry.fat;
      }
      
      // Convert diet history entries to nutrition entries
      final nutritionEntries = dietEntries.map((dietEntry) => NutritionEntry(
        id: dietEntry.id,
        name: dietEntry.foodName,
        mealType: dietEntry.mealType,
        calories: dietEntry.calories.round(),
        protein: dietEntry.protein.round(),
        carbs: dietEntry.carbs.round(),
        fat: dietEntry.fat.round(),
        timestamp: dietEntry.loggedAt,
        description: dietEntry.notes ?? 'Logged from diet history',
      )).toList();
      
      // Create combined nutrition log
      return DailyNutritionLog(
        date: dateOnly,
        calories: totalCalories.round(),
        protein: totalProtein.round(),
        carbs: totalCarbs.round(),
        fat: totalFat.round(),
        entries: nutritionEntries,
      );
    } catch (e) {
      print('Error getting combined log for date: $e');
      return DailyNutritionLog.empty();
    }
  }
  
  // Get combined weekly summary including diet history
  static Future<WeeklyNutritionSummary> getCombinedWeeklySummary() async {
    try {
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      
      final List<DailyNutritionLog> logs = [];
      
      // Get combined logs for each day of the week
      for (int i = 0; i < 7; i++) {
        final date = weekStart.add(Duration(days: i));
        final log = await getCombinedLogForDate(date);
        logs.add(log);
      }
      
      return WeeklyNutritionSummary.fromLogs(logs);
    } catch (e) {
      print('Error getting combined weekly summary: $e');
      return WeeklyNutritionSummary.empty();
    }
  }
  
  // Add a new diet history entry and sync with nutrition tracking
  static Future<bool> addDietEntryAndSync(DietHistoryEntry entry) async {
    try {
      // Save to diet history
      final success = await DietHistoryService.saveDietEntry(entry);
      
      if (success) {
        // Sync with nutrition tracking
        await syncTodayWithDietHistory();
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error adding diet entry and syncing: $e');
      return false;
    }
  }
  
  // Remove a diet history entry and sync with nutrition tracking
  static Future<bool> removeDietEntryAndSync(String entryId) async {
    try {
      // Remove from diet history
      final success = await DietHistoryService.deleteDietEntry(entryId);
      
      if (success) {
        // Sync with nutrition tracking
        await syncTodayWithDietHistory();
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error removing diet entry and syncing: $e');
      return false;
    }
  }
  
  // Get nutrition breakdown by meal type for today
  static Future<Map<String, Map<String, int>>> getTodayMealBreakdown() async {
    try {
      final todayLog = await getCombinedTodayLog();
      final Map<String, Map<String, int>> breakdown = {};
      
      for (final entry in todayLog.entries) {
        if (!breakdown.containsKey(entry.mealType)) {
          breakdown[entry.mealType] = {
            'calories': 0,
            'protein': 0,
            'carbs': 0,
            'fat': 0,
          };
        }
        
        breakdown[entry.mealType]!['calories'] = 
            (breakdown[entry.mealType]!['calories']! + entry.calories);
        breakdown[entry.mealType]!['protein'] = 
            (breakdown[entry.mealType]!['protein']! + entry.protein);
        breakdown[entry.mealType]!['carbs'] = 
            (breakdown[entry.mealType]!['carbs']! + entry.carbs);
        breakdown[entry.mealType]!['fat'] = 
            (breakdown[entry.mealType]!['fat']! + entry.fat);
      }
      
      return breakdown;
    } catch (e) {
      print('Error getting meal breakdown: $e');
      return {};
    }
  }
  
  // Check if there are any diet history entries for today
  static Future<bool> hasDietHistoryForToday() async {
    try {
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final dietEntries = await DietHistoryService.getDietHistoryForRange(todayDate, todayDate);
      return dietEntries.isNotEmpty;
    } catch (e) {
      print('Error checking diet history for today: $e');
      return false;
    }
  }
  
  // Get the last sync timestamp
  static Future<DateTime?> getLastSyncTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getString('last_nutrition_sync');
      return timestamp != null ? DateTime.parse(timestamp) : null;
    } catch (e) {
      print('Error getting last sync time: $e');
      return null;
    }
  }
  
  // Set the last sync timestamp
  static Future<void> setLastSyncTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_nutrition_sync', DateTime.now().toIso8601String());
    } catch (e) {
      print('Error setting last sync time: $e');
    }
  }
  
  // Auto-sync if needed (sync if last sync was more than 1 hour ago)
  static Future<void> autoSyncIfNeeded() async {
    try {
      final lastSync = await getLastSyncTime();
      final now = DateTime.now();
      
      if (lastSync == null || now.difference(lastSync).inHours >= 1) {
        await syncTodayWithDietHistory();
        await setLastSyncTime();
        print('Auto-synced nutrition data');
      }
    } catch (e) {
      print('Error in auto-sync: $e');
    }
  }
}
