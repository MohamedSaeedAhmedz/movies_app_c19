import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  static Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    final UserCredential user = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user;
  }
}
