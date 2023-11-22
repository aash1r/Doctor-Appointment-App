import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth.dart';
import '../services/helpers.dart';
import '../services/user.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key, this.ontap});
  final Function()? ontap;

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String cnic = "";
  String pass = "";
  final user = User();
  void signUp() async {
    bool userExists = await Auth.doesUserExist(cnic);

    if (userExists) {
      // User exists, perform login logic
      var snackbar = const SnackBar(content: Text("User already exists!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // } else {
      //   // User does not exist
      //   var snackbar = const SnackBar(content: Text("Account not found!"));
      //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    if (user.password != user.confirmPassword) {
      Navigator.pop(context);
      var snackbar = const SnackBar(content: Text("Passwords do not match!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/Login.svg"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
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
                      "Your Name",
                      style: colour,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: (val) {
                      user.userName = val;
                    },
                    hintText: "Name",
                    icon: Icons.person),
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
                      user.password = val;
                    },
                    hintText: "Password",
                    icon: Icons.remove_red_eye),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Confirm Password",
                      style: colour,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: (val) {
                      user.confirmPassword = val;
                    },
                    hintText: "Confirm Password",
                    icon: Icons.remove_red_eye),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Gender",
                      style: colour,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: (val) {
                      user.gender = val;
                    },
                    hintText: "Male",
                    icon: Icons.male),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "National-ID",
                      style: colour,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: (val) {
                      user.cnic = val;
                    },
                    hintText: "CNIC",
                    icon: Icons.perm_identity),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "D.O.B",
                      style: colour,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: (val) {},
                    hintText: "4/12/1998",
                    icon: Icons.calendar_month),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  text: "Sign In",
                  ontap: signUp,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: colour,
                    ),
                    Text(
                      " Login!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900),
                    ),
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
