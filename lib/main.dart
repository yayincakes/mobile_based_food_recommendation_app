import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_dashboard.dart';
import 'screens/ingredient_search_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/create_meal_plan_screen.dart';
import 'screens/onboarding_flow_screen.dart';
import 'screens/tracker_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/daily_nutrition_screen.dart';
import 'screens/goals_management_screen.dart';
import 'screens/health_conditions_management_screen.dart';
import 'screens/allergies_management_screen.dart';
import 'screens/meal_plans_management_screen.dart';
import 'screens/diet_history_management_screen.dart';
import 'screens/meal_logging_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/admin/admin_users_screen.dart';
import 'screens/admin/admin_recipes_screen.dart';
import 'screens/admin/admin_analytics_screen.dart';

void main() {
  runApp(const FitMealApp());
}

class FitMealApp extends StatelessWidget {
  const FitMealApp({super.key});

  static const Color darkGreen = Color(0xFF006400);

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: darkGreen, primary: darkGreen),
      useMaterial3: false,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitMeal',
      theme: base.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        primaryColor: darkGreen,
      ),
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  static Route<dynamic>? _generateRoute(RouteSettings settings) {
    // Handle route arguments properly
    final args = settings.arguments as Map<String, dynamic>?;
    
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/create_plan':
      case '/create_meal_plan':
        return MaterialPageRoute(builder: (_) => const CreateMealPlanScreen());
      case '/onboarding_flow':
        return MaterialPageRoute(
          builder: (_) => OnboardingFlowScreen(
            planMode: args?['mode'] ?? 'auto',
          ),
        );
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const MainDashboard());
      case '/ingredient_search':
        return MaterialPageRoute(builder: (_) => const IngredientSearchScreen());
      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case '/tracker':
        return MaterialPageRoute(builder: (_) => const TrackerScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/daily-nutrition':
        return MaterialPageRoute(builder: (_) => const DailyNutritionScreen());
      case '/goals_management':
        return MaterialPageRoute(builder: (_) => const GoalsManagementScreen());
      case '/health_conditions_management':
        return MaterialPageRoute(builder: (_) => const HealthConditionsManagementScreen());
      case '/allergies_management':
        return MaterialPageRoute(builder: (_) => const AllergiesManagementScreen());
      case '/meal_plans_management':
        return MaterialPageRoute(builder: (_) => const MealPlansManagementScreen());
      case '/diet_history_management':
        return MaterialPageRoute(builder: (_) => const DietHistoryManagementScreen());
      case '/log_meal':
        return MaterialPageRoute(builder: (_) => const MealLoggingScreen());
      // Admin routes
      case '/admin_login':
        return MaterialPageRoute(builder: (_) => const AdminLoginScreen());
      case '/admin_dashboard':
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      case '/admin_users':
        return MaterialPageRoute(builder: (_) => const AdminUsersScreen());
      case '/admin_recipes':
        return MaterialPageRoute(builder: (_) => const AdminRecipesScreen());
      case '/admin_analytics':
        return MaterialPageRoute(builder: (_) => const AdminAnalyticsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }
}