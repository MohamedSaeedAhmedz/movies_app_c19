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

  static Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> reAuthentication({required String password}) async {
    final user = auth.currentUser!;

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
  }

  static Future<void> logoutUser() async {
    await auth.signOut();
  }

  static Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
