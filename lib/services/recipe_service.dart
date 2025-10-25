import '../models/recipe.dart';

class RecipeService {
  static final RecipeService _instance = RecipeService._internal();
  factory RecipeService() => _instance;
  RecipeService._internal();

  // Comprehensive Filipino recipe collection
  List<Recipe> getAllRecipes() {
    return [
      // Filipino Breakfast Dishes
      Recipe(
        id: 1,
        name: 'Tapsilog',
        description: 'Tapa, Sinangag, at Itlog - Classic Filipino breakfast',
        prepTime: 15,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 28,
        carbsPerServing: 58,
        fatPerServing: 18,
        instructions: '''1. Marinate the beef tapa with soy sauce, garlic, and calamansi for at least 30 minutes
2. Cook garlic rice by sautéing minced garlic in oil until golden, then add cooked rice and mix well
3. Heat oil in a pan and cook the marinated beef until tender and slightly caramelized
4. In a separate pan, fry an egg sunny-side up
5. Serve the beef tapa over garlic rice with the fried egg on top
6. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['beef tapa', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['soy', 'egg'],
        rating: 4.8,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/tapsilog.jpg',
      ),
      Recipe(
        id: 2,
        name: 'Champorado with Tuyo',
        description: 'Sweet chocolate rice porridge with dried fish',
        prepTime: 10,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 15,
        carbsPerServing: 62,
        fatPerServing: 9,
        instructions: '''1. Rinse 1 cup of glutinous rice until water runs clear
2. In a pot, combine rice with 4 cups of water and bring to a boil
3. Reduce heat and simmer for 15-20 minutes until rice is tender
4. Add 3-4 tablespoons of cocoa powder and 1/2 cup of sugar, mix well
5. Continue cooking for 5 more minutes until thick and creamy
6. Serve hot in bowls, top with tuyo (dried fish) and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['rice', 'cocoa powder', 'sugar', 'tuyo', 'milk'],
        tags: ['filipino', 'breakfast', 'comfort food'],
        allergens: ['fish', 'milk'],
        rating: 4.5,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/champorado.jpg',
      ),
      Recipe(
        id: 3,
        name: 'Pandesal with Scrambled Egg',
        description: 'Soft Filipino bread with scrambled eggs',
        prepTime: 5,
        cookTime: 10,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 340,
        proteinPerServing: 18,
        carbsPerServing: 44,
        fatPerServing: 12,
        instructions: '''1. Slice pandesal bread in half and toast until golden brown
2. In a bowl, crack 2-3 eggs and add 2 tablespoons of milk, salt, and pepper
3. Whisk the egg mixture until well combined
4. Heat butter in a non-stick pan over medium heat
5. Pour in the egg mixture and gently scramble with a spatula
6. Cook until eggs are soft and creamy, remove from heat
7. Fill the toasted pandesal with scrambled eggs and serve immediately''',
        isFilipinoDish: true,
        ingredients: ['pandesal', 'eggs', 'milk', 'butter', 'salt'],
        tags: ['filipino', 'breakfast', 'quick'],
        allergens: ['egg', 'milk', 'wheat'],
        rating: 4.3,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'https://example.com/pandesal.jpg',
      ),
      Recipe(
        id: 4,
        name: 'Lugaw with Egg',
        description: 'Warm rice porridge with soft-boiled egg',
        prepTime: 10,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 12,
        carbsPerServing: 52,
        fatPerServing: 8,
        instructions: '''1. Rinse 1 cup of jasmine rice until water runs clear
2. In a large pot, heat 2 tablespoons of oil and sauté 3 cloves minced garlic until golden
3. Add 1 tablespoon grated ginger and 1 chopped onion, cook until fragrant
4. Add the rice and stir for 2 minutes
5. Pour in 4 cups of chicken broth and bring to a boil
6. Reduce heat to low, cover and simmer for 20-25 minutes until rice is tender
7. Season with fish sauce, salt, and pepper to taste
8. In a separate pan, soft-boil 4 eggs (6 minutes for runny yolk)
9. Serve the rice porridge hot, topped with soft-boiled eggs, chopped spring onions, and fried garlic
10. Garnish with calamansi wedges and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['rice', 'chicken broth', 'egg', 'ginger', 'spring onion'],
        tags: ['filipino', 'breakfast', 'comfort food'],
        allergens: ['egg'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/lugaw.jpg',
      ),

      // Filipino Lunch Dishes
      Recipe(
        id: 5,
        name: 'Adobong Manok',
        description: 'Classic Filipino chicken in soy sauce and vinegar',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 350,
        proteinPerServing: 25,
        carbsPerServing: 15,
        fatPerServing: 20,
        instructions: '''1. Cut chicken into serving pieces and marinate with soy sauce, vinegar, garlic, and bay leaves for 30 minutes
2. Heat oil in a pan and brown the chicken pieces on all sides
3. Add the marinade liquid and bring to a boil
4. Reduce heat and simmer for 20-25 minutes until chicken is tender
5. Add potatoes and cook for another 10 minutes
6. Season with salt and pepper to taste
7. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'soy sauce', 'vinegar', 'garlic', 'bay leaves'],
        tags: ['filipino', 'lunch', 'traditional'],
        allergens: ['soy'],
        rating: 4.8,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'assets/images/adobo.jpg',
      ),
      Recipe(
        id: 6,
        name: 'Sinigang na Baboy',
        description: 'Sour soup with pork and vegetables',
        prepTime: 20,
        cookTime: 45,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 25,
        carbsPerServing: 35,
        fatPerServing: 14,
        instructions: '''1. In a large pot, boil pork ribs in water with salt for 30 minutes until tender
2. Add tamarind paste or tamarind powder and mix well
3. Add tomatoes, onions, and radish, cook for 10 minutes
4. Add string beans and okra, cook for another 5 minutes
5. Season with fish sauce and pepper to taste
6. Add spinach or kangkong leaves and cook for 2 minutes
7. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['pork', 'tamarind', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'lunch', 'soup'],
        allergens: ['fish'],
        rating: 4.6,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd',
      ),
      Recipe(
        id: 7,
        name: 'Beef Nilaga',
        description: 'Boiled beef with vegetables',
        prepTime: 15,
        cookTime: 60,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 450,
        proteinPerServing: 32,
        carbsPerServing: 38,
        fatPerServing: 18,
        instructions: '''1. Cut 1 kg beef into 2-inch cubes and rinse under cold water
2. In a large pot, place beef with 8 cups water, 2 bay leaves, and 1 tsp salt
3. Bring to a boil, then reduce heat and simmer for 1.5-2 hours until beef is tender
4. Skim off any foam that rises to the surface during cooking
5. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
6. Continue simmering for 15 minutes
7. Add 1 small cabbage (quartered) and 1 bunch bok choy
8. Season with fish sauce, salt, and pepper to taste
9. Simmer for another 5-10 minutes until vegetables are tender
10. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['beef', 'potatoes', 'carrots', 'cabbage', 'onion'],
        tags: ['filipino', 'lunch', 'comfort food'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/nilaga.jpg',
      ),
      Recipe(
        id: 8,
        name: 'Fish Sinigang',
        description: 'Sour soup with fish and vegetables',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 360,
        proteinPerServing: 28,
        carbsPerServing: 36,
        fatPerServing: 10,
        instructions: '''1. Clean and cut 1 kg fish (milkfish or tilapia) into serving pieces
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 2 large tomatoes (quartered) and cook until soft
5. Pour in 6 cups water and bring to a boil
6. Add 3-4 tablespoons tamarind paste or 1 cup tamarind juice
7. Season with fish sauce, salt, and pepper to taste
8. Add fish pieces and simmer for 10 minutes
9. Add 1 bunch kangkong (water spinach) and 1 bunch string beans
10. Add 2-3 pieces green chili peppers
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['fish', 'tamarind', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'lunch', 'soup', 'healthy'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/fish-sinigang.jpg',
      ),
      Recipe(
        id: 9,
        name: 'Pancit Canton',
        description: 'Filipino stir-fried noodles with vegetables and meat',
        prepTime: 15,
        cookTime: 20,
        servings: 6,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 18,
        carbsPerServing: 45,
        fatPerServing: 14,
        instructions: '''1. Soak 500g canton noodles in warm water for 10 minutes, then drain
2. Cut 300g chicken breast into thin strips and marinate with soy sauce and pepper
3. Heat 3 tablespoons oil in a large wok or pan over high heat
4. Sauté 4 cloves minced garlic and 1 sliced onion until fragrant
5. Add marinated chicken and cook until golden brown
6. Add 1 cup sliced carrots and 2 cups shredded cabbage
7. Stir-fry for 3-4 minutes until vegetables are tender-crisp
8. Add the soaked noodles and 3 tablespoons soy sauce
9. Toss everything together for 2-3 minutes until well combined
10. Season with salt, pepper, and a pinch of sugar
11. Garnish with chopped spring onions and serve hot with calamansi wedges''',
        isFilipinoDish: true,
        ingredients: ['canton noodles', 'chicken', 'cabbage', 'carrots', 'soy sauce'],
        tags: ['filipino', 'lunch', 'noodles'],
        allergens: ['gluten', 'soy'],
        rating: 4.7,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      ),
      Recipe(
        id: 10,
        name: 'Tinolang Manok',
        description: 'Filipino chicken soup with vegetables',
        prepTime: 15,
        cookTime: 30,
        servings: 6,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 250,
        proteinPerServing: 30,
        carbsPerServing: 15,
        fatPerServing: 8,
        instructions: '''1. Cut 1 whole chicken into serving pieces and rinse well
2. In a large pot, heat 2 tablespoons oil and sauté 1 thumb-sized ginger (sliced) until fragrant
3. Add 1 chopped onion and 4 cloves minced garlic, cook until golden
4. Add chicken pieces and brown on all sides for 5 minutes
5. Pour in 6 cups water and bring to a boil
6. Skim off any foam, then reduce heat and simmer for 30 minutes
7. Add 2 chayote (sayote) cut into wedges and 2 green papaya chunks
8. Season with fish sauce, salt, and pepper to taste
9. Add 1 bunch malunggay leaves and 2-3 chili leaves
10. Simmer for another 10 minutes until vegetables are tender
11. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'ginger', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'lunch', 'soup', 'healthy'],
        allergens: ['fish'],
        rating: 4.8,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd',
      ),

      // Filipino Dinner Dishes
      Recipe(
        id: 11,
        name: 'Kare-Kare',
        description: 'Oxtail stew with peanut sauce',
        prepTime: 30,
        cookTime: 120,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 480,
        proteinPerServing: 28,
        carbsPerServing: 45,
        fatPerServing: 22,
        instructions: '''1. Boil 1 kg oxtail in water with bay leaves for 2-3 hours until very tender
2. In a separate pan, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 1/2 cup peanut butter and 1 cup of the oxtail broth
5. Stir until peanut butter is dissolved and sauce is smooth
6. Add 2 tablespoons annatto powder for color
7. Season with fish sauce, salt, and pepper
8. Add the tender oxtail to the peanut sauce
9. Add 1 bunch string beans and 1 eggplant (cut in chunks)
10. Simmer for 10-15 minutes until vegetables are tender
11. Serve hot with steamed rice and bagoong on the side''',
        isFilipinoDish: true,
        ingredients: ['oxtail', 'peanut butter', 'vegetables', 'bagoong', 'onion'],
        tags: ['filipino', 'dinner', 'special'],
        allergens: ['nuts', 'fish'],
        rating: 4.7,
        cookTimeFormatted: '120 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
      ),
      Recipe(
        id: 12,
        name: 'Lechon Kawali',
        description: 'Crispy fried pork belly',
        prepTime: 20,
        cookTime: 45,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 32,
        carbsPerServing: 38,
        fatPerServing: 28,
        instructions: '''1. Cut 1 kg pork belly into 2-inch thick slices
2. In a large pot, place pork with 8 cups water, 4 cloves garlic, 2 bay leaves, and 1 tbsp salt
3. Bring to a boil, then reduce heat and simmer for 45-60 minutes until tender
4. Remove pork from water and let cool completely
5. Pat dry with paper towels and score the skin with a knife
6. Rub salt all over the pork, especially on the skin
7. Let it air-dry for 30 minutes or refrigerate uncovered for 2 hours
8. Heat oil in a deep pan to 350°F (175°C)
9. Carefully lower pork into hot oil, skin side down first
10. Fry for 8-10 minutes until golden and crispy
11. Flip and fry the other side for 5-7 minutes
12. Drain on paper towels and serve hot with steamed rice and lechon sauce''',
        isFilipinoDish: true,
        ingredients: ['pork belly', 'garlic', 'bay leaves', 'salt', 'oil'],
        tags: ['filipino', 'dinner', 'special'],
        allergens: [],
        rating: 4.6,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b',
      ),
      Recipe(
        id: 13,
        name: 'Chicken Afritada',
        description: 'Chicken stew with potatoes and carrots',
        prepTime: 20,
        cookTime: 40,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 460,
        proteinPerServing: 34,
        carbsPerServing: 48,
        fatPerServing: 14,
        instructions: '''1. Cut 1 whole chicken into serving pieces and season with salt and pepper
2. Heat 3 tablespoons oil in a large pan over medium-high heat
3. Brown chicken pieces on all sides for 5-7 minutes, then remove from pan
4. In the same pan, sauté 1 chopped onion until translucent
5. Add 4 cloves minced garlic and cook until fragrant
6. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
7. Cook vegetables for 5 minutes until slightly tender
8. Return chicken to the pan and add 1 can tomato sauce
9. Pour in 1 cup water and bring to a boil
10. Reduce heat and simmer for 25-30 minutes until chicken is tender
11. Season with fish sauce, salt, pepper, and a pinch of sugar
12. Add 1 bell pepper (sliced) and simmer for 5 more minutes
13. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'potatoes', 'carrots', 'tomato sauce', 'onion'],
        tags: ['filipino', 'dinner', 'comfort food'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '40 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/afritada.jpg',
      ),
      Recipe(
        id: 14,
        name: 'Laing',
        description: 'Taro leaves in coconut milk',
        prepTime: 25,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 400,
        proteinPerServing: 26,
        carbsPerServing: 44,
        fatPerServing: 14,
        instructions: '''1. Wash 1 bunch taro leaves (gabi leaves) thoroughly and cut into strips
2. Cut 300g pork belly into small cubes
3. Heat 2 tablespoons oil in a large pot and sauté 1 thumb-sized ginger (sliced)
4. Add 1 chopped onion and 4 cloves minced garlic, cook until golden
5. Add pork cubes and cook until lightly browned
6. Add 2 cups coconut milk and bring to a gentle boil
7. Add taro leaves and stir to combine
8. Season with fish sauce, salt, and pepper
9. Add 2-3 pieces green chili peppers
10. Simmer for 15-20 minutes until leaves are tender and pork is cooked
11. Add 1/2 cup coconut cream and simmer for 5 more minutes
12. Serve hot with steamed rice and bagoong on the side''',
        isFilipinoDish: true,
        ingredients: ['taro leaves', 'coconut milk', 'pork', 'ginger', 'chili'],
        tags: ['filipino', 'dinner', 'vegetarian option'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      ),
      Recipe(
        id: 15,
        name: 'Bicol Express',
        description: 'Spicy pork with coconut milk',
        prepTime: 20,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 20,
        carbsPerServing: 12,
        fatPerServing: 25,
        instructions: '''1. Cut 500g pork belly into thin strips
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add pork strips and cook until lightly browned
5. Add 2-3 pieces green chili peppers (sliced) and 1 thumb-sized ginger (sliced)
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 tablespoon shrimp paste (bagoong) and mix well
9. Simmer for 20-25 minutes until pork is tender
10. Add 1/2 cup coconut cream and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['pork', 'coconut milk', 'chili', 'shrimp paste', 'garlic'],
        tags: ['filipino', 'dinner', 'spicy'],
        allergens: ['shellfish'],
        rating: 4.7,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      ),
      Recipe(
        id: 16,
        name: 'Sisig',
        description: 'Famous Kapampangan dish with pork and liver',
        prepTime: 30,
        cookTime: 20,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 30,
        carbsPerServing: 5,
        fatPerServing: 28,
        instructions: 'Cook pork and liver, mix with vegetables and seasonings',
        isFilipinoDish: true,
        ingredients: ['pork', 'liver', 'onion', 'chili', 'calamansi'],
        tags: ['filipino', 'dinner', 'spicy'],
        allergens: ['egg'],
        rating: 4.9,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe',
      ),
      Recipe(
        id: 17,
        name: 'Pinakbet',
        description: 'Mixed vegetables with shrimp paste',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 120,
        proteinPerServing: 8,
        carbsPerServing: 20,
        fatPerServing: 3,
        instructions: 'Sauté vegetables with bagoong',
        isFilipinoDish: true,
        ingredients: ['mixed vegetables', 'bagoong', 'garlic', 'onion', 'tomato'],
        tags: ['filipino', 'dinner', 'vegetarian', 'healthy'],
        allergens: ['fish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      ),
      Recipe(
        id: 18,
        name: 'Beef Caldereta',
        description: 'Rich beef stew with cheese and milk',
        prepTime: 30,
        cookTime: 90,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 420,
        proteinPerServing: 35,
        carbsPerServing: 25,
        fatPerServing: 20,
        instructions: 'Cook beef until tender, add vegetables and cheese',
        isFilipinoDish: true,
        ingredients: ['beef', 'tomatoes', 'onions', 'garlic', 'cheese', 'milk'],
        tags: ['filipino', 'dinner', 'special occasion'],
        allergens: ['dairy'],
        rating: 4.8,
        cookTimeFormatted: '90 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
      ),
      Recipe(
        id: 19,
        name: 'Chicken Curry',
        description: 'Filipino-style chicken curry',
        prepTime: 20,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 350,
        proteinPerServing: 32,
        carbsPerServing: 20,
        fatPerServing: 18,
        instructions: '''1. Cut 1 kg chicken into serving pieces and season with salt and pepper
2. Heat 3 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add chicken pieces and cook until lightly browned
6. Add 2 tablespoons curry powder and stir for 1 minute
7. Pour in 2 cups coconut milk and bring to a gentle boil
8. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
9. Season with fish sauce, salt, and pepper
10. Simmer for 25-30 minutes until chicken is tender
11. Add 1 bell pepper (sliced) and 1/2 cup coconut cream
12. Simmer for 5 more minutes and serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'curry powder', 'coconut milk', 'potatoes', 'carrots'],
        tags: ['filipino', 'dinner', 'spicy'],
        allergens: [],
        rating: 4.7,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd',
      ),
      Recipe(
        id: 20,
        name: 'Ginisang Munggo',
        description: 'Sautéed mung beans with vegetables',
        prepTime: 10,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 180,
        proteinPerServing: 12,
        carbsPerServing: 25,
        fatPerServing: 5,
        instructions: 'Cook mung beans, sauté with vegetables',
        isFilipinoDish: true,
        ingredients: ['mung beans', 'vegetables', 'garlic', 'onion', 'fish sauce'],
        tags: ['filipino', 'dinner', 'vegetarian', 'healthy'],
        allergens: ['fish'],
        rating: 4.2,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      ),
      Recipe(
        id: 21,
        name: 'Crispy Pata',
        description: 'Deep-fried pork knuckle',
        prepTime: 30,
        cookTime: 120,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 45,
        carbsPerServing: 5,
        fatPerServing: 35,
        instructions: 'Boil pork knuckle, deep fry until crispy',
        isFilipinoDish: true,
        ingredients: ['pork knuckle', 'salt', 'pepper', 'garlic', 'vinegar'],
        tags: ['filipino', 'dinner', 'special occasion'],
        allergens: [],
        rating: 4.9,
        cookTimeFormatted: '120 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b',
      ),
      Recipe(
        id: 22,
        name: 'Dinuguan',
        description: 'Pork blood stew',
        prepTime: 20,
        cookTime: 60,
        servings: 8,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 30,
        carbsPerServing: 15,
        fatPerServing: 25,
        instructions: 'Cook pork, add blood and seasonings',
        isFilipinoDish: true,
        ingredients: ['pork', 'pig blood', 'vinegar', 'garlic', 'chili'],
        tags: ['filipino', 'dinner', 'special occasion'],
        allergens: [],
        rating: 4.6,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      ),
      Recipe(
        id: 23,
        name: 'Paksiw na Isda',
        description: 'Fish in vinegar',
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 220,
        proteinPerServing: 35,
        carbsPerServing: 12,
        fatPerServing: 8,
        instructions: '''1. Clean and cut 1 kg fish (milkfish or tilapia) into serving pieces
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add fish pieces and cook for 2 minutes on each side
6. Pour in 1 cup vinegar and 1/2 cup water
7. Add 2 tablespoons fish sauce and 1 teaspoon salt
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Bring to a boil, then reduce heat and simmer for 15 minutes
10. Add 1 bunch kangkong (water spinach) and 2 pieces green chili peppers
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['fish', 'vinegar', 'garlic', 'chili', 'fish sauce'],
        tags: ['filipino', 'dinner', 'healthy'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44',
      ),
      Recipe(
        id: 24,
        name: 'Ginataang Alimango',
        description: 'Crab in coconut milk',
        prepTime: 20,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 280,
        proteinPerServing: 25,
        carbsPerServing: 8,
        fatPerServing: 18,
        instructions: '''1. Clean 1 kg fresh crabs and cut into halves
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add crab pieces and cook for 3 minutes on each side
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 15-20 minutes until crab is cooked
10. Add 1/2 cup coconut cream and 1 bunch malunggay leaves
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['crab', 'coconut milk', 'garlic', 'chili', 'fish sauce'],
        tags: ['filipino', 'dinner', 'seafood'],
        allergens: ['shellfish'],
        rating: 4.8,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44',
      ),
      Recipe(
        id: 25,
        name: 'Pancit Bihon',
        description: 'Rice noodles with vegetables and meat',
        prepTime: 15,
        cookTime: 15,
        servings: 6,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 15,
        carbsPerServing: 45,
        fatPerServing: 12,
        instructions: 'Cook rice noodles, stir-fry with vegetables and meat',
        isFilipinoDish: true,
        ingredients: ['rice noodles', 'chicken', 'cabbage', 'carrots', 'soy sauce'],
        tags: ['filipino', 'dinner', 'noodles'],
        allergens: ['gluten', 'soy'],
        rating: 4.7,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      ),
      Recipe(
        id: 26,
        name: 'Tortang Talong',
        description: 'Eggplant omelet',
        prepTime: 10,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 180,
        proteinPerServing: 12,
        carbsPerServing: 8,
        fatPerServing: 12,
        instructions: 'Grill eggplant, dip in egg mixture, fry',
        isFilipinoDish: true,
        ingredients: ['eggplant', 'eggs', 'onion', 'garlic', 'salt'],
        tags: ['filipino', 'dinner', 'vegetarian'],
        allergens: ['egg'],
        rating: 4.5,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      ),
      Recipe(
        id: 27,
        name: 'Chicken Inasal',
        description: 'Grilled chicken with lemongrass and annatto',
        prepTime: 30,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 340,
        proteinPerServing: 38,
        carbsPerServing: 12,
        fatPerServing: 16,
        instructions: 'Marinate chicken, grill with lemongrass and annatto',
        isFilipinoDish: true,
        ingredients: ['chicken', 'lemongrass', 'annatto', 'garlic', 'soy sauce'],
        tags: ['filipino', 'dinner', 'grilled'],
        allergens: ['soy'],
        rating: 4.9,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6',
      ),
      Recipe(
        id: 28,
        name: 'Bulalo',
        description: 'Beef shank soup with vegetables',
        prepTime: 30,
        cookTime: 180,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 35,
        carbsPerServing: 20,
        fatPerServing: 18,
        instructions: 'Boil beef shank until tender, add vegetables',
        isFilipinoDish: true,
        ingredients: ['beef shank', 'corn', 'cabbage', 'fish sauce', 'pepper'],
        tags: ['filipino', 'dinner', 'soup'],
        allergens: ['fish'],
        rating: 4.9,
        cookTimeFormatted: '180 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554',
      ),

      // Filipino Snacks
      Recipe(
        id: 29,
        name: 'Banana Cue',
        description: 'Caramelized banana on stick',
        prepTime: 5,
        cookTime: 10,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 180,
        proteinPerServing: 2,
        carbsPerServing: 38,
        fatPerServing: 4,
        instructions: '''1. Peel 6-8 ripe saba bananas and cut in half lengthwise
2. Heat 1/2 cup brown sugar in a large pan over medium heat
3. Add 2 tablespoons butter and stir until sugar melts
4. Add 1/4 cup water and stir until sugar dissolves
5. Add banana pieces and cook for 3-4 minutes on each side
6. Add 1 teaspoon vanilla extract and stir gently
7. Continue cooking until bananas are caramelized and golden
8. Add 1/4 cup coconut cream and simmer for 2 minutes
9. Serve hot with vanilla ice cream or as is
10. Garnish with toasted coconut flakes if desired''',
        isFilipinoDish: true,
        ingredients: ['saba banana', 'brown sugar', 'oil'],
        tags: ['filipino', 'snack', 'sweet'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'https://example.com/banana-cue.jpg',
      ),
      Recipe(
        id: 30,
        name: 'Kamote Cue',
        description: 'Caramelized sweet potato',
        prepTime: 5,
        cookTime: 10,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 150,
        proteinPerServing: 3,
        carbsPerServing: 32,
        fatPerServing: 1,
        instructions: '''1. Peel and cut 1 kg sweet potatoes into 2-inch chunks
2. Heat 1/2 cup brown sugar in a large pan over medium heat
3. Add 2 tablespoons butter and stir until sugar melts
4. Add 1/4 cup water and stir until sugar dissolves
5. Add sweet potato chunks and cook for 5-6 minutes on each side
6. Add 1 teaspoon cinnamon and 1/2 teaspoon nutmeg
7. Continue cooking until sweet potatoes are caramelized
8. Add 1/4 cup coconut cream and simmer for 3 minutes
9. Serve hot with vanilla ice cream or as is
10. Garnish with toasted coconut flakes and sesame seeds''',
        isFilipinoDish: true,
        ingredients: ['sweet potato', 'brown sugar', 'oil'],
        tags: ['filipino', 'snack', 'healthy'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'https://example.com/kamote-cue.jpg',
      ),
      Recipe(
        id: 31,
        name: 'Turon',
        description: 'Fried banana spring roll',
        prepTime: 10,
        cookTime: 15,
        servings: 6,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 200,
        proteinPerServing: 2,
        carbsPerServing: 35,
        fatPerServing: 7,
        instructions: 'Wrap banana in spring roll wrapper, fry',
        isFilipinoDish: true,
        ingredients: ['saba banana', 'spring roll wrapper', 'brown sugar', 'oil'],
        tags: ['filipino', 'snack', 'sweet'],
        allergens: ['wheat'],
        rating: 4.4,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/turon.jpg',
      ),

      // Healthy Options
      Recipe(
        id: 32,
        name: 'Grilled Bangus',
        description: 'Grilled milkfish with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 250,
        proteinPerServing: 30,
        carbsPerServing: 8,
        fatPerServing: 12,
        instructions: 'Season and grill bangus, serve with vegetables',
        isFilipinoDish: true,
        ingredients: ['bangus', 'lemon', 'garlic', 'vegetables', 'olive oil'],
        tags: ['healthy', 'protein', 'low-carb'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/grilled-bangus.jpg',
      ),
      Recipe(
        id: 33,
        name: 'Ensaladang Talong',
        description: 'Grilled eggplant salad',
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 12,
        fatPerServing: 2,
        instructions: 'Grill eggplant, mix with tomatoes and onions',
        isFilipinoDish: true,
        ingredients: ['eggplant', 'tomatoes', 'onion', 'vinegar', 'salt'],
        tags: ['healthy', 'vegetarian', 'low-calorie'],
        allergens: [],
        rating: 4.1,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ensaladang-talong.jpg',
      ),
      Recipe(
        id: 34,
        name: 'Atchara',
        description: 'Pickled papaya and vegetables',
        prepTime: 20,
        cookTime: 0,
        servings: 8,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 25,
        proteinPerServing: 1,
        carbsPerServing: 6,
        fatPerServing: 0,
        instructions: 'Mix papaya with vinegar, sugar, and spices',
        isFilipinoDish: true,
        ingredients: ['green papaya', 'vinegar', 'sugar', 'ginger', 'carrots'],
        tags: ['healthy', 'vegetarian', 'low-calorie'],
        allergens: [],
        rating: 4.0,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/atchara.jpg',
      ),

      // Additional Healthy Filipino Dishes
      Recipe(
        id: 35,
        name: 'Ginisang Ampalaya',
        description: 'Sautéed bitter gourd with eggs',
        prepTime: 10,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 80,
        proteinPerServing: 6,
        carbsPerServing: 8,
        fatPerServing: 3,
        instructions: 'Sauté bitter gourd with garlic and onions, add beaten eggs',
        isFilipinoDish: true,
        ingredients: ['bitter gourd', 'eggs', 'garlic', 'onion', 'fish sauce', 'oil'],
        tags: ['healthy', 'low-calorie', 'vegetarian option', 'bitter melon'],
        allergens: ['egg', 'fish'],
        rating: 4.1,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ampalaya.jpg',
      ),
      Recipe(
        id: 36,
        name: 'Chopsuey',
        description: 'Mixed vegetables stir-fry',
        prepTime: 15,
        cookTime: 10,
        servings: 6,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 90,
        proteinPerServing: 4,
        carbsPerServing: 12,
        fatPerServing: 3,
        instructions: 'Stir-fry mixed vegetables with light sauce',
        isFilipinoDish: true,
        ingredients: ['mixed vegetables', 'garlic', 'onion', 'soy sauce', 'cornstarch', 'oil'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'mixed vegetables'],
        allergens: ['soy'],
        rating: 4.2,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/chopsuey.jpg',
      ),
      Recipe(
        id: 37,
        name: 'Kinilaw na Isda',
        description: 'Raw fish ceviche with vinegar and spices',
        prepTime: 20,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 120,
        proteinPerServing: 20,
        carbsPerServing: 5,
        fatPerServing: 2,
        instructions: 'Marinate raw fish in vinegar with ginger, onions, and chili',
        isFilipinoDish: true,
        ingredients: ['fresh fish', 'vinegar', 'ginger', 'onion', 'chili', 'salt'],
        tags: ['healthy', 'raw', 'protein', 'low-carb', 'fresh'],
        allergens: ['fish'],
        rating: 4.3,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/kinilaw.jpg',
      ),
      Recipe(
        id: 38,
        name: 'Grilled Tilapia',
        description: 'Simple grilled fish with lemon and herbs',
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 180,
        proteinPerServing: 35,
        carbsPerServing: 2,
        fatPerServing: 4,
        instructions: 'Season fish with lemon, herbs, and grill until cooked',
        isFilipinoDish: true,
        ingredients: ['tilapia', 'lemon', 'garlic', 'herbs', 'salt', 'pepper'],
        tags: ['healthy', 'grilled', 'protein', 'low-carb', 'lean'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/grilled-tilapia.jpg',
      ),
      Recipe(
        id: 39,
        name: 'Steamed Lapu-Lapu',
        description: 'Steamed grouper fish with ginger and soy sauce',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 160,
        proteinPerServing: 32,
        carbsPerServing: 3,
        fatPerServing: 2,
        instructions: 'Steam fish with ginger, garlic, and light soy sauce',
        isFilipinoDish: true,
        ingredients: ['lapu-lapu', 'ginger', 'garlic', 'light soy sauce', 'spring onions'],
        tags: ['healthy', 'steamed', 'protein', 'low-fat', 'lean'],
        allergens: ['fish', 'soy'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/steamed-lapu-lapu.jpg',
      ),
      Recipe(
        id: 40,
        name: 'Adobong Kangkong',
        description: 'Water spinach cooked in vinegar and soy sauce',
        prepTime: 10,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 45,
        proteinPerServing: 3,
        carbsPerServing: 6,
        fatPerServing: 1,
        instructions: 'Sauté water spinach with garlic, vinegar, and soy sauce',
        isFilipinoDish: true,
        ingredients: ['kangkong', 'garlic', 'vinegar', 'soy sauce', 'oil'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'leafy greens'],
        allergens: ['soy'],
        rating: 4.0,
        cookTimeFormatted: '8 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/adobong-kangkong.jpg',
      ),
      Recipe(
        id: 41,
        name: 'Ginisang Togue',
        description: 'Sautéed mung bean sprouts',
        prepTime: 10,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 35,
        proteinPerServing: 3,
        carbsPerServing: 5,
        fatPerServing: 1,
        instructions: 'Sauté bean sprouts with garlic and light seasoning',
        isFilipinoDish: true,
        ingredients: ['mung bean sprouts', 'garlic', 'onion', 'fish sauce', 'oil'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'sprouts'],
        allergens: ['fish'],
        rating: 4.1,
        cookTimeFormatted: '8 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/togue.jpg',
      ),
      Recipe(
        id: 42,
        name: 'Ensaladang Mangga',
        description: 'Green mango salad with tomatoes and onions',
        prepTime: 10,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 40,
        proteinPerServing: 1,
        carbsPerServing: 8,
        fatPerServing: 0,
        instructions: 'Mix green mango, tomatoes, and onions with light dressing',
        isFilipinoDish: true,
        ingredients: ['green mango', 'tomatoes', 'onion', 'vinegar', 'salt'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'fresh', 'salad'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ensaladang-mangga.jpg',
      ),
      Recipe(
        id: 43,
        name: 'Tinolang Isda',
        description: 'Fish soup with vegetables and ginger',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 140,
        proteinPerServing: 22,
        carbsPerServing: 8,
        fatPerServing: 3,
        instructions: 'Boil fish with ginger, vegetables, and light seasoning',
        isFilipinoDish: true,
        ingredients: ['fish', 'ginger', 'vegetables', 'fish sauce', 'onion'],
        tags: ['healthy', 'soup', 'protein', 'low-fat', 'warming'],
        allergens: ['fish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/tinolang-isda.jpg',
      ),
      Recipe(
        id: 44,
        name: 'Ginisang Sayote',
        description: 'Sautéed chayote with shrimp',
        prepTime: 10,
        cookTime: 12,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 60,
        proteinPerServing: 4,
        carbsPerServing: 8,
        fatPerServing: 1,
        instructions: 'Sauté chayote with shrimp and light seasoning',
        isFilipinoDish: true,
        ingredients: ['chayote', 'shrimp', 'garlic', 'onion', 'fish sauce'],
        tags: ['healthy', 'vegetarian option', 'low-calorie', 'chayote'],
        allergens: ['shellfish', 'fish'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/sayote.jpg',
      ),
      Recipe(
        id: 45,
        name: 'Paksiw na Bangus',
        description: 'Milkfish cooked in vinegar and spices',
        prepTime: 10,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 150,
        proteinPerServing: 28,
        carbsPerServing: 5,
        fatPerServing: 3,
        instructions: '''1. Clean and cut 1 kg milkfish into serving pieces
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 6 cloves minced garlic and cook until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add milkfish pieces and cook for 2 minutes on each side
6. Pour in 1 cup vinegar and 1/2 cup water
7. Add 3 tablespoons fish sauce and 1 teaspoon salt
8. Add 1 teaspoon whole peppercorns and 2 bay leaves
9. Bring to a boil, then reduce heat and simmer for 20 minutes
10. Add 1 bunch string beans and 1 eggplant (cut in chunks)
11. Simmer for 10 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'vinegar', 'garlic', 'ginger', 'fish sauce'],
        tags: ['healthy', 'protein', 'low-fat', 'paksiw'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/paksiw-bangus.jpg',
      ),
      Recipe(
        id: 46,
        name: 'Ginisang Upo',
        description: 'Sautéed bottle gourd with shrimp',
        prepTime: 10,
        cookTime: 12,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 50,
        proteinPerServing: 3,
        carbsPerServing: 6,
        fatPerServing: 1,
        instructions: 'Sauté bottle gourd with shrimp and light seasoning',
        isFilipinoDish: true,
        ingredients: ['bottle gourd', 'shrimp', 'garlic', 'onion', 'fish sauce'],
        tags: ['healthy', 'vegetarian option', 'low-calorie', 'gourd'],
        allergens: ['shellfish', 'fish'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/upo.jpg',
      ),
      Recipe(
        id: 47,
        name: 'Ensaladang Talong at Kamatis',
        description: 'Grilled eggplant and tomato salad',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 60,
        proteinPerServing: 2,
        carbsPerServing: 10,
        fatPerServing: 1,
        instructions: 'Grill eggplant, mix with tomatoes and light dressing',
        isFilipinoDish: true,
        ingredients: ['eggplant', 'tomatoes', 'onion', 'vinegar', 'salt'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'grilled', 'salad'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/ensaladang-talong-kamatis.jpg',
      ),
      Recipe(
        id: 48,
        name: 'Sinigang na Hipon',
        description: 'Shrimp sinigang with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 120,
        proteinPerServing: 18,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: '''1. Clean 500g fresh shrimp and remove heads
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 2 large tomatoes (quartered) and cook until soft
5. Pour in 4 cups water and bring to a boil
6. Add 3-4 tablespoons tamarind paste or 1 cup tamarind juice
7. Season with fish sauce, salt, and pepper to taste
8. Add shrimp and simmer for 5 minutes
9. Add 1 bunch kangkong (water spinach) and 1 bunch string beans
10. Add 2-3 pieces green chili peppers
11. Simmer for 3 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['shrimp', 'tamarind', 'vegetables', 'fish sauce', 'onion'],
        tags: ['healthy', 'soup', 'protein', 'low-fat', 'shrimp'],
        allergens: ['shellfish', 'fish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinigang-hipon.jpg',
      ),
      Recipe(
        id: 49,
        name: 'Ginisang Repolyo',
        description: 'Sautéed cabbage with carrots',
        prepTime: 10,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 35,
        proteinPerServing: 2,
        carbsPerServing: 6,
        fatPerServing: 1,
        instructions: 'Sauté cabbage and carrots with garlic',
        isFilipinoDish: true,
        ingredients: ['cabbage', 'carrots', 'garlic', 'onion', 'fish sauce'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'cabbage'],
        allergens: ['fish'],
        rating: 4.0,
        cookTimeFormatted: '8 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/repolyo.jpg',
      ),
      Recipe(
        id: 50,
        name: 'Inihaw na Pusit',
        description: 'Grilled squid with calamansi',
        prepTime: 15,
        cookTime: 10,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 130,
        proteinPerServing: 22,
        carbsPerServing: 3,
        fatPerServing: 2,
        instructions: '''1. Clean 1 kg fresh squid and score the body in a crisscross pattern
2. Marinate squid with 1/4 cup calamansi juice, 2 tablespoons soy sauce, and 1 teaspoon salt
3. Let marinate for 15-20 minutes
4. Heat grill or grill pan over medium-high heat
5. Brush squid with oil and grill for 2-3 minutes on each side
6. Add 4 cloves minced garlic and 1 thumb-sized ginger (sliced)
7. Grill for 1 more minute until squid is cooked through
8. Remove from grill and cut into bite-sized pieces
9. Serve with calamansi wedges and fish sauce dipping sauce
10. Garnish with chopped spring onions and chili peppers
11. Best served immediately while hot and tender''',
        isFilipinoDish: true,
        ingredients: ['squid', 'calamansi', 'garlic', 'salt', 'pepper'],
        tags: ['healthy', 'grilled', 'protein', 'low-carb', 'seafood'],
        allergens: ['shellfish'],
        rating: 4.4,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/inihaw-pusit.jpg',
      ),
      Recipe(
        id: 51,
        name: 'Ginisang Pechay',
        description: 'Sautéed bok choy with garlic',
        prepTime: 8,
        cookTime: 6,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 25,
        proteinPerServing: 2,
        carbsPerServing: 4,
        fatPerServing: 1,
        instructions: 'Sauté bok choy with garlic and light seasoning',
        isFilipinoDish: true,
        ingredients: ['pechay', 'garlic', 'fish sauce', 'oil'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'leafy greens'],
        allergens: ['fish'],
        rating: 4.1,
        cookTimeFormatted: '6 min',
        prepTimeFormatted: '8 min',
        imageUrl: 'https://example.com/pechay.jpg',
      ),
      Recipe(
        id: 52,
        name: 'Steamed Okra',
        description: 'Simple steamed okra with dipping sauce',
        prepTime: 5,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 30,
        proteinPerServing: 2,
        carbsPerServing: 6,
        fatPerServing: 0,
        instructions: '''1. Wash 500g fresh okra and trim the stems
2. Place okra in a steamer basket over boiling water
3. Steam for 8-10 minutes until tender but still firm
4. Remove from steamer and arrange on a serving plate
5. For dipping sauce: mix 1/4 cup fish sauce, 2 tablespoons calamansi juice
6. Add 1 tablespoon brown sugar and 2 cloves minced garlic
7. Add 1 teaspoon vinegar and 1/2 teaspoon chili flakes
8. Mix well and adjust seasoning to taste
9. Serve okra hot with the dipping sauce on the side
10. Garnish with chopped spring onions if desired
11. Best served immediately while hot and tender''',
        isFilipinoDish: true,
        ingredients: ['okra', 'fish sauce', 'vinegar', 'garlic'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'steamed', 'okra'],
        allergens: ['fish'],
        rating: 4.0,
        cookTimeFormatted: '8 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'https://example.com/steamed-okra.jpg',
      ),
      Recipe(
        id: 53,
        name: 'Ginisang Saluyot',
        description: 'Sautéed jute leaves with shrimp',
        prepTime: 10,
        cookTime: 10,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 40,
        proteinPerServing: 3,
        carbsPerServing: 5,
        fatPerServing: 1,
        instructions: 'Sauté jute leaves with shrimp and light seasoning',
        isFilipinoDish: true,
        ingredients: ['saluyot', 'shrimp', 'garlic', 'onion', 'fish sauce'],
        tags: ['healthy', 'vegetarian option', 'low-calorie', 'leafy greens'],
        allergens: ['shellfish', 'fish'],
        rating: 4.1,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/saluyot.jpg',
      ),
      Recipe(
        id: 54,
        name: 'Inihaw na Bangus',
        description: 'Grilled milkfish with tomatoes and onions',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 200,
        proteinPerServing: 30,
        carbsPerServing: 5,
        fatPerServing: 7,
        instructions: '''1. Clean 1 whole milkfish and make a slit along the belly
2. Stuff fish with 2 large tomatoes (sliced) and 1 onion (sliced)
3. Season fish with salt, pepper, and calamansi juice
4. Marinate for 30 minutes
5. Heat grill or grill pan over medium-high heat
6. Brush fish with oil and grill for 6-8 minutes on each side
7. Baste with remaining marinade while grilling
8. Grill until fish is cooked through and skin is crispy
9. Remove from grill and serve hot
10. Garnish with calamansi wedges and chopped spring onions
11. Serve with fish sauce dipping sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'tomatoes', 'onions', 'salt', 'pepper'],
        tags: ['healthy', 'grilled', 'protein', 'low-carb', 'stuffed'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/inihaw-bangus.jpg',
      ),
      Recipe(
        id: 55,
        name: 'Ginisang Kamote Tops',
        description: 'Sautéed sweet potato leaves',
        prepTime: 10,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 30,
        proteinPerServing: 2,
        carbsPerServing: 5,
        fatPerServing: 1,
        instructions: 'Sauté sweet potato leaves with garlic',
        isFilipinoDish: true,
        ingredients: ['kamote tops', 'garlic', 'onion', 'fish sauce', 'oil'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'leafy greens'],
        allergens: ['fish'],
        rating: 4.0,
        cookTimeFormatted: '8 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/kamote-tops.jpg',
      ),
      Recipe(
        id: 56,
        name: 'Sinigang na Bangus',
        description: 'Milkfish sinigang with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 150,
        proteinPerServing: 25,
        carbsPerServing: 8,
        fatPerServing: 3,
        instructions: '''1. Clean and cut 1 kg milkfish into serving pieces
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 2 large tomatoes (quartered) and cook until soft
5. Pour in 6 cups water and bring to a boil
6. Add 3-4 tablespoons tamarind paste or 1 cup tamarind juice
7. Season with fish sauce, salt, and pepper to taste
8. Add milkfish pieces and simmer for 10 minutes
9. Add 1 bunch kangkong (water spinach) and 1 bunch string beans
10. Add 2-3 pieces green chili peppers
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'tamarind', 'vegetables', 'fish sauce', 'onion'],
        tags: ['healthy', 'soup', 'protein', 'low-fat', 'sinigang'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinigang-bangus.jpg',
      ),
      Recipe(
        id: 57,
        name: 'Ginisang Labanos',
        description: 'Sautéed radish with carrots',
        prepTime: 10,
        cookTime: 10,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 35,
        proteinPerServing: 1,
        carbsPerServing: 6,
        fatPerServing: 1,
        instructions: 'Sauté radish and carrots with garlic',
        isFilipinoDish: true,
        ingredients: ['radish', 'carrots', 'garlic', 'onion', 'fish sauce'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'root vegetables'],
        allergens: ['fish'],
        rating: 4.0,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/labanos.jpg',
      ),
      Recipe(
        id: 58,
        name: 'Steamed Lapu-Lapu with Tofu',
        description: 'Steamed grouper with tofu and vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 140,
        proteinPerServing: 25,
        carbsPerServing: 4,
        fatPerServing: 3,
        instructions: 'Steam fish with tofu, vegetables, and light sauce',
        isFilipinoDish: true,
        ingredients: ['lapu-lapu', 'tofu', 'vegetables', 'ginger', 'light soy sauce'],
        tags: ['healthy', 'steamed', 'protein', 'low-fat', 'tofu'],
        allergens: ['fish', 'soy'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/steamed-lapu-lapu-tofu.jpg',
      ),

      // Additional Filipino Recipes with Accurate Nutritional Data
      Recipe(
        id: 59,
        name: 'Pork Adobo',
        description: 'Classic Filipino pork in soy sauce and vinegar',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 310,
        proteinPerServing: 22,
        carbsPerServing: 6,
        fatPerServing: 20,
        instructions: 'Marinate pork, cook in soy sauce and vinegar',
        isFilipinoDish: true,
        ingredients: ['pork', 'soy sauce', 'vinegar', 'garlic', 'bay leaves'],
        tags: ['filipino', 'traditional', 'pork'],
        allergens: ['soy'],
        rating: 4.8,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/pork-adobo.jpg',
      ),
      Recipe(
        id: 60,
        name: 'Adobong Sitaw',
        description: 'String beans cooked in adobo style',
        prepTime: 10,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 180,
        proteinPerServing: 7,
        carbsPerServing: 10,
        fatPerServing: 12,
        instructions: '''1. Wash and trim 500g string beans, cut into 2-inch pieces
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add string beans and stir-fry for 3-4 minutes
6. Add 3 tablespoons soy sauce and 2 tablespoons vinegar
7. Add 1 tablespoon brown sugar and 1/2 cup water
8. Season with salt and pepper to taste
9. Simmer for 5-7 minutes until beans are tender-crisp
10. Add 1 tablespoon sesame oil and toss well
11. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['string beans', 'soy sauce', 'vinegar', 'garlic', 'oil'],
        tags: ['healthy', 'vegetarian', 'low-calorie'],
        allergens: ['soy'],
        rating: 4.2,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/adobong-sitaw.jpg',
      ),
      Recipe(
        id: 61,
        name: 'Pares (Beef Stew)',
        description: 'Tender beef stew with soy sauce and spices',
        prepTime: 20,
        cookTime: 90,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 400,
        proteinPerServing: 25,
        carbsPerServing: 20,
        fatPerServing: 22,
        instructions: '''1. Cut 1 kg beef into 2-inch cubes and season with salt and pepper
2. Heat 3 tablespoons oil in a large pot over medium-high heat
3. Brown beef cubes on all sides for 5-7 minutes, then remove from pot
4. In the same pot, sauté 1 chopped onion until translucent
5. Add 6 cloves minced garlic and 1 thumb-sized ginger (sliced)
6. Add 2 bay leaves and 1 teaspoon whole peppercorns
7. Return beef to pot and add 1/2 cup soy sauce
8. Pour in 4 cups water and bring to a boil
9. Reduce heat and simmer for 1.5-2 hours until beef is tender
10. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
11. Simmer for 20 more minutes until vegetables are tender
12. Season with fish sauce, salt, and pepper to taste
13. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['beef', 'soy sauce', 'garlic', 'onion', 'star anise'],
        tags: ['filipino', 'stew', 'comfort food'],
        allergens: ['soy'],
        rating: 4.6,
        cookTimeFormatted: '90 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/pares.jpg',
      ),
      Recipe(
        id: 62,
        name: 'Tinola',
        description: 'Filipino chicken soup with ginger and vegetables',
        prepTime: 15,
        cookTime: 30,
        servings: 6,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 180,
        proteinPerServing: 22,
        carbsPerServing: 6,
        fatPerServing: 6,
        instructions: '''1. Cut 1 whole chicken into serving pieces and rinse well
2. In a large pot, heat 2 tablespoons oil and sauté 1 thumb-sized ginger (sliced) until fragrant
3. Add 1 chopped onion and 4 cloves minced garlic, cook until golden
4. Add chicken pieces and brown on all sides for 5 minutes
5. Pour in 6 cups water and bring to a boil
6. Skim off any foam, then reduce heat and simmer for 30 minutes
7. Add 2 chayote (sayote) cut into wedges and 2 green papaya chunks
8. Season with fish sauce, salt, and pepper to taste
9. Add 1 bunch malunggay leaves and 2-3 chili leaves
10. Simmer for another 10 minutes until vegetables are tender
11. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'ginger', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'healthy', 'warming'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/tinola.jpg',
      ),
      Recipe(
        id: 63,
        name: 'Kaldereta',
        description: 'Beef stew with tomato sauce and vegetables',
        prepTime: 20,
        cookTime: 60,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 400,
        proteinPerServing: 25,
        carbsPerServing: 14,
        fatPerServing: 22,
        instructions: '''1. Cut 1 kg beef into 2-inch cubes and season with salt and pepper
2. Heat 3 tablespoons oil in a large pot over medium-high heat
3. Brown beef cubes on all sides for 5-7 minutes, then remove from pot
4. In the same pot, sauté 1 chopped onion until translucent
5. Add 4 cloves minced garlic and cook until fragrant
6. Add 2 large tomatoes (quartered) and cook until soft
7. Return beef to pot and add 1 can tomato sauce
8. Pour in 1 cup water and bring to a boil
9. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
10. Season with fish sauce, salt, pepper, and a pinch of sugar
11. Simmer for 1.5-2 hours until beef is tender
12. Add 1 bell pepper (sliced) and simmer for 5 more minutes
13. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['beef', 'tomato sauce', 'potatoes', 'carrots', 'bell peppers'],
        tags: ['filipino', 'stew', 'special occasion'],
        allergens: [],
        rating: 4.7,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/kaldereta.jpg',
      ),
      Recipe(
        id: 64,
        name: 'Menudo',
        description: 'Pork and liver stew with vegetables',
        prepTime: 20,
        cookTime: 45,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 350,
        proteinPerServing: 22,
        carbsPerServing: 18,
        fatPerServing: 18,
        instructions: '''1. Cut 500g pork into 1-inch cubes and 300g liver into thin slices
2. Heat 3 tablespoons oil in a large pot over medium-high heat
3. Brown pork cubes for 5-7 minutes, then remove from pot
4. In the same pot, sauté 1 chopped onion until translucent
5. Add 4 cloves minced garlic and cook until fragrant
6. Add liver slices and cook for 3-4 minutes
7. Return pork to pot and add 1 can tomato sauce
8. Pour in 1 cup water and bring to a boil
9. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
10. Season with fish sauce, salt, pepper, and a pinch of sugar
11. Simmer for 30-40 minutes until pork is tender
12. Add 1 bell pepper (sliced) and simmer for 5 more minutes
13. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['pork', 'liver', 'potatoes', 'carrots', 'tomato sauce'],
        tags: ['filipino', 'stew', 'special occasion'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/menudo.jpg',
      ),
      Recipe(
        id: 65,
        name: 'Afritada',
        description: 'Chicken stew with potatoes and carrots',
        prepTime: 15,
        cookTime: 40,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 20,
        carbsPerServing: 15,
        fatPerServing: 18,
        instructions: '''1. Cut 1 kg chicken into serving pieces and season with salt and pepper
2. Heat 3 tablespoons oil in a large pan over medium-high heat
3. Brown chicken pieces on all sides for 5-7 minutes, then remove from pan
4. In the same pan, sauté 1 chopped onion until translucent
5. Add 4 cloves minced garlic and cook until fragrant
6. Add 2 large tomatoes (quartered) and cook until soft
7. Return chicken to pan and add 1 can tomato sauce
8. Pour in 1 cup water and bring to a boil
9. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
10. Season with fish sauce, salt, pepper, and a pinch of sugar
11. Simmer for 25-30 minutes until chicken is tender
12. Add 1 bell pepper (sliced) and simmer for 5 more minutes
13. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'tomato sauce', 'potatoes', 'carrots', 'bell peppers'],
        tags: ['filipino', 'stew', 'comfort food'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '40 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/afritada.jpg',
      ),
      Recipe(
        id: 66,
        name: 'Ginataang Langka',
        description: 'Jackfruit in coconut milk',
        prepTime: 15,
        cookTime: 25,
        servings: 6,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 250,
        proteinPerServing: 6,
        carbsPerServing: 18,
        fatPerServing: 18,
        instructions: '''1. Cut 1 kg young jackfruit into bite-sized pieces
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add jackfruit pieces and cook for 5 minutes
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 tablespoon shrimp paste (bagoong) and mix well
9. Simmer for 20-25 minutes until jackfruit is tender
10. Add 1/2 cup coconut cream and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['jackfruit', 'coconut milk', 'garlic', 'onion', 'chili'],
        tags: ['filipino', 'vegetarian', 'coconut milk'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/ginataang-langka.jpg',
      ),
      Recipe(
        id: 67,
        name: 'Lumpiang Shanghai',
        description: 'Filipino spring rolls with pork filling',
        prepTime: 30,
        cookTime: 15,
        servings: 8,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 310,
        proteinPerServing: 14,
        carbsPerServing: 10,
        fatPerServing: 22,
        instructions: '''1. Cook 300g ground pork in a pan until browned
2. Add 1 chopped onion and 4 cloves minced garlic, cook until fragrant
3. Add 1 cup shredded carrots and 1 cup shredded cabbage
4. Season with soy sauce, salt, and pepper
5. Cook for 5 minutes until vegetables are tender
6. Let filling cool completely
7. Place spring roll wrapper on a flat surface
8. Add 2 tablespoons filling near one edge
9. Fold sides inward and roll tightly
10. Seal edge with water or egg wash
11. Heat oil in a deep pan to 350°F (175°C)
12. Fry spring rolls for 3-4 minutes until golden brown
13. Drain on paper towels and serve hot with sweet and sour sauce''',
        isFilipinoDish: true,
        ingredients: ['pork', 'spring roll wrapper', 'carrots', 'onion', 'garlic'],
        tags: ['filipino', 'appetizer', 'fried'],
        allergens: ['wheat'],
        rating: 4.6,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/lumpiang-shanghai.jpg',
      ),
      Recipe(
        id: 68,
        name: 'Bulalo',
        description: 'Beef shank soup with vegetables',
        prepTime: 30,
        cookTime: 180,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 450,
        proteinPerServing: 28,
        carbsPerServing: 5,
        fatPerServing: 32,
        instructions: 'Boil beef shank until tender, add vegetables',
        isFilipinoDish: true,
        ingredients: ['beef shank', 'corn', 'cabbage', 'fish sauce', 'pepper'],
        tags: ['filipino', 'soup', 'special occasion'],
        allergens: ['fish'],
        rating: 4.9,
        cookTimeFormatted: '180 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/bulalo.jpg',
      ),
      Recipe(
        id: 69,
        name: 'Pochero',
        description: 'Beef and vegetable stew',
        prepTime: 20,
        cookTime: 60,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 22,
        carbsPerServing: 20,
        fatPerServing: 22,
        instructions: '''1. Cut 1 kg beef into 2-inch cubes and season with salt and pepper
2. Heat 3 tablespoons oil in a large pot over medium-high heat
3. Brown beef cubes on all sides for 5-7 minutes, then remove from pot
4. In the same pot, sauté 1 chopped onion until translucent
5. Add 4 cloves minced garlic and cook until fragrant
6. Add 2 large tomatoes (quartered) and cook until soft
7. Return beef to pot and add 1 can tomato sauce
8. Pour in 1 cup water and bring to a boil
9. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
10. Season with fish sauce, salt, pepper, and a pinch of sugar
11. Simmer for 1.5-2 hours until beef is tender
12. Add 1 small cabbage (quartered) and simmer for 10 more minutes
13. Serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['beef', 'tomato sauce', 'potatoes', 'carrots', 'cabbage'],
        tags: ['filipino', 'stew', 'comfort food'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/pochero.jpg',
      ),
      Recipe(
        id: 70,
        name: 'Bistek Tagalog',
        description: 'Filipino beef steak with onions',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 310,
        proteinPerServing: 25,
        carbsPerServing: 6,
        fatPerServing: 18,
        instructions: 'Marinate beef, cook with onions and soy sauce',
        isFilipinoDish: true,
        ingredients: ['beef', 'onions', 'soy sauce', 'lemon', 'garlic'],
        tags: ['filipino', 'steak', 'quick'],
        allergens: ['soy'],
        rating: 4.6,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/bistek-tagalog.jpg',
      ),
      Recipe(
        id: 71,
        name: 'Arroz Caldo',
        description: 'Filipino rice porridge with chicken',
        prepTime: 10,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 230,
        proteinPerServing: 14,
        carbsPerServing: 35,
        fatPerServing: 4,
        instructions: '''1. Rinse 2 cups jasmine rice until water runs clear
2. Cut 500g chicken into bite-sized pieces and season with salt and pepper
3. Heat 3 tablespoons oil in a large pot and sauté 1 chopped onion
4. Add 4 cloves minced garlic and cook until golden
5. Add chicken pieces and cook until lightly browned
6. Add 1 tablespoon grated ginger and 2 bay leaves
7. Add rice and stir for 2 minutes
8. Pour in 4 cups chicken broth and bring to a boil
9. Reduce heat to low, cover and simmer for 20-25 minutes
10. Season with fish sauce, salt, and pepper to taste
11. Fluff rice with a fork and serve hot
12. Garnish with chopped spring onions and fried garlic''',
        isFilipinoDish: true,
        ingredients: ['rice', 'chicken', 'chicken broth', 'ginger', 'garlic'],
        tags: ['filipino', 'porridge', 'comfort food'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/arroz-caldo.jpg',
      ),
      Recipe(
        id: 72,
        name: 'Tocilog',
        description: 'Tocino, Sinangag, at Itlog - Sweet cured pork with garlic rice and egg',
        prepTime: 10,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 450,
        proteinPerServing: 25,
        carbsPerServing: 20,
        fatPerServing: 28,
        instructions: 'Cook tocino, garlic rice, and fried egg',
        isFilipinoDish: true,
        ingredients: ['tocino', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['soy', 'egg'],
        rating: 4.7,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/tocilog.jpg',
      ),
      Recipe(
        id: 73,
        name: 'Longsilog',
        description: 'Longganisa, Sinangag, at Itlog - Filipino sausage with garlic rice and egg',
        prepTime: 10,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 480,
        proteinPerServing: 24,
        carbsPerServing: 22,
        fatPerServing: 32,
        instructions: 'Cook longganisa, garlic rice, and fried egg',
        isFilipinoDish: true,
        ingredients: ['longganisa', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['soy', 'egg'],
        rating: 4.8,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/longsilog.jpg',
      ),
      Recipe(
        id: 74,
        name: 'Lechon (Roast Pork)',
        description: 'Traditional Filipino roasted whole pig',
        prepTime: 60,
        cookTime: 300,
        servings: 20,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 700,
        proteinPerServing: 45,
        carbsPerServing: 10,
        fatPerServing: 50,
        instructions: '''1. Clean and prepare 1 whole pig (lechon)
2. Make diagonal cuts on the skin side
3. Season pig with salt, pepper, and calamansi juice
4. Stuff cavity with lemongrass, bay leaves, and garlic
5. Sew the cavity closed with kitchen twine
6. Place pig on a rotisserie or roasting rack
7. Roast over charcoal for 4-6 hours, turning occasionally
8. Baste with oil and seasonings while roasting
9. Roast until skin is golden brown and crispy
10. Remove from heat and let rest for 30 minutes
11. Carve and serve hot with steamed rice
12. Serve with lechon sauce and calamansi wedges''',
        isFilipinoDish: true,
        ingredients: ['whole pig', 'salt', 'pepper', 'garlic', 'lemongrass'],
        tags: ['filipino', 'special occasion', 'roasted'],
        allergens: [],
        rating: 4.9,
        cookTimeFormatted: '300 min',
        prepTimeFormatted: '60 min',
        imageUrl: 'https://example.com/lechon.jpg',
      ),
      Recipe(
        id: 75,
        name: 'La Paz Batchoy',
        description: 'Filipino noodle soup with pork and liver',
        prepTime: 20,
        cookTime: 30,
        servings: 4,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 430,
        proteinPerServing: 18,
        carbsPerServing: 50,
        fatPerServing: 16,
        instructions: 'Cook noodles with pork, liver, and rich broth',
        isFilipinoDish: true,
        ingredients: ['noodles', 'pork', 'liver', 'broth', 'garlic'],
        tags: ['filipino', 'noodle soup', 'comfort food'],
        allergens: ['wheat'],
        rating: 4.7,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/la-paz-batchoy.jpg',
      ),
      Recipe(
        id: 76,
        name: 'Pancit Malabon',
        description: 'Filipino noodle dish with seafood and thick sauce',
        prepTime: 20,
        cookTime: 25,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 400,
        proteinPerServing: 15,
        carbsPerServing: 48,
        fatPerServing: 16,
        instructions: '''1. Soak 500g thick noodles in warm water for 10 minutes, then drain
2. Clean 200g shrimp and 200g squid, cut squid into rings
3. Heat 3 tablespoons oil in a large wok over high heat
4. Sauté 1 chopped onion and 4 cloves minced garlic until fragrant
5. Add shrimp and squid, cook for 2-3 minutes
6. Add 1 cup sliced carrots and 2 cups shredded cabbage
7. Stir-fry for 3-4 minutes until vegetables are tender-crisp
8. Add the soaked noodles and 3 tablespoons soy sauce
9. Add 1/4 cup oyster sauce and 2 tablespoons cornstarch mixed with water
10. Toss everything together for 2-3 minutes until sauce thickens
11. Season with salt, pepper, and a pinch of sugar
12. Garnish with chopped spring onions and serve hot with calamansi wedges''',
        isFilipinoDish: true,
        ingredients: ['noodles', 'seafood', 'shrimp', 'squid', 'thick sauce'],
        tags: ['filipino', 'noodles', 'seafood'],
        allergens: ['shellfish', 'wheat'],
        rating: 4.6,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/pancit-malabon.jpg',
      ),
      Recipe(
        id: 77,
        name: 'Pancit Palabok',
        description: 'Filipino noodle dish with shrimp sauce and toppings',
        prepTime: 20,
        cookTime: 25,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 370,
        proteinPerServing: 16,
        carbsPerServing: 46,
        fatPerServing: 14,
        instructions: '''1. Soak 500g thick noodles in warm water for 10 minutes, then drain
2. Cook 200g shrimp and 200g pork belly, cut into bite-sized pieces
3. Heat 3 tablespoons oil in a large wok over high heat
4. Sauté 1 chopped onion and 4 cloves minced garlic until fragrant
5. Add pork and shrimp, cook for 3-4 minutes
6. Add 1 cup sliced carrots and 2 cups shredded cabbage
7. Stir-fry for 3-4 minutes until vegetables are tender-crisp
8. Add the soaked noodles and 1/4 cup shrimp sauce
9. Add 3 tablespoons soy sauce and 2 tablespoons oyster sauce
10. Toss everything together for 2-3 minutes until well combined
11. Season with salt, pepper, and a pinch of sugar
12. Top with hard-boiled eggs, chicharon, and spring onions
13. Serve hot with calamansi wedges and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['noodles', 'shrimp sauce', 'shrimp', 'pork', 'toppings'],
        tags: ['filipino', 'noodles', 'seafood'],
        allergens: ['shellfish', 'wheat'],
        rating: 4.5,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/pancit-palabok.jpg',
      ),
      Recipe(
        id: 78,
        name: 'Monggo Guisado',
        description: 'Sautéed mung beans with vegetables and meat',
        prepTime: 10,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 280,
        proteinPerServing: 14,
        carbsPerServing: 20,
        fatPerServing: 12,
        instructions: '''1. Soak 1 cup mung beans in water for 30 minutes, then drain
2. Cut 300g pork into small cubes
3. Heat 3 tablespoons oil in a large pot over medium heat
4. Sauté 1 chopped onion and 4 cloves minced garlic until golden
5. Add pork cubes and cook until lightly browned
6. Add mung beans and 4 cups water, bring to a boil
7. Reduce heat and simmer for 30-40 minutes until beans are tender
8. Add 1 cup sliced carrots and 1 cup sliced cabbage
9. Season with fish sauce, salt, and pepper
10. Add 1 bunch malunggay leaves and 2-3 pieces green chili peppers
11. Simmer for 10 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['mung beans', 'vegetables', 'pork', 'garlic', 'onion'],
        tags: ['filipino', 'vegetarian option', 'healthy'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/monggo-guisado.jpg',
      ),
      Recipe(
        id: 79,
        name: 'Nilaga na Baka',
        description: 'Boiled beef with vegetables',
        prepTime: 15,
        cookTime: 60,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 350,
        proteinPerServing: 28,
        carbsPerServing: 15,
        fatPerServing: 18,
        instructions: '''1. Cut 1 kg beef into 2-inch cubes and rinse under cold water
2. In a large pot, place beef with 8 cups water, 2 bay leaves, and 1 tsp salt
3. Bring to a boil, then reduce heat and simmer for 1.5-2 hours until beef is tender
4. Skim off any foam that rises to the surface during cooking
5. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
6. Continue simmering for 15 minutes
7. Add 1 small cabbage (quartered) and 1 bunch bok choy
8. Season with fish sauce, salt, and pepper to taste
9. Simmer for another 5-10 minutes until vegetables are tender
10. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['beef', 'potatoes', 'carrots', 'cabbage', 'onion'],
        tags: ['filipino', 'soup', 'comfort food'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/nilaga-baka.jpg',
      ),
      Recipe(
        id: 80,
        name: 'Nilagang Baboy',
        description: 'Boiled pork with vegetables',
        prepTime: 15,
        cookTime: 45,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 26,
        carbsPerServing: 14,
        fatPerServing: 16,
        instructions: 'Boil pork until tender, add vegetables',
        isFilipinoDish: true,
        ingredients: ['pork', 'potatoes', 'carrots', 'cabbage', 'onion'],
        tags: ['filipino', 'soup', 'comfort food'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/nilaga-baboy.jpg',
      ),
      Recipe(
        id: 81,
        name: 'Lomi',
        description: 'Filipino thick noodle soup',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 420,
        proteinPerServing: 20,
        carbsPerServing: 35,
        fatPerServing: 22,
        instructions: '''1. Soak 500g thick noodles in warm water for 10 minutes, then drain
2. Cut 400g pork into thin strips and season with salt and pepper
3. Heat 3 tablespoons oil in a large pot over medium heat
4. Sauté 1 chopped onion and 6 cloves minced garlic until golden
5. Add pork strips and cook until lightly browned
6. Add 4 cups chicken broth and bring to a boil
7. Add 1 cup sliced carrots and 2 cups shredded cabbage
8. Season with fish sauce, salt, and pepper
9. Simmer for 15-20 minutes until pork is tender
10. Add the soaked noodles and cook for 5 more minutes
11. Add 1 bunch malunggay leaves and 2-3 pieces green chili peppers
12. Serve hot with calamansi wedges and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['thick noodles', 'pork', 'vegetables', 'broth', 'garlic'],
        tags: ['filipino', 'noodle soup', 'comfort food'],
        allergens: ['wheat'],
        rating: 4.6,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/lomi.jpg',
      ),
      Recipe(
        id: 82,
        name: 'Mami (Chicken Noodle)',
        description: 'Filipino chicken noodle soup',
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 300,
        proteinPerServing: 16,
        carbsPerServing: 28,
        fatPerServing: 12,
        instructions: '''1. Soak 500g noodles in warm water for 10 minutes, then drain
2. Cut 400g chicken into bite-sized pieces and season with salt and pepper
3. Heat 3 tablespoons oil in a large pot over medium heat
4. Sauté 1 chopped onion and 4 cloves minced garlic until golden
5. Add chicken pieces and cook until lightly browned
6. Add 4 cups chicken broth and bring to a boil
7. Add 1 cup sliced carrots and 2 cups shredded cabbage
8. Season with fish sauce, salt, and pepper
9. Simmer for 15-20 minutes until chicken is tender
10. Add the soaked noodles and cook for 5 more minutes
11. Add 1 bunch malunggay leaves and 2-3 pieces green chili peppers
12. Serve hot with calamansi wedges and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['noodles', 'chicken', 'vegetables', 'broth', 'garlic'],
        tags: ['filipino', 'noodle soup', 'comfort food'],
        allergens: ['wheat'],
        rating: 4.4,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/mami.jpg',
      ),
      Recipe(
        id: 83,
        name: 'Suam na Mais',
        description: 'Filipino corn soup',
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 210,
        proteinPerServing: 12,
        carbsPerServing: 18,
        fatPerServing: 8,
        instructions: '''1. Cut 4 ears of corn into 2-inch pieces
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add corn pieces and cook for 3-4 minutes
5. Add 4 cups vegetable broth and bring to a boil
6. Add 1 cup sliced carrots and 1 cup sliced cabbage
7. Season with fish sauce, salt, and pepper
8. Simmer for 15-20 minutes until vegetables are tender
9. Add 1 bunch malunggay leaves and 2-3 pieces green chili peppers
10. Simmer for 5 more minutes
11. Serve hot with steamed rice and fish sauce on the side
12. Garnish with chopped spring onions if desired''',
        isFilipinoDish: true,
        ingredients: ['corn', 'vegetables', 'broth', 'garlic', 'onion'],
        tags: ['filipino', 'soup', 'vegetarian option'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/suam-na-mais.jpg',
      ),
      Recipe(
        id: 84,
        name: 'Ginataang Kalabasa',
        description: 'Squash in coconut milk',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 270,
        proteinPerServing: 10,
        carbsPerServing: 16,
        fatPerServing: 20,
        instructions: '''1. Cut 1 kg squash into bite-sized pieces
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add squash pieces and cook for 5 minutes
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 tablespoon shrimp paste (bagoong) and mix well
9. Simmer for 20-25 minutes until squash is tender
10. Add 1/2 cup coconut cream and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['squash', 'coconut milk', 'garlic', 'onion', 'chili'],
        tags: ['filipino', 'vegetarian', 'coconut milk'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/ginataang-kalabasa.jpg',
      ),
      Recipe(
        id: 85,
        name: 'Inihaw na Liempo',
        description: 'Grilled pork belly',
        prepTime: 20,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 25,
        carbsPerServing: 5,
        fatPerServing: 42,
        instructions: '''1. Cut 1 kg pork belly into 1-inch thick slices
2. Make diagonal cuts on the skin side
3. Marinate pork with 1/4 cup soy sauce, 1/4 cup calamansi juice, and 1 teaspoon salt
4. Add 6 cloves minced garlic and 1 teaspoon ground pepper
5. Let marinate for 2-4 hours or overnight
6. Heat grill or grill pan over medium-high heat
7. Brush pork with oil and grill for 8-10 minutes on each side
8. Baste with remaining marinade while grilling
9. Grill until pork is cooked through and skin is crispy
10. Remove from grill and let rest for 5 minutes
11. Slice and serve hot with steamed rice
12. Serve with fish sauce dipping sauce and calamansi wedges''',
        isFilipinoDish: true,
        ingredients: ['pork belly', 'soy sauce', 'garlic', 'lemon', 'pepper'],
        tags: ['filipino', 'grilled', 'pork'],
        allergens: ['soy'],
        rating: 4.7,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/inihaw-liempo.jpg',
      ),
      Recipe(
        id: 86,
        name: 'Inihaw na Bangus',
        description: 'Grilled milkfish',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 350,
        proteinPerServing: 30,
        carbsPerServing: 4,
        fatPerServing: 22,
        instructions: '''1. Clean 1 whole milkfish and make diagonal cuts on both sides
2. Marinate fish with 1/4 cup calamansi juice, 2 tablespoons soy sauce, and 1 teaspoon salt
3. Add 4 cloves minced garlic and 1 thumb-sized ginger (sliced)
4. Let marinate for 30 minutes
5. Heat grill or grill pan over medium-high heat
6. Brush fish with oil and grill for 5-6 minutes on each side
7. Baste with remaining marinade while grilling
8. Grill until fish is cooked through and skin is crispy
9. Remove from grill and serve hot
10. Garnish with calamansi wedges and chopped spring onions
11. Serve with fish sauce dipping sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'salt', 'pepper', 'lemon', 'garlic'],
        tags: ['filipino', 'grilled', 'fish'],
        allergens: ['fish'],
        rating: 4.6,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/inihaw-bangus.jpg',
      ),
      Recipe(
        id: 87,
        name: 'Inihaw na Manok',
        description: 'Grilled chicken',
        prepTime: 20,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 280,
        proteinPerServing: 25,
        carbsPerServing: 6,
        fatPerServing: 16,
        instructions: '''1. Cut 1 kg chicken into serving pieces
2. Make diagonal cuts on the skin side
3. Marinate chicken with 1/4 cup soy sauce, 1/4 cup calamansi juice, and 1 teaspoon salt
4. Add 6 cloves minced garlic and 1 teaspoon ground pepper
5. Let marinate for 2-4 hours or overnight
6. Heat grill or grill pan over medium-high heat
7. Brush chicken with oil and grill for 6-8 minutes on each side
8. Baste with remaining marinade while grilling
9. Grill until chicken is cooked through and skin is crispy
10. Remove from grill and let rest for 5 minutes
11. Serve hot with steamed rice
12. Serve with fish sauce dipping sauce and calamansi wedges''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'soy sauce', 'garlic', 'lemon', 'pepper'],
        tags: ['filipino', 'grilled', 'chicken'],
        allergens: ['soy'],
        rating: 4.5,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/inihaw-manok.jpg',
      ),
      Recipe(
        id: 88,
        name: 'Pritong Tilapia',
        description: 'Fried tilapia fish',
        prepTime: 10,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 300,
        proteinPerServing: 28,
        carbsPerServing: 0,
        fatPerServing: 20,
        instructions: '''1. Clean 4 whole tilapia and make diagonal cuts on both sides
2. Season fish with salt, pepper, and calamansi juice
3. Let marinate for 15-20 minutes
4. Dredge fish in flour, shaking off excess
5. Heat oil in a large pan to 350°F (175°C)
6. Carefully lower fish into hot oil
7. Fry for 5-6 minutes on each side until golden brown
8. Remove from oil and drain on paper towels
9. Serve hot with steamed rice
10. Serve with fish sauce dipping sauce and calamansi wedges
11. Garnish with chopped spring onions if desired
12. Best served immediately while hot and crispy''',
        isFilipinoDish: true,
        ingredients: ['tilapia', 'salt', 'pepper', 'flour', 'oil'],
        tags: ['filipino', 'fried', 'fish'],
        allergens: ['fish', 'wheat'],
        rating: 4.4,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/pritong-tilapia.jpg',
      ),
      Recipe(
        id: 89,
        name: 'Daing na Bangus',
        description: 'Dried and fried milkfish',
        prepTime: 10,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 26,
        carbsPerServing: 1,
        fatPerServing: 22,
        instructions: '''1. Clean 2 pieces dried milkfish and pat dry
2. Heat oil in a large pan over medium heat
3. Carefully lower dried milkfish into hot oil
4. Fry for 3-4 minutes on each side until crispy
5. Remove from oil and drain on paper towels
6. In a separate pan, sauté 4 cloves minced garlic until golden
7. Add 2 tablespoons vinegar and 1 tablespoon soy sauce
8. Add 1 teaspoon sugar and mix well
9. Pour sauce over fried milkfish
10. Serve hot with steamed rice
11. Serve with fish sauce dipping sauce and calamansi wedges
12. Best served immediately while hot and crispy''',
        isFilipinoDish: true,
        ingredients: ['dried bangus', 'oil', 'garlic', 'vinegar'],
        tags: ['filipino', 'fried', 'fish'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/daing-bangus.jpg',
      ),
      Recipe(
        id: 90,
        name: 'Escabeche',
        description: 'Sweet and sour fish',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 310,
        proteinPerServing: 22,
        carbsPerServing: 10,
        fatPerServing: 18,
        instructions: '''1. Clean and cut 1 kg fish into serving pieces
2. Season fish with salt, pepper, and calamansi juice
3. Dredge fish in flour, shaking off excess
4. Heat oil in a large pan to 350°F (175°C)
5. Fry fish for 5-6 minutes on each side until golden brown
6. Remove from oil and drain on paper towels
7. For sweet and sour sauce: heat 2 tablespoons oil in a pan
8. Sauté 1 chopped onion and 2 cloves minced garlic
9. Add 1 cup vinegar, 1/2 cup sugar, and 2 tablespoons soy sauce
10. Add 1 cup sliced bell peppers and 1 cup sliced carrots
11. Simmer for 5 minutes until vegetables are tender
12. Pour sauce over fried fish and serve hot with steamed rice''',
        isFilipinoDish: true,
        ingredients: ['fish', 'vinegar', 'sugar', 'vegetables', 'ginger'],
        tags: ['filipino', 'sweet and sour', 'fish'],
        allergens: ['fish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/escabeche.jpg',
      ),
      Recipe(
        id: 91,
        name: 'Ginataang Hipon',
        description: 'Shrimp in coconut milk',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 25,
        carbsPerServing: 10,
        fatPerServing: 26,
        instructions: '''1. Clean 500g fresh shrimp and remove heads
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add shrimp and cook for 2-3 minutes
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 15-20 minutes until shrimp is cooked
10. Add 1/2 cup coconut cream and 1 bunch malunggay leaves
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['shrimp', 'coconut milk', 'vegetables', 'garlic', 'onion'],
        tags: ['filipino', 'seafood', 'coconut milk'],
        allergens: ['shellfish'],
        rating: 4.6,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/ginataang-hipon.jpg',
      ),
      Recipe(
        id: 92,
        name: 'Tinolang Tahong',
        description: 'Mussel soup with ginger',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 210,
        proteinPerServing: 18,
        carbsPerServing: 6,
        fatPerServing: 8,
        instructions: '''1. Clean 1 kg fresh mussels and remove beards
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add mussels and cook for 2-3 minutes
6. Pour in 4 cups water and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 10-15 minutes until mussels open
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Discard any mussels that don't open
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['mussels', 'ginger', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'seafood'],
        allergens: ['shellfish', 'fish'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/tinolang-tahong.jpg',
      ),
      Recipe(
        id: 93,
        name: 'Sinigang na Bangus',
        description: 'Milkfish sinigang with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 280,
        proteinPerServing: 24,
        carbsPerServing: 10,
        fatPerServing: 12,
        instructions: '''1. Clean and cut 1 kg milkfish into serving pieces
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 2 large tomatoes (quartered) and cook until soft
5. Pour in 6 cups water and bring to a boil
6. Add 3-4 tablespoons tamarind paste or 1 cup tamarind juice
7. Season with fish sauce, salt, and pepper to taste
8. Add milkfish pieces and simmer for 10 minutes
9. Add 1 bunch kangkong (water spinach) and 1 bunch string beans
10. Add 2-3 pieces green chili peppers
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'tamarind', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'fish'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinigang-bangus.jpg',
      ),
      Recipe(
        id: 94,
        name: 'Sinigang na Salmon',
        description: 'Salmon sinigang with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 360,
        proteinPerServing: 25,
        carbsPerServing: 8,
        fatPerServing: 22,
        instructions: '''1. Clean and cut 1 kg salmon into serving pieces
2. In a large pot, heat 2 tablespoons oil and sauté 1 chopped onion
3. Add 4 cloves minced garlic and cook until golden
4. Add 2 large tomatoes (quartered) and cook until soft
5. Pour in 6 cups water and bring to a boil
6. Add 3-4 tablespoons tamarind paste or 1 cup tamarind juice
7. Season with fish sauce, salt, and pepper to taste
8. Add salmon pieces and simmer for 10 minutes
9. Add 1 bunch kangkong (water spinach) and 1 bunch string beans
10. Add 2-3 pieces green chili peppers
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['salmon', 'tamarind', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'fish'],
        allergens: ['fish'],
        rating: 4.7,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinigang-salmon.jpg',
      ),
      Recipe(
        id: 95,
        name: 'Papaitan',
        description: 'Filipino bitter soup with goat innards',
        prepTime: 30,
        cookTime: 45,
        servings: 6,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 350,
        proteinPerServing: 30,
        carbsPerServing: 8,
        fatPerServing: 20,
        instructions: '''1. Clean 1 kg goat innards thoroughly and cut into bite-sized pieces
2. Heat 3 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 6 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add goat innards and cook for 5-7 minutes
6. Pour in 4 cups water and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch bitter herbs (ampalaya leaves) and 1 bunch string beans
9. Simmer for 30-40 minutes until innards are tender
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['goat innards', 'bitter herbs', 'garlic', 'onion', 'ginger'],
        tags: ['filipino', 'soup', 'special occasion'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/papaitan.jpg',
      ),
      Recipe(
        id: 96,
        name: 'Pesa',
        description: 'Clear fish soup with ginger',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 270,
        proteinPerServing: 22,
        carbsPerServing: 6,
        fatPerServing: 12,
        instructions: '''1. Clean and cut 1 kg fish into serving pieces
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add fish pieces and cook for 2-3 minutes
6. Pour in 4 cups water and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 15-20 minutes until fish is cooked
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['fish', 'ginger', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'fish'],
        allergens: ['fish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/pesa.jpg',
      ),
      Recipe(
        id: 97,
        name: 'Balbacua',
        description: 'Filipino oxtail soup',
        prepTime: 30,
        cookTime: 180,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 28,
        carbsPerServing: 15,
        fatPerServing: 32,
        instructions: '''1. Cut 1 kg oxtail into 2-inch pieces and season with salt and pepper
2. Heat 3 tablespoons oil in a large pot over medium-high heat
3. Brown oxtail pieces on all sides for 5-7 minutes, then remove from pot
4. In the same pot, sauté 1 chopped onion until translucent
5. Add 6 cloves minced garlic and 1 thumb-sized ginger (sliced)
6. Return oxtail to pot and add 4 cups water
7. Bring to a boil, then reduce heat and simmer for 2-3 hours
8. Add 2 large potatoes (quartered) and 2 carrots (cut in chunks)
9. Season with fish sauce, salt, and pepper
10. Simmer for 30 more minutes until vegetables are tender
11. Add 1 bunch malunggay leaves and simmer for 5 more minutes
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['oxtail', 'vegetables', 'garlic', 'onion', 'ginger'],
        tags: ['filipino', 'soup', 'special occasion'],
        allergens: [],
        rating: 4.6,
        cookTimeFormatted: '180 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/balbacua.jpg',
      ),
      Recipe(
        id: 98,
        name: 'Sinampalukang Manok',
        description: 'Chicken soup with tamarind leaves',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 250,
        proteinPerServing: 22,
        carbsPerServing: 8,
        fatPerServing: 12,
        instructions: '''1. Cut 1 kg chicken into serving pieces and season with salt and pepper
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add chicken pieces and cook until lightly browned
5. Add 4 cups water and bring to a boil
6. Season with fish sauce, salt, and pepper
7. Add 1 bunch tamarind leaves and 1 bunch string beans
8. Simmer for 20-25 minutes until chicken is tender
9. Add 1 eggplant (cut in chunks) and 2-3 pieces green chili peppers
10. Simmer for 10 more minutes until vegetables are tender
11. Add 1 bunch malunggay leaves and simmer for 5 more minutes
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'tamarind leaves', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'chicken'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinampalukang-manok.jpg',
      ),
      Recipe(
        id: 99,
        name: 'Sinabawang Tahong',
        description: 'Mussel soup with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 200,
        proteinPerServing: 18,
        carbsPerServing: 4,
        fatPerServing: 8,
        instructions: '''1. Clean 1 kg fresh mussels and remove beards
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add mussels and cook for 2-3 minutes
6. Pour in 4 cups vegetable broth and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 10-15 minutes until mussels open
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Discard any mussels that don't open
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['mussels', 'vegetables', 'broth', 'garlic', 'onion'],
        tags: ['filipino', 'soup', 'seafood'],
        allergens: ['shellfish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinabawang-tahong.jpg',
      ),
      Recipe(
        id: 100,
        name: 'Sinabawang Baboy',
        description: 'Pork soup with vegetables',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 25,
        carbsPerServing: 10,
        fatPerServing: 18,
        instructions: '''1. Cut 500g pork into bite-sized pieces and season with salt and pepper
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add pork pieces and cook until lightly browned
6. Pour in 4 cups pork broth and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 20-25 minutes until pork is tender
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['pork', 'vegetables', 'broth', 'garlic', 'onion'],
        tags: ['filipino', 'soup', 'pork'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinabawang-baboy.jpg',
      ),
      Recipe(
        id: 101,
        name: 'KBL (Kadyos, Baboy, Langka)',
        description: 'Filipino stew with pigeon peas, pork, and jackfruit',
        prepTime: 20,
        cookTime: 60,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 390,
        proteinPerServing: 26,
        carbsPerServing: 20,
        fatPerServing: 22,
        instructions: '''1. Soak 1 cup pigeon peas in water for 30 minutes, then drain
2. Cut 400g pork into bite-sized pieces and season with salt and pepper
3. Heat 3 tablespoons oil in a large pot over medium heat
4. Sauté 1 chopped onion and 4 cloves minced garlic until golden
5. Add pork pieces and cook until lightly browned
6. Add pigeon peas and 4 cups water, bring to a boil
7. Season with fish sauce, salt, and pepper
8. Simmer for 30-40 minutes until peas are tender
9. Add 1 cup jackfruit (cut in chunks) and 2 cups coconut milk
10. Simmer for 15-20 minutes until jackfruit is tender
11. Add 1 bunch malunggay leaves and simmer for 5 more minutes
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['pigeon peas', 'pork', 'jackfruit', 'coconut milk', 'garlic'],
        tags: ['filipino', 'stew', 'special occasion'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/kbl.jpg',
      ),
      Recipe(
        id: 102,
        name: 'Laswa',
        description: 'Filipino vegetable soup',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 220,
        proteinPerServing: 12,
        carbsPerServing: 12,
        fatPerServing: 8,
        instructions: '''1. Prepare 2 cups mixed vegetables (carrots, cabbage, string beans, eggplant)
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add mixed vegetables and cook for 3-4 minutes
6. Pour in 4 cups vegetable broth and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Simmer for 15-20 minutes until vegetables are tender
9. Add 1 bunch malunggay leaves and simmer for 5 more minutes
10. Adjust seasoning and add more chili if desired
11. Serve hot with steamed rice and fish sauce on the side
12. Garnish with chopped spring onions if desired''',
        isFilipinoDish: true,
        ingredients: ['mixed vegetables', 'broth', 'garlic', 'onion', 'fish sauce'],
        tags: ['filipino', 'soup', 'vegetarian'],
        allergens: ['fish'],
        rating: 4.2,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/laswa.jpg',
      ),
      Recipe(
        id: 103,
        name: 'Bulanglang',
        description: 'Filipino vegetable stew',
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 250,
        proteinPerServing: 15,
        carbsPerServing: 12,
        fatPerServing: 12,
        instructions: '''1. Prepare 2 cups mixed vegetables (carrots, cabbage, string beans, eggplant)
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add mixed vegetables and cook for 3-4 minutes
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 tablespoon shrimp paste (bagoong) and mix well
9. Simmer for 15-20 minutes until vegetables are tender
10. Add 1/2 cup coconut cream and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['vegetables', 'coconut milk', 'garlic', 'onion', 'chili'],
        tags: ['filipino', 'stew', 'vegetarian'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/bulanglang.jpg',
      ),
      Recipe(
        id: 104,
        name: 'Pinangat na Isda',
        description: 'Fish cooked in coconut milk',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 260,
        proteinPerServing: 20,
        carbsPerServing: 6,
        fatPerServing: 16,
        instructions: '''1. Clean and cut 1 kg fish into serving pieces
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add fish pieces and cook for 2-3 minutes
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 15-20 minutes until fish is cooked
10. Add 1/2 cup coconut cream and 1 bunch malunggay leaves
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['fish', 'coconut milk', 'vegetables', 'garlic', 'onion'],
        tags: ['filipino', 'fish', 'coconut milk'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/pinangat-isda.jpg',
      ),
      Recipe(
        id: 105,
        name: 'Pangat na Bangus',
        description: 'Milkfish cooked in coconut milk',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 270,
        proteinPerServing: 22,
        carbsPerServing: 8,
        fatPerServing: 16,
        instructions: '''1. Clean and cut 1 kg milkfish into serving pieces
2. Heat 3 tablespoons oil in a large pan over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add milkfish pieces and cook for 2-3 minutes
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 15-20 minutes until milkfish is cooked
10. Add 1/2 cup coconut cream and 1 bunch malunggay leaves
11. Simmer for 5 more minutes until vegetables are tender
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'coconut milk', 'vegetables', 'garlic', 'onion'],
        tags: ['filipino', 'fish', 'coconut milk'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/pangat-bangus.jpg',
      ),
      Recipe(
        id: 106,
        name: 'Sinanglay na Tilapia',
        description: 'Tilapia wrapped in taro leaves',
        prepTime: 20,
        cookTime: 25,
        servings: 4,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 300,
        proteinPerServing: 24,
        carbsPerServing: 10,
        fatPerServing: 18,
        instructions: '''1. Clean 4 whole tilapia and season with salt and pepper
2. Wash 8-10 taro leaves and remove stems
3. Heat 3 tablespoons oil in a large pan over medium heat
4. Sauté 1 chopped onion and 4 cloves minced garlic until golden
5. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
6. Pour in 2 cups coconut milk and bring to a gentle boil
7. Season with fish sauce, salt, and pepper
8. Wrap each tilapia in 2-3 taro leaves
9. Place wrapped fish in the coconut milk mixture
10. Simmer for 15-20 minutes until fish is cooked
11. Add 1/2 cup coconut cream and simmer for 5 more minutes
12. Serve hot with steamed rice and calamansi on the side''',
        isFilipinoDish: true,
        ingredients: ['tilapia', 'taro leaves', 'coconut milk', 'garlic', 'onion'],
        tags: ['filipino', 'fish', 'coconut milk'],
        allergens: ['fish'],
        rating: 4.6,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/sinanglay-tilapia.jpg',
      ),
      Recipe(
        id: 107,
        name: 'Nilagang Manok',
        description: 'Boiled chicken with vegetables',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 260,
        proteinPerServing: 22,
        carbsPerServing: 10,
        fatPerServing: 12,
        instructions: '''1. Cut 1 kg chicken into serving pieces and season with salt and pepper
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add chicken pieces and cook until lightly browned
6. Pour in 4 cups water and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch string beans and 1 eggplant (cut in chunks)
9. Simmer for 20-25 minutes until chicken is tender
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'vegetables', 'garlic', 'onion', 'fish sauce'],
        tags: ['filipino', 'soup', 'chicken'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/nilagang-manok.jpg',
      ),
      Recipe(
        id: 108,
        name: 'Sinampalukang Isda',
        description: 'Fish soup with tamarind leaves',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 240,
        proteinPerServing: 20,
        carbsPerServing: 7,
        fatPerServing: 10,
        instructions: '''1. Clean and cut 1 kg fish into serving pieces
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add fish pieces and cook for 2-3 minutes
6. Pour in 4 cups water and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 bunch tamarind leaves and 1 bunch string beans
9. Simmer for 15-20 minutes until fish is cooked
10. Add 1 eggplant (cut in chunks) and 2-3 pieces green chili peppers
11. Simmer for 10 more minutes until vegetables are tender
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['fish', 'tamarind leaves', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'fish'],
        allergens: ['fish'],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinampalukang-isda.jpg',
      ),
      Recipe(
        id: 109,
        name: 'Sinabawang Labong',
        description: 'Bamboo shoot soup',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 230,
        proteinPerServing: 10,
        carbsPerServing: 9,
        fatPerServing: 8,
        instructions: '''1. Prepare 2 cups bamboo shoots (sliced) and 2 cups mixed vegetables
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add bamboo shoots and mixed vegetables, cook for 3-4 minutes
6. Pour in 4 cups vegetable broth and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Simmer for 15-20 minutes until vegetables are tender
9. Add 1 bunch malunggay leaves and simmer for 5 more minutes
10. Adjust seasoning and add more chili if desired
11. Serve hot with steamed rice and fish sauce on the side
12. Garnish with chopped spring onions if desired''',
        isFilipinoDish: true,
        ingredients: ['bamboo shoots', 'vegetables', 'broth', 'garlic', 'onion'],
        tags: ['filipino', 'soup', 'vegetarian'],
        allergens: [],
        rating: 4.1,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinabawang-labong.jpg',
      ),
      Recipe(
        id: 110,
        name: 'Sinabawang Labanosa',
        description: 'Radish soup with vegetables',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 270,
        proteinPerServing: 20,
        carbsPerServing: 8,
        fatPerServing: 12,
        instructions: '''1. Prepare 2 cups radish (sliced) and 2 cups mixed vegetables
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add radish and mixed vegetables, cook for 3-4 minutes
6. Pour in 4 cups vegetable broth and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Simmer for 15-20 minutes until vegetables are tender
9. Add 1 bunch malunggay leaves and simmer for 5 more minutes
10. Adjust seasoning and add more chili if desired
11. Serve hot with steamed rice and fish sauce on the side
12. Garnish with chopped spring onions if desired''',
        isFilipinoDish: true,
        ingredients: ['radish', 'vegetables', 'broth', 'garlic', 'onion'],
        tags: ['filipino', 'soup', 'vegetarian'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinabawang-labanosa.jpg',
      ),
      Recipe(
        id: 111,
        name: 'Sinigang sa Bayabas',
        description: 'Sour soup with guava',
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 310,
        proteinPerServing: 22,
        carbsPerServing: 14,
        fatPerServing: 16,
        instructions: '''1. Cut 500g meat into bite-sized pieces and season with salt and pepper
2. Heat 2 tablespoons oil in a large pot over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until golden
4. Add 1 thumb-sized ginger (sliced) and 2-3 pieces green chili peppers
5. Add meat pieces and cook until lightly browned
6. Pour in 4 cups water and bring to a boil
7. Season with fish sauce, salt, and pepper
8. Add 1 cup guava (sliced) and 2 cups mixed vegetables
9. Simmer for 20-25 minutes until meat is tender
10. Add 1 bunch malunggay leaves and simmer for 5 more minutes
11. Adjust seasoning and add more chili if desired
12. Serve hot with steamed rice and fish sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['meat', 'guava', 'vegetables', 'fish sauce', 'onion'],
        tags: ['filipino', 'soup', 'special'],
        allergens: ['fish'],
        rating: 4.4,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinigang-bayabas.jpg',
      ),

      // Filipino Dessert Recipes with Accurate Nutritional Data
      Recipe(
        id: 112,
        name: 'Bibingka',
        description: 'Traditional Filipino rice cake with coconut milk',
        prepTime: 15,
        cookTime: 25,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 250,
        proteinPerServing: 5,
        carbsPerServing: 45,
        fatPerServing: 6,
        instructions: 'Mix rice flour with coconut milk, bake in banana leaves',
        isFilipinoDish: true,
        ingredients: ['malagkit na bigas', 'gata', 'asukal', 'itlog', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'traditional'],
        allergens: ['egg'],
        rating: 4.6,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/bibingka.jpg',
      ),
      Recipe(
        id: 113,
        name: 'Biko',
        description: 'Sweet sticky rice cake with coconut milk',
        prepTime: 20,
        cookTime: 30,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 280,
        proteinPerServing: 4,
        carbsPerServing: 50,
        fatPerServing: 7,
        instructions: '''1. Rinse 2 cups glutinous rice until water runs clear
2. Soak rice in water for 30 minutes, then drain
3. In a large pot, combine rice with 3 cups coconut milk
4. Add 1 cup brown sugar and 1/2 teaspoon salt
5. Bring to a boil, then reduce heat to low
6. Cover and simmer for 20-25 minutes until rice is tender
7. Stir occasionally to prevent sticking
8. Add 1/2 cup coconut cream and mix well
9. Continue cooking for 5 more minutes
10. Remove from heat and let rest for 10 minutes
11. Serve warm with additional coconut cream on top
12. Garnish with toasted coconut flakes if desired''',
        isFilipinoDish: true,
        ingredients: ['malagkit na bigas', 'gata', 'brown sugar', 'latik'],
        tags: ['dessert', 'filipino', 'meryenda', 'sticky rice'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/biko.jpg',
      ),
      Recipe(
        id: 114,
        name: 'Halo-Halo',
        description: 'Filipino mixed dessert with shaved ice and various toppings',
        prepTime: 30,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 320,
        proteinPerServing: 6,
        carbsPerServing: 55,
        fatPerServing: 8,
        instructions: '''1. Prepare 4 cups shaved ice in a large bowl
2. Add 1/2 cup ube halaya (purple yam jam) on top of ice
3. Add 1/2 cup leche flan (caramel custard) in small pieces
4. Add 1/2 cup sago (tapioca pearls) and 1/2 cup nata de coco
5. Add 1/2 cup sweetened beans and 1/2 cup sweetened corn
6. Add 1/2 cup jackfruit strips and 1/2 cup coconut sport
7. Add 1/2 cup sweetened banana and 1/2 cup sweetened mango
8. Pour 1 cup evaporated milk over the ingredients
9. Add 1/2 cup condensed milk and mix gently
10. Top with additional shaved ice
11. Garnish with toasted coconut flakes and sesame seeds
12. Serve immediately while cold and refreshing''',
        isFilipinoDish: true,
        ingredients: ['shaved ice', 'evaporated milk', 'ube halaya', 'leche flan', 'sago', 'nata de coco'],
        tags: ['dessert', 'filipino', 'tag-init', 'cold', 'refreshing'],
        allergens: ['milk', 'egg'],
        rating: 4.8,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/halo-halo.jpg',
      ),
      Recipe(
        id: 115,
        name: 'Leche Flan',
        description: 'Filipino caramel custard dessert',
        prepTime: 20,
        cookTime: 40,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 310,
        proteinPerServing: 6,
        carbsPerServing: 45,
        fatPerServing: 12,
        instructions: 'Make caramel, pour custard mixture, steam until set',
        isFilipinoDish: true,
        ingredients: ['itlog', 'gatas', 'asukal', 'vanilla extract'],
        tags: ['dessert', 'filipino', 'handaan', 'custard'],
        allergens: ['egg', 'milk'],
        rating: 4.7,
        cookTimeFormatted: '40 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/leche-flan.jpg',
      ),
      Recipe(
        id: 116,
        name: 'Ube Halaya',
        description: 'Purple yam jam dessert',
        prepTime: 15,
        cookTime: 45,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 270,
        proteinPerServing: 4,
        carbsPerServing: 45,
        fatPerServing: 8,
        instructions: '''1. Peel and cut 1 kg purple yam (ube) into small cubes
2. Boil yam in water for 15-20 minutes until tender
3. Drain and mash the yam while still hot
4. In a large pan, heat 2 cups coconut milk over medium heat
5. Add 1 cup sugar and stir until dissolved
6. Add mashed yam and mix well
7. Cook for 15-20 minutes, stirring constantly
8. Add 1/2 cup coconut cream and continue stirring
9. Cook until mixture is thick and smooth
10. Add 1 teaspoon vanilla extract and mix well
11. Remove from heat and let cool slightly
12. Serve warm or chilled with additional coconut cream on top''',
        isFilipinoDish: true,
        ingredients: ['ube', 'gatas', 'mantikilya', 'asukal', 'condensed milk'],
        tags: ['dessert', 'filipino', 'pista', 'purple yam'],
        allergens: ['milk'],
        rating: 4.6,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/ube-halaya.jpg',
      ),
      Recipe(
        id: 117,
        name: 'Sans Rival',
        description: 'Filipino layered cake with cashew meringue',
        prepTime: 45,
        cookTime: 30,
        servings: 12,
        difficulty: 'Hard',
        category: 'Dessert',
        caloriesPerServing: 460,
        proteinPerServing: 8,
        carbsPerServing: 40,
        fatPerServing: 30,
        instructions: 'Make cashew meringue layers, fill with buttercream, chill',
        isFilipinoDish: true,
        ingredients: ['cashew', 'butter', 'itlog', 'asukal', 'flour'],
        tags: ['dessert', 'filipino', 'handaan', 'cake', 'special occasion'],
        allergens: ['nuts', 'egg', 'wheat'],
        rating: 4.9,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '45 min',
        imageUrl: 'https://example.com/sans-rival.jpg',
      ),
      Recipe(
        id: 118,
        name: 'Polvoron',
        description: 'Filipino powdered milk candy',
        prepTime: 20,
        cookTime: 15,
        servings: 20,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 430,
        proteinPerServing: 8,
        carbsPerServing: 50,
        fatPerServing: 20,
        instructions: 'Toast flour, mix with powdered milk and sugar, shape into balls',
        isFilipinoDish: true,
        ingredients: ['harina', 'asukal', 'gatas', 'mantikilya', 'powdered milk'],
        tags: ['dessert', 'filipino', 'pasalubong', 'candy'],
        allergens: ['milk', 'wheat'],
        rating: 4.4,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/polvoron.jpg',
      ),
      Recipe(
        id: 119,
        name: 'Yema',
        description: 'Filipino milk candy balls',
        prepTime: 15,
        cookTime: 20,
        servings: 15,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 400,
        proteinPerServing: 8,
        carbsPerServing: 60,
        fatPerServing: 15,
        instructions: 'Cook condensed milk with egg yolks, shape into balls, wrap in cellophane',
        isFilipinoDish: true,
        ingredients: ['itlog', 'gatas', 'asukal', 'condensed milk'],
        tags: ['dessert', 'filipino', 'pasalubong', 'candy'],
        allergens: ['egg', 'milk'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/yema.jpg',
      ),
      Recipe(
        id: 120,
        name: 'Turon',
        description: 'Filipino banana spring roll dessert',
        prepTime: 20,
        cookTime: 15,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 180,
        proteinPerServing: 3,
        carbsPerServing: 35,
        fatPerServing: 4,
        instructions: 'Wrap banana and jackfruit in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['saging', 'langka', 'spring roll wrapper', 'brown sugar', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'fried'],
        allergens: ['wheat'],
        rating: 4.6,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/turon.jpg',
      ),
      Recipe(
        id: 121,
        name: 'Puto',
        description: 'Filipino steamed rice cake',
        prepTime: 15,
        cookTime: 20,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 120,
        proteinPerServing: 3,
        carbsPerServing: 25,
        fatPerServing: 1,
        instructions: 'Mix rice flour with water and sugar, steam in molds',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'asukal', 'water', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto.jpg',
      ),
      Recipe(
        id: 122,
        name: 'Kutsinta',
        description: 'Filipino brown rice cake',
        prepTime: 10,
        cookTime: 25,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 90,
        proteinPerServing: 2,
        carbsPerServing: 20,
        fatPerServing: 1,
        instructions: 'Mix rice flour with brown sugar and water, steam until set',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'brown sugar', 'water', 'lye water'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/kutsinta.jpg',
      ),
      Recipe(
        id: 123,
        name: 'Pichi-Pichi',
        description: 'Filipino cassava cake with coconut',
        prepTime: 15,
        cookTime: 20,
        servings: 10,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 150,
        proteinPerServing: 2,
        carbsPerServing: 30,
        fatPerServing: 3,
        instructions: 'Mix cassava with sugar and water, steam, roll in coconut',
        isFilipinoDish: true,
        ingredients: ['cassava', 'asukal', 'water', 'niyog', 'gata'],
        tags: ['dessert', 'filipino', 'meryenda', 'cassava'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/pichi-pichi.jpg',
      ),
      Recipe(
        id: 124,
        name: 'Sapin-Sapin',
        description: 'Filipino layered glutinous rice cake',
        prepTime: 30,
        cookTime: 45,
        servings: 12,
        difficulty: 'Hard',
        category: 'Dessert',
        caloriesPerServing: 220,
        proteinPerServing: 4,
        carbsPerServing: 40,
        fatPerServing: 6,
        instructions: 'Make different colored layers of glutinous rice, steam each layer',
        isFilipinoDish: true,
        ingredients: ['malagkit na bigas', 'gata', 'asukal', 'ube', 'pandan', 'latik'],
        tags: ['dessert', 'filipino', 'handaan', 'layered'],
        allergens: [],
        rating: 4.7,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/sapin-sapin.jpg',
      ),
      Recipe(
        id: 125,
        name: 'Maja Blanca',
        description: 'Filipino coconut pudding',
        prepTime: 15,
        cookTime: 20,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 160,
        proteinPerServing: 3,
        carbsPerServing: 25,
        fatPerServing: 6,
        instructions: '''1. In a large pot, heat 4 cups coconut milk over medium heat
2. Add 1 cup sugar and stir until dissolved
3. In a separate bowl, mix 1/2 cup cornstarch with 1/2 cup water
4. Slowly add cornstarch mixture to coconut milk, stirring constantly
5. Continue cooking and stirring for 10-15 minutes
6. Add 1 teaspoon vanilla extract and mix well
7. Cook until mixture is thick and smooth
8. Remove from heat and let cool slightly
9. Pour into serving dishes or molds
10. Let cool completely before serving
11. Garnish with toasted coconut flakes if desired
12. Serve chilled or at room temperature''',
        isFilipinoDish: true,
        ingredients: ['gata', 'cornstarch', 'asukal', 'niyog', 'latik'],
        tags: ['dessert', 'filipino', 'handaan', 'pudding'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/maja-blanca.jpg',
      ),
      Recipe(
        id: 126,
        name: 'Ginataang Bilo-Bilo',
        description: 'Filipino sweet soup with glutinous rice balls',
        prepTime: 20,
        cookTime: 25,
        servings: 6,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 200,
        proteinPerServing: 4,
        carbsPerServing: 35,
        fatPerServing: 6,
        instructions: 'Make glutinous rice balls, cook in coconut milk with sweet potatoes and sago',
        isFilipinoDish: true,
        ingredients: ['malagkit na bigas', 'gata', 'kamote', 'sago', 'asukal'],
        tags: ['dessert', 'filipino', 'meryenda', 'soup'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/ginataang-bilo-bilo.jpg',
      ),
      Recipe(
        id: 127,
        name: 'Taho',
        description: 'Filipino silken tofu dessert',
        prepTime: 5,
        cookTime: 10,
        servings: 4,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 4,
        carbsPerServing: 15,
        fatPerServing: 1,
        instructions: 'Heat silken tofu, add brown sugar syrup and sago pearls',
        isFilipinoDish: true,
        ingredients: ['silken tofu', 'brown sugar', 'sago', 'water'],
        tags: ['dessert', 'filipino', 'almusal', 'healthy'],
        allergens: ['soy'],
        rating: 4.3,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'https://example.com/taho.jpg',
      ),
      Recipe(
        id: 128,
        name: 'Buko Pandan',
        description: 'Filipino coconut and pandan jelly dessert',
        prepTime: 20,
        cookTime: 15,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 140,
        proteinPerServing: 2,
        carbsPerServing: 25,
        fatPerServing: 4,
        instructions: 'Make pandan jelly, mix with young coconut, add cream and condensed milk',
        isFilipinoDish: true,
        ingredients: ['young coconut', 'pandan jelly', 'cream', 'condensed milk', 'gata'],
        tags: ['dessert', 'filipino', 'tag-init', 'cold'],
        allergens: ['milk'],
        rating: 4.6,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/buko-pandan.jpg',
      ),
      Recipe(
        id: 129,
        name: 'Mais Con Yelo',
        description: 'Filipino corn and ice dessert',
        prepTime: 10,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 120,
        proteinPerServing: 3,
        carbsPerServing: 20,
        fatPerServing: 3,
        instructions: 'Mix sweet corn with shaved ice, evaporated milk, and sugar',
        isFilipinoDish: true,
        ingredients: ['sweet corn', 'shaved ice', 'evaporated milk', 'asukal'],
        tags: ['dessert', 'filipino', 'tag-init', 'cold'],
        allergens: ['milk'],
        rating: 4.2,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/mais-con-yelo.jpg',
      ),
      Recipe(
        id: 130,
        name: 'Gulaman',
        description: 'Filipino agar jelly dessert',
        prepTime: 15,
        cookTime: 10,
        servings: 6,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 60,
        proteinPerServing: 1,
        carbsPerServing: 12,
        fatPerServing: 0,
        instructions: 'Dissolve agar powder in water, add sugar and flavoring, let set',
        isFilipinoDish: true,
        ingredients: ['agar powder', 'water', 'asukal', 'food coloring'],
        tags: ['dessert', 'filipino', 'meryenda', 'jelly'],
        allergens: [],
        rating: 4.1,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/gulaman.jpg',
      ),
      Recipe(
        id: 131,
        name: 'Sago at Gulaman',
        description: 'Filipino sago and jelly drink',
        prepTime: 20,
        cookTime: 15,
        servings: 4,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 100,
        proteinPerServing: 1,
        carbsPerServing: 20,
        fatPerServing: 0,
        instructions: 'Cook sago pearls, make gulaman jelly, mix with brown sugar syrup',
        isFilipinoDish: true,
        ingredients: ['sago', 'gulaman', 'brown sugar', 'water', 'ice'],
        tags: ['dessert', 'filipino', 'tag-init', 'drink'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/sago-gulaman.jpg',
      ),
      Recipe(
        id: 132,
        name: 'Puto Bumbong',
        description: 'Filipino purple rice cake steamed in bamboo',
        prepTime: 30,
        cookTime: 20,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 200,
        proteinPerServing: 4,
        carbsPerServing: 35,
        fatPerServing: 5,
        instructions: 'Mix purple rice flour with coconut milk, steam in bamboo tubes',
        isFilipinoDish: true,
        ingredients: ['purple rice flour', 'gata', 'asukal', 'niyog', 'latik'],
        tags: ['dessert', 'filipino', 'pasko', 'mahal na araw', 'special'],
        allergens: [],
        rating: 4.8,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/puto-bumbong.jpg',
      ),
      Recipe(
        id: 133,
        name: 'Bibingkang Malagkit',
        description: 'Filipino glutinous rice cake',
        prepTime: 20,
        cookTime: 30,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 240,
        proteinPerServing: 4,
        carbsPerServing: 42,
        fatPerServing: 6,
        instructions: 'Mix glutinous rice with coconut milk and sugar, bake until set',
        isFilipinoDish: true,
        ingredients: ['malagkit na bigas', 'gata', 'asukal', 'latik'],
        tags: ['dessert', 'filipino', 'meryenda', 'sticky rice'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/bibingkang-malagkit.jpg',
      ),
      Recipe(
        id: 134,
        name: 'Kakanin',
        description: 'Filipino rice cake assortment',
        prepTime: 25,
        cookTime: 35,
        servings: 12,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 180,
        proteinPerServing: 3,
        carbsPerServing: 32,
        fatPerServing: 4,
        instructions: '''1. Mix 2 cups rice flour with 1 cup coconut milk
2. Add 1/2 cup sugar and 1/2 teaspoon salt
3. Divide mixture into 4 equal parts
4. Add different food colors to each part (red, green, yellow, purple)
5. Add different flavors (pandan, ube, mango, strawberry)
6. Pour each colored mixture into small molds
7. Steam for 15-20 minutes until cooked through
8. Remove from molds and let cool
9. Arrange on a serving plate
10. Garnish with toasted coconut flakes
11. Serve with additional coconut cream on the side
12. Best served fresh and warm''',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'gata', 'asukal', 'food coloring', 'niyog'],
        tags: ['dessert', 'filipino', 'meryenda', 'assorted'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '35 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://example.com/kakanin.jpg',
      ),
      Recipe(
        id: 135,
        name: 'Puto Kutsinta',
        description: 'Filipino steamed rice cake with brown sugar',
        prepTime: 15,
        cookTime: 25,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 110,
        proteinPerServing: 2,
        carbsPerServing: 22,
        fatPerServing: 1,
        instructions: 'Mix rice flour with brown sugar and water, steam in molds',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'brown sugar', 'water', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto-kutsinta.jpg',
      ),
      Recipe(
        id: 136,
        name: 'Bibingkang Cassava',
        description: 'Filipino cassava cake',
        prepTime: 20,
        cookTime: 40,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 190,
        proteinPerServing: 3,
        carbsPerServing: 35,
        fatPerServing: 5,
        instructions: 'Grate cassava, mix with coconut milk and sugar, bake until golden',
        isFilipinoDish: true,
        ingredients: ['cassava', 'gata', 'asukal', 'itlog', 'butter'],
        tags: ['dessert', 'filipino', 'meryenda', 'cassava'],
        allergens: ['egg'],
        rating: 4.3,
        cookTimeFormatted: '40 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/bibingkang-cassava.jpg',
      ),
      Recipe(
        id: 137,
        name: 'Puto Cheese',
        description: 'Filipino steamed rice cake with cheese',
        prepTime: 15,
        cookTime: 20,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 130,
        proteinPerServing: 4,
        carbsPerServing: 20,
        fatPerServing: 3,
        instructions: 'Mix rice flour with water and sugar, steam, top with cheese',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'water', 'asukal', 'cheese', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: ['milk'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto-cheese.jpg',
      ),
      Recipe(
        id: 138,
        name: 'Puto Ube',
        description: 'Filipino purple yam steamed rice cake',
        prepTime: 15,
        cookTime: 20,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 140,
        proteinPerServing: 3,
        carbsPerServing: 25,
        fatPerServing: 3,
        instructions: 'Mix rice flour with ube flavoring and sugar, steam in molds',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'ube flavoring', 'asukal', 'water', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'purple yam'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto-ube.jpg',
      ),
      Recipe(
        id: 139,
        name: 'Puto Pandan',
        description: 'Filipino pandan flavored steamed rice cake',
        prepTime: 15,
        cookTime: 20,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 120,
        proteinPerServing: 3,
        carbsPerServing: 22,
        fatPerServing: 2,
        instructions: 'Mix rice flour with pandan flavoring and sugar, steam in molds',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'pandan flavoring', 'asukal', 'water', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'pandan'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto-pandan.jpg',
      ),
      Recipe(
        id: 140,
        name: 'Puto Calasiao',
        description: 'Filipino soft steamed rice cake from Calasiao',
        prepTime: 20,
        cookTime: 25,
        servings: 12,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 150,
        proteinPerServing: 3,
        carbsPerServing: 28,
        fatPerServing: 3,
        instructions: 'Mix rice flour with coconut milk and sugar, steam until soft',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'gata', 'asukal', 'water', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'regional'],
        allergens: [],
        rating: 4.6,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/puto-calasiao.jpg',
      ),
      Recipe(
        id: 141,
        name: 'Puto Maya',
        description: 'Filipino glutinous rice with coconut',
        prepTime: 15,
        cookTime: 30,
        servings: 6,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 170,
        proteinPerServing: 3,
        carbsPerServing: 30,
        fatPerServing: 4,
        instructions: '''1. Rinse 2 cups glutinous rice until water runs clear
2. Soak rice in water for 30 minutes, then drain
3. In a large pot, combine rice with 3 cups coconut milk
4. Add 1 cup sugar and 1/2 teaspoon salt
5. Bring to a boil, then reduce heat to low
6. Cover and simmer for 20-25 minutes until rice is tender
7. Stir occasionally to prevent sticking
8. Add 1/2 cup coconut cream and mix well
9. Continue cooking for 5 more minutes
10. Remove from heat and let rest for 10 minutes
11. Serve warm with additional coconut cream on top
12. Garnish with toasted coconut flakes if desired''',
        isFilipinoDish: true,
        ingredients: ['malagkit na bigas', 'gata', 'asukal', 'niyog'],
        tags: ['dessert', 'filipino', 'meryenda', 'sticky rice'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto-maya.jpg',
      ),
      Recipe(
        id: 142,
        name: 'Puto Seko',
        description: 'Filipino crumbly rice cake',
        prepTime: 20,
        cookTime: 30,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 160,
        proteinPerServing: 3,
        carbsPerServing: 28,
        fatPerServing: 4,
        instructions: 'Mix rice flour with coconut milk and sugar, bake until crumbly',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'gata', 'asukal', 'niyog', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'crumbly'],
        allergens: [],
        rating: 4.1,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/puto-seko.jpg',
      ),
      Recipe(
        id: 143,
        name: 'Puto Pao',
        description: 'Filipino steamed rice cake with meat filling',
        prepTime: 25,
        cookTime: 20,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 180,
        proteinPerServing: 6,
        carbsPerServing: 25,
        fatPerServing: 5,
        instructions: 'Make rice flour dough, fill with meat mixture, steam',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'ground pork', 'onion', 'garlic', 'soy sauce'],
        tags: ['dessert', 'filipino', 'meryenda', 'savory'],
        allergens: ['soy'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://example.com/puto-pao.jpg',
      ),
      Recipe(
        id: 144,
        name: 'Puto Bumbong',
        description: 'Filipino purple rice cake steamed in bamboo tubes',
        prepTime: 30,
        cookTime: 20,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 200,
        proteinPerServing: 4,
        carbsPerServing: 35,
        fatPerServing: 5,
        instructions: 'Mix purple rice flour with coconut milk, steam in bamboo tubes',
        isFilipinoDish: true,
        ingredients: ['purple rice flour', 'gata', 'asukal', 'niyog', 'latik'],
        tags: ['dessert', 'filipino', 'pasko', 'mahal na araw', 'special'],
        allergens: [],
        rating: 4.8,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/puto-bumbong.jpg',
      ),
      Recipe(
        id: 145,
        name: 'Puto Kutsinta',
        description: 'Filipino brown rice cake',
        prepTime: 15,
        cookTime: 25,
        servings: 12,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 110,
        proteinPerServing: 2,
        carbsPerServing: 22,
        fatPerServing: 1,
        instructions: 'Mix rice flour with brown sugar and water, steam in molds',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'brown sugar', 'water', 'baking powder'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: [],
        rating: 4.2,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/puto-kutsinta.jpg',
      ),
      Recipe(
        id: 146,
        name: 'Buko Salad',
        description: 'Filipino young coconut fruit salad',
        prepTime: 20,
        cookTime: 0,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 180,
        proteinPerServing: 3,
        carbsPerServing: 35,
        fatPerServing: 5,
        instructions: '''1. Open 2 young coconuts and extract the meat and water
2. Cut coconut meat into thin strips
3. Prepare 1 cup mixed fruits (mango, banana, jackfruit, etc.)
4. Cut fruits into bite-sized pieces
5. In a large bowl, combine coconut meat and mixed fruits
6. Add 1 cup coconut water and mix well
7. Add 1/2 cup condensed milk and stir gently
8. Add 1/4 cup sugar and mix until dissolved
9. Add 1 cup coconut cream and mix well
10. Chill in refrigerator for 30 minutes
11. Serve cold in individual bowls
12. Garnish with additional coconut cream and fruit slices''',
        isFilipinoDish: true,
        ingredients: ['young coconut', 'mixed fruits', 'cream', 'condensed milk', 'cheese'],
        tags: ['dessert', 'filipino', 'handaan', 'fruit salad'],
        allergens: ['milk'],
        rating: 4.5,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/buko-salad.jpg',
      ),
      Recipe(
        id: 147,
        name: 'Macapuno',
        description: 'Filipino coconut sport dessert',
        prepTime: 15,
        cookTime: 30,
        servings: 6,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 200,
        proteinPerServing: 2,
        carbsPerServing: 40,
        fatPerServing: 4,
        instructions: '''1. Grate 2 cups coconut sport (macapuno) into thin strips
2. In a large pan, heat 2 cups water over medium heat
3. Add 1 cup sugar and stir until dissolved
4. Add coconut sport and mix well
5. Cook for 15-20 minutes, stirring constantly
6. Add 1/2 cup coconut cream and continue stirring
7. Cook until mixture is thick and syrupy
8. Add 1 teaspoon vanilla extract and mix well
9. Remove from heat and let cool slightly
10. Serve warm or chilled
11. Garnish with toasted coconut flakes if desired
12. Best served with ice cream or as a topping for desserts''',
        isFilipinoDish: true,
        ingredients: ['macapuno', 'asukal', 'water', 'gata'],
        tags: ['dessert', 'filipino', 'meryenda', 'coconut'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/macapuno.jpg',
      ),
      Recipe(
        id: 148,
        name: 'Buko Pie',
        description: 'Filipino young coconut pie',
        prepTime: 30,
        cookTime: 45,
        servings: 8,
        difficulty: 'Hard',
        category: 'Dessert',
        caloriesPerServing: 350,
        proteinPerServing: 6,
        carbsPerServing: 45,
        fatPerServing: 16,
        instructions: 'Make pie crust, fill with young coconut mixture, bake until golden',
        isFilipinoDish: true,
        ingredients: ['young coconut', 'pie crust', 'milk', 'sugar', 'cornstarch'],
        tags: ['dessert', 'filipino', 'handaan', 'pie'],
        allergens: ['milk', 'wheat'],
        rating: 4.7,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/buko-pie.jpg',
      ),
      Recipe(
        id: 149,
        name: 'Ensaymada',
        description: 'Filipino sweet bread with cheese and butter',
        prepTime: 60,
        cookTime: 25,
        servings: 12,
        difficulty: 'Hard',
        category: 'Dessert',
        caloriesPerServing: 280,
        proteinPerServing: 8,
        carbsPerServing: 35,
        fatPerServing: 12,
        instructions: 'Make sweet bread dough, roll with butter and sugar, top with cheese',
        isFilipinoDish: true,
        ingredients: ['bread flour', 'sugar', 'butter', 'cheese', 'yeast'],
        tags: ['dessert', 'filipino', 'meryenda', 'bread'],
        allergens: ['wheat', 'milk', 'egg'],
        rating: 4.6,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '60 min',
        imageUrl: 'https://example.com/ensaymada.jpg',
      ),
      Recipe(
        id: 150,
        name: 'Pan de Sal',
        description: 'Filipino salt bread rolls',
        prepTime: 30,
        cookTime: 20,
        servings: 12,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 120,
        proteinPerServing: 4,
        carbsPerServing: 22,
        fatPerServing: 2,
        instructions: 'Make bread dough with salt, shape into rolls, bake until golden',
        isFilipinoDish: true,
        ingredients: ['bread flour', 'salt', 'yeast', 'water', 'oil'],
        tags: ['dessert', 'filipino', 'almusal', 'bread'],
        allergens: ['wheat'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/pan-de-sal.jpg',
      ),
      Recipe(
        id: 151,
        name: 'Pandesal',
        description: 'Filipino sweet bread rolls',
        prepTime: 30,
        cookTime: 20,
        servings: 12,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 140,
        proteinPerServing: 4,
        carbsPerServing: 25,
        fatPerServing: 3,
        instructions: 'Make sweet bread dough, shape into rolls, bake until golden',
        isFilipinoDish: true,
        ingredients: ['bread flour', 'sugar', 'yeast', 'water', 'oil'],
        tags: ['dessert', 'filipino', 'almusal', 'bread'],
        allergens: ['wheat'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/pandesal.jpg',
      ),
      Recipe(
        id: 152,
        name: 'Monay',
        description: 'Filipino dense bread',
        prepTime: 25,
        cookTime: 30,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 180,
        proteinPerServing: 5,
        carbsPerServing: 30,
        fatPerServing: 4,
        instructions: 'Make dense bread dough, shape into oval, bake until golden',
        isFilipinoDish: true,
        ingredients: ['bread flour', 'sugar', 'yeast', 'water', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'bread'],
        allergens: ['wheat'],
        rating: 4.2,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://example.com/monay.jpg',
      ),
      Recipe(
        id: 153,
        name: 'Spanish Bread',
        description: 'Filipino sweet bread with filling',
        prepTime: 40,
        cookTime: 25,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 220,
        proteinPerServing: 6,
        carbsPerServing: 32,
        fatPerServing: 7,
        instructions: 'Make sweet bread dough, fill with butter and sugar mixture, bake',
        isFilipinoDish: true,
        ingredients: ['bread flour', 'sugar', 'butter', 'yeast', 'breadcrumbs'],
        tags: ['dessert', 'filipino', 'meryenda', 'bread'],
        allergens: ['wheat', 'milk'],
        rating: 4.4,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '40 min',
        imageUrl: 'https://example.com/spanish-bread.jpg',
      ),
      Recipe(
        id: 154,
        name: 'Hopia',
        description: 'Filipino flaky pastry with sweet filling',
        prepTime: 45,
        cookTime: 30,
        servings: 15,
        difficulty: 'Hard',
        category: 'Dessert',
        caloriesPerServing: 250,
        proteinPerServing: 5,
        carbsPerServing: 35,
        fatPerServing: 10,
        instructions: 'Make flaky pastry dough, fill with sweet bean paste, bake until golden',
        isFilipinoDish: true,
        ingredients: ['flour', 'butter', 'sweet bean paste', 'sugar', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'pastry'],
        allergens: ['wheat'],
        rating: 4.6,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '45 min',
        imageUrl: 'https://example.com/hopia.jpg',
      ),
      Recipe(
        id: 155,
        name: 'Hopiang Baboy',
        description: 'Filipino flaky pastry with pork filling',
        prepTime: 45,
        cookTime: 30,
        servings: 15,
        difficulty: 'Hard',
        category: 'Dessert',
        caloriesPerServing: 280,
        proteinPerServing: 8,
        carbsPerServing: 30,
        fatPerServing: 12,
        instructions: 'Make flaky pastry dough, fill with seasoned pork, bake until golden',
        isFilipinoDish: true,
        ingredients: ['flour', 'butter', 'ground pork', 'onion', 'garlic'],
        tags: ['dessert', 'filipino', 'meryenda', 'savory'],
        allergens: ['wheat'],
        rating: 4.5,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '45 min',
        imageUrl: 'https://example.com/hopiang-baboy.jpg',
      ),
      Recipe(
        id: 156,
        name: 'Empanada',
        description: 'Filipino meat-filled pastry',
        prepTime: 30,
        cookTime: 25,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 200,
        proteinPerServing: 8,
        carbsPerServing: 25,
        fatPerServing: 8,
        instructions: 'Make pastry dough, fill with meat mixture, seal and fry',
        isFilipinoDish: true,
        ingredients: ['flour', 'ground meat', 'onion', 'garlic', 'potatoes'],
        tags: ['dessert', 'filipino', 'meryenda', 'savory'],
        allergens: ['wheat'],
        rating: 4.3,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/empanada.jpg',
      ),
      Recipe(
        id: 157,
        name: 'Siopao',
        description: 'Filipino steamed bun with meat filling',
        prepTime: 40,
        cookTime: 20,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 180,
        proteinPerServing: 8,
        carbsPerServing: 28,
        fatPerServing: 4,
        instructions: 'Make bun dough, fill with meat mixture, steam until cooked',
        isFilipinoDish: true,
        ingredients: ['flour', 'ground meat', 'onion', 'garlic', 'yeast'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: ['wheat'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '40 min',
        imageUrl: 'https://example.com/siopao.jpg',
      ),
      Recipe(
        id: 158,
        name: 'Siomai',
        description: 'Filipino steamed dumpling',
        prepTime: 30,
        cookTime: 15,
        servings: 12,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 6,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Make dumpling wrapper, fill with meat mixture, steam until cooked',
        isFilipinoDish: true,
        ingredients: ['dumpling wrapper', 'ground meat', 'onion', 'garlic', 'soy sauce'],
        tags: ['dessert', 'filipino', 'meryenda', 'steamed'],
        allergens: ['wheat', 'soy'],
        rating: 4.3,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/siomai.jpg',
      ),
      Recipe(
        id: 159,
        name: 'Lumpia',
        description: 'Filipino spring roll',
        prepTime: 25,
        cookTime: 15,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 120,
        proteinPerServing: 5,
        carbsPerServing: 15,
        fatPerServing: 4,
        instructions: 'Wrap vegetable mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'vegetables', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'fried'],
        allergens: ['wheat'],
        rating: 4.2,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://example.com/lumpia.jpg',
      ),
      Recipe(
        id: 160,
        name: 'Lumpiang Gulay',
        description: 'Filipino vegetable spring roll',
        prepTime: 25,
        cookTime: 15,
        servings: 10,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 100,
        proteinPerServing: 4,
        carbsPerServing: 12,
        fatPerServing: 3,
        instructions: 'Wrap mixed vegetables in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'mixed vegetables', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://example.com/lumpiang-gulay.jpg',
      ),
      Recipe(
        id: 161,
        name: 'Lumpiang Sariwa',
        description: 'Filipino fresh spring roll',
        prepTime: 20,
        cookTime: 10,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap fresh vegetables in rice paper, serve with sweet sauce',
        isFilipinoDish: true,
        ingredients: ['rice paper', 'fresh vegetables', 'lettuce', 'carrots', 'sweet sauce'],
        tags: ['dessert', 'filipino', 'meryenda', 'fresh'],
        allergens: [],
        rating: 4.0,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-sariwa.jpg',
      ),
      Recipe(
        id: 162,
        name: 'Lumpiang Hubad',
        description: 'Filipino naked spring roll',
        prepTime: 15,
        cookTime: 10,
        servings: 6,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 90,
        proteinPerServing: 4,
        carbsPerServing: 12,
        fatPerServing: 2,
        instructions: 'Mix vegetables with sauce, serve without wrapper',
        isFilipinoDish: true,
        ingredients: ['mixed vegetables', 'sweet sauce', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: [],
        rating: 4.0,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/lumpiang-hubad.jpg',
      ),
      Recipe(
        id: 163,
        name: 'Lumpiang Togue',
        description: 'Filipino bean sprout spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bean sprouts in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bean sprouts', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-togue.jpg',
      ),
      Recipe(
        id: 164,
        name: 'Lumpiang Ubod',
        description: 'Filipino heart of palm spring roll',
        prepTime: 25,
        cookTime: 15,
        servings: 8,
        difficulty: 'Medium',
        category: 'Dessert',
        caloriesPerServing: 110,
        proteinPerServing: 4,
        carbsPerServing: 12,
        fatPerServing: 4,
        instructions: 'Wrap heart of palm mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'heart of palm', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.2,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '25 min',
        imageUrl: 'https://example.com/lumpiang-ubod.jpg',
      ),
      Recipe(
        id: 165,
        name: 'Lumpiang Singkamas',
        description: 'Filipino jicama spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 85,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap jicama mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'jicama', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-singkamas.jpg',
      ),
      Recipe(
        id: 166,
        name: 'Lumpiang Kamote',
        description: 'Filipino sweet potato spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 95,
        proteinPerServing: 3,
        carbsPerServing: 15,
        fatPerServing: 2,
        instructions: 'Wrap sweet potato mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'sweet potato', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kamote.jpg',
      ),
      Recipe(
        id: 167,
        name: 'Lumpiang Kalabasa',
        description: 'Filipino squash spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap squash mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'squash', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kalabasa.jpg',
      ),
      Recipe(
        id: 168,
        name: 'Lumpiang Sayote',
        description: 'Filipino chayote spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap chayote mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'chayote', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-sayote.jpg',
      ),
      Recipe(
        id: 169,
        name: 'Lumpiang Upo',
        description: 'Filipino bottle gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bottle gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bottle gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-upo.jpg',
      ),
      Recipe(
        id: 170,
        name: 'Lumpiang Patola',
        description: 'Filipino sponge gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap sponge gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'sponge gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-patola.jpg',
      ),
      Recipe(
        id: 171,
        name: 'Lumpiang Talong',
        description: 'Filipino eggplant spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 85,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap eggplant mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'eggplant', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-talong.jpg',
      ),
      Recipe(
        id: 172,
        name: 'Lumpiang Ampalaya',
        description: 'Filipino bitter gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bitter gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bitter gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-ampalaya.jpg',
      ),
      Recipe(
        id: 173,
        name: 'Lumpiang Kangkong',
        description: 'Filipino water spinach spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap water spinach mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'water spinach', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kangkong.jpg',
      ),
      Recipe(
        id: 174,
        name: 'Lumpiang Saluyot',
        description: 'Filipino jute leaves spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap jute leaves mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'jute leaves', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-saluyot.jpg',
      ),
      Recipe(
        id: 175,
        name: 'Lumpiang Malunggay',
        description: 'Filipino moringa leaves spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 4,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap moringa leaves mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'moringa leaves', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-malunggay.jpg',
      ),
      Recipe(
        id: 176,
        name: 'Lumpiang Pechay',
        description: 'Filipino Chinese cabbage spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap Chinese cabbage mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'Chinese cabbage', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-pechay.jpg',
      ),
      Recipe(
        id: 177,
        name: 'Lumpiang Repolyo',
        description: 'Filipino cabbage spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap cabbage mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'cabbage', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-repolyo.jpg',
      ),
      Recipe(
        id: 178,
        name: 'Lumpiang Labanos',
        description: 'Filipino radish spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap radish mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'radish', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-labanos.jpg',
      ),
      Recipe(
        id: 179,
        name: 'Lumpiang Singkamas',
        description: 'Filipino jicama spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap jicama mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'jicama', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-singkamas.jpg',
      ),
      Recipe(
        id: 180,
        name: 'Lumpiang Kamote',
        description: 'Filipino sweet potato spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 85,
        proteinPerServing: 3,
        carbsPerServing: 12,
        fatPerServing: 2,
        instructions: 'Wrap sweet potato mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'sweet potato', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kamote.jpg',
      ),
      Recipe(
        id: 181,
        name: 'Lumpiang Kalabasa',
        description: 'Filipino squash spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap squash mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'squash', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kalabasa.jpg',
      ),
      Recipe(
        id: 182,
        name: 'Lumpiang Sayote',
        description: 'Filipino chayote spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap chayote mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'chayote', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-sayote.jpg',
      ),
      Recipe(
        id: 183,
        name: 'Lumpiang Upo',
        description: 'Filipino bottle gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bottle gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bottle gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-upo.jpg',
      ),
      Recipe(
        id: 184,
        name: 'Lumpiang Patola',
        description: 'Filipino sponge gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap sponge gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'sponge gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-patola.jpg',
      ),
      Recipe(
        id: 185,
        name: 'Lumpiang Talong',
        description: 'Filipino eggplant spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 85,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap eggplant mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'eggplant', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-talong.jpg',
      ),
      Recipe(
        id: 186,
        name: 'Lumpiang Ampalaya',
        description: 'Filipino bitter gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bitter gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bitter gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-ampalaya.jpg',
      ),
      Recipe(
        id: 187,
        name: 'Lumpiang Kangkong',
        description: 'Filipino water spinach spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap water spinach mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'water spinach', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kangkong.jpg',
      ),
      Recipe(
        id: 188,
        name: 'Lumpiang Saluyot',
        description: 'Filipino jute leaves spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap jute leaves mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'jute leaves', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-saluyot.jpg',
      ),
      Recipe(
        id: 189,
        name: 'Lumpiang Malunggay',
        description: 'Filipino moringa leaves spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 4,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap moringa leaves mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'moringa leaves', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-malunggay.jpg',
      ),
      Recipe(
        id: 190,
        name: 'Lumpiang Pechay',
        description: 'Filipino Chinese cabbage spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap Chinese cabbage mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'Chinese cabbage', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-pechay.jpg',
      ),
      Recipe(
        id: 191,
        name: 'Lumpiang Repolyo',
        description: 'Filipino cabbage spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap cabbage mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'cabbage', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-repolyo.jpg',
      ),
      Recipe(
        id: 192,
        name: 'Lumpiang Labanos',
        description: 'Filipino radish spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap radish mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'radish', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-labanos.jpg',
      ),
      Recipe(
        id: 193,
        name: 'Lumpiang Singkamas',
        description: 'Filipino jicama spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap jicama mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'jicama', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-singkamas.jpg',
      ),
      Recipe(
        id: 194,
        name: 'Lumpiang Kamote',
        description: 'Filipino sweet potato spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 85,
        proteinPerServing: 3,
        carbsPerServing: 12,
        fatPerServing: 2,
        instructions: 'Wrap sweet potato mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'sweet potato', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kamote.jpg',
      ),
      Recipe(
        id: 195,
        name: 'Lumpiang Kalabasa',
        description: 'Filipino squash spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap squash mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'squash', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-kalabasa.jpg',
      ),
      Recipe(
        id: 196,
        name: 'Lumpiang Sayote',
        description: 'Filipino chayote spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap chayote mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'chayote', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-sayote.jpg',
      ),
      Recipe(
        id: 197,
        name: 'Lumpiang Upo',
        description: 'Filipino bottle gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bottle gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bottle gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-upo.jpg',
      ),
      Recipe(
        id: 198,
        name: 'Lumpiang Patola',
        description: 'Filipino sponge gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap sponge gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'sponge gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-patola.jpg',
      ),
      Recipe(
        id: 199,
        name: 'Lumpiang Talong',
        description: 'Filipino eggplant spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 85,
        proteinPerServing: 3,
        carbsPerServing: 10,
        fatPerServing: 2,
        instructions: 'Wrap eggplant mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'eggplant', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.1,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-talong.jpg',
      ),
      Recipe(
        id: 200,
        name: 'Lumpiang Ampalaya',
        description: 'Filipino bitter gourd spring roll',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Dessert',
        caloriesPerServing: 80,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: 'Wrap bitter gourd mixture in spring roll wrapper, fry until golden',
        isFilipinoDish: true,
        ingredients: ['spring roll wrapper', 'bitter gourd', 'onion', 'garlic', 'oil'],
        tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/lumpiang-ampalaya.jpg',
      ),
      
      // Additional Filipino Breakfast Dishes for Variety
      Recipe(
        id: 201,
        name: 'Tocilog',
        description: 'Tocino, Sinangag, at Itlog - Sweet cured pork with garlic rice and egg',
        prepTime: 15,
        cookTime: 20,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 450,
        proteinPerServing: 22,
        carbsPerServing: 35,
        fatPerServing: 25,
        instructions: '''1. Marinate pork belly with sugar, salt, and garlic overnight
2. Cook garlic rice by sautéing minced garlic in oil until golden, then add cooked rice
3. Pan-fry the marinated tocino until caramelized and tender
4. Fry an egg sunny-side up
5. Serve tocino over garlic rice with the fried egg on top
6. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['pork belly', 'garlic rice', 'egg', 'garlic', 'sugar', 'salt'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['egg'],
        rating: 4.6,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/tocilog.jpg',
      ),
      Recipe(
        id: 202,
        name: 'Bangsilog',
        description: 'Bangus, Sinangag, at Itlog - Milkfish with garlic rice and egg',
        prepTime: 20,
        cookTime: 25,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 420,
        proteinPerServing: 28,
        carbsPerServing: 32,
        fatPerServing: 18,
        instructions: '''1. Clean and marinate bangus with calamansi, salt, and pepper
2. Cook garlic rice by sautéing minced garlic in oil until golden
3. Grill or pan-fry the bangus until golden and crispy
4. Fry an egg sunny-side up
5. Serve bangus over garlic rice with the fried egg
6. Serve with atchara (pickled papaya) on the side''',
        isFilipinoDish: true,
        ingredients: ['bangus', 'garlic rice', 'egg', 'garlic', 'calamansi', 'salt'],
        tags: ['filipino', 'breakfast', 'protein', 'fish'],
        allergens: ['egg', 'fish'],
        rating: 4.5,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/bangsilog.jpg',
      ),
      Recipe(
        id: 203,
        name: 'Cornsilog',
        description: 'Corned Beef, Sinangag, at Itlog - Corned beef with garlic rice and egg',
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 480,
        proteinPerServing: 25,
        carbsPerServing: 38,
        fatPerServing: 22,
        instructions: '''1. Cook garlic rice by sautéing minced garlic in oil until golden
2. Sauté corned beef with onions until heated through
3. Fry an egg sunny-side up
4. Serve corned beef over garlic rice with the fried egg
5. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['corned beef', 'garlic rice', 'egg', 'garlic', 'onion'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['egg', 'beef'],
        rating: 4.4,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/cornsilog.jpg',
      ),
      Recipe(
        id: 204,
        name: 'Spamsilog',
        description: 'Spam, Sinangag, at Itlog - Spam with garlic rice and egg',
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 24,
        carbsPerServing: 35,
        fatPerServing: 28,
        instructions: '''1. Slice spam and pan-fry until golden brown
2. Cook garlic rice by sautéing minced garlic in oil until golden
3. Fry an egg sunny-side up
4. Serve spam over garlic rice with the fried egg
5. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['spam', 'garlic rice', 'egg', 'garlic'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['egg', 'pork'],
        rating: 4.3,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/spamsilog.jpg',
      ),
      Recipe(
        id: 205,
        name: 'Hotsilog',
        description: 'Hotdog, Sinangag, at Itlog - Hotdog with garlic rice and egg',
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 18,
        carbsPerServing: 32,
        fatPerServing: 20,
        instructions: '''1. Slice hotdog and pan-fry until golden brown
2. Cook garlic rice by sautéing minced garlic in oil until golden
3. Fry an egg sunny-side up
4. Serve hotdog over garlic rice with the fried egg
5. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['hotdog', 'garlic rice', 'egg', 'garlic'],
        tags: ['filipino', 'breakfast', 'protein'],
        allergens: ['egg', 'pork'],
        rating: 4.2,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/hotsilog.jpg',
      ),
      Recipe(
        id: 206,
        name: 'Champorado with Tuyo',
        description: 'Sweet chocolate rice porridge with dried fish',
        prepTime: 10,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 15,
        carbsPerServing: 62,
        fatPerServing: 9,
        instructions: '''1. Boil water in a pot
2. Add glutinous rice and cook until soft
3. Add cocoa powder and sugar, mix well
4. Cook until thick and creamy
5. Serve hot with tuyo (dried fish) on the side
6. Enjoy the sweet and savory combination!''',
        isFilipinoDish: true,
        ingredients: ['glutinous rice', 'cocoa powder', 'sugar', 'tuyo', 'water'],
        tags: ['filipino', 'breakfast', 'comfort food'],
        allergens: ['fish'],
        rating: 4.7,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/champorado-tuyo.jpg',
      ),
      Recipe(
        id: 207,
        name: 'Ginataang Mais',
        description: 'Sweet corn in coconut milk - Filipino breakfast porridge',
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 8,
        carbsPerServing: 45,
        fatPerServing: 12,
        instructions: '''1. Boil water in a pot
2. Add corn kernels and cook until soft
3. Add coconut milk and sugar
4. Simmer until thick and creamy
5. Serve hot and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['corn kernels', 'coconut milk', 'sugar', 'water'],
        tags: ['filipino', 'breakfast', 'vegetarian'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ginataang-mais.jpg',
      ),
      Recipe(
        id: 208,
        name: 'Pandesal with Cheese',
        description: 'Filipino bread roll with cheese filling',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 280,
        proteinPerServing: 12,
        carbsPerServing: 35,
        fatPerServing: 8,
        instructions: '''1. Slice pandesal bread in half
2. Toast until golden brown
3. Add cheese slices inside
4. Serve warm with coffee or hot chocolate
5. Enjoy the simple Filipino breakfast!''',
        isFilipinoDish: true,
        ingredients: ['pandesal', 'cheese', 'butter'],
        tags: ['filipino', 'breakfast', 'quick'],
        allergens: ['dairy', 'wheat'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/pandesal-cheese.jpg',
      ),
    ];
  }

  // Get detailed cooking steps for each recipe
  List<String> _getRecipeSteps(Recipe recipe) {
    // Return detailed step-by-step instructions based on recipe name
    switch (recipe.name) {
      case 'Adobong Manok':
        return [
          'Hugasan at patuyuin ang manok',
          'I-marinate ang manok sa toyo, suka, at bawang ng 30 minutes',
          'Igisa ang bawang hanggang mabango',
          'Ilagay ang manok at marinade',
          'Dagdagan ng dahon ng laurel at paminta',
          'Pakuluan ng 30-40 minutes o hanggang lumambot',
          'Adjust lasa kung kailangan',
          'Ihain kasama ng mainit na kanin'
        ];
      case 'Sinigang na Baboy':
        return [
          'Pakuluan ang baboy sa tubig na may sibuyas',
          'Alisin ang unang kulo',
          'Dagdagan ng bagong tubig at pakuluan ulit',
          'Ilagay ang kamatis at labanos',
          'Timplahan ng sampalok o sinigang mix',
          'Idagdag ang sitaw at talong',
          'Sa huli, ilagay ang kangkong at sili',
          'Ihain ng mainit'
        ];
      case 'Pancit Canton':
        return [
          'Lutuin ang canton noodles ayon sa instruction',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang karne at lutuin',
          'Idagdag ang gulay at igisa',
          'Ilagay ang canton at haluin',
          'Timplahan ng toyo at patis',
          'Garnish ng calamansi at chicharon'
        ];
      case 'Tinolang Manok':
        return [
          'Igisa ang luya, bawang, at sibuyas',
          'Ilagay ang manok at lutuin hanggang medyo brown',
          'Dagdagan ng tubig at pakuluan',
          'Ilagay ang sayote',
          'Timplahan ng patis',
          'Idagdag ang dahon ng sili at malunggay',
          'Ihain ng mainit'
        ];
      case 'Kare-Kare':
        return [
          'Pakuluan ang buntot ng baka hanggang lumambot (2-3 hours)',
          'Giling ang mani o gumamit ng peanut butter',
          'Lagyan ng kulay gamit ang atsuete',
          'Ilagay ang mani sauce sa karne',
          'Idagdag ang gulay',
          'Lutuin hanggang malapot',
          'Ihain kasama ng bagoong'
        ];
      case 'Ginisang Sitaw at Kalabasa':
        return [
          'Igisa ang bawang, sibuyas, at bagoong',
          'Ilagay ang kalabasa',
          'Dagdagan ng konting tubig',
          'Pakuluan hanggang medyo lumalambot',
          'Ibuhos ang gata',
          'Idagdag ang sitaw at sili',
          'Pakuluan ng 5 minutes',
          'Ihain'
        ];
      case 'Chicken Inasal':
        return [
          'Gawa ang marinade: calamansi, lemongrass, bawang, luya, toyo',
          'Marinate ang manok ng 4 hours o overnight',
          'Ihanda ang achuete oil para sa basting',
          'Ihaw ang manok ng mabagal',
          'Basting ng achuete oil habang naghihiaw',
          'Baliktarin at ulitin',
          'Ihain kasama ng kanin at atsara'
        ];
      case 'Bulalo':
        return [
          'Pakuluan ang bulalo sa malaking kaldero',
          'Alisin ang unang kulo',
          'Dagdagan ng bagong tubig at pakuluan ng 2-3 hours',
          'Ilagay ang mais',
          'Timplahan ng patis at paminta',
          'Idagdag ang gulay sa huli',
          'Ihain ng mainit na mainit'
        ];
      case 'Lechon Kawali':
        return [
          'Hugasan at patuyuin ang liempo',
          'Lagyan ng asin at paminta',
          'Pakuluan sa tubig na may bawang ng 45 minutes',
          'Patuyuin at lagyan ng suka',
          'Iprito sa malalim na mantika hanggang golden brown',
          'Hiwain ng makapal',
          'Ihain kasama ng sarsa'
        ];
      case 'Bicol Express':
        return [
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang liempo at lutuin hanggang brown',
          'Idagdag ang bagoong',
          'Ibuhos ang gata',
          'Pakuluan ng 20 minutes',
          'Ilagay ang sili at tanglad',
          'Lutuin ng 10 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Sisig':
        return [
          'Lutuin ang baboy at atay',
          'Hiwain ng maliliit',
          'Igisa ang sibuyas',
          'Ilagay ang baboy at atay',
          'Lagyan ng sili at calamansi',
          'Haluan ng mayonnaise',
          'Lagyan ng itlog at chicharon',
          'Ihain sa mainit na plato'
        ];
      case 'Laing':
        return [
          'Hugasan ang dahon ng gabi',
          'Igisa ang bawang, sibuyas, at luya',
          'Idagdag ang bagoong',
          'Ilagay ang dahon ng gabi',
          'Ibuhos ang gata',
          'Pakuluan ng 30 minutes',
          'Ilagay ang sili',
          'Lutuin ng 10 minutes pa'
        ];
      case 'Pinakbet':
        return [
          'Hugasan at hiwain ang lahat ng gulay',
          'Igisa ang bawang at sibuyas',
          'Idagdag ang bagoong',
          'Ilagay ang kalabasa',
          'Dagdagan ng konting tubig',
          'Pakuluan ng 10 minutes',
          'Idagdag ang ibang gulay',
          'Lutuin hanggang malambot'
        ];
      case 'Beef Caldereta':
        return [
          'Lutuin ang beef hanggang lumambot',
          'Igisa ang bawang, sibuyas, at kamatis',
          'Ilagay ang beef at stock',
          'Dagdagan ng bay leaves',
          'Pakuluan ng 1 hour',
          'Idagdag ang patatas at bell peppers',
          'Haluan ng gatas at cheese',
          'Lutuin hanggang malapot'
        ];
      case 'Chicken Curry':
        return [
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang manok at lutuin',
          'Lagyan ng curry powder',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Idagdag ang patatas at carrots',
          'Ibuhos ang gata',
          'Lutuin hanggang malambot'
        ];
      case 'Ginisang Munggo':
        return [
          'Lutuin ang munggo hanggang malambot',
          'Igisa ang bawang, sibuyas, at kamatis',
          'Idagdag ang alamang',
          'Ilagay ang lutong munggo',
          'Timplahan ng patis',
          'Idagdag ang malunggay',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Crispy Pata':
        return [
          'Pakuluan ang pata sa tubig na may asin, paminta, at bay leaves',
          'Lutuin ng 1-2 hours hanggang lumambot',
          'Patuyuin at lagyan ng suka',
          'Iprito sa malalim na mantika',
          'Lutuin hanggang golden brown at crispy',
          'Hiwain ng makapal',
          'Ihain kasama ng sarsa'
        ];
      case 'Dinuguan':
        return [
          'Lutuin ang baboy hanggang lumambot',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang baboy',
          'Dagdagan ng suka',
          'Idagdag ang dugo ng baboy',
          'Pakuluan ng 20 minutes',
          'Lagyan ng sili at bay leaves',
          'Lutuin hanggang malapot'
        ];
      case 'Paksiw na Isda':
        return [
          'Hugasan ang isda',
          'Ilagay sa kaldero ang suka, patis, at tubig',
          'Idagdag ang luya, bawang, at sibuyas',
          'Ilagay ang isda',
          'Pakuluan ng 15 minutes',
          'Idagdag ang kamatis at sili',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Ginataang Alimango':
        return [
          'Hugasan ang alimango',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang alimango',
          'Dagdagan ng konting tubig',
          'Pakuluan ng 10 minutes',
          'Ibuhos ang gata',
          'Idagdag ang sili at tanglad',
          'Lutuin ng 15 minutes'
        ];
      case 'Pancit Bihon':
        return [
          'Soak ang bihon sa tubig ng 10 minutes',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang karne at lutuin',
          'Idagdag ang gulay',
          'Ilagay ang bihon',
          'Timplahan ng toyo at patis',
          'Haluin ng maigi',
          'Ihain kasama ng calamansi'
        ];
      case 'Tortang Talong':
        return [
          'Ihaw ang talong hanggang lumambot',
          'Alisin ang balat at i-flatten',
          'Gisa ang sibuyas at bawang',
          'Haluan ang itlog ng asin at paminta',
          'I-dip ang talong sa itlog',
          'Ilagay sa kawali kasama ang gisado',
          'Iprito hanggang golden brown',
          'Ihain kasama ng toyo'
        ];
      case 'Ginisang Ampalaya':
        return [
          'Hiwain ang ampalaya ng pahaba',
          'Alisin ang buto at puti sa loob',
          'Lagyan ng asin at i-massage',
          'Banlawan ng tubig at patuyuin',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang ampalaya',
          'Ilagay ang beaten eggs',
          'Lutuin hanggang luto ang itlog'
        ];
      case 'Chopsuey':
        return [
          'Hugasan at hiwain ang lahat ng gulay',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang carrots at repolyo',
          'Idagdag ang bell peppers',
          'Lagyan ng konting tubig',
          'Gawa ang sauce: toyo, cornstarch, at tubig',
          'Ihalo ang sauce sa gulay',
          'Lutuin hanggang malapot'
        ];
      case 'Kinilaw na Isda':
        return [
          'Hiwain ang isda ng maliliit na cubes',
          'Lagyan ng asin at i-massage',
          'Banlawan ng tubig',
          'Lagyan ng suka at i-marinate ng 10 minutes',
          'Idagdag ang luya, sibuyas, at sili',
          'Haluin ng maigi',
          'Ihain agad kasama ng calamansi'
        ];
      case 'Grilled Tilapia':
        return [
          'Hugasan at patuyuin ang tilapia',
          'Lagyan ng asin at paminta',
          'Lagyan ng lemon juice',
          'I-marinate ng 15 minutes',
          'I-grill sa medium heat',
          'Baliktarin pag may sear marks',
          'Lutuin hanggang luto',
          'Ihain kasama ng lemon wedges'
        ];
      case 'Steamed Lapu-Lapu':
        return [
          'Hugasan at patuyuin ang lapu-lapu',
          'Lagyan ng asin at paminta',
          'Ilagay sa steamer',
          'Lagyan ng luya at spring onions',
          'I-steam ng 15-20 minutes',
          'Lagyan ng light soy sauce',
          'Ihain ng mainit'
        ];
      case 'Adobong Kangkong':
        return [
          'Hugasan ang kangkong',
          'Hiwain ng 2-3 inches',
          'Igisa ang bawang',
          'Ilagay ang kangkong',
          'Lagyan ng toyo at suka',
          'Haluin ng maigi',
          'Lutuin ng 2-3 minutes lang',
          'Ihain agad'
        ];
      case 'Ginisang Togue':
        return [
          'Hugasan ang togue',
          'Alisin ang mga brown na bahagi',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang togue',
          'Lagyan ng patis',
          'Haluin ng maigi',
          'Lutuin ng 3-4 minutes lang',
          'Ihain agad'
        ];
      case 'Ensaladang Mangga':
        return [
          'Hiwain ang green mango ng strips',
          'Hiwain ang kamatis at sibuyas',
          'Ilagay sa bowl',
          'Lagyan ng asin',
          'Lagyan ng suka',
          'Haluin ng maigi',
          'Ihain agad'
        ];
      case 'Tinolang Isda':
        return [
          'Hugasan ang isda',
          'Igisa ang luya, bawang, at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang isda',
          'Pakuluan ng 10 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa'
        ];
      case 'Ginisang Sayote':
        return [
          'Hiwain ang sayote ng strips',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang sayote',
          'Lagyan ng konting tubig',
          'Pakuluan ng 8 minutes',
          'Idagdag ang hipon',
          'Lutuin ng 2 minutes pa',
          'Ihain'
        ];
      case 'Paksiw na Bangus':
        return [
          'Hugasan ang bangus',
          'Ilagay sa kawali',
          'Lagyan ng suka at tubig',
          'Idagdag ang luya, bawang, at sibuyas',
          'Pakuluan ng 15 minutes',
          'Baliktarin ang isda',
          'Lutuin ng 5 minutes pa',
          'Ihain'
        ];
      case 'Ginisang Upo':
        return [
          'Hiwain ang upo ng strips',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang upo',
          'Lagyan ng konting tubig',
          'Pakuluan ng 10 minutes',
          'Idagdag ang hipon',
          'Lutuin ng 2 minutes pa',
          'Ihain'
        ];
      case 'Ensaladang Talong at Kamatis':
        return [
          'Ihaw ang talong hanggang lumambot',
          'Alisin ang balat',
          'Hiwain ang kamatis at sibuyas',
          'Ilagay sa bowl',
          'Lagyan ng suka at asin',
          'Haluin ng maigi',
          'Ihain'
        ];
      case 'Sinigang na Hipon':
        return [
          'Hugasan ang hipon',
          'Pakuluan ang tubig',
          'Ilagay ang kamatis at labanos',
          'Timplahan ng sampalok',
          'Ilagay ang hipon',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes',
          'Ihain ng mainit'
        ];
      case 'Ginisang Repolyo':
        return [
          'Hiwain ang repolyo ng strips',
          'Hiwain ang carrots ng strips',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang carrots',
          'Lutuin ng 3 minutes',
          'Idagdag ang repolyo',
          'Lutuin ng 5 minutes',
          'Ihain'
        ];
      case 'Inihaw na Pusit':
        return [
          'Hugasan ang pusit',
          'Lagyan ng asin at paminta',
          'Lagyan ng calamansi juice',
          'I-marinate ng 10 minutes',
          'I-grill sa medium heat',
          'Baliktarin pag may sear marks',
          'Lutuin hanggang luto',
          'Ihain kasama ng calamansi'
        ];
      case 'Ginisang Pechay':
        return [
          'Hugasan ang pechay',
          'Hiwain ng 2-3 inches',
          'Igisa ang bawang',
          'Ilagay ang pechay',
          'Lagyan ng patis',
          'Haluin ng maigi',
          'Lutuin ng 3-4 minutes lang',
          'Ihain agad'
        ];
      case 'Steamed Okra':
        return [
          'Hugasan ang okra',
          'Alisin ang mga dulo',
          'Ilagay sa steamer',
          'I-steam ng 8 minutes',
          'Gawa ang dipping sauce: patis, suka, bawang',
          'Ihain kasama ng dipping sauce'
        ];
      case 'Ginisang Saluyot':
        return [
          'Hugasan ang saluyot',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang saluyot',
          'Lagyan ng konting tubig',
          'Pakuluan ng 8 minutes',
          'Idagdag ang hipon',
          'Lutuin ng 2 minutes pa',
          'Ihain'
        ];
      case 'Inihaw na Bangus':
        return [
          'Hugasan ang bangus',
          'Lagyan ng asin at paminta',
          'Lagyan ng lemon juice',
          'I-marinate ng 15 minutes',
          'I-stuff ng kamatis at sibuyas',
          'I-grill sa medium heat',
          'Baliktarin pag may sear marks',
          'Lutuin hanggang luto'
        ];
      case 'Ginisang Kamote Tops':
        return [
          'Hugasan ang kamote tops',
          'Hiwain ng 2-3 inches',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang kamote tops',
          'Lagyan ng konting tubig',
          'Lutuin ng 5-6 minutes',
          'Ihain'
        ];
      case 'Sinigang na Bangus':
        return [
          'Hugasan ang bangus',
          'Pakuluan ang tubig',
          'Ilagay ang kamatis at labanos',
          'Timplahan ng sampalok',
          'Ilagay ang bangus',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes',
          'Ihain ng mainit'
        ];
      case 'Ginisang Labanos':
        return [
          'Hiwain ang labanos ng strips',
          'Hiwain ang carrots ng strips',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang labanos',
          'Lagyan ng konting tubig',
          'Lutuin ng 8 minutes',
          'Idagdag ang carrots',
          'Lutuin ng 2 minutes pa'
        ];
      case 'Steamed Lapu-Lapu with Tofu':
        return [
          'Hugasan ang lapu-lapu',
          'Lagyan ng asin at paminta',
          'Hiwain ang tofu ng cubes',
          'Ilagay sa steamer ang isda',
          'Lagyan ng luya at spring onions',
          'Ilagay ang tofu',
          'I-steam ng 15-20 minutes',
          'Ihain ng mainit'
        ];
      case 'Pork Adobo':
        return [
          'Hugasan at patuyuin ang baboy',
          'I-marinate ang baboy sa toyo, suka, at bawang ng 30 minutes',
          'Igisa ang bawang hanggang mabango',
          'Ilagay ang baboy at marinade',
          'Dagdagan ng dahon ng laurel at paminta',
          'Pakuluan ng 30-40 minutes o hanggang lumambot',
          'Adjust lasa kung kailangan',
          'Ihain kasama ng mainit na kanin'
        ];
      case 'Adobong Sitaw':
        return [
          'Hugasan ang sitaw at hiwain ng 2 inches',
          'Igisa ang bawang hanggang mabango',
          'Ilagay ang sitaw',
          'Lagyan ng toyo at suka',
          'Haluin ng maigi',
          'Lutuin ng 5-7 minutes',
          'Ihain agad'
        ];
      case 'Pares (Beef Stew)':
        return [
          'Lutuin ang beef hanggang lumambot',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang beef at stock',
          'Dagdagan ng star anise at bay leaves',
          'Pakuluan ng 1 hour',
          'Idagdag ang patatas at carrots',
          'Lutuin hanggang malambot',
          'Ihain kasama ng kanin'
        ];
      case 'Tinola':
        return [
          'Igisa ang luya, bawang, at sibuyas',
          'Ilagay ang manok at lutuin hanggang medyo brown',
          'Dagdagan ng tubig at pakuluan',
          'Ilagay ang sayote',
          'Timplahan ng patis',
          'Idagdag ang dahon ng sili at malunggay',
          'Ihain ng mainit'
        ];
      case 'Kaldereta':
        return [
          'Lutuin ang beef hanggang lumambot',
          'Igisa ang bawang, sibuyas, at kamatis',
          'Ilagay ang beef at stock',
          'Dagdagan ng bay leaves',
          'Pakuluan ng 1 hour',
          'Idagdag ang patatas at bell peppers',
          'Haluan ng gatas at cheese',
          'Lutuin hanggang malapot'
        ];
      case 'Menudo':
        return [
          'Lutuin ang baboy at atay',
          'Hiwain ng maliliit',
          'Igisa ang bawang, sibuyas, at kamatis',
          'Ilagay ang baboy at atay',
          'Dagdagan ng tomato sauce',
          'Pakuluan ng 30 minutes',
          'Idagdag ang patatas at carrots',
          'Lutuin hanggang malambot'
        ];
      case 'Afritada':
        return [
          'Igisa ang bawang, sibuyas, at kamatis',
          'Ilagay ang manok at lutuin',
          'Lagyan ng tomato sauce',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Idagdag ang patatas at carrots',
          'Lutuin hanggang malambot',
          'Ihain kasama ng kanin'
        ];
      case 'Ginataang Langka':
        return [
          'Hiwain ang langka ng maliliit',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang langka',
          'Ibuhos ang gata',
          'Pakuluan ng 20 minutes',
          'Idagdag ang sili',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Shanghai':
        return [
          'Gisa ang baboy, carrots, at sibuyas',
          'Lagyan ng asin at paminta',
          'I-wrap sa spring roll wrapper',
          'I-seal ang mga gilid',
          'Iprito sa malalim na mantika',
          'Lutuin hanggang golden brown',
          'Ihain kasama ng sweet and sour sauce'
        ];
      case 'Bulalo':
        return [
          'Pakuluan ang bulalo sa malaking kaldero',
          'Alisin ang unang kulo',
          'Dagdagan ng bagong tubig at pakuluan ng 2-3 hours',
          'Ilagay ang mais',
          'Timplahan ng patis at paminta',
          'Idagdag ang gulay sa huli',
          'Ihain ng mainit na mainit'
        ];
      case 'Pochero':
        return [
          'Lutuin ang beef hanggang lumambot',
          'Igisa ang bawang, sibuyas, at kamatis',
          'Ilagay ang beef at stock',
          'Dagdagan ng bay leaves',
          'Pakuluan ng 1 hour',
          'Idagdag ang patatas at carrots',
          'Lutuin hanggang malambot',
          'Ihain kasama ng kanin'
        ];
      case 'Bistek Tagalog':
        return [
          'I-marinate ang beef sa toyo at calamansi',
          'Igisa ang sibuyas',
          'Ilagay ang beef at lutuin',
          'Dagdagan ng marinade',
          'Pakuluan ng 10 minutes',
          'Baliktarin ang beef',
          'Lutuin ng 5 minutes pa',
          'Ihain kasama ng sibuyas'
        ];
      case 'Arroz Caldo':
        return [
          'Igisa ang luya at bawang',
          'Ilagay ang manok at lutuin',
          'Dagdagan ng kanin',
          'Ibuhos ang chicken broth',
          'Pakuluan ng 20 minutes',
          'Timplahan ng patis',
          'Garnish ng spring onions',
          'Ihain ng mainit'
        ];
      case 'Tocilog':
        return [
          'Lutuin ang tocino sa kawali',
          'Igisa ang kanin sa bawang',
          'Iprito ang itlog',
          'Ihain ang tocino, sinangag, at itlog',
          'Lagyan ng calamansi',
          'Ihain kasama ng atsara'
        ];
      case 'Longsilog':
        return [
          'Lutuin ang longganisa sa kawali',
          'Igisa ang kanin sa bawang',
          'Iprito ang itlog',
          'Ihain ang longganisa, sinangag, at itlog',
          'Lagyan ng calamansi',
          'Ihain kasama ng atsara'
        ];
      case 'Lechon (Roast Pork)':
        return [
          'Hugasan at patuyuin ang baboy',
          'Lagyan ng asin, paminta, at luya',
          'I-stuff ng lemongrass at bawang',
          'I-roast sa oven ng 4-5 hours',
          'Basting ng oil habang naghihiaw',
          'Lutuin hanggang crispy ang balat',
          'Hiwain ng makapal',
          'Ihain kasama ng sarsa'
        ];
      case 'La Paz Batchoy':
        return [
          'Lutuin ang noodles ayon sa instruction',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang baboy at atay',
          'Dagdagan ng broth',
          'Pakuluan ng 15 minutes',
          'Ilagay ang noodles',
          'Garnish ng chicharon at spring onions',
          'Ihain ng mainit'
        ];
      case 'Pancit Malabon':
        return [
          'Lutuin ang noodles ayon sa instruction',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang seafood',
          'Dagdagan ng thick sauce',
          'Pakuluan ng 10 minutes',
          'Ilagay ang noodles',
          'Haluin ng maigi',
          'Ihain kasama ng calamansi'
        ];
      case 'Pancit Palabok':
        return [
          'Lutuin ang noodles ayon sa instruction',
          'Gawa ang shrimp sauce',
          'Ilagay ang noodles sa plato',
          'Lagyan ng shrimp sauce',
          'Garnish ng shrimp, chicharon, at spring onions',
          'Ihain kasama ng calamansi'
        ];
      case 'Monggo Guisado':
        return [
          'Lutuin ang munggo hanggang malambot',
          'Igisa ang bawang, sibuyas, at kamatis',
          'Idagdag ang alamang',
          'Ilagay ang lutong munggo',
          'Timplahan ng patis',
          'Idagdag ang malunggay',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Nilaga na Baka':
        return [
          'Pakuluan ang beef sa tubig',
          'Alisin ang unang kulo',
          'Dagdagan ng bagong tubig',
          'Pakuluan ng 1 hour',
          'Ilagay ang patatas at carrots',
          'Timplahan ng asin at paminta',
          'Idagdag ang repolyo',
          'Ihain ng mainit'
        ];
      case 'Nilagang Baboy':
        return [
          'Pakuluan ang baboy sa tubig',
          'Alisin ang unang kulo',
          'Dagdagan ng bagong tubig',
          'Pakuluan ng 45 minutes',
          'Ilagay ang patatas at carrots',
          'Timplahan ng asin at paminta',
          'Idagdag ang repolyo',
          'Ihain ng mainit'
        ];
      case 'Lomi':
        return [
          'Lutuin ang thick noodles ayon sa instruction',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang baboy',
          'Dagdagan ng broth',
          'Pakuluan ng 10 minutes',
          'Ilagay ang noodles',
          'Garnish ng spring onions',
          'Ihain ng mainit'
        ];
      case 'Mami (Chicken Noodle)':
        return [
          'Lutuin ang noodles ayon sa instruction',
          'Igisa ang bawang at sibuyas',
          'Ilagay ang manok',
          'Dagdagan ng broth',
          'Pakuluan ng 15 minutes',
          'Ilagay ang noodles',
          'Garnish ng spring onions',
          'Ihain ng mainit'
        ];
      case 'Suam na Mais':
        return [
          'Igisa ang bawang at sibuyas',
          'Ilagay ang mais',
          'Dagdagan ng broth',
          'Pakuluan ng 15 minutes',
          'Timplahan ng patis',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Ginataang Kalabasa':
        return [
          'Hiwain ang kalabasa ng cubes',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang kalabasa',
          'Ibuhos ang gata',
          'Pakuluan ng 15 minutes',
          'Idagdag ang sili',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Inihaw na Liempo':
        return [
          'I-marinate ang liempo sa toyo, bawang, at calamansi',
          'I-marinate ng 2 hours',
          'I-grill sa medium heat',
          'Baliktarin pag may sear marks',
          'Lutuin hanggang luto',
          'Hiwain ng makapal',
          'Ihain kasama ng kanin'
        ];
      case 'Inihaw na Bangus':
        return [
          'Hugasan ang bangus',
          'Lagyan ng asin at paminta',
          'Lagyan ng calamansi juice',
          'I-marinate ng 15 minutes',
          'I-grill sa medium heat',
          'Baliktarin pag may sear marks',
          'Lutuin hanggang luto',
          'Ihain kasama ng calamansi'
        ];
      case 'Inihaw na Manok':
        return [
          'I-marinate ang manok sa toyo, bawang, at calamansi',
          'I-marinate ng 2 hours',
          'I-grill sa medium heat',
          'Baliktarin pag may sear marks',
          'Lutuin hanggang luto',
          'Ihain kasama ng kanin'
        ];
      case 'Pritong Tilapia':
        return [
          'Hugasan ang tilapia',
          'Lagyan ng asin at paminta',
          'Lagyan ng harina',
          'Iprito sa malalim na mantika',
          'Lutuin hanggang golden brown',
          'Baliktarin',
          'Lutuin ng 3 minutes pa',
          'Ihain kasama ng toyo at calamansi'
        ];
      case 'Daing na Bangus':
        return [
          'Hugasan ang dried bangus',
          'Lagyan ng suka at bawang',
          'I-marinate ng 10 minutes',
          'Iprito sa malalim na mantika',
          'Lutuin hanggang crispy',
          'Baliktarin',
          'Lutuin ng 3 minutes pa',
          'Ihain kasama ng toyo at calamansi'
        ];
      case 'Escabeche':
        return [
          'Iprito ang isda hanggang golden brown',
          'Igisa ang sibuyas at luya',
          'Dagdagan ng suka at asukal',
          'Pakuluan ng 5 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 3 minutes pa',
          'Ihain kasama ng kanin'
        ];
      case 'Ginataang Hipon':
        return [
          'Hugasan ang hipon',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang hipon',
          'Dagdagan ng konting tubig',
          'Pakuluan ng 5 minutes',
          'Ibuhos ang gata',
          'Idagdag ang sili',
          'Lutuin ng 10 minutes pa'
        ];
      case 'Tinolang Tahong':
        return [
          'Hugasan ang tahong',
          'Igisa ang luya, bawang, at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang tahong',
          'Pakuluan ng 10 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa'
        ];
      case 'Sinigang na Bangus':
        return [
          'Hugasan ang bangus',
          'Pakuluan ang tubig',
          'Ilagay ang kamatis at labanos',
          'Timplahan ng sampalok',
          'Ilagay ang bangus',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes',
          'Ihain ng mainit'
        ];
      case 'Sinigang na Salmon':
        return [
          'Hugasan ang salmon',
          'Pakuluan ang tubig',
          'Ilagay ang kamatis at labanos',
          'Timplahan ng sampalok',
          'Ilagay ang salmon',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes',
          'Ihain ng mainit'
        ];
      case 'Papaitan':
        return [
          'Lutuin ang goat innards hanggang lumambot',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang innards',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Idagdag ang bitter herbs',
          'Lutuin ng 10 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Pesa':
        return [
          'Hugasan ang isda',
          'Igisa ang luya, bawang, at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang isda',
          'Pakuluan ng 10 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa'
        ];
      case 'Balbacua':
        return [
          'Lutuin ang oxtail hanggang lumambot (3 hours)',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang oxtail',
          'Dagdagan ng stock',
          'Pakuluan ng 1 hour',
          'Idagdag ang gulay',
          'Lutuin hanggang malambot',
          'Ihain ng mainit'
        ];
      case 'Sinampalukang Manok':
        return [
          'Igisa ang luya, bawang, at sibuyas',
          'Ilagay ang manok at lutuin',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Ilagay ang tamarind leaves',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Sinabawang Tahong':
        return [
          'Hugasan ang tahong',
          'Igisa ang bawang at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang tahong',
          'Pakuluan ng 10 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa'
        ];
      case 'Sinabawang Baboy':
        return [
          'Igisa ang bawang at sibuyas',
          'Ilagay ang baboy at lutuin',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes pa',
          'Ihain ng mainit'
        ];
      case 'KBL (Kadyos, Baboy, Langka)':
        return [
          'Lutuin ang kadyos hanggang malambot',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang baboy at lutuin',
          'Dagdagan ng tubig',
          'Pakuluan ng 30 minutes',
          'Ilagay ang langka',
          'Ibuhos ang gata',
          'Lutuin ng 15 minutes pa'
        ];
      case 'Laswa':
        return [
          'Hugasan ang lahat ng gulay',
          'Igisa ang bawang at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang gulay',
          'Lutuin ng 10 minutes',
          'Timplahan ng patis',
          'Ihain ng mainit'
        ];
      case 'Bulanglang':
        return [
          'Hugasan ang lahat ng gulay',
          'Igisa ang bawang, sibuyas, at luya',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang gulay',
          'Ibuhos ang gata',
          'Lutuin ng 15 minutes',
          'Ihain ng mainit'
        ];
      case 'Pinangat na Isda':
        return [
          'Hugasan ang isda',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang isda',
          'Ibuhos ang gata',
          'Pakuluan ng 15 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Pangat na Bangus':
        return [
          'Hugasan ang bangus',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang bangus',
          'Ibuhos ang gata',
          'Pakuluan ng 15 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Sinanglay na Tilapia':
        return [
          'Hugasan ang tilapia',
          'I-wrap sa taro leaves',
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang wrapped tilapia',
          'Ibuhos ang gata',
          'Pakuluan ng 20 minutes',
          'Lutuin ng 5 minutes pa',
          'Ihain ng mainit'
        ];
      case 'Nilagang Manok':
        return [
          'Igisa ang bawang at sibuyas',
          'Ilagay ang manok at lutuin',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes pa',
          'Timplahan ng patis',
          'Ihain ng mainit'
        ];
      case 'Sinampalukang Isda':
        return [
          'Hugasan ang isda',
          'Igisa ang luya, bawang, at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang isda',
          'Ilagay ang tamarind leaves',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes pa'
        ];
      case 'Sinabawang Labong':
        return [
          'Hugasan ang labong',
          'Igisa ang bawang at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang labong',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes',
          'Ihain ng mainit'
        ];
      case 'Sinabawang Labanosa':
        return [
          'Hugasan ang labanosa',
          'Igisa ang bawang at sibuyas',
          'Dagdagan ng tubig',
          'Pakuluan ng 5 minutes',
          'Ilagay ang labanosa',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes',
          'Ihain ng mainit'
        ];
      case 'Sinigang sa Bayabas':
        return [
          'Igisa ang bawang, sibuyas, at luya',
          'Ilagay ang karne at lutuin',
          'Dagdagan ng tubig',
          'Pakuluan ng 20 minutes',
          'Ilagay ang bayabas',
          'Idagdag ang gulay',
          'Lutuin ng 10 minutes pa',
          'Ihain ng mainit'
        ];
      
      // Filipino Dessert Recipes
      case 'Bibingka':
        return [
          'Ihanda ang malagkit na bigas',
          'I-mix ang bigas sa gata at asukal',
          'Ilagay sa banana leaves',
          'I-bake sa 350°F ng 25 minutes',
          'I-check kung luto na',
          'Ihain ng mainit'
        ];
      case 'Biko':
        return [
          'Lutuin ang malagkit na bigas',
          'I-mix ang gata at brown sugar',
          'I-cook hanggang lumapot',
          'Ilagay sa llanera',
          'I-top ng latik',
          'Ihain ng mainit'
        ];
      case 'Halo-Halo':
        return [
          'Ihanda ang shaved ice',
          'Ilagay ang ube halaya',
          'Idagdag ang leche flan',
          'I-top ng sago at nata de coco',
          'I-pour ang evaporated milk',
          'Ihain ng malamig'
        ];
      case 'Leche Flan':
        return [
          'I-melt ang asukal para sa caramel',
          'I-pour sa llanera',
          'I-mix ang itlog at gatas',
          'I-pour sa llanera',
          'I-steam ng 40 minutes',
          'I-chill bago ihain'
        ];
      case 'Ube Halaya':
        return [
          'I-boil ang ube hanggang lumambot',
          'I-mash ang ube',
          'I-mix sa gata at asukal',
          'I-cook hanggang lumapot',
          'I-stir ng tuloy-tuloy',
          'Ihain ng malamig'
        ];
      case 'Sans Rival':
        return [
          'I-make ang cashew meringue',
          'I-bake ang meringue layers',
          'I-make ang buttercream',
          'I-layer ang meringue at buttercream',
          'I-chill ng 2 hours',
          'Ihain ng malamig'
        ];
      case 'Polvoron':
        return [
          'I-toast ang harina',
          'I-mix sa powdered milk at asukal',
          'I-add ang mantikilya',
          'I-shape sa molds',
          'I-wrap sa cellophane',
          'Ihain'
        ];
      case 'Yema':
        return [
          'I-mix ang condensed milk at egg yolks',
          'I-cook sa low heat',
          'I-stir hanggang lumapot',
          'I-shape sa balls',
          'I-wrap sa cellophane',
          'Ihain'
        ];
      case 'Turon':
        return [
          'I-peel ang saging',
          'I-add ang langka',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden brown',
          'I-drain ang oil',
          'Ihain ng mainit'
        ];
      case 'Puto':
        return [
          'I-mix ang rice flour at asukal',
          'I-add ang water at baking powder',
          'I-pour sa molds',
          'I-steam ng 20 minutes',
          'I-check kung luto na',
          'Ihain ng mainit'
        ];
      case 'Kutsinta':
        return [
          'I-mix ang rice flour at brown sugar',
          'I-add ang lye water',
          'I-pour sa molds',
          'I-steam ng 25 minutes',
          'I-check kung luto na',
          'Ihain ng mainit'
        ];
      case 'Pichi-Pichi':
        return [
          'I-mix ang cassava at asukal',
          'I-add ang water',
          'I-steam ng 20 minutes',
          'I-roll sa niyog',
          'Ihain ng mainit'
        ];
      case 'Sapin-Sapin':
        return [
          'I-make ang different colored layers',
          'I-steam ang first layer',
          'I-add ang second layer',
          'I-steam ulit',
          'I-repeat hanggang matapos',
          'Ihain ng mainit'
        ];
      case 'Maja Blanca':
        return [
          'I-mix ang gata at cornstarch',
          'I-add ang asukal',
          'I-cook hanggang lumapot',
          'I-pour sa llanera',
          'I-top ng latik',
          'Ihain ng malamig'
        ];
      case 'Ginataang Bilo-Bilo':
        return [
          'I-make ang glutinous rice balls',
          'I-cook sa gata',
          'I-add ang kamote at sago',
          'I-cook ng 25 minutes',
          'Ihain ng mainit'
        ];
      case 'Taho':
        return [
          'I-heat ang silken tofu',
          'I-make ang brown sugar syrup',
          'I-cook ang sago',
          'I-pour ang syrup sa tofu',
          'I-top ng sago',
          'Ihain ng mainit'
        ];
      case 'Buko Pandan':
        return [
          'I-make ang pandan jelly',
          'I-mix sa young coconut',
          'I-add ang cream at condensed milk',
          'I-chill ng 2 hours',
          'Ihain ng malamig'
        ];
      case 'Mais Con Yelo':
        return [
          'I-prepare ang sweet corn',
          'I-add ang shaved ice',
          'I-pour ang evaporated milk',
          'I-top ng asukal',
          'Ihain ng malamig'
        ];
      case 'Gulaman':
        return [
          'I-dissolve ang agar powder',
          'I-add ang asukal at flavoring',
          'I-pour sa molds',
          'I-chill hanggang mag-set',
          'Ihain ng malamig'
        ];
      case 'Sago at Gulaman':
        return [
          'I-cook ang sago pearls',
          'I-make ang gulaman jelly',
          'I-mix sa brown sugar syrup',
          'I-add ang ice',
          'Ihain ng malamig'
        ];
      case 'Puto Bumbong':
        return [
          'I-mix ang purple rice flour sa gata',
          'I-steam sa bamboo tubes',
          'I-top ng niyog at latik',
          'Ihain ng mainit'
        ];
      case 'Bibingkang Malagkit':
        return [
          'I-mix ang malagkit na bigas sa gata',
          'I-add ang asukal',
          'I-bake hanggang mag-set',
          'I-top ng latik',
          'Ihain ng mainit'
        ];
      case 'Kakanin':
        return [
          'I-make ang different rice cakes',
          'I-add ang different colors',
          'I-steam o i-bake',
          'Ihain ng mainit'
        ];
      case 'Buko Salad':
        return [
          'I-prepare ang young coconut',
          'I-mix sa mixed fruits',
          'I-add ang cream at condensed milk',
          'I-top ng cheese',
          'I-chill ng 2 hours',
          'Ihain ng malamig'
        ];
      case 'Macapuno':
        return [
          'I-cook ang macapuno sa asukal',
          'I-add ang water',
          'I-cook hanggang lumapot',
          'Ihain ng malamig'
        ];
      case 'Buko Pie':
        return [
          'I-make ang pie crust',
          'I-prepare ang young coconut filling',
          'I-add ang milk at cornstarch',
          'I-bake hanggang golden',
          'Ihain ng malamig'
        ];
      case 'Ensaymada':
        return [
          'I-make ang sweet bread dough',
          'I-roll sa butter at asukal',
          'I-top ng cheese',
          'I-bake ng 25 minutes',
          'Ihain ng mainit'
        ];
      case 'Pan de Sal':
        return [
          'I-make ang bread dough',
          'I-add ang salt',
          'I-shape sa rolls',
          'I-bake hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Pandesal':
        return [
          'I-make ang sweet bread dough',
          'I-shape sa rolls',
          'I-bake hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Monay':
        return [
          'I-make ang dense bread dough',
          'I-shape sa oval',
          'I-bake hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Spanish Bread':
        return [
          'I-make ang sweet bread dough',
          'I-fill sa butter at asukal mixture',
          'I-bake ng 25 minutes',
          'Ihain ng mainit'
        ];
      case 'Hopia':
        return [
          'I-make ang flaky pastry dough',
          'I-fill sa sweet bean paste',
          'I-bake hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Hopiang Baboy':
        return [
          'I-make ang flaky pastry dough',
          'I-fill sa seasoned pork',
          'I-bake hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Empanada':
        return [
          'I-make ang pastry dough',
          'I-fill sa meat mixture',
          'I-seal at i-fry',
          'Ihain ng mainit'
        ];
      case 'Siopao':
        return [
          'I-make ang bun dough',
          'I-fill sa meat mixture',
          'I-steam hanggang luto',
          'Ihain ng mainit'
        ];
      case 'Siomai':
        return [
          'I-make ang dumpling wrapper',
          'I-fill sa meat mixture',
          'I-steam hanggang luto',
          'Ihain ng mainit'
        ];
      case 'Lumpia':
        return [
          'I-prepare ang vegetable mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Gulay':
        return [
          'I-prepare ang mixed vegetables',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Sariwa':
        return [
          'I-prepare ang fresh vegetables',
          'I-wrap sa rice paper',
          'I-serve sa sweet sauce',
          'Ihain'
        ];
      case 'Lumpiang Hubad':
        return [
          'I-mix ang vegetables sa sauce',
          'I-serve without wrapper',
          'Ihain'
        ];
      case 'Lumpiang Togue':
        return [
          'I-prepare ang bean sprouts',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Ubod':
        return [
          'I-prepare ang heart of palm mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Singkamas':
        return [
          'I-prepare ang jicama mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Kamote':
        return [
          'I-prepare ang sweet potato mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Kalabasa':
        return [
          'I-prepare ang squash mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Sayote':
        return [
          'I-prepare ang chayote mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Upo':
        return [
          'I-prepare ang bottle gourd mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Patola':
        return [
          'I-prepare ang sponge gourd mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Talong':
        return [
          'I-prepare ang eggplant mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Ampalaya':
        return [
          'I-prepare ang bitter gourd mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Kangkong':
        return [
          'I-prepare ang water spinach mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Saluyot':
        return [
          'I-prepare ang jute leaves mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Malunggay':
        return [
          'I-prepare ang moringa leaves mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Pechay':
        return [
          'I-prepare ang Chinese cabbage mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Repolyo':
        return [
          'I-prepare ang cabbage mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      case 'Lumpiang Labanos':
        return [
          'I-prepare ang radish mixture',
          'I-wrap sa spring roll wrapper',
          'I-fry hanggang golden',
          'Ihain ng mainit'
        ];
      default:
        // Fallback for any recipe not explicitly listed
        return recipe.instructions.split('. ').where((step) => step.trim().isNotEmpty).toList();
    }
  }

  // Convert Recipe objects to Map format for ingredient search screen
  List<Map<String, dynamic>> getRecipesAsMaps() {
    return getAllRecipes().map((recipe) => {
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
      'steps': _getRecipeSteps(recipe),
      'comments': [
        {'user': 'Filipino Food Lover', 'comment': 'Authentic and delicious!'},
        {'user': 'Home Cook', 'comment': 'Perfect for family meals!'}
      ],
    }).toList();
  }

  // Search recipes by ingredients, name, or tags
  List<Recipe> searchRecipes(String query) {
    if (query.trim().isEmpty) return getAllRecipes();
    
    final inputList = query.split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    
    return getAllRecipes().where((recipe) {
      final ingredients = recipe.ingredients.map((e) => e.toLowerCase()).toList();
      final name = recipe.name.toLowerCase();
      final tags = recipe.tags.map((e) => e.toLowerCase()).toList();
      
      return inputList.every((needle) => 
        ingredients.any((ingredient) => ingredient.contains(needle.toLowerCase())) ||
        name.contains(needle.toLowerCase()) ||
        tags.any((tag) => tag.contains(needle.toLowerCase()))
      );
    }).toList();
  }

  // Get recipes by category
  List<Recipe> getRecipesByCategory(String category) {
    return getAllRecipes().where((recipe) => 
      recipe.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  // Get recipes by meal type
  List<Recipe> getRecipesByMealType(String mealType) {
    return getAllRecipes().where((recipe) {
      final recipeText = '${recipe.name} ${recipe.description}'.toLowerCase();
      
      switch (mealType.toLowerCase()) {
        case 'breakfast':
          return recipeText.contains('breakfast') || 
                 recipe.caloriesPerServing <= 400;
        case 'lunch':
          return recipeText.contains('lunch') ||
                 (recipe.caloriesPerServing >= 300 && recipe.caloriesPerServing <= 600);
        case 'dinner':
          return recipeText.contains('dinner') ||
                 recipe.caloriesPerServing >= 400;
        case 'snack':
          return recipeText.contains('snack') ||
                 recipe.caloriesPerServing <= 200;
        default:
          return true;
      }
    }).toList();
  }

  // Get Filipino dishes only
  List<Recipe> getFilipinoDishes() {
    return getAllRecipes().where((recipe) => recipe.isFilipinoDish).toList();
  }

  // Get healthy dishes
  List<Recipe> getHealthyDishes() {
    return getAllRecipes().where((recipe) => 
      recipe.caloriesPerServing <= 350 && 
      recipe.category.toLowerCase() == 'healthy'
    ).toList();
  }
}
