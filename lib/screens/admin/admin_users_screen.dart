import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  
  List<dynamic> _users = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _roleFilter = 'all';
  String _statusFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await ApiService.get('/admin/users');
      if (response['success'] == true) {
        setState(() {
          _users = response['data']['data'] ?? [];
          _isLoading = false;
        });
      } else {
        _loadFallbackUsers();
      }
    } catch (e) {
      _loadFallbackUsers();
    }
  }

  void _loadFallbackUsers() {
    setState(() {
      _users = [
        {
          'id': 1,
          'name': 'John Doe',
          'email': 'john@example.com',
          'role': 'user',
          'is_active': true,
          'created_at': '2024-01-15T10:30:00Z',
        },
        {
          'id': 2,
          'name': 'Jane Smith',
          'email': 'jane@example.com',
          'role': 'user',
          'is_active': true,
          'created_at': '2024-01-20T14:15:00Z',
        },
        {
          'id': 3,
          'name': 'Mike Johnson',
          'email': 'mike@example.com',
          'role': 'user',
          'is_active': false,
          'created_at': '2024-01-25T09:45:00Z',
        },
        {
          'id': 4,
          'name': 'Sarah Wilson',
          'email': 'sarah@example.com',
          'role': 'user',
          'is_active': true,
          'created_at': '2024-02-01T16:20:00Z',
        },
        {
          'id': 5,
          'name': 'Admin User',
          'email': 'admin@fitmeal.com',
          'role': 'admin',
          'is_active': true,
          'created_at': '2024-01-01T00:00:00Z',
        },
      ];
      _isLoading = false;
    });
  }

  Future<void> _toggleUserStatus(int userId, bool isActive) async {
    try {
      final response = await ApiService.put('/admin/users/$userId/status', {
        'is_active': !isActive,
      });
      
      if (response['success'] == true) {
        _loadUsers(); // Refresh the list
        _showSuccess(isActive ? 'User deactivated' : 'User activated');
      } else {
        _showError('Failed to update user status');
      }
    } catch (e) {
      _showError('Failed to update user status');
    }
  }

  Future<void> _deleteUser(int userId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete this user? This action cannot be undone.',
          style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final response = await ApiService.delete('/admin/users/$userId');
        if (response['success'] == true) {
          _loadUsers(); // Refresh the list
          _showSuccess('User deleted successfully');
        } else {
          _showError('Failed to delete user');
        }
      } catch (e) {
        _showError('Failed to delete user');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  List<dynamic> get _filteredUsers {
    return _users.where((user) {
      final matchesSearch = _searchQuery.isEmpty || 
          user['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user['email'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesRole = _roleFilter == 'all' || user['role'] == _roleFilter;
      final matchesStatus = _statusFilter == 'all' || 
          (_statusFilter == 'active' && user['is_active'] == true) ||
          (_statusFilter == 'inactive' && user['is_active'] == false);
      
      return matchesSearch && matchesRole && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'User Management',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: _loadUsers,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Filters and Search
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Search Bar
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() => _searchQuery = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search users...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: lightGreen.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: darkGreen, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Filter Chips
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _roleFilter,
                              decoration: InputDecoration(
                                labelText: 'Role',
                                filled: true,
                                fillColor: lightGreen.withOpacity(0.3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Roles')),
                                DropdownMenuItem(value: 'user', child: Text('Users')),
                                DropdownMenuItem(value: 'admin', child: Text('Admins')),
                              ],
                              onChanged: (value) {
                                setState(() => _roleFilter = value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _statusFilter,
                              decoration: InputDecoration(
                                labelText: 'Status',
                                filled: true,
                                fillColor: lightGreen.withOpacity(0.3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Status')),
                                DropdownMenuItem(value: 'active', child: Text('Active')),
                                DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                              ],
                              onChanged: (value) {
                                setState(() => _statusFilter = value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Users List
                Expanded(
                  child: _filteredUsers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                'No users found',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return _buildUserCard(user);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    final isActive = user['is_active'] == true;
    final isAdmin = user['role'] == 'admin';
    final createdAt = DateTime.parse(user['created_at']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
          Row(
            children: [
              // Avatar
              CircleAvatar(
                backgroundColor: isAdmin ? Colors.red.shade100 : darkGreen.withOpacity(0.1),
                child: Icon(
                  isAdmin ? Icons.admin_panel_settings : Icons.person,
                  color: isAdmin ? Colors.red.shade700 : darkGreen,
                ),
              ),
              const SizedBox(width: 16),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        if (isAdmin) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'ADMIN',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['email'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Joined ${_formatDate(createdAt)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isActive ? 'Active' : 'Inactive',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _toggleUserStatus(user['id'], isActive),
                  icon: Icon(
                    isActive ? Icons.block : Icons.check_circle,
                    size: 18,
                  ),
                  label: Text(isActive ? 'Deactivate' : 'Activate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isActive ? Colors.red : Colors.green,
                    side: BorderSide(color: isActive ? Colors.red : Colors.green),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (!isAdmin) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _deleteUser(user['id']),
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ] else
                const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return '${(difference.inDays / 30).floor()} months ago';
    }
  }
}
