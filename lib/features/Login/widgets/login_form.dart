import 'package:flutter/material.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextField(
          style: const TextStyle(color: MColors.white),
          cursorColor: MColors.yellow,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                MIcons.mail,
                width: 24,
                height: 24,
                color: MColors.white,
              ),
            ),
            hintText: loc.email,
            hintStyle: const TextStyle(color: MColors.white),
            filled: true,
            fillColor: MColors.dgrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 16),

        TextField(
          obscureText: isPasswordHidden,
          style: const TextStyle(color: MColors.white),
          cursorColor: MColors.yellow,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                MIcons.lock,
                width: 24,
                height: 24,
                color: MColors.white,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: MColors.white,
              ),
              onPressed: () {
                setState(() {
                  isPasswordHidden = !isPasswordHidden;
                });
              },
            ),
            hintText: loc.password,
            hintStyle: const TextStyle(color: MColors.white),
            filled: true,
            fillColor: MColors.dgrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.forgetpassword);
            },
            child: Text(
              loc.forgetPassword,
              style: const TextStyle(color: MColors.yellow),
            ),
          ),
        ),
      ],
    );
  }
}