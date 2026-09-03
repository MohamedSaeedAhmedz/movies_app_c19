
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final TextStyle textStyle;
  final Color color;
  const CustomButton({super.key, required this.onTap, required this.text, required this.textStyle, required this.color});

  @override
  Widget build(BuildContext context) {
   
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          padding: EdgeInsets.all(14.5),
          backgroundColor:color,
        ),
        child: Text(
          text,
          style:textStyle,
        ),
      ),
    );
  }
}
