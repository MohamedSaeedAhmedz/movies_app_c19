import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/core/firebase/firebase_auth.dart';
import 'package:movies_app/core/firebase/firestore_service.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';
import 'package:movies_app/features/Login/widgets/language_switch.dart';
import 'package:movies_app/widget/custom_text_form_field.dart';
import 'package:movies_app/widget/show_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  GlobalKey<FormState> formKey = GlobalKey();
  final PageController _controller = PageController(viewportFraction: 0.376);
  bool isLoading = false;
  int selectedAvatarIndex = 0;
  String name = '';
  String email = '';
  String password = '';
  String phoneNumber = '';

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(color: MColors.yellow),
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: MColors.black,
        appBar: AppBar(
          backgroundColor: MColors.black,
          centerTitle: true,
          title: Text(
            l10n.register,
            style: TextStyle(
              fontSize: 16,
              color: MColors.yellow,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.heightOf(context) * 0.2,
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) => selectedAvatarIndex = index,
                    itemCount: MImages.avatarList.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _controller,
                        child: ClipRRect(
                          child: Image.asset(MImages.avatarList[index]),
                        ),
                        builder: (context, child) {
                          double page = 0;

                          if (_controller.hasClients &&
                              _controller.position.haveDimensions) {
                            page =
                                _controller.page ??
                                selectedAvatarIndex.toDouble();
                          }

                          final difference = (page - index).abs();

                          double scale = 1 - (difference * 0.5);

                          scale = scale.clamp(0.3, 1.0);

                          return Transform.scale(scale: scale, child: child);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.avatar,
                  style: const TextStyle(color: MColors.white, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(MIcons.name, width: 30, height: 30),
                    ),
                    hintText: l10n.name,
                    onChange: (data) {
                      name = data;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.pleaseEnterYourName;
                      }

                      if (!RegExp(
                        r'^[a-zA-Z\u0600-\u06FF ]+$',
                      ).hasMatch(value.trim())) {
                        return l10n.nameCanOnlyContainLetters;
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
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
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
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
                        return l10n
                            .passwordMustContainAtLeastOneSpecialCharacter;
                      }

                      return null;
                    },
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
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        MIcons.lock,
                        width: 24,
                        height: 24,
                        color: MColors.white,
                      ),
                    ),
                    obscureText: isConfirmPasswordHidden,
                    hintText: l10n.confirmPassword,
                    validator: (value) {
                      if (value != password) {
                        return l10n.passwordsDoNotMatch;
                      }

                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: MColors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        MIcons.call,
                        width: 24,
                        height: 24,
                        color: MColors.white,
                      ),
                    ),
                    validator: (data) {
                      if (data!.isEmpty) {
                        return l10n.fieldIsRequired;
                      }
                      if (!RegExp(
                        r'^01[0125][0-9]{8}$',
                      ).hasMatch(data.trim())) {
                        return l10n.pleaseEnterAValidEgyptianPhoneNumber;
                      }
                      return null;
                    },
                    hintText: l10n.phoneNumber,
                    onChange: (data) {
                      phoneNumber = data;
                    },
                  ),
                ),
                SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              isLoading = true;
                            });

                            final credential =
                                await FirebaseAuthService.registerUser(
                                  email: email,
                                  password: password,
                                );

                            final uid = credential.user!.uid;

                            await FirestoreService.addUser(
                              selectedAvatarPath:
                                  MImages.avatarList[selectedAvatarIndex],
                              name: name,
                              phoneNumber: phoneNumber,
                              uid: uid,
                            );
                            if (context.mounted) {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.homescreen);
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MColors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        l10n.createAccount,
                        style: TextStyle(
                          color: MColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 18),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.alreadyHaveAccount,
                      style: TextStyle(
                        color: MColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        l10n.login,
                        style: TextStyle(
                          color: MColors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
