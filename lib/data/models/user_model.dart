import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String userName;
  String userUid;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.userUid,
  });

  factory UserModel.fromJson(DocumentSnapshot snap) {
    return UserModel(
        id: snap.id,
        email: snap["email"],
        userName: snap['userName'],
        userUid: snap['userUid']);
  }
}
