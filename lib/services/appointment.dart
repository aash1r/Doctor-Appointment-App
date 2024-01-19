class Appointment {
  String? patientCnic;
  String? doctorCnic;
  DateTime? date;
  String? status; // Pending, Confirmed, Cancelled, etc.

  Appointment({
    this.patientCnic,
    this.doctorCnic,
    this.date,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'patientCnic': patientCnic,
      'doctorCnic': doctorCnic,
      'date': date?.toIso8601String(),
      'status': status,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      patientCnic: json['patientCnic'],
      doctorCnic: json['doctorCnic'],
      date: DateTime.tryParse(json['date']),
      status: json['status'],
    );
  }
}
