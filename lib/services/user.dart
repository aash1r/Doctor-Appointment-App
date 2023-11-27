import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? cnic;
  String? password;
  String? confirmPassword;
  String? gender;
  String? userName;
  DateTime? dob;

  User({
    this.cnic,
    this.confirmPassword,
    this.dob,
    this.gender,
    this.password,
    this.userName,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      cnic: data['cnic'],
      password: data['password'],
      confirmPassword: data['confirmPassword'],
      gender: data['gender'],
      userName: data['userName'],
      dob: data['dob']?.toDate(),
    );
  }
}
