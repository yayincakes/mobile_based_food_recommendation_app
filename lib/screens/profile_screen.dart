// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Favorites count source
import 'favorites_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color darkGreen = const Color(0xFF0B6A0B);
  final Color soft = const Color(0xFFF7F9F7);

  // Basic profile fields (mock — wire to your user store later)
  String _name = 'Your Name';
  String _email = 'user@email.com';

  // Settings persisted locally
  bool _notifEnabled = true;
  bool _useMetric = true; // true: cm/kg, false: ft/lbs
  String _goal = 'Weight Loss';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _notifEnabled = p.getBool('notifEnabled') ?? true;
      _useMetric = p.getBool('useMetric') ?? true;
      _name = p.getString('profileName') ?? _name;
      _email = p.getString('profileEmail') ?? _email;
      _goal = p.getString('dietGoal') ?? _goal;
    });
  }

  Future<void> _savePrefs() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('notifEnabled', _notifEnabled);
    await p.setBool('useMetric', _useMetric);
    await p.setString('profileName', _name);
    await p.setString('profileEmail', _email);
    await p.setString('dietGoal', _goal);
  }

  @override
  Widget build(BuildContext context) {
    final favCount = FavoritesManager().favorites.length;
    final plans = PlanHistoryManager().plans; // mock data for now

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
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            // Header card
            _card(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _avatarPlaceholder(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 18)),
                        const SizedBox(height: 2),
                        Text(_email,
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _openEditSheet(context),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkGreen,
                      side: BorderSide(color: darkGreen),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Stats row
            Row(
              children: [
                Expanded(
                  child: _statTile(
                    icon: Icons.event_note,
                    iconBg: Colors.indigo.shade100,
                    label: 'Plans',
                    value: PlanHistoryManager().plans.length.toString(),
                    onTap: () => _scrollToHistory(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statTile(
                    icon: Icons.favorite_rounded,
                    iconBg: Colors.pink.shade100,
                    label: 'Favorites',
                    value: favCount.toString(),
                    onTap: () => Navigator.pushNamed(context, '/favorites'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Settings section
            Text('Settings',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            _card(
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.tips_and_updates,
                    title: 'Dietary Goal',
                    subtitle: _goal,
                    onTap: _pickGoal,
                  ),
                  const Divider(height: 0),
                  _switchTile(
                    icon: Icons.notifications_active,
                    title: 'Notifications',
                    value: _notifEnabled,
                    onChanged: (v) async {
                      setState(() => _notifEnabled = v);
                      await _savePrefs();
                    },
                  ),
                  const Divider(height: 0),
                  _switchTile(
                    icon: Icons.straighten,
                    title: 'Units',
                    subtitle: _useMetric ? 'cm / kg' : 'ft / lbs',
                    value: _useMetric,
                    onChanged: (v) async {
                      setState(() => _useMetric = v);
                      await _savePrefs();
                    },
                  ),
                  const Divider(height: 0),
                  _settingTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy',
                    subtitle: 'Manage data and permissions',
                    onTap: () => _snack('Privacy settings coming soon'),
                  ),
                  const Divider(height: 0),
                  _settingTile(
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'Version 1.0.0',
                    onTap: () => _snack('FitMeal • NutriGuide'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Plan History
            Text('Plan History',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            if (plans.isEmpty)
              _card(
                child: Text(
                  'No plans yet. Create one from Dashboard → Create/Update.',
                  style: GoogleFonts.poppins(color: Colors.black54),
                ),
              )
            else
              _card(
                padding: EdgeInsets.zero,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final p = plans[i];
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: CircleAvatar(
                        backgroundColor: soft,
                        child: Icon(Icons.event_note, color: darkGreen),
                      ),
                      title: Text(p.title,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      subtitle: Text('${p.date} • ${p.goal}',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black54)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _snack('Open plan details: ${p.title}'),
                    );
                  },
                ),
              ),

            const SizedBox(height: 18),

            // Logout button
            ElevatedButton.icon(
              onPressed: () {
                // TODO: clear auth state then route to /login
                Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================= UI HELPERS =======================

  Widget _avatarPlaceholder() {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.green.shade100,
      child: Icon(Icons.person, color: darkGreen),
    );
  }

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

  Widget _statTile({
    required IconData icon,
    required Color iconBg,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: iconBg, child: Icon(icon, color: Colors.black87)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w800)),
                Text(label,
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: CircleAvatar(
        backgroundColor: soft,
        child: Icon(icon, color: darkGreen),
      ),
      title: Text(title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: CircleAvatar(
        backgroundColor: soft,
        child: Icon(icon, color: darkGreen),
      ),
      title: Text(title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
      trailing: Switch(value: value, onChanged: onChanged, activeColor: darkGreen),
      onTap: () => onChanged(!value),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _scrollToHistory(BuildContext context) {
    // In this simple page we already show history. You can scroll controllers if needed.
    _snack('Scroll to Plan History below');
  }

  Future<void> _pickGoal() async {
    final options = ['Weight Loss', 'Maintenance', 'Weight Gain'];
    final v = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map((e) => ListTile(
                      title: Text(e, style: GoogleFonts.poppins()),
                      trailing: e == _goal ? const Icon(Icons.check) : null,
                      onTap: () => Navigator.pop(context, e),
                    ))
                .toList(),
          ),
        );
      },
    );
    if (v != null) {
      setState(() => _goal = v);
      await _savePrefs();
    }
  }

  Future<void> _openEditSheet(BuildContext context) async {
    final nameCtl = TextEditingController(text: _name);
    final emailCtl = TextEditingController(text: _email);

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
      setState(() {
        _name = nameCtl.text.trim().isEmpty ? _name : nameCtl.text.trim();
        _email = emailCtl.text.trim().isEmpty ? _email : emailCtl.text.trim();
      });
      await _savePrefs();
      _snack('Profile updated');
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
