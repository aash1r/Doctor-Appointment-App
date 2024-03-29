import 'package:doctor_appointment_app/services/appointment.dart';

class User {
  String? cnic;
  String? password;
  String? confirmPassword;
  String? gender;
  String? userName;
  String? dob;
  String? role;
  List<String>? messages;
  List<Appointment>? appointments;

  User(
      {this.cnic,
      this.messages,
      this.confirmPassword,
      this.dob,
      this.gender,
      this.password,
      this.userName,
      this.role,
      this.appointments});

  factory User.fromDocument(Map<String, dynamic> data) {
    return User(
        appointments: (data['appointments'] as List<dynamic>?)
            ?.map((appointment) => Appointment.fromJson(appointment))
            .toList(),
        messages: data['messages'].cast<String>(),
        cnic: data['cnic'],
        password: data['password'],
        confirmPassword: data['confirmPassword'],
        gender: data['gender'],
        userName: data['userName'],
        dob: data['dob'],
        role: data['role']);
  }
}
