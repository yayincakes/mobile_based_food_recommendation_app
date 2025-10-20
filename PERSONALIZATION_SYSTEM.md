# 🎯 Personalization System Documentation

## Overview
The Food Recommendation App features a comprehensive personalization system that tailors meal suggestions and recipe recommendations based on user health conditions, dietary restrictions, and fitness goals.

## 🏗️ System Architecture

### Core Components:
1. **UserPreferenceService** - Manages user preferences and filtering logic
2. **MealSuggestionService** - Provides intelligent meal suggestions
3. **MealPlanService** - Handles meal plan generation and management
4. **ApiService** - Manages API communication with Laravel backend

## 📊 User Profile Data

### Health Information:
- **Gender** - Male/Female (affects calorie calculations)
- **Height** - In centimeters (BMI calculations)
- **Weight** - Current weight in kg
- **Target Weight** - Goal weight in kg
- **Birth Date** - Age calculations
- **Activity Level** - Sedentary/Moderate/Active/Very Active

### Health Conditions:
- **Diabetes** - Filters high-sugar recipes
- **Hypertension** - Limits sodium content
- **Heart Disease** - Focuses on heart-healthy options
- **CKD (Chronic Kidney Disease)** - Restricts protein and sodium

### Dietary Restrictions:
- **Vegetarian** - Excludes meat recipes
- **Vegan** - Excludes all animal products
- **Gluten-Free** - Avoids gluten-containing ingredients
- **Dairy-Free** - Excludes dairy products
- **Nut Allergies** - Removes nut-containing recipes

### Fitness Goals:
- **Weight Loss** - Lower calorie, higher protein options
- **Weight Gain** - Higher calorie, balanced macros
- **Muscle Building** - High protein, moderate carbs
- **Maintenance** - Balanced macro distribution

## 🧠 Smart Filtering Logic

### Recipe Filtering Algorithm:
```dart
List<Map<String, dynamic>> filterRecipesForUser(
  List<Map<String, dynamic>> recipes,
  {List<String>? healthConditions,
   List<String>? dietaryRestrictions,
   String? goal}
) {
  return recipes.where((recipe) {
    // Health condition filtering
    if (healthConditions != null) {
      for (String condition in healthConditions) {
        if (!_isRecipeSuitableForCondition(recipe, condition)) {
          return false;
        }
      }
    }
    
    // Dietary restriction filtering
    if (dietaryRestrictions != null) {
      for (String restriction in dietaryRestrictions) {
        if (!_isRecipeSuitableForRestriction(recipe, restriction)) {
          return false;
        }
      }
    }
    
    // Goal-based filtering
    if (goal != null && !_isRecipeSuitableForGoal(recipe, goal)) {
      return false;
    }
    
    return true;
  }).toList();
}
```

### Health Condition Rules:

#### Diabetes:
- Excludes recipes with >15g sugar per serving
- Prioritizes low-glycemic index ingredients
- Avoids high-carb recipes (>50g carbs per serving)

#### Hypertension:
- Limits sodium content (<600mg per serving)
- Avoids processed ingredients
- Emphasizes fresh vegetables and lean proteins

#### Heart Disease:
- Focuses on heart-healthy fats (omega-3, monounsaturated)
- Limits saturated fats (<7g per serving)
- Emphasizes fiber-rich ingredients

#### CKD (Chronic Kidney Disease):
- Restricts protein content (<25g per serving)
- Limits sodium (<400mg per serving)
- Avoids high-potassium ingredients

### Dietary Restriction Rules:

#### Vegetarian:
- Excludes recipes containing meat, poultry, fish
- Allows dairy and eggs

#### Vegan:
- Excludes all animal products
- Focuses on plant-based proteins

#### Gluten-Free:
- Avoids wheat, barley, rye, and their derivatives
- Uses gluten-free alternatives

#### Dairy-Free:
- Excludes milk, cheese, butter, cream
- Uses plant-based alternatives

#### Nut Allergies:
- Removes recipes with tree nuts and peanuts
- Checks ingredient lists thoroughly

## 🎯 Goal-Based Recommendations

### Weight Loss:
- **Calorie Target**: 1200-1500 kcal/day
- **Macro Split**: 40% Protein, 30% Carbs, 30% Fat
- **Focus**: High protein, low calorie, high fiber

### Weight Gain:
- **Calorie Target**: 2500-3000 kcal/day
- **Macro Split**: 25% Protein, 50% Carbs, 25% Fat
- **Focus**: Calorie-dense, nutrient-rich foods

### Muscle Building:
- **Calorie Target**: 2000-2500 kcal/day
- **Macro Split**: 35% Protein, 40% Carbs, 25% Fat
- **Focus**: High protein, complex carbs, healthy fats

### Maintenance:
- **Calorie Target**: 1800-2200 kcal/day
- **Macro Split**: 30% Protein, 40% Carbs, 30% Fat
- **Focus**: Balanced nutrition, variety

## 📱 User Interface Integration

### Dashboard Screen:
- Displays personalized recipe recommendations
- Shows health-based meal suggestions
- Provides macro tracking and progress
- Features smart meal suggestions

### Ingredient Search Screen:
- Filters recipes based on user preferences
- Shows health-compatible options first
- Highlights suitable ingredients

### Create Meal Plan Screen:
- Captures user health conditions and restrictions
- Generates personalized meal plans
- Adjusts portion sizes based on goals

## 🔄 Data Flow

1. **User Registration** → Profile data stored in SharedPreferences
2. **Preference Selection** → Health conditions and restrictions saved
3. **Recipe Fetching** → API calls filtered through personalization logic
4. **Meal Plan Generation** → Algorithms create customized plans
5. **Smart Suggestions** → AI-powered recommendations based on preferences

## 🧪 Testing Scenarios

### Test Case 1: Diabetic User
- **Input**: Diabetes condition, Weight Loss goal
- **Expected**: Low-sugar, high-protein recipes
- **Verification**: All suggested recipes <15g sugar

### Test Case 2: Vegetarian with Hypertension
- **Input**: Vegetarian restriction, Hypertension condition
- **Expected**: Plant-based, low-sodium recipes
- **Verification**: No meat, <600mg sodium per serving

### Test Case 3: Muscle Building Goal
- **Input**: Muscle Building goal, Active lifestyle
- **Expected**: High-protein, calorie-dense recipes
- **Verification**: >25g protein, 2000+ calories per day

## 📈 Performance Optimization

### Caching Strategy:
- User preferences cached locally
- Recipe filtering results cached
- Smart suggestions cached for 1 hour

### API Optimization:
- Batch recipe filtering on server
- Pagination for large recipe sets
- Compressed response data

## 🔮 Future Enhancements

### Planned Features:
- **Machine Learning**: Learn from user preferences over time
- **Seasonal Recommendations**: Weather-based meal suggestions
- **Social Features**: Share personalized meal plans
- **Advanced Analytics**: Detailed nutrition tracking
- **Integration**: Connect with fitness trackers

## 🛠️ Implementation Notes

### Key Files:
- `lib/services/user_preference_service.dart` - Core personalization logic
- `lib/services/meal_suggestion_service.dart` - Smart suggestions
- `lib/services/meal_plan_service.dart` - Meal plan management
- `lib/screens/dashboard_screen.dart` - Personalized dashboard
- `lib/screens/create_meal_plan_screen.dart` - Preference capture

### Dependencies:
- `shared_preferences` - Local preference storage
- `http` - API communication
- `flutter/material.dart` - UI components

---

This personalization system ensures that every user receives tailored, health-conscious meal recommendations that align with their individual needs and goals. 🎯✨
