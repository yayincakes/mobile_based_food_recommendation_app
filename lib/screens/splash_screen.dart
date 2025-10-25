import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profile_management_service.dart';
import '../services/user_data_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  static const Color darkGreen = Color(0xFF006400);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Check login status and route accordingly
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if user is logged in
      final currentUser = prefs.getString('current_user');
      final isAdminLoggedIn = prefs.getBool('is_admin_logged_in') ?? false;
      
      // Wait for splash animation to complete
      await Future.delayed(const Duration(milliseconds: 2200));
      
      if (!mounted) return;
      
      // Route based on login status
      if (isAdminLoggedIn) {
        // Admin user - go to admin dashboard
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
      } else if (currentUser != null) {
        // Regular user - check if they have completed onboarding
        final hasCompletedOnboarding = await UserDataService.isOnboardingCompleted();
        final hasActiveMealPlan = await ProfileManagementService.getActiveMealPlan() != null;
        
        if (hasCompletedOnboarding && hasActiveMealPlan) {
          // User is fully set up - go to dashboard
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else if (hasCompletedOnboarding && !hasActiveMealPlan) {
          // User completed onboarding but no meal plan - go to create plan
          Navigator.pushReplacementNamed(context, '/create_plan');
        } else {
          // User not fully set up - go to onboarding
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      } else {
        // No user logged in - go to onboarding
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    } catch (e) {
      // On error, go to onboarding
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: _fade,
                child: Text(
                  'FitMeal',
                  style: GoogleFonts.pacifico(
                    fontSize: 48,
                    color: Colors.white,
                    shadows: const [
                      Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Text(
                'NutriGuide',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
