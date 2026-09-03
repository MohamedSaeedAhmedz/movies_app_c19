import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/utils/app_text_style.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: MColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: MColors.black,
      centerTitle: true,
      titleTextStyle: AppTextStyle.font16W400.copyWith(color: MColors.yellow),
      iconTheme: IconThemeData(color: MColors.yellow),
    ),
  );
}
