import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OnboardingFlowScreen extends StatefulWidget {
  final String planMode;
  
  const OnboardingFlowScreen({
    super.key,
    this.planMode = 'auto',
  });

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  final PageController _pageController = PageController();

  int _step = 0;
  bool _isLoading = false;

  // User data
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
    _initializeSteps();
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
          validator: () => _height >= 50 && _height <= 250,
          errorMessage: 'Please select a valid height',
        ),
        OnboardingStep(
          title: 'What is your current weight?',
          isRequired: true,
          validator: () => _weight >= 20 && _weight <= 300,
          errorMessage: 'Please select a valid weight',
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
          validator: () => _height >= 50 && _height <= 250,
          errorMessage: 'Please select a valid height',
        ),
        OnboardingStep(
          title: 'What is your current weight?',
          isRequired: true,
          validator: () => _weight >= 20 && _weight <= 300,
          errorMessage: 'Please select a valid weight',
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
          validator: () => _targetWeight != null,
          errorMessage: 'Please set your target weight',
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

  @override
  void dispose() {
    _customConditionController.dispose();
    _customRestrictionController.dispose();
    _pageController.dispose();
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
        const SnackBar(
          content: Text('Your personalized plan has been created!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      if (!mounted) return;
      _showError('Failed to create plan: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _saveUserProfile(UserProfile profile) async {
    debugPrint('Saving user profile: ${profile.toJson()}');
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('profileName', 'User');
      await prefs.setString('profileEmail', 'user@email.com');
      await prefs.setDouble('height', profile.height);
      await prefs.setDouble('weight', profile.weight);
      await prefs.setString('dietGoal', profile.goal);
      await prefs.setString('gender', profile.gender);
      await prefs.setString('activity', profile.activity);
      
      if (profile.targetWeight != null) {
        await prefs.setDouble('targetWeight', profile.targetWeight!);
      }
      
      await prefs.setString('healthConditions', json.encode(profile.conditions));
      await prefs.setString('restrictions', json.encode(profile.restrictions));
      await prefs.setString('planMode', profile.planMode);
      
      if (profile.mealsPerDay != null) {
        await prefs.setInt('mealsPerDay', profile.mealsPerDay!);
      }
      if (profile.mealPreferences != null) {
        await prefs.setString('mealPreferences', json.encode(profile.mealPreferences));
      }
      if (profile.dailyBudget != null) {
        await prefs.setString('dailyBudget', profile.dailyBudget!);
      }
      
      await prefs.setBool('onboardingCompleted', true);
      
      debugPrint('User profile saved successfully');
    } catch (e) {
      debugPrint('Error saving user profile: $e');
      throw Exception('Failed to save profile: $e');
    }
  }

  void _showCustomDialog(String title, String hint, Function(String) onSave) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: lightGreen,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Add', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text('Create Your Plan', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _back,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar - Responsive
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: EdgeInsets.all(constraints.maxWidth > 600 ? 24 : 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text('FitMeal', 
                        style: GoogleFonts.pacifico(fontSize: 28, color: darkGreen)),
                      const SizedBox(height: 12),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (_step + 1) / _steps.length,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [darkGreen, darkGreen.withOpacity(0.7)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Step ${_step + 1} of ${_steps.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 14, 
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        )),
                    ],
                  ),
                );
              }
            ),
            
            // Content - Responsive
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final padding = constraints.maxWidth > 600 
                      ? const EdgeInsets.symmetric(horizontal: 48, vertical: 24)
                      : const EdgeInsets.all(16);
                  
                  return PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _steps.length,
                    itemBuilder: (context, index) => SingleChildScrollView(
                      padding: padding,
                      child: _buildStepContent(index),
                    ),
                  );
                },
              ),
            ),
            
            // Buttons - Responsive
            LayoutBuilder(
              builder: (context, constraints) {
                final padding = constraints.maxWidth > 600
                    ? const EdgeInsets.symmetric(horizontal: 48, vertical: 24)
                    : const EdgeInsets.all(24);
                
                return Container(
                  padding: padding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (_step > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isLoading ? null : _back,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: darkGreen,
                              side: BorderSide(color: darkGreen),
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                            ),
                            child: Text('Back', 
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            elevation: 2,
                          ),
                          onPressed: _isLoading ? null : _next,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  _step == _steps.length - 1 ? 'Create Plan' : 'Continue',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, 
                                    fontSize: 16
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(int index) {
    if (widget.planMode == 'auto') {
      switch (index) {
        case 0:
          return _genderStep();
        case 1:
          return _heightSliderStep();
        case 2:
          return _weightSliderStep();
        case 3:
          return _bmiResultsStep();
        case 4:
          return _goalStep();
        case 5:
          return _activityStep();
        case 6:
          return _conditionsStep();
        case 7:
          return _restrictionsStep();
        default:
          return const SizedBox();
      }
    } else {
      switch (index) {
        case 0:
          return _genderStep();
        case 1:
          return _heightSliderStep();
        case 2:
          return _weightSliderStep();
        case 3:
          return _bmiResultsStep();
        case 4:
          return _goalStep();
        case 5:
          return _targetWeightStep();
        case 6:
          return _activityStep();
        case 7:
          return _mealsPerDayStep();
        case 8:
          return _mealPreferencesStep();
        case 9:
          return _conditionsStep();
        case 10:
          return _restrictionsStep();
        default:
          return const SizedBox();
      }
    }
  }

  Widget _genderStep() {
    return Column(
      children: [
        _stepTitle('What is your gender?'),
        const SizedBox(height: 40),
        // Responsive gender selection
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  Expanded(child: _genderOption('Male', Icons.man, 'Male')),
                  const SizedBox(width: 16),
                  Expanded(child: _genderOption('Female', Icons.woman, 'Female')),
                  const SizedBox(width: 16),
                  Expanded(child: _genderOption('Other', Icons.person, 'Other')),
                ],
              );
            } else {
              return Column(
                children: [
                  _genderOption('Male', Icons.man, 'Male'),
                  const SizedBox(height: 12),
                  _genderOption('Female', Icons.woman, 'Female'),
                  const SizedBox(height: 12),
                  _genderOption('Other', Icons.person, 'Other'),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _genderOption(String label, IconData icon, String value) {
    final isSelected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? darkGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, 
              size: 48, 
              color: isSelected ? Colors.white : darkGreen),
            const SizedBox(height: 12),
            Text(label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : darkGreen,
              )),
          ],
        ),
      ),
    );
  }

  Widget _heightSliderStep() {
    return Column(
      children: [
        _stepTitle('What is your height?'),
        const SizedBox(height: 40),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [darkGreen.withOpacity(0.1), lightGreen],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                '${_height.round()}',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              Text(
                'cm',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: darkGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 40),
        
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            activeTrackColor: darkGreen,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: darkGreen,
            overlayColor: darkGreen.withOpacity(0.2),
          ),
          child: Slider(
            value: _height,
            min: 100,
            max: 220,
            divisions: 120,
            onChanged: (value) => setState(() => _height = value),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('100 cm', style: GoogleFonts.poppins(color: Colors.grey)),
              Text('220 cm', style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weightSliderStep() {
    return Column(
      children: [
        _stepTitle('What is your current weight?'),
        const SizedBox(height: 40),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [darkGreen.withOpacity(0.1), lightGreen],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                '${_weight.toStringAsFixed(1)}',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              Text(
                'kg',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: darkGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 40),
        
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            activeTrackColor: darkGreen,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: darkGreen,
            overlayColor: darkGreen.withOpacity(0.2),
          ),
          child: Slider(
            value: _weight,
            min: 30,
            max: 200,
            divisions: 340,
            onChanged: (value) => setState(() => _weight = value),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('30 kg', style: GoogleFonts.poppins(color: Colors.grey)),
              Text('200 kg', style: GoogleFonts.poppins(color: Colors.grey)),
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
    final bmiDescription = _getBMIDescriptionFilipino(bmiCategory);
    final healthyRange = _getHealthyWeightRange(_height);
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                bmiColor.withOpacity(0.1),
                bmiColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Icon(Icons.favorite, size: 56, color: bmiColor),
              const SizedBox(height: 16),
              Text('Your Health Summary',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                )),
              const SizedBox(height: 8),
              Text('Based on your height and weight',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                )),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: bmiColor.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: bmiColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.monitor_weight_outlined, 
                      color: bmiColor, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Text('Body Mass Index',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    )),
                ],
              ),
              
              const SizedBox(height: 24),
              
              Text(bmi.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: bmiColor,
                  height: 1,
                )),
              
              const SizedBox(height: 12),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: bmiColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(bmiCategory,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: bmiColor,
                  )),
              ),
              
              const SizedBox(height: 20),
              
              Text(bmiDescription,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                )),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [lightGreen, lightGreen.withOpacity(0.5)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: darkGreen.withOpacity(0.2), width: 1.5),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, color: darkGreen, size: 20),
                  const SizedBox(width: 8),
                  Text('Healthy Weight Range',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: darkGreen,
                    )),
                ],
              ),
              const SizedBox(height: 12),
              Text('For your height (${_height.round()} cm)',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                )),
              const SizedBox(height: 8),
              Text(healthyRange,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _goalStep() {
    final goals = [
      {'title': 'Weight Loss', 'subtitle': 'Lose weight healthily', 
        'icon': Icons.trending_down, 'value': 'Weight loss'},
      {'title': 'Maintenance', 'subtitle': 'Maintain current weight', 
        'icon': Icons.balance, 'value': 'Maintenance'},
      {'title': 'Weight Gain', 'subtitle': 'Gain weight healthily', 
        'icon': Icons.trending_up, 'value': 'Weight gain'},
    ];

    return Column(
      children: [
        _stepTitle('What is your dietary goal?'),
        const SizedBox(height: 40),
        ...goals.map((goal) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _optionCard(
            title: goal['title'] as String,
            subtitle: goal['subtitle'] as String,
            icon: goal['icon'] as IconData,
            isSelected: _goal == goal['value'],
            onTap: () => setState(() => _goal = goal['value'] as String),
          ),
        )),
      ],
    );
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
            onTap: () => setState(() => _activity = activity['value'] as String),
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
              onTap: () => _toggleCondition(condition),
            )),
            _multiSelectChip(
              label: 'Other',
              isSelected: false,
              onTap: () => _showCustomDialog(
                'Add Health Condition',
                'Enter your health condition',
                (value) => setState(() {
                  _conditions.remove('None');
                  _conditions.add(value);
                }),
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
              onTap: () => _toggleRestriction(restriction),
            )),
            _multiSelectChip(
              label: 'Other',
              isSelected: false,
              onTap: () => _showCustomDialog(
                'Add Dietary Restriction',
                'Enter your dietary restriction or allergy',
                (value) => setState(() {
                  _restrictions.remove('None');
                  _restrictions.add(value);
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _targetWeightStep() {
    return Column(
      children: [
        _stepTitle('What is your target weight?'),
        _stepSubtitle('Set a realistic goal for your health journey'),
        const SizedBox(height: 40),
        
        if (_targetWeight != null) ...[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [darkGreen.withOpacity(0.1), lightGreen],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text('${_targetWeight!.toStringAsFixed(1)}',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  )),
                Text('kg', 
                  style: GoogleFonts.poppins(fontSize: 18, color: darkGreen)),
                const SizedBox(height: 16),
                Text(
                  'Weight difference: ${(_targetWeight! - _weight).abs().toStringAsFixed(1)} kg',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  )),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
              activeTrackColor: darkGreen,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: darkGreen,
            ),
            child: Slider(
              value: _targetWeight!,
              min: 30,
              max: 200,
              divisions: 340,
              onChanged: (value) => setState(() => _targetWeight = value),
            ),
          ),
        ] else ...[
          _optionCard(
            title: 'Set Target Weight',
            subtitle: 'Define your weight goal',
            icon: Icons.flag,
            isSelected: false,
            onTap: () => setState(() => _targetWeight = _weight),
          ),
        ],
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
            onTap: () => setState(() => _mealsPerDay = option['value'] as int),
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
        const SizedBox(height: 40), SizedBox(height: 40),
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
            },
          )).toList(),
        ),
      ],
    );
  }

  // Helper widgets
  Widget _stepTitle(String title) {
    return Text(title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkGreen,
      ));
  }

  Widget _stepSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(subtitle,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 14,
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
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? darkGreen.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? darkGreen : lightGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, 
                color: isSelected ? Colors.white : darkGreen,
                size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? darkGreen : Colors.black87,
                    )),
                  Text(subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    )),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: darkGreen, size: 24),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? darkGreen : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.grey.shade300,
            width: 2,
          ),
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
      if (condition == 'Wala') {
        _conditions.clear();
        _conditions.add('Wala');
      } else {
        _conditions.remove('Wala');
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
      if (restriction == 'Wala') {
        _restrictions.clear();
        _restrictions.add('Wala');
      } else {
        _restrictions.remove('Wala');
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

  String _getBMIDescriptionFilipino(String category) {
    switch (category) {
      case 'Underweight':
        return 'Your BMI suggests you may be underweight. A balanced nutrition plan can help you reach a healthy weight.';
      case 'Normal weight':
        return 'Great! Your BMI is in the healthy range. Maintain your healthy lifestyle with balanced nutrition and regular activity.';
      case 'Overweight':
        return 'Your BMI suggests you may be overweight. We can help you create a sustainable plan for healthier habits.';
      case 'Obese':
        return 'Your BMI suggests you may be in the obese range. Let\'s work together on a personalized plan for your health goals.';
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