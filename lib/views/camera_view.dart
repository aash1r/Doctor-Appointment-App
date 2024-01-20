import 'package:camera/camera.dart';
import 'package:doctor_appointment_app/controller/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ScanController>(
            init: ScanController(),
            builder: (controller) {
              return controller.isCameraInitialized.value
                  ? CameraPreview(controller.cameraController)
                  : const Center(child: Text("Loading Preview"));
            }));
  }
}
