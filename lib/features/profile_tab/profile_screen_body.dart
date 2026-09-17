import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/core/firebase/firebase_auth.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/core/routes/AppRoutes.dart';
import 'package:movies_app/features/profile_tab/category_tab.dart';
import 'package:movies_app/features/profile_tab/profile_data_component.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/utils/app_text_style.dart';
import 'package:movies_app/widget/custom_button.dart';
import 'package:movies_app/widget/show_snack_bar.dart';

class ProfieScreenBody extends StatefulWidget {
  final UserModel userData;
  const ProfieScreenBody({super.key, required this.userData});

  @override
  State<ProfieScreenBody> createState() => _ProfieScreenBodyState();
}

class _ProfieScreenBodyState extends State<ProfieScreenBody> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.widthOf(context);
    final height = MediaQuery.heightOf(context);
    final l10n = AppLocalizations.of(context)!;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: MColors.veryDarkGray),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      spacing: width * .04,
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            widget.userData.selectedAvatarPath,
                            width: width * .3,
                            height: height * .2,
                          ),
                        ),
                        ProfileDataComponent(
                          data1: Text('0', style: AppTextStyle.font36W700),
                          data2: Text(
                            l10n.watchList,
                            style: AppTextStyle.font24W700,
                          ),
                        ),
                        ProfileDataComponent(
                          data1: Text('0', style: AppTextStyle.font36W700),
                          data2: Text(
                            l10n.history,
                            style: AppTextStyle.font24W700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        widget.userData.name,

                        style: AppTextStyle.font20W700.copyWith(
                          color: MColors.white,
                        ),
                      ),
                      Spacer(flex: 8),
                    ],
                  ),
                  SizedBox(height: 23),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomButton(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.updateProfile,
                                arguments: widget.userData,
                              );
                            },
                            text: l10n.editProfile,
                            textStyle: AppTextStyle.font20W400.copyWith(
                              color: MColors.black,
                            ),
                            color: MColors.yellow,
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            onTap: () async {
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                await FirebaseAuthService.logoutUser();
                                if (context.mounted) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.login,
                                    (route) => false,
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
                            },
                            text: l10n.exit,
                            icon: FaIcon(
                              FontAwesomeIcons.rightFromBracket,
                              color: MColors.white,
                            ),
                            textStyle: AppTextStyle.font20W400.copyWith(
                              color: MColors.white,
                            ),
                            color: MColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TabBar(
                    dividerColor: MColors.black,
                    indicatorColor: MColors.yellow,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      CategoryTab(
                        icon: SvgPicture.asset(
                          MIcons.listSvg,
                          width: 26,
                          height: 26,
                        ),
                        text: l10n.watchList,
                      ),
                      CategoryTab(
                        icon: SvgPicture.asset(
                          MIcons.folderSvg,
                          width: 30,
                          height: 30,
                        ),
                        text: l10n.history,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(child: Image.asset(MImages.popcorn)),
                Center(child: Image.asset(MImages.popcorn)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
