import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/diet_history.dart';
import '../services/diet_history_service.dart';
import '../widgets/diet_history_widgets.dart';

class DietHistoryManagementScreen extends StatefulWidget {
  const DietHistoryManagementScreen({super.key});

  @override
  State<DietHistoryManagementScreen> createState() => _DietHistoryManagementScreenState();
}

class _DietHistoryManagementScreenState extends State<DietHistoryManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Data
  List<DietHistoryEntry> _allEntries = [];
  List<DailyNutritionSummary> _weeklySummaries = [];
  EatingHabitAnalysis? _analysis;
  List<DietAdherenceScore> _adherenceScores = [];
  
  // Loading states
  bool _isLoadingEntries = false;
  bool _isLoadingAnalysis = false;
  bool _isLoadingAdherence = false;

  // Filter options
  DateTime _selectedDate = DateTime.now();
  String _selectedMealType = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadAllData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAllData() async {
    await Future.wait([
      _loadEntries(),
      _loadWeeklySummaries(),
      _loadAnalysis(),
      _loadAdherenceScores(),
    ]);
  }

  Future<void> _loadEntries() async {
    setState(() => _isLoadingEntries = true);
    
    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 30));
      final entries = await DietHistoryService.getDietHistoryForRange(startDate, endDate);
      
      setState(() {
        _allEntries = entries;
        _isLoadingEntries = false;
      });
    } catch (e) {
      print('Error loading entries: $e');
      setState(() => _isLoadingEntries = false);
    }
  }

  Future<void> _loadWeeklySummaries() async {
    try {
      final summaries = <DailyNutritionSummary>[];
      final endDate = DateTime.now();
      
      for (int i = 0; i < 7; i++) {
        final date = endDate.subtract(Duration(days: i));
        final summary = await DietHistoryService.getDailyNutritionSummary(date);
        if (summary != null) {
          summaries.add(summary);
        }
      }
      
      setState(() {
        _weeklySummaries = summaries;
      });
    } catch (e) {
      print('Error loading summaries: $e');
    }
  }

  Future<void> _loadAnalysis() async {
    setState(() => _isLoadingAnalysis = true);
    
    try {
      final analysis = await DietHistoryService.analyzeEatingHabits(30);
      
      setState(() {
        _analysis = analysis;
        _isLoadingAnalysis = false;
      });
    } catch (e) {
      print('Error loading analysis: $e');
      setState(() => _isLoadingAnalysis = false);
    }
  }

  Future<void> _loadAdherenceScores() async {
    setState(() => _isLoadingAdherence = true);
    
    try {
      final scores = <DietAdherenceScore>[];
      final endDate = DateTime.now();
      
      for (int i = 0; i < 7; i++) {
        final date = endDate.subtract(Duration(days: i));
        final score = await DietHistoryService.calculateAdherenceScore(date);
        scores.add(score);
      }
      
      setState(() {
        _adherenceScores = scores;
        _isLoadingAdherence = false;
      });
    } catch (e) {
      print('Error loading adherence scores: $e');
      setState(() => _isLoadingAdherence = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6A0B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
        title: Text(
          'Diet History & Analytics',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.timeline), text: 'Overview'),
            Tab(icon: Icon(Icons.restaurant), text: 'Meals'),
            Tab(icon: Icon(Icons.analytics), text: 'Analysis'),
            Tab(icon: Icon(Icons.trending_up), text: 'Adherence'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/log_meal'),
            tooltip: 'Log Meal',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAllData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildMealsTab(),
          _buildAnalysisTab(),
          _buildAdherenceTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    if (_isLoadingAnalysis) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const DietHistoryOverview(),
          const SizedBox(height: 16),
          
          // Weekly Nutrition Summaries
          if (_weeklySummaries.isNotEmpty) ...[
            Container(
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
                    'Weekly Nutrition Summary',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._weeklySummaries.map((summary) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DailyNutritionCard(summary: summary),
                  )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMealsTab() {
    if (_isLoadingEntries) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredEntries = _getFilteredEntries();

    return Column(
      children: [
        // Filter controls
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[50],
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedMealType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type, style: GoogleFonts.poppins(fontSize: 12)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedMealType = value!);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Entries list
        Expanded(
          child: filteredEntries.isEmpty
              ? _buildEmptyMealsState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredEntries.length,
                  itemBuilder: (context, index) {
                    final entry = filteredEntries[index];
                    return _buildMealEntryCard(entry);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildAnalysisTab() {
    if (_isLoadingAnalysis) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_analysis == null) {
      return _buildEmptyAnalysisState();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eating Habits Analysis
          Container(
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
                  'Eating Habits Analysis',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Top Foods
                _buildAnalysisSection(
                  'Most Eaten Foods',
                  _analysis!.topFoods,
                  Icons.fastfood,
                  Colors.orange,
                ),
                
                const SizedBox(height: 16),
                
                // Macro Distribution
                _buildMacroDistribution(),
                
                const SizedBox(height: 16),
                
                // Insights
                _buildInsightsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdherenceTab() {
    if (_isLoadingAdherence) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Weekly Adherence Overview
          Container(
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
                  'Weekly Adherence Overview',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Average adherence
                Row(
                  children: [
                    Expanded(
                      child: _buildAdherenceMetric(
                        'Average Adherence',
                        '${(_adherenceScores.map((s) => s.adherencePercentage).reduce((a, b) => a + b) / _adherenceScores.length).toStringAsFixed(0)}%',
                        Icons.trending_up,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAdherenceMetric(
                        'Best Day',
                        '${_adherenceScores.map((s) => s.adherencePercentage).reduce((a, b) => a > b ? a : b).toStringAsFixed(0)}%',
                        Icons.star,
                        Colors.amber,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Daily adherence scores
                ..._adherenceScores.map((score) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DietAdherenceCard(score: score),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealEntryCard(DietHistoryEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B6A0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  entry.mealType.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B6A0B),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${entry.loggedAt.hour.toString().padLeft(2, '0')}:${entry.loggedAt.minute.toString().padLeft(2, '0')}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Icons.edit, size: 16),
                        const SizedBox(width: 8),
                        Text('Edit', style: GoogleFonts.poppins()),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete, size: 16, color: Colors.red),
                        const SizedBox(width: 8),
                        Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) => _handleEntryAction(entry, value.toString()),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.foodName,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${entry.quantity.toStringAsFixed(1)} ${entry.unit}',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildNutritionBadge('${entry.calories.toStringAsFixed(0)} cal', Colors.orange),
              const SizedBox(width: 8),
              _buildNutritionBadge('${entry.protein.toStringAsFixed(1)}g protein', Colors.red),
              const SizedBox(width: 8),
              _buildNutritionBadge('${entry.carbs.toStringAsFixed(1)}g carbs', Colors.blue),
              const SizedBox(width: 8),
              _buildNutritionBadge('${entry.fat.toStringAsFixed(1)}g fat', Colors.green),
            ],
          ),
          if (entry.notes != null && entry.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Notes: ${entry.notes}',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNutritionBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEmptyMealsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No meals found',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start logging your meals to track your nutrition',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/log_meal'),
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

  Widget _buildEmptyAnalysisState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Analysis Data',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Log more meals to see detailed analysis of your eating habits',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(String title, List<String> items, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (items.isEmpty)
          Text(
            'No data available',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: items.map((item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: color,
                ),
              ),
            )).toList(),
          ),
      ],
    );
  }

  Widget _buildMacroDistribution() {
    if (_analysis == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.pie_chart, color: Colors.blue, size: 16),
            const SizedBox(width: 8),
            Text(
              'Macro Distribution',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildMacroBar('Protein', _analysis!.macroDistribution['Protein'] ?? 0, Colors.red),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMacroBar('Carbs', _analysis!.macroDistribution['Carbs'] ?? 0, Colors.blue),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMacroBar('Fat', _analysis!.macroDistribution['Fat'] ?? 0, Colors.green),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroBar(String label, double percentage, Color color) {
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
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsSection() {
    if (_analysis == null || _analysis!.insights.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.amber, size: 16),
            const SizedBox(width: 8),
            Text(
              'Insights & Recommendations',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ..._analysis!.insights.map((insight) => Padding(
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
                  insight,
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
    );
  }

  Widget _buildAdherenceMetric(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
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

  List<DietHistoryEntry> _getFilteredEntries() {
    var filtered = _allEntries.where((entry) {
      final entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      final selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      
      return entryDate.isAtSameMomentAs(selectedDate) &&
             (_selectedMealType == 'All' || entry.mealType.toLowerCase() == _selectedMealType.toLowerCase());
    }).toList();

    // Sort by time (most recent first)
    filtered.sort((a, b) => b.loggedAt.compareTo(a.loggedAt));
    
    return filtered;
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _handleEntryAction(DietHistoryEntry entry, String action) async {
    switch (action) {
      case 'edit':
        // TODO: Implement edit functionality
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Edit functionality coming soon')),
        );
        break;
      case 'delete':
        final confirmed = await _showDeleteConfirmation();
        if (confirmed == true) {
          final success = await DietHistoryService.deleteDietEntry(entry.id);
          if (success) {
            await _loadEntries();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Entry deleted successfully')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to delete entry')),
            );
          }
        }
        break;
    }
  }

  Future<bool?> _showDeleteConfirmation() async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Entry', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text('Are you sure you want to delete this meal entry?',
            style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
