import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/core/firebase/firestore_service.dart';
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
import 'package:movies_app/widget/custom_svg_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.widthOf(context);
    final height = MediaQuery.heightOf(context);
    final l10n = AppLocalizations.of(context)!;
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: FutureBuilder<UserModel>(
          future: FirestoreService.getUser(uid: uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
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
                                  MImages.avatar1,
                                  width: width * .3,
                                  height: height * .2,
                                ),
                              ),
                              ProfileDataComponent(
                                data1: Text(
                                  '0',
                                  style: AppTextStyle.font36W700,
                                ),
                                data2: Text(
                                  l10n.watchList,
                                  style: AppTextStyle.font24W700,
                                ),
                              ),
                              ProfileDataComponent(
                                data1: Text(
                                  '0',
                                  style: AppTextStyle.font36W700,
                                ),
                                data2: Text(
                                  l10n.history,
                                  style: AppTextStyle.font24W700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Align(
                            alignment: .centerStart,
                            child: Text(
                              'Mohamed elsayed',

                              style: AppTextStyle.font20W700.copyWith(
                                color: MColors.white,
                              ),
                            ),
                          ),
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
                                    Navigator.of(
                                      context,
                                    ).pushNamed(AppRoutes.updateProfile);
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
                                  onTap: () {},
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
            );
            }else if(snapshot.hasError){
              return Center(child: Text('There is no data'),);
            }else{
              return Center(child: CircularProgressIndicator(color:MColors.yellow,));
            }
           
          },
        ),
      ),
    );
  }
}
