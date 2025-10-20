class Recipe {
  final int id;
  final String name;
  final String description;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String difficulty;
  final String category;
  final int caloriesPerServing;
  final int proteinPerServing;
  final int carbsPerServing;
  final int fatPerServing;
  final String instructions;
  final bool isFilipinoDish;
  final List<String> ingredients;
  final List<String> tags;
  final List<String> allergens;
  final double rating;
  final String cookTimeFormatted;
  final String prepTimeFormatted;
  final String imageUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    required this.category,
    required this.caloriesPerServing,
    required this.proteinPerServing,
    required this.carbsPerServing,
    required this.fatPerServing,
    required this.instructions,
    required this.isFilipinoDish,
    required this.ingredients,
    required this.tags,
    required this.allergens,
    required this.rating,
    required this.cookTimeFormatted,
    required this.prepTimeFormatted,
    required this.imageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      prepTime: json['prep_time'] ?? 0,
      cookTime: json['cook_time'] ?? 0,
      servings: json['servings'] ?? 1,
      difficulty: json['difficulty'] ?? 'Easy',
      category: json['category'] ?? '',
      caloriesPerServing: json['calories_per_serving'] ?? 0,
      proteinPerServing: json['protein_per_serving'] ?? 0,
      carbsPerServing: json['carbs_per_serving'] ?? 0,
      fatPerServing: json['fat_per_serving'] ?? 0,
      instructions: json['instructions'] ?? '',
      isFilipinoDish: json['is_filipino_dish'] ?? false,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      allergens: List<String>.from(json['allergens'] ?? []),
      rating: (json['rating'] ?? 4.0).toDouble(),
      cookTimeFormatted: json['cook_time_formatted'] ?? '${json['cook_time'] ?? 0} minutes',
      prepTimeFormatted: json['prep_time_formatted'] ?? '${json['prep_time'] ?? 0} minutes',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'prep_time': prepTime,
      'cook_time': cookTime,
      'servings': servings,
      'difficulty': difficulty,
      'category': category,
      'calories_per_serving': caloriesPerServing,
      'protein_per_serving': proteinPerServing,
      'carbs_per_serving': carbsPerServing,
      'fat_per_serving': fatPerServing,
      'instructions': instructions,
      'is_filipino_dish': isFilipinoDish,
      'ingredients': ingredients,
      'tags': tags,
      'allergens': allergens,
      'rating': rating,
      'cook_time_formatted': cookTimeFormatted,
      'prep_time_formatted': prepTimeFormatted,
      'image_url': imageUrl,
    };
  }
}
