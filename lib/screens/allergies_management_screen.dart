import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/profile_management_service.dart';

class AllergiesManagementScreen extends StatefulWidget {
  const AllergiesManagementScreen({super.key});

  @override
  State<AllergiesManagementScreen> createState() => _AllergiesManagementScreenState();
}

class _AllergiesManagementScreenState extends State<AllergiesManagementScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  List<Allergy> _allergies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllergies();
  }

  Future<void> _loadAllergies() async {
    setState(() => _isLoading = true);
    final allergies = await ProfileManagementService.getAllergies();
    setState(() {
      _allergies = allergies;
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
        title: Text('Allergies', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addAllergy,
            tooltip: 'Add Allergy',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _allergies.isEmpty
              ? _buildEmptyState()
              : _buildAllergiesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('No Allergies Recorded', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Add any allergies for safer recommendations', 
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addAllergy,
            icon: const Icon(Icons.add),
            label: const Text('Add Allergy'),
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

  Widget _buildAllergiesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _allergies.length,
      itemBuilder: (context, index) {
        final allergy = _allergies[index];
        return _buildAllergyCard(allergy);
      },
    );
  }

  Widget _buildAllergyCard(Allergy allergy) {
    final severityColor = _getSeverityColor(allergy.severity);
    
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
                  Icons.warning,
                  color: severityColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allergy.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${allergy.type.toUpperCase()} • ${allergy.severity.toUpperCase()}',
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
                  onSelected: (value) => _handleAllergyAction(allergy.id, value.toString()),
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
                Row(
                  children: [
                    _buildAllergyInfo('Type', allergy.type.toUpperCase()),
                    const SizedBox(width: 16),
                    _buildAllergyInfo('Severity', allergy.severity.toUpperCase()),
                  ],
                ),
                if (allergy.symptoms != null && allergy.symptoms!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildAllergyInfo('Symptoms', allergy.symptoms!),
                ],
                if (allergy.notes != null && allergy.notes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildAllergyInfo('Notes', allergy.notes!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergyInfo(String label, String value) {
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
      case 'life_threatening':
        return Colors.red.shade800;
      default:
        return Colors.grey;
    }
  }

  Future<void> _addAllergy() async {
    final result = await _showAllergyForm();
    if (result != null) {
      final success = await ProfileManagementService.addAllergy(result);
      if (success) {
        await _loadAllergies();
        _showSnackBar('Allergy added successfully');
      } else {
        _showSnackBar('Failed to add allergy');
      }
    }
  }

  Future<void> _handleAllergyAction(String allergyId, String action) async {
    switch (action) {
      case 'edit':
        final allergy = _allergies.firstWhere((a) => a.id == allergyId);
        final result = await _showAllergyForm(allergy: allergy);
        if (result != null) {
          final success = await ProfileManagementService.updateAllergy(allergyId, result);
          if (success) {
            await _loadAllergies();
            _showSnackBar('Allergy updated successfully');
          } else {
            _showSnackBar('Failed to update allergy');
          }
        }
        break;
      case 'delete':
        final confirmed = await _showDeleteConfirmation('allergy');
        if (confirmed == true) {
          final success = await ProfileManagementService.deleteAllergy(allergyId);
          if (success) {
            await _loadAllergies();
            _showSnackBar('Allergy deleted');
          } else {
            _showSnackBar('Failed to delete allergy');
          }
        }
        break;
    }
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
