import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final PageController _pageController = PageController();

  int _step = 0;
  bool _isLoading = false;

  // User data
  String? _gender;
  String? _goal;
  String? _activity;

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetController = TextEditingController();

  final Set<String> _conditions = {};
  final Set<String> _restrictions = {};

  // Form keys for validation
  final _heightFormKey = GlobalKey<FormState>();
  final _weightFormKey = GlobalKey<FormState>();
  final _targetFormKey = GlobalKey<FormState>();

  // Steps configuration
  late final List<OnboardingStep> _steps;

  @override
  void initState() {
    super.initState();
    _initializeSteps();
  }

  void _initializeSteps() {
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
        validator: () => _heightFormKey.currentState?.validate() ?? false,
        errorMessage: 'Please enter a valid height',
      ),
      OnboardingStep(
        title: 'What is your weight?',
        isRequired: true,
        validator: () => _weightFormKey.currentState?.validate() ?? false,
        errorMessage: 'Please enter a valid weight',
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
        errorMessage: 'Please select at least one option (or None)',
      ),
      OnboardingStep(
        title: 'What is your target weight?',
        isRequired: false,
        validator: () => _targetController.text.isEmpty || _targetFormKey.currentState?.validate() == true,
        errorMessage: 'Please enter a valid target weight',
      ),
      OnboardingStep(
        title: 'Dietary restrictions / allergies',
        isRequired: false,
        validator: () => true, // Optional step
        errorMessage: '',
      ),
    ];
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetController.dispose();
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
      Navigator.pushReplacementNamed(context, '/create_plan');
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
      // Validate all required fields
      final height = double.tryParse(_heightController.text);
      final weight = double.tryParse(_weightController.text);
      final target = _targetController.text.isNotEmpty 
          ? double.tryParse(_targetController.text)
          : null;

      if (height == null || weight == null) {
        throw Exception('Invalid height or weight');
      }

      // Simulate plan generation
      await Future.delayed(const Duration(seconds: 2));

      // Save user profile data (implement with your preferred storage solution)
      await _saveUserProfile(UserProfile(
        gender: _gender!,
        height: height,
        weight: weight,
        goal: _goal!,
        activity: _activity!,
        conditions: _conditions.toList(),
        restrictions: _restrictions.toList(),
        targetWeight: target,
        planMode: widget.planMode,
      ));

      if (!mounted) return;

      // Show success and navigate to dashboard
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
    // TODO: Implement with your preferred storage solution
    // This could be SharedPreferences, Hive, SQLite, or a web API
    print('Saving user profile: ${profile.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Text('Create Your Plan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _back,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress header
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('FitMeal', 
                    style: GoogleFonts.pacifico(fontSize: 28, color: darkGreen)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_step + 1) / _steps.length,
                    color: darkGreen,
                    backgroundColor: Colors.grey.shade300,
                    minHeight: 6,
                  ),
                  const SizedBox(height: 8),
                  Text('Step ${_step + 1} of ${_steps.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 12, 
                      color: Colors.black54,
                    )),
                ],
              ),
            ),
            
            // Step content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _steps.length,
                itemBuilder: (context, index) => _buildStepContent(index),
              ),
            ),
            
            // Navigation buttons
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading ? null : _back,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: darkGreen,
                          minimumSize: const Size.fromHeight(52),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: _step > 0 ? 2 : 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(52),
                      ),
                      onPressed: _isLoading ? null : _next,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              _step == _steps.length - 1 
                                  ? 'Create Plan' 
                                  : 'Next',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(int index) {
    switch (index) {
      case 0: // Gender
        return _selectStep(
          'What is your gender?',
          ['Male', 'Female', 'Other'],
          (v) => setState(() => _gender = v),
          _gender,
        );
      case 1: // Height
        return _inputStep(
          'What is your height?',
          _heightController,
          formKey: _heightFormKey,
          hint: 'cm',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) {
            if (v?.isEmpty ?? true) return 'Please enter your height';
            final height = int.tryParse(v!);
            if (height == null) return 'Please enter a valid number';
            if (height < 50 || height > 300) return 'Please enter a realistic height';
            return null;
          },
        );
      case 2: // Weight
        return _inputStep(
          'What is your weight?',
          _weightController,
          formKey: _weightFormKey,
          hint: 'kg',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
          validator: (v) {
            if (v?.isEmpty ?? true) return 'Please enter your weight';
            final weight = double.tryParse(v!);
            if (weight == null) return 'Please enter a valid number';
            if (weight < 20 || weight > 500) return 'Please enter a realistic weight';
            return null;
          },
        );
      case 3: // Goal
        return _selectStep(
          'What is your dietary goal?',
          ['Weight loss', 'Maintenance', 'Weight gain'],
          (v) => setState(() => _goal = v),
          _goal,
        );
      case 4: // Activity
        return _selectStep(
          'What is your activity level?',
          ['Sedentary', 'Light active', 'Moderate', 'Very active'],
          (v) => setState(() => _activity = v),
          _activity,
        );
      case 5: // Health conditions
        return _multiSelectStep(
          title: 'Do you have any health conditions?',
          options: const ['Diabetes', 'Hypertension', 'CKD', 'Hyperlipidemia', 'None'],
          set: _conditions,
          allowNone: true,
        );
      case 6: // Target weight
        return _inputStep(
          'What is your target weight? (Optional)',
          _targetController,
          formKey: _targetFormKey,
          hint: 'kg',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
          validator: (v) {
            if (v?.isEmpty ?? true) return null; // Optional field
            final target = double.tryParse(v!);
            if (target == null) return 'Please enter a valid number';
            if (target < 20 || target > 500) return 'Please enter a realistic weight';
            return null;
          },
        );
      case 7: // Restrictions
        return _multiSelectStep(
          title: 'Dietary restrictions / allergies',
          options: const ['Vegetarian', 'Vegan', 'Dairy-free', 'Nut allergy', 'Gluten-free', 'Pork-free', 'None'],
          set: _restrictions,
          allowNone: true,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _selectStep(String question, List<String> options, void Function(String) onSelect, String? selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(question, textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          ...options.map((opt) {
            final isSelected = selectedValue == opt;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? darkGreen : Colors.grey.shade200,
                    foregroundColor: isSelected ? Colors.white : Colors.black87,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => onSelect(opt),
                  child: Text(opt, style: GoogleFonts.poppins(fontSize: 16)),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _inputStep(
    String question, 
    TextEditingController controller, {
    GlobalKey<FormState>? formKey,
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(question, textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 18),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              validator: validator,
              decoration: InputDecoration(
                hintText: hint ?? 'Enter value',
                filled: true, 
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                errorStyle: GoogleFonts.poppins(color: Colors.red),
              ),
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _multiSelectStep({
    required String title,
    required List<String> options,
    required Set<String> set,
    bool allowNone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(title, textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Text(
            'Select all that apply',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8, 
            runSpacing: 8,
            children: options.map((o) {
              final isSelected = set.contains(o);
              return FilterChip(
                label: Text(o, style: GoogleFonts.poppins()),
                selected: isSelected,
                selectedColor: darkGreen.withOpacity(0.2),
                checkmarkColor: darkGreen,
                onSelected: (_) {
                  setState(() {
                    if (allowNone && o == 'None') {
                      set
                        ..clear()
                        ..add('None');
                    } else {
                      set.remove('None');
                      isSelected ? set.remove(o) : set.add(o);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
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
    'createdAt': DateTime.now().toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    gender: json['gender'],
    height: json['height'].toDouble(),
    weight: json['weight'].toDouble(),
    goal: json['goal'],
    activity: json['activity'],
    conditions: List<String>.from(json['conditions']),
    restrictions: List<String>.from(json['restrictions']),
    targetWeight: json['targetWeight']?.toDouble(),
    planMode: json['planMode'],
  );
}