import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});
  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen>
    with SingleTickerProviderStateMixin {
  final Color darkGreen = const Color(0xFF0B6A0B);
  final Color lightGreen = const Color(0xFFBFE6BE);

  // Day selector
  final days = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int _selectedDay = DateTime.now().weekday % 7; // 0..6

  // Demo state (wire up to your store later)
  int calories = 1235, caloriesGoal = 1800;
  int steps = 5200, stepsGoal = 8000;
  int water = 5, waterGoal = 8; // glasses
  int protein = 58, proteinGoal = 110;
  int carbs = 165, carbsGoal = 220;
  int fat = 35, fatGoal = 60;
  int sleep = 7, sleepGoal = 8; // hours
  int workoutMinutes = 25, workoutGoal = 30;

  // Animation controller for progress animations
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Habits (simple toggles)
  final List<_Habit> habits = [
    _Habit('Morning walk (30 min)', false, Icons.directions_walk),
    _Habit('Drink 8 glasses of water', true, Icons.local_drink),
    _Habit('Take vitamins', false, Icons.medication),
    _Habit('Stretch for 10 minutes', true, Icons.self_improvement),
    _Habit('Read nutrition labels', false, Icons.label),
  ];

  // Weekly progress data
  final List<_WeeklyData> weeklyData = [
    _WeeklyData('Mon', 1650, 7500, 6),
    _WeeklyData('Tue', 1720, 8200, 7),
    _WeeklyData('Wed', 1580, 6800, 8),
    _WeeklyData('Thu', 1650, 9100, 6),
    _WeeklyData('Fri', 1235, 5200, 7),
    _WeeklyData('Sat', 0, 0, 0), // Today (partial)
    _WeeklyData('Sun', 0, 0, 0), // Future
  ];

  double _pct(int v, int g) => (v / g).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayStr = _formatDate(today);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text('Daily Tracker', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showWeeklyProgress,
            tooltip: 'Weekly progress',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettings,
            tooltip: 'Tracker settings',
          ),
        ],
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: Today + streak
                  _headerCard(todayStr),
                  
                  const SizedBox(height: 16),

                  // Day selector
                  _daySelector(),

                  const SizedBox(height: 16),

                  // Progress snapshot card
                  _snapshotCard(),

                  const SizedBox(height: 16),

                  // Key metrics (responsive grid)
                  _metricsGrid(),

                  const SizedBox(height: 16),

                  // Macros section
                  _macrosCard(),

                  const SizedBox(height: 16),

                  // Additional metrics
                  _additionalMetricsRow(),

                  const SizedBox(height: 16),

                  // Habits and goals section
                  _habitsAndGoalsSection(),

                  const SizedBox(height: 16),

                  // Quick add section
                  _quickAddSection(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEntryDialog,
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('Log Entry', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
    );
  }

  // Header card with today's info and streak
  Widget _headerCard(String todayStr) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [darkGreen, darkGreen.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.today, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Progress", 
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, 
                    fontSize: 18,
                  )),
                const SizedBox(height: 4),
                Text(todayStr, 
                  style: GoogleFonts.poppins(
                    fontSize: 13, 
                    color: Colors.black54,
                  )),
              ],
            ),
          ),
          _streakBadge(count: 4),
        ],
      ),
    );
  }

  // Day selector with current day highlighted
  Widget _daySelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, i) {
          final sel = i == _selectedDay;
          final isToday = i == DateTime.now().weekday % 7;
          
          return Padding(
            padding: EdgeInsets.only(right: i == days.length - 1 ? 0 : 12),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _selectedDay = i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 50,
                decoration: BoxDecoration(
                  color: sel ? darkGreen : (isToday ? lightGreen : Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(25),
                  border: isToday && !sel ? Border.all(color: darkGreen, width: 2) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      days[i],
                      style: GoogleFonts.poppins(
                        color: sel ? Colors.white : (isToday ? darkGreen : Colors.black54),
                        fontWeight: sel ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${DateTime.now().add(Duration(days: i - DateTime.now().weekday % 7)).day}',
                      style: GoogleFonts.poppins(
                        color: sel ? Colors.white : (isToday ? darkGreen : Colors.black45),
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Progress snapshot widget
  Widget _snapshotCard() {
    final pctCals = _pct(calories, caloriesGoal);
    final pctSteps = _pct(steps, stepsGoal);
    final pctWater = _pct(water, waterGoal);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Today\'s Overview', 
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700, 
                  fontSize: 16,
                )),
              const Spacer(),
              Text('${_getCompletionPercentage()}% Complete',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: darkGreen,
                  fontWeight: FontWeight.w600,
                )),
            ],
          ),
          const SizedBox(height: 12),
          _miniProgressRow('Calories', '$calories / $caloriesGoal kcal', pctCals, Colors.deepOrange),
          const SizedBox(height: 10),
          _miniProgressRow('Steps', '$steps / $stepsGoal', pctSteps, Colors.teal),
          const SizedBox(height: 10),
          _miniProgressRow('Water', '$water / $waterGoal glasses', pctWater, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _miniProgressRow(String label, String value, double pct, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label, 
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
            Text(value, 
              style: GoogleFonts.poppins(
                fontSize: 12, 
                color: Colors.black54,
              )),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            minHeight: 6,
            value: pct,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // Responsive metrics grid
  Widget _metricsGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth >= 700;
      final crossAxisCount = isWide ? 3 : 2;
      final aspectRatio = isWide ? 1.1 : 0.9;
      
      return GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _ringMetric(
            icon: Icons.local_fire_department,
            title: 'Calories',
            value: calories,
            goal: caloriesGoal,
            unit: 'kcal',
            color: Colors.deepOrange,
            onAdd: () => _updateMetric('calories', 50),
            onMinus: () => _updateMetric('calories', -50),
          ),
          _ringMetric(
            icon: Icons.directions_walk,
            title: 'Steps',
            value: steps,
            goal: stepsGoal,
            unit: 'steps',
            color: Colors.teal,
            onAdd: () => _updateMetric('steps', 500),
            onMinus: () => _updateMetric('steps', -500),
          ),
          _ringMetric(
            icon: Icons.opacity,
            title: 'Water',
            value: water,
            goal: waterGoal,
            unit: 'glasses',
            color: Colors.blueAccent,
            onAdd: () => _updateMetric('water', 1),
            onMinus: () => _updateMetric('water', -1),
          ),
        ],
      );
    });
  }

  // Ring metric widget with circular progress
  Widget _ringMetric({
    required IconData icon,
    required String title,
    required int value,
    required int goal,
    required String unit,
    required Color color,
    required VoidCallback onAdd,
    required VoidCallback onMinus,
  }) {
    final pct = _pct(value, goal);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header with controls
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, 
                    fontSize: 14,
                  )),
              ),
              _controlButton(Icons.remove, onMinus),
              const SizedBox(width: 4),
              _controlButton(Icons.add, onAdd),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Circular progress
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      value: pct,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Text('$value',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800, 
                          fontSize: 20, 
                          color: color,
                        )),
                    ),
                    Text(unit, 
                      style: GoogleFonts.poppins(
                        fontSize: 10, 
                        color: Colors.black54,
                      )),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          Text('$value / $goal $unit',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11, 
              color: Colors.black54,
            )),
        ],
      ),
    );
  }

  // Macros card
  Widget _macrosCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant, color: darkGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Macronutrients',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, 
                    fontSize: 16,
                  )),
              ),
              InkWell(
                onTap: () => _showAddFoodDialog(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: darkGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('Add Food',
                    style: GoogleFonts.poppins(
                      color: darkGreen, 
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _macroRow('Protein', protein, proteinGoal, Colors.green),
          const SizedBox(height: 12),
          _macroRow('Carbs', carbs, carbsGoal, Colors.orange),
          const SizedBox(height: 12),
          _macroRow('Fat', fat, fatGoal, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _macroRow(String label, int v, int g, Color color) {
    final pct = _pct(v, g);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label, 
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
            Text('$v / $g g', 
              style: GoogleFonts.poppins(
                fontSize: 12, 
                color: Colors.black54,
              )),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: pct,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // Additional metrics row (sleep, workout)
  Widget _additionalMetricsRow() {
    return Row(
      children: [
        Expanded(
          child: _additionalMetricCard(
            icon: Icons.bedtime,
            label: 'Sleep',
            value: '$sleep hrs',
            progress: _pct(sleep, sleepGoal),
            color: Colors.indigo,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _additionalMetricCard(
            icon: Icons.fitness_center,
            label: 'Workout',
            value: '$workoutMinutes min',
            progress: _pct(workoutMinutes, workoutGoal),
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _additionalMetricCard({
    required IconData icon,
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                    Text(label,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                      )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  // Habits and goals section
  Widget _habitsAndGoalsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _habitsCard()),
        const SizedBox(width: 12),
        Expanded(child: _remindersCard()),
      ],
    );
  }

  Widget _habitsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.task_alt, color: darkGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Daily Habits', 
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, 
                    fontSize: 16,
                  )),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...habits.map((habit) => _habitTile(habit)),
        ],
      ),
    );
  }

  Widget _habitTile(_Habit habit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => habit.done = !habit.done);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: habit.done ? darkGreen : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: habit.done ? darkGreen : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: habit.done 
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
            ),
          ),
          const SizedBox(width: 12),
          Icon(habit.icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              habit.label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                decoration: habit.done ? TextDecoration.lineThrough : null,
                color: habit.done ? Colors.grey.shade500 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remindersCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: darkGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Reminders', 
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, 
                    fontSize: 16,
                  )),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _reminderTile(Icons.local_drink, 'Drink water', 'Every 2 hours'),
          _reminderTile(Icons.restaurant, 'Lunch time', '12:30 PM'),
          _reminderTile(Icons.directions_walk, 'Evening walk', '6:00 PM'),
          _reminderTile(Icons.bedtime, 'Wind down', '10:00 PM'),
        ],
      ),
    );
  }

  Widget _reminderTile(IconData icon, String title, String when) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: lightGreen,
            child: Icon(icon, size: 14, color: darkGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, 
                  style: GoogleFonts.poppins(
                    fontSize: 13, 
                    fontWeight: FontWeight.w600,
                  )),
                Text(when, 
                  style: GoogleFonts.poppins(
                    fontSize: 11, 
                    color: Colors.black54,
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Quick add section
  Widget _quickAddSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Add', 
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, 
              fontSize: 16,
            )),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _quickAddButton('Water', Icons.local_drink, () => _updateMetric('water', 1)),
              _quickAddButton('100 Steps', Icons.directions_walk, () => _updateMetric('steps', 100)),
              _quickAddButton('Snack', Icons.cookie, () => _updateMetric('calories', 150)),
              _quickAddButton('Exercise', Icons.fitness_center, _showWorkoutDialog),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAddButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: darkGreen.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: darkGreen),
            const SizedBox(width: 6),
            Text(label, 
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              )),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _controlButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.grey.shade200,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(icon, size: 16, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _streakBadge({required int count}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.deepOrange.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text('$count-day streak', 
            style: GoogleFonts.poppins(
              color: Colors.white, 
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
        ],
      ),
    );
  }

  // Helper methods
  String _formatDate(DateTime date) {
    final weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    return '${weekdays[date.weekday % 7]}, ${months[date.month - 1]} ${date.day}';
  }

  int _getCompletionPercentage() {
    final totalMetrics = 6; // calories, steps, water, protein, carbs, fat
    int completed = 0;
    
    if (_pct(calories, caloriesGoal) >= 0.8) completed++;
    if (_pct(steps, stepsGoal) >= 0.8) completed++;
    if (_pct(water, waterGoal) >= 0.8) completed++;
    if (_pct(protein, proteinGoal) >= 0.8) completed++;
    if (_pct(carbs, carbsGoal) >= 0.8) completed++;
    if (_pct(fat, fatGoal) >= 0.8) completed++;
    
    return ((completed / totalMetrics) * 100).round();
  }

  void _updateMetric(String metric, int delta) {
    setState(() {
      switch (metric) {
        case 'calories':
          calories = (calories + delta).clamp(0, 9999);
          break;
        case 'steps':
          steps = (steps + delta).clamp(0, 50000);
          break;
        case 'water':
          water = (water + delta).clamp(0, 20);
          break;
        case 'protein':
          protein = (protein + delta).clamp(0, 300);
          break;
        case 'carbs':
          carbs = (carbs + delta).clamp(0, 500);
          break;
        case 'fat':
          fat = (fat + delta).clamp(0, 200);
          break;
      }
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${metric.capitalize()} updated'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        // Refresh logic here - reload from storage/API
      });
    }
  }

  void _showWeeklyProgress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            Text('Weekly Progress', 
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView.builder(
                itemCount: weeklyData.length,
                itemBuilder: (context, index) {
                  final data = weeklyData[index];
                  final isToday = index == 4;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isToday ? darkGreen.withOpacity(0.1) : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: isToday ? Border.all(color: darkGreen, width: 2) : null,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(data.day,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: isToday ? darkGreen : Colors.black87,
                            )),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.calories} kcal',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                              Text('${data.steps} steps â€¢ ${data.water} glasses',
                                style: GoogleFonts.poppins(
                                  fontSize: 12, 
                                  color: Colors.black54,
                                )),
                            ],
                          ),
                        ),
                        if (data.calories > 0)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tracker Settings', 
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
            const SizedBox(height: 20),
            
            ListTile(
              leading: Icon(Icons.edit_notifications, color: darkGreen),
              title: Text('Notification Schedule', 
                style: GoogleFonts.poppins()),
              subtitle: Text('Manage reminder times',
                style: GoogleFonts.poppins(fontSize: 12)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pop(context),
            ),
            
            ListTile(
              leading: Icon(Icons.flag, color: darkGreen),
              title: Text('Daily Goals', 
                style: GoogleFonts.poppins()),
              subtitle: Text('Adjust target values',
                style: GoogleFonts.poppins(fontSize: 12)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pop(context),
            ),
            
            ListTile(
              leading: Icon(Icons.import_export, color: darkGreen),
              title: Text('Export Data', 
                style: GoogleFonts.poppins()),
              subtitle: Text('Download your progress',
                style: GoogleFonts.poppins(fontSize: 12)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quick Log', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('What would you like to log?',
              style: GoogleFonts.poppins()),
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _dialogButton('Meal', Icons.restaurant, () {
                  Navigator.pop(context);
                  _showAddFoodDialog();
                }),
                _dialogButton('Water', Icons.local_drink, () {
                  Navigator.pop(context);
                  _updateMetric('water', 1);
                }),
                _dialogButton('Exercise', Icons.fitness_center, () {
                  Navigator.pop(context);
                  _showWorkoutDialog();
                }),
                _dialogButton('Weight', Icons.monitor_weight, () {
                  Navigator.pop(context);
                  _showWeightDialog();
                }),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', 
              style: GoogleFonts.poppins(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _dialogButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: darkGreen, size: 28),
            const SizedBox(height: 4),
            Text(label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              )),
          ],
        ),
      ),
    );
  }

  void _showAddFoodDialog() {
    final TextEditingController caloriesController = TextEditingController();
    final TextEditingController proteinController = TextEditingController();
    final TextEditingController carbsController = TextEditingController();
    final TextEditingController fatController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Food', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Calories',
                  hintText: 'Enter calories',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: proteinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Protein (g)',
                  hintText: 'Enter protein',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: carbsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Carbs (g)',
                  hintText: 'Enter carbs',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: fatController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Fat (g)',
                  hintText: 'Enter fat',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final cal = int.tryParse(caloriesController.text) ?? 0;
              final prot = int.tryParse(proteinController.text) ?? 0;
              final carb = int.tryParse(carbsController.text) ?? 0;
              final fatValue = int.tryParse(fatController.text) ?? 0;

              setState(() {
                calories += cal;
                protein += prot;
                carbs += carb;
                fat += fatValue;
              });

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Food logged successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              foregroundColor: Colors.white,
            ),
            child: Text('Add', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showWorkoutDialog() {
    final TextEditingController minutesController = TextEditingController();
    String selectedType = 'Cardio';
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Log Workout', 
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: InputDecoration(
                  labelText: 'Workout Type',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                items: ['Cardio', 'Strength', 'Yoga', 'Walking', 'Running']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type, style: GoogleFonts.poppins()),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() => selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: minutesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Duration (minutes)',
                  hintText: 'Enter minutes',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final minutes = int.tryParse(minutesController.text) ?? 0;
                if (minutes > 0) {
                  setState(() {
                    workoutMinutes += minutes;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$selectedType workout logged: ${minutes}min'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
              ),
              child: Text('Log', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showWeightDialog() {
    final TextEditingController weightController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Log Weight', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                hintText: 'Enter your weight',
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 12),
            Text(
              'Your weight will be saved and used for progress tracking.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final weight = double.tryParse(weightController.text);
              if (weight != null && weight > 0) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Weight logged: ${weight.toStringAsFixed(1)}kg'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              foregroundColor: Colors.white,
            ),
            child: Text('Log', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// Helper classes
class _Habit {
  final String label;
  final IconData icon;
  bool done;
  
  _Habit(this.label, this.done, this.icon);
}

class _WeeklyData {
  final String day;
  final int calories;
  final int steps;
  final int water;
  
  _WeeklyData(this.day, this.calories, this.steps, this.water);
}

// Extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}