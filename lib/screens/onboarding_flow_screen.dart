import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../services/profile_management_service.dart';
import '../services/user_data_service.dart';
import '../models/user_profile.dart' as models;

class OnboardingFlowScreen extends StatefulWidget {
  final String planMode;
  
  const OnboardingFlowScreen({
    super.key,
    this.planMode = 'auto',
  });

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> with SingleTickerProviderStateMixin {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  final PageController _pageController = PageController();
  late AnimationController _animController;

  int _step = 0;
  bool _isLoading = false;

  // User data with realistic defaults
  String? _gender;
  String? _goal;
  String? _activity;
  double _height = 170.0;
  double _weight = 70.0;
  double? _targetWeight;
  
  // Manual mode specific
  int? _mealsPerDay;
  String? _dailyBudget;
  final Set<String> _mealPreferences = {};

  final Set<String> _conditions = {};
  final Set<String> _restrictions = {};
  
  final _customConditionController = TextEditingController();
  final _customRestrictionController = TextEditingController();

  late final List<OnboardingStep> _steps;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _initializeSteps();
    _checkExistingMealPlan();
  }

  Future<void> _checkExistingMealPlan() async {
    try {
      // Check if user already has an active meal plan
      final existingMealPlan = await ProfileManagementService.getActiveMealPlan();
      
      if (existingMealPlan != null) {
        // User already has a meal plan - redirect to dashboard
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('You already have a meal plan. Redirecting to dashboard...',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              backgroundColor: darkGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
          
          // Wait a moment for user to see the message, then redirect
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    } catch (e) {
      // If there's an error checking, continue with onboarding
      debugPrint('Error checking existing meal plan: $e');
    }
  }

  void _initializeSteps() {
    if (widget.planMode == 'auto') {
      _steps = [
        OnboardingStep(
          title: 'What is your gender?',
          isRequired: true,
          validator: () => _gender != null,
          errorMessage: 'Please select your gender',
        ),
        OnboardingStep(
          title: 'What is your height?',
          isRequired: true,
          validator: () => _height >= 100 && _height <= 220,
          errorMessage: 'Please adjust your height',
        ),
        OnboardingStep(
          title: 'What is your current weight?',
          isRequired: true,
          validator: () => _weight >= 30 && _weight <= 200,
          errorMessage: 'Please adjust your weight',
        ),
        OnboardingStep(
          title: 'Your Health Summary',
          isRequired: true,
          validator: () => true,
          errorMessage: '',
        ),
        OnboardingStep(
          title: 'What is your dietary goal?',
          isRequired: true,
          validator: () => _goal != null,
          errorMessage: 'Please select your dietary goal',
        ),
        OnboardingStep(
          title: 'What is your activity level?',
          isRequired: true,
          validator: () => _activity != null,
          errorMessage: 'Please select your activity level',
        ),
        OnboardingStep(
          title: 'Do you have any health conditions?',
          isRequired: true,
          validator: () => _conditions.isNotEmpty,
          errorMessage: 'Please select at least one option',
        ),
        OnboardingStep(
          title: 'Any dietary restrictions?',
          isRequired: false,
          validator: () => true,
          errorMessage: '',
        ),
      ];
    } else {
      _steps = [
        OnboardingStep(
          title: 'What is your gender?',
          isRequired: true,
          validator: () => _gender != null,
          errorMessage: 'Please select your gender',
        ),
        OnboardingStep(
          title: 'What is your height?',
          isRequired: true,
          validator: () => _height >= 100 && _height <= 220,
          errorMessage: 'Please adjust your height',
        ),
        OnboardingStep(
          title: 'What is your current weight?',
          isRequired: true,
          validator: () => _weight >= 30 && _weight <= 200,
          errorMessage: 'Please adjust your weight',
        ),
        OnboardingStep(
          title: 'Your Health Summary',
          isRequired: true,
          validator: () => true,
          errorMessage: '',
        ),
        OnboardingStep(
          title: 'What is your dietary goal?',
          isRequired: true,
          validator: () => _goal != null,
          errorMessage: 'Please select your dietary goal',
        ),
        OnboardingStep(
          title: 'What is your target weight?',
          isRequired: true,
          validator: () => _targetWeight != null && _validateTargetWeight(),
          errorMessage: 'Please set a realistic target weight',
        ),
        OnboardingStep(
          title: 'What is your activity level?',
          isRequired: true,
          validator: () => _activity != null,
          errorMessage: 'Please select your activity level',
        ),
        OnboardingStep(
          title: 'How many meals per day?',
          isRequired: true,
          validator: () => _mealsPerDay != null,
          errorMessage: 'Please select meals per day',
        ),
        OnboardingStep(
          title: 'Meal preferences',
          isRequired: true,
          validator: () => _mealPreferences.isNotEmpty,
          errorMessage: 'Please select at least one preference',
        ),
        OnboardingStep(
          title: 'Do you have any health conditions?',
          isRequired: true,
          validator: () => _conditions.isNotEmpty,
          errorMessage: 'Please select at least one option',
        ),
        OnboardingStep(
          title: 'Any dietary restrictions?',
          isRequired: false,
          validator: () => true,
          errorMessage: '',
        ),
      ];
    }
  }

  bool _validateTargetWeight() {
    if (_targetWeight == null) return false;
    
    final bmi = _calculateBMI(_height, _targetWeight!);
    return bmi >= 16.0 && bmi <= 35.0;
  }

  @override
  void dispose() {
    _customConditionController.dispose();
    _customRestrictionController.dispose();
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    if (_isLoading) return;

    final currentStep = _steps[_step];
    
    if (!currentStep.validator()) {
      _showError(currentStep.errorMessage);
      return;
    }

    if (_step < _steps.length - 1) {
      setState(() => _step++);
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      await _finish();
    }
  }

  Future<void> _back() async {
    if (_step == 0) {
      Navigator.pop(context);
    } else {
      setState(() => _step--);
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _finish() async {
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      await _saveUserProfile(UserProfile(
        gender: _gender!,
        height: _height,
        weight: _weight,
        goal: _goal!,
        activity: _activity!,
        conditions: _conditions.toList(),
        restrictions: _restrictions.toList(),
        targetWeight: _targetWeight,
        planMode: widget.planMode,
        mealsPerDay: _mealsPerDay,
        mealPreferences: _mealPreferences.toList(),
        dailyBudget: _dailyBudget,
      ));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text('Your personalized plan has been created!',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          backgroundColor: darkGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      if (!mounted) return;
      _showError('Failed to create plan. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, 
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _saveUserProfile(UserProfile profile) async {
    try {
      // Get user data from login session
      final prefs = await SharedPreferences.getInstance();
      final currentUser = prefs.getString('current_user') ?? 'User';
      final currentUserDataJson = prefs.getString('current_user_data');
      
      String userName = 'User';
      String userEmail = 'user@email.com';
      
      if (currentUserDataJson != null) {
        try {
          final userData = json.decode(currentUserDataJson) as Map<String, dynamic>;
          userName = userData['fullName'] ?? userData['name'] ?? currentUser;
          userEmail = userData['email'] ?? 'user@email.com';
        } catch (e) {
          debugPrint('Error parsing user data: $e');
        }
      }
      
      // Save basic profile information to ProfileManagementService
      final userProfile = models.UserProfile(
        name: userName,
        email: userEmail,
        height: profile.height,
        weight: profile.weight,
        gender: profile.gender,
        birthDate: DateTime.now().subtract(const Duration(days: 25 * 365)), // Default age 25
        activityLevel: profile.activity,
        dietaryGoals: [],
        healthConditions: [],
        allergies: [],
        mealPlans: [],
        preferences: profile.mealPreferences ?? [],
        goal: profile.goal,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await ProfileManagementService.saveProfile(userProfile);

      // Also save to UserDataService for consistency with profile screen
      final userProfileData = UserProfileData(
        name: userName,
        email: userEmail,
        height: profile.height,
        weight: profile.weight,
        goal: profile.goal,
        gender: profile.gender,
        activity: profile.activity,
        targetWeight: profile.targetWeight,
        bmi: _calculateBMI(profile.height, profile.weight),
        bmiCategory: _getBMICategory(_calculateBMI(profile.height, profile.weight)),
        healthConditions: profile.conditions,
        restrictions: profile.restrictions,
      );
      
      await UserDataService.saveUserProfile(userProfileData);

      // Save dietary goals
      if (profile.goal.isNotEmpty) {
        await ProfileManagementService.addDietaryGoal(models.DietaryGoal(
          id: ProfileManagementService.generateId(),
          name: profile.goal,
          description: _getGoalDescription(profile.goal),
          type: _getGoalType(profile.goal),
          targetWeight: profile.targetWeight,
          targetCalories: _calculateTargetCalories(profile),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 90)),
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
      }

      // Save health conditions
      for (String condition in profile.conditions) {
        if (condition != 'None') {
          await ProfileManagementService.addHealthCondition(models.HealthCondition(
            id: ProfileManagementService.generateId(),
            name: condition,
            description: _getConditionDescription(condition),
            severity: _getConditionSeverity(condition),
            diagnosedDate: DateTime.now(),
            notes: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ));
        }
      }

      // Save allergies/dietary restrictions
      for (String restriction in profile.restrictions) {
        if (restriction != 'None') {
          await ProfileManagementService.addAllergy(models.Allergy(
            id: ProfileManagementService.generateId(),
            name: restriction,
            type: _getAllergyType(restriction),
            severity: _getAllergySeverity(restriction),
            symptoms: null,
            notes: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ));
        }
      }

      // Save meal plan (one plan per user - this will deactivate any existing plans)
      final planName = profile.planMode == 'manual' 
          ? 'My Custom Plan' 
          : 'My Personalized Plan';
      final planDescription = profile.planMode == 'manual' 
          ? 'Custom meal plan with ${profile.mealsPerDay} meals per day'
          : 'AI-generated meal plan based on your preferences';
      
      // This method automatically deactivates existing plans and creates a new active one
      await ProfileManagementService.addMealPlan(models.MealPlan(
        id: ProfileManagementService.generateId(),
        name: planName,
        description: planDescription,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      // Mark onboarding as completed
      await prefs.setBool('onboardingCompleted', true);
    } catch (e) {
      throw Exception('Failed to save profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            _buildProgressHeader(isTablet),
            
            // Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _steps.length,
                itemBuilder: (context, index) => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 48 : 20,
                    vertical: isTablet ? 32 : 20,
                  ),
                  child: _buildStepContent(index),
                ),
              ),
            ),
            
            // Bottom Buttons
            _buildBottomButtons(isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkGreen, darkGreen.withOpacity(0.8)],
        ),
        boxShadow: [
          BoxShadow(
            color: darkGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _back,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              Text('FitMeal', 
                style: GoogleFonts.pacifico(fontSize: isTablet ? 32 : 26, color: Colors.white)),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: 8,
                width: MediaQuery.of(context).size.width * (_step + 1) / _steps.length,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Step ${_step + 1} of ${_steps.length}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            )),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_step > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isLoading ? null : _back,
                icon: const Icon(Icons.arrow_back),
                label: Text('Back', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: darkGreen,
                  side: BorderSide(color: darkGreen, width: 2),
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          if (_step > 0) const SizedBox(width: 16),
          Expanded(
            flex: _step > 0 ? 2 : 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
              ),
              onPressed: _isLoading ? null : _next,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _step == _steps.length - 1 ? 'Create My Plan' : 'Continue',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(int index) {
    if (widget.planMode == 'auto') {
      switch (index) {
        case 0: return _genderStep();
        case 1: return _heightInteractiveStep();
        case 2: return _weightInteractiveStep();
        case 3: return _bmiResultsStep();
        case 4: return _goalStep();
        case 5: return _activityStep();
        case 6: return _conditionsStep();
        case 7: return _restrictionsStep();
        default: return const SizedBox();
      }
    } else {
      switch (index) {
        case 0: return _genderStep();
        case 1: return _heightInteractiveStep();
        case 2: return _weightInteractiveStep();
        case 3: return _bmiResultsStep();
        case 4: return _goalStep();
        case 5: return _targetWeightStep();
        case 6: return _activityStep();
        case 7: return _mealsPerDayStep();
        case 8: return _mealPreferencesStep();
        case 9: return _conditionsStep();
        case 10: return _restrictionsStep();
        default: return const SizedBox();
      }
    }
  }

  Widget _genderStep() {
    return Column(
      children: [
        _stepTitle('What is your gender?'),
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(child: _genderOption('Male', Icons.man, 'Male')),
            const SizedBox(width: 16),
            Expanded(child: _genderOption('Female', Icons.woman, 'Female')),
          ],
        ),
      ],
    );
  }

  Widget _genderOption(String label, IconData icon, String value) {
    final isSelected = _gender == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = value;
          // Set realistic defaults based on gender
          if (value == 'Male') {
            _height = 175.0;
            _weight = 75.0;
          } else {
            _height = 165.0;
            _weight = 60.0;
          }
        });
        HapticFeedback.mediumImpact();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: isSelected 
              ? LinearGradient(
                  colors: [darkGreen, darkGreen.withOpacity(0.8)],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.grey.shade300,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: darkGreen.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))]
              : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Icon(icon,
              size: 64,
              color: isSelected ? Colors.white : darkGreen),
            const SizedBox(height: 16),
            Text(label,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : darkGreen,
              )),
          ],
        ),
      ),
    );
  }

  Widget _heightInteractiveStep() {
    if (_gender == null) {
      return Center(
        child: Text('Please select gender first',
          style: GoogleFonts.poppins(color: Colors.grey)),
      );
    }

    return Column(
      children: [
        _stepTitle('What is your height?'),
        _stepSubtitle('Drag the character up or down'),
        const SizedBox(height: 32),
        
        Container(
          height: 450,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [lightGreen.withOpacity(0.3), Colors.white],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: darkGreen.withOpacity(0.2), width: 2),
          ),
          child: Stack(
            children: [
              // Height ruler
              Positioned.fill(
                child: CustomPaint(
                  painter: HeightRulerPainter(darkGreen),
                ),
              ),
              
              // Draggable character
              Positioned(
                left: 0,
                right: 0,
                bottom: ((_height - 100) / 120) * 350, // 100cm at bottom, 220cm at top
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      final delta = -details.delta.dy;
                      _height = (_height + (delta * 0.5)).clamp(100.0, 220.0);
                    });
                    HapticFeedback.selectionClick();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: darkGreen.withOpacity(0.4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Text(
                          '${_height.round()} cm',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedBuilder(
                        animation: _animController,
                        builder: (context, child) {
                          // Calculate scale based on height (100cm = 0.8x, 220cm = 1.5x) - larger difference
                          final heightScale = 0.8 + ((_height - 100) / 120) * 0.7;
                          // Position the character at the bottom, growing upward
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.scale(
                              scale: heightScale,
                              alignment: Alignment.bottomCenter,
                              child: Transform.translate(
                                offset: Offset(0, _animController.value * 5),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          _gender == 'Male' ? '🧍‍♂️' : '🧍‍♀️',
                          style: const TextStyle(fontSize: 90), // Increased from 64 to 90
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weightInteractiveStep() {
    if (_gender == null) {
      return Center(
        child: Text('Please select gender first',
          style: GoogleFonts.poppins(color: Colors.grey)),
      );
    }

    return Column(
      children: [
        _stepTitle('What is your current weight?'),
        _stepSubtitle('Drag the character left or right'),
        const SizedBox(height: 32),
        
        Container(
          height: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [lightGreen.withOpacity(0.3), Colors.white, lightGreen.withOpacity(0.3)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: darkGreen.withOpacity(0.2), width: 2),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: darkGreen.withOpacity(0.4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Text(
                  '${_weight.toStringAsFixed(1)} kg',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Stack(
                  children: [
                    // Weight scale
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 40,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade300,
                              Colors.green.shade300,
                              Colors.orange.shade300,
                              Colors.red.shade300,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    
                    // Draggable character
                    Positioned(
                      left: ((_weight - 30) / 170) * (MediaQuery.of(context).size.width - 120),
                      bottom: 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          setState(() {
                            final screenWidth = MediaQuery.of(context).size.width - 120;
                            final delta = details.delta.dx;
                            _weight = (_weight + (delta / screenWidth) * 170).clamp(30.0, 200.0);
                          });
                          HapticFeedback.selectionClick();
                        },
                        child: AnimatedBuilder(
                          animation: _animController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_animController.value * 0.05),
                              child: child,
                            );
                          },
                          child: Text(
                            _gender == 'Male' ? '🧍‍♂️' : '🧍‍♀️',
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('30 kg', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                  Text('200 kg', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bmiResultsStep() {
    final bmi = _calculateBMI(_height, _weight);
    final bmiCategory = _getBMICategory(bmi);
    final bmiColor = _getBMIColor(bmiCategory);
    final bmiDescription = _getBMIDescription(bmiCategory);
    final healthyRange = _getHealthyWeightRange(_height);
    final recommendedWeight = _getRecommendedWeight();
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                bmiColor.withOpacity(0.15),
                bmiColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: bmiColor.withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(Icons.favorite, size: 48, color: bmiColor),
              ),
              const SizedBox(height: 20),
              Text('Your Health Summary',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                )),
              const SizedBox(height: 8),
              Text('Based on your height and weight',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                )),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: bmiColor.withOpacity(0.2),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bmiColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.monitor_weight_outlined, 
                      color: bmiColor, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Text('Body Mass Index',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    )),
                ],
              ),
              
              const SizedBox(height: 28),
              
              Text(bmi.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: bmiColor,
                  height: 1,
                )),
              
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                decoration: BoxDecoration(
                  color: bmiColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: bmiColor.withOpacity(0.4), width: 2),
                ),
                child: Text(bmiCategory,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: bmiColor,
                  )),
              ),
              
              const SizedBox(height: 24),
              
              Text(bmiDescription,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.6,
                )),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [lightGreen, lightGreen.withOpacity(0.5)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: darkGreen.withOpacity(0.3), width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, color: darkGreen, size: 24),
                  const SizedBox(width: 10),
                  Text('Healthy Weight Range',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: darkGreen,
                    )),
                ],
              ),
              const SizedBox(height: 16),
              Text('For your height (${_height.round()} cm)',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                )),
              const SizedBox(height: 8),
              Text(healthyRange,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                )),
              
              if (bmiCategory != 'Normal weight') ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: darkGreen.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lightbulb_outline, color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text('Recommended Target',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('${recommendedWeight.toStringAsFixed(1)} kg',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        )),
                      const SizedBox(height: 4),
                      Text(
                        bmiCategory == 'Underweight' 
                          ? 'Consider gaining weight for optimal health'
                          : 'A healthy target weight for your height',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  double _getRecommendedWeight() {
    final heightM = _height / 100;
    if (_weight < 18.5 * (heightM * heightM)) {
      return 20.0 * (heightM * heightM);
    } else {
      return 22.0 * (heightM * heightM);
    }
  }

  Widget _goalStep() {
    final bmi = _calculateBMI(_height, _weight);
    final bmiCategory = _getBMICategory(bmi);
    final recommendedGoal = _getRecommendedGoal(bmiCategory);
    
    final goals = [
      {'title': 'Weight Loss', 'subtitle': 'Lose weight healthily', 
        'icon': Icons.trending_down, 'value': 'Weight loss', 'recommended': recommendedGoal == 'Weight loss'},
      {'title': 'Maintenance', 'subtitle': 'Maintain current weight', 
        'icon': Icons.balance, 'value': 'Maintenance', 'recommended': recommendedGoal == 'Maintenance'},
      {'title': 'Weight Gain', 'subtitle': 'Gain weight healthily', 
        'icon': Icons.trending_up, 'value': 'Weight gain', 'recommended': recommendedGoal == 'Weight gain'},
    ];

    return Column(
      children: [
        _stepTitle('What is your dietary goal?'),
        _stepSubtitle('Based on your BMI (${bmi.toStringAsFixed(1)}), we recommend ${recommendedGoal.toLowerCase()}'),
        const SizedBox(height: 40),
        
        // Show recommendation banner
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.blue.shade50],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Based on your BMI of ${bmi.toStringAsFixed(1)} (${bmiCategory}), we recommend ${recommendedGoal.toLowerCase()} for optimal health.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        ...goals.map((goal) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _goalOptionCard(
            title: goal['title'] as String,
            subtitle: goal['subtitle'] as String,
            icon: goal['icon'] as IconData,
            isSelected: _goal == goal['value'],
            isRecommended: goal['recommended'] as bool,
            onTap: () {
              setState(() => _goal = goal['value'] as String);
              HapticFeedback.mediumImpact();
            },
          ),
        )),
        
        // Show error message if user selects non-recommended goal
        if (_goal != null && _goal != recommendedGoal) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This goal may not be optimal for your current BMI. Consider ${recommendedGoal.toLowerCase()} for better health outcomes.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _targetWeightStep() {
    final minWeight = _getHealthyWeightMin();
    final maxWeight = _getHealthyWeightMax();
    final recommendedWeight = _getRecommendedWeight();
    final hasError = _targetWeight != null && !_validateTargetWeight();
    final isRecommendedWeight = _targetWeight != null && 
        (_targetWeight! - recommendedWeight).abs() < 1.0;
    
    return Column(
      children: [
        _stepTitle('What is your target weight?'),
        _stepSubtitle('Set a realistic goal based on your BMI'),
        const SizedBox(height: 32),
        
        if (_targetWeight == null) ...[
          GestureDetector(
            onTap: () {
              setState(() {
                _targetWeight = recommendedWeight;
              });
              HapticFeedback.mediumImpact();
            },
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [darkGreen.withOpacity(0.1), lightGreen],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: darkGreen.withOpacity(0.3), width: 2),
              ),
              child: Column(
                children: [
                  Icon(Icons.flag, size: 56, color: darkGreen),
                  const SizedBox(height: 16),
                  Text('Set Your Target Weight',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    )),
                  const SizedBox(height: 8),
                  Text('Tap to begin',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    )),
                ],
              ),
            ),
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: hasError 
                  ? [Colors.red.shade50, Colors.red.shade50]
                  : [darkGreen.withOpacity(0.1), lightGreen],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: hasError ? Colors.red.shade300 : darkGreen.withOpacity(0.3), 
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text('${_targetWeight!.toStringAsFixed(1)}',
                  style: GoogleFonts.poppins(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: hasError ? Colors.red.shade700 : darkGreen,
                  )),
                Text('kg', 
                  style: GoogleFonts.poppins(
                    fontSize: 20, 
                    color: hasError ? Colors.red.shade700 : darkGreen,
                    fontWeight: FontWeight.w600,
                  )),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Change: ${(_targetWeight! - _weight).abs().toStringAsFixed(1)} kg',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (hasError) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This target may be unhealthy. Please choose a weight between ${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} kg',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (isRecommendedWeight) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Great choice! This target weight is within the recommended healthy range.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 32),
          
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 18),
              activeTrackColor: hasError ? Colors.red.shade400 : darkGreen,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: hasError ? Colors.red.shade600 : darkGreen,
              overlayColor: hasError 
                ? Colors.red.withOpacity(0.2)
                : darkGreen.withOpacity(0.2),
            ),
            child: Slider(
              value: _targetWeight!,
              min: 30,
              max: 200,
              divisions: 340,
              onChanged: (value) {
                setState(() => _targetWeight = value);
                HapticFeedback.selectionClick();
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30 kg', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                Text('200 kg', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade50, Colors.orange.shade50],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.recommend, color: Colors.orange.shade700, size: 22),
                    const SizedBox(width: 8),
                    Text('Recommended Target',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange.shade900,
                      )),
                  ],
                ),
                const SizedBox(height: 12),
                Text('${recommendedWeight.toStringAsFixed(1)} kg',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  )),
                const SizedBox(height: 8),
                Text(
                  'Healthy range: ${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} kg',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  double _getHealthyWeightMin() {
    final heightM = _height / 100;
    return 18.5 * (heightM * heightM);
  }

  double _getHealthyWeightMax() {
    final heightM = _height / 100;
    return 24.9 * (heightM * heightM);
  }

  Widget _activityStep() {
    final activities = [
      {'title': 'Sedentary', 'subtitle': 'Little to no exercise', 
        'icon': Icons.chair, 'value': 'Sedentary'},
      {'title': 'Light Active', 'subtitle': 'Light exercise 1-3 days/week', 
        'icon': Icons.directions_walk, 'value': 'Light active'},
      {'title': 'Moderate', 'subtitle': 'Moderate exercise 3-5 days/week', 
        'icon': Icons.directions_run, 'value': 'Moderate'},
      {'title': 'Very Active', 'subtitle': 'Hard exercise 6-7 days/week', 
        'icon': Icons.fitness_center, 'value': 'Very active'},
    ];

    return Column(
      children: [
        _stepTitle('What is your activity level?'),
        const SizedBox(height: 40),
        ...activities.map((activity) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _optionCard(
            title: activity['title'] as String,
            subtitle: activity['subtitle'] as String,
            icon: activity['icon'] as IconData,
            isSelected: _activity == activity['value'],
            onTap: () {
              setState(() => _activity = activity['value'] as String);
              HapticFeedback.mediumImpact();
            },
          ),
        )),
      ],
    );
  }

  Widget _conditionsStep() {
    final conditions = [
      'Diabetes', 'Hypertension', 'CKD', 'Hyperlipidemia', 'None'
    ];
    
    return Column(
      children: [
        _stepTitle('Do you have any health conditions?'),
        _stepSubtitle('Select all that apply'),
        const SizedBox(height: 40),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...conditions.map((condition) => _multiSelectChip(
              label: condition,
              isSelected: _conditions.contains(condition),
              onTap: () {
                _toggleCondition(condition);
                HapticFeedback.selectionClick();
              },
            )),
            _multiSelectChip(
              label: 'Other',
              isSelected: false,
              onTap: () => _showCustomDialog(
                'Add Health Condition',
                'Enter your health condition',
                (value) {
                  setState(() {
                    _conditions.remove('None');
                    _conditions.add(value);
                  });
                  HapticFeedback.mediumImpact();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _restrictionsStep() {
    final restrictions = [
      'Vegetarian', 'Vegan', 'Dairy-free', 
      'Nut allergy', 'Gluten-free', 'Pork-free', 'None'
    ];
    
    return Column(
      children: [
        _stepTitle('Any dietary restrictions?'),
        _stepSubtitle('Select all that apply (optional)'),
        const SizedBox(height: 40),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...restrictions.map((restriction) => _multiSelectChip(
              label: restriction,
              isSelected: _restrictions.contains(restriction),
              onTap: () {
                _toggleRestriction(restriction);
                HapticFeedback.selectionClick();
              },
            )),
            _multiSelectChip(
              label: 'Other',
              isSelected: false,
              onTap: () => _showCustomDialog(
                'Add Dietary Restriction',
                'Enter your dietary restriction or allergy',
                (value) {
                  setState(() {
                    _restrictions.remove('None');
                    _restrictions.add(value);
                  });
                  HapticFeedback.mediumImpact();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mealsPerDayStep() {
    final mealOptions = [
      {'title': '2 Meals', 'subtitle': 'Intermittent fasting style', 
        'icon': Icons.restaurant, 'value': 2},
      {'title': '3 Meals', 'subtitle': 'Traditional breakfast, lunch, dinner', 
        'icon': Icons.restaurant_menu, 'value': 3},
      {'title': '4 Meals', 'subtitle': '3 meals + 1 snack', 
        'icon': Icons.local_dining, 'value': 4},
      {'title': '5-6 Meals', 'subtitle': 'Small frequent meals', 
        'icon': Icons.fastfood, 'value': 6},
    ];

    return Column(
      children: [
        _stepTitle('How many meals per day?'),
        _stepSubtitle('Choose your preferred eating schedule'),
        const SizedBox(height: 40),
        ...mealOptions.map((option) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _optionCard(
            title: option['title'] as String,
            subtitle: option['subtitle'] as String,
            icon: option['icon'] as IconData,
            isSelected: _mealsPerDay == option['value'],
            onTap: () {
              setState(() => _mealsPerDay = option['value'] as int);
              HapticFeedback.mediumImpact();
            },
          ),
        )),
      ],
    );
  }

  Widget _mealPreferencesStep() {
    final preferences = [
      'Home-cooked meals',
      'Quick & easy recipes',
      'Meal prep friendly',
      'Restaurant-style',
      'Traditional Filipino',
      'International cuisine',
      'Budget-friendly',
      'High protein',
    ];
    
    return Column(
      children: [
        _stepTitle('Meal preferences'),
        _stepSubtitle('What type of meals do you prefer? (Select all that apply)'),
        const SizedBox(height: 40),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: preferences.map((pref) => _multiSelectChip(
            label: pref,
            isSelected: _mealPreferences.contains(pref),
            onTap: () {
              setState(() {
                if (_mealPreferences.contains(pref)) {
                  _mealPreferences.remove(pref);
                } else {
                  _mealPreferences.add(pref);
                }
              });
              HapticFeedback.selectionClick();
            },
          )).toList(),
        ),
      ],
    );
  }

  void _showCustomDialog(String title, String hint, Function(String) onSave) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: lightGreen,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                onSave(value);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('Add', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _stepTitle(String title) {
    return Text(title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: darkGreen,
      ));
  }

  Widget _stepSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(subtitle,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.grey.shade600,
        )),
    );
  }

  Widget _optionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? darkGreen.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.grey.shade300,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: darkGreen.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5))]
              : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected ? darkGreen : lightGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, 
                color: isSelected ? Colors.white : darkGreen,
                size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? darkGreen : Colors.black87,
                    )),
                  const SizedBox(height: 4),
                  Text(subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    )),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: darkGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 20),
              ),
          ],
        ),
      ),
    );
  }

  Widget _goalOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required bool isRecommended,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? darkGreen.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? darkGreen : (isRecommended ? Colors.blue.shade300 : Colors.grey.shade300),
            width: isSelected ? 3 : (isRecommended ? 2.5 : 2),
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: darkGreen.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5))]
              : isRecommended
                  ? [BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 3))]
                  : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected ? darkGreen : (isRecommended ? Colors.blue.shade100 : lightGreen),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, 
                color: isSelected ? Colors.white : (isRecommended ? Colors.blue.shade700 : darkGreen),
                size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? darkGreen : Colors.black87,
                        )),
                      if (isRecommended) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Recommended',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            )),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    )),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: darkGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 20),
              ),
          ],
        ),
      ),
    );
  }

  Widget _multiSelectChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? darkGreen : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.grey.shade300,
            width: isSelected ? 2.5 : 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: darkGreen.withOpacity(0.2), blurRadius: 10)]
              : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Text(label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : darkGreen,
          )),
      ),
    );
  }

  void _toggleCondition(String condition) {
    setState(() {
      if (condition == 'None') {
        _conditions.clear();
        _conditions.add('None');
      } else {
        _conditions.remove('None');
        if (_conditions.contains(condition)) {
          _conditions.remove(condition);
        } else {
          _conditions.add(condition);
        }
      }
    });
  }

  void _toggleRestriction(String restriction) {
    setState(() {
      if (restriction == 'None') {
        _restrictions.clear();
        _restrictions.add('None');
      } else {
        _restrictions.remove('None');
        if (_restrictions.contains(restriction)) {
          _restrictions.remove(restriction);
        } else {
          _restrictions.add(restriction);
        }
      }
    });
  }

  // BMI Helper methods
  double _calculateBMI(double heightCm, double weightKg) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }
  
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
  
  Color _getBMIColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue.shade600;
      case 'Normal weight':
        return Colors.green.shade600;
      case 'Overweight':
        return Colors.orange.shade600;
      case 'Obese':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getBMIDescription(String category) {
    switch (category) {
      case 'Underweight':
        return 'Your BMI suggests you may be underweight. A balanced nutrition plan can help you reach a healthy weight safely.';
      case 'Normal weight':
        return 'Excellent! Your BMI is in the healthy range. Maintain your healthy lifestyle with balanced nutrition and regular activity.';
      case 'Overweight':
        return 'Your BMI suggests you may be overweight. We\'ll create a sustainable plan to help you reach your health goals.';
      case 'Obese':
        return 'Your BMI suggests you may be in the obese range. Let\'s work together on a personalized plan for better health.';
      default:
        return '';
    }
  }

  String _getHealthyWeightRange(double heightCm) {
    final heightM = heightCm / 100;
    final minWeight = 18.5 * (heightM * heightM);
    final maxWeight = 24.9 * (heightM * heightM);
    return '${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} kg';
  }

  String _getRecommendedGoal(String bmiCategory) {
    switch (bmiCategory) {
      case 'Underweight':
        return 'Weight gain';
      case 'Normal weight':
        return 'Maintenance';
      case 'Overweight':
      case 'Obese':
        return 'Weight loss';
      default:
        return 'Maintenance';
    }
  }

  // Helper methods for saving profile data
  String _getGoalDescription(String goal) {
    switch (goal) {
      case 'Weight loss':
        return 'Lose weight healthily and sustainably';
      case 'Weight gain':
        return 'Gain weight through healthy nutrition';
      case 'Maintenance':
        return 'Maintain current weight and health';
      default:
        return 'Achieve your health and fitness goals';
    }
  }

  String _getGoalType(String goal) {
    switch (goal) {
      case 'Weight loss':
        return 'weight_loss';
      case 'Weight gain':
        return 'weight_gain';
      case 'Maintenance':
        return 'maintenance';
      default:
        return 'maintenance';
    }
  }

  double? _calculateTargetCalories(UserProfile profile) {
    // Basic BMR calculation (simplified)
    double bmr;
    if (profile.gender == 'Male') {
      bmr = 88.362 + (13.397 * profile.weight) + (4.799 * profile.height) - (5.677 * 25); // Assuming age 25
    } else {
      bmr = 447.593 + (9.247 * profile.weight) + (3.098 * profile.height) - (4.330 * 25); // Assuming age 25
    }

    // Activity multiplier
    double multiplier = 1.2; // Sedentary
    switch (profile.activity) {
      case 'Light active':
        multiplier = 1.375;
        break;
      case 'Moderate':
        multiplier = 1.55;
        break;
      case 'Very active':
        multiplier = 1.725;
        break;
    }

    double targetCalories = bmr * multiplier;

    // Adjust based on goal
    switch (profile.goal) {
      case 'Weight loss':
        targetCalories -= 500; // 500 calorie deficit
        break;
      case 'Weight gain':
        targetCalories += 500; // 500 calorie surplus
        break;
    }

    return targetCalories;
  }

  String _getConditionDescription(String condition) {
    switch (condition) {
      case 'Diabetes':
        return 'Diabetes mellitus - blood sugar management required';
      case 'Hypertension':
        return 'High blood pressure - sodium restriction recommended';
      case 'CKD':
        return 'Chronic Kidney Disease - protein and sodium monitoring needed';
      case 'Hyperlipidemia':
        return 'High cholesterol - heart-healthy diet recommended';
      default:
        return 'Health condition requiring dietary considerations';
    }
  }

  String _getConditionSeverity(String condition) {
    // Default to moderate for most conditions
    return 'moderate';
  }

  String _getAllergyType(String restriction) {
    switch (restriction) {
      case 'Vegetarian':
      case 'Vegan':
        return 'dietary';
      case 'Dairy-free':
      case 'Nut allergy':
      case 'Gluten-free':
      case 'Pork-free':
        return 'food';
      default:
        return 'food';
    }
  }

  String _getAllergySeverity(String restriction) {
    switch (restriction) {
      case 'Nut allergy':
        return 'severe';
      case 'Dairy-free':
      case 'Gluten-free':
        return 'moderate';
      default:
        return 'mild';
    }
  }
}

class HeightRulerPainter extends CustomPainter {
  final Color color;
  HeightRulerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 2;

    // Draw vertical ruler lines (inverted - 220cm at top, 100cm at bottom)
    for (int i = 0; i <= 12; i++) {
      final y = (size.height / 12) * i;
      final isMajor = i % 3 == 0;
      
      paint.strokeWidth = isMajor ? 3 : 1;
      paint.color = isMajor ? color.withOpacity(0.6) : color.withOpacity(0.3);
      
      canvas.drawLine(
        Offset(size.width * 0.1, y),
        Offset(size.width * 0.9, y),
        paint,
      );
      
      if (isMajor) {
        // Draw height labels - inverted (220cm at top i=0, 100cm at bottom i=12)
        final height = 220 - (i * 10);
        final textPainter = TextPainter(
          text: TextSpan(
            text: '${height}cm',
            style: TextStyle(
              color: color.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(size.width * 0.05, y - textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Data models
class OnboardingStep {
  final String title;
  final bool isRequired;
  final bool Function() validator;
  final String errorMessage;

  OnboardingStep({
    required this.title,
    required this.isRequired,
    required this.validator,
    required this.errorMessage,
  });
}

class UserProfile {
  final String gender;
  final double height;
  final double weight;
  final String goal;
  final String activity;
  final List<String> conditions;
  final List<String> restrictions;
  final double? targetWeight;
  final String planMode;
  final int? mealsPerDay;
  final List<String>? mealPreferences;
  final String? dailyBudget;

  UserProfile({
    required this.gender,
    required this.height,
    required this.weight,
    required this.goal,
    required this.activity,
    required this.conditions,
    required this.restrictions,
    this.targetWeight,
    required this.planMode,
    this.mealsPerDay,
    this.mealPreferences,
    this.dailyBudget,
  });

  Map<String, dynamic> toJson() => {
    'gender': gender,
    'height': height,
    'weight': weight,
    'goal': goal,
    'activity': activity,
    'conditions': conditions,
    'restrictions': restrictions,
    'targetWeight': targetWeight,
    'planMode': planMode,
    'mealsPerDay': mealsPerDay,
    'mealPreferences': mealPreferences,
    'dailyBudget': dailyBudget,
    'createdAt': DateTime.now().toIso8601String(),
  };
} 