// Simple in-memory favorites store.
// Swap to Provider/Hive later for persistence.
class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => List.unmodifiable(_favorites);

  void addFavorite(Map<String, dynamic> recipe) {
    if (!_favorites.any((r) => r['name'] == recipe['name'])) {
      _favorites.add(recipe);
    }
  }

  void removeFavorite(String recipeName) {
    _favorites.removeWhere((r) => r['name'] == recipeName);
  }

  bool isFavorite(String recipeName) {
    return _favorites.any((r) => r['name'] == recipeName);
  }
}
