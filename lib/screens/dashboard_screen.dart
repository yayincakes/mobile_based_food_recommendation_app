import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'recipe_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTab = 0; // 0=weekly, 1=daily
  int selectedDay = 1; // 0=Sun..6=Sat
  final Color darkGreen = const Color(0xFF006400);
  final List<String> days = const ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];

  // Demo progress (wire to real data later)
  int calories = 1250, caloriesGoal = 1800;
  int protein = 60, proteinGoal = 80;
  int carbs   = 150, carbsGoal   = 200;
  int fat     = 40, fatGoal      = 60;

  String get _dailyTip {
    final calLeft = (caloriesGoal - calories);
    final proLeft = (proteinGoal - protein);
    final carbLeft = (carbsGoal - carbs);
    final fatLeft = (fatGoal - fat);

    if (calLeft < -150) return 'You’re ${calLeft.abs()} kcal over. Choose a lighter meal and add a short walk.';
    if (fatLeft < -10)  return 'Fat is a bit high today. Go lean protein and veggies next.';
    if (carbLeft < -25) return 'Carbs trending high. Prefer leafy greens and proteins tonight.';

    if (proLeft > 20)   return 'You’re ${proLeft}g short on protein. Add chicken, tofu, or eggs next.';
    if (calLeft > 250)  return 'About ${calLeft} kcal left—try a balanced snack (yogurt + fruit).';
    if (carbLeft > 40)  return 'You still have ${carbLeft}g carbs—whole grains or fruit could help.';
    if (fatLeft > 15)   return 'Room for ${fatLeft}g fat—add a little olive oil or nuts.';

    if (calLeft.abs() <= 100 && proLeft <= 10 && carbLeft <= 20 && fatLeft <= 10) {
      return 'Great pace! A light, balanced dinner will nail today’s goals.';
    }
    return 'Keep it steady—aim for balanced portions in your next meal.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BottomNav is owned by MainDashboard.
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          children: [
            const SizedBox(height: 16),
            Center(child: Text('FitMeal', style: GoogleFonts.pacifico(fontSize: 32, color: darkGreen))),
            const SizedBox(height: 12),

            // Search pill → Ingredient Search
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/ingredient_search'),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Icon(Icons.search, color: darkGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Search recipes by ingredients',
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.black54)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Elegant daily progress (calories + macros)
            _dailyProgressCard(),

            const SizedBox(height: 12),

            // Smart reminder
            _reminderCard(_dailyTip),

            const SizedBox(height: 16),

            // Plan selector
            Container(
              height: 46,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.grey.shade200),
              child: Row(children: [
                _planTabButton('Weekly Plan', 0),
                _planTabButton('Daily Plan', 1),
              ]),
            ),
            const SizedBox(height: 12),

            // Days of week scroll
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  final selected = i == selectedDay;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDay = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? darkGreen : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(days[i],
                        style: GoogleFonts.poppins(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Plan summary (now Wrap → no overflow)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Weight Loss Meal Plan",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _planStat('Protein', '450g', Colors.orange),
                      _planStat('Calories', '1800', Colors.deepOrange),
                      _planStat('Fat', '60g', Colors.redAccent),
                      _planStat('Carbs', '200g', Colors.amber),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Text('Details', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(height: 8),
            Text('Breakfast', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),

            // Tappable meal → Recipe details
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecipeDetailScreen(
                      name: 'Egg, Wheat Bread, Orange Juice',
                      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
                      calories: 320, protein: 16, fat: 10, carbs: 42,
                      ingredients: ['Egg', 'Wheat Bread', 'Orange Juice'],
                      steps: ['Boil the egg.', 'Toast the bread.', 'Pour orange juice into glass.'],
                      tags: ['Breakfast', 'Vegetarian'],
                      allergens: ['Egg', 'Gluten'],
                      comments: [
                        {'user':'Anna','comment':'Quick and easy!'},
                        {'user':'Ben','comment':'Perfect for busy mornings.'}
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: 56,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text('Egg, Wheat Bread, Orange Juice',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.black54)),
              ),
            ),

            Text('Ingredients', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            SizedBox(
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _ingredientIcon('🥖', 'Bread'),
                  _ingredientIcon('🍅', 'Tomato'),
                  _ingredientIcon('🥬', 'Lettuce'),
                  _ingredientIcon('➕', 'View All'),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  // === Progress Card ===
  Widget _dailyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          _progressRow(
            label: 'Calories',
            value: calories,
            goal: caloriesGoal,
            color: Colors.orange,
            icon: Icons.local_fire_department,
            unit: 'kcal',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _macroTile('Protein', protein, proteinGoal, Colors.green)),
              const SizedBox(width: 10),
              Expanded(child: _macroTile('Carbs', carbs, carbsGoal, Colors.blue)),
              const SizedBox(width: 10),
              Expanded(child: _macroTile('Fat', fat, fatGoal, Colors.red)),
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
          width: 56, height: 56,
          decoration: BoxDecoration(color: color.withOpacity(0.10), shape: BoxShape.circle),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$value / $goal ${unit.isNotEmpty ? unit : ''}',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ]),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bubble_chart, color: color, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(label,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('$value/$goal g',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct.toDouble(),
              minHeight: 8,
              color: color,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  // === Reminder ===
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
          Icon(warn ? Icons.warning_amber : Icons.lightbulb, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // === Existing helpers ===
  Widget _planStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 13, color: color, fontWeight: FontWeight.w700)),
          Text(value, style: GoogleFonts.poppins(fontSize: 16, color: color, fontWeight: FontWeight.w600)),
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
                ? [const BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0,1))]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 1, overflow: TextOverflow.ellipsis,
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

  Widget _ingredientIcon(String emoji, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 64,
      decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(14)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 6),
        Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
