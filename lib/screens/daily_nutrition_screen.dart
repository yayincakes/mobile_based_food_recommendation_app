import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'plan_history_manager.dart';
import '../services/user_data_service.dart';

class DailyNutritionScreen extends StatefulWidget {
  const DailyNutritionScreen({super.key});

  @override
  State<DailyNutritionScreen> createState() => _DailyNutritionScreenState();
}

class _DailyNutritionScreenState extends State<DailyNutritionScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  final Color soft = const Color(0xFFF7F9F7);
  
  UserProfileData? _userProfile;
  List<UserMealPlan> _plans = [];
  bool _isLoading = true;
  String _selectedPeriod = 'Today';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final userProfile = await UserDataService.getUserProfile();
      await PlanHistoryManager().initialize();
      final plans = PlanHistoryManager().plans;
      
      setState(() {
        _userProfile = userProfile;
        _plans = plans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        _snack('Error loading nutrition data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final activePlans = _plans.where((p) => p.status == PlanStatus.active).toList();
    final todayNutrition = _calculateTodayNutrition(activePlans);
    final weeklyNutrition = _calculateWeeklyNutrition(activePlans);

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Period selector
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            
            // Nutrition overview cards
            _buildNutritionOverview(todayNutrition),
            const SizedBox(height: 16),
            
            // Progress charts
            _buildProgressCharts(todayNutrition, weeklyNutrition),
            const SizedBox(height: 16),
            
            // Active plans section
            _buildActivePlansSection(activePlans),
            const SizedBox(height: 16),
            
            // Nutrition goals
            if (_userProfile != null) _buildNutritionGoals(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: darkGreen,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        tooltip: 'Back',
      ),
      title: Text('Daily Nutrition', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _loadData,
          tooltip: 'Refresh',
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Today', 'This Week', 'This Month'];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: periods.map((period) {
          final isSelected = _selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedPeriod = period),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? darkGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNutritionOverview(Map<String, dynamic> nutrition) {
    return Row(
      children: [
        Expanded(
          child: _nutritionCard(
            icon: Icons.local_fire_department,
            title: 'Calories',
            value: nutrition['calories'].toString(),
            subtitle: 'kcal',
            color: Colors.orange,
            progress: nutrition['calories'] / 2000, // Assuming 2000 as daily goal
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _nutritionCard(
            icon: Icons.fitness_center,
            title: 'Protein',
            value: nutrition['protein'].toString(),
            subtitle: 'g',
            color: Colors.blue,
            progress: nutrition['protein'] / 150, // Assuming 150g as daily goal
          ),
        ),
      ],
    );
  }

  Widget _nutritionCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCharts(Map<String, dynamic> todayNutrition, Map<String, dynamic> weeklyNutrition) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Progress',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: _buildWeeklyProgressBars(weeklyNutrition),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgressBars(Map<String, dynamic> weeklyNutrition) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final calories = [
      weeklyNutrition['monday']['calories'] as int,
      weeklyNutrition['tuesday']['calories'] as int,
      weeklyNutrition['wednesday']['calories'] as int,
      weeklyNutrition['thursday']['calories'] as int,
      weeklyNutrition['friday']['calories'] as int,
      weeklyNutrition['saturday']['calories'] as int,
      weeklyNutrition['sunday']['calories'] as int,
    ];
    
    final maxCalories = calories.reduce((a, b) => a > b ? a : b);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: days.asMap().entries.map((entry) {
        final index = entry.key;
        final day = entry.value;
        final height = maxCalories > 0 ? (calories[index] / maxCalories) * 150 : 0.0;
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              calories[index].toString(),
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 30,
              height: height,
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              day,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildActivePlansSection(List<UserMealPlan> activePlans) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Meal Plans',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          if (activePlans.isEmpty)
            Text(
              'No active meal plans. Create one from the dashboard.',
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: 14,
              ),
            )
          else
            ...activePlans.map((plan) => _buildPlanTile(plan)),
        ],
      ),
    );
  }

  Widget _buildPlanTile(UserMealPlan plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: soft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: darkGreen.withOpacity(0.1),
            child: Icon(Icons.restaurant_menu, color: darkGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${plan.progress.daysCompleted}/${plan.progress.totalDays} days',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${plan.progress.caloriesAveragePerDay.toInt()} kcal',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                '${plan.progress.proteinAveragePerDay.toInt()}g protein',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionGoals() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Nutrition Goals',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          _goalTile(
            icon: Icons.track_changes,
            title: 'Dietary Goal',
            value: _userProfile!.goal,
          ),
          _goalTile(
            icon: Icons.straighten,
            title: 'Height',
            value: '${_userProfile!.height.toStringAsFixed(0)} cm',
          ),
          _goalTile(
            icon: Icons.monitor_weight,
            title: 'Current Weight',
            value: '${_userProfile!.weight.toStringAsFixed(1)} kg',
          ),
          if (_userProfile!.targetWeight != null)
            _goalTile(
              icon: Icons.flag,
              title: 'Target Weight',
              value: '${_userProfile!.targetWeight!.toStringAsFixed(1)} kg',
            ),
        ],
      ),
    );
  }

  Widget _goalTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: soft,
            child: Icon(icon, color: darkGreen, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  Map<String, dynamic> _calculateTodayNutrition(List<UserMealPlan> activePlans) {
    if (activePlans.isEmpty) {
      return {'calories': 0, 'protein': 0, 'carbs': 0, 'fat': 0};
    }

    int totalCalories = 0;
    int totalProtein = 0;
    int totalCarbs = 0;
    int totalFat = 0;

    for (final plan in activePlans) {
      totalCalories += plan.progress.caloriesAveragePerDay.round();
      totalProtein += plan.progress.proteinAveragePerDay.round();
      // Estimate carbs and fat based on calories
      totalCarbs += (plan.progress.caloriesAveragePerDay * 0.5 / 4).round(); // 50% carbs
      totalFat += (plan.progress.caloriesAveragePerDay * 0.25 / 9).round(); // 25% fat
    }

    return {
      'calories': totalCalories,
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
    };
  }

  Map<String, dynamic> _calculateWeeklyNutrition(List<UserMealPlan> activePlans) {
    // Simplified weekly calculation
    final todayNutrition = _calculateTodayNutrition(activePlans);
    return {
      'monday': todayNutrition,
      'tuesday': todayNutrition,
      'wednesday': todayNutrition,
      'thursday': todayNutrition,
      'friday': todayNutrition,
      'saturday': todayNutrition,
      'sunday': todayNutrition,
    };
  }


  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
