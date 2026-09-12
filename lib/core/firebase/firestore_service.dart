import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/core/firebase/firebase_collection.dart';
import 'package:movies_app/models/user_model.dart';

class FirestoreService {
  static final userRef = FirebaseFirestore.instance
      .collection(FirebaseCollection.users)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );

  static Future<void> addUser({
    required String selectedAvatarPath,
    required String name,
    required String phoneNumber,
    required String uid
  }) async{
    await userRef.doc(uid).set(
      UserModel(
        selectedAvatarPath: selectedAvatarPath,
        name: name,
        phoneNumber: phoneNumber,
      ),
    );
  }

  static Future<UserModel> getUser({required String uid}) async{
    final snapshot=await userRef.doc(uid).get();
   return snapshot.data()! ;
  }
}
