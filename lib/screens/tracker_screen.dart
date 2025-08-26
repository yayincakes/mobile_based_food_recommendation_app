// lib/screens/tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});
  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
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

  // Habits (simple toggles)
  final List<_Habit> habits = [
    _Habit('Walk 30 min', false),
    _Habit('Stretch 10 min', true),
    _Habit('Breathing 5 min', false),
  ];

  double _pct(int v, int g) => (v / g).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text('Daily Tracker', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Today + streak
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10, offset: const Offset(0, 2))],
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: lightGreen,
                      child: Icon(Icons.bolt, color: darkGreen),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today's Summary", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
                          Text(todayStr, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ),
                    _streakBadge(count: 4),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Day selector
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(days.length, (i) {
                    final sel = i == _selectedDay;
                    return Padding(
                      padding: EdgeInsets.only(right: i == days.length - 1 ? 0 : 8),
                      child: ChoiceChip(
                        selected: sel,
                        label: Text(days[i]),
                        selectedColor: darkGreen,
                        labelStyle: GoogleFonts.poppins(
                          color: sel ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) => setState(() => _selectedDay = i),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 12),

              // Progress snapshot card
              _snapshotCard(),

              const SizedBox(height: 12),

              // Key metrics (responsive)
              LayoutBuilder(builder: (context, c) {
                // 2 columns on phones, 3 on wider screens
                final isWide = c.maxWidth >= 700;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _ringMetric(
                      width: isWide ? (c.maxWidth - 24) / 3 : (c.maxWidth - 12) / 2,
                      icon: Icons.local_fire_department,
                      title: 'Calories',
                      value: calories,
                      goal: caloriesGoal,
                      unit: 'kcal',
                      color: Colors.deepOrange,
                      onAdd: () => setState(() => calories += 50),
                      onMinus: () => setState(() => calories = (calories - 50).clamp(0, 999999)),
                    ),
                    _ringMetric(
                      width: isWide ? (c.maxWidth - 24) / 3 : (c.maxWidth - 12) / 2,
                      icon: Icons.directions_walk,
                      title: 'Steps',
                      value: steps,
                      goal: stepsGoal,
                      unit: 'steps',
                      color: Colors.teal,
                      onAdd: () => setState(() => steps += 500),
                      onMinus: () => setState(() => steps = (steps - 500).clamp(0, 999999)),
                    ),
                    _ringMetric(
                      width: isWide ? (c.maxWidth - 24) / 3 : c.maxWidth, // full width if 2-col
                      icon: Icons.opacity,
                      title: 'Water',
                      value: water,
                      goal: waterGoal,
                      unit: 'glasses',
                      color: Colors.blueAccent,
                      onAdd: () => setState(() => water += 1),
                      onMinus: () => setState(() => water = (water - 1).clamp(0, 999)),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 12),

              // Macros
              _macrosCard(),

              const SizedBox(height: 12),

              // Habits + Reminders
              LayoutBuilder(builder: (context, c) {
                final isWide = c.maxWidth >= 700;
                final w = isWide ? (c.maxWidth - 12) / 2 : c.maxWidth;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _habitsCard(width: w),
                    _remindersCard(width: w),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- snapshot widget ----------
  Widget _snapshotCard() {
    final pctCals = _pct(calories, caloriesGoal);
    final pctSteps = _pct(steps, stepsGoal);
    final pctWater = _pct(water, waterGoal);
    return _card(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Today’s Progress', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          _miniProgressRow('Calories', '$calories / $caloriesGoal kcal', pctCals, Colors.deepOrange),
          const SizedBox(height: 8),
          _miniProgressRow('Steps', '$steps / $stepsGoal', pctSteps, Colors.teal),
          const SizedBox(height: 8),
          _miniProgressRow('Water', '$water / $waterGoal glasses', pctWater, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _miniProgressRow(String label, String value, double pct, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        ),
        Text(value, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  // ---------- ring metric ----------
  Widget _ringMetric({
    required double width,
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
    return _card(
      width: width,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
              ),
              _roundIconButton(Icons.remove, onMinus),
              const SizedBox(width: 6),
              _roundIconButton(Icons.add, onAdd),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(builder: (context, cons) {
            final side = cons.maxWidth.clamp(140.0, 220.0);
            return SizedBox(
              width: side,
              height: side,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 12,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
                  ),
                  CircularProgressIndicator(
                    value: pct,
                    strokeWidth: 12,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    backgroundColor: Colors.transparent,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        child: Text('$value',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w800, fontSize: 28, color: color)),
                      ),
                      const SizedBox(height: 2),
                      Text(unit, style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Text('$value / $goal $unit',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
        ],
      ),
    );
  }

  // ---------- macros card ----------
  Widget _macrosCard() {
    return _card(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant, color: darkGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Macros',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
              ),
              InkWell(
                onTap: () => _snack('Add Food tapped'),
                child: Text('Add Food',
                    style: GoogleFonts.poppins(
                        color: darkGreen, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _macroRow('Protein', protein, proteinGoal, Colors.green),
          const SizedBox(height: 10),
          _macroRow('Carbs', carbs, carbsGoal, Colors.orange),
          const SizedBox(height: 10),
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
            Expanded(child: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
            Text('$v / $g g', style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 6),
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

  // ---------- habits ----------
  Widget _habitsCard({required double width}) {
    return _card(
      width: width,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.task_alt, color: darkGreen),
              const SizedBox(width: 8),
              Text('Habits', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          ...List.generate(habits.length, (i) {
            final h = habits[i];
            return CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              value: h.done,
              onChanged: (v) => setState(() => h.done = v ?? false),
              title: Text(h.label, style: GoogleFonts.poppins(fontSize: 14)),
              activeColor: darkGreen,
            );
          }),
        ],
      ),
    );
  }

  // ---------- reminders ----------
  Widget _remindersCard({required double width}) {
    return _card(
      width: width,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: darkGreen),
              const SizedBox(width: 8),
              Text('Reminders', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          _reminderTile(Icons.local_drink, 'Drink a glass of water', 'Every 2 hours'),
          _reminderTile(Icons.set_meal, 'Protein with lunch', 'Today, 12:30 PM'),
          _reminderTile(Icons.directions_walk, 'Evening walk', 'Today, 6:00 PM'),
        ],
      ),
    );
  }

  Widget _reminderTile(IconData icon, String title, String when) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: lightGreen,
        child: Icon(icon, size: 18, color: darkGreen),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle: Text(when, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
      trailing: Icon(Icons.chevron_right, color: Colors.black45),
      onTap: () => _snack('Reminder tapped'),
    );
  }

  // ---------- small pieces ----------
  Widget _card({double? width, required EdgeInsets padding, required Widget child}) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: child,
    );
  }

  Widget _roundIconButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.grey.shade200,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _streakBadge({required int count}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: darkGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text('$count‑day streak', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _Habit {
  final String label;
  bool done;
  _Habit(this.label, this.done);
}
