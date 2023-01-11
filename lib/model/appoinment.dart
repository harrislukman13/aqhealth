import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String? bookdate;
  int? time;
  String? doctorid;
  String? doctorname;
  String? patientname;
  String? patientID;
  String? specialistname;

  Appointment(
      {this.bookdate,
      this.doctorname,
      this.time,
      this.patientID,
      this.specialistname,
      this.doctorid,
      this.patientname});

  factory Appointment.fromFireStore(DocumentSnapshot doc) {
    return Appointment(
        bookdate: doc['bookdate'],
        doctorid: doc['doctorid'],
        doctorname: doc['doctorname'],
        specialistname: doc['specialistname'],
        time: doc['time'],
        patientID: doc['patientid'],
        patientname: doc['patientname']);
  }
}
