import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/utils/app_text_style.dart';

typedef Validator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final Validator validator;
  final bool? obscureText;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const CustomTextFormField({
    super.key,
    this.obscureText,
    this.maxLines,
    this.validator,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.font16W400.copyWith(color: MColors.white),
      cursorColor: MColors.yellow,
      validator: validator,
      obscureText: obscureText ?? false,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: obscureText == true ? 1 : maxLines,

      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(),
        filled: true,
        fillColor: MColors.dgrey,
        hintText: hintText,
        hintStyle: AppTextStyle.font16W400.copyWith(color: MColors.white),
        labelText: labelText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
