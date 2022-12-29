import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  DateTime? bookdate;
  int? time;
  String? doctorId;
  String? patientID;

  Appointment({
    this.bookdate,
    this.time,
    this.doctorId,
    this.patientID,
  });

  factory Appointment.fromFireStore(DocumentSnapshot doc) {
    return Appointment(
      bookdate: doc['bookdate'],
      time: doc['time'],
      doctorId: doc['doctorId'],
      patientID: doc['patientId'],
    );
  }
}
