import 'package:doctor_appointment_app/services/auth.dart';
import 'package:doctor_appointment_app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/helpers.dart';
import 'signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    this.user,
  });
  final User? user;
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
                Row(
                  children: [
                    Text(
                      "National-Id",
                      style: colour,
                    ),
                  ],
                ),
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
                Row(
                  children: [
                    Text(
                      "Password",
                      style: colour,
                    ),
                  ],
                ),
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
                  text: "Login",
                  ontap: () async {
                    try {
                      Auth.registerUser(context, cnic, pass);

                      var snackbar =
                          const SnackBar(content: Text("Account not found!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } catch (e) {
                      print('Error during login: $e');
                    }
                    // if (cnic == widget.user?.cnic &&
                    //     pass == widget.user?.password) {
                    //   Auth.registerUser(context, cnic, pass);
                    // } else if (widget.user == null) {
                    //   var snackbar =
                    //       const SnackBar(content: Text("Account not found!"));
                    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    // } else {
                    //   var snackbar =
                    //       const SnackBar(content: Text("Account not found!"));
                    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    // }
                  },
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
                                builder: (_) => const SignupView()));
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
