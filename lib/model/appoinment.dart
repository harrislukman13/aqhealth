import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String? bookdate;
  int? time;
  String? doctorname;
  String? patientID;

  Appointment({
    this.bookdate,
    this.doctorname,
    this.time,
    this.patientID,
  });

  factory Appointment.fromFireStore(DocumentSnapshot doc) {
    return Appointment(
      bookdate: doc['bookdate'],
      doctorname: doc['doctorname'],
      time: doc['time'],
      patientID: doc['patientid'],
    );
  }
}
