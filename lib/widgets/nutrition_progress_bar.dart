import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NutritionProgressBar extends StatelessWidget {
  final String label;
  final int current;
  final int target;
  final Color color;
  final IconData icon;
  final String unit;

  const NutritionProgressBar({
    super.key,
    required this.label,
    required this.current,
    required this.target,
    required this.color,
    required this.icon,
    this.unit = '',
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (current / target).clamp(0.0, 1.0);
    final isOverTarget = current > target;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                '$current / $target $unit',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isOverTarget ? Colors.red : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage.toDouble(),
              minHeight: 10,
              color: isOverTarget ? Colors.red : color,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          if (isOverTarget)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${current - target} $unit over target',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
