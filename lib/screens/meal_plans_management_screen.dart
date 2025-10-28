import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/profile_management_service.dart';

class MealPlansManagementScreen extends StatefulWidget {
  const MealPlansManagementScreen({super.key});

  @override
  State<MealPlansManagementScreen> createState() => _MealPlansManagementScreenState();
}

class _MealPlansManagementScreenState extends State<MealPlansManagementScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  List<MealPlan> _mealPlans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMealPlans();
  }

  Future<void> _loadMealPlans() async {
    setState(() => _isLoading = true);
    // Get only active meal plans (one plan per user)
    final activeMealPlan = await ProfileManagementService.getActiveMealPlan();
    setState(() {
      _mealPlans = activeMealPlan != null ? [activeMealPlan] : [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
        title: Text('Meal Plans', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addMealPlan,
            tooltip: 'Add Meal Plan',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _mealPlans.isEmpty
              ? _buildEmptyState()
              : _buildMealPlansList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('No Meal Plans', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Create your first meal plan to get started', 
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addMealPlan,
            icon: const Icon(Icons.add),
            label: const Text('Create Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlansList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _mealPlans.length,
      itemBuilder: (context, index) {
        final mealPlan = _mealPlans[index];
        return _buildMealPlanCard(mealPlan);
      },
    );
  }

  Widget _buildMealPlanCard(MealPlan mealPlan) {
    final duration = mealPlan.endDate.difference(mealPlan.startDate).inDays + 1;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: mealPlan.isActive ? darkGreen : Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  mealPlan.isActive ? Icons.restaurant_menu : Icons.restaurant_menu_outlined,
                  color: mealPlan.isActive ? Colors.white : Colors.grey.shade600,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mealPlan.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: mealPlan.isActive ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (mealPlan.isActive)
                        Text(
                          'ACTIVE PLAN',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: mealPlan.isActive ? Colors.white : Colors.grey.shade600,
                  ),
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
                    if (!mealPlan.isActive)
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
                  onSelected: (value) => _handleMealPlanAction(mealPlan.id, value.toString()),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealPlan.description,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildMealPlanInfo('Start Date', _formatDate(mealPlan.startDate)),
                    const SizedBox(width: 16),
                    _buildMealPlanInfo('End Date', _formatDate(mealPlan.endDate)),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMealPlanInfo('Duration', '$duration days'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlanInfo(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _addMealPlan() async {
    // Check if user already has an active plan
    final activePlan = await ProfileManagementService.getActiveMealPlan();
    if (activePlan != null) {
      _showSnackBar('You already have an active meal plan. Creating a new plan will replace your current one.');
    }
    
    final result = await _showMealPlanForm();
    if (result != null) {
      final success = await ProfileManagementService.addMealPlan(result);
      if (success) {
        await _loadMealPlans();
        _showSnackBar('Meal plan created successfully (replaced previous plan)');
      } else {
        _showSnackBar('Failed to create meal plan');
      }
    }
  }

  Future<void> _handleMealPlanAction(String planId, String action) async {
    switch (action) {
      case 'edit':
        final plan = _mealPlans.firstWhere((p) => p.id == planId);
        final result = await _showMealPlanForm(plan: plan);
        if (result != null) {
          final success = await ProfileManagementService.updateMealPlan(planId, result);
          if (success) {
            await _loadMealPlans();
            _showSnackBar('Meal plan updated successfully');
          } else {
            _showSnackBar('Failed to update meal plan');
          }
        }
        break;
      case 'activate':
        // Set meal plan as active
        _showSnackBar('Meal plan activated');
        break;
      case 'delete':
        final confirmed = await _showDeleteConfirmation('meal plan');
        if (confirmed == true) {
          final success = await ProfileManagementService.deleteMealPlan(planId);
          if (success) {
            await _loadMealPlans();
            _showSnackBar('Meal plan deleted');
          } else {
            _showSnackBar('Failed to delete meal plan');
          }
        }
        break;
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
              Text(plan == null ? 'Create Meal Plan' : 'Edit Meal Plan',
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
                      subtitle: Text(_formatDate(startDate)),
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
                      subtitle: Text(_formatDate(endDate)),
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
                          mealsPerDay: plan?.mealsPerDay ?? 3, // Use existing value or default to 3
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: darkGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
