import 'package:flutter/material.dart';
import 'package:food_recommendation_app/screens/profile_screen.dart';
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

      // Flow:
      // / (Splash) -> /onboarding -> /login -> /create_plan -> /onboarding_flow -> /dashboard
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/create_plan': (context) => const CreateMealPlanScreen(),
        '/onboarding_flow': (context) => const OnboardingFlowScreen(),
        '/dashboard': (context) => const MainDashboard(),

        // Extra pages (reachable from dashboard/bottom nav)
        '/ingredient_search': (context) => const IngredientSearchScreen(),
        '/favorites': (context) => const FavoriteScreen(),
        '/tracker': (context) => const TrackerScreen(),
        '/profile': (context) => const ProfileScreen(), // optional direct route
      },
    );
  }
}