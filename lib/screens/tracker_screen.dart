import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/user_data_service.dart';
import '../services/nutrition_tracking_service.dart';
import '../services/goal_calculation_service.dart';
import '../services/nutrition_integration_service.dart';

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

  // Real user data
  UserProfileData? _userProfile;
  DailyNutritionLog? _todayLog;
  Map<String, int> _goals = {};
  Map<String, int> _currentValues = {};
  bool _isLoading = true;

  // Animation controller for progress animations
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Habits (simple toggles)
  final List<_Habit> habits = [
    _Habit('Morning walk (30 min)', false, Icons.directions_walk),
    _Habit('Drink 8 glasses of water', false, Icons.local_drink),
    _Habit('Take vitamins', false, Icons.medication),
    _Habit('Stretch for 10 minutes', false, Icons.self_improvement),
  ];

  // Weekly progress data - will be loaded dynamically
  List<_WeeklyData> weeklyData = [];
  
  // Streak count - will be calculated dynamically
  int _streakCount = 0;

  double _pct(int v, int g) => (v / g).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _loadUserData();
    _loadWeeklyData();
    _calculateStreak();
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

  // Load user data and goals
  Future<void> _loadUserData() async {
    try {
      setState(() => _isLoading = true);
      
      // Load user profile
      _userProfile = await UserDataService.getUserProfile();
      
      // Calculate personalized goals
      if (_userProfile != null) {
        _goals = GoalCalculationService.getAllGoals(_userProfile);
      } else {
        // Default goals if no profile
        _goals = {
          'calories': 1800,
          'protein': 80,
          'carbs': 200,
          'fat': 60,
          'water': 8,
        };
      }
      
      // Auto-sync with diet history if needed
      await NutritionIntegrationService.autoSyncIfNeeded();
      
      // Load today's combined nutrition log (includes diet history)
      _todayLog = await NutritionIntegrationService.getCombinedTodayLog();
      
      // Set current values
      _updateCurrentValues();
      
      setState(() => _isLoading = false);
    } catch (e) {
      print('Error loading user data: $e');
      setState(() => _isLoading = false);
    }
  }

  // Update current values from today's log
  void _updateCurrentValues() {
    if (_todayLog != null) {
      _currentValues = {
        'calories': _todayLog!.calories,
        'protein': _todayLog!.protein,
        'carbs': _todayLog!.carbs,
        'fat': _todayLog!.fat,
        'water': _todayLog!.water,
      };
    } else {
      _currentValues = {
        'calories': 0,
        'protein': 0,
        'carbs': 0,
        'fat': 0,
        'water': 0,
      };
    }
  }

  // Load real weekly nutrition data
  Future<void> _loadWeeklyData() async {
    try {
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      
      // Get logs for the past 7 days
      final logs = await NutritionTrackingService.getLogsForDateRange(
        weekStart, 
        weekStart.add(const Duration(days: 6))
      );
      
      // Create a map of date to log for easy lookup
      final Map<String, DailyNutritionLog> logMap = {};
      for (final log in logs) {
        final dateKey = '${log.date.year}-${log.date.month.toString().padLeft(2, '0')}-${log.date.day.toString().padLeft(2, '0')}';
        logMap[dateKey] = log;
      }
      
      // Generate weekly data for the past 7 days
      weeklyData.clear();
      final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      
      for (int i = 0; i < 7; i++) {
        final date = weekStart.add(Duration(days: i));
        final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        
        final log = logMap[dateKey];
        final calories = log?.calories ?? 0;
        final water = log?.water ?? 0;
        final steps = log?.steps ?? 0;
        
        weeklyData.add(_WeeklyData(dayNames[i], calories, steps, water));
      }
      
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error loading weekly data: $e');
      // Fallback to empty data
      weeklyData = List.generate(7, (index) => _WeeklyData(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index], 0, 0, 0));
    }
  }

  // Calculate streak count based on consecutive days with nutrition logging
  Future<void> _calculateStreak() async {
    try {
      final now = DateTime.now();
      int streak = 0;
      
      // Check consecutive days backwards from today
      for (int i = 0; i < 30; i++) { // Check up to 30 days back
        final checkDate = now.subtract(Duration(days: i));
        
        // Get log for this date
        final log = await NutritionTrackingService.getLogsForDateRange(checkDate, checkDate);
        
        if (log.isNotEmpty && log.first.calories > 0) {
          // Day has nutrition data, continue streak
          streak++;
        } else {
          // No data for this day, streak ends
          break;
        }
      }
      
      _streakCount = streak;
      
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error calculating streak: $e');
      _streakCount = 0;
    }
  }

  // Get current value for a metric
  int _getCurrentValue(String metric) {
    return _currentValues[metric] ?? 0;
  }

  // Get goal for a metric
  int _getGoal(String metric) {
    return _goals[metric] ?? 1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
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
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Refresh',
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

                  // Habits and goals section
                  _habitsAndGoalsSection(),

                  const SizedBox(height: 16),

                  // Goal reminders section
                  _goalRemindersSection(),
                ],
              ),
            ),
          ),
        ),
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
          _streakBadge(count: _streakCount),
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
    final pctCals = _pct(_getCurrentValue('calories'), _getGoal('calories'));
    final pctWater = _pct(_getCurrentValue('water'), _getGoal('water'));

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
          _miniProgressRow('Calories', '${_getCurrentValue('calories')} / ${_getGoal('calories')} kcal', pctCals, Colors.deepOrange),
          const SizedBox(height: 10),
          _miniProgressRow('Water', '${_getCurrentValue('water')} / ${_getGoal('water')} glasses', pctWater, Colors.blueAccent),
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
      final crossAxisCount = isWide ? 2 : 2;
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
            value: _getCurrentValue('calories'),
            goal: _getGoal('calories'),
            unit: 'kcal',
            color: Colors.deepOrange,
            onAdd: () => _updateMetric('calories', 50),
            onMinus: () => _updateMetric('calories', -50),
          ),
          _ringMetric(
            icon: Icons.opacity,
            title: 'Water',
            value: _getCurrentValue('water'),
            goal: _getGoal('water'),
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
          _macroRow('Protein', _getCurrentValue('protein'), _getGoal('protein'), Colors.green),
          const SizedBox(height: 12),
          _macroRow('Carbs', _getCurrentValue('carbs'), _getGoal('carbs'), Colors.orange),
          const SizedBox(height: 12),
          _macroRow('Fat', _getCurrentValue('fat'), _getGoal('fat'), Colors.redAccent),
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

  // Habits and goals section
  Widget _habitsAndGoalsSection() {
    return _habitsCard();
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

  // Goal reminders section
  Widget _goalRemindersSection() {
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
              Icon(Icons.flag, color: darkGreen),
              const SizedBox(width: 8),
              Text('Today\'s Goal Reminders', 
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700, 
                  fontSize: 16,
                )),
            ],
          ),
          const SizedBox(height: 16),
          _goalReminderTile(
            icon: Icons.local_fire_department,
            title: 'Calorie Target',
            goal: '${_getGoal('calories')} kcal',
            current: _getCurrentValue('calories'),
            goalValue: _getGoal('calories'),
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 12),
          _goalReminderTile(
            icon: Icons.opacity,
            title: 'Water Intake',
            goal: '${_getGoal('water')} glasses',
            current: _getCurrentValue('water'),
            goalValue: _getGoal('water'),
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 12),
          _goalReminderTile(
            icon: Icons.restaurant,
            title: 'Protein Goal',
            goal: '${_getGoal('protein')} g',
            current: _getCurrentValue('protein'),
            goalValue: _getGoal('protein'),
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _goalReminderTile(
            icon: Icons.grain,
            title: 'Carbs Goal',
            goal: '${_getGoal('carbs')} g',
            current: _getCurrentValue('carbs'),
            goalValue: _getGoal('carbs'),
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _goalReminderTile(
            icon: Icons.water_drop,
            title: 'Fat Goal',
            goal: '${_getGoal('fat')} g',
            current: _getCurrentValue('fat'),
            goalValue: _getGoal('fat'),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _goalReminderTile({
    required IconData icon,
    required String title,
    required String goal,
    required int current,
    required int goalValue,
    required Color color,
  }) {
    final remaining = (goalValue - current).clamp(0, goalValue);
    final isComplete = current >= goalValue;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isComplete ? color.withOpacity(0.1) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isComplete ? color : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
                const SizedBox(height: 2),
                Text(
                  isComplete 
                    ? 'Goal achieved! 🎉' 
                    : 'Remaining: $remaining',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isComplete ? color : Colors.black54,
                    fontWeight: isComplete ? FontWeight.w600 : FontWeight.normal,
                  )),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(goal,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                )),
              Text('$current / $goalValue',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.black54,
                )),
            ],
          ),
          const SizedBox(width: 8),
          if (isComplete)
            Icon(Icons.check_circle, color: color, size: 24),
        ],
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
    final totalMetrics = 5; // calories, water, protein, carbs, fat
    int completed = 0;
    
    if (_pct(_getCurrentValue('calories'), _getGoal('calories')) >= 0.8) completed++;
    if (_pct(_getCurrentValue('water'), _getGoal('water')) >= 0.8) completed++;
    if (_pct(_getCurrentValue('protein'), _getGoal('protein')) >= 0.8) completed++;
    if (_pct(_getCurrentValue('carbs'), _getGoal('carbs')) >= 0.8) completed++;
    if (_pct(_getCurrentValue('fat'), _getGoal('fat')) >= 0.8) completed++;
    
    return ((completed / totalMetrics) * 100).round();
  }

  void _updateMetric(String metric, int delta) async {
    final currentValue = _getCurrentValue(metric);
    final newValue = (currentValue + delta).clamp(0, 9999);
    
    // Update local state immediately for responsive UI
    setState(() {
      _currentValues[metric] = newValue;
    });
    
    // Save to nutrition tracking service
    try {
      Map<String, int> updateValues = {};
      updateValues[metric] = newValue;
      
      await NutritionTrackingService.updateNutritionValues(
        calories: metric == 'calories' ? newValue : null,
        protein: metric == 'protein' ? newValue : null,
        carbs: metric == 'carbs' ? newValue : null,
        fat: metric == 'fat' ? newValue : null,
        water: metric == 'water' ? newValue : null,
      );
      
      // Sync with diet history and reload data
      await NutritionIntegrationService.syncTodayWithDietHistory();
      _todayLog = await NutritionIntegrationService.getCombinedTodayLog();
      _updateCurrentValues();
      
      // Also refresh weekly data to show updated values
      await _loadWeeklyData();
      
      // Recalculate streak
      await _calculateStreak();
      
      // Show feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${metric.capitalize()} updated'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      print('Error updating metric: $e');
      // Revert local state on error
      setState(() {
        _currentValues[metric] = currentValue;
      });
    }
  }

  Future<void> _refreshData() async {
    // Sync with diet history first
    await NutritionIntegrationService.syncTodayWithDietHistory();
    
    // Reload user data, weekly data, and streak
    await _loadUserData();
    await _loadWeeklyData();
    await _calculateStreak();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data refreshed'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
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
              child: weeklyData.isEmpty 
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: weeklyData.length,
                    itemBuilder: (context, index) {
                      final data = weeklyData[index];
                      final now = DateTime.now();
                      final todayWeekday = now.weekday; // 1 = Monday, 7 = Sunday
                      final isToday = index == (todayWeekday - 1); // Convert to 0-based index
                      
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
                                  Text('${data.water} glasses water',
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
            onPressed: () async {
              final cal = int.tryParse(caloriesController.text) ?? 0;
              final prot = int.tryParse(proteinController.text) ?? 0;
              final carb = int.tryParse(carbsController.text) ?? 0;
              final fatValue = int.tryParse(fatController.text) ?? 0;

              // Create nutrition entry
              final entry = NutritionEntry(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: 'Custom Food',
                mealType: 'snack',
                calories: cal,
                protein: prot,
                carbs: carb,
                fat: fatValue,
                timestamp: DateTime.now(),
                description: 'Manually added food',
              );
              
              // Add to nutrition tracking
              await NutritionTrackingService.addNutritionEntry(entry);
              
              // Sync with diet history to ensure consistency
              await NutritionIntegrationService.syncTodayWithDietHistory();
              
              // Reload data to update UI
              await _loadUserData();
              await _loadWeeklyData();
              await _calculateStreak();

              Navigator.pop(context);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Food logged successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
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