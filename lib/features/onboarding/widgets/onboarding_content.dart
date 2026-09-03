import 'package:flutter/material.dart';
import '../../../../core/resources/app_color.dart';
import '../model/onboarding_item.dart';
import 'onboarding_button.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem page;
  final int currentIndex;
  final int pagesLength;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnboardingContent({
    super.key,
    required this.page,
    required this.currentIndex,
    required this.pagesLength,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          child: Column(
            children: [
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: MColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              if (page.description.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: MColors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    height: 1.7,
                  ),
                ),
              ],
              const SizedBox(height: 28),
              OnboardingButton(
                buttonText: page.buttonText,
                onPressed: onNext,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        30,
        24,
        MediaQuery.of(context).padding.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: MColors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: MColors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (page.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              page.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.7,
              ),
            ),
          ],
          const SizedBox(height: 20),
          OnboardingButton(
            buttonText: page.buttonText,
            onPressed: onNext,
          ),
          if (currentIndex >= 2) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: MColors.yellow,
                    width: 1.5,
                  ),
                  foregroundColor: MColors.yellow,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onBack,
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}