import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/health_dictionary_service.dart';

class HealthDictionaryScreen extends StatefulWidget {
  const HealthDictionaryScreen({super.key});

  @override
  State<HealthDictionaryScreen> createState() => _HealthDictionaryScreenState();
}

class _HealthDictionaryScreenState extends State<HealthDictionaryScreen>
    with SingleTickerProviderStateMixin {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      if (_searchQuery.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = HealthDictionaryService.searchAll(_searchQuery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Health Dictionary',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
          tabs: [
            Tab(text: 'Health Conditions'),
            Tab(text: 'Allergies'),
            Tab(text: 'Nutrition Terms'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search health terms...',
                prefixIcon: Icon(Icons.search, color: darkGreen),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: darkGreen, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: _searchQuery.isNotEmpty
                ? _buildSearchResults()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildHealthConditions(),
                      _buildAllergies(),
                      _buildNutritionTerms(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try different keywords',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        if (item is HealthConditionInfo) {
          return _buildHealthConditionCard(item);
        } else if (item is AllergyInfo) {
          return _buildAllergyCard(item);
        } else if (item is NutritionTermInfo) {
          return _buildNutritionTermCard(item);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildHealthConditions() {
    final conditions = HealthDictionaryService.getAllHealthConditions();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: conditions.length,
      itemBuilder: (context, index) {
        return _buildHealthConditionCard(conditions[index]);
      },
    );
  }

  Widget _buildAllergies() {
    final allergies = HealthDictionaryService.getAllAllergies();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: allergies.length,
      itemBuilder: (context, index) {
        return _buildAllergyCard(allergies[index]);
      },
    );
  }

  Widget _buildNutritionTerms() {
    final terms = HealthDictionaryService.getAllNutritionTerms();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: terms.length,
      itemBuilder: (context, index) {
        return _buildNutritionTermCard(terms[index]);
      },
    );
  }

  Widget _buildHealthConditionCard(HealthConditionInfo condition) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Text(condition.icon, style: const TextStyle(fontSize: 32)),
        title: Text(
          condition.name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          condition.description,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection('Dietary Impact', condition.dietaryImpact),
                const SizedBox(height: 16),
                _buildListSection('Foods to Avoid', condition.foodsToAvoid, Colors.red.shade50),
                const SizedBox(height: 16),
                _buildListSection('Recommended Foods', condition.recommendedFoods, lightGreen),
                const SizedBox(height: 16),
                _buildInfoSection('Severity', condition.severityExplanation),
                const SizedBox(height: 16),
                _buildInfoSection('Management Tips', condition.managementTips),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergyCard(AllergyInfo allergy) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Text(allergy.icon, style: const TextStyle(fontSize: 32)),
        title: Text(
          allergy.name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          allergy.description,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection('Severity Level', allergy.severityLevel),
                const SizedBox(height: 16),
                _buildListSection('Hidden Sources', allergy.hiddenSources, Colors.orange.shade50),
                const SizedBox(height: 16),
                _buildListSection('Safe Alternatives', allergy.safeAlternatives, lightGreen),
                const SizedBox(height: 16),
                _buildInfoSection('Cross-Reactivity', allergy.crossReactivityInfo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTermCard(NutritionTermInfo term) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Text(term.icon, style: const TextStyle(fontSize: 32)),
        title: Text(
          term.term,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          term.definition,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection('Importance', term.importance),
                const SizedBox(height: 16),
                _buildInfoSection('Daily Recommendation', term.dailyRecommendation),
                const SizedBox(height: 16),
                _buildListSection('Food Sources', term.foodSources, lightGreen),
                const SizedBox(height: 16),
                _buildInfoSection('Health Impact', term.healthImpact),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items, Color backgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: GoogleFonts.poppins(
                      color: darkGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
