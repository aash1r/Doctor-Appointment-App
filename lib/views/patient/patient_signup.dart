import 'package:doctor_appointment_app/services/user.dart';
import 'package:doctor_appointment_app/views/login_view.dart';
import 'package:doctor_appointment_app/views/signup_view.dart';
import 'package:flutter/material.dart';

class PatientSignup extends StatefulWidget {
  const PatientSignup({super.key});

  @override
  State<PatientSignup> createState() => _PatientSignupState();
}

class _PatientSignupState extends State<PatientSignup> {
  final user = User();
  @override
  Widget build(BuildContext context) {
    return SignupView(
      onLoginTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const LoginView(
                      role: 'Patient',
                    )));
      },
      name: (val) {
        user.userName = val;
      },
      passw: (val) {
        user.password = val;
      },
      gender: (val) {
        user.gender = val;
      },
      nic: (val) {
        user.cnic = val;
      },
      dob: (val) {
        user.dob = val;
      },
      cpassw: (val) {
        user.confirmPassword = val;
      },
      user: user,
      role: 'Patient',
    );
  }
}
