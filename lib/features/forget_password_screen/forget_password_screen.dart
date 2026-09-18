import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/core/firebase/firebase_auth.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/utils/app_text_style.dart';
import 'package:movies_app/widget/custom_button.dart';
import 'package:movies_app/widget/custom_svg_pic.dart';
import 'package:movies_app/widget/custom_text_form_field.dart';
import 'package:movies_app/widget/show_snack_bar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool isLoading = false;
  String email = '';
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.forgetPassword)),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 24,
              children: [
                Image.asset(MImages.forgot),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    prefixIcon: CustomSvgPicture(svgPath: MIcons.emailSvg),
                    hintText: l10n.email,
                    onChange: (data) {
                      email = data;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.pleaseEnterYourEmail;
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
                        return l10n.pleaseEnterAValidEmail;
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),

                  child: CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await FirebaseAuthService.resetPassword(email: email);
                          if (context.mounted) {
                            Navigator.pop(context);
                            showSnackBar(
                              context,
                              'Password reset link has been sent to your email',
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showSnackBar(context, e.toString());
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      }
                    },
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
        ),
      ),
    );
  }
}
