import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartSuggestionCard extends StatelessWidget {
  final Map<String, dynamic> suggestion;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onViewDetails;

  const SmartSuggestionCard({
    super.key,
    required this.suggestion,
    this.onAccept,
    this.onDecline,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final mealType = suggestion['mealType']?.toString().toUpperCase() ?? 'MEAL';
    final mealData = suggestion['suggestion'];
    final reason = suggestion['reason'] ?? 'A healthy meal recommendation based on your preferences.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Smart Meal Suggestion',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Based on your preferences',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  mealType,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Meal Information
          if (mealData != null) ...[
            Text(
              mealData['name'] ?? 'Recommended Meal',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.green.shade800,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              reason,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.green.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),

            // Nutrition Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _nutritionInfo(
                      '${mealData['calories'] ?? 0}',
                      'Calories',
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.green.shade200,
                  ),
                  Expanded(
                    child: _nutritionInfo(
                      '${mealData['protein'] ?? 0}g',
                      'Protein',
                      Icons.fitness_center,
                      Colors.green,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.green.shade200,
                  ),
                  Expanded(
                    child: _nutritionInfo(
                      '${mealData['carbs'] ?? 0}g',
                      'Carbs',
                      Icons.rice_bowl,
                      Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onViewDetails,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green.shade600,
                      side: BorderSide(color: Colors.green.shade600),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Details',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onDecline,
                  icon: Icon(
                    Icons.close,
                    color: Colors.green.shade600,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                  ),
                ),
              ],
            ),
          ] else ...[
            Text(
              'No suggestions available',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.green.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _nutritionInfo(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.green.shade800,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.green.shade600,
          ),
        ),
      ],
    );
  }
}
