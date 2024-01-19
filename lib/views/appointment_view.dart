import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/services/user.dart';
import 'package:flutter/material.dart';

import '../services/appointment.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView(
      {Key? key, required this.patientCnic, required User user})
      : super(key: key);
  final String patientCnic;

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  final TextEditingController dateController = TextEditingController();
  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection('Doctor');
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

  bool isSubmitting = false;

  Future<void> bookAppointment(String doctorCnic) async {
    try {
      setState(() {
        isSubmitting = true;
      });

      if (dateController.text.isEmpty) {
        var snackbar = const SnackBar(content: Text("Please select a date."));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      DateTime selectedDate = DateTime.parse(dateController.text);
      if (selectedDate.isBefore(DateTime.now())) {
        var snackbar = const SnackBar(
            content: Text("Selected date must be in the future."));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      bool isDoctorAvailable =
          await isDoctorAvailableForAppointment(doctorCnic, selectedDate);
      if (!isDoctorAvailable) {
        var snackbar = const SnackBar(
            content:
                Text("This doctor is not available for the selected date."));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      final appointment = Appointment(
        patientCnic: widget.patientCnic,
        doctorCnic: doctorCnic,
        date: selectedDate,
        status: 'Pending',
      );

      // Update Firestore collections
      await appointmentsCollection.add(appointment.toJson());
      await linkAppointmentToPatient(widget.patientCnic);

      var snackbar =
          const SnackBar(content: Text("Successfully booked your appointment"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // ...
    } catch (e) {
      // Handle errors
      print('Error booking appointment: $e');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  Future<bool> isDoctorAvailableForAppointment(
      String doctorCnic, DateTime selectedDate) async {
    try {
      QuerySnapshot appointmentsQuery = await appointmentsCollection
          .where('doctorCnic', isEqualTo: doctorCnic)
          .where('date', isEqualTo: selectedDate)
          .get();

      return appointmentsQuery.docs.isEmpty;
    } catch (e) {
      print('Error checking doctor availability: $e');
      return false;
    }
  }

  Future<void> linkAppointmentToPatient(String patientCnic) async {
    try {
      final DocumentReference patientDocRef =
          FirebaseFirestore.instance.collection('Patient').doc(patientCnic);

      final CollectionReference appointmentsSubcollection =
          patientDocRef.collection('appointments');

      final QuerySnapshot appointmentsQuery =
          await appointmentsCollection.get();
      final List<DocumentSnapshot> appointments =
          appointmentsQuery.docs.toList();
      for (final DocumentSnapshot appointment in appointments) {
        await appointmentsSubcollection.add(appointment.data()!);
      }

      await patientDocRef.update({'appointmentsLinked': true});
    } catch (e) {
      print('Error linking appointments to patient: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: doctorsCollection.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final doctors = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return ListTile(
                      title: Text(doctor['userName']),
                      // subtitle: Text(doctor['specialization']),
                      onTap: isSubmitting
                          ? null
                          : () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              ).then((pickedDate) {
                                if (pickedDate != null) {
                                  dateController.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                  bookAppointment(doctor['cnic']);
                                }
                              });
                            },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
