// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:doctor_appointment_app/components/my_row.dart';
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
      required this.onLoginTap,
      required this.cpassw,
      required this.user,
      required this.role});
  final Function()? ontap;
  final Function(String) name;
  final Function(String) passw;
  final Function(String) cpassw;
  final Function(String) gender;
  final Function(String) nic;
  final Function(String) dob;
  final Function() onLoginTap;
  final User user;
  final String role;

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _items = ["Male", "Female"];
  String dropdownValue = "Male";
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
                    hintText: "Password",
                    icon: Icons.remove_red_eye),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Gender"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: DropdownButton(
                    underline: Container(
                      height:
                          0.0, // Set the height to 0.0 to remove the underline
                      color: Colors.transparent, // Set the color to transparent
                    ),
                    elevation: 10,
                    items: _items.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 15),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        widget.gender(val ?? '');
                        dropdownValue = val ?? '';
                      });
                    },
                    value: dropdownValue,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyRow(labelText: "Cnic"),
                const SizedBox(
                  height: 5,
                ),
                MyTextfield(
                    onChanged: widget.nic,
                    hintText: "42201-4918973-9",
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
                  text: "Sign Up",
                  ontap: () {
                    Auth.signUp(widget.user, context, widget.role);
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
                      onTap: widget.onLoginTap,
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
