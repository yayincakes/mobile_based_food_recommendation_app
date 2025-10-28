class HealthConditionInfo {
  final String name;
  final String description;
  final String dietaryImpact;
  final List<String> foodsToAvoid;
  final List<String> recommendedFoods;
  final String severityExplanation;
  final String managementTips;
  final String icon;

  HealthConditionInfo({
    required this.name,
    required this.description,
    required this.dietaryImpact,
    required this.foodsToAvoid,
    required this.recommendedFoods,
    required this.severityExplanation,
    required this.managementTips,
    required this.icon,
  });
}

class AllergyInfo {
  final String name;
  final String description;
  final String severityLevel;
  final List<String> hiddenSources;
  final List<String> safeAlternatives;
  final String crossReactivityInfo;
  final String icon;

  AllergyInfo({
    required this.name,
    required this.description,
    required this.severityLevel,
    required this.hiddenSources,
    required this.safeAlternatives,
    required this.crossReactivityInfo,
    required this.icon,
  });
}

class NutritionTermInfo {
  final String term;
  final String definition;
  final String importance;
  final String dailyRecommendation;
  final List<String> foodSources;
  final String healthImpact;
  final String icon;

  NutritionTermInfo({
    required this.term,
    required this.definition,
    required this.importance,
    required this.dailyRecommendation,
    required this.foodSources,
    required this.healthImpact,
    required this.icon,
  });
}

class HealthDictionaryService {
  // Health Conditions Dictionary
  static final Map<String, HealthConditionInfo> healthConditions = {
    'Diabetes': HealthConditionInfo(
      name: 'Diabetes',
      description: 'A condition where your body can\'t properly use glucose (sugar) for energy, leading to high blood sugar levels.',
      dietaryImpact: 'Requires careful monitoring of carbohydrate intake and blood sugar levels. Timing of meals is crucial.',
      foodsToAvoid: [
        'Sugar and sweets',
        'White rice and white bread',
        'Soda and sugary drinks',
        'Candy and desserts',
        'Processed foods with added sugar',
        'Fruit juices (high sugar content)'
      ],
      recommendedFoods: [
        'Whole grains (brown rice, quinoa)',
        'Non-starchy vegetables',
        'Lean proteins (fish, chicken)',
        'High-fiber foods',
        'Low-glycemic fruits (berries)',
        'Healthy fats (avocado, nuts)'
      ],
      severityExplanation: 'Can range from mild (diet-controlled) to severe (insulin-dependent). Type 2 is most common.',
      managementTips: 'Eat regular meals, monitor blood sugar, choose low-glycemic foods, and maintain consistent carbohydrate intake.',
      icon: '🩺',
    ),
    'Hypertension': HealthConditionInfo(
      name: 'Hypertension',
      description: 'High blood pressure that can damage your heart, blood vessels, and other organs over time.',
      dietaryImpact: 'Sodium restriction is key. A heart-healthy diet can help lower blood pressure naturally.',
      foodsToAvoid: [
        'High-sodium foods',
        'Processed and canned foods',
        'Pickled and cured foods',
        'Fast food',
        'Salted snacks',
        'Excessive alcohol'
      ],
      recommendedFoods: [
        'Fresh fruits and vegetables',
        'Whole grains',
        'Lean proteins',
        'Low-fat dairy',
        'Foods rich in potassium',
        'Heart-healthy fats'
      ],
      severityExplanation: 'Mild (130-139/80-89), Moderate (140-159/90-99), Severe (160+/100+). Can be managed with lifestyle changes.',
      managementTips: 'Limit sodium to 2,300mg daily, increase potassium intake, maintain healthy weight, and exercise regularly.',
      icon: '❤️',
    ),
    'CKD': HealthConditionInfo(
      name: 'Chronic Kidney Disease (CKD)',
      description: 'Progressive loss of kidney function over time, affecting the body\'s ability to filter waste and excess fluids.',
      dietaryImpact: 'Requires careful monitoring of protein, sodium, potassium, and phosphorus intake to reduce kidney workload.',
      foodsToAvoid: [
        'High-protein foods (excessive amounts)',
        'High-sodium foods',
        'High-potassium foods (bananas, oranges)',
        'High-phosphorus foods (dairy, nuts)',
        'Processed foods',
        'Dark sodas (high phosphorus)'
      ],
      recommendedFoods: [
        'Low-potassium vegetables',
        'Appropriate protein portions',
        'Fresh fruits (limited amounts)',
        'Whole grains',
        'Healthy fats',
        'Low-sodium foods'
      ],
      severityExplanation: 'Stages 1-5 based on kidney function. Early stages may have no symptoms, while advanced stages require dialysis.',
      managementTips: 'Work with a dietitian, monitor lab values, control blood pressure and diabetes, and limit protein as recommended.',
      icon: '🫘',
    ),
    'Hyperlipidemia': HealthConditionInfo(
      name: 'Hyperlipidemia',
      description: 'High levels of fats (lipids) in the blood, including cholesterol and triglycerides, increasing heart disease risk.',
      dietaryImpact: 'Focus on heart-healthy fats and fiber while limiting saturated and trans fats to improve lipid profile.',
      foodsToAvoid: [
        'Saturated fats (red meat, full-fat dairy)',
        'Trans fats (fried foods, processed snacks)',
        'High-cholesterol foods',
        'Excessive alcohol',
        'Refined carbohydrates',
        'Processed meats'
      ],
      recommendedFoods: [
        'Omega-3 rich fish',
        'Fiber-rich foods',
        'Plant-based proteins',
        'Nuts and seeds',
        'Fruits and vegetables',
        'Whole grains'
      ],
      severityExplanation: 'Can be genetic or lifestyle-related. High cholesterol increases risk of heart attack and stroke.',
      managementTips: 'Choose healthy fats, increase fiber intake, exercise regularly, and consider medication if lifestyle changes aren\'t enough.',
      icon: '🫀',
    ),
  };

  // Allergies Dictionary
  static final Map<String, AllergyInfo> allergies = {
    'Nut allergy': AllergyInfo(
      name: 'Nut Allergy',
      description: 'Severe allergic reaction to tree nuts and peanuts that can cause life-threatening anaphylaxis.',
      severityLevel: 'Can be life-threatening (anaphylaxis) - requires immediate medical attention',
      hiddenSources: [
        'Nut oils and extracts',
        'Cross-contamination in facilities',
        'Baked goods and desserts',
        'Salad dressings',
        'Cereals and granola',
        'Asian and Mediterranean dishes'
      ],
      safeAlternatives: [
        'Sunflower seeds',
        'Pumpkin seeds',
        'Soy nuts',
        'Seed butters',
        'Coconut (if not allergic)',
        'Oat-based products'
      ],
      crossReactivityInfo: 'May also react to other tree nuts or legumes. Always read labels carefully.',
      icon: '🥜',
    ),
    'Dairy-free': AllergyInfo(
      name: 'Dairy Allergy/Intolerance',
      description: 'Inability to digest lactose (milk sugar) or allergic reaction to milk proteins.',
      severityLevel: 'Can range from mild discomfort to severe allergic reaction',
      hiddenSources: [
        'Whey and casein proteins',
        'Lactose in medications',
        'Baked goods',
        'Processed foods',
        'Non-dairy creamers (may contain milk)',
        'Chocolate and candies'
      ],
      safeAlternatives: [
        'Almond milk',
        'Oat milk',
        'Coconut milk',
        'Soy milk',
        'Rice milk',
        'Dairy-free cheeses'
      ],
      crossReactivityInfo: 'May also react to goat\'s milk or sheep\'s milk. Check for hidden dairy ingredients.',
      icon: '🥛',
    ),
    'Gluten-free': AllergyInfo(
      name: 'Gluten Intolerance/Celiac Disease',
      description: 'Inability to digest gluten (found in wheat, barley, rye) or autoimmune reaction to gluten.',
      severityLevel: 'Celiac disease can cause serious intestinal damage; gluten sensitivity causes discomfort',
      hiddenSources: [
        'Wheat, barley, rye',
        'Soy sauce',
        'Beer and malt beverages',
        'Processed foods',
        'Medications and supplements',
        'Cross-contamination'
      ],
      safeAlternatives: [
        'Rice and rice flour',
        'Quinoa',
        'Buckwheat',
        'Almond flour',
        'Coconut flour',
        'Certified gluten-free oats'
      ],
      crossReactivityInfo: 'Must avoid all gluten-containing grains. Look for certified gluten-free products.',
      icon: '🌾',
    ),
    'Vegetarian': AllergyInfo(
      name: 'Vegetarian Diet',
      description: 'Diet that excludes meat and fish but may include dairy and eggs.',
      severityLevel: 'Dietary choice - not an allergy',
      hiddenSources: [
        'Meat and fish',
        'Gelatin',
        'Rennet (in some cheeses)',
        'Lard',
        'Meat-based broths',
        'Some wines and beers'
      ],
      safeAlternatives: [
        'Plant-based proteins',
        'Legumes and beans',
        'Tofu and tempeh',
        'Dairy and eggs',
        'Nuts and seeds',
        'Whole grains'
      ],
      crossReactivityInfo: 'Focus on getting complete proteins from plant sources or dairy/eggs.',
      icon: '🥬',
    ),
    'Vegan': AllergyInfo(
      name: 'Vegan Diet',
      description: 'Diet that excludes all animal products including meat, dairy, eggs, and honey.',
      severityLevel: 'Dietary choice - requires careful planning for nutrients',
      hiddenSources: [
        'All animal products',
        'Dairy and eggs',
        'Honey',
        'Gelatin',
        'Whey and casein',
        'Some vitamins and supplements'
      ],
      safeAlternatives: [
        'Plant-based proteins',
        'Nut milks',
        'Tofu and tempeh',
        'Nutritional yeast',
        'Plant-based cheeses',
        'Maple syrup or agave'
      ],
      crossReactivityInfo: 'Ensure adequate intake of B12, iron, calcium, and omega-3 fatty acids.',
      icon: '🌱',
    ),
  };

  // Nutrition Terms Dictionary
  static final Map<String, NutritionTermInfo> nutritionTerms = {
    'BMI': NutritionTermInfo(
      term: 'BMI (Body Mass Index)',
      definition: 'A measure of body fat based on height and weight, calculated as weight (kg) divided by height (m) squared.',
      importance: 'Helps assess if your weight is healthy for your height and identifies potential health risks.',
      dailyRecommendation: 'Aim for BMI between 18.5-24.9 for optimal health',
      foodSources: ['Not applicable - calculated from height and weight'],
      healthImpact: 'High BMI increases risk of diabetes, heart disease, high blood pressure, and other conditions.',
      icon: '⚖️',
    ),
    'Calories': NutritionTermInfo(
      term: 'Calories',
      definition: 'Units of energy that your body uses for all functions including breathing, digestion, and physical activity.',
      importance: 'Balancing calories consumed with calories burned is key to maintaining, losing, or gaining weight.',
      dailyRecommendation: 'Adults typically need 1,800-2,400 calories daily, depending on age, gender, and activity level',
      foodSources: ['All foods provide calories - proteins and carbs (4 cal/g), fats (9 cal/g), alcohol (7 cal/g)'],
      healthImpact: 'Too many calories lead to weight gain; too few can cause nutrient deficiencies and metabolic slowdown.',
      icon: '🔥',
    ),
    'Protein': NutritionTermInfo(
      term: 'Protein',
      definition: 'Essential macronutrient made of amino acids, crucial for building and repairing muscles, tissues, and enzymes.',
      importance: 'Supports muscle growth, immune function, hormone production, and helps you feel full longer.',
      dailyRecommendation: 'Adults need about 0.8g per kg of body weight daily (56g for 70kg person)',
      foodSources: ['Meat, fish, poultry, eggs, dairy, beans, nuts, seeds, tofu, quinoa'],
      healthImpact: 'Inadequate protein can lead to muscle loss, weakened immunity, and slower recovery from illness.',
      icon: '💪',
    ),
    'Carbs': NutritionTermInfo(
      term: 'Carbohydrates',
      definition: 'Your body\'s main energy source, broken down into glucose for immediate energy or stored as glycogen.',
      importance: 'Provides energy for brain function, physical activity, and helps preserve muscle during exercise.',
      dailyRecommendation: '45-65% of total daily calories should come from carbohydrates',
      foodSources: ['Whole grains, fruits, vegetables, legumes, dairy products, nuts, seeds'],
      healthImpact: 'Complex carbs provide sustained energy; simple carbs cause blood sugar spikes and crashes.',
      icon: '🍞',
    ),
    'Fat': NutritionTermInfo(
      term: 'Dietary Fat',
      definition: 'Essential macronutrient that provides energy, supports cell growth, and helps absorb vitamins A, D, E, K.',
      importance: 'Necessary for hormone production, brain health, and protecting vital organs.',
      dailyRecommendation: '20-35% of total daily calories should come from healthy fats',
      foodSources: ['Avocados, nuts, seeds, olive oil, fatty fish, coconut, dark chocolate'],
      healthImpact: 'Healthy fats support heart health; trans fats increase heart disease risk.',
      icon: '🥑',
    ),
    'Fiber': NutritionTermInfo(
      term: 'Dietary Fiber',
      definition: 'Indigestible plant material that promotes digestive health and helps control blood sugar and cholesterol.',
      importance: 'Supports gut health, helps maintain healthy weight, and reduces risk of chronic diseases.',
      dailyRecommendation: 'Women: 25g daily, Men: 38g daily (most people get only 15g)',
      foodSources: ['Fruits, vegetables, whole grains, legumes, nuts, seeds, bran'],
      healthImpact: 'High fiber intake reduces risk of heart disease, diabetes, and certain cancers.',
      icon: '🌾',
    ),
    'Sodium': NutritionTermInfo(
      term: 'Sodium',
      definition: 'Essential mineral that helps maintain fluid balance and nerve function, but excess can raise blood pressure.',
      importance: 'Needed for proper muscle and nerve function, but most people consume too much.',
      dailyRecommendation: 'Limit to 2,300mg daily (1 teaspoon of salt), ideally 1,500mg for adults',
      foodSources: ['Table salt, processed foods, canned foods, restaurant meals, condiments'],
      healthImpact: 'Excess sodium increases blood pressure and risk of heart disease and stroke.',
      icon: '🧂',
    ),
    'Sugar': NutritionTermInfo(
      term: 'Added Sugar',
      definition: 'Sugars added to foods during processing or preparation, different from natural sugars in fruits.',
      importance: 'Provides quick energy but excessive intake can lead to weight gain and health problems.',
      dailyRecommendation: 'Limit to 25g (6 teaspoons) daily for women, 37g (9 teaspoons) for men',
      foodSources: ['Soda, candy, desserts, processed foods, condiments, flavored drinks'],
      healthImpact: 'Excess sugar contributes to obesity, diabetes, heart disease, and tooth decay.',
      icon: '🍭',
    ),
  };

  // Get all health conditions
  static List<HealthConditionInfo> getAllHealthConditions() {
    return healthConditions.values.toList();
  }

  // Get all allergies
  static List<AllergyInfo> getAllAllergies() {
    return allergies.values.toList();
  }

  // Get all nutrition terms
  static List<NutritionTermInfo> getAllNutritionTerms() {
    return nutritionTerms.values.toList();
  }

  // Search across all categories
  static List<dynamic> searchAll(String query) {
    final results = <dynamic>[];
    final lowerQuery = query.toLowerCase();

    // Search health conditions
    healthConditions.forEach((key, value) {
      if (value.name.toLowerCase().contains(lowerQuery) ||
          value.description.toLowerCase().contains(lowerQuery) ||
          value.foodsToAvoid.any((food) => food.toLowerCase().contains(lowerQuery)) ||
          value.recommendedFoods.any((food) => food.toLowerCase().contains(lowerQuery))) {
        results.add(value);
      }
    });

    // Search allergies
    allergies.forEach((key, value) {
      if (value.name.toLowerCase().contains(lowerQuery) ||
          value.description.toLowerCase().contains(lowerQuery) ||
          value.safeAlternatives.any((alt) => alt.toLowerCase().contains(lowerQuery))) {
        results.add(value);
      }
    });

    // Search nutrition terms
    nutritionTerms.forEach((key, value) {
      if (value.term.toLowerCase().contains(lowerQuery) ||
          value.definition.toLowerCase().contains(lowerQuery) ||
          value.foodSources.any((source) => source.toLowerCase().contains(lowerQuery))) {
        results.add(value);
      }
    });

    return results;
  }

  // Get specific health condition
  static HealthConditionInfo? getHealthCondition(String name) {
    return healthConditions[name];
  }

  // Get specific allergy
  static AllergyInfo? getAllergy(String name) {
    return allergies[name];
  }

  // Get specific nutrition term
  static NutritionTermInfo? getNutritionTerm(String term) {
    return nutritionTerms[term];
  }
}
