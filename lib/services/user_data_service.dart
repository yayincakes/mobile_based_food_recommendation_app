import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataService {
  // User profile data model
  static Future<UserProfileData?> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final name = prefs.getString('profileName');
      final email = prefs.getString('profileEmail');
      final height = prefs.getDouble('height');
      final weight = prefs.getDouble('weight');
      final goal = prefs.getString('dietGoal');
      final gender = prefs.getString('gender');
      final activity = prefs.getString('activity');
      final targetWeight = prefs.getDouble('targetWeight');
      
      if (name == null || height == null || weight == null || goal == null) {
        return null;
      }
      
      // Calculate BMI
      final bmi = _calculateBMI(height, weight);
      final bmiCategory = _getBMICategory(bmi);
      
      return UserProfileData(
        name: name,
        email: email ?? '',
        height: height,
        weight: weight,
        goal: goal,
        gender: gender ?? 'Other',
        activity: activity ?? 'Sedentary',
        targetWeight: targetWeight,
        bmi: bmi,
        bmiCategory: bmiCategory,
        healthConditions: await _getHealthConditions(prefs),
        restrictions: await _getRestrictions(prefs),
        mealPreferences: await _getMealPreferences(prefs),
      );
    } catch (e) {
      return null;
    }
  }
  
  // Save user profile
  static Future<bool> saveUserProfile(UserProfileData profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('profileName', profile.name);
      await prefs.setString('profileEmail', profile.email);
      await prefs.setDouble('height', profile.height);
      await prefs.setDouble('weight', profile.weight);
      await prefs.setString('dietGoal', profile.goal);
      await prefs.setString('gender', profile.gender);
      await prefs.setString('activity', profile.activity);
      
      if (profile.targetWeight != null) {
        await prefs.setDouble('targetWeight', profile.targetWeight!);
      }
      
      await prefs.setString('healthConditions', json.encode(profile.healthConditions));
      await prefs.setString('restrictions', json.encode(profile.restrictions));
      await prefs.setString('mealPreferences', json.encode(profile.mealPreferences));
      
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Update height
  static Future<bool> updateHeight(double height) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('height', height);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Update weight
  static Future<bool> updateWeight(double weight) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('weight', weight);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Update goal
  static Future<bool> updateGoal(String goal) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dietGoal', goal);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Check if onboarding is completed
  static Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('onboardingCompleted') ?? false;
    } catch (e) {
      return false;
    }
  }
  
  // Helper methods
  static double _calculateBMI(double height, double weight) {
    final heightM = height / 100;
    return weight / (heightM * heightM);
  }
  
  static String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
  
  static Future<List<String>> _getHealthConditions(SharedPreferences prefs) async {
    try {
      final conditionsJson = prefs.getString('healthConditions');
      if (conditionsJson != null) {
        return List<String>.from(json.decode(conditionsJson));
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  static Future<List<String>> _getRestrictions(SharedPreferences prefs) async {
    try {
      final restrictionsJson = prefs.getString('restrictions');
      if (restrictionsJson != null) {
        return List<String>.from(json.decode(restrictionsJson));
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  static Future<List<String>> _getMealPreferences(SharedPreferences prefs) async {
    try {
      final preferencesJson = prefs.getString('mealPreferences');
      if (preferencesJson != null) {
        return List<String>.from(json.decode(preferencesJson));
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

// User profile data model
class UserProfileData {
  final String name;
  final String email;
  final double height;
  final double weight;
  final String goal;
  final String gender;
  final String activity;
  final double? targetWeight;
  final double bmi;
  final String bmiCategory;
  final List<String> healthConditions;
  final List<String> restrictions;
  final List<String> mealPreferences;
  
  UserProfileData({
    required this.name,
    required this.email,
    required this.height,
    required this.weight,
    required this.goal,
    required this.gender,
    required this.activity,
    this.targetWeight,
    required this.bmi,
    required this.bmiCategory,
    required this.healthConditions,
    required this.restrictions,
    this.mealPreferences = const [],
  });
}
