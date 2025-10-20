class User {
  final int id;
  final String name;
  final String email;
  final String? gender;
  final int? heightCm;
  final double? weightKg;
  final double? targetWeightKg;
  final DateTime? birthDate;
  final String? activityLevel;
  final String? dietaryGoal;
  final List<String> healthConditions;
  final List<String> dietaryRestrictions;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.targetWeightKg,
    this.birthDate,
    this.activityLevel,
    this.dietaryGoal,
    required this.healthConditions,
    required this.dietaryRestrictions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'],
      heightCm: json['height_cm'],
      weightKg: json['weight_kg']?.toDouble(),
      targetWeightKg: json['target_weight_kg']?.toDouble(),
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      activityLevel: json['activity_level'],
      dietaryGoal: json['dietary_goal'],
      healthConditions: List<String>.from(json['health_conditions'] ?? []),
      dietaryRestrictions: List<String>.from(json['dietary_restrictions'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'target_weight_kg': targetWeightKg,
      'birth_date': birthDate?.toIso8601String(),
      'activity_level': activityLevel,
      'dietary_goal': dietaryGoal,
      'health_conditions': healthConditions,
      'dietary_restrictions': dietaryRestrictions,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  int? get age {
    if (birthDate == null) return null;
    return DateTime.now().year - birthDate!.year;
  }

  double? get bmi {
    if (heightCm == null || weightKg == null) return null;
    double heightInMeters = heightCm! / 100;
    return weightKg! / (heightInMeters * heightInMeters);
  }

  String? get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue == null) return null;
    
    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }

  double? get weightToLose {
    if (weightKg == null || targetWeightKg == null) return null;
    return weightKg! - targetWeightKg!;
  }

  bool get hasHealthConditions => healthConditions.isNotEmpty;
  bool get hasDietaryRestrictions => dietaryRestrictions.isNotEmpty;
}
