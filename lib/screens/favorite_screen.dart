import 'package:flutter/material.dart';
import 'favorites_manager.dart';
import 'recipe_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Color darkGreen = const Color(0xFF006400);

  @override
  Widget build(BuildContext context) {
    final favs = FavoritesManager().favorites;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Text('Favorites'),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: favs.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favs.length,
              itemBuilder: (_, i) {
                final r = favs[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        r['imageUrl'],
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.fastfood, size: 32, color: Colors.grey),
                      ),
                    ),
                    title: Text(r['name']),
                    subtitle: Text('Calories: ${r['calories']} • Protein: ${r['protein']}g'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(
                            name: r['name'],
                            imageUrl: r['imageUrl'],
                            calories: r['calories'],
                            protein: r['protein'],
                            fat: r['fat'],
                            carbs: r['carbs'],
                            ingredients: List<String>.from(r['ingredients']),
                            steps: List<String>.from(r['steps']),
                            tags: List<String>.from(r['tags']),
                            allergens: List<String>.from(r['allergens']),
                            comments: List<Map<String, String>>.from(r['comments']),
                          ),
                        ),
                      ).then((_) => setState(() {})); // refresh after return
                    },
                  ),
                );
              },
            ),
    );
  }
}
