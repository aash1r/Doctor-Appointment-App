import 'package:doctor_appointment_app/views/camera_view.dart';
import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const CameraView()));
      },
      child: const Text("Camera"),
    );
  }
}
