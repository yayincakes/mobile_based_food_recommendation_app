import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'favorites_manager.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tags;
  final List<String> allergens;
  final List<Map<String, String>> comments;

  const RecipeDetailScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.ingredients,
    required this.steps,
    this.tags = const [],
    this.allergens = const [],
    this.comments = const [],
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFavorite = false;
  final Color darkGreen = const Color(0xFF006400);

  @override
  void initState() {
    super.initState();
    isFavorite = FavoritesManager().isFavorite(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: Text(widget.name, style: GoogleFonts.poppins()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: 'Favorite',
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.pink : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
                if (isFavorite) {
                  FavoritesManager().addFavorite({
                    'name': widget.name,
                    'imageUrl': widget.imageUrl,
                    'calories': widget.calories,
                    'protein': widget.protein,
                    'fat': widget.fat,
                    'carbs': widget.carbs,
                    'ingredients': widget.ingredients,
                    'steps': widget.steps,
                    'tags': widget.tags,
                    'allergens': widget.allergens,
                    'comments': widget.comments,
                  });
                } else {
                  FavoritesManager().removeFavorite(widget.name);
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(isFavorite ? 'Added to favorites' : 'Removed from favorites')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: Colors.grey.shade200,
                child: const Icon(Icons.fastfood, size: 64, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(widget.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: darkGreen,
              )),
          const SizedBox(height: 10),

          if (widget.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              children: widget.tags.map((t) => Chip(
                label: Text(t, style: GoogleFonts.poppins(fontSize: 13)),
                backgroundColor: darkGreen.withOpacity(0.12),
                labelStyle: TextStyle(color: darkGreen),
              )).toList(),
            ),

          if (widget.allergens.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text('Allergens',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                )),
            Wrap(
              spacing: 8,
              children: widget.allergens.map((a) => Chip(
                label: Text(a, style: GoogleFonts.poppins(fontSize: 13, color: Colors.redAccent)),
                backgroundColor: Colors.redAccent.withOpacity(0.10),
              )).toList(),
            ),
          ],

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nutri('Calories', '${widget.calories}', Colors.deepOrange),
              _nutri('Protein', '${widget.protein}g', Colors.green),
              _nutri('Fat', '${widget.fat}g', Colors.redAccent),
              _nutri('Carbs', '${widget.carbs}g', Colors.amber[700]!),
            ],
          ),

          const SizedBox(height: 24),
          Text('Ingredients', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...widget.ingredients.map((ing) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(child: Text(ing, style: GoogleFonts.poppins(fontSize: 15))),
              ],
            ),
          )),

          const SizedBox(height: 24),
          Text('Preparation Steps', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...List.generate(widget.steps.length, (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${i + 1}. ', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                Expanded(child: Text(widget.steps[i], style: GoogleFonts.poppins())),
              ],
            ),
          )),

          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add to Plan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to your plan!')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutri(String label, String value, Color color) {
    return Chip(
      backgroundColor: color.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Column(
        children: [
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: color)),
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
