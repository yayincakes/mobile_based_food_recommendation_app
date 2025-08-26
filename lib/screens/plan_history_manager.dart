// plan_history_manager.dart
// Simple in-memory plan history. Swap for Hive/SQLite/Firestore later.
class PlanHistoryManager {
  static final PlanHistoryManager _i = PlanHistoryManager._internal();
  factory PlanHistoryManager() => _i;
  PlanHistoryManager._internal();

  final List<Map<String, dynamic>> _plans = [];

  List<Map<String, dynamic>> get plans => List.unmodifiable(_plans);

  void addPlan({
    required DateTime date,
    required String goal,
    required String activity,
    required double heightCm,
    required double weightKg,
    required Set<String> conditions,
    required Set<String> restrictions,
    double? targetWeight,
  }) {
    _plans.insert(0, {
      'date': date.toIso8601String(),
      'goal': goal,
      'activity': activity,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'targetWeight': targetWeight,
      'conditions': conditions.toList(),
      'restrictions': restrictions.toList(),
    });
  }

  void clear() => _plans.clear();
}
