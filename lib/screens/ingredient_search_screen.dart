import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'recipe_detail_screen.dart';

class IngredientSearchScreen extends StatefulWidget {
  const IngredientSearchScreen({super.key});

  @override
  State<IngredientSearchScreen> createState() => _IngredientSearchScreenState();
}

class _IngredientSearchScreenState extends State<IngredientSearchScreen>
    with SingleTickerProviderStateMixin {
  int _tab = 0; // 0=Recipes, 1=Popular
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Color darkGreen = const Color(0xFF006400);
  
  bool _isSearching = false;
  List<String> _searchHistory = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Demo recipes with enhanced details
  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Grilled Chicken Salad',
      'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      'calories': 350, 'protein': 30, 'fat': 10, 'carbs': 18,
      'ingredients': ['Chicken breast', 'Mixed lettuce', 'Cherry tomatoes', 'Cucumber', 'Olive oil'],
      'steps': [
        'Season chicken breast with salt, pepper, and herbs',
        'Grill chicken for 6-7 minutes per side until cooked through',
        'Let chicken rest for 5 minutes, then slice',
        'Wash and chop all vegetables',
        'Combine vegetables in a bowl',
        'Add sliced chicken on top',
        'Drizzle with olive oil and serve'
      ],
      'tags': ['Low Carb', 'High Protein', 'Healthy', 'Quick'],
      'allergens': [],
      'comments': [
        {'user': 'Jane', 'comment': 'Delicious and easy! Perfect for lunch.'},
        {'user': 'Mike', 'comment': 'Great protein content, keeps me full.'}
      ],
      'cookTime': '20 minutes',
      'difficulty': 'Easy',
      'rating': 4.8,
    },
    {
      'name': 'Veggie Omelette',
      'imageUrl': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      'calories': 180, 'protein': 12, 'fat': 9, 'carbs': 8,
      'ingredients': ['Eggs', 'Bell pepper', 'Onion', 'Spinach', 'Cheese'],
      'steps': [
        'Heat oil in a non-stick pan over medium heat',
        'Sauté onions and bell peppers until soft',
        'Add spinach and cook until wilted',
        'Beat eggs with salt and pepper',
        'Pour eggs into the pan over vegetables',
        'Add cheese on one half of the omelette',
        'Fold omelette in half and serve hot'
      ],
      'tags': ['Breakfast', 'Quick', 'Vegetarian', 'High Protein'],
      'allergens': ['Egg', 'Dairy'],
      'comments': [
        {'user': 'Sam', 'comment': 'Protein-packed breakfast! Love it.'},
        {'user': 'Lisa', 'comment': 'Quick and satisfying meal.'}
      ],
      'cookTime': '15 minutes',
      'difficulty': 'Easy',
      'rating': 4.6,
    },
    {
      'name': 'Tomato Basil Soup',
      'imageUrl': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0',
      'calories': 210, 'protein': 5, 'fat': 6, 'carbs': 30,
      'ingredients': ['Fresh tomatoes', 'Onion', 'Garlic', 'Fresh basil', 'Olive oil', 'Vegetable broth'],
      'steps': [
        'Heat olive oil in a large pot',
        'Sauté onions and garlic until fragrant',
        'Add chopped tomatoes and cook for 10 minutes',
        'Add vegetable broth and bring to boil',
        'Simmer for 20 minutes',
        'Add fresh basil and blend until smooth',
        'Season with salt and pepper to taste'
      ],
      'tags': ['Vegan', 'Soup', 'Comfort Food', 'Low Fat'],
      'allergens': [],
      'comments': [
        {'user': 'Carlo', 'comment': 'Perfect for rainy days!'},
        {'user': 'Nina', 'comment': 'So comforting and healthy.'}
      ],
      'cookTime': '35 minutes',
      'difficulty': 'Easy',
      'rating': 4.7,
    },
    {
      'name': 'Quinoa Power Bowl',
      'imageUrl': 'https://images.unsplash.com/photo-1546793665-c74683f339c1',
      'calories': 420, 'protein': 18, 'fat': 15, 'carbs': 45,
      'ingredients': ['Quinoa', 'Black beans', 'Avocado', 'Corn', 'Red pepper', 'Lime'],
      'steps': [
        'Cook quinoa according to package instructions',
        'Drain and rinse black beans',
        'Dice avocado and red pepper',
        'Combine all ingredients in a bowl',
        'Squeeze lime juice over the bowl',
        'Season with salt and pepper',
        'Toss gently and serve'
      ],
      'tags': ['Vegan', 'High Fiber', 'Superfood', 'Bowl'],
      'allergens': [],
      'comments': [
        {'user': 'Alex', 'comment': 'So filling and nutritious!'},
        {'user': 'Maya', 'comment': 'My go-to healthy meal.'}
      ],
      'cookTime': '25 minutes',
      'difficulty': 'Easy',
      'rating': 4.9,
    },
    {
      'name': 'Greek Yogurt Parfait',
      'imageUrl': 'https://images.unsplash.com/photo-1488477181946-6428a0291777',
      'calories': 280, 'protein': 20, 'fat': 8, 'carbs': 35,
      'ingredients': ['Greek yogurt', 'Mixed berries', 'Granola', 'Honey', 'Almonds'],
      'steps': [
        'Layer Greek yogurt in a glass or bowl',
        'Add a layer of mixed berries',
        'Sprinkle granola over berries',
        'Repeat layers as desired',
        'Top with sliced almonds',
        'Drizzle with honey',
        'Serve immediately'
      ],
      'tags': ['Breakfast', 'Healthy', 'Quick', 'High Protein'],
      'allergens': ['Dairy', 'Nuts'],
      'comments': [
        {'user': 'Emma', 'comment': 'Perfect breakfast, so creamy!'},
        {'user': 'David', 'comment': 'Love the crunch from the granola.'}
      ],
      'cookTime': '5 minutes',
      'difficulty': 'Very Easy',
      'rating': 4.5,
    },
  ];

  List<Map<String, dynamic>> get filtered {
    final input = _controller.text.trim().toLowerCase();
    if (input.isEmpty) return recipes;
    
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
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadSearchHistory() {
    // TODO: Load from SharedPreferences
    setState(() {
      _searchHistory = ['chicken, tomato', 'egg', 'quinoa, beans', 'yogurt, berries'];
    });
  }

  void _addToSearchHistory(String query) {
    if (query.trim().isEmpty) return;
    
    setState(() {
      _searchHistory.remove(query);
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 10) {
        _searchHistory = _searchHistory.take(10).toList();
      }
    });
    // TODO: Save to SharedPreferences
  }

  void _performSearch() {
    if (_controller.text.trim().isNotEmpty) {
      _addToSearchHistory(_controller.text.trim());
      setState(() {
        _isSearching = true;
      });
      
      // Simulate search delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isSearching = false;
          });
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
        title: Text('Ingredient Search',
            style: GoogleFonts.poppins(
              color: darkGreen, 
              fontWeight: FontWeight.bold, 
              fontSize: 20,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: _showFilterDialog,
            tooltip: 'Filter recipes',
          ),
        ],
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
              
              // Search instruction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Enter your ingredients',
                    style: GoogleFonts.poppins(
                      fontSize: 20, 
                      fontWeight: FontWeight.w600,
                    )),
              ),
              const SizedBox(height: 8),
              
              // Search tip
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Separate multiple ingredients with commas',
                    style: GoogleFonts.poppins(
                      fontSize: 12, 
                      color: Colors.grey.shade600,
                    )),
              ),
              const SizedBox(height: 12),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      hintText: 'e.g. chicken, tomato, basil',
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
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s,]')),
                      LengthLimitingTextInputFormatter(100),
                    ],
                  ),
                ),
              ),

              // Search history
              if (_controller.text.isEmpty && _searchHistory.isNotEmpty) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text('Recent searches',
                          style: GoogleFonts.poppins(
                            fontSize: 14, 
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          )),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _searchHistory.clear();
                          });
                        },
                        child: Text(
                          'Clear',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _searchHistory.length,
                    itemBuilder: (context, index) {
                      final query = _searchHistory[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < _searchHistory.length - 1 ? 8 : 0),
                        child: Chip(
                          label: Text(query, 
                            style: GoogleFonts.poppins(fontSize: 12)),
                          onDeleted: () {
                            setState(() {
                              _searchHistory.removeAt(index);
                            });
                          },
                          backgroundColor: Colors.grey.shade200,
                        ),
                      );
                    },
                  ),
                ),
              ],

              const SizedBox(height: 14),
              
              // Tab buttons
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _tabBtn('Recipes', 0),
                    const SizedBox(width: 32),
                    _tabBtn('Popular', 1),
                    const Spacer(),
                    // Results count
                    if (_controller.text.isNotEmpty)
                      Text(
                        '${filtered.length} result${filtered.length == 1 ? '' : 's'}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Results
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildResults(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    final list = _tab == 0 ? filtered : recipes.reversed.toList();
    
    if (list.isEmpty && _controller.text.isNotEmpty) {
      return _buildEmptyResults();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) => _buildRecipeCard(list[i]),
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
          Text('Try different ingredients or check spelling',
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
              'Show All Recipes',
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
              // Recipe image
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
              
              // Recipe details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and rating
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
                    
                    // Ingredients preview
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
                    
                    // Nutrition and time info
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _infoChip(Icons.local_fire_department, 
                          '${recipe['calories']}', Colors.orange),
                        _infoChip(Icons.fitness_center, 
                          '${recipe['protein']}g', Colors.green),
                        _infoChip(Icons.access_time, 
                          recipe['cookTime'], Colors.blue),
                        _infoChip(Icons.trending_up, 
                          recipe['difficulty'], darkGreen),
                      ],
                    ),
                    
                    // Tags
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

  Widget _tabBtn(String label, int idx) {
    return GestureDetector(
      onTap: () => setState(() => _tab = idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: _tab == idx ? darkGreen : Colors.black54,
                  fontSize: 16,
                )),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: _tab == idx ? 40 : 0,
              color: darkGreen,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRecipe(Map<String, dynamic> recipe) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          name: recipe['name'],
          imageUrl: recipe['imageUrl'],
          calories: recipe['calories'],
          protein: recipe['protein'],
          fat: recipe['fat'],
          carbs: recipe['carbs'],
          ingredients: List<String>.from(recipe['ingredients']),
          steps: List<String>.from(recipe['steps']),
          tags: List<String>.from(recipe['tags']),
          allergens: List<String>.from(recipe['allergens'] ?? []),
          comments: List<Map<String, String>>.from(recipe['comments']),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Recipes',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Dietary Preferences',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['Vegetarian', 'Vegan', 'High Protein', 'Low Carb']
                  .map((filter) => FilterChip(
                        label: Text(filter, style: GoogleFonts.poppins(fontSize: 12)),
                        selected: false,
                        onSelected: (selected) {
                          // TODO: Implement filter logic
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Apply Filters',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}