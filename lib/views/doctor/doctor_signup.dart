import 'package:doctor_appointment_app/services/user.dart';
import 'package:doctor_appointment_app/views/signup_view.dart';
import 'package:flutter/material.dart';

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({super.key});

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  final user = User();
  @override
  Widget build(BuildContext context) {
    return SignupView(
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
    );
  }
}
