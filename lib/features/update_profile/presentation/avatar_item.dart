import 'package:flutter/material.dart';

import 'package:movies_app/core/resources/app_color.dart';

class AvatarItem extends StatelessWidget {
  final String avatar;
  const AvatarItem({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MColors.yellow),
        ),
        child: ClipRRect(child: Image.asset(avatar)),
      ),
    );
  }
}
