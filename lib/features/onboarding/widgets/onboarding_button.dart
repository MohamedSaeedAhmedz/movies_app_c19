import 'package:flutter/material.dart';
import '../../../../core/resources/app_color.dart';

class OnboardingButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MColors.yellow,
          foregroundColor: MColors.black,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}