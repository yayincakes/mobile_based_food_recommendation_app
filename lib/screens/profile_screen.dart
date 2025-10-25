import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'favorites_manager.dart';
import '../models/user_profile.dart';
import '../models/diet_history.dart';
import '../services/profile_management_service.dart';
import '../services/user_data_service.dart';
import '../services/diet_history_service.dart';
import '../widgets/diet_history_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  final Color soft = const Color(0xFFF7F9F7);

  // Profile data
  UserProfile? _profile;
  UserProfileData? _userProfileData;
  List<DietaryGoal> _goals = [];
  List<HealthCondition> _healthConditions = [];
  List<Allergy> _allergies = [];
  List<MealPlan> _mealPlans = [];

  // Settings persisted locally
  bool _notifEnabled = true;
  bool _useMetric = true; // true: cm/kg, false: ft/lbs

  // Diet history data
  List<DailyNutritionSummary> _recentNutritionSummaries = [];
  DietAdherenceScore? _currentAdherenceScore;
  bool _isLoadingDietHistory = false;
  
  // Loading states for management sections
  bool _isLoadingGoals = false;
  bool _isLoadingHealthConditions = false;
  bool _isLoadingAllergies = false;
  bool _isLoadingMealPlans = false;
  
  // Error states
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadDietHistory();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh diet history when screen becomes visible
    _loadDietHistory();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    
    try {
      setState(() {
        _errorMessage = null;
        _isLoadingGoals = true;
        _isLoadingHealthConditions = true;
        _isLoadingAllergies = true;
        _isLoadingMealPlans = true;
      });

      final p = await SharedPreferences.getInstance();
      
      // Get current logged-in user data first
      final currentUser = p.getString('current_user');
      final currentUserDataJson = p.getString('current_user_data');
      
      String userName = 'User';
      String userEmail = 'user@email.com';
      
      if (currentUserDataJson != null) {
        try {
          final userData = json.decode(currentUserDataJson) as Map<String, dynamic>;
          userName = userData['fullName'] ?? userData['name'] ?? currentUser ?? 'User';
          userEmail = userData['email'] ?? 'user@email.com';
        } catch (e) {
          debugPrint('Error parsing user data: $e');
        }
      }
      
      // Load all data in parallel for better performance
      final results = await Future.wait([
        ProfileManagementService.getProfile(),
        UserDataService.getUserProfile(),
        ProfileManagementService.getDietaryGoals(),
        ProfileManagementService.getHealthConditions(),
        ProfileManagementService.getAllergies(),
        ProfileManagementService.getActiveMealPlan(),
      ]);

      final profile = results[0] as UserProfile?;
      final userProfileData = results[1] as UserProfileData?;
      final goals = results[2] as List<DietaryGoal>;
      final conditions = results[3] as List<HealthCondition>;
      final allergies = results[4] as List<Allergy>;
      final activeMealPlan = results[5] as MealPlan?;
      final activeMealPlans = activeMealPlan != null ? [activeMealPlan] : <MealPlan>[];

      // If profile data is missing but we have current user data, create a basic profile
      UserProfileData? finalUserProfileData = userProfileData;
      if (finalUserProfileData == null && (userName != 'User' || userEmail != 'user@email.com')) {
        // Create a basic profile with current user data
        finalUserProfileData = UserProfileData(
          name: userName,
          email: userEmail,
          height: 170.0, // Default values
          weight: 70.0,
          goal: 'Maintenance',
          gender: 'Other',
          activity: 'Sedentary',
          targetWeight: null,
          bmi: 24.2, // Default BMI
          bmiCategory: 'Normal weight',
          healthConditions: [],
          restrictions: [],
        );
      }

      // Debug: Print profile data
      print('Current user: $currentUser');
      print('Current user data: $userName, $userEmail');
      print('Profile loaded: ${profile?.name}');
      print('UserProfileData loaded: ${finalUserProfileData?.name}');

      setState(() {
        _profile = profile;
        _userProfileData = finalUserProfileData;
        _goals = goals;
        _healthConditions = conditions;
        _allergies = allergies;
        _mealPlans = activeMealPlans;
        _notifEnabled = p.getBool('notifEnabled') ?? true;
        _useMetric = p.getBool('useMetric') ?? true;
        _isLoadingGoals = false;
        _isLoadingHealthConditions = false;
        _isLoadingAllergies = false;
        _isLoadingMealPlans = false;
      });
    } catch (e) {
      debugPrint('Error loading profile data: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load profile data. Please try again.';
          _isLoadingGoals = false;
          _isLoadingHealthConditions = false;
          _isLoadingAllergies = false;
          _isLoadingMealPlans = false;
        });
      }
    }
  }

  Future<void> _savePrefs() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('notifEnabled', _notifEnabled);
    await p.setBool('useMetric', _useMetric);
  }

  Future<void> _loadDietHistory() async {
    if (!mounted) return;
    
    setState(() => _isLoadingDietHistory = true);
    
    try {
      // Load recent nutrition summaries (last 7 days)
      final endDate = DateTime.now();
      final summaries = <DailyNutritionSummary>[];
      
      for (int i = 0; i < 7; i++) {
        final date = endDate.subtract(Duration(days: i));
        try {
          final summary = await DietHistoryService.getDailyNutritionSummary(date);
          if (summary != null) {
            summaries.add(summary);
          }
        } catch (e) {
          debugPrint('Error loading summary for date $date: $e');
          // Continue with other dates
        }
      }
      
      // Get today's adherence score
      DietAdherenceScore? adherenceScore;
      try {
        adherenceScore = await DietHistoryService.calculateAdherenceScore(endDate);
      } catch (e) {
        debugPrint('Error calculating adherence score: $e');
        // Continue without adherence score
      }
      
      if (mounted) {
        setState(() {
          _recentNutritionSummaries = summaries;
          _currentAdherenceScore = adherenceScore;
          _isLoadingDietHistory = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading diet history: $e');
      if (mounted) {
        setState(() {
          _isLoadingDietHistory = false;
        });
        // Show error message to user
        _snack('Failed to load diet history. Please try again.', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final favCount = FavoritesManager().favorites.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
        title: Text('Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit_profile',
                child: Row(
                  children: [
                    const Icon(Icons.edit, size: 20),
                    const SizedBox(width: 12),
                    Text('Edit Profile', style: GoogleFonts.poppins()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'notifications',
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active, size: 20),
                    const SizedBox(width: 12),
                    Text('Notifications', style: GoogleFonts.poppins()),
                    const Spacer(),
                    Switch(
                      value: _notifEnabled,
                      onChanged: (v) async {
                        setState(() => _notifEnabled = v);
                        await _savePrefs();
                      },
                      activeColor: darkGreen,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'privacy',
                child: Row(
                  children: [
                    const Icon(Icons.privacy_tip_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text('Privacy', style: GoogleFonts.poppins()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 20),
                    const SizedBox(width: 12),
                    Text('About', style: GoogleFonts.poppins()),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 20, color: Colors.red),
                    const SizedBox(width: 12),
                    Text('Logout', style: GoogleFonts.poppins(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            // Error message display
            if (_errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade600),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.poppins(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => _errorMessage = null),
                      icon: Icon(Icons.close, color: Colors.red.shade600),
                    ),
                  ],
                ),
              ),
            // Fancy Profile Header Card
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    darkGreen,
                    darkGreen.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: darkGreen.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: darkGreen,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getDisplayName(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getDisplayEmail(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              if (_userProfileData?.bmi != null || _profile?.bmi != null) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'BMI: ${(_userProfileData?.bmi ?? _profile?.bmi)!.toStringAsFixed(1)} (${_userProfileData?.bmiCategory ?? _profile?.bmiCategory})',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Stats row with fancy styling
                    Row(
                      children: [
                        Expanded(
                          child: _fancyStatTile(
                            icon: Icons.event_note,
                            label: 'Plans',
                            value: _mealPlans.length.toString(),
                            onTap: () => _scrollToHistory(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _fancyStatTile(
                            icon: Icons.favorite_rounded,
                            label: 'Favorites',
                            value: favCount.toString(),
                            onTap: () => Navigator.pushNamed(context, '/favorites'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Dietary Goals Management
            Row(
              children: [
                Icon(Icons.flag, color: darkGreen, size: 20),
                const SizedBox(width: 8),
                Text('Dietary Goal', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            if (_isLoadingGoals)
              _card(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_goals.isEmpty)
              _card(
                child: Column(
                  children: [
                    Icon(Icons.flag_outlined, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('No goal set yet', style: GoogleFonts.poppins(color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text('Set your dietary goal to get started', 
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade500)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _addGoal(),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Set Goal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            else if (_goals.isNotEmpty)
              _card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: _goals.first.isActive ? darkGreen : Colors.grey.shade300,
                    child: Icon(
                      _goals.first.isActive ? Icons.flag : Icons.flag_outlined,
                      color: _goals.first.isActive ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                  title: Text(_goals.first.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  subtitle: Text(_goals.first.description, 
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                  trailing: IconButton(
                    onPressed: () => _editGoal(_goals.first),
                    icon: const Icon(Icons.edit, size: 20),
                    tooltip: 'Edit Goal',
                    style: IconButton.styleFrom(
                      foregroundColor: darkGreen,
                    ),
                  ),
                  onTap: () => _editGoal(_goals.first),
                ),
              ),

            const SizedBox(height: 18),

            // Health Conditions Management
            _buildSectionHeader('Health Conditions', Icons.health_and_safety, () => _manageHealthConditions()),
            const SizedBox(height: 8),
            if (_isLoadingHealthConditions)
              _card(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_healthConditions.isEmpty)
              _card(
                child: Column(
                  children: [
                    Icon(Icons.health_and_safety_outlined, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('No health conditions recorded', style: GoogleFonts.poppins(color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text('Add any health conditions for better recommendations', 
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade500)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _addHealthCondition(),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add Condition'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            else
              _card(
                padding: EdgeInsets.zero,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _healthConditions.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final condition = _healthConditions[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: _getSeverityColor(condition.severity).withOpacity(0.1),
                        child: Icon(
                          Icons.health_and_safety,
                          color: _getSeverityColor(condition.severity),
                        ),
                      ),
                      title: Text(condition.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('${condition.severity.toUpperCase()} • ${condition.description}', 
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                const Icon(Icons.edit, size: 16),
                                const SizedBox(width: 8),
                                Text('Edit', style: GoogleFonts.poppins()),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete, size: 16, color: Colors.red),
                                const SizedBox(width: 8),
                                Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) => _handleHealthConditionAction(condition.id, value.toString()),
                      ),
                      onTap: () => _editHealthCondition(condition),
                    );
                  },
                ),
              ),

            const SizedBox(height: 18),

            // Allergies Management
            _buildSectionHeader('Allergies', Icons.warning, () => _manageAllergies()),
            const SizedBox(height: 8),
            if (_isLoadingAllergies)
              _card(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_allergies.isEmpty)
              _card(
                child: Column(
                  children: [
                    Icon(Icons.warning_outlined, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('No allergies recorded', style: GoogleFonts.poppins(color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text('Add any allergies for safer recommendations', 
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade500)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _addAllergy(),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add Allergy'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            else
              _card(
                padding: EdgeInsets.zero,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _allergies.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final allergy = _allergies[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: _getSeverityColor(allergy.severity).withOpacity(0.1),
                        child: Icon(
                          Icons.warning,
                          color: _getSeverityColor(allergy.severity),
                        ),
                      ),
                      title: Text(allergy.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('${allergy.type.toUpperCase()} • ${allergy.severity.toUpperCase()}', 
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                const Icon(Icons.edit, size: 16),
                                const SizedBox(width: 8),
                                Text('Edit', style: GoogleFonts.poppins()),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete, size: 16, color: Colors.red),
                                const SizedBox(width: 8),
                                Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) => _handleAllergyAction(allergy.id, value.toString()),
                      ),
                      onTap: () => _editAllergy(allergy),
                    );
                  },
                ),
              ),

            const SizedBox(height: 18),

            // Meal Plans Management
            _buildSectionHeader('Meal Plans', Icons.restaurant_menu, null),
            const SizedBox(height: 8),
            if (_isLoadingMealPlans)
              _card(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_mealPlans.isEmpty)
              _card(
                child: Column(
                  children: [
                    Icon(Icons.restaurant_menu_outlined, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('No meal plans created', style: GoogleFonts.poppins(color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text('Create your first meal plan to get started', 
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade500)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/create_meal_plan'),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Create Plan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            else
              _card(
                padding: EdgeInsets.zero,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _mealPlans.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final plan = _mealPlans[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: plan.isActive ? darkGreen : Colors.grey.shade300,
                        child: Icon(
                          plan.isActive ? Icons.restaurant_menu : Icons.restaurant_menu_outlined,
                          color: plan.isActive ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                      title: Text(plan.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('${plan.startDate.day}/${plan.startDate.month}/${plan.startDate.year} - ${plan.endDate.day}/${plan.endDate.month}/${plan.endDate.year}', 
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                const Icon(Icons.edit, size: 16),
                                const SizedBox(width: 8),
                                Text('Edit', style: GoogleFonts.poppins()),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'activate',
                            child: Row(
                              children: [
                                const Icon(Icons.check, size: 16),
                                const SizedBox(width: 8),
                                Text('Set Active', style: GoogleFonts.poppins()),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete, size: 16, color: Colors.red),
                                const SizedBox(width: 8),
                                Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) => _handleMealPlanAction(plan.id, value.toString()),
                      ),
                      onTap: () => _editMealPlan(plan),
                    );
                  },
                ),
              ),

            const SizedBox(height: 18),

            // Diet History Section
            _buildDietHistoryHeader(),
            const SizedBox(height: 8),
            if (_isLoadingDietHistory)
              _card(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_recentNutritionSummaries.isEmpty)
              _card(
                child: Column(
                  children: [
                    Icon(Icons.timeline_outlined, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('No diet history yet', style: GoogleFonts.poppins(color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text('Start logging your meals to see nutritional insights', 
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade500)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/log_meal'),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Log Meal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            else ...[
              // Diet History Overview
              _card(
                child: const DietHistoryOverview(),
              ),
              const SizedBox(height: 12),
              
              // Recent Nutrition Summaries
              _card(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Recent Nutrition',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (_recentNutritionSummaries.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _recentNutritionSummaries.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) {
                          final summary = _recentNutritionSummaries[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: DailyNutritionCard(summary: summary),
                          );
                        },
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'No recent nutrition data',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              // Diet Adherence Card
              if (_currentAdherenceScore != null)
                _card(
                  child: DietAdherenceCard(score: _currentAdherenceScore!),
                ),
            ],

          ],
        ),
      ),
    );
    } catch (e) {
      debugPrint('Error in build method: $e');
      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkGreen,
          title: Text('Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Something went wrong', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Please restart the app', style: GoogleFonts.poppins(color: Colors.grey[600])),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Retry', style: GoogleFonts.poppins()),
              ),
            ],
          ),
        ),
      );
    }
  }

  // ======================= MENU ACTIONS =======================

  void _handleMenuAction(String action) {
    switch (action) {
      case 'edit_profile':
        _openEditSheet(context);
        break;
      case 'notifications':
        // Toggle is handled directly in the switch widget
        break;
      case 'privacy':
        _snack('Privacy settings coming soon');
        break;
      case 'about':
        _snack('FitMeal • NutriGuide');
        break;
      case 'logout':
        _handleLogout();
        break;
    }
  }

  // ======================= UI HELPERS =======================


  Widget _card({EdgeInsets? padding, required Widget child}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }


  Widget _fancyStatTile({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _snack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        backgroundColor: isError ? Colors.red.shade600 : darkGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  void _scrollToHistory(BuildContext context) {
    // In this simple page we already show history. You can scroll controllers if needed.
    _snack('Scroll to Plan History below');
  }

  // ======================= HELPER METHODS =======================

  Widget _buildSectionHeader(String title, IconData icon, VoidCallback? onTap) {
    return Row(
      children: [
        Icon(icon, color: darkGreen, size: 20),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        if (onTap != null) ...[
          const Spacer(),
          TextButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.manage_accounts, size: 16),
            label: const Text('Manage'),
            style: TextButton.styleFrom(
              foregroundColor: darkGreen,
              textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDietHistoryHeader() {
    return Row(
      children: [
        Icon(Icons.analytics, color: darkGreen, size: 20),
        const SizedBox(width: 8),
        Text('Diet History & Analytics', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        const Spacer(),
        IconButton(
          onPressed: _loadDietHistory,
          icon: const Icon(Icons.refresh, size: 20),
          tooltip: 'Refresh Diet History',
          style: IconButton.styleFrom(
            foregroundColor: darkGreen,
          ),
        ),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      case 'life_threatening':
        return Colors.red.shade800;
      default:
        return Colors.grey;
    }
  }

  // ======================= DIETARY GOALS MANAGEMENT =======================

  Future<void> _addGoal() async {
    try {
      final result = await _showGoalForm();
      if (result != null) {
        // Validate goal data
        if (result.name.trim().isEmpty) {
          _snack('Goal name is required', isError: true);
          return;
        }
        
        setState(() => _isLoadingGoals = true);
        final success = await ProfileManagementService.addDietaryGoal(result);
        if (success) {
          await _loadData();
          _snack('Goal added successfully');
        } else {
          _snack('Failed to add goal. Please try again.', isError: true);
        }
      }
    } catch (e) {
      debugPrint('Error adding goal: $e');
      _snack('Error adding goal. Please try again.', isError: true);
    } finally {
      setState(() => _isLoadingGoals = false);
    }
  }

  Future<void> _editGoal(DietaryGoal goal) async {
    try {
      final result = await _showGoalForm(goal: goal);
      if (result != null) {
        // Validate goal data
        if (result.name.trim().isEmpty) {
          _snack('Goal name is required', isError: true);
          return;
        }
        
        setState(() => _isLoadingGoals = true);
        final success = await ProfileManagementService.updateDietaryGoal(goal.id, result);
        if (success) {
          await _loadData();
          _snack('Goal updated successfully');
        } else {
          _snack('Failed to update goal. Please try again.', isError: true);
        }
      }
    } catch (e) {
      debugPrint('Error updating goal: $e');
      _snack('Error updating goal. Please try again.', isError: true);
    } finally {
      setState(() => _isLoadingGoals = false);
    }
  }



  Future<DietaryGoal?> _showGoalForm({DietaryGoal? goal}) async {
    final nameCtl = TextEditingController(text: goal?.name ?? '');
    final descCtl = TextEditingController(text: goal?.description ?? '');
    final targetWeightCtl = TextEditingController(text: goal?.targetWeight?.toString() ?? '');
    
    String selectedType = goal?.type ?? 'weight_loss';

    return await showModalBottomSheet<DietaryGoal>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(goal == null ? 'Add Goal' : 'Edit Goal',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  labelText: 'Goal Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtl,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Goal Type',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'weight_loss',
                  'maintenance',
                  'weight_gain'
                ].map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.replaceAll('_', ' ').toUpperCase()),
                )).toList(),
                onChanged: (value) => setState(() => selectedType = value!),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: targetWeightCtl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Target Weight (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate form data
                        if (nameCtl.text.trim().isEmpty) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text('Goal name is required', 
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                              backgroundColor: Colors.red.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                          return;
                        }
                        
                        final newGoal = DietaryGoal(
                          id: goal?.id ?? ProfileManagementService.generateId(),
                          name: nameCtl.text.trim(),
                          description: descCtl.text.trim(),
                          type: selectedType,
                          targetWeight: targetWeightCtl.text.trim().isEmpty ? null : double.tryParse(targetWeightCtl.text.trim()),
                          targetCalories: null, // Removed target calories
                          startDate: goal?.startDate ?? DateTime.now(),
                          endDate: goal?.endDate,
                          isActive: goal?.isActive ?? true,
                          createdAt: goal?.createdAt ?? DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        Navigator.pop(ctx, newGoal);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ======================= HEALTH CONDITIONS MANAGEMENT =======================

  Future<void> _addHealthCondition() async {
    try {
      final result = await _showHealthConditionForm();
      if (result != null) {
        setState(() => _isLoadingHealthConditions = true);
        final success = await ProfileManagementService.addHealthCondition(result);
        if (success) {
          await _loadData();
          _snack('Health condition added successfully');
        } else {
          _snack('Failed to add health condition');
        }
      }
    } catch (e) {
      debugPrint('Error adding health condition: $e');
      _snack('Error adding health condition. Please try again.');
    } finally {
      setState(() => _isLoadingHealthConditions = false);
    }
  }

  Future<void> _editHealthCondition(HealthCondition condition) async {
    try {
      final result = await _showHealthConditionForm(condition: condition);
      if (result != null) {
        setState(() => _isLoadingHealthConditions = true);
        final success = await ProfileManagementService.updateHealthCondition(condition.id, result);
        if (success) {
          await _loadData();
          _snack('Health condition updated successfully');
        } else {
          _snack('Failed to update health condition');
        }
      }
    } catch (e) {
      debugPrint('Error updating health condition: $e');
      _snack('Error updating health condition. Please try again.');
    } finally {
      setState(() => _isLoadingHealthConditions = false);
    }
  }

  Future<void> _handleHealthConditionAction(String conditionId, String action) async {
    try {
      switch (action) {
        case 'edit':
          final condition = _healthConditions.firstWhere((c) => c.id == conditionId);
          await _editHealthCondition(condition);
          break;
        case 'delete':
          final confirmed = await _showDeleteConfirmation('health condition');
          if (confirmed == true) {
            setState(() => _isLoadingHealthConditions = true);
            final success = await ProfileManagementService.deleteHealthCondition(conditionId);
            if (success) {
              await _loadData();
              _snack('Health condition deleted');
            } else {
              _snack('Failed to delete health condition');
            }
          }
          break;
      }
    } catch (e) {
      debugPrint('Error handling health condition action: $e');
      _snack('Error processing request. Please try again.');
    } finally {
      setState(() => _isLoadingHealthConditions = false);
    }
  }

  Future<void> _manageHealthConditions() async {
    Navigator.pushNamed(context, '/health_conditions_management');
  }

  Future<HealthCondition?> _showHealthConditionForm({HealthCondition? condition}) async {
    final nameCtl = TextEditingController(text: condition?.name ?? '');
    final descCtl = TextEditingController(text: condition?.description ?? '');
    final notesCtl = TextEditingController(text: condition?.notes ?? '');
    
    String selectedSeverity = condition?.severity ?? 'mild';
    DateTime diagnosedDate = condition?.diagnosedDate ?? DateTime.now();

    return await showModalBottomSheet<HealthCondition>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(condition == null ? 'Add Health Condition' : 'Edit Health Condition',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  labelText: 'Condition Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtl,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedSeverity,
                decoration: const InputDecoration(
                  labelText: 'Severity',
                  border: OutlineInputBorder(),
                ),
                items: ['mild', 'moderate', 'severe'].map((severity) => DropdownMenuItem(
                  value: severity,
                  child: Text(severity.toUpperCase()),
                )).toList(),
                onChanged: (value) => setState(() => selectedSeverity = value!),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtl,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final newCondition = HealthCondition(
                          id: condition?.id ?? ProfileManagementService.generateId(),
                          name: nameCtl.text.trim(),
                          description: descCtl.text.trim(),
                          severity: selectedSeverity,
                          diagnosedDate: diagnosedDate,
                          notes: notesCtl.text.trim().isEmpty ? null : notesCtl.text.trim(),
                          createdAt: condition?.createdAt ?? DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        Navigator.pop(ctx, newCondition);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ======================= ALLERGIES MANAGEMENT =======================

  Future<void> _addAllergy() async {
    try {
      final result = await _showAllergyForm();
      if (result != null) {
        setState(() => _isLoadingAllergies = true);
        final success = await ProfileManagementService.addAllergy(result);
        if (success) {
          await _loadData();
          _snack('Allergy added successfully');
        } else {
          _snack('Failed to add allergy');
        }
      }
    } catch (e) {
      debugPrint('Error adding allergy: $e');
      _snack('Error adding allergy. Please try again.');
    } finally {
      setState(() => _isLoadingAllergies = false);
    }
  }

  Future<void> _editAllergy(Allergy allergy) async {
    try {
      final result = await _showAllergyForm(allergy: allergy);
      if (result != null) {
        setState(() => _isLoadingAllergies = true);
        final success = await ProfileManagementService.updateAllergy(allergy.id, result);
        if (success) {
          await _loadData();
          _snack('Allergy updated successfully');
        } else {
          _snack('Failed to update allergy');
        }
      }
    } catch (e) {
      debugPrint('Error updating allergy: $e');
      _snack('Error updating allergy. Please try again.');
    } finally {
      setState(() => _isLoadingAllergies = false);
    }
  }

  Future<void> _handleAllergyAction(String allergyId, String action) async {
    try {
      switch (action) {
        case 'edit':
          final allergy = _allergies.firstWhere((a) => a.id == allergyId);
          await _editAllergy(allergy);
          break;
        case 'delete':
          final confirmed = await _showDeleteConfirmation('allergy');
          if (confirmed == true) {
            setState(() => _isLoadingAllergies = true);
            final success = await ProfileManagementService.deleteAllergy(allergyId);
            if (success) {
              await _loadData();
              _snack('Allergy deleted');
            } else {
              _snack('Failed to delete allergy');
            }
          }
          break;
      }
    } catch (e) {
      debugPrint('Error handling allergy action: $e');
      _snack('Error processing request. Please try again.');
    } finally {
      setState(() => _isLoadingAllergies = false);
    }
  }

  Future<void> _manageAllergies() async {
    Navigator.pushNamed(context, '/allergies_management');
  }

  Future<Allergy?> _showAllergyForm({Allergy? allergy}) async {
    final nameCtl = TextEditingController(text: allergy?.name ?? '');
    final symptomsCtl = TextEditingController(text: allergy?.symptoms ?? '');
    final notesCtl = TextEditingController(text: allergy?.notes ?? '');
    
    String selectedType = allergy?.type ?? 'food';
    String selectedSeverity = allergy?.severity ?? 'mild';

    return await showModalBottomSheet<Allergy>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(allergy == null ? 'Add Allergy' : 'Edit Allergy',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  labelText: 'Allergy Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      items: ['food', 'medication', 'environmental', 'other'].map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.toUpperCase()),
                      )).toList(),
                      onChanged: (value) => setState(() => selectedType = value!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedSeverity,
                      decoration: const InputDecoration(
                        labelText: 'Severity',
                        border: OutlineInputBorder(),
                      ),
                      items: ['mild', 'moderate', 'severe', 'life_threatening'].map((severity) => DropdownMenuItem(
                        value: severity,
                        child: Text(severity.replaceAll('_', ' ').toUpperCase()),
                      )).toList(),
                      onChanged: (value) => setState(() => selectedSeverity = value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: symptomsCtl,
                decoration: const InputDecoration(
                  labelText: 'Symptoms (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtl,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final newAllergy = Allergy(
                          id: allergy?.id ?? ProfileManagementService.generateId(),
                          name: nameCtl.text.trim(),
                          type: selectedType,
                          severity: selectedSeverity,
                          symptoms: symptomsCtl.text.trim().isEmpty ? null : symptomsCtl.text.trim(),
                          notes: notesCtl.text.trim().isEmpty ? null : notesCtl.text.trim(),
                          createdAt: allergy?.createdAt ?? DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        Navigator.pop(ctx, newAllergy);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ======================= MEAL PLANS MANAGEMENT =======================

  Future<void> _editMealPlan(MealPlan plan) async {
    try {
      final result = await _showMealPlanForm(plan: plan);
      if (result != null) {
        setState(() => _isLoadingMealPlans = true);
        final success = await ProfileManagementService.updateMealPlan(plan.id, result);
        if (success) {
          await _loadData();
          _snack('Meal plan updated successfully');
        } else {
          _snack('Failed to update meal plan');
        }
      }
    } catch (e) {
      debugPrint('Error updating meal plan: $e');
      _snack('Error updating meal plan. Please try again.');
    } finally {
      setState(() => _isLoadingMealPlans = false);
    }
  }

  Future<void> _handleMealPlanAction(String planId, String action) async {
    try {
      switch (action) {
        case 'edit':
          final plan = _mealPlans.firstWhere((p) => p.id == planId);
          await _editMealPlan(plan);
          break;
        case 'activate':
          setState(() => _isLoadingMealPlans = true);
          // Set meal plan as active
          final success = await ProfileManagementService.setActiveMealPlan(planId);
          if (success) {
            await _loadData();
            _snack('Meal plan activated');
          } else {
            _snack('Failed to activate meal plan');
          }
          break;
        case 'delete':
          final confirmed = await _showDeleteConfirmation('meal plan');
          if (confirmed == true) {
            setState(() => _isLoadingMealPlans = true);
            final success = await ProfileManagementService.deleteMealPlan(planId);
            if (success) {
              await _loadData();
              _snack('Meal plan deleted');
            } else {
              _snack('Failed to delete meal plan');
            }
          }
          break;
      }
    } catch (e) {
      debugPrint('Error handling meal plan action: $e');
      _snack('Error processing request. Please try again.');
    } finally {
      setState(() => _isLoadingMealPlans = false);
    }
  }




  Future<MealPlan?> _showMealPlanForm({MealPlan? plan}) async {
    final nameCtl = TextEditingController(text: plan?.name ?? '');
    final descCtl = TextEditingController(text: plan?.description ?? '');
    
    DateTime startDate = plan?.startDate ?? DateTime.now();
    DateTime endDate = plan?.endDate ?? DateTime.now().add(const Duration(days: 7));

    return await showModalBottomSheet<MealPlan>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(plan == null ? 'Add Meal Plan' : 'Edit Meal Plan',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  labelText: 'Plan Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtl,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Start Date', style: GoogleFonts.poppins(fontSize: 12)),
                      subtitle: Text('${startDate.day}/${startDate.month}/${startDate.year}'),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() => startDate = date);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ListTile(
                      title: Text('End Date', style: GoogleFonts.poppins(fontSize: 12)),
                      subtitle: Text('${endDate.day}/${endDate.month}/${endDate.year}'),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: endDate,
                          firstDate: startDate,
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() => endDate = date);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final newPlan = MealPlan(
                          id: plan?.id ?? ProfileManagementService.generateId(),
                          name: nameCtl.text.trim(),
                          description: descCtl.text.trim(),
                          startDate: startDate,
                          endDate: endDate,
                          isActive: plan?.isActive ?? true,
                          createdAt: plan?.createdAt ?? DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        Navigator.pop(ctx, newPlan);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ======================= UTILITY METHODS =======================

  String _getDisplayName() {
    // Priority: UserProfileData -> Profile -> Default
    if (_userProfileData?.name != null && _userProfileData!.name.isNotEmpty) {
      return _userProfileData!.name;
    }
    if (_profile?.name != null && _profile!.name.isNotEmpty) {
      return _profile!.name;
    }
    return 'Your Name';
  }

  String _getDisplayEmail() {
    // Priority: UserProfileData -> Profile -> Default
    if (_userProfileData?.email != null && _userProfileData!.email.isNotEmpty) {
      return _userProfileData!.email;
    }
    if (_profile?.email != null && _profile!.email.isNotEmpty) {
      return _profile!.email;
    }
    return 'user@email.com';
  }

  Future<void> _handleLogout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Clear all session data
      await prefs.remove('current_user');
      await prefs.remove('current_user_data');
      await prefs.remove('is_admin');
      await prefs.remove('is_admin_logged_in');
      await prefs.remove('admin_token');
      await prefs.remove('admin_user');
      await prefs.remove('onboardingCompleted');
      
      // Clear remember me data
      await prefs.remove('remembered_username');
      await prefs.remove('remember_me');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logged out successfully', 
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            backgroundColor: darkGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        
        // Navigate to login screen and clear all previous routes
        Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
      }
    } catch (e) {
      debugPrint('Error during logout: $e');
      if (mounted) {
        _snack('Error during logout. Please try again.');
      }
    }
  }

  Future<bool?> _showDeleteConfirmation(String itemType) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete $itemType', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text('Are you sure you want to delete this $itemType? This action cannot be undone.',
            style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _openEditSheet(BuildContext context) async {
    final nameCtl = TextEditingController(text: _getDisplayName());
    final emailCtl = TextEditingController(text: _getDisplayEmail());
    final heightCtl = TextEditingController(text: (_userProfileData?.height ?? _profile?.height)?.toString() ?? '');
    final weightCtl = TextEditingController(text: (_userProfileData?.weight ?? _profile?.weight)?.toString() ?? '');

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit Profile',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailCtl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: heightCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: weightCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B6A0B),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (saved == true) {
      // Update using UserDataService since that's what the onboarding uses
      if (_userProfileData != null) {
        final updatedProfile = UserProfileData(
          name: nameCtl.text.trim().isEmpty ? _userProfileData!.name : nameCtl.text.trim(),
          email: emailCtl.text.trim().isEmpty ? _userProfileData!.email : emailCtl.text.trim(),
          height: heightCtl.text.trim().isEmpty ? _userProfileData!.height : double.tryParse(heightCtl.text.trim()) ?? _userProfileData!.height,
          weight: weightCtl.text.trim().isEmpty ? _userProfileData!.weight : double.tryParse(weightCtl.text.trim()) ?? _userProfileData!.weight,
          goal: _userProfileData!.goal,
          gender: _userProfileData!.gender,
          activity: _userProfileData!.activity,
          targetWeight: _userProfileData!.targetWeight,
          bmi: _userProfileData!.bmi,
          bmiCategory: _userProfileData!.bmiCategory,
          healthConditions: _userProfileData!.healthConditions,
          restrictions: _userProfileData!.restrictions,
        );
        
        final success = await UserDataService.saveUserProfile(updatedProfile);
        
        if (success) {
          await _loadData();
          _snack('Profile updated');
        } else {
          _snack('Failed to update profile');
        }
      } else {
        _snack('No profile data found. Please complete onboarding first.');
      }
    }
  }
}

/// Tiny mock manager for completed plans.
/// Replace with your real repository later.
class PlanHistoryManager {
  static final PlanHistoryManager _i = PlanHistoryManager._internal();
  factory PlanHistoryManager() => _i;
  PlanHistoryManager._internal();

  final List<PlanHistoryItem> plans = [
    // Example:
    // PlanHistoryItem(title: 'Weight Loss – Week 1', date: '2025-08-01', goal: 'Weight Loss'),
  ];
}

class PlanHistoryItem {
  final String title;
  final String date;
  final String goal;
  PlanHistoryItem({required this.title, required this.date, required this.goal});
}
