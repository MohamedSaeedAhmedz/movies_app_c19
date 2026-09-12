import 'package:flutter/material.dart';
import 'package:movies_app/core/firebase/firebase_auth.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';
import 'package:movies_app/widget/show_snack_bar.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  String email;
  String password;
  LoginButton({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MColors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            try {
              setState(() {
                isLoading = true;
              });
              await FirebaseAuthService.loginUser(
                email: widget.email,
                password: widget.password,
              );

              if (context.mounted) {
                Navigator.of(context).pushNamed(AppRoutes.homescreen);
              }
            } catch (e) {
              if (context.mounted) showSnackBar(context, e.toString());
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
        child: isLoading
            ? CircularProgressIndicator(color: MColors.black)
            : Text(
                loc.login,
                style: const TextStyle(
                  color: MColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
