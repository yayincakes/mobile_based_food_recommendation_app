import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/profile_management_service.dart';

class GoalsManagementScreen extends StatefulWidget {
  const GoalsManagementScreen({super.key});

  @override
  State<GoalsManagementScreen> createState() => _GoalsManagementScreenState();
}

class _GoalsManagementScreenState extends State<GoalsManagementScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  List<DietaryGoal> _goals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    setState(() => _isLoading = true);
    final goals = await ProfileManagementService.getDietaryGoals();
    setState(() {
      _goals = goals;
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
        title: Text('Dietary Goals', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addGoal,
            tooltip: 'Add Goal',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _goals.isEmpty
              ? _buildEmptyState()
              : _buildGoalsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('No Goals Yet', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Create your first dietary goal to get started', 
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addGoal,
            icon: const Icon(Icons.add),
            label: const Text('Add Goal'),
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

  Widget _buildGoalsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _goals.length,
      itemBuilder: (context, index) {
        final goal = _goals[index];
        return _buildGoalCard(goal);
      },
    );
  }

  Widget _buildGoalCard(DietaryGoal goal) {
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
              color: goal.isActive ? darkGreen : Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  goal.isActive ? Icons.flag : Icons.flag_outlined,
                  color: goal.isActive ? Colors.white : Colors.grey.shade600,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: goal.isActive ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (goal.isActive)
                        Text(
                          'ACTIVE GOAL',
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
                    color: goal.isActive ? Colors.white : Colors.grey.shade600,
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
                    if (!goal.isActive)
                      PopupMenuItem(
                        value: 'activate',
                        child: Row(
                          children: [
                            const Icon(Icons.flag, size: 16),
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
                  onSelected: (value) => _handleGoalAction(goal.id, value.toString()),
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
                  goal.description,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildGoalInfo('Type', goal.type.replaceAll('_', ' ').toUpperCase()),
                    const SizedBox(width: 16),
                    _buildGoalInfo('Start Date', _formatDate(goal.startDate)),
                  ],
                ),
                if (goal.targetWeight != null || goal.targetCalories != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (goal.targetWeight != null)
                        _buildGoalInfo('Target Weight', '${goal.targetWeight!.toStringAsFixed(1)} kg'),
                      if (goal.targetWeight != null && goal.targetCalories != null)
                        const SizedBox(width: 16),
                      if (goal.targetCalories != null)
                        _buildGoalInfo('Target Calories', '${goal.targetCalories!.toStringAsFixed(0)} kcal'),
                    ],
                  ),
                ],
                if (goal.endDate != null) ...[
                  const SizedBox(height: 12),
                  _buildGoalInfo('End Date', _formatDate(goal.endDate!)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalInfo(String label, String value) {
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

  Future<void> _addGoal() async {
    final result = await _showGoalForm();
    if (result != null) {
      final success = await ProfileManagementService.addDietaryGoal(result);
      if (success) {
        await _loadGoals();
        _showSnackBar('Goal added successfully');
      } else {
        _showSnackBar('Failed to add goal');
      }
    }
  }

  Future<void> _handleGoalAction(String goalId, String action) async {
    switch (action) {
      case 'edit':
        final goal = _goals.firstWhere((g) => g.id == goalId);
        final result = await _showGoalForm(goal: goal);
        if (result != null) {
          final success = await ProfileManagementService.updateDietaryGoal(goalId, result);
          if (success) {
            await _loadGoals();
            _showSnackBar('Goal updated successfully');
          } else {
            _showSnackBar('Failed to update goal');
          }
        }
        break;
      case 'activate':
        final success = await ProfileManagementService.setActiveGoal(goalId);
        if (success) {
          await _loadGoals();
          _showSnackBar('Goal activated');
        } else {
          _showSnackBar('Failed to activate goal');
        }
        break;
      case 'delete':
        final confirmed = await _showDeleteConfirmation('goal');
        if (confirmed == true) {
          final success = await ProfileManagementService.deleteDietaryGoal(goalId);
          if (success) {
            await _loadGoals();
            _showSnackBar('Goal deleted');
          } else {
            _showSnackBar('Failed to delete goal');
          }
        }
        break;
    }
  }

  Future<DietaryGoal?> _showGoalForm({DietaryGoal? goal}) async {
    final nameCtl = TextEditingController(text: goal?.name ?? '');
    final descCtl = TextEditingController(text: goal?.description ?? '');
    final targetWeightCtl = TextEditingController(text: goal?.targetWeight?.toString() ?? '');
    final targetCaloriesCtl = TextEditingController(text: goal?.targetCalories?.toString() ?? '');
    
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
                  'weight_gain',
                  'maintenance',
                  'muscle_building',
                  'endurance'
                ].map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.replaceAll('_', ' ').toUpperCase()),
                )).toList(),
                onChanged: (value) => setState(() => selectedType = value!),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: targetWeightCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Target Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: targetCaloriesCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Target Calories',
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
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final newGoal = DietaryGoal(
                          id: goal?.id ?? ProfileManagementService.generateId(),
                          name: nameCtl.text.trim(),
                          description: descCtl.text.trim(),
                          type: selectedType,
                          targetWeight: targetWeightCtl.text.trim().isEmpty ? null : double.tryParse(targetWeightCtl.text.trim()),
                          targetCalories: targetCaloriesCtl.text.trim().isEmpty ? null : double.tryParse(targetCaloriesCtl.text.trim()),
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
