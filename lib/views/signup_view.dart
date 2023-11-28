// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:doctor_appointment_app/components/my_row.dart';
import 'package:doctor_appointment_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth.dart';
import '../services/helpers.dart';
import '../services/user.dart';

class SignupView extends StatefulWidget {
  const SignupView(
      {super.key,
      this.ontap,
      required this.name,
      required this.passw,
      required this.gender,
      required this.nic,
      required this.dob,
      required this.cpassw,
      required this.user});
  final Function()? ontap;
  final Function(String) name;
  final Function(String) passw;
  final Function(String) cpassw;
  final Function(String) gender;
  final Function(String) nic;
  final Function(String) dob;
  final User user;

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String cnic = "";
  String pass = "";

  final TextEditingController _dateController = TextEditingController();

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
                const MyRow(labelText: "Your Name"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: widget.name,
                    // user.userName

                    hintText: "Name",
                    icon: Icons.person),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Password"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: widget.passw,
                    // (val) {
                    //   user.password = val;
                    // },
                    hintText: "Password",
                    icon: Icons.remove_red_eye),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Confirm Password"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: widget.cpassw,
                    // (val) {
                    //   user.confirmPassword = val;
                    // },
                    hintText: "Password",
                    icon: Icons.remove_red_eye),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Gender"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: widget.gender,
                    // (val) {
                    //   user.gender = val;
                    // },
                    hintText: "Gender",
                    icon: Icons.male),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Cnic"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: widget.nic,
                    // (val) {
                    //   user.cnic = val;
                    // },
                    hintText: "CNIC",
                    icon: Icons.perm_identity),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "D.O.B"),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  readOnly: true,
                  controller: _dateController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade600),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade600),
                      ),
                      suffixIconColor: Colors.blue.shade600,
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black38, fontSize: 13),
                      hintText: "Select Date",
                      suffixIcon: const Icon(Icons.calendar_today)),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      String date = DateFormat('dd-MM-yyyy').format(picked);
                      setState(() {
                        widget.user.dob = date;
                        _dateController.text = date;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  font: 25,
                  text: "Sign In",
                  ontap: () {
                    Auth.signUp(widget.user, context);
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
                    Text(
                      "Already have an account?",
                      style: Helpers.colour,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginView()));
                      },
                      child: Text(
                        " Login!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900),
                      ),
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
