import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTab = 0; // 0=weekly, 1=daily
  DateTime selectedDate = DateTime.now();
  final Color darkGreen = const Color(0xFF006400);
  
  // Get day of week (0=Mon, 6=Sun)
  int get currentDayOfWeek => (selectedDate.weekday - 1) % 7;
  
  // Weekly meal plan data structure - Filipino Meals
  final Map<int, Map<String, dynamic>> weeklyMealPlan = {
    // Monday (0)
    0: {
      'breakfast': {'name': 'Champorado with Tuyo', 'calories': 380, 'protein': 15, 'carbs': 62, 'fat': 9},
      'lunch': {'name': 'Chicken Tinola', 'calories': 420, 'protein': 38, 'carbs': 32, 'fat': 16},
      'dinner': {'name': 'Grilled Bangus with Brown Rice', 'calories': 450, 'protein': 32, 'carbs': 48, 'fat': 12},
      'snack': {'name': 'Banana Cue (1 piece)', 'calories': 180, 'protein': 2, 'carbs': 38, 'fat': 4},
    },
    // Tuesday (1)
    1: {
      'breakfast': {'name': 'Tapsilog', 'calories': 520, 'protein': 28, 'carbs': 58, 'fat': 18},
      'lunch': {'name': 'Sinigang na Baboy', 'calories': 380, 'protein': 25, 'carbs': 35, 'fat': 14},
      'dinner': {'name': 'Pinakbet with Grilled Fish', 'calories': 400, 'protein': 30, 'carbs': 42, 'fat': 10},
      'snack': {'name': 'Kamote (Steamed)', 'calories': 150, 'protein': 3, 'carbs': 32, 'fat': 1},
    },
    // Wednesday (2)
    2: {
      'breakfast': {'name': 'Pandesal with Scrambled Egg', 'calories': 340, 'protein': 18, 'carbs': 44, 'fat': 12},
      'lunch': {'name': 'Chicken Adobo with Rice', 'calories': 480, 'protein': 35, 'carbs': 52, 'fat': 15},
      'dinner': {'name': 'Ginisang Monggo with Fish', 'calories': 420, 'protein': 28, 'carbs': 55, 'fat': 9},
      'snack': {'name': 'Fresh Mango', 'calories': 120, 'protein': 1, 'carbs': 28, 'fat': 1},
    },
    // Thursday (3)
    3: {
      'breakfast': {'name': 'Lugaw with Egg', 'calories': 320, 'protein': 12, 'carbs': 52, 'fat': 8},
      'lunch': {'name': 'Beef Nilaga', 'calories': 450, 'protein': 32, 'carbs': 38, 'fat': 18},
      'dinner': {'name': 'Tortang Talong with Rice', 'calories': 380, 'protein': 16, 'carbs': 54, 'fat': 12},
      'snack': {'name': 'Peanuts (handful)', 'calories': 160, 'protein': 7, 'carbs': 6, 'fat': 14},
    },
    // Friday (4)
    4: {
      'breakfast': {'name': 'Arroz Caldo', 'calories': 350, 'protein': 15, 'carbs': 58, 'fat': 8},
      'lunch': {'name': 'Fish Sinigang', 'calories': 360, 'protein': 28, 'carbs': 36, 'fat': 10},
      'dinner': {'name': 'Chicken Afritada', 'calories': 460, 'protein': 34, 'carbs': 48, 'fat': 14},
      'snack': {'name': 'Turon (1 piece)', 'calories': 200, 'protein': 2, 'carbs': 35, 'fat': 7},
    },
    // Saturday (5)
    5: {
      'breakfast': {'name': 'Longsilog', 'calories': 540, 'protein': 26, 'carbs': 62, 'fat': 20},
      'lunch': {'name': 'Kare-Kare with Bagoong', 'calories': 480, 'protein': 28, 'carbs': 45, 'fat': 22},
      'dinner': {'name': 'Grilled Tilapia with Ensaladang Talong', 'calories': 380, 'protein': 35, 'carbs': 32, 'fat': 12},
      'snack': {'name': 'Mais (Boiled Corn)', 'calories': 140, 'protein': 4, 'carbs': 30, 'fat': 2},
    },
    // Sunday (6)
    6: {
      'breakfast': {'name': 'Bibingka with Salted Egg', 'calories': 420, 'protein': 14, 'carbs': 58, 'fat': 16},
      'lunch': {'name': 'Lechon Kawali with Atchara', 'calories': 520, 'protein': 32, 'carbs': 38, 'fat': 28},
      'dinner': {'name': 'Laing with Grilled Fish', 'calories': 400, 'protein': 26, 'carbs': 44, 'fat': 14},
      'snack': {'name': 'Gulaman', 'calories': 100, 'protein': 0, 'carbs': 25, 'fat': 0},
    },
  };

  // Daily goals
  final int dailyCalorieGoal = 1800;
  final int dailyProteinGoal = 80;
  final int dailyCarbsGoal = 200;
  final int dailyFatGoal = 60;

  // Get current day's meals
  Map<String, dynamic> get todaysMeals => weeklyMealPlan[currentDayOfWeek] ?? {};
  
  // Calculate daily totals
  int get totalCalories {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['calories'] as int? ?? 0);
    });
    return total;
  }

  int get totalProtein {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['protein'] as int? ?? 0);
    });
    return total;
  }

  int get totalCarbs {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['carbs'] as int? ?? 0);
    });
    return total;
  }

  int get totalFat {
    int total = 0;
    todaysMeals.forEach((key, meal) {
      if (meal is Map) total += (meal['fat'] as int? ?? 0);
    });
    return total;
  }

  String get _dailyTip {
    final calLeft = (dailyCalorieGoal - totalCalories);
    final proLeft = (dailyProteinGoal - totalProtein);
    final carbLeft = (dailyCarbsGoal - totalCarbs);
    final fatLeft = (dailyFatGoal - totalFat);

    if (calLeft < -150) return 'You\'re ${calLeft.abs()} kcal over. Choose a lighter meal and add a short walk.';
    if (fatLeft < -10)  return 'Fat is a bit high today. Go for lean protein and veggies next.';
    if (carbLeft < -25) return 'Carbs trending high. Prefer leafy greens and proteins tonight.';

    if (proLeft > 20)   return 'You\'re ${proLeft}g short on protein. Add chicken, fish, or eggs next.';
    if (calLeft > 250)  return 'About ${calLeft} kcal left—try a balanced snack.';
    if (carbLeft > 40)  return 'You still have ${carbLeft}g carbs—whole grains could help.';
    if (fatLeft > 15)   return 'Room for ${fatLeft}g fat—add a little olive oil or nuts.';

    if (calLeft.abs() <= 100 && proLeft <= 10 && carbLeft <= 20 && fatLeft <= 10) {
      return 'Great pace! You\'re on track to hit today\'s goals.';
    }
    return 'Keep it steady—aim for balanced portions in your next meal.';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    
    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    final day = date.day;
    
    return '$weekday, $month $day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            children: [
              const SizedBox(height: 16),
              Center(child: Text('FitMeal', style: GoogleFonts.pacifico(fontSize: 32, color: darkGreen))),
              const SizedBox(height: 20),

              // Daily progress card
              _dailyProgressCard(),

              const SizedBox(height: 14),

              // Smart reminder
              _reminderCard(_dailyTip),

              const SizedBox(height: 18),

              // Plan selector tabs
              Container(
                height: 46,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.grey.shade200),
                child: Row(children: [
                  _planTabButton('Weekly Plan', 0),
                  _planTabButton('Daily Plan', 1),
                ]),
              ),
              const SizedBox(height: 16),

              // Content based on selected tab
              if (selectedTab == 0) _buildWeeklyPlan() else _buildDailyPlan(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyPlan() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Overview', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        
        // Weekly summary cards
        ...List.generate(7, (index) {
          final dayMeals = weeklyMealPlan[index]!;
          int dayTotal = 0;
          dayMeals.forEach((key, meal) {
            if (meal is Map) dayTotal += (meal['calories'] as int? ?? 0);
          });
          
          final isToday = index == currentDayOfWeek;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isToday ? darkGreen.withOpacity(0.08) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isToday ? darkGreen : Colors.grey.shade300,
                width: isToday ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isToday ? darkGreen : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        days[index],
                        style: GoogleFonts.poppins(
                          color: isToday ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Today',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      '$dayTotal kcal',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMealRow('Breakfast', dayMeals['breakfast']),
                _buildMealRow('Lunch', dayMeals['lunch']),
                _buildMealRow('Dinner', dayMeals['dinner']),
                _buildMealRow('Snack', dayMeals['snack']),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMealRow(String mealType, Map<String, dynamic>? meal) {
    if (meal == null) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getMealColor(mealType),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${mealType}: ${meal['name']}',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${meal['calories']} kcal',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(selectedDate),
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDate.subtract(const Duration(days: 1));
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDate.add(const Duration(days: 1));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Daily goals summary
        _dailyGoalsSummary(),
        
        const SizedBox(height: 16),
        Text('Today\'s Meals', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 12),

        // Breakfast
        _mealCard('Breakfast', todaysMeals['breakfast'], Icons.breakfast_dining, Colors.orange),
        const SizedBox(height: 10),

        // Lunch
        _mealCard('Lunch', todaysMeals['lunch'], Icons.lunch_dining, Colors.green),
        const SizedBox(height: 10),

        // Dinner
        _mealCard('Dinner', todaysMeals['dinner'], Icons.dinner_dining, Colors.blue),
        const SizedBox(height: 10),

        // Snack
        _mealCard('Snack', todaysMeals['snack'], Icons.cookie, Colors.purple),
      ],
    );
  }

  Widget _dailyGoalsSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.orange.shade700, size: 22),
              const SizedBox(width: 8),
              Text(
                'Daily Goals',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _goalStat('Calories', '$totalCalories / $dailyCalorieGoal', Colors.orange),
              _goalStat('Protein', '${totalProtein}g / ${dailyProteinGoal}g', Colors.green),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _goalStat('Carbs', '${totalCarbs}g / ${dailyCarbsGoal}g', Colors.blue),
              _goalStat('Fat', '${totalFat}g / ${dailyFatGoal}g', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _goalStat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealCard(String mealType, Map<String, dynamic>? meal, IconData icon, Color color) {
    if (meal == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mealType,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      meal['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nutritionBadge('${meal['calories']} kcal', Icons.local_fire_department, Colors.orange),
              _nutritionBadge('${meal['protein']}g P', Icons.fitness_center, Colors.green),
              _nutritionBadge('${meal['carbs']}g C', Icons.rice_bowl, Colors.blue),
              _nutritionBadge('${meal['fat']}g F', Icons.water_drop, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nutritionBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.green;
      case 'dinner':
        return Colors.blue;
      case 'snack':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {});
    }
  }

  Widget _dailyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkGreen.withOpacity(0.08), Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: darkGreen.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: darkGreen),
              const SizedBox(width: 8),
              Text(
                'Today\'s Progress',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _progressRow(
            label: 'Calories',
            value: totalCalories,
            goal: dailyCalorieGoal,
            color: Colors.orange,
            icon: Icons.local_fire_department,
            unit: 'kcal',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _macroTile('Protein', totalProtein, dailyProteinGoal, Colors.green)),
              const SizedBox(width: 8),
              Expanded(child: _macroTile('Carbs', totalCarbs, dailyCarbsGoal, Colors.blue)),
              const SizedBox(width: 8),
              Expanded(child: _macroTile('Fat', totalFat, dailyFatGoal, Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressRow({
    required String label,
    required int value,
    required int goal,
    required Color color,
    required IconData icon,
    String unit = '',
  }) {
    final pct = (value / goal).clamp(0, 1);
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                  const Spacer(),
                  Text(
                    '$value / $goal $unit',
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: pct.toDouble(),
                  minHeight: 10,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _macroTile(String label, int value, int goal, Color color) {
    final pct = (value / goal).clamp(0, 1);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.bubble_chart, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            '$value/$goal',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct.toDouble(),
              minHeight: 6,
              color: color,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reminderCard(String tip) {
    final bool warn = tip.contains('over') || tip.contains('high');
    final Color bg = warn ? Colors.redAccent.withOpacity(0.12) : darkGreen.withOpacity(0.10);
    final Color iconColor = warn ? Colors.redAccent : darkGreen;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(warn ? Icons.warning_amber : Icons.lightbulb, color: iconColor, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _planTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: selectedTab == index ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: selectedTab == index
                ? [const BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1))]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: selectedTab == index ? darkGreen : Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}