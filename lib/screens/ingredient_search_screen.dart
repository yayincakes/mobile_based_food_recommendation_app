import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'recipe_detail_screen.dart';

class IngredientSearchScreen extends StatefulWidget {
  const IngredientSearchScreen({super.key});

  @override
  State<IngredientSearchScreen> createState() => _IngredientSearchScreenState();
}

class _IngredientSearchScreenState extends State<IngredientSearchScreen> {
  int _tab = 0; // 0=Recipes, 1=Popular
  final TextEditingController _controller = TextEditingController();
  final Color darkGreen = const Color(0xFF006400);

  // Demo recipes w/ details
  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Grilled Chicken Salad',
      'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      'calories': 350, 'protein': 30, 'fat': 10, 'carbs': 18,
      'ingredients': ['Chicken', 'Lettuce', 'Tomato'],
      'steps': ['Grill the chicken.', 'Chop the vegetables.', 'Mix together and serve.'],
      'tags': ['Low Carb', 'High Protein'],
      'allergens': [],
      'comments': [{'user': 'Jane', 'comment': 'Delicious and easy!'}],
    },
    {
      'name': 'Veggie Omelette',
      'imageUrl': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      'calories': 180, 'protein': 12, 'fat': 9, 'carbs': 8,
      'ingredients': ['Egg', 'Bell Pepper', 'Onion'],
      'steps': ['Beat the eggs.', 'Cook veggies in a pan.', 'Pour eggs and cook through.'],
      'tags': ['Breakfast', 'Quick'],
      'allergens': ['Egg'],
      'comments': [{'user': 'Sam', 'comment': 'Protein-packed breakfast!'}],
    },
    {
      'name': 'Tomato Soup',
      'imageUrl': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0',
      'calories': 210, 'protein': 5, 'fat': 6, 'carbs': 30,
      'ingredients': ['Tomato', 'Onion', 'Garlic'],
      'steps': ['Sauté onions and garlic.', 'Add tomatoes and cook.', 'Blend and serve warm.'],
      'tags': ['Vegan', 'Soup'],
      'allergens': [],
      'comments': [{'user': 'Carlo', 'comment': 'Great for rainy days.'}],
    },
  ];

  List<Map<String, dynamic>> get filtered {
    final input = _controller.text.trim().toLowerCase();
    if (input.isEmpty) return recipes;
    final inputList = input.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    return recipes.where((r) {
      final ingr = (r['ingredients'] as List).map((e) => e.toString().toLowerCase()).toList();
      return inputList.every((needle) => ingr.any((ri) => ri.contains(needle)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NOTE: No BottomNavigationBar here — MainDashboard owns it.
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
              color: darkGreen, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text('FitMeal', style: GoogleFonts.pacifico(fontSize: 32, color: darkGreen)),
            const SizedBox(height: 12),
            Text('Enter your ingredients',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'e.g. tomato, egg',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  filled: true, fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: darkGreen),
                    onPressed: () => setState(() {}),
                  ),
                ),
                style: GoogleFonts.poppins(),
              ),
            ),

            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tabBtn('Recipes', 0),
                const SizedBox(width: 32),
                _tabBtn('Popular', 1),
              ],
            ),
            const SizedBox(height: 8),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  itemCount: (_tab == 0 ? filtered : recipes.reversed.toList()).length,
                  itemBuilder: (_, i) {
                    final list = _tab == 0 ? filtered : recipes.reversed.toList();
                    final recipe = list[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      color: _tab == 0 ? Colors.grey.shade200 : Colors.grey.shade100,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            recipe['imageUrl'], width: 54, height: 54, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade300,
                              width: 54, height: 54,
                              child: const Icon(Icons.fastfood, color: Colors.grey, size: 28),
                            ),
                          ),
                        ),
                        title: Text(recipe['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                        subtitle: Text((recipe['ingredients'] as List).join(', '),
                            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {
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
                                allergens: List<String>.from(recipe['allergens']),
                                comments: List<Map<String, String>>.from(recipe['comments']),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBtn(String label, int idx) {
    return GestureDetector(
      onTap: () => setState(() => _tab = idx),
      child: Column(
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: _tab == idx ? darkGreen : Colors.black54,
                fontSize: 16,
              )),
          if (_tab == idx)
            Container(height: 2, width: 40, margin: const EdgeInsets.only(top: 2), color: darkGreen),
        ],
      ),
    );
  }
}
