import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/diet_history.dart';
import '../services/diet_history_service.dart';

class DietHistoryOverview extends StatefulWidget {
  const DietHistoryOverview({super.key});

  @override
  State<DietHistoryOverview> createState() => _DietHistoryOverviewState();
}

class _DietHistoryOverviewState extends State<DietHistoryOverview> {
  EatingHabitAnalysis? _analysis;
  List<NutritionTrend> _trends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAnalysis();
  }

  Future<void> _loadAnalysis() async {
    setState(() => _isLoading = true);
    
    final analysis = await DietHistoryService.analyzeEatingHabits(30);
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 7));
    final trends = await DietHistoryService.getNutritionTrends(startDate, endDate);
    
    setState(() {
      _analysis = analysis;
      _trends = trends;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_analysis == null) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildQuickStats(),
        const SizedBox(height: 16),
        _buildTrendChart(),
        const SizedBox(height: 16),
        _buildInsights(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.timeline, color: const Color(0xFF0B6A0B), size: 24),
        const SizedBox(width: 8),
        Text(
          'Diet History Overview',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B6A0B),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getTrendColor(_analysis!.overallTrend).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _analysis!.overallTrend.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _getTrendColor(_analysis!.overallTrend),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Daily Calories',
            '${_analysis!.averageDailyCalories.toStringAsFixed(0)}',
            Icons.local_fire_department,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Meals/Day',
            '${_analysis!.averageMealFrequency.toStringAsFixed(1)}',
            Icons.restaurant,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Top Meal',
            _analysis!.mostEatenMeal,
            Icons.favorite,
            Colors.pink,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            radius: 16,
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    if (_trends.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Calorie Trend',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: _buildSimpleLineChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleLineChart() {
    if (_trends.isEmpty) return const Center(child: Text('No data available'));

    final maxCalories = _trends.map((t) => t.calories).reduce((a, b) => a > b ? a : b);
    final minCalories = _trends.map((t) => t.calories).reduce((a, b) => a < b ? a : b);

    return CustomPaint(
      size: const Size(double.infinity, 120),
      painter: SimpleLineChartPainter(
        trends: _trends,
        maxValue: maxCalories,
        minValue: minCalories,
      ),
    );
  }

  Widget _buildInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Insights & Recommendations',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ..._analysis!.insights.map((insight) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 16,
                  color: Colors.amber[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    insight,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.timeline_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Diet History Yet',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start logging your meals to see your eating habits and nutritional trends',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to meal logging screen
              Navigator.pushNamed(context, '/log_meal');
            },
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Log Your First Meal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B6A0B),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case 'improving':
        return Colors.green;
      case 'declining':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}

class SimpleLineChartPainter extends CustomPainter {
  final List<NutritionTrend> trends;
  final double maxValue;
  final double minValue;

  SimpleLineChartPainter({
    required this.trends,
    required this.maxValue,
    required this.minValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (trends.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFF0B6A0B)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFF0B6A0B).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final stepX = size.width / (trends.length - 1);
    final range = maxValue - minValue;
    final normalizedRange = range > 0 ? range : 1;

    for (int i = 0; i < trends.length; i++) {
      final x = i * stepX;
      final normalizedValue = (trends[i].calories - minValue) / normalizedRange;
      final y = size.height - (normalizedValue * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      // Draw data points
      final pointPaint = Paint()
        ..color = const Color(0xFF0B6A0B)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 3, pointPaint);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DailyNutritionCard extends StatelessWidget {
  final DailyNutritionSummary summary;

  const DailyNutritionCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Text(
                '${summary.date.day}/${summary.date.month}/${summary.date.year}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B6A0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${summary.mealCount} meals',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B6A0B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMacroBar('Calories', summary.totalCalories, 2000, Colors.orange),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMacroBar('Protein', summary.totalProtein, 50, Colors.red),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMacroBar('Carbs', summary.totalCarbs, 250, Colors.blue),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMacroBar('Fat', summary.totalFat, 65, Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBar(String label, double value, double target, Color color) {
    final percentage = (value / target * 100).clamp(0, 100);
    
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toStringAsFixed(0),
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: GoogleFonts.poppins(
                  fontSize: 8,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DietAdherenceCard extends StatelessWidget {
  final DietAdherenceScore score;

  const DietAdherenceCard({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Text(
                'Diet Adherence',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getAdherenceColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${score.adherencePercentage.toStringAsFixed(0)}%',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _getAdherenceColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            score.feedback,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          if (score.improvements.isNotEmpty) ...[
            Text(
              'Improvements:',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            ...score.improvements.map((improvement) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_right,
                    size: 12,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      improvement,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Color _getAdherenceColor() {
    if (score.adherencePercentage >= 80) return Colors.green;
    if (score.adherencePercentage >= 60) return Colors.orange;
    return Colors.red;
  }
}
