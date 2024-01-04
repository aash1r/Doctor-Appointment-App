import 'package:doctor_appointment_app/components/my_button.dart';
import 'package:doctor_appointment_app/views/doctor/doctor_signup.dart';
import 'package:doctor_appointment_app/views/patient/patient_signup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  "assets/welcome_logo.json",
                  height: 250,
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PatientSignup()));
                    },
                    child: const MyButton(
                      font: 18,
                      text: "Are you a Patient?",
                      width: 200,
                      height: 50,
                    )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DoctorSignup()));
                    },
                    child: const MyButton(
                      font: 18,
                      text: "Are you a Doctor?",
                      width: 200,
                      height: 50,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
