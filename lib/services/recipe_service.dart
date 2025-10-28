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
        imageUrl: 'assets/images/Tapsilog.jpg',
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
        imageUrl: 'assets/images/ChamporadoWithTuyo.jpg',
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
        imageUrl: 'assets/images/PandesalWithScrambledEgg.jpg',
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
        imageUrl: 'assets/images/LugawWithEgg.jpg',
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
        imageUrl: 'assets/images/SinigangNaBaboy.jpg',
      ),
       Recipe(
        id: 7,
        name: 'Ensaladang Pipino',
        description: 'Cucumber salad with tomatoes - refreshing',
        prepTime: 10,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 35,
        proteinPerServing: 1,
        carbsPerServing: 7,
        fatPerServing: 0,
        instructions: '''1. Slice cucumbers thinly
2. Add diced tomatoes and onions
3. Make dressing: vinegar, calamansi, salt
4. Add a touch of stevia instead of sugar
5. Toss vegetables with dressing
6. Chill for 10 minutes
7. Serve cold as side dish''',
        isFilipinoDish: true,
        ingredients: ['cucumber', 'tomatoes', 'onions', 'vinegar', 'calamansi'],
        tags: ['healthy', 'salad', 'zero-fat', 'refreshing'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'assets/images/EnsaladangPipino.jpg',
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
        imageUrl: 'assets/images/FishSinigang.jpg',
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
        imageUrl: 'assets/images/PancitCanton.jpg',
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
        imageUrl: 'assets/images/TinolangManok.jpg',
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
        imageUrl: 'assets/images/KareKare.jpg',
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
        imageUrl: 'assets/images/LechonKawali.jpg',
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
        imageUrl: 'assets/images/ChickenAfritada.jpg',
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
        imageUrl: 'assets/images/Laing.jpg',
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
        imageUrl: 'assets/images/BicolExpress.jpg',
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
        instructions: '''1. Boil 500g pork face or belly and 200g pork liver in salted water until tender
2. Drain and let it cool, then chop into small pieces
3. In a pan, heat 2 tablespoons oil over medium heat
4. Sauté 1 chopped onion and 3 cloves minced garlic until fragrant
5. Add the chopped pork and liver, and cook until lightly crispy
6. Season with salt, pepper, and soy sauce to taste
7. Add 2 chopped chili peppers and mix well
8. Squeeze in juice from 2 calamansi (or 1 tablespoon lemon juice)
9. Crack 1 egg on top (optional) and stir quickly while still hot
10. Serve sizzling on a hot plate with extra calamansi and chili on the side''',
        isFilipinoDish: true,
        ingredients: ['pork', 'liver', 'onion', 'chili', 'calamansi', 'egg'],
        tags: ['filipino', 'dinner', 'spicy'],
        allergens: ['egg'],
        rating: 4.9,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'assets/images/Sisig.jpg',
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
        imageUrl: 'assets/images/Pinakbet.jpg',
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
        imageUrl: 'assets/images/BeefCaldereta.jpg',
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
        imageUrl: 'assets/images/ChickenCurry.jpg',
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
        instructions: '''1. Rinse 1 cup mung beans (munggo) and place in a pot with 4 cups water
2. Bring to a boil, then lower heat and simmer for 20–25 minutes until beans are soft
3. In a separate pan, heat 2 tablespoons oil over medium heat
4. Sauté 1 chopped onion and 3 cloves minced garlic until fragrant
5. Add 1 chopped tomato and cook until softened
6. Add the cooked mung beans with some of the broth and stir well
7. Season with 1 tablespoon fish sauce, salt, and pepper to taste
8. Add 1 cup leafy greens (like ampalaya leaves or spinach) and stir until wilted
9. Optional: Add fried or boiled pork, chicharon, or shrimp for extra flavor
10. Serve hot with steamed rice''',
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
        instructions: '''1. Clean 1 whole pork knuckle (pata) thoroughly and pat dry
2. Place pork knuckle in a large pot with enough water to cover
3. Add 1 tablespoon salt, 1 teaspoon peppercorns, 5 cloves garlic, and 2 tablespoons vinegar
4. Bring to a boil, then simmer for 1 to 1½ hours until tender
5. Remove from the pot and let it cool completely
6. Pat dry the pork skin with paper towels and refrigerate uncovered for several hours or overnight to help dry the skin
7. Heat enough oil in a deep fryer or large pot for deep frying
8. Carefully lower the pork knuckle into the hot oil and fry until golden brown and crispy (about 10–15 minutes)
9. Remove and drain excess oil on paper towels
10. Serve hot with a dipping sauce made of soy sauce, vinegar, chopped onion, garlic, and chili''',
        isFilipinoDish: true,
        ingredients: ['pork knuckle', 'salt', 'pepper', 'garlic', 'vinegar'],
        tags: ['filipino', 'dinner', 'special occasion'],
        allergens: [],
        rating: 4.9,
        cookTimeFormatted: '120 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'assets/images/CrispyPata.jpg',
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
        instructions: '''1. Cut 1 kg pork belly or pork shoulder into small cubes
2. In a pot, heat 2 tablespoons oil over medium heat
3. Sauté 1 chopped onion and 4 cloves minced garlic until fragrant
4. Add the pork and cook until lightly browned
5. Pour in 1 cup water and 1 cup vinegar, then bring to a boil without stirring
6. Lower the heat and simmer until pork is tender (about 30–40 minutes)
7. In a separate bowl, strain 1 cup fresh pig’s blood to remove clots
8. Slowly pour the blood into the pot while stirring continuously to prevent curdling
9. Add 2–3 chopped chili peppers (optional for spice)
10. Season with salt, pepper, and fish sauce to taste
11. Continue to simmer for another 10–15 minutes until the sauce thickens
12. Serve hot with steamed rice or puto (rice cakes)''',
        isFilipinoDish: true,
        ingredients: ['pork', 'pig blood', 'vinegar', 'garlic', 'chili'],
        tags: ['filipino', 'dinner', 'special occasion'],
        allergens: [],
        rating: 4.6,
        cookTimeFormatted: '60 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'assets/images/Dinuguan.jpg',
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
        imageUrl: 'assets/images/PaksiwnaIsda.jpg',
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
        imageUrl: 'assets/images/GinatangAlimango.jpg',
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
        instructions: '''1. Soak 400g rice noodles (bihon) in warm water for 10 minutes, then drain and set aside
2. In a large pan or wok, heat 2 tablespoons oil over medium heat
3. Sauté 3 cloves minced garlic and 1 chopped onion until fragrant
4. Add 200g sliced chicken (or pork) and cook until lightly browned
5. Pour in 2 cups chicken broth and 2 tablespoons soy sauce, then bring to a boil
6. Add sliced carrots, cabbage, and any other desired vegetables
7. Stir in the soaked bihon noodles and mix well to absorb the sauce
8. Continue cooking, tossing gently until noodles are tender and evenly coated
9. Season with salt, pepper, and a bit more soy sauce if needed
10. Garnish with sliced calamansi, green onions, and serve hot''',
        isFilipinoDish: true,
        ingredients: ['rice noodles', 'chicken', 'cabbage', 'carrots', 'soy sauce'],
        tags: ['filipino', 'dinner', 'noodles'],
        allergens: ['gluten', 'soy'],
        rating: 4.7,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'assets/images/PancitBihon.jpg',
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
        instructions: '''1. Grill or broil 4 medium-sized eggplants until the skin is charred and the flesh is soft
2. Let the eggplants cool slightly, then peel off the charred skin carefully
3. Flatten each eggplant gently using a fork
4. In a bowl, beat 4 eggs and season with salt and pepper
5. Optional: Add finely chopped onion and garlic to the egg mixture for extra flavor
6. Dip each flattened eggplant into the egg mixture, making sure it’s fully coated
7. Heat 2 tablespoons oil in a pan over medium heat
8. Fry each eggplant omelet until golden brown on both sides
9. Remove from pan and drain excess oil on paper towels
10. Serve hot with steamed rice and ketchup or soy sauce with calamansi''',
        isFilipinoDish: true,
        ingredients: ['eggplant', 'eggs', 'onion', 'garlic', 'salt'],
        tags: ['filipino', 'dinner', 'vegetarian'],
        allergens: ['egg'],
        rating: 4.5,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'assets/images/TortangTalong.jpg',
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
        instructions: '''1. Clean and cut 1 kg chicken (preferably leg quarters or breast with bone)
2. In a bowl, combine 3 cloves minced garlic, 1 thumb-sized ginger (grated), 1 stalk lemongrass (finely chopped), 3 tablespoons vinegar, 2 tablespoons soy sauce, 1 tablespoon calamansi or lemon juice, salt, and pepper
3. Mix well and marinate the chicken in this mixture for at least 2 hours or overnight for best flavor
4. In a small saucepan, melt 2 tablespoons butter or margarine with 1 tablespoon annatto (atsuete) oil and a pinch of salt — this will be the basting sauce
5. Preheat grill over medium heat and lightly oil the grates
6. Grill the chicken, turning occasionally, and baste with the annatto oil mixture for color and flavor
7. Continue grilling for 25–30 minutes or until the chicken is fully cooked and slightly charred
8. Remove from the grill and brush with a bit more annatto oil before serving
9. Serve hot with steamed rice, pickled papaya (atchara), and calamansi with soy sauce on the side''',
        isFilipinoDish: true,
        ingredients: ['chicken', 'lemongrass', 'annatto', 'garlic', 'soy sauce'],
        tags: ['filipino', 'dinner', 'grilled'],
        allergens: ['soy'],
        rating: 4.9,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'assets/images/ChickenInasal.jpg',
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
        instructions: '''1. In a large pot, place 1.5 kg beef shank with bone marrow and cover with water
2. Bring to a boil and skim off any scum or impurities that rise to the surface
3. Lower the heat, cover, and simmer for 2½ to 3 hours or until the meat is very tender
4. Add water as needed to keep the meat submerged during cooking
5. Once tender, season with 2 tablespoons fish sauce and 1 teaspoon ground pepper
6. Add 2 pieces corn on the cob (cut into sections) and cook for 10–15 minutes
7. Add 1 onion (quartered) and continue to simmer until the corn is cooked
8. Add vegetables such as pechay or cabbage, and cook for another 3–5 minutes
9. Taste and adjust seasoning with more fish sauce or salt if needed
10. Serve hot with steamed rice and a dipping sauce of fish sauce, calamansi, and chili''',
        isFilipinoDish: true,
        ingredients: ['beef shank', 'corn', 'cabbage', 'fish sauce', 'pepper'],
        tags: ['filipino', 'dinner', 'soup'],
        allergens: ['fish'],
        rating: 4.9,
        cookTimeFormatted: '180 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'assets/images/Bulalo.jpg',
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
        imageUrl: 'assets/images/BananaCue.jpg',
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
        instructions: '''1. Peel and slice 6 ripe saba bananas in half lengthwise
2. Place each banana slice on a spring roll wrapper
3. Sprinkle 1 teaspoon brown sugar over each banana and add a strip of jackfruit (optional)
4. Roll the wrapper tightly, folding the sides to seal, and brush the edge with a bit of water to close
5. Heat oil in a pan over medium heat
6. Once hot, fry the wrapped bananas until golden brown and crispy
7. Sprinkle additional brown sugar into the oil to create a caramelized coating (optional)
8. Remove and drain excess oil on paper towels
9. Serve warm as a sweet snack or dessert''',
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
        instructions: '''1. Clean and butterfly 1 whole bangus (milkfish), removing the scales and innards
2. In a small bowl, combine 3 cloves minced garlic, juice of 1 lemon (or calamansi), 1 tablespoon olive oil, salt, and pepper
3. Rub the mixture evenly on both sides of the fish and marinate for 15–20 minutes
4. Prepare foil or banana leaves and place sliced tomatoes, onions, and a bit of garlic inside the fish cavity
5. Wrap the bangus securely in the foil or banana leaves
6. Preheat grill to medium heat
7. Grill the fish for about 8–10 minutes on each side or until fully cooked and slightly charred
8. Remove from the grill and carefully unwrap
9. Serve hot with grilled or steamed vegetables and a side of vinegar dipping sauce''',
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
        instructions: '''1. Grill 2 medium-sized eggplants over an open flame or on a pan until the skin is charred and the flesh becomes soft
2. Allow the eggplants to cool slightly, then peel off the charred skin
3. Gently flatten the eggplants using a fork and place them on a serving plate
4. In a bowl, combine 2 chopped tomatoes and 1 small red onion (thinly sliced)
5. Add 2 tablespoons vinegar, a pinch of salt, and pepper to taste, then mix well
6. Pour the tomato-onion mixture over the grilled eggplants
7. Optional: drizzle with a bit of fish sauce or calamansi juice for added flavor
8. Serve as a side dish with grilled or fried dishes like pork, fish, or chicken''',
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
        instructions: '''1. Peel and grate 1 medium green papaya, then sprinkle with 1 tablespoon salt
2. Let it sit for 30 minutes to draw out moisture, then rinse and squeeze dry
3. In a saucepan, combine 1 cup vinegar, 1/2 cup sugar, and 1 teaspoon salt
4. Heat the mixture just until the sugar dissolves, then let it cool
5. In a large bowl, mix the papaya with thinly sliced carrots, red bell pepper, and ginger strips
6. Pour the cooled vinegar mixture over the vegetables and mix well
7. Transfer to clean glass jars and refrigerate for at least 1 day before serving
8. Serve as a side dish with grilled or fried Filipino dishes''',
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
        instructions: '''1. Slice the bitter gourd thinly and remove the seeds.
2. Rub the slices with salt and let sit for 10 minutes to reduce bitterness, then rinse and drain.
3. Heat oil in a pan and sauté garlic and onion until fragrant.
4. Add the bitter gourd and cook for 3–5 minutes.
5. Season with fish sauce and pepper.
6. Pour in beaten eggs and let them set slightly before stirring gently.
7. Cook for another 2 minutes until eggs are fully cooked.
8. Serve hot with steamed rice.''',
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
        instructions: '''1. Heat oil in a wok or large pan.
2. Sauté garlic and onion until fragrant.
3. Add mixed vegetables such as carrots, cabbage, bell peppers, and cauliflower.
4. Stir-fry for 3–4 minutes.
5. Mix soy sauce and cornstarch in a small bowl with a little water to make a light sauce.
6. Pour the sauce into the pan and toss until vegetables are evenly coated and slightly tender.
7. Season with salt and pepper to taste.
8. Serve hot as a side dish or main meal with rice.''',
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
        instructions: '''1. Clean and cube the fresh fish (such as tuna or tanigue).
2. Rinse with vinegar briefly, then drain to remove any fishy odor.
3. In a bowl, combine vinegar, ginger, onions, and chopped chili.
4. Add the fish cubes and mix gently until evenly coated.
5. Season with salt and let it marinate for 10–15 minutes.
6. Serve immediately while fresh.''',
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
        instructions: '''1. Clean and score the tilapia on both sides.
2. Rub with salt, pepper, minced garlic, and your choice of herbs.
3. Squeeze lemon juice over the fish and let it marinate for 5–10 minutes.
4. Preheat the grill and lightly brush with oil.
5. Grill the tilapia for about 6–8 minutes per side, or until cooked through and flaky.
6. Serve hot with lemon wedges or a side of vegetables.''',
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
        instructions: '''1. Clean the lapu-lapu thoroughly and pat dry with paper towels.
2. Place slices of ginger inside the fish cavity and on top of the fish.
3. Arrange the fish on a heatproof plate that fits inside your steamer.
4. In a separate bowl, mix 2 tablespoons of light soy sauce and 1 tablespoon of sesame oil.
5. Steam the fish over medium heat for 15–20 minutes, or until the fish flakes easily.
6. Carefully remove from the steamer and pour the soy sauce mixture over the fish.
7. Garnish with sliced spring onions and additional ginger if desired.
8. Serve hot with steamed rice.''',
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
        instructions: '''1. Separate the kangkong leaves and tender stems, then wash thoroughly.
2. Heat 1 tablespoon of oil in a pan over medium heat.
3. Sauté 3 cloves of minced garlic until lightly golden.
4. Add 1–2 tablespoons of soy sauce and 1 tablespoon of vinegar.
5. Let it simmer for about 1 minute without stirring.
6. Add the kangkong stems first and cook for 1–2 minutes.
7. Add the kangkong leaves and toss until wilted.
8. Season with salt and pepper to taste.
9. Serve immediately as a healthy side dish or over steamed rice.''',
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
        instructions: '''1. Rinse the mung bean sprouts thoroughly and drain well.
2. Heat 1 tablespoon of oil in a pan over medium heat.
3. Sauté 3 cloves of minced garlic and 1 chopped onion until fragrant.
4. Add a splash of fish sauce and let it cook for about 30 seconds.
5. Add the mung bean sprouts and toss gently for 2–3 minutes.
6. Optionally, add sliced carrots or tofu for added flavor and texture.
7. Season with salt and pepper to taste.
8. Remove from heat and serve immediately while crisp and fresh.''',
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
        instructions: '''1. Peel and slice 2 green mangoes into thin strips.
2. Dice 2 tomatoes and finely chop 1 small onion.
3. Combine mangoes, tomatoes, and onion in a mixing bowl.
4. Add 2 tablespoons of vinegar and a pinch of salt.
5. Toss gently to mix and balance the flavors.
6. Optionally, add chopped chili for a spicy kick.
7. Serve chilled as a refreshing side dish.''',
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
        instructions: '''1. Heat 1 tablespoon of oil in a pot over medium heat.
2. Sauté 1 chopped onion and 3 slices of ginger until fragrant.
3. Add 4 cups of water and bring to a boil.
4. Add your chosen fish (e.g., tilapia or bangus) and simmer for 8–10 minutes.
5. Add vegetables such as malunggay leaves, pechay, or green papaya.
6. Season with 1 tablespoon of fish sauce, salt, and pepper to taste.
7. Simmer for another 5 minutes until vegetables are tender.
8. Serve hot as a comforting soup.''',
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
        instructions: '''1. Peel and slice 2 medium sayote (chayote) into thin strips.
2. Heat 1 tablespoon of oil in a pan over medium heat.
3. Sauté 2 cloves of minced garlic and 1 chopped onion until fragrant.
4. Add a handful of small shrimp and cook until they turn pink.
5. Add the sliced sayote and stir-fry for 3–5 minutes.
6. Season with 1 tablespoon of fish sauce and a pinch of pepper.
7. Add a small amount of water, cover, and cook until tender but not mushy.
8. Serve warm as a healthy side dish.''',
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
        instructions: '''1. Peel and slice 1 medium bottle gourd (upo) into thin strips or cubes.
2. Heat 1 tablespoon of oil in a pan over medium heat.
3. Sauté 2 cloves of minced garlic and 1 chopped onion until fragrant.
4. Add a handful of shrimp and cook until they turn pink.
5. Add the sliced upo and stir-fry for 3–4 minutes.
6. Season with 1 tablespoon of fish sauce and a pinch of pepper.
7. Add about 1/4 cup of water, cover, and let it simmer until the upo becomes tender but not mushy.
8. Serve hot with steamed rice.''',
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
        instructions: '''1. Grill or roast 3 eggplants until the skin is charred and the flesh is soft.
2. Let the eggplants cool, then peel off the burnt skin.
3. Slice 2 tomatoes and 1 small onion.
4. Combine eggplant, tomatoes, and onion in a bowl.
5. Add 2 tablespoons of vinegar and a pinch of salt to taste.
6. Toss gently until well mixed.
7. Optionally, drizzle with a bit of oil or add chili for extra flavor.
8. Serve as a refreshing side dish or appetizer.''',
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
        description: 'Sautéed cabbage with carrots and light seasoning',
        prepTime: 10,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 35,
        proteinPerServing: 2,
        carbsPerServing: 6,
        fatPerServing: 1,
        instructions: '''1. Slice half a head of cabbage and one medium carrot into thin strips.
2. Heat 1 tablespoon of oil in a pan over medium heat.
3. Sauté 2 cloves of minced garlic and 1 chopped onion until fragrant.
4. Add the sliced carrots and cook for about 2 minutes.
5. Add the cabbage and stir-fry for another 3–4 minutes until slightly tender.
6. Season with 1 tablespoon of fish sauce and a pinch of pepper.
7. Mix well and cook for another minute, then remove from heat.
8. Serve warm as a side dish or light meal.''',
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
        description: 'Sautéed bok choy with garlic and light seasoning',
        prepTime: 8,
        cookTime: 6,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 25,
        proteinPerServing: 2,
        carbsPerServing: 4,
        fatPerServing: 1,
        instructions: '''1. Wash and chop the pechay (bok choy) into bite-sized pieces.
2. Heat 1 tablespoon of oil in a pan over medium heat.
3. Sauté 2 cloves of minced garlic until golden and fragrant.
4. Add the pechay stems first and cook for about 2 minutes.
5. Add the pechay leaves and season with 1 tablespoon of fish sauce and a pinch of pepper.
6. Stir well and cook for another 2–3 minutes, or until the leaves are wilted and tender.
7. Remove from heat and serve warm as a side dish or light meal.''',
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
  instructions: '''
1. Wash the saluyot leaves thoroughly and remove any tough stems. 
2. In a pan, heat oil and sauté garlic and onion until fragrant. 
3. Add the shrimp and cook until they turn pink. 
4. Pour in a small amount of fish sauce and stir well. 
5. Add the saluyot leaves and sauté for 2–3 minutes until wilted. 
6. Adjust seasoning with salt and pepper to taste. 
7. Serve warm with steamed rice.
''',
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
  instructions: '''
1. Wash the kamote tops thoroughly and remove tough stems. 
2. Heat oil in a pan and sauté garlic and onion until fragrant. 
3. Add a splash of fish sauce and stir. 
4. Add the kamote tops and cook for 2–3 minutes or until wilted. 
5. Adjust seasoning with salt and pepper as desired. 
6. Serve hot as a healthy side dish.
''',
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
  id: 55,
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
  instructions: '''
1. Peel and slice the radish and carrots thinly. 
2. Heat oil in a pan and sauté garlic and onion until golden. 
3. Add the sliced radish and carrots and stir-fry for 2–3 minutes. 
4. Pour in fish sauce and a small amount of water. 
5. Cover and cook for another 3–4 minutes until vegetables are tender. 
6. Season with salt and pepper to taste. 
7. Serve warm with rice.
''',
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
  id: 56,
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
  instructions: '''
1. Clean the lapu-lapu and pat dry. Season lightly with salt and pepper. 
2. Arrange slices of tofu and vegetables (like bell pepper and carrots) on a steaming plate. 
3. Place the fish on top and add ginger slices and spring onions. 
4. Drizzle with light soy sauce. 
5. Steam for about 15–20 minutes, or until the fish is cooked through. 
6. Carefully transfer to a serving plate, pour the sauce over, and serve hot.
''',
  isFilipinoDish: true,
  ingredients: ['lapu-lapu', 'tofu', 'vegetables', 'ginger', 'light soy sauce'],
  tags: ['healthy', 'steamed', 'protein', 'low-fat', 'tofu'],
  allergens: ['fish', 'soy'],
  rating: 4.3,
  cookTimeFormatted: '20 min',
  prepTimeFormatted: '15 min',
  imageUrl: 'https://example.com/steamed-lapu-lapu-tofu.jpg',
),

Recipe(
  id: 57,
  name: 'Pork Adobo',
  description: 'Classic Filipino pork braised in soy sauce and vinegar',
  prepTime: 15,
  cookTime: 30,
  servings: 4,
  difficulty: 'Easy',
  category: 'Filipino',
  caloriesPerServing: 310,
  proteinPerServing: 22,
  carbsPerServing: 6,
  fatPerServing: 20,
  instructions: '''
1. Cut pork into cubes and place in a pot. 
2. Add soy sauce, vinegar, garlic, bay leaves, and peppercorns. Marinate for at least 30 minutes. 
3. Place the pot over medium heat and bring to a boil. Do not stir. 
4. Once boiling, reduce the heat and simmer until the pork is tender, about 25–30 minutes. 
5. Adjust seasoning with salt or a bit of sugar if desired. 
6. Serve with hot steamed rice and enjoy!
''',
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
        id: 58,
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
        id: 59,
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
        id: 60,
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
        id: 61,
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
        id: 62,
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
        id: 63,
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
        id: 64,
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
        id: 65,
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
        id: 66,
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
      id: 67,
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
      instructions: '''
    1. Slice the beef thinly and place it in a bowl. Add soy sauce, lemon juice (or calamansi), minced garlic, and ground black pepper. Mix well and marinate for at least 30 minutes.  
    2. Heat oil in a pan over medium heat. Sauté the onions until soft, then remove and set aside.  
    3. In the same pan, add the marinated beef (reserve the marinade). Cook until the meat browns on both sides.  
    4. Pour in the reserved marinade and a small amount of water. Simmer for 10–15 minutes or until the beef is tender.  
    5. Add the sautéed onions back into the pan and mix gently. Adjust seasoning with soy sauce or lemon juice as needed.  
    6. Serve hot with steamed rice.
    ''',
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
        id: 68,
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
        imageUrl: 'assets/images/ArrozCaldo.jpg',
      ),
      Recipe(
  id: 69,
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
  instructions: '''
1. In a pan over medium heat, cook the tocino with a little water. Allow the water to evaporate, then let the tocino cook in its own rendered fat until caramelized and slightly sticky. Set aside.  
2. For the garlic rice (sinangag), heat a small amount of oil in a pan. Add minced garlic and sauté until golden brown.  
3. Add cooked rice, breaking up any clumps. Stir-fry until well mixed and fragrant. Season lightly with salt or soy sauce if desired.  
4. In a separate pan, fry eggs sunny-side up or as preferred.  
5. Serve the tocino with garlic rice and fried egg on a plate. Optionally, garnish with sliced tomatoes or atchara (pickled papaya).
''',
  isFilipinoDish: true,
  ingredients: ['tocino', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
  tags: ['filipino', 'breakfast', 'protein'],
  allergens: ['soy', 'egg'],
  rating: 4.7,
  cookTimeFormatted: '20 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'assets/images/Tocilog.jpg',
),

     Recipe(
  id: 70,
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
  instructions: '''
1. In a pan over medium heat, add the longganisa sausages with a small amount of water. Cover and let simmer until the water evaporates.  
2. Once dry, allow the longganisa to cook in its own oil until browned and fully cooked. Set aside.  
3. For the garlic rice (sinangag), heat oil in a pan and sauté minced garlic until golden brown.  
4. Add leftover cooked rice, stirring until evenly coated and fragrant. Season lightly with salt or soy sauce.  
5. In a separate pan, fry eggs sunny-side up or as preferred.  
6. Plate the longganisa with garlic rice and fried egg. Add optional sides like sliced tomatoes or vinegar dipping sauce.
''',
  isFilipinoDish: true,
  ingredients: ['longganisa', 'garlic rice', 'egg', 'garlic', 'soy sauce'],
  tags: ['filipino', 'breakfast', 'protein'],
  allergens: ['soy', 'egg'],
  rating: 4.8,
  cookTimeFormatted: '20 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'assets/images/Longsilog.jpg',
),

      Recipe(
        id: 71,
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
  id: 72,
  name: 'La Paz Batchoy',
  description: 'Filipino noodle soup with pork, liver, and rich broth',
  prepTime: 20,
  cookTime: 30,
  servings: 4,
  difficulty: 'Medium',
  category: 'Filipino',
  caloriesPerServing: 430,
  proteinPerServing: 18,
  carbsPerServing: 50,
  fatPerServing: 16,
  instructions: '''
1. In a pot, boil pork bones and pork meat in water for about 15–20 minutes to create a rich broth. Skim off any impurities that rise to the top.  
2. Add garlic, onion, and fish sauce or salt to season the broth. Simmer for another 10–15 minutes until the flavor deepens.  
3. In a separate pan, sauté minced garlic until golden brown, then add sliced pork and liver. Cook until the meat is browned and liver is just done.  
4. Prepare the noodles by blanching them in boiling water until soft, then drain.  
5. Place noodles into serving bowls. Pour the hot broth over the noodles and top with the cooked pork and liver mixture.  
6. Garnish with crushed chicharon (pork cracklings), sliced green onions, and a hard-boiled egg if desired.  
7. Serve hot with a side of calamansi or soy-fish sauce for dipping.
''',
  isFilipinoDish: true,
  ingredients: ['noodles', 'pork', 'liver', 'broth', 'garlic', 'onion', 'fish sauce', 'chicharon', 'egg', 'green onions'],
  tags: ['filipino', 'noodle soup', 'comfort food', 'savory'],
  allergens: ['wheat'],
  rating: 4.7,
  cookTimeFormatted: '30 min',
  prepTimeFormatted: '20 min',
  imageUrl: 'https://example.com/la-paz-batchoy.jpg',
),

      Recipe(
        id: 73,
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
        id: 74,
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
        id: 75,
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
        id: 76,
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
  id: 77,
  name: 'Nilagang Baboy',
  description: 'Classic Filipino boiled pork soup with vegetables',
  prepTime: 15,
  cookTime: 45,
  servings: 6,
  difficulty: 'Medium',
  category: 'Filipino',
  caloriesPerServing: 320,
  proteinPerServing: 26,
  carbsPerServing: 14,
  fatPerServing: 16,
  instructions: '''
1. In a large pot, bring water to a boil. Add pork chunks and simmer for 5–10 minutes. Skim off any scum that floats to the surface to keep the broth clear.  
2. Add onion, peppercorns, and a little salt. Continue simmering over low heat for about 30–40 minutes or until the pork becomes tender.  
3. Add potatoes and carrots. Cook until the vegetables start to soften.  
4. Add cabbage (and optional pechay or green beans) and cook for another 3–5 minutes until all vegetables are tender.  
5. Taste and adjust seasoning with salt or fish sauce.  
6. Serve hot in bowls with steamed rice and a side of fish sauce with calamansi for dipping.
''',
  isFilipinoDish: true,
  ingredients: [
    'pork',
    'potatoes',
    'carrots',
    'cabbage',
    'onion',
    'peppercorns',
    'salt',
    'fish sauce',
    'water'
  ],
  tags: ['filipino', 'soup', 'comfort food', 'boiled', 'hearty'],
  allergens: [],
  rating: 4.4,
  cookTimeFormatted: '45 min',
  prepTimeFormatted: '15 min',
  imageUrl: 'https://example.com/nilaga-baboy.jpg',
),

      Recipe(
        id: 78,
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
        id: 79,
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
        id: 80,
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
        id: 81,
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
        id: 82,
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
        id: 83,
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
        id: 84,
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
        id: 85,
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
        id: 86,
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
        id: 87,
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
        id: 88,
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
        id: 89,
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
        id: 90,
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
        id: 91,
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
        id: 92,
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
        id: 93,
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
        id: 94,
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
        id: 95,
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
        id: 96,
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
        id: 97,
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
        id: 98,
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
            id: 99,
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
        id: 100,
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
        id: 101,
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
        id: 102,
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
            id: 103,
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
        id: 104,
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
        id: 105,
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
        id: 106,
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
        id: 107,
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
                    id: 108,
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
        id: 109,
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
        id: 110,
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
        id: 111,
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
        id: 112,
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
            id: 113,
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
        id: 114,
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
        id: 115,
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
        id: 116,
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
        id: 117,
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
        id: 118,
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
        id: 119,
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
                id: 120,
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
        id: 121,
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
        id: 122,
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
        id: 123,
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
        id: 124,
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
        id: 125,
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
        id: 126,
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
            id: 127,
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
        id: 128,
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
        id: 129,
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
        id: 130,
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
        id: 131,
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
        id: 132,
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
        id: 133,
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
        id: 134,
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
                  id: 135,
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
        id: 136,
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
        id: 137,
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
        id: 138,
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
        id: 139,
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
        id: 140,
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
        instructions: '1. Prepare the pie crust and chill for 30 minutes. '
            '2. In a saucepan, mix coconut meat, milk, sugar, and cornstarch. '
            '3. Cook over medium heat until thickened. '
            '4. Pour the mixture into the prepared crust. '
            '5. Cover with top crust and seal edges. '
            '6. Bake in a preheated oven at 180°C (350°F) for 45 minutes or until golden brown. '
            '7. Cool before slicing and serving.',
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
        id: 141,
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
        instructions: '1. Combine yeast, sugar, and warm water. Let it activate. '
            '2. Mix flour, eggs, butter, and the yeast mixture. Knead until smooth. '
            '3. Let the dough rise until doubled in size. '
            '4. Flatten dough, spread butter and sugar, then roll. '
            '5. Shape into spirals and let rise again. '
            '6. Bake at 180°C (350°F) for 20–25 minutes. '
            '7. Once baked, brush with butter and top with grated cheese and sugar.',
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
        id: 142,
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
        instructions: '1. Mix flour, salt, yeast, and sugar in a bowl. '
            '2. Add water and oil; knead until smooth. '
            '3. Let the dough rise until doubled. '
            '4. Shape into logs and cut into small rolls. '
            '5. Coat with breadcrumbs. '
            '6. Place on a baking tray and let rise again. '
            '7. Bake at 180°C (350°F) for 20 minutes or until golden.',
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
        id: 143,
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
        instructions: '1. In a bowl, combine yeast, sugar, and warm water. '
            '2. Add flour, oil, and mix until dough forms. '
            '3. Knead until smooth and elastic. '
            '4. Let it rise until doubled. '
            '5. Form into logs and cut into rolls. '
            '6. Roll in breadcrumbs and let rise again. '
            '7. Bake at 180°C (350°F) for 20 minutes until golden.',
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
        id: 144,
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
        instructions: '1. Mix flour, sugar, yeast, and warm water. '
            '2. Add oil and knead until smooth and elastic. '
            '3. Let rise for 1 hour. '
            '4. Shape into oval forms with a slit on top. '
            '5. Let rest for 15 minutes. '
            '6. Bake at 180°C (350°F) for 25–30 minutes until golden brown.',
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
        id: 145,
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
        instructions: '1. Make the dough with flour, yeast, sugar, butter, and water. '
            '2. Knead until soft and let it rise for 1 hour. '
            '3. Prepare the filling by mixing butter, sugar, and breadcrumbs. '
            '4. Roll dough flat, spread filling, and roll into logs. '
            '5. Cut and shape pieces. '
            '6. Let rise again for 30 minutes. '
            '7. Bake at 180°C (350°F) for 25 minutes or until golden.',
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
        id: 146,
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
        instructions: '1. In a bowl, mix flour, sugar, and a pinch of salt. '
            '2. Cut in butter and oil until crumbly, then form into a dough. '
            '3. Divide dough into portions and flatten each piece. '
            '4. Place sweet bean paste filling in the center. '
            '5. Seal and roll into a round or oval shape. '
            '6. Arrange on a baking sheet lined with parchment paper. '
            '7. Bake in a preheated oven at 180°C (350°F) for 25–30 minutes until golden brown. '
            '8. Cool completely before serving.',
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
        id: 147,
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
        instructions: '1. Make the pastry dough by mixing flour, butter, and oil until soft. '
            '2. In a pan, sauté ground pork with garlic and onion. '
            '3. Add sugar and soy sauce; cook until mixture thickens, then let it cool. '
            '4. Roll out the dough and place a spoonful of pork filling in the center. '
            '5. Fold and seal the edges tightly. '
            '6. Arrange on a baking tray lined with parchment paper. '
            '7. Bake in a preheated oven at 180°C (350°F) for 25–30 minutes or until golden brown. '
            '8. Cool before serving.',
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
        id: 148,
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
        instructions: '1. In a bowl, combine flour, salt, and butter; mix until crumbly. '
            '2. Add cold water gradually and form into a dough. Let rest for 15 minutes. '
            '3. In a pan, sauté ground meat with onion, garlic, and potatoes until cooked. '
            '4. Flatten dough and cut into circles. '
            '5. Place filling in the center, fold, and seal edges with a fork. '
            '6. Fry in hot oil until golden brown, or bake at 190°C (375°F) for 25 minutes. '
            '7. Serve hot with vinegar dipping sauce.',
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
        id: 149,
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
        instructions: '1. Combine flour, sugar, yeast, and warm water to make dough. '
            '2. Knead until smooth, then let rise until doubled. '
            '3. In a pan, cook ground meat with garlic, onion, soy sauce, and oyster sauce. Let cool. '
            '4. Divide dough into portions and flatten each one. '
            '5. Place filling in the center and seal into a round bun. '
            '6. Place buns on parchment paper squares. '
            '7. Steam for 15–20 minutes until fluffy and cooked through. '
            '8. Serve hot.',
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
        id: 150,
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
        instructions: '1. In a bowl, mix ground meat, minced onion, garlic, soy sauce, and seasonings. '
            '2. Place a spoonful of filling in the center of a dumpling wrapper. '
            '3. Fold and press the edges lightly to seal the shape. '
            '4. Arrange siomai in a steamer lined with parchment or banana leaves. '
            '5. Steam over medium heat for 12–15 minutes until cooked through. '
            '6. Serve hot with soy sauce, calamansi, and chili garlic oil.',
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
      id: 151,
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
      instructions: '1. In a pan, sauté onion and garlic in oil until fragrant. '
          '2. Add chopped vegetables and cook until slightly tender. '
          '3. Let mixture cool completely before wrapping. '
          '4. Place a spoonful of filling on a spring roll wrapper and roll tightly, sealing the edge with water. '
          '5. Heat oil in a pan and fry until golden brown. '
          '6. Drain excess oil on paper towels and serve with vinegar or sweet chili sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'vegetables', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'fried'],
      allergens: ['wheat'],
      rating: 4.2,
      cookTimeFormatted: '15 min',
      prepTimeFormatted: '25 min',
      imageUrl: 'assets/images/Lumpia.jpg',
    ),

    Recipe(
      id: 152,
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
      instructions: '1. In a pan, heat oil and sauté garlic and onion until fragrant. '
          '2. Add mixed vegetables and season with salt and pepper. '
          '3. Cook until vegetables are slightly tender, then let cool. '
          '4. Wrap mixture in spring roll wrappers and seal edges with water. '
          '5. Deep-fry in hot oil until crisp and golden brown. '
          '6. Drain excess oil and serve hot with vinegar dipping sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'mixed vegetables', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.1,
      cookTimeFormatted: '15 min',
      prepTimeFormatted: '25 min',
      imageUrl: 'assets/images/LumpiangGulay.jpg',
    ),

    Recipe(
      id: 153,
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
      instructions: '1. Blanch or lightly sauté vegetables such as carrots, lettuce, and bean sprouts. '
          '2. Prepare rice paper or fresh lumpia wrapper and lay flat on a plate. '
          '3. Place a portion of vegetables in the center of the wrapper. '
          '4. Roll tightly and fold the sides to enclose the filling. '
          '5. Serve with homemade sweet garlic sauce and crushed peanuts on top.',
      isFilipinoDish: true,
      ingredients: ['rice paper', 'fresh vegetables', 'lettuce', 'carrots', 'sweet sauce'],
      tags: ['dessert', 'filipino', 'meryenda', 'fresh'],
      allergens: [],
      rating: 4.0,
      cookTimeFormatted: '10 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangSariwa.jpg',
    ),

    Recipe(
      id: 154,
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
      instructions: '1. In a pan, heat oil and sauté garlic and onion until fragrant. '
          '2. Add mixed vegetables and cook until tender. '
          '3. Pour sweet sauce over the cooked vegetables and mix well. '
          '4. Transfer to a serving plate and top with crushed peanuts. '
          '5. Serve warm as a healthy and light snack.',
      isFilipinoDish: true,
      ingredients: ['mixed vegetables', 'sweet sauce', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: [],
      rating: 4.0,
      cookTimeFormatted: '10 min',
      prepTimeFormatted: '15 min',
      imageUrl: 'assets/images/LumpiangHubad.jpg',
    ),

    Recipe(
      id: 155,
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
      instructions: '1. In a pan, sauté garlic and onion until fragrant. '
          '2. Add bean sprouts and cook for 2–3 minutes, just until slightly tender. '
          '3. Let cool before wrapping. '
          '4. Place filling on spring roll wrapper and roll tightly, sealing the edges with water. '
          '5. Fry in hot oil until golden brown and crispy. '
          '6. Drain on paper towels and serve with vinegar or garlic dipping sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'bean sprouts', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.1,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangTogue.jpg',
),

     Recipe(
      id: 156,
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
      instructions: '''
    1. Heat oil in a pan over medium heat. 
    2. Sauté garlic and onion until fragrant. 
    3. Add sliced heart of palm (ubod) and cook until tender. 
    4. Season with salt and pepper to taste, then let it cool. 
    5. Place a portion of the mixture on each spring roll wrapper. 
    6. Roll tightly and seal the edges with water. 
    7. Fry until golden brown and crisp. 
    8. Drain excess oil and serve with sweet garlic sauce.
    ''',
      isFilipinoDish: true,
      ingredients: [
        'spring roll wrapper',
        'heart of palm',
        'onion',
        'garlic',
        'oil'
      ],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.2,
      cookTimeFormatted: '15 min',
      prepTimeFormatted: '25 min',
      imageUrl: 'assets/images/LumpiangUbod.jpg',
    ),

    Recipe(
      id: 157,
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
      instructions: '''
    1. Heat oil in a pan over medium heat. 
    2. Sauté garlic and onion until fragrant. 
    3. Add shredded singkamas (jicama) and cook lightly for 2–3 minutes. 
    4. Season with salt and pepper. Let the mixture cool. 
    5. Place filling in a spring roll wrapper and roll tightly. 
    6. Seal edges with water. 
    7. Fry until golden brown. 
    8. Drain on paper towels and serve with vinegar dipping sauce.
    ''',
      isFilipinoDish: true,
      ingredients: [
        'spring roll wrapper',
        'jicama',
        'onion',
        'garlic',
        'oil'
      ],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangSingkamas.jpg',
    ),

    Recipe(
        id: 158,
        name: 'Chicken Relleno',
        description: 'Stuffed whole chicken - Filipino special occasion dish',
        prepTime: 60,
        cookTime: 90,
        servings: 8,
        difficulty: 'Hard',
        category: 'Filipino',
        caloriesPerServing: 520,
        proteinPerServing: 42,
        carbsPerServing: 18,
        fatPerServing: 32,
        instructions: '''1. Debone whole chicken carefully, keeping skin intact
2. Prepare stuffing: ground pork, chorizo, hard-boiled eggs
3. Mix stuffing with raisins, pickles, and breadcrumbs
4. Season chicken cavity with salt and pepper
5. Fill chicken with stuffing mixture
6. Sew or tie chicken to close
7. Brown chicken in oil on all sides
8. Braise in soy sauce and water for 1 hour
9. Bake at 350°F for 30 minutes
10. Slice and serve with liver sauce''',
        isFilipinoDish: true,
        ingredients: ['whole chicken', 'ground pork', 'chorizo', 'hard-boiled eggs', 'raisins'],
        tags: ['filipino', 'lunch', 'special occasion', 'stuffed'],
        allergens: ['egg', 'wheat', 'soy'],
        rating: 4.9,
        cookTimeFormatted: '90 min',
        prepTimeFormatted: '60 min',
        imageUrl: 'assets/images/ChickenRelleno.jpg',
      ),

    Recipe(
      id: 159,
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
      instructions: '''
    1. Peel and grate the squash (kalabasa). 
    2. Sauté garlic and onion in a little oil until fragrant. 
    3. Add grated squash and cook until slightly soft. 
    4. Season with salt and pepper. Let cool before wrapping. 
    5. Place a spoonful of the mixture in a spring roll wrapper and roll tightly. 
    6. Seal the edge with water. 
    7. Deep-fry until golden brown. 
    8. Drain excess oil and serve hot with vinegar or sweet chili sauce.
    ''',
      isFilipinoDish: true,
      ingredients: [
        'spring roll wrapper',
        'squash',
        'onion',
        'garlic',
        'oil'
      ],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangKalabasa.jpg',
    ),

    Recipe(
      id: 160,
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
      instructions: '''
    1. Peel and shred sayote (chayote). 
    2. Heat oil in a pan and sauté garlic and onion. 
    3. Add shredded sayote and cook for 2–3 minutes. 
    4. Season with salt and pepper. Remove from heat and cool. 
    5. Place mixture on a spring roll wrapper, roll tightly, and seal with water. 
    6. Fry in hot oil until golden brown and crispy. 
    7. Drain excess oil and serve with sweet chili or vinegar sauce.
    ''',
      isFilipinoDish: true,
      ingredients: [
        'spring roll wrapper',
        'chayote',
        'onion',
        'garlic',
        'oil'
      ],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangSayote.jpg',
    ),

          Recipe(
      id: 161,
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
      instructions: 
        '1. Peel and slice sponge gourd into thin strips.\n'
        '2. Sauté garlic and onion in oil until fragrant.\n'
        '3. Add the sponge gourd and cook for 3–5 minutes until slightly tender.\n'
        '4. Let it cool, then place 2 tablespoons of the mixture onto each spring roll wrapper.\n'
        '5. Fold and seal edges with water.\n'
        '6. Heat oil in a pan and fry the rolls until golden brown.\n'
        '7. Drain excess oil on paper towels and serve warm with vinegar or sweet chili sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'sponge gourd', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangPatola.jpg',
    ),

    Recipe(
      id: 162,
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
      instructions: 
        '1. Slice the bitter gourd thinly and soak in salted water for 10 minutes.\n'
        '2. Sauté garlic and onion in oil.\n'
        '3. Add drained bitter gourd and cook for 3–4 minutes.\n'
        '4. Allow to cool, then place a small portion on each spring roll wrapper.\n'
        '5. Fold tightly and seal edges with water.\n'
        '6. Fry in hot oil until golden and crisp.\n'
        '7. Serve with spiced vinegar or sweet dipping sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'bitter gourd', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangAmpalaya.jpg',
    ),

    Recipe(
      id: 163,
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
      instructions: 
        '1. Wash and cut water spinach into small pieces.\n'
        '2. Sauté garlic and onion in oil until aromatic.\n'
        '3. Add kangkong and cook briefly until wilted.\n'
        '4. Let the mixture cool before wrapping.\n'
        '5. Place a portion of the mixture on a spring roll wrapper, fold tightly, and seal with water.\n'
        '6. Heat oil and fry until golden and crisp.\n'
        '7. Serve with vinegar or sweet chili sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'water spinach', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangKangkong.jpg',
    ),

    Recipe(
      id: 164,
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
      instructions: 
        '1. Clean and roughly chop the saluyot (jute) leaves.\n'
        '2. Sauté garlic and onion in oil.\n'
        '3. Add saluyot and cook for 2–3 minutes until soft.\n'
        '4. Let mixture cool before wrapping.\n'
        '5. Place 1–2 tablespoons of filling into each wrapper, roll tightly, and seal edges.\n'
        '6. Deep fry in hot oil until golden brown.\n'
        '7. Serve with vinegar or banana ketchup.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'jute leaves', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangSaluyot.jpg',
    ),

    Recipe(
      id: 165,
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
      instructions: 
        '1. Remove malunggay (moringa) leaves from stems and wash well.\n'
        '2. Sauté garlic and onion in oil until fragrant.\n'
        '3. Add malunggay leaves and cook for 2–3 minutes until tender.\n'
        '4. Allow mixture to cool before wrapping.\n'
        '5. Wrap 2 tablespoons in each spring roll wrapper, fold tightly, and seal with water.\n'
        '6. Fry in medium-hot oil until golden brown.\n'
        '7. Serve with vinegar-garlic dip or sweet chili sauce.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'moringa leaves', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.1,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangMalunggay.jpg',
    ),

    Recipe(
      id: 166,
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
      instructions: 
        '1. Chop Chinese cabbage finely and remove excess water.\n'
        '2. Sauté garlic and onion in oil until fragrant.\n'
        '3. Add chopped cabbage and cook for 3 minutes until softened.\n'
        '4. Let cool before wrapping.\n'
        '5. Put a spoonful of filling on each wrapper, fold tightly, and seal edges with water.\n'
        '6. Fry in hot oil until golden brown and crisp.\n'
        '7. Drain excess oil and serve with sweet dipping sauce or vinegar.',
      isFilipinoDish: true,
      ingredients: ['spring roll wrapper', 'Chinese cabbage', 'onion', 'garlic', 'oil'],
      tags: ['dessert', 'filipino', 'meryenda', 'vegetarian'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangPechay.jpg',
    ),

        Recipe(
        id: 167,
        name: 'Lumpiang Repolyo',
        description: 'Crispy Filipino spring roll filled with sautéed cabbage and vegetables',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Snack',
        caloriesPerServing: 75,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: '''
      1. Finely shred the cabbage and chop the onion and garlic.  
      2. Heat oil in a pan over medium heat.  
      3. Sauté the garlic and onion until fragrant.  
      4. Add the shredded cabbage and cook for about 3–5 minutes, just until slightly wilted.  
      5. Season with salt and pepper to taste. Add a bit of soy sauce or oyster sauce if desired.  
      6. Remove from heat and let the filling cool.  
      7. Place 1–2 tablespoons of the cabbage filling on a spring roll wrapper. Fold and roll tightly, sealing the edge with a bit of water.  
      8. Heat oil in a pan and fry the lumpia until golden brown and crisp on all sides.  
      9. Drain excess oil on paper towels.  
      10. Serve hot with spiced vinegar or sweet chili sauce for dipping.
      ''',
        isFilipinoDish: true,
        ingredients: [
          'spring roll wrapper',
          'cabbage',
          'onion',
          'garlic',
          'salt',
          'pepper',
          'oil',
          'soy sauce (optional)'
        ],
        tags: ['filipino', 'snack', 'meryenda', 'vegetarian', 'crispy'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'assets/images/LumpiangRepolyo.jpg',
      ),

      Recipe(
        id: 168,
        name: 'Lumpiang Labanos',
        description: 'Crispy Filipino spring roll filled with sautéed radish and vegetables',
        prepTime: 20,
        cookTime: 12,
        servings: 8,
        difficulty: 'Easy',
        category: 'Snack',
        caloriesPerServing: 70,
        proteinPerServing: 3,
        carbsPerServing: 8,
        fatPerServing: 2,
        instructions: '''
      1. Peel and shred the radish (labanos). Lightly squeeze out excess liquid using clean hands or a cloth to prevent soggy filling.  
      2. In a pan, heat oil and sauté garlic and onion until fragrant.  
      3. Add the shredded radish and cook for about 5–7 minutes or until tender.  
      4. Season with salt and pepper to taste. You may also add a small amount of soy sauce for added flavor.  
      5. Let the mixture cool slightly.  
      6. Place 1–2 tablespoons of the radish filling on a spring roll wrapper. Roll tightly and seal the edge with water.  
      7. Heat enough oil in a pan over medium heat and fry the lumpia until golden brown and crispy.  
      8. Drain excess oil on paper towels.  
      9. Serve hot with vinegar dipping sauce or sweet chili sauce.
      ''',
        isFilipinoDish: true,
        ingredients: [
          'spring roll wrapper',
          'radish (labanos)',
          'onion',
          'garlic',
          'salt',
          'pepper',
          'oil',
          'soy sauce (optional)'
        ],
        tags: ['filipino', 'snack', 'meryenda', 'vegetarian', 'crispy', 'light'],
        allergens: ['wheat'],
        rating: 4.0,
        cookTimeFormatted: '12 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'assets/images/LumpiangLabanos.jpg',
      ),

      
      
      Recipe(
          id: 169,
          name: 'Lumpiang Kamote',
          description: 'Crispy Filipino spring roll filled with sautéed sweet potato mixture',
          prepTime: 20,
          cookTime: 12,
          servings: 8,
          difficulty: 'Easy',
          category: 'Snack',
          caloriesPerServing: 85,
          proteinPerServing: 3,
          carbsPerServing: 12,
          fatPerServing: 2,
          instructions: '''
        1. Peel and grate or finely chop the sweet potato (kamote).  
        2. In a pan, heat a small amount of oil and sauté garlic and onion until fragrant.  
        3. Add the sweet potato and cook for 5–7 minutes or until slightly tender. Season with salt and pepper to taste.  
        4. Let the mixture cool slightly to make wrapping easier.  
        5. Place a spoonful of the kamote filling on a spring roll wrapper. Roll tightly and seal the edge with a bit of water.  
        6. Heat oil in a frying pan over medium heat. Fry the lumpia until golden brown and crispy on all sides.  
        7. Drain excess oil using paper towels.  
        8. Serve hot as a snack or meryenda. Optionally, drizzle with a little caramelized brown sugar syrup for a sweeter version.
        ''',
          isFilipinoDish: true,
          ingredients: [
            'spring roll wrapper',
            'sweet potato (kamote)',
            'onion',
            'garlic',
            'salt',
            'pepper',
            'oil'
          ],
          tags: ['filipino', 'snack', 'meryenda', 'vegetarian', 'crispy', 'sweet'],
          allergens: ['wheat'],
          rating: 4.1,
          cookTimeFormatted: '12 min',
          prepTimeFormatted: '20 min',
          imageUrl: 'assets/images/LumpiangKamote.jpg',
        ),

      Recipe(
      id: 170,
      name: 'Lumpiang Upo',
      description: 'Crispy Filipino spring roll filled with sautéed bottle gourd and vegetables',
      prepTime: 20,
      cookTime: 12,
      servings: 8,
      difficulty: 'Easy',
      category: 'Snack',
      caloriesPerServing: 70,
      proteinPerServing: 3,
      carbsPerServing: 8,
      fatPerServing: 2,
      instructions: '''
    1. Peel and finely chop the bottle gourd (upo).  
    2. In a pan, heat a little oil and sauté garlic and onion until fragrant.  
    3. Add the chopped upo and cook until slightly tender. Season with salt and pepper to taste.  
    4. Drain excess liquid from the cooked upo mixture to avoid soggy lumpia. Let it cool.  
    5. Place a spoonful of the mixture onto a spring roll wrapper. Roll tightly and seal the edge with water.  
    6. Heat oil in a pan over medium heat and fry the lumpia until golden brown and crispy on all sides.  
    7. Drain on paper towels to remove excess oil.  
    8. Serve hot with vinegar or sweet chili sauce for dipping.
    ''',
      isFilipinoDish: true,
      ingredients: [
        'spring roll wrapper',
        'bottle gourd (upo)',
        'onion',
        'garlic',
        'salt',
        'pepper',
        'oil'
      ],
      tags: ['filipino', 'meryenda', 'snack', 'vegetarian', 'crispy'],
      allergens: ['wheat'],
      rating: 4.0,
      cookTimeFormatted: '12 min',
      prepTimeFormatted: '20 min',
      imageUrl: 'assets/images/LumpiangUpo.jpg',
    ),

      
      Recipe(
  id: 171,
  name: 'Lumpiang Talong',
  description: 'Crispy Filipino eggplant spring roll, perfect for snacks or meryenda',
  prepTime: 20,
  cookTime: 12,
  servings: 8,
  difficulty: 'Easy',
  category: 'Snack',
  caloriesPerServing: 85,
  proteinPerServing: 3,
  carbsPerServing: 10,
  fatPerServing: 2,
  instructions: '''
1. Grill or roast the eggplants until the skin is charred and the flesh becomes soft. Let them cool slightly, then peel off the skin and mash the flesh lightly.  
2. In a pan, sauté garlic and onion until fragrant. Add the mashed eggplant and season with salt and pepper. Mix well and let it cool.  
3. Place a portion of the eggplant mixture on a spring roll wrapper. Roll tightly and seal the edge with a bit of water.  
4. Heat oil in a pan over medium heat. Fry the lumpia until golden brown and crisp on all sides.  
5. Drain excess oil on paper towels.  
6. Serve hot with vinegar, ketchup, or sweet chili sauce for dipping.
''',
  isFilipinoDish: true,
  ingredients: [
    'spring roll wrapper',
    'eggplant',
    'onion',
    'garlic',
    'salt',
    'pepper',
    'oil'
  ],
  tags: ['filipino', 'meryenda', 'snack', 'vegetarian', 'crispy'],
  allergens: ['wheat'],
  rating: 4.1,
  cookTimeFormatted: '12 min',
  prepTimeFormatted: '20 min',
  imageUrl: 'assets/images/LumpiangTalong.jpg',
),

      
      Recipe(
        id: 172,
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
        imageUrl: 'assets/images/Bangsilog.jpg',
      ),
      Recipe(
        id: 173,
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
        imageUrl: 'assets/images/Cornsilog.jpg',
      ),
      
      
      
      Recipe(
                id: 174,
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
        imageUrl: 'assets/images/GinataangMais.jpg',
      ),
      Recipe(
        id: 175,
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
        imageUrl: 'assets/images/PandesalWithCheese.jpg',
      ),
      
      Recipe(
        id: 176,
        name: 'Spamsilog',
        description: 'Spam, Sinangag, at Itlog - Spam with garlic rice and egg',
        prepTime: 5,
        cookTime: 10,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 480,
        proteinPerServing: 20,
        carbsPerServing: 48,
        fatPerServing: 22,
        instructions: '''1. Slice spam and fry until golden brown on both sides
2. Cook garlic rice by sautéing minced garlic in oil until golden, then add cooked rice
3. In a separate pan, fry an egg sunny-side up
4. Serve the fried spam over garlic rice with the fried egg
5. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['spam', 'garlic rice', 'egg', 'garlic', 'oil'],
        tags: ['filipino', 'breakfast', 'quick'],
        allergens: ['egg'],
        rating: 4.2,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'assets/images/Spamsilog.jpg',
      ),
      Recipe(
        id: 177,
        name: 'Hotsilog',
        description: 'Hotdog, Sinangag, at Itlog - Hotdog with garlic rice and egg',
        prepTime: 5,
        cookTime: 10,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 16,
        carbsPerServing: 46,
        fatPerServing: 12,
        instructions: '''1. Slice hotdogs and fry until golden brown
2. Cook garlic rice by sautéing minced garlic in oil until golden, then add cooked rice
3. In a separate pan, fry an egg sunny-side up
4. Serve the fried hotdogs over garlic rice with the fried egg
5. Garnish with sliced tomatoes and enjoy!''',
        isFilipinoDish: true,
        ingredients: ['hotdog', 'garlic rice', 'egg', 'garlic', 'oil'],
        tags: ['filipino', 'breakfast', 'quick'],
        allergens: ['egg'],
        rating: 4.1,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'assets/images/Hotsilog.jpg',
      ),
      
      
      Recipe(
        id: 178,
        name: 'Suman',
        description: 'Sticky rice wrapped in banana leaves - Traditional Filipino breakfast',
        prepTime: 30,
        cookTime: 45,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 280,
        proteinPerServing: 6,
        carbsPerServing: 58,
        fatPerServing: 3,
        instructions: '''1. Soak glutinous rice in water for 2 hours
2. Mix rice with coconut milk and sugar
3. Wrap in banana leaves and tie securely
4. Steam for 45 minutes until rice is tender
5. Serve warm with coconut cream on top''',
        isFilipinoDish: true,
        ingredients: ['glutinous rice', 'coconut milk', 'sugar', 'banana leaves'],
        tags: ['filipino', 'breakfast', 'traditional'],
        allergens: [],
        rating: 4.5,
        cookTimeFormatted: '45 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'assets/images/Suman.jpg',
      ),
      
      Recipe(
        id: 179,  
        name: 'Kakanin',
        description: 'Traditional Filipino rice cakes - Assorted breakfast treats',
        prepTime: 20,
        cookTime: 25,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 250,
        proteinPerServing: 4,
        carbsPerServing: 48,
        fatPerServing: 4,
        instructions: '''1. Mix rice flour with coconut milk and sugar
2. Add pandan extract for flavor and color
3. Pour into molds and steam for 20-25 minutes
4. Let cool before serving
5. Enjoy with coffee or hot chocolate''',
        isFilipinoDish: true,
        ingredients: ['rice flour', 'coconut milk', 'sugar', 'pandan extract'],
        tags: ['filipino', 'breakfast', 'traditional'],
        allergens: [],
        rating: 4.4,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'assets/images/Kakanin.jpg',
      ),
      Recipe(
        id: 180,
        name: 'Tuyo at Itlog',
        description: 'Dried fish and egg - Simple Filipino breakfast',
        prepTime: 5,
        cookTime: 10,
        servings: 2,
        difficulty: 'Easy',
        category: 'Filipino',
        caloriesPerServing: 320,
        proteinPerServing: 28,
        carbsPerServing: 12,
        fatPerServing: 18,
        instructions: '''1. Fry tuyo (dried fish) in oil until crispy
2. Remove tuyo and set aside
3. Fry eggs in the same oil until desired doneness
4. Serve tuyo and eggs over garlic rice
5. Add sliced tomatoes and vinegar on the side
6. Enjoy with your morning coffee''',
        isFilipinoDish: true,
        ingredients: ['tuyo', 'eggs', 'garlic rice', 'tomatoes', 'vinegar'],
        tags: ['filipino', 'breakfast', 'quick', 'protein'],
        allergens: ['fish', 'egg'],
        rating: 4.4,
        cookTimeFormatted: '10 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'assets/images/TuyoAtItlog.jpg',
      ),
      Recipe(
        id: 181,
        name: 'Pancit Miki-Bihon',
        description: 'Mixed noodles with meat and vegetables',
        prepTime: 20,
        cookTime: 25,
        servings: 6,
        difficulty: 'Medium',
        category: 'Filipino',
        caloriesPerServing: 380,
        proteinPerServing: 18,
        carbsPerServing: 52,
        fatPerServing: 12,
        instructions: '''1. Soak bihon noodles in warm water
2. Cook miki noodles according to package
3. Sauté garlic, onions, and celery
4. Add chicken or pork and cook
5. Add shrimp and cook until pink
6. Add vegetables: cabbage, carrots, snow peas
7. Season with soy sauce and oyster sauce
8. Add both noodles and toss
9. Cook until well combined
10. Garnish with eggs and calamansi''',
        isFilipinoDish: true,
        ingredients: ['miki noodles', 'bihon', 'chicken', 'shrimp', 'mixed vegetables'],
        tags: ['filipino', 'lunch', 'noodles', 'mixed'],
        allergens: ['shellfish', 'wheat', 'soy', 'egg'],
        rating: 4.7,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/miki-bihon.jpg',
      ),

      // Additional Healthy Filipino Dishes
      Recipe(
        id: 182,
        name: 'Ensaladang Pipino at Kamatis',
        description: 'Refreshing cucumber and tomato salad with coconut vinegar dressing',
        prepTime: 10,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Salad',
        caloriesPerServing: 45,
        proteinPerServing: 2,
        carbsPerServing: 8,
        fatPerServing: 1,
        instructions: '''
1. Slice cucumbers and tomatoes into bite-sized pieces
2. Thinly slice red onion
3. Mix vegetables in a bowl
4. Drizzle with coconut vinegar
5. Sprinkle with sea salt and black pepper
6. Toss gently and let marinate for 10 minutes
7. Serve chilled as a side dish
        ''',
        isFilipinoDish: true,
        ingredients: ['cucumber', 'tomatoes', 'red onion', 'coconut vinegar', 'sea salt', 'black pepper'],
        tags: ['filipino', 'salad', 'healthy', 'vegetarian', 'refreshing'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ensaladang-pipino-kamatis.jpg',
      ),

      Recipe(
        id: 183,
        name: 'Kilawing Tanigue',
        description: 'Fresh Spanish mackerel ceviche with vinegar and calamansi',
        prepTime: 20,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Appetizer',
        caloriesPerServing: 180,
        proteinPerServing: 25,
        carbsPerServing: 8,
        fatPerServing: 6,
        instructions: '''
1. Cut fresh tanigue into thin slices
2. Marinate fish in vinegar and calamansi juice for 15 minutes
3. Add sliced ginger and onions
4. Season with salt and pepper
5. Add chili peppers for heat
6. Let marinate for another 10 minutes
7. Serve immediately with crackers or rice
        ''',
        isFilipinoDish: true,
        ingredients: ['fresh tanigue', 'vinegar', 'calamansi', 'ginger', 'onion', 'chili peppers', 'salt', 'pepper'],
        tags: ['filipino', 'appetizer', 'healthy', 'protein', 'raw'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '20 min',
        imageUrl: 'https://example.com/kilawing-tanigue.jpg',
      ),

      Recipe(
        id: 184,
        name: 'Tofu Tinola',
        description: 'Plant-based version of tinola using tofu instead of chicken',
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Soup',
        caloriesPerServing: 120,
        proteinPerServing: 12,
        carbsPerServing: 8,
        fatPerServing: 4,
        instructions: '''
1. Sauté garlic, onion, and ginger in oil
2. Add tofu cubes and cook until lightly browned
3. Pour in vegetable broth and bring to boil
4. Add chayote and green papaya
5. Season with fish sauce and pepper
6. Add malunggay leaves at the end
7. Simmer for 5 minutes and serve hot
        ''',
        isFilipinoDish: true,
        ingredients: ['firm tofu', 'ginger', 'garlic', 'onion', 'chayote', 'green papaya', 'malunggay', 'vegetable broth'],
        tags: ['filipino', 'soup', 'healthy', 'vegetarian', 'vegan'],
        allergens: ['soy'],
        rating: 4.4,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/tofu-tinola.jpg',
      ),

      Recipe(
        id: 185,
        name: 'Steamed Tilapia with Tomatoes and Onions',
        description: 'Simple and healthy steamed fish with fresh vegetables',
        prepTime: 10,
        cookTime: 15,
        servings: 3,
        difficulty: 'Easy',
        category: 'Main Course',
        caloriesPerServing: 200,
        proteinPerServing: 30,
        carbsPerServing: 6,
        fatPerServing: 6,
        instructions: '''
1. Clean and score the tilapia
2. Season with salt and pepper
3. Place fish on a steaming plate
4. Top with sliced tomatoes and onions
5. Add ginger slices and spring onions
6. Steam for 12-15 minutes until cooked
7. Drizzle with soy sauce and serve hot
        ''',
        isFilipinoDish: true,
        ingredients: ['tilapia', 'tomatoes', 'onions', 'ginger', 'spring onions', 'soy sauce', 'salt', 'pepper'],
        tags: ['filipino', 'main course', 'healthy', 'protein', 'steamed'],
        allergens: ['fish', 'soy'],
        rating: 4.6,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/steamed-tilapia-tomatoes.jpg',
      ),

      Recipe(
        id: 186,
        name: 'Adobong Pusit',
        description: 'Squid sautéed in garlic, onions, vinegar, and soy sauce',
        prepTime: 15,
        cookTime: 20,
        servings: 4,
        difficulty: 'Medium',
        category: 'Main Course',
        caloriesPerServing: 150,
        proteinPerServing: 20,
        carbsPerServing: 8,
        fatPerServing: 4,
        instructions: '''
1. Clean squid and cut into rings
2. Sauté garlic and onions until fragrant
3. Add squid and cook for 2 minutes
4. Pour in vinegar and soy sauce
5. Add bay leaves and peppercorns
6. Simmer for 15 minutes until tender
7. Adjust seasoning and serve hot
        ''',
        isFilipinoDish: true,
        ingredients: ['squid', 'garlic', 'onions', 'vinegar', 'soy sauce', 'bay leaves', 'peppercorns'],
        tags: ['filipino', 'main course', 'healthy', 'protein', 'seafood'],
        allergens: ['shellfish', 'soy'],
        rating: 4.5,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/adobong-pusit.jpg',
      ),

      Recipe(
        id: 187,
        name: 'Ginataang Sitaw at Kalabasa',
        description: 'String beans and squash cooked in coconut milk',
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        difficulty: 'Easy',
        category: 'Vegetable',
        caloriesPerServing: 180,
        proteinPerServing: 4,
        carbsPerServing: 15,
        fatPerServing: 12,
        instructions: '''
1. Sauté garlic, onion, and shrimp paste
2. Add squash cubes and cook for 5 minutes
3. Pour in coconut milk and bring to boil
4. Add string beans and chili peppers
5. Simmer for 10 minutes until vegetables are tender
6. Season with salt and pepper
7. Serve hot with rice
        ''',
        isFilipinoDish: true,
        ingredients: ['string beans', 'squash', 'coconut milk', 'garlic', 'onion', 'shrimp paste', 'chili peppers'],
        tags: ['filipino', 'vegetable', 'healthy', 'vegetarian', 'coconut'],
        allergens: ['shellfish'],
        rating: 4.4,
        cookTimeFormatted: '20 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ginataang-sitaw-kalabasa.jpg',
      ),

      Recipe(
        id: 188,
        name: 'Lumpiang Sariwa (Fresh Spring Rolls)',
        description: 'Fresh spring rolls with heart of palm, vegetables, and peanut sauce',
        prepTime: 30,
        cookTime: 15,
        servings: 6,
        difficulty: 'Medium',
        category: 'Appetizer',
        caloriesPerServing: 120,
        proteinPerServing: 6,
        carbsPerServing: 18,
        fatPerServing: 4,
        instructions: '''
1. Sauté heart of palm, carrots, and beans
2. Season with salt and pepper
3. Prepare fresh lettuce leaves
4. Make peanut sauce with garlic and soy sauce
5. Wrap vegetables in lettuce leaves
6. Serve with peanut sauce on the side
7. Enjoy fresh and healthy
        ''',
        isFilipinoDish: true,
        ingredients: ['heart of palm', 'carrots', 'green beans', 'lettuce', 'peanuts', 'garlic', 'soy sauce'],
        tags: ['filipino', 'appetizer', 'healthy', 'vegetarian', 'fresh'],
        allergens: ['peanuts', 'soy'],
        rating: 4.7,
        cookTimeFormatted: '15 min',
        prepTimeFormatted: '30 min',
        imageUrl: 'https://example.com/lumpiang-sariwa.jpg',
      ),

      Recipe(
        id: 189,
        name: 'Ginisang Munggo with Malunggay',
        description: 'Sautéed mung beans with moringa leaves - nutritious and healthy',
        prepTime: 15,
        cookTime: 30,
        servings: 4,
        difficulty: 'Easy',
        category: 'Vegetable',
        caloriesPerServing: 160,
        proteinPerServing: 12,
        carbsPerServing: 25,
        fatPerServing: 3,
        instructions: '''
1. Boil mung beans until tender
2. Sauté garlic, onion, and tomatoes
3. Add shrimp paste and cook for 2 minutes
4. Add cooked mung beans and mix well
5. Pour in coconut milk and simmer
6. Add malunggay leaves at the end
7. Season with salt and serve hot
        ''',
        isFilipinoDish: true,
        ingredients: ['mung beans', 'malunggay leaves', 'garlic', 'onion', 'tomatoes', 'shrimp paste', 'coconut milk'],
        tags: ['filipino', 'vegetable', 'healthy', 'protein', 'nutritious'],
        allergens: ['shellfish'],
        rating: 4.6,
        cookTimeFormatted: '30 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/ginisang-munggo-malunggay.jpg',
      ),

      Recipe(
        id: 190,
        name: 'Sinigang na Isda sa Bayabas',
        description: 'Fish sour soup with guava - tangy and healthy',
        prepTime: 15,
        cookTime: 25,
        servings: 4,
        difficulty: 'Easy',
        category: 'Soup',
        caloriesPerServing: 180,
        proteinPerServing: 22,
        carbsPerServing: 12,
        fatPerServing: 4,
        instructions: '''
1. Boil water with guava leaves and fruit
2. Add fish and simmer for 10 minutes
3. Add tomatoes, radish, and string beans
4. Season with fish sauce and salt
5. Add kangkong and okra
6. Simmer for 5 more minutes
7. Serve hot with rice
        ''',
        isFilipinoDish: true,
        ingredients: ['fish', 'guava leaves', 'guava fruit', 'tomatoes', 'radish', 'string beans', 'kangkong', 'okra'],
        tags: ['filipino', 'soup', 'healthy', 'protein', 'sour'],
        allergens: ['fish'],
        rating: 4.5,
        cookTimeFormatted: '25 min',
        prepTimeFormatted: '15 min',
        imageUrl: 'https://example.com/sinigang-isda-bayabas.jpg',
      ),
    Recipe(
        id: 191,
        name: 'Steamed Pechay with Garlic',
        description: 'Simple steamed bok choy - very low calorie',
        prepTime: 5,
        cookTime: 8,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 30,
        proteinPerServing: 3,
        carbsPerServing: 4,
        fatPerServing: 1,
        instructions: '''1. Wash pechay thoroughly
2. Steam for 6-8 minutes until tender
3. Heat 1 tsp sesame oil with minced garlic
4. Pour garlic oil over steamed pechay
5. Add a dash of light soy sauce
6. Serve immediately
7. Perfect side dish for any meal''',
        isFilipinoDish: true,
        ingredients: ['pechay', 'garlic', 'sesame oil', 'light soy sauce'],
        tags: ['healthy', 'vegetarian', 'low-calorie', 'quick'],
        allergens: ['soy'],
        rating: 4.2,
        cookTimeFormatted: '8 min',
        prepTimeFormatted: '5 min',
        imageUrl: 'https://example.com/steamed-pechay.jpg',
      ),
      
       Recipe(
        id: 192,
        name: 'Ensaladang Pipino',
        description: 'Cucumber salad with tomatoes - refreshing',
        prepTime: 10,
        cookTime: 0,
        servings: 4,
        difficulty: 'Easy',
        category: 'Healthy',
        caloriesPerServing: 35,
        proteinPerServing: 1,
        carbsPerServing: 7,
        fatPerServing: 0,
        instructions: '''1. Slice cucumbers thinly
2. Add diced tomatoes and onions
3. Make dressing: vinegar, calamansi, salt
4. Add a touch of stevia instead of sugar
5. Toss vegetables with dressing
6. Chill for 10 minutes
7. Serve cold as side dish''',
        isFilipinoDish: true,
        ingredients: ['cucumber', 'tomatoes', 'onions', 'vinegar', 'calamansi'],
        tags: ['healthy', 'salad', 'zero-fat', 'refreshing'],
        allergens: [],
        rating: 4.3,
        cookTimeFormatted: '0 min',
        prepTimeFormatted: '10 min',
        imageUrl: 'https://example.com/ensaladang-pipino.jpg',
      ),
Recipe(
  id: 193,
  name: 'Tuna Pandesal Melt',
  description: 'A light, protein-rich breakfast sandwich using whole wheat pandesal and tuna.',
  prepTime: 10,
  cookTime: 5,
  servings: 2,
  difficulty: 'Easy',
  category: 'Healthy Breakfast',
  caloriesPerServing: 220,
  proteinPerServing: 20,
  carbsPerServing: 18,
  fatPerServing: 7,
  instructions: '''1. Mix canned tuna (in water, drained) with a teaspoon of light mayonnaise and chopped celery.
2. Slice whole wheat pandesal in half and toast lightly.
3. Spread tuna mixture on the bottom half and top with a thin slice of low-fat cheese.
4. Toast in the oven or pan until cheese melts slightly.
5. Add lettuce or cucumber slices for crunch.
6. Serve warm with black coffee or green tea.''',
  isFilipinoDish: true,
  ingredients: ['whole wheat pandesal', 'tuna in water', 'light mayonnaise', 'celery', 'low-fat cheese', 'lettuce', 'cucumber'],
  tags: ['high-protein', 'low-fat', 'sandwich', 'diet-breakfast'],
  allergens: ['fish', 'dairy'],
  rating: 4.6,
  cookTimeFormatted: '5 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'https://example.com/tuna-pandesal-melt.jpg',
),
Recipe(
  id: 194,
  name: 'Ampalaya Omelette with Tomatoes',
  description: 'A low-calorie omelette packed with nutrients from bitter melon and tomatoes.',
  prepTime: 10,
  cookTime: 8,
  servings: 2,
  difficulty: 'Easy',
  category: 'Healthy Breakfast',
  caloriesPerServing: 160,
  proteinPerServing: 12,
  carbsPerServing: 6,
  fatPerServing: 8,
  instructions: '''1. Slice ampalaya thinly and soak in water with a pinch of salt for 5 minutes, then drain.
2. Sauté onion, garlic, and tomatoes in a teaspoon of olive oil.
3. Add ampalaya and cook for 2 minutes until slightly tender.
4. Beat eggs and pour over vegetables, cooking until set.
5. Fold and serve with a side of fresh papaya slices.''',
  isFilipinoDish: true,
  ingredients: ['ampalaya', 'eggs', 'onion', 'garlic', 'tomatoes', 'olive oil'],
  tags: ['low-carb', 'vegetarian', 'keto-friendly', 'high-protein', 'diet'],
  allergens: ['egg'],
  rating: 4.8,
  cookTimeFormatted: '8 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'https://example.com/ampalaya-omelette.jpg',
),
Recipe(
  id: 195,
  name: 'Oatmeal Lugaw with Malunggay and Egg',
  description: 'A fiber-rich, low-fat twist on the classic lugaw using oats and malunggay.',
  prepTime: 10,
  cookTime: 15,
  servings: 2,
  difficulty: 'Easy',
  category: 'Healthy Breakfast',
  caloriesPerServing: 180,
  proteinPerServing: 10,
  carbsPerServing: 25,
  fatPerServing: 4,
  instructions: '''1. In a pot, boil 2 cups of water and add ½ cup rolled oats.
2. Stir occasionally until the mixture thickens to lugaw consistency.
3. Add finely chopped malunggay leaves and simmer for 2 minutes.
4. Crack in one egg, stirring gently until cooked.
5. Season with salt, pepper, and a few drops of calamansi juice.
6. Serve warm, topped with a sprinkle of toasted garlic.''',
  isFilipinoDish: true,
  ingredients: ['rolled oats', 'egg', 'malunggay leaves', 'calamansi', 'salt', 'pepper', 'garlic'],
  tags: ['diet', 'fiber', 'low-fat', 'oatmeal', 'lugaw'],
  allergens: ['egg'],
  rating: 4.7,
  cookTimeFormatted: '15 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'https://example.com/oatmeal-lugaw.jpg',
),
Recipe(
  id: 196,
  name: 'Chicken and Malunggay Egg Muffins',
  description: 'Protein-packed baked egg muffins with shredded chicken and malunggay leaves.',
  prepTime: 10,
  cookTime: 20,
  servings: 4,
  difficulty: 'Easy',
  category: 'Healthy Breakfast',
  caloriesPerServing: 150,
  proteinPerServing: 14,
  carbsPerServing: 3,
  fatPerServing: 8,
  instructions: '''1. Preheat oven to 180°C.
2. In a bowl, whisk 6 eggs with salt, pepper, and a dash of milk.
3. Add shredded chicken breast, malunggay leaves, and diced tomatoes.
4. Pour into greased muffin molds.
5. Bake for 15–20 minutes or until firm and lightly golden.
6. Serve warm or store in the fridge for grab-and-go breakfast.''',
  isFilipinoDish: true,
  ingredients: ['eggs', 'chicken breast', 'malunggay leaves', 'tomatoes', 'milk', 'salt', 'pepper'],
  tags: ['high-protein', 'meal-prep', 'low-carb', 'diet', 'keto-friendly'],
  allergens: ['egg', 'dairy'],
  rating: 4.8,
  cookTimeFormatted: '20 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'https://example.com/chicken-malunggay-muffins.jpg',
),
Recipe(
  id: 197,
  name: 'Banana Oat Turon Bites',
  description: 'A lighter version of turon using oats, saba banana, and an air fryer instead of oil.',
  prepTime: 10,
  cookTime: 10,
  servings: 4,
  difficulty: 'Easy',
  category: 'Healthy Breakfast',
  caloriesPerServing: 160,
  proteinPerServing: 3,
  carbsPerServing: 28,
  fatPerServing: 4,
  instructions: '''1. Slice saba bananas into halves and roll them in oats mixed with a touch of cinnamon.
2. Wrap each in rice paper or lumpia wrapper lightly brushed with water.
3. Air fry at 180°C for 8–10 minutes until golden.
4. Drizzle lightly with honey or serve with low-fat yogurt for dipping.''',
  isFilipinoDish: true,
  ingredients: ['saba banana', 'oats', 'cinnamon', 'rice paper', 'honey', 'low-fat yogurt'],
  tags: ['low-fat', 'fiber', 'air-fryer', 'diet', 'sweet-breakfast'],
  allergens: [],
  rating: 4.7,
  cookTimeFormatted: '10 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'https://example.com/banana-oat-turon-bites.jpg',
),
Recipe(
  id: 198,
  name: 'Ginisang Monggo with Malunggay and Tinapa Flakes',
  description: 'A fiber- and protein-rich monggo dish enhanced with malunggay and a touch of tinapa.',
  prepTime: 15,
  cookTime: 30,
  servings: 3,
  difficulty: 'Medium',
  category: 'Healthy Lunch',
  caloriesPerServing: 240,
  proteinPerServing: 18,
  carbsPerServing: 22,
  fatPerServing: 7,
  instructions: '''1. Boil ½ cup mung beans until soft; drain excess water.
2. In a pan, sauté garlic, onion, and tomatoes in 1 teaspoon olive oil.
3. Add cooked monggo and mix well.
4. Stir in malunggay leaves and a small handful of tinapa flakes for flavor.
5. Simmer for 3 minutes and serve with a squeeze of calamansi.''',
  isFilipinoDish: true,
  ingredients: ['mung beans', 'malunggay', 'tinapa flakes', 'garlic', 'onion', 'tomatoes', 'olive oil', 'calamansi'],
  tags: ['fiber-rich', 'high-protein', 'heart-healthy', 'diet', 'vegetable-dish'],
  allergens: ['fish'],
  rating: 4.9,
  cookTimeFormatted: '30 min',
  prepTimeFormatted: '15 min',
  imageUrl: 'https://example.com/monggo-malunggay.jpg',
),
Recipe(
  id: 199,
  name: 'Tofu Adobo',
  description: 'A plant-based twist on adobo made with tofu and light soy sauce, served with brown rice.',
  prepTime: 10,
  cookTime: 15,
  servings: 2,
  difficulty: 'Easy',
  category: 'Healthy Lunch',
  caloriesPerServing: 230,
  proteinPerServing: 16,
  carbsPerServing: 18,
  fatPerServing: 9,
  instructions: '''1. Drain and cube firm tofu; pat dry.
2. In a pan, sauté garlic and onion in 1 teaspoon olive oil.
3. Add tofu, vinegar, soy sauce (low-sodium), and bay leaf.
4. Simmer for 5–7 minutes until sauce thickens and tofu is golden.
5. Serve over brown rice with steamed kangkong or pechay on the side.''',
  isFilipinoDish: true,
  ingredients: ['tofu', 'garlic', 'onion', 'vinegar', 'soy sauce', 'bay leaf', 'olive oil', 'brown rice', 'kangkong'],
  tags: ['plant-based', 'low-fat', 'fiber', 'diet', 'adobo'],
  allergens: ['soy'],
  rating: 4.9,
  cookTimeFormatted: '15 min',
  prepTimeFormatted: '10 min',
  imageUrl: 'https://example.com/tofu-adobo-bowl.jpg',
),
Recipe(
  id: 200,
  name: 'Vegetable Kare-Kare',
  description: 'A lighter, plant-based kare-kare using peanut butter substitute and no bagoong.',
  prepTime: 15,
  cookTime: 20,
  servings: 3,
  difficulty: 'Medium',
  category: 'Healthy Lunch',
  caloriesPerServing: 220,
  proteinPerServing: 10,
  carbsPerServing: 18,
  fatPerServing: 10,
  instructions: '''1. In a pot, sauté garlic and onion in 1 teaspoon olive oil.
2. Add sliced eggplant, pechay, sitaw, and banana heart; cook for 3–4 minutes.
3. Mix 2 tablespoons natural peanut butter (or powdered peanut butter) with 1 cup low-sodium vegetable broth.
4. Pour mixture into the pot and simmer until vegetables are tender.
5. Season with a pinch of salt and serve with a few slices of grilled tofu.''',
  isFilipinoDish: true,
  ingredients: ['eggplant', 'pechay', 'sitaw', 'banana heart', 'peanut butter', 'vegetable broth', 'olive oil', 'tofu'],
  tags: ['plant-based', 'low-sodium', 'fiber-rich', 'diet', 'vegan'],
  allergens: ['peanuts', 'soy'],
  rating: 4.7,
  cookTimeFormatted: '20 min',
  prepTimeFormatted: '15 min',
  imageUrl: 'https://example.com/vegetable-kare-kare-lite.jpg',
),
Recipe(
  id: 201,
  name: 'Chicken Adobo sa Puso ng Saging',
  description: 'A fiber-rich, heart-healthy twist on adobo using lean chicken breast and banana blossom.',
  prepTime: 15,
  cookTime: 20,
  servings: 3,
  difficulty: 'Medium',
  category: 'Healthy Lunch',
  caloriesPerServing: 210,
  proteinPerServing: 22,
  carbsPerServing: 10,
  fatPerServing: 7,
  instructions: '''1. Boil banana blossoms for 5 minutes, then drain.
2. In a pan, sauté garlic and onion in 1 teaspoon olive oil.
3. Add chicken breast and cook until lightly browned.
4. Pour vinegar, low-sodium soy sauce, and bay leaf; simmer for 10 minutes.
5. Stir in the banana blossoms and cook until sauce reduces slightly.
6. Serve with steamed vegetables or ½ cup brown rice.''',
  isFilipinoDish: true,
  ingredients: ['chicken breast', 'banana blossom', 'vinegar', 'soy sauce', 'garlic', 'onion', 'olive oil', 'bay leaf'],
  tags: ['adobo', 'low-sodium', 'high-protein', 'fiber', 'diet'],
  allergens: ['soy'],
  rating: 4.9,
  cookTimeFormatted: '20 min',
  prepTimeFormatted: '15 min',
  imageUrl: 'https://example.com/chicken-adobo-puso.jpg',
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
