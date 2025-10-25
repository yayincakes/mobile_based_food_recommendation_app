import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

class AdminRecipesScreen extends StatefulWidget {
  const AdminRecipesScreen({super.key});

  @override
  State<AdminRecipesScreen> createState() => _AdminRecipesScreenState();
}

class _AdminRecipesScreenState extends State<AdminRecipesScreen> {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  
  List<dynamic> _recipes = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _categoryFilter = 'all';
  String _difficultyFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecipes() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await ApiService.get('/admin/recipes');
      if (response['success'] == true) {
        setState(() {
          _recipes = response['data']['data'] ?? [];
          _isLoading = false;
        });
      } else {
        _loadFallbackRecipes();
      }
    } catch (e) {
      _loadFallbackRecipes();
    }
  }

  void _loadFallbackRecipes() {
    setState(() {
      _recipes = [
        {
          'id': 1,
          'name': 'Adobo',
          'description': 'Classic Filipino adobo with chicken and pork',
          'category': 'Filipino',
          'difficulty': 'Easy',
          'prep_time': 15,
          'cook_time': 30,
          'servings': 4,
          'calories_per_serving': 350,
          'is_filipino_dish': true,
          'created_at': '2024-01-15T10:30:00Z',
        },
        {
          'id': 2,
          'name': 'Sinigang',
          'description': 'Sour soup with pork and vegetables',
          'category': 'Filipino',
          'difficulty': 'Medium',
          'prep_time': 20,
          'cook_time': 45,
          'servings': 6,
          'calories_per_serving': 280,
          'is_filipino_dish': true,
          'created_at': '2024-01-20T14:15:00Z',
        },
        {
          'id': 3,
          'name': 'Kare-Kare',
          'description': 'Oxtail stew with peanut sauce',
          'category': 'Filipino',
          'difficulty': 'Hard',
          'prep_time': 30,
          'cook_time': 120,
          'servings': 8,
          'calories_per_serving': 450,
          'is_filipino_dish': true,
          'created_at': '2024-01-25T09:45:00Z',
        },
        {
          'id': 4,
          'name': 'Grilled Chicken',
          'description': 'Simple grilled chicken breast',
          'category': 'International',
          'difficulty': 'Easy',
          'prep_time': 10,
          'cook_time': 20,
          'servings': 2,
          'calories_per_serving': 200,
          'is_filipino_dish': false,
          'created_at': '2024-02-01T16:20:00Z',
        },
        {
          'id': 5,
          'name': 'Pancit',
          'description': 'Filipino noodle dish',
          'category': 'Filipino',
          'difficulty': 'Medium',
          'prep_time': 25,
          'cook_time': 15,
          'servings': 6,
          'calories_per_serving': 320,
          'is_filipino_dish': true,
          'created_at': '2024-02-05T11:30:00Z',
        },
      ];
      _isLoading = false;
    });
  }

  Future<void> _deleteRecipe(int recipeId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Recipe', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete this recipe? This action cannot be undone.',
          style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final response = await ApiService.delete('/admin/recipes/$recipeId');
        if (response['success'] == true) {
          _loadRecipes(); // Refresh the list
          _showSuccess('Recipe deleted successfully');
        } else {
          _showError('Failed to delete recipe');
        }
      } catch (e) {
        _showError('Failed to delete recipe');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  List<dynamic> get _filteredRecipes {
    return _recipes.where((recipe) {
      final matchesSearch = _searchQuery.isEmpty || 
          recipe['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _categoryFilter == 'all' || recipe['category'] == _categoryFilter;
      final matchesDifficulty = _difficultyFilter == 'all' || recipe['difficulty'] == _difficultyFilter;
      
      return matchesSearch && matchesCategory && matchesDifficulty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Recipe Management',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: _loadRecipes,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: () => _showError('Add recipe feature coming soon'),
            icon: const Icon(Icons.add),
            tooltip: 'Add Recipe',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Filters and Search
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Search Bar
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() => _searchQuery = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search recipes...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: lightGreen.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: darkGreen, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Filter Chips
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _categoryFilter,
                              decoration: InputDecoration(
                                labelText: 'Category',
                                filled: true,
                                fillColor: lightGreen.withOpacity(0.3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Categories')),
                                DropdownMenuItem(value: 'breakfast', child: Text('Breakfast')),
                                DropdownMenuItem(value: 'lunch', child: Text('Lunch')),
                                DropdownMenuItem(value: 'dinner', child: Text('Dinner')),
                                DropdownMenuItem(value: 'snack', child: Text('Snack')),
                                DropdownMenuItem(value: 'dessert', child: Text('Dessert')),
                              ],
                              onChanged: (value) {
                                setState(() => _categoryFilter = value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _difficultyFilter,
                              decoration: InputDecoration(
                                labelText: 'Difficulty',
                                filled: true,
                                fillColor: lightGreen.withOpacity(0.3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Difficulties')),
                                DropdownMenuItem(value: 'easy', child: Text('Easy')),
                                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                                DropdownMenuItem(value: 'hard', child: Text('Hard')),
                              ],
                              onChanged: (value) {
                                setState(() => _difficultyFilter = value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Recipes List
                Expanded(
                  child: _filteredRecipes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant_outlined, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                'No recipes found',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = _filteredRecipes[index];
                            return _buildRecipeCard(recipe);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    final isFilipino = recipe['is_filipino_dish'] == true;
    final difficulty = recipe['difficulty'];
    final category = recipe['category'];
    final createdAt = DateTime.parse(recipe['created_at']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            children: [
              // Recipe Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: darkGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.restaurant,
                  color: darkGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Recipe Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            recipe['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        if (isFilipino) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'FILIPINO',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe['description'] ?? 'No description available',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildInfoChip('Category', category.toUpperCase()),
                        const SizedBox(width: 8),
                        _buildInfoChip('Difficulty', difficulty.toUpperCase()),
                        const SizedBox(width: 8),
                        _buildInfoChip('Servings', '${recipe['servings']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Nutrition Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: lightGreen.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutritionItem('Calories', '${recipe['calories_per_serving']} kcal'),
                _buildNutritionItem('Protein', '${recipe['protein_per_serving']}g'),
                _buildNutritionItem('Carbs', '${recipe['carbs_per_serving']}g'),
                _buildNutritionItem('Fat', '${recipe['fat_per_serving']}g'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Time and Actions
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                'Prep: ${recipe['prep_time']}min | Cook: ${recipe['cook_time']}min',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              Text(
                'Created ${_formatDate(createdAt)}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showError('Edit recipe feature coming soon'),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: darkGreen,
                    side: BorderSide(color: darkGreen),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _deleteRecipe(recipe['id']),
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('Delete'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: darkGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $value',
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: darkGreen,
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return '${(difference.inDays / 30).floor()} months ago';
    }
  }
}
