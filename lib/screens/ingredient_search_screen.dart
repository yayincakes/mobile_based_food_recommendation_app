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
  int _tab = 0;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Color darkGreen = const Color(0xFF006400);
  
  bool _isSearching = false;
  List<String> _searchHistory = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Filipino recipes with authentic ingredients
  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Adobong Manok',
      'imageUrl': 'https://images.unsplash.com/photo-1580554530778-ca36943938b2',
      'calories': 320, 'protein': 35, 'fat': 12, 'carbs': 18,
      'ingredients': ['Manok (Chicken)', 'Toyo (Soy Sauce)', 'Suka (Vinegar)', 'Bawang (Garlic)', 'Dahon ng Laurel (Bay Leaves)', 'Paminta (Black Pepper)'],
      'steps': [
        'Marinate chicken sa toyo, suka, at bawang for 30 minutes',
        'Igisa ang bawang hanggang mabango',
        'Ilagay ang manok at marinade',
        'Dagdagan ng dahon ng laurel at paminta',
        'Pakuluan ng 30-40 minutes o hanggang lumambot',
        'Adjust lasa kung kailangan',
        'Ihain kasama ng mainit na kanin'
      ],
      'tags': ['Ulam', 'Pang-Araw-Araw', 'Traditional', 'High Protein'],
      'allergens': ['Soy'],
      'comments': [
        {'user': 'Maria', 'comment': 'Paborito ng pamilya! Perfect sa tanghalian.'},
        {'user': 'Juan', 'comment': 'Sobrang sarap! Lalo na pag may kanin.'}
      ],
      'cookTime': '45 minutes',
      'difficulty': 'Easy',
      'rating': 4.9,
    },
    {
      'name': 'Sinigang na Baboy',
      'imageUrl': 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd',
      'calories': 280, 'protein': 28, 'fat': 10, 'carbs': 22,
      'ingredients': ['Baboy (Pork)', 'Sampalok (Tamarind)', 'Kangkong', 'Sitaw (String Beans)', 'Labanos (Radish)', 'Kamatis (Tomatoes)', 'Sibuyas (Onions)', 'Sili (Chili)'],
      'steps': [
        'Pakuluan ang baboy sa tubig na may sibuyas',
        'Alisin ang unang kulo',
        'Dagdagan ng bagong tubig at pakuluan ulit',
        'Ilagay ang kamatis at labanos',
        'Timplahan ng sampalok o sinigang mix',
        'Idagdag ang sitaw at talong',
        'Sa huli, ilagay ang kangkong at sili',
        'Ihain ng mainit'
      ],
      'tags': ['Sabaw', 'Comfort Food', 'Healthy', 'Pang-Ulan'],
      'allergens': [],
      'comments': [
        {'user': 'Lola Rosa', 'comment': 'Yan ang tunay na sinigang! Asim-kilig!'},
        {'user': 'Pedro', 'comment': 'Perfect sa malamig na panahon.'}
      ],
      'cookTime': '1 hour',
      'difficulty': 'Medium',
      'rating': 4.8,
    },
    {
      'name': 'Pancit Canton',
      'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      'calories': 380, 'protein': 18, 'fat': 14, 'carbs': 45,
      'ingredients': ['Canton Noodles', 'Manok o Baboy (Chicken/Pork)', 'Repolyo (Cabbage)', 'Carrots', 'Bawang', 'Sibuyas', 'Toyo', 'Patatas (Calamansi)'],
      'steps': [
        'Lutuin ang canton noodles ayon sa instruction',
        'Igisa ang bawang at sibuyas',
        'Ilagay ang karne at lutuin',
        'Idagdag ang gulay at igisa',
        'Ilagay ang canton at haluin',
        'Timplahan ng toyo at patis',
        'Garnish ng calamansi at chicharon'
      ],
      'tags': ['Pansit', 'Handaan', 'Birthday', 'Quick'],
      'allergens': ['Gluten', 'Soy'],
      'comments': [
        {'user': 'Ate Ning', 'comment': 'Hindi kumpleto ang handaan kung walang pancit!'},
        {'user': 'Kuya Ben', 'comment': 'Mas masarap pag may chicharon!'}
      ],
      'cookTime': '30 minutes',
      'difficulty': 'Easy',
      'rating': 4.7,
    },
    {
      'name': 'Tinolang Manok',
      'imageUrl': 'https://images.unsplash.com/photo-1547592166-23ac45744acd',
      'calories': 250, 'protein': 30, 'fat': 8, 'carbs': 15,
      'ingredients': ['Manok', 'Luya (Ginger)', 'Bawang', 'Sibuyas', 'Dahon ng Sili (Chili Leaves)', 'Sayote (Chayote)', 'Malunggay', 'Patis (Fish Sauce)'],
      'steps': [
        'Igisa ang luya, bawang, at sibuyas',
        'Ilagay ang manok at lutuin hanggang medyo brown',
        'Dagdagan ng tubig at pakuluan',
        'Ilagay ang sayote',
        'Timplahan ng patis',
        'Idagdag ang dahon ng sili at malunggay',
        'Ihain ng mainit'
      ],
      'tags': ['Sabaw', 'Healthy', 'Comfort Food', 'Low Fat'],
      'allergens': [],
      'comments': [
        {'user': 'Nanay', 'comment': 'Perpekto para sa may sipon!'},
        {'user': 'Tatay', 'comment': 'Mas masarap pag mainit na mainit!'}
      ],
      'cookTime': '40 minutes',
      'difficulty': 'Easy',
      'rating': 4.8,
    },
    {
      'name': 'Kare-Kare',
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
      'calories': 420, 'protein': 32, 'fat': 22, 'carbs': 28,
      'ingredients': ['Buntot ng Baka (Oxtail)', 'Mani (Peanuts)', 'Atsuete (Annatto)', 'Sitaw', 'Talong (Eggplant)', 'Pechay', 'Bagoong (Shrimp Paste)'],
      'steps': [
        'Pakuluan ang buntot ng baka hanggang lumambot (2-3 hours)',
        'Giling ang mani o gumamit ng peanut butter',
        'Lagyan ng kulay gamit ang atsuete',
        'Ilagay ang mani sauce sa karne',
        'Idagdag ang gulay',
        'Lutuin hanggang malapot',
        'Ihain kasama ng bagoong'
      ],
      'tags': ['Special Occasion', 'Traditional', 'Rich', 'Festive'],
      'allergens': ['Peanuts', 'Shellfish'],
      'comments': [
        {'user': 'Tita Cora', 'comment': 'Hindi kumpleto ang fiesta kung walang kare-kare!'},
        {'user': 'Tito Ben', 'comment': 'Kailangan may bagoong!'}
      ],
      'cookTime': '3 hours',
      'difficulty': 'Hard',
      'rating': 4.9,
    },
    {
      'name': 'Ginataang Sitaw at Kalabasa',
      'imageUrl': 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      'calories': 220, 'protein': 8, 'fat': 15, 'carbs': 20,
      'ingredients': ['Sitaw', 'Kalabasa (Squash)', 'Gata (Coconut Milk)', 'Bagoong', 'Bawang', 'Sibuyas', 'Sili'],
      'steps': [
        'Igisa ang bawang, sibuyas, at bagoong',
        'Ilagay ang kalabasa',
        'Dagdagan ng konting tubig',
        'Pakuluan hanggang medyo lumalambot',
        'Ibuhos ang gata',
        'Idagdag ang sitaw at sili',
        'Pakuluan ng 5 minutes',
        'Ihain'
      ],
      'tags': ['Gulay', 'Vegetarian Option', 'Healthy', 'Pinoy'],
      'allergens': [],
      'comments': [
        {'user': 'Aling Nena', 'comment': 'Simple lang pero napakasarap!'},
        {'user': 'Mang Tomas', 'comment': 'Perfect sa hapunan!'}
      ],
      'cookTime': '25 minutes',
      'difficulty': 'Easy',
      'rating': 4.6,
    },
    {
      'name': 'Chicken Inasal',
      'imageUrl': 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6',
      'calories': 340, 'protein': 38, 'fat': 16, 'carbs': 12,
      'ingredients': ['Manok', 'Calamansi', 'Lemongrass', 'Bawang', 'Luya', 'Achuete Oil', 'Toyo', 'Asukal (Sugar)', 'Suka'],
      'steps': [
        'Gawa ang marinade: calamansi, lemongrass, bawang, luya, toyo',
        'Marinate ang manok ng 4 hours o overnight',
        'Ihanda ang achuete oil para sa basting',
        'Ihaw ang manok ng mabagal',
        'Basting ng achuete oil habang naghihiaw',
        'Baliktarin at ulitin',
        'Ihain kasama ng kanin at atsara'
      ],
      'tags': ['Ihaw', 'BBQ', 'Street Food', 'High Protein'],
      'allergens': [],
      'comments': [
        {'user': 'Kuya Joel', 'comment': 'Mas masarap pa sa Bacolod!'},
        {'user': 'Ate Lyn', 'comment': 'Kailangan may unlimited rice!'}
      ],
      'cookTime': '45 minutes (plus marinating)',
      'difficulty': 'Medium',
      'rating': 4.9,
    },
    {
      'name': 'Bulalo',
      'imageUrl': 'https://images.unsplash.com/photo-1547592180-85f173990554',
      'calories': 380, 'protein': 35, 'fat': 18, 'carbs': 20,
      'ingredients': ['Bulalo (Beef Shank)', 'Mais (Corn)', 'Repolyo', 'Pechay', 'Sitaw', 'Patis', 'Paminta', 'Sibuyas'],
      'steps': [
        'Pakuluan ang bulalo sa malaking kaldero',
        'Alisin ang unang kulo',
        'Dagdagan ng bagong tubig at pakuluan ng 2-3 hours',
        'Ilagay ang mais',
        'Timplahan ng patis at paminta',
        'Idagdag ang gulay sa huli',
        'Ihain ng mainit na mainit'
      ],
      'tags': ['Sabaw', 'Comfort Food', 'Tagaytay Special', 'Warming'],
      'allergens': [],
      'comments': [
        {'user': 'Mama Gloria', 'comment': 'Perfect sa malamig na panahon sa Tagaytay!'},
        {'user': 'Papa Jun', 'comment': 'Ang utak at sabaw ang pinakamasarap!'}
      ],
      'cookTime': '3 hours',
      'difficulty': 'Medium',
      'rating': 4.9,
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
    setState(() {
      _searchHistory = ['manok, toyo', 'baboy', 'sitaw, kalabasa', 'gata'];
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
  }

  void _performSearch() {
    if (_controller.text.trim().isNotEmpty) {
      _addToSearchHistory(_controller.text.trim());
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
        title: Text('Paghahanap ng Lutuin',
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
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Maghanap ng Pinoy Recipes',
                    style: GoogleFonts.poppins(
                      fontSize: 20, 
                      fontWeight: FontWeight.w600,
                    )),
              ),
              const SizedBox(height: 8),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Ilagay ang sangkap na mayroon ka',
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
                          hintText: 'e.g. manok, toyo, bawang',
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

              // Search history
              if (_controller.text.isEmpty && _searchHistory.isNotEmpty) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text('Nakaraang Paghahanap',
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
                          'Linisin',
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
                    _tabBtn('Mga Recipe', 0),
                    const SizedBox(width: 32),
                    _tabBtn('Patok', 1),
                    const Spacer(),
                    if (_controller.text.isNotEmpty)
                      Text(
                        '${filtered.length} resulta',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: list.length,
        itemBuilder: (_, i) => _buildRecipeCard(list[i]),
      ),
    );
  }

  Widget _buildGridResults(int crossAxisCount) {
    final list = _tab == 0 ? filtered : recipes.reversed.toList();
    
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
          Text('Walang nakitang recipe',
              style: GoogleFonts.poppins(
                fontSize: 18, 
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              )),
          const SizedBox(height: 8),
          Text('Subukan ang ibang sangkap',
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
              'Ipakita Lahat',
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
                          recipe['cookTime'], Colors.blue),
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
                            recipe['cookTime'],
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
              'I-filter ang Recipes',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Uri ng Pagkain',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['Ulam', 'Sabaw', 'Pansit', 'Ihaw', 'Gulay']
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
                  'I-apply ang Filter',
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