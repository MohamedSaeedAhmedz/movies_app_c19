import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/firebase/firestore_service.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/features/profile_tab/profile_screen_body.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/utils/app_text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: StreamBuilder<UserModel>(
          stream: FirestoreService.getUser(uid: uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProfieScreenBody(userData: snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(child: Text('There is no data',style: AppTextStyle.font24W700,));
            } else {
              return Center(
                child: CircularProgressIndicator(color: MColors.yellow),
              );
            }
          },
        ),
      ),
    );
  }
}
