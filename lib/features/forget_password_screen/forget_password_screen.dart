import 'package:flutter/material.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/utils/app_text_style.dart';
import 'package:movies_app/widget/custom_button.dart';
import 'package:movies_app/widget/custom_svg_pic.dart';
import 'package:movies_app/widget/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.forgetPassword)),
      body: SingleChildScrollView(
        child: Column(
          spacing: 24,
          children: [
            Image.asset(MImages.forgot),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: CustomTextFormField(
                prefixIcon: CustomSvgPicture(svgPath: MIcons.emailSvg),
                hintText: l10n.email,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),

              child: CustomButton(
                onTap: () {},
                text: l10n.verifyEmail,
                textStyle: AppTextStyle.font20W400.copyWith(
                  color: MColors.black,
                ),
                color: MColors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
