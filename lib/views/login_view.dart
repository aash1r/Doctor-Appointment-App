// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:doctor_appointment_app/services/auth.dart';
import 'package:doctor_appointment_app/views/patient/patient_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_button.dart';
import '../components/my_row.dart';
import '../components/my_textfield.dart';
import '../services/helpers.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    this.role,
  });
  final String? role;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String cnic = '';
  String pass = '';
  bool passToggle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SvgPicture.asset("assets/Login.svg"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 29,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "National-Id | (use dashes)"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                  onChanged: (val) {
                    cnic = val;
                  },
                  hintText: "12345-6789012-3",
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Password"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                  onChanged: (val) {
                    pass = val;
                  },
                  hintText: "Enter your password",
                ),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  font: 25,
                  text: "Login",
                  ontap: () async {
                    try {
                      // Check if the
                      // user exists in Firestore
                      bool userExists =
                          await Auth.doesUserExist(cnic, widget.role ?? "");
                      print('userExist: $userExists');
                      if (userExists) {
                        // User exists, validate credentials
                        bool isValidCredentials =
                            await Auth.validateCredentials(
                                cnic, pass, widget.role ?? "");
                        print('Validity: $isValidCredentials');
                        if (isValidCredentials) {
                          // Navigate to the home view
                          Auth.authenticateUser(
                              context, cnic, pass, widget.role ?? "");
                        } else {
                          // Show a snackbar with an authentication error
                          var snackbar = const SnackBar(
                            content: Text(
                                "Invalid credentials. Please check your CNIC and password."),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      } else {
                        // User does not exist, show a snackbar
                        var snackbar = SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 115, 211, 255),
                          content: Text(
                            "Account not found, Please Register Yourself!",
                            style: Helpers.colour,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    } catch (e) {
                      print('Error during login: $e');
                    }
                  },
                  width: 300,
                  height: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PatientSignup(
                                      role: 'Patient',
                                    )));
                      },
                      child: Text(
                        " Register yourself now!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
