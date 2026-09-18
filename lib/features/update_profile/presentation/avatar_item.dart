import 'package:flutter/material.dart';

import 'package:movies_app/core/resources/app_color.dart';

class AvatarItem extends StatelessWidget {
  final String avatar;
  final VoidCallback onTab;
  final bool isSelected;
  const AvatarItem({
    super.key,
    required this.avatar,
    required this.onTab,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? MColors.yellow.withValues(alpha: .56) : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MColors.yellow),
        ),
        child: ClipRRect(child: Image.asset(avatar)),
      ),
    );
  }
}
