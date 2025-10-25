import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe.dart';
import '../services/diet_history_service.dart';
import '../models/diet_history.dart';
import 'favorites_manager.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final String mealType;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.mealType,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isLogging = false;
  final Color darkGreen = const Color(0xFF006400);
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = FavoritesManager().isFavorite(widget.recipe.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Recipe Details',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
            tooltip: _isFavorited ? 'Remove from favorites' : 'Add to favorites',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareRecipe,
            tooltip: 'Share Recipe',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Header
            _buildRecipeHeader(),
            
            // Recipe Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  if (widget.recipe.description.isNotEmpty) ...[
                    _buildSectionTitle('Description'),
                    const SizedBox(height: 12),
                    _buildDescriptionCard(),
                    const SizedBox(height: 24),
                  ],

                  // Nutrition Information
                  _buildSectionTitle('Nutrition Information'),
                  const SizedBox(height: 12),
                  _buildNutritionCard(),
                  const SizedBox(height: 24),

                  // Ingredients
                  _buildSectionTitle('Ingredients'),
                  const SizedBox(height: 12),
                  _buildIngredientsCard(),
                  const SizedBox(height: 24),

                  // Instructions
                  _buildSectionTitle('Instructions'),
                  const SizedBox(height: 12),
                  _buildInstructionsCard(),
                  const SizedBox(height: 24),

                  // Recipe Info
                  _buildRecipeInfoCard(),
                  const SizedBox(height: 24),

                  // Log Meal Button
                  _buildLogMealButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkGreen, darkGreen.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.mealType.toUpperCase(),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Recipe Name
          Text(
            widget.recipe.name,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          
          // Recipe Tags
          if (widget.recipe.tags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.recipe.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
          
          // Quick Info Row
          Row(
            children: [
              _quickInfoItem(Icons.access_time, '${widget.recipe.prepTime + widget.recipe.cookTime} min'),
              const SizedBox(width: 16),
              _quickInfoItem(Icons.people, '${widget.recipe.servings} servings'),
              const SizedBox(width: 16),
              _quickInfoItem(Icons.star, '${widget.recipe.rating}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkGreen,
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        widget.recipe.description,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildNutritionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Per Serving',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _nutritionItem(
                  'Calories',
                  '${widget.recipe.caloriesPerServing}',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _nutritionItem(
                  'Protein',
                  '${widget.recipe.proteinPerServing}g',
                  Icons.fitness_center,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _nutritionItem(
                  'Carbs',
                  '${widget.recipe.carbsPerServing}g',
                  Icons.rice_bowl,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _nutritionItem(
                  'Fat',
                  '${widget.recipe.fatPerServing}g',
                  Icons.water_drop,
                  Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nutritionItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.shopping_cart, color: darkGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                '${widget.recipe.ingredients.length} Ingredients',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: darkGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.recipe.ingredients.asMap().entries.map((entry) {
            final index = entry.key;
            final ingredient = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: darkGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ingredient,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book, color: darkGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                'Cooking Instructions',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: darkGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.recipe.instructions,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipe Information',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _infoItem('Prep Time', '${widget.recipe.prepTime} min'),
              ),
              Expanded(
                child: _infoItem('Cook Time', '${widget.recipe.cookTime} min'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoItem('Difficulty', widget.recipe.difficulty),
              ),
              Expanded(
                child: _infoItem('Category', widget.recipe.category),
              ),
            ],
          ),
          if (widget.recipe.isFilipinoDish) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.flag, color: Colors.red.shade600, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Traditional Filipino Dish',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLogMealButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLogging ? null : _logMeal,
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLogging
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Log This Meal',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _logMeal() async {
    setState(() {
      _isLogging = true;
    });

    try {
      final entry = DietHistoryEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        mealType: widget.mealType,
        foodName: widget.recipe.name,
        quantity: 1.0,
        unit: 'serving',
        calories: widget.recipe.caloriesPerServing.toDouble(),
        protein: widget.recipe.proteinPerServing.toDouble(),
        carbs: widget.recipe.carbsPerServing.toDouble(),
        fat: widget.recipe.fatPerServing.toDouble(),
        fiber: 0.0, // Not available in recipe model
        sugar: 0.0, // Not available in recipe model
        sodium: 0.0, // Not available in recipe model
        loggedAt: DateTime.now(),
        notes: 'Logged from meal plan',
      );

      final success = await DietHistoryService.saveDietEntry(entry);
      
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${widget.recipe.name} logged successfully! Check your diet history.',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: darkGreen,
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          // Navigate back to dashboard
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to log meal. Please try again.',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error logging meal: $e',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLogging = false;
        });
      }
    }
  }

  void _shareRecipe() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Share functionality coming soon!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: darkGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Map<String, dynamic> _recipeToMap(Recipe recipe) {
    return {
      'id': recipe.id,
      'name': recipe.name,
      'description': recipe.description,
      'prepTime': recipe.prepTime,
      'cookTime': recipe.cookTime,
      'servings': recipe.servings,
      'difficulty': recipe.difficulty,
      'category': recipe.category,
      'calories': recipe.caloriesPerServing,
      'protein': recipe.proteinPerServing,
      'carbs': recipe.carbsPerServing,
      'fat': recipe.fatPerServing,
      'instructions': recipe.instructions,
      'isFilipinoDish': recipe.isFilipinoDish,
      'ingredients': recipe.ingredients,
      'tags': recipe.tags,
      'allergens': recipe.allergens,
      'rating': recipe.rating,
      'cookTimeFormatted': recipe.cookTimeFormatted,
      'prepTimeFormatted': recipe.prepTimeFormatted,
      'imageUrl': recipe.imageUrl,
    };
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });

    if (_isFavorited) {
      FavoritesManager().addFavorite(_recipeToMap(widget.recipe));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added to favorites!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      FavoritesManager().removeFavorite(widget.recipe.name);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Removed from favorites!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}