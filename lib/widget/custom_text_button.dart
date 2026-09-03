import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? fontSize;
  final Color? color;
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
    );
  }
}
