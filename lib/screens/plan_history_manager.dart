// Enhanced plan history manager with data persistence and comprehensive functionality
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

class PlanHistoryManager {
  static final PlanHistoryManager _instance = PlanHistoryManager._internal();
  factory PlanHistoryManager() => _instance;
  PlanHistoryManager._internal();

  final List<UserMealPlan> _plans = [];
  final StreamController<List<UserMealPlan>> _plansController = 
      StreamController<List<UserMealPlan>>.broadcast();

  // Stream for listening to plan changes
  Stream<List<UserMealPlan>> get plansStream => _plansController.stream;
  
  // Get current plans (immutable copy)
  List<UserMealPlan> get plans => List.unmodifiable(_plans);
  
  // Get the current active plan (one plan per user)
  UserMealPlan? get activePlan => _plans.where((plan) => plan.status == PlanStatus.active).firstOrNull;
  
  // Get plans count
  int get count => _plans.length;
  
  // Check if plans is empty
  bool get isEmpty => _plans.isEmpty;
  bool get isNotEmpty => _plans.isNotEmpty;

  // Add a new meal plan (one plan per user - deactivates existing plans)
  String addPlan({
    required DateTime date,
    required String goal,
    required String activity,
    required double heightCm,
    required double weightKg,
    required Set<String> conditions,
    required Set<String> restrictions,
    double? targetWeight,
    String planMode = 'auto',
    String? planName,
  }) {
    try {
      // Deactivate all existing plans (one plan per user)
      for (int i = 0; i < _plans.length; i++) {
        if (_plans[i].status == PlanStatus.active) {
          _plans[i] = UserMealPlan(
            id: _plans[i].id,
            name: _plans[i].name,
            createdDate: _plans[i].createdDate,
            goal: _plans[i].goal,
            activityLevel: _plans[i].activityLevel,
            heightCm: _plans[i].heightCm,
            weightKg: _plans[i].weightKg,
            targetWeight: _plans[i].targetWeight,
            healthConditions: _plans[i].healthConditions,
            dietaryRestrictions: _plans[i].dietaryRestrictions,
            planMode: _plans[i].planMode,
            status: PlanStatus.completed, // Mark old plan as completed
            progress: _plans[i].progress,
            lastModified: DateTime.now(),
          );
        }
      }

      final planId = DateTime.now().millisecondsSinceEpoch.toString();
      final plan = UserMealPlan(
        id: planId,
        name: planName ?? _generatePlanName(goal, date),
        createdDate: date,
        goal: goal,
        activityLevel: activity,
        heightCm: heightCm,
        weightKg: weightKg,
        targetWeight: targetWeight,
        healthConditions: conditions.toList(),
        dietaryRestrictions: restrictions.toList(),
        planMode: planMode,
        status: PlanStatus.active,
        progress: PlanProgress.initial(),
      );

      _plans.insert(0, plan); // Add to beginning (most recent first)
      _notifyListeners();
      _persistPlans();
      
      if (kDebugMode) print('Added plan: ${plan.name} (deactivated ${_plans.length - 1} old plans)');
      return planId;
    } catch (e) {
      if (kDebugMode) print('Error adding plan: $e');
      return '';
    }
  }

  // Update an existing plan
  bool updatePlan(String planId, {
    String? name,
    String? goal,
    String? activityLevel,
    double? heightCm,
    double? weightKg,
    double? targetWeight,
    List<String>? healthConditions,
    List<String>? dietaryRestrictions,
    PlanStatus? status,
    PlanProgress? progress,
  }) {
    try {
      final index = _plans.indexWhere((p) => p.id == planId);
      if (index == -1) return false;

      final oldPlan = _plans[index];
      final updatedPlan = UserMealPlan(
        id: oldPlan.id,
        name: name ?? oldPlan.name,
        createdDate: oldPlan.createdDate,
        goal: goal ?? oldPlan.goal,
        activityLevel: activityLevel ?? oldPlan.activityLevel,
        heightCm: heightCm ?? oldPlan.heightCm,
        weightKg: weightKg ?? oldPlan.weightKg,
        targetWeight: targetWeight ?? oldPlan.targetWeight,
        healthConditions: healthConditions ?? oldPlan.healthConditions,
        dietaryRestrictions: dietaryRestrictions ?? oldPlan.dietaryRestrictions,
        planMode: oldPlan.planMode,
        status: status ?? oldPlan.status,
        progress: progress ?? oldPlan.progress,
        lastModified: DateTime.now(),
      );

      _plans[index] = updatedPlan;
      _notifyListeners();
      _persistPlans();
      
      if (kDebugMode) print('Updated plan: ${updatedPlan.name}');
      return true;
    } catch (e) {
      if (kDebugMode) print('Error updating plan: $e');
      return false;
    }
  }

  // Remove a plan
  bool removePlan(String planId) {
    try {
      final initialLength = _plans.length;
      _plans.removeWhere((p) => p.id == planId);
      
      final removed = _plans.length < initialLength;
      if (removed) {
        _notifyListeners();
        _persistPlans();
        if (kDebugMode) print('Removed plan with ID: $planId');
      }
      
      return removed;
    } catch (e) {
      if (kDebugMode) print('Error removing plan: $e');
      return false;
    }
  }

  // Get a specific plan by ID
  UserMealPlan? getPlan(String planId) {
    try {
      return _plans.firstWhere((p) => p.id == planId);
    } catch (e) {
      return null;
    }
  }

  // Get active plans
  List<UserMealPlan> getActivePlans() {
    return _plans.where((p) => p.status == PlanStatus.active).toList();
  }

  // Get plans by goal
  List<UserMealPlan> getPlansByGoal(String goal) {
    return _plans.where((p) => p.goal.toLowerCase() == goal.toLowerCase()).toList();
  }

  // Get recent plans
  List<UserMealPlan> getRecentPlans(int count) {
    return _plans.take(count).toList();
  }

  // Search plans
  List<UserMealPlan> searchPlans(String query) {
    if (query.trim().isEmpty) return plans;
    
    final lowerQuery = query.toLowerCase();
    return _plans.where((plan) {
      return plan.name.toLowerCase().contains(lowerQuery) ||
             plan.goal.toLowerCase().contains(lowerQuery) ||
             plan.healthConditions.any((condition) => 
                 condition.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  // Get statistics
  Map<String, dynamic> getStatistics() {
    if (_plans.isEmpty) {
      return {
        'totalPlans': 0,
        'activePlans': 0,
        'completedPlans': 0,
        'averageWeight': 0.0,
        'commonGoal': null,
        'commonCondition': null,
      };
    }

    final activePlans = _plans.where((p) => p.status == PlanStatus.active).length;
    final completedPlans = _plans.where((p) => p.status == PlanStatus.completed).length;
    
    final totalWeight = _plans.map((p) => p.weightKg).reduce((a, b) => a + b);
    final averageWeight = totalWeight / _plans.length;

    // Count goals
    final Map<String, int> goalCounts = {};
    for (final plan in _plans) {
      goalCounts[plan.goal] = (goalCounts[plan.goal] ?? 0) + 1;
    }
    final commonGoal = goalCounts.isNotEmpty
        ? goalCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    // Count conditions
    final Map<String, int> conditionCounts = {};
    for (final plan in _plans) {
      for (final condition in plan.healthConditions) {
        conditionCounts[condition] = (conditionCounts[condition] ?? 0) + 1;
      }
    }
    final commonCondition = conditionCounts.isNotEmpty
        ? conditionCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    return {
      'totalPlans': _plans.length,
      'activePlans': activePlans,
      'completedPlans': completedPlans,
      'averageWeight': averageWeight.round(),
      'commonGoal': commonGoal,
      'commonCondition': commonCondition,
      'goalCounts': goalCounts,
      'conditionCounts': conditionCounts,
    };
  }

  // Clear all plans
  void clearPlans() {
    if (_plans.isNotEmpty) {
      _plans.clear();
      _notifyListeners();
      _persistPlans();
      if (kDebugMode) print('Cleared all plans');
    }
  }

  // Export plans as JSON
  String exportPlansJson() {
    try {
      return jsonEncode({
        'plans': _plans.map((p) => p.toJson()).toList(),
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0',
      });
    } catch (e) {
      if (kDebugMode) print('Error exporting plans: $e');
      return '';
    }
  }

  // Import plans from JSON
  bool importPlansJson(String jsonString, {bool replace = false}) {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final importedPlans = data['plans'] as List<dynamic>;
      
      if (replace) {
        clearPlans();
      }
      
      for (final planData in importedPlans) {
        final plan = UserMealPlan.fromJson(planData);
        _plans.add(plan);
      }
      
      _notifyListeners();
      _persistPlans();
      
      if (kDebugMode) print('Imported ${importedPlans.length} plans');
      return true;
    } catch (e) {
      if (kDebugMode) print('Error importing plans: $e');
      return false;
    }
  }

  // Initialize plans (load from storage)
  Future<void> initialize() async {
    try {
      await _loadPlans();
      if (kDebugMode) print('Plan history manager initialized with ${_plans.length} items');
    } catch (e) {
      if (kDebugMode) print('Error initializing plan history: $e');
    }
  }

  // Private methods
  String _generatePlanName(String goal, DateTime date) {
    goal.replaceAll(' ', '').toLowerCase();
    final dateStr = '${date.month}/${date.day}';
    return '${goal} Plan - $dateStr';
  }

  void _notifyListeners() {
    _plansController.add(List.unmodifiable(_plans));
  }

  Future<void> _persistPlans() async {
    try {
      // TODO: Implement actual persistence with SharedPreferences, Hive, etc.
      exportPlansJson();
      if (kDebugMode) print('Persisting ${_plans.length} plans');
      // await SharedPreferences.getInstance().then((prefs) => 
      //   prefs.setString('meal_plans', jsonString));
    } catch (e) {
      if (kDebugMode) print('Error persisting plans: $e');
    }
  }

  Future<void> _loadPlans() async {
    try {
      // TODO: Implement actual loading with SharedPreferences, Hive, etc.
      // For now, load some demo data
      _loadDemoData();
      /*
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('meal_plans');
      if (jsonString != null) {
        final data = jsonDecode(jsonString) as Map<String, dynamic>;
        final plansData = data['plans'] as List<dynamic>;
        _plans.clear();
        for (final planData in plansData) {
          _plans.add(UserMealPlan.fromJson(planData));
        }
        _notifyListeners();
      }
      */
    } catch (e) {
      if (kDebugMode) print('Error loading plans: $e');
    }
  }

  void _loadDemoData() {
    // Add some demo plans for testing
    _plans.addAll([
      UserMealPlan(
        id: '1',
        name: 'Weight Loss Plan - Week 1',
        createdDate: DateTime.now().subtract(const Duration(days: 7)),
        goal: 'Weight Loss',
        activityLevel: 'Moderate',
        heightCm: 170,
        weightKg: 75,
        targetWeight: 70,
        healthConditions: ['None'],
        dietaryRestrictions: ['None'],
        planMode: 'auto',
        status: PlanStatus.completed,
        progress: PlanProgress(
          currentWeight: 73,
          daysCompleted: 7,
          totalDays: 7,
          caloriesAveragePerDay: 1650,
          proteinAveragePerDay: 110,
        ),
      ),
      UserMealPlan(
        id: '2',
        name: 'Diabetes Management Plan',
        createdDate: DateTime.now().subtract(const Duration(days: 3)),
        goal: 'Maintenance',
        activityLevel: 'Light active',
        heightCm: 165,
        weightKg: 68,
        healthConditions: ['Diabetes'],
        dietaryRestrictions: ['Low sugar'],
        planMode: 'manual',
        status: PlanStatus.active,
        progress: PlanProgress(
          currentWeight: 68,
          daysCompleted: 3,
          totalDays: 14,
          caloriesAveragePerDay: 1800,
          proteinAveragePerDay: 95,
        ),
      ),
    ]);
  }

  // Dispose resources
  void dispose() {
    _plansController.close();
  }
}

// Data models
class UserMealPlan {
  final String id;
  final String name;
  final DateTime createdDate;
  final String goal;
  final String activityLevel;
  final double heightCm;
  final double weightKg;
  final double? targetWeight;
  final List<String> healthConditions;
  final List<String> dietaryRestrictions;
  final String planMode;
  final PlanStatus status;
  final PlanProgress progress;
  final DateTime? lastModified;

  UserMealPlan({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.goal,
    required this.activityLevel,
    required this.heightCm,
    required this.weightKg,
    this.targetWeight,
    required this.healthConditions,
    required this.dietaryRestrictions,
    required this.planMode,
    required this.status,
    required this.progress,
    this.lastModified,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdDate': createdDate.toIso8601String(),
    'goal': goal,
    'activityLevel': activityLevel,
    'heightCm': heightCm,
    'weightKg': weightKg,
    'targetWeight': targetWeight,
    'healthConditions': healthConditions,
    'dietaryRestrictions': dietaryRestrictions,
    'planMode': planMode,
    'status': status.name,
    'progress': progress.toJson(),
    'lastModified': lastModified?.toIso8601String(),
  };

  factory UserMealPlan.fromJson(Map<String, dynamic> json) => UserMealPlan(
    id: json['id'],
    name: json['name'],
    createdDate: DateTime.parse(json['createdDate']),
    goal: json['goal'],
    activityLevel: json['activityLevel'],
    heightCm: json['heightCm'].toDouble(),
    weightKg: json['weightKg'].toDouble(),
    targetWeight: json['targetWeight']?.toDouble(),
    healthConditions: List<String>.from(json['healthConditions']),
    dietaryRestrictions: List<String>.from(json['dietaryRestrictions']),
    planMode: json['planMode'],
    status: PlanStatus.values.firstWhere(
      (e) => e.name == json['status'], 
      orElse: () => PlanStatus.active,
    ),
    progress: PlanProgress.fromJson(json['progress']),
    lastModified: json['lastModified'] != null 
        ? DateTime.parse(json['lastModified']) 
        : null,
  );

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdDate).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    if (difference < 30) return '${(difference / 7).round()} weeks ago';
    return '${createdDate.month}/${createdDate.day}/${createdDate.year}';
  }

  double? get bmi {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  String get statusDisplay {
    switch (status) {
      case PlanStatus.active:
        return 'Active';
      case PlanStatus.completed:
        return 'Completed';
      case PlanStatus.paused:
        return 'Paused';
      case PlanStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class PlanProgress {
  final double? currentWeight;
  final int daysCompleted;
  final int totalDays;
  final double caloriesAveragePerDay;
  final double proteinAveragePerDay;
  final Map<String, double>? weeklyWeights;
  final List<String>? achievements;

  PlanProgress({
    this.currentWeight,
    required this.daysCompleted,
    required this.totalDays,
    required this.caloriesAveragePerDay,
    required this.proteinAveragePerDay,
    this.weeklyWeights,
    this.achievements,
  });

  factory PlanProgress.initial() => PlanProgress(
    daysCompleted: 0,
    totalDays: 14,
    caloriesAveragePerDay: 0,
    proteinAveragePerDay: 0,
  );

  double get completionPercentage {
    if (totalDays == 0) return 0.0;
    return (daysCompleted / totalDays).clamp(0.0, 1.0);
  }

  int get remainingDays => (totalDays - daysCompleted).clamp(0, totalDays);

  Map<String, dynamic> toJson() => {
    'currentWeight': currentWeight,
    'daysCompleted': daysCompleted,
    'totalDays': totalDays,
    'caloriesAveragePerDay': caloriesAveragePerDay,
    'proteinAveragePerDay': proteinAveragePerDay,
    'weeklyWeights': weeklyWeights,
    'achievements': achievements,
  };

  factory PlanProgress.fromJson(Map<String, dynamic> json) => PlanProgress(
    currentWeight: json['currentWeight']?.toDouble(),
    daysCompleted: json['daysCompleted'],
    totalDays: json['totalDays'],
    caloriesAveragePerDay: json['caloriesAveragePerDay'].toDouble(),
    proteinAveragePerDay: json['proteinAveragePerDay'].toDouble(),
    weeklyWeights: json['weeklyWeights'] != null 
        ? Map<String, double>.from(json['weeklyWeights']) 
        : null,
    achievements: json['achievements'] != null 
        ? List<String>.from(json['achievements']) 
        : null,
  );
}

enum PlanStatus {
  active,
  completed,
  paused,
  cancelled,
}

// Extension methods for convenience
extension PlanHistoryManagerExtension on PlanHistoryManager {
  // Get the most recent active plan
  UserMealPlan? get currentActivePlan {
    try {
      return _plans.firstWhere((p) => p.status == PlanStatus.active);
    } catch (e) {
      return null;
    }
  }
  
  // Check if user has any active plans
  bool get hasActivePlans => getActivePlans().isNotEmpty;
  
  // Get plans created in the last N days
  List<UserMealPlan> getRecentPlansInDays(int days) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return _plans.where((p) => p.createdDate.isAfter(cutoffDate)).toList();
  }
  
  // Update plan progress
  bool updatePlanProgress(String planId, PlanProgress progress) {
    return updatePlan(planId, progress: progress);
  }
  
  // Mark plan as completed
  bool completePlan(String planId) {
    return updatePlan(planId, status: PlanStatus.completed);
  }
  
  // Pause a plan
  bool pausePlan(String planId) {
    return updatePlan(planId, status: PlanStatus.paused);
  }
  
  // Resume a paused plan
  bool resumePlan(String planId) {
    return updatePlan(planId, status: PlanStatus.active);
  }
}