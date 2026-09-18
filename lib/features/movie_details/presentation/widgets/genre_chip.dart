import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';

class GenreChip extends StatelessWidget {
  final String label;

  const GenreChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MColors.grey.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: MColors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}