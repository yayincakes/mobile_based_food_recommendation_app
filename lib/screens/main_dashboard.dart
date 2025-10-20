import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';
import 'ingredient_search_screen.dart';
import 'favorite_screen.dart';
import 'tracker_screen.dart';
import 'profile_screen.dart';

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

  final List<NavigationItem> _navigationItems = const [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
      route: '/dashboard',
    ),
    NavigationItem(
      icon: Icons.search,
      activeIcon: Icons.search,
      label: 'Search',
      route: '/ingredient_search',
    ),
    NavigationItem(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: 'Favorites',
      route: '/favorites',
    ),
    NavigationItem(
      icon: Icons.directions_run_outlined,
      activeIcon: Icons.directions_run,
      label: 'Tracker',
      route: '/tracker',
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
      route: '/profile',
    ),
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: _selectedIndex == 0 // Only show on home tab
          ? FloatingActionButton.extended(
              onPressed: _showAddMealDialog,
              backgroundColor: darkGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: Text(
                'Add Meal',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navigationItems.length, (index) {
                final item = _navigationItems[index];
                final isSelected = index == _selectedIndex;
                
                return Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? darkGreen.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isSelected ? item.activeIcon : item.icon,
                              color: isSelected ? darkGreen : Colors.grey,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isSelected ? darkGreen : Colors.grey,
                              fontWeight: isSelected 
                                  ? FontWeight.w600 
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddMealDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddMealBottomSheet(onMealAdded: _onMealAdded),
    );
  }

  void _onMealAdded(String mealType, String mealName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $mealName to $mealType'),
        backgroundColor: darkGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}

class AddMealBottomSheet extends StatefulWidget {
  final Function(String mealType, String mealName) onMealAdded;

  const AddMealBottomSheet({
    super.key,
    required this.onMealAdded,
  });

  @override
  State<AddMealBottomSheet> createState() => _AddMealBottomSheetState();
}

class _AddMealBottomSheetState extends State<AddMealBottomSheet> {
  static const darkGreen = Color(0xFF006400);
  String _selectedMealType = 'Breakfast';
  final _mealController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _mealTypes = [
    'Breakfast',
    'Morning Snack',
    'Lunch', 
    'Afternoon Snack',
    'Dinner',
    'Evening Snack',
  ];

  final List<String> _quickMeals = [
    'Tapsilog',
    'Chicken Adobo',
    'Sinigang na Baboy',
    'Pancit Canton',
    'Lumpia Shanghai',
    'Arroz Caldo',
    'Tinola',
    'Pinakbet',
    'Lechon Kawali',
    'Kare-Kare',
    'Sisig',
    'Bangus',
    'Champorado',
    'Turon',
    'Banana Cue',
    'Halo-Halo',
  ];

  @override
  void dispose() {
    _mealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Title
          Text(
            'Add Meal',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // Meal type selector
          Text(
            'Meal Type',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedMealType,
                isExpanded: true,
                items: _mealTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type, style: GoogleFonts.poppins()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedMealType = value);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Custom meal input
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _mealController,
              decoration: InputDecoration(
                labelText: 'Meal Name',
                hintText: 'e.g., Chicken Adobo with Rice',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.restaurant),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter a meal name';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _addMeal(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Quick add options
          Text(
            'Quick Add (Filipino Favorites)',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _quickMeals.length,
              itemBuilder: (context, index) {
                final meal = _quickMeals[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < _quickMeals.length - 1 ? 8 : 0,
                  ),
                  child: ActionChip(
                    label: Text(
                      meal,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    onPressed: () => _addQuickMeal(meal),
                    backgroundColor: Colors.orange.shade50,
                    side: BorderSide(color: Colors.orange.shade200),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _addMeal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    'Add Meal',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addMeal() {
    if (_formKey.currentState?.validate() ?? false) {
      final mealName = _mealController.text.trim();
      widget.onMealAdded(_selectedMealType, mealName);
      Navigator.pop(context);
    }
  }

  void _addQuickMeal(String meal) {
    widget.onMealAdded(_selectedMealType, meal);
    Navigator.pop(context);
  }
}