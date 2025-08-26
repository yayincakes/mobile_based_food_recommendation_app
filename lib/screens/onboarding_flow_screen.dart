import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final Color darkGreen = const Color(0xFF006400);

  int _step = 0;

  String? _gender;
  String? _goal;
  String? _activity;

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetController = TextEditingController();

  final Set<String> _conditions = {};       // Disease-specific
  final Set<String> _restrictions = {};     // Dietary restrictions/allergies

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _next() {
    // minimal validations
    if (_step == 0 && _gender == null) return _warn('Please select a gender.');
    if (_step == 1 && _heightController.text.trim().isEmpty) return _warn('Please enter your height.');
    if (_step == 2 && _weightController.text.trim().isEmpty) return _warn('Please enter your weight.');
    if (_step == 3 && _goal == null) return _warn('Please select a dietary goal.');
    if (_step == 4 && _activity == null) return _warn('Please select an activity level.');
    if (_step == 5 && _conditions.isEmpty) return _warn('Select at least one health condition (or None).');
    if (_step == 6 && _targetController.text.trim().isEmpty) return _warn('Please enter a target weight.');

    if (_step < 6) {
      setState(() => _step++);
    } else {
      // Here you'd save profile/preferences and generate plan based on:
      // gender, height, weight, goal, activity, conditions, restrictions, target
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  void _back() {
    if (_step == 0) {
      Navigator.pushReplacementNamed(context, '/create_plan');
    } else {
      setState(() => _step--);
    }
  }

  void _warn(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    final steps = <Widget>[
      _selectStep('What is your gender?', ['Male', 'Female'], (v) => _gender = v),
      _inputStep('What is your height?', _heightController, hint: 'cm'),
      _inputStep('What is your weight?', _weightController, hint: 'kg'),
      _selectStep('What is your dietary goal?', ['Weight loss','Maintenance','Weight gain'], (v) => _goal = v),
      _selectStep('What is your activity level?', ['Sedentary','Light active','Moderate','Very active'], (v) => _activity = v),
      _multiSelectStep(
        title: 'Do you have any health conditions?',
        options: const ['Diabetes','Hypertension','CKD','Hyperlipidemia','None'],
        set: _conditions,
        allowNone: true,
      ),
      _inputStep('What is your target weight?', _targetController, hint: 'kg'),
      // You can add another step for restrictions if you want it separated
      _multiSelectStep(
        title: 'Dietary restrictions / allergies',
        options: const ['Vegetarian','Vegan','Dairy‑free','Nut allergy','Gluten‑free','Pork‑free','None'],
        set: _restrictions,
        allowNone: true,
      ),
    ];

    // keep index in range
    final clampedIndex = _step.clamp(0, steps.length - 1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Text('Create Your Plan'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: _back),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text('FitMeal', style: GoogleFonts.pacifico(fontSize: 28, color: darkGreen)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: LinearProgressIndicator(
                value: (clampedIndex + 1) / steps.length,
                color: darkGreen,
                backgroundColor: Colors.grey.shade300,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: steps[clampedIndex]),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52),
                ),
                onPressed: _next,
                child: Text(clampedIndex == steps.length - 1 ? 'Finish' : 'Next',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectStep(String question, List<String> options, void Function(String) onSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(question, textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          ...options.map((opt) {
            final isSelected = (_gender == opt) || (_goal == opt) || (_activity == opt);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? darkGreen : Colors.grey.shade200,
                  foregroundColor: isSelected ? Colors.white : Colors.black87,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => setState(() => onSelect(opt)),
                child: Text(opt, style: GoogleFonts.poppins(fontSize: 16)),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _inputStep(String question, TextEditingController controller, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(question, textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint ?? 'Enter value',
              filled: true, fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ],
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
          Wrap(
            spacing: 8, runSpacing: 8,
            children: options.map((o) {
              final isSelected = set.contains(o);
              return FilterChip(
                label: Text(o),
                selected: isSelected,
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
