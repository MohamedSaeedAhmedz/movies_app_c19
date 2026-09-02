import 'package:flutter/material.dart';
import '../../../../core/resources/app_color.dart';
import '../model/onboarding_item.dart';


class OnboardingBackground extends StatelessWidget {
  final OnboardingItem page;

  const OnboardingBackground({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          page.imagePath,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                MColors.black.withOpacity(0.4),
                MColors.black.withOpacity(0.85),
              ],
              stops: const [0.4, 0.7, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}