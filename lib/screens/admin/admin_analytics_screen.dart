import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  
  Map<String, dynamic>? _analyticsData;
  bool _isLoading = true;
  String _selectedPeriod = '30';

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await ApiService.get('/admin/analytics?period=$_selectedPeriod');
      if (response['success'] == true) {
        setState(() {
          _analyticsData = response['data'];
          _isLoading = false;
        });
      } else {
        _loadFallbackAnalytics();
      }
    } catch (e) {
      _loadFallbackAnalytics();
    }
  }

  void _loadFallbackAnalytics() {
    setState(() {
      _analyticsData = {
        'usersByRole': [
          {'role': 'user', 'count': 20},
          {'role': 'admin', 'count': 1},
        ],
        'recipesByCategory': [
          {'category': 'Filipino', 'count': 45},
          {'category': 'International', 'count': 30},
          {'category': 'Healthy', 'count': 25},
        ],
        'totalUsers': 25,
        'totalRecipes': 100,
        'userGrowth': [
          {'month': 'Jan', 'users': 15},
          {'month': 'Feb', 'users': 20},
          {'month': 'Mar', 'users': 25},
        ],
        'recipeStats': {
          'avg_calories': 320.5,
          'avg_prep_time': 25.0,
          'most_popular_category': 'Filipino',
        },
      };
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Analytics & Reports',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        actions: [
          // Period Selector
          DropdownButton<String>(
            value: _selectedPeriod,
            dropdownColor: Colors.white,
            style: GoogleFonts.poppins(color: Colors.white),
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: '7', child: Text('Last 7 days')),
              DropdownMenuItem(value: '30', child: Text('Last 30 days')),
              DropdownMenuItem(value: '90', child: Text('Last 90 days')),
            ],
            onChanged: (value) {
              setState(() => _selectedPeriod = value!);
              _loadAnalytics();
            },
          ),
          IconButton(
            onPressed: _loadAnalytics,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Cards
                  _buildOverviewCards(),
                  
                  const SizedBox(height: 24),
                  
                  // Charts Section
                  _buildChartsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Popular Content
                  _buildPopularContent(),
                  
                  const SizedBox(height: 24),
                  
                  // Category Distribution
                  _buildCategoryDistribution(),
                ],
              ),
            ),
    );
  }

  Widget _buildOverviewCards() {
    if (_analyticsData == null) return const SizedBox();

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.2 : 1.1,
      children: [
        _buildOverviewCard(
          'User Registrations',
          _analyticsData!['user_registrations']?.length.toString() ?? '0',
          Icons.people,
          Colors.blue,
          'New users this period',
        ),
        _buildOverviewCard(
          'Recipe Views',
          _analyticsData!['recipe_views']?.length.toString() ?? '0',
          Icons.visibility,
          Colors.green,
          'Total recipe views',
        ),
        _buildOverviewCard(
          'Popular Recipes',
          _analyticsData!['popular_recipes']?.length.toString() ?? '0',
          Icons.trending_up,
          Colors.orange,
          'Top performing recipes',
        ),
        _buildOverviewCard(
          'Categories',
          _analyticsData!['category_distribution']?.length.toString() ?? '0',
          Icons.category,
          Colors.purple,
          'Active recipe categories',
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Icon(Icons.analytics, color: Colors.grey.shade400, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            'User Registration Trends',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 20),
          
          // Placeholder for chart
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: lightGreen.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: darkGreen.withOpacity(0.2)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    'Chart visualization would be here',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'Integration with chart library needed',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularContent() {
    if (_analyticsData == null || _analyticsData!['popular_recipes'] == null) {
      return const SizedBox();
    }

    final popularRecipes = _analyticsData!['popular_recipes'] as List<dynamic>;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            'Popular Recipes',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 20),
          
          ...popularRecipes.take(5).map((recipe) => _buildPopularRecipeItem(recipe)).toList(),
        ],
      ),
    );
  }

  Widget _buildPopularRecipeItem(Map<String, dynamic> recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreen.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: darkGreen.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: darkGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.restaurant, color: darkGreen, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['name'] ?? 'Unknown Recipe',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${recipe['category']?.toUpperCase() ?? 'UNKNOWN'} • ${recipe['calories_per_serving'] ?? '0'} kcal',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.trending_up, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryDistribution() {
    if (_analyticsData == null || _analyticsData!['category_distribution'] == null) {
      return const SizedBox();
    }

    final categories = _analyticsData!['category_distribution'] as List<dynamic>;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            'Recipe Categories Distribution',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 20),
          
          ...categories.map((category) => _buildCategoryItem(category)).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    final categoryName = category['category'] ?? 'Unknown';
    final count = category['count'] ?? 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: darkGreen,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              categoryName.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Text(
            '$count recipes',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }
}
