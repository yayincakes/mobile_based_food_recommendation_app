import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'favorites_manager.dart';
import 'recipe_detail_screen.dart';
import '../models/recipe.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Color darkGreen = const Color(0xFF006400);
  String _searchQuery = '';
  bool _isLoading = false;

  List<Map<String, dynamic>> get _filteredFavorites {
    final favs = FavoritesManager().favorites;
    if (_searchQuery.isEmpty) return favs;
    
    return favs.where((recipe) {
      final name = recipe['name'].toString().toLowerCase();
      final ingredients = (recipe['ingredients'] as List<String>)
          .join(' ').toLowerCase();
      final tags = (recipe['tags'] as List<String>?)
          ?.join(' ').toLowerCase() ?? '';
      
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || 
             ingredients.contains(query) || 
             tags.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFavs = _filteredFavorites;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text('Favorites', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshFavorites,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search your favorites...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search, color: darkGreen),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              ),
              style: GoogleFonts.poppins(),
            ),
          ),

          // Results count
          if (filteredFavs.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    _searchQuery.isEmpty 
                        ? 'All favorites (${filteredFavs.length})'
                        : 'Found ${filteredFavs.length} result${filteredFavs.length == 1 ? '' : 's'}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildContent(filteredFavs),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Map<String, dynamic>> favorites) {
    if (favorites.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _refreshFavorites,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => _buildFavoriteCard(favorites[i]),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isEmpty ? Icons.favorite_border : Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty 
                ? 'No favorites yet'
                : 'No favorites found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Start adding recipes to your favorites\nby tapping the heart icon'
                : 'Try searching with different keywords',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          if (_searchQuery.isEmpty) ...[
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/ingredient_search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.search),
              label: Text(
                'Discover Recipes',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> recipe) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _navigateToRecipe(recipe),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Recipe image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: recipe['imageUrl'] != null
                      ? Image.network(
                          recipe['imageUrl'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(darkGreen),
                              ),
                            );
                          },
                        )
                      : _buildImagePlaceholder(),
                ),
              ),
              const SizedBox(width: 16),
              
              // Recipe details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    
                    // Nutrition info
                    Row(
                      children: [
                        _nutritionChip(
                          icon: Icons.local_fire_department,
                          value: '${recipe['calories']}',
                          unit: 'kcal',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        _nutritionChip(
                          icon: Icons.fitness_center,
                          value: '${recipe['protein']}g',
                          unit: 'protein',
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Tags
                    if (recipe['tags'] != null && (recipe['tags'] as List).isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: (recipe['tags'] as List<String>)
                            .take(2)
                            .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: darkGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
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
                ),
              ),
              
              // Remove button
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _showRemoveDialog(recipe['name']),
                    tooltip: 'Remove from favorites',
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey.shade200,
      child: Icon(
        Icons.restaurant,
        size: 32,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _nutritionChip({
    required IconData icon,
    required String value,
    required String unit,
    required Color color,
  }) {
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
            value,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
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
      cookTimeFormatted: recipeMap['cookTimeFormatted'] ?? '${recipeMap['cookTime'] ?? 0} min',
      prepTimeFormatted: recipeMap['prepTimeFormatted'] ?? '${recipeMap['prepTime'] ?? 0} min',
      imageUrl: recipeMap['imageUrl'] ?? '',
    );
  }

  void _navigateToRecipe(Map<String, dynamic> recipeMap) {
    final recipe = _mapToRecipe(recipeMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          recipe: recipe,
          mealType: 'Favorite', // Default meal type for favorites
        ),
      ),
    ).then((_) => setState(() {})); // Refresh after return
  }

  void _showRemoveDialog(String recipeName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Remove from favorites?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to remove "$recipeName" from your favorites?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeFavorite(recipeName);
            },
            child: Text(
              'Remove',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeFavorite(String recipeName) {
    FavoritesManager().removeFavorite(recipeName);
    setState(() {});
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed from favorites'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
      ),
    );
  }

  Future<void> _refreshFavorites() async {
    setState(() => _isLoading = true);
    
    // Simulate refresh delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}