import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../views/home_view.dart';

class Auth {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static bool validateCnic(String value, BuildContext context) {
    if (value.isEmpty) {
      var snackbar =
          const SnackBar(content: Text("Please fill all the fields"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return false;
    }
    if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(value)) {
      var snackbar = const SnackBar(content: Text("In-Valid Cnic"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return false;
    }
    return true;
  }

  static bool validatePassword(String value, BuildContext context) {
    if (value.isEmpty) {
      return false;
    }
    if (value.length < 6) {
      return false;
    }
    return true;
  }

  static void registerUser(BuildContext context, String cnic, String pass) {
    final isNicValidated = validateCnic(cnic, context);
    final isPassValidated = validatePassword(pass, context);
    if (isNicValidated && isPassValidated) {
      firestore.collection('users').doc().set({
        'cnic': cnic.trim(),
        'password': pass.trim(),
      });
      Future.delayed(const Duration(milliseconds: 300), () async {
        await Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeView()));
      });
    }
  }

  static Future<bool> doesUserExist(String cnic) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot query = await users.where('cnic', isEqualTo: cnic).get();
    print('Query result: ${query.docs}');
    // Check if any documents match the query
    return query.docs.isNotEmpty;
  }
}
