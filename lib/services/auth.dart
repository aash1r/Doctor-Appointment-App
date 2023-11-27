// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../views/home_view.dart';
import 'user.dart';

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
      var snackbar = const SnackBar(content: Text("Weak Password"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return false;
    }
    return true;
  }

  static void registerUser(
      BuildContext context, String cnic, String pass, User user) {
    final isNicValidated = validateCnic(cnic, context);
    final isPassValidated = validatePassword(pass, context);
    if (isNicValidated && isPassValidated) {
      firestore.collection('users').doc().set({
        'cnic': cnic.trim(),
        'password': pass.trim(),
        'confirmpassword': user.confirmPassword,
        'gender': user.gender, // Add more fields as needed
        'userName': user.userName,
        'dob': user.dob,
      });
      Future.delayed(const Duration(milliseconds: 300), () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HomeView(
                      cnic: cnic,
                    )));
      });
    }
  }

  static authenticateUser(
      BuildContext context, String cnic, String pass) async {
    final isNicValidated = validateCnic(cnic, context);
    final isPassValidated = validatePassword(pass, context);

    bool userExist = false;
    if (isNicValidated && isPassValidated) {
      // Check if the user exists in Firestore
      userExist = await doesUserExist(cnic);

      if (userExist) {
        // User exists, validate credentials and log in
        bool isValidCredentials = await validateCredentials(cnic, pass);

        if (isValidCredentials) {
          var snackbar = const SnackBar(
            backgroundColor: Color(0xffB28cff),
            content: Text("Successful Login!"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Future.delayed(const Duration(milliseconds: 300), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HomeView(
                        cnic: cnic,
                      )),
            );
          });
          // Navigate to the home view
        } else {
          // Show a snackbar with an authentication error
          var snackbar = const SnackBar(
            content: Text(
                "Invalid credentials. Please check your CNIC and password."),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        print('Invalid credentials!');
        // User does not exist, show a snackbar or handle as needed
        var snackbar = const SnackBar(
          content: Text("User not found. Please register first."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  static Future<Map<String, dynamic>> getUserData(String cnic) async {
    try {
      // Use a query to find the document where 'cnic' field matches the provided CNIC
      QuerySnapshot query = await firestore
          .collection('users')
          .where('cnic', isEqualTo: cnic)
          .get();

      if (query.docs.isNotEmpty) {
        // Assuming there's only one document for a given CNIC, use the first one
        DocumentSnapshot userDoc = query.docs.first;
        return userDoc.data() as Map<String, dynamic>;
      } else {
        print('User not found for CNIC: $cnic');
        return {}; // Return an empty map if user is not found
      }
    } catch (e) {
      print('Error fetching user data for CNIC $cnic: $e');
      return {}; // Return an empty map on error
    }
  }

  static Future<bool> validateCredentials(String cnic, String password) async {
    try {
      // Query the collection based on the CNIC field
      QuerySnapshot query = await firestore
          .collection('users')
          .where('cnic', isEqualTo: cnic)
          .get();

      if (query.docs.isNotEmpty) {
        // User found, check if the provided password matches the stored password
        String storedPassword = query.docs.first['password'];
        return storedPassword == password;
      } else {
        // User not found
        return false;
      }
    } catch (e) {
      print("$e");
      return false;
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
