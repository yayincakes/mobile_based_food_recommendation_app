
class UserProfile {
  final String name;
  final String email;
  final double? height;
  final double? weight;
  final String? gender;
  final DateTime? birthDate;
  final String? activityLevel;
  final List<DietaryGoal> dietaryGoals;
  final List<HealthCondition> healthConditions;
  final List<Allergy> allergies;
  final List<MealPlan> mealPlans;
  final List<String> preferences; // User preferences like 'Filipino', 'Vegetarian', etc.
  final String goal; // Primary goal: 'Weight loss', 'Weight gain', 'Muscle gain', 'Maintenance'
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.name,
    required this.email,
    this.height,
    this.weight,
    this.gender,
    this.birthDate,
    this.activityLevel,
    required this.dietaryGoals,
    required this.healthConditions,
    required this.allergies,
    required this.mealPlans,
    required this.preferences,
    required this.goal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      gender: json['gender'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      activityLevel: json['activity_level'],
      dietaryGoals: (json['dietary_goals'] as List<dynamic>?)
          ?.map((goal) => DietaryGoal.fromJson(goal))
          .toList() ?? [],
      healthConditions: (json['health_conditions'] as List<dynamic>?)
          ?.map((condition) => HealthCondition.fromJson(condition))
          .toList() ?? [],
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((allergy) => Allergy.fromJson(allergy))
          .toList() ?? [],
      mealPlans: (json['meal_plans'] as List<dynamic>?)
          ?.map((plan) => MealPlan.fromJson(plan))
          .toList() ?? [],
      preferences: (json['preferences'] as List<dynamic>?)
          ?.map((pref) => pref.toString())
          .toList() ?? [],
      goal: json['goal'] ?? 'Maintenance',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'gender': gender,
      'birth_date': birthDate?.toIso8601String(),
      'activity_level': activityLevel,
      'dietary_goals': dietaryGoals.map((goal) => goal.toJson()).toList(),
      'health_conditions': healthConditions.map((condition) => condition.toJson()).toList(),
      'allergies': allergies.map((allergy) => allergy.toJson()).toList(),
      'meal_plans': mealPlans.map((plan) => plan.toJson()).toList(),
      'preferences': preferences,
      'goal': goal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  double? get bmi {
    if (height == null || weight == null) return null;
    double heightInMeters = height! / 100;
    return weight! / (heightInMeters * heightInMeters);
  }

  String? get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue == null) return null;
    
    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }

  int? get age {
    if (birthDate == null) return null;
    return DateTime.now().year - birthDate!.year;
  }

  DietaryGoal? get currentGoal {
    return dietaryGoals.isNotEmpty ? dietaryGoals.first : null;
  }
}

class DietaryGoal {
  final String id;
  final String name;
  final String description;
  final String type; // 'weight_loss', 'weight_gain', 'maintenance', 'muscle_building', 'endurance'
  final double? targetWeight;
  final double? targetCalories;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  DietaryGoal({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.targetWeight,
    this.targetCalories,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DietaryGoal.fromJson(Map<String, dynamic> json) {
    return DietaryGoal(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      targetWeight: json['target_weight']?.toDouble(),
      targetCalories: json['target_calories']?.toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'target_weight': targetWeight,
      'target_calories': targetCalories,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class HealthCondition {
  final String id;
  final String name;
  final String description;
  final String severity; // 'mild', 'moderate', 'severe'
  final DateTime diagnosedDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  HealthCondition({
    required this.id,
    required this.name,
    required this.description,
    required this.severity,
    required this.diagnosedDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HealthCondition.fromJson(Map<String, dynamic> json) {
    return HealthCondition(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? 'mild',
      diagnosedDate: DateTime.parse(json['diagnosed_date']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'severity': severity,
      'diagnosed_date': diagnosedDate.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Allergy {
  final String id;
  final String name;
  final String type; // 'food', 'medication', 'environmental', 'other'
  final String severity; // 'mild', 'moderate', 'severe', 'life_threatening'
  final String? symptoms;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Allergy({
    required this.id,
    required this.name,
    required this.type,
    required this.severity,
    this.symptoms,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? 'food',
      severity: json['severity'] ?? 'mild',
      symptoms: json['symptoms'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'severity': severity,
      'symptoms': symptoms,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Simplified MealPlan for profile management
class MealPlan {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final List<String> mealPreferences;
  final int mealsPerDay;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.mealPreferences = const [],
    this.mealsPerDay = 3,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      isActive: json['is_active'] ?? true,
      mealPreferences: (json['meal_preferences'] as List<dynamic>?)
          ?.map((pref) => pref.toString())
          .toList() ?? [],
      mealsPerDay: json['meals_per_day'] ?? 3,
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
      'is_active': isActive,
      'meal_preferences': mealPreferences,
      'meals_per_day': mealsPerDay,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
