// Example usage of the nutrition integration service
// This shows how diet history entries now contribute to tracker progress

import '../services/nutrition_integration_service.dart';
import '../models/diet_history.dart';

class NutritionIntegrationExample {
  // Example: Add a diet history entry and see it reflected in tracker
  static Future<void> demonstrateIntegration() async {
    // Create a sample diet history entry
    final dietEntry = DietHistoryEntry(
      id: 'example-1',
      date: DateTime.now(),
      mealType: 'breakfast',
      foodName: 'Oatmeal with Banana',
      quantity: 1.0,
      unit: 'bowl',
      calories: 300.0,
      protein: 12.0,
      carbs: 55.0,
      fat: 6.0,
      fiber: 8.0,
      sugar: 15.0,
      sodium: 200.0,
      loggedAt: DateTime.now(),
      notes: 'Healthy breakfast option',
    );
    
    // Add the entry and sync with nutrition tracking
    await NutritionIntegrationService.addDietEntryAndSync(dietEntry);
    
    // Get combined today's log (includes diet history)
    final todayLog = await NutritionIntegrationService.getCombinedTodayLog();
    
    print('Today\'s combined nutrition:');
    print('Calories: ${todayLog.calories}');
    print('Protein: ${todayLog.protein}g');
    print('Carbs: ${todayLog.carbs}g');
    print('Fat: ${todayLog.fat}g');
    print('Entries: ${todayLog.entries.length}');
    
    // Get meal breakdown
    final mealBreakdown = await NutritionIntegrationService.getTodayMealBreakdown();
    print('Meal breakdown: $mealBreakdown');
  }
  
  // Example: Check if diet history exists for today
  static Future<void> checkDietHistoryStatus() async {
    final hasDietHistory = await NutritionIntegrationService.hasDietHistoryForToday();
    print('Has diet history for today: $hasDietHistory');
    
    if (hasDietHistory) {
      print('Diet history entries will be included in tracker progress!');
    } else {
      print('No diet history entries found for today.');
    }
  }
}
