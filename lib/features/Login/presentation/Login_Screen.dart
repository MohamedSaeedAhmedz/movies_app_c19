import 'package:flutter/material.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';
import '../widgets/language_switch.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form.dart';
import '../widgets/login_google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                Image.asset(
                  MImages.logo2,
                  width: 121,
                  height: 118,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 69),

                const LoginForm(),

                const SizedBox(height: 16),

                const LoginButton(),

                const SizedBox(height: 20),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc.dontHaveAccount,
                        style: const TextStyle(color: MColors.white),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.register);
                        },
                        child: Text(
                          loc.createOne,
                          style: const TextStyle(
                            color: MColors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const LoginGoogleButton(),

                const SizedBox(height: 24),

                const LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
