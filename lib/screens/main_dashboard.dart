import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';
import 'ingredient_search_screen.dart';
import 'favorite_screen.dart';
import 'tracker_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const FitMealApp());
}

class FitMealApp extends StatelessWidget {
  const FitMealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitMeal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(primary: const Color(0xFF006400)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  static const darkGreen = Color(0xFF006400);

  final List<Widget> _pages = const [
    DashboardScreen(),
    IngredientSearchScreen(),
    FavoriteScreen(),
    TrackerScreen(),    
    ProfileScreen(),     
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // Add meal/plan logic here
              },
              backgroundColor: darkGreen,
              child: const Icon(Icons.add, color: Colors.white),
              tooltip: "Add meal/plan",
            )
          : null,
          bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: darkGreen,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0, // dashboard is index 0
          onTap: (i) {
            if (i == 0) {
              // already on home
            } else if (i == 1) {
              Navigator.pushNamed(context, '/ingredient_search'); // if you have this route
            } else if (i == 2) {
              Navigator.pushNamed(context, '/favorites'); // <-- go to Favorites
            } else if (i == 3) {
              Navigator.pushNamed(context, '/tracker');
            } else if (i == 4) {
              Navigator.pushNamed(context, '/profile');
            }
          },
          items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: 'Tracker'), 
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
