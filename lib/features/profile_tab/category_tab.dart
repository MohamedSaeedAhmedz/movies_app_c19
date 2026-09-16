import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/utils/app_text_style.dart';
import 'package:movies_app/widget/custom_svg_pic.dart';

class CategoryTab extends StatelessWidget {
  final Widget icon;
  final String text;
  const CategoryTab({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: icon,
      child: Text(
        text,
        style: AppTextStyle.font20W400.copyWith(color: MColors.white),
      ),
    );
  }
}
