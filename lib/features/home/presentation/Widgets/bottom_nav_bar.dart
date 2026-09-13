import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      MIcons.home,
      MIcons.search,
      MIcons.explore,
      MIcons.profile,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final bool isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ImageIcon(
                AssetImage(icons[index]),
                color: isSelected ? MColors.yellow : MColors.white,
                size: 26,
              ),
            ),
          );
        }),
      ),
    );
  }
}