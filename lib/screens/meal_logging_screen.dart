import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/diet_history.dart';
import '../services/diet_history_service.dart';

class MealLoggingScreen extends StatefulWidget {
  const MealLoggingScreen({super.key});

  @override
  State<MealLoggingScreen> createState() => _MealLoggingScreenState();
}

class _MealLoggingScreenState extends State<MealLoggingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedMealType = 'breakfast';
  String _selectedUnit = 'serving';
  DateTime _selectedDate = DateTime.now();
  
  final Color darkGreen = const Color(0xFF0B6A0B);
  bool _isLoading = false;

  @override
  void dispose() {
    _foodNameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _logMeal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Create a simple diet entry with estimated nutrition values
      final entry = DietHistoryEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: _selectedDate,
        mealType: _selectedMealType,
        foodName: _foodNameController.text.trim(),
        quantity: double.parse(_quantityController.text),
        unit: _selectedUnit,
        calories: _calculateCalories(),
        protein: _calculateProtein(),
        carbs: _calculateCarbs(),
        fat: _calculateFat(),
        fiber: _calculateFiber(),
        sugar: _calculateSugar(),
        sodium: _calculateSodium(),
        loggedAt: DateTime.now(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );

      final success = await DietHistoryService.saveDietEntry(entry);
      
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Meal logged successfully!', 
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              backgroundColor: darkGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to log meal. Please try again.', 
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging meal: $e', 
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Simple nutrition calculations based on food type and quantity
  double _calculateCalories() {
    final quantity = double.parse(_quantityController.text);
    final foodName = _foodNameController.text.toLowerCase();
    
    // Basic calorie estimates per serving
    if (foodName.contains('rice') || foodName.contains('pasta')) {
      return quantity * 130; // ~130 cal per 100g
    } else if (foodName.contains('chicken') || foodName.contains('beef')) {
      return quantity * 165; // ~165 cal per 100g
    } else if (foodName.contains('fish')) {
      return quantity * 120; // ~120 cal per 100g
    } else if (foodName.contains('vegetable') || foodName.contains('salad')) {
      return quantity * 25; // ~25 cal per 100g
    } else if (foodName.contains('fruit')) {
      return quantity * 60; // ~60 cal per 100g
    } else if (foodName.contains('bread')) {
      return quantity * 250; // ~250 cal per slice
    } else {
      return quantity * 100; // Default estimate
    }
  }

  double _calculateProtein() => _calculateCalories() * 0.15 / 4; // 15% of calories from protein
  double _calculateCarbs() => _calculateCalories() * 0.50 / 4; // 50% of calories from carbs
  double _calculateFat() => _calculateCalories() * 0.35 / 9; // 35% of calories from fat
  double _calculateFiber() => _calculateCarbs() * 0.1; // 10% of carbs as fiber
  double _calculateSugar() => _calculateCarbs() * 0.2; // 20% of carbs as sugar
  double _calculateSodium() => _calculateCalories() * 0.5; // Rough sodium estimate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
        title: Text('Log Meal', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Log Your Meal',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track your nutrition and build your diet history',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Food Name
                Text(
                  'Food Name',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _foodNameController,
                  decoration: InputDecoration(
                    hintText: 'e.g., Grilled Chicken Breast',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.restaurant),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter food name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Meal Type
                Text(
                  'Meal Type',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedMealType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.schedule),
                  ),
                  items: [
                    'breakfast',
                    'lunch',
                    'dinner',
                    'snack'
                  ].map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.toUpperCase()),
                  )).toList(),
                  onChanged: (value) => setState(() => _selectedMealType = value!),
                ),
                const SizedBox(height: 16),

                // Quantity and Unit
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '1.0',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.scale),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Invalid number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unit',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedUnit,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: [
                              'serving',
                              'cup',
                              'piece',
                              'gram',
                              'ounce'
                            ].map((unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            )).toList(),
                            onChanged: (value) => setState(() => _selectedUnit = value!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Date
                Text(
                  'Date',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 12),
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                Text(
                  'Notes (Optional)',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Any additional notes about this meal...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.note),
                  ),
                ),
                const SizedBox(height: 32),

                // Log Meal Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _logMeal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Log Meal',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
