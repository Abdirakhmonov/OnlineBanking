import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserAuthService {
  final _userAuthentication = FirebaseAuth.instance;
  final _userfirebase = FirebaseFirestore.instance;

  Future<UserModel?> registerUser(
    String email,
    String password,
    String username,
  ) async {
    UserCredential userCredential =
        await _userAuthentication.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user != null) {
      await _userfirebase.collection("users").doc(user.uid).set(
        {
          "email": user.email,
          "userName": username,
          "userUid": user.uid
        },
      );
      DocumentSnapshot userDoc =
          await _userfirebase.collection("users").doc(user.uid).get();
      return UserModel.fromJson(userDoc);
    }
    return null;
  }

  Future<UserModel?> logInUser(String email, String password) async {
    UserCredential userCredential =
        await _userAuthentication.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _userfirebase.collection("users").doc(user.uid).get();
      return UserModel.fromJson(userDoc);
    }
    return null;
  }

  Future<void> resetPasswordUser(String email) async {
    await _userAuthentication.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> signOut() async {
    await _userAuthentication.signOut();
  }
}
