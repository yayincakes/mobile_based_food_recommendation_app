import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/profile_management_service.dart';

class HealthConditionsManagementScreen extends StatefulWidget {
  const HealthConditionsManagementScreen({super.key});

  @override
  State<HealthConditionsManagementScreen> createState() => _HealthConditionsManagementScreenState();
}

class _HealthConditionsManagementScreenState extends State<HealthConditionsManagementScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  List<HealthCondition> _conditions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConditions();
  }

  Future<void> _loadConditions() async {
    setState(() => _isLoading = true);
    final conditions = await ProfileManagementService.getHealthConditions();
    setState(() {
      _conditions = conditions;
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
        title: Text('Health Conditions', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addCondition,
            tooltip: 'Add Condition',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _conditions.isEmpty
              ? _buildEmptyState()
              : _buildConditionsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.health_and_safety_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('No Health Conditions', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Add any health conditions for better recommendations', 
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addCondition,
            icon: const Icon(Icons.add),
            label: const Text('Add Condition'),
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

  Widget _buildConditionsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _conditions.length,
      itemBuilder: (context, index) {
        final condition = _conditions[index];
        return _buildConditionCard(condition);
      },
    );
  }

  Widget _buildConditionCard(HealthCondition condition) {
    final severityColor = _getSeverityColor(condition.severity);
    
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
              color: severityColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.health_and_safety,
                  color: severityColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        condition.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        condition.severity.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: severityColor,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
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
                  onSelected: (value) => _handleConditionAction(condition.id, value.toString()),
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
                  condition.description,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildConditionInfo('Diagnosed', _formatDate(condition.diagnosedDate)),
                    const SizedBox(width: 16),
                    _buildConditionInfo('Severity', condition.severity.toUpperCase()),
                  ],
                ),
                if (condition.notes != null && condition.notes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildConditionInfo('Notes', condition.notes!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionInfo(String label, String value) {
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

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _addCondition() async {
    final result = await _showConditionForm();
    if (result != null) {
      final success = await ProfileManagementService.addHealthCondition(result);
      if (success) {
        await _loadConditions();
        _showSnackBar('Health condition added successfully');
      } else {
        _showSnackBar('Failed to add health condition');
      }
    }
  }

  Future<void> _handleConditionAction(String conditionId, String action) async {
    switch (action) {
      case 'edit':
        final condition = _conditions.firstWhere((c) => c.id == conditionId);
        final result = await _showConditionForm(condition: condition);
        if (result != null) {
          final success = await ProfileManagementService.updateHealthCondition(conditionId, result);
          if (success) {
            await _loadConditions();
            _showSnackBar('Health condition updated successfully');
          } else {
            _showSnackBar('Failed to update health condition');
          }
        }
        break;
      case 'delete':
        final confirmed = await _showDeleteConfirmation('health condition');
        if (confirmed == true) {
          final success = await ProfileManagementService.deleteHealthCondition(conditionId);
          if (success) {
            await _loadConditions();
            _showSnackBar('Health condition deleted');
          } else {
            _showSnackBar('Failed to delete health condition');
          }
        }
        break;
    }
  }

  Future<HealthCondition?> _showConditionForm({HealthCondition? condition}) async {
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
              ListTile(
                title: Text('Diagnosed Date', style: GoogleFonts.poppins(fontSize: 12)),
                subtitle: Text(_formatDate(diagnosedDate)),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: diagnosedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => diagnosedDate = date);
                  }
                },
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
