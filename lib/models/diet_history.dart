class DietHistoryEntry {
  final String id;
  final DateTime date;
  final String mealType; // breakfast, lunch, dinner, snack
  final String foodName;
  final double quantity;
  final String unit;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;
  final DateTime loggedAt;
  final String? notes;

  DietHistoryEntry({
    required this.id,
    required this.date,
    required this.mealType,
    required this.foodName,
    required this.quantity,
    required this.unit,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.loggedAt,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mealType': mealType,
      'foodName': foodName,
      'quantity': quantity,
      'unit': unit,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'loggedAt': loggedAt.toIso8601String(),
      'notes': notes,
    };
  }

  factory DietHistoryEntry.fromJson(Map<String, dynamic> json) {
    return DietHistoryEntry(
      id: json['id'],
      date: DateTime.parse(json['date']),
      mealType: json['mealType'],
      foodName: json['foodName'],
      quantity: json['quantity'].toDouble(),
      unit: json['unit'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      carbs: json['carbs'].toDouble(),
      fat: json['fat'].toDouble(),
      fiber: json['fiber'].toDouble(),
      sugar: json['sugar'].toDouble(),
      sodium: json['sodium'].toDouble(),
      loggedAt: DateTime.parse(json['loggedAt']),
      notes: json['notes'],
    );
  }
}

class DailyNutritionSummary {
  final DateTime date;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final double totalFiber;
  final double totalSugar;
  final double totalSodium;
  final List<DietHistoryEntry> entries;
  final int mealCount;

  DailyNutritionSummary({
    required this.date,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalFiber,
    required this.totalSugar,
    required this.totalSodium,
    required this.entries,
    required this.mealCount,
  });

  double get caloriesPercentage => (totalCalories / 2000) * 100; // Assuming 2000 as daily target
  double get proteinPercentage => (totalProtein / 50) * 100; // Assuming 50g as daily target
  double get carbsPercentage => (totalCarbs / 250) * 100; // Assuming 250g as daily target
  double get fatPercentage => (totalFat / 65) * 100; // Assuming 65g as daily target
}

class DietAdherenceScore {
  final DateTime date;
  final double adherencePercentage;
  final int mealsLogged;
  final int mealsPlanned;
  final double calorieAdherence;
  final double macroAdherence;
  final String feedback;
  final List<String> improvements;

  DietAdherenceScore({
    required this.date,
    required this.adherencePercentage,
    required this.mealsLogged,
    required this.mealsPlanned,
    required this.calorieAdherence,
    required this.macroAdherence,
    required this.feedback,
    required this.improvements,
  });
}

class EatingHabitAnalysis {
  final double averageDailyCalories;
  final double averageMealFrequency;
  final String mostEatenMeal;
  final String leastEatenMeal;
  final List<String> topFoods;
  final Map<String, double> macroDistribution;
  final List<String> insights;
  final String overallTrend; // improving, declining, stable

  EatingHabitAnalysis({
    required this.averageDailyCalories,
    required this.averageMealFrequency,
    required this.mostEatenMeal,
    required this.leastEatenMeal,
    required this.topFoods,
    required this.macroDistribution,
    required this.insights,
    required this.overallTrend,
  });
}

class NutritionTrend {
  final DateTime date;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  NutritionTrend({
    required this.date,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}
