// Enhanced favorites manager with data persistence and error handling
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Map<String, dynamic>> _favorites = [];
  final StreamController<List<Map<String, dynamic>>> _favoritesController = 
      StreamController<List<Map<String, dynamic>>>.broadcast();

  // Stream for listening to favorites changes
  Stream<List<Map<String, dynamic>>> get favoritesStream => _favoritesController.stream;
  
  // Get current favorites (immutable copy)
  List<Map<String, dynamic>> get favorites => List.unmodifiable(_favorites);
  
  // Get favorites count
  int get count => _favorites.length;
  
  // Check if favorites is empty
  bool get isEmpty => _favorites.isEmpty;
  bool get isNotEmpty => _favorites.isNotEmpty;

  // Add a recipe to favorites
  bool addFavorite(Map<String, dynamic> recipe) {
    try {
      // Validate required fields
      if (!_isValidRecipe(recipe)) {
        if (kDebugMode) print('Invalid recipe data provided');
        return false;
      }

      // Check if already exists
      if (_favorites.any((r) => r['name'] == recipe['name'])) {
        if (kDebugMode) print('Recipe already in favorites');
        return false;
      }

      // Add timestamp and ID
      final recipeWithMeta = {
        ...recipe,
        'favoriteId': DateTime.now().millisecondsSinceEpoch.toString(),
        'addedAt': DateTime.now().toIso8601String(),
      };

      _favorites.insert(0, recipeWithMeta); // Add to beginning
      _notifyListeners();
      _persistFavorites(); // Save to storage
      
      if (kDebugMode) print('Added "${recipe['name']}" to favorites');
      return true;
    } catch (e) {
      if (kDebugMode) print('Error adding favorite: $e');
      return false;
    }
  }

  // Remove a recipe from favorites
  bool removeFavorite(String recipeName) {
    try {
      final initialLength = _favorites.length;
      _favorites.removeWhere((r) => r['name'] == recipeName);
      
      final removed = _favorites.length < initialLength;
      if (removed) {
        _notifyListeners();
        _persistFavorites(); // Save to storage
        if (kDebugMode) print('Removed "$recipeName" from favorites');
      }
      
      return removed;
    } catch (e) {
      if (kDebugMode) print('Error removing favorite: $e');
      return false;
    }
  }

  // Remove favorite by ID
  bool removeFavoriteById(String favoriteId) {
    try {
      final initialLength = _favorites.length;
      _favorites.removeWhere((r) => r['favoriteId'] == favoriteId);
      
      final removed = _favorites.length < initialLength;
      if (removed) {
        _notifyListeners();
        _persistFavorites();
      }
      
      return removed;
    } catch (e) {
      if (kDebugMode) print('Error removing favorite by ID: $e');
      return false;
    }
  }

  // Check if a recipe is in favorites
  bool isFavorite(String recipeName) {
    return _favorites.any((r) => r['name'] == recipeName);
  }

  // Get a specific favorite by name
  Map<String, dynamic>? getFavorite(String recipeName) {
    try {
      return _favorites.firstWhere((r) => r['name'] == recipeName);
    } catch (e) {
      return null;
    }
  }

  // Search favorites
  List<Map<String, dynamic>> searchFavorites(String query) {
    if (query.trim().isEmpty) return favorites;
    
    final lowerQuery = query.toLowerCase();
    return _favorites.where((recipe) {
      final name = recipe['name'].toString().toLowerCase();
      final ingredients = (recipe['ingredients'] as List<String>?)
          ?.join(' ').toLowerCase() ?? '';
      final tags = (recipe['tags'] as List<String>?)
          ?.join(' ').toLowerCase() ?? '';
      
      return name.contains(lowerQuery) || 
             ingredients.contains(lowerQuery) || 
             tags.contains(lowerQuery);
    }).toList();
  }

  // Get favorites by category/tag
  List<Map<String, dynamic>> getFavoritesByTag(String tag) {
    return _favorites.where((recipe) {
      final tags = recipe['tags'] as List<String>? ?? [];
      return tags.any((t) => t.toLowerCase() == tag.toLowerCase());
    }).toList();
  }

  // Sort favorites by different criteria
  List<Map<String, dynamic>> getSortedFavorites({
    FavoritesSortBy sortBy = FavoritesSortBy.dateAdded,
    bool ascending = false,
  }) {
    final sortedList = List<Map<String, dynamic>>.from(_favorites);
    
    sortedList.sort((a, b) {
      int comparison = 0;
      
      switch (sortBy) {
        case FavoritesSortBy.name:
          comparison = a['name'].toString().compareTo(b['name'].toString());
          break;
        case FavoritesSortBy.calories:
          comparison = (a['calories'] as int).compareTo(b['calories'] as int);
          break;
        case FavoritesSortBy.protein:
          comparison = (a['protein'] as int).compareTo(b['protein'] as int);
          break;
        case FavoritesSortBy.dateAdded:
          final dateA = DateTime.tryParse(a['addedAt'] ?? '') ?? DateTime.now();
          final dateB = DateTime.tryParse(b['addedAt'] ?? '') ?? DateTime.now();
          comparison = dateA.compareTo(dateB);
          break;
      }
      
      return ascending ? comparison : -comparison;
    });
    
    return sortedList;
  }

  // Clear all favorites
  void clearFavorites() {
    if (_favorites.isNotEmpty) {
      _favorites.clear();
      _notifyListeners();
      _persistFavorites();
      if (kDebugMode) print('Cleared all favorites');
    }
  }

  // Get statistics
  Map<String, dynamic> getStatistics() {
    if (_favorites.isEmpty) {
      return {
        'totalFavorites': 0,
        'averageCalories': 0,
        'averageProtein': 0,
        'mostCommonTag': null,
        'tags': <String>[],
      };
    }

    final totalCalories = _favorites
        .map((r) => r['calories'] as int? ?? 0)
        .reduce((a, b) => a + b);
    
    final totalProtein = _favorites
        .map((r) => r['protein'] as int? ?? 0)
        .reduce((a, b) => a + b);

    // Count tags
    final Map<String, int> tagCounts = {};
    for (final recipe in _favorites) {
      final tags = recipe['tags'] as List<String>? ?? [];
      for (final tag in tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }

    final mostCommonTag = tagCounts.isNotEmpty
        ? tagCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    return {
      'totalFavorites': _favorites.length,
      'averageCalories': (totalCalories / _favorites.length).round(),
      'averageProtein': (totalProtein / _favorites.length).round(),
      'mostCommonTag': mostCommonTag,
      'tags': tagCounts.keys.toList(),
      'tagCounts': tagCounts,
    };
  }

  // Bulk operations
  bool addMultipleFavorites(List<Map<String, dynamic>> recipes) {
    try {
      int addedCount = 0;
      for (final recipe in recipes) {
        if (addFavorite(recipe)) {
          addedCount++;
        }
      }
      if (kDebugMode) print('Added $addedCount out of ${recipes.length} recipes');
      return addedCount > 0;
    } catch (e) {
      if (kDebugMode) print('Error in bulk add: $e');
      return false;
    }
  }

  // Export favorites as JSON
  String exportFavoritesJson() {
    try {
      return jsonEncode({
        'favorites': _favorites,
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0',
      });
    } catch (e) {
      if (kDebugMode) print('Error exporting favorites: $e');
      return '';
    }
  }

  // Import favorites from JSON
  bool importFavoritesJson(String jsonString, {bool replace = false}) {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final importedFavorites = data['favorites'] as List<dynamic>;
      
      if (replace) {
        clearFavorites();
      }
      
      final recipes = importedFavorites
          .cast<Map<String, dynamic>>()
          .where(_isValidRecipe)
          .toList();
          
      return addMultipleFavorites(recipes);
    } catch (e) {
      if (kDebugMode) print('Error importing favorites: $e');
      return false;
    }
  }

  // Initialize favorites (load from storage)
  Future<void> initialize() async {
    try {
      await _loadFavorites();
      if (kDebugMode) print('Favorites manager initialized with ${_favorites.length} items');
    } catch (e) {
      if (kDebugMode) print('Error initializing favorites: $e');
    }
  }

  // Private methods
  bool _isValidRecipe(Map<String, dynamic> recipe) {
    return recipe.containsKey('name') &&
           recipe['name'] is String &&
           recipe['name'].toString().trim().isNotEmpty &&
           recipe.containsKey('calories') &&
           recipe['calories'] is int &&
           recipe.containsKey('protein') &&
           recipe['protein'] is int;
  }

  void _notifyListeners() {
    _favoritesController.add(List.unmodifiable(_favorites));
  }

  Future<void> _persistFavorites() async {
    try {
      // TODO: Implement actual persistence with SharedPreferences, Hive, etc.
      // For now, this is a placeholder
      jsonEncode(_favorites);
      if (kDebugMode) print('Persisting ${_favorites.length} favorites');
      // await SharedPreferences.getInstance().then((prefs) => 
      //   prefs.setString('favorites', jsonString));
    } catch (e) {
      if (kDebugMode) print('Error persisting favorites: $e');
    }
  }

  Future<void> _loadFavorites() async {
    try {
      // TODO: Implement actual loading with SharedPreferences, Hive, etc.
      // For now, this loads demo data
      /* 
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('favorites');
      if (jsonString != null) {
        final List<dynamic> loadedData = jsonDecode(jsonString);
        _favorites.clear();
        _favorites.addAll(loadedData.cast<Map<String, dynamic>>());
        _notifyListeners();
      }
      */
    } catch (e) {
      if (kDebugMode) print('Error loading favorites: $e');
    }
  }

  // Dispose resources
  void dispose() {
    _favoritesController.close();
  }
}

// Enum for sorting options
enum FavoritesSortBy {
  name,
  calories,
  protein,
  dateAdded,
}

// Extension methods for convenience
extension FavoritesManagerExtension on FavoritesManager {
  // Quick methods for common operations
  bool toggleFavorite(Map<String, dynamic> recipe) {
    final recipeName = recipe['name'] as String;
    if (isFavorite(recipeName)) {
      return removeFavorite(recipeName);
    } else {
      return addFavorite(recipe);
    }
  }
  
  // Get recent favorites (last N items)
  List<Map<String, dynamic>> getRecentFavorites(int count) {
    return favorites.take(count).toList();
  }
  
  // Get high protein favorites
  List<Map<String, dynamic>> getHighProteinFavorites({int minProtein = 20}) {
    return favorites.where((r) => (r['protein'] as int? ?? 0) >= minProtein).toList();
  }
  
  // Get low calorie favorites
  List<Map<String, dynamic>> getLowCalorieFavorites({int maxCalories = 300}) {
    return favorites.where((r) => (r['calories'] as int? ?? 0) <= maxCalories).toList();
  }
}