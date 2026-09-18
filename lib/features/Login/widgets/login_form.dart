import 'package:flutter/material.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';
import 'package:movies_app/features/Login/widgets/login_button.dart';
import 'package:movies_app/widget/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const LoginForm({super.key, required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPasswordHidden = true;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.5),
              child: Image.asset(
                MIcons.mail,
                width: 24,
                height: 24,
                color: MColors.white,
              ),
            ),
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
          const SizedBox(height: 16),

          const SizedBox(height: 8),
          CustomTextFormField(
            obscureText: isPasswordHidden,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Image.asset(
                MIcons.lock,
                width: 24,
                height: 24,
                color: MColors.white,
              ),
            ),
            hintText: l10n.password,
            onChange: (data) {
              password = data;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.pleaseEnterYourPassword;
              }

              if (value.length < 6) {
                return l10n.passwordMustBeAtLeast6Characters;
              }

              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return l10n.passwordMustContainAtLeastOneNumber;
              }

              if (!RegExp(
                r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]]',
              ).hasMatch(value)) {
                return l10n.passwordMustContainAtLeastOneSpecialCharacter;
              }

              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                color: MColors.white,
              ),
              onPressed: () {
                setState(() {
                  isPasswordHidden = !isPasswordHidden;
                });
              },
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.forgetpassword);
              },
              child: Text(
                l10n.forgetPassword,
                style: const TextStyle(color: MColors.yellow),
              ),
            ),
          ),
          const SizedBox(height: 16),

          LoginButton(
            formKey: widget.formKey,
            email: email,
            password: password,
          ),
        ],
      ),
    );
  }
}
