import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class ProfileManagementService {
  static const String _profileKey = 'user_profile';
  static const String _goalsKey = 'dietary_goals';
  static const String _conditionsKey = 'health_conditions';
  static const String _allergiesKey = 'allergies';
  static const String _mealPlansKey = 'meal_plans';

  // ======================= PROFILE MANAGEMENT =======================

  static Future<UserProfile?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString(_profileKey);
      
      if (profileJson == null) return null;
      
      final profileData = json.decode(profileJson);
      return UserProfile.fromJson(profileData);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> saveProfile(UserProfile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_profileKey, json.encode(profile.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateProfile({
    String? name,
    String? email,
    double? height,
    double? weight,
    String? gender,
    DateTime? birthDate,
    String? activityLevel,
    List<String>? preferences,
    String? goal,
  }) async {
    try {
      final currentProfile = await getProfile();
      if (currentProfile == null) return false;

      final updatedProfile = UserProfile(
        name: name ?? currentProfile.name,
        email: email ?? currentProfile.email,
        height: height ?? currentProfile.height,
        weight: weight ?? currentProfile.weight,
        gender: gender ?? currentProfile.gender,
        birthDate: birthDate ?? currentProfile.birthDate,
        activityLevel: activityLevel ?? currentProfile.activityLevel,
        dietaryGoals: currentProfile.dietaryGoals,
        healthConditions: currentProfile.healthConditions,
        allergies: currentProfile.allergies,
        mealPlans: currentProfile.mealPlans,
        preferences: preferences ?? currentProfile.preferences,
        goal: goal ?? currentProfile.goal,
        createdAt: currentProfile.createdAt,
        updatedAt: DateTime.now(),
      );

      return await saveProfile(updatedProfile);
    } catch (e) {
      return false;
    }
  }

  // ======================= DIETARY GOALS MANAGEMENT =======================

  static Future<List<DietaryGoal>> getDietaryGoals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final goalsJson = prefs.getString(_goalsKey);
      
      if (goalsJson == null) return [];
      
      final goalsData = json.decode(goalsJson) as List<dynamic>;
      return goalsData.map((goal) => DietaryGoal.fromJson(goal)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addDietaryGoal(DietaryGoal goal) async {
    try {
      final goals = await getDietaryGoals();
      final updatedGoals = List<DietaryGoal>.from(goals)..add(goal);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_goalsKey, json.encode(updatedGoals.map((g) => g.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateDietaryGoal(String goalId, DietaryGoal updatedGoal) async {
    try {
      final goals = await getDietaryGoals();
      final index = goals.indexWhere((goal) => goal.id == goalId);
      
      if (index == -1) return false;
      
      final updatedGoals = List<DietaryGoal>.from(goals);
      updatedGoals[index] = updatedGoal;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_goalsKey, json.encode(updatedGoals.map((g) => g.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteDietaryGoal(String goalId) async {
    try {
      final goals = await getDietaryGoals();
      final updatedGoals = goals.where((goal) => goal.id != goalId).toList();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_goalsKey, json.encode(updatedGoals.map((g) => g.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setActiveGoal(String goalId) async {
    try {
      final goals = await getDietaryGoals();
      final updatedGoals = <DietaryGoal>[];
      
      // Process all goals
      for (final goal in goals) {
        if (goal.id == goalId) {
          // Activate the selected goal
          updatedGoals.add(DietaryGoal(
            id: goal.id,
            name: goal.name,
            description: goal.description,
            type: goal.type,
            targetWeight: goal.targetWeight,
            targetCalories: goal.targetCalories,
            startDate: goal.startDate,
            endDate: goal.endDate,
            isActive: true,
            createdAt: goal.createdAt,
            updatedAt: DateTime.now(),
          ));
        } else {
          // Deactivate all other goals
          updatedGoals.add(DietaryGoal(
            id: goal.id,
            name: goal.name,
            description: goal.description,
            type: goal.type,
            targetWeight: goal.targetWeight,
            targetCalories: goal.targetCalories,
            startDate: goal.startDate,
            endDate: goal.endDate,
            isActive: false,
            createdAt: goal.createdAt,
            updatedAt: DateTime.now(),
          ));
        }
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_goalsKey, json.encode(updatedGoals.map((g) => g.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // ======================= HEALTH CONDITIONS MANAGEMENT =======================

  static Future<List<HealthCondition>> getHealthConditions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final conditionsJson = prefs.getString(_conditionsKey);
      
      if (conditionsJson == null) return [];
      
      final conditionsData = json.decode(conditionsJson) as List<dynamic>;
      return conditionsData.map((condition) => HealthCondition.fromJson(condition)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addHealthCondition(HealthCondition condition) async {
    try {
      final conditions = await getHealthConditions();
      final updatedConditions = List<HealthCondition>.from(conditions)..add(condition);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_conditionsKey, json.encode(updatedConditions.map((c) => c.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateHealthCondition(String conditionId, HealthCondition updatedCondition) async {
    try {
      final conditions = await getHealthConditions();
      final index = conditions.indexWhere((condition) => condition.id == conditionId);
      
      if (index == -1) return false;
      
      final updatedConditions = List<HealthCondition>.from(conditions);
      updatedConditions[index] = updatedCondition;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_conditionsKey, json.encode(updatedConditions.map((c) => c.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteHealthCondition(String conditionId) async {
    try {
      final conditions = await getHealthConditions();
      final updatedConditions = conditions.where((condition) => condition.id != conditionId).toList();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_conditionsKey, json.encode(updatedConditions.map((c) => c.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // ======================= ALLERGIES MANAGEMENT =======================

  static Future<List<Allergy>> getAllergies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allergiesJson = prefs.getString(_allergiesKey);
      
      if (allergiesJson == null) return [];
      
      final allergiesData = json.decode(allergiesJson) as List<dynamic>;
      return allergiesData.map((allergy) => Allergy.fromJson(allergy)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addAllergy(Allergy allergy) async {
    try {
      final allergies = await getAllergies();
      final updatedAllergies = List<Allergy>.from(allergies)..add(allergy);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_allergiesKey, json.encode(updatedAllergies.map((a) => a.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateAllergy(String allergyId, Allergy updatedAllergy) async {
    try {
      final allergies = await getAllergies();
      final index = allergies.indexWhere((allergy) => allergy.id == allergyId);
      
      if (index == -1) return false;
      
      final updatedAllergies = List<Allergy>.from(allergies);
      updatedAllergies[index] = updatedAllergy;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_allergiesKey, json.encode(updatedAllergies.map((a) => a.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteAllergy(String allergyId) async {
    try {
      final allergies = await getAllergies();
      final updatedAllergies = allergies.where((allergy) => allergy.id != allergyId).toList();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_allergiesKey, json.encode(updatedAllergies.map((a) => a.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // ======================= MEAL PLANS MANAGEMENT =======================

  static Future<List<MealPlan>> getMealPlans() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final plansJson = prefs.getString(_mealPlansKey);
      
      if (plansJson == null) return [];
      
      final plansData = json.decode(plansJson) as List<dynamic>;
      return plansData.map((plan) => MealPlan.fromJson(plan)).toList();
    } catch (e) {
      return [];
    }
  }

  // Get only the active meal plan (one plan per user)
  static Future<MealPlan?> getActiveMealPlan() async {
    try {
      final plans = await getMealPlans();
      return plans.where((plan) => plan.isActive).firstOrNull;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addMealPlan(MealPlan plan) async {
    try {
      final plans = await getMealPlans();
      final updatedPlans = <MealPlan>[];
      
      // Deactivate all existing plans (one plan per user)
      for (var existingPlan in plans) {
        if (existingPlan.isActive) {
          updatedPlans.add(MealPlan(
            id: existingPlan.id,
            name: existingPlan.name,
            description: existingPlan.description,
            startDate: existingPlan.startDate,
            endDate: existingPlan.endDate,
            isActive: false, // Deactivate old plan
            createdAt: existingPlan.createdAt,
            updatedAt: DateTime.now(),
          ));
        } else {
          updatedPlans.add(existingPlan);
        }
      }
      
      // Add the new plan (it will be the only active one)
      updatedPlans.add(plan);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_mealPlansKey, json.encode(updatedPlans.map((p) => p.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateMealPlan(String planId, MealPlan updatedPlan) async {
    try {
      final plans = await getMealPlans();
      final index = plans.indexWhere((plan) => plan.id == planId);
      
      if (index == -1) return false;
      
      final updatedPlans = List<MealPlan>.from(plans);
      updatedPlans[index] = updatedPlan;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_mealPlansKey, json.encode(updatedPlans.map((p) => p.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteMealPlan(String planId) async {
    try {
      final plans = await getMealPlans();
      final updatedPlans = plans.where((plan) => plan.id != planId).toList();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_mealPlansKey, json.encode(updatedPlans.map((p) => p.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setActiveMealPlan(String planId) async {
    try {
      final plans = await getMealPlans();
      final updatedPlans = <MealPlan>[];
      
      // Process all plans
      for (final plan in plans) {
        if (plan.id == planId) {
          // Activate the selected plan
          updatedPlans.add(MealPlan(
            id: plan.id,
            name: plan.name,
            description: plan.description,
            startDate: plan.startDate,
            endDate: plan.endDate,
            isActive: true,
            createdAt: plan.createdAt,
            updatedAt: DateTime.now(),
          ));
        } else {
          // Deactivate all other plans
          updatedPlans.add(MealPlan(
            id: plan.id,
            name: plan.name,
            description: plan.description,
            startDate: plan.startDate,
            endDate: plan.endDate,
            isActive: false,
            createdAt: plan.createdAt,
            updatedAt: DateTime.now(),
          ));
        }
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_mealPlansKey, json.encode(updatedPlans.map((p) => p.toJson()).toList()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // ======================= PREFERENCES MANAGEMENT =======================

  static Future<List<String>> getPreferences() async {
    try {
      final profile = await getProfile();
      return profile?.preferences ?? [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updatePreferences(List<String> preferences) async {
    try {
      final currentProfile = await getProfile();
      if (currentProfile == null) return false;

      final updatedProfile = UserProfile(
        name: currentProfile.name,
        email: currentProfile.email,
        height: currentProfile.height,
        weight: currentProfile.weight,
        gender: currentProfile.gender,
        birthDate: currentProfile.birthDate,
        activityLevel: currentProfile.activityLevel,
        dietaryGoals: currentProfile.dietaryGoals,
        healthConditions: currentProfile.healthConditions,
        allergies: currentProfile.allergies,
        mealPlans: currentProfile.mealPlans,
        preferences: preferences,
        goal: currentProfile.goal,
        createdAt: currentProfile.createdAt,
        updatedAt: DateTime.now(),
      );

      return await saveProfile(updatedProfile);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addPreference(String preference) async {
    try {
      final currentPreferences = await getPreferences();
      if (currentPreferences.contains(preference)) return true; // Already exists
      
      currentPreferences.add(preference);
      return await updatePreferences(currentPreferences);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removePreference(String preference) async {
    try {
      final currentPreferences = await getPreferences();
      currentPreferences.remove(preference);
      return await updatePreferences(currentPreferences);
    } catch (e) {
      return false;
    }
  }

  // ======================= GOAL MANAGEMENT =======================

  static Future<String> getCurrentGoal() async {
    try {
      final profile = await getProfile();
      return profile?.goal ?? 'Maintenance';
    } catch (e) {
      return 'Maintenance';
    }
  }

  static Future<bool> updateGoal(String goal) async {
    try {
      final currentProfile = await getProfile();
      if (currentProfile == null) return false;

      final updatedProfile = UserProfile(
        name: currentProfile.name,
        email: currentProfile.email,
        height: currentProfile.height,
        weight: currentProfile.weight,
        gender: currentProfile.gender,
        birthDate: currentProfile.birthDate,
        activityLevel: currentProfile.activityLevel,
        dietaryGoals: currentProfile.dietaryGoals,
        healthConditions: currentProfile.healthConditions,
        allergies: currentProfile.allergies,
        mealPlans: currentProfile.mealPlans,
        preferences: currentProfile.preferences,
        goal: goal,
        createdAt: currentProfile.createdAt,
        updatedAt: DateTime.now(),
      );

      return await saveProfile(updatedProfile);
    } catch (e) {
      return false;
    }
  }

  // ======================= UTILITY METHODS =======================

  static Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileKey);
      await prefs.remove(_goalsKey);
      await prefs.remove(_conditionsKey);
      await prefs.remove(_allergiesKey);
      await prefs.remove(_mealPlansKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // ======================= PROFILE CREATION HELPERS =======================

  static Future<bool> createInitialProfile({
    required String name,
    required String email,
    double? height,
    double? weight,
    String? gender,
    DateTime? birthDate,
    String? activityLevel,
    String goal = 'Maintenance',
    List<String> preferences = const [],
  }) async {
    try {
      final now = DateTime.now();
      final profile = UserProfile(
        name: name,
        email: email,
        height: height,
        weight: weight,
        gender: gender,
        birthDate: birthDate,
        activityLevel: activityLevel,
        dietaryGoals: [],
        healthConditions: [],
        allergies: [],
        mealPlans: [],
        preferences: preferences,
        goal: goal,
        createdAt: now,
        updatedAt: now,
      );

      return await saveProfile(profile);
    } catch (e) {
      return false;
    }
  }

  // ======================= PROFILE VALIDATION =======================

  static Future<bool> isProfileComplete() async {
    try {
      final profile = await getProfile();
      if (profile == null) return false;

      // Check if essential fields are filled
      return profile.name.isNotEmpty &&
             profile.email.isNotEmpty &&
             profile.height != null &&
             profile.weight != null &&
             profile.gender != null;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getProfileCompletionStatus() async {
    try {
      final profile = await getProfile();
      if (profile == null) {
        return {
          'isComplete': false,
          'completionPercentage': 0.0,
          'missingFields': ['name', 'email', 'height', 'weight', 'gender'],
        };
      }

      final missingFields = <String>[];
      int completedFields = 0;
      const totalFields = 5;

      if (profile.name.isEmpty) missingFields.add('name');
      else completedFields++;

      if (profile.email.isEmpty) missingFields.add('email');
      else completedFields++;

      if (profile.height == null) missingFields.add('height');
      else completedFields++;

      if (profile.weight == null) missingFields.add('weight');
      else completedFields++;

      if (profile.gender == null) missingFields.add('gender');
      else completedFields++;

      final completionPercentage = (completedFields / totalFields) * 100;

      return {
        'isComplete': missingFields.isEmpty,
        'completionPercentage': completionPercentage,
        'missingFields': missingFields,
      };
    } catch (e) {
      return {
        'isComplete': false,
        'completionPercentage': 0.0,
        'missingFields': ['name', 'email', 'height', 'weight', 'gender'],
      };
    }
  }
}
