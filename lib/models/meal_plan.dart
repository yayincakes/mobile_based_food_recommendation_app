import 'recipe.dart';

class MealPlan {
  final int id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int userId;
  final List<MealPlanItem> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      userId: json['user_id'] ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => MealPlanItem.fromJson(item))
          .toList() ?? [],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  int get durationInDays {
    return endDate.difference(startDate).inDays + 1;
  }

  List<MealPlanItem> getItemsForDay(int day) {
    return items.where((item) => item.day == day).toList();
  }

  List<MealPlanItem> getItemsForMealType(String mealType) {
    return items.where((item) => item.mealType == mealType).toList();
  }

  double get totalCalories {
    return items.fold(0.0, (sum, item) => sum + (item.recipe.caloriesPerServing * item.servings));
  }

  double get totalProtein {
    return items.fold(0.0, (sum, item) => sum + (item.recipe.proteinPerServing * item.servings));
  }

  double get totalCarbs {
    return items.fold(0.0, (sum, item) => sum + (item.recipe.carbsPerServing * item.servings));
  }

  double get totalFat {
    return items.fold(0.0, (sum, item) => sum + (item.recipe.fatPerServing * item.servings));
  }
}

class MealPlanItem {
  final int id;
  final int mealPlanId;
  final Recipe recipe;
  final int day;
  final String mealType;
  final int servings;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealPlanItem({
    required this.id,
    required this.mealPlanId,
    required this.recipe,
    required this.day,
    required this.mealType,
    required this.servings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealPlanItem.fromJson(Map<String, dynamic> json) {
    return MealPlanItem(
      id: json['id'] ?? 0,
      mealPlanId: json['meal_plan_id'] ?? 0,
      recipe: Recipe.fromJson(json['recipe'] ?? {}),
      day: json['day'] ?? 1,
      mealType: json['meal_type'] ?? '',
      servings: json['servings'] ?? 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_plan_id': mealPlanId,
      'recipe': recipe.toJson(),
      'day': day,
      'meal_type': mealType,
      'servings': servings,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  double get totalCalories => recipe.caloriesPerServing.toDouble() * servings;
  double get totalProtein => recipe.proteinPerServing.toDouble() * servings;
  double get totalCarbs => recipe.carbsPerServing.toDouble() * servings;
  double get totalFat => recipe.fatPerServing.toDouble() * servings;
}
