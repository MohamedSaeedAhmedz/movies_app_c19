import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';

class StatBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const StatBadge({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: MColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}