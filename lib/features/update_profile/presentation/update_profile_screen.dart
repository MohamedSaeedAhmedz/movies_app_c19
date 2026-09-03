import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/bloc/locale/locale_bloc.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/features/update_profile/presentation/bottom_sheet_body.dart';
import 'package:movies_app/utils/app_text_style.dart';
import 'package:movies_app/widget/custom_button.dart';
import 'package:movies_app/widget/custom_svg_pic.dart';
import 'package:movies_app/widget/custom_text_button.dart';
import 'package:movies_app/widget/custom_text_form_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.pickAvatar)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return BottomSheetBody();
                  },
                );
              },
              child: ClipRRect(
                child: Image.asset(MImages.avatar1, width: 150, height: 150),
              ),
            ),
            SizedBox(height: height * .035),
            CustomTextFormField(
              prefixIcon: CustomSvgPicture(svgPath: MIcons.userSvg),
              hintText: 'Mohamed Elsayed',
            ),
            SizedBox(height: height * .02),
            CustomTextFormField(
              prefixIcon: CustomSvgPicture(svgPath: MIcons.phoneSvg),
              hintText: '01200000000',
            ),
            BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                return Align(
                  alignment: state.locale == Locale('en')
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: CustomTextButton(
                    onTap: () {},
                    text: l10n.resetPassword,
                    fontSize: 20,
                    color: MColors.white,
                  ),
                );
              },
            ),
            Spacer(),
            CustomButton(
              onTap: () {},
              text: l10n.deleteAccount,
              textStyle: AppTextStyle.font20W400.copyWith(color: MColors.white),
              color: MColors.red,
            ),
            SizedBox(height: height * .02),
            CustomButton(
              onTap: () {},
              text: l10n.updateData,
              textStyle: AppTextStyle.font20W400.copyWith(color: MColors.black),
              color: MColors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
