import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/core/bloc/locale/locale_bloc.dart';
import 'package:movies_app/core/firebase/firestore_service.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';
import 'package:movies_app/features/update_profile/presentation/bottom_sheet_body.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/utils/app_text_style.dart';
import 'package:movies_app/widget/custom_button.dart';
import 'package:movies_app/widget/custom_svg_pic.dart';
import 'package:movies_app/widget/custom_text_button.dart';
import 'package:movies_app/widget/custom_text_form_field.dart';
import 'package:movies_app/widget/show_snack_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isLoading = false;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String? name;
  String? phoneNumber;
  late int selectedAvatarIndex;
  late final UserModel userData;
  bool _isInitialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      userData = ModalRoute.of(context)!.settings.arguments as UserModel;
      selectedAvatarIndex = MImages.avatarList.indexOf(
        userData.selectedAvatarPath,
      );
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(color: MColors.yellow),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.pickAvatar)),
        body: SingleChildScrollView(
          child: AbsorbPointer(
            absorbing: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final selectedIndex = await showModalBottomSheet<int>(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return BottomSheetBody(
                            selectedAvatarIndex: selectedAvatarIndex,
                          );
                        },
                      );
                      if (selectedIndex != null) {
                        setState(() {
                          selectedAvatarIndex = selectedIndex;
                        });
                      }
                    },
                    child: ClipRRect(
                      child: Image.asset(
                        MImages.avatarList[selectedAvatarIndex],
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .035),
                  CustomTextFormField(
                    prefixIcon: CustomSvgPicture(svgPath: MIcons.userSvg),
                    hintText: userData.name,
                    onChange: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                    prefixIcon: CustomSvgPicture(svgPath: MIcons.phoneSvg),
                    hintText: userData.phoneNumber,
                    onChange: (value) {
                      phoneNumber = value;
                    },
                  ),
                  BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, state) {
                      return Align(
                        alignment: state.locale == Locale('en')
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: CustomTextButton(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.forgetpassword);
                          },
                          text: l10n.resetPassword,
                          fontSize: 20,
                          color: MColors.white,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * .25),
                  CustomButton(
                    onTap: () async {
                      try {
                        final password = await showDeleteAccountDialog();

                        if (password == null || password.isEmpty) {
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });

                        await FirestoreService.deleteUser(uid: uid);
                        await FirebaseAuth.instance.currentUser!.delete();
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.login,
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        log(e.toString());
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
                    },
                    text: l10n.deleteAccount,
                    textStyle: AppTextStyle.font20W400.copyWith(
                      color: MColors.white,
                    ),
                    color: MColors.red,
                  ),
                  SizedBox(height: height * .02),
                  CustomButton(
                    onTap: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await FirestoreService.updateUser(
                          uid: uid,
                          userModel: UserModel(
                            selectedAvatarPath:
                                MImages.avatarList[selectedAvatarIndex],
                            name: name ?? userData.name,
                            phoneNumber: phoneNumber ?? userData.phoneNumber,
                          ),
                        );
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        log(e.toString());
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
                    },
                    text: l10n.updateData,
                    textStyle: AppTextStyle.font20W400.copyWith(
                      color: MColors.black,
                    ),
                    color: MColors.yellow,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> showDeleteAccountDialog() {
    return showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Confirm account deletion'),
          content: TextField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
