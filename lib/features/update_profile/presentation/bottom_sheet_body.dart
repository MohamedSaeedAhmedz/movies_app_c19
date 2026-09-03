import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_image.dart';
import 'package:movies_app/features/update_profile/presentation/avatar_item.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      decoration: BoxDecoration(
        color: MColors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            crossAxisCount: 3,
          ),
          itemCount: MImages.avatarList.length,
          itemBuilder: (context, index) {
            return AvatarItem(avatar: MImages.avatarList[index]);
          },
        ),
      ),
    );
  }
}
