import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import './recipe_detail_screen.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';

class IngredientSearchScreen extends StatefulWidget {
  const IngredientSearchScreen({super.key});

  @override
  State<IngredientSearchScreen> createState() => _IngredientSearchScreenState();
}

class _IngredientSearchScreenState extends State<IngredientSearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Color darkGreen = const Color(0xFF006400);
  
  bool _isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Get recipes from shared service
  List<Map<String, dynamic>> get recipes => RecipeService().getRecipesAsMaps();

  List<Map<String, dynamic>> get filtered {
    final input = _controller.text.trim().toLowerCase();
    if (input.isEmpty) return recipes.take(10).toList();
    
    final inputList = input.split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    
    return recipes.where((r) {
      final ingredients = (r['ingredients'] as List)
          .map((e) => e.toString().toLowerCase())
          .toList();
      final name = r['name'].toString().toLowerCase();
      final tags = (r['tags'] as List)
          .map((e) => e.toString().toLowerCase())
          .toList();
      
      return inputList.every((needle) => 
        ingredients.any((ingredient) => ingredient.contains(needle)) ||
        name.contains(needle) ||
        tags.any((tag) => tag.contains(needle))
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _performSearch() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() => _isSearching = true);
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _isSearching = false);
        }
      });
    }
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text('Recipe Search',
            style: GoogleFonts.poppins(
              color: darkGreen, 
              fontWeight: FontWeight.bold, 
              fontSize: 20,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text('FitMeal', 
                style: GoogleFonts.pacifico(fontSize: 32, color: darkGreen)),
              const SizedBox(height: 12),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Search Filipino Recipes',
                    style: GoogleFonts.poppins(
                      fontSize: 20, 
                      fontWeight: FontWeight.w600,
                    )),
              ),
              const SizedBox(height: 8),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Enter the ingredients you have',
                    style: GoogleFonts.poppins(
                      fontSize: 12, 
                      color: Colors.grey.shade600,
                    )),
              ),
              const SizedBox(height: 12),

              // Search bar - Responsive
              LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 32 : 16
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _performSearch(),
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'e.g. chicken, soy sauce, garlic',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey),
                          filled: true, 
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: darkGreen, width: 2),
                          ),
                          suffixIcon: _controller.text.isNotEmpty
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _controller.clear();
                                        setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: _isSearching
                                          ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(darkGreen),
                                              ),
                                            )
                                          : Icon(Icons.search, color: darkGreen),
                                      onPressed: _performSearch,
                                    ),
                                  ],
                                )
                              : IconButton(
                                  icon: Icon(Icons.search, color: darkGreen),
                                  onPressed: _performSearch,
                                ),
                        ),
                        style: GoogleFonts.poppins(),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      ),
                    ),
                  );
                }
              ),


              const SizedBox(height: 14),
              

              // Results - Responsive Grid
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      // Large screens - 3 columns
                      return _buildGridResults(3);
                    } else if (constraints.maxWidth > 600) {
                      // Tablets - 2 columns
                      return _buildGridResults(2);
                    } else {
                      // Mobile - List view
                      return _buildResults();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    final list = filtered;
    
    if (list.isEmpty && _controller.text.isNotEmpty) {
      return _buildEmptyResults();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: list.length,
        itemBuilder: (_, i) => _buildRecipeCard(list[i]),
      ),
    );
  }

  Widget _buildGridResults(int crossAxisCount) {
    final list = filtered;
    
    if (list.isEmpty && _controller.text.isNotEmpty) {
      return _buildEmptyResults();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: list.length,
        itemBuilder: (_, i) => _buildRecipeGridCard(list[i]),
      ),
    );
  }

  Widget _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('No recipes found',
              style: GoogleFonts.poppins(
                fontSize: 18, 
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              )),
          const SizedBox(height: 8),
          Text('Try different ingredients',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14, 
                color: Colors.grey.shade500,
              )),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              _controller.clear();
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.refresh),
            label: Text(
              'Show All',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _navigateToRecipe(recipe),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: Image.network(
                    recipe['imageUrl'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.restaurant,
                      color: Colors.grey.shade400,
                      size: 32,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(darkGreen),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
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
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(
                              '${recipe['rating']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    Text(
                      (recipe['ingredients'] as List).take(3).join(', ') +
                          ((recipe['ingredients'] as List).length > 3 ? '...' : ''),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _infoChip(Icons.local_fire_department, 
                          '${recipe['calories']}', Colors.orange),
                        _infoChip(Icons.fitness_center, 
                          '${recipe['protein']}g', Colors.green),
                        _infoChip(Icons.access_time, 
                          recipe['cookTime'].toString(), Colors.blue),
                        _infoChip(Icons.trending_up, 
                          recipe['difficulty'], darkGreen),
                      ],
                    ),
                    
                    if ((recipe['tags'] as List).isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: (recipe['tags'] as List<String>)
                            .take(2)
                            .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: darkGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: darkGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
              
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeGridCard(Map<String, dynamic> recipe) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _navigateToRecipe(recipe),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      recipe['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.restaurant,
                        color: Colors.grey.shade400,
                        size: 48,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${recipe['rating']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        _infoChip(Icons.local_fire_department, 
                          '${recipe['calories']}', Colors.orange),
                        const SizedBox(width: 6),
                        _infoChip(Icons.fitness_center, 
                          '${recipe['protein']}g', Colors.green),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            recipe['cookTime'].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    if ((recipe['tags'] as List).isNotEmpty)
                      Wrap(
                        spacing: 4,
                        children: (recipe['tags'] as List<String>)
                            .take(2)
                            .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: darkGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color: darkGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }


  // Helper method to convert Map to Recipe object
  Recipe _mapToRecipe(Map<String, dynamic> recipeMap) {
    return Recipe(
      id: recipeMap['id'] ?? 0,
      name: recipeMap['name'] ?? '',
      description: recipeMap['description'] ?? '',
      prepTime: recipeMap['prepTime'] ?? 0,
      cookTime: recipeMap['cookTime'] ?? 0,
      servings: recipeMap['servings'] ?? 1,
      difficulty: recipeMap['difficulty'] ?? 'Easy',
      category: recipeMap['category'] ?? '',
      caloriesPerServing: recipeMap['calories'] ?? 0,
      proteinPerServing: recipeMap['protein'] ?? 0,
      carbsPerServing: recipeMap['carbs'] ?? 0,
      fatPerServing: recipeMap['fat'] ?? 0,
      instructions: recipeMap['instructions'] ?? '',
      isFilipinoDish: recipeMap['isFilipinoDish'] ?? false,
      ingredients: List<String>.from(recipeMap['ingredients'] ?? []),
      tags: List<String>.from(recipeMap['tags'] ?? []),
      allergens: List<String>.from(recipeMap['allergens'] ?? []),
      rating: (recipeMap['rating'] ?? 4.0).toDouble(),
      cookTimeFormatted: recipeMap['cookTimeFormatted'] ?? '${(recipeMap['cookTime'] ?? 0).toString()} min',
      prepTimeFormatted: recipeMap['prepTimeFormatted'] ?? '${(recipeMap['prepTime'] ?? 0).toString()} min',
      imageUrl: recipeMap['imageUrl'] ?? '',
    );
  }

  void _navigateToRecipe(Map<String, dynamic> recipeMap) {
    try {
    HapticFeedback.lightImpact();
      final recipe = _mapToRecipe(recipeMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
            recipe: recipe,
            mealType: 'Recipe', // Default meal type for search results
        ),
      ),
    );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening recipe: $e'),
          backgroundColor: Colors.red,
      ),
    );
  }
  }

}