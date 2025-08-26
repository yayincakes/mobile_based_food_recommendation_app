import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum PlanMode { auto, manual }

class CreateMealPlanScreen extends StatelessWidget {
  const CreateMealPlanScreen({super.key});

  Color get darkGreen => const Color(0xFF0B6A0B);

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
        title: Text('Plan Setup',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/dashboard'),
            child: Text('Skip',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pick how you want to build your plan',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),

                    _InfoBanner(
                      icon: Icons.healing,
                      color: darkGreen,
                      text:
                          'This app is disease‑specific. Your choices (e.g., Diabetes, Hypertension, CKD, Hyperlipidemia) tailor calories, macros, sodium/sugar thresholds, and recommended recipes.',
                    ),
                    const SizedBox(height: 16),

                    // Options
                    _OptionCard(
                      title: 'Auto‑Generate Plan',
                      icon: Icons.auto_awesome,
                      iconColor: Colors.amber[700]!,
                      description:
                          'Fast setup. Answer a few health and lifestyle questions and we\'ll craft a plan automatically.',
                      bullets: const [
                        'Smart defaults for your condition',
                        'Instant weekly plan',
                        'You can edit later'
                      ],
                      onTap: () => _goFlow(context, PlanMode.auto),
                      accent: darkGreen,
                    ),
                    const SizedBox(height: 12),
                    _OptionCard(
                      title: 'Create Manually',
                      icon: Icons.edit,
                      iconColor: darkGreen,
                      description:
                          'Full control. We still ask key questions, then you pick/replace meals yourself.',
                      bullets: const [
                        'Choose meals per day',
                        'Swap recipes anytime',
                        'Keep condition rules active'
                      ],
                      onTap: () => _goFlow(context, PlanMode.manual),
                      outlined: true,
                      accent: darkGreen,
                    ),
                    const SizedBox(height: 20),

                    // What we'll ask + privacy
                    _SectionHeader(title: 'What we’ll ask'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        _ChipPill(label: 'Goal'),
                        _ChipPill(label: 'Activity'),
                        _ChipPill(label: 'Height/Weight'),
                        _ChipPill(label: 'Conditions'),
                        _ChipPill(label: 'Dietary limits'),
                        _ChipPill(label: 'Allergies'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _PrivacyRow(color: darkGreen),
                    const SizedBox(height: 100), // space under sticky CTA
                  ],
                ),
              ),
            ),

            // Sticky CTA
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 10,
                      offset: const Offset(0, -2))
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12, bottom: 12),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(52),
                        textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Auto‑Generate Plan'),
                      onPressed: () => _goFlow(context, PlanMode.auto),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: darkGreen,
                        side: BorderSide(color: darkGreen, width: 1.2),
                        minimumSize: const Size.fromHeight(52),
                        textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('Create Manually'),
                      onPressed: () => _goFlow(context, PlanMode.manual),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goFlow(BuildContext context, PlanMode mode) {
    // Navigate to your onboarding_flow_screen and pass the chosen mode.
    // In your flow screen, read arguments:
    // final args = ModalRoute.of(context)!.settings.arguments as Map?;
    // final mode = args?['mode'] as PlanMode? ?? PlanMode.auto;
    Navigator.pushNamed(
      context,  
      '/onboarding_flow',
      arguments: {'mode': mode.name},
    );
  }
}

/* ---------- Small UI widgets ---------- */

class _OptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String description;
  final List<String> bullets;
  final VoidCallback onTap;
  final bool outlined;
  final Color accent;

  const _OptionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.description,
    required this.bullets,
    required this.onTap,
    required this.accent,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final box = BoxDecoration(
      color: outlined ? Colors.white : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: outlined ? Border.all(color: accent.withOpacity(.35)) : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.04),
          blurRadius: 10,
          offset: const Offset(0, 2),
        )
      ],
    );

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: box,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(.15),
              foregroundColor: iconColor,
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bullets
                        .map(
                          (b) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ',
                                    style: TextStyle(color: Colors.black54)),
                                Expanded(
                                  child: Text(
                                    b,
                                    style: GoogleFonts.poppins(
                                        fontSize: 13, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _InfoBanner({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            foregroundColor: color,
            child: Icon(icon, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style:
                  GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style:
            GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15));
  }
}

class _ChipPill extends StatelessWidget {
  final String label;
  const _ChipPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      backgroundColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

class _PrivacyRow extends StatelessWidget {
  final Color color;
  const _PrivacyRow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.shield_outlined, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your answers stay on-device or in your account. You can edit or delete them any time.',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
