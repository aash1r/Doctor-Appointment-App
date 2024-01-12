import 'package:doctor_appointment_app/components/my_textfield.dart';
import 'package:doctor_appointment_app/services/user.dart';
import 'package:flutter/material.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({
    super.key,
    required this.user,
  });
  final user;

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  String day = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.user ?? ""),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select appointment day"),
              const SizedBox(
                height: 5,
              ),
              MyTextfield(
                  icon: Icons.date_range,
                  hintText: "Select day",
                  onChanged: (val) {
                    day = val;
                  }),
              const Text("Select appointment time"),
              const SizedBox(
                height: 5,
              ),
              MyTextfield(
                  icon: Icons.watch_later,
                  hintText: "Select time",
                  onChanged: (val) {
                    day = val;
                  }),
              const Text("Select appointment day"),
              const SizedBox(
                height: 5,
              ),
              MyTextfield(
                  icon: Icons.date_range,
                  hintText: "Select day",
                  onChanged: (val) {
                    day = val;
                  }),
              const Text("Select appointment day"),
              const SizedBox(
                height: 5,
              ),
              MyTextfield(
                  icon: Icons.date_range,
                  hintText: "Select day",
                  onChanged: (val) {
                    day = val;
                  })
            ],
          ),
        ));
  }
}
