import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String uid = (FirebaseAuth.instance.currentUser)!.uid;
  String? email;
  String? username;
  String? phone;

  UserModel({required this.uid, this.email, this.username, this.phone});



  //Receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      phone: map['phone']
    );
  }

  //Sending data to your server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phone': phone,
    };
  }
}
